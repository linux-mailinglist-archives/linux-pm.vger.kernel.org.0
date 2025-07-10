Return-Path: <linux-pm+bounces-30626-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F259B0099A
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 19:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7EA11C87069
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 17:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AF22F0C67;
	Thu, 10 Jul 2025 17:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="h0OjEWzk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-10624.protonmail.ch (mail-10624.protonmail.ch [79.135.106.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45F02F0C5A;
	Thu, 10 Jul 2025 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752167485; cv=none; b=uQPt3HNl3RkyEqpEnZiWBwaIPEDmP0O4YGDgUy2xjEh0z/XZYNSYXvMpUP8mSD5HMA4Ddha1H1EZKVRHmpZ1IBzaZSsW35uhLIJBDHo6bQGePDw06MaboRQ7spZVRwJOd+58YkaRE0f3Js/E0S+NDPsyPfXoIrT+2mh+RLXRKJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752167485; c=relaxed/simple;
	bh=KC+uynFzwD7E66DfW7+QvoCO2cFn/w2RVZc8ARgHTTo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZMT/Oj5mL/S0pn6FeOOSKXsRpn6fNdGV7sdnW3hDzxY+WVWY0F3YRA8gT5v2Ff/s9s2uA6HAtKgI5JliNexAwIKvQiiici3MuJ/cDgbYsgCx5mdxgjpGwYYwx8f6ZQBe4b0S/HJggwg927sxhtt9NIz1+gbQIj/1RltugxFRic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=h0OjEWzk; arc=none smtp.client-ip=79.135.106.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1752167480; x=1752426680;
	bh=E3tfQJRcOopnIqJ3Jo5gBmBA1CzTx3UtERcWnXjAcrg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=h0OjEWzk3ERiqhMXAxEE+2a8BRO5TvP0u6z2I3SdnLjbAonVm+fWllaNn9HicrLy3
	 h7iIIbAmw9at7p5E6HmRBDReWRz2AwaYqaMi8sBoU7mkpaFlJUu6WuOfLN8uu/Eiwx
	 qSaKY2KLwMlDz9jKZFbteayPHn3c19gSu05B90tIooRgqMpygxe/ip1SeDEYS2urOr
	 9iv5MBeUMr8h8qJfUGwqKTbKqtJU3PPY1CQZ0rVqnNsYPjaeXBQNkhYm11lSYD4JI9
	 b6gnzCfbMB/Mn+N5pUGNkKrxqrY0dV/7ROMDmy2nVSUNukHRr6c3ZN08aTB3fxi9qZ
	 1jluJkNRkpoLA==
Date: Thu, 10 Jul 2025 17:11:14 +0000
To: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
From: Sean Nyekjaer <sean@geanix.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Frank Li <Frank.li@nxp.com>, imx@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>, Abel Vesa <abelvesa@linux.com>, Robin Gong <b38343@freescale.com>, Robin Gong <yibin.gong@nxp.com>, Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v8 3/6] regulator: pf1550: add support for regulator
Message-ID: <ff3c3r336qgnlwfheelm6hjypnkjhw3txmeztv7mz2y6xdoxld@ecgifcvuihr3>
In-Reply-To: <aG_x8VELlUvLxezY@fedora>
References: <20250707-pf1550-v8-0-6b6eb67c03a0@savoirfairelinux.com> <20250707-pf1550-v8-3-6b6eb67c03a0@savoirfairelinux.com> <ni3bmj4ye3dp3opolk466r2ayx7iuk6hhyx4pdikydizqykfx7@nc5qdok32hsm> <aG_x8VELlUvLxezY@fedora>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: 95574d42e814086a6ca3db29868a1238c79f64ec
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 01:01:37PM +0100, Samuel Kayode wrote:
> On Thu, Jul 10, 2025 at 02:49:21PM +0000, Sean Nyekjaer wrote:
> > > +#define PF_SW1(_chip, match, _name, mask, voltages)=09{=09\
> > > +=09.desc =3D {=09\
> > > +=09=09.name =3D #_name,=09\
> > > +=09=09.of_match =3D of_match_ptr(match),=09\
> > > +=09=09.regulators_node =3D of_match_ptr("regulators"),=09\
> > > +=09=09.n_voltages =3D ARRAY_SIZE(voltages),=09\
> > > +=09=09.ops =3D &pf1550_sw1_ops,=09\
> > > +=09=09.type =3D REGULATOR_VOLTAGE,=09\
> > > +=09=09.id =3D _chip ## _ ## _name,=09\
> > > +=09=09.owner =3D THIS_MODULE,=09\
> > > +=09=09.volt_table =3D voltages,=09\
> > > +=09=09.vsel_reg =3D _chip ## _PMIC_REG_ ## _name ## _VOLT, \
> > > +=09=09.vsel_mask =3D (mask),=09\
> > > +=09},=09\
> > > +=09.stby_reg =3D _chip ## _PMIC_REG_ ## _name ## _STBY_VOLT,=09\
> > > +=09.stby_mask =3D (mask),=09\
> > > +}
> >
> > This is unused.
> >
> If checking of the DVS status for the SW1 regulator is added as you reque=
sted.
> This would prove beneficial because it is the preferred method when DVS i=
s
> disabled for the SW1. This is the case for the default variant, A1, of th=
e
> PMIC.
> > > +
> > > +#define PF_SW3(_chip, match, _name, min, max, mask, step)=09{=09\
> >
> > [...]
> >
> > > +
> > > +static struct pf1550_desc pf1550_regulators[] =3D {
> > > +=09PF_SW3(PF1550, "sw1", SW1, 600000, 1387500, 0x3f, 12500),
> > > +=09PF_SW3(PF1550, "sw2", SW2, 600000, 1387500, 0x3f, 12500),
> > > +=09PF_SW3(PF1550, "sw3", SW3, 1800000, 3300000, 0xf, 100000),
> >
> > Seems weird they all use the PF_SW3 macro.
> >
> The PF_SW3 macro is very generic. It is the preferred macro when a step h=
as to
> be provided which is the case for SW1 & SW2 with DVS enabled. The default
> variant, A1, has SW2 enabled.
> > > +=09PF_VREF(PF1550, "vrefddr", VREFDDR, 1200000),
> > > +=09PF_LDO1(PF1550, "ldo1", LDO1, 0x1f, pf1550_ldo13_volts),
> > > +=09PF_LDO2(PF1550, "ldo2", LDO2, 0xf, 1800000, 3300000, 100000),
> > > +=09PF_LDO1(PF1550, "ldo3", LDO3, 0x1f, pf1550_ldo13_volts),
> > > +};
> > > +
> >
> > [...]
> >
> > > +
> > > +static int pf1550_regulator_probe(struct platform_device *pdev)
> > > +{
> > > +=09const struct pf1550_ddata *pf1550 =3D dev_get_drvdata(pdev->dev.p=
arent);
> > > +=09struct regulator_config config =3D { };
> > > +=09struct pf1550_regulator_info *info;
> > > +=09int i, irq =3D -1, ret =3D 0;
> > > +
> > > +=09info =3D devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
> > > +=09if (!info)
> > > +=09=09return -ENOMEM;
> > > +
> > > +=09config.regmap =3D dev_get_regmap(pf1550->dev, NULL);
> > > +=09if (!config.regmap)
> > > +=09=09return dev_err_probe(&pdev->dev, -ENODEV,
> > > +=09=09=09=09     "failed to get parent regmap\n");
> > > +
> > > +=09config.dev =3D pf1550->dev;
> > > +=09config.regmap =3D pf1550->regmap;
> > > +=09info->dev =3D &pdev->dev;
> > > +=09info->pf1550 =3D pf1550;
> > > +
> > > +=09memcpy(info->regulator_descs, pf1550_regulators,
> > > +=09       sizeof(info->regulator_descs));
> > > +
> > > +=09for (i =3D 0; i < ARRAY_SIZE(pf1550_regulators); i++) {
> > > +=09=09struct regulator_desc *desc;
> > > +
> > > +=09=09desc =3D &info->regulator_descs[i].desc;
> > > +
> > > +=09=09if (desc->id =3D=3D PF1550_SW2 && pf1550->dvs_enb) {
> >
> > We should enter here if dvs_enb =3D=3D false.
> > My A6 variant reported 0.625V instead of the correct 1.35V
> >
> Yeah, that would happen with the current if statement.
>=20
> Since dvs_enb is true when DVS is enabled (OTP_SW2_DVS_ENB =3D=3D 0), I s=
hould
> modify the if statment to:
> (desc->id =3D=3D PF1550_SW2 && !pf1550->dvs_enb) /* OTP_SW2_DVS_ENB =3D=
=3D 1 */

-=09=09if (desc->id =3D=3D PF1550_SW2 && pf1550->dvs_enb) {
+=09=09if (desc->id =3D=3D PF1550_SW2 && !pf1550->dvs_enb) {

Yes that's what I have been running my tests with :)

I will continue with testing the onkey and battery charger

>=20
> I think that would be a more readable solution.
> > > +=09=09=09/* OTP_SW2_DVS_ENB =3D=3D 1? */
> > > +=09=09=09desc->volt_table =3D pf1550_sw12_volts;
> > > +=09=09=09desc->n_voltages =3D ARRAY_SIZE(pf1550_sw12_volts);
> > > +=09=09=09desc->ops =3D &pf1550_sw1_ops;
> > > +=09=09}
> > >
>=20
> Thanks,
> Sam

/Sean


