Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28225241451
	for <lists+linux-pm@lfdr.de>; Tue, 11 Aug 2020 02:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgHKAvs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Aug 2020 20:51:48 -0400
Received: from mx1.riseup.net ([198.252.153.129]:58656 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725969AbgHKAvs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Aug 2020 20:51:48 -0400
Received: from capuchin.riseup.net (capuchin-pn.riseup.net [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4BQZ6B3SzHzDsZ0;
        Mon, 10 Aug 2020 17:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1597107106; bh=Pm8wD6nNA1iMVbbLQJUcofOWePOQT116qkTX5e7A3FQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gWUjecRq5bCS++aMLh8SwTJhxGqqn64UH3UcEetlxGM4YFNmNmWfznCCnLhuA+sBt
         mirK25KOJsfdyG2fBAoLIJ2c4zcFl20vt2cVRtY1yCkk4q2EhHNIYZt2rbOYFS347R
         UIhwuhOGyYHwcVl64vlsZMOeAM4HhvDyo4DaJIkA=
X-Riseup-User-ID: 52B791EC20A8908142D05576BBDD36A9ED54B05290BB6DF6C4B92F58F0FC8898
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 4BQZ695rR7z8t5Q;
        Mon, 10 Aug 2020 17:51:45 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux Documentation <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v7] cpufreq: intel_pstate: Implement passive mode with HWP enabled
In-Reply-To: <122847018.uQ7iJ9lzrg@kreacher>
References: <4981405.3kqTVLv5tO@kreacher> <1709487.Bxjb1zNRZM@kreacher> <3226770.pJcYkdRNc2@kreacher> <122847018.uQ7iJ9lzrg@kreacher>
Date:   Mon, 10 Aug 2020 17:51:41 -0700
Message-ID: <87mu32atsy.fsf@riseup.net>
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
> in sysfs on HWP systems) the HWP algorithm is allowed to make the
> CPU run at a frequency above the floor P-state set by intel_pstate,
> with or without hardware coordination of P-states among CPUs in the
> same package.
>

The "frequency range below the base frequency" part of the paragraph
above seems somewhat misleading, since AFAICT the same thing will happen
in the P-state range above the base frequency.   Another minor comment
below, other than that LGTM:

Reviewed-by: Francisco Jerez <currojerez@riseup.net>

> [If P-states of the CPUs in the same package are coordinated at the
>  hardware level, a non-HWP processor may choose a P-state above the
>  target one like a processor with HWP enabled may choose a P-state
>  above the HWP floor, so the HWP behavior is analogous to the non-HWP
>  one in that case.
>
>  Also note that the HWP floor may not be taken into account by
>  the processor in the range of P-states above the base frequency,
>  referred to as the turbo range, where the processor has a license to
>  choose any P-state, either below or above the HWP floor, just like a
>  non-HWP processor in the case when the target P-state falls into the
>  turbo range.]
>
> With this change applied, intel_pstate in the passive mode
> assumes complete control over the HWP request MSR and concurrent
> changes of that MSR (eg. via the direct MSR access interface) are
> overridden by it.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> Sending the right patch this time, sorry for the confusion.
>
> This is based on the current mainline.
>
> v1 -> v2:
>    * Avoid a race condition when updating the HWP request register while
>      setting a new EPP value via sysfs.
>
> v2 -> v3:
>    * Rebase.
>
> v3 -> v4:
>    * Avoid exposing the hwp_dynamic_boost sysfs switch in the passive mod=
e.
>
> v4 -> v5:
>    * Do not acquire intel_pstate_driver_lock in
>      store_energy_performance_preference(), because it runs under
>      policy->rwsem, so intel_pstate_driver cannot change while it is runn=
ing.
>    * Rearrange the changelog a bit to avoid confusion.
>
> v5 -> v6:
>    * Fix the problem with the EPP setting via sysfs not working with the
>      performance and powersave governors by stopping and restarting the
>      governor around the sysfs-based EPP updates in the passive mode.
>    * Because of that, use the epp_cached field just for avoiding the above
>      if the new EPP value for the given CPU is the same as the old one.
>    * Export cpufreq_start/stop_governor() from the core (for the above).
>
> v6 -> v7:
>    * Cosmetic changes in store_energy_performance_prefernce() to reduce t=
he
>      LoC number and make it a bit easier to read.  No intentional functio=
nal
>      impact.
>
> ---
>  Documentation/admin-guide/pm/intel_pstate.rst |   89 ++++-----
>  drivers/cpufreq/cpufreq.c                     |    6=20
>  drivers/cpufreq/intel_pstate.c                |  245 +++++++++++++++++++=
-------
>  include/linux/cpufreq.h                       |    2=20
>  4 files changed, 229 insertions(+), 113 deletions(-)
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
> @@ -220,6 +221,7 @@ struct global_params {
>   *			preference/bias
>   * @epp_saved:		Saved EPP/EPB during system suspend or CPU offline
>   *			operation
> + * @epp_cached		Cached HWP energy-performance preference value
>   * @hwp_req_cached:	Cached value of the last HWP Request MSR
>   * @hwp_cap_cached:	Cached value of the last HWP Capabilities MSR
>   * @last_io_update:	Last time when IO wake flag was set
> @@ -257,6 +259,7 @@ struct cpudata {
>  	s16 epp_policy;
>  	s16 epp_default;
>  	s16 epp_saved;
> +	s16 epp_cached;
>  	u64 hwp_req_cached;
>  	u64 hwp_cap_cached;
>  	u64 last_io_update;
> @@ -639,6 +642,26 @@ static int intel_pstate_get_energy_pref_
>  	return index;
>  }
>=20=20
> +static int intel_pstate_set_epp(struct cpudata *cpu, u32 epp)
> +{
> +	/*
> +	 * Use the cached HWP Request MSR value, because in the active mode the
> +	 * register itself may be updated by intel_pstate_hwp_boost_up() or
> +	 * intel_pstate_hwp_boost_down() at any time.
> +	 */
> +	u64 value =3D READ_ONCE(cpu->hwp_req_cached);
> +
> +	value &=3D ~GENMASK_ULL(31, 24);
> +	value |=3D (u64)epp << 24;
> +	/*
> +	 * The only other updater of hwp_req_cached in the active mode,
> +	 * intel_pstate_hwp_set(), is called under the same lock as this
> +	 * function, so it cannot run in parallel with the update below.
> +	 */
> +	WRITE_ONCE(cpu->hwp_req_cached, value);
> +	return wrmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
> +}
> +
>  static int intel_pstate_set_energy_pref_index(struct cpudata *cpu_data,
>  					      int pref_index, bool use_raw,
>  					      u32 raw_epp)
> @@ -650,28 +673,12 @@ static int intel_pstate_set_energy_pref_
>  		epp =3D cpu_data->epp_default;
>=20=20
>  	if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
> -		/*
> -		 * Use the cached HWP Request MSR value, because the register
> -		 * itself may be updated by intel_pstate_hwp_boost_up() or
> -		 * intel_pstate_hwp_boost_down() at any time.
> -		 */
> -		u64 value =3D READ_ONCE(cpu_data->hwp_req_cached);
> -
> -		value &=3D ~GENMASK_ULL(31, 24);
> -
>  		if (use_raw)
>  			epp =3D raw_epp;
>  		else if (epp =3D=3D -EINVAL)
>  			epp =3D epp_values[pref_index - 1];
>=20=20
> -		value |=3D (u64)epp << 24;
> -		/*
> -		 * The only other updater of hwp_req_cached in the active mode,
> -		 * intel_pstate_hwp_set(), is called under the same lock as this
> -		 * function, so it cannot run in parallel with the update below.
> -		 */
> -		WRITE_ONCE(cpu_data->hwp_req_cached, value);
> -		ret =3D wrmsrl_on_cpu(cpu_data->cpu, MSR_HWP_REQUEST, value);
> +		ret =3D intel_pstate_set_epp(cpu_data, epp);
>  	} else {
>  		if (epp =3D=3D -EINVAL)
>  			epp =3D (pref_index - 1) << 2;
> @@ -697,10 +704,12 @@ static ssize_t show_energy_performance_a
>=20=20
>  cpufreq_freq_attr_ro(energy_performance_available_preferences);
>=20=20
> +static struct cpufreq_driver intel_pstate;
> +
>  static ssize_t store_energy_performance_preference(
>  		struct cpufreq_policy *policy, const char *buf, size_t count)
>  {
> -	struct cpudata *cpu_data =3D all_cpu_data[policy->cpu];
> +	struct cpudata *cpu =3D all_cpu_data[policy->cpu];
>  	char str_preference[21];
>  	bool raw =3D false;
>  	ssize_t ret;
> @@ -725,15 +734,44 @@ static ssize_t store_energy_performance_
>  		raw =3D true;
>  	}
>=20=20
> +	/*
> +	 * This function runs with the policy R/W semaphore held, which
> +	 * guarantees that the driver pointer will not change while it is
> +	 * running.
> +	 */
> +	if (!intel_pstate_driver)
> +		return -EAGAIN;
> +
>  	mutex_lock(&intel_pstate_limits_lock);
>=20=20
> -	ret =3D intel_pstate_set_energy_pref_index(cpu_data, ret, raw, epp);
> -	if (!ret)
> -		ret =3D count;
> +	if (intel_pstate_driver =3D=3D &intel_pstate) {
> +		ret =3D intel_pstate_set_energy_pref_index(cpu, ret, raw, epp);
> +	} else {
> +		/*
> +		 * In the passive mode the governor needs to be stopped on the
> +		 * target CPU before the EPP update and restarted after it,
> +		 * which is super-heavy-weight, so make sure it is worth doing
> +		 * upfront.
> +		 */
> +		if (!raw)
> +			epp =3D ret ? epp_values[ret - 1] : cpu->epp_default;
> +
> +		if (cpu->epp_cached !=3D epp) {
> +			int err;
> +
> +			cpufreq_stop_governor(policy);
> +			ret =3D intel_pstate_set_epp(cpu, epp);
> +			err =3D cpufreq_start_governor(policy);
> +			if (!ret) {
> +				cpu->epp_cached =3D epp;
> +				ret =3D err;
> +			}
> +		}
> +	}
>=20=20
>  	mutex_unlock(&intel_pstate_limits_lock);
>=20=20
> -	return ret;
> +	return ret ?: count;
>  }
>=20=20
>  static ssize_t show_energy_performance_preference(
> @@ -1145,8 +1183,6 @@ static ssize_t store_no_turbo(struct kob
>  	return count;
>  }
>=20=20
> -static struct cpufreq_driver intel_pstate;
> -
>  static void update_qos_request(enum freq_qos_req_type type)
>  {
>  	int max_state, turbo_max, freq, i, perf_pct;
> @@ -1330,9 +1366,10 @@ static const struct attribute_group inte
>=20=20
>  static const struct x86_cpu_id intel_pstate_cpu_ee_disable_ids[];
>=20=20
> +static struct kobject *intel_pstate_kobject;
> +
>  static void __init intel_pstate_sysfs_expose_params(void)
>  {
> -	struct kobject *intel_pstate_kobject;
>  	int rc;
>=20=20
>  	intel_pstate_kobject =3D kobject_create_and_add("intel_pstate",
> @@ -1357,17 +1394,31 @@ static void __init intel_pstate_sysfs_ex
>  	rc =3D sysfs_create_file(intel_pstate_kobject, &min_perf_pct.attr);
>  	WARN_ON(rc);
>=20=20
> -	if (hwp_active) {
> -		rc =3D sysfs_create_file(intel_pstate_kobject,
> -				       &hwp_dynamic_boost.attr);
> -		WARN_ON(rc);
> -	}
> -
>  	if (x86_match_cpu(intel_pstate_cpu_ee_disable_ids)) {
>  		rc =3D sysfs_create_file(intel_pstate_kobject, &energy_efficiency.attr=
);
>  		WARN_ON(rc);
>  	}
>  }
> +
> +static void intel_pstate_sysfs_expose_hwp_dynamic_boost(void)
> +{
> +	int rc;
> +
> +	if (!hwp_active)
> +		return;
> +
> +	rc =3D sysfs_create_file(intel_pstate_kobject, &hwp_dynamic_boost.attr);
> +	WARN_ON_ONCE(rc);
> +}
> +
> +static void intel_pstate_sysfs_hide_hwp_dynamic_boost(void)
> +{
> +	if (!hwp_active)
> +		return;
> +
> +	sysfs_remove_file(intel_pstate_kobject, &hwp_dynamic_boost.attr);
> +}
> +
>  /************************** sysfs end ************************/
>=20=20
>  static void intel_pstate_hwp_enable(struct cpudata *cpudata)
> @@ -2246,7 +2297,10 @@ static int intel_pstate_verify_policy(st
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
> @@ -2254,12 +2308,10 @@ static void intel_pstate_stop_cpu(struct
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
> @@ -2389,13 +2441,71 @@ static void intel_cpufreq_trace(struct c
>  		fp_toint(cpu->iowait_boost * 100));
>  }
>=20=20
> +static void intel_cpufreq_adjust_hwp(struct cpudata *cpu, u32 target_pst=
ate,
> +				     bool fast_switch)
> +{
> +	u64 prev =3D READ_ONCE(cpu->hwp_req_cached), value =3D prev;
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
> +	if (value =3D=3D prev)
> +		return;
> +
> +	WRITE_ONCE(cpu->hwp_req_cached, value);
> +	if (fast_switch)
> +		wrmsrl(MSR_HWP_REQUEST, value);
> +	else
> +		wrmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
> +}
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
> @@ -2403,6 +2513,7 @@ static int intel_cpufreq_target(struct c
>  	freqs.new =3D target_freq;
>=20=20
>  	cpufreq_freq_transition_begin(policy, &freqs);
> +
>  	switch (relation) {
>  	case CPUFREQ_RELATION_L:
>  		target_pstate =3D DIV_ROUND_UP(freqs.new, cpu->pstate.scaling);
> @@ -2414,15 +2525,11 @@ static int intel_cpufreq_target(struct c
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
> @@ -2432,15 +2539,14 @@ static unsigned int intel_cpufreq_fast_s
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
> @@ -2460,7 +2566,6 @@ static int intel_cpufreq_cpu_init(struct
>  		return ret;
>=20=20
>  	policy->cpuinfo.transition_latency =3D INTEL_CPUFREQ_TRANSITION_LATENCY;
> -	policy->transition_delay_us =3D INTEL_CPUFREQ_TRANSITION_DELAY;
>  	/* This reflects the intel_pstate_get_cpu_pstates() setting. */
>  	policy->cur =3D policy->cpuinfo.min_freq;
>=20=20
> @@ -2472,10 +2577,18 @@ static int intel_cpufreq_cpu_init(struct
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
> +		cpu->epp_cached =3D (value & GENMASK_ULL(31, 24)) >> 24;
> +	} else {
>  		turbo_max =3D cpu->pstate.turbo_pstate;
> +		policy->transition_delay_us =3D INTEL_CPUFREQ_TRANSITION_DELAY;
> +	}
>=20=20
>  	min_freq =3D DIV_ROUND_UP(turbo_max * global.min_perf_pct, 100);
>  	min_freq *=3D cpu->pstate.scaling;
> @@ -2552,6 +2665,10 @@ static void intel_pstate_driver_cleanup(
>  		}
>  	}
>  	put_online_cpus();
> +
> +	if (intel_pstate_driver =3D=3D &intel_pstate)
> +		intel_pstate_sysfs_hide_hwp_dynamic_boost();
> +
>  	intel_pstate_driver =3D NULL;
>  }
>=20=20
> @@ -2559,6 +2676,9 @@ static int intel_pstate_register_driver(
>  {
>  	int ret;
>=20=20
> +	if (driver =3D=3D &intel_pstate)
> +		intel_pstate_sysfs_expose_hwp_dynamic_boost();
> +
>  	memset(&global, 0, sizeof(global));
>  	global.max_perf_pct =3D 100;
>=20=20
> @@ -2576,9 +2696,6 @@ static int intel_pstate_register_driver(
>=20=20
>  static int intel_pstate_unregister_driver(void)
>  {
> -	if (hwp_active)
> -		return -EBUSY;
> -
>  	cpufreq_unregister_driver(intel_pstate_driver);
>  	intel_pstate_driver_cleanup();
>=20=20
> @@ -2834,7 +2951,10 @@ static int __init intel_pstate_init(void
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
> @@ -2905,14 +3025,13 @@ static int __init intel_pstate_setup(cha
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

Typo: performance

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
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -73,8 +73,6 @@ static inline bool has_target(void)
>  static unsigned int __cpufreq_get(struct cpufreq_policy *policy);
>  static int cpufreq_init_governor(struct cpufreq_policy *policy);
>  static void cpufreq_exit_governor(struct cpufreq_policy *policy);
> -static int cpufreq_start_governor(struct cpufreq_policy *policy);
> -static void cpufreq_stop_governor(struct cpufreq_policy *policy);
>  static void cpufreq_governor_limits(struct cpufreq_policy *policy);
>  static int cpufreq_set_policy(struct cpufreq_policy *policy,
>  			      struct cpufreq_governor *new_gov,
> @@ -2266,7 +2264,7 @@ static void cpufreq_exit_governor(struct
>  	module_put(policy->governor->owner);
>  }
>=20=20
> -static int cpufreq_start_governor(struct cpufreq_policy *policy)
> +int cpufreq_start_governor(struct cpufreq_policy *policy)
>  {
>  	int ret;
>=20=20
> @@ -2293,7 +2291,7 @@ static int cpufreq_start_governor(struct
>  	return 0;
>  }
>=20=20
> -static void cpufreq_stop_governor(struct cpufreq_policy *policy)
> +void cpufreq_stop_governor(struct cpufreq_policy *policy)
>  {
>  	if (cpufreq_suspended || !policy->governor)
>  		return;
> Index: linux-pm/include/linux/cpufreq.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/include/linux/cpufreq.h
> +++ linux-pm/include/linux/cpufreq.h
> @@ -576,6 +576,8 @@ unsigned int cpufreq_driver_resolve_freq
>  unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *p=
olicy);
>  int cpufreq_register_governor(struct cpufreq_governor *governor);
>  void cpufreq_unregister_governor(struct cpufreq_governor *governor);
> +int cpufreq_start_governor(struct cpufreq_policy *policy);
> +void cpufreq_stop_governor(struct cpufreq_policy *policy);
>=20=20
>  #define cpufreq_governor_init(__governor)			\
>  static int __init __governor##_init(void)			\

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCXzHrnQAKCRCDmTidfVK/
WzfyAP9vJv7tW18pxFRUqhUGiIH91NmFV5x6Jr6DL2xP7H7iugD9GDEPxTPdtFfM
C/PdqpKdWagc26lDOCN4otnegzbSiyA=
=ATfD
-----END PGP SIGNATURE-----
--==-=-=--
