Return-Path: <linux-pm+bounces-19465-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D479F703E
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 23:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5F091683EA
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 22:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E134C13D8A3;
	Wed, 18 Dec 2024 22:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="Q8gU4J73"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A234690;
	Wed, 18 Dec 2024 22:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734562005; cv=pass; b=D8I11BpPY+x8t9Zsz+5fz0Hvf9THhS6K+fUSRu7AoLszHy4uPrwYBIx2qb0GC7ErwA74TVMnZsKzBcrgcP+/iIH+AS3pGXMv+U4bQ0Uq3R9/cr6uKW2c9ONTiBO+wrko5pTCMGdqjPlD0c7+9421q+coDxMqJc1oGE33zWFF/4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734562005; c=relaxed/simple;
	bh=gom19N4DjFmRLYBDNIQJeQBetpAxp3RniMSiSs1VxcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIkjLIxk3n2nPbnZMSwJPE8cMI74Jqj4CJkENRXSxTSFif+8vv44Wh4LrcXex0/rQw3TuIfy9Ot89RxAXcWoXK0h9pvlcsAWfdskw7S+OzaCIQkAlPZBvbQpRx5oldpA3+Hlx67fhrelZ0YBZaRNir74zOgVWwm5B2qinK6ZKes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=Q8gU4J73; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1734561991; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=I5bOT54wAezpehLU2X4E76Q563894EvsUMwTSd2ChKX9V9vuoPo8jpDA30D8J/ibQG7C8/rI3gXkDNmWI2G0TeKmCNVrLOi3F6Lk+7r4KnC0HblRtIEqkafvgYJt4uzcTZH4c8P1T2LqHE0lMkzcjIXPjOk0kzUpKiIDaDge4A8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1734561991; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9kkUB+G5DbEygu4ZRjirxEqrd26K9Di6wcZN27V0lxY=; 
	b=Bt4FWtWHc+ATvo2KS4SibxslNdMMpH54l33Q/+BLZoNhpu1FYZ1RSPnCIFPOeei6v1GyD2gZ5hIOy5dTdNkn35gTtdS9xPuxfuqAI8TWI9UD9ZFfhOp+xGMvwOLWiW9lvL9jJYicLeY166/XdAmdzV1gPGgImtcdG4x2NN3JbLM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1734561991;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=9kkUB+G5DbEygu4ZRjirxEqrd26K9Di6wcZN27V0lxY=;
	b=Q8gU4J73i160KkQVZTJ1jC0F61XvKv55Q+Qtn2qBywCzMtv4gbUimFrZMjjmfC9j
	v15dFGeHUe0UzTNtC0vFzodnv+VLqL//WF+wydWCbBgM7cVQhqbPxSRzDNSbRYOnsGE
	ZWciLp6uxIqUP1T3xFwQJHIp5a+ATihuX6rkHlLs=
Received: by mx.zohomail.com with SMTPS id 1734561988612787.2009935196426;
	Wed, 18 Dec 2024 14:46:28 -0800 (PST)
Received: by mercury (Postfix, from userid 1000)
	id 517C71060345; Wed, 18 Dec 2024 23:46:23 +0100 (CET)
Date: Wed, 18 Dec 2024 23:46:23 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Nathan Chancellor <nathan@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
	Hans de Goede <hdegoede@redhat.com>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 4/4] power: supply: core: add UAPI to discover
 currently used extensions
Message-ID: <lbtleh6bihwxbj4nlj24wddqvhr7srrkyq5osi4oc6kaxq225n@asu5qkwxe6zc>
References: <20241211-power-supply-extensions-v6-0-9d9dc3f3d387@weissschuh.net>
 <20241211-power-supply-extensions-v6-4-9d9dc3f3d387@weissschuh.net>
 <20241218195229.GA2796534@ax162>
 <eb265cb2-b079-4bca-bc35-17a9f4d0ec3e@t-8ch.de>
 <otwk52a7nkle7yx3444swh5xasm3l6lmu2suapmvjuplezihyv@p6vrs6lo454e>
 <26833b6c-834d-433b-8d80-0ad39b1c968e@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zwjc7voobm6ufg2p"
Content-Disposition: inline
In-Reply-To: <26833b6c-834d-433b-8d80-0ad39b1c968e@t-8ch.de>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/234.468.73
X-ZohoMailClient: External


--zwjc7voobm6ufg2p
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 4/4] power: supply: core: add UAPI to discover
 currently used extensions
MIME-Version: 1.0

Hi,

On Wed, Dec 18, 2024 at 11:16:16PM +0100, Thomas Wei=DFschuh wrote:
> On 2024-12-18 23:11:35+0100, Sebastian Reichel wrote:
> > On Wed, Dec 18, 2024 at 09:29:31PM +0100, Thomas Wei=DFschuh wrote:
> > > On 2024-12-18 12:52:29-0700, Nathan Chancellor wrote:
> > > > I am seeing a build failure in certain configurations because
> > > > power_supply_extension_group is only declared under a CONFIG_SYSFS =
ifdef
> > > > but this code can be built without CONFIG_SYSFS.
> > >=20
> > > Thanks for the report.
> > >=20
> > > >   $ echo 'CONFIG_EXPERT=3Dy
> > > >   CONFIG_SYSFS=3Dn' >allno.config
> > > >=20
> > > >   $ make -skj"$(nproc)" ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-=
 KCONFIG_ALLCONFIG=3D1 mrproper allnoconfig drivers/power/supply/power_supp=
ly_core.o
> > > >   drivers/power/supply/power_supply_core.c: In function 'power_supp=
ly_register_extension':
> > > >   drivers/power/supply/power_supply_core.c:1389:55: error: 'power_s=
upply_extension_group' undeclared (first use in this function); did you mea=
n 'power_supply_attr_groups'?
> > > >    1389 |         ret =3D sysfs_add_link_to_group(&psy->dev.kobj, p=
ower_supply_extension_group.name,
> > > >         |                                                       ^~~=
~~~~~~~~~~~~~~~~~~~~~~~~~
> > > >         |                                                       pow=
er_supply_attr_groups
> > > >   drivers/power/supply/power_supply_core.c:1389:55: note: each unde=
clared identifier is reported only once for each function it appears in
> > > >   drivers/power/supply/power_supply_core.c: In function 'power_supp=
ly_unregister_extension':
> > > >   drivers/power/supply/power_supply_core.c:1419:54: error: 'power_s=
upply_extension_group' undeclared (first use in this function); did you mea=
n 'power_supply_attr_groups'?
> > > >    1419 |                                                      powe=
r_supply_extension_group.name,
> > > >         |                                                      ^~~~=
~~~~~~~~~~~~~~~~~~~~~~~~
> > > >         |                                                      powe=
r_supply_attr_groups
> > >=20
> > > The reproducer doesn't actually enable CONFIG_POWER_SUPPLY, when I us=
e it
> > > I get a whole array of errors.
> > >=20
> > > > Should the declaration be moved out from the ifdef or is there some
> > > > other solution I am not seeing?
> > >=20
> > > This, inline constants or a #define.
> > >=20
> > > Sebastian, do you want me to send a patch?
> >=20
> > Yes, please send a patch. I suppose a define next to the NULL define
> > for power_supply_attr_groups should be good enough and consistent
> > with existing handling of this problem in the subsystem.=20
>=20
> That doesn't work because of the usage of the member "name" of the
> symbol power_supply_extension_group.

Right. Maybe make the power_supply_extension_group static to
power_supply_sysfs.c and instead offer power_supply_add_extension_sysfs()
as a wrapper to sysfs_add_link_to_group(). Then power_supply.h can
provide a dummy for !CONFIG_SYSFS making this similar to the
power_supply_add_hwmon_sysfs() handling.

-- Sebastian

--zwjc7voobm6ufg2p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmdjULkACgkQ2O7X88g7
+pqUYxAAplmQPfm/LT8dh+Pf5BN1oGzexOAt8JuXwzFscFtaXElYuBj8CibRGspn
obgehyumqepGFi1lkapeZv8WJxIdkbDwIggf5aob8Hem9usZxG04Ky/7Pim+9G9f
PkKWVI4Sy5UxBZ3Jl5zQiHYJ10BcKAAg6KYoXzRqqBf7NOT+c7fdbkDeLq4S5itO
ezGYwguN0CYE7pKHW46WFHMK+G25ps2VgTrOn/eSpVaM2DN0oMAQAtiqwhGbOPOS
jWKSAgW7As8pD+Rd7HouxvqoSyUik8I9eO1wAXkE87jxpI5xqTn4ege5x4iA1ZBQ
RIeZpK11H1MBqU74/v5XM/M9sLbf0Pf0Vh5b/VyhwioJs6ki7N4oOMBCBw/1SNaC
Hy5gqqDPYfWdXLKtvuxo2hITGG7wxp9pdMviFv+0zgy1QkmYwNellB+DmDWb7M9Y
6/Q/05mfWBALMTPCz0W7OEMuN3WLVIIRXEZgJ/Nw4TM+oHhICRHFpV2B3XjDUDcx
GNbPL+/qr/KkxjV/fSe1zX9lr3kcvNJnOO6AjDtRFAv40PJUy+3t8X6b8zwt9kq/
Kv71PRgkLThOVuxzPSowAkEcD3evTiaFhPwmqaaeacj5HAn/PEE2c7rtFd95F26N
Uk25Q2uYRliRCJgiQkmKXM3B9BcRVMwrcSF4xiJXj0W0suwH9is=
=VGrv
-----END PGP SIGNATURE-----

--zwjc7voobm6ufg2p--

