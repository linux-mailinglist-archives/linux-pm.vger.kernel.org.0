Return-Path: <linux-pm+bounces-18338-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAD09DFEE3
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 11:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE8E4161D1F
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 10:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5131FC114;
	Mon,  2 Dec 2024 10:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+6Ds/Ai"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2902018AEA;
	Mon,  2 Dec 2024 10:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733135296; cv=none; b=AGlLDqag8ZlS78Rk5aX92hEXJQdGbCR9sveLJOrdC0DosLycscG7sXGQ9ASUkF/gksOjmdhYaY4IUN5GyJi/0/Q5btuKEPhmjzK7kgFK2Fw1BI/aDTjOtsNcjdTLNkr6KM2xhXXm0FE1wipTii5hBAuFx23H4VqGloA7htysfpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733135296; c=relaxed/simple;
	bh=dmAO+00hD77a0xSfiVTts1xUU/62BM73uZLkMdxPVFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rg3pFRP7AFv3ehu4N8mr4nDYM0kJ1eDC34dHV7U630Ce7dlKWh0F/TPBOXz11kXHI+6V0BUDJovU2W+K5tmj0jE+8E2UQAUxd+biZsMsCm8385evnklKSwsZHxxBE1Nz/hA5UICUu/f2epqYU/hKp565E18BlaCGuzZyz9psm1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+6Ds/Ai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DFEC4CED1;
	Mon,  2 Dec 2024 10:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733135295;
	bh=dmAO+00hD77a0xSfiVTts1xUU/62BM73uZLkMdxPVFw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j+6Ds/AimDuv/Im3j3QOYKPEjaL3Oe7hW4vzSsWfGDxz8EN+TXZkhYMgdOgiQqkQz
	 0qlTlaD0t7Mb1Qs039F6pw03cG7IhPqHKVd8GQs5lE9ll+tXN1XM+FmtUIlRAonEZz
	 Z5io3bjCvG9QT17MM37+b6IWbZmlWG51RJV/Q/fwbQ+W8cXd1mUguQ/TyvIuJwjpUs
	 FzIhTt4hrERMY4H5sd7strUi6XK+9GtIp5jjrRdnZSjwULu/jf7N+Wnc5pZsJG+j6L
	 vSlcrYT0MIllO0oeJ+hXP3mxg/3qF2Ut+GA4Bfl8S2ZbEltRShD/QyfQi+Ok5fSG9w
	 TNR2q7ngRZjAA==
Message-ID: <9b88a26c-088d-44a8-9226-8317a0bf63f1@kernel.org>
Date: Mon, 2 Dec 2024 11:28:07 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 8/9] power: supply: max77705: Add charger driver for
 Maxim 77705
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
 <20241202-starqltechn_integration_upstream-v9-8-a1adc3bae2b8@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20241202-starqltechn_integration_upstream-v9-8-a1adc3bae2b8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/12/2024 10:48, Dzmitry Sankouski wrote:
> Add driver for Maxim 77705 switch-mode charger (part of max77705
> MFD driver) providing power supply class information to userspace.
> 
> The driver is configured through DTS (battery and system related
> settings).
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> 


...

> +
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
> +

Same problems as in other patchset. This really needs some work to look
closer to Linux coding style.


> +	if (IS_ERR(i2c_chg))
> +		return PTR_ERR(i2c_chg);
> +
> +	chg->regmap = devm_regmap_init_i2c(i2c_chg, &max77705_chg_regmap_config);
> +
> +	if (IS_ERR(chg->regmap))
> +		return PTR_ERR(chg->regmap);
> +
> +	chg->dev = dev;
> +
> +	ret = regmap_update_bits(chg->regmap,
> +				MAX77705_CHG_REG_INT_MASK,
> +				MAX77705_CHGIN_IM, 0);
> +
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
> +	if (ret) {
> +		dev_err(dev, "failed to add irq chip: %d\n", ret);
> +		return ret;
> +	}
> +
> +	chg->wqueue = create_singlethread_workqueue(dev_name(dev));
> +	if (IS_ERR(chg->wqueue)) {
> +		dev_err(dev, "failed to create workqueue\n");
> +		return PTR_ERR(chg->wqueue);
> +	}
> +	INIT_WORK(&chg->chgin_work, max77705_chgin_isr_work);
> +
> +	max77705_charger_initialize(chg);
> +
> +	return max77705_charger_enable(chg);
> +}
> +
> +static void max77705_charger_remove(struct platform_device *pdev)
> +{
> +	struct max77705_charger_data *chg = platform_get_drvdata(pdev);
> +
> +	max77705_charger_disable(chg);


Use devm for this. You use shared interrupt, so you are not suppose to
mix devm and non-devm, even if this is actually safe.

> +}
> +
> +static const struct of_device_id max77705_charger_of_match[] = {
> +	{ .compatible = "maxim,max77705-charger" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max77705_charger_of_match);
> +
> +static struct platform_driver max77705_charger_driver = {
> +	.driver = {
> +		.name = "max77705-charger",
> +		.of_match_table = max77705_charger_of_match,
> +	},
> +	.probe = max77705_charger_probe,
> +	.remove = max77705_charger_remove,
> +};
> +module_platform_driver(max77705_charger_driver);
> +
> +MODULE_AUTHOR("Dzmitry Sankouski <dsankouski@gmail.com>");
> +MODULE_DESCRIPTION("Maxim MAX77705 charger driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/power/max77705_charger.h b/include/linux/power/max77705_charger.h
> new file mode 100644
> index 000000000000..44ecd6b32cbe
> --- /dev/null
> +++ b/include/linux/power/max77705_charger.h
> @@ -0,0 +1,216 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Maxim MAX77705 definitions.
> + *
> + * Copyright (C) 2015 Samsung Electronics, Inc.
> + * Copyright (C) 2024 Dzmitry Sankouski <dsankouski@gmail.com>
> + */


...

> +
> +/* MAX77705_CHG_REG_CNFG_10 */
> +#define MAX77705_CHG_WCIN_LIM		GENMASK(5, 0)
> +
> +/* MAX77705_CHG_REG_CNFG_11 */
> +#define MAX77705_VBYPSET_SHIFT		0
> +#define MAX77705_VBYPSET_MASK		GENMASK(6, 0)
> +
> +/* MAX77705_CHG_REG_CNFG_12 */
> +#define MAX77705_CHGINSEL_SHIFT		5
> +#define MAX77705_CHGINSEL_MASK		BIT(MAX77705_CHGINSEL_SHIFT)
> +#define MAX77705_WCINSEL_SHIFT		6
> +#define MAX77705_WCINSEL_MASK		BIT(MAX77705_WCINSEL_SHIFT)
> +#define MAX77705_VCHGIN_REG_MASK	GENMASK(4, 3)
> +#define MAX77705_WCIN_REG_MASK		GENMASK(2, 1)
> +#define MAX77705_REG_DISKIP_SHIFT	0
> +#define MAX77705_REG_DISKIP_MASK	BIT(MAX77705_REG_DISKIP_SHIFT)
> +/* REG=4.5V, UVLO=4.7V */
> +#define MAX77705_VCHGIN_4_5		0
> +/* REG=4.5V, UVLO=4.7V */
> +#define MAX77705_WCIN_4_5		0
> +#define MAX77705_DISABLE_SKIP		1
> +#define MAX77705_AUTO_SKIP		0
> +
> +/* mA */
> +#define MAX77705_CURRENT_STEP		25
> +#define MAX77705_CURRENT_WCIN_MAX	1600
> +#define MAX77705_CURRENT_CHGIN_MAX	3200
> +
> +/* Convert current in mA to corresponding CNFG09 value */
> +inline u8 max77705_convert_ma_to_chgin_ilim_value(unsigned int cur)
> +{
> +	if (cur < MAX77705_CURRENT_STEP)
> +		return 0;
> +	if (cur < MAX77705_CURRENT_CHGIN_MAX)
> +		return (cur / MAX77705_CURRENT_STEP) - 1;
> +	else
> +		return (MAX77705_CURRENT_CHGIN_MAX / MAX77705_CURRENT_STEP) - 1;
> +}


Drop all inlines from header. You are not suppose to have such driver
functions inlined all over the users.


Best regards,
Krzysztof

