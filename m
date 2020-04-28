Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3371BB48C
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 05:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgD1D1x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 23:27:53 -0400
Received: from mx1.riseup.net ([198.252.153.129]:48948 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgD1D1x (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Apr 2020 23:27:53 -0400
Received: from bell.riseup.net (unknown [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 49B6Xl5syQzFfH2;
        Mon, 27 Apr 2020 20:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1588044472; bh=jzMfAwf2qCn44CmH1JZRLcqTnbbJltLtP3LwjVjb2A0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dBkuM/lyydSjEyqjvA3e5nNf9tA5ehk5SqCzxhSgL6TJrSr9dZsbe+gXNVe9qUMzQ
         8WVCYXs4+lqzGhqXbMy7tCZLfUUk7DE03fLmgjEqgBbeEBruaU3MdpDgEMOwsbKEfk
         TyzJS9FipvMcz7HDtq8B7vpQqYpaqFvHPiwpPHAo=
X-Riseup-User-ID: 3314717E41DBEB7F9491F69BEBF0D21136C5FB4A6E0A74DBBC9909AD1B5302D4
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id 49B6Xl3b9yzJqbv;
        Mon, 27 Apr 2020 20:27:51 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Pandruvada\, Srinivas" <srinivas.pandruvada@intel.com>
Cc:     linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        chris.p.wilson@intel.com,
        "Vivi\, Rodrigo" <rodrigo.vivi@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCHv2.99 07/11] cpufreq: intel_pstate: Implement VLP controller statistics and target range calculation.
Date:   Mon, 27 Apr 2020 20:22:54 -0700
Message-Id: <20200428032258.2518-8-currojerez@riseup.net>
In-Reply-To: <20200428032258.2518-1-currojerez@riseup.net>
References: <20200428032258.2518-1-currojerez@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The goal of the statistics calculation code introduced here is to
compute two informational data structures: struct vlp_input_stats
aggregating various scheduling and PM statistics gathered in every
call of the update_util() hook, and struct vlp_status_sample which
contains status information derived from the former indicating whether
the system is likely to have an IO or CPU bottleneck.  This will be
used as main heuristic input by the new variably low-pass filtering
controller (AKA VLP) that will assist the HWP at finding a reasonably
energy-efficient P-state given the additional information available to
the kernel about I/O utilization and scheduling behavior.

Then a function is introduced (get_vlp_target_range()) which
calculates a P-state range derived from those statistics, which will
be used to drive the HWP P-state range or (if HWP is not available) as
basis for some additional kernel-side frequency selection mechanism
which will choose a single P-state from the range.  This is meant to
provide a variably low-pass filtering effect that will damp
oscillations below a frequency threshold that can be specified by
device drivers via PM QoS in order to achieve energy-efficient
behavior in cases where the system has an IO bottleneck.

v3: Rename CPU_RESPONSE_FREQUENCY to CPU_SCALING_RESPONSE (Rafael).
    Merge patch with statistics calculations with patch which computes
    a derived P-state target based on their result (Rafael).  Define
    generic CPUFREQ policy to control VLP governor (Rafael).  Adjust
    realtime_gain_pml to avoid fluctuation of minimum P-state on HWP
    parts (Srinivas).

Signed-off-by: Francisco Jerez <currojerez@riseup.net>
---
 drivers/cpufreq/intel_pstate.c | 398 +++++++++++++++++++++++++++++++++
 1 file changed, 398 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index fd7eee57c05c..d13eb95a6271 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -19,6 +19,7 @@
 #include <linux/list.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
+#include <linux/debugfs.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
 #include <linux/fs.h>
@@ -33,6 +34,8 @@
 #include <asm/cpufeature.h>
 #include <asm/intel-family.h>
 
+#include "../../kernel/sched/sched.h"
+
 #define INTEL_PSTATE_SAMPLING_INTERVAL	(10 * NSEC_PER_MSEC)
 
 #define INTEL_CPUFREQ_TRANSITION_LATENCY	20000
@@ -59,6 +62,14 @@ static inline int32_t mul_fp(int32_t x, int32_t y)
 	return ((int64_t)x * (int64_t)y) >> FRAC_BITS;
 }
 
+/**
+ * Round a fixed-point fraction to the closest integer.
+ */
+static inline int rnd_fp(int32_t x)
+{
+	return (x + (1 << (FRAC_BITS - 1))) >> FRAC_BITS;
+}
+
 static inline int32_t div_fp(s64 x, s64 y)
 {
 	return div64_s64((int64_t)x << FRAC_BITS, y);
@@ -169,6 +180,66 @@ struct vid_data {
 	int32_t ratio;
 };
 
+/**
+ * Scheduling and PM statistics gathered by update_vlp_sample() at
+ * every call of the VLP update_state() hook, used as heuristic
+ * inputs.
+ */
+struct vlp_input_stats {
+	int32_t realtime_count;
+	int32_t io_wait_count;
+	uint32_t max_scaling_response_hz;
+	uint32_t last_scaling_response_hz;
+};
+
+enum vlp_status {
+	VLP_BOTTLENECK_IO = 1 << 0,
+	/*
+	 * XXX - Add other status bits here indicating a CPU or TDP
+	 * bottleneck.
+	 */
+};
+
+/**
+ * Heuristic status information calculated by get_vlp_status_sample()
+ * from struct vlp_input_stats above, indicating whether the system
+ * has a potential IO or latency bottleneck.
+ */
+struct vlp_status_sample {
+	enum vlp_status value;
+	int32_t realtime_avg;
+};
+
+/**
+ * VLP controller state used for the estimation of the target P-state
+ * range, computed by get_vlp_target_range() from the heuristic status
+ * information defined above in struct vlp_status_sample.
+ */
+struct vlp_target_range {
+	unsigned int value[2];
+	int32_t p_base;
+};
+
+/**
+ * struct vlp_data - VLP controller parameters and state.
+ * @sample_interval_ns:	 Update interval in ns.
+ * @sample_frequency_hz: Reciprocal of the update interval in Hz.
+ * @gain*:		 Response factor of the controller relative to each
+ *			 one of its linear input variables as fixed-point
+ *			 fraction.
+ */
+struct vlp_data {
+	s64 sample_interval_ns;
+	int32_t sample_frequency_hz;
+	int32_t gain_aggr;
+	int32_t gain_rt;
+	int32_t gain;
+
+	struct vlp_input_stats stats;
+	struct vlp_status_sample status;
+	struct vlp_target_range target;
+};
+
 /**
  * struct global_params - Global parameters, mostly tunable via sysfs.
  * @no_turbo:		Whether or not to use turbo P-states.
@@ -239,6 +310,7 @@ struct cpudata {
 
 	struct pstate_data pstate;
 	struct vid_data vid;
+	struct vlp_data vlp;
 
 	u64	last_update;
 	u64	last_sample_time;
@@ -268,6 +340,24 @@ struct cpudata {
 
 static struct cpudata **all_cpu_data;
 
+/**
+ * struct vlp_params - VLP controller static configuration
+ * @sample_interval_ms:	     Update interval in ms.
+ * @setpoint_*_pml:	     Target CPU utilization at which the controller is
+ *			     expected to leave the current P-state untouched,
+ *			     as an integer per mille.
+ * @avg*_hz:		     Exponential averaging frequencies of the various
+ *			     low-pass filters as an integer in Hz.
+ */
+struct vlp_params {
+	int sample_interval_ms;
+	int setpoint_0_pml;
+	int setpoint_aggr_pml;
+	int avg_hz;
+	int realtime_gain_pml;
+	int debug;
+};
+
 /**
  * struct pstate_funcs - Per CPU model specific callbacks
  * @get_max:		Callback to get maximum non turbo effective P state
@@ -293,6 +383,14 @@ struct pstate_funcs {
 };
 
 static struct pstate_funcs pstate_funcs __read_mostly;
+static struct vlp_params vlp_params __read_mostly = {
+	.sample_interval_ms = 10,
+	.setpoint_0_pml = 900,
+	.setpoint_aggr_pml = 1500,
+	.avg_hz = 2,
+	.realtime_gain_pml = 0,
+	.debug = 0,
+};
 
 static int hwp_active __read_mostly;
 static int hwp_mode_bdw __read_mostly;
@@ -1790,6 +1888,306 @@ static inline int32_t get_target_pstate(struct cpudata *cpu)
 	return target;
 }
 
+/**
+ * Initialize the struct vlp_data of the specified CPU to the defaults
+ * calculated from @vlp_params.
+ */
+static void intel_pstate_reset_vlp(struct cpudata *cpu)
+{
+	struct vlp_data *vlp = &cpu->vlp;
+
+	if (cpu->policy != CPUFREQ_POLICY_ADAPTIVE)
+		return;
+
+	vlp->sample_interval_ns = vlp_params.sample_interval_ms * NSEC_PER_MSEC;
+
+	if (vlp_params.sample_interval_ms)
+		vlp->sample_frequency_hz = max(1u, (uint32_t)MSEC_PER_SEC /
+						   vlp_params.sample_interval_ms);
+	else
+		vlp->sample_frequency_hz = 0;
+
+	vlp->gain_rt = div_fp(cpu->pstate.max_pstate *
+			      vlp_params.realtime_gain_pml, 1000);
+	vlp->gain_aggr = max(1, div_fp(1000, vlp_params.setpoint_aggr_pml));
+	vlp->gain = max(1, div_fp(1000, vlp_params.setpoint_0_pml));
+	vlp->target.p_base = 0;
+	vlp->stats.last_scaling_response_hz = vlp_params.avg_hz;
+}
+
+/**
+ * Fixed point representation with twice the usual number of
+ * fractional bits.
+ */
+#define DFRAC_BITS 16
+#define DFRAC_ONE (1 << DFRAC_BITS)
+#define DFRAC_MAX_INT (0u - (uint32_t)DFRAC_ONE)
+
+/**
+ * Fast but rather inaccurate piecewise-linear approximation of a
+ * fixed-point inverse exponential:
+ *
+ *  exp2n(p) = int_tofp(1) * 2 ^ (-p / DFRAC_ONE) + O(1)
+ *
+ * The error term should be lower in magnitude than 0.044.
+ */
+static int32_t exp2n(uint32_t p)
+{
+	if (p < 32 * DFRAC_ONE) {
+		/* Interpolate between 2^-floor(p) and 2^-ceil(p). */
+		const uint32_t floor_p = p >> DFRAC_BITS;
+		const uint32_t ceil_p = (p + DFRAC_ONE - 1) >> DFRAC_BITS;
+		const uint64_t frac_p = p - (floor_p << DFRAC_BITS);
+
+		return ((int_tofp(1) >> floor_p) * (DFRAC_ONE - frac_p) +
+			(ceil_p >= 32 ? 0 : int_tofp(1) >> ceil_p) * frac_p) >>
+			DFRAC_BITS;
+	}
+
+	/* Short-circuit to avoid overflow. */
+	return 0;
+}
+
+/**
+ * Calculate the exponential averaging weight for a new sample based
+ * on the requested averaging frequency @hz and the delay since the
+ * last update.
+ */
+static int32_t get_last_sample_avg_weight(struct cpudata *cpu, unsigned int hz)
+{
+	/*
+	 * Approximate, but saves several 64-bit integer divisions
+	 * below and should be fully evaluated at compile-time.
+	 * Causes the exponential averaging to have an effective base
+	 * of 1.90702343749, which has little functional implications
+	 * as long as the hz parameter is scaled accordingly.
+	 */
+	const uint32_t ns_per_s_shift = order_base_2(NSEC_PER_SEC);
+	const uint64_t delta_ns = cpu->sample.time - cpu->last_sample_time;
+
+	return exp2n(min((uint64_t)DFRAC_MAX_INT,
+			 (hz * delta_ns) >> (ns_per_s_shift - DFRAC_BITS)));
+}
+
+/**
+ * Calculate some status information heuristically based on the struct
+ * vlp_input_stats statistics gathered by the update_state() hook.
+ */
+static const struct vlp_status_sample *get_vlp_status_sample(
+	struct cpudata *cpu, const int32_t po)
+{
+	struct vlp_data *vlp = &cpu->vlp;
+	struct vlp_input_stats *stats = &vlp->stats;
+	struct vlp_status_sample *last_status = &vlp->status;
+
+	/*
+	 * Calculate the VLP_BOTTLENECK_IO state bit, which indicates
+	 * whether some IO device driver has requested a PM response
+	 * frequency bound, typically due to the device being under
+	 * close to full utilization, which should cause the
+	 * controller to make a more conservative trade-off between
+	 * latency and energy usage, since performance isn't
+	 * guaranteed to scale further with increasing CPU frequency
+	 * whenever the system is close to IO-bound.
+	 *
+	 * Note that the maximum achievable response frequency is
+	 * limited by the sampling frequency of the controller,
+	 * response frequency requests greater than that will be
+	 * promoted to infinity (i.e. no low-pass filtering) in order
+	 * to avoid violating the response frequency constraint
+	 * provided via PM QoS.
+	 */
+	const bool bottleneck_io = stats->max_scaling_response_hz <
+				   vlp->sample_frequency_hz;
+
+	/*
+	 * Calculate the realtime statistic that tracks the
+	 * exponentially-averaged rate of occurrence of
+	 * latency-sensitive events (like wake-ups from IO wait).
+	 */
+	const uint64_t delta_ns = cpu->sample.time - cpu->last_sample_time;
+	const int32_t realtime_sample =
+		div_fp((uint64_t)(stats->realtime_count +
+				  (bottleneck_io ? 0 : stats->io_wait_count)) *
+		       NSEC_PER_SEC,
+		       100 * delta_ns);
+	const int32_t alpha = get_last_sample_avg_weight(cpu,
+							 vlp_params.avg_hz);
+	const int32_t realtime_avg = realtime_sample +
+		mul_fp(alpha, last_status->realtime_avg - realtime_sample);
+
+	/* Consume the input statistics. */
+	stats->io_wait_count = 0;
+	stats->realtime_count = 0;
+	if (bottleneck_io)
+		stats->last_scaling_response_hz =
+			stats->max_scaling_response_hz;
+	stats->max_scaling_response_hz = 0;
+
+	/* Update the state of the controller. */
+	last_status->realtime_avg = realtime_avg;
+	last_status->value = (bottleneck_io ? VLP_BOTTLENECK_IO : 0);
+
+	/* Update state used for tracing. */
+	cpu->sample.busy_scaled = int_tofp(stats->max_scaling_response_hz);
+	cpu->iowait_boost = realtime_avg;
+
+	return last_status;
+}
+
+/**
+ * Calculate the target P-state range for the next update period.
+ * Uses a variably low-pass-filtering controller intended to improve
+ * energy efficiency when a CPU response frequency target is specified
+ * via PM QoS (e.g. under IO-bound conditions).
+ */
+static const struct vlp_target_range *get_vlp_target_range(struct cpudata *cpu)
+{
+	struct vlp_data *vlp = &cpu->vlp;
+	struct vlp_target_range *last_target = &vlp->target;
+
+	/*
+	 * P-state limits in fixed-point as allowed by the policy.
+	 */
+	const int32_t p0 = int_tofp(max(cpu->pstate.min_pstate,
+					cpu->min_perf_ratio));
+	const int32_t p1 = int_tofp(cpu->max_perf_ratio);
+
+	/*
+	 * Observed average P-state during the sampling period.	 The
+	 * conservative path (po_cons) uses the TSC increment as
+	 * denominator which will give the minimum (arguably most
+	 * energy-efficient) P-state able to accomplish the observed
+	 * amount of work during the sampling period.
+	 *
+	 * The downside of that somewhat optimistic estimate is that
+	 * it can give a biased result for intermittent
+	 * latency-sensitive workloads, which may have to be completed
+	 * in a short window of time for the system to achieve maximum
+	 * performance, even if the average CPU utilization is low.
+	 * For that reason the aggressive path (po_aggr) uses the
+	 * MPERF increment as denominator, which is approximately
+	 * optimal under the pessimistic assumption that the CPU work
+	 * cannot be parallelized with any other dependent IO work
+	 * that subsequently keeps the CPU idle (partly in C1+
+	 * states).
+	 */
+	const int32_t po_cons =
+		div_fp((cpu->sample.aperf << cpu->aperf_mperf_shift)
+		       * cpu->pstate.max_pstate_physical,
+		       cpu->sample.tsc);
+	const int32_t po_aggr =
+		div_fp((cpu->sample.aperf << cpu->aperf_mperf_shift)
+		       * cpu->pstate.max_pstate_physical,
+		       (cpu->sample.mperf << cpu->aperf_mperf_shift));
+
+	const struct vlp_status_sample *status =
+		get_vlp_status_sample(cpu, po_cons);
+
+	/* Calculate the target P-state. */
+	const int32_t p_tgt_cons = mul_fp(vlp->gain, po_cons);
+	const int32_t p_tgt_aggr = mul_fp(vlp->gain_aggr, po_aggr);
+	const int32_t p_tgt = max(p0, min(p1, max(p_tgt_cons, p_tgt_aggr)));
+
+	/* Calculate the realtime P-state target lower bound. */
+	const int32_t pm = int_tofp(cpu->pstate.max_pstate);
+	const int32_t p_tgt_rt = min(pm, mul_fp(vlp->gain_rt,
+						status->realtime_avg));
+
+	/*
+	 * Low-pass filter the P-state estimate above by exponential
+	 * averaging.  For an oscillating workload (e.g. submitting
+	 * work repeatedly to a device like a soundcard or GPU) this
+	 * will approximate the minimum P-state that would be able to
+	 * accomplish the observed amount of work during the averaging
+	 * period, which is also the optimally energy-efficient one,
+	 * under the assumptions that:
+	 *
+	 *  - The power curve of the system is convex throughout the
+	 *    range of P-states allowed by the policy. I.e. energy
+	 *    efficiency is steadily decreasing with frequency past p0
+	 *    (which is typically close to the maximum-efficiency
+	 *    ratio).  In practice for the lower range of P-states
+	 *    this may only be approximately true due to the
+	 *    interaction between different components of the system.
+	 *
+	 *  - Parallelism constraints of the workload don't prevent it
+	 *    from achieving the same throughput at the lower P-state.
+	 *    This will happen in cases where the application is
+	 *    designed in a way that doesn't allow for dependent CPU
+	 *    and IO jobs to be pipelined, leading to alternating full
+	 *    and zero utilization of the CPU and IO device.  This
+	 *    will give an average IO device utilization lower than
+	 *    100% regardless of the CPU frequency, which should
+	 *    prevent the device driver from requesting a response
+	 *    frequency bound, so the filtered P-state calculated
+	 *    below won't have an influence on the controller
+	 *    response.
+	 *
+	 *  - The period of the oscillating workload is significantly
+	 *    shorter than the time constant of the exponential
+	 *    average (1s / last_scaling_response_hz).  Otherwise for
+	 *    more slowly oscillating workloads the controller
+	 *    response will roughly follow the oscillation, leading to
+	 *    decreased energy efficiency.
+	 *
+	 *  - The behavior of the workload doesn't change
+	 *    qualitatively during the next update interval.  This is
+	 *    only true in the steady state, and could possibly lead
+	 *    to a transitory period in which the controller response
+	 *    deviates from the most energy-efficient ratio until the
+	 *    workload reaches a steady state again.
+	 */
+	const int32_t alpha = get_last_sample_avg_weight(
+		cpu, vlp->stats.last_scaling_response_hz);
+
+	last_target->p_base = p_tgt + mul_fp(alpha,
+					     last_target->p_base - p_tgt);
+
+	/*
+	 * Use the low-pass-filtered controller response for better
+	 * energy efficiency unless we have reasons to believe that
+	 * some of the optimality assumptions discussed above may not
+	 * hold.
+	 */
+	if ((status->value & VLP_BOTTLENECK_IO)) {
+		last_target->value[0] = rnd_fp(p0);
+		last_target->value[1] = rnd_fp(last_target->p_base);
+	} else {
+		last_target->value[0] = rnd_fp(p_tgt_rt);
+		last_target->value[1] = rnd_fp(p1);
+	}
+
+	return last_target;
+}
+
+/**
+ * Collect some scheduling and PM statistics in response to an
+ * update_state() call.
+ */
+static bool update_vlp_sample(struct cpudata *cpu, u64 time, unsigned int flags)
+{
+	struct vlp_input_stats *stats = &cpu->vlp.stats;
+
+	/* Update PM QoS scaling response frequency request. */
+	const uint32_t resp_hz = cpu_scaling_response_qos_limit();
+
+	stats->max_scaling_response_hz = !resp_hz ? UINT_MAX :
+		max(stats->max_scaling_response_hz, resp_hz);
+
+	/* Update scheduling statistics. */
+	if ((flags & SCHED_CPUFREQ_IOWAIT))
+		stats->io_wait_count++;
+
+	if (cpu_rq(cpu->cpu)->rt.rt_nr_running)
+		stats->realtime_count++;
+
+	/* Return whether a P-state update is due. */
+	return smp_processor_id() == cpu->cpu &&
+		time - cpu->sample.time >= cpu->vlp.sample_interval_ns &&
+		intel_pstate_sample(cpu, time);
+}
+
 static int intel_pstate_prepare_request(struct cpudata *cpu, int pstate)
 {
 	int min_pstate = max(cpu->pstate.min_pstate, cpu->min_perf_ratio);
-- 
2.22.1

