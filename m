Return-Path: <linux-pm+bounces-34682-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EF7B5810A
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 17:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B160E1886355
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 15:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE511A9FB3;
	Mon, 15 Sep 2025 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="GJaAWjR1"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C122EAE3;
	Mon, 15 Sep 2025 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950500; cv=pass; b=evjK8BfZsiQLi9Wmi+LwxGo4cDLc9vZjNRmjzMRtOzdlgGFmSdDqKp6u6bVuoiYwXhPDOF2K2TgMK6J0hZO5MIMq7IDPjrIWGd7B8V7bSUc8cgOc/3YmYbkk2KATvUiSyNcEfFBi8akMU/CgLnVFWvLXmIDZKjWS935bBoL8aIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950500; c=relaxed/simple;
	bh=cgAecMRjpTSxSn3yNjMeCa2GzgOYEGibL+uyNeB5Zv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHebVLGwSz2rHTYVJ2C4GdJe9C8VUKN9ZJg3RddVeli9qem+WiV9vLvXLaEXW8usGTkVfbJ6B3UMT01Q8iIxh6fef4XC90m0uKMK2TJUuUy/T+uB5WdXJ2H4S/u8SyZgzd1breiEvNucRyLrEfIUSQCq11g60Aj1Pc8JdN+ZNWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=GJaAWjR1; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757950488; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OUoSQM4WnzWnpLTwxfdqzR/QuErdUuszZkprlkiap5XPhIBrzvWMBfZlVahvM5fQCF6hA9ABUYBV68BitcfCgGMwAY8eQxM2II25/ZNvoXDjRYBiE0IANGIvVU0eb+9eGD/N/+oRfpaR/0g0LdQnhk/CwpQKGFAHi0FniJZ+Mkk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757950488; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DcxWG34AyR7+6Hj6I15XIb092Ch5rWpmIFhRMnldzuc=; 
	b=IXX4zwg6JrPO+1Ge6BHdwHAuZ2SYqMjYOcCJMtnImsdTmCJysVDj75b7bJF0FEKx9KaFWcdTzBtjO20NHCLgWUqE6C3tipEN7FTOp9jA6CMYAvotEhjMSEAx8E/L0DyYkwxhzXLF5zXBVKCeZl7HfrNcHbJXx+KOOjXdNc/1TQA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757950488;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=DcxWG34AyR7+6Hj6I15XIb092Ch5rWpmIFhRMnldzuc=;
	b=GJaAWjR1XM79goDqBMDjW0rf/Kh4SCMewiRSCOdtVsMaG6uvD+LSeSqt1l4DUe6r
	U1ex4YQVaUbXTYqocSJ5fKq5s5PCJBXBcSknfZOQsytbI58YrE6oDSX7Vrwic3/dxHb
	TuZ32XLM+K7YG6cUo2rrOC8nnkzDZD7al+C65GtQ=
Received: by mx.zohomail.com with SMTPS id 1757950486290239.887179332684;
	Mon, 15 Sep 2025 08:34:46 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 0B0FB180BBB; Mon, 15 Sep 2025 17:34:43 +0200 (CEST)
Date: Mon, 15 Sep 2025 17:34:42 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 6/9] power: supply: max77705_charger: rework interrupts
Message-ID: <agaalpr6eo6we4yxdgdxccyjuw2zdl5qo5gqs7u3cqx73x73s3@a4hgn7pubon2>
References: <20250911-max77705_77976_charger_improvement-v3-0-35203686fa29@gmail.com>
 <20250911-max77705_77976_charger_improvement-v3-6-35203686fa29@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4ka7lzbuctyagj4n"
Content-Disposition: inline
In-Reply-To: <20250911-max77705_77976_charger_improvement-v3-6-35203686fa29@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/257.892.47
X-ZohoMailClient: External


--4ka7lzbuctyagj4n
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 6/9] power: supply: max77705_charger: rework interrupts
MIME-Version: 1.0

Hi,

On Thu, Sep 11, 2025 at 08:57:14PM +0300, Dzmitry Sankouski wrote:
> Current implementation uses handle_post_irq to actually handle chgin
> irq. This is not how things are meant to work in regmap-irq.
>=20
> Remove handle_post_irq, and request a threaded interrupt for chgin.
>=20
> Fixes: a6a494c8e3ce ("power: supply: max77705: Add charger driver for Max=
im 77705")
>=20

There shouldn't be a newline between Fixes and SoB line.

> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
> Changes to v3:
> - move irq initialization after workqueue and charger initialization
> ---
>  drivers/power/supply/max77705_charger.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supp=
ly/max77705_charger.c
> index d6a3cd98c898..5f831c25b150 100644
> --- a/drivers/power/supply/max77705_charger.c
> +++ b/drivers/power/supply/max77705_charger.c
> @@ -40,13 +40,13 @@ static enum power_supply_property max77705_charger_pr=
ops[] =3D {
>  	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
>  };
> =20
> -static int max77705_chgin_irq(void *irq_drv_data)
> +static irqreturn_t max77705_chgin_irq(int irq, void *irq_drv_data)
>  {
>  	struct max77705_charger_data *chg =3D irq_drv_data;
> =20
>  	queue_work(chg->wqueue, &chg->chgin_work);
> =20
> -	return 0;
> +	return IRQ_HANDLED;
>  }
> =20
>  static const struct regmap_irq max77705_charger_irqs[] =3D {
> @@ -64,7 +64,6 @@ static struct regmap_irq_chip max77705_charger_irq_chip=
 =3D {
>  	.name			=3D "max77705-charger",
>  	.status_base		=3D MAX77705_CHG_REG_INT,
>  	.mask_base		=3D MAX77705_CHG_REG_INT_MASK,
> -	.handle_post_irq	=3D max77705_chgin_irq,
>  	.num_regs		=3D 1,
>  	.irqs			=3D max77705_charger_irqs,
>  	.num_irqs		=3D ARRAY_SIZE(max77705_charger_irqs),
> @@ -593,12 +592,6 @@ static int max77705_charger_probe(struct i2c_client =
*i2c)
>  					     "cannot allocate regmap field\n");
>  	}
> =20
> -	ret =3D regmap_update_bits(chg->regmap,
> -				MAX77705_CHG_REG_INT_MASK,
> -				MAX77705_CHGIN_IM, 0);
> -	if (ret)
> -		return ret;
> -
>  	pscfg.fwnode =3D dev_fwnode(dev);
>  	pscfg.drv_data =3D chg;
> =20
> @@ -630,6 +623,15 @@ static int max77705_charger_probe(struct i2c_client =
*i2c)
>  		goto destroy_wq;
>  	}
> =20
> +	ret =3D devm_request_threaded_irq(dev, regmap_irq_get_virq(irq_data, MA=
X77705_CHGIN_I),
> +				 NULL, max77705_chgin_irq,
> +				 IRQF_TRIGGER_HIGH,

I guess IRQF_TRIGGER_NONE considering this is not a physical IRQ?

> +	"chgin-irq", chg);

wrong indent

> +	if (ret) {
> +		pr_err("%s: Failed to Request IRQ (%d)\n", __func__, ret);

dev_err_probe() and no need to print __func__, see how it works in
other drivers.

Greetings,

-- Sebastian

> +		goto destroy_wq;
> +	}
> +
>  	ret =3D max77705_charger_enable(chg);
>  	if (ret) {
>  		dev_err_probe(dev, ret, "failed to enable charge\n");
>=20
> --=20
> 2.39.5
>=20

--4ka7lzbuctyagj4n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmjIMhIACgkQ2O7X88g7
+pqCZQ/9GbV7pZUKKVBBqBy5Vwe+Aw9fMTLztdmRhOlamrsps/yrWhUhmMkaThzB
zH7zLmNMxjwkHEawHHRuHggdG+iT3LYtjuSCr4wHXwVeBpkVP6l6wp62JlIEeLGJ
IFQK7+F3dZ3frePtg7+HFXdWV4vC+o3quqHG6DNRrULze6qBAnol+74RKVfpxgbk
nkZZVJKWOWyZCrb8R/MsnqnsrxJ0BTvvr0vu4C0XllTcJ67vinyWYS8g4NAweQFO
1AkO7nB3k67B6e/WkINrJwQ8cwhLJZC/bx4IVWHdDv4v4E/3QTTaCJzA9Szqtrac
tceNrQNPHV8rj7oJ8Le5CIWQYGMLLts70s3BNyox7RHLFEYTBFw5tpmqV3o9b8Fh
NdfRKgQiEWAigNgZVikTRB3SrJw81w+qSZAN+fHg1q/BQ+r39siVtTkajBY0sKPf
fXOzn41B4MWu2woH6BWovdTYBzAefrd9xTbf1k7H5fFcRXWJx2lbVkkm1FMH6Vva
0e8cl+pQvievyTIsUPEbxQVuSkDxOvQxKYqPACTEjoRL3HFchXuwXIAZT8/i4yBT
gguOatpjnNpTYO+yrD9aJhJa0r0tgYk3So1mz6mTrnst+9HSfoNGuetps2QpVC8K
aI55McGrUB5h5aQp+u4mh4gT6iEFGJ6H1YvxScxTKkhkVFX6da0=
=fHuH
-----END PGP SIGNATURE-----

--4ka7lzbuctyagj4n--

