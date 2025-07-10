Return-Path: <linux-pm+bounces-30623-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC848B00972
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 19:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AB331680F5
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 17:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A062EFDB6;
	Thu, 10 Jul 2025 17:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="oQDLnUo2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DF642A9D;
	Thu, 10 Jul 2025 17:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166903; cv=none; b=XAxb7uPTtrhpVj/MznDH65qFtR8PpcGLagSQdHB8wv3St4SKnlEBFS9fkUe8HpRRq+qoRdbhcXLKS15Cw8F/J17B/VAqjO/lK91uea7xGZmrOdB9FfGIRTgK/7rUHvyKfWYJku5YpQ8+TCLRE+gY6BK76lhvHJdSjsTD5B6AixM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166903; c=relaxed/simple;
	bh=QSzDAxfN4sppY+oXqLp+S3cjY5KSRmdh52uliVq4nZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKAx2LKBpvAULhGXqFhlJzKv7pOiMlVamxKsW226SWT8tg0MrK719pQkAUdJvdpmJLNzu4QRpnHl8dIK6/cyF4ib6IjBgX8u9iWlhwC1/rCNOUuLUg0ttNhRO2RJBMggQDfUWfx3VfPSGmaYf8FexTNhq64sBIh/RUdBzIaS/Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=oQDLnUo2; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id BDE7C3D84E48;
	Thu, 10 Jul 2025 13:01:39 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id TygYQdipvOq3; Thu, 10 Jul 2025 13:01:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 037013D8E983;
	Thu, 10 Jul 2025 13:01:39 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 037013D8E983
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1752166899; bh=hqZi4qDDb5Krwc362RQG8hRtm8pWkvSstpAwC6iu2Q4=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=oQDLnUo21iaviaOCbPhg9A0kthbm1iljyw+x9vWRaVJ2aCcG3GR5eO03FUYLz2eSu
	 w3cc6Vi0eVFBeyP5ZLm1Y8OHyhjWAVQPgHIZ1khOgD+6JELcvW5O/yubwNGgJpDz/r
	 rxJJvR0dIfeKx6XBLmvKot1TKXwprn0IaAiIN6jEHIl5jbvRWEiqgK0D8Ui99hghZI
	 kPXEdUY+aWnkzgB4/+ap6m0nrBF69lO/ALO/BhbejvWC0oVxPY5DfiNqTtrmWt6tGl
	 EkkMWzNOgdvkRWrk0vwSCxU9P+EYcvqkz5JimrfrfQBnzqfAgyyfF8AGHY/TCm/wwd
	 CpGabtHMq2HkA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id bAcRyZFUQaQ6; Thu, 10 Jul 2025 13:01:38 -0400 (EDT)
Received: from fedora (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 9D14A3D84E48;
	Thu, 10 Jul 2025 13:01:38 -0400 (EDT)
Date: Thu, 10 Jul 2025 13:01:37 -0400
From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, Frank Li <Frank.li@nxp.com>,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>,
	Abel Vesa <abelvesa@linux.com>, Robin Gong <b38343@freescale.com>,
	Robin Gong <yibin.gong@nxp.com>,
	Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v8 3/6] regulator: pf1550: add support for regulator
Message-ID: <aG_x8VELlUvLxezY@fedora>
References: <20250707-pf1550-v8-0-6b6eb67c03a0@savoirfairelinux.com>
 <20250707-pf1550-v8-3-6b6eb67c03a0@savoirfairelinux.com>
 <ni3bmj4ye3dp3opolk466r2ayx7iuk6hhyx4pdikydizqykfx7@nc5qdok32hsm>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ni3bmj4ye3dp3opolk466r2ayx7iuk6hhyx4pdikydizqykfx7@nc5qdok32hsm>

On Thu, Jul 10, 2025 at 02:49:21PM +0000, Sean Nyekjaer wrote:
> > +#define PF_SW1(_chip, match, _name, mask, voltages)	{	\
> > +	.desc = {	\
> > +		.name = #_name,	\
> > +		.of_match = of_match_ptr(match),	\
> > +		.regulators_node = of_match_ptr("regulators"),	\
> > +		.n_voltages = ARRAY_SIZE(voltages),	\
> > +		.ops = &pf1550_sw1_ops,	\
> > +		.type = REGULATOR_VOLTAGE,	\
> > +		.id = _chip ## _ ## _name,	\
> > +		.owner = THIS_MODULE,	\
> > +		.volt_table = voltages,	\
> > +		.vsel_reg = _chip ## _PMIC_REG_ ## _name ## _VOLT, \
> > +		.vsel_mask = (mask),	\
> > +	},	\
> > +	.stby_reg = _chip ## _PMIC_REG_ ## _name ## _STBY_VOLT,	\
> > +	.stby_mask = (mask),	\
> > +}
> 
> This is unused.
>
If checking of the DVS status for the SW1 regulator is added as you requested.
This would prove beneficial because it is the preferred method when DVS is
disabled for the SW1. This is the case for the default variant, A1, of the
PMIC.
> > +
> > +#define PF_SW3(_chip, match, _name, min, max, mask, step)	{	\
> 
> [...]
> 
> > +
> > +static struct pf1550_desc pf1550_regulators[] = {
> > +	PF_SW3(PF1550, "sw1", SW1, 600000, 1387500, 0x3f, 12500),
> > +	PF_SW3(PF1550, "sw2", SW2, 600000, 1387500, 0x3f, 12500),
> > +	PF_SW3(PF1550, "sw3", SW3, 1800000, 3300000, 0xf, 100000),
> 
> Seems weird they all use the PF_SW3 macro.
> 
The PF_SW3 macro is very generic. It is the preferred macro when a step has to
be provided which is the case for SW1 & SW2 with DVS enabled. The default
variant, A1, has SW2 enabled.
> > +	PF_VREF(PF1550, "vrefddr", VREFDDR, 1200000),
> > +	PF_LDO1(PF1550, "ldo1", LDO1, 0x1f, pf1550_ldo13_volts),
> > +	PF_LDO2(PF1550, "ldo2", LDO2, 0xf, 1800000, 3300000, 100000),
> > +	PF_LDO1(PF1550, "ldo3", LDO3, 0x1f, pf1550_ldo13_volts),
> > +};
> > +
> 
> [...]
> 
> > +
> > +static int pf1550_regulator_probe(struct platform_device *pdev)
> > +{
> > +	const struct pf1550_ddata *pf1550 = dev_get_drvdata(pdev->dev.parent);
> > +	struct regulator_config config = { };
> > +	struct pf1550_regulator_info *info;
> > +	int i, irq = -1, ret = 0;
> > +
> > +	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
> > +	if (!info)
> > +		return -ENOMEM;
> > +
> > +	config.regmap = dev_get_regmap(pf1550->dev, NULL);
> > +	if (!config.regmap)
> > +		return dev_err_probe(&pdev->dev, -ENODEV,
> > +				     "failed to get parent regmap\n");
> > +
> > +	config.dev = pf1550->dev;
> > +	config.regmap = pf1550->regmap;
> > +	info->dev = &pdev->dev;
> > +	info->pf1550 = pf1550;
> > +
> > +	memcpy(info->regulator_descs, pf1550_regulators,
> > +	       sizeof(info->regulator_descs));
> > +
> > +	for (i = 0; i < ARRAY_SIZE(pf1550_regulators); i++) {
> > +		struct regulator_desc *desc;
> > +
> > +		desc = &info->regulator_descs[i].desc;
> > +
> > +		if (desc->id == PF1550_SW2 && pf1550->dvs_enb) {
> 
> We should enter here if dvs_enb == false.
> My A6 variant reported 0.625V instead of the correct 1.35V
> 
Yeah, that would happen with the current if statement.

Since dvs_enb is true when DVS is enabled (OTP_SW2_DVS_ENB == 0), I should
modify the if statment to:
(desc->id == PF1550_SW2 && !pf1550->dvs_enb) /* OTP_SW2_DVS_ENB == 1 */

I think that would be a more readable solution.
> > +			/* OTP_SW2_DVS_ENB == 1? */
> > +			desc->volt_table = pf1550_sw12_volts;
> > +			desc->n_voltages = ARRAY_SIZE(pf1550_sw12_volts);
> > +			desc->ops = &pf1550_sw1_ops;
> > +		}
> >

Thanks,
Sam

