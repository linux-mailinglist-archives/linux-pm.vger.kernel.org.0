Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D12EA10842
	for <lists+linux-pm@lfdr.de>; Wed,  1 May 2019 15:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfEANWA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 09:22:00 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46593 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfEANWA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 09:22:00 -0400
Received: by mail-pl1-f196.google.com with SMTP id bi2so3404128plb.13;
        Wed, 01 May 2019 06:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WP0vzWQ0K7moCtdMUn5/d28f8JOzkwdNMOZyCz/7XgM=;
        b=GQ4Z8FZhKdjRDDT2QddYYsvPWa9QOk5HqY7M0vjW+gfZK/aD/4wcAv7k5XCExwumXI
         CjbN9ESFoSQMzFHGK8w67MPEqPHIlUH+BrsUdAko22UMvtQjHlNYICtc2xaEZmyTsWt2
         oXOZkRcFCq7zbo2rHnmKkrE+e1aMrn3wVjZA2y2e8fG9C6zu1ci+J1jesB6fqEs1XOil
         rqUAzam0yqjjwqPZ7jk96hAGpLZGBTF2bk2VrXU0RzXg6zECqZW61w2tYKoE0moCB1R9
         cb/m5rNJIMUh25UZNLJlezRnK6KM6t2DbTgnUfZFpZy9l6lqjlknO3JzeUBIM9SL6dXI
         Pa9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WP0vzWQ0K7moCtdMUn5/d28f8JOzkwdNMOZyCz/7XgM=;
        b=kiyuWbnjnmPRvAuj6c5MVQeVFrmUqZ9zoQAJ7TTd5kfO8C44Kb3vyLxClrxLxZaIZV
         SXqUOITPdUReZ5xrZBhSEg7z8n3qtyEZ6o/xBtVTdHKvPlnfjMof4ZkB28yOh4zdkVRF
         aJzv6ZCL3AufwBatYyBCrHgYb6ogNPiqZbwB0SC3GvMRlx9qz+GqG5YCvdgxvc0tZDOe
         Ua5DDXeE9FSmRxXs4uLRsA8zqHF9E1N8Qd31z04Id6vJdbs1DhG1MXQ72gwgn6U0dGUY
         pAa2W3WodSSJU0rtwcWqXdH9/E7Z8qsoJSeKgrqO9MoCF2towRNFo4gGWBQc7rHL+UbU
         wENQ==
X-Gm-Message-State: APjAAAU1JruPEJ/eGgr0lMgIg4/hOpk10/CoR855fZC3YLQKU0BD6ZLb
        0b/xx7stUXTPugGYet4Wi/AZ4xPT
X-Google-Smtp-Source: APXvYqyv5PH5WfrpOe2EqvKfMbzRHnBiajjMw0Vv5ZIqwT9716pQIv3XdosthPXXyW8pB/gkgXRYEA==
X-Received: by 2002:a17:902:e293:: with SMTP id cf19mr18285694plb.151.1556716919028;
        Wed, 01 May 2019 06:21:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a129sm58129184pfa.152.2019.05.01.06.21.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 06:21:57 -0700 (PDT)
Subject: Re: [PATCH v5 2/3] power: supply: Add driver for Microchip UCS1002
To:     Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc:     Enric Balletbo Serra <enric.balletbo@collabora.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20190501033434.18548-1-andrew.smirnov@gmail.com>
 <20190501033434.18548-3-andrew.smirnov@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b8aed36f-b89e-4256-4896-9fd625b1f502@roeck-us.net>
Date:   Wed, 1 May 2019 06:21:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501033434.18548-3-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/30/19 8:34 PM, Andrey Smirnov wrote:
> Add driver for Microchip UCS1002 Programmable USB Port Power
> Controller with Charger Emulation. The driver exposed a power supply
> device to control/monitor various parameter of the device as well as a
> regulator to allow controlling VBUS line.
> 
> Signed-off-by: Enric Balletbo Serra <enric.balletbo@collabora.com>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org

With the 'tristate' indentation problem fixed:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/power/supply/Kconfig         |   9 +
>   drivers/power/supply/Makefile        |   1 +
>   drivers/power/supply/ucs1002_power.c | 646 +++++++++++++++++++++++++++
>   3 files changed, 656 insertions(+)
>   create mode 100644 drivers/power/supply/ucs1002_power.c
> 
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index e901b9879e7e..c614c8a196f3 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -660,4 +660,13 @@ config FUEL_GAUGE_SC27XX
>   	 Say Y here to enable support for fuel gauge with SC27XX
>   	 PMIC chips.
>   
> +config CHARGER_UCS1002
> +        tristate "Microchip UCS1002 USB Port Power Controller"
> +	depends on I2C
> +	depends on OF
> +	select REGMAP_I2C
> +	help
> +	  Say Y to enable support for Microchip UCS1002 Programmable
> +	  USB Port Power Controller with Charger Emulation.
> +
>   endif # POWER_SUPPLY
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index b731c2a9b695..c56803a9e4fe 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -87,3 +87,4 @@ obj-$(CONFIG_AXP288_CHARGER)	+= axp288_charger.o
>   obj-$(CONFIG_CHARGER_CROS_USBPD)	+= cros_usbpd-charger.o
>   obj-$(CONFIG_CHARGER_SC2731)	+= sc2731_charger.o
>   obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+= sc27xx_fuel_gauge.o
> +obj-$(CONFIG_CHARGER_UCS1002)	+= ucs1002_power.o
> diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/ucs1002_power.c
> new file mode 100644
> index 000000000000..d66b4eff9b7a
> --- /dev/null
> +++ b/drivers/power/supply/ucs1002_power.c
> @@ -0,0 +1,646 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Driver for UCS1002 Programmable USB Port Power Controller
> + *
> + * Copyright (C) 2019 Zodiac Inflight Innovations
> + */
> +#include <linux/bits.h>
> +#include <linux/freezer.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/kthread.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/power_supply.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/of_regulator.h>
> +
> +/* UCS1002 Registers */
> +#define UCS1002_REG_CURRENT_MEASUREMENT	0x00
> +
> +/*
> + * The Total Accumulated Charge registers store the total accumulated
> + * charge delivered from the VS source to a portable device. The total
> + * value is calculated using four registers, from 01h to 04h. The bit
> + * weighting of the registers is given in mA/hrs.
> + */
> +#define UCS1002_REG_TOTAL_ACC_CHARGE	0x01
> +
> +/* Other Status Register */
> +#define UCS1002_REG_OTHER_STATUS	0x0f
> +#  define F_ADET_PIN			BIT(4)
> +#  define F_CHG_ACT			BIT(3)
> +
> +/* Interrupt Status */
> +#define UCS1002_REG_INTERRUPT_STATUS	0x10
> +#  define F_DISCHARGE_ERR		BIT(6)
> +#  define F_RESET			BIT(5)
> +#  define F_MIN_KEEP_OUT		BIT(4)
> +#  define F_TSD				BIT(3)
> +#  define F_OVER_VOLT			BIT(2)
> +#  define F_BACK_VOLT			BIT(1)
> +#  define F_OVER_ILIM			BIT(0)
> +
> +/* Pin Status Register */
> +#define UCS1002_REG_PIN_STATUS		0x14
> +#  define UCS1002_PWR_STATE_MASK	0x03
> +#  define F_PWR_EN_PIN			BIT(6)
> +#  define F_M2_PIN			BIT(5)
> +#  define F_M1_PIN			BIT(4)
> +#  define F_EM_EN_PIN			BIT(3)
> +#  define F_SEL_PIN			BIT(2)
> +#  define F_ACTIVE_MODE_MASK		GENMASK(5, 3)
> +#  define F_ACTIVE_MODE_PASSTHROUGH	F_M2_PIN
> +#  define F_ACTIVE_MODE_DEDICATED	F_EM_EN_PIN
> +#  define F_ACTIVE_MODE_BC12_DCP	(F_M2_PIN | F_EM_EN_PIN)
> +#  define F_ACTIVE_MODE_BC12_SDP	F_M1_PIN
> +#  define F_ACTIVE_MODE_BC12_CDP	(F_M1_PIN | F_M2_PIN | F_EM_EN_PIN)
> +
> +/* General Configuration Register */
> +#define UCS1002_REG_GENERAL_CFG		0x15
> +#  define F_RATION_EN			BIT(3)
> +
> +/* Emulation Configuration Register */
> +#define UCS1002_REG_EMU_CFG		0x16
> +
> +/* Switch Configuration Register */
> +#define UCS1002_REG_SWITCH_CFG		0x17
> +#  define F_PIN_IGNORE			BIT(7)
> +#  define F_EM_EN_SET			BIT(5)
> +#  define F_M2_SET			BIT(4)
> +#  define F_M1_SET			BIT(3)
> +#  define F_S0_SET			BIT(2)
> +#  define F_PWR_EN_SET			BIT(1)
> +#  define F_LATCH_SET			BIT(0)
> +#  define V_SET_ACTIVE_MODE_MASK	GENMASK(5, 3)
> +#  define V_SET_ACTIVE_MODE_PASSTHROUGH	F_M2_SET
> +#  define V_SET_ACTIVE_MODE_DEDICATED	F_EM_EN_SET
> +#  define V_SET_ACTIVE_MODE_BC12_DCP	(F_M2_SET | F_EM_EN_SET)
> +#  define V_SET_ACTIVE_MODE_BC12_SDP	F_M1_SET
> +#  define V_SET_ACTIVE_MODE_BC12_CDP	(F_M1_SET | F_M2_SET | F_EM_EN_SET)
> +
> +/* Current Limit Register */
> +#define UCS1002_REG_ILIMIT		0x19
> +#  define UCS1002_ILIM_SW_MASK		GENMASK(3, 0)
> +
> +/* Product ID */
> +#define UCS1002_REG_PRODUCT_ID		0xfd
> +#  define UCS1002_PRODUCT_ID		0x4e
> +
> +/* Manufacture name */
> +#define UCS1002_MANUFACTURER		"SMSC"
> +
> +struct ucs1002_info {
> +	struct power_supply *charger;
> +	struct i2c_client *client;
> +	struct regmap *regmap;
> +	struct regulator_desc *regulator_descriptor;
> +	bool present;
> +};
> +
> +static enum power_supply_property ucs1002_props[] = {
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_CHARGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_MAX,
> +	POWER_SUPPLY_PROP_PRESENT, /* the presence of PED */
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +	POWER_SUPPLY_PROP_USB_TYPE,
> +	POWER_SUPPLY_PROP_HEALTH,
> +};
> +
> +static int ucs1002_get_online(struct ucs1002_info *info,
> +			      union power_supply_propval *val)
> +{
> +	unsigned int reg;
> +	int ret;
> +
> +	ret = regmap_read(info->regmap, UCS1002_REG_OTHER_STATUS, &reg);
> +	if (ret)
> +		return ret;
> +
> +	val->intval = !!(reg & F_CHG_ACT);
> +
> +	return 0;
> +}
> +
> +static int ucs1002_get_charge(struct ucs1002_info *info,
> +			      union power_supply_propval *val)
> +{
> +	/*
> +	 * To fit within 32 bits some values are rounded (uA/h)
> +	 *
> +	 * For Total Accumulated Charge Middle Low Byte register, addr
> +	 * 03h, byte 2
> +	 *
> +	 *   B0: 0.01084 mA/h rounded to 11 uA/h
> +	 *   B1: 0.02169 mA/h rounded to 22 uA/h
> +	 *   B2: 0.04340 mA/h rounded to 43 uA/h
> +	 *   B3: 0.08676 mA/h rounded to 87 uA/h
> +	 *   B4: 0.17350 mA/h rounded to 173 uÁ/h
> +	 *
> +	 * For Total Accumulated Charge Low Byte register, addr 04h,
> +	 * byte 3
> +	 *
> +	 *   B6: 0.00271 mA/h rounded to 3 uA/h
> +	 *   B7: 0.005422 mA/h rounded to 5 uA/h
> +	 */
> +	static const int bit_weights_uAh[BITS_PER_TYPE(u32)] = {
> +		/*
> +		 * Bit corresponding to low byte (offset 0x04)
> +		 * B0 B1 B2 B3 B4 B5 B6 B7
> +		 */
> +		0, 0, 0, 0, 0, 0, 3, 5,
> +		/*
> +		 * Bit corresponding to middle low byte (offset 0x03)
> +		 * B0 B1 B2 B3 B4 B5 B6 B7
> +		 */
> +		11, 22, 43, 87, 173, 347, 694, 1388,
> +		/*
> +		 * Bit corresponding to middle high byte (offset 0x02)
> +		 * B0 B1 B2 B3 B4 B5 B6 B7
> +		 */
> +		2776, 5552, 11105, 22210, 44420, 88840, 177700, 355400,
> +		/*
> +		 * Bit corresponding to high byte (offset 0x01)
> +		 * B0 B1 B2 B3 B4 B5 B6 B7
> +		 */
> +		710700, 1421000, 2843000, 5685000, 11371000, 22742000,
> +		45484000, 90968000,
> +	};
> +	unsigned long total_acc_charger;
> +	unsigned int reg;
> +	int i, ret;
> +
> +	ret = regmap_bulk_read(info->regmap, UCS1002_REG_TOTAL_ACC_CHARGE,
> +			       &reg, sizeof(u32));
> +	if (ret)
> +		return ret;
> +
> +	total_acc_charger = be32_to_cpu(reg); /* BE as per offsets above */
> +	val->intval = 0;
> +
> +	for_each_set_bit(i, &total_acc_charger, ARRAY_SIZE(bit_weights_uAh))
> +		val->intval += bit_weights_uAh[i];
> +
> +	return 0;
> +}
> +
> +static int ucs1002_get_current(struct ucs1002_info *info,
> +			       union power_supply_propval *val)
> +{
> +	/*
> +	 * The Current Measurement register stores the measured
> +	 * current value delivered to the portable device. The range
> +	 * is from 9.76 mA to 2.5 A.
> +	 */
> +	static const int bit_weights_uA[BITS_PER_TYPE(u8)] = {
> +		9760, 19500, 39000, 78100, 156200, 312300, 624600, 1249300,
> +	};
> +	unsigned long current_measurement;
> +	unsigned int reg;
> +	int i, ret;
> +
> +	ret = regmap_read(info->regmap, UCS1002_REG_CURRENT_MEASUREMENT, &reg);
> +	if (ret)
> +		return ret;
> +
> +	current_measurement = reg;
> +	val->intval = 0;
> +
> +	for_each_set_bit(i, &current_measurement, ARRAY_SIZE(bit_weights_uA))
> +		val->intval += bit_weights_uA[i];
> +
> +	return 0;
> +}
> +
> +/*
> + * The Current Limit register stores the maximum current used by the
> + * port switch. The range is from 500mA to 2.5 A.
> + */
> +static const u32 ucs1002_current_limit_uA[] = {
> +	500000, 900000, 1000000, 1200000, 1500000, 1800000, 2000000, 2500000,
> +};
> +
> +static int ucs1002_get_max_current(struct ucs1002_info *info,
> +				   union power_supply_propval *val)
> +{
> +	unsigned int reg;
> +	int ret;
> +
> +	ret = regmap_read(info->regmap, UCS1002_REG_ILIMIT, &reg);
> +	if (ret)
> +		return ret;
> +
> +	val->intval = ucs1002_current_limit_uA[reg & UCS1002_ILIM_SW_MASK];
> +
> +	return 0;
> +}
> +
> +static int ucs1002_set_max_current(struct ucs1002_info *info, u32 val)
> +{
> +	unsigned int reg;
> +	int ret, idx;
> +
> +	for (idx = 0; idx < ARRAY_SIZE(ucs1002_current_limit_uA); idx++) {
> +		if (val == ucs1002_current_limit_uA[idx])
> +			break;
> +	}
> +
> +	if (idx == ARRAY_SIZE(ucs1002_current_limit_uA))
> +		return -EINVAL;
> +
> +	ret = regmap_write(info->regmap, UCS1002_REG_ILIMIT, idx);
> +	if (ret)
> +		return ret;
> +	/*
> +	 * Any current limit setting exceeding the one set via ILIM
> +	 * pin will be rejected, so we read out freshly changed limit
> +	 * to make sure that it took effect.
> +	 */
> +	ret = regmap_read(info->regmap, UCS1002_REG_ILIMIT, &reg);
> +	if (ret)
> +		return ret;
> +
> +	if (reg != idx)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static enum power_supply_usb_type ucs1002_usb_types[] = {
> +	POWER_SUPPLY_USB_TYPE_PD,
> +	POWER_SUPPLY_USB_TYPE_SDP,
> +	POWER_SUPPLY_USB_TYPE_DCP,
> +	POWER_SUPPLY_USB_TYPE_CDP,
> +	POWER_SUPPLY_USB_TYPE_UNKNOWN,
> +};
> +
> +static int ucs1002_set_usb_type(struct ucs1002_info *info, int val)
> +{
> +	unsigned int mode;
> +
> +	if (val < 0 || val >= ARRAY_SIZE(ucs1002_usb_types))
> +		return -EINVAL;
> +
> +	switch (ucs1002_usb_types[val]) {
> +	case POWER_SUPPLY_USB_TYPE_PD:
> +		mode = V_SET_ACTIVE_MODE_DEDICATED;
> +		break;
> +	case POWER_SUPPLY_USB_TYPE_SDP:
> +		mode = V_SET_ACTIVE_MODE_BC12_SDP;
> +		break;
> +	case POWER_SUPPLY_USB_TYPE_DCP:
> +		mode = V_SET_ACTIVE_MODE_BC12_DCP;
> +		break;
> +	case POWER_SUPPLY_USB_TYPE_CDP:
> +		mode = V_SET_ACTIVE_MODE_BC12_CDP;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return regmap_update_bits(info->regmap, UCS1002_REG_SWITCH_CFG,
> +				  V_SET_ACTIVE_MODE_MASK, mode);
> +}
> +
> +static int ucs1002_get_usb_type(struct ucs1002_info *info,
> +				union power_supply_propval *val)
> +{
> +	enum power_supply_usb_type type;
> +	unsigned int reg;
> +	int ret;
> +
> +	ret = regmap_read(info->regmap, UCS1002_REG_PIN_STATUS, &reg);
> +	if (ret)
> +		return ret;
> +
> +	switch (reg & F_ACTIVE_MODE_MASK) {
> +	default:
> +		type = POWER_SUPPLY_USB_TYPE_UNKNOWN;
> +		break;
> +	case F_ACTIVE_MODE_DEDICATED:
> +		type = POWER_SUPPLY_USB_TYPE_PD;
> +		break;
> +	case F_ACTIVE_MODE_BC12_SDP:
> +		type = POWER_SUPPLY_USB_TYPE_SDP;
> +		break;
> +	case F_ACTIVE_MODE_BC12_DCP:
> +		type = POWER_SUPPLY_USB_TYPE_DCP;
> +		break;
> +	case F_ACTIVE_MODE_BC12_CDP:
> +		type = POWER_SUPPLY_USB_TYPE_CDP;
> +		break;
> +	};
> +
> +	val->intval = type;
> +
> +	return 0;
> +}
> +
> +static int ucs1002_get_health(struct ucs1002_info *info,
> +			      union power_supply_propval *val)
> +{
> +	unsigned int reg;
> +	int ret, health;
> +
> +	ret = regmap_read(info->regmap, UCS1002_REG_INTERRUPT_STATUS, &reg);
> +	if (ret)
> +		return ret;
> +
> +	if (reg & F_TSD)
> +		health = POWER_SUPPLY_HEALTH_OVERHEAT;
> +	else if (reg & (F_OVER_VOLT | F_BACK_VOLT))
> +		health = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> +	else if (reg & F_OVER_ILIM)
> +		health = POWER_SUPPLY_HEALTH_OVERCURRENT;
> +	else if (reg & (F_DISCHARGE_ERR | F_MIN_KEEP_OUT))
> +		health = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
> +	else
> +		health = POWER_SUPPLY_HEALTH_GOOD;
> +
> +	val->intval = health;
> +
> +	return 0;
> +}
> +
> +static int ucs1002_get_property(struct power_supply *psy,
> +				enum power_supply_property psp,
> +				union power_supply_propval *val)
> +{
> +	struct ucs1002_info *info = power_supply_get_drvdata(psy);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		return ucs1002_get_online(info, val);
> +	case POWER_SUPPLY_PROP_CHARGE_NOW:
> +		return ucs1002_get_charge(info, val);
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		return ucs1002_get_current(info, val);
> +	case POWER_SUPPLY_PROP_CURRENT_MAX:
> +		return ucs1002_get_max_current(info, val);
> +	case POWER_SUPPLY_PROP_USB_TYPE:
> +		return ucs1002_get_usb_type(info, val);
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		return ucs1002_get_health(info, val);
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		val->intval = info->present;
> +		return 0;
> +	case POWER_SUPPLY_PROP_MANUFACTURER:
> +		val->strval = UCS1002_MANUFACTURER;
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ucs1002_set_property(struct power_supply *psy,
> +				enum power_supply_property psp,
> +				const union power_supply_propval *val)
> +{
> +	struct ucs1002_info *info = power_supply_get_drvdata(psy);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CURRENT_MAX:
> +		return ucs1002_set_max_current(info, val->intval);
> +	case POWER_SUPPLY_PROP_USB_TYPE:
> +		return ucs1002_set_usb_type(info, val->intval);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ucs1002_property_is_writeable(struct power_supply *psy,
> +					 enum power_supply_property psp)
> +{
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CURRENT_MAX:
> +	case POWER_SUPPLY_PROP_USB_TYPE:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static const struct power_supply_desc ucs1002_charger_desc = {
> +	.name			= "ucs1002",
> +	.type			= POWER_SUPPLY_TYPE_USB,
> +	.usb_types		= ucs1002_usb_types,
> +	.num_usb_types		= ARRAY_SIZE(ucs1002_usb_types),
> +	.get_property		= ucs1002_get_property,
> +	.set_property		= ucs1002_set_property,
> +	.property_is_writeable	= ucs1002_property_is_writeable,
> +	.properties		= ucs1002_props,
> +	.num_properties		= ARRAY_SIZE(ucs1002_props),
> +};
> +
> +static irqreturn_t ucs1002_charger_irq(int irq, void *data)
> +{
> +	int ret, regval;
> +	bool present;
> +	struct ucs1002_info *info = data;
> +
> +	present = info->present;
> +
> +	ret = regmap_read(info->regmap, UCS1002_REG_OTHER_STATUS, &regval);
> +	if (ret)
> +		return IRQ_HANDLED;
> +
> +	/* update attached status */
> +	info->present = regval & F_ADET_PIN;
> +
> +	/* notify the change */
> +	if (present != info->present)
> +		power_supply_changed(info->charger);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t ucs1002_alert_irq(int irq, void *data)
> +{
> +	struct ucs1002_info *info = data;
> +
> +	power_supply_changed(info->charger);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct regulator_ops ucs1002_regulator_ops = {
> +	.is_enabled	= regulator_is_enabled_regmap,
> +	.enable		= regulator_enable_regmap,
> +	.disable	= regulator_disable_regmap,
> +};
> +
> +static const struct regulator_desc ucs1002_regulator_descriptor = {
> +	.name		= "ucs1002-vbus",
> +	.ops		= &ucs1002_regulator_ops,
> +	.type		= REGULATOR_VOLTAGE,
> +	.owner		= THIS_MODULE,
> +	.enable_reg	= UCS1002_REG_SWITCH_CFG,
> +	.enable_mask	= F_PWR_EN_SET,
> +	.enable_val	= F_PWR_EN_SET,
> +	.fixed_uV	= 5000000,
> +	.n_voltages	= 1,
> +};
> +
> +static int ucs1002_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *dev_id)
> +{
> +	struct device *dev = &client->dev;
> +	struct power_supply_config charger_config = {};
> +	const struct regmap_config regmap_config = {
> +		.reg_bits = 8,
> +		.val_bits = 8,
> +	};
> +	struct regulator_config regulator_config = {};
> +	int irq_a_det, irq_alert, ret;
> +	struct regulator_dev *rdev;
> +	struct ucs1002_info *info;
> +	unsigned int regval;
> +
> +	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	info->regmap = devm_regmap_init_i2c(client, &regmap_config);
> +	ret = PTR_ERR_OR_ZERO(info->charger);
> +	if (ret) {
> +		dev_err(dev, "Regmap initialization failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	info->client = client;
> +
> +	irq_a_det = of_irq_get_byname(dev->of_node, "a_det");
> +	irq_alert = of_irq_get_byname(dev->of_node, "alert");
> +
> +	charger_config.of_node = dev->of_node;
> +	charger_config.drv_data = info;
> +
> +	ret = regmap_read(info->regmap, UCS1002_REG_PRODUCT_ID, &regval);
> +	if (ret) {
> +		dev_err(dev, "Failed to read product ID: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (regval != UCS1002_PRODUCT_ID) {
> +		dev_err(dev,
> +			"Product ID does not match (0x%02x != 0x%02x)\n",
> +			regval, UCS1002_PRODUCT_ID);
> +		return -ENODEV;
> +	}
> +
> +	/* Enable charge rationing by default */
> +	ret = regmap_update_bits(info->regmap, UCS1002_REG_GENERAL_CFG,
> +				 F_RATION_EN, F_RATION_EN);
> +	if (ret) {
> +		dev_err(dev, "Failed to read general config: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Ignore the M1, M2, PWR_EN, and EM_EN pin states. Set active
> +	 * mode selection to BC1.2 CDP.
> +	 */
> +	ret = regmap_update_bits(info->regmap, UCS1002_REG_SWITCH_CFG,
> +				 V_SET_ACTIVE_MODE_MASK | F_PIN_IGNORE,
> +				 V_SET_ACTIVE_MODE_BC12_CDP | F_PIN_IGNORE);
> +	if (ret) {
> +		dev_err(dev, "Failed to configure default mode: %d\n", ret);
> +		return ret;
> +	}
> +	/*
> +	 * Be safe and set initial current limit to 500mA
> +	 */
> +	ret = ucs1002_set_max_current(info, 500000);
> +	if (ret) {
> +		dev_err(dev, "Failed to set max current default: %d\n", ret);
> +		return ret;
> +	}
> +
> +	info->charger = devm_power_supply_register(dev, &ucs1002_charger_desc,
> +						   &charger_config);
> +	ret = PTR_ERR_OR_ZERO(info->charger);
> +	if (ret) {
> +		dev_err(dev, "Failed to register power supply: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regmap_read(info->regmap, UCS1002_REG_PIN_STATUS, &regval);
> +	if (ret) {
> +		dev_err(dev, "Failed to read pin status: %d\n", ret);
> +		return ret;
> +	}
> +
> +	info->regulator_descriptor =
> +		devm_kmemdup(dev, &ucs1002_regulator_descriptor,
> +			     sizeof(ucs1002_regulator_descriptor),
> +			     GFP_KERNEL);
> +	if (!info->regulator_descriptor)
> +		return -ENOMEM;
> +
> +	info->regulator_descriptor->enable_is_inverted = !(regval & F_SEL_PIN);
> +
> +	regulator_config.dev = dev;
> +	regulator_config.of_node = dev->of_node;
> +	regulator_config.regmap = info->regmap;
> +
> +	rdev = devm_regulator_register(dev, info->regulator_descriptor,
> +				       &regulator_config);
> +	ret = PTR_ERR_OR_ZERO(info->charger);
> +	if (ret) {
> +		dev_err(dev, "Failed to register VBUS regulator: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (irq_a_det > 0) {
> +		ret = devm_request_threaded_irq(dev, irq_a_det, NULL,
> +						ucs1002_charger_irq,
> +						IRQF_ONESHOT,
> +						"ucs1002-a_det", info);
> +		if (ret) {
> +			dev_err(dev, "Failed to request A_DET threaded irq: %d\n",
> +				ret);
> +			return ret;
> +		}
> +	}
> +
> +	if (irq_alert > 0) {
> +		ret = devm_request_threaded_irq(dev, irq_alert, NULL,
> +						ucs1002_alert_irq,
> +						IRQF_ONESHOT,
> +						"ucs1002-alert", info);
> +		if (ret) {
> +			dev_err(dev, "Failed to request ALERT threaded irq: %d\n",
> +				ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ucs1002_of_match[] = {
> +	{ .compatible = "microchip,ucs1002", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, ucs1002_of_match);
> +
> +static struct i2c_driver ucs1002_driver = {
> +	.driver = {
> +		   .name = "ucs1002",
> +		   .of_match_table = ucs1002_of_match,
> +	},
> +	.probe = ucs1002_probe,
> +};
> +module_i2c_driver(ucs1002_driver);
> +
> +MODULE_DESCRIPTION("Microchip UCS1002 Programmable USB Port Power Controller");
> +MODULE_AUTHOR("Enric Balletbo Serra <enric.balletbo@collabora.com>");
> +MODULE_AUTHOR("Andrey Smirnov <andrew.smirnov@gmail.com>");
> +MODULE_LICENSE("GPL");
> 

