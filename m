Return-Path: <linux-pm+bounces-32529-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EF5B29F2D
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 12:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368A2189AFEC
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 10:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F9F17B50F;
	Mon, 18 Aug 2025 10:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOCJ2f6X"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7837C2C2343;
	Mon, 18 Aug 2025 10:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755513192; cv=none; b=HmiENFQjqRI9mz/bqrH3fYTShayJ13hvF41io2ZFs+8rCv8upgcMrAmqXenjFNI4wsdUM8f4i1fTAIDYN9Mps+SRmMv64nPjhZf9u79vIM87rdpgHD3NWUvKuhF5Gnon/9gbkHAwTZKnPlHn9CoxPRQoWN/s90JesiqSf9YYcag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755513192; c=relaxed/simple;
	bh=HliApHKwwsPpUp4VvGK2RDaVkcFJEcqTWnOm4FniFrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QFcU/w5oUi8RL/+gTPTdn62wmvDtvCjZeL28CizXGmD/5Tvo1E0yQ42eYq8gGRbXDHTo32ccK6eU2ZGNX7fOCFTPE4zODlctnvaLBek23loN2AWnNkGLpCpinGxn5I582ip1iH3WkQGTF+V7AMCmVQxhOFl7bc4nt8W+ErOkccU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOCJ2f6X; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55ce5247da6so4101906e87.2;
        Mon, 18 Aug 2025 03:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755513189; x=1756117989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5HVvDl2TKVMOM9c7UG2rJaLgYS0GchXaiezoPP3NMzY=;
        b=hOCJ2f6XJ7HNmzAFgmXu2oHEKCOQ/5ONwr1mt3Zepkh24QgAeIoH0A8vCMxvSb6cKx
         mHCi8NPToHpvmuv9GUcs43UnLj6CAEUwL/RQZiUh1/Cf3xfGxF2Wh164rLS6b1z3bamS
         zDT4dUXOhxMedYbd78JmreP1VP6S5iAEkHSxG2tAZRRl7ZjUwCCOh3v61zGc57CQwTVe
         4l8LVbbMXy0r8GPEGofhqAEEARMc+Nid8y2rL62YehqAj2fIn7Ep7745WQVx3aMBUVwL
         597U2qi+KLHma6ufHzcf05rG8kfENpv4aDcJqPn2qaCWwiO2hjuu/iGy+/jNI/b5Slwf
         Ir8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755513189; x=1756117989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5HVvDl2TKVMOM9c7UG2rJaLgYS0GchXaiezoPP3NMzY=;
        b=FvLxhr7dPUELOqjDOofCDXxuEolcXjcdpe+J+8OTCYVtVJeNLfAAkorGSb3hHimNSP
         X2HAua0kCLlugbKS0wVpHpt7rf0DzZCUUupJAOd0GXsZO3P/eDnkSwvdVRSE1HK5AVIT
         PmCHhB5jNJAZXpIcoD96hu+blBQZVnTmS+1fZTPKw5joOjMW6Zneoy5gdBmQCuPGMiSG
         QtVgZqY+dySqSbLM5/Jl8P/ZUjQt5lMCeLVQIkW3veyHFQunz3MUQYGvkBmVum/uZamO
         zWT3c99NkZ1VoAwcKaXPR3W/zWUNd1aUgtNbelzqf47SPu15c/DGUc7xjscI4V4AKJVw
         EHBg==
X-Forwarded-Encrypted: i=1; AJvYcCWwN7PpZ9uDyOvH2be+paa1QO6KByt4ZCZCeW2YYMYxSoQZCCdrSQNSynRgk9n+e8IqPlXkKSKm0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmXr/igsF7dgepwmwsdp99sfP62hNi7ocmqZGKcNW745qrc5CK
	xEZ5+fgZOpzh/Gvytw8jJWgOPrTrWEGHWSddadpMT1rHYB4J+MC88kv5
X-Gm-Gg: ASbGncsdAizDiZLEl279xMhHa8NHYs0M9I/h8Y2mXaeRko2w1z++w5Z/pGUx/S3eRjE
	RZikqRG95QaM7f0dG9QpMN1w8s54hxse/Sr3R8gwM7xd5WEmJcxWvLIcYGIJ2ZM9LZgqrHnqT40
	BLWrfL9ckS8GEMEiNrvMS2YlgJ3YXEHSrZeScE6kPC0V2GqC1deWZPJ8YhzGpBFFHolsYzOEUJV
	7RO/QRnDPjzULbbXfKquaEvIVaca/4O+aBjTDU4lEqGodYFMZte8uR7T+LFX5V/9EJdFxSG12kP
	reRcw966P6IwVmwf8t7eL/fkib0bvJpEg6fKQbRLEpJIVQgtjobVwOtncauCXoOYgh+/kQIo6w6
	fg8y/LpMABlhrlpSrZd5fR53Sw/ZLOxbjokNG5gmGvjoimzVQtPM8BNs2y/4gS9HfzQcUz+0Sfa
	EyCMcu4DGnS3kKgQ==
X-Google-Smtp-Source: AGHT+IHPPzF04VDTVu3ihBrTGMCImipGwTWe+/WmUAsOkA2i4IBa3+qgGLcAqXg52UP2CGSS+iViBQ==
X-Received: by 2002:ac2:4bd2:0:b0:553:3314:adcf with SMTP id 2adb3069b0e04-55cf2c8ac3bmr2549095e87.5.1755513188379;
        Mon, 18 Aug 2025 03:33:08 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef351a15sm1595997e87.2.2025.08.18.03.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 03:33:06 -0700 (PDT)
Message-ID: <33880bc8-40af-42f0-b962-cc5214c7b330@gmail.com>
Date: Mon, 18 Aug 2025 13:33:05 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] power: supply: Add bd718(15/28/78) charger driver
To: Andreas Kemnade <andreas@kemnade.info>, Lee Jones <lee@kernel.org>,
 Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250816-bd71828-charger-v1-0-71b11bde5c73@kemnade.info>
 <20250816-bd71828-charger-v1-2-71b11bde5c73@kemnade.info>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250816-bd71828-charger-v1-2-71b11bde5c73@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/08/2025 22:19, Andreas Kemnade wrote:
> Add charger driver for ROHM BD718(15/28/78) PMIC charger block.
> It is a stripped down version of the driver here:
> https://lore.kernel.org/lkml/dbd97c1b0d715aa35a8b4d79741e433d97c562aa.1637061794.git.matti.vaittinen@fi.rohmeurope.com/
> 
> For the ease of review and to do a step-by-step approach remove all the
> coloumb counter related stuff and do not sneak in BD71827 support.
> 
> Changes besides that:
> Replace the custom property by a standard one and do not use megaohms
> for the current sense resistor.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>   drivers/power/supply/Kconfig         |   11 +
>   drivers/power/supply/Makefile        |    1 +
>   drivers/power/supply/bd71828-power.c | 1144 ++++++++++++++++++++++++++++++++++
>   3 files changed, 1156 insertions(+)
> 
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 79ddb006e2dad6bf96b71ed570a37c006b5f9433..f3429f0aecf5a17fbaa52ee76899657181429a48 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -974,6 +974,17 @@ config CHARGER_UCS1002
>   	  Say Y to enable support for Microchip UCS1002 Programmable
>   	  USB Port Power Controller with Charger Emulation.
>   
> +config CHARGER_BD71828
> +	tristate "Power-supply driver for ROHM BD71828 and BD71815 PMIC"
> +	depends on MFD_ROHM_BD71828
> +	select POWER_SIMPLE_GAUGE
> +	help
> +	  Say Y here to enable support for charger, battery and fuel gauge

Maybe drop the fuel-gauge?

> +	  in ROHM BD71815, BD71817, ROHM BD71828 power management
> +	  ICs. This driver gets various bits of information about battery
> +	  and charger states and also implements fuel gauge based on
> +	  coulomb counters on PMIC.
> +
>   config CHARGER_BD99954
>   	tristate "ROHM bd99954 charger driver"
>   	depends on I2C
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index f943c9150b326d41ff241f82610f70298635eb08..c6520a11f021c872f01250ae54eb4c63018cd428 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -113,6 +113,7 @@ obj-$(CONFIG_CHARGER_SC2731)	+= sc2731_charger.o
>   obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+= sc27xx_fuel_gauge.o
>   obj-$(CONFIG_FUEL_GAUGE_STC3117)       += stc3117_fuel_gauge.o
>   obj-$(CONFIG_CHARGER_UCS1002)	+= ucs1002_power.o
> +obj-$(CONFIG_CHARGER_BD71828)	+= bd71828-power.o
>   obj-$(CONFIG_CHARGER_BD99954)	+= bd99954-charger.o
>   obj-$(CONFIG_CHARGER_WILCO)	+= wilco-charger.o
>   obj-$(CONFIG_RN5T618_POWER)	+= rn5t618_power.o
> diff --git a/drivers/power/supply/bd71828-power.c b/drivers/power/supply/bd71828-power.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..f2686c7eadf0515856d60123f57bca59b33bbd10
> --- /dev/null
> +++ b/drivers/power/supply/bd71828-power.c
> @@ -0,0 +1,1144 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * bd71828-power.c
> + * @file ROHM BD71815, BD71828 and BD71878 Charger driver
> + *
> + * Copyright 2021.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/rohm-bd71815.h>
> +#include <linux/mfd/rohm-bd71828.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +
> +/* common defines */
> +#define BD7182x_MASK_VBAT_U			0x1f
> +#define BD7182x_MASK_VDCIN_U			0x0f
> +#define BD7182x_MASK_IBAT_U			0x3f
> +#define BD7182x_MASK_CURDIR_DISCHG		0x80
> +#define BD7182x_MASK_CC_CCNTD_HI		0x0FFF
> +#define BD7182x_MASK_CC_CCNTD			0x0FFFFFFF
> +#define BD7182x_MASK_CHG_STATE			0x7f
> +#define BD7182x_MASK_CC_FULL_CLR		0x10
> +#define BD7182x_MASK_BAT_TEMP			0x07
> +#define BD7182x_MASK_DCIN_DET			BIT(0)
> +#define BD7182x_MASK_CONF_PON			BIT(0)
> +#define BD71815_MASK_CONF_XSTB			BIT(1)
> +#define BD7182x_MASK_BAT_STAT			0x3f
> +#define BD7182x_MASK_DCIN_STAT			0x07
> +
> +#define BD7182x_MASK_CCNTRST			0x80
> +#define BD7182x_MASK_CCNTENB			0x40
> +#define BD7182x_MASK_CCCALIB			0x20

I suppose unused defines could get cleared. (At least the CC related 
ones)...

> +#define BD7182x_MASK_WDT_AUTO			0x40
> +#define BD7182x_MASK_VBAT_ALM_LIMIT_U		0x01
> +#define BD7182x_MASK_CHG_EN			0x01
> +
> +#define BD7182x_DCIN_COLLAPSE_DEFAULT		0x36
> +
> +/* Measured min and max value clear bits */
> +#define BD718XX_MASK_VSYS_MIN_AVG_CLR		0x10
> +
> +#define JITTER_DEFAULT				3000

...Also the loop jitter

> +#define MAX_CURRENT_DEFAULT			890000		/* uA */
> +#define AC_NAME					"bd71828_ac"
> +#define BAT_NAME				"bd71828_bat"
> +
> +/*
> + * VBAT Low voltage detection Threshold
> + * 0x00D4*16mV = 212*0.016 = 3.392v
> + */
> +#define VBAT_LOW_TH			0x00D4
> +
> +#define THR_RELAX_CURRENT_DEFAULT		5		/* mA */
> +#define THR_RELAX_TIME_DEFAULT			(60 * 60)	/* sec. */
> +
> +#define DGRD_CYC_CAP_DEFAULT			88	/* 1 micro Ah */
> +
> +#define DGRD_TEMP_H_DEFAULT			450	/* 0.1 degrees C */
> +#define DGRD_TEMP_M_DEFAULT			250	/* 0.1 degrees C */
> +#define DGRD_TEMP_L_DEFAULT			50	/* 0.1 degrees C */
> +#define DGRD_TEMP_VL_DEFAULT			0	/* 0.1 degrees C */
> +
> +#define SOC_EST_MAX_NUM_DEFAULT			5
> +#define PWRCTRL_NORMAL				0x22
> +#define PWRCTRL_RESET				0x23
> +
> +/*
> + * Originally we relied upon a fixed size table of OCV and VDR params.
> + * However the exising linux power-supply batinfo interface for getting the OCV
> + * values from DT does not have fixed amount of OCV values. Thus we use fixed
> + * parameter amount only for values provided as module params - and use this
> + * only as maximum number of parameters when values come from DT.
> + */
> +#define NUM_BAT_PARAMS				23
> +#define MAX_NUM_VDR_VALUES NUM_BAT_PARAMS
> +
> +struct pwr_regs {
> +	int used_init_regs;
> +	u8 vbat_init;
> +	u8 vbat_init2;
> +	u8 vbat_init3;
> +	u8 vbat_avg;
> +	u8 ibat;
> +	u8 ibat_avg;
> +	u8 meas_clear;
> +	u8 vsys_min_avg;
> +	u8 btemp_vth;
> +	u8 chg_state;
> +	u8 coulomb3;
> +	u8 coulomb2;
> +	u8 coulomb1;
> +	u8 coulomb0;
> +	u8 coulomb_ctrl;
 > +	u8 vbat_rex_avg;
> +	u8 coulomb_full3;
> +	u8 cc_full_clr;
> +	u8 coulomb_chg3;

The coulomb counter and vbat_rex related entries could be dropped as 
they're now unused. Actually, dropping all unused members would simplify 
this quite a bit.

> +	u8 bat_temp;
> +	u8 dcin_stat;
> +	u8 dcin_collapse_limit;
> +	u8 chg_set1;
> +	u8 chg_en;
> +	u8 vbat_alm_limit_u;
> +	u8 batcap_mon_limit_u;
> +	u8 conf;
> +	u8 vdcin;
> +};
> +

...

> +
> +static int bd71828_battery_set_property(struct power_supply *psy,
> +					enum power_supply_property psp,
> +					const union power_supply_propval *val)
> +{
> +	struct bd71828_power *pwr = dev_get_drvdata(psy->dev.parent);
> +	int ret = 0;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> +		if (val->intval == POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO)
> +			ret = regmap_update_bits(pwr->regmap, pwr->regs->chg_en,
> +						 BD7182x_MASK_CHG_EN,
> +						 BD7182x_MASK_CHG_EN);
> +		else
> +			ret = regmap_update_bits(pwr->regmap, pwr->regs->chg_en,
> +						 BD7182x_MASK_CHG_EN,
> +						 0);

Nice! I didn't know about the POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO.

> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +

...

> +
> +static int bd71828_power_probe(struct platform_device *pdev)
> +{
> +	struct bd71828_power *pwr;
> +	struct power_supply_config ac_cfg = {};
> +	struct power_supply_config bat_cfg = {};
> +	int ret;
> +	struct regmap *regmap;
> +
> +	regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!regmap) {
> +		dev_err(&pdev->dev, "No parent regmap\n");
> +		return -EINVAL;
> +	}
> +
> +	pwr = devm_kzalloc(&pdev->dev, sizeof(*pwr), GFP_KERNEL);
> +	if (!pwr)
> +		return -ENOMEM;
> +
> +	pwr->regmap = regmap;
> +	pwr->dev = &pdev->dev;
> +	pwr->chip_type = platform_get_device_id(pdev)->driver_data;
> +
> +	switch (pwr->chip_type) {
> +	case ROHM_CHIP_TYPE_BD71828:
> +		pwr->bat_inserted = bd71828_bat_inserted;
> +		pwr->get_temp = bd71828_get_temp;
> +		pwr->regs = &pwr_regs_bd71828;
> +		dev_dbg(pwr->dev, "Found ROHM BD71828\n");
> +		break;
> +	case ROHM_CHIP_TYPE_BD71815:
> +		pwr->bat_inserted = bd71815_bat_inserted;
> +		pwr->get_temp = bd71815_get_temp;
> +		pwr->regs = &pwr_regs_bd71815;
> +		dev_dbg(pwr->dev, "Found ROHM BD71815\n");
> +	break;
> +	default:
> +		dev_err(pwr->dev, "Unknown PMIC\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = bd7182x_get_rsens(pwr);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "sense resistor missing\n");
> +
> +	dev_set_drvdata(&pdev->dev, pwr);
> +	bd71828_init_hardware(pwr);
> +
> +	bat_cfg.drv_data	= pwr;
> +	bat_cfg.fwnode		= dev_fwnode(&pdev->dev);
> +
> +	ac_cfg.supplied_to	= bd71828_ac_supplied_to;
> +	ac_cfg.num_supplicants	= ARRAY_SIZE(bd71828_ac_supplied_to);
> +	ac_cfg.drv_data		= pwr;
> +
> +	pwr->ac = devm_power_supply_register(&pdev->dev, &bd71828_ac_desc,
> +					     &ac_cfg);
> +	if (IS_ERR(pwr->ac)) {
> +		return dev_err_probe(&pdev->dev, PTR_ERR(pwr->ac),
> +				     "failed to register ac\n");
> +	}
> +
> +	pwr->bat = devm_power_supply_register(&pdev->dev, &bd71828_bat_desc,
> +					      &bat_cfg);
> +	if (IS_ERR(pwr->bat)) {
> +		return dev_err_probe(&pdev->dev, PTR_ERR(pwr->bat),
> +				     "failed to register bat\n");
> +	}
> +
> +	ret = bd7182x_get_irqs(pdev, pwr);
> +	if (ret) {
> +		return dev_err_probe(&pdev->dev, ret, "failed to request IRQs");
> +	};

Can drop the {}

> +
> +	/* Configure wakeup capable */
> +	device_set_wakeup_capable(pwr->dev, 1);
> +	device_set_wakeup_enable(pwr->dev, 1);
> +
> +	return 0;
> +}
> +
> +static const struct platform_device_id bd71828_charger_id[] = {
> +	{ "bd71815-power", ROHM_CHIP_TYPE_BD71815 },
> +	{ "bd71828-power", ROHM_CHIP_TYPE_BD71828 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(platform, bd71828_charger_id);
> +
> +static struct platform_driver bd71828_power_driver = {
> +	.driver = {
> +		.name = "bd718xx-power",
> +	},
> +	.probe = bd71828_power_probe,
> +	.id_table = bd71828_charger_id,
> +};
> +
> +module_platform_driver(bd71828_power_driver);
> +MODULE_ALIAS("platform:bd718xx-power");
> +
> +MODULE_AUTHOR("Cong Pham <cpham2403@gmail.com>");
> +MODULE_DESCRIPTION("ROHM BD718(15/17/28/78) PMIC Battery Charger driver");
> +MODULE_LICENSE("GPL");
> 


