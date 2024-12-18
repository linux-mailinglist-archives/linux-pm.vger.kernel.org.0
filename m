Return-Path: <linux-pm+bounces-19466-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C91A79F70B8
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 00:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 275C716DD68
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 23:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889131FCD08;
	Wed, 18 Dec 2024 23:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="U34MY7ib"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8241FCCE1;
	Wed, 18 Dec 2024 23:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734564250; cv=pass; b=rHHtR/t0dTCNUKgb6P9RlxqJyw4/omTbe+e7laX5JC/Su+fM6zbQAKhk1DX9w4BbIqokn4rRTWeZ9Ttgck8MOkwlViCh7OHpUL6EDBj94UGTdfpcsSGgWb8aSjCZ3f4cvROMB/G87T+7HI6XUs25Z/qhclz0JK+qF6Xynxt69OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734564250; c=relaxed/simple;
	bh=wdr0t8qDJjtsLvnbcrCJEX0hlINzDrdXF2LxIVS46+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNvtAbpdP9CrowIaJGMtP/Umqfpgmcl/87jdFsedHnVOQ97qcp1WIRvEdaxDZvf8ByDn3LDabUS9vOTVWnP10mSEhzbPiPwuIabbA3UCC1kh4B2UWaFk8HfS2wzU0JP17t9fzrd9V3omTHHy2/DiXREq5WffB5ghwqOSNsqsFO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=U34MY7ib; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1734564239; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bIpeNH4QSE31Weq/VKVU8IX0EGDhXe0lXnYrTMZXMWVzrHaXaN1uDnJdJdq3WUfJmd3iJHIpR3x2jI80Gj3WjVirZAtWjU/eB1NZWHTxmRzVneZKXeznXOs/zHUmJRxmSss4dsFxi2VRACBWW/+hh/TNKgmNesfxutLs39yqBvg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1734564239; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8ZT/x7HyuP2EkR1cFSQW2bcFZrEhyLrC0V50uwExDUE=; 
	b=H8U8606AlsxvJye0GmxU2M9ZOpHdH84p9yb6W3s3SxO4dZ3GpkvRa/EFpq650eRTisgXMIkZYkKI7TTgLpfcR9mQoa5cvh6HSz+FaP000z8WDy/uXPBqG8N3n4npAJwaVqw8l5tGIfypJZdELIAAyT60UfhfruMr7lGX3QNecvI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1734564239;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=8ZT/x7HyuP2EkR1cFSQW2bcFZrEhyLrC0V50uwExDUE=;
	b=U34MY7ibAv+k+On8UnQ4rXcG+DOWoU5sTMLJ/xfEQJk0PXWzYmcU7jNVNUqlVVqy
	5lgk/uYOmP1a3Jw7po82xqQDNG+zHaknkuraFRFw7gGlWAYI7KDgNy1/yGkAak4ikdZ
	EJYlLHLKoeYxWVmcka+7QvxXEYmQMOvDS6QcZ5aQ=
Received: by mx.zohomail.com with SMTPS id 173456423696394.3412501413028;
	Wed, 18 Dec 2024 15:23:56 -0800 (PST)
Received: by mercury (Postfix, from userid 1000)
	id 010801060345; Thu, 19 Dec 2024 00:23:51 +0100 (CET)
Date: Thu, 19 Dec 2024 00:23:51 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
Cc: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 2/2] power: supply: Add STC3117 fuel gauge unit driver
Message-ID: <sbzgrm2zplaqaxr7ll4t2xbxzorgh5swuonqyqvwsnrfum7565@luiffklagamp>
References: <20241216070457.8083-1-bhavin.sharma@siliconsignals.io>
 <20241216070457.8083-3-bhavin.sharma@siliconsignals.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5ma34qwrenrmxsht"
Content-Disposition: inline
In-Reply-To: <20241216070457.8083-3-bhavin.sharma@siliconsignals.io>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/234.439.92
X-ZohoMailClient: External


--5ma34qwrenrmxsht
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v11 2/2] power: supply: Add STC3117 fuel gauge unit driver
MIME-Version: 1.0

Hi,

On Mon, Dec 16, 2024 at 12:34:55PM +0530, Bhavin Sharma wrote:
> Adds initial support for the STC3117 fuel gauge.
>=20
> The driver provides functionality to monitor key parameters including:
> - Voltage
> - Current
> - State of Charge (SOC)
> - Temperature
> - Status
>=20
> Co-developed-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.=
io>

This is not what I wrote. Please check the process documentation, which
I already referenced in my comment in your v9 submission. Apart from
that my comment also applies to the other patch in this series.

> Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
> ---
>  MAINTAINERS                               |   8 +
>  drivers/power/supply/Kconfig              |   7 +
>  drivers/power/supply/Makefile             |   1 +
>  drivers/power/supply/stc3117_fuel_gauge.c | 607 ++++++++++++++++++++++
>  4 files changed, 623 insertions(+)
>  create mode 100644 drivers/power/supply/stc3117_fuel_gauge.c

[...]

> +	if (ram_data.reg.state !=3D STC3117_RUNNING) {
> +		data->batt_current =3D -ENODATA;
> +		data->temp =3D -ENODATA;
> +	} else {
> +		if (data->voltage < APP_CUTOFF_VOLTAGE)
> +			data->soc =3D -ENODATA;
> +
> +		if (mode & STC3117_VMODE) {
> +			data->avg_current =3D -ENODATA;
> +			data->batt_current =3D -ENODATA;
> +		}
> +	}

You multiply these with 1000 (10 for temp) before returning them to
userspace. So you return (-ENODATA * 1000), which is obviously
wrong...

Greetings,

-- Sebastian

--5ma34qwrenrmxsht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmdjWYAACgkQ2O7X88g7
+pp+oQ//eIqzXfv+bCK+NUi25LM3gfES7RkhOqFu5ekxkqeXl8YfKycQ+UrHv6YH
Qnkd3fbqTGshyDj6b8HOY8x2I/dlreMePbRcCZ+dxnzZBJl/Tz/2KnD/FL5yJZox
XOx4h3cvsrZf6uNnxjKY2nGLckj1iOE/PmEXWrgu4qx0t8S0R1+aCyNOYxgHziXz
XYv9EQX//5erF9MI86/StKwpYtOS8kHnfXagsBHF4Wr7xXuDsHuw0SH07TwfIMxm
yd3sliEH6Yx5vaPS0J9CAJ1j0d4/yhJdwz1w4YQl87SKbWqpts3N+yF4ZsjPXh4H
BLp7YqrMm0kiT5Y0ga6z+fqTpc2i/7Q2nc05BdWoREblXRTgGWl/MZL6ixsIoXZO
Qp7zzLJCFNyssr/ViR30UpDV2ZWGiSmCiwzh6fOXtwIG3bKIXErkpdxuZhu9fF9W
Mwj5dSm5GFfRqi2Kw+pULQ0oax21w2zy7HKKoS5G3FUK6u9DfAsLkGFyaFAhfLBW
i3ZXOf8JsLjNUY2uGBydOeQYf+ccu1CWomhuon97oRy/PJ3j/EAzUlwoEIt7yLiK
gKG6K0NZBTvKEBp3oYTIpyjdUbnHNQBBC05tECN3XKTTXj5x1yn1wFFQ+mskT+79
LigHfo4PCSe+wOS3+QVCTIaaRAQOxORuMHDAL0YjSbSQCmZjBEM=
=e52W
-----END PGP SIGNATURE-----

--5ma34qwrenrmxsht--

