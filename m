Return-Path: <linux-pm+bounces-30595-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F36B005D7
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 16:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85E4516B37B
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 14:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A80273D8E;
	Thu, 10 Jul 2025 14:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="uhPFOwbe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch [109.224.244.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5226478C91;
	Thu, 10 Jul 2025 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752159286; cv=none; b=ajHgu47SJ0PDQjQ/Huri/MGwYya8Bzg6SVdAdmM6cWJdXmiq4dDqtIoAwYrk4RlIGN1dA3CaTGcIE37+zKhnuGQPrHbaTmlYYiIq8R0WgS8J9zyWPpkJb75vNuYAm7ABDU9LBIs9RepNjiT7Fel0CIgW8KJdyaocl+1ibXSnA+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752159286; c=relaxed/simple;
	bh=/BZeJ9skQYgL/W2BpgbCzGkjhkKi61qTc1GVie0Bgso=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FVq2hunHNW/lPZkOdCqYdym2izDpC5mvXC6a7GbXXXAg5nyuyoG8bP2tBqo1bnP6pCgPpaayDPowOykKEqsqmUFTREcb45gvQ3CQom8k91S7z+5DjtFny5M3ds+shKtxWzwjSHBYbZLgwcjRFfViqU0b5AJ74DZ4y6DCJnrB/sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=uhPFOwbe; arc=none smtp.client-ip=109.224.244.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1752159281; x=1752418481;
	bh=8hCoJT7oSQ2+hO4Crxb7/QCTsLK+i6Ix8pOcE1yioP0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=uhPFOwbeICsKGailuEYBwH6LRdeKbV8Yd2OFHcUz01WN1lgd/jdyXl6/fF4cXEJ5e
	 PY6+i9bfZ7M2R9ILo6ZO3dlftaltWKXJTKrOC8Upt0TYKs6vzvSk6pa0AM1Rnpni3G
	 /9+yFMFK+B4lb9THN2oRSu6ilVfqjYvG3HXJzfTfY8TUMcEScLh1w8Qd61MSifgdF9
	 yG0NxcHvZ43k/qjgsgd6szdh2tlIDC+sKrBihRCzit57fep6ItGp3zx5Izh7GExYKe
	 VrmgdXL81sMQ++NOnsNHWJUnb5lEqlPjtZoOwW6HxtERdXRbpNTdegSrWdnz6XWfj8
	 FE780GM89Jdqw==
Date: Thu, 10 Jul 2025 14:54:38 +0000
To: samuel.kayode@savoirfairelinux.com
From: Sean Nyekjaer <sean@geanix.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Frank Li <Frank.li@nxp.com>, imx@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>, Abel Vesa <abelvesa@linux.com>, Robin Gong <b38343@freescale.com>, Robin Gong <yibin.gong@nxp.com>, Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v8 2/6] mfd: pf1550: add core driver
Message-ID: <idqtxdptxq6s57r452staq3xv6zzs3i5bbapzxdlu3o7cdahaq@j257j4okrw52>
In-Reply-To: <20250707-pf1550-v8-2-6b6eb67c03a0@savoirfairelinux.com>
References: <20250707-pf1550-v8-0-6b6eb67c03a0@savoirfairelinux.com> <20250707-pf1550-v8-2-6b6eb67c03a0@savoirfairelinux.com>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: 3c444e4d1f4130e043ffc827ffec8747504ef419
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Mon, Jul 07, 2025 at 05:37:21PM +0100, Samuel Kayode via B4 Relay wrote:
> From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
>=20
> Add the core driver for pf1550 PMIC. There are 3 subdevices for which the
> drivers will be added in subsequent patches.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> ---

[...]

> +
> +static int pf1550_i2c_probe(struct i2c_client *i2c)
> +{
> +=09const struct mfd_cell *regulator =3D &pf1550_regulator_cell;
> +=09const struct mfd_cell *charger =3D &pf1550_charger_cell;
> +=09const struct mfd_cell *onkey =3D &pf1550_onkey_cell;
> +=09unsigned int reg_data =3D 0, otp_data =3D 0;
> +=09struct pf1550_ddata *pf1550;
> +=09struct irq_domain *domain;
> +=09int irq, ret =3D 0;
> +
> +=09pf1550 =3D devm_kzalloc(&i2c->dev, sizeof(*pf1550), GFP_KERNEL);
> +=09if (!pf1550)
> +=09=09return -ENOMEM;
> +
> +=09i2c_set_clientdata(i2c, pf1550);
> +=09pf1550->dev =3D &i2c->dev;
> +=09pf1550->irq =3D i2c->irq;
> +
> +=09pf1550->regmap =3D devm_regmap_init_i2c(i2c, &pf1550_regmap_config);
> +=09if (IS_ERR(pf1550->regmap))
> +=09=09return dev_err_probe(pf1550->dev, PTR_ERR(pf1550->regmap),
> +=09=09=09=09     "failed to allocate register map\n");
> +
> +=09ret =3D regmap_read(pf1550->regmap, PF1550_PMIC_REG_DEVICE_ID, &reg_d=
ata);
> +=09if (ret < 0)
> +=09=09return dev_err_probe(pf1550->dev, ret, "cannot read chip ID\n");
> +=09if (reg_data !=3D PF1550_DEVICE_ID)
> +=09=09return dev_err_probe(pf1550->dev, -ENODEV,
> +=09=09=09=09     "invalid device ID: 0x%02x\n", reg_data);
> +
> +=09/* Regulator DVS */
> +=09ret =3D pf1550_read_otp(pf1550, PF1550_OTP_SW2_SW3, &otp_data);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09/* When clear, DVS should be enabled */
> +=09if (!(otp_data & OTP_DVS_ENB))
> +=09=09pf1550->dvs_enb =3D true;
> +

Thanks for upstreaming this :)

We need to handle DVS for SW1 here.
I'm using the A6 variant that have DVS enabled for SW1 and disabled for
SW2.
The A1 variant have DVS for SW1 disabled...

/Sean


