Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809B743922B
	for <lists+linux-pm@lfdr.de>; Mon, 25 Oct 2021 11:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhJYJVI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Oct 2021 05:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhJYJVH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Oct 2021 05:21:07 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C937C061745
        for <linux-pm@vger.kernel.org>; Mon, 25 Oct 2021 02:18:45 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id m22so8278192wrb.0
        for <linux-pm@vger.kernel.org>; Mon, 25 Oct 2021 02:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=0K9oB98vATUamjzcj4tEx34ixsH0x5kxvFZkUIoQchU=;
        b=NHOJnriy88T7pDK4sQmB6lhS5lYRZ/MJVBr86E+4g0o3/8heQl44c1eS3bh1ERDQJ3
         FwoGAVVtjyhwE5d9IMdo+lK+sLVoGZF5VT2kCr2Ha85LNwvbFVRCdzrz14omoXr4mpIB
         FQz8zociPSx5GVnSslgA911ApR4TdRvfzkvpS1IqRODcslyTwVYzS0QalPShvygVH9qI
         CbvEpcUx+4AUzDgx3AJLWZS/+i5jsWkluIRoJBNLAQKRwUZUApcLaxYzVyy88FeHGyhl
         HbjHj1jQ+qu9Ru+PhPOCbhMdHsax+MGeJ8UfUDxxBRNMnW4VMMKhiMAMvGqLcxYy2voL
         eLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0K9oB98vATUamjzcj4tEx34ixsH0x5kxvFZkUIoQchU=;
        b=kKSX/RA1sDjspEZBsBvbGgRxFcbEf2KO5LWPvIQjN9N1VvzqTdaRw1kNJfHho1ylM5
         02u0Pw8lVVs1wRNLygdxw1vy3dkVt5ZqbRm0+9RYBuaeRC4UE9RJ3GqZyywAfx+1ARP0
         3NUBbbhATJaXUVi9pbhEqPDuFkVGixIvQRc/c3P+tNvzbJi1S0R8uN/x4ZKJrEnLF24P
         fZDHBoyV6AmjUazS26k7e3Qu0eQdDJpj8lDWtsUnTDvjLlQG47kUon0s80lE3h+1w8ae
         QThPo1EYMnyWFHdcpQKQ+YC0wlwuD7GeOA4Y4S+yaD9mCJlWwnx5Elc6r8NF4xmnNTMN
         b1DA==
X-Gm-Message-State: AOAM533NScmv3UGRmxKEYxXJO/gFPavael40GM8C9Zmw7aWjSRw2kXkK
        YEYHjAZoAZeWK0cejOPIBdLg8g==
X-Google-Smtp-Source: ABdhPJxsHYv5D1e4MOoOjcNIhsMhyzMjTeKl7RG08cQIDI34OH90nsHgm5c1+PBJ2k2tMvWM38YzXw==
X-Received: by 2002:adf:ebd0:: with SMTP id v16mr17426184wrn.291.1635153524008;
        Mon, 25 Oct 2021 02:18:44 -0700 (PDT)
Received: from [10.1.3.133] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q14sm18161591wmq.4.2021.10.25.02.18.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 02:18:43 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] thermal: add a virtual sensor to aggregate
 temperatures
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Zhang, Rui" <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ben.tseng@mediatek.com, Kevin Hilman <khilman@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        kernel test robot <lkp@intel.com>
References: <20210917072732.611140-1-abailon@baylibre.com>
 <20210917072732.611140-3-abailon@baylibre.com>
 <CAJZ5v0hzS-bquhW_wbsd81EpJYx5RHxeXkamdZ+MBs4oczDw1A@mail.gmail.com>
From:   Alexandre Bailon <abailon@baylibre.com>
Message-ID: <2fc7f8c1-a33a-85bb-33a0-3ff1bf3fb789@baylibre.com>
Date:   Mon, 25 Oct 2021 11:18:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hzS-bquhW_wbsd81EpJYx5RHxeXkamdZ+MBs4oczDw1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On 10/7/21 6:38 PM, Rafael J. Wysocki wrote:
> On Fri, Sep 17, 2021 at 9:25 AM Alexandre Bailon <abailon@baylibre.com> wrote:
>> This adds a virtual thermal sensor that reads temperature from
> This should be "virtual sensor driver" I suppose.
>
>> hardware sensor and return an aggregated temperature.
> "returns"
>
> Also wrapping it around a single hardware sensor makes a little sense
> AFAICS, so I guess you mean "multiple hardware sensors" here.
>
>> Currently, this supports three operations:
>> the minimum, maximum and average temperature.
> They are aggregation functions rather than "operations"
>
>> Reported-by: kernel test robot <lkp@intel.com>
> This is new code, so what does it fix?
The CI has found some build issues.
I was not sure if I had to add this or not.
>
>> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
>> ---
>>   drivers/thermal/Kconfig                  |   8 +
>>   drivers/thermal/Makefile                 |   1 +
>>   drivers/thermal/virtual-thermal-sensor.h |  54 ++++
>>   drivers/thermal/virtual_thermal_sensor.c | 350 +++++++++++++++++++++++
>>   4 files changed, 413 insertions(+)
>>   create mode 100644 drivers/thermal/virtual-thermal-sensor.h
>>   create mode 100644 drivers/thermal/virtual_thermal_sensor.c
>>
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index d7f44deab5b1d..20bc93c48f5b1 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -228,6 +228,14 @@ config THERMAL_MMIO
>>            register or shared memory, is a potential candidate to work with this
>>            driver.
>>
>> +config VIRTUAL_THERMAL
>> +       tristate "Virtual thermal sensor driver"
> This should be "DT-based virtual thermal sensor driver" I think.
>
>> +       depends on THERMAL_OF || COMPILE_TEST
>> +       help
>> +         This option enables the generic thermal sensor aggregator.
> "generic DT-based"
>
>> +         This driver creates a thermal sensor that reads the hardware sensors
> s/the/multiple/
>
>> +         and aggregate the temperature.
> "aggregates their output"
>
>> +
>>   config HISI_THERMAL
>>          tristate "Hisilicon thermal driver"
>>          depends on ARCH_HISI || COMPILE_TEST
>> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
>> index 82fc3e616e54b..8bf55973059c5 100644
>> --- a/drivers/thermal/Makefile
>> +++ b/drivers/thermal/Makefile
>> @@ -60,3 +60,4 @@ obj-$(CONFIG_UNIPHIER_THERMAL)        += uniphier_thermal.o
>>   obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
>>   obj-$(CONFIG_SPRD_THERMAL)     += sprd_thermal.o
>>   obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)   += khadas_mcu_fan.o
>> +obj-$(CONFIG_VIRTUAL_THERMAL) += virtual_thermal_sensor.o
>> diff --git a/drivers/thermal/virtual-thermal-sensor.h b/drivers/thermal/virtual-thermal-sensor.h
>> new file mode 100644
>> index 0000000000000..3bbf7c324dddc
>> --- /dev/null
>> +++ b/drivers/thermal/virtual-thermal-sensor.h
>> @@ -0,0 +1,54 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (c) 2021 BayLibre
>> + */
>> +
>> +#ifndef __THERMAL_VIRTUAL_SENSOR_H__
>> +#define __THERMAL_VIRTUAL_SENSOR_H__
>> +
>> +#include <linux/device.h>
>> +#include <linux/thermal.h>
>> +
>> +struct virtual_thermal_sensor;
>> +struct thermal_sensor_data;
>> +
>> +#if IS_ENABLED(CONFIG_VIRTUAL_THERMAL)
>> +struct thermal_sensor_data *
>> +thermal_virtual_sensor_register(struct device *dev, int sensor_id, void *data,
>> +                               const struct thermal_zone_of_device_ops *ops);
>> +void thermal_virtual_sensor_unregister(struct device *dev,
>> +                                      struct thermal_sensor_data *sensor_data);
>> +struct thermal_sensor_data *
>> +devm_thermal_virtual_sensor_register(struct device *dev, int sensor_id, void *data,
>> +                                    const struct thermal_zone_of_device_ops *ops);
>> +
>> +void devm_thermal_virtual_sensor_unregister(struct device *dev,
>> +                                           struct virtual_thermal_sensor *sensor);
>> +#else
>> +static inline struct thermal_sensor_data *
>> +thermal_virtual_sensor_register(struct device *dev, int sensor_id, void *data,
>> +                               const struct thermal_zone_of_device_ops *ops)
>> +{
>> +       return ERR_PTR(-ENODEV);
>> +}
>> +
>> +void thermal_virtual_sensor_unregister(struct device *dev,
>> +                                      struct thermal_sensor_data *sensor_data)
>> +{
>> +}
>> +
>> +static inline struct thermal_sensor_data *
>> +devm_thermal_virtual_sensor_register(struct device *dev, int sensor_id, void *data,
>> +                                    const struct thermal_zone_of_device_ops *ops)
>> +{
>> +       return ERR_PTR(-ENODEV);
>> +}
>> +
>> +static inline
>> +void devm_thermal_virtual_sensor_unregister(struct device *dev,
>> +                                           struct virtual_thermal_sensor *sensor)
>> +{
>> +}
>> +#endif
>> +
>> +#endif /* __THERMAL_VIRTUAL_SENSOR_H__ */
>> diff --git a/drivers/thermal/virtual_thermal_sensor.c b/drivers/thermal/virtual_thermal_sensor.c
>> new file mode 100644
>> index 0000000000000..234563af6643e
>> --- /dev/null
>> +++ b/drivers/thermal/virtual_thermal_sensor.c
>> @@ -0,0 +1,350 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2021 BayLibre
> Please add information on what's in this file to the preamble.
Does something like "DT-based virtual thermal sensor driver" would be 
enough,
or should I details a little bit more ?
>
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/export.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/slab.h>
>> +#include <linux/thermal.h>
>> +#include <linux/types.h>
>> +#include <linux/string.h>
>> +
>> +#include <dt-bindings/thermal/virtual-sensor.h>
>> +
>> +#include "virtual-thermal-sensor.h"
>> +
>> +struct thermal_sensor_data {
>> +       struct list_head node;
>> +
>> +       /* sensor interface */
>> +       int id;
>> +       void *sensor_data;
>> +       const struct thermal_zone_of_device_ops *ops;
>> +};
>> +
>> +struct virtual_thermal_sensor {
>> +       int count;
>> +       struct thermal_sensor_data *sensors;
>> +       struct thermal_zone_device *tzd;
>> +       int (*aggr_temp)(int temp1, int temp2);
>> +
>> +       struct list_head node;
>> +};
>> +
>> +static LIST_HEAD(thermal_sensors);
>> +static LIST_HEAD(virtual_sensors);
> These lists don't seem to be protected against concurrent access and
> they should be.
I Reworked the driver and I am going to remove them.
>
>> +
>> +static int max_temp(int temp1, int temp2)
>> +{
>> +       return max(temp1, temp2);
>> +}
>> +
>> +static int min_temp(int temp1, int temp2)
>> +{
>> +       return min(temp1, temp2);
>> +}
>> +
>> +static int avg_temp(int temp1, int temp2)
>> +{
>> +       return ((temp1) / 2) + ((temp2) / 2) + (((temp1) % 2 + (temp2) % 2) / 2);
> There are a few redundant parens here.
>
> And why not
>
> return (temp1 + temp2) / 2;
>
>> +}
>> +
>> +static int virtual_thermal_sensor_get_temp(void *data, int *temperature)
>> +{
>> +       struct virtual_thermal_sensor *sensor = data;
>> +       int max_temp = INT_MIN;
>> +       int temp;
>> +       int i;
>> +
> Some synchronization (eg. locking) should be added to this.  It is racy as is.
>
I am not sure to figure out what is racy here.
Anyway, I will update the logic of the driver and simplify this 
function, so this would
probably be fixed.
>> +       for (i = 0; i < sensor->count; i++) {
>> +               struct thermal_sensor_data *hw_sensor;
>> +
>> +               hw_sensor = &sensor->sensors[i];
>> +               if (!hw_sensor->ops)
>> +                       return -ENODEV;
>> +
>> +               hw_sensor->ops->get_temp(hw_sensor->sensor_data, &temp);
>> +               max_temp = sensor->aggr_temp(max_temp, temp);
>> +       }
>> +
>> +       *temperature = max_temp;
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct thermal_zone_of_device_ops virtual_thermal_sensor_ops = {
>> +       .get_temp = virtual_thermal_sensor_get_temp,
>> +};
>> +
>> +static int virtual_sensor_add_sensor(struct virtual_thermal_sensor *sensor,
>> +                                    struct of_phandle_args args,
>> +                                    int index)
>> +{
>> +       struct thermal_sensor_data *sensor_data;
>> +       int id;
>> +
>> +       list_for_each_entry(sensor_data, &thermal_sensors, node) {
>> +               id = args.args_count ? args.args[0] : 0;
>> +               if (sensor_data->id == id) {
>> +                       memcpy(&sensor->sensors[index], sensor_data,
>> +                               sizeof(*sensor_data));
> The data object being copied includes pointers, so I wouldn't copy
> them like this.  Especially the ops one annotated as const.
>
>> +                       return 0;
>> +               }
>> +       }
>> +
>> +       return -ENODEV;
>> +}
>> +
>> +static int virtual_thermal_sensor_probe(struct platform_device *pdev)
>> +{
>> +       struct virtual_thermal_sensor *sensor;
>> +       struct device *dev = &pdev->dev;
>> +       struct of_phandle_args args;
>> +       u32 type;
>> +       int ret;
>> +       int i;
>> +
>> +       sensor = devm_kzalloc(dev, sizeof(*sensor), GFP_KERNEL);
>> +       if (!sensor)
>> +               return -ENOMEM;
>> +
>> +       sensor->count = of_count_phandle_with_args(dev->of_node,
>> +                                                  "thermal-sensors",
>> +                                                  "#thermal-sensor-cells");
>> +       if (sensor->count <= 0)
>> +               return -EINVAL;
>> +
>> +       sensor->sensors = devm_kmalloc_array(dev, sensor->count,
>> +                                            sizeof(*sensor->sensors),
>> +                                            GFP_KERNEL);
>> +       if (!sensor->sensors)
>> +               return -ENOMEM;
>> +
>> +       for (i = 0; i < sensor->count; i++) {
>> +               ret = of_parse_phandle_with_args(dev->of_node,
>> +                                                "thermal-sensors",
>> +                                                "#thermal-sensor-cells",
>> +                                                i,
>> +                                                &args);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               ret = virtual_sensor_add_sensor(sensor, args, i);
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>> +       ret = of_property_read_u32(dev->of_node, "aggregation-function", &type);
>> +       if (ret)
>> +               return ret;
>> +
>> +       switch (type) {
>> +       case VIRTUAL_THERMAL_SENSOR_MAX:
>> +               sensor->aggr_temp = max_temp;
>> +               break;
>> +       case VIRTUAL_THERMAL_SENSOR_MIN:
>> +               sensor->aggr_temp = min_temp;
>> +               break;
>> +       case VIRTUAL_THERMAL_SENSOR_AVG:
>> +               sensor->aggr_temp = avg_temp;
>> +               break;
>> +       default:
>> +               return -EINVAL;
>> +       }
>> +
>> +       sensor->tzd = devm_thermal_zone_of_sensor_register(dev, 0, sensor,
>> +                                                          &virtual_thermal_sensor_ops);
>> +       if (IS_ERR(sensor->tzd))
>> +               return PTR_ERR(sensor->tzd);
>> +
>> +       platform_set_drvdata(pdev, sensor);
>> +       list_add(&sensor->node, &virtual_sensors);
>> +
>> +       return 0;
>> +}
>> +
>> +static int virtual_thermal_sensor_remove(struct platform_device *pdev)
>> +{
>> +       struct virtual_thermal_sensor *sensor;
>> +
>> +       sensor = platform_get_drvdata(pdev);
>> +       list_del(&sensor->node);
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct of_device_id virtual_thermal_sensor_of_match[] = {
>> +       {
>> +               .compatible = "virtual,thermal-sensor",
>> +       },
>> +       {
>> +       },
>> +};
>> +MODULE_DEVICE_TABLE(of, virtual_thermal_sensor_of_match);
>> +
>> +static struct platform_driver virtual_thermal_sensor = {
>> +       .probe = virtual_thermal_sensor_probe,
>> +       .remove = virtual_thermal_sensor_remove,
>> +       .driver = {
>> +               .name = "virtual-thermal-sensor",
>> +               .of_match_table = virtual_thermal_sensor_of_match,
>> +       },
>> +};
>> +
>> +/**
>> + * thermal_virtual_sensor_register - registers a sensor that could be a virtual
>> + * sensor
>> + * @dev: a valid struct device pointer of a sensor device. Must contain
>> + *       a valid .of_node, for the sensor node.
>> + * @sensor_id: a sensor identifier, in case the sensor IP has more
>> + *             than one sensor
>> + * @data: a private pointer (owned by the caller) that will be passed
>> + *        back, when a temperature reading is needed.
>> + * @ops: struct thermal_zone_of_device_ops *. Must contain at least .get_temp.
>> + *
>> + * This function will register a thermal sensor to make it available for later
>> + * usage by a virtual sensor.
> So who's expected to be calling it?
Any driver that would like to expose its sensors to the virtual thermal 
sensor driver,
which was a bad solution ...
In the next series, I will remove this function, as well the other 
register /  unregister
functions, and use directly thermal_zone_device to get the temperature 
from the sensors.

Probe will take care of finding the thermal_zone_device listed in the 
virtual sensor device
tree node, will defer if a thermal_zone_device is not yet ready and use 
try_module_get()
to prevent any thermal_zone_device used by the virtual sensor to be removed.

Best Regards,
Alexandre

>
>> + *
>> + * The thermal zone temperature is provided by the @get_temp function
>> + * pointer. When called, it will have the private pointer @data back.
> It is unclear what you mean here.  I think you are describing a return
> mechanism, but as is it is hard to follow.
>
>> + *
>> + * Return: On success returns a valid struct thermal_zone_device,
> That doesn't seem to be the case.  It returns an address returned by
> devm_kzalloc() and the memory at that address is expected to be a
> thermal_sensor_data object.
>
>> + * otherwise, it returns a corresponding ERR_PTR(). Caller must
>> + * check the return value with help of IS_ERR() helper.
>> + */
>> +struct thermal_sensor_data *thermal_virtual_sensor_register(
>> +       struct device *dev, int sensor_id, void *data,
>> +       const struct thermal_zone_of_device_ops *ops)
>> +{
>> +       struct thermal_sensor_data *sensor_data;
>> +
>> +       sensor_data = devm_kzalloc(dev, sizeof(*sensor_data), GFP_KERNEL);
>> +       if (!sensor_data)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       sensor_data->id = sensor_id;
>> +       sensor_data->sensor_data = data;
>> +       sensor_data->ops = ops;
>> +
>> +       list_add(&sensor_data->node, &thermal_sensors);
>> +
>> +       return sensor_data;
> Overall, this is non-modular code squeezed into a module.
>
> If this module goes away and whoever called it wants to unregister the
> sensor, they will crash, so to a minimum it should do a
> try_module_get() on the module containing it.
>
>> +}
>> +EXPORT_SYMBOL_GPL(thermal_virtual_sensor_register);
>> +
>> +/**
>> + * thermal_virtual_sensor_unregister - unregisters a sensor
>> + * @dev: a valid struct device pointer of a sensor device.
>> + * @sensor_data: a pointer to struct thermal_sensor_data to unregister.
>> + *
>> + * This function removes the sensor from the list of available thermal sensors.
>> + * If the sensor is in use, then the next call to .get_temp will return -ENODEV.
>> + */
>> +void thermal_virtual_sensor_unregister(struct device *dev,
>> +                                      struct thermal_sensor_data *sensor_data)
>> +{
>> +       struct thermal_sensor_data *sd;
>> +       struct virtual_thermal_sensor *sensor;
>> +       int i;
>> +
> All of the code in this function is obviously racy.
>
>> +       list_del(&sensor_data->node);
>> +
>> +       list_for_each_entry(sensor, &virtual_sensors, node) {
>> +               for (i = 0; i < sensor->count; i++) {
>> +                       sd = &sensor->sensors[i];
>> +                       if (sd->id == sensor_data->id &&
>> +                               sd->sensor_data == sensor_data->sensor_data) {
>> +                               sd->ops = NULL;
>> +                       }
> The inner braces are not necessary.
>
>> +               }
>> +       }
> And again, this code requires the module to be protected from
> unloading until the last instance of
> thermal_virtual_sensor_unregister() has returned.
>
>> +}
>> +EXPORT_SYMBOL_GPL(thermal_virtual_sensor_unregister);
>> +
>> +static void devm_thermal_virtual_sensor_release(struct device *dev, void *res)
>> +{
>> +       thermal_virtual_sensor_unregister(dev,
>> +                                         *(struct thermal_sensor_data **)res);
>> +}
>> +
>> +static int devm_thermal_virtual_sensor_match(struct device *dev, void *res,
>> +                                            void *data)
>> +{
>> +       struct thermal_sensor_data **r = res;
>> +
>> +       if (WARN_ON(!r || !*r))
>> +               return 0;
>> +
>> +       return *r == data;
>> +}
>> +
>> +/**
>> + * devm_thermal_virtual_sensor_register - Resource managed version of
>> + *                             thermal_virtual_sensor_register()
>> + * @dev: a valid struct device pointer of a sensor device. Must contain
>> + *       a valid .of_node, for the sensor node.
>> + * @sensor_id: a sensor identifier, in case the sensor IP has more
>> + *            than one sensor
>> + * @data: a private pointer (owned by the caller) that will be passed
>> + *       back, when a temperature reading is needed.
>> + * @ops: struct thermal_zone_of_device_ops *. Must contain at least .get_temp.
>> + *
>> + * Refer thermal_zone_of_sensor_register() for more details.
>> + *
>> + * Return: On success returns a valid struct virtual_sensor_data,
>> + * otherwise, it returns a corresponding ERR_PTR(). Caller must
>> + * check the return value with help of IS_ERR() helper.
>> + * Registered virtual_sensor_data device will automatically be
>> + * released when device is unbound.
>> + */
>> +struct thermal_sensor_data *devm_thermal_virtual_sensor_register(
>> +       struct device *dev, int sensor_id,
>> +       void *data, const struct thermal_zone_of_device_ops *ops)
>> +{
>> +       struct thermal_sensor_data **ptr, *sensor_data;
>> +
>> +       ptr = devres_alloc(devm_thermal_virtual_sensor_release, sizeof(*ptr),
>> +                          GFP_KERNEL);
>> +       if (!ptr)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       sensor_data = thermal_virtual_sensor_register(dev, sensor_id, data, ops);
>> +       if (IS_ERR(sensor_data)) {
>> +               devres_free(ptr);
>> +               return sensor_data;
>> +       }
>> +
>> +       *ptr = sensor_data;
>> +       devres_add(dev, ptr);
>> +
>> +       return sensor_data;
>> +}
>> +EXPORT_SYMBOL_GPL(devm_thermal_virtual_sensor_register);
>> +
>> +/**
>> + * devm_thermal_virtual_sensor_unregister - Resource managed version of
>> + *                             thermal_virtual_sensor_unregister().
>> + * @dev: Device for which resource was allocated.
>> + * @sensor: a pointer to struct thermal_zone_device where the sensor is registered.
>> + *
>> + * This function removes the sensor from the list of sensors registered with
>> + * devm_thermal_virtual_sensor_register() API.
>> + * Normally this function will not need to be called and the resource
>> + * management code will ensure that the resource is freed.
>> + */
>> +void devm_thermal_virtual_sensor_unregister(struct device *dev,
>> +                                           struct virtual_thermal_sensor *sensor)
>> +{
>> +       WARN_ON(devres_release(dev, devm_thermal_virtual_sensor_release,
>> +                              devm_thermal_virtual_sensor_match, sensor));
>> +}
>> +EXPORT_SYMBOL_GPL(devm_thermal_virtual_sensor_unregister);
>> +
>> +module_platform_driver(virtual_thermal_sensor);
>> +MODULE_AUTHOR("Alexandre Bailon <abailon@baylibre.com>");
>> +MODULE_DESCRIPTION("Virtual thermal sensor");
>> +MODULE_LICENSE("GPL v2");
>> --
