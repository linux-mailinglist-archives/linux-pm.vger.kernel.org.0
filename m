Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBEDA425994
	for <lists+linux-pm@lfdr.de>; Thu,  7 Oct 2021 19:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242634AbhJGRgA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Oct 2021 13:36:00 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:44655 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242002AbhJGRgA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Oct 2021 13:36:00 -0400
Received: by mail-ot1-f49.google.com with SMTP id o27-20020a9d411b000000b005453f95356cso7479598ote.11;
        Thu, 07 Oct 2021 10:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=65Bxf9hSsUl2w9ZWI9c8O9jDZzANCeJvv+oKIbPkQBY=;
        b=PPYqEKvkt1icwffcX3ADsxyyHbLugNnDhRpq8K9g3y4s8lIWmxQz1C+V0+jvTppKzV
         l99qgmFmxfA3GuzTNkssMLQXzKkO6/y/SumMc9YuDH2703Ye8DiO7vnnTo5pSpUekOHW
         z6G2vM7C62IjnS5Xe7uQoMcLYyjV1LJ4EP/f8L45SWeIyp79QAFgR7ef/fuoI05fP9WH
         7j3t3vY1BfT+XPl/3dOih/sQ07fhuiHO+hN7etjWsFBwn8dpemRXdVn1Hgh8Mk1EOTj/
         9f+71u0E2WjTOtrUKQGvpD+RLVMVzyOtsmTbZlOAdDf0gKaljfEBXni8TIiZVvGr8/6G
         zbHQ==
X-Gm-Message-State: AOAM533ceBfpim8r6GvgFzy9pj9r8u5h0K3P/yf/nSWEVYTe/q/47iga
        Um3r02FaItKKmSb/YT8THdn3p4sUJfo3bYmuntHmy/GLGPc=
X-Google-Smtp-Source: ABdhPJzkquijNZJe1vxXb6p+ewZe5cN39UcCX2UIRs3ybruwsjqKrNRFndX7W/GRcwvd3aD3O/e1+jXnzjx+C04cPu4=
X-Received: by 2002:a9d:2f24:: with SMTP id h33mr4876893otb.254.1633628045846;
 Thu, 07 Oct 2021 10:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210917072732.611140-1-abailon@baylibre.com> <20210917072732.611140-3-abailon@baylibre.com>
 <CAJZ5v0hzS-bquhW_wbsd81EpJYx5RHxeXkamdZ+MBs4oczDw1A@mail.gmail.com>
In-Reply-To: <CAJZ5v0hzS-bquhW_wbsd81EpJYx5RHxeXkamdZ+MBs4oczDw1A@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Oct 2021 19:33:54 +0200
Message-ID: <CAJZ5v0iSdi+gxR1UMiwM707ZBkvpgF8XaoB6VR7wiDq7MW8thA@mail.gmail.com>
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

On Thu, Oct 7, 2021 at 6:38 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Sep 17, 2021 at 9:25 AM Alexandre Bailon <abailon@baylibre.com> wrote:
> >
> > This adds a virtual thermal sensor that reads temperature from
>
> This should be "virtual sensor driver" I suppose.
>
> > hardware sensor and return an aggregated temperature.
>
> "returns"
>
> Also wrapping it around a single hardware sensor makes a little sense
> AFAICS, so I guess you mean "multiple hardware sensors" here.
>
> > Currently, this supports three operations:
> > the minimum, maximum and average temperature.
>
> They are aggregation functions rather than "operations"
>
> >
> > Reported-by: kernel test robot <lkp@intel.com>
>
> This is new code, so what does it fix?
>
> > Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> > ---
> >  drivers/thermal/Kconfig                  |   8 +
> >  drivers/thermal/Makefile                 |   1 +
> >  drivers/thermal/virtual-thermal-sensor.h |  54 ++++
> >  drivers/thermal/virtual_thermal_sensor.c | 350 +++++++++++++++++++++++
> >  4 files changed, 413 insertions(+)
> >  create mode 100644 drivers/thermal/virtual-thermal-sensor.h
> >  create mode 100644 drivers/thermal/virtual_thermal_sensor.c
> >
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index d7f44deab5b1d..20bc93c48f5b1 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -228,6 +228,14 @@ config THERMAL_MMIO
> >           register or shared memory, is a potential candidate to work with this
> >           driver.
> >
> > +config VIRTUAL_THERMAL
> > +       tristate "Virtual thermal sensor driver"
>
> This should be "DT-based virtual thermal sensor driver" I think.
>
> > +       depends on THERMAL_OF || COMPILE_TEST
> > +       help
> > +         This option enables the generic thermal sensor aggregator.
>
> "generic DT-based"
>
> > +         This driver creates a thermal sensor that reads the hardware sensors
>
> s/the/multiple/
>
> > +         and aggregate the temperature.
>
> "aggregates their output"
>
> > +
> >  config HISI_THERMAL
> >         tristate "Hisilicon thermal driver"
> >         depends on ARCH_HISI || COMPILE_TEST
> > diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> > index 82fc3e616e54b..8bf55973059c5 100644
> > --- a/drivers/thermal/Makefile
> > +++ b/drivers/thermal/Makefile
> > @@ -60,3 +60,4 @@ obj-$(CONFIG_UNIPHIER_THERMAL)        += uniphier_thermal.o
> >  obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
> >  obj-$(CONFIG_SPRD_THERMAL)     += sprd_thermal.o
> >  obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)   += khadas_mcu_fan.o
> > +obj-$(CONFIG_VIRTUAL_THERMAL) += virtual_thermal_sensor.o
> > diff --git a/drivers/thermal/virtual-thermal-sensor.h b/drivers/thermal/virtual-thermal-sensor.h
> > new file mode 100644
> > index 0000000000000..3bbf7c324dddc
> > --- /dev/null
> > +++ b/drivers/thermal/virtual-thermal-sensor.h
> > @@ -0,0 +1,54 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (c) 2021 BayLibre
> > + */
> > +
> > +#ifndef __THERMAL_VIRTUAL_SENSOR_H__
> > +#define __THERMAL_VIRTUAL_SENSOR_H__
> > +
> > +#include <linux/device.h>
> > +#include <linux/thermal.h>
> > +
> > +struct virtual_thermal_sensor;
> > +struct thermal_sensor_data;
> > +
> > +#if IS_ENABLED(CONFIG_VIRTUAL_THERMAL)
> > +struct thermal_sensor_data *
> > +thermal_virtual_sensor_register(struct device *dev, int sensor_id, void *data,
> > +                               const struct thermal_zone_of_device_ops *ops);
> > +void thermal_virtual_sensor_unregister(struct device *dev,
> > +                                      struct thermal_sensor_data *sensor_data);
> > +struct thermal_sensor_data *
> > +devm_thermal_virtual_sensor_register(struct device *dev, int sensor_id, void *data,
> > +                                    const struct thermal_zone_of_device_ops *ops);
> > +
> > +void devm_thermal_virtual_sensor_unregister(struct device *dev,
> > +                                           struct virtual_thermal_sensor *sensor);
> > +#else
> > +static inline struct thermal_sensor_data *
> > +thermal_virtual_sensor_register(struct device *dev, int sensor_id, void *data,
> > +                               const struct thermal_zone_of_device_ops *ops)
> > +{
> > +       return ERR_PTR(-ENODEV);
> > +}
> > +
> > +void thermal_virtual_sensor_unregister(struct device *dev,
> > +                                      struct thermal_sensor_data *sensor_data)
> > +{
> > +}
> > +
> > +static inline struct thermal_sensor_data *
> > +devm_thermal_virtual_sensor_register(struct device *dev, int sensor_id, void *data,
> > +                                    const struct thermal_zone_of_device_ops *ops)
> > +{
> > +       return ERR_PTR(-ENODEV);
> > +}
> > +
> > +static inline
> > +void devm_thermal_virtual_sensor_unregister(struct device *dev,
> > +                                           struct virtual_thermal_sensor *sensor)
> > +{
> > +}
> > +#endif
> > +
> > +#endif /* __THERMAL_VIRTUAL_SENSOR_H__ */
> > diff --git a/drivers/thermal/virtual_thermal_sensor.c b/drivers/thermal/virtual_thermal_sensor.c
> > new file mode 100644
> > index 0000000000000..234563af6643e
> > --- /dev/null
> > +++ b/drivers/thermal/virtual_thermal_sensor.c
> > @@ -0,0 +1,350 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2021 BayLibre
>
> Please add information on what's in this file to the preamble.
>
> > + */
> > +
> > +#include <linux/err.h>
> > +#include <linux/export.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/slab.h>
> > +#include <linux/thermal.h>
> > +#include <linux/types.h>
> > +#include <linux/string.h>
> > +
> > +#include <dt-bindings/thermal/virtual-sensor.h>
> > +
> > +#include "virtual-thermal-sensor.h"
> > +
> > +struct thermal_sensor_data {
> > +       struct list_head node;
> > +
> > +       /* sensor interface */
> > +       int id;
> > +       void *sensor_data;
> > +       const struct thermal_zone_of_device_ops *ops;
> > +};
> > +
> > +struct virtual_thermal_sensor {
> > +       int count;
> > +       struct thermal_sensor_data *sensors;
> > +       struct thermal_zone_device *tzd;
> > +       int (*aggr_temp)(int temp1, int temp2);
> > +
> > +       struct list_head node;
> > +};
> > +
> > +static LIST_HEAD(thermal_sensors);
> > +static LIST_HEAD(virtual_sensors);
>
> These lists don't seem to be protected against concurrent access and
> they should be.
>
> > +
> > +static int max_temp(int temp1, int temp2)
> > +{
> > +       return max(temp1, temp2);
> > +}
> > +
> > +static int min_temp(int temp1, int temp2)
> > +{
> > +       return min(temp1, temp2);
> > +}
> > +
> > +static int avg_temp(int temp1, int temp2)
> > +{
> > +       return ((temp1) / 2) + ((temp2) / 2) + (((temp1) % 2 + (temp2) % 2) / 2);
>
> There are a few redundant parens here.
>
> And why not
>
> return (temp1 + temp2) / 2;
>
> > +}
> > +
> > +static int virtual_thermal_sensor_get_temp(void *data, int *temperature)
> > +{
> > +       struct virtual_thermal_sensor *sensor = data;
> > +       int max_temp = INT_MIN;
> > +       int temp;
> > +       int i;
> > +
>
> Some synchronization (eg. locking) should be added to this.  It is racy as is.
>
> > +       for (i = 0; i < sensor->count; i++) {
> > +               struct thermal_sensor_data *hw_sensor;
> > +
> > +               hw_sensor = &sensor->sensors[i];
> > +               if (!hw_sensor->ops)
> > +                       return -ENODEV;
> > +
> > +               hw_sensor->ops->get_temp(hw_sensor->sensor_data, &temp);
> > +               max_temp = sensor->aggr_temp(max_temp, temp);
> > +       }
> > +
> > +       *temperature = max_temp;
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct thermal_zone_of_device_ops virtual_thermal_sensor_ops = {
> > +       .get_temp = virtual_thermal_sensor_get_temp,
> > +};
> > +
> > +static int virtual_sensor_add_sensor(struct virtual_thermal_sensor *sensor,
> > +                                    struct of_phandle_args args,
> > +                                    int index)
> > +{
> > +       struct thermal_sensor_data *sensor_data;
> > +       int id;
> > +
> > +       list_for_each_entry(sensor_data, &thermal_sensors, node) {
> > +               id = args.args_count ? args.args[0] : 0;
> > +               if (sensor_data->id == id) {
> > +                       memcpy(&sensor->sensors[index], sensor_data,
> > +                               sizeof(*sensor_data));
>
> The data object being copied includes pointers, so I wouldn't copy
> them like this.  Especially the ops one annotated as const.
>
> > +                       return 0;
> > +               }
> > +       }
> > +
> > +       return -ENODEV;
> > +}
> > +
> > +static int virtual_thermal_sensor_probe(struct platform_device *pdev)
> > +{
> > +       struct virtual_thermal_sensor *sensor;
> > +       struct device *dev = &pdev->dev;
> > +       struct of_phandle_args args;
> > +       u32 type;
> > +       int ret;
> > +       int i;
> > +
> > +       sensor = devm_kzalloc(dev, sizeof(*sensor), GFP_KERNEL);
> > +       if (!sensor)
> > +               return -ENOMEM;
> > +
> > +       sensor->count = of_count_phandle_with_args(dev->of_node,
> > +                                                  "thermal-sensors",
> > +                                                  "#thermal-sensor-cells");
> > +       if (sensor->count <= 0)
> > +               return -EINVAL;
> > +
> > +       sensor->sensors = devm_kmalloc_array(dev, sensor->count,
> > +                                            sizeof(*sensor->sensors),
> > +                                            GFP_KERNEL);
> > +       if (!sensor->sensors)
> > +               return -ENOMEM;
> > +
> > +       for (i = 0; i < sensor->count; i++) {
> > +               ret = of_parse_phandle_with_args(dev->of_node,
> > +                                                "thermal-sensors",
> > +                                                "#thermal-sensor-cells",
> > +                                                i,
> > +                                                &args);
> > +               if (ret)
> > +                       return ret;
> > +
> > +               ret = virtual_sensor_add_sensor(sensor, args, i);
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> > +       ret = of_property_read_u32(dev->of_node, "aggregation-function", &type);
> > +       if (ret)
> > +               return ret;
> > +
> > +       switch (type) {
> > +       case VIRTUAL_THERMAL_SENSOR_MAX:
> > +               sensor->aggr_temp = max_temp;
> > +               break;
> > +       case VIRTUAL_THERMAL_SENSOR_MIN:
> > +               sensor->aggr_temp = min_temp;
> > +               break;
> > +       case VIRTUAL_THERMAL_SENSOR_AVG:
> > +               sensor->aggr_temp = avg_temp;
> > +               break;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +
> > +       sensor->tzd = devm_thermal_zone_of_sensor_register(dev, 0, sensor,
> > +                                                          &virtual_thermal_sensor_ops);
> > +       if (IS_ERR(sensor->tzd))
> > +               return PTR_ERR(sensor->tzd);
> > +
> > +       platform_set_drvdata(pdev, sensor);
> > +       list_add(&sensor->node, &virtual_sensors);
> > +
> > +       return 0;
> > +}
> > +
> > +static int virtual_thermal_sensor_remove(struct platform_device *pdev)
> > +{
> > +       struct virtual_thermal_sensor *sensor;
> > +
> > +       sensor = platform_get_drvdata(pdev);
> > +       list_del(&sensor->node);
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct of_device_id virtual_thermal_sensor_of_match[] = {
> > +       {
> > +               .compatible = "virtual,thermal-sensor",
> > +       },
> > +       {
> > +       },
> > +};
> > +MODULE_DEVICE_TABLE(of, virtual_thermal_sensor_of_match);
> > +
> > +static struct platform_driver virtual_thermal_sensor = {
> > +       .probe = virtual_thermal_sensor_probe,
> > +       .remove = virtual_thermal_sensor_remove,
> > +       .driver = {
> > +               .name = "virtual-thermal-sensor",
> > +               .of_match_table = virtual_thermal_sensor_of_match,
> > +       },
> > +};
> > +
> > +/**
> > + * thermal_virtual_sensor_register - registers a sensor that could be a virtual
> > + * sensor
> > + * @dev: a valid struct device pointer of a sensor device. Must contain
> > + *       a valid .of_node, for the sensor node.
> > + * @sensor_id: a sensor identifier, in case the sensor IP has more
> > + *             than one sensor
> > + * @data: a private pointer (owned by the caller) that will be passed
> > + *        back, when a temperature reading is needed.
> > + * @ops: struct thermal_zone_of_device_ops *. Must contain at least .get_temp.
> > + *
> > + * This function will register a thermal sensor to make it available for later
> > + * usage by a virtual sensor.
>
> So who's expected to be calling it?
>
> > + *
> > + * The thermal zone temperature is provided by the @get_temp function
> > + * pointer. When called, it will have the private pointer @data back.
>
> It is unclear what you mean here.  I think you are describing a return
> mechanism, but as is it is hard to follow.
>
> > + *
> > + * Return: On success returns a valid struct thermal_zone_device,
>
> That doesn't seem to be the case.  It returns an address returned by
> devm_kzalloc() and the memory at that address is expected to be a
> thermal_sensor_data object.
>
> > + * otherwise, it returns a corresponding ERR_PTR(). Caller must
> > + * check the return value with help of IS_ERR() helper.
> > + */
> > +struct thermal_sensor_data *thermal_virtual_sensor_register(
> > +       struct device *dev, int sensor_id, void *data,
> > +       const struct thermal_zone_of_device_ops *ops)
> > +{
> > +       struct thermal_sensor_data *sensor_data;
> > +
> > +       sensor_data = devm_kzalloc(dev, sizeof(*sensor_data), GFP_KERNEL);
> > +       if (!sensor_data)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       sensor_data->id = sensor_id;
> > +       sensor_data->sensor_data = data;
> > +       sensor_data->ops = ops;
> > +
> > +       list_add(&sensor_data->node, &thermal_sensors);
> > +
> > +       return sensor_data;
>
> Overall, this is non-modular code squeezed into a module.
>
> If this module goes away and whoever called it wants to unregister the
> sensor, they will crash, so to a minimum it should do a
> try_module_get() on the module containing it.

And that wouldn't be sufficient either, because in theory the module
may go away before that try_module_get() gets called.  Sorry for the
confusion.
