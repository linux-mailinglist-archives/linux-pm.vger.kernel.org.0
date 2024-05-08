Return-Path: <linux-pm+bounces-7640-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B4F8BF9B5
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 11:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BFB8282E6D
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 09:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689FB77620;
	Wed,  8 May 2024 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="GavXCaxn"
X-Original-To: linux-pm@vger.kernel.org
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3809F76413;
	Wed,  8 May 2024 09:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715161421; cv=none; b=SnnsCR2WmJH4laijEa46hWH/rtBbixPspNXdg5Rt/t5+fFF1E79grbO8QuiXMOexp/lvjtlBNtK+fm4Zel9aFnu1sR4emhny9tPf5Bg0G4DYWPJFOaUNXjldfGi9DHVYt+rdiJsFfb5yfZwQ8GNhJ5ZRqxEugbYTloshgRUIsUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715161421; c=relaxed/simple;
	bh=CmGfIJyZ+UYick2uEOot8RpMO/bSjOiYp86j3Z5KQRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJgFp1xpUHDpm36oGvCe1/hNDX8pp5rVgdEF22ZixqlMm5ndsK4sh97Hk8WukymdrN0B0XCWHzPqbfDxX8e5Dk38VPKzb2PJsTgMkG0MXAxVxYMp+qkWV9lP26UW052+haQH/gdlgEe9ZKkH12H2KMwLOGDUrFXibeG4wM/xffo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=GavXCaxn; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id A3EB362DD101;
	Wed, 08 May 2024 11:43:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1715161416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3+oM/lvaBS+oU8AOo9x3rwjNrQaLNmP38FbL8zTOlnI=;
	b=GavXCaxnS2Jxss9HYxS1ItS8doLbWqG2/V1FA6sX8l7DM7brrdpaSowg/RCfC9ubu7kY/W
	9QlZ7YYDIrdRT9IdKYX/7/qfQqpwxyP27i8pdUjUaYJAzymlNcgAiwcoR4YU22OgjH0o8S
	PS+GC3p/f2vKZZdw6TKw1ZfdVZOv1Y0=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com, Perry Yuan <perry.yuan@amd.com>
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v10 6/7] cpufreq: amd-pstate: introduce per CPU frequency boost
 control
Date: Wed, 08 May 2024 11:43:26 +0200
Message-ID: <1884700.tdWV9SEqCh@natalenko.name>
In-Reply-To: <12430678.O9o76ZdvQC@natalenko.name>
References:
 <cover.1715152592.git.perry.yuan@amd.com>
 <49204c6d4a334c0bfbc589dda79b5cd7c4c28b7c.1715152592.git.perry.yuan@amd.com>
 <12430678.O9o76ZdvQC@natalenko.name>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2181343.irdbgypaU6";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart2181343.irdbgypaU6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Wed, 08 May 2024 11:43:26 +0200
Message-ID: <1884700.tdWV9SEqCh@natalenko.name>
In-Reply-To: <12430678.O9o76ZdvQC@natalenko.name>
MIME-Version: 1.0

On st=C5=99eda 8. kv=C4=9Btna 2024 11:34:21, SEL=C4=8C Oleksandr Natalenko =
wrote:
> Hello.
>=20
> On st=C5=99eda 8. kv=C4=9Btna 2024 9:21:11, SEL=C4=8C Perry Yuan wrote:
> > Add a new sysfs attribute file to support per CPU frequency boost
> > control, allowing individual CPUs to enable or disable CPB separately.
> >=20
> > The new sysfs attribute file is located at below path,
> > `/sys/devices/system/cpu/cpuX/cpufreq/boost`,
> > where `X` represents the CPU number.
> >=20
> > To disable CPB for a specific CPU, you can use the following command:
> > $ sudo bash -c "echo 0 > /sys/devices/system/cpu/cpuX/cpufreq/boost"
> >=20
> > After disabling CPB, the CPU frequency will no longer boost beyond
> > the base frequency for that particular CPU.
> >=20
> > for example:
> > ----------------------------------------------------------------------
> > CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
> >   0    0      0    0 0:0:0:0          yes 4208.0000 400.0000 1666.7740
> >   1    0      0    0 0:0:0:0          yes 4208.0000 400.0000  400.0000
> >=20
> > ----------------------------------------------------------------------
> > $ sudo bash -c "echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/boost"
> >=20
> > CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
> >   0    0      0    0 0:0:0:0          yes 3501.0000 400.0000 4154.3140
> >   1    0      0    0 0:0:0:0          yes 4208.0000 400.0000  400.0000
> >=20
> > Please be aware that modifying the global variable
> > `amd_pstate_global_params.cpb_boost` will overwrite the individual CPU =
settings.
> >=20
> > Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >=20
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > index 11bce2c1db32..cb0055e7c842 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -1371,6 +1371,30 @@ static int amd_pstate_cpu_boost(int cpu, bool st=
ate)
> >  	return ret < 0 ? ret : 0;
> >  }
> > =20
> > +static ssize_t show_boost(struct cpufreq_policy *policy, char *buf)
> > +{
> > +	struct amd_cpudata *cpudata =3D policy->driver_data;
> > +	bool boost_val;
> > +
> > +	boost_val =3D READ_ONCE(cpudata->boost_state);
> > +
> > +	return sysfs_emit(buf, "%u\n", boost_val);
> > +}
> > +
> > +static ssize_t store_boost(
> > +		struct cpufreq_policy *policy, const char *buf, size_t count)
> > +{
> > +	bool boost_val;
> > +	int ret;
> > +
> > +	if (sscanf(buf, "%d", &boost_val) !=3D 1)
>=20
> This will generate warning. IIUC, sscanf() doesn't work with booleans dir=
ectly, so you'd probably want to read the value into an (unsigned) integer,=
 and then cast it to bool.

=E2=80=A6or maybe just use kstrtobool()?

>=20
> > +		return -EINVAL;
> > +
> > +	ret =3D amd_pstate_cpu_boost(policy->cpu, boost_val);
> > +
> > +	return ret < 0 ? ret : count;
> > +}
> > +
> >  static ssize_t cpb_boost_show(struct device *dev,
> >  			   struct device_attribute *attr, char *buf)
> >  {
> > @@ -1416,6 +1440,7 @@ cpufreq_freq_attr_ro(amd_pstate_prefcore_ranking);
> >  cpufreq_freq_attr_ro(amd_pstate_hw_prefcore);
> >  cpufreq_freq_attr_rw(energy_performance_preference);
> >  cpufreq_freq_attr_ro(energy_performance_available_preferences);
> > +cpufreq_freq_attr_rw(boost);
> >  static DEVICE_ATTR_RW(status);
> >  static DEVICE_ATTR_RO(prefcore);
> >  static DEVICE_ATTR_RW(cpb_boost);
> > @@ -1426,6 +1451,7 @@ static struct freq_attr *amd_pstate_attr[] =3D {
> >  	&amd_pstate_highest_perf,
> >  	&amd_pstate_prefcore_ranking,
> >  	&amd_pstate_hw_prefcore,
> > +	&boost,
> >  	NULL,
> >  };
> > =20
> > @@ -1437,6 +1463,7 @@ static struct freq_attr *amd_pstate_epp_attr[] =
=3D {
> >  	&amd_pstate_hw_prefcore,
> >  	&energy_performance_preference,
> >  	&energy_performance_available_preferences,
> > +	&boost,
> >  	NULL,
> >  };
> > =20
> >=20
>=20
>=20
>=20


=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart2181343.irdbgypaU6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmY7ST4ACgkQil/iNcg8
M0uDohAAvhcXV/dax02GTdt+JLrK1tAlRk3L3EGv76XgInyHr+McYfbn9z++ALar
VsmnTdlnDeTNOt88dZSMmprRpoMMLFnT2YIBF8EUwvTsmyFTcIn8lb3Sg2M0egG/
hACOkUtub05/lJ+4LNtOmJeVyEGJeHrOLwgIOpgK4OftYirqBQeNDkVwCpY5CAeR
8Eta01LykP0abjlvyw9cvejzDO+vlRYdJyaiT6zNnTDeuQoO44H9G8nREPrJgHYj
BHBNVtNPUMFyMRG8ofGs88FNp8XKV+LIEAVSY5sLxbt/EfQAzEQoO0OXPDE0gY86
JqIkAQIm9Z6d7jbSygi4eUyoL97LCZu3seO3/T4x2KYbS3TkAMCmCsVd4lGAxqxQ
5PQa0T7aH4nUO5nLvA3f8NwCD5vB2Vdgl/vN8losJpm1Kn8jeDG8ZxUiBoRCdmmT
Z2iWktP7PcT8Zmo/WFPBkmMQ1QbVvS2LIwUZtLNJU/ukY2r4bvRSCMBCi/m1DU5m
484WYXGeJChRrDaoBScCJwf7DOLm1UT7tvhOFocMrqKZXF90ixMcafQebReVgAmP
+XXYIPgDuHGz/99rqRdUOvheBALNNxYsYnTXCpZtKI8We7lIUQv1eW3w5JECZQna
ONRqe/4yGO3ezCH3qj4VGP2O0bhGsfDTD/gR2NsiyPmhJCDAit0=
=OI1g
-----END PGP SIGNATURE-----

--nextPart2181343.irdbgypaU6--




