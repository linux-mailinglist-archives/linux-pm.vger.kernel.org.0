Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A792B42581F
	for <lists+linux-pm@lfdr.de>; Thu,  7 Oct 2021 18:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242739AbhJGQk3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Oct 2021 12:40:29 -0400
Received: from mail-oo1-f45.google.com ([209.85.161.45]:39482 "EHLO
        mail-oo1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242741AbhJGQk2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Oct 2021 12:40:28 -0400
Received: by mail-oo1-f45.google.com with SMTP id w6-20020a4aa446000000b002b5795cca03so2063183ool.6;
        Thu, 07 Oct 2021 09:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TjMmO2IxAOZIC3m03JaHCGs++YE7N3juOkB6T+6+wp4=;
        b=xAQDYEdPla7w92tteRj6bm1BGkVQeT9DmgfiOg/MAyUpMDFsemo/wCf9srq/75zR0Z
         5Lwe85oK/SNakyF3otPDrRFE9MW71tTOc0aii/E67+oFNcsvjeDP50HGSTLimACpM1Yx
         TO62Z9IZ0MuQrVShYkBWkSsINdqgs7Am9vTOFbqiNLAGx3sU2IHCI4uBusQxo4U8JuDe
         8prQwta+9hQbzP7z/PNwD/adM61Ww0AH9Phi72tky8C0efbrr1sSWuHQ17miK1MWnEwU
         3BeoIMmqcbZjC3+scV0NSed442NxVBXKp95NFdnrCSTdvo8XGBR5mREJpMfR8Hzcmhou
         n7iw==
X-Gm-Message-State: AOAM531ImQpN0tGcgqUj/eQHcZlfSkRvj4M6NBpVrVkoVdBYsnLvp4kO
        CihNwraooBvRMqoE/YOkc7izkQCrAJrvg3MUh3s=
X-Google-Smtp-Source: ABdhPJxDxECnTmSq8NTUKBHaaEYRGx/1hNhf627Mcbne7oGVk8BJefmwbgL2nTWBv6XJ/3AQUcAa4fN0wJadLc2cqvM=
X-Received: by 2002:a4a:a9ce:: with SMTP id h14mr4062989oon.89.1633624713833;
 Thu, 07 Oct 2021 09:38:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210917072732.611140-1-abailon@baylibre.com> <20210917072732.611140-3-abailon@baylibre.com>
In-Reply-To: <20210917072732.611140-3-abailon@baylibre.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Oct 2021 18:38:22 +0200
Message-ID: <CAJZ5v0hzS-bquhW_wbsd81EpJYx5RHxeXkamdZ+MBs4oczDw1A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] thermal: add a virtual sensor to aggregate temperatures
To:     Alexandre Bailon <abailon@baylibre.com>
Cc:     "Zhang, Rui" <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ben.tseng@mediatek.com, Kevin Hilman <khilman@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 17, 2021 at 9:25 AM Alexandre Bailon <abailon@baylibre.com> wrote:
>
> This adds a virtual thermal sensor that reads temperature from

This should be "virtual sensor driver" I suppose.

> hardware sensor and return an aggregated temperature.

"returns"

Also wrapping it around a single hardware sensor makes a little sense
AFAICS, so I guess you mean "multiple hardware sensors" here.

> Currently, this supports three operations:
> the minimum, maximum and average temperature.

They are aggregation functions rather than "operations"

>
> Reported-by: kernel test robot <lkp@intel.com>

This is new code, so what does it fix?

> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>  drivers/thermal/Kconfig                  |   8 +
>  drivers/thermal/Makefile                 |   1 +
>  drivers/thermal/virtual-thermal-sensor.h |  54 ++++
>  drivers/thermal/virtual_thermal_sensor.c | 350 +++++++++++++++++++++++
>  4 files changed, 413 insertions(+)
>  create mode 100644 drivers/thermal/virtual-thermal-sensor.h
>  create mode 100644 drivers/thermal/virtual_thermal_sensor.c
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index d7f44deab5b1d..20bc93c48f5b1 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -228,6 +228,14 @@ config THERMAL_MMIO
>           register or shared memory, is a potential candidate to work with this
>           driver.
>
> +config VIRTUAL_THERMAL
> +       tristate "Virtual thermal sensor driver"

This should be "DT-based virtual thermal sensor driver" I think.

> +       depends on THERMAL_OF || COMPILE_TEST
> +       help
> +         This option enables the generic thermal sensor aggregator.

"generic DT-based"

> +         This driver creates a thermal sensor that reads the hardware sensors

s/the/multiple/

> +         and aggregate the temperature.

"aggregates their output"

> +
>  config HISI_THERMAL
>         tristate "Hisilicon thermal driver"
>         depends on ARCH_HISI || COMPILE_TEST
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 82fc3e616e54b..8bf55973059c5 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -60,3 +60,4 @@ obj-$(CONFIG_UNIPHIER_THERMAL)        += uniphier_thermal.o
>  obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
>  obj-$(CONFIG_SPRD_THERMAL)     += sprd_thermal.o
>  obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)   += khadas_mcu_fan.o
> +obj-$(CONFIG_VIRTUAL_THERMAL) += virtual_thermal_sensor.o
> diff --git a/drivers/thermal/virtual-thermal-sensor.h b/drivers/thermal/virtual-thermal-sensor.h
> new file mode 100644
> index 0000000000000..3bbf7c324dddc
> --- /dev/null
> +++ b/drivers/thermal/virtual-thermal-sensor.h
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2021 BayLibre
> + */
> +
> +#ifndef __THERMAL_VIRTUAL_SENSOR_H__
> +#define __THERMAL_VIRTUAL_SENSOR_H__
> +
> +#include <linux/device.h>
> +#include <linux/thermal.h>
> +
> +struct virtual_thermal_sensor;
> +struct thermal_sensor_data;
> +
> +#if IS_ENABLED(CONFIG_VIRTUAL_THERMAL)
> +struct thermal_sensor_data *
> +thermal_virtual_sensor_register(struct device *dev, int sensor_id, void *data,
> +                               const struct thermal_zone_of_device_ops *ops);
> +void thermal_virtual_sensor_unregister(struct device *dev,
> +                                      struct thermal_sensor_data *sensor_data);
> +struct thermal_sensor_data *
> +devm_thermal_virtual_sensor_register(struct device *dev, int sensor_id, void *data,
> +                                    const struct thermal_zone_of_device_ops *ops);
> +
> +void devm_thermal_virtual_sensor_unregister(struct device *dev,
> +                                           struct virtual_thermal_sensor *sensor);
> +#else
> +static inline struct thermal_sensor_data *
> +thermal_virtual_sensor_register(struct device *dev, int sensor_id, void *data,
> +                               const struct thermal_zone_of_device_ops *ops)
> +{
> +       return ERR_PTR(-ENODEV);
> +}
> +
> +void thermal_virtual_sensor_unregister(struct device *dev,
> +                                      struct thermal_sensor_data *sensor_data)
> +{
> +}
> +
> +static inline struct thermal_sensor_data *
> +devm_thermal_virtual_sensor_register(struct device *dev, int sensor_id, void *data,
> +                                    const struct thermal_zone_of_device_ops *ops)
> +{
> +       return ERR_PTR(-ENODEV);
> +}
> +
> +static inline
> +void devm_thermal_virtual_sensor_unregister(struct device *dev,
> +                                           struct virtual_thermal_sensor *sensor)
> +{
> +}
> +#endif
> +
> +#endif /* __THERMAL_VIRTUAL_SENSOR_H__ */
> diff --git a/drivers/thermal/virtual_thermal_sensor.c b/drivers/thermal/virtual_thermal_sensor.c
> new file mode 100644
> index 0000000000000..234563af6643e
> --- /dev/null
> +++ b/drivers/thermal/virtual_thermal_sensor.c
> @@ -0,0 +1,350 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2021 BayLibre

Please add information on what's in this file to the preamble.

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
> +#include "virtual-thermal-sensor.h"
> +
> +struct thermal_sensor_data {
> +       struct list_head node;
> +
> +       /* sensor interface */
> +       int id;
> +       void *sensor_data;
> +       const struct thermal_zone_of_device_ops *ops;
> +};
> +
> +struct virtual_thermal_sensor {
> +       int count;
> +       struct thermal_sensor_data *sensors;
> +       struct thermal_zone_device *tzd;
> +       int (*aggr_temp)(int temp1, int temp2);
> +
> +       struct list_head node;
> +};
> +
> +static LIST_HEAD(thermal_sensors);
> +static LIST_HEAD(virtual_sensors);

These lists don't seem to be protected against concurrent access and
they should be.

> +
> +static int max_temp(int temp1, int temp2)
> +{
> +       return max(temp1, temp2);
> +}
> +
> +static int min_temp(int temp1, int temp2)
> +{
> +       return min(temp1, temp2);
> +}
> +
> +static int avg_temp(int temp1, int temp2)
> +{
> +       return ((temp1) / 2) + ((temp2) / 2) + (((temp1) % 2 + (temp2) % 2) / 2);

There are a few redundant parens here.

And why not

return (temp1 + temp2) / 2;

> +}
> +
> +static int virtual_thermal_sensor_get_temp(void *data, int *temperature)
> +{
> +       struct virtual_thermal_sensor *sensor = data;
> +       int max_temp = INT_MIN;
> +       int temp;
> +       int i;
> +

Some synchronization (eg. locking) should be added to this.  It is racy as is.

> +       for (i = 0; i < sensor->count; i++) {
> +               struct thermal_sensor_data *hw_sensor;
> +
> +               hw_sensor = &sensor->sensors[i];
> +               if (!hw_sensor->ops)
> +                       return -ENODEV;
> +
> +               hw_sensor->ops->get_temp(hw_sensor->sensor_data, &temp);
> +               max_temp = sensor->aggr_temp(max_temp, temp);
> +       }
> +
> +       *temperature = max_temp;
> +
> +       return 0;
> +}
> +
> +static const struct thermal_zone_of_device_ops virtual_thermal_sensor_ops = {
> +       .get_temp = virtual_thermal_sensor_get_temp,
> +};
> +
> +static int virtual_sensor_add_sensor(struct virtual_thermal_sensor *sensor,
> +                                    struct of_phandle_args args,
> +                                    int index)
> +{
> +       struct thermal_sensor_data *sensor_data;
> +       int id;
> +
> +       list_for_each_entry(sensor_data, &thermal_sensors, node) {
> +               id = args.args_count ? args.args[0] : 0;
> +               if (sensor_data->id == id) {
> +                       memcpy(&sensor->sensors[index], sensor_data,
> +                               sizeof(*sensor_data));

The data object being copied includes pointers, so I wouldn't copy
them like this.  Especially the ops one annotated as const.

> +                       return 0;
> +               }
> +       }
> +
> +       return -ENODEV;
> +}
> +
> +static int virtual_thermal_sensor_probe(struct platform_device *pdev)
> +{
> +       struct virtual_thermal_sensor *sensor;
> +       struct device *dev = &pdev->dev;
> +       struct of_phandle_args args;
> +       u32 type;
> +       int ret;
> +       int i;
> +
> +       sensor = devm_kzalloc(dev, sizeof(*sensor), GFP_KERNEL);
> +       if (!sensor)
> +               return -ENOMEM;
> +
> +       sensor->count = of_count_phandle_with_args(dev->of_node,
> +                                                  "thermal-sensors",
> +                                                  "#thermal-sensor-cells");
> +       if (sensor->count <= 0)
> +               return -EINVAL;
> +
> +       sensor->sensors = devm_kmalloc_array(dev, sensor->count,
> +                                            sizeof(*sensor->sensors),
> +                                            GFP_KERNEL);
> +       if (!sensor->sensors)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < sensor->count; i++) {
> +               ret = of_parse_phandle_with_args(dev->of_node,
> +                                                "thermal-sensors",
> +                                                "#thermal-sensor-cells",
> +                                                i,
> +                                                &args);
> +               if (ret)
> +                       return ret;
> +
> +               ret = virtual_sensor_add_sensor(sensor, args, i);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       ret = of_property_read_u32(dev->of_node, "aggregation-function", &type);
> +       if (ret)
> +               return ret;
> +
> +       switch (type) {
> +       case VIRTUAL_THERMAL_SENSOR_MAX:
> +               sensor->aggr_temp = max_temp;
> +               break;
> +       case VIRTUAL_THERMAL_SENSOR_MIN:
> +               sensor->aggr_temp = min_temp;
> +               break;
> +       case VIRTUAL_THERMAL_SENSOR_AVG:
> +               sensor->aggr_temp = avg_temp;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       sensor->tzd = devm_thermal_zone_of_sensor_register(dev, 0, sensor,
> +                                                          &virtual_thermal_sensor_ops);
> +       if (IS_ERR(sensor->tzd))
> +               return PTR_ERR(sensor->tzd);
> +
> +       platform_set_drvdata(pdev, sensor);
> +       list_add(&sensor->node, &virtual_sensors);
> +
> +       return 0;
> +}
> +
> +static int virtual_thermal_sensor_remove(struct platform_device *pdev)
> +{
> +       struct virtual_thermal_sensor *sensor;
> +
> +       sensor = platform_get_drvdata(pdev);
> +       list_del(&sensor->node);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id virtual_thermal_sensor_of_match[] = {
> +       {
> +               .compatible = "virtual,thermal-sensor",
> +       },
> +       {
> +       },
> +};
> +MODULE_DEVICE_TABLE(of, virtual_thermal_sensor_of_match);
> +
> +static struct platform_driver virtual_thermal_sensor = {
> +       .probe = virtual_thermal_sensor_probe,
> +       .remove = virtual_thermal_sensor_remove,
> +       .driver = {
> +               .name = "virtual-thermal-sensor",
> +               .of_match_table = virtual_thermal_sensor_of_match,
> +       },
> +};
> +
> +/**
> + * thermal_virtual_sensor_register - registers a sensor that could be a virtual
> + * sensor
> + * @dev: a valid struct device pointer of a sensor device. Must contain
> + *       a valid .of_node, for the sensor node.
> + * @sensor_id: a sensor identifier, in case the sensor IP has more
> + *             than one sensor
> + * @data: a private pointer (owned by the caller) that will be passed
> + *        back, when a temperature reading is needed.
> + * @ops: struct thermal_zone_of_device_ops *. Must contain at least .get_temp.
> + *
> + * This function will register a thermal sensor to make it available for later
> + * usage by a virtual sensor.

So who's expected to be calling it?

> + *
> + * The thermal zone temperature is provided by the @get_temp function
> + * pointer. When called, it will have the private pointer @data back.

It is unclear what you mean here.  I think you are describing a return
mechanism, but as is it is hard to follow.

> + *
> + * Return: On success returns a valid struct thermal_zone_device,

That doesn't seem to be the case.  It returns an address returned by
devm_kzalloc() and the memory at that address is expected to be a
thermal_sensor_data object.

> + * otherwise, it returns a corresponding ERR_PTR(). Caller must
> + * check the return value with help of IS_ERR() helper.
> + */
> +struct thermal_sensor_data *thermal_virtual_sensor_register(
> +       struct device *dev, int sensor_id, void *data,
> +       const struct thermal_zone_of_device_ops *ops)
> +{
> +       struct thermal_sensor_data *sensor_data;
> +
> +       sensor_data = devm_kzalloc(dev, sizeof(*sensor_data), GFP_KERNEL);
> +       if (!sensor_data)
> +               return ERR_PTR(-ENOMEM);
> +
> +       sensor_data->id = sensor_id;
> +       sensor_data->sensor_data = data;
> +       sensor_data->ops = ops;
> +
> +       list_add(&sensor_data->node, &thermal_sensors);
> +
> +       return sensor_data;

Overall, this is non-modular code squeezed into a module.

If this module goes away and whoever called it wants to unregister the
sensor, they will crash, so to a minimum it should do a
try_module_get() on the module containing it.

> +}
> +EXPORT_SYMBOL_GPL(thermal_virtual_sensor_register);
> +
> +/**
> + * thermal_virtual_sensor_unregister - unregisters a sensor
> + * @dev: a valid struct device pointer of a sensor device.
> + * @sensor_data: a pointer to struct thermal_sensor_data to unregister.
> + *
> + * This function removes the sensor from the list of available thermal sensors.
> + * If the sensor is in use, then the next call to .get_temp will return -ENODEV.
> + */
> +void thermal_virtual_sensor_unregister(struct device *dev,
> +                                      struct thermal_sensor_data *sensor_data)
> +{
> +       struct thermal_sensor_data *sd;
> +       struct virtual_thermal_sensor *sensor;
> +       int i;
> +

All of the code in this function is obviously racy.

> +       list_del(&sensor_data->node);
> +
> +       list_for_each_entry(sensor, &virtual_sensors, node) {
> +               for (i = 0; i < sensor->count; i++) {
> +                       sd = &sensor->sensors[i];
> +                       if (sd->id == sensor_data->id &&
> +                               sd->sensor_data == sensor_data->sensor_data) {
> +                               sd->ops = NULL;
> +                       }

The inner braces are not necessary.

> +               }
> +       }

And again, this code requires the module to be protected from
unloading until the last instance of
thermal_virtual_sensor_unregister() has returned.

> +}
> +EXPORT_SYMBOL_GPL(thermal_virtual_sensor_unregister);
> +
> +static void devm_thermal_virtual_sensor_release(struct device *dev, void *res)
> +{
> +       thermal_virtual_sensor_unregister(dev,
> +                                         *(struct thermal_sensor_data **)res);
> +}
> +
> +static int devm_thermal_virtual_sensor_match(struct device *dev, void *res,
> +                                            void *data)
> +{
> +       struct thermal_sensor_data **r = res;
> +
> +       if (WARN_ON(!r || !*r))
> +               return 0;
> +
> +       return *r == data;
> +}
> +
> +/**
> + * devm_thermal_virtual_sensor_register - Resource managed version of
> + *                             thermal_virtual_sensor_register()
> + * @dev: a valid struct device pointer of a sensor device. Must contain
> + *       a valid .of_node, for the sensor node.
> + * @sensor_id: a sensor identifier, in case the sensor IP has more
> + *            than one sensor
> + * @data: a private pointer (owned by the caller) that will be passed
> + *       back, when a temperature reading is needed.
> + * @ops: struct thermal_zone_of_device_ops *. Must contain at least .get_temp.
> + *
> + * Refer thermal_zone_of_sensor_register() for more details.
> + *
> + * Return: On success returns a valid struct virtual_sensor_data,
> + * otherwise, it returns a corresponding ERR_PTR(). Caller must
> + * check the return value with help of IS_ERR() helper.
> + * Registered virtual_sensor_data device will automatically be
> + * released when device is unbound.
> + */
> +struct thermal_sensor_data *devm_thermal_virtual_sensor_register(
> +       struct device *dev, int sensor_id,
> +       void *data, const struct thermal_zone_of_device_ops *ops)
> +{
> +       struct thermal_sensor_data **ptr, *sensor_data;
> +
> +       ptr = devres_alloc(devm_thermal_virtual_sensor_release, sizeof(*ptr),
> +                          GFP_KERNEL);
> +       if (!ptr)
> +               return ERR_PTR(-ENOMEM);
> +
> +       sensor_data = thermal_virtual_sensor_register(dev, sensor_id, data, ops);
> +       if (IS_ERR(sensor_data)) {
> +               devres_free(ptr);
> +               return sensor_data;
> +       }
> +
> +       *ptr = sensor_data;
> +       devres_add(dev, ptr);
> +
> +       return sensor_data;
> +}
> +EXPORT_SYMBOL_GPL(devm_thermal_virtual_sensor_register);
> +
> +/**
> + * devm_thermal_virtual_sensor_unregister - Resource managed version of
> + *                             thermal_virtual_sensor_unregister().
> + * @dev: Device for which resource was allocated.
> + * @sensor: a pointer to struct thermal_zone_device where the sensor is registered.
> + *
> + * This function removes the sensor from the list of sensors registered with
> + * devm_thermal_virtual_sensor_register() API.
> + * Normally this function will not need to be called and the resource
> + * management code will ensure that the resource is freed.
> + */
> +void devm_thermal_virtual_sensor_unregister(struct device *dev,
> +                                           struct virtual_thermal_sensor *sensor)
> +{
> +       WARN_ON(devres_release(dev, devm_thermal_virtual_sensor_release,
> +                              devm_thermal_virtual_sensor_match, sensor));
> +}
> +EXPORT_SYMBOL_GPL(devm_thermal_virtual_sensor_unregister);
> +
> +module_platform_driver(virtual_thermal_sensor);
> +MODULE_AUTHOR("Alexandre Bailon <abailon@baylibre.com>");
> +MODULE_DESCRIPTION("Virtual thermal sensor");
> +MODULE_LICENSE("GPL v2");
> --
