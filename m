Return-Path: <linux-pm+bounces-30594-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32963B005C0
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 16:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7959480715
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 14:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A895C274FCF;
	Thu, 10 Jul 2025 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="lT5EKIeC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C349B2749C7;
	Thu, 10 Jul 2025 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752158973; cv=none; b=qXwCA1ANBzEvchPCVSMnvIbhGuMQfEQqv3+ReiHzG7u86I3D9ZavALh0RyRoRdSb7d/lgkhPuoMW/oeAqhvF3+cAwxoki/ZjGW8ja7xLMH803++dGUAhoOeSqlPHaHAkkQGgIaaBdYgbr3ZHU7lSVvfcVolAoIHWHMvS3SgvMO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752158973; c=relaxed/simple;
	bh=isscTgcBZAVVEBwnse1MUKIvJL0xJ/IuXJKT2AqzWlQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TEMfuLF9QqNGYrGU3oilGmRQAX9q1e0iLoXItzOG+zz9nSI9PqKYmULvQIRr9GM9fxZnw7VeiLKFbhzNo3aP22JWGINelCKGn1CdoEAcOV5bg5X5TXA7U7x3gNHzMjpkNFxIzi0fX11zSdV5Dxt70FyHzI8knoC5fOIhUgiNOCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=lT5EKIeC; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1752158968; x=1752418168;
	bh=5I8flEWvmqDd6x+t/g5P7dZT4ROh7WF5XE11abOETzc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=lT5EKIeCBMtt/STEPtaaBBeEB1Ix3xKS6p/qK1e+XbiIrgZ+30aQ1UfrdWVs2hf/l
	 MiaUkMt3xSoq3Iyi5qDZPu+IQxVHCbmG/SwaFRvbem0dTi8vN6c7YOXJMzsZBJAFUu
	 +MUolG1J5OoHT0ShW5AJHttVv46gKg8OYpb4MLnOpXbqX6ebq9NR6/ChE2nSC9GRoC
	 /cD/5toabjPu34pjkG3hIEcRwdk77h+Cmg8N8O9GFVo05Czdq5a/icKUNTBtRV65Nh
	 d3Sd9SdU9gUe/+Z7jR0Hp7Ra5rVKGBofrOF+Eog9zu6OoKT6RTJn9G9rd7ATftnP1W
	 V3TLsRm8mUyug==
Date: Thu, 10 Jul 2025 14:49:21 +0000
To: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
From: Sean Nyekjaer <sean@geanix.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Frank Li <Frank.li@nxp.com>, imx@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>, Abel Vesa <abelvesa@linux.com>, Robin Gong <b38343@freescale.com>, Robin Gong <yibin.gong@nxp.com>, Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v8 3/6] regulator: pf1550: add support for regulator
Message-ID: <ni3bmj4ye3dp3opolk466r2ayx7iuk6hhyx4pdikydizqykfx7@nc5qdok32hsm>
In-Reply-To: <20250707-pf1550-v8-3-6b6eb67c03a0@savoirfairelinux.com>
References: <20250707-pf1550-v8-0-6b6eb67c03a0@savoirfairelinux.com> <20250707-pf1550-v8-3-6b6eb67c03a0@savoirfairelinux.com>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: 11f257d26d96d1d079ba2b2c2800d3b5475e57b2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Mon, Jul 07, 2025 at 05:37:22PM +0100, Samuel Kayode wrote:
> Add regulator support for the pf1550 PMIC.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>

[...]

> diff --git a/drivers/regulator/pf1550-regulator.c b/drivers/regulator/pf1=
550-regulator.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..fa8c4b17270e750e64fef9107=
4727951511d14f3
> --- /dev/null
> +++ b/drivers/regulator/pf1550-regulator.c

[...]

> +
> +#define PF_SW1(_chip, match, _name, mask, voltages)=09{=09\
> +=09.desc =3D {=09\
> +=09=09.name =3D #_name,=09\
> +=09=09.of_match =3D of_match_ptr(match),=09\
> +=09=09.regulators_node =3D of_match_ptr("regulators"),=09\
> +=09=09.n_voltages =3D ARRAY_SIZE(voltages),=09\
> +=09=09.ops =3D &pf1550_sw1_ops,=09\
> +=09=09.type =3D REGULATOR_VOLTAGE,=09\
> +=09=09.id =3D _chip ## _ ## _name,=09\
> +=09=09.owner =3D THIS_MODULE,=09\
> +=09=09.volt_table =3D voltages,=09\
> +=09=09.vsel_reg =3D _chip ## _PMIC_REG_ ## _name ## _VOLT, \
> +=09=09.vsel_mask =3D (mask),=09\
> +=09},=09\
> +=09.stby_reg =3D _chip ## _PMIC_REG_ ## _name ## _STBY_VOLT,=09\
> +=09.stby_mask =3D (mask),=09\
> +}

This is unused.

> +
> +#define PF_SW3(_chip, match, _name, min, max, mask, step)=09{=09\

[...]

> +
> +static struct pf1550_desc pf1550_regulators[] =3D {
> +=09PF_SW3(PF1550, "sw1", SW1, 600000, 1387500, 0x3f, 12500),
> +=09PF_SW3(PF1550, "sw2", SW2, 600000, 1387500, 0x3f, 12500),
> +=09PF_SW3(PF1550, "sw3", SW3, 1800000, 3300000, 0xf, 100000),

Seems weird they all use the PF_SW3 macro.

> +=09PF_VREF(PF1550, "vrefddr", VREFDDR, 1200000),
> +=09PF_LDO1(PF1550, "ldo1", LDO1, 0x1f, pf1550_ldo13_volts),
> +=09PF_LDO2(PF1550, "ldo2", LDO2, 0xf, 1800000, 3300000, 100000),
> +=09PF_LDO1(PF1550, "ldo3", LDO3, 0x1f, pf1550_ldo13_volts),
> +};
> +

[...]

> +
> +static int pf1550_regulator_probe(struct platform_device *pdev)
> +{
> +=09const struct pf1550_ddata *pf1550 =3D dev_get_drvdata(pdev->dev.paren=
t);
> +=09struct regulator_config config =3D { };
> +=09struct pf1550_regulator_info *info;
> +=09int i, irq =3D -1, ret =3D 0;
> +
> +=09info =3D devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
> +=09if (!info)
> +=09=09return -ENOMEM;
> +
> +=09config.regmap =3D dev_get_regmap(pf1550->dev, NULL);
> +=09if (!config.regmap)
> +=09=09return dev_err_probe(&pdev->dev, -ENODEV,
> +=09=09=09=09     "failed to get parent regmap\n");
> +
> +=09config.dev =3D pf1550->dev;
> +=09config.regmap =3D pf1550->regmap;
> +=09info->dev =3D &pdev->dev;
> +=09info->pf1550 =3D pf1550;
> +
> +=09memcpy(info->regulator_descs, pf1550_regulators,
> +=09       sizeof(info->regulator_descs));
> +
> +=09for (i =3D 0; i < ARRAY_SIZE(pf1550_regulators); i++) {
> +=09=09struct regulator_desc *desc;
> +
> +=09=09desc =3D &info->regulator_descs[i].desc;
> +
> +=09=09if (desc->id =3D=3D PF1550_SW2 && pf1550->dvs_enb) {

We should enter here if dvs_enb =3D=3D false.
My A6 variant reported 0.625V instead of the correct 1.35V

> +=09=09=09/* OTP_SW2_DVS_ENB =3D=3D 1? */
> +=09=09=09desc->volt_table =3D pf1550_sw12_volts;
> +=09=09=09desc->n_voltages =3D ARRAY_SIZE(pf1550_sw12_volts);
> +=09=09=09desc->ops =3D &pf1550_sw1_ops;
> +=09=09}
>

/Sean


