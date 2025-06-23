Return-Path: <linux-pm+bounces-29412-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC27AE5779
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 00:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23A916F141
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 22:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B6F223DEF;
	Mon, 23 Jun 2025 22:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="k2ZwwYI3"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8320870838;
	Mon, 23 Jun 2025 22:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750718163; cv=pass; b=lKeZkcTgf06/LrQo6ooc1QgRwmWu4/zNTrxYmEukGO8I6SYUjwfQqlqnwD0YveAN/jrbmRBM5dJMVAu17IiH5DvEM7jmfNuTDzmHHCEIRHKPRwNLa3HHZ4Kb8tPqtgxsDsk/IxKGNE718H/Pc07xG44Ho4ojo+r9r58gsiKTh1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750718163; c=relaxed/simple;
	bh=Bpb1XGCEGQSyquUsetJbD6fKhS8HO87jR+rjffJajzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4wQvTAqTBzvDjg4tPUiauk3LTNP900MM9nb0JkJc3yqpf1NiBhxl8ISdaFSIyHYsT9P3A7nV9pL6RCrPbox2r5VMLKCpgTichCKEOmuQ2xgFgnUd7PHv5Oi/Re/mcPclbKmJSsjG6IzCEaZ2fXjSTXqTKo3HdCgu2sJSuM19h0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=k2ZwwYI3; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750718149; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GGHhT/Qo7uVOv5mCCev6ktcMTcNn2Dza8msOTkLfznetV5NypgB3JQlgkAL6e9uV+Uchl1Jf6EDl+7u+G1o51ii84AheH1jsaDRJa/RghGy6fcLnG8lEXXiJswxRBHsaB/xyqaoAggMttXEq3B3KDmiHBzIz1j7UPI72fDLBKBo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750718149; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=G7+6mgddDVVWKLgx6vrtHbMyWaUysUn/2HYgj+dU1Zg=; 
	b=nusuo36CP/vF+DPbkAwN/M8oYEa4ZSEVnhh/rR9/Mx2uBCJrvyDOIXu0oBroDBq6MkmkNZXtpSB28YRWW8EX70FJecIozNMXJpjiT3ylK0ZZxrZrFhHBKAHNbgxoYD/g8h7cn1M2/ZnjqsdUBmVBSKAt6PJlx9UrAhv1GuVS04Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750718149;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=G7+6mgddDVVWKLgx6vrtHbMyWaUysUn/2HYgj+dU1Zg=;
	b=k2ZwwYI38fPgS4pqj0d2bUhOHvuKtj3LT90JcBGj2fG6x8gORf/oUvpSM/PgtZa2
	XLomwEX4+NEDBNjQjATd8paMBix6di9E56B4kigLBOVPAqt6baUsHdmrsoDkMxoBDwu
	weDKY9zM+00ovti8eyubruSbtW6XxTAuxDqtzW1A=
Received: by mx.zohomail.com with SMTPS id 1750718146591594.9176350366654;
	Mon, 23 Jun 2025 15:35:46 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id C3733180AAB; Tue, 24 Jun 2025 00:35:42 +0200 (CEST)
Date: Tue, 24 Jun 2025 00:35:42 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Armin Wolf <W_Armin@gmx.de>
Cc: Hans de Goede <hansg@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	platform-driver-x86@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH] platform/x86: dell-ddv: Fix taking the
 psy->extensions_sem lock twice
Message-ID: <f7ii6htomrmo4oaijemps6y6f2mdjkhe6ug4nuyqgtjariimec@uyogwv4pghsy>
References: <20250620175807.418300-1-hansg@kernel.org>
 <3bfea893-fd3e-48b6-8a34-9ab36108efe2@gmx.de>
 <b46dcef3-2893-4b94-81ef-a495e6a0e7ca@kernel.org>
 <13e25678-d73f-49b1-afed-94812a9c10fb@gmx.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5or5bqtbn5mstngw"
Content-Disposition: inline
In-Reply-To: <13e25678-d73f-49b1-afed-94812a9c10fb@gmx.de>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/250.326.2
X-ZohoMailClient: External


--5or5bqtbn5mstngw
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] platform/x86: dell-ddv: Fix taking the
 psy->extensions_sem lock twice
MIME-Version: 1.0

Hi,

On Mon, Jun 23, 2025 at 12:08:04AM +0200, Armin Wolf wrote:
> Am 22.06.25 um 22:59 schrieb Hans de Goede:
>=20
> > + Cc sre, whom I should have Cc-ed from the beginning.
> >=20
> > Hi Armin,
> >=20
> > On 22-Jun-25 8:41 PM, Armin Wolf wrote:
> > > Am 20.06.25 um 19:58 schrieb Hans de Goede:
> > >=20
> > > > dell_wmi_ddv_get_property() gets called with psy->extensions_sem
> > > > read-locked, it calls dell_wmi_ddv_battery_translate() which calls
> > > > power_supply_get_property() on the same psy which again read-locks
> > > > psy->extensions_sem.
> > > >=20
> > > > Lockdep rightfully complains about this:
> > > >=20
> > > >  =A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >  =A0 WARNING: possible recursive locking detected
> > > > ...
> > > >  =A0 kworker/16:3/1230 is trying to acquire lock:
> > > >  =A0 ffff8c3143417658 (&psy->extensions_sem){++++}-{4:4},
> > > >  =A0=A0 at: power_supply_get_property.part.0+0x23/0x160
> > > >  =A0 but task is already holding lock:
> > > >  =A0 ffff8c3143417658 (&psy->extensions_sem){++++}-{4:4},
> > > >  =A0=A0 at: power_supply_get_property.part.0+0x23/0x160
> > > > ...
> > > >  =A0=A0 Possible unsafe locking scenario:
> > > >=20
> > > >  =A0=A0=A0=A0=A0=A0=A0=A0 CPU0
> > > >  =A0=A0=A0=A0=A0=A0=A0=A0 ----
> > > >  =A0=A0=A0 lock(&psy->extensions_sem);
> > > >  =A0=A0=A0 lock(&psy->extensions_sem);
> > > >=20
> > > >  =A0=A0 *** DEADLOCK ***
> > > > ...
> > > >  =A0 Call Trace:
> > > >  =A0=A0 <TASK>
> > > >  =A0=A0 ...
> > > >  =A0=A0 down_read+0x3e/0x180
> > > >  =A0=A0 ? power_supply_get_property.part.0+0x23/0x160
> > > >  =A0=A0 power_supply_get_property.part.0+0x23/0x160
> > > >  =A0=A0 dell_wmi_ddv_battery_translate+0x68/0x1d0 [dell_wmi_ddv]
> > > >  =A0=A0 ? lock_acquire+0xd9/0x2c0
> > > >  =A0=A0 dell_wmi_ddv_get_property+0x25/0x240 [dell_wmi_ddv]
> > > >  =A0=A0 power_supply_get_property.part.0+0x87/0x160
> > > >  =A0=A0 power_supply_format_property+0xc4/0x3d0
> > > >  =A0=A0 add_prop_uevent+0x26/0x90
> > > >  =A0=A0 power_supply_uevent+0xb9/0xf0
> > > >=20
> > > > This usually works fine, because read-locking can be done multiple =
times
> > > > but if someone tries to write-lock between the 2 read-lock calls th=
en
> > > > the second read-lock will block on the write-lock and the write-loc=
k will
> > > > be blocked on the first read-lock leading to a deadlock.
> > > >=20
> > > > The serial is part of the main psy device, not of an extension. Dir=
ectly
> > > > call psy->desc->get_property() in dell_wmi_ddv_battery_translate() =
to fix
> > > > the double-lock issue.
> > > >=20
> > > > Note this also influences eppid_show() which is called directly rat=
her
> > > > then through power_supply_get_property(). This is ok since the ACPI
> > > > battery is fully ready to be used when the battery hook's add_batte=
ry
> > > > callback is called.
> > > Thank you very much for finding this issue, but i think that simply c=
alling battery->desc->get_property()
> > > is not the right solution for this:
> > >=20
> > > 1. We should still call psy_desc_has_property() to determine if the p=
ower supply actually support
> > >  =A0=A0 POWER_SUPPLY_PROP_SERIAL_NUMBER.
> > Although it is currently not enforced in power_supply_core.c it seems
> > reasonable to assume that any powersupply must have a get_property
> > callback in their desc (the core also unconditionally calls this).
> >=20
> > And most (all?) psy drivers I've seen have a default which returns -EIN=
VAL
> > in their get_property() implementation which works just as well as
> > calling has_prop ...
> >=20
> > My bigger worry is the lack of the:
> >=20
> > >      if (atomic_read(&psy->use_cnt) <=3D 0) {
> > >          if (!psy->initialized)
> > >              return -EAGAIN;
> > >          return -ENODEV;
> > >      }
> > Check TBH.
> >=20
> > > 2. At least another power supply extension user (the uniwill-laptop d=
river currently being under review)
> > >  =A0=A0 suffers from a similar problem, so a more generic solution is=
 needed.
> > >=20
> > > Maybe we could introduce a new function for reading power supply prop=
erties that ignores any
> > > power supply extensions? This way future extension could use this fun=
ction too.
> > >=20
> > > I envision something like this:
> > > int power_supply_get_property_direct(struct power_supply *psy,
> > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enum power_supply_prop=
erty psp,
> > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 union power_supply_pro=
pval *val)
> > > {
> > >  =A0=A0=A0=A0if (atomic_read(&psy->use_cnt) <=3D 0) {
> > >  =A0=A0=A0=A0=A0=A0=A0 if (!psy->initialized)
> > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EAGAIN;
> > >  =A0=A0=A0=A0=A0=A0=A0 return -ENODEV;
> > >  =A0=A0=A0=A0}
> > >=20
> > >  =A0=A0=A0=A0if (psy_desc_has_property(psy->desc, psp))
> > >  =A0=A0=A0=A0=A0=A0=A0 return psy->desc->get_property(psy, psp, val);
> > >  =A0=A0=A0=A0else if (power_supply_battery_info_has_prop(psy->battery=
_info, psp))
> > >  =A0=A0=A0=A0=A0=A0=A0 return power_supply_battery_info_get_prop(psy-=
>battery_info, psp, val);
> > >  =A0=A0=A0=A0else
> > >  =A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
> > > }
> > > EXPORT_SYMBOL_GPL(power_supply_get_property_direct);
> > >=20
> > > It basically is power_supply_get_property() without the extension log=
ic.
> > While working on this fix I was thinking that something like this would=
 be useful,
> > so +1 for this.
> >=20
> > Maybe first do a prep patch where the extension handling in
> > power_supply_get_property() is moved last, then power_supply_get_proper=
ty()
> > can just wrap this new helprr and on -EINVAL check the extensions.
> >=20
> > Actually if you move the extensions check to last then the whole double=
lock
> > issue goes away because the serial-number will be found before checking
> > extensions.
> >=20
> > Or if you want to keep checking the extensions first change
> > the current power_supply_get_property() into a new
> > __power_supply_get_property() with a "bool check_extensions"
> > argument and make power_supply_get_property() wrap it pasing true
> > for check_extensions. Or some such, whatever you do try to avoid code
> > duplication but you already know this ...
> > > I can also write some
> > > documentation on how to implement power supply extensions in general.
> > That would also be good to have.
> >=20
> > Regards,
> >=20
> > Hans
>=20
> Alright, i will send the necessary patches soon.

Sounds good to me. Please also Cc Thomas Wei=DFschuh, who implemented
all the extension code :)

Greetings,

-- Sebastian

--5or5bqtbn5mstngw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmhZ1roACgkQ2O7X88g7
+poTrg/+LX4Wc1TE1ZxiQAlP57sFDjqo2YXSaWRAf7fXFGkAfzGZpWdj8weX1usm
GMj8EoG3O6QzXJ9+iNco6PNe1mPLhBXS3Xe+GgWaPdAx358tFb3D/NK7cbWgZlZs
DeJAFu4E1mHM8OdwW2zOzUHVMsR75JYKpLp8xIpbrJB0eMJCsrH9fDwqBaM5SHkN
V0MnATjvH5+JgJBwIbybZucq8ZkbfPETtZyu+3cH19Ulw8QEmr87tnmotPDj+ZpV
CRLDHYRsz84iDanHgfCG+fdP5Gk5PQvJQi9lJhLoEGx4iE6OvFQhEn9OH0pGpSOM
ectiDEnAJeoI3Sn396+JSyrVKvzkD6g6CKWvu50FZah+tDP14C7jmX/r8KUGkCuU
rjwTYH5kh26s4EOLMdMtPLQ67qn6jdO7kBzkPMBnFYYi3MY9A+41j63brIBAeYJL
kPdf2BXhpk9aYyw7MfgLTpCon4iCqSAGP622vVw7/KlMjLLGAWId7/DO8P2EQRrA
uc6ehbYpM/Md6m3hNiN2TGg4LFJ/fZPI7gwLTTvmszW+FiW0CsaahKy1UvVPxxbF
N78PJUbYwG2liCDwGbAxhOt6dC1+WczRWzub40lPjjaLtgoyZgXLzdHveiXoa6tV
zNeHib/If/DD8+EkJfxHhzP06ultrj6QlmDeuewj3xrV7/dBRvg=
=GfIe
-----END PGP SIGNATURE-----

--5or5bqtbn5mstngw--

