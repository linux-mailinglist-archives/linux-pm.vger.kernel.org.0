Return-Path: <linux-pm+bounces-18337-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADAE9DFEB9
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 11:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 224302814E1
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 10:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D41B1FC0E4;
	Mon,  2 Dec 2024 10:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PahSbI/X"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3C31FA829;
	Mon,  2 Dec 2024 10:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733135004; cv=none; b=fon6NZWXfykfcPNdSqN/ESEe1RFQ4WFyNOxeM07ZQC9RPICqSKUp0NwB1lVdiSNt44NWZxEaUXvuOnZDpEYQCja66ernQsAoZ6iOtr89acufgVWlhz+dXLW8AdR97mFQWWOd3aReMSLFpdkthcZJ4heF/5l8vHGyRGiEqBH4fps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733135004; c=relaxed/simple;
	bh=8BS/xJX6ypVQCl4Re3aAiciu/UhD3J9Ut8F6ZMNAF4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h55u7UeCfa+DYFA3qCRn2pY7DSVzd4nIIF6ICycmHi7Z90qV0rZKBiuro/pFdCSHNB/23kdB0PDS1CLnwFTe8lxsGEvB10oIU9rxti3e52vXXQVxznk8HKyAvetnBbr/zQg52qRNW7sg6+X25wg10C5QgawySCCoWK8hafPYxFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PahSbI/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD6AC4CED1;
	Mon,  2 Dec 2024 10:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733135003;
	bh=8BS/xJX6ypVQCl4Re3aAiciu/UhD3J9Ut8F6ZMNAF4A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PahSbI/X1m9veA7z+v/VgZe9eCxT9RYybHUNxemJSHqeKec0xNb6nWC2pVrGbV2+M
	 W0xGRixWRGTeH3PRB+FRPyq9rc8UoYS7kxigWEwOmU5NIGYB4UObW6LJU97/vqF6Qd
	 SvaWq59ByyFgr4fSkmxgQ7Gfsr7P2HJXM/C+pdDQiwZy41qycnO9epib2LBpICZdA2
	 crs3fout2xem/o3rkqKbx8HTSuYt3VtaOv3/xN9HMn361/Y+FZQAPKL16+hcD5HRxN
	 qCrrql54PiHv85/CGfj/NT8nM5FJqLjFsok2w3m5nK4ka0vXyehsefk8Xjkf1sLCNt
	 pkhVokbG6tNVQ==
Message-ID: <59c27c5d-3db7-44da-b3ac-7b8e7c8b6f16@kernel.org>
Date: Mon, 2 Dec 2024 11:23:16 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/9] mfd: Add new driver for MAX77705 PMIC
To: Dzmitry Sankouski <dsankouski@gmail.com>,
 Sebastian Reichel <sre@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Hans de Goede <hdegoede@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
 Purism Kernel Team <kernel@puri.sm>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org
References: <20241202-starqltechn_integration_upstream-v9-0-a1adc3bae2b8@gmail.com>
 <20241202-starqltechn_integration_upstream-v9-6-a1adc3bae2b8@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20241202-starqltechn_integration_upstream-v9-6-a1adc3bae2b8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/12/2024 10:47, Dzmitry Sankouski wrote:
> Add the core MFD driver for max77705 PMIC. We define five sub-devices
> for which the drivers will be added in subsequent patches.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> 


...

> +
> +static int max77705_i2c_probe(struct i2c_client *i2c)
> +{
> +	struct max77693_dev *max77705;
> +	struct i2c_client *i2c_fg;
> +	struct regmap_irq_chip_data *irq_data;
> +	struct irq_domain *domain;
> +	int ret;
> +	unsigned int pmic_rev_value;
> +	enum max77705_hw_rev pmic_rev;
> +
> +


Only one blank line

> +	max77705 = devm_kzalloc(&i2c->dev, sizeof(*max77705), GFP_KERNEL);
> +	if (!max77705)
> +		return -ENOMEM;
> +
> +	max77705->i2c = i2c;
> +	max77705->dev = &i2c->dev;
> +	max77705->irq = i2c->irq;
> +	max77705->type = TYPE_MAX77705;
> +	i2c_set_clientdata(i2c, max77705);
> +
> +	max77705->regmap = devm_regmap_init_i2c(i2c, &max77705_regmap_config);
> +

No blank line. Theer is never blank line between call and its error check.

> +	if (IS_ERR(max77705->regmap))
> +		return PTR_ERR(max77705->regmap);
> +
> +	if (regmap_read(max77705->regmap, MAX77705_PMIC_REG_PMICREV, &pmic_rev_value) < 0)
> +		return -ENODEV;
> +
> +	pmic_rev = pmic_rev_value & MAX77705_REVISION_MASK;
> +

Drop blank line.

> +	if (pmic_rev != MAX77705_PASS3) {
> +		dev_err(max77705->dev, "rev.0x%x is not tested",
> +			pmic_rev);

Unnecessary line wrap.

> +		return -ENODEV;
> +	}
> +
> +	max77705->regmap_leds = devm_regmap_init_i2c(i2c, &max77705_leds_regmap_config);
> +
> +	if (IS_ERR(max77705->regmap_leds))
> +		return PTR_ERR(max77705->regmap_leds);
> +
> +	ret = devm_regmap_add_irq_chip(max77705->dev, max77705->regmap,
> +					max77705->irq,
> +					IRQF_ONESHOT | IRQF_SHARED, 0,
> +					&max77705_topsys_irq_chip,
> +					&irq_data);
> +

Same issues, all over the code.

> +	if (ret)
> +		dev_err(max77705->dev, "failed to add irq chip: %d\n", ret);
> +
> +	/* Unmask interrupts from all blocks in interrupt source register */
> +	ret = regmap_update_bits(max77705->regmap,
> +				 MAX77705_PMIC_REG_INTSRC_MASK,
> +				 MAX77705_SRC_IRQ_ALL, (unsigned int)~MAX77705_SRC_IRQ_ALL);


The need for cast comes from some compiler warning?

> +
> +	if (ret < 0) {
> +		dev_err(max77705->dev,
> +			"Could not unmask interrupts in INTSRC: %d\n", ret);
> +		return ret;
> +	}
> +
> +	domain = regmap_irq_get_domain(irq_data);
> +
> +	i2c_fg = devm_i2c_new_dummy_device(max77705->dev, max77705->i2c->adapter, I2C_ADDR_FG);
> +
> +	if (IS_ERR(i2c_fg))
> +		return PTR_ERR(i2c_fg);
> +
> +	max77705->i2c_fg = i2c_fg;
> +
> +	for (int i = 0; i < ARRAY_SIZE(max77705_devs); i++) {
> +		if (!strcmp(max77705_devs[i].name, FUEL_GAUGE_NAME)) {
> +			max77705_devs[i].platform_data = &i2c_fg;
> +			max77705_devs[i].pdata_size = sizeof(i2c_fg);
> +		}
> +	}
> +
> +	ret = devm_mfd_add_devices(max77705->dev, PLATFORM_DEVID_NONE,
> +				   max77705_devs, ARRAY_SIZE(max77705_devs),
> +				   NULL, 0, domain);
> +
> +	if (ret) {
> +		dev_err(max77705->dev, "Failed to register child devices: %d\n", ret);
> +		return ret;
> +	}
> +
> +	device_init_wakeup(max77705->dev, true);
> +
> +	return 0;
> +}
> +
> +static int max77705_suspend(struct device *dev)
> +{
> +	struct i2c_client *i2c = to_i2c_client(dev);
> +	struct max77693_dev *max77705 = i2c_get_clientdata(i2c);
> +
> +	disable_irq(max77705->irq);
> +
> +	if (device_may_wakeup(dev))
> +		enable_irq_wake(max77705->irq);
> +
> +	return 0;
> +}
> +
> +static int max77705_resume(struct device *dev)
> +{
> +	struct i2c_client *i2c = to_i2c_client(dev);
> +	struct max77693_dev *max77705 = i2c_get_clientdata(i2c);
> +
> +	if (device_may_wakeup(dev))
> +		disable_irq_wake(max77705->irq);
> +
> +	enable_irq(max77705->irq);
> +
> +	return 0;
> +}
> +DEFINE_SIMPLE_DEV_PM_OPS(max77705_pm_ops, max77705_suspend, max77705_resume);
> +
> +static const struct of_device_id max77705_i2c_of_match[] = {
> +	{ .compatible = "maxim,max77705" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, max77705_i2c_of_match);
> +
> +static struct i2c_driver max77705_i2c_driver = {
> +	.driver = {
> +		.name			= "max77705",
> +		.of_match_table		= max77705_i2c_of_match,
> +		.pm			= pm_sleep_ptr(&max77705_pm_ops),
> +		.suppress_bind_attrs	= true,
> +	},
> +	.probe = max77705_i2c_probe,
> +};
> +module_i2c_driver(max77705_i2c_driver);
> +
> +MODULE_DESCRIPTION("Maxim MAX77705 PMIC core driver");
> +MODULE_AUTHOR("Dzmitry Sankouski <dsankouski@gmail.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/max77693-common.h b/include/linux/mfd/max77693-common.h
> index a5bce099f1ed..8665097892cd 100644
> --- a/include/linux/mfd/max77693-common.h
> +++ b/include/linux/mfd/max77693-common.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
>  /*
> - * Common data shared between Maxim 77693 and 77843 drivers
> + * Common data shared between Maxim 77693, 77705 and 77843 drivers
>   *
>   * Copyright (C) 2015 Samsung Electronics
>   */
> @@ -11,6 +11,7 @@
>  enum max77693_types {
>  	TYPE_MAX77693_UNKNOWN,
>  	TYPE_MAX77693,
> +	TYPE_MAX77705,
>  	TYPE_MAX77843,
>  
>  	TYPE_MAX77693_NUM,
> @@ -25,6 +26,7 @@ struct max77693_dev {
>  	struct i2c_client *i2c_muic;	/* 0x4A , MUIC */
>  	struct i2c_client *i2c_haptic;	/* MAX77693: 0x90 , Haptic */
>  	struct i2c_client *i2c_chg;	/* MAX77843: 0xD2, Charger */
> +	struct i2c_client *i2c_fg;	/* MAX77843: 0xD2, Charger */


You mix patchsets. Don't grow 77843 wigth 77705. Or is this not max77843?

>  
>  	enum max77693_types type;
>  
> @@ -32,6 +34,7 @@ struct max77693_dev {
>  	struct regmap *regmap_muic;
>  	struct regmap *regmap_haptic;	/* Only MAX77693 */
>  	struct regmap *regmap_chg;	/* Only MAX77843 */
> +	struct regmap *regmap_leds;	/* Only MAX77705 */
>  
>  	struct regmap_irq_chip_data *irq_data_led;
>  	struct regmap_irq_chip_data *irq_data_topsys;
> diff --git a/include/linux/mfd/max77705-private.h b/include/linux/mfd/max77705-private.h
> new file mode 100644
> index 000000000000..be781a0f9802


...

> +
> +enum max77705_led_reg {
> +	MAX77705_RGBLED_REG_BASE		= 0x30,
> +	MAX77705_RGBLED_REG_LEDEN		= 0,
> +	MAX77705_RGBLED_REG_LED0BRT,
> +	MAX77705_RGBLED_REG_LED1BRT,
> +	MAX77705_RGBLED_REG_LED2BRT,
> +	MAX77705_RGBLED_REG_LED3BRT,
> +	MAX77705_RGBLED_REG_LEDRMP,
> +	MAX77705_RGBLED_REG_LEDBLNK,
> +	MAX77705_LED_REG_END
> +};
> +
> +enum max77705_charger_battery_state {
> +	MAX77705_BATTERY_NOBAT,
> +	MAX77705_BATTERY_PREQUALIFICATION,
> +	MAX77705_BATTERY_DEAD,
> +	MAX77705_BATTERY_GOOD,
> +	MAX77705_BATTERY_LOWVOLTAGE,
> +	MAX77705_BATTERY_OVERVOLTAGE,
> +	MAX77705_BATTERY_RESERVED,
> +};
> +
> +enum max77705_charger_charge_type {
> +	MAX77705_CHARGER_CONSTANT_CURRENT	= 1,
> +	MAX77705_CHARGER_CONSTANT_VOLTAGE,
> +	MAX77705_CHARGER_END_OF_CHARGE,
> +	MAX77705_CHARGER_DONE,
> +};
> +
> +extern const struct dev_pm_ops max77705_pm_ops;


Why do you need it in the header?

> +
> +#endif /* __LINUX_MFD_MAX77705_PRIV_H */
> 


Best regards,
Krzysztof

