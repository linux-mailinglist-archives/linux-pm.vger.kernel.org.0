Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992883F4611
	for <lists+linux-pm@lfdr.de>; Mon, 23 Aug 2021 09:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbhHWHxu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Aug 2021 03:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235115AbhHWHxs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Aug 2021 03:53:48 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135FFC061575
        for <linux-pm@vger.kernel.org>; Mon, 23 Aug 2021 00:53:06 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id z4so9253531wrr.6
        for <linux-pm@vger.kernel.org>; Mon, 23 Aug 2021 00:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=V+vPGHI9SVeq2sopTpon+vV9taO7FHpPMPDfk1nYm0I=;
        b=jtpopl/cB84EcZ+xmqeCzJ0hOgYb3IzvrOHuzSw1kbR0nker/+mZpSJ1JRfnkucPUM
         MquYTkl/ZpuXUR/MtHOxru78Jt9yb2MjxCQZJaGWTcXL69cJXY/+22yMdd9vzJLFX2Kf
         PXpfw/LtifHIrhpDEtlvtOgj5RfTH+6N68Z02xX72A/WBjUt9vFTLad/XQcizO4qSs6u
         M9W29HW4vDnIlCp/Zwj/3X1wQ4pqdQdNRtkW+8pkbF1cmbo30rZYz7dT6jD40S6r3wRv
         w/NOpUSA9EW3oW8Deq00mkec7px+Xf61ohdewFC22vIfDaWoDq8j8mMmWagX7m0NFIBm
         Qj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=V+vPGHI9SVeq2sopTpon+vV9taO7FHpPMPDfk1nYm0I=;
        b=UNGVdo/C3+aDkAJ7nhWBqdpdW5TLN3CTFwcIov4mmChQ+IlH7Lk3lt2jO5Y7T/4mK9
         mal2wmo6+WKe1nFWjlenHoSsB4/t5ZaM9x192e3cvx4QLXEluV8Qh7eUK6X6TuVSZOB9
         kpGa/3NAO7qeVO5yZwGcjlSZ2hCCRYtrja23XX6D2p3+Ygf0g6sqptgvTkKmD8ICn7Wl
         +OxmvmSzeTyL2nimPPhbje5DbdJbShRdhDQw18xpPfQSymajZVUxCOdYnygnR3m2x7AM
         eEk+kPY1nao0tkrWyWeEX3ipmJOSldL2jRDTt/vrHDzaGxy7erY4RnDCAXD+Gi4BWopv
         nJ3w==
X-Gm-Message-State: AOAM530PM7B275KYDuQ1zoJdoFKJnhsz5sUxnewC+1o6ZqgTSC+0CnOD
        tYf9kaMwh4XMwnDbw+x9pfxF8w==
X-Google-Smtp-Source: ABdhPJxn/5TiT3qgdpAG5HUT4VqFPQ+8a4/AsF6ibz83mnrvB3n3x+oKbZvSx2/AYqBKZ0Pk53/G4g==
X-Received: by 2002:a5d:64ce:: with SMTP id f14mr11980656wri.17.1629705184690;
        Mon, 23 Aug 2021 00:53:04 -0700 (PDT)
Received: from alex-xps13.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q22sm17447869wmj.32.2021.08.23.00.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 00:53:04 -0700 (PDT)
Subject: Re: [RFC PATCH 2/2] thermal: add a virtual sensor to aggregate
 temperatures
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com
References: <20210819123215.591593-1-abailon@baylibre.com>
 <20210819123215.591593-3-abailon@baylibre.com>
 <068ad0f9-ca73-6f62-f04a-6916c055279a@linaro.org>
From:   Alexandre Bailon <abailon@baylibre.com>
Message-ID: <55b94272-7364-72cf-f95d-5de0b0f99495@baylibre.com>
Date:   Mon, 23 Aug 2021 09:54:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <068ad0f9-ca73-6f62-f04a-6916c055279a@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On 20/08/2021 14:52, Daniel wrote:
> On 19/08/2021 14:32, Alexandre Bailon wrote:
>> This adds a virtual thermal sensor that reads temperature from
>> hardware sensor and return an aggregated temperature.
>> Currently, this only return the max temperature.
>>
>> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
>> ---
>>   drivers/thermal/Kconfig              |   8 ++
>>   drivers/thermal/Makefile             |   1 +
>>   drivers/thermal/thermal_aggregator.c | 134 +++++++++++++++++++++++++++
>>   3 files changed, 143 insertions(+)
>>   create mode 100644 drivers/thermal/thermal_aggregator.c
>>
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index 7a4ba50ba97d0..f9c152cfb95bc 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -228,6 +228,14 @@ config THERMAL_MMIO
>>   	  register or shared memory, is a potential candidate to work with this
>>   	  driver.
>>   
>> +config THERMAL_AGGREGATOR
> We discussed the virtual sensor doing aggregation but may be we can give
> it another purpose in the future like returning a constant temp or
> low/high pass filter.
>
> It may make sense to use a more generic name like virtual sensor for
> example.
Indeed, this would make more sense.
>
>> +	tristate "Generic thermal aggregator driver"
>> +	depends on TERMAL_OF || COMPILE_TEST
> s/TERMAL_OF/THERMAL_OF/
>
>> +	help
>> +	  This option enables the generic thermal sensor aggregator.
>> +	  This driver creates a thermal sensor that reads the hardware sensors
>> +	  and aggregate the temperature.
>> +
>>   config HISI_THERMAL
>>   	tristate "Hisilicon thermal driver"
>>   	depends on ARCH_HISI || COMPILE_TEST
>> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
>> index 9729a2b089919..5b20ef15aebbe 100644
>> --- a/drivers/thermal/Makefile
>> +++ b/drivers/thermal/Makefile
>> @@ -60,3 +60,4 @@ obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
>>   obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
>>   obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
>>   obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
>> +obj-$(CONFIG_THERMAL_AGGREGATOR) += thermal_aggregator.o
>> diff --git a/drivers/thermal/thermal_aggregator.c b/drivers/thermal/thermal_aggregator.c
>> new file mode 100644
>> index 0000000000000..76f871dbfee9e
>> --- /dev/null
>> +++ b/drivers/thermal/thermal_aggregator.c
>> @@ -0,0 +1,134 @@
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
>> +const char *aggr_types[] = {
>> +	"min",
>> +	"max",
>> +	"avg",
>> +};
>> +
>> +struct thermal_aggr;
>> +
>> +typedef int (*aggregate_fn)(struct thermal_aggr *aggr);
>> +
>> +struct thermal_aggr_sensor {
>> +	struct thermal_sensor *sensor;
>> +
>> +	struct list_head node;
>> +};
>> +
>> +struct thermal_aggr {
>> +	struct list_head sensors;
>> +	aggregate_fn *aggregate;
>> +	//struct thermal_zone_device *tz;
>> +};
>> +
>> +static int thermal_aggr_read_temp(void *data, int *temperature)
>> +{
>> +	struct thermal_aggr *aggr = data;
>> +	struct thermal_aggr_sensor *sensor;
>> +	int max_temp = 0;
>> +	int temp;
>> +
> What happens if a hardware sensor module is unloaded ?
Hum, I don't know how to deal with it.
Maybe adding refcounting to sensors to prevent module unloading ?
>
>> +	list_for_each_entry(sensor, &aggr->sensors, node) {
>> +		if (!sensor->sensor) {
>> +			return -ENODEV;
>> +		}
>
>
>
>> +		sensor->sensor->ops->get_temp(sensor->sensor->sensor_data, &temp);
>> +		max_temp = max(max_temp, temp);
>> +	}
>> +
>> +	*temperature = max_temp;
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct thermal_zone_of_device_ops thermal_aggr_max_ops = {
>> +	.get_temp = thermal_aggr_read_temp,
> 	.get_temp = thermal_virtual_sensor_get_temp ?

Actually, I though I could create a thermol_zone_of_device_ops for each 
type of operation
(min, max, etc) we would support and would just to register the right 
ops at probe time.

>> +};
>> +
>> +static int thermal_aggr_probe(struct platform_device *pdev)
>> +{
>> +	struct thermal_aggr *aggr;
>> +	struct device *dev = &pdev->dev;
>> +	struct of_phandle_args args;
>> +	int count;
>> +	int ret;
>> +	int i;
>> +
>> +	count = of_count_phandle_with_args(dev->of_node,
>> +					   "thermal-sensors",
>> +					   "#thermal-sensor-cells");
>> +	if (count <= 0)
>> +		return -EINVAL;
>> +
>> +	aggr = kzalloc(sizeof(*aggr), GFP_KERNEL);
> 	devm_kzalloc
>
>> +	INIT_LIST_HEAD(&aggr->sensors);
>> +
>> +	for (i = 0; i < count; i++) {
>> +		struct thermal_sensor *sensor;
>> +		struct thermal_aggr_sensor *aggr_sensor;
>> +		int id;
>> +
>> +		ret = of_parse_phandle_with_args(dev->of_node,
>> +						 "thermal-sensors",
>> +						 "#thermal-sensor-cells",
>> +						 i,
>> +						 &args);
>> +		if (ret) {
>> +			return ret;
>> +		}
>> +
>> +		id = args.args_count ? args.args[0] : 0;
>> +		sensor = thermal_of_get_sensor(args.np, id);
>> +		if (sensor == NULL) {
>> +			return -EPROBE_DEFER;
>> +		}
>> +
>> +		aggr_sensor = kzalloc(sizeof(*aggr_sensor), GFP_KERNEL);
> 		devm_kzalloc
>
>> +		aggr_sensor->np = args.np;
> Why the 'np' and id are stored, they won't be needed anymore, no ?
Right. At some point, I had issues with the sensors that was not available.
I though it was an probe orderings issue and I tried to get the sensor 
later from the callback.
It was an issue with the sensor module itself, and not with the ordering 
but I forgot to remove
np and id that not useful anymore.
>
>> +		aggr_sensor->id = id;
>> +		aggr_sensor->sensor = sensor;
>> +		list_add(&aggr_sensor->node, &aggr->sensors);
>> +	}
>> +
>> +	/*tzdev = */devm_thermal_zone_of_sensor_register(dev, 0, aggr, &thermal_aggr_max_ops);
>> +
>> +	return 0;
>> +}
>> +
>> +static int thermal_aggr_remove(struct platform_device *pdev)
>> +{
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id thermal_aggr_of_match[] = {
>> +	{
>> +		.compatible = "generic,thermal-aggregator",  "^virtual,.*":
> As stated in the documentation
> Documentation/devicetree/bindings/vendor-prefixes.yaml
>
>    "^virtual,.*":
>      description: Used for virtual device without specific vendor.
>
> I suggest something like:
>
> 	.compatible = "virtual,thermal-sensor",
OK, makes sense to me.

Thanks you for the review.
Alexandre

>
>
>> +	},
>> +	{
>> +	},
>> +};
>> +MODULE_DEVICE_TABLE(of, thermal_aggr_of_match);
>> +
>> +static struct platform_driver thermal_aggr = {
>> +	.probe = thermal_aggr_probe,
>> +	.remove = thermal_aggr_remove,
>> +	.driver = {
>> +		.name = "thermal-aggregator",
>> +		.of_match_table = thermal_aggr_of_match,
>> +	},
>> +};
>> +
>> +module_platform_driver(thermal_aggr);
>> +MODULE_AUTHOR("Alexandre Bailon <abailon@baylibre.com>");
>> +MODULE_DESCRIPTION("Thermal sensor aggregator");
>> +MODULE_LICENSE("GPL v2");
>>
>
