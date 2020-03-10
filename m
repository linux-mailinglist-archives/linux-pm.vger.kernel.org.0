Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16D47180AD0
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 22:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbgCJVqZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 17:46:25 -0400
Received: from mx1.riseup.net ([198.252.153.129]:49234 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbgCJVqY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Mar 2020 17:46:24 -0400
Received: from bell.riseup.net (unknown [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 48cTDv5qNzzFf7g;
        Tue, 10 Mar 2020 14:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1583876783; bh=KEkzgcuMGqyPvBrxJ4k0uNT7bSd/BkqPcZ27lj5X3iQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SsE+jQECn1EKJsgYYTSBo6F1id/YM6VWt39fclFqNhwoM4MoRKR8K7uFm7/SJR1TD
         heL7OFWXINHXDJpgE5u8Dww6bpjrPnEH2erUnKd408jVOSQDsJhHEY0uvLXmw630YI
         k32HpJUJvsY0yI9Ox1WvM44Zjk4oX12SVhTpmd98=
X-Riseup-User-ID: AD4EAA60D84A63821C196DFB6AFBF4BEDE6F01FBB0D27219F575F5C9C11F17D0
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id 48cTDv3zs7zJsFM;
        Tue, 10 Mar 2020 14:46:23 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 06/10] cpufreq: intel_pstate: Implement VLP controller target P-state range estimation.
Date:   Tue, 10 Mar 2020 14:41:59 -0700
Message-Id: <20200310214203.26459-7-currojerez@riseup.net>
In-Reply-To: <20200310214203.26459-1-currojerez@riseup.net>
References: <20200310214203.26459-1-currojerez@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The function introduced here calculates a P-state range derived from
the statistics computed in the previous patch which will be used to
drive the HWP P-state range or (if HWP is not available) as basis for
some additional kernel-side frequency selection mechanism which will
choose a single P-state from the range.  This is meant to provide a
variably low-pass filtering effect that will damp oscillations below a
frequency threshold that can be specified by device drivers via PM QoS
in order to achieve energy-efficient behavior in cases where the
system has an IO bottleneck.

Signed-off-by: Francisco Jerez <currojerez@riseup.net>
---
 drivers/cpufreq/intel_pstate.c | 157 +++++++++++++++++++++++++++++++++
 1 file changed, 157 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 12ee350db2a9..cecadfec8bc1 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -207,17 +207,34 @@ struct vlp_status_sample {
 	int32_t realtime_avg;
 };
 
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
 /**
  * struct vlp_data - VLP controller parameters and state.
  * @sample_interval_ns:	 Update interval in ns.
  * @sample_frequency_hz: Reciprocal of the update interval in Hz.
+ * @gain*:		 Response factor of the controller relative to each
+ *			 one of its linear input variables as fixed-point
+ *			 fraction.
  */
 struct vlp_data {
 	s64 sample_interval_ns;
 	int32_t sample_frequency_hz;
+	int32_t gain_aggr;
+	int32_t gain_rt;
+	int32_t gain;
 
 	struct vlp_input_stats stats;
 	struct vlp_status_sample status;
+	struct vlp_target_range target;
 };
 
 /**
@@ -323,12 +340,18 @@ static struct cpudata **all_cpu_data;
 /**
  * struct vlp_params - VLP controller static configuration
  * @sample_interval_ms:	     Update interval in ms.
+ * @setpoint_*_pml:	     Target CPU utilization at which the controller is
+ *			     expected to leave the current P-state untouched,
+ *			     as an integer per mille.
  * @avg*_hz:		     Exponential averaging frequencies of the various
  *			     low-pass filters as an integer in Hz.
  */
 struct vlp_params {
 	int sample_interval_ms;
+	int setpoint_0_pml;
+	int setpoint_aggr_pml;
 	int avg_hz;
+	int realtime_gain_pml;
 	int debug;
 };
 
@@ -362,7 +385,10 @@ struct pstate_funcs {
 static struct pstate_funcs pstate_funcs __read_mostly;
 static struct vlp_params vlp_params __read_mostly = {
 	.sample_interval_ms = 10,
+	.setpoint_0_pml = 900,
+	.setpoint_aggr_pml = 1500,
 	.avg_hz = 2,
+	.realtime_gain_pml = 12000,
 	.debug = 0,
 };
 
@@ -1873,6 +1899,11 @@ static void intel_pstate_reset_vlp(struct cpudata *cpu)
 	vlp->sample_interval_ns = vlp_params.sample_interval_ms * NSEC_PER_MSEC;
 	vlp->sample_frequency_hz = max(1u, (uint32_t)MSEC_PER_SEC /
 					   vlp_params.sample_interval_ms);
+	vlp->gain_rt = div_fp(cpu->pstate.max_pstate *
+			      vlp_params.realtime_gain_pml, 1000);
+	vlp->gain_aggr = max(1, div_fp(1000, vlp_params.setpoint_aggr_pml));
+	vlp->gain = max(1, div_fp(1000, vlp_params.setpoint_0_pml));
+	vlp->target.p_base = 0;
 	vlp->stats.last_response_frequency_hz = vlp_params.avg_hz;
 }
 
@@ -1996,6 +2027,132 @@ static const struct vlp_status_sample *get_vlp_status_sample(
 	return last_status;
 }
 
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
+	 *    average (1s / last_response_frequency_hz).  Otherwise for
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
+		cpu, vlp->stats.last_response_frequency_hz);
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
 /**
  * Collect some scheduling and PM statistics in response to an
  * update_state() call.
-- 
2.22.1

