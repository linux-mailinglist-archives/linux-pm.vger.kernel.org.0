Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A520CEC596
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 16:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfKAP2C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 11:28:02 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41631 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbfKAP2C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 11:28:02 -0400
Received: by mail-ed1-f67.google.com with SMTP id a21so7820328edj.8;
        Fri, 01 Nov 2019 08:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/NDrXUcKJ7/8F/Y/hMevpGshYdNpAqX9Q9Po/a2HHFU=;
        b=sUOzVhtQocv5pfp9i1AnDEhFCeZazsN4amRqIg4MZp/mCyXVRM3InGwd3tOy6eY1rl
         4/uln9q0KOZ+FVV9XQwx5mU4dE8rglkFOxlE3f1fpFnNXnBozb80SYC0fP3GgCFjUkTX
         H7Vm+jR4aUd/YPUMRwbSsg5q1pTBmMqc51VOzDFFSUFwqdQbh/YMsMPFdSmC6RARIcTc
         3iqWWy7qZCjYc+/578iGwnHG0eHEmRhsHjmTdY+BfcFX7IEGGBKV/wbEX5Bgmlfg37j0
         y4vCnW5zqUNhIT/V0ouPqRcA89H+L6nmPLXxCFxH6MLuOdKFsIc2jkKg/51yscQalTAs
         sx0g==
X-Gm-Message-State: APjAAAXb7xQyqtPV7fO5klAENMADll0DLyorkRP+Hea1lSj2I9RVaETT
        TCyqKavgwzQjPqh/rL8OId89WzqR
X-Google-Smtp-Source: APXvYqxv92IajGpVuJNmou4pi/RvjIctHN/Z9uqKoJY2ORRfop0PfmLD8aDVPmlhQFctKWT7tl5IzQ==
X-Received: by 2002:a17:906:218a:: with SMTP id 10mr10267550eju.38.1572622079111;
        Fri, 01 Nov 2019 08:27:59 -0700 (PDT)
Received: from pi3 ([194.230.155.180])
        by smtp.googlemail.com with ESMTPSA id nq2sm39225ejb.43.2019.11.01.08.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 08:27:57 -0700 (PDT)
Date:   Fri, 1 Nov 2019 16:27:55 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        cw00.choi@samsung.com, b.zolnierkie@samsung.com,
        lee.jones@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] power: supply: max17040: Config alert SOC low
 level threshold from FDT
Message-ID: <20191101152755.GC28931@pi3>
References: <CAJKOXPdCtbsPaAgYp5iVBhkAsjXzOYWwttQBptgiUgzhbKi09w@mail.gmail.com>
 <20191031184134.30621-1-matheus@castello.eng.br>
 <20191031184134.30621-4-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191031184134.30621-4-matheus@castello.eng.br>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 31, 2019 at 03:41:33PM -0300, Matheus Castello wrote:
> For configuration of fuel gauge alert for a low level state of charge
> interrupt we add a function to config level threshold and a device tree
> binding property to set it in flatned device tree node.
> 
> Now we can use "maxim,alert-low-soc-level" property with the values from
> 1% up to 32% to configure alert interrupt threshold.
> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  drivers/power/supply/max17040_battery.c | 88 +++++++++++++++++++++----
>  1 file changed, 74 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
> index 75459f76d02c..802575342c72 100644
> --- a/drivers/power/supply/max17040_battery.c
> +++ b/drivers/power/supply/max17040_battery.c
> @@ -29,6 +29,9 @@
>  #define MAX17040_DELAY		1000
>  #define MAX17040_BATTERY_FULL	95
> 
> +#define MAX17040_ATHD_MASK		0xFFC0
> +#define MAX17040_ATHD_DEFAULT_POWER_UP	4
> +
>  struct max17040_chip {
>  	struct i2c_client		*client;
>  	struct delayed_work		work;
> @@ -43,6 +46,8 @@ struct max17040_chip {
>  	int soc;
>  	/* State Of Charge */
>  	int status;
> +	/* Low alert threshold from 32% to 1% of the State of Charge */
> +	u32 low_soc_alert_threshold;
>  };
> 
>  static int max17040_get_property(struct power_supply *psy,
> @@ -99,6 +104,22 @@ static void max17040_reset(struct i2c_client *client)
>  	max17040_write_reg(client, MAX17040_CMD, 0x0054);
>  }
> 
> +static int max17040_set_low_soc_threshold_alert(struct i2c_client *client,
> +	u32 level)
> +{
> +	int ret;
> +	u16 data;
> +
> +	level = 32 - level;
> +	data = max17040_read_reg(client, MAX17040_RCOMP);
> +	/* clear the alrt bit and set LSb 5 bits */
> +	data &= MAX17040_ATHD_MASK;
> +	data |= level;
> +	ret = max17040_write_reg(client, MAX17040_RCOMP, data);
> +
> +	return ret;
> +}
> +
>  static void max17040_get_vcell(struct i2c_client *client)
>  {
>  	struct max17040_chip *chip = i2c_get_clientdata(client);
> @@ -115,7 +136,6 @@ static void max17040_get_soc(struct i2c_client *client)
>  	u16 soc;
> 
>  	soc = max17040_read_reg(client, MAX17040_SOC);
> -
>  	chip->soc = (soc >> 8);
>  }
> 
> @@ -161,6 +181,24 @@ static void max17040_get_status(struct i2c_client *client)
>  		chip->status = POWER_SUPPLY_STATUS_FULL;
>  }
> 
> +static int max17040_get_of_data(struct max17040_chip *chip)
> +{
> +	struct device *dev = &chip->client->dev;
> +	struct device_node *np = dev->of_node;
> +	int ret = 0;
> +
> +	if (of_property_read_u32(np, "maxim,alert-low-soc-level",
> +			&chip->low_soc_alert_threshold)) {

Please align the line break with line above. checkpatch --strict might
give you hints about this.

> +		chip->low_soc_alert_threshold = MAX17040_ATHD_DEFAULT_POWER_UP;
> +	/* check if low_soc_alert_threshold is between 1% and 32% */

The comment looks misleading here, like it belongs to previous block.
Maybe put it inside else if {} block?

> +	} else if (chip->low_soc_alert_threshold <= 0 ||
> +			chip->low_soc_alert_threshold >= 33){

Missing space before {.

> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
>  static void max17040_check_changes(struct i2c_client *client)
>  {
>  	max17040_get_vcell(client);
> @@ -192,6 +230,10 @@ static irqreturn_t max17040_thread_handler(int id, void *dev)
>  	/* send uevent */
>  	power_supply_changed(chip->battery);
> 
> +	/* reset alert bit */
> +	max17040_set_low_soc_threshold_alert(client,
> +		chip->low_soc_alert_threshold);

Unless the continuation exceeds 80 character limit, please align it with
previous line.

> +
>  	return IRQ_HANDLED;
>  }
> 
> @@ -216,6 +258,7 @@ static int max17040_probe(struct i2c_client *client,
>  	struct i2c_adapter *adapter = client->adapter;
>  	struct power_supply_config psy_cfg = {};
>  	struct max17040_chip *chip;
> +	int ret;
> 
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
>  		return -EIO;
> @@ -226,6 +269,12 @@ static int max17040_probe(struct i2c_client *client,
> 
>  	chip->client = client;
>  	chip->pdata = client->dev.platform_data;
> +	ret = max17040_get_of_data(chip);
> +	if (ret) {
> +		dev_err(&client->dev,
> +			"failed: low SOC alert OF data out of bounds\n");
> +		return ret;
> +	}
> 
>  	i2c_set_clientdata(client, chip);
>  	psy_cfg.drv_data = chip;
> @@ -242,20 +291,31 @@ static int max17040_probe(struct i2c_client *client,
> 
>  	/* check interrupt */
>  	if (client->irq) {
> -		int ret;
> -		unsigned int flags;
> -
> -		dev_info(&client->dev, "IRQ: enabled\n");
> -		flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
> -		ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> -						max17040_thread_handler, flags,
> -						chip->battery->desc->name,
> -						chip);
> -
> -		if (ret) {
> -			client->irq = 0;
> +		if (of_device_is_compatible(client->dev.of_node,
> +			"maxim,max77836-battery")) {

Alignment.

> +			ret = max17040_set_low_soc_threshold_alert(client,
> +				chip->low_soc_alert_threshold);

Ditto.

> +			if (ret) {
> +				dev_err(&client->dev,
> +					"Failed to set low SOC alert: err %d\n",
> +					ret);
> +				return ret;
> +			}
> +
> +			dev_info(&client->dev, "IRQ: enabled\n");
> +			ret = devm_request_threaded_irq(&client->dev,
> +				client->irq, NULL, max17040_thread_handler,
> +				(client->flags | IRQF_ONESHOT),

This looks unrelated. Befor ethis were IRQF_TRIGGER_FALLING |
IRQF_ONESHOT, now you use client->flags. There is no reason why this
commit should change it.

> +				chip->battery->desc->name, chip);

This breaks alignment which was here before.

Best regards,
Krzysztof


> +
> +			if (ret) {
> +				client->irq = 0;
> +				dev_warn(&client->dev,
> +					"Failed to get IRQ err %d\n", ret);
> +			}
> +		} else {
>  			dev_warn(&client->dev,
> -				"Failed to get IRQ err %d\n", ret);
> +				"Device not compatible for IRQ");
>  		}
>  	}
> 
> --
> 2.24.0.rc2
> 
