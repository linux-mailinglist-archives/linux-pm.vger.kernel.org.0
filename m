Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECFE1E0477
	for <lists+linux-pm@lfdr.de>; Mon, 25 May 2020 03:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgEYBjX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 24 May 2020 21:39:23 -0400
Received: from mga12.intel.com ([192.55.52.136]:12420 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387925AbgEYBjW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 24 May 2020 21:39:22 -0400
IronPort-SDR: Qi7dwveCaFErghmEvQGQP9pKW3Ah9IrAt4clye/4/q6jyQQzgQxstGY1dWTkLc7bUTk/A2O7E6
 HU5WB00/TVMw==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2020 18:36:20 -0700
IronPort-SDR: 62+a4nNYyBnk/NTBXI1zDdYzjxkDQVpiKcQFKb4z9b1c2t2K8unZpNhpQCuxJTx6JLeXXfKVs1
 kCZ/wa2y+Cnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,431,1583222400"; 
   d="asc'?scan'208";a="375300188"
Received: from grauter-mobl1.ger.corp.intel.com (HELO otredad) ([10.252.56.65])
  by fmsmga001.fm.intel.com with ESMTP; 24 May 2020 18:36:16 -0700
From:   Francisco Jerez <francisco.jerez.plata@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>
Subject: Re: [RFC/RFT][PATCH] cpufreq: intel_pstate: Work in passive mode with HWP enabled
In-Reply-To: <3169564.ZRsPWhXyMD@kreacher>
References: <3169564.ZRsPWhXyMD@kreacher>
Date:   Sun, 24 May 2020 18:36:28 -0700
Message-ID: <87mu5wre1v.fsf@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Allow intel_pstate to work in the passive mode with HWP enabled and
> make it translate the target frequency supplied by the cpufreq
> governor in use into an EPP value to be written to the HWP request
> MSR (high frequencies are mapped to low EPP values that mean more
> performance-oriented HWP operation) as a hint for the HWP algorithm
> in the processor, so as to prevent it and the CPU scheduler from
> working against each other at least when the schedutil governor is
> in use.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> This is a prototype not intended for production use (based on linux-next).
>
> Please test it if you can (on HWP systems, of course) and let me know the
> results.
>
> The INTEL_CPUFREQ_TRANSITION_DELAY_HWP value has been guessed and it very=
 well
> may turn out to be either too high or too low for the general use, which =
is one
> reason why getting as much testing coverage as possible is key here.
>
> If you can play with different INTEL_CPUFREQ_TRANSITION_DELAY_HWP values,
> please do so and let me know the conclusions.
>
> Cheers,
> Rafael
>
> ---
>  drivers/cpufreq/intel_pstate.c |  169 +++++++++++++++++++++++++++++++---=
-------
>  1 file changed, 131 insertions(+), 38 deletions(-)
>
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -36,6 +36,7 @@
>  #define INTEL_PSTATE_SAMPLING_INTERVAL	(10 * NSEC_PER_MSEC)
>=20=20
>  #define INTEL_CPUFREQ_TRANSITION_LATENCY	20000
> +#define INTEL_CPUFREQ_TRANSITION_DELAY_HWP	5000
>  #define INTEL_CPUFREQ_TRANSITION_DELAY		500
>=20=20
>  #ifdef CONFIG_ACPI
> @@ -95,6 +96,8 @@ static inline int32_t percent_ext_fp(int
>  	return div_ext_fp(percent, 100);
>  }
>=20=20
> +#define HWP_EPP_TO_BYTE(x)	(((u64)x >> 24) & 0xFF)
> +
>  /**
>   * struct sample -	Store performance sample
>   * @core_avg_perf:	Ratio of APERF/MPERF which is the actual average
> @@ -2175,7 +2178,10 @@ static int intel_pstate_verify_policy(st
>=20=20
>  static void intel_cpufreq_stop_cpu(struct cpufreq_policy *policy)
>  {
> -	intel_pstate_set_min_pstate(all_cpu_data[policy->cpu]);
> +	if (hwp_active)
> +		intel_pstate_hwp_force_min_perf(policy->cpu);
> +	else
> +		intel_pstate_set_min_pstate(all_cpu_data[policy->cpu]);
>  }
>=20=20
>  static void intel_pstate_stop_cpu(struct cpufreq_policy *policy)
> @@ -2183,12 +2189,10 @@ static void intel_pstate_stop_cpu(struct
>  	pr_debug("CPU %d exiting\n", policy->cpu);
>=20=20
>  	intel_pstate_clear_update_util_hook(policy->cpu);
> -	if (hwp_active) {
> +	if (hwp_active)
>  		intel_pstate_hwp_save_state(policy);
> -		intel_pstate_hwp_force_min_perf(policy->cpu);
> -	} else {
> -		intel_cpufreq_stop_cpu(policy);
> -	}
> +
> +	intel_cpufreq_stop_cpu(policy);
>  }
>=20=20
>  static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
> @@ -2296,7 +2300,8 @@ static int intel_cpufreq_verify_policy(s
>  #define	INTEL_PSTATE_TRACE_TARGET 10
>  #define	INTEL_PSTATE_TRACE_FAST_SWITCH 90
>=20=20
> -static void intel_cpufreq_trace(struct cpudata *cpu, unsigned int trace_=
type, int old_pstate)
> +static void intel_cpufreq_trace(struct cpudata *cpu, unsigned int trace_=
type,
> +				int from, int to)
>  {
>  	struct sample *sample;
>=20=20
> @@ -2309,8 +2314,8 @@ static void intel_cpufreq_trace(struct c
>  	sample =3D &cpu->sample;
>  	trace_pstate_sample(trace_type,
>  		0,
> -		old_pstate,
> -		cpu->pstate.current_pstate,
> +		from,
> +		to,
>  		sample->mperf,
>  		sample->aperf,
>  		sample->tsc,
> @@ -2318,40 +2323,110 @@ static void intel_cpufreq_trace(struct c
>  		fp_toint(cpu->iowait_boost * 100));
>  }
>=20=20
> -static int intel_cpufreq_target(struct cpufreq_policy *policy,
> -				unsigned int target_freq,
> -				unsigned int relation)
> +static void intel_cpufreq_update_hwp_request(struct cpudata *cpu, u8 new=
_epp)
>  {
> -	struct cpudata *cpu =3D all_cpu_data[policy->cpu];
> -	struct cpufreq_freqs freqs;
> -	int target_pstate, old_pstate;
> +	u64 value, prev;
>=20=20
> -	update_turbo_state();
> +	prev =3D READ_ONCE(cpu->hwp_req_cached);
> +	value =3D prev;
>=20=20
> -	freqs.old =3D policy->cur;
> -	freqs.new =3D target_freq;
> +	/*
> +	 * The entire MSR needs to be updated in order to update the EPP field
> +	 * in it, so opportunistically update the min and max too if needed.
> +	 */
> +	value &=3D ~HWP_MIN_PERF(~0L);
> +	value |=3D HWP_MIN_PERF(cpu->min_perf_ratio);
> +
> +	value &=3D ~HWP_MAX_PERF(~0L);
> +	value |=3D HWP_MAX_PERF(cpu->max_perf_ratio);
> +
> +	if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
> +		intel_cpufreq_trace(cpu, INTEL_PSTATE_TRACE_TARGET,
> +				    HWP_EPP_TO_BYTE(prev), new_epp);
> +
> +		value &=3D ~GENMASK_ULL(31, 24);
> +		value |=3D HWP_ENERGY_PERF_PREFERENCE(new_epp);
> +	}
> +
> +	if (value !=3D prev) {
> +		WRITE_ONCE(cpu->hwp_req_cached, value);
> +		wrmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
> +	}
> +}
> +
> +/**
> + * intel_cpufreq_adjust_hwp_request - Adjust the HWP reuqest register.
> + * @cpu: Target CPU.
> + * @max_freq: Maximum frequency to consider.
> + * @target_freq: Target frequency selected by the governor.
> + *
> + * Translate the target frequency into a new EPP value to be written int=
o the
> + * HWP request MSR of @cpu as a hint for the HW-driven P-state selection.
> + *
> + * The purpose of this is to avoid situations in which the kernel and th=
e HWP
> + * algorithm work against each other by giving a hint about the expectat=
ions of
> + * the former to the latter.
> + *
> + * The mapping betweeen the target frequencies and the hint values need =
not be
> + * exact, but it must be monotonic, so that higher target frequencies al=
ways
> + * indicate more performance-oriented P-state selection.
> + */
> +static void intel_cpufreq_adjust_hwp_request(struct cpudata *cpu, s64 ma=
x_freq,
> +					     unsigned int target_freq)
> +{
> +	s64 epp_fp =3D div_fp(255 * (max_freq - target_freq), max_freq);
> +
> +	intel_cpufreq_update_hwp_request(cpu, fp_toint(epp_fp));
> +}
> +

Hey Rafael, I'm building a kernel with this in order to give it a try on
my system, but I'm skeptical that translating the target frequency to an
EPP value will work reliably.  AFAIA the EPP value only has an indirect
influence on the processor's performance by adjusting the trade-off
between its responsiveness (rather than the actual clock frequency which
it will sustain in the long run) and its energy usage, in a largely
unspecified and non-linear way (non-linear like the effect of switching
CPU energy optimization features on and off, or like its effect on the
energy balancing behavior of the processor which can have a paradoxical
effect on performance).

I doubt that the scheduling-based CPU utilization is a good predictor
for the optimal trade-off between those two variables.  Consider the
following scenarios where this would deviate from the typical default
EPP of 0x80:

 - The application has low CPU utilization (say 10%) but it's
   latency-bound, the current default EPP value allows the CPU to ramp
   up during each burst and deliver reasonable average performance.
   With this code in effect you may end up at an EPP > 0xE0 which will
   severely limit the responsiveness of the HWP during each burst of
   work, possibly reducing performance (since the application was
   latency-bound), which will cause the CPU utilization of the process
   to further decrease, leading to a further increase in EPP and further
   decrease in performance (IOW this failure mode would have positive
   feedback rather than being somehow self-correcting).

 - The application has medium to high CPU utilization (say 60%), but
   it's IO-bound (e.g. a database server with a hard-drive bottleneck).
   This would cause you to program an EPP value around 0x60 which will
   cause the HWP to respond more aggressively than currently to each
   burst of work, increasing energy usage without a corresponding
   increase in performance (since the application was IO-bound).

 - Same as the last point, but the application is TDP-bound instead
   (e.g. a computer game running on an integrated GPU).  Not only will
   CPU energy usage increase, but performance will decrease with it, due
   to the TDP budget being stolen from the GPU.

 - The application has medium to low CPU utilization and frequently
   migrates between CPU cores.  This would end up at an EPP >=3D 0x80
   which won't give the application any CPU responsiveness advantage
   during migration over the current behavior (but possibly quite the
   opposite), even though the scheduler might know exactly what CPU
   frequency the application was able to average, and could have saved
   it some significant amount of ramp-up time.

It seems to me that hooking this up to the HWP_MIN_PERF control instead
of EPP would have a more deterministic effect and avoid the failure
scenarios described above.  E.g. upon migration you would be able to
instantly set up the new CPU core to the same P-state you knew the
application was averaging before migration.  No performance is
sacrificed in latency-bound applications since you wouldn't be limiting
the HWP's responsiveness.  No energy efficiency is sacrificed in the
steady state since you would be programming the most energy-efficient
(minimum constant) P-state which is able to deliver the observed
performance of the application -- It might make sense to program that
value *minus* some small margin though, in order to give the HWP the
chance to clock down in cases where the load fluctuates discontinuously
before the next update of the HWP request.

Of course it would also be nice to give schedutil control of
HWP_MAX_PERF eventually, e.g. by implementing the energy efficiency
optimization I've been proposing [1] in schedutil too.

[1] https://lwn.net/Articles/818827/

> +static int intel_cpufreq_adjust_pstate(struct cpudata *cpu,
> +				       unsigned int target_freq,
> +				       unsigned int relation)
> +{
> +	int old_pstate =3D cpu->pstate.current_pstate;
> +	int target_pstate;
>=20=20
> -	cpufreq_freq_transition_begin(policy, &freqs);
>  	switch (relation) {
>  	case CPUFREQ_RELATION_L:
> -		target_pstate =3D DIV_ROUND_UP(freqs.new, cpu->pstate.scaling);
> +		target_pstate =3D DIV_ROUND_UP(target_freq, cpu->pstate.scaling);
>  		break;
>  	case CPUFREQ_RELATION_H:
> -		target_pstate =3D freqs.new / cpu->pstate.scaling;
> +		target_pstate =3D target_freq / cpu->pstate.scaling;
>  		break;
>  	default:
> -		target_pstate =3D DIV_ROUND_CLOSEST(freqs.new, cpu->pstate.scaling);
> +		target_pstate =3D DIV_ROUND_CLOSEST(target_freq, cpu->pstate.scaling);
>  		break;
>  	}
>  	target_pstate =3D intel_pstate_prepare_request(cpu, target_pstate);
> -	old_pstate =3D cpu->pstate.current_pstate;
> -	if (target_pstate !=3D cpu->pstate.current_pstate) {
> +	if (target_pstate !=3D old_pstate) {
>  		cpu->pstate.current_pstate =3D target_pstate;
> -		wrmsrl_on_cpu(policy->cpu, MSR_IA32_PERF_CTL,
> +		wrmsrl_on_cpu(cpu->cpu, MSR_IA32_PERF_CTL,
>  			      pstate_funcs.get_val(cpu, target_pstate));
>  	}
> -	freqs.new =3D target_pstate * cpu->pstate.scaling;
> -	intel_cpufreq_trace(cpu, INTEL_PSTATE_TRACE_TARGET, old_pstate);
> +	intel_cpufreq_trace(cpu, INTEL_PSTATE_TRACE_TARGET, old_pstate, target_=
pstate);
> +	return target_pstate * cpu->pstate.scaling;
> +}
> +
> +static int intel_cpufreq_target(struct cpufreq_policy *policy,
> +				unsigned int target_freq,
> +				unsigned int relation)
> +{
> +	struct cpudata *cpu =3D all_cpu_data[policy->cpu];
> +	struct cpufreq_freqs freqs;
> +
> +	update_turbo_state();
> +
> +	freqs.old =3D policy->cur;
> +	freqs.new =3D target_freq;
> +
> +	cpufreq_freq_transition_begin(policy, &freqs);
> +
> +	if (hwp_active)
> +		intel_cpufreq_adjust_hwp_request(cpu, policy->cpuinfo.max_freq,
> +						 target_freq);
> +	else
> +		freqs.new =3D intel_cpufreq_adjust_pstate(cpu, target_freq, relation);
> +
>  	cpufreq_freq_transition_end(policy, &freqs, false);
>=20=20
>  	return 0;
> @@ -2365,11 +2440,18 @@ static unsigned int intel_cpufreq_fast_s
>=20=20
>  	update_turbo_state();
>=20=20
> +	if (hwp_active) {
> +		intel_cpufreq_adjust_hwp_request(cpu, policy->cpuinfo.max_freq,
> +						 target_freq);
> +		return target_freq;
> +	}
> +
>  	target_pstate =3D DIV_ROUND_UP(target_freq, cpu->pstate.scaling);
>  	target_pstate =3D intel_pstate_prepare_request(cpu, target_pstate);
>  	old_pstate =3D cpu->pstate.current_pstate;
>  	intel_pstate_update_pstate(cpu, target_pstate);
> -	intel_cpufreq_trace(cpu, INTEL_PSTATE_TRACE_FAST_SWITCH, old_pstate);
> +	intel_cpufreq_trace(cpu, INTEL_PSTATE_TRACE_FAST_SWITCH, old_pstate,
> +			    target_pstate);
>  	return target_pstate * cpu->pstate.scaling;
>  }
>=20=20
> @@ -2389,7 +2471,6 @@ static int intel_cpufreq_cpu_init(struct
>  		return ret;
>=20=20
>  	policy->cpuinfo.transition_latency =3D INTEL_CPUFREQ_TRANSITION_LATENCY;
> -	policy->transition_delay_us =3D INTEL_CPUFREQ_TRANSITION_DELAY;
>  	/* This reflects the intel_pstate_get_cpu_pstates() setting. */
>  	policy->cur =3D policy->cpuinfo.min_freq;
>=20=20
> @@ -2401,10 +2482,19 @@ static int intel_cpufreq_cpu_init(struct
>=20=20
>  	cpu =3D all_cpu_data[policy->cpu];
>=20=20
> -	if (hwp_active)
> +	if (hwp_active) {
> +		u64 value;
> +
> +		rdmsrl_on_cpu(policy->cpu, MSR_HWP_REQUEST, &value);
> +		WRITE_ONCE(cpu->hwp_req_cached, value);
> +		cpu->epp_saved =3D HWP_EPP_TO_BYTE(value);
> +
>  		intel_pstate_get_hwp_max(policy->cpu, &turbo_max, &max_state);
> -	else
> +		policy->transition_delay_us =3D INTEL_CPUFREQ_TRANSITION_DELAY_HWP;
> +	} else {
>  		turbo_max =3D cpu->pstate.turbo_pstate;
> +		policy->transition_delay_us =3D INTEL_CPUFREQ_TRANSITION_DELAY;
> +	}
>=20=20
>  	min_freq =3D DIV_ROUND_UP(turbo_max * global.min_perf_pct, 100);
>  	min_freq *=3D cpu->pstate.scaling;
> @@ -2449,6 +2539,13 @@ static int intel_cpufreq_cpu_exit(struct
>  	freq_qos_remove_request(req);
>  	kfree(req);
>=20=20
> +	if (hwp_active) {
> +		struct cpudata *cpu =3D all_cpu_data[policy->cpu];
> +
> +		/* Restore the original HWP EPP value. */
> +		intel_cpufreq_update_hwp_request(cpu, cpu->epp_saved);
> +	}
> +
>  	return intel_pstate_cpu_exit(policy);
>  }
>=20=20
> @@ -2505,9 +2602,6 @@ static int intel_pstate_register_driver(
>=20=20
>  static int intel_pstate_unregister_driver(void)
>  {
> -	if (hwp_active)
> -		return -EBUSY;
> -
>  	cpufreq_unregister_driver(intel_pstate_driver);
>  	intel_pstate_driver_cleanup();
>=20=20
> @@ -2815,12 +2909,11 @@ static int __init intel_pstate_setup(cha
>  	if (!str)
>  		return -EINVAL;
>=20=20
> -	if (!strcmp(str, "disable")) {
> +	if (!strcmp(str, "disable"))
>  		no_load =3D 1;
> -	} else if (!strcmp(str, "passive")) {
> +	else if (!strcmp(str, "passive"))
>  		default_driver =3D &intel_cpufreq;
> -		no_hwp =3D 1;
> -	}
> +
>  	if (!strcmp(str, "no_hwp")) {
>  		pr_info("HWP disabled\n");
>  		no_hwp =3D 1;

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCXsshHAAKCRCDmTidfVK/
Wy/MAP998cc0Ec/kAmm1qXN+z4GU5Mik5erwsG8HCsgt7mfYjQEAoQdkFgenBH8a
a8VtqumBFPLedbBtwVTWv0Gw6FVN3L8=
=yUY1
-----END PGP SIGNATURE-----
--==-=-=--
