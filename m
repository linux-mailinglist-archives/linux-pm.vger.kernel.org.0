Return-Path: <linux-pm+bounces-40616-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2C2D10312
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 01:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F06E3001BF3
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 00:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410A21D5146;
	Mon, 12 Jan 2026 00:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="FHarc+2k"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBEEEED8;
	Mon, 12 Jan 2026 00:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768178790; cv=pass; b=u9nZ2cbgqwB/nQV7bEmhmJXLGU1HL4YGJQ/l7J13cTaUR1t7e1FvErjtdTWPJtMi5q4MQmKOGweBAKZObZnvFkIGOjPzktHqF0t8QWC4SGjc5mrJ1HrRbT0EsSZZF0eyzRLYttl15z5riFcZhGP94jJYt2FCj+gmfmedjTRT6No=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768178790; c=relaxed/simple;
	bh=MVszG6ihy0qYnZqGnu8VCSCSuIjiqRpmuTh+ly9v9ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2uJI9uQat96yfQGK8yHWy/hY0mW5WDXeGf+30MjeoXrynEFbWKBC/Fvd12CmQKPFVC6XZEZcbMyUrb5twiCAtbDZMKDn7qVkTCv9l+EaObF6Nj72qgo1LFiY+tm9rYR5jZx5UgcI8LNtgAPG0FYBYD+WUd5y1Tq3dbQx6mrwo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=FHarc+2k; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1768178765; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jgXLt5UNxMxkLphEleFuVPKdJSHEE4d+8SJlcjThc4jgujX2WVCy46xUoVugINj2hyC8LxA0SnG2nwLHQlEjg095CdBEFvRKeZkWPCt96r/xJcEX0zvfd9bni+EKLj1KxbtFuKrJHTpgWAGXb3PrC5Vu6wwn5Blk4PUH7lIRMok=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768178765; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+gc/eeIsAUoiq+pqcqi1YCV9QaAlVn33H60DGRVC2/M=; 
	b=BEmdMHcw7Vwv2cl2L7k14ruNwlcFiC6yCbhkikyu6n/2EXfGGfhD4NhYSFVydnnck4dUWqovGQdsh6MkLDUPgHRtZYnSvwqIfY5Mj36DZ3CG8qU0mhub7XM/oL5Td8inp/7Orkn12n4i6INvLSwsjO1pQFgNj3Nj8lG5X6HkpQY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768178765;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=+gc/eeIsAUoiq+pqcqi1YCV9QaAlVn33H60DGRVC2/M=;
	b=FHarc+2krfXnrje9qVO0q2mwYZKXL+j9si9NSuHtCSy4sKRcmxeu8we3o6HuwhQe
	LRwqy7MCiKYY/zP+g01XJ/uT9NM5DuxYk3DxHyzuKi3TAwo6b6ai1RMGPSwe32w4GCC
	o7woq2AATQIjwAbcAJ6c5ynoUMUZY6cV6EZ1qfRY=
Received: by mx.zohomail.com with SMTPS id 1768178763287841.100101235651;
	Sun, 11 Jan 2026 16:46:03 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 858861803AD; Mon, 12 Jan 2026 01:45:55 +0100 (CET)
Date: Mon, 12 Jan 2026 01:45:55 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org, 
	Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH RESEND v6 15/17] power: supply: bd71828: Support wider
 register addresses
Message-ID: <aWREICvFRzoelLWm@venus>
References: <cover.1765804226.git.mazziesaccount@gmail.com>
 <57c87f7e2082a666f0adeafcd11f673c0af7d326.1765804226.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p53qtk3uydhqcv77"
Content-Disposition: inline
In-Reply-To: <57c87f7e2082a666f0adeafcd11f673c0af7d326.1765804226.git.mazziesaccount@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.5.1/268.172.5
X-ZohoMailClient: External


--p53qtk3uydhqcv77
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RESEND v6 15/17] power: supply: bd71828: Support wider
 register addresses
MIME-Version: 1.0

Hi,

On Mon, Dec 15, 2025 at 03:21:03PM +0200, Matti Vaittinen wrote:
> From: Matti Vaittinen <mazziesaccount@gmail.com>
>=20
> The BD71828 power-supply driver assumes register addresses to be 8-bit.
> The new BD72720 will use stacked register maps to hide paging which is
> done using secondary I2C slave address. This requires use of 9-bit
> register addresses in the power-supply driver (added offset 0x100 to
> the 8-bit hardware register addresses).
>=20
> The cost is slightly used memory consumption as the members in the
> struct pwr_regs will be changed from u8 to unsigned int, which means 3
> byte increase / member / instance.
> This is currently 14 members (expected to possibly be increased when
> adding new variants / new functionality which may introduce new
> registers, but not expected to grow much) and 2 instances (will be 3
> instances when BD72720 gets added).
>=20
> So, even if the number of registers grew to 50 it'd be 150 bytes /
> instance. Assuming we eventually supported 5 variants, it'd be
> 5 * 150 bytes, which stays very reasonable considering systems we are
> dealing with.
>=20
> As a side note, we can reduce the "wasted space / member / instance" from
> 3 bytes to 1 byte, by using u16 instead of the unsigned int if needed. I
> rather use unsigned int to be initially prepared for devices with 32 bit
> registers if there is no need to count bytes.
>=20
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Greetings,

-- Sebastian

> Revision history:
>  v2 =3D> :
>  - No changes
>=20
>  RFCv1 =3D> v2:
>  - New patch
> ---
>  drivers/power/supply/bd71828-power.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/power/supply/bd71828-power.c b/drivers/power/supply/=
bd71828-power.c
> index f667baedeb77..ce73c0f48397 100644
> --- a/drivers/power/supply/bd71828-power.c
> +++ b/drivers/power/supply/bd71828-power.c
> @@ -44,19 +44,19 @@
>  #define VBAT_LOW_TH			0x00D4
> =20
>  struct pwr_regs {
> -	u8 vbat_avg;
> -	u8 ibat;
> -	u8 ibat_avg;
> -	u8 btemp_vth;
> -	u8 chg_state;
> -	u8 bat_temp;
> -	u8 dcin_stat;
> -	u8 dcin_collapse_limit;
> -	u8 chg_set1;
> -	u8 chg_en;
> -	u8 vbat_alm_limit_u;
> -	u8 conf;
> -	u8 vdcin;
> +	unsigned int vbat_avg;
> +	unsigned int ibat;
> +	unsigned int ibat_avg;
> +	unsigned int btemp_vth;
> +	unsigned int chg_state;
> +	unsigned int bat_temp;
> +	unsigned int dcin_stat;
> +	unsigned int dcin_collapse_limit;
> +	unsigned int chg_set1;
> +	unsigned int chg_en;
> +	unsigned int vbat_alm_limit_u;
> +	unsigned int conf;
> +	unsigned int vdcin;
>  };
> =20
>  static const struct pwr_regs pwr_regs_bd71828 =3D {
> --=20
> 2.52.0
>=20



--p53qtk3uydhqcv77
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmlkREAACgkQ2O7X88g7
+prsXA/9Eyvov5f12fyRIhmjYutdiaP1GuAKhRbEGDFkORkT6ugco4syK9vPy6Nz
tgkcW9JgdAZGyJLN+DIfdV207IigO2u2v2pKebeCVE0QcP1nHDW1SvM+s+yqAnxQ
fEITKr+r8AYhGsHUowtpeRwG5ZFWdqqBboqxJIwmKcRiFKqk94dL+qy5uZ3omhyX
DRmRuYtm8Zof8bPH4tafWQjocvw7Hi9rsgODvy78+ubKosSHEz/x9VJ3K3Bs3s4d
DUyHFQciqP+mxBALwSCnMKrAojyi7kICS1Sb4JcUJ0vWeFR6iSfPYdVbrtHDmv8c
CEOcZiU54nFicBTcqe3ttHc/TUD3absKgvQW6Z7kUPQFmuCJIH+Qdv/y4tbxi7q6
iPZVgFE+R+39DOx/f/cjnp/Bo0Si+LSnSG3lWB6zZkF8FCevdEDZkKyHdTBG/lOO
rDQmwryrjtwtiQ9ALXK8odD0JPBxs8mSBhrgVjV6nRxxrWxa9K9/mMl6gXsMZfbD
g8w+y+KbFxDEPo+Oave8z0b+s5y9mWvCwbrmlnbP7uSks0+WHj7hBuFOrBLbz2vg
9soeu2L7RFwCUbIUk07u/UFPEiL453f1EN2VpHOu/uDtzW9j+y5aORO0EBPb03Tq
+dId3gphxAQJTMm8+rosZOWVA/GVs6kal4OizAMjrDFZ1HXnMkY=
=O5nq
-----END PGP SIGNATURE-----

--p53qtk3uydhqcv77--

