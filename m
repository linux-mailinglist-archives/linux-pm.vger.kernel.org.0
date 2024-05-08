Return-Path: <linux-pm+bounces-7638-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB3F8BF99E
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 11:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018CD282E60
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 09:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BD875803;
	Wed,  8 May 2024 09:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="j/xAcfs6"
X-Original-To: linux-pm@vger.kernel.org
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4A21DFE8;
	Wed,  8 May 2024 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715161176; cv=none; b=lFn/phLzYFZD3wS0X2nQbrKbTfBt9T2+KzVGdvLiypZN4HTUJN97ItHgGYrOiGI0AurAbs8phLCrhen3G4SU6lquLX4qNTXTtRRx9wD96YdX0LUl6seT2VyLxHmJAE4mboIi1AXGeISWYiFSk5asVpQeQxt22vQMw+k8bknwcN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715161176; c=relaxed/simple;
	bh=KH7B+KUi7/uyxY/n5GLOsX5f4dTbd0+EXoloUHOnaWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fhMEv5ENyVVHbxxCEYwlmaJTOMQT/x/dCTCZCozCZylaKCp1jGkQxaV8zqbZi035/j+Lvdp3ME2lkNthqBR6BSs8zvhXAxedNXN2dBD7lRZ/IVut4aQAtdmXv7sgTB4I55VBjLLDwcjwz1EDm1bB9B+ywfybnJcimmbi3kjG4u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=j/xAcfs6; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id A4C1762DD102;
	Wed, 08 May 2024 11:39:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1715161170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uYimBYoGsy02yIPeW5MHw0nmB/ooXCVrMND+XDBZq/8=;
	b=j/xAcfs6jkOB87aATp/uUNBdM/ByWYRwcOw/m8gQZccvn5dXCJvefzMjdZ3MQYKO/ZarLu
	urjZZ8+ru2sQLst2qcu2U9JgrTAOcyogQaimMP8uvGxNBv5M3p6yiRIx3E93mVnBX4i8HX
	ldlWogz5c2kiTTC2G4m+dyEMeMW98i8=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com, Perry Yuan <perry.yuan@amd.com>
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v10 3/7] cpufreq: amd-pstate: implement cpb_boost sysfs entry for
 boost control
Date: Wed, 08 May 2024 11:39:15 +0200
Message-ID: <4563575.LvFx2qVVIh@natalenko.name>
In-Reply-To:
 <90a2bf1607c525a1e5b42d7327dbcfe5dd338549.1715152592.git.perry.yuan@amd.com>
References:
 <cover.1715152592.git.perry.yuan@amd.com>
 <90a2bf1607c525a1e5b42d7327dbcfe5dd338549.1715152592.git.perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2322898.ElGaqSPkdT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart2322898.ElGaqSPkdT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Wed, 08 May 2024 11:39:15 +0200
Message-ID: <4563575.LvFx2qVVIh@natalenko.name>
MIME-Version: 1.0

Hello.

On st=C5=99eda 8. kv=C4=9Btna 2024 9:21:08, SEL=C4=8C Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
>=20
> With this new sysfs entry `cpb_boost`created, user can change CPU boost
> state dynamically under `active`, `guided` and `passive` modes.
> And the highest perf and frequency will also be updated as the boost
> state changing.
>=20
> 0): check current boost state
> cat /sys/devices/system/cpu/amd_pstate/cpb_boost
>=20
> 1): disable CPU boost
> sudo bash -c "echo 0 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
>=20
> 2): enable CPU boost
> sudo bash -c "echo 1 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
>=20
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217931
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217618
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate-ut.c |   2 +-
>  drivers/cpufreq/amd-pstate.c    | 114 +++++++++++++++++++++++++++++++-
>  include/linux/amd-pstate.h      |   1 +
>  3 files changed, 115 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate=
=2Dut.c
> index f04ae67dda37..b3601b0e6dd3 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -226,7 +226,7 @@ static void amd_pstate_ut_check_freq(u32 index)
>  			goto skip_test;
>  		}
> =20
> -		if (cpudata->boost_supported) {
> +		if (amd_pstate_global_params.cpb_boost) {
>  			if ((policy->max =3D=3D cpudata->max_freq) ||
>  					(policy->max =3D=3D cpudata->nominal_freq))
>  				amd_pstate_ut_cases[index].result =3D AMD_PSTATE_UT_RESULT_PASS;
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index f7dab0f7b452..f81fd61dd2a9 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -686,8 +686,10 @@ static int amd_pstate_boost_init(struct amd_cpudata =
*cpudata)
>  	}
> =20
>  	amd_pstate_global_params.cpb_supported =3D !(boost_val & MSR_K7_HWCR_CP=
B_DIS);
> -	if (amd_pstate_global_params.cpb_supported)
> +	if (amd_pstate_global_params.cpb_supported) {
>  		current_pstate_driver->boost_enabled =3D true;
> +		cpudata->boost_state =3D true;
> +	}
> =20
>  	amd_pstate_global_params.cpb_boost =3D amd_pstate_global_params.cpb_sup=
ported;
> =20
> @@ -1293,6 +1295,114 @@ static ssize_t prefcore_show(struct device *dev,
>  	return sysfs_emit(buf, "%s\n", str_enabled_disabled(amd_pstate_prefcore=
));
>  }
> =20
> +static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bo=
ol on)
> +{
> +	struct amd_cpudata *cpudata =3D policy->driver_data;
> +	struct cppc_perf_ctrls perf_ctrls;
> +	u32 highest_perf, nominal_perf, nominal_freq, max_freq;
> +	int ret;
> +
> +	if (!policy) {
> +		pr_err("policy is null\n");
> +		return -ENODATA;
> +	}
> +
> +	highest_perf =3D READ_ONCE(cpudata->highest_perf);
> +	nominal_perf =3D READ_ONCE(cpudata->nominal_perf);
> +	nominal_freq =3D READ_ONCE(cpudata->nominal_freq);
> +	max_freq =3D READ_ONCE(cpudata->max_freq);
> +
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		u64 value =3D READ_ONCE(cpudata->cppc_req_cached);
> +
> +		value &=3D ~GENMASK_ULL(7, 0);
> +		value |=3D on ? highest_perf : nominal_perf;
> +		WRITE_ONCE(cpudata->cppc_req_cached, value);
> +
> +		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> +	} else {
> +		perf_ctrls.max_perf =3D on ? highest_perf : nominal_perf;
> +		ret =3D cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
> +		if (ret) {
> +			cpufreq_cpu_release(policy);
> +			pr_debug("failed to set energy perf value (%d)\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	if (on)
> +		policy->cpuinfo.max_freq =3D max_freq;
> +	else
> +		policy->cpuinfo.max_freq =3D nominal_freq * 1000;
> +
> +	policy->max =3D policy->cpuinfo.max_freq;
> +
> +	if (cppc_state =3D=3D AMD_PSTATE_PASSIVE) {
> +		ret =3D freq_qos_update_request(&cpudata->req[1],
> +				      policy->cpuinfo.max_freq);
> +	}
> +
> +	return ret;
> +}
> +
> +static int amd_pstate_cpu_boost(int cpu, bool state)
> +{
> +	int ret;
> +	struct cpufreq_policy *policy =3D cpufreq_cpu_get(cpu);
> +	struct amd_cpudata *cpudata =3D policy->driver_data;
> +
> +	if (!policy) {
> +		pr_err("policy is NULL\n");
> +		ret =3D -ENODATA;
> +		goto err_exit;
> +	}
> +
> +	ret =3D amd_pstate_cpu_boost_update(policy, state);
> +	refresh_frequency_limits(policy);
> +	cpudata->boost_state =3D !!state;
> +
> +err_exit:
> +	cpufreq_cpu_put(policy);
> +	return ret < 0 ? ret : 0;
> +}
> +
> +static ssize_t cpb_boost_show(struct device *dev,
> +			   struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%u\n", amd_pstate_global_params.cpb_boost);
> +}
> +
> +static ssize_t cpb_boost_store(struct device *dev, struct device_attribu=
te *b,
> +			    const char *buf, size_t count)
> +{
> +	bool new_state;
> +	ssize_t ret;
> +	int cpu;
> +
> +	if (!amd_pstate_global_params.cpb_supported) {
> +		pr_err("Boost mode is not supported by this processor or SBIOS\n");
> +		return -EINVAL;
> +	}
> +
> +	ret =3D kstrtobool(buf, &new_state);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&amd_pstate_driver_lock);
> +	for_each_present_cpu(cpu) {
> +		ret =3D amd_pstate_cpu_boost(cpu, new_state);
> +		if (ret < 0) {
> +			pr_warn("failed to update cpu boost for CPU%d (%d)\n", cpu, ret);

Note ret is ssize_t, so %d should be %ld (or %z/%zd/%zi?) instead.

> +			goto err_exit;
> +		}
> +	}
> +	amd_pstate_global_params.cpb_boost =3D !!new_state;
> +
> +err_exit:
> +	mutex_unlock(&amd_pstate_driver_lock);
> +	return ret < 0 ? ret : count;
> +}
> +
>  cpufreq_freq_attr_ro(amd_pstate_max_freq);
>  cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
> =20
> @@ -1303,6 +1413,7 @@ cpufreq_freq_attr_rw(energy_performance_preference);
>  cpufreq_freq_attr_ro(energy_performance_available_preferences);
>  static DEVICE_ATTR_RW(status);
>  static DEVICE_ATTR_RO(prefcore);
> +static DEVICE_ATTR_RW(cpb_boost);
> =20
>  static struct freq_attr *amd_pstate_attr[] =3D {
>  	&amd_pstate_max_freq,
> @@ -1327,6 +1438,7 @@ static struct freq_attr *amd_pstate_epp_attr[] =3D {
>  static struct attribute *pstate_global_attributes[] =3D {
>  	&dev_attr_status.attr,
>  	&dev_attr_prefcore.attr,
> +	&dev_attr_cpb_boost.attr,
>  	NULL
>  };
> =20
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index 8ba5dd4d3405..56f616a5cd0f 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -106,6 +106,7 @@ struct amd_cpudata {
>  	u32	policy;
>  	u64	cppc_cap1_cached;
>  	bool	suspended;
> +	bool	boost_state;
>  };
> =20
>  /*
>=20


=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart2322898.ElGaqSPkdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmY7SEMACgkQil/iNcg8
M0tgIBAA2bvCr4o6vPSrdQN6Iunfu5oZDcI7uElQJ93I/hCYBOi7RWVXKDDggd7M
lJcxY5xRYQuAAlLsgDd6GMqbdfbki3ham9uj25ALq1Ct11OwSplaFPzWIpN7OS6C
SjdXlfjwc6X0YmI7q1wzOUqAJjRNVmYcQAAD8c84JGON2/UZ73WqBLrDYV993r6K
Us+XkC79RdUGPY0aX1v9AGaeZlVvLVzsbbFImWDijaH47Z3SmIfVytHtW/euy5CJ
1UZ5fmrRaGY4fOXmtd9c9/x9SxCo1B9I99crkSIu9xdbCHtBkrWCDqYGQpBvhw/n
HUZEM0C1IoFGHm/wdhaJQAYeyj6E7IYOAZXWLfKzAhxpj4BZxUXa7HYHS8V6BcYF
Bk/zoln7lMlaYFAqNNR2jGYH8+iEptbn+Y8spocnNy5bbqrcvQGXvgx/oe+GOl+x
fm2OtpHfSAGga1tqsBFsZEOa+4K/Gtk/HiALseF5GGYTReDmTdttMqzugU09Tw33
6DwSDxTGrW8Pbxctw3mmP9J7b7l4NbhMu4t+2reh+Jx5+sRwPMzZHbTZg3bapu61
zEBpgxNI6+ycsBU/158S+3zq6FRFzgkDWMsfEK9iNVAMXErmQSwGV3PTZV6qHSP7
OMD6HThh8FveOklfhJDLLdvXJUN+2WhlDf93KYg0Qco1lQYN184=
=PK+c
-----END PGP SIGNATURE-----

--nextPart2322898.ElGaqSPkdT--




