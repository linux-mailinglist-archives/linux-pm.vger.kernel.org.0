Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB46220142
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 02:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgGOAJl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 20:09:41 -0400
Received: from mx1.riseup.net ([198.252.153.129]:56290 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbgGOAJl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Jul 2020 20:09:41 -0400
Received: from capuchin.riseup.net (capuchin-pn.riseup.net [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4B5yS41CzNzFccC;
        Tue, 14 Jul 2020 17:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1594771780; bh=Ad5qlOqnmimrNbAC4ZME4HG7yQpdX8yK593nHQsZmmQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=o5Xfxk2cMSN3DCGJZcyfTaLyyKtgbe+HsWgbW9XYTDf2idWXYFyIONCHoIQ4F1Cy9
         eMB5K/N7N/EkeFjotkH6SA3w1TTOX8yy+Zn3bhRnn9ibbprTlLxX+sp1tivRlhybIn
         Sx/efcnXT9UfW+54hDNaaBUCmAQxo6WKqM4IUEvI=
X-Riseup-User-ID: E6178C2038C11DF7FD051B4B29915B39E4249CB275ACF2B1623D68C4225D3A25
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 4B5yS341n4z8tqN;
        Tue, 14 Jul 2020 17:09:39 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux Documentation <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>
Subject: Re: [PATCH] cpufreq: intel_pstate: Implement passive mode with HWP enabled
In-Reply-To: <3955470.QvD6XneCf3@kreacher>
References: <3955470.QvD6XneCf3@kreacher>
Date:   Tue, 14 Jul 2020 17:09:33 -0700
Message-ID: <87r1tdiqpu.fsf@riseup.net>
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
> make it set the HWP minimum performance limit (HWP floor) to the
> P-state value given by the target frequency supplied by the cpufreq
> governor, so as to prevent the HWP algorithm and the CPU scheduler
> from working against each other, at least when the schedutil governor
> is in use, and update the intel_pstate documentation accordingly.
>
> Among other things, this allows utilization clamps to be taken
> into account, at least to a certain extent, when intel_pstate is
> in use and makes it more likely that sufficient capacity for
> deadline tasks will be provided.
>
> After this change, the resulting behavior of an HWP system with
> intel_pstate in the passive mode should be close to the behavior
> of the analogous non-HWP system with intel_pstate in the passive
> mode, except that in the frequency range below the base frequency
> (ie. the frequency retured by the base_frequency cpufreq attribute
> in sysfs on HWP systems) the HWP algorithm is allowed to go above
> the floor P-state set by intel_pstate with or without hardware
> coordination of P-states among CPUs in the same package.
>
> Also note that the setting of the HWP floor may not be taken into
> account by the processor in the following cases:
>
>  * For the HWP floor in the range of P-states above the base
>    frequency, referred to as the turbo range, the processor has a
>    license to choose any P-state from that range, either below or
>    above the HWP floor, just like a non-HWP processor in the case
>    when the target P-state falls into the turbo range.
>
>  * If P-states of the CPUs in the same package are coordinated
>    at the hardware level, the processor may choose a P-state
>    above the HWP floor, just like a non-HWP processor in the
>    analogous case.
>
> With this change applied, intel_pstate in the passive mode
> assumes complete control over the HWP request MSR and concurrent
> changes of that MSR (eg. via the direct MSR access interface) are
> overridden by it.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> This basically unifies the passive mode behavior of intel_pstate for syst=
ems
> with and without HWP enabled.  The only case in which there is a differen=
ce
> between the two (after this patch) is below the turbo range, where the HWP
> algorithm can go above the floor regardless of whether or not P-state are
> coordinated package-wide (this means the systems with per-core P-states
> mostly is where the difference can be somewhat visible).
>
> Since the passive mode hasn't worked with HWP at all, and it is not going=
 to
> the default for HWP systems anyway, I don't see any drawbacks related to =
making
> this change, so I would consider this as 5.9 material unless there are any
> serious objections.
>
> Thanks!
>
> ---
>  Documentation/admin-guide/pm/intel_pstate.rst |   89 +++++++---------
>  drivers/cpufreq/intel_pstate.c                |  141 +++++++++++++++++++=
+------
>  2 files changed, 152 insertions(+), 78 deletions(-)
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
> @@ -222,6 +223,7 @@ struct global_params {
>   *			preference/bias
>   * @epp_saved:		Saved EPP/EPB during system suspend or CPU offline
>   *			operation
> + * @epp_cached		Cached HWP energy-performance preference value
>   * @hwp_req_cached:	Cached value of the last HWP Request MSR
>   * @hwp_cap_cached:	Cached value of the last HWP Capabilities MSR
>   * @last_io_update:	Last time when IO wake flag was set
> @@ -259,6 +261,7 @@ struct cpudata {
>  	s16 epp_policy;
>  	s16 epp_default;
>  	s16 epp_saved;
> +	s16 epp_cached;
>  	u64 hwp_req_cached;
>  	u64 hwp_cap_cached;
>  	u64 last_io_update;
> @@ -676,6 +679,8 @@ static int intel_pstate_set_energy_pref_
>=20=20
>  		value |=3D (u64)epp << 24;
>  		ret =3D wrmsrl_on_cpu(cpu_data->cpu, MSR_HWP_REQUEST, value);
> +
> +		WRITE_ONCE(cpu_data->epp_cached, epp);

Why introduce a new EPP cache variable if there is already
hwp_req_cached?  If intel_pstate_set_energy_pref_index() is failing to
update hwp_req_cached maybe we should fix that instead.  That will save
you a little bit of work in intel_cpufreq_adjust_hwp().

>  	} else {
>  		if (epp =3D=3D -EINVAL)
>  			epp =3D (pref_index - 1) << 2;
> @@ -2047,6 +2052,7 @@ static int intel_pstate_init_cpu(unsigne
>  		cpu->epp_default =3D -EINVAL;
>  		cpu->epp_powersave =3D -EINVAL;
>  		cpu->epp_saved =3D -EINVAL;
> +		WRITE_ONCE(cpu->epp_cached, -EINVAL);
>  	}
>=20=20
>  	cpu =3D all_cpu_data[cpunum];
> @@ -2245,7 +2251,10 @@ static int intel_pstate_verify_policy(st
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
> @@ -2253,12 +2262,10 @@ static void intel_pstate_stop_cpu(struct
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
> @@ -2388,13 +2395,82 @@ static void intel_cpufreq_trace(struct c
>  		fp_toint(cpu->iowait_boost * 100));
>  }
>=20=20
> +static void intel_cpufreq_adjust_hwp(struct cpudata *cpu, u32 target_pst=
ate,
> +				     bool fast_switch)
> +{
> +	u64 prev =3D READ_ONCE(cpu->hwp_req_cached), value =3D prev;
> +	s16 epp;
> +
> +	value &=3D ~HWP_MIN_PERF(~0L);
> +	value |=3D HWP_MIN_PERF(target_pstate);
> +
> +	/*
> +	 * The entire MSR needs to be updated in order to update the HWP min
> +	 * field in it, so opportunistically update the max too if needed.
> +	 */
> +	value &=3D ~HWP_MAX_PERF(~0L);
> +	value |=3D HWP_MAX_PERF(cpu->max_perf_ratio);
> +
> +	/*
> +	 * In case the EPP has been adjusted via sysfs, write the last cached
> +	 * value of it to the MSR as well.
> +	 */
> +	epp =3D READ_ONCE(cpu->epp_cached);
> +	if (epp >=3D 0) {
> +		value &=3D ~GENMASK_ULL(31, 24);
> +		value |=3D (u64)epp << 24;
> +	}
> +
> +	if (value =3D=3D prev)
> +		return;
> +
> +	WRITE_ONCE(cpu->hwp_req_cached, value);
> +	if (fast_switch)
> +		wrmsrl(MSR_HWP_REQUEST, value);
> +	else
> +		wrmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
> +}

I've asked this question already but you may have missed it: Given that
you are of the opinion that [1] should be implemented in schedutil
instead with intel_pstate in HWP passive mode, what's your plan for
exposing the HWP_MAX_PERF knob to the governor in addition to
HWP_MIN_PERF, since the interface implemented here only allows the
governor to provide a single frequency?

[1] https://lwn.net/ml/linux-pm/20200428032258.2518-1-currojerez@riseup.net/

> +
> +static void intel_cpufreq_adjust_perf_ctl(struct cpudata *cpu,
> +					  u32 target_pstate, bool fast_switch)
> +{
> +	if (fast_switch)
> +		wrmsrl(MSR_IA32_PERF_CTL,
> +		       pstate_funcs.get_val(cpu, target_pstate));
> +	else
> +		wrmsrl_on_cpu(cpu->cpu, MSR_IA32_PERF_CTL,
> +			      pstate_funcs.get_val(cpu, target_pstate));
> +}
> +
> +static int intel_cpufreq_update_pstate(struct cpudata *cpu, int target_p=
state,
> +				       bool fast_switch)
> +{
> +	int old_pstate =3D cpu->pstate.current_pstate;
> +
> +	target_pstate =3D intel_pstate_prepare_request(cpu, target_pstate);
> +	if (target_pstate !=3D old_pstate) {
> +		cpu->pstate.current_pstate =3D target_pstate;
> +		if (hwp_active)
> +			intel_cpufreq_adjust_hwp(cpu, target_pstate,
> +						 fast_switch);
> +		else
> +			intel_cpufreq_adjust_perf_ctl(cpu, target_pstate,
> +						      fast_switch);
> +	}
> +
> +	intel_cpufreq_trace(cpu, fast_switch ? INTEL_PSTATE_TRACE_FAST_SWITCH :
> +			    INTEL_PSTATE_TRACE_TARGET, old_pstate);
> +
> +	return target_pstate;
> +}
> +
>  static int intel_cpufreq_target(struct cpufreq_policy *policy,
>  				unsigned int target_freq,
>  				unsigned int relation)
>  {
>  	struct cpudata *cpu =3D all_cpu_data[policy->cpu];
>  	struct cpufreq_freqs freqs;
> -	int target_pstate, old_pstate;
> +	int target_pstate;
>=20=20
>  	update_turbo_state();
>=20=20
> @@ -2402,6 +2478,7 @@ static int intel_cpufreq_target(struct c
>  	freqs.new =3D target_freq;
>=20=20
>  	cpufreq_freq_transition_begin(policy, &freqs);
> +
>  	switch (relation) {
>  	case CPUFREQ_RELATION_L:
>  		target_pstate =3D DIV_ROUND_UP(freqs.new, cpu->pstate.scaling);
> @@ -2413,15 +2490,11 @@ static int intel_cpufreq_target(struct c
>  		target_pstate =3D DIV_ROUND_CLOSEST(freqs.new, cpu->pstate.scaling);
>  		break;
>  	}
> -	target_pstate =3D intel_pstate_prepare_request(cpu, target_pstate);
> -	old_pstate =3D cpu->pstate.current_pstate;
> -	if (target_pstate !=3D cpu->pstate.current_pstate) {
> -		cpu->pstate.current_pstate =3D target_pstate;
> -		wrmsrl_on_cpu(policy->cpu, MSR_IA32_PERF_CTL,
> -			      pstate_funcs.get_val(cpu, target_pstate));
> -	}
> +
> +	target_pstate =3D intel_cpufreq_update_pstate(cpu, target_pstate, false=
);
> +
>  	freqs.new =3D target_pstate * cpu->pstate.scaling;
> -	intel_cpufreq_trace(cpu, INTEL_PSTATE_TRACE_TARGET, old_pstate);
> +
>  	cpufreq_freq_transition_end(policy, &freqs, false);
>=20=20
>  	return 0;
> @@ -2431,15 +2504,14 @@ static unsigned int intel_cpufreq_fast_s
>  					      unsigned int target_freq)
>  {
>  	struct cpudata *cpu =3D all_cpu_data[policy->cpu];
> -	int target_pstate, old_pstate;
> +	int target_pstate;
>=20=20
>  	update_turbo_state();
>=20=20
>  	target_pstate =3D DIV_ROUND_UP(target_freq, cpu->pstate.scaling);
> -	target_pstate =3D intel_pstate_prepare_request(cpu, target_pstate);
> -	old_pstate =3D cpu->pstate.current_pstate;
> -	intel_pstate_update_pstate(cpu, target_pstate);
> -	intel_cpufreq_trace(cpu, INTEL_PSTATE_TRACE_FAST_SWITCH, old_pstate);
> +
> +	target_pstate =3D intel_cpufreq_update_pstate(cpu, target_pstate, true);
> +
>  	return target_pstate * cpu->pstate.scaling;
>  }
>=20=20
> @@ -2459,7 +2531,6 @@ static int intel_cpufreq_cpu_init(struct
>  		return ret;
>=20=20
>  	policy->cpuinfo.transition_latency =3D INTEL_CPUFREQ_TRANSITION_LATENCY;
> -	policy->transition_delay_us =3D INTEL_CPUFREQ_TRANSITION_DELAY;
>  	/* This reflects the intel_pstate_get_cpu_pstates() setting. */
>  	policy->cur =3D policy->cpuinfo.min_freq;
>=20=20
> @@ -2471,10 +2542,17 @@ static int intel_cpufreq_cpu_init(struct
>=20=20
>  	cpu =3D all_cpu_data[policy->cpu];
>=20=20
> -	if (hwp_active)
> +	if (hwp_active) {
> +		u64 value;
> +
>  		intel_pstate_get_hwp_max(policy->cpu, &turbo_max, &max_state);
> -	else
> +		policy->transition_delay_us =3D INTEL_CPUFREQ_TRANSITION_DELAY_HWP;
> +		rdmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, &value);
> +		WRITE_ONCE(cpu->hwp_req_cached, value);
> +	} else {
>  		turbo_max =3D cpu->pstate.turbo_pstate;
> +		policy->transition_delay_us =3D INTEL_CPUFREQ_TRANSITION_DELAY;
> +	}
>=20=20
>  	min_freq =3D DIV_ROUND_UP(turbo_max * global.min_perf_pct, 100);
>  	min_freq *=3D cpu->pstate.scaling;
> @@ -2575,9 +2653,6 @@ static int intel_pstate_register_driver(
>=20=20
>  static int intel_pstate_unregister_driver(void)
>  {
> -	if (hwp_active)
> -		return -EBUSY;
> -
>  	cpufreq_unregister_driver(intel_pstate_driver);
>  	intel_pstate_driver_cleanup();
>=20=20
> @@ -2828,7 +2903,10 @@ static int __init intel_pstate_init(void
>  			hwp_active++;
>  			hwp_mode_bdw =3D id->driver_data;
>  			intel_pstate.attr =3D hwp_cpufreq_attrs;
> -			default_driver =3D &intel_pstate;
> +			intel_cpufreq.attr =3D hwp_cpufreq_attrs;
> +			if (!default_driver)
> +				default_driver =3D &intel_pstate;
> +
>  			goto hwp_cpu_matched;
>  		}
>  	} else {
> @@ -2899,14 +2977,13 @@ static int __init intel_pstate_setup(cha
>  	if (!str)
>  		return -EINVAL;
>=20=20
> -	if (!strcmp(str, "disable")) {
> +	if (!strcmp(str, "disable"))
>  		no_load =3D 1;
> -	} else if (!strcmp(str, "active")) {
> +	else if (!strcmp(str, "active"))
>  		default_driver =3D &intel_pstate;
> -	} else if (!strcmp(str, "passive")) {
> +	else if (!strcmp(str, "passive"))
>  		default_driver =3D &intel_cpufreq;
> -		no_hwp =3D 1;
> -	}
> +
>  	if (!strcmp(str, "no_hwp")) {
>  		pr_info("HWP disabled\n");
>  		no_hwp =3D 1;
> Index: linux-pm/Documentation/admin-guide/pm/intel_pstate.rst
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/Documentation/admin-guide/pm/intel_pstate.rst
> +++ linux-pm/Documentation/admin-guide/pm/intel_pstate.rst
> @@ -54,10 +54,13 @@ registered (see `below <status_attr_>`_)
>  Operation Modes
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20=20
> -``intel_pstate`` can operate in three different modes: in the active mod=
e with
> -or without hardware-managed P-states support and in the passive mode.  W=
hich of
> -them will be in effect depends on what kernel command line options are u=
sed and
> -on the capabilities of the processor.
> +``intel_pstate`` can operate in two different modes, active or passive. =
 In the
> +active mode, it uses its own internal preformance scaling governor algor=
ithm or
> +allows the hardware to do preformance scaling by itself, while in the pa=
ssive
> +mode it responds to requests made by a generic ``CPUFreq`` governor impl=
ementing
> +a certain performance scaling algorithm.  Which of them will be in effect
> +depends on what kernel command line options are used and on the capabili=
ties of
> +the processor.
>=20=20
>  Active Mode
>  -----------
> @@ -194,10 +197,11 @@ This is the default operation mode of ``
>  hardware-managed P-states (HWP) support.  It is always used if the
>  ``intel_pstate=3Dpassive`` argument is passed to the kernel in the comma=
nd line
>  regardless of whether or not the given processor supports HWP.  [Note th=
at the
> -``intel_pstate=3Dno_hwp`` setting implies ``intel_pstate=3Dpassive`` if =
it is used
> -without ``intel_pstate=3Dactive``.]  Like in the active mode without HWP=
 support,
> -in this mode ``intel_pstate`` may refuse to work with processors that ar=
e not
> -recognized by it.
> +``intel_pstate=3Dno_hwp`` setting causes the driver to start in the pass=
ive mode
> +if it is not combined with ``intel_pstate=3Dactive``.]  Like in the acti=
ve mode
> +without HWP support, in this mode ``intel_pstate`` may refuse to work wi=
th
> +processors that are not recognized by it if HWP is prevented from being =
enabled
> +through the kernel command line.
>=20=20
>  If the driver works in this mode, the ``scaling_driver`` policy attribut=
e in
>  ``sysfs`` for all ``CPUFreq`` policies contains the string "intel_cpufre=
q".
> @@ -318,10 +322,9 @@ manuals need to be consulted to get to i
>=20=20
>  For this reason, there is a list of supported processors in ``intel_psta=
te`` and
>  the driver initialization will fail if the detected processor is not in =
that
> -list, unless it supports the `HWP feature <Active Mode_>`_.  [The interf=
ace to
> -obtain all of the information listed above is the same for all of the pr=
ocessors
> -supporting the HWP feature, which is why they all are supported by
> -``intel_pstate``.]
> +list, unless it supports the HWP feature.  [The interface to obtain all =
of the
> +information listed above is the same for all of the processors supportin=
g the
> +HWP feature, which is why ``intel_pstate`` works with all of them.]
>=20=20
>=20=20
>  User Space Interface in ``sysfs``
> @@ -425,22 +428,16 @@ argument is passed to the kernel in the
>  	as well as the per-policy ones) are then reset to their default
>  	values, possibly depending on the target operation mode.]
>=20=20
> -	That only is supported in some configurations, though (for example, if
> -	the `HWP feature is enabled in the processor <Active Mode With HWP_>`_,
> -	the operation mode of the driver cannot be changed), and if it is not
> -	supported in the current configuration, writes to this attribute will
> -	fail with an appropriate error.
> -
>  ``energy_efficiency``
> -	This attribute is only present on platforms, which have CPUs matching
> -	Kaby Lake or Coffee Lake desktop CPU model. By default
> -	energy efficiency optimizations are disabled on these CPU models in HWP
> -	mode by this driver. Enabling energy efficiency may limit maximum
> -	operating frequency in both HWP and non HWP mode. In non HWP mode,
> -	optimizations are done only in the turbo frequency range. In HWP mode,
> -	optimizations are done in the entire frequency range. Setting this
> -	attribute to "1" enables energy efficiency optimizations and setting
> -	to "0" disables energy efficiency optimizations.
> +	This attribute is only present on platforms with CPUs matching the Kaby
> +	Lake or Coffee Lake desktop CPU model. By default, energy-efficiency
> +	optimizations are disabled on these CPU models if HWP is enabled.
> +	Enabling energy-efficiency optimizations may limit maximum operating
> +	frequency with or without the HWP feature.  With HWP enabled, the
> +	optimizations are done only in the turbo frequency range.  Without it,
> +	they are done in the entire available frequency range.  Setting this
> +	attribute to "1" enables the energy-efficiency optimizations and setting
> +	to "0" disables them.
>=20=20
>  Interpretation of Policy Attributes
>  -----------------------------------
> @@ -484,8 +481,8 @@ Next, the following policy attributes ha
>  	policy for the time interval between the last two invocations of the
>  	driver's utilization update callback by the CPU scheduler for that CPU.
>=20=20
> -One more policy attribute is present if the `HWP feature is enabled in t=
he
> -processor <Active Mode With HWP_>`_:
> +One more policy attribute is present if the HWP feature is enabled in the
> +processor:
>=20=20
>  ``base_frequency``
>  	Shows the base frequency of the CPU. Any frequency above this will be
> @@ -526,11 +523,11 @@ on the following rules, regardless of th
>=20=20
>   3. The global and per-policy limits can be set independently.
>=20=20
> -If the `HWP feature is enabled in the processor <Active Mode With HWP_>`=
_, the
> -resulting effective values are written into its registers whenever the l=
imits
> -change in order to request its internal P-state selection logic to alway=
s set
> -P-states within these limits.  Otherwise, the limits are taken into acco=
unt by
> -scaling governors (in the `passive mode <Passive Mode_>`_) and by the dr=
iver
> +In the `active mode with the HWP feature enabled <Active Mode With HWP_>=
`_, the
> +resulting effective values are written into hardware registers whenever =
the
> +limits change in order to request its internal P-state selection logic t=
o always
> +set P-states within these limits.  Otherwise, the limits are taken into =
account
> +by scaling governors (in the `passive mode <Passive Mode_>`_) and by the=
 driver
>  every time before setting a new P-state for a CPU.
>=20=20
>  Additionally, if the ``intel_pstate=3Dper_cpu_perf_limits`` command line=
 argument
> @@ -541,12 +538,11 @@ at all and the only way to set the limit
>  Energy vs Performance Hints
>  ---------------------------
>=20=20
> -If ``intel_pstate`` works in the `active mode with the HWP feature enabl=
ed
> -<Active Mode With HWP_>`_ in the processor, additional attributes are pr=
esent
> -in every ``CPUFreq`` policy directory in ``sysfs``.  They are intended t=
o allow
> -user space to help ``intel_pstate`` to adjust the processor's internal P=
-state
> -selection logic by focusing it on performance or on energy-efficiency, or
> -somewhere between the two extremes:
> +If the hardware-managed P-states (HWP) is enabled in the processor, addi=
tional
> +attributes, intended to allow user space to help ``intel_pstate`` to adj=
ust the
> +processor's internal P-state selection logic by focusing it on performan=
ce or on
> +energy-efficiency, or somewhere between the two extremes, are present in=
 every
> +``CPUFreq`` policy directory in ``sysfs``.  They are :
>=20=20
>  ``energy_performance_preference``
>  	Current value of the energy vs performance hint for the given policy
> @@ -650,12 +646,14 @@ of them have to be prepended with the ``
>  	Do not register ``intel_pstate`` as the scaling driver even if the
>  	processor is supported by it.
>=20=20
> +``active``
> +	Register ``intel_pstate`` in the `active mode <Active Mode_>`_ to start
> +	with.
> +
>  ``passive``
>  	Register ``intel_pstate`` in the `passive mode <Passive Mode_>`_ to
>  	start with.
>=20=20
> -	This option implies the ``no_hwp`` one described below.
> -
>  ``force``
>  	Register ``intel_pstate`` as the scaling driver instead of
>  	``acpi-cpufreq`` even if the latter is preferred on the given system.
> @@ -670,13 +668,12 @@ of them have to be prepended with the ``
>  	driver is used instead of ``acpi-cpufreq``.
>=20=20
>  ``no_hwp``
> -	Do not enable the `hardware-managed P-states (HWP) feature
> -	<Active Mode With HWP_>`_ even if it is supported by the processor.
> +	Do not enable the hardware-managed P-states (HWP) feature even if it is
> +	supported by the processor.
>=20=20
>  ``hwp_only``
>  	Register ``intel_pstate`` as the scaling driver only if the
> -	`hardware-managed P-states (HWP) feature <Active Mode With HWP_>`_ is
> -	supported by the processor.
> +	hardware-managed P-states (HWP) feature is supported by the processor.
>=20=20
>  ``support_acpi_ppc``
>  	Take ACPI ``_PPC`` performance limits into account.

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCXw5JPQAKCRCDmTidfVK/
W5O0AP9vpRhu6K8Fvgews8Gw41q4yV/gB1EikL0GqFp5slLVjAD9FCeDgKF4VkWk
XkYof5PtwCfffJqUxpBj8v/RztmjWRM=
=xlGb
-----END PGP SIGNATURE-----
--==-=-=--
