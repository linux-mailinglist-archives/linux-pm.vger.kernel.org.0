Return-Path: <linux-pm+bounces-17708-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7DD9D0F27
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 12:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95A2D1F22183
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 11:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E7C19644B;
	Mon, 18 Nov 2024 11:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GucvHOxr"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2896194C8D
	for <linux-pm@vger.kernel.org>; Mon, 18 Nov 2024 11:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731927811; cv=none; b=Dq+OsGUYxNFKXB4ZkUFijLIGCJFJjrZStM4rh6M6SVXXccnFg2wiDOih5wGU3xGL+fyI4/fhIw6L5KYqcP4sLg1o9A6Q5qgFdtiS1yDGW/kjtClZwjerXq08MCixEsHCLtVVg6MDyiOuGiDn80fCZn9Zbphk3mp0mZ41wAvd12k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731927811; c=relaxed/simple;
	bh=sTWHw+APVrMMSJpBKXYcLEozbM8o88Mak8YJJs642u4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5QmOHGUV2wk7PngeKv5w5MrOC7qMdnlsIURx1zsTqJP4ZgpiBxcCs1Bv7oeIDiZCKFeQws1lFjjL5S+Lxj+YA1Ftyk7AiyOIDtklq0Qxofo9KGanJWcKALWvzqlkElQr/1AucDpNP1uzp5tIy9Xh8VB0H0FOxe4qaB17cVvvaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GucvHOxr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731927807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fFu/OAvTmsREW3ildiFBX75cwQiDefrF6674U37Lx1Y=;
	b=GucvHOxrYmVutOCwjbScNXi38K9/V+nbvuMhn0i7WO4MOynsNeH44cvCKvV/aZ072AXXuD
	F/o0LjYKcMexmJTwBDt8OmROBRNSzs1S0om3fP7VxwsTXB+0n5jrJyINg8XFSBvHx+CH0q
	zIs9rHNf+mN3qotNdohHAtvx3ghxL6s=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-rJrv_Nd9O9yU6vo9tfyeDw-1; Mon, 18 Nov 2024 06:03:26 -0500
X-MC-Unique: rJrv_Nd9O9yU6vo9tfyeDw-1
X-Mimecast-MFC-AGG-ID: rJrv_Nd9O9yU6vo9tfyeDw
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a9a01cba9f7so179410266b.3
        for <linux-pm@vger.kernel.org>; Mon, 18 Nov 2024 03:03:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731927805; x=1732532605;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fFu/OAvTmsREW3ildiFBX75cwQiDefrF6674U37Lx1Y=;
        b=HuHjYcefjshRpKbDrNATshB7Lsk6DO4zuhODNxKTU5POLequQPdqt6853Qpgk3+GRc
         EETEUA2N+ocSVhs7b5Y8ePDIeevIGkd7ZYkOtUyJIZc77ohljahvcWiQ3Av3DWqeciOv
         oIP9RlylY+K55TzoOHzabgtK94sy/4RaDOjG4SCDr/hwDFf76ChF3QgIHpHqIHJWeaYf
         vU9r8YMxaYx4JihJEewESM3mMrLHIH3kqfQkndJ4RoIkPX/eclDByLQKxXUhWg3tNWWH
         eCohnFIU+qBTxAC/97flwddMWTQ+Goum8bnKSCqz+85zhB/RLsf/h/MD8DuznMGbOrOe
         Ch3g==
X-Gm-Message-State: AOJu0YyNyM8hbpcUWg/NqQwhODPkXOzI+vDVYWbzvUqiRK45ESHfEpDW
	6QtVL+H/9fWgAOMkA/dl5BFWovouFCnQdAaCfhgR0Lg52jY35g2+EHcRPdQkSSe+mXNMkH+ShT0
	epagD45z40fCQJT8ruOoUyhCugEyN4It02V1XsgIyw6Ocw23JoU9aSajm
X-Received: by 2002:a17:907:60cb:b0:a99:4f40:3e82 with SMTP id a640c23a62f3a-aa4833f46famr1234286766b.7.1731927805041;
        Mon, 18 Nov 2024 03:03:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgE5lFUGeJWNc5aF38BP5qToKS4LCc2lzaIKk6WaXRxGUC+tJxJL16EB5HAdoRxTV53XMQZA==
X-Received: by 2002:a17:907:60cb:b0:a99:4f40:3e82 with SMTP id a640c23a62f3a-aa4833f46famr1234282866b.7.1731927804585;
        Mon, 18 Nov 2024 03:03:24 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df501f9sm526378166b.46.2024.11.18.03.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 03:03:24 -0800 (PST)
Message-ID: <b05db127-b80e-401a-b93b-dec1907902ba@redhat.com>
Date: Mon, 18 Nov 2024 12:03:23 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] power: supply: max17042: add platform driver
 variant
To: Dzmitry Sankouski <dsankouski@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
 Purism Kernel Team <kernel@puri.sm>, Sebastian Reichel <sre@kernel.org>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-msm@vger.kernel.org
References: <20241118-b4-max17042-v3-0-9bcaeda42a06@gmail.com>
 <20241118-b4-max17042-v3-2-9bcaeda42a06@gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241118-b4-max17042-v3-2-9bcaeda42a06@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dzmitry,

On 18-Nov-24 11:09 AM, Dzmitry Sankouski wrote:
> Maxim PMICs may include fuel gauge with additional features, which is
> out of single Linux power supply driver scope.
> 
> For example, in max77705 PMIC fuelgauge has additional registers,
> like IIN_REG, VSYS_REG, ISYS_REG. Those needed to measure PMIC input
> current, system voltage and current respectively. Those measurements
> cannot be bound to any of fuelgauge properties.
> 
> The solution here add and option to use max17042 driver as a MFD
> sub device, thus allowing any additional functionality be implemented as
> another sub device. This will help to reduce code duplication in MFD
> fuel gauge drivers.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
> Changes in v3:
> - pass dev pointer in max17042_probe
> - remove prints
> ---
>  drivers/power/supply/max17042_battery.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------
>  1 file changed, 90 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
> index 99bf6915aa23..d11bf37aaae2 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -16,6 +16,7 @@
>  #include <linux/i2c.h>
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
> +#include <linux/platform_device.h>
>  #include <linux/pm.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/power_supply.h>
> @@ -1029,14 +1030,12 @@ static const struct power_supply_desc max17042_no_current_sense_psy_desc = {
>  	.num_properties	= ARRAY_SIZE(max17042_battery_props) - 2,
>  };
>  
> -static int max17042_probe(struct i2c_client *client)
> +static int max17042_probe(struct i2c_client *client, struct device *dev,
> +			  enum max170xx_chip_type chip_type)
>  {
> -	const struct i2c_device_id *id = i2c_client_get_device_id(client);
>  	struct i2c_adapter *adapter = client->adapter;
>  	const struct power_supply_desc *max17042_desc = &max17042_psy_desc;
>  	struct power_supply_config psy_cfg = {};
> -	const struct acpi_device_id *acpi_id = NULL;
> -	struct device *dev = &client->dev;
>  	struct max17042_chip *chip;
>  	int ret;
>  	int i;
> @@ -1045,33 +1044,24 @@ static int max17042_probe(struct i2c_client *client)
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WORD_DATA))
>  		return -EIO;
>  
> -	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
> +	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
>  	if (!chip)
>  		return -ENOMEM;
>  
>  	chip->client = client;
> -	if (id) {
> -		chip->chip_type = id->driver_data;
> -	} else {
> -		acpi_id = acpi_match_device(dev->driver->acpi_match_table, dev);
> -		if (!acpi_id)
> -			return -ENODEV;
> -
> -		chip->chip_type = acpi_id->driver_data;
> -	}

I would expect you to now add a:

	chip->chip_type = chip_type;

line here storing the chip_type probe() function argument, but
that appears to be missing always leaving chip_type at 0.

>  	chip->regmap = devm_regmap_init_i2c(client, &max17042_regmap_config);
>  	if (IS_ERR(chip->regmap)) {
> -		dev_err(&client->dev, "Failed to initialize regmap\n");
> +		dev_err(dev, "Failed to initialize regmap\n");
>  		return -EINVAL;
>  	}
>  
>  	chip->pdata = max17042_get_pdata(chip);
>  	if (!chip->pdata) {
> -		dev_err(&client->dev, "no platform data provided\n");
> +		dev_err(dev, "no platform data provided\n");
>  		return -EINVAL;
>  	}
>  
> -	i2c_set_clientdata(client, chip);
> +	dev_set_drvdata(dev, chip);
>  	psy_cfg.drv_data = chip;
>  	psy_cfg.of_node = dev->of_node;
>  
> @@ -1095,17 +1085,17 @@ static int max17042_probe(struct i2c_client *client)
>  		regmap_write(chip->regmap, MAX17042_LearnCFG, 0x0007);
>  	}
>  
> -	chip->battery = devm_power_supply_register(&client->dev, max17042_desc,
> +	chip->battery = devm_power_supply_register(dev, max17042_desc,
>  						   &psy_cfg);
>  	if (IS_ERR(chip->battery)) {
> -		dev_err(&client->dev, "failed: power supply register\n");
> +		dev_err(dev, "failed: power supply register\n");
>  		return PTR_ERR(chip->battery);
>  	}
>  
>  	if (client->irq) {
>  		unsigned int flags = IRQF_ONESHOT | IRQF_SHARED | IRQF_PROBE_SHARED;
>  
> -		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +		ret = devm_request_threaded_irq(dev, client->irq,
>  						NULL,
>  						max17042_thread_handler, flags,
>  						chip->battery->desc->name,
> @@ -1118,7 +1108,7 @@ static int max17042_probe(struct i2c_client *client)
>  		} else {
>  			client->irq = 0;
>  			if (ret != -EBUSY)
> -				dev_err(&client->dev, "Failed to get IRQ\n");
> +				dev_err(dev, "Failed to get IRQ\n");
>  		}
>  	}
>  	/* Not able to update the charge threshold when exceeded? -> disable */
> @@ -1127,7 +1117,7 @@ static int max17042_probe(struct i2c_client *client)
>  
>  	regmap_read(chip->regmap, MAX17042_STATUS, &val);
>  	if (val & STATUS_POR_BIT) {
> -		ret = devm_work_autocancel(&client->dev, &chip->work,
> +		ret = devm_work_autocancel(dev, &chip->work,
>  					   max17042_init_worker);
>  		if (ret)
>  			return ret;
> @@ -1139,6 +1129,38 @@ static int max17042_probe(struct i2c_client *client)
>  	return 0;
>  }
>  
> +static int max17042_i2c_probe(struct i2c_client *client)
> +{
> +	const struct i2c_device_id *id = i2c_client_get_device_id(client);
> +	const struct acpi_device_id *acpi_id = NULL;
> +	struct device *dev = &client->dev;
> +	enum max170xx_chip_type chip_type;
> +
> +	if (id) {
> +		chip_type = id->driver_data;
> +	} else {
> +		acpi_id = acpi_match_device(dev->driver->acpi_match_table, dev);
> +		if (!acpi_id)
> +			return -ENODEV;
> +
> +		chip_type = acpi_id->driver_data;
> +	}
> +
> +	return max17042_probe(client, dev, chip_type);
> +}
> +
> +static int max17042_platform_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct i2c_client *i2c = dev_get_platdata(dev);
> +	const struct platform_device_id *id = platform_get_device_id(pdev);
> +
> +	if (!i2c)
> +		return -EINVAL;
> +
> +	return max17042_probe(i2c, dev, id->driver_data);
> +}
> +
>  #ifdef CONFIG_PM_SLEEP
>  static int max17042_suspend(struct device *dev)
>  {
> @@ -1204,6 +1226,16 @@ static const struct i2c_device_id max17042_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, max17042_id);
>  
> +static const struct platform_device_id max17042_platform_id[] = {
> +	{ "max17042", MAXIM_DEVICE_TYPE_MAX17042 },
> +	{ "max17047", MAXIM_DEVICE_TYPE_MAX17047 },
> +	{ "max17050", MAXIM_DEVICE_TYPE_MAX17050 },
> +	{ "max17055", MAXIM_DEVICE_TYPE_MAX17055 },
> +	{ "max77849-battery", MAXIM_DEVICE_TYPE_MAX17047 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(platform, max17042_platform_id);
> +
>  static struct i2c_driver max17042_i2c_driver = {
>  	.driver	= {
>  		.name	= "max17042",
> @@ -1211,10 +1243,44 @@ static struct i2c_driver max17042_i2c_driver = {
>  		.of_match_table = of_match_ptr(max17042_dt_match),
>  		.pm	= &max17042_pm_ops,
>  	},
> -	.probe		= max17042_probe,
> +	.probe		= max17042_i2c_probe,
>  	.id_table	= max17042_id,
>  };
> -module_i2c_driver(max17042_i2c_driver);
> +
> +static struct platform_driver max17042_platform_driver = {
> +	.driver	= {
> +		.name	= "max17042",
> +		.acpi_match_table = ACPI_PTR(max17042_acpi_match),
> +		.of_match_table = of_match_ptr(max17042_dt_match),
> +		.pm	= &max17042_pm_ops,
> +	},
> +	.probe		= max17042_platform_probe,
> +	.id_table	= max17042_platform_id,
> +};
> +
> +static int __init __driver_max17042_platform_init(void)

I would name this just max17042_init() no reason to prefix with __
and using platform in the name is weird since it registers both
the i2c and platform drivers.

> +{
> +	int ret = 0;

No need to initialize ret to 0, since you immediately assign
a value to it after declaring it.

> +	ret = platform_driver_register(&max17042_platform_driver);

missing if (ret) return ret.

> +	if (ret) {
> +		platform_driver_unregister(&max17042_platform_driver);
> +		return ret;
> +	}
> +
> +	ret = i2c_add_driver(&max17042_i2c_driver);

This needs to be above if (ret) which unregisters the platform_driver
again.

> +
> +	return ret;

and this should be return 0;

> +}
> +module_init(__driver_max17042_platform_init);

Basically the whole function should look like this:

static int __init max17042_init(void)
{
	int ret;

	ret = platform_driver_register(&max17042_platform_driver);
	if (ret)
		return ret;

	ret = i2c_add_driver(&max17042_i2c_driver);
	if (ret) {
		platform_driver_unregister(&max17042_platform_driver);
		return ret;
	}

	return 0;
}
module_init(max17042_init);


> +
> +static void __exit __driver_max17042_platform_exit(void)

Please name this one just max17042_exit()

> +{
> +	i2c_del_driver(&max17042_i2c_driver);
> +	platform_driver_unregister(&max17042_platform_driver);
> +}
> +module_exit(__driver_max17042_platform_exit);
>  
>  MODULE_AUTHOR("MyungJoo Ham <myungjoo.ham@samsung.com>");
>  MODULE_DESCRIPTION("MAX17042 Fuel Gauge");
> 

Regards,

Hans


