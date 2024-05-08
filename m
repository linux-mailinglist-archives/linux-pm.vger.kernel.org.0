Return-Path: <linux-pm+bounces-7639-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B4C8BF9AD
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 11:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797D91C217A4
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 09:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B627762D7;
	Wed,  8 May 2024 09:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="C1WtybD9"
X-Original-To: linux-pm@vger.kernel.org
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2551DFE8;
	Wed,  8 May 2024 09:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715161344; cv=none; b=onh4ycT5O1FzqKlEST2ACBpnllUtzV3czkBJCKfN35r3iUwxukXkaFx0SV3uua0UWD5HdDLlWYWU3fu/ynwXNBkTo1Y2MX3ykzOxwr/LRP55fCwS4I3PtCYizc/eQX3OJbr7yuSaC6c8bMgy5wKxp4E+TeM+kMcqD8vUP3NSJhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715161344; c=relaxed/simple;
	bh=tpHBLYwWAXWzFJOiiqPNurkj4onSKHEuQPtc+N0ukQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VfsK94TT9j5ZRhedqF6cA9oH7BBYdpCz2sa6Kk0C2kLLE807oDrwRa3dQqRPnapBSS9DmhLxJXhLl1xz9mwflCxe5uRtNPvGt2sM5LLqFK2FHlwHmfZv6UCH1xY2SB/k5ZoNnHJoewpYNijrWP04YpUpGeB+OJuB2FACaFjBWeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=C1WtybD9; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id BE1EC62DD101;
	Wed, 08 May 2024 11:34:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1715160896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ITaU40SFRGKxHYojpCSGh4eL/ryxiwlKRxY2NrN5Zus=;
	b=C1WtybD9FCqWeBqrKKxR6GaNxYDNixDpsr8122tNc9qjBkBxdK5+OZSBm8d/iIzRSScW8I
	aZ2o+kiJy0d3sa3ZgBToBB5vwIe5Hk6WobBHabirTBFjky7OBc17eYz9MGPXAM4RJWnTP+
	avQsxBdHVgLbQwRtbyM8GLhENTKHRek=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com, Perry Yuan <perry.yuan@amd.com>
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v10 6/7] cpufreq: amd-pstate: introduce per CPU frequency boost
 control
Date: Wed, 08 May 2024 11:34:21 +0200
Message-ID: <12430678.O9o76ZdvQC@natalenko.name>
In-Reply-To:
 <49204c6d4a334c0bfbc589dda79b5cd7c4c28b7c.1715152592.git.perry.yuan@amd.com>
References:
 <cover.1715152592.git.perry.yuan@amd.com>
 <49204c6d4a334c0bfbc589dda79b5cd7c4c28b7c.1715152592.git.perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5776929.DvuYhMxLoT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart5776929.DvuYhMxLoT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Wed, 08 May 2024 11:34:21 +0200
Message-ID: <12430678.O9o76ZdvQC@natalenko.name>
MIME-Version: 1.0

Hello.

On st=C5=99eda 8. kv=C4=9Btna 2024 9:21:11, SEL=C4=8C Perry Yuan wrote:
> Add a new sysfs attribute file to support per CPU frequency boost
> control, allowing individual CPUs to enable or disable CPB separately.
>=20
> The new sysfs attribute file is located at below path,
> `/sys/devices/system/cpu/cpuX/cpufreq/boost`,
> where `X` represents the CPU number.
>=20
> To disable CPB for a specific CPU, you can use the following command:
> $ sudo bash -c "echo 0 > /sys/devices/system/cpu/cpuX/cpufreq/boost"
>=20
> After disabling CPB, the CPU frequency will no longer boost beyond
> the base frequency for that particular CPU.
>=20
> for example:
> ----------------------------------------------------------------------
> CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
>   0    0      0    0 0:0:0:0          yes 4208.0000 400.0000 1666.7740
>   1    0      0    0 0:0:0:0          yes 4208.0000 400.0000  400.0000
>=20
> ----------------------------------------------------------------------
> $ sudo bash -c "echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/boost"
>=20
> CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
>   0    0      0    0 0:0:0:0          yes 3501.0000 400.0000 4154.3140
>   1    0      0    0 0:0:0:0          yes 4208.0000 400.0000  400.0000
>=20
> Please be aware that modifying the global variable
> `amd_pstate_global_params.cpb_boost` will overwrite the individual CPU se=
ttings.
>=20
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>=20
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 11bce2c1db32..cb0055e7c842 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1371,6 +1371,30 @@ static int amd_pstate_cpu_boost(int cpu, bool stat=
e)
>  	return ret < 0 ? ret : 0;
>  }
> =20
> +static ssize_t show_boost(struct cpufreq_policy *policy, char *buf)
> +{
> +	struct amd_cpudata *cpudata =3D policy->driver_data;
> +	bool boost_val;
> +
> +	boost_val =3D READ_ONCE(cpudata->boost_state);
> +
> +	return sysfs_emit(buf, "%u\n", boost_val);
> +}
> +
> +static ssize_t store_boost(
> +		struct cpufreq_policy *policy, const char *buf, size_t count)
> +{
> +	bool boost_val;
> +	int ret;
> +
> +	if (sscanf(buf, "%d", &boost_val) !=3D 1)

This will generate warning. IIUC, sscanf() doesn't work with booleans direc=
tly, so you'd probably want to read the value into an (unsigned) integer, a=
nd then cast it to bool.

> +		return -EINVAL;
> +
> +	ret =3D amd_pstate_cpu_boost(policy->cpu, boost_val);
> +
> +	return ret < 0 ? ret : count;
> +}
> +
>  static ssize_t cpb_boost_show(struct device *dev,
>  			   struct device_attribute *attr, char *buf)
>  {
> @@ -1416,6 +1440,7 @@ cpufreq_freq_attr_ro(amd_pstate_prefcore_ranking);
>  cpufreq_freq_attr_ro(amd_pstate_hw_prefcore);
>  cpufreq_freq_attr_rw(energy_performance_preference);
>  cpufreq_freq_attr_ro(energy_performance_available_preferences);
> +cpufreq_freq_attr_rw(boost);
>  static DEVICE_ATTR_RW(status);
>  static DEVICE_ATTR_RO(prefcore);
>  static DEVICE_ATTR_RW(cpb_boost);
> @@ -1426,6 +1451,7 @@ static struct freq_attr *amd_pstate_attr[] =3D {
>  	&amd_pstate_highest_perf,
>  	&amd_pstate_prefcore_ranking,
>  	&amd_pstate_hw_prefcore,
> +	&boost,
>  	NULL,
>  };
> =20
> @@ -1437,6 +1463,7 @@ static struct freq_attr *amd_pstate_epp_attr[] =3D {
>  	&amd_pstate_hw_prefcore,
>  	&energy_performance_preference,
>  	&energy_performance_available_preferences,
> +	&boost,
>  	NULL,
>  };
> =20
>=20


=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart5776929.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmY7Rx0ACgkQil/iNcg8
M0sozhAAwBKs7R6wasSZh5RwWS9z9V5g2aOMfwlMXNbXWMxVHZsq8E/rncUtUJ5b
jjjvAYGBFcW4Z+5WWU8OTQr82MpTiXfPs7A5lSz6vbrkuF2dGfWPdrXFmA1xv1Nw
SrDjQSNkzB7U3/wUFjADu5yyaORBMRrCGCl6CktG4Cnoe6pRi1tLndNqPjp7xiHm
blZJTNvs7V7KV2tTpMPYgPKAadkuMfEURI7grBqe0kfy8r1z6HHQmkJVHCfoa3RF
oHiwFcBBZJ3bAUG2ps/V8dsNcStYWvgDQHuKMO1ZGwvx0L3JMhY8hKFIzb92i2El
51u9zAa81QZEnEr4BjvqRIdRuH+4QkQ07gXjsmfxQwGmhJgpGTlqUoHBLUXNyD6U
QZpfWsltaKpLf3ilhc/OTXclHe4eg3/hMhNUNTCg1ThKKgSRG/QCLE3vS80F2tdL
Vc1RehzmUdFfxLPN+6In+w+i9eQqzrKelXME1NGOoETKyLtxu4UvUOxw+Ux8/jTD
Dh9mRRFAaeiPuKnH+Eu7X1dCoCZ9flByhOJKABZO9Q3LQ3bvNUzJHEHVDsSmiKZ0
2a0FkEuC/kRwUnr1rARFjHzxoFZh94gMewyqCCehgAH1iB4dYNzHZHkDXJi1z/dD
IrwctWnfVHmwTLQmx7u/4qXoTwvoxAyf4QDvhcZIlq4D5CYz1g0=
=SI1r
-----END PGP SIGNATURE-----

--nextPart5776929.DvuYhMxLoT--




