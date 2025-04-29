Return-Path: <linux-pm+bounces-26396-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 601FDAA3AFB
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 00:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0E7E4C277D
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 22:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B3426B972;
	Tue, 29 Apr 2025 22:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="GPpnDA0r"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B565D26B0B6;
	Tue, 29 Apr 2025 22:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745964379; cv=pass; b=SzRB64MqdTpmevq8q1YaWAbq/5wIRu5A85LMOTficgrclHAGBYm7fzZ+AYvmQ6ekYSL9H6TpGOiIazu8FgP1O9bosUYXfxaOAsN55jfuxqnT5hFXJ2VxjhraOFKudasm/Zns/CW1jglM6vD2PlluFi86fYOueeTlbTxr+tYInjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745964379; c=relaxed/simple;
	bh=MbaXHLoJxArsHCdBOfQEu9DXbsHyT1rVLuVB1Qx+Wt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJmiU8MSxG8xa+ciNnWtr+E8dco4LWTFHkamZSHUn6VnJQitHHJopLkj3a9iBkMSclwec54OplOAfCV2wzLixGuZv2nJjKFtgHij704hGE0OcsiRuYNM7FmLoc2cax+TYy4EyN6B7bmpTv6NK75qdXBv9B6wRANuVd9dCHo65ZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=GPpnDA0r; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1745964350; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CxH5FmnYt3jz34p54uFpXpdabkd4YQ//oGr+UBOlF91tdO8gTrTfIZHHiQIDp92s2zi7FSDOKe725JtGQWVaIow/R+X0fseqw27HKAo9Jblqj1/s/nUv2LQB3gRiH+kAQNrXjHXiZ6a+FAaBmOVd500S3DbhCzvddqNlOx2++3A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745964350; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KdFbTJ+DPzwXoDMuxfaNe7+vTjaQwFbN5rPgO6uNUDQ=; 
	b=gsjx/NXrH5THERaLwleLVBMeR1l0csvylt2I28yZyggmN+vWLaYEwBAxw20zf0Prcu/5s0K3tU/K5N0h2UzZXDWy50S5S38YzFs+gy9324Uq8YtMDyAIeAG3qpUTZESJIvjkpw3+LILBINOp890No81Rygv5VehlPIb76EHutYg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745964350;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=KdFbTJ+DPzwXoDMuxfaNe7+vTjaQwFbN5rPgO6uNUDQ=;
	b=GPpnDA0rt1h6eg8FfBWhcMkPCLCwP7qHhWz0tDSeDhKDa6J/P/BxfKn4QpJj9eDs
	qjKb9mReeyULz1OYiSSbVKFbdpNRhRB6BWBC8v/6YogjX7PdjqHUtrWz3KqCFRGbs2a
	3/HIvCbrr90LXCYcaXGzPVNcMzG2K0WSBLU4yJLE=
Received: by mx.zohomail.com with SMTPS id 1745964348503182.07787205987552;
	Tue, 29 Apr 2025 15:05:48 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id AF3A5180D2B; Wed, 30 Apr 2025 00:05:43 +0200 (CEST)
Date: Wed, 30 Apr 2025 00:05:43 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, Aradhya Bhatia <a-bhatia1@ti.com>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 3/4] power: supply: Add driver for Pegatron Chagall
 battery
Message-ID: <uem7xcvoqaezqdagp5afdahpkbadyt2xplzq2vgj7rtkb3o2ty@stxwmj5rlhsc>
References: <20250429061803.9581-1-clamor95@gmail.com>
 <20250429061803.9581-4-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="derrf7u7tiethnp7"
Content-Disposition: inline
In-Reply-To: <20250429061803.9581-4-clamor95@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/245.962.17
X-ZohoMailClient: External


--derrf7u7tiethnp7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 3/4] power: supply: Add driver for Pegatron Chagall
 battery
MIME-Version: 1.0

Hi,

On Tue, Apr 29, 2025 at 09:18:01AM +0300, Svyatoslav Ryhel wrote:
> The Pegatron Chagall is an Android tablet utilizing a customized Cypress
> CG7153AM microcontroller (MCU) as its battery fuel gauge. It supports a
> single-cell battery and features a dual-color charging LED.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>
> [...]
>
> +	cg->white_led.name =3D "power::white";
> +	cg->white_led.max_brightness =3D 1;
> +	cg->white_led.flags =3D LED_CORE_SUSPENDRESUME;
> +	cg->white_led.brightness_set =3D chagall_led_set_brightness_white;
> +	cg->amber_led.default_trigger =3D "chagall-battery-full";

^^^ I fixed up the typo while applying.

> [...]

Greetings,

-- Sebastian

--derrf7u7tiethnp7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmgRTSwACgkQ2O7X88g7
+pqEhw/+IwFRgtxVJelx1FT74sLgxKIYg2FTtDpPy/NaeX2hYC7hLAHKX/DGf5BJ
po+IXI3KVaSEfRgq/QoIvvjIqTDuQYF9EuQpjhZghr+V0lHNRmOoDAaGSofRdHP4
LznDh3ITORxtTz4yYTZVR/Z+uN+R++LPoKxCbaX2u1+aqnJDZzI4C+56yfhGyubG
E9KOCCVkXxMmEqTkZJ8yviX3pead/oGBaKi4e1EdB4FaLgBWam766D/dbKhIHZ2F
K/JKaj1llKip6jByFXadPlskdXhYUDu1kqgZNMylD7eC6olauWvKsaMmYSnkoNfP
nTp1EWHCDnkcdTRmOWsvX4071Y5y1y64+MIK3vFP3ptjNIsdFFvLS/X8Opf4itJE
z5dmXDI0TYY6i0wrpvw5eD61kqvDDwfzANZQ8AOS6k26tzmBSrhDDADCIuyJaEqL
7Buj2zryA1tlutViQ7W35KmS7bs8sy6YNQBUa0N2iF4MHb9194d/OY43E6AgNlmK
/aRPEHTzsG0k4ex1hSQBmh2kgVUOif4L+vFzcVN5pac+DexyeEcmBcKsp9zzzQcI
ZWbirKXypRJjCFz8AgC7Rn9YnkW2d/OM/NrkNhTtaFN+bQmrmIB9UrowVbv+Ma5d
wMON2BI9alM7jeGLH8n5V/f26DeN4s3PxbGm8/c//Hz7/Ov8pzY=
=okJ9
-----END PGP SIGNATURE-----

--derrf7u7tiethnp7--

