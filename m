Return-Path: <linux-pm+bounces-14404-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3109B97BB06
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 12:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8E701F21391
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 10:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38F517A597;
	Wed, 18 Sep 2024 10:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyTif9Dw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1FA1CF9B;
	Wed, 18 Sep 2024 10:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726656187; cv=none; b=Id9/QPmDeqezmfALbsleuTtC/NKEybxH25EqUQii780medYsY0RS6bLpnr+9VY0FV3AizDIaQUC5BJX6ahRdiOOSzipR18yzpPvUUj1mUABGn9bpnjxiVOjfZuQ394GUyXp64+wf9KgwveKlLfw5dL3D6ydejHq3O9pPtypa4tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726656187; c=relaxed/simple;
	bh=pLNSGSlxEJMU9z/8PbcHIURJH1dyIXAik9PiewAkWFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LJZFU+dunnpSL07EedVrU30anHJ8tkw+4sAWjb7WQqwkRk9QpsoAS5rj8Sq81Y1e9SrNHJUYo6GsS53xt82n5lqw5MG2TWZ3qMxWJlqqo5TnZmBgr/rbNAZ7j/Mq3WCEietZMjuSScFQJ5ppGq0lHxgL9ZnxYOWZuv4o8MYhy48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyTif9Dw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3345C4CEC3;
	Wed, 18 Sep 2024 10:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726656187;
	bh=pLNSGSlxEJMU9z/8PbcHIURJH1dyIXAik9PiewAkWFg=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=YyTif9Dwz5B/v+HDBD0f3duGiOGbbpEjEPhqdkaKAMkM28D8PaLaNZ9lX/d8jHuxC
	 9vSPH+M4SHdu1ZilQNO2K6/IVtLopndSQmlS8sJG3vU13kZZZug2hx+ABzRRIYLmoT
	 OIYWoRdthOC6MnM1R7+ypzs6hy5I9puxALU+V1ND0AzYiZ3x2mPSu3o1THbrOdfdgT
	 Vm7wtHDPb0vHCla0KEmCc0MbCnB7LKcaFQIvHqr0Mf5oj+l4hs8iBmOSCIjNwbM2v2
	 hn7I/P8DDnWXZRKgMLGywASc63F18/SndyrsPx+2H7LT/Qc6AFGTgsfcSEIU1cf7pZ
	 hS31q71yoxs3Q==
Message-ID: <89a7e86b-8866-4148-9f9e-13ca84c1aede@kernel.org>
Date: Wed, 18 Sep 2024 12:43:01 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] power: supply: initial support for TWL6030/32
To: Andreas Kemnade <andreas@kemnade.info>, tony@atomide.com,
 Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org,
 devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 linux-pm@vger.kernel.org
References: <20240918084132.928295-1-andreas@kemnade.info>
 <20240918084132.928295-4-andreas@kemnade.info>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240918084132.928295-4-andreas@kemnade.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/09/2024 10:41, Andreas Kemnade wrote:
> Add a driver for the charger in the TWL6030/32. For now it does not report
> much in sysfs but parameters are set up for USB, charging is enabled with
> the specified parameters. It stops charging when full and also restarts
> charging.
> This prevents ending up in a system setup where you run out of battery
> although a charger is plugged in after precharge completed.
> 
> Battery voltage behavior was checked via the GPADC.
> 

Few stylistic comments below.

> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/power/supply/Kconfig           |  10 +
>  drivers/power/supply/Makefile          |   1 +
>  drivers/power/supply/twl6030_charger.c | 566 +++++++++++++++++++++++++
>  3 files changed, 577 insertions(+)
>  create mode 100644 drivers/power/supply/twl6030_charger.c
> 
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index bcfa63fb9f1e2..9f2eef6787f7a 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -493,6 +493,16 @@ config CHARGER_TWL4030
>  	help
>  	  Say Y here to enable support for TWL4030 Battery Charge Interface.
>  
> +config CHARGER_TWL6030
> +	tristate "OMAP TWL6030 BCI charger driver"
> +	depends on IIO && TWL4030_CORE

|| COMPILE_TEST, at least for TWL part
(but please test first)

> +	help
> +	  Say Y here to enable support for TWL6030/6032 Battery Charge
> +	  Interface.
> +
> +	  This driver can be build as a module. If so, the module will be
> +	  called twl6030_charger.
> +



> +
> +static int twl6030_charger_probe(struct platform_device *pdev)
> +{
> +	struct twl6030_charger_info *charger;
> +	struct power_supply_config psy_cfg = {};
> +	int ret;
> +	u8 val;
> +
> +	charger = devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
> +	if (!charger)
> +		return -ENOMEM;
> +
> +	charger->dev = &pdev->dev;
> +	charger->irq_chg = platform_get_irq(pdev, 0);
> +
> +	platform_set_drvdata(pdev, charger);
> +	psy_cfg.drv_data = charger;
> +
> +	charger->channel_vusb = devm_iio_channel_get(&pdev->dev, "vusb");
> +	if (IS_ERR(charger->channel_vusb)) {
> +		ret = PTR_ERR(charger->channel_vusb);
> +		if (ret == -EPROBE_DEFER)
> +			return ret;	/* iio not ready */
> +		dev_warn(&pdev->dev, "could not request vusb iio channel (%d)",
> +			 ret);
> +		charger->channel_vusb = NULL;
> +	}
> +
> +	charger->usb = devm_power_supply_register(&pdev->dev,
> +						  &twl6030_charger_usb_desc,
> +						  &psy_cfg);
> +	if (IS_ERR(charger->usb)) {

Checkpatch...

> +		return dev_err_probe(&pdev->dev, PTR_ERR(charger->usb),
> +				     "Failed to register usb\n");
> +	}
> +
> +	ret = power_supply_get_battery_info(charger->usb, &charger->binfo);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Failed to get battery info\n");
> +
> +	dev_info(&pdev->dev, "battery with vmax %d imax: %d\n",
> +		 charger->binfo->constant_charge_voltage_max_uv,
> +		 charger->binfo->constant_charge_current_max_ua);
> +
> +	if (charger->binfo->constant_charge_voltage_max_uv == -EINVAL) {
> +		ret = twl6030_charger_read(CHARGERUSB_CTRLLIMIT1, &val);
> +		if (ret < 0)
> +			return ret;
> +
> +		charger->binfo->constant_charge_voltage_max_uv =
> +			VOREG_TO_UV(val);
> +	}
> +
> +	if (charger->binfo->constant_charge_voltage_max_uv > 4760000 ||
> +	    charger->binfo->constant_charge_voltage_max_uv < 350000)
> +		return dev_err_probe(&pdev->dev, -EINVAL,
> +				     "Invalid charge voltage\n");
> +
> +	if (charger->binfo->constant_charge_current_max_ua == -EINVAL) {
> +		ret = twl6030_charger_read(CHARGERUSB_CTRLLIMIT2, &val);
> +		if (ret < 0)
> +			return ret;
> +
> +		charger->binfo->constant_charge_current_max_ua = VICHRG_TO_UA(val);
> +	}
> +
> +	if (charger->binfo->constant_charge_current_max_ua < 100000 ||
> +	    charger->binfo->constant_charge_current_max_ua > 1500000) {
> +		return dev_err_probe(&pdev->dev, -EINVAL,
> +			 "Invalid charge current\n");
> +	}
> +
> +	if ((charger->binfo->charge_term_current_ua != -EINVAL) &&
> +	    (charger->binfo->charge_term_current_ua > 400000 ||
> +	     charger->binfo->charge_term_current_ua < 50000)) {
> +		return dev_err_probe(&pdev->dev, -EINVAL,
> +			"Invalid charge termination current\n");
> +	}
> +
> +	ret = devm_delayed_work_autocancel(&pdev->dev,
> +					   &charger->charger_monitor,
> +					   twl6030_charger_wdg);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Failed to register delayed work\n");
> +
> +	ret = devm_request_threaded_irq(&pdev->dev, charger->irq_chg, NULL,
> +					twl6030_charger_interrupt,
> +					IRQF_ONESHOT, pdev->name,
> +					charger);
> +	if (ret < 0) {

Drop {}, see checkpatch.

> +		return dev_err_probe(&pdev->dev, ret,
> +				     "could not request irq %d\n",
> +				     charger->irq_chg);
> +	}
> +
> +	/* turing to charging to configure things */
> +	twl6030_charger_write(CONTROLLER_CTRL1, 0);
> +	twl6030_charger_interrupt(0, charger);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id twl_charger_of_match[] __maybe_unused = {
> +	{.compatible = "ti,twl6030-charger", },
> +	{.compatible = "ti,twl6032-charger", },

So they are compatible? Why two entries in such case?

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, twl_charger_of_match);
> +
> +static struct platform_driver twl6030_charger_driver = {
> +	.probe = twl6030_charger_probe,
> +	.driver	= {
> +		.name	= "twl6030_charger",
> +		.of_match_table = of_match_ptr(twl_charger_of_match),

I propose to drop of_match_ptr and maybe_unused, so this won't be
restricted only to OF

> +	},
> +};
> +module_platform_driver(twl6030_charger_driver);
> +
> +MODULE_DESCRIPTION("TWL6030 Battery Charger Interface driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:twl6030_charger");


You should not need MODULE_ALIAS() in normal cases. If you need it,
usually it means your device ID table is wrong (e.g. misses either
entries or MODULE_DEVICE_TABLE()). MODULE_ALIAS() is not a substitute
for incomplete ID table.


Best regards,
Krzysztof


