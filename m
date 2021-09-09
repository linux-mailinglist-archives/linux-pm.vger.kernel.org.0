Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BCA405F95
	for <lists+linux-pm@lfdr.de>; Fri, 10 Sep 2021 00:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhIIWau (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 18:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhIIWau (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 18:30:50 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08126C061575
        for <linux-pm@vger.kernel.org>; Thu,  9 Sep 2021 15:29:40 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id g184so3331585pgc.6
        for <linux-pm@vger.kernel.org>; Thu, 09 Sep 2021 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nrJwSEgINw1/HbRT2xQPIos8TgeLi2QDHj3pmKrS7bU=;
        b=VvJHhLdDu7mvVAw5Vpi7W6c6cE9pilytsjxGE9U2a2ofiQl15OMncTelEjU4EB0+0i
         quKwUHK87JqL7mDxYEPstdzVhvATi5FnN0qbnc3NbMtnidanidI0P0dv3+h7jQ27ayrn
         BNuaxdOgIf8svMoW0OSPifsRsL+er/Wkwlmms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nrJwSEgINw1/HbRT2xQPIos8TgeLi2QDHj3pmKrS7bU=;
        b=VLT2rF+SDaCQ2SNhqiVGfQ9oiG2XMbLI5v2XmNhM02IWf0Zi1EHPSPpa0+nYVpA/BI
         kl1l2L5qJ+ISTGkRzfKtI/nl/fnHVB32MvEqSiBt9XjdKtVSlMxsuDRaOnfaZl+LwFxC
         Rsa3/fOSmsewjQmi1m4vkqbgyJ81x6oQCULYxFwYUuPYMaL3vaxTAiyK2LsGvekEKZnr
         4HLH9YZfjbBx4bZRcXMnn/aoDggKsAvpUhxdQFjAL752o8xf5+saBLyCVLi+Vewh7Inn
         4G1WLbQNXfY8+LoGhXDydb+AWdaW1VICsyjVn+6JNy5AuNPZ2dBbxM2vFX55kd0PNeu7
         eo4g==
X-Gm-Message-State: AOAM531042OpT3QuS0x9vYC6HF9ubdwEuIiLmnZFwG0/7qhkBH4pqMuO
        7r51IV47Ac0Cpm7tBUw6EWWzFQ==
X-Google-Smtp-Source: ABdhPJyzpxpsvto8ac43TXk9Yihceha4pKPZy/IBujfd2wIIIYmg6c/kmA6R7ucVDCgxcOZ0NJO/eA==
X-Received: by 2002:a63:e413:: with SMTP id a19mr4637381pgi.408.1631226579403;
        Thu, 09 Sep 2021 15:29:39 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:c1fe:57b:eb6:58a5])
        by smtp.gmail.com with UTF8SMTPSA id d10sm3231842pfq.205.2021.09.09.15.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 15:29:39 -0700 (PDT)
Date:   Thu, 9 Sep 2021 15:29:37 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alexandre Bailon <abailon@baylibre.com>
Cc:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com, gpain@baylibre.com
Subject: Re: [PATCH 2/2] thermal: add a virtual sensor to aggregate
 temperatures
Message-ID: <YTqK0UnabqsLYIGw@google.com>
References: <20210906190454.114751-1-abailon@baylibre.com>
 <20210906190454.114751-3-abailon@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210906190454.114751-3-abailon@baylibre.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 06, 2021 at 09:04:54PM +0200, Alexandre Bailon wrote:
> This adds a virtual thermal sensor that reads temperature from
> hardware sensor and return an aggregated temperature.

s/hardware sensor/hardware sensors/

> Currently, this only return the max temperature.

it seems this is outdated.

> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>  drivers/thermal/Kconfig          |   8 +
>  drivers/thermal/Makefile         |   1 +
>  drivers/thermal/virtual-sensor.h |  51 ++++
>  drivers/thermal/virtual_sensor.c | 400 +++++++++++++++++++++++++++++++
>  4 files changed, 460 insertions(+)
>  create mode 100644 drivers/thermal/virtual-sensor.h
>  create mode 100644 drivers/thermal/virtual_sensor.c
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 7a4ba50ba97d0..23dc903da2fc5 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -228,6 +228,14 @@ config THERMAL_MMIO
>  	  register or shared memory, is a potential candidate to work with this
>  	  driver.
>  
> +config VIRTUAL_THERMAL
> +	tristate "Generic virtual thermal sensor driver"

Not sure if 'Generic' adds much value here.

> +	depends on THERMAL_OF || COMPILE_TEST
> +	help
> +	  This option enables the generic thermal sensor aggregator.
> +	  This driver creates a thermal sensor that reads the hardware sensors
> +	  and aggregate the temperature.
> +
>  config HISI_THERMAL
>  	tristate "Hisilicon thermal driver"
>  	depends on ARCH_HISI || COMPILE_TEST
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 9729a2b089919..76dfa1d61bfc5 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -60,3 +60,4 @@ obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
>  obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
>  obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
>  obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
> +obj-$(CONFIG_VIRTUAL_THERMAL) += virtual_sensor.o
> diff --git a/drivers/thermal/virtual-sensor.h b/drivers/thermal/virtual-sensor.h
> new file mode 100644
> index 0000000000000..e024d434856c7
> --- /dev/null
> +++ b/drivers/thermal/virtual-sensor.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2021 BayLibre
> + */
> +
> +#ifndef __THERMAL_VIRTUAL_SENSOR_H__
> +#define __THERMAL_VIRTUAL_SENSOR_H__
> +
> +struct virtual_sensor;
> +struct virtual_sensor_data;

Other types of virtual sensors could be added in the future, you might
want to name these virtual_thermal_sensor(_data). Then again, these
structs are of internal use only, so it's probably not super important.

> +
> +#ifdef CONFIG_VIRTUAL_THERMAL
> +struct virtual_sensor_data *
> +thermal_virtual_sensor_register(struct device *dev, int sensor_id, void *data,
> +				const struct thermal_zone_of_device_ops *ops);
> +void thermal_virtual_sensor_unregister(struct device *dev,
> +				       struct virtual_sensor_data *sensor_data);
> +struct virtual_sensor_data *
> +devm_thermal_virtual_sensor_register(struct device *dev, int sensor_id, void *data,
> +				     const struct thermal_zone_of_device_ops *ops);
> +
> +void devm_thermal_virtual_sensor_unregister(struct device *dev,
> +					    struct virtual_sensor *sensor);
> +#else
> +static inline struct virtual_sensor_data *
> +thermal_virtual_sensor_register(struct device *dev, int sensor_id, void *data,
> +				const struct thermal_zone_of_device_ops *ops)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +
> +void thermal_virtual_sensor_unregister(struct device *dev,
> +				       struct virtual_sensor_data *sensor_data)
> +{
> +}
> +
> +static inline struct virtual_sensor_data *
> +devm_thermal_virtual_sensor_register(struct device *dev, int sensor_id, void *data,
> +				     const struct thermal_zone_of_device_ops *ops)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +
> +static inline
> +void devm_thermal_virtual_sensor_unregister(struct device *dev,
> +					    struct virtual_sensor *sensor)
> +{
> +}
> +#endif
> +
> +#endif /* __THERMAL_VIRTUAL_SENSOR_H__ */
> diff --git a/drivers/thermal/virtual_sensor.c b/drivers/thermal/virtual_sensor.c
> new file mode 100644
> index 0000000000000..e5bb0ef9adb39
> --- /dev/null
> +++ b/drivers/thermal/virtual_sensor.c
> @@ -0,0 +1,400 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2021 BayLibre
> + */
> +
> +#include <linux/err.h>
> +#include <linux/export.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/slab.h>
> +#include <linux/thermal.h>
> +#include <linux/types.h>
> +#include <linux/string.h>
> +
> +#include <dt-bindings/thermal/virtual-sensor.h>
> +
> +#include "virtual-sensor.h"
> +
> +struct virtual_sensor_data {

This struct (typically) corresponds to an actual sensor, maybe name it
'thermal_sensor_data' instead?

> +	struct list_head node;
> +
> +	/* sensor interface */
> +	int id;
> +	void *sensor_data;
> +	const struct thermal_zone_of_device_ops *ops;
> +};
> +
> +struct virtual_sensor {
> +	int count;
> +	struct virtual_sensor_data *sensors;
> +	struct thermal_zone_device *tzd;
> +
> +	struct list_head node;
> +};
> +
> +static LIST_HEAD(thermal_sensors);
> +static LIST_HEAD(virtual_sensors);
> +
> +static int virtual_sensor_get_temp_max(void *data, int *temperature)
> +{
> +	struct virtual_sensor *sensor = data;
> +	int max_temp = INT_MIN;
> +	int temp;
> +	int i;
> +
> +	for (i = 0; i < sensor->count; i++) {
> +		struct virtual_sensor_data *hw_sensor;
> +
> +		hw_sensor = &sensor->sensors[i];
> +		if (!hw_sensor->ops)
> +			return -ENODEV;
> +
> +		hw_sensor->ops->get_temp(hw_sensor->sensor_data, &temp);
> +		max_temp = max(max_temp, temp);
> +	}
> +
> +	*temperature = max_temp;
> +
> +	return 0;
> +}
> +
> +static const struct thermal_zone_of_device_ops virtual_sensor_max_ops = {
> +	.get_temp = virtual_sensor_get_temp_max,
> +};
> +
> +static int virtual_sensor_get_temp_min(void *data, int *temperature)
> +{
> +	struct virtual_sensor *sensor = data;
> +	int min_temp = INT_MAX;
> +	int temp;
> +	int i;
> +
> +	for (i = 0; i < sensor->count; i++) {
> +		struct virtual_sensor_data *hw_sensor;
> +
> +		hw_sensor = &sensor->sensors[i];
> +		if (!hw_sensor->ops)
> +			return -ENODEV;
> +
> +		hw_sensor->ops->get_temp(hw_sensor->sensor_data, &temp);
> +		min_temp = min(min_temp, temp);
> +	}
> +
> +	*temperature = min_temp;
> +
> +	return 0;
> +}
> +
> +static const struct thermal_zone_of_device_ops virtual_sensor_min_ops = {
> +	.get_temp = virtual_sensor_get_temp_min,
> +};
> +
> +static int do_avg(int val1, int val2)
> +{
> +	return ((val1) / 2) + ((val2) / 2) + (((val1) % 2 + (val2) % 2) / 2);
> +}
> +
> +static int virtual_sensor_get_temp_avg(void *data, int *temperature)
> +{
> +	struct virtual_sensor *sensor = data;
> +	int avg_temp = 0;
> +	int temp;
> +	int i;
> +
> +	for (i = 0; i < sensor->count; i++) {
> +		struct virtual_sensor_data *hw_sensor;
> +
> +		hw_sensor = &sensor->sensors[i];
> +		if (!hw_sensor->ops)
> +			return -ENODEV;
> +
> +		hw_sensor->ops->get_temp(hw_sensor->sensor_data, &temp);
> +		avg_temp = do_avg(avg_temp, temp);
> +	}
> +
> +	*temperature = avg_temp;
> +
> +	return 0;
> +}

_get_temp_min(), _get_temp_max() and _get_temp_avg() have the same
structure, the only differences is the aggregator function and the
initialization value. If you wanted to save a few lines of code you
could have a meta-function that receives the initialization value and
a pointer of the aggregator function.

The functions are relatively short though, so I wouldn't claim that
it would be a huge improvement, one could also argue that the code is
easier to follow as is.

> +
> +static const struct thermal_zone_of_device_ops virtual_sensor_avg_ops = {
> +	.get_temp = virtual_sensor_get_temp_avg,
> +};
> +
> +static int register_virtual_sensor(struct virtual_sensor *sensor,
> +				    struct of_phandle_args args,
> +				    int index)

Does this really register a virtual sensor? IIUC the registered sensor is
(typically) an actual sensor, which is used by a virtual sensor.

Shouldn't it be something like 'register_thermal_sensor' or
'virtual_sensor_add_sensor'?

> +{
> +	struct virtual_sensor_data *sensor_data;
> +	int id;
> +
> +	list_for_each_entry(sensor_data, &thermal_sensors, node) {
> +		id = args.args_count ? args.args[0] : 0;
> +		if (sensor_data->id == id) {
> +			memcpy(&sensor->sensors[index], sensor_data,
> +				sizeof(*sensor_data));
> +			return 0;
> +		}
> +	}
> +
> +	return -ENODEV;
> +}
> +
> +static int virtual_sensor_probe(struct platform_device *pdev)
> +{
> +	const struct thermal_zone_of_device_ops *ops;
> +	struct virtual_sensor *sensor;
> +	struct device *dev = &pdev->dev;
> +	struct of_phandle_args args;
> +	u32 type;
> +	int ret;
> +	int i;
> +
> +	sensor = devm_kzalloc(dev, sizeof(*sensor), GFP_KERNEL);
> +	if (!sensor)
> +		return -ENOMEM;
> +
> +	sensor->count = of_count_phandle_with_args(dev->of_node,
> +						   "thermal-sensors",
> +						   "#thermal-sensor-cells");
> +	if (sensor->count <= 0)
> +		return -EINVAL;
> +
> +	sensor->sensors = devm_kmalloc_array(dev, sensor->count,
> +					     sizeof(*sensor->sensors),
> +					     GFP_KERNEL);
> +	if (!sensor->sensors)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < sensor->count; i++) {
> +		ret = of_parse_phandle_with_args(dev->of_node,
> +						 "thermal-sensors",
> +						 "#thermal-sensor-cells",
> +						 i,
> +						 &args);
> +		if (ret)
> +			return ret;
> +
> +		ret = register_virtual_sensor(sensor, args, i);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = of_property_read_u32(dev->of_node, "type", &type);

More a question for the binding, butthis should probably be something
more specific than 'type', like 'aggregation-function'.

> +	if (ret)
> +		return ret;
> +
> +	switch (type) {
> +	case VIRTUAL_SENSOR_MAX:
> +		ops = &virtual_sensor_max_ops;
> +		break;
> +	case VIRTUAL_SENSOR_MIN:
> +		ops = &virtual_sensor_min_ops;
> +		break;
> +	case VIRTUAL_SENSOR_AVG:
> +		ops = &virtual_sensor_avg_ops;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	sensor->tzd = devm_thermal_zone_of_sensor_register(dev, 0, sensor, ops);
> +	if (IS_ERR(sensor->tzd))
> +		return PTR_ERR(sensor->tzd);
> +
> +	platform_set_drvdata(pdev, sensor);
> +	list_add(&sensor->node, &virtual_sensors);

If you also added the sensor to 'thermal_sensors' you could support virtual
sensors using virtual sensors, though it's not clear how useful that would be
in practice and it could raise issues with the initialization order.

> +
> +	return 0;
> +}
> +
> +static int virtual_sensor_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct virtual_sensor *sensor;
> +
> +	sensor = platform_get_drvdata(pdev);
> +	list_del(&sensor->node);
> +
> +	devm_thermal_zone_of_sensor_unregister(dev, sensor->tzd);
> +	devm_kfree(dev, sensor->sensors);
> +	devm_kfree(dev, sensor);

Are the above 3 statements really needed, shouldn't devm_* handle that
automagically?

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id virtual_sensor_of_match[] = {
> +	{
> +		.compatible = "virtual,thermal-sensor",
> +	},
> +	{
> +	},
> +};
> +MODULE_DEVICE_TABLE(of, thermal_aggr_of_match);
> +
> +static struct platform_driver virtual_sensor = {
> +	.probe = virtual_sensor_probe,
> +	.remove = virtual_sensor_remove,
> +	.driver = {
> +		.name = "virtual-sensor",

I suggest to change it to 'virtual-thermal-sensor' since there might be
other types of virtual sensors.

> +		.of_match_table = virtual_sensor_of_match,
> +	},
> +};
> +
> +/**
> + * thermal_virtual_sensor_register - registers a sensor that could by a virtual

s/by/be/

> + * sensor
> + * @dev: a valid struct device pointer of a sensor device. Must contain
> + *       a valid .of_node, for the sensor node.
> + * @sensor_id: a sensor identifier, in case the sensor IP has more
> + *             than one sensors

s/sensors/sensor/

> + * @data: a private pointer (owned by the caller) that will be passed
> + *        back, when a temperature reading is needed.
> + * @ops: struct thermal_zone_of_device_ops *. Must contain at least .get_temp.
> + *
> + * This function will register a thermal sensor to make it available for later
> + * usage by a virtual sensor.
> + *
> + * The thermal zone temperature is provided by the @get_temp function
> + * pointer. When called, it will have the private pointer @data back.
> + *
> + * Return: On success returns a valid struct thermal_zone_device,
> + * otherwise, it returns a corresponding ERR_PTR(). Caller must
> + * check the return value with help of IS_ERR() helper.
> + */
> +struct virtual_sensor_data *thermal_virtual_sensor_register(
> +	struct device *dev, int sensor_id, void *data,
> +	const struct thermal_zone_of_device_ops *ops)
> +{
> +	struct virtual_sensor_data *sensor_data;
> +
> +	sensor_data = devm_kzalloc(dev, sizeof(*sensor_data), GFP_KERNEL);
> +	if (!sensor_data)
> +		return ERR_PTR(-ENOMEM);
> +
> +	sensor_data->id = sensor_id;
> +	sensor_data->sensor_data = data;
> +	sensor_data->ops = ops;
> +
> +	list_add(&sensor_data->node, &thermal_sensors);
> +
> +	return sensor_data;
> +}
> +EXPORT_SYMBOL_GPL(thermal_virtual_sensor_register);
> +
> +/**
> + * thermal_virtual_sensor_unregister - unregisters a sensor
> + * @dev: a valid struct device pointer of a sensor device.
> + * @sensor_data: a pointer to struct virtual_sensor_data to unregister.
> + *
> + * This function removes the sensor from the list of available thermal sensors.
> + * If the sensor is in use, then the next call to .get_temp will return -ENODEV.
> + */
> +void thermal_virtual_sensor_unregister(struct device *dev,
> +				       struct virtual_sensor_data *sensor_data)
> +{
> +	struct virtual_sensor_data *temp;

'temp' might not be the best name in this context, since it's associated with
temperature. Maybe name it 'sd'?

> +	struct virtual_sensor *sensor;
> +	int i;
> +
> +	list_del(&sensor_data->node);
> +
> +	list_for_each_entry(sensor, &virtual_sensors, node) {
> +		for (i = 0; i < sensor->count; i++) {
> +			temp = &sensor->sensors[i];
> +			if (temp->id == sensor_data->id &&
> +				temp->sensor_data == sensor_data->sensor_data) {
> +				temp->ops = NULL;
> +			}
> +		}
> +	}
> +	devm_kfree(dev, sensor_data);

Does it actually make sense to allocate the memory with devm_kzalloc() if
it is explicitly freed here?

> +}
> +EXPORT_SYMBOL_GPL(thermal_virtual_sensor_unregister);
> +
> +static void devm_thermal_virtual_sensor_release(struct device *dev, void *res)
> +{
> +	thermal_virtual_sensor_unregister(dev,
> +					  *(struct virtual_sensor_data **)res);
> +}
> +
> +static int devm_thermal_virtual_sensor_match(struct device *dev, void *res,
> +					     void *data)
> +{
> +	struct virtual_sensor_data **r = res;
> +
> +	if (WARN_ON(!r || !*r))
> +		return 0;
> +
> +	return *r == data;
> +}
> +
> +

delete one of the empty lines

> +/**
> + * devm_thermal_virtual_sensor_register - Resource managed version of
> + *				thermal_virtual_sensor_register()
> + * @dev: a valid struct device pointer of a sensor device. Must contain
> + *       a valid .of_node, for the sensor node.
> + * @sensor_id: a sensor identifier, in case the sensor IP has more
> + *	       than one sensors

s/sensors/sensor/

> + * @data: a private pointer (owned by the caller) that will be passed
> + *	  back, when a temperature reading is needed.
> + * @ops: struct thermal_zone_of_device_ops *. Must contain at least .get_temp.
> + *
> + * Refer thermal_zone_of_sensor_register() for more details.
> + *
> + * Return: On success returns a valid struct virtual_sensor_data,
> + * otherwise, it returns a corresponding ERR_PTR(). Caller must
> + * check the return value with help of IS_ERR() helper.
> + * Registered virtual_sensor_data device will automatically be
> + * released when device is unbounded.

s/unbounded/unbound/
