Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D49A3F2C80
	for <lists+linux-pm@lfdr.de>; Fri, 20 Aug 2021 14:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240626AbhHTMxR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Aug 2021 08:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240614AbhHTMxO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Aug 2021 08:53:14 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7AAC061756
        for <linux-pm@vger.kernel.org>; Fri, 20 Aug 2021 05:52:36 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id h13so14181251wrp.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Aug 2021 05:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uDTdVQ6VcZqXNEvJcgw1HUA2KyfCBkRaPWncrxYNJWk=;
        b=eaqy9ksXHq1q+ufHfMy7Qz7AXCXvmsVesluSW3w0jpQYOQhekVNJ+E0Pj6/oxpOT0O
         TF+mRFG7M+BYd2TI3lnDniRRUSfJpkDFXou7iZytU2SRMtQvUuATihVA92x8Nngp7lNn
         /9Y3+c3mGSiJ5REDTQohfw145gDG131qbXqs23kUILV1uKkHBBzjaKawMiJSGydsw/cF
         8iOHq8CDfOvTX0AzW7OaFfg9tQwsYd83paPmEhGtz31h06j7jt7p4Y4XQbeYqaRNCaeA
         gJRMi8gCwFT1Et3aD+b1IIXE7DlSoKo/jvOdMJ6BTFSTFEI61i5ONZJH1jKVZy6xjisH
         KZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uDTdVQ6VcZqXNEvJcgw1HUA2KyfCBkRaPWncrxYNJWk=;
        b=kGDIN24qmuX9jNakV2vgtVXpm5FXj0U0bLhtWJ3hDE3Bbb+hKmGElEBS0zJa+A0NlI
         lf1oaqWzoqkZjhIaFRr7GPfAI+7K8lFJtrnYdiLM8waTVjO+fPuf/y8P/oIWMJ6Ia9w5
         5+oMHF2Kq8FN0IqV+PgfVo7DAIMUlhqDmanYyGLFphyIwk8jIVto3QIVsTZsGq1TIwMX
         wZMoRaYcZEw66FXQYW0WALSMshXmVPdNXbh73Ucvf5VsQqIBteHFbXyAeV014zyl/B6q
         jCW2kgV0CPeC+1GrEJua/V+dy6Xzl/KVckzIS1phsiANp8H/WXcoNM5KfmEUOSU6LW4G
         kDKw==
X-Gm-Message-State: AOAM533Hf/0dr+VKesxoPTFBV5SkSGikprKo+u1AxfADI73iiwipDfCI
        MIh6R65ZYpYGdBtIoIcHganqaA==
X-Google-Smtp-Source: ABdhPJyEMhIbVJ1kesB31+cLegNOQi/PQSCZwwVw08RHY1eqJxi2kXF8pHctFA3eKG6OzuND2D+ezg==
X-Received: by 2002:a5d:4c4e:: with SMTP id n14mr9750950wrt.226.1629463955154;
        Fri, 20 Aug 2021 05:52:35 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:c378:b01b:5d2d:5223? ([2a01:e34:ed2f:f020:c378:b01b:5d2d:5223])
        by smtp.googlemail.com with ESMTPSA id y14sm3820717wma.28.2021.08.20.05.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 05:52:34 -0700 (PDT)
Subject: Re: [RFC PATCH 2/2] thermal: add a virtual sensor to aggregate
 temperatures
To:     Alexandre Bailon <abailon@baylibre.com>, rui.zhang@intel.com,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com
References: <20210819123215.591593-1-abailon@baylibre.com>
 <20210819123215.591593-3-abailon@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <068ad0f9-ca73-6f62-f04a-6916c055279a@linaro.org>
Date:   Fri, 20 Aug 2021 14:52:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210819123215.591593-3-abailon@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19/08/2021 14:32, Alexandre Bailon wrote:
> This adds a virtual thermal sensor that reads temperature from
> hardware sensor and return an aggregated temperature.
> Currently, this only return the max temperature.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>  drivers/thermal/Kconfig              |   8 ++
>  drivers/thermal/Makefile             |   1 +
>  drivers/thermal/thermal_aggregator.c | 134 +++++++++++++++++++++++++++
>  3 files changed, 143 insertions(+)
>  create mode 100644 drivers/thermal/thermal_aggregator.c
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 7a4ba50ba97d0..f9c152cfb95bc 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -228,6 +228,14 @@ config THERMAL_MMIO
>  	  register or shared memory, is a potential candidate to work with this
>  	  driver.
>  
> +config THERMAL_AGGREGATOR

We discussed the virtual sensor doing aggregation but may be we can give
it another purpose in the future like returning a constant temp or
low/high pass filter.

It may make sense to use a more generic name like virtual sensor for
example.

> +	tristate "Generic thermal aggregator driver"
> +	depends on TERMAL_OF || COMPILE_TEST

s/TERMAL_OF/THERMAL_OF/

> +	help
> +	  This option enables the generic thermal sensor aggregator.
> +	  This driver creates a thermal sensor that reads the hardware sensors
> +	  and aggregate the temperature.
> +
>  config HISI_THERMAL
>  	tristate "Hisilicon thermal driver"
>  	depends on ARCH_HISI || COMPILE_TEST
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 9729a2b089919..5b20ef15aebbe 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -60,3 +60,4 @@ obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
>  obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
>  obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
>  obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
> +obj-$(CONFIG_THERMAL_AGGREGATOR) += thermal_aggregator.o
> diff --git a/drivers/thermal/thermal_aggregator.c b/drivers/thermal/thermal_aggregator.c
> new file mode 100644
> index 0000000000000..76f871dbfee9e
> --- /dev/null
> +++ b/drivers/thermal/thermal_aggregator.c
> @@ -0,0 +1,134 @@
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
> +const char *aggr_types[] = {
> +	"min",
> +	"max",
> +	"avg",
> +};
> +
> +struct thermal_aggr;
> +
> +typedef int (*aggregate_fn)(struct thermal_aggr *aggr);
> +
> +struct thermal_aggr_sensor {
> +	struct thermal_sensor *sensor;
> +
> +	struct list_head node;
> +};
> +
> +struct thermal_aggr {
> +	struct list_head sensors;
> +	aggregate_fn *aggregate;
> +	//struct thermal_zone_device *tz;
> +};
> +
> +static int thermal_aggr_read_temp(void *data, int *temperature)
> +{
> +	struct thermal_aggr *aggr = data;
> +	struct thermal_aggr_sensor *sensor;
> +	int max_temp = 0;
> +	int temp;
> +

What happens if a hardware sensor module is unloaded ?

> +	list_for_each_entry(sensor, &aggr->sensors, node) {
> +		if (!sensor->sensor) {
> +			return -ENODEV;
> +		}




> +		sensor->sensor->ops->get_temp(sensor->sensor->sensor_data, &temp);
> +		max_temp = max(max_temp, temp);
> +	}
> +
> +	*temperature = max_temp;
> +
> +	return 0;
> +}
> +
> +static const struct thermal_zone_of_device_ops thermal_aggr_max_ops = {
> +	.get_temp = thermal_aggr_read_temp,

	.get_temp = thermal_virtual_sensor_get_temp ?
> +};
> +
> +static int thermal_aggr_probe(struct platform_device *pdev)
> +{
> +	struct thermal_aggr *aggr;
> +	struct device *dev = &pdev->dev;
> +	struct of_phandle_args args;
> +	int count;
> +	int ret;
> +	int i;
> +
> +	count = of_count_phandle_with_args(dev->of_node,
> +					   "thermal-sensors",
> +					   "#thermal-sensor-cells");
> +	if (count <= 0)
> +		return -EINVAL;
> +
> +	aggr = kzalloc(sizeof(*aggr), GFP_KERNEL);

	devm_kzalloc

> +	INIT_LIST_HEAD(&aggr->sensors);
> +
> +	for (i = 0; i < count; i++) {
> +		struct thermal_sensor *sensor;
> +		struct thermal_aggr_sensor *aggr_sensor;
> +		int id;
> +
> +		ret = of_parse_phandle_with_args(dev->of_node,
> +						 "thermal-sensors",
> +						 "#thermal-sensor-cells",
> +						 i,
> +						 &args);
> +		if (ret) {
> +			return ret;
> +		}
> +
> +		id = args.args_count ? args.args[0] : 0;
> +		sensor = thermal_of_get_sensor(args.np, id);
> +		if (sensor == NULL) {
> +			return -EPROBE_DEFER;
> +		}
> +
> +		aggr_sensor = kzalloc(sizeof(*aggr_sensor), GFP_KERNEL);

		devm_kzalloc

> +		aggr_sensor->np = args.np;

Why the 'np' and id are stored, they won't be needed anymore, no ?

> +		aggr_sensor->id = id;
> +		aggr_sensor->sensor = sensor;
> +		list_add(&aggr_sensor->node, &aggr->sensors);
> +	}
> +
> +	/*tzdev = */devm_thermal_zone_of_sensor_register(dev, 0, aggr, &thermal_aggr_max_ops);
> +
> +	return 0;
> +}
> +
> +static int thermal_aggr_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +
> +static const struct of_device_id thermal_aggr_of_match[] = {
> +	{
> +		.compatible = "generic,thermal-aggregator",  "^virtual,.*":

As stated in the documentation
Documentation/devicetree/bindings/vendor-prefixes.yaml

  "^virtual,.*":
    description: Used for virtual device without specific vendor.

I suggest something like:

	.compatible = "virtual,thermal-sensor",


> +	},
> +	{
> +	},
> +};
> +MODULE_DEVICE_TABLE(of, thermal_aggr_of_match);
> +
> +static struct platform_driver thermal_aggr = {
> +	.probe = thermal_aggr_probe,
> +	.remove = thermal_aggr_remove,
> +	.driver = {
> +		.name = "thermal-aggregator",
> +		.of_match_table = thermal_aggr_of_match,
> +	},
> +};
> +
> +module_platform_driver(thermal_aggr);
> +MODULE_AUTHOR("Alexandre Bailon <abailon@baylibre.com>");
> +MODULE_DESCRIPTION("Thermal sensor aggregator");
> +MODULE_LICENSE("GPL v2");
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
