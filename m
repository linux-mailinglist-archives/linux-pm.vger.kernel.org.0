Return-Path: <linux-pm+bounces-19990-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4382CA028F1
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 16:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EEF8164417
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 15:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121DF158A1F;
	Mon,  6 Jan 2025 15:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYrQlBSM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB291547F2;
	Mon,  6 Jan 2025 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736176618; cv=none; b=GeSMoG+X/utIepUpTYDBSONJc8acAwnlaQZqBufEu5yBYPtz7xVsq0RtSjUgrP6xMw+c3bSi21viLTL7gClqXu4ZOJHYrzqT9Ge/UYIkQTtHmTUHaVYWhtfQLWToDkoQDhAp/sOuU4Yesz6DvpfI59C4ZzjLcx8jbsB6q6uds3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736176618; c=relaxed/simple;
	bh=J+Y8OL7oG0PqEI4D0x3j09u744z8WiuT1O1WeIUAbrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6IOrCQAFioAI97Q6pWvMjmSuBVXK1Ye1lY0NamUKO0OADyivbWloEMSp4Kz6nGpCZ9yHfKUwa4Zegq2CNk38jrl9C6obegjWS0tXVOE14+vKmPi2Q3oNAfUBaWJyCoqC5+pa89i9n4DYNdn/RRCrvUJaAJA/0YeuDT6OA7jH30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYrQlBSM; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4361fe642ddso151922205e9.2;
        Mon, 06 Jan 2025 07:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736176615; x=1736781415; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D0SpWPvZ88/rzaKxyWdiuzAOb2of6E+MdGH8hOo2Dzk=;
        b=hYrQlBSMPSeQKdfCnYkUTEpPpCJh177m3YobBA+IAgoOyCIhbeoPeNRHggAdKP62Uv
         sZYshRsa2n1E3qSnqLf/0ZUP9FZyfOP3ZJDoNfgodTQyE/OU7NCC2AsdTtmAt9CASmZJ
         /1hnb0tMfZkMyphAoBwumGfkTecO2d1M4TPqb/86YQq39VvnwT8AWICk5veUQEqjJwmd
         SGVMcdiDePJWCu4x0jAzc57LhINlzTOO+dpyL+mbv34mziqGDfNMP9mCp49ZuKt7Qy87
         uvziXZ5i+9odMbEB1b/ZwJ1fA1TFde7RtREmd/JPXsHgdZmkxPjluOn7kRr3Nk2c+DeM
         N6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736176615; x=1736781415;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D0SpWPvZ88/rzaKxyWdiuzAOb2of6E+MdGH8hOo2Dzk=;
        b=tw0br3jhjqlmaZTMh4TKF41QIX9ltqA1kkMhVmXaqaPWOodqbI2ddIfPG3vPqbYX1E
         Ga6jxQBCojveB8TtuyFhCUrowzqecG7QHVVtaF9UShN4skSiAo3zDmtvc+I0EkX2idKC
         OdegWDROJg1hZd+O0LSHKdxsgua4sWzmeKN4tISiLAwZVvF8/ZDWqlu8iz1PtRehlT6L
         vVRJxD459gtivmEbeji4PdWy6eygVXZgTzO8PXlVY8NTQ9y0We/7RHXK8qTTpb6bzSTw
         Hqg8/ToZaSq9uXWA3TWa5Xjx1rxlV+6NV0fQ+gLptE6U0FzlMOuvqS9Ck8fkWrYNA+pe
         jmRA==
X-Forwarded-Encrypted: i=1; AJvYcCUefTVJbTRJ8MYVaP64CBj5W7mYev1IC82qjgC9peJRG5E1JOlN/saONT7cUq7Vv5axG/R8tgHWd59R@vger.kernel.org, AJvYcCUrwE94M0+lp3+uv8p5xGfAmdx63Xc0pLDCJ6r8t94GfjXeGBP03Zs+0OKft9fV4jklHv3JfLO9fzo=@vger.kernel.org, AJvYcCVqGCjc0fiN95JjfZcmUnNK3B4h7N+EG6pbPtaqsNl7gLczw0Jrta9C4+/8/Gkz30TGCTt7u0PpmNWsjWDr@vger.kernel.org, AJvYcCWG0O4HbrI8jZ9ShYWv7rVJ/ekS940pjx1Y3vb3y+aApD8syqMqLTP4NuLPub5KbVhM5I/QLBObt6+UKV8hZz9+fKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCeTo9ZNMPJ7xwRLyhtbi3J+AHF5Gg2cqk8lkTw5wydI7PBHHC
	dWuVA5yFS6MOh7r0LXZwSt2lprMAB4ugL5yU440l8O6F6plOomnT
X-Gm-Gg: ASbGncvfTsKt/msiqvh5mLEIvJ1EvGvAtrZ0N2u2URCKwSnd0dKw/sHvLJnBn7+EZ6Y
	Q1vLqRGGGK/XsjLBZDkupOfVpnjUIraVOlJUHPJK58oOo+bM3JPRDcwB1vEv4F+cEAemTUvsU1E
	x+XSLx19Vr6vk+jT/6jjL2AowPe8MT8zxnl3hFk5i0o4v+K4BC4nL7xyArrs0kcCwJPjazTJ4B9
	6DZTlu0sBACRtH+1tmaj1lV8xXDmIES9fi1kySj/mvoBROp9/r7
X-Google-Smtp-Source: AGHT+IEUBeiOgEHbVhzVNtQ3RIq3O18XCjU6p+FX6N1nz8U/rZB8Y7Ul/j2h4pIGjNXdeV8+jymP3Q==
X-Received: by 2002:a5d:5848:0:b0:385:df6d:6fc7 with SMTP id ffacd0b85a97d-38a221f2e4emr49306826f8f.25.1736176614813;
        Mon, 06 Jan 2025 07:16:54 -0800 (PST)
Received: from debian ([2a00:79c0:63f:e400:224:9bff:fe22:6dd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8330d4sm47550913f8f.29.2025.01.06.07.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 07:16:54 -0800 (PST)
Date: Mon, 6 Jan 2025 16:16:51 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: t.antoine@uclouvain.be
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	=?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 1/4] power: supply: add support for max77759 fuel gauge
Message-ID: <20250106151651.GA14942@debian>
References: <20250102-b4-gs101_max77759_fg-v2-0-87959abeb7ff@uclouvain.be>
 <20250102-b4-gs101_max77759_fg-v2-1-87959abeb7ff@uclouvain.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250102-b4-gs101_max77759_fg-v2-1-87959abeb7ff@uclouvain.be>

Hi Thomas,

Am Thu, Jan 02, 2025 at 12:15:03PM +0100 schrieb Thomas Antoine via B4 Relay:
> From: Thomas Antoine <t.antoine@uclouvain.be>
> 
> The interface of the Maxim max77759 fuel gauge has a lot of common with the
> Maxim max1720x. The major difference is the lack of non-volatile memory
> slave address. No slave is available at address 0xb of the i2c bus, which
> is coherent with the following driver from google: line 5836 disables
> non-volatile memory for m5 gauge.
> 
> Link: https://android.googlesource.com/kernel/google-modules/bms/+/1a68c36bef474573cc8629cc1d121eb6a81ab68c/max1720x_battery.c
> 
> Other differences include the lack of V_BATT register to read the battery
> level and a difference in the way to identify the chip (the same register
> is used but not the same mask).
> 
> Add support for the max77759 by allowing to use the non-volatile
> memory or not based on the chip. Also add the V_CELL regsister as a
> fallback to read voltage value in the case where read of V_BATT fails.
> 
> The cast is necessary to avoid an overflow when the value of the register
> is above 54975 (equivalent to a voltage around 4.29 V).
> 
> The regmap of the max77759 will lead the read to fail for V_BATT and to
> correctly use V_CELL instead. This regmap was proposed by André Draszik in
> 
> Link: https://lore.kernel.org/all/d1bade77b5281c1de6b2ddcb4dbbd033e455a116.camel@linaro.org/
> 
> Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
> ---
>  drivers/power/supply/max1720x_battery.c | 189 +++++++++++++++++++++++++++-----
>  1 file changed, 164 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/power/supply/max1720x_battery.c b/drivers/power/supply/max1720x_battery.c
> index 33105419e2427bb37963bda9948b647c239f8faa..a41976679eded44fbd13120ad756a626d2867919 100644
> --- a/drivers/power/supply/max1720x_battery.c
> +++ b/drivers/power/supply/max1720x_battery.c
> @@ -27,6 +27,7 @@
>  #define MAX172XX_REPCAP			0x05	/* Average capacity */
>  #define MAX172XX_REPSOC			0x06	/* Percentage of charge */
>  #define MAX172XX_TEMP			0x08	/* Temperature */
> +#define MAX172XX_VCELL			0x09	/* Lowest cell voltage */
>  #define MAX172XX_CURRENT		0x0A	/* Actual current */
>  #define MAX172XX_AVG_CURRENT		0x0B	/* Average current */
>  #define MAX172XX_TTE			0x11	/* Time to empty */
> @@ -39,6 +40,8 @@
>  #define MAX172XX_DEV_NAME_TYPE_MASK	GENMASK(3, 0)
>  #define MAX172XX_DEV_NAME_TYPE_MAX17201	BIT(0)
>  #define MAX172XX_DEV_NAME_TYPE_MAX17205	(BIT(0) | BIT(2))
> +#define MAX77759_DEV_NAME_TYPE_MASK	GENMASK(15, 9)
> +#define MAX77759_DEV_NAME_TYPE_MAX77759	0x31
>  #define MAX172XX_QR_TABLE10		0x22
>  #define MAX172XX_BATT			0xDA	/* Battery voltage */
>  #define MAX172XX_ATAVCAP		0xDF
> @@ -46,12 +49,20 @@
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
> +	int has_nvmem;

Switch to bool and why is needed twice ? Here and in chip_data. Better
keep it in chip_data.

> +	enum chip_id id;
>  };
>  
>  /*
> @@ -254,6 +265,67 @@ static const enum power_supply_property max1720x_battery_props[] = {
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  };
>  
> +/*
> + * Registers 0x80 up to 0xaf which contain the model for the fuel gauge
> + * algorithm (stored in nvmem for the max1720x) are locked. They can
> + * be unlocked by writing 0x59 to 0x62 and 0xc4 to 0x63. They should be
> + * enabled in the regmap if the driver is extended to manage the model.
> + */
> +static const struct regmap_range max77759_registers[] = {
> +	regmap_reg_range(0x00, 0x4f),
> +	regmap_reg_range(0xb0, 0xbf),
> +	regmap_reg_range(0xd0, 0xd0),
> +	regmap_reg_range(0xdc, 0xdf),
> +	regmap_reg_range(0xfb, 0xfb),
> +	regmap_reg_range(0xff, 0xff),
> +};
> +
> +static const struct regmap_range max77759_ro_registers[] = {
> +	regmap_reg_range(0x3d, 0x3d),
> +	regmap_reg_range(0xfb, 0xfb),
> +	regmap_reg_range(0xff, 0xff),
> +};
> +
> +static const struct regmap_access_table max77759_write_table = {
> +	.yes_ranges = max77759_registers,
> +	.n_yes_ranges = ARRAY_SIZE(max77759_registers),
> +	.no_ranges = max77759_ro_registers,
> +	.n_no_ranges = ARRAY_SIZE(max77759_ro_registers),
> +};
> +
> +static const struct regmap_access_table max77759_rd_table = {
> +	.yes_ranges = max77759_registers,
> +	.n_yes_ranges = ARRAY_SIZE(max77759_registers),
> +};
> +
> +static const struct regmap_config max77759_regmap_cfg = {
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.max_register = 0xff,
> +	.wr_table = &max77759_write_table,
> +	.rd_table = &max77759_rd_table,
> +	.val_format_endian = REGMAP_ENDIAN_LITTLE,
> +	.cache_type = REGCACHE_NONE,
> +};
> +
> +struct chip_data {
> +	u8 has_nvmem;
> +	const struct regmap_config *regmap_cfg;
> +	enum chip_id id;
> +};
> +
> +static const struct chip_data max1720x_data  = {
> +	.has_nvmem = 1,
> +	.regmap_cfg = &max1720x_regmap_cfg,
> +	.id = MAX1720X_ID,
> +};
> +
> +static const struct chip_data max77759_data = {
> +	.has_nvmem = 0,
> +	.regmap_cfg = &max77759_regmap_cfg,
> +	.id = MAX77759_ID,
> +};
> +
>  /* Convert regs value to power_supply units */
>  
>  static int max172xx_time_to_ps(unsigned int reg)
> @@ -271,6 +343,14 @@ static int max172xx_voltage_to_ps(unsigned int reg)
>  	return reg * 1250;	/* in uV */
>  }
>  
> +// Use 64 bits because computation on 32 bits leads to an overflow
> +static int max172xx_cell_voltage_to_ps(unsigned int reg)
> +{
> +	u64 val = reg;
> +
> +	return val * 78125 / 1000;	/* in uV */

You could avoid the overflow with:
	return val * 625 / 8;	/* in uV */
> +}
> +
>  static int max172xx_capacity_to_ps(unsigned int reg)
>  {
>  	return reg * 500;	/* in uAh */
> @@ -303,6 +383,33 @@ static int max172xx_current_to_voltage(unsigned int reg)
>  	return val * 156252;
>  }
>  
> +static int max1720x_devname_to_model(unsigned int reg_val,
> +					union power_supply_propval *val,
> +					struct max1720x_device_info *info)

nit: Align with open parenthesis

> +{
> +	switch (info->id) {
> +	case MAX1720X_ID:
> +		reg_val = FIELD_GET(MAX172XX_DEV_NAME_TYPE_MASK, reg_val);
> +		if (reg_val == MAX172XX_DEV_NAME_TYPE_MAX17201)
> +			val->strval = max17201_model;
> +		else if (reg_val == MAX172XX_DEV_NAME_TYPE_MAX17205)
> +			val->strval = max17205_model;
> +		else
> +			return -ENODEV;
> +		break;
> +	case MAX77759_ID:
> +		reg_val = FIELD_GET(MAX77759_DEV_NAME_TYPE_MASK, reg_val);
> +		if (reg_val == MAX77759_DEV_NAME_TYPE_MAX77759)
> +			val->strval = max77759_model;
> +		else
> +			return -ENODEV;
> +		break;
> +	default:
> +		return -ENODEV;
> +	}
> +	return 0;
> +}
> +
>  static int max1720x_battery_get_property(struct power_supply *psy,
>  					 enum power_supply_property psp,
>  					 union power_supply_propval *val)
> @@ -332,7 +439,12 @@ static int max1720x_battery_get_property(struct power_supply *psy,
>  		break;
>  	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>  		ret = regmap_read(info->regmap, MAX172XX_BATT, &reg_val);
> -		val->intval = max172xx_voltage_to_ps(reg_val);
> +		if (!ret)
> +			val->intval = max172xx_voltage_to_ps(reg_val);
> +		else {
> +			ret = regmap_read(info->regmap, MAX172XX_VCELL, &reg_val);
> +			val->intval = max172xx_cell_voltage_to_ps(reg_val);
> +		}

Would be better to read the right register, since we know which device
we are. You could differentiate like in max1720x_devname_to_model.

>  		break;
>  	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
>  		ret = regmap_read(info->regmap, MAX172XX_DESIGN_CAP, &reg_val);
> @@ -364,13 +476,8 @@ static int max1720x_battery_get_property(struct power_supply *psy,
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
> +		if (!ret)
> +			ret = max1720x_devname_to_model(reg_val, val, info);
>  		break;
>  	case POWER_SUPPLY_PROP_MANUFACTURER:
>  		val->strval = max1720x_manufacturer;
> @@ -416,7 +523,6 @@ static int max1720x_probe_nvmem(struct i2c_client *client,
>  		.priv = info,
>  	};
>  	struct nvmem_device *nvmem;
> -	unsigned int val;
>  	int ret;
>  
>  	info->ancillary = i2c_new_ancillary_device(client, "nvmem", 0xb);
> @@ -438,18 +544,6 @@ static int max1720x_probe_nvmem(struct i2c_client *client,
>  		return PTR_ERR(info->regmap_nv);
>  	}
>  
> -	ret = regmap_read(info->regmap_nv, MAX1720X_NRSENSE, &val);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to read sense resistor value\n");
> -		return ret;
> -	}
> -
> -	info->rsense = val;
> -	if (!info->rsense) {
> -		dev_warn(dev, "RSense not calibrated, set 10 mOhms!\n");
> -		info->rsense = 1000; /* in regs in 10^-5 */
> -	}
> -
>  	nvmem = devm_nvmem_register(dev, &nvmem_config);
>  	if (IS_ERR(nvmem)) {
>  		dev_err(dev, "Could not register nvmem!");
> @@ -459,6 +553,36 @@ static int max1720x_probe_nvmem(struct i2c_client *client,
>  	return 0;
>  }
>  
> +static int max1720x_get_rsense(struct device *dev,
> +					 struct max1720x_device_info *info)

nit: Align with open parenthesis.

> +{
> +	unsigned int val;
> +	int ret;
> +
> +	if (info->has_nvmem) {
> +		ret = regmap_read(info->regmap_nv, MAX1720X_NRSENSE, &val);
> +		if (ret < 0) {
> +			dev_err(dev, "Failed to read RSense from nvmem\n");
> +			return ret;
> +		}
> +
> +		info->rsense = val;
> +		if (!info->rsense) {
> +			dev_warn(dev, "RSense not calibrated, set 10 mOhms!\n");
> +			info->rsense = 1000; /* in regs in 10^-5 */
> +		}
> +	} else {
> +		ret = of_property_read_u32(dev->of_node,
> +					"shunt-resistor-micro-ohms", &val);

nit: Align with open parenthesis.

> +		if (ret) {
> +			dev_err(dev, "Failed to read RSense from devicetree\n");
> +			return ret;
> +		}
> +		info->rsense = val/10;
> +	}
> +	return 0;
> +}
> 
[...]

Best regards,
Dimitri Fedrau

