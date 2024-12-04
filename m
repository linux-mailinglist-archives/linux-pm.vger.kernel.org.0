Return-Path: <linux-pm+bounces-18586-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F54B9E4758
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 23:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1787C16A7C9
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 22:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3255D1946B3;
	Wed,  4 Dec 2024 22:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="bp2KUPjQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CB11922CC;
	Wed,  4 Dec 2024 22:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733349669; cv=none; b=bFlXtJs0s6AwvdFhXuWCxsS93bLblm0PwPwgV9uT1ltaIzcM0KwTVLRcMSlJeE6Fnh4GosDr4dUxvjJEVVOwmawBIMj9c0L2gkHzVST+to64kSL8fnmitF+mCFNsrBL0j0GYvmbFolH+Do/B5cD24kK7KfY12L2D3y7EwM+8GpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733349669; c=relaxed/simple;
	bh=657Ovy0HJodj6dPNC/6YLDl4wZSQOJ/3NePzsiUh0lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cS6bshVhf7qj+zeKtH8//5NvpJRv7VuA+2yPuhkiWrK2gu2fDBdammwpnxm8Rx4gH+VJcqQ2onLk01MHWuk7qZMZ91U11QB/Dx1chZsnv2e2mcN+eBOyZZ5JX6g/7on1IK4I744HXz5La8TkmZqP1kGOZcB0c6yzS1CqYyKD7K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=bp2KUPjQ; arc=none smtp.client-ip=80.12.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id IxPTtIDrcnKDzIxPTtIyVH; Wed, 04 Dec 2024 22:59:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1733349594;
	bh=qmm2EnZh4yKKWPoPQOh3lTfrcYbc7B9Zyo8CHOXMMzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=bp2KUPjQlR1kM3nSRPoe0C0H/59ejCORfn+6OkR3zVAyB3hI0PSe3/6o3p9XQ0vZS
	 rNR1h3tpiF4IztjPcltYg7zSQfl6OJwRdW3Z1mMvov+P9yLF+RqZ1Ddy7l6qZqB0dC
	 pqhVfT9lCzHrrPH0k+H7Vn41HcOj/GLIemh1zYmP/PGcwehnl9Z4n5YMYdEDf96CGj
	 TZbQrZ+jc/sv+WgMd9bRGVk/T4yFN8EhIP7ixM4oljQj/22te/OsNW0b/wBe6TzCZJ
	 ISrSME+RlO0aLP9xKNDLWP1bSM1EitsVBX1LS1lpPN7OEzArw2kVTPx536zowLGnR+
	 RSK8vBYbknHaQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Wed, 04 Dec 2024 22:59:54 +0100
X-ME-IP: 90.11.132.44
Message-ID: <87e26131-7793-49fc-a2be-73126bce86ba@wanadoo.fr>
Date: Wed, 4 Dec 2024 22:59:50 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 7/8] power: supply: max77705: Add charger driver for
 Maxim 77705
To: Dzmitry Sankouski <dsankouski@gmail.com>,
 Sebastian Reichel <sre@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Hans de Goede <hdegoede@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
 Purism Kernel Team <kernel@puri.sm>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org
References: <20241204-starqltechn_integration_upstream-v10-0-7de85e48e562@gmail.com>
 <20241204-starqltechn_integration_upstream-v10-7-7de85e48e562@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241204-starqltechn_integration_upstream-v10-7-7de85e48e562@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 04/12/2024 à 21:09, Dzmitry Sankouski a écrit :
> Add driver for Maxim 77705 switch-mode charger (part of max77705
> MFD driver) providing power supply class information to userspace.
> 
> The driver is configured through DTS (battery and system related
> settings).
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> 
> ---

Hi,

> +static int max77705_check_battery(struct max77705_charger_data *charger, int *val)
> +{
> +	unsigned int reg_data;
> +	unsigned int reg_data2;
> +	struct regmap *regmap = charger->regmap;
> +
> +
> +	regmap_read(regmap, MAX77705_CHG_REG_INT_OK, &reg_data);
> +
> +	dev_dbg(charger->dev, "CHG_INT_OK(0x%x)\n", reg_data);
> +
> +	regmap_read(regmap,
> +			  MAX77705_CHG_REG_DETAILS_00, &reg_data2);

This can fit on a single line, I think.

> +
> +	dev_dbg(charger->dev, "CHG_DETAILS00(0x%x)\n", reg_data2);
> +
> +	if ((reg_data & MAX77705_BATP_OK) || !(reg_data2 & MAX77705_BATP_DTLS))
> +		*val = true;
> +	else
> +		*val = false;
> +
> +	return 0;
> +}

...

> +static int max77705_get_input_current(struct max77705_charger_data *charger,
> +					int *val)
> +{
> +	unsigned int reg_data;
> +	int get_current = 0;
> +	struct regmap *regmap = charger->regmap;
> +
> +	regmap_read(regmap,
> +			  MAX77705_CHG_REG_CNFG_09, &reg_data);

It can fit on a single line, I think.

> +
> +	reg_data &= MAX77705_CHG_CHGIN_LIM_MASK;
> +
> +	if (reg_data <= 3)
> +		get_current = 100;
> +	else if (reg_data >= MAX77705_CHG_CHGIN_LIM_MASK)
> +		get_current = MAX77705_CURRENT_CHGIN_MAX;
> +	else
> +		get_current = (reg_data + 1) * 25;
> +
> +	*val = get_current;
> +
> +	return 0;
> +}
> +
> +static int max77705_get_charge_current(struct max77705_charger_data *charger,
> +					int *val)
> +{
> +	unsigned int reg_data;
> +	struct regmap *regmap = charger->regmap;
> +
> +

No need for to empty lines.

> +	regmap_read(regmap, MAX77705_CHG_REG_CNFG_02, &reg_data);
> +	reg_data &= MAX77705_CHG_CC;
> +
> +	*val = reg_data <= 0x2 ? 100 : reg_data * 50;
> +
> +	return 0;
> +}

...

> +static int max77705_charger_probe(struct platform_device *pdev)
> +{
> +	struct power_supply_config pscfg = {};
> +	struct i2c_client *i2c_chg;
> +	struct max77693_dev *max77705;
> +	struct max77705_charger_data *chg;
> +	struct device *dev, *parent;
> +	struct regmap_irq_chip_data *irq_data;
> +	int ret;
> +
> +	dev = &pdev->dev;
> +	parent = dev->parent;
> +	max77705 = dev_get_drvdata(parent);
> +
> +	chg = devm_kzalloc(dev, sizeof(*chg), GFP_KERNEL);
> +	if (!chg)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, chg);
> +
> +	i2c_chg = devm_i2c_new_dummy_device(dev, max77705->i2c->adapter, I2C_ADDR_CHG);
> +	if (IS_ERR(i2c_chg))
> +		return PTR_ERR(i2c_chg);
> +
> +	chg->regmap = devm_regmap_init_i2c(i2c_chg, &max77705_chg_regmap_config);
> +	if (IS_ERR(chg->regmap))
> +		return PTR_ERR(chg->regmap);
> +
> +	chg->dev = dev;
> +
> +	ret = regmap_update_bits(chg->regmap,
> +				MAX77705_CHG_REG_INT_MASK,
> +				MAX77705_CHGIN_IM, 0);
> +	if (ret)
> +		return ret;
> +
> +	pscfg.of_node = dev->of_node;
> +	pscfg.drv_data = chg;
> +
> +	chg->psy_chg = devm_power_supply_register(dev, &max77705_charger_psy_desc, &pscfg);
> +	if (IS_ERR(chg->psy_chg))
> +		return PTR_ERR(chg->psy_chg);
> +
> +	max77705_charger_irq_chip.irq_drv_data = chg;
> +	ret = devm_regmap_add_irq_chip(chg->dev, chg->regmap, max77705->irq,
> +					IRQF_ONESHOT | IRQF_SHARED, 0,
> +					&max77705_charger_irq_chip,
> +					&irq_data);
> +	if (ret)
> +		dev_err_probe(dev, ret, "failed to add irq chip\n");
> +
> +	chg->wqueue = create_singlethread_workqueue(dev_name(dev));
> +	if (IS_ERR(chg->wqueue))
> +		dev_err_probe(dev, PTR_ERR(chg->wqueue), "failed to create workqueue\n");

Is it fine if chg->wqueue is an ERR?
I think that max77705_chgin_irq() won't like it.

Missing return?

Same for the test above. Is it fine to continue if 
devm_regmap_add_irq_chip() fails?

> +
> +	INIT_WORK(&chg->chgin_work, max77705_chgin_isr_work);
> +
> +	max77705_charger_initialize(chg);
> +
> +	ret = devm_add_action_or_reset(dev, max77705_charger_disable, chg);
> +	if (ret)
> +		return ret;
> +
> +	return max77705_charger_enable(chg);
> +}

...

CJ

