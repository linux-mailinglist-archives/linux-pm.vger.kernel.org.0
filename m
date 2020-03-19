Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFA1918B20B
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 12:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgCSLGH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 07:06:07 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52319 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCSLGH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 07:06:07 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 18de2cf8c8d831e9; Thu, 19 Mar 2020 12:06:02 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Francisco Jerez <currojerez@riseup.net>
Cc:     linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 05/10] cpufreq: intel_pstate: Implement VLP controller statistics and status calculation.
Date:   Thu, 19 Mar 2020 12:06:02 +0100
Message-ID: <3789314.5IfZyTANZo@kreacher>
In-Reply-To: <20200310214203.26459-6-currojerez@riseup.net>
References: <20200310214203.26459-1-currojerez@riseup.net> <20200310214203.26459-6-currojerez@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday, March 10, 2020 10:41:58 PM CET Francisco Jerez wrote:
> The goal of the helper code introduced here is to compute two
> informational data structures: struct vlp_input_stats aggregating
> various scheduling and PM statistics gathered in every call of the
> update_util() hook, and struct vlp_status_sample which contains status
> information derived from the former indicating whether the system is
> likely to have an IO or CPU bottleneck.  This will be used as main
> heuristic input by the new variably low-pass filtering controller (AKA
> VLP)

I'm not sure how widely used this is.

It would be good to provide a pointer to a definition of it where all of
the maths is described and the foundation of it is explained.  Alternatively,
document it in the kernel source.

> that will assist the HWP at finding a reasonably energy-efficient
> P-state given the additional information available to the kernel about
> I/O utilization and scheduling behavior.
> 
> Signed-off-by: Francisco Jerez <currojerez@riseup.net>
> ---
>  drivers/cpufreq/intel_pstate.c | 230 +++++++++++++++++++++++++++++++++
>  1 file changed, 230 insertions(+)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 8cb5bf419b40..12ee350db2a9 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -19,6 +19,7 @@
>  #include <linux/list.h>
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
> +#include <linux/debugfs.h>
>  #include <linux/sysfs.h>
>  #include <linux/types.h>
>  #include <linux/fs.h>
> @@ -33,6 +34,8 @@
>  #include <asm/cpufeature.h>
>  #include <asm/intel-family.h>
>  
> +#include "../../kernel/sched/sched.h"
> +
>  #define INTEL_PSTATE_SAMPLING_INTERVAL	(10 * NSEC_PER_MSEC)
>  
>  #define INTEL_CPUFREQ_TRANSITION_LATENCY	20000
> @@ -59,6 +62,11 @@ static inline int32_t mul_fp(int32_t x, int32_t y)
>  	return ((int64_t)x * (int64_t)y) >> FRAC_BITS;
>  }
>  
> +static inline int rnd_fp(int32_t x)

What does md stand for?

> +{
> +	return (x + (1 << (FRAC_BITS - 1))) >> FRAC_BITS;
> +}
> +
>  static inline int32_t div_fp(s64 x, s64 y)
>  {
>  	return div64_s64((int64_t)x << FRAC_BITS, y);
> @@ -169,6 +177,49 @@ struct vid_data {
>  	int32_t ratio;
>  };
>  
> +/**
> + * Scheduling and PM statistics gathered by update_vlp_sample() at
> + * every call of the VLP update_state() hook, used as heuristic
> + * inputs.
> + */
> +struct vlp_input_stats {
> +	int32_t realtime_count;
> +	int32_t io_wait_count;
> +	uint32_t max_response_frequency_hz;
> +	uint32_t last_response_frequency_hz;
> +};
> +
> +enum vlp_status {
> +	VLP_BOTTLENECK_IO = 1 << 0,
> +	/*
> +	 * XXX - Add other status bits here indicating a CPU or TDP
> +	 * bottleneck.
> +	 */
> +};
> +
> +/**
> + * Heuristic status information calculated by get_vlp_status_sample()
> + * from struct vlp_input_stats above, indicating whether the system
> + * has a potential IO or latency bottleneck.
> + */
> +struct vlp_status_sample {
> +	enum vlp_status value;
> +	int32_t realtime_avg;
> +};
> +
> +/**
> + * struct vlp_data - VLP controller parameters and state.
> + * @sample_interval_ns:	 Update interval in ns.
> + * @sample_frequency_hz: Reciprocal of the update interval in Hz.
> + */
> +struct vlp_data {
> +	s64 sample_interval_ns;
> +	int32_t sample_frequency_hz;
> +
> +	struct vlp_input_stats stats;
> +	struct vlp_status_sample status;
> +};
> +
>  /**
>   * struct global_params - Global parameters, mostly tunable via sysfs.
>   * @no_turbo:		Whether or not to use turbo P-states.
> @@ -239,6 +290,7 @@ struct cpudata {
>  
>  	struct pstate_data pstate;
>  	struct vid_data vid;
> +	struct vlp_data vlp;
>  
>  	u64	last_update;
>  	u64	last_sample_time;
> @@ -268,6 +320,18 @@ struct cpudata {
>  
>  static struct cpudata **all_cpu_data;
>  
> +/**
> + * struct vlp_params - VLP controller static configuration
> + * @sample_interval_ms:	     Update interval in ms.
> + * @avg*_hz:		     Exponential averaging frequencies of the various
> + *			     low-pass filters as an integer in Hz.
> + */
> +struct vlp_params {
> +	int sample_interval_ms;
> +	int avg_hz;
> +	int debug;
> +};
> +
>  /**
>   * struct pstate_funcs - Per CPU model specific callbacks
>   * @get_max:		Callback to get maximum non turbo effective P state
> @@ -296,6 +360,11 @@ struct pstate_funcs {
>  };
>  
>  static struct pstate_funcs pstate_funcs __read_mostly;
> +static struct vlp_params vlp_params __read_mostly = {
> +	.sample_interval_ms = 10,
> +	.avg_hz = 2,
> +	.debug = 0,
> +};
>  
>  static int hwp_active __read_mostly;
>  static int hwp_mode_bdw __read_mostly;
> @@ -1793,6 +1862,167 @@ static inline int32_t get_target_pstate(struct cpudata *cpu)
>  	return target;
>  }
>  
> +/**
> + * Initialize the struct vlp_data of the specified CPU to the defaults
> + * calculated from @vlp_params.
> + */

Nit: All of the function header comments need to be in the canonical kerneldoc
format, ie. with arguments listed etc.

> +static void intel_pstate_reset_vlp(struct cpudata *cpu)
> +{
> +	struct vlp_data *vlp = &cpu->vlp;
> +
> +	vlp->sample_interval_ns = vlp_params.sample_interval_ms * NSEC_PER_MSEC;
> +	vlp->sample_frequency_hz = max(1u, (uint32_t)MSEC_PER_SEC /
> +					   vlp_params.sample_interval_ms);
> +	vlp->stats.last_response_frequency_hz = vlp_params.avg_hz;
> +}
> +
> +/**
> + * Fixed point representation with twice the usual number of
> + * fractional bits.
> + */
> +#define DFRAC_BITS 16
> +#define DFRAC_ONE (1 << DFRAC_BITS)
> +#define DFRAC_MAX_INT (0u - (uint32_t)DFRAC_ONE)
> +
> +/**
> + * Fast but rather inaccurate piecewise-linear approximation of a
> + * fixed-point inverse exponential:
> + *
> + *  exp2n(p) = int_tofp(1) * 2 ^ (-p / DFRAC_ONE) + O(1)
> + *
> + * The error term should be lower in magnitude than 0.044.
> + */
> +static int32_t exp2n(uint32_t p)
> +{
> +	if (p < 32 * DFRAC_ONE) {
> +		/* Interpolate between 2^-floor(p) and 2^-ceil(p). */
> +		const uint32_t floor_p = p >> DFRAC_BITS;
> +		const uint32_t ceil_p = (p + DFRAC_ONE - 1) >> DFRAC_BITS;
> +		const uint64_t frac_p = p - (floor_p << DFRAC_BITS);
> +
> +		return ((int_tofp(1) >> floor_p) * (DFRAC_ONE - frac_p) +
> +			(ceil_p >= 32 ? 0 : int_tofp(1) >> ceil_p) * frac_p) >>
> +			DFRAC_BITS;
> +	}
> +
> +	/* Short-circuit to avoid overflow. */
> +	return 0;
> +}
> +
> +/**
> + * Calculate the exponential averaging weight for a new sample based
> + * on the requested averaging frequency @hz and the delay since the
> + * last update.
> + */
> +static int32_t get_last_sample_avg_weight(struct cpudata *cpu, unsigned int hz)
> +{
> +	/*
> +	 * Approximate, but saves several 64-bit integer divisions
> +	 * below and should be fully evaluated at compile-time.
> +	 * Causes the exponential averaging to have an effective base
> +	 * of 1.90702343749, which has little functional implications
> +	 * as long as the hz parameter is scaled accordingly.
> +	 */
> +	const uint32_t ns_per_s_shift = order_base_2(NSEC_PER_SEC);
> +	const uint64_t delta_ns = cpu->sample.time - cpu->last_sample_time;
> +
> +	return exp2n(min((uint64_t)DFRAC_MAX_INT,
> +			 (hz * delta_ns) >> (ns_per_s_shift - DFRAC_BITS)));
> +}
> +
> +/**
> + * Calculate some status information heuristically based on the struct
> + * vlp_input_stats statistics gathered by the update_state() hook.
> + */
> +static const struct vlp_status_sample *get_vlp_status_sample(
> +	struct cpudata *cpu, const int32_t po)
> +{
> +	struct vlp_data *vlp = &cpu->vlp;
> +	struct vlp_input_stats *stats = &vlp->stats;
> +	struct vlp_status_sample *last_status = &vlp->status;
> +
> +	/*
> +	 * Calculate the VLP_BOTTLENECK_IO state bit, which indicates
> +	 * whether some IO device driver has requested a PM response
> +	 * frequency bound, typically due to the device being under
> +	 * close to full utilization, which should cause the
> +	 * controller to make a more conservative trade-off between
> +	 * latency and energy usage, since performance isn't
> +	 * guaranteed to scale further with increasing CPU frequency
> +	 * whenever the system is close to IO-bound.
> +	 *
> +	 * Note that the maximum achievable response frequency is
> +	 * limited by the sampling frequency of the controller,
> +	 * response frequency requests greater than that will be
> +	 * promoted to infinity (i.e. no low-pass filtering) in order
> +	 * to avoid violating the response frequency constraint
> +	 * provided via PM QoS.
> +	 */
> +	const bool bottleneck_io = stats->max_response_frequency_hz <
> +				   vlp->sample_frequency_hz;
> +
> +	/*
> +	 * Calculate the realtime statistic that tracks the
> +	 * exponentially-averaged rate of occurrence of
> +	 * latency-sensitive events (like wake-ups from IO wait).
> +	 */
> +	const uint64_t delta_ns = cpu->sample.time - cpu->last_sample_time;
> +	const int32_t realtime_sample =
> +		div_fp((uint64_t)(stats->realtime_count +
> +				  (bottleneck_io ? 0 : stats->io_wait_count)) *
> +		       NSEC_PER_SEC,
> +		       100 * delta_ns);
> +	const int32_t alpha = get_last_sample_avg_weight(cpu,
> +							 vlp_params.avg_hz);
> +	const int32_t realtime_avg = realtime_sample +
> +		mul_fp(alpha, last_status->realtime_avg - realtime_sample);
> +
> +	/* Consume the input statistics. */
> +	stats->io_wait_count = 0;
> +	stats->realtime_count = 0;
> +	if (bottleneck_io)
> +		stats->last_response_frequency_hz =
> +			stats->max_response_frequency_hz;
> +	stats->max_response_frequency_hz = 0;
> +
> +	/* Update the state of the controller. */
> +	last_status->realtime_avg = realtime_avg;
> +	last_status->value = (bottleneck_io ? VLP_BOTTLENECK_IO : 0);
> +
> +	/* Update state used for tracing. */
> +	cpu->sample.busy_scaled = int_tofp(stats->max_response_frequency_hz);
> +	cpu->iowait_boost = realtime_avg;
> +
> +	return last_status;
> +}
> +
> +/**
> + * Collect some scheduling and PM statistics in response to an
> + * update_state() call.
> + */
> +static bool update_vlp_sample(struct cpudata *cpu, u64 time, unsigned int flags)
> +{
> +	struct vlp_input_stats *stats = &cpu->vlp.stats;
> +
> +	/* Update PM QoS request. */
> +	const uint32_t resp_hz = cpu_response_frequency_qos_limit();
> +
> +	stats->max_response_frequency_hz = !resp_hz ? UINT_MAX :
> +		max(stats->max_response_frequency_hz, resp_hz);
> +
> +	/* Update scheduling statistics. */
> +	if ((flags & SCHED_CPUFREQ_IOWAIT))
> +		stats->io_wait_count++;
> +
> +	if (cpu_rq(cpu->cpu)->rt.rt_nr_running)
> +		stats->realtime_count++;
> +
> +	/* Return whether a P-state update is due. */
> +	return smp_processor_id() == cpu->cpu &&
> +		time - cpu->sample.time >= cpu->vlp.sample_interval_ns &&
> +		intel_pstate_sample(cpu, time);
> +}
> +
>  static int intel_pstate_prepare_request(struct cpudata *cpu, int pstate)
>  {
>  	int min_pstate = max(cpu->pstate.min_pstate, cpu->min_perf_ratio);
> 




