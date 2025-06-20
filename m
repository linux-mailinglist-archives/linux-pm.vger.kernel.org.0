Return-Path: <linux-pm+bounces-29173-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B831AE2269
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 20:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8462C5A42D7
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 18:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EEB2EAB6D;
	Fri, 20 Jun 2025 18:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="XmJvixB3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC7821FF3D;
	Fri, 20 Jun 2025 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750445011; cv=none; b=dKXRX5OuvU9HeCwYIiTUwd2mQSAHCmwVo2IAzWXALjrFHeqDp8RbbtfInCp6tly0RihC8XY7Ue1JwXoohNGcTcOqvyfIbj4X5KcXD4Qy+L97mQCPlH7sufgyh40za7n43ZOoliXXWU46JqPFv/VbkhCSCgmQ/cI9ySb5ft55ziA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750445011; c=relaxed/simple;
	bh=hfeTC/LbrTNu/kIwcjwzlqTcJlOSBsGVhxjsYYmiXcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOv9vPdUC5wmBby9XCzDpWSxhz99lmd7Aon6vXfXiJ7xrbxzUusymWrJSfWRSPj6Y+J29Kr8UPxPrN483tUyAkclMyH45h86pes0ZL0akcoOXGTdG8PeSYPTf7thLNB5MO4+LuQSdaf0JFmDdj+6H/WCFwwH+2sKrt8KkHeQEaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=XmJvixB3; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 393753D8762C;
	Fri, 20 Jun 2025 14:43:21 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id gYTgZfNRbSRD; Fri, 20 Jun 2025 14:43:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 4683A3D8762F;
	Fri, 20 Jun 2025 14:43:20 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 4683A3D8762F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1750445000; bh=TaQQHObo8HRDlJD+n70gAPQXWO2RtYiWYUzJBZk6vh4=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=XmJvixB32vMJfc7yNrKh45ZFj1uA5zrDmuGUdWoqrIS0o+GaD0hiTpxl6/iHNj4jV
	 9DSmGcn1Xn2WVxgfx9Fs4NiCpGxZCPwkI4J8yVkcm6fax7kpPPyw0AE0icPxyHP8Su
	 58ZYgmgvW/JVQtM/6AT000t9zJ21VLYPF18qhAgQqafGsUZ6jk5lzph6/RUYVWSG01
	 o6Vrqj9JvyDjBJSRgi6Pwf4i+7CZcyJWuTEB19ja0OV4kl0KxsL/WhqwEIH9xUfAu2
	 Q02xezEjgxiS+qMZZ0xrMWBv/e+j1J6aGjsBJx3sTyqTHKECxrT3acwep6l9mWb5LJ
	 D+d5YMoK7r1wQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id uB8q18XrN1G8; Fri, 20 Jun 2025 14:43:20 -0400 (EDT)
Received: from fedora (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id DCFEA3D8762C;
	Fri, 20 Jun 2025 14:43:19 -0400 (EDT)
Date: Fri, 20 Jun 2025 14:43:18 -0400
From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
To: Lee Jones <lee@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
Subject: Re: [PATCH v7 2/6] mfd: pf1550: add core mfd driver
Message-ID: <aFWrxtArHjb5nc0M@fedora>
References: <20250612-pf1550-v7-0-0e393b0f45d7@savoirfairelinux.com>
 <20250612-pf1550-v7-2-0e393b0f45d7@savoirfairelinux.com>
 <20250619130337.GA795775@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619130337.GA795775@google.com>

Hi Lee,

Thanks a lot for the review.

On Thu, Jun 19, 2025 at 02:03:37PM +0100, Lee Jones wrote:
> > +static int pf1550_read_otp(const struct pf1550_dev *pf1550, unsigned int index,
> 
> What does OTP mean?
>
It's a One-Time Programmable memory with configuration for the pf1550. I will
expand on this in the commit description of the next version.
> Why do you have to write to 4 registers first?
> 
The pf1550 was designed such that the registers of the accompanying OTP is
accessed indirectly. Valid keys have to be written to specific pf1550
registers. After writing the keys, the address of the OTP register to be read
is then written to PF1550_TEST_REG_FMRADDR and its corresponding value read from
PF1550_TEST_REG_FMRDATA.
> This should all be made clear in some way or another.
> 
I'll be adding comments on this in the next version.
> > +			   unsigned int *val)
> > +{
> > +	int ret = 0;
> > +
> > +	ret = regmap_write(pf1550->regmap, PF1550_PMIC_REG_KEY, 0x15);
> 
> No magic numbers.  These should all be defined.
Will do.
> 
> > +	if (ret)
> > +		goto read_err;
> > +	ret = regmap_write(pf1550->regmap, PF1550_CHARG_REG_CHGR_KEY2, 0x50);
> > +	if (ret)
> > +		goto read_err;
> > +	ret = regmap_write(pf1550->regmap, PF1550_TEST_REG_KEY3, 0xab);
> > +	if (ret)
> > +		goto read_err;
> > +	ret = regmap_write(pf1550->regmap, PF1550_TEST_REG_FMRADDR, index);
> > +	if (ret)
> > +		goto read_err;
> > +	ret = regmap_read(pf1550->regmap, PF1550_TEST_REG_FMRDATA, val);
> > +	if (ret)
> > +		goto read_err;
> > +
> > +	return 0;
> > +
> > +read_err:
> > +	dev_err_probe(pf1550->dev, ret, "read otp reg %x found!\n", index);
...
> > +static int pf1550_add_child_device(struct pf1550_dev *pmic,
> > +				   const struct mfd_cell *cell,
> > +				   struct regmap_irq_chip_data *pdata,
> 
> This is not pdata.
> 
> > +				   int pirq,
> > +				   const struct regmap_irq_chip *chip,
> > +				   struct regmap_irq_chip_data **data)
> > +{
> > +	struct device *dev = pmic->dev;
> > +	struct irq_domain *domain;
> > +	int irq, ret;
> > +
> > +	irq = regmap_irq_get_virq(pdata, pirq);
> > +	if (irq < 0)
> > +		return dev_err_probe(dev, irq,
> > +				     "Failed to get parent vIRQ(%d) for chip %s\n",
> > +				     pirq, chip->name);
> > +
> > +	ret = devm_regmap_add_irq_chip(dev, pmic->regmap, irq,
> > +				       IRQF_ONESHOT | IRQF_SHARED |
> > +				       IRQF_TRIGGER_FALLING, 0, chip, data);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret,
> > +				     "Failed to add %s IRQ chip\n",
> > +				     chip->name);
> > +
> > +	domain = regmap_irq_get_domain(*data);
> > +
> > +	return devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, cell, 1,
> > +				    NULL, 0, domain);
> 
> Why can't all 3 devices be registered in one call?
> 
The 3 devices use different regmap_irq_chip s. I have to register them
separately cause they have different irq domains but perhaps there is a better
way to handle this?
> > +}
> 
> To be honest, the premise around this function is a bit of a mess.
> 
> Please move all of this into .probe().
Will do.
> 
> > +static int pf1550_i2c_probe(struct i2c_client *i2c)
> > +{
> > +	const struct mfd_cell *regulator = &pf1550_regulator_cell;
> > +	const struct mfd_cell *charger = &pf1550_charger_cell;
> > +	const struct mfd_cell *onkey = &pf1550_onkey_cell;
> > +	unsigned int reg_data = 0, otp_data = 0;
> > +	struct pf1550_dev *pf1550;
> > +	int ret = 0;
> > +
> > +	pf1550 = devm_kzalloc(&i2c->dev, sizeof(*pf1550), GFP_KERNEL);
> > +	if (!pf1550)
> > +		return -ENOMEM;
> > +
> > +	i2c_set_clientdata(i2c, pf1550);
> > +	pf1550->dev = &i2c->dev;
> > +	pf1550->i2c = i2c;
> 
> What are you storing i2c for?
> 
It doesn't need to be stored.
> Either store dev and irq OR i2c.  You don't need all three.
> 
Will do.
> > +	ret = regmap_read(pf1550->regmap, PF1550_PMIC_REG_DEVICE_ID, &reg_data);
> > +	if (ret < 0 || reg_data != PF1550_DEVICE_ID)
> > +		return dev_err_probe(pf1550->dev, ret ?: -EINVAL,
> > +				     "device not found!\n");
> 
> Are you sure?  What if the wrong device was found?
>
I can change the error log here to "Invalid device ID: ..."?
>
...
> > +	/* add top level interrupts */
> > +	ret = devm_regmap_add_irq_chip(pf1550->dev, pf1550->regmap, pf1550->irq,
> > +				       IRQF_ONESHOT | IRQF_SHARED |
> > +				       IRQF_TRIGGER_FALLING,
> > +				       0, &pf1550_irq_chip,
> > +				       &pf1550->irq_data);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = pf1550_add_child_device(pf1550, regulator, pf1550->irq_data,
> > +				      PF1550_IRQ_REGULATOR,
> > +				      &pf1550_regulator_irq_chip,
> > +				      &pf1550->irq_data_regulator);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = pf1550_add_child_device(pf1550, onkey, pf1550->irq_data,
> > +				      PF1550_IRQ_ONKEY,
> > +				      &pf1550_onkey_irq_chip,
> > +				      &pf1550->irq_data_onkey);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = pf1550_add_child_device(pf1550, charger, pf1550->irq_data,
> > +				      PF1550_IRQ_CHG,
> > +				      &pf1550_charger_irq_chip,
> > +				      &pf1550->irq_data_charger);
> > +	return ret;
> > +}
> > +
> > +static int pf1550_suspend(struct device *dev)
> > +{
> > +	struct i2c_client *i2c = container_of(dev, struct i2c_client, dev);
> > +	struct pf1550_dev *pf1550 = i2c_get_clientdata(i2c);
> 
> You can swap all of this for:
> 
> 	struct pf1550_dev *pf1550 = dev_get_drvdata(dev).
> 
Will do.
> > +
> > +	if (device_may_wakeup(dev)) {
> > +		enable_irq_wake(pf1550->irq);
> > +		disable_irq(pf1550->irq);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int pf1550_resume(struct device *dev)
> > +{
> > +	struct i2c_client *i2c = container_of(dev, struct i2c_client, dev);
> > +	struct pf1550_dev *pf1550 = i2c_get_clientdata(i2c);
> 
> As above.
> 
> > +
> > +	if (device_may_wakeup(dev)) {
> > +		disable_irq_wake(pf1550->irq);
> > +		enable_irq(pf1550->irq);
> 
> I would normally expect these to be around the opposite way to the ones
> in .suspend().
Do you mean enable_irq_wake and disable_irq in .resume() and the opposite for
.suspend()?
> 
> > +	}
> > +
> > +	return 0;
> > +}
> > +

Thanks,
Sam

