Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E79A8EFA47
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 10:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388055AbfKEJ7N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 04:59:13 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42279 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730454AbfKEJ7M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Nov 2019 04:59:12 -0500
Received: by mail-ed1-f67.google.com with SMTP id m13so9300313edv.9;
        Tue, 05 Nov 2019 01:59:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EsQY1+FYq6hmp/aV3ZQ9R7RWQ2nr+29an3C9DMBubgw=;
        b=NDbAMQDjrOTGJwtB6zZnPgPim1KpxpAi7BcYVeLuvLXcasuoVPNn4+hq6hDydtPa61
         RcI5Pi6prEN8WbXO+x1Rd3bZunRN7My/NIoC3Hz331/vUKKSShCvaNATD7yDjVHjgLyC
         kjNWPMjcyKIY4e3+wY+I04dmrwjgER0ADJphPKSDnvaToBYfTPhevraOHwPx+dS5+dny
         hQB71hwABZnt68osbaggMbFLEkYBHp529kkZc7DI/a3RKa+8LRFbulM+DZdTdcS8li6W
         hb6NnTiWe0tOruuIMg+nMP+o3VmJf7mMlGGRwrF889Oag/cwtFaRl8t+v5NO1Oha/RWY
         rr4Q==
X-Gm-Message-State: APjAAAVak+K8YPFSi88XlUmlIIpsGlEs00q1EF8MetC2KMJa1DCM/A9P
        A8g6V4AiY0JQWojKqzT2zRk=
X-Google-Smtp-Source: APXvYqym7iMcRcDXO9zIYTv1DLgDk242F6B4BEeeidEiTic9E35TdFMtHO5+wzp+4GPeyP9g0jbpsg==
X-Received: by 2002:a17:906:3285:: with SMTP id 5mr27628244ejw.143.1572947948275;
        Tue, 05 Nov 2019 01:59:08 -0800 (PST)
Received: from pi3 ([194.230.155.180])
        by smtp.googlemail.com with ESMTPSA id j19sm252942ejs.88.2019.11.05.01.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 01:59:07 -0800 (PST)
Date:   Tue, 5 Nov 2019 10:59:05 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        cw00.choi@samsung.com, b.zolnierkie@samsung.com,
        lee.jones@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/5] power: supply: max17040: Config alert SOC low
 level threshold from FDT
Message-ID: <20191105095905.GA31721@pi3>
References: <20191105015827.GA332@bogus>
 <20191105054218.29826-1-matheus@castello.eng.br>
 <20191105054218.29826-5-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191105054218.29826-5-matheus@castello.eng.br>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 05, 2019 at 02:42:17AM -0300, Matheus Castello wrote:
> For configuration of fuel gauge alert for a low level state of charge
> interrupt we add a function to config level threshold and a device tree
> binding property to set it in flatned device tree node.
> 
> Now we can use "maxim,alert-low-soc-level" property with the values from
> 1% up to 32% to configure alert interrupt threshold.
> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  drivers/power/supply/max17040_battery.c | 96 +++++++++++++++++++++----
>  1 file changed, 82 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
> index 75459f76d02c..c48a691cbd7b 100644
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
> +	u32 low_soc_alert;
>  };
> 
>  static int max17040_get_property(struct power_supply *psy,
> @@ -99,6 +104,21 @@ static void max17040_reset(struct i2c_client *client)
>  	max17040_write_reg(client, MAX17040_CMD, 0x0054);
>  }
> 
> +static int max17040_set_low_soc_alert(struct i2c_client *client, u32 level)
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
> @@ -115,7 +135,6 @@ static void max17040_get_soc(struct i2c_client *client)
>  	u16 soc;
> 
>  	soc = max17040_read_reg(client, MAX17040_SOC);
> -
>  	chip->soc = (soc >> 8);
>  }
> 
> @@ -161,6 +180,24 @@ static void max17040_get_status(struct i2c_client *client)
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
> +				 &chip->low_soc_alert)) {
> +		chip->low_soc_alert = MAX17040_ATHD_DEFAULT_POWER_UP;
> +	} else if (chip->low_soc_alert <= 0 ||
> +			chip->low_soc_alert >= 33) {
> +		/* low_soc_alert is not between 1% and 32% */
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
>  static void max17040_check_changes(struct i2c_client *client)
>  {
>  	max17040_get_vcell(client);
> @@ -192,9 +229,27 @@ static irqreturn_t max17040_thread_handler(int id, void *dev)
>  	/* send uevent */
>  	power_supply_changed(chip->battery);
> 
> +	/* reset alert bit */
> +	max17040_set_low_soc_alert(client, chip->low_soc_alert);
> +
>  	return IRQ_HANDLED;
>  }
> 
> +static int max17040_enable_alert_irq(struct max17040_chip *chip)
> +{

It does not make really sense to move this code to separate function in
this patch. This should be done in patch 1/5. Otherwise you add a code
in patch 1 and later in patch 4 you immediately rearrange it. This
raises eybrows and gives a hint that patchset is not well structured.

> +	struct i2c_client *client = chip->client;
> +	unsigned int flags;
> +	int ret;
> +
> +	dev_info(&client->dev, "IRQ: enabled\n");

While at it, get rid of dev_info here. It does not bring any useful
information. All this is available in /proc/interrupts.

Best regards,
Krzysztof

> +	flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
> +	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +					max17040_thread_handler, flags,
> +					chip->battery->desc->name, chip);
> +
> +	return ret;
> +}
> +
>  static enum power_supply_property max17040_battery_props[] = {
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_ONLINE,
> @@ -216,6 +271,7 @@ static int max17040_probe(struct i2c_client *client,
>  	struct i2c_adapter *adapter = client->adapter;
>  	struct power_supply_config psy_cfg = {};
>  	struct max17040_chip *chip;
> +	int ret;
> 
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
>  		return -EIO;
> @@ -226,6 +282,12 @@ static int max17040_probe(struct i2c_client *client,
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
> @@ -242,20 +304,26 @@ static int max17040_probe(struct i2c_client *client,
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
> +					    "maxim,max77836-battery")) {
> +			ret = max17040_set_low_soc_alert(client,
> +							 chip->low_soc_alert);
> +			if (ret) {
> +				dev_err(&client->dev,
> +					"Failed to set low SOC alert: err %d\n",
> +					ret);
> +				return ret;
> +			}
> +
> +			ret = max17040_enable_alert_irq(chip);
> +			if (ret) {
> +				client->irq = 0;
> +				dev_warn(&client->dev,
> +					 "Failed to get IRQ err %d\n", ret);
> +			}
> +		} else {
>  			dev_warn(&client->dev,
> -				"Failed to get IRQ err %d\n", ret);
> +				 "Device not compatible for IRQ");
>  		}
>  	}
> 
> --
> 2.24.0.rc2
> 
