Return-Path: <linux-pm+bounces-8390-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079428D3B6E
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 17:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3817FB2099F
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 15:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09345181BA7;
	Wed, 29 May 2024 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UXIe0O1m"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D023A15B115
	for <linux-pm@vger.kernel.org>; Wed, 29 May 2024 15:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716997920; cv=none; b=kwHE8EPmOdNHsZWRwZYNsN0mNT+zYeqqZ7TaS3gfA6FLy2Y7GunO3flSfw36lEgkLLhuzPqaUohGtHelNPhHFqtgjyDWoQiO4rCupIvl7qF2TWgC+EvvIE8TeYJB+etx9ffAz9jBw8lKhwg2rDcdzF6SnI7Clxsb8Uxp17c3cSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716997920; c=relaxed/simple;
	bh=ApsmkRXkkGkT954CRVwsYk3LWkuiZgy1Pusg+a5zKlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jlujszYts7plMyQFrAWrLEDHvZy8BcUC/LXsVlsYqxe4ZTHje3tDY2rB4/HqM5VC5Uxxc7KzAeWGXLfADgm+zuyDtxQlEyaTTaiVZNLQ37aezlal2wy423dxp4s4dJEH6vRWjRL/uFl5lSjMTBA77LXhbMiZlam7Jlb5F/NkJQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UXIe0O1m; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-42120fc8d1dso16832235e9.2
        for <linux-pm@vger.kernel.org>; Wed, 29 May 2024 08:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716997917; x=1717602717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jjd1n2JPMW2TdLlUOBHw2URblqiljuy7IRkNgAOkzsY=;
        b=UXIe0O1m6nOPX+das+WZEswk35DvL3OnhOe1FpUJi8uWAtrsaQ94JRlVbFof3A3/LE
         J+b3l5SHxXUzjQwddxdIIVicmi8c/cKrck2qjveFEUWX3gKw8mDGTXB3v42EsUbhj6gY
         kMc7GlGMAHRl1jOL8lE8XmnFwI/oyYCl6JO2S7Y43XLIJ1KoB0+zh+asrSsO35mhtTlZ
         5k0L+XzwE+ktEsh/QFCrcgQU4wW39ezAZ1jUfqUaZwmZeGrqb/IRCZDVWQAXE/E3/7NG
         d3eFf3+Dy9hzJIukjdwU4B55z+T/Se7s/Bk9d6o939n1Ww2tIjbKv/xzd1i8pgEZXVTq
         gMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716997917; x=1717602717;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jjd1n2JPMW2TdLlUOBHw2URblqiljuy7IRkNgAOkzsY=;
        b=tbwZYYxoqArN15kbrbl/7j7VMHmdD2lXnzgTWqXyFamxzxJUVIGk/XQHoTM5PfQBMw
         mGrS9oRb+WTBVQ8vw2tIDc3AWtP47CXl7FRC05CVbqxuqyopt5qhRLFHldiJPEJAccil
         EOVvY7Usotk50XykXuNNXYggM4vwC+kjElpAmAx5g69978cwo40J4YJ9w4EIdDc9hG94
         Ir8HmJKZWwCbK6a5gyNzEC/0LNvT54WLvjcQItIzyNDFDcbYJ2Zl4p71lDKoGUG40hvS
         CTqZWpxxwwQ5Nye0aPoPbDVhYw0l+JxvooZqXxqQMchXh5qS90mT2wnvIbzKWltKvGi2
         tp+w==
X-Gm-Message-State: AOJu0YyEqdU6PLM59DpOwd7ohSBPsHlb58cNojGs9dKU9lUsrXRdVwKe
	gIs1gqFZyxLN+QV1jl9IbIap3uCEOUJJa2Xkq+7at8rtIJo6ZgunjehOge9/agg=
X-Google-Smtp-Source: AGHT+IENf1xZ7tDsg3hFqvjcQ7KSlV6G3kWDzVUOOAh+IW9M10P+1sEdzjXuz1aq8gOmi5dLyE29GQ==
X-Received: by 2002:a05:600c:5121:b0:41e:3272:6476 with SMTP id 5b1f17b1804b1-42108a5929dmr129232505e9.10.1716997916079;
        Wed, 29 May 2024 08:51:56 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42120e03335sm54286735e9.43.2024.05.29.08.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 08:51:55 -0700 (PDT)
Message-ID: <6d957019-ccec-4129-9e6d-33204de88dd5@linaro.org>
Date: Wed, 29 May 2024 16:51:54 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] power: supply: lenovo_yoga_c630_battery: add
 Lenovo C630 driver
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Nikita Travkin <nikita@trvn.ru>
References: <20240528-yoga-ec-driver-v4-0-4fa8dfaae7b6@linaro.org>
 <20240528-yoga-ec-driver-v4-4-4fa8dfaae7b6@linaro.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240528-yoga-ec-driver-v4-4-4fa8dfaae7b6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/05/2024 21:44, Dmitry Baryshkov wrote:
> On the Lenovo Yoga C630 WOS laptop the EC provides access to the adapter
> and battery status. Add the driver to read power supply status on the
> laptop.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/power/supply/Kconfig                    |   9 +
>   drivers/power/supply/Makefile                   |   1 +
>   drivers/power/supply/lenovo_yoga_c630_battery.c | 479 ++++++++++++++++++++++++
>   3 files changed, 489 insertions(+)
> 
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 3e31375491d5..55ab8e90747d 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -167,6 +167,15 @@ config BATTERY_LEGO_EV3
>   	help
>   	  Say Y here to enable support for the LEGO MINDSTORMS EV3 battery.
>   
> +config BATTERY_LENOVO_YOGA_C630
> +	tristate "Lenovo Yoga C630 battery"
> +	depends on OF && EC_LENOVO_YOGA_C630
> +	help
> +	  This driver enables battery support on the Lenovo Yoga C630 laptop.
> +
> +	  To compile the driver as a module, choose M here: the module will be
> +	  called lenovo_yoga_c630_battery.
> +
>   config BATTERY_PMU
>   	tristate "Apple PMU battery"
>   	depends on PPC32 && ADB_PMU
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 58b567278034..8ebbdcf92dac 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_BATTERY_DS2782)	+= ds2782_battery.o
>   obj-$(CONFIG_BATTERY_GAUGE_LTC2941)	+= ltc2941-battery-gauge.o
>   obj-$(CONFIG_BATTERY_GOLDFISH)	+= goldfish_battery.o
>   obj-$(CONFIG_BATTERY_LEGO_EV3)	+= lego_ev3_battery.o
> +obj-$(CONFIG_BATTERY_LENOVO_YOGA_C630) += lenovo_yoga_c630_battery.o
>   obj-$(CONFIG_BATTERY_PMU)	+= pmu_battery.o
>   obj-$(CONFIG_BATTERY_QCOM_BATTMGR)	+= qcom_battmgr.o
>   obj-$(CONFIG_BATTERY_OLPC)	+= olpc_battery.o
> diff --git a/drivers/power/supply/lenovo_yoga_c630_battery.c b/drivers/power/supply/lenovo_yoga_c630_battery.c
> new file mode 100644
> index 000000000000..76152ad38d46
> --- /dev/null
> +++ b/drivers/power/supply/lenovo_yoga_c630_battery.c
> @@ -0,0 +1,479 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022-2024, Linaro Ltd
> + * Authors:
> + *    Bjorn Andersson
> + *    Dmitry Baryshkov
> + */
> +#include <linux/auxiliary_bus.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/platform_data/lenovo-yoga-c630.h>
> +#include <linux/power_supply.h>
> +
> +struct yoga_c630_psy {
> +	struct yoga_c630_ec *ec;
> +	struct device *dev;
> +	struct device_node *of_node;
> +	struct notifier_block nb;
> +	struct mutex lock;

Do locks still not require a

struct mutex lock; /* this mutex locks this thing */

> +
> +	struct power_supply *adp_psy;
> +	struct power_supply *bat_psy;
> +
> +	unsigned long last_status_update;
> +
> +	bool adapter_online;
> +
> +	bool unit_mA;
> +
> +	bool bat_present;
> +	unsigned int bat_status;
> +	unsigned int design_capacity;
> +	unsigned int design_voltage;
> +	unsigned int full_charge_capacity;
> +
> +	unsigned int capacity_now;
> +	unsigned int voltage_now;
> +
> +	int current_now;
> +	int rate_now;
> +};
> +
> +#define LENOVO_EC_CACHE_TIME		(10 * HZ)
> +
> +#define LENOVO_EC_ADPT_STATUS		0xa3
> +#define LENOVO_EC_ADPT_PRESENT		BIT(7)
> +#define LENOVO_EC_BAT_ATTRIBUTES	0xc0
> +#define LENOVO_EC_BAT_ATTR_UNIT_IS_MA	BIT(1)
> +#define LENOVO_EC_BAT_STATUS		0xc1
> +#define LENOVO_EC_BAT_REMAIN_CAPACITY	0xc2
> +#define LENOVO_EC_BAT_VOLTAGE		0xc6
> +#define LENOVO_EC_BAT_DESIGN_VOLTAGE	0xc8
> +#define LENOVO_EC_BAT_DESIGN_CAPACITY	0xca
> +#define LENOVO_EC_BAT_FULL_CAPACITY	0xcc
> +#define LENOVO_EC_BAT_CURRENT		0xd2
> +#define LENOVO_EC_BAT_FULL_FACTORY	0xd6
> +#define LENOVO_EC_BAT_PRESENT		0xda
> +#define LENOVO_EC_BAT_FULL_REGISTER	0xdb
> +#define LENOVO_EC_BAT_FULL_IS_FACTORY	BIT(0)
> +
> +/* the mutex should already be locked */
> +static int yoga_c630_psy_update_bat_info(struct yoga_c630_psy *ecbat)
> +{
> +	struct yoga_c630_ec *ec = ecbat->ec;
> +	int val;
> +
> +	val = yoga_c630_ec_read8(ec, LENOVO_EC_BAT_PRESENT);
> +	if (val < 0)
> +		return val;
> +	ecbat->bat_present = !!(val & BIT(0));
> +	if (!ecbat->bat_present)
> +		return val;
> +
> +	val = yoga_c630_ec_read8(ec, LENOVO_EC_BAT_ATTRIBUTES);
> +	if (val < 0)
> +		return val;
> +	ecbat->unit_mA = val & LENOVO_EC_BAT_ATTR_UNIT_IS_MA;
> +
> +	val = yoga_c630_ec_read16(ec, LENOVO_EC_BAT_DESIGN_CAPACITY);
> +	if (val < 0)
> +		return val;
> +	ecbat->design_capacity = val * 1000;
> +
> +	msleep(50);

What's this for ? Also do you really want to hold a mutex for 50 
milliseconds ?

> +
> +	val = yoga_c630_ec_read16(ec, LENOVO_EC_BAT_DESIGN_VOLTAGE);
> +	if (val < 0)
> +		return val;
> +	ecbat->design_voltage = val;
> +
> +	msleep(50);

And again ?

I guess it doesn't really matter how long you hold your mutex but, some 
description of the delay in the code would be nice from a reader's 
perspective.

Same comment for the rest of the msleeps();

> +
> +	val = yoga_c630_ec_read8(ec, LENOVO_EC_BAT_FULL_REGISTER);
> +	if (val < 0)
> +		return val;
> +	if (val & LENOVO_EC_BAT_FULL_IS_FACTORY)
> +		val = yoga_c630_ec_read16(ec, LENOVO_EC_BAT_FULL_FACTORY);
> +	else
> +		val = yoga_c630_ec_read16(ec, LENOVO_EC_BAT_FULL_CAPACITY);
> +	if (val < 0)
> +		return val;
> +
> +	ecbat->full_charge_capacity = val * 1000;
> +
> +	if (!ecbat->unit_mA) {
> +		ecbat->design_capacity *= 10;
> +		ecbat->full_charge_capacity *= 10;
> +	}
> +
> +	return 0;
> +}
> +
> +/* the mutex should already be locked */
> +static int yoga_c630_psy_maybe_update_bat_status(struct yoga_c630_psy *ecbat)
> +{
> +	struct yoga_c630_ec *ec = ecbat->ec;
> +	int current_mA;
> +	int val;
> +
> +	if (time_before(jiffies, ecbat->last_status_update + LENOVO_EC_CACHE_TIME))
> +		return 0;
> +
> +	val = yoga_c630_ec_read8(ec, LENOVO_EC_BAT_STATUS);
> +	if (val < 0)
> +		return val;
> +	ecbat->bat_status = val;
> +
> +	msleep(50);
> +
> +	val = yoga_c630_ec_read16(ec, LENOVO_EC_BAT_REMAIN_CAPACITY);
> +	if (val < 0)
> +		return val;
> +	ecbat->capacity_now = val * 1000;
> +
> +	msleep(50);
> +
> +	val = yoga_c630_ec_read16(ec, LENOVO_EC_BAT_VOLTAGE);
> +	if (val < 0)
> +		return val;
> +	ecbat->voltage_now = val * 1000;
> +
> +	msleep(50);
> +
> +	val = yoga_c630_ec_read16(ec, LENOVO_EC_BAT_CURRENT);
> +	if (val < 0)
> +		return val;
> +	current_mA = sign_extend32(val, 15);
> +	ecbat->current_now = current_mA * 1000;
> +	ecbat->rate_now = current_mA * (ecbat->voltage_now / 1000);
> +
> +	msleep(50);
> +
> +	if (!ecbat->unit_mA)
> +		ecbat->capacity_now *= 10;
> +
> +	ecbat->last_status_update = jiffies;
> +
> +	return 0;
> +}
> +
> +static int yoga_c630_psy_update_adapter_status(struct yoga_c630_psy *ecbat)
> +{
> +	struct yoga_c630_ec *ec = ecbat->ec;
> +	int val;
> +
> +	mutex_lock(&ecbat->lock);
> +
> +	val = yoga_c630_ec_read8(ec, LENOVO_EC_ADPT_STATUS);
> +	if (val > 0)
> +		ecbat->adapter_online = FIELD_GET(LENOVO_EC_ADPT_PRESENT, val);
> +
> +	mutex_unlock(&ecbat->lock);
> +
> +	return val;
> +}
> +
> +static bool yoga_c630_psy_is_charged(struct yoga_c630_psy *ecbat)
> +{
> +	if (ecbat->bat_status != 0)
> +		return false;
> +
> +	if (ecbat->full_charge_capacity <= ecbat->capacity_now)
> +		return true;
> +
> +	if (ecbat->design_capacity <= ecbat->capacity_now)
> +		return true;
> +
> +	return false;
> +}
> +
> +static int yoga_c630_psy_bat_get_property(struct power_supply *psy,
> +					 enum power_supply_property psp,
> +					 union power_supply_propval *val)
> +{
> +	struct yoga_c630_psy *ecbat = power_supply_get_drvdata(psy);
> +	int rc = 0;
> +
> +	if (!ecbat->bat_present &&
> +	    psp != POWER_SUPPLY_PROP_PRESENT)
> +		return -ENODEV;
> +
> +	mutex_lock(&ecbat->lock);
> +	rc = yoga_c630_psy_maybe_update_bat_status(ecbat);
> +	mutex_unlock(&ecbat->lock);
> +
> +	if (rc)
> +		return rc;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		if (ecbat->bat_status & BIT(0))
> +			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
> +		else if (ecbat->bat_status & BIT(1))

For preference I'd name these bits.

> +			val->intval = POWER_SUPPLY_STATUS_CHARGING;
> +		else if (yoga_c630_psy_is_charged(ecbat))
> +			val->intval = POWER_SUPPLY_STATUS_FULL;
> +		else
> +			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		break;
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		val->intval = ecbat->bat_present;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
> +		val->intval = ecbat->design_voltage;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> +	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
> +		val->intval = ecbat->design_capacity;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_FULL:
> +	case POWER_SUPPLY_PROP_ENERGY_FULL:
> +		val->intval = ecbat->full_charge_capacity;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_NOW:
> +	case POWER_SUPPLY_PROP_ENERGY_NOW:
> +		val->intval = ecbat->capacity_now;
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		val->intval = ecbat->current_now;
> +		break;
> +	case POWER_SUPPLY_PROP_POWER_NOW:
> +		val->intval = ecbat->rate_now;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		val->intval = ecbat->voltage_now;
> +		break;
> +	case POWER_SUPPLY_PROP_TECHNOLOGY:
> +		val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
> +		break;
> +	case POWER_SUPPLY_PROP_MODEL_NAME:
> +		val->strval = "PABAS0241231";
> +		break;
> +	case POWER_SUPPLY_PROP_MANUFACTURER:
> +		val->strval = "Compal";
> +		break;
> +	default:
> +		rc = -EINVAL;
> +		break;
> +	}
> +
> +	return rc;
> +}
> +
> +static enum power_supply_property yoga_c630_psy_bat_mA_properties[] = {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
> +	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> +	POWER_SUPPLY_PROP_CHARGE_FULL,
> +	POWER_SUPPLY_PROP_CHARGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_POWER_NOW,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_TECHNOLOGY,
> +	POWER_SUPPLY_PROP_MODEL_NAME,
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +};
> +
> +static enum power_supply_property yoga_c630_psy_bat_mWh_properties[] = {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
> +	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
> +	POWER_SUPPLY_PROP_ENERGY_FULL,
> +	POWER_SUPPLY_PROP_ENERGY_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_POWER_NOW,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_TECHNOLOGY,
> +	POWER_SUPPLY_PROP_MODEL_NAME,
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +};
> +
> +static const struct power_supply_desc yoga_c630_psy_bat_psy_desc_mA = {
> +	.name = "yoga-c630-battery",
> +	.type = POWER_SUPPLY_TYPE_BATTERY,
> +	.properties = yoga_c630_psy_bat_mA_properties,
> +	.num_properties = ARRAY_SIZE(yoga_c630_psy_bat_mA_properties),
> +	.get_property = yoga_c630_psy_bat_get_property,
> +};
> +
> +static const struct power_supply_desc yoga_c630_psy_bat_psy_desc_mWh = {
> +	.name = "yoga-c630-battery",
> +	.type = POWER_SUPPLY_TYPE_BATTERY,
> +	.properties = yoga_c630_psy_bat_mWh_properties,
> +	.num_properties = ARRAY_SIZE(yoga_c630_psy_bat_mWh_properties),
> +	.get_property = yoga_c630_psy_bat_get_property,
> +};
> +
> +static int yoga_c630_psy_adpt_get_property(struct power_supply *psy,
> +					  enum power_supply_property psp,
> +					  union power_supply_propval *val)
> +{
> +	struct yoga_c630_psy *ecbat = power_supply_get_drvdata(psy);
> +	int rc = 0;
> +
> +	yoga_c630_psy_update_adapter_status(ecbat);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		val->intval = ecbat->adapter_online;
> +		break;
> +	default:
> +		rc = -EINVAL;
> +		break;
> +	}
> +
> +	return rc;
> +}
> +
> +static enum power_supply_property yoga_c630_psy_adpt_properties[] = {
> +	POWER_SUPPLY_PROP_ONLINE,
> +};
> +
> +static const struct power_supply_desc yoga_c630_psy_adpt_psy_desc = {
> +	.name = "yoga-c630-adapter",
> +	.type = POWER_SUPPLY_TYPE_USB_TYPE_C,
> +	.properties = yoga_c630_psy_adpt_properties,
> +	.num_properties = ARRAY_SIZE(yoga_c630_psy_adpt_properties),
> +	.get_property = yoga_c630_psy_adpt_get_property,
> +};
> +
> +static int yoga_c630_psy_register_bat_psy(struct yoga_c630_psy *ecbat)
> +{
> +	struct power_supply_config bat_cfg = {};
> +
> +	bat_cfg.drv_data = ecbat;
> +	bat_cfg.of_node = ecbat->of_node;
> +	if (ecbat->unit_mA)
> +		ecbat->bat_psy = power_supply_register_no_ws(ecbat->dev, &yoga_c630_psy_bat_psy_desc_mA, &bat_cfg);
> +	else
> +		ecbat->bat_psy = power_supply_register_no_ws(ecbat->dev, &yoga_c630_psy_bat_psy_desc_mWh, &bat_cfg);

These look a bit long, in the other driver in this series you're capping 
at whatever it is 75 or 80 characters.

TBH I think I prefer the longer line above maybe consider elongating the 
length of the line in the previous driver or curtailing to 80 here.

But I think you should have a consistent line lenght in the same series.

> +	if (IS_ERR(ecbat->bat_psy)) {
> +		dev_err(ecbat->dev, "failed to register battery supply\n");
> +		return PTR_ERR(ecbat->bat_psy);
> +	}
> +
> +	return 0;
> +}
> +
> +static void yoga_c630_ec_refresh_bat_info(struct yoga_c630_psy *ecbat)
> +{
> +	bool current_unit;
> +
> +	mutex_lock(&ecbat->lock);
> +	current_unit = ecbat->unit_mA;
> +
> +	yoga_c630_psy_update_bat_info(ecbat);
> +
> +	if (current_unit != ecbat->unit_mA) {
> +		power_supply_unregister(ecbat->bat_psy);
> +		yoga_c630_psy_register_bat_psy(ecbat);
> +	}
> +
> +	mutex_unlock(&ecbat->lock);
> +}
> +
> +static int yoga_c630_psy_notify(struct notifier_block *nb,
> +				unsigned long action, void *data)
> +{
> +	struct yoga_c630_psy *ecbat = container_of(nb, struct yoga_c630_psy, nb);
> +
> +	switch (action) {
> +	case LENOVO_EC_EVENT_BAT_INFO:
> +		yoga_c630_ec_refresh_bat_info(ecbat);
> +		break;
> +	case LENOVO_EC_EVENT_BAT_ADPT_STATUS:
> +		power_supply_changed(ecbat->adp_psy);
> +		fallthrough;
> +	case LENOVO_EC_EVENT_BAT_STATUS:
> +		power_supply_changed(ecbat->bat_psy);
> +		break;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static int yoga_c630_psy_probe(struct auxiliary_device *adev,
> +				   const struct auxiliary_device_id *id)
> +{
> +	struct yoga_c630_ec *ec = adev->dev.platform_data;
> +	struct power_supply_config adp_cfg = {};
> +	struct device *dev = &adev->dev;
> +	struct yoga_c630_psy *ecbat;
> +	int ret;
> +
> +	ecbat = devm_kzalloc(&adev->dev, sizeof(*ecbat), GFP_KERNEL);
> +	if (!ecbat)
> +		return -ENOMEM;
> +
> +	ecbat->ec = ec;
> +	ecbat->dev = dev;
> +	mutex_init(&ecbat->lock);
> +	ecbat->of_node = adev->dev.parent->of_node;
> +	ecbat->nb.notifier_call = yoga_c630_psy_notify;
> +
> +	auxiliary_set_drvdata(adev, ecbat);
> +
> +	adp_cfg.drv_data = ecbat;
> +	adp_cfg.of_node = ecbat->of_node;
> +	adp_cfg.supplied_to = (char **)&yoga_c630_psy_bat_psy_desc_mA.name;
> +	adp_cfg.num_supplicants = 1;
> +	ecbat->adp_psy = devm_power_supply_register_no_ws(dev, &yoga_c630_psy_adpt_psy_desc, &adp_cfg);
> +	if (IS_ERR(ecbat->adp_psy)) {
> +		dev_err(dev, "failed to register AC adapter supply\n");
> +		return PTR_ERR(ecbat->adp_psy);
> +	}
> +
> +	mutex_lock(&ecbat->lock);

Do you really need this lock here in your probe() function ? What's the 
parallel path of execution you are mitigating against here ?

> +
> +	ret = yoga_c630_psy_update_bat_info(ecbat);
> +	if (ret)
> +		goto err_unlock;
> +
> +	ret = yoga_c630_psy_register_bat_psy(ecbat);
> +	if (ret)
> +		goto err_unlock;
> +
> +	mutex_unlock(&ecbat->lock);
> +
> +	ret = yoga_c630_ec_register_notify(ecbat->ec, &ecbat->nb);
> +	if (ret)
> +		goto err_unreg_bat;
> +
> +	return 0;
> +
> +err_unlock:
> +	mutex_unlock(&ecbat->lock);
> +
> +err_unreg_bat:
> +	power_supply_unregister(ecbat->bat_psy);
> +	return ret;
> +}
> +
> +static void yoga_c630_psy_remove(struct auxiliary_device *adev)
> +{
> +	struct yoga_c630_psy *ecbat = auxiliary_get_drvdata(adev);
> +
> +	yoga_c630_ec_unregister_notify(ecbat->ec, &ecbat->nb);
> +	power_supply_unregister(ecbat->bat_psy);
> +}
> +
> +static const struct auxiliary_device_id yoga_c630_psy_id_table[] = {
> +	{ .name = YOGA_C630_MOD_NAME "." YOGA_C630_DEV_PSY, },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(auxiliary, yoga_c630_psy_id_table);
> +
> +static struct auxiliary_driver yoga_c630_psy_driver = {
> +	.name = YOGA_C630_DEV_PSY,
> +	.id_table = yoga_c630_psy_id_table,
> +	.probe = yoga_c630_psy_probe,
> +	.remove = yoga_c630_psy_remove,
> +};
> +
> +module_auxiliary_driver(yoga_c630_psy_driver);
> +
> +MODULE_DESCRIPTION("Lenovo Yoga C630 psy");
> +MODULE_LICENSE("GPL");
> 


