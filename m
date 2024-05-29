Return-Path: <linux-pm+bounces-8389-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB068D3B37
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 17:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E72D3B26108
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 15:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C489A1836D0;
	Wed, 29 May 2024 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H1+Llnwy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A776A181BBE;
	Wed, 29 May 2024 15:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716997308; cv=none; b=MTBeWo2gtK12F7kzug5aPl27JoYwJWYrV8Mh0s/0o3fGLgOfeG/S7fHHZO9mrRHRTs0b5l1Lp9/y3RwVqKBPhpydqR5NBbwX3s43pG0xMmmt+LXR9pMHLqkraxlUGdf/A5jNe5a8DcOOEE/xmO99D3NcWt4YTTW8mxkXHU0OPjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716997308; c=relaxed/simple;
	bh=BxUDW/g9BmmcZzznPLdgoLFf/H0+nT927VNXfm+z/y8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=h4nRUvCS7MCzzu+w3OoSv15PiFXvhXB0znsMU5sV/+dfbToaGxJnAAlC9IDpUM+CyKdXasySFkqdhoQpLvFXrTlcWgMTIfUZREEAm7pCxW8XZC5jlLsQK/Gwk2H9/uZSA6pHwFRt22fmRPbp/p0Uu4qblhLeENjZFomGojgCRQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H1+Llnwy; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716997307; x=1748533307;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BxUDW/g9BmmcZzznPLdgoLFf/H0+nT927VNXfm+z/y8=;
  b=H1+LlnwydS8dPBwAPMxx5108Qa2vI8MeDJPV0JtHW7Kv99W19LX0TqTB
   2gdpgWMj4d/eawYwnyjiCJsQNRqWaeCUbFSTQEhozlsGwzM46o99rfcMU
   YfS++iZQfRzKB8Nroy0mO6eH2WAJ9a8muA+JCfau/JtpOGL6qa6G7dy+N
   D4OIFHzOE5nFYdYnRKTmZYId0zvIVDCijSMRnZ/MBToIb/p4k5HNya7PG
   Fifdcf6mnZIXbE4Lzn+0dtEQB3urYEX+7gQAtdaXZKNFX7HPBfGtP/Jdw
   BHn/XWi78OXRvCJz3GPUgokSBb/+CZ6SVIiQo66GmXyi31hlESORRRO+B
   A==;
X-CSE-ConnectionGUID: BiZNjT56QGuvjV8Q3PKOFQ==
X-CSE-MsgGUID: zML+WNBsRGCe/wi22hBXeA==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13285672"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="13285672"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 08:41:46 -0700
X-CSE-ConnectionGUID: Mrk8oUMQTwKqeh734POlVg==
X-CSE-MsgGUID: wTCz31JvRPWUhGQl2tEGjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="39938911"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.149])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 08:41:40 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 29 May 2024 18:41:36 +0300 (EEST)
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
    Hans de Goede <hdegoede@redhat.com>, 
    Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
    Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Konrad Dybcio <konrad.dybcio@linaro.org>, linux-pm@vger.kernel.org, 
    devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, linux-usb@vger.kernel.org, 
    linux-arm-msm@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
Subject: Re: [PATCH v4 4/6] power: supply: lenovo_yoga_c630_battery: add
 Lenovo C630 driver
In-Reply-To: <20240528-yoga-ec-driver-v4-4-4fa8dfaae7b6@linaro.org>
Message-ID: <d24f720d-66e1-7fa1-5a99-6fa1defebf2c@linux.intel.com>
References: <20240528-yoga-ec-driver-v4-0-4fa8dfaae7b6@linaro.org> <20240528-yoga-ec-driver-v4-4-4fa8dfaae7b6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 28 May 2024, Dmitry Baryshkov wrote:

> On the Lenovo Yoga C630 WOS laptop the EC provides access to the adapter
> and battery status. Add the driver to read power supply status on the
> laptop.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/power/supply/Kconfig                    |   9 +
>  drivers/power/supply/Makefile                   |   1 +
>  drivers/power/supply/lenovo_yoga_c630_battery.c | 479 ++++++++++++++++++++++++
>  3 files changed, 489 insertions(+)
> 
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 3e31375491d5..55ab8e90747d 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -167,6 +167,15 @@ config BATTERY_LEGO_EV3
>  	help
>  	  Say Y here to enable support for the LEGO MINDSTORMS EV3 battery.
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
>  config BATTERY_PMU
>  	tristate "Apple PMU battery"
>  	depends on PPC32 && ADB_PMU
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 58b567278034..8ebbdcf92dac 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_BATTERY_DS2782)	+= ds2782_battery.o
>  obj-$(CONFIG_BATTERY_GAUGE_LTC2941)	+= ltc2941-battery-gauge.o
>  obj-$(CONFIG_BATTERY_GOLDFISH)	+= goldfish_battery.o
>  obj-$(CONFIG_BATTERY_LEGO_EV3)	+= lego_ev3_battery.o
> +obj-$(CONFIG_BATTERY_LENOVO_YOGA_C630) += lenovo_yoga_c630_battery.o
>  obj-$(CONFIG_BATTERY_PMU)	+= pmu_battery.o
>  obj-$(CONFIG_BATTERY_QCOM_BATTMGR)	+= qcom_battmgr.o
>  obj-$(CONFIG_BATTERY_OLPC)	+= olpc_battery.o
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

Missing a few includes, please check them here as well.

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

Add include for BIT()

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

Name the bit with a define.

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

Check linux/units.h if some WATT related one matches to that literal 1000.

> +	msleep(50);
> +
> +	val = yoga_c630_ec_read16(ec, LENOVO_EC_BAT_DESIGN_VOLTAGE);
> +	if (val < 0)
> +		return val;
> +	ecbat->design_voltage = val;
> +
> +	msleep(50);
> +
> +	val = yoga_c630_ec_read8(ec, LENOVO_EC_BAT_FULL_REGISTER);
> +	if (val < 0)
> +		return val;
> +	if (val & LENOVO_EC_BAT_FULL_IS_FACTORY)
> +		val = yoga_c630_ec_read16(ec, LENOVO_EC_BAT_FULL_FACTORY);
> +	else
> +		val = yoga_c630_ec_read16(ec, LENOVO_EC_BAT_FULL_CAPACITY);

You could consider doing this instead of branching:

	val = yoga_c630_ec_read16(ec, val & LENOVO_EC_BAT_FULL_IS_FACTORY ?
				      LENOVO_EC_BAT_FULL_FACTORY :
				      LENOVO_EC_BAT_FULL_CAPACITY);

> +	if (val < 0)
> +		return val;
> +
> +	ecbat->full_charge_capacity = val * 1000;

Something from linux/units.h ?

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

units.h ?

> +	msleep(50);
> +
> +	val = yoga_c630_ec_read16(ec, LENOVO_EC_BAT_VOLTAGE);
> +	if (val < 0)
> +		return val;
> +	ecbat->voltage_now = val * 1000;

Ditto.

> +	msleep(50);
> +
> +	val = yoga_c630_ec_read16(ec, LENOVO_EC_BAT_CURRENT);
> +	if (val < 0)
> +		return val;
> +	current_mA = sign_extend32(val, 15);
> +	ecbat->current_now = current_mA * 1000;
> +	ecbat->rate_now = current_mA * (ecbat->voltage_now / 1000);

Ditto.

> +	msleep(50);
> +
> +	if (!ecbat->unit_mA)
> +		ecbat->capacity_now *= 10;
> +
> +	ecbat->last_status_update = jiffies;

Add jiffies.h

> +	return 0;
> +}
> +
> +static int yoga_c630_psy_update_adapter_status(struct yoga_c630_psy *ecbat)
> +{
> +	struct yoga_c630_ec *ec = ecbat->ec;
> +	int val;
> +
> +	mutex_lock(&ecbat->lock);

This kind of functions coul use guard to take the mutex so unlock will be 
handled for you by the cleanup automation.

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

Fits to one line.

> +		return -ENODEV;
> +
> +	mutex_lock(&ecbat->lock);
> +	rc = yoga_c630_psy_maybe_update_bat_status(ecbat);
> +	mutex_unlock(&ecbat->lock);
> +
> +	if (rc)

Remove empty line in between since this is the error handling.

> +		return rc;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		if (ecbat->bat_status & BIT(0))

Name bits with defines.

> +			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
> +		else if (ecbat->bat_status & BIT(1))

Ditto.

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

Again, it might be easier to see what's different in here if the relevant 
parameter just uses ?: instead of full blown if/else.

> +	if (IS_ERR(ecbat->bat_psy)) {
> +		dev_err(ecbat->dev, "failed to register battery supply\n");
> +		return PTR_ERR(ecbat->bat_psy);
> +	}
> +
> +	return 0;
> +}


-- 
 i.


