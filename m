Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A86F92DD55
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 14:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfE2Mkf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 May 2019 08:40:35 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35007 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfE2Mkf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 May 2019 08:40:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id t1so1316565pgc.2;
        Wed, 29 May 2019 05:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G5tvBZS6La6jgcfc/NA4rJDLCInkuyucFh8IESSwL58=;
        b=S4p76h2CgsumoY9wWaCR+E6ll+MJ7TZqGJsXpkMhAg8jGwzlLdGx6D37CNBRiMkM/9
         WwpDvRt+qIVqOrq0ER003DfJwribC8kzEwgueer7L/v1S+c+1cAJWB98439C5Xv1wWDS
         YHbhQYdyi7gNDeejb4MCCE3GHR7v+csZhN1yaigaljhn8KV4xQ7fSKBCn91af/Ntff7D
         q2C4UhocmxGMool5KXmjVUE5TeG5FYiROR6/F/nmZhx9nuRg1Yj+3f/CTL86/vP2OLpY
         EqJhhoB8f5B76KhyvYP+08eXdhYTfTILJnnfQ1PVNMvI7JnlqEZl5La7xPxVn8lAoy3N
         4Pow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G5tvBZS6La6jgcfc/NA4rJDLCInkuyucFh8IESSwL58=;
        b=Iy+NXW9MLBkIJj3sufCwhNeqMMR34FN7pLdmjA+eJnWlZ89w5M2ncfWUzXZlQSShUM
         1UBCM3v2b4kJVHq21aF3VdXOKTVr2SlxJLPeUFIyjDb+mZUEtxj8rw/+hwxB5xU6gjt8
         ITijmXasasIerVlfSymS63UZyqoj/J9NtXDpnbQz0ZYixWWphJ3hdmdx+2GAWwgH+Xyf
         U29zV/KaZsouAGoAGEtSg9IXBFK/XDgEk3vfOfLntBdS2UOHURt0qrVGVdHXDPeDTLpw
         sn2R8T0xl+YzB1kDaE7fa+NWcVMY4AUMiBBw4cV8xdGXxEOH3CDckrnqpE+mbgphtSaW
         AxHQ==
X-Gm-Message-State: APjAAAUGN7HkF8s1vJM1qHFHQOPMPCjMFrAdedYcY3A9yKaBtH+kl42M
        4B5XaAsfjQxP7ppcFSsd9jMH73pn
X-Google-Smtp-Source: APXvYqwKN9aVtBA/yN8mZ8+Ak3y9oJa/zMtzMpKgrqWm7pT9nLCQH1e7aGl3uHZYfR+A6T2/8vc8Lg==
X-Received: by 2002:a17:90a:8b91:: with SMTP id z17mr12037403pjn.61.1559133634199;
        Wed, 29 May 2019 05:40:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k14sm32762510pga.5.2019.05.29.05.40.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 05:40:33 -0700 (PDT)
Subject: Re: [PATCH 1/2] power: supply: Add HWMON compatibility layer
To:     Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc:     Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20190529071112.16849-1-andrew.smirnov@gmail.com>
 <20190529071112.16849-2-andrew.smirnov@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <22dcfea4-00a2-3de8-8313-35d8d1350493@roeck-us.net>
Date:   Wed, 29 May 2019 05:40:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190529071112.16849-2-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/29/19 12:11 AM, Andrey Smirnov wrote:
> Add code implementing HWMON adapter/compatibility layer to allow
> expositing various sensors present on power supply devices via HWMON
> subsystem. This is done in order to allow userspace to use single
> ABI/library(libsensors) to access/manipulate all of the sensors of the
> system.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> ---
>   drivers/power/supply/Kconfig              |  14 +
>   drivers/power/supply/Makefile             |   1 +
>   drivers/power/supply/power_supply_hwmon.c | 329 ++++++++++++++++++++++
>   include/linux/power_supply.h              |  11 +
>   4 files changed, 355 insertions(+)
>   create mode 100644 drivers/power/supply/power_supply_hwmon.c
> 
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 26dacdab03cc..1f2252cb95fd 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -14,6 +14,20 @@ config POWER_SUPPLY_DEBUG
>   	  Say Y here to enable debugging messages for power supply class
>   	  and drivers.
>   
> +config POWER_SUPPLY_HWMON
> +	bool
> +	prompt "Expose power supply sensors as hwmon device"
> +	depends on HWMON=y || HWMON=POWER_SUPPLY
> +	default y

Not sure if you want to enable that by default.

> +	help
> +	  This options enables API that allows sensors found on a
> +	  power supply device (current, voltage, temperature) to be
> +	  exposed as a hwmon device.
> +
> +	  Say 'Y' here if you want power supplies to
> +	  have hwmon sysfs interface too.
> +
> +
>   config PDA_POWER
>   	tristate "Generic PDA/phone power driver"
>   	depends on !S390
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index f208273f9686..c47e88ba16b9 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -6,6 +6,7 @@ power_supply-$(CONFIG_SYSFS)		+= power_supply_sysfs.o
>   power_supply-$(CONFIG_LEDS_TRIGGERS)	+= power_supply_leds.o
>   
>   obj-$(CONFIG_POWER_SUPPLY)	+= power_supply.o
> +obj-$(CONFIG_POWER_SUPPLY_HWMON) += power_supply_hwmon.o
>   obj-$(CONFIG_GENERIC_ADC_BATTERY)	+= generic-adc-battery.o
>   
>   obj-$(CONFIG_PDA_POWER)		+= pda_power.o
> diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
> new file mode 100644
> index 000000000000..dca7f79fae6e
> --- /dev/null
> +++ b/drivers/power/supply/power_supply_hwmon.c
> @@ -0,0 +1,329 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  power_supply_hwmon.c - power supply hwmon support.
> + */
> +
> +#include <linux/hwmon.h>
> +#include <linux/slab.h>
> +#include <linux/err.h>
> +#include <linux/power_supply.h>
> +
Alphabetic order ?

> +struct power_supply_hwmon {
> +	struct power_supply *psy;
> +	unsigned long *props;
> +};
> +
> +static int power_supply_hwmon_in_to_property(u32 attr)
> +{
> +	switch (attr) {
> +	case hwmon_in_average:
> +		return POWER_SUPPLY_PROP_VOLTAGE_AVG;
> +	case hwmon_in_min:
> +		return POWER_SUPPLY_PROP_VOLTAGE_MIN;
> +	case hwmon_in_max:
> +		return POWER_SUPPLY_PROP_VOLTAGE_MAX;
> +	case hwmon_in_input:
> +		return POWER_SUPPLY_PROP_VOLTAGE_NOW;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int power_supply_hwmon_curr_to_property(u32 attr)
> +{
> +	switch (attr) {
> +	case hwmon_curr_average:
> +		return POWER_SUPPLY_PROP_CURRENT_AVG;
> +	case hwmon_curr_max:
> +		return POWER_SUPPLY_PROP_CURRENT_MAX;
> +	case hwmon_curr_input:
> +		return POWER_SUPPLY_PROP_CURRENT_NOW;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int power_supply_hwmon_temp_to_property(u32 attr, int channel)
> +{
> +	if (channel) {
> +		switch (attr) {
> +		case hwmon_temp_input:
> +			return POWER_SUPPLY_PROP_TEMP_AMBIENT;
> +		case hwmon_temp_min_alarm:
> +			return POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN;
> +		case hwmon_temp_max_alarm:
> +			return POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX;
> +		default:
> +			break;
> +		}
> +	} else {
> +		switch (attr) {
> +		case hwmon_temp_input:
> +			return POWER_SUPPLY_PROP_TEMP;
> +		case hwmon_temp_max:
> +			return POWER_SUPPLY_PROP_TEMP_MAX;
> +		case hwmon_temp_min:
> +			return POWER_SUPPLY_PROP_TEMP_MIN;
> +		case hwmon_temp_min_alarm:
> +			return POWER_SUPPLY_PROP_TEMP_ALERT_MIN;
> +		case hwmon_temp_max_alarm:
> +			return POWER_SUPPLY_PROP_TEMP_ALERT_MAX;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int
> +power_supply_hwmon_to_property(enum hwmon_sensor_types type,
> +			       u32 attr, int channel)
> +{
> +	switch (type) {
> +	case hwmon_in:
> +		return power_supply_hwmon_in_to_property(attr);
> +	case hwmon_curr:
> +		return power_supply_hwmon_curr_to_property(attr);
> +	case hwmon_temp:
> +		return power_supply_hwmon_temp_to_property(attr, channel);
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static bool power_supply_hwmon_is_a_label(enum hwmon_sensor_types type,
> +					  u32 attr)
> +{
> +	return type == hwmon_temp && attr == hwmon_temp_label;
> +}
> +
> +static umode_t power_supply_hwmon_is_visible(const void *data,
> +					     enum hwmon_sensor_types type,
> +					     u32 attr, int channel)
> +{
> +	const struct power_supply_hwmon *psyhw = data;
> +	int prop, is_writable;
> +
> +	if (power_supply_hwmon_is_a_label(type, attr))
> +		return 0444;
> +
> +	prop = power_supply_hwmon_to_property(type, attr, channel);
> +	if (prop < 0 || !test_bit(prop, psyhw->props))
> +		return 0;
> +
> +	is_writable = power_supply_property_is_writeable(psyhw->psy, prop);
> +
> +	return (is_writable <= 0) ? 0444 : 0644;

I a a bit concerned that this can result in writeable voltage/current/temp
values (not just for limits), which would be very undesirable. It might be
better to add another check to ensure that this does not happen.

> +}
> +
> +static int power_supply_hwmon_read_string(struct device *dev,
> +					  enum hwmon_sensor_types type,
> +					  u32 attr, int channel,
> +					  const char **str)
> +{
> +	*str = channel ? "temp" : "temp ambient";
> +	return 0;
> +}
> +
> +static int
> +power_supply_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> +			u32 attr, int channel, long *val)
> +{
> +	struct power_supply_hwmon *psyhw = dev_get_drvdata(dev);
> +	struct power_supply *psy = psyhw->psy;
> +	union power_supply_propval pspval;
> +	int ret, prop;
> +
> +	prop = power_supply_hwmon_to_property(type, attr, channel);
> +	if (prop < 0)
> +		return prop;
> +
> +	ret  = power_supply_get_property(psy, prop, &pspval);
> +	if (ret)
> +		return ret;
> +
> +	switch (type) {
> +	/*
> +	 * Both voltage and current is reported in units of
> +	 * microvolts/microamps, so we need to adjust it to
> +	 * milliamps(volts)
> +	 */
> +	case hwmon_curr:
> +	case hwmon_in:
> +		pspval.intval /= 1000;

DIV_ROUND_CLOSEST() ?

> +		break;
> +	/*
> +	 * Temp needs to be converted from 1/10 C to milli-C
> +	 */
> +	case hwmon_temp:
> +		pspval.intval *= 100;

intval is an int, so theoretically this could result in an overflow.


> +		break;
> +	default:

Wouldn't this be an error ?

Personally I prefer direct value assignments. I don't see value in
updating pspval.intval first only to assign it to *val later.

> +		break;
> +	}
> +
> +	*val = pspval.intval;
> +
> +	return 0;
> +}
> +
> +static int
> +power_supply_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
> +			 u32 attr, int channel, long val)
> +{
> +	struct power_supply_hwmon *psyhw = dev_get_drvdata(dev);
> +	struct power_supply *psy = psyhw->psy;
> +	union power_supply_propval pspval;
> +	int prop;
> +
> +	prop = power_supply_hwmon_to_property(type, attr, channel);
> +	if (prop < 0)
> +		return prop;
> +
> +	pspval.intval = val;
> +
> +	switch (type) {
> +	/*
> +	 * Both voltage and current is reported in units of
> +	 * microvolts/microamps, so we need to adjust it to
> +	 * milliamps(volts)
> +	 */
> +	case hwmon_curr:
> +	case hwmon_in:
> +		pspval.intval *= 1000;

Range checks ? This can result in an overflow.

> +		break;
> +	/*
> +	 * Temp needs to be converted from 1/10 C to milli-C
> +	 */
> +	case hwmon_temp:
> +		pspval.intval /= 100;
> +		break;
> +	default:
> +		break;

Wouldn't this be an error ?

> +	}
> +
> +	return power_supply_set_property(psy, prop, &pspval);
> +}
> +
> +static const struct hwmon_ops power_supply_hwmon_ops = {
> +	.is_visible	= power_supply_hwmon_is_visible,
> +	.read		= power_supply_hwmon_read,
> +	.write		= power_supply_hwmon_write,
> +	.read_string	= power_supply_hwmon_read_string,
> +};
> +
> +static const struct hwmon_channel_info *power_supply_hwmon_info[] = {
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_LABEL     |
> +			   HWMON_T_INPUT     |
> +			   HWMON_T_MAX       |
> +			   HWMON_T_MIN       |
> +			   HWMON_T_MIN_ALARM |
> +			   HWMON_T_MIN_ALARM,
> +
> +			   HWMON_T_LABEL     |
> +			   HWMON_T_INPUT     |
> +			   HWMON_T_MIN_ALARM |
> +			   HWMON_T_LABEL     |
> +			   HWMON_T_MAX_ALARM),
> +
> +	HWMON_CHANNEL_INFO(curr,
> +			   HWMON_C_AVERAGE |
> +			   HWMON_C_MAX     |
> +			   HWMON_C_INPUT),
> +
> +	HWMON_CHANNEL_INFO(in,
> +			   HWMON_I_AVERAGE |
> +			   HWMON_I_MIN     |
> +			   HWMON_I_MAX     |
> +			   HWMON_I_INPUT),
> +	NULL
> +};
> +
> +static const struct hwmon_chip_info power_supply_hwmon_chip_info = {
> +	.ops = &power_supply_hwmon_ops,
> +	.info = power_supply_hwmon_info,
> +};
> +
> +static void power_supply_hwmon_bitmap_free(void *data)
> +{
> +	bitmap_free(data);
> +}
> +
> +struct device *devm_power_supply_add_hwmon_sysfs(struct power_supply *psy)
> +{
> +	const struct power_supply_desc *desc = psy->desc;
> +	struct power_supply_hwmon *psyhw;
> +	struct device *dev = &psy->dev;
> +	struct device *hwmon;
> +	int ret, i;
> +
> +	if (!devres_open_group(dev, NULL, GFP_KERNEL))
> +		return ERR_PTR(-ENOMEM);
> +
> +	psyhw = devm_kzalloc(dev, sizeof(*psyhw), GFP_KERNEL);
> +	if (!psyhw) {
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
> +	psyhw->psy = psy;
> +	psyhw->props = bitmap_zalloc(POWER_SUPPLY_PROP_TIME_TO_FULL_AVG + 1,
> +				     GFP_KERNEL);
> +	if (!psyhw->props) {
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
> +	ret = devm_add_action(dev, power_supply_hwmon_bitmap_free,
> +			      psyhw->props);
> +	if (ret)
> +		goto error;
> +
> +	for (i = 0; i < desc->num_properties; i++) {
> +		const enum power_supply_property prop = desc->properties[i];
> +
> +		switch (prop) {
> +		case POWER_SUPPLY_PROP_CURRENT_AVG:
> +		case POWER_SUPPLY_PROP_CURRENT_MAX:
> +		case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		case POWER_SUPPLY_PROP_TEMP:
> +		case POWER_SUPPLY_PROP_TEMP_MAX:
> +		case POWER_SUPPLY_PROP_TEMP_MIN:
> +		case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
> +		case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
> +		case POWER_SUPPLY_PROP_TEMP_AMBIENT:
> +		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN:
> +		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX:
> +		case POWER_SUPPLY_PROP_VOLTAGE_AVG:
> +		case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> +		case POWER_SUPPLY_PROP_VOLTAGE_MAX:
> +		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +			set_bit(prop, psyhw->props);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	hwmon = devm_hwmon_device_register_with_info(dev, psy->desc->name,
> +						psyhw,
> +						&power_supply_hwmon_chip_info,
> +						NULL);
> +	ret = PTR_ERR_OR_ZERO(hwmon);
> +	if (ret)
> +		goto error;
> +
> +	devres_remove_group(dev, NULL);

Why devres_remove_group() and not devres_close_group() ?

> +	return hwmon;

Why return a pointer to the hwmon device and not just an error code ?

> +error:
> +	devres_release_group(dev, NULL);
> +	return ERR_PTR(ret);
> +}
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index d9c0c094f8a0..839abfa2c640 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -481,4 +481,15 @@ static inline bool power_supply_is_watt_property(enum power_supply_property psp)
>   	return 0;
>   }
>   
> +#ifdef CONFIG_POWER_SUPPLY_HWMON
> +extern struct device *
> +devm_power_supply_add_hwmon_sysfs(struct power_supply *psy);
> +#else
> +static struct device *
> +devm_power_supply_add_hwmon_sysfs(struct power_supply *psy)
> +{
> +	return 0;

You might consider making the return code an int. Otherwise this gets difficult
for the caller, who would have to check for IS_ERR() and NULL (if the device
pointer is supposed to be used for anything).

> +}
> +#endif
> +
>   #endif /* __LINUX_POWER_SUPPLY_H__ */
> 

