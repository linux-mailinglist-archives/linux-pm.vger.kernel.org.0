Return-Path: <linux-pm+bounces-25939-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5557AA9749D
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 20:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2930918964DA
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 18:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C481F0988;
	Tue, 22 Apr 2025 18:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhSxWrGe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF98D1624E1;
	Tue, 22 Apr 2025 18:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745347687; cv=none; b=FZTUU+PUTgeVxlw/OLDZJ+44+yNic9FGUO2J4AtrtxOhDrTn5sJY9e+wM3HyFG9vGgAgs7wdyWIpSJLdf0LhuR8IUJF0WEILJ/NyCTOfoNsNQS5A3fNXVhtK+vezZZKGeNmz1NgRHxVg1EtMTdiXsrs3nyi0hF/eGXWlTXGGYWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745347687; c=relaxed/simple;
	bh=vY2FFP8JNh045CJf3kl8GcWU+sAiyXl95+ZsVTPFyT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxV9Sa1aq4XkTQ4Z5dvEuvZDxFIT9Go/KyUCB3CwSkLcTK1Ep092iQUW/kcU+ckEAxKx9iND2TRPPSkxBFeDL5SsDfQw+X4Co8EocrBPXldIwjc2vZA8V78jHd1MzNeBVzP4ebTX+9SGvIs3VmEg0oRILwjqZYYcWfaWgQx1/rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhSxWrGe; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso38920885e9.1;
        Tue, 22 Apr 2025 11:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745347684; x=1745952484; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/k3taZkFmb1E65Ysug6YAb3iu1BOXVPDS/i79D+w5w4=;
        b=PhSxWrGe5TCdygbepdXFBDtqBtu8FGcpyQx37dyaTwXGIGKXyuWXsmbibf14kSJSm5
         a8cE6xHLpWDSSavNEHsbFl2mq2uqRP6rc5MtZD1FSmzpk+6UiuH4IPUJYLl6nacMGHGQ
         MWzbt5U/NTZL6n+hg3JBIFLCWeFCb7BqBYgDo0shiqN84C9do480jUterFPbU1mtZirS
         UgV6sgqYQvXrUzZiOEm0x4++Xn847HgXNEoml1ahvXPKW0dOSdI2oc1QD48/oFoVR0os
         jAQRP6ySPlMjItxQEgxrYiX7x2U//WQiY+ad26FzzPPIlWsB/IhCDZ2R5Qo4AxuK5z6b
         r1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745347684; x=1745952484;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/k3taZkFmb1E65Ysug6YAb3iu1BOXVPDS/i79D+w5w4=;
        b=ubNbf0ZlU4bg/14R25WoY+XrnWd3IMphiDx6/CzUQ8wGc2kPjt6vHsPFEmo2uS1BMQ
         Pqkm7q9YeaP5SMS0oq589FVKtjpCk81kGPRQN/au/XwLs40GvcX5eu2CXPFv8K4txRYH
         92I2FemkI77+/bbk29XyIegr5rk7lPq7oy6BFY65YzJqJzvdEMqMXEDplfGKqG6gX00p
         P2XKWKIrTQFot4e37rnIDWixDZc9FJNHk9QWsfAOIVv4CsNyRBFMOSuIXjKKYV6trIsB
         Wktx7ABem0BOJOyf9jUvzJa4GlOA/vBFotfziWDFwWBGk8J2RhAeiHgR2i7OUSlXTYBV
         mvMw==
X-Forwarded-Encrypted: i=1; AJvYcCUnXOtFZzNYdIZVxJ8ZhEX2MDcT3viQYD/vnTSklKczI2V5UV8HDTwW4vhfxfCkqPadli+HaH724Ug=@vger.kernel.org, AJvYcCXaX2myCcxqJp1RIpilvZWMezb+6nVcQbpYa8+twrml/ihlksMsUmj717aJtAAXvSmDTegKnG1dycqJwrziVBEN6F4=@vger.kernel.org, AJvYcCXbhzhINlSejMWK4JOIrrIudDKmCkfX8IojgUL2r56xwSV5q0mVPvo1dL08IfvW32zo9rlCsmFj3GkP@vger.kernel.org, AJvYcCXvfdEdVqaKNsshKh26J2JTr0QRU3y7gJfPy2Ver2Slb0SxY9NX5GQ4jJq/leNswVFw2XMBOIOkoYnYJYDx@vger.kernel.org
X-Gm-Message-State: AOJu0Yycc7XXOyk/CC5T8+dqbT1zYoMxMJhHSStfaJIqBR2hif5rct1y
	Lo3ah7CVCei/bS7UsEhDwlfN5KxlVQAd0TXpUkcAMPYQzo2FVsgS
X-Gm-Gg: ASbGncsA/TWKp28mWOUTTzmZfJYzoyorOzhcpOYTCJt2IyOeOC6VHXD+7j3yL2hmEo3
	1ZtQaEuUTd10LTqD98fV4T8tqZN4HmBTba6rSlbqF1NSlarHuwfY/3L4gavW5najzLwZhN6LMTb
	5uT0J7gTUer/juJq5coAu4gBLF8GlD6VKmCMFEq81oHUebj+Ba1WxWxjmRNPGRijr9V7NRWQEiz
	WLqGSMt2QKlt7H/iiDR4vgSkdXmF0utvs60SbugD0UQZgMsL9EIg1RnJ+9DnaOT5OHBRX9ZSTIt
	OWCrhoKuhLFobXSGrIh25Xordwsxe1+INAY6d50=
X-Google-Smtp-Source: AGHT+IG2j3VHoVL2M2AJ10p+sbssgxi4HaLuJQ31gFdOBcHjdA9awEAW09YZ0ryNYevSH+x3j+8Hxg==
X-Received: by 2002:a05:600c:3583:b0:43c:f689:dd with SMTP id 5b1f17b1804b1-4406abb3bd9mr125898075e9.19.1745347683820;
        Tue, 22 Apr 2025 11:48:03 -0700 (PDT)
Received: from legfed1 ([2a00:79c0:6a3:c300:22ea:3d6a:5919:85f8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5acc9esm187337825e9.13.2025.04.22.11.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 11:48:03 -0700 (PDT)
Date: Tue, 22 Apr 2025 20:48:01 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: t.antoine@uclouvain.be
Cc: Rob Herring <robh@kernel.org>, Peter Griffin <peter.griffin@linaro.org>,
	=?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/5] power: supply: add support for max77759 fuel gauge
Message-ID: <20250422184801.GA395455@legfed1>
References: <20250421-b4-gs101_max77759_fg-v3-0-50cd8caf9017@uclouvain.be>
 <20250421-b4-gs101_max77759_fg-v3-2-50cd8caf9017@uclouvain.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250421-b4-gs101_max77759_fg-v3-2-50cd8caf9017@uclouvain.be>

Hi Thomas,

On Mon, Apr 21, 2025 at 08:13:33PM +0200, Thomas Antoine via B4 Relay wrote:
> From: Thomas Antoine <t.antoine@uclouvain.be>
> 
> The interface of the Maxim MAX77759 fuel gauge has a lot of common with the
> Maxim MAX1720x. A major difference is the lack of non-volatile memory
> slave address. No slave is available at address 0xb of the i2c bus, which
> is coherent with the following driver from google: line 5836 disables
> non-volatile memory for m5 gauge.
> 
> Link: https://android.googlesource.com/kernel/google-modules/bms/+/1a68c36bef474573cc8629cc1d121eb6a81ab68c/max1720x_battery.c
> 
> Other differences include the lack of V_BATT register to read the battery
> level. The voltage must instead be read from V_CELL, the lowest voltage of
> all cells. The mask to identify the chip is different. The computation of
> the charge must also be changed to take into account TASKPERIOD, which
> can add a factor 2 to the result.
> 
> Add support for the MAX77759 by taking into account all of those
> differences based on chip type.
> 
> Do not advertise temp probes using the non-volatile memory as those are
> not available.
> 
> The regmap was proposed by André Draszik in
> 
> Link: https://lore.kernel.org/all/d1bade77b5281c1de6b2ddcb4dbbd033e455a116.camel@linaro.org/
> 
> Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
> ---
>  drivers/power/supply/max1720x_battery.c | 270 ++++++++++++++++++++++++++++----
>  1 file changed, 237 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/power/supply/max1720x_battery.c b/drivers/power/supply/max1720x_battery.c
> index cca5f8b5071fb731f9b60420239ea03d46cb1bf3..969d3a7c2baa7e1d23c5175942d975b277c8554c 100644
> --- a/drivers/power/supply/max1720x_battery.c
> +++ b/drivers/power/supply/max1720x_battery.c
> @@ -37,6 +37,7 @@
>  #define MAX172XX_REPCAP			0x05	/* Average capacity */
>  #define MAX172XX_REPSOC			0x06	/* Percentage of charge */
>  #define MAX172XX_TEMP			0x08	/* Temperature */
> +#define MAX172XX_VCELL			0x09	/* Lowest cell voltage */
>  #define MAX172XX_CURRENT		0x0A	/* Actual current */
>  #define MAX172XX_AVG_CURRENT		0x0B	/* Average current */
>  #define MAX172XX_FULL_CAP		0x10	/* Calculated full capacity */
> @@ -50,19 +51,32 @@
>  #define MAX172XX_DEV_NAME_TYPE_MASK	GENMASK(3, 0)
>  #define MAX172XX_DEV_NAME_TYPE_MAX17201	BIT(0)
>  #define MAX172XX_DEV_NAME_TYPE_MAX17205	(BIT(0) | BIT(2))
> +#define MAX77759_DEV_NAME_TYPE_MASK	GENMASK(15, 9)
> +#define MAX77759_DEV_NAME_TYPE_MAX77759	0x31
>  #define MAX172XX_QR_TABLE10		0x22
> +#define MAX77759_TASKPERIOD		0x3C
> +#define MAX77759_TASKPERIOD_175MS	0x1680
> +#define MAX77759_TASKPERIOD_351MS	0x2D00

I think it would be more readable if MAX77759_ defines are separated to
the MAX172XX defines instead of mixing them up.

>  #define MAX172XX_BATT			0xDA	/* Battery voltage */
>  #define MAX172XX_ATAVCAP		0xDF
>  
>  static const char *const max1720x_manufacturer = "Maxim Integrated";
>  static const char *const max17201_model = "MAX17201";
>  static const char *const max17205_model = "MAX17205";
> +static const char *const max77759_model = "MAX77759";
> +
> +enum chip_id {
> +	MAX1720X_ID,
> +	MAX77759_ID,
> +};
>  
>  struct max1720x_device_info {
>  	struct regmap *regmap;
>  	struct regmap *regmap_nv;
>  	struct i2c_client *ancillary;
>  	int rsense;
> +	int charge_full_design;

Don't see charge_full_design is used somewhere besides reading it from
device-tree and it isn't part of the bindings. If not needed, remove it.

> +	enum chip_id id;
>  };
>  
> 

[...]

> +static int max172xx_cell_voltage_to_ps(unsigned int reg)
> +{
> +	return reg * 625 / 8;	/* in uV */
> +}
> +
>  static int max172xx_capacity_to_ps(unsigned int reg,
> -				   struct max1720x_device_info *info)
> +				   struct max1720x_device_info *info,
> +				   int *intval)
>  {
> -	return reg * (500000 / info->rsense);	/* in uAh */
> +	int lsb = 1;
> +	int reg_val;

The naming of reg_val is somehow confusing because of reg. Better rename
it to something like reg_task_period or similar and reg_val should be of
type unsigned int. 

> +	int ret;
> +
> +	if (info->id == MAX77759_ID) {
> +		ret = regmap_read(info->regmap, MAX77759_TASKPERIOD, &reg_val);
> +		if (ret)
> +			return ret;
> +
> +		switch (reg_val) {
> +		case MAX77759_TASKPERIOD_175MS:
> +			break;
> +		case MAX77759_TASKPERIOD_351MS:
> +			lsb = 2;
> +			break;
> +		default:
> +			return -ENODEV;
> +		}
> +	}
> +	*intval = reg * (500000 / info->rsense) * lsb;	/* in uAh */
> +	return 0;

nit: add newline before return.

>  }
>  
>  /*
> @@ -306,6 +420,28 @@ static int max172xx_temperature_to_ps(unsigned int reg)
>  	return val * 10 / 256; /* in tenths of deg. C */
>  }
>  
> +static const char *max1720x_devname_to_model(unsigned int reg_val,
> +					     union power_supply_propval *val,
> +					     struct max1720x_device_info *info)
> +{
> +	switch (info->id) {
> +	case MAX1720X_ID:
> +		reg_val = FIELD_GET(MAX172XX_DEV_NAME_TYPE_MASK, reg_val);
> +		if (reg_val == MAX172XX_DEV_NAME_TYPE_MAX17201)
> +			return max17201_model;
> +		else if (reg_val == MAX172XX_DEV_NAME_TYPE_MAX17205)
> +			return max17205_model;
> +		return NULL;

nit: return NULL in else case.

> +	case MAX77759_ID:
> +		reg_val = FIELD_GET(MAX77759_DEV_NAME_TYPE_MASK, reg_val);
> +		if (reg_val == MAX77759_DEV_NAME_TYPE_MAX77759)
> +			return max77759_model;
> +		return NULL;

nit: return NULL in else case.

> +	default:
> +		return NULL;
> +	}
> +}
> +
>  /*
>   * Calculating current registers resolution:
>   *
> @@ -390,19 +526,31 @@ static int max1720x_battery_get_property(struct power_supply *psy,
>  		val->intval = max172xx_percent_to_ps(reg_val);
>  		break;
>  	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> -		ret = regmap_read(info->regmap, MAX172XX_BATT, &reg_val);
> -		val->intval = max172xx_voltage_to_ps(reg_val);
> +		if (info->id == MAX1720X_ID) {
> +			ret = regmap_read(info->regmap, MAX172XX_BATT, &reg_val);
> +			val->intval = max172xx_voltage_to_ps(reg_val);
> +		} else if (info->id == MAX77759_ID) {
> +			ret = regmap_read(info->regmap, MAX172XX_VCELL, &reg_val);
> +			val->intval = max172xx_cell_voltage_to_ps(reg_val);
> +		} else
> +			return -ENODEV;
>  		break;
>  	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
>  		ret = regmap_read(info->regmap, MAX172XX_DESIGN_CAP, &reg_val);
> -		val->intval = max172xx_capacity_to_ps(reg_val);
> +		if (ret)
> +			break;

I would keep max172xx_capacity_to_ps as it was before and add the
calculation for the MAX77759 after handling the MAX1720X case. Creating
a function max77759_capacity_to_ps that further processes the value
calculated by max172xx_capacity_to_ps or just inline this code.
Otherwise the naming of the function is somehow confusing.

> +		ret = max172xx_capacity_to_ps(reg_val, info, &val->intval);
>  		break;
>  	case POWER_SUPPLY_PROP_CHARGE_AVG:
>  		ret = regmap_read(info->regmap, MAX172XX_REPCAP, &reg_val);
> -		val->intval = max172xx_capacity_to_ps(reg_val);
> +		if (ret)
> +			break;
> +

Same as above.

> +		ret = max172xx_capacity_to_ps(reg_val, info, &val->intval);
>  		break;
>  	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
>  		ret = regmap_read(info->regmap, MAX172XX_TTE, &reg_val);
> +		pr_info("RAW TTE: %d", reg_val);

Remove pr_info.

>  		val->intval = max172xx_time_to_ps(reg_val);
>  		break;
>  	case POWER_SUPPLY_PROP_TIME_TO_FULL_AVG:
> @@ -423,17 +571,15 @@ static int max1720x_battery_get_property(struct power_supply *psy,
>  		break;
>  	case POWER_SUPPLY_PROP_CHARGE_FULL:
>  		ret = regmap_read(info->regmap, MAX172XX_FULL_CAP, &reg_val);
> -		val->intval = max172xx_capacity_to_ps(reg_val);

...

> +		if (ret)
> +			break;
> +		ret = max172xx_capacity_to_ps(reg_val, info, &val->intval);
>  		break;
>  	case POWER_SUPPLY_PROP_MODEL_NAME:
>  		ret = regmap_read(info->regmap, MAX172XX_DEV_NAME, &reg_val);
> -		reg_val = FIELD_GET(MAX172XX_DEV_NAME_TYPE_MASK, reg_val);
> -		if (reg_val == MAX172XX_DEV_NAME_TYPE_MAX17201)
> -			val->strval = max17201_model;
> -		else if (reg_val == MAX172XX_DEV_NAME_TYPE_MAX17205)
> -			val->strval = max17205_model;
> -		else
> -			return -ENODEV;
> +		val->strval = max1720x_devname_to_model(reg_val, val, info);

Wouldn't it be better to just inline this function ?

> +		if (!val->strval)
> +			ret = -ENODEV;
>  {

[...]

>  	struct power_supply_config psy_cfg = {};
>  	struct device *dev = &client->dev;
>  	struct max1720x_device_info *info;
>  	struct power_supply *bat;
> +	const struct chip_data *data;
> +	const struct power_supply_desc *bat_desc;
>  	int ret;
>  
>  	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
>  	if (!info)
>  		return -ENOMEM;
>  
> +	data = device_get_match_data(dev);
> +	if (!data)
> +		return dev_err_probe(dev, -EINVAL, "Failed to get chip data\n");
> +
>  	psy_cfg.drv_data = info;
>  	psy_cfg.fwnode = dev_fwnode(dev);
> -	psy_cfg.attr_grp = max1720x_groups;
> +	switch (data->id) {
> +	case MAX1720X_ID:
> +		psy_cfg.attr_grp = max1720x_groups;
> +		bat_desc = &max1720x_bat_desc;
> +		break;
> +	case MAX77759_ID:
> +		bat_desc = &max77759_bat_desc;
> +		break;
> +	default:
> +		return dev_err_probe(dev, -EINVAL, "Unsupported chip\n");
> +	}

nit: add empty line

>  	i2c_set_clientdata(client, info);
> -	info->regmap = devm_regmap_init_i2c(client, &max1720x_regmap_cfg);
> +
> +	info->id = data->id;
> +	info->regmap = devm_regmap_init_i2c(client, data->regmap_cfg);
>  	if (IS_ERR(info->regmap))
>  		return dev_err_probe(dev, PTR_ERR(info->regmap),
>  				     "regmap initialization failed\n");
>  
> -	ret = max1720x_probe_nvmem(client, info);
> +	if (data->has_nvmem) {
> +		ret = max1720x_probe_nvmem(client, info);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to probe nvmem\n");
> +	}
> +
> +	ret = of_property_read_u32(dev->of_node,
> +				   "charge-full-design-microamp-hours", &info->charge_full_design);
> +	if (ret)
> +		info->charge_full_design = 0;
> +
> +	ret = max1720x_get_rsense(dev, info, data);
>  	if (ret)
> -		return dev_err_probe(dev, ret, "Failed to probe nvmem\n");
> +		return dev_err_probe(dev, ret, "Failed to get RSense\n");
>  
> -	bat = devm_power_supply_register(dev, &max1720x_bat_desc, &psy_cfg);
> +	bat = devm_power_supply_register(dev, bat_desc, &psy_cfg);
>  	if (IS_ERR(bat))
>  		return dev_err_probe(dev, PTR_ERR(bat),
>  				     "Failed to register power supply\n");
> @@ -613,7 +816,8 @@ static int max1720x_probe(struct i2c_client *client)
>  }
>  
>  static const struct of_device_id max1720x_of_match[] = {
> -	{ .compatible = "maxim,max17201" },
> +	{ .compatible = "maxim,max17201", .data = (void *) &max1720x_data },
> +	{ .compatible = "maxim,max77759-fg", .data = (void *) &max77759_data },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, max1720x_of_match);
> 
> -- 
> 2.49.0
> 
> 

Best regards,
Dimitri Fedrau

