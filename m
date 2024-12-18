Return-Path: <linux-pm+bounces-19462-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3389F6FE5
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 23:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D4607A3FF5
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 22:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AF01FCFE4;
	Wed, 18 Dec 2024 22:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="YnPOmvDW"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05AB1FCF66;
	Wed, 18 Dec 2024 22:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734559919; cv=pass; b=auPP1uA6qShn6OJ1f31OHxaMbRt9wSiekv+WjZm94imILR8ARHH7lTXKuHVCL4eQloBBpySxte8ndDikBVneF1NsUIfBi0tVZhhp9JKnqapo+fdyk8WgjHFTi81Irds5RmtNWOW7nG1HN6TTfgFlZVPa4UeAnnyTD7vQopDsLN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734559919; c=relaxed/simple;
	bh=IIFJUgSFcllsxyTqqalwYX8lwQT014h+3ow/BGcKCeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVEngWehjqjlcLl9tT8U7N7FvKGaabDFE7ONpnpOLOoacVS9xXrwkqbvDjCv/1v01gmuGYre25AObo5UytQ966w3b+Q9qCuExUvSgVbn/KuKJc9iBqkjSsCnyBoA4z34OqB+f8bABdssTZUtCk8iHucOOvFuuP/oSMB3Xw4T6Cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=YnPOmvDW; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1734559903; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gXuHM4YTxBw6TZ2iIXJDgG9hQEp1v3bkJOg0hxBDgT0rpNyX/ExkE1iNFBRluKJvyfQKBFX5J4j2Xu3ThT5li9aOmuRcbFSxhkrkCCwVJXPZNJvW2+NB5quYKFHw4nC6YSf+J3kP6qyqWH7vD1L2YxbzG5iOllIyFKF5lHP7blU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1734559903; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zIC73tJE+0Lgr/1a9NeB62/o6YEaEQYqq8EDI1i5mfo=; 
	b=ZtaeDTFM1WM3+m3qca+EJIG94ImfvlTNAM8b/2uCmClE2n9P5apZbJDBvgIglqNB+pkNtZYYx+nfJxZN9nFrddA63Vga5Rs7ZZhGUXn25q487ymqMObtoPbp4kcIETeTxgVGG9qDcshKDNGL1Z9ZAoGRlSwNEI8k/sfS67cjeMM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1734559903;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=zIC73tJE+0Lgr/1a9NeB62/o6YEaEQYqq8EDI1i5mfo=;
	b=YnPOmvDWxpVOfcIWcS63XMO8waj7CXDs1rtic/I6R8X6Tm+KfaGb7E/naXHxFsNe
	f0n/N8VympK7Z5OpLGWPBVW8WFxOiu7AuBMOJFcGWHSYwwN8+ue0LmPrQff427dN0BZ
	UHsxegIIMBJwQmAxobvmTPssLDDxdo0opM5MPuGU=
Received: by mx.zohomail.com with SMTPS id 1734559900336540.3066848116509;
	Wed, 18 Dec 2024 14:11:40 -0800 (PST)
Received: by mercury (Postfix, from userid 1000)
	id ABC7B1060345; Wed, 18 Dec 2024 23:11:35 +0100 (CET)
Date: Wed, 18 Dec 2024 23:11:35 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Nathan Chancellor <nathan@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
	Hans de Goede <hdegoede@redhat.com>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 4/4] power: supply: core: add UAPI to discover
 currently used extensions
Message-ID: <otwk52a7nkle7yx3444swh5xasm3l6lmu2suapmvjuplezihyv@p6vrs6lo454e>
References: <20241211-power-supply-extensions-v6-0-9d9dc3f3d387@weissschuh.net>
 <20241211-power-supply-extensions-v6-4-9d9dc3f3d387@weissschuh.net>
 <20241218195229.GA2796534@ax162>
 <eb265cb2-b079-4bca-bc35-17a9f4d0ec3e@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eerui4o2x4lxvoah"
Content-Disposition: inline
In-Reply-To: <eb265cb2-b079-4bca-bc35-17a9f4d0ec3e@t-8ch.de>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/234.486.72
X-ZohoMailClient: External


--eerui4o2x4lxvoah
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 4/4] power: supply: core: add UAPI to discover
 currently used extensions
MIME-Version: 1.0

Hi,

On Wed, Dec 18, 2024 at 09:29:31PM +0100, Thomas Wei=DFschuh wrote:
> On 2024-12-18 12:52:29-0700, Nathan Chancellor wrote:
> > I am seeing a build failure in certain configurations because
> > power_supply_extension_group is only declared under a CONFIG_SYSFS ifdef
> > but this code can be built without CONFIG_SYSFS.
>=20
> Thanks for the report.
>=20
> >   $ echo 'CONFIG_EXPERT=3Dy
> >   CONFIG_SYSFS=3Dn' >allno.config
> >=20
> >   $ make -skj"$(nproc)" ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux- KCO=
NFIG_ALLCONFIG=3D1 mrproper allnoconfig drivers/power/supply/power_supply_c=
ore.o
> >   drivers/power/supply/power_supply_core.c: In function 'power_supply_r=
egister_extension':
> >   drivers/power/supply/power_supply_core.c:1389:55: error: 'power_suppl=
y_extension_group' undeclared (first use in this function); did you mean 'p=
ower_supply_attr_groups'?
> >    1389 |         ret =3D sysfs_add_link_to_group(&psy->dev.kobj, power=
_supply_extension_group.name,
> >         |                                                       ^~~~~~~=
~~~~~~~~~~~~~~~~~~~~~
> >         |                                                       power_s=
upply_attr_groups
> >   drivers/power/supply/power_supply_core.c:1389:55: note: each undeclar=
ed identifier is reported only once for each function it appears in
> >   drivers/power/supply/power_supply_core.c: In function 'power_supply_u=
nregister_extension':
> >   drivers/power/supply/power_supply_core.c:1419:54: error: 'power_suppl=
y_extension_group' undeclared (first use in this function); did you mean 'p=
ower_supply_attr_groups'?
> >    1419 |                                                      power_su=
pply_extension_group.name,
> >         |                                                      ^~~~~~~~=
~~~~~~~~~~~~~~~~~~~~
> >         |                                                      power_su=
pply_attr_groups
>=20
> The reproducer doesn't actually enable CONFIG_POWER_SUPPLY, when I use it
> I get a whole array of errors.
>=20
> > Should the declaration be moved out from the ifdef or is there some
> > other solution I am not seeing?
>=20
> This, inline constants or a #define.
>=20
> Sebastian, do you want me to send a patch?

Yes, please send a patch. I suppose a define next to the NULL define
for power_supply_attr_groups should be good enough and consistent
with existing handling of this problem in the subsystem.=20

Greetings,

-- Sebastian

--eerui4o2x4lxvoah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmdjSIsACgkQ2O7X88g7
+ppwSw/+JIBBJeZjTcNbURvfdfQrjHyPIUOmGJJTkxriENOR1kfwJIJ2JIPwLe4h
Jsbwxx69vWEowODu2430epiPrSpD/wLSvG7Ex/ZuUMZj7YD14B902523xzZ++C8F
JsRSrBlRnlGCFSnLMe3c+DgnsVupr03yNbBxuoMBVxXKOVw7qWnRf5W759U7zMUj
wuhEu9AUn8Pdy/KemCRz5i+Z4Ox93w6cXRD1+s3HZ7iTq8JP6cVnFCwiAgEGMalQ
NewD9HHmSXkCO06ZyvWrDk16cQzRwEEm1PwK6K+0SeotpBMVLHabpff942KluG1O
hK+LcIWSS+yBbZkTJpPEd0BK4X21MKc5GaTDKCgU5mrJdzabkbSDxAuectlFpR5y
v+S5MNlHwlM3dDpsWDLaqQs6xikIRVqovvotjOs8CIvlepKU4FvD3vTVZbAx5I8b
x1D8NI8pWIuNqDYqHwWmJSRM4utEY/g36dyNFPrzpMCK9+Z/+G75adAiAXxGI8Yz
ytMX5riBheJURJ5lCMLu8Mb6XfbelisDcG/t8cwdhH7VQQiMrtiqR9/rO8S7r7RW
uOhOfNV5K1c4o8h5CbPjYa+jsLJ3/K95IEJ0+t/fGvLYcHUL2mT/SKYg1zbrPonZ
d64NYkoakcfB604AQfysFcQZPyXCbYHogFr0Dv/O6tGVcrKMZ0c=
=0J0E
-----END PGP SIGNATURE-----

--eerui4o2x4lxvoah--

