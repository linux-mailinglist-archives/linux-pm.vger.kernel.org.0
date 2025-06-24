Return-Path: <linux-pm+bounces-29447-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B38AE6BF8
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 18:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21B2D179276
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 16:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B762E11C9;
	Tue, 24 Jun 2025 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+/ZQg3E"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9103074AB;
	Tue, 24 Jun 2025 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750780963; cv=none; b=m9AZzW+hPqGqamP7T3ftKRmzRu/uJRQ3uFwEQxyCOhpXvIvosbfuGgSLpiqkZQO4dIVZCRgosAZkTlKZEUA9lG0AgIQdUY63acCAled11Wf3SZWCVmW9ws/8WUhCUz/lFGRfwWT0/b9Htx3MPdBB6+/KYL8luL3o6Dncxe9QP/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750780963; c=relaxed/simple;
	bh=FPCSlDVYJ3mJwkIKhhgrkGwH4ruAR20+CRSWbEpS8NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJ8lLoCV24+3M8e+l9jYXSAT9v7D9m+7egsDuLoTHYlmxVqcpJA1URzyo9b0K2oPE60DDVNoQpXit6V6TEFM4gC3Eyj1J5X+MHb0qjUUCumD5OyFNZWQ3Ib9C5ich8ZhLcV/VCukuDvd9U+y2BuJPfSqzBxGmQldI59FeNS7u2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+/ZQg3E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41142C4CEE3;
	Tue, 24 Jun 2025 16:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750780962;
	bh=FPCSlDVYJ3mJwkIKhhgrkGwH4ruAR20+CRSWbEpS8NA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n+/ZQg3Eo0DYsVZpgfKjlHN/ec6EHGcm0Kz+VDqNGyfGTZlPD0T/0+rk6LxkAb+IF
	 /EnxzEzdA6UkghrvTuQEvZC1VIK/6pxCcm7Um9CkcMsGfrDvL28BFwq0JYV67oaNvF
	 DHORjlAvYhtsVDuQW5HGeVCSfKzTmd+XhHjjxe8/aeHwOHWhveFouxaQEZEBrji4gt
	 kedCy4q5qt3RQqjK8HRoFQCahCnPxJ5lKREnu65VNaYHoD4KbTXGJIZ/iyKhB11OiL
	 FRAkzhP2xOFkqqXnr/paG5FamftxJPSwzLmMF9oCrqmEI78Pzvvt4J3/ar08XSZ1DZ
	 cRQBvwhgAybYQ==
Date: Tue, 24 Jun 2025 17:02:35 +0100
From: Lee Jones <lee@kernel.org>
To: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
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
Message-ID: <20250624160235.GM795775@google.com>
References: <20250612-pf1550-v7-0-0e393b0f45d7@savoirfairelinux.com>
 <20250612-pf1550-v7-2-0e393b0f45d7@savoirfairelinux.com>
 <20250619130337.GA795775@google.com>
 <aFWrxtArHjb5nc0M@fedora>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aFWrxtArHjb5nc0M@fedora>

On Fri, 20 Jun 2025, Samuel Kayode wrote:

> Hi Lee,
> 
> Thanks a lot for the review.
> 
> On Thu, Jun 19, 2025 at 02:03:37PM +0100, Lee Jones wrote:
> > > +static int pf1550_read_otp(const struct pf1550_dev *pf1550, unsigned int index,
> > 
> > What does OTP mean?
> >
> It's a One-Time Programmable memory with configuration for the pf1550. I will
> expand on this in the commit description of the next version.

Place it in a comment please.

> > Why do you have to write to 4 registers first?
> > 
> The pf1550 was designed such that the registers of the accompanying OTP is
> accessed indirectly. Valid keys have to be written to specific pf1550
> registers. After writing the keys, the address of the OTP register to be read
> is then written to PF1550_TEST_REG_FMRADDR and its corresponding value read from
> PF1550_TEST_REG_FMRDATA.

In a comment please.  If I wondered, so with others.

> > This should all be made clear in some way or another.
> > 
> I'll be adding comments on this in the next version.

Great!

> > > +			   unsigned int *val)
> > > +{
> > > +	int ret = 0;
> > > +
> > > +	ret = regmap_write(pf1550->regmap, PF1550_PMIC_REG_KEY, 0x15);
> > 
> > No magic numbers.  These should all be defined.
> Will do.
> > 
> > > +	if (ret)
> > > +		goto read_err;
> > > +	ret = regmap_write(pf1550->regmap, PF1550_CHARG_REG_CHGR_KEY2, 0x50);
> > > +	if (ret)
> > > +		goto read_err;
> > > +	ret = regmap_write(pf1550->regmap, PF1550_TEST_REG_KEY3, 0xab);
> > > +	if (ret)
> > > +		goto read_err;
> > > +	ret = regmap_write(pf1550->regmap, PF1550_TEST_REG_FMRADDR, index);
> > > +	if (ret)
> > > +		goto read_err;
> > > +	ret = regmap_read(pf1550->regmap, PF1550_TEST_REG_FMRDATA, val);
> > > +	if (ret)
> > > +		goto read_err;
> > > +
> > > +	return 0;
> > > +
> > > +read_err:
> > > +	dev_err_probe(pf1550->dev, ret, "read otp reg %x found!\n", index);
> ...
> > > +static int pf1550_add_child_device(struct pf1550_dev *pmic,
> > > +				   const struct mfd_cell *cell,
> > > +				   struct regmap_irq_chip_data *pdata,
> > 
> > This is not pdata.
> > 
> > > +				   int pirq,
> > > +				   const struct regmap_irq_chip *chip,
> > > +				   struct regmap_irq_chip_data **data)
> > > +{
> > > +	struct device *dev = pmic->dev;
> > > +	struct irq_domain *domain;
> > > +	int irq, ret;
> > > +
> > > +	irq = regmap_irq_get_virq(pdata, pirq);
> > > +	if (irq < 0)
> > > +		return dev_err_probe(dev, irq,
> > > +				     "Failed to get parent vIRQ(%d) for chip %s\n",
> > > +				     pirq, chip->name);
> > > +
> > > +	ret = devm_regmap_add_irq_chip(dev, pmic->regmap, irq,
> > > +				       IRQF_ONESHOT | IRQF_SHARED |
> > > +				       IRQF_TRIGGER_FALLING, 0, chip, data);
> > > +	if (ret)
> > > +		return dev_err_probe(dev, ret,
> > > +				     "Failed to add %s IRQ chip\n",
> > > +				     chip->name);
> > > +
> > > +	domain = regmap_irq_get_domain(*data);
> > > +
> > > +	return devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, cell, 1,
> > > +				    NULL, 0, domain);
> > 
> > Why can't all 3 devices be registered in one call?
> > 
> The 3 devices use different regmap_irq_chip s. I have to register them
> separately cause they have different irq domains but perhaps there is a better
> way to handle this?

That's okay, just do 3 calls.

Must neater than what we have here.

> > > +}
> > 
> > To be honest, the premise around this function is a bit of a mess.
> > 
> > Please move all of this into .probe().
> Will do.
> > 
> > > +static int pf1550_i2c_probe(struct i2c_client *i2c)
> > > +{
> > > +	const struct mfd_cell *regulator = &pf1550_regulator_cell;
> > > +	const struct mfd_cell *charger = &pf1550_charger_cell;
> > > +	const struct mfd_cell *onkey = &pf1550_onkey_cell;
> > > +	unsigned int reg_data = 0, otp_data = 0;
> > > +	struct pf1550_dev *pf1550;
> > > +	int ret = 0;
> > > +
> > > +	pf1550 = devm_kzalloc(&i2c->dev, sizeof(*pf1550), GFP_KERNEL);
> > > +	if (!pf1550)
> > > +		return -ENOMEM;
> > > +
> > > +	i2c_set_clientdata(i2c, pf1550);
> > > +	pf1550->dev = &i2c->dev;
> > > +	pf1550->i2c = i2c;
> > 
> > What are you storing i2c for?
> > 
> It doesn't need to be stored.
> > Either store dev and irq OR i2c.  You don't need all three.
> > 
> Will do.
> > > +	ret = regmap_read(pf1550->regmap, PF1550_PMIC_REG_DEVICE_ID, &reg_data);
> > > +	if (ret < 0 || reg_data != PF1550_DEVICE_ID)
> > > +		return dev_err_probe(pf1550->dev, ret ?: -EINVAL,
> > > +				     "device not found!\n");
> > 
> > Are you sure?  What if the wrong device was found?
> >
> I can change the error log here to "Invalid device ID: ..."?

Right.  Invalid or unsupported, etc.

> >
> ...
> > > +	/* add top level interrupts */
> > > +	ret = devm_regmap_add_irq_chip(pf1550->dev, pf1550->regmap, pf1550->irq,
> > > +				       IRQF_ONESHOT | IRQF_SHARED |
> > > +				       IRQF_TRIGGER_FALLING,
> > > +				       0, &pf1550_irq_chip,
> > > +				       &pf1550->irq_data);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = pf1550_add_child_device(pf1550, regulator, pf1550->irq_data,
> > > +				      PF1550_IRQ_REGULATOR,
> > > +				      &pf1550_regulator_irq_chip,
> > > +				      &pf1550->irq_data_regulator);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = pf1550_add_child_device(pf1550, onkey, pf1550->irq_data,
> > > +				      PF1550_IRQ_ONKEY,
> > > +				      &pf1550_onkey_irq_chip,
> > > +				      &pf1550->irq_data_onkey);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = pf1550_add_child_device(pf1550, charger, pf1550->irq_data,
> > > +				      PF1550_IRQ_CHG,
> > > +				      &pf1550_charger_irq_chip,
> > > +				      &pf1550->irq_data_charger);
> > > +	return ret;
> > > +}
> > > +
> > > +static int pf1550_suspend(struct device *dev)
> > > +{
> > > +	struct i2c_client *i2c = container_of(dev, struct i2c_client, dev);
> > > +	struct pf1550_dev *pf1550 = i2c_get_clientdata(i2c);
> > 
> > You can swap all of this for:
> > 
> > 	struct pf1550_dev *pf1550 = dev_get_drvdata(dev).
> > 
> Will do.
> > > +
> > > +	if (device_may_wakeup(dev)) {
> > > +		enable_irq_wake(pf1550->irq);
> > > +		disable_irq(pf1550->irq);
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int pf1550_resume(struct device *dev)
> > > +{
> > > +	struct i2c_client *i2c = container_of(dev, struct i2c_client, dev);
> > > +	struct pf1550_dev *pf1550 = i2c_get_clientdata(i2c);
> > 
> > As above.
> > 
> > > +
> > > +	if (device_may_wakeup(dev)) {
> > > +		disable_irq_wake(pf1550->irq);
> > > +		enable_irq(pf1550->irq);
> > 
> > I would normally expect these to be around the opposite way to the ones
> > in .suspend().
> Do you mean enable_irq_wake and disable_irq in .resume() and the opposite for
> .suspend()?

Yes.  Or whatever fits best.

Maybe the h/w doesn't work that way, I just found it odd.

-- 
Lee Jones [李琼斯]

