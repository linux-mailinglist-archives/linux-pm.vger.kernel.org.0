Return-Path: <linux-pm+bounces-34683-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73055B5810C
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 17:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5E93A706F
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 15:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F972214801;
	Mon, 15 Sep 2025 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="G5lh7bKN"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE571AC43A;
	Mon, 15 Sep 2025 15:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950991; cv=pass; b=MKeOzEZ3+fRjYWePuHsF+s7IA4aK8vmg2L2s1HuWIU8FQr92jPltZFCTdAjfFikhvJ7QsiVASEVIHDAwf9ohZsD52ePzUMDKUxvfavVI7b5X4x7byZTV/Pp+4sUKGHtvNqq/3RiKEoi+e5t4xcSNm2G4HfiCMzkZLQ25Lj9M7rM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950991; c=relaxed/simple;
	bh=DgJFvM2gk9OTar+AD3V1ZhHQ2NtbZBq0Ar6vhY4ZQq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlUFUu2teWnFxnN4WGndV9SAcZHmJsRppROYVrsad9YvJo7aMMXbBIHcyZtRpQ8wd6w6ZfT2fDDgoL5YOTju84eqW2t0knURxJVO1H5faofICDirgzhp0uNU092oC9g3h4zyGt/YUfslmrJMi8NH+RA8iZPRBc1EvYTVWBku+yM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=G5lh7bKN; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757950976; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dTzdfJsm4AGeIQoRkbnpDaB4mVAq3P/ohTNkxP1lP03Kp8TCVXHRNCRnghp8FT1eYkdpCJzxb8ZzWkFWqSauCoAdp71QmNT/VyNhQPWCdeZn0T0DXbAMEEFb4oBvQa1AeQJzhC9QsnM4bCaXdyX7F+uU7wDKvZ8lYdZU31505QM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757950976; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6BRtmVLmOXJkxv/HF6uExqi1uChK9itXuHnwqBIFTnQ=; 
	b=DwATWz6XbKnDdUsZGv4bYCJHR4XF1ASAzD09iiE95Zcx7Pa/goSDvr49STgJZe6CYg5ZDjSnn2k2tCM3xPK9dbo72Acwl/EKzb656WmWvY11NWNlGHuaUfiw7cWu7vvrcp0xQL2F3+SxwlCG6/EAgz7aT+WLOLQVV9n+J25zwF8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757950976;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=6BRtmVLmOXJkxv/HF6uExqi1uChK9itXuHnwqBIFTnQ=;
	b=G5lh7bKNoE52U1QS7k9Xyn3grfZ9Z7zVyeGCqEATABk57u/Emwaoiax3hTBoZapV
	VQ7oDQIQqzk2qxbAnKkGkC9zscYAk4ba4HpbcLIW7Vr+84XbGCNUOd0IgirN27xfwvG
	2bFbZWPXBcHd8g1wslTdR5hB6vU1oHfeRjWcPw2Y=
Received: by mx.zohomail.com with SMTPS id 1757950974984537.1525815536428;
	Mon, 15 Sep 2025 08:42:54 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id DB5CE180BBB; Mon, 15 Sep 2025 17:42:51 +0200 (CEST)
Date: Mon, 15 Sep 2025 17:42:51 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Dzmitry Sankouski <dsankouski@gmail.com>, Lee Jones <lee@kernel.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/9] mfd: max77705: max77705_charger: move active
 discharge setting to mfd parent
Message-ID: <rwnwaen5hqoeieiubishsrzn3wnmhhpbaurx6oukos7ysjoppm@uh6m22r2cdps>
References: <20250911-max77705_77976_charger_improvement-v3-0-35203686fa29@gmail.com>
 <20250911-max77705_77976_charger_improvement-v3-1-35203686fa29@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fhdfxlzbrktlztwq"
Content-Disposition: inline
In-Reply-To: <20250911-max77705_77976_charger_improvement-v3-1-35203686fa29@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/257.946.47
X-ZohoMailClient: External


--fhdfxlzbrktlztwq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/9] mfd: max77705: max77705_charger: move active
 discharge setting to mfd parent
MIME-Version: 1.0

Hi,

On Thu, Sep 11, 2025 at 08:57:09PM +0300, Dzmitry Sankouski wrote:
> Active discharge setting is a part of MFD top level i2c device, hence
> cannot be controlled by charger. Writing to MAX77705_PMIC_REG_MAINCTRL1
> register from charger driver is a mistake.
>
> Move active discharge setting to MFD parent driver.

This is quite confusing to read without knowing the driver. I think
it's betterly described like this:

Active discharge setting is a part of MFD top level register range,
hence cannot be controlled by the charger regmap, which only offers
access to the charger registers.

Move active discharge setting to MFD parent driver to fix the issue.

>=20
> Fixes: a6a494c8e3ce ("power: supply: max77705: Add charger driver for Max=
im 77705")
>=20

No newline after Fixes:

> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
>  drivers/mfd/max77705.c                  | 3 +++
>  drivers/power/supply/max77705_charger.c | 3 ---
>  2 files changed, 3 insertions(+), 3 deletions(-)

I think it's sensible to use 'mfd: max77705:' prefix for this patch,
otherwise Lee easily misses that this patchset has anything to do
with his subsystem :)

Greetings,

-- Sebastian

>=20
> diff --git a/drivers/mfd/max77705.c b/drivers/mfd/max77705.c
> index 6b263bacb8c2..ff07d0e0d5f8 100644
> --- a/drivers/mfd/max77705.c
> +++ b/drivers/mfd/max77705.c
> @@ -108,6 +108,9 @@ static int max77705_i2c_probe(struct i2c_client *i2c)
>  	if (pmic_rev !=3D MAX77705_PASS3)
>  		return dev_err_probe(dev, -ENODEV, "Rev.0x%x is not tested\n", pmic_re=
v);
> =20
> +	/* Active Discharge Enable */
> +	regmap_update_bits(max77705->regmap, MAX77705_PMIC_REG_MAINCTRL1, 1, 1);
> +
>  	ret =3D devm_regmap_add_irq_chip(dev, max77705->regmap,
>  					i2c->irq,
>  					IRQF_ONESHOT | IRQF_SHARED, 0,
> diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supp=
ly/max77705_charger.c
> index 329b430d0e50..3b75c82b9b9e 100644
> --- a/drivers/power/supply/max77705_charger.c
> +++ b/drivers/power/supply/max77705_charger.c
> @@ -487,9 +487,6 @@ static void max77705_charger_initialize(struct max777=
05_charger_data *chg)
>  	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_00,
>  				MAX77705_WDTEN_MASK, 0);
> =20
> -	/* Active Discharge Enable */
> -	regmap_update_bits(regmap, MAX77705_PMIC_REG_MAINCTRL1, 1, 1);
> -
>  	/* VBYPSET=3D5.0V */
>  	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_11, MAX77705_VBYPSET_M=
ASK, 0);
> =20
>=20
> --=20
> 2.39.5
>=20

--fhdfxlzbrktlztwq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmjIM/sACgkQ2O7X88g7
+ppHsQ/9FojUVp2snsD2i8XTbcYL5TwesQH+bOry68s/8np3x/k8NM7X0I8mMW9H
wC906ggjHxB6O5Tbngy4XQTvqCWlOx1sNNPbZDUX9LVfsPFASOqI7IYzR4s1hspt
J/bUqL00UEQiA7l3/ELiKnUpyZoKC2mS+bBSz+1BrrbAbLc7+D2oMTBt9bL86j0r
StPOW8uSD9NfsGCJOfY2en8PWLwsLUB+tLGMd4lR9xPiWmKwI+1qcVHrGEYKXp0g
IgvaAM6HRagHt43DNloT25SP62942g1pcbUGaiGvlqfycBcpt3S5JeWkx3ztYMBs
n/pK9BUaC9EE3eAIjZYBer03CrVpXKOY+F1JxW9FekB8RvmJk14vVdOGNaj/GXuQ
pARnsM77iE7puSKZeeilCzsQi3YyCS8o9lSXIlkjfCI9Ai4QPMUhH3HHr0hYNyXR
Hx7X+eSAR2LjLfTyEn4PIVkn76JLwyVR9M/kAs3sOLjJA0YkjGJOCZ1Dk/bzyKLh
slS4xezw3/NJxgafll2HG4K3/sPYFyGbXFVUbG1jAGUPRCMrwUsgLD/VURXPNXcF
GZzE8rMr6o/yygTKJW94PALgfZqxgw+HFEM71TT9stFPUeMTEcNzd9MmElud/7+y
6e5jKy9PSzXnrewyXUKc0PEWukv41KP25LslQWY6mKrWSd2ixb8=
=s+tl
-----END PGP SIGNATURE-----

--fhdfxlzbrktlztwq--

