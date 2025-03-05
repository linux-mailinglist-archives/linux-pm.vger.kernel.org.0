Return-Path: <linux-pm+bounces-23525-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C7AA50EDD
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 23:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5529118920EB
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 22:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B2F266B49;
	Wed,  5 Mar 2025 22:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="hffPW94a"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC967204088;
	Wed,  5 Mar 2025 22:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741214416; cv=pass; b=KkVpDPFPHJaFTayv6Km7Un0VGIWcSdsQUIurGE1F2tw+ilfCe4K2TQoanC5ocW5Y8TzgFBMsFBa4q+pOxX4gjxOEnHvdtA+faLhdEUSbkRoNEX9GJMcLrs21bQ9luvA43b4MMoyey0QDsTQwBkpy3o/1XyT3KcGqSi914wR2K5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741214416; c=relaxed/simple;
	bh=eKXxIE4WwPVC4+e8OqKFdghtOdRPil/d/nIxoVtTfKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6/nNVfJQGIl2yDexwqh7+c3F2fTPVq2dBDinT619iGTS2GgNI8qrkrsKR1Gfz50WyIhjnhNvcXDFQ0SWhl1tjgcMDd41G+LJk7NN7iFxms29/r14bKrA3YszQ4GkeKQpnrNQAkyAbnsuT5GqGb20sRM9LisG85LeJPwNgS54zM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=hffPW94a; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741214403; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OqV/zZ1hYCyFILfo6R8GYZchY1D+2XKZFB1Eo7gUyB5diFAUW6nJkiR3vxZMHkZV8D/+YBfbloLzBvi+xSHW4rZUxbArA3NXvObPhejRrSkAuoJrSoS7sAE55LxqhXRRQFe3BguHJJ3EVRzbyQ/5DLulKk+nH02wuBDjdM/o5zI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741214403; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BBsY6vbyK602yG3/GWZnTVSAcS3PfZMJ2KkShbDU/K8=; 
	b=VxpWmFc5oHogCJOVVsWtelR9F2MhOVc0VK3BYZaLd4Uh4XUcnBcH1zaOe4tN1EhNAi8TedqF/yVMMG0a/k6HAB2zdhH9q4sbmE9esdryPCmfYJZZCQzWhpRaGZlzzpU6hymFOrqXPzc/LPfM6FA9/yftlFyc3RQBew1RnVqrQ78=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741214403;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=BBsY6vbyK602yG3/GWZnTVSAcS3PfZMJ2KkShbDU/K8=;
	b=hffPW94a9o4UlYuUq9I1kr9CSwIQ680OeIJfOJmlaXq9e8Gc4jfdXdrhsIDBro7q
	ImBV+QPnZWwl/o2++FfojNLdRgAc444cMq4/1YWKy6b9xSG79/ASG//MRUnwa1tPYA3
	cdp3HGEY0tq7Z3R5dafVtMb7yiPbF5I1FHjYcPvc=
Received: by mx.zohomail.com with SMTPS id 1741214401365197.1635456630188;
	Wed, 5 Mar 2025 14:40:01 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 78D47183465; Wed, 05 Mar 2025 23:39:57 +0100 (CET)
Date: Wed, 5 Mar 2025 23:39:57 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Armin Wolf <W_Armin@gmx.de>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] platform/x86: dell-ddv: Rework battery temperature
 handling
Message-ID: <s4xexzrsozgs7knt7yha5mdjykgctrxklpnnfsm3qj7me5hf4e@tucwr2wvdpri>
References: <20250305053009.378609-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rhj322g6xfycfnlo"
Content-Disposition: inline
In-Reply-To: <20250305053009.378609-1-W_Armin@gmx.de>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/238.671.54
X-ZohoMailClient: External


--rhj322g6xfycfnlo
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/3] platform/x86: dell-ddv: Rework battery temperature
 handling
MIME-Version: 1.0

Hi,

On Wed, Mar 05, 2025 at 06:30:06AM +0100, Armin Wolf wrote:
> This patch series reworks the handling of the battery temperature
> inside the dell-wmi-ddv driver.
>=20
> The first patch fixes an issue inside the calculation formula for
> the temperature value that resulted in strange temperature values
> like 29.1 degrees celcius.
>=20
> The second patch then simplifies the battery hook handling by using
> devm_battery_hook_register().
>=20
> The third patch finally makes use of the new power supply extension
> mechanism to expose the battery temperature to userspace. The
> power supply extension mechanism also takes care that the temperature
> shows up inside the hwmon interface of the associated battery.
>=20
> All patches where tested on a Dell Inspiron 3505 and appear to work.

LGTM.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> Armin Wolf (3):
>   platform/x86: dell-ddv: Fix temperature calculation
>   platform/x86: dell-ddv: Use devm_battery_hook_register
>   platform/x86: dell-ddv: Use the power supply extension mechanism
>=20
>  drivers/platform/x86/dell/dell-wmi-ddv.c | 84 +++++++++++++-----------
>  1 file changed, 46 insertions(+), 38 deletions(-)
>=20
> --
> 2.39.5
>=20
>=20

--rhj322g6xfycfnlo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmfI0p8ACgkQ2O7X88g7
+ppbtxAAqUC1M1FObaMzK3Cv/flLvomFaEpbaYZH2x45Wc52PADtW2KmmR/Cr5r9
mWgc6VeJjcStGiZ6pNOWe6Y2AAfM39DK6ocrlVi1e7E+ItZmr2n+CzZ02NtlmWiP
9puWXFrEa+E9WP7uvsr1GNFt/eAC57lqkL8RdIFLMcejH5AioQkiwDGeBojspTJg
3SQJmuM64fLKmrptwh4nibml9sIwTR3l9PiFc9xfFX3Vunbqa78a2VAgmGZigGM3
rkHcAvrfUHmJ2j43KeI3ihxfCQ8ytpbCmrLU3mWXndcdSbwRWNIXF/rVeClo7FLk
Qt9FbxvhLAtmEvLbtKDn+To0IRaV9z0tFczhUIx43KKd7RhJ77pax6pwH7Brnx94
IZ1bdSm7F+iOzMLLVBiAPasykm+cYz6ZEy1OJAl4o4NATUgNbMi1SeltLF8tYH2p
cxlXDaziHozlV1MzzD1eI1ip6Qg3/Xhe67WpLii72SWM2+L31+NtyVmIF+ZufWv9
E9jvTFKAOX5KQTr+TXZYXj0U3uE5c6f33WnCW8gkXTvcvJ/ZX7/h5lfIwDKs76kO
WpwiRrKx+vPPp+JWCc2Ppr1GXXF1Pq3jbDiQJKH/wr1H2rdHhEEq+STm6kJ4+2Ap
Jzif5QIrBXTwnZnOMt+j+Cbymb5FfVN1MmBTMo7Q3AQcG7uNoBw=
=UA8u
-----END PGP SIGNATURE-----

--rhj322g6xfycfnlo--

