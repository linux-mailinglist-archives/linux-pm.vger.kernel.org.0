Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDC16202AB
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2019 11:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfEPJiS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 May 2019 05:38:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36698 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfEPJiS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 May 2019 05:38:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id s17so2609571wru.3
        for <linux-pm@vger.kernel.org>; Thu, 16 May 2019 02:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dXvL9U6vqGn+3dzqe2q3AnaDCZlkUax0fDWBtTifafo=;
        b=I/UDJahv2XoQTVlI/CBZzg4KvAhMldXn8LDjvfGiNkTKJbZ1TvfKXE3AEzLil71RJk
         r8LRO8eku+PRGnNuTA5mKDMQ61I5fApITxI9TF+yK3io1+bIZJ5ZRwcu/WUpdbLFnU7E
         5GVKXZnrVCdEXjTd5MiJ6XX2jXWuTrYAd9HNNCxYvVbSVk+OKHNvCJFtHZXHrSCXpRcJ
         98z/i3ht+/qRm+k//8SXDpLRkwzJebC1eVR//gULnCMcgMHjBhorb+NnLU6L5oVjXEuK
         oNX2dqh68Ygyq62nm3IFh3dPaXY0UcRAQp8KKat80D2BGtjs0/XsV7k6oAkGc4poSJLy
         yMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dXvL9U6vqGn+3dzqe2q3AnaDCZlkUax0fDWBtTifafo=;
        b=OZrYjhNIGsFE4gTd/UzMQdrS/Gkcg3sP6PvlG4KkMa5Q72UxJJ9YTDnAh/CatERwqj
         Emh8xHhmYSUrBmAH2rTvHu2YC8Fz5uD11XNF68obl0R2nY2rNrBQgWs0qfmO4O/OSHOM
         qfp/JnZ0Xd5LcIXVRGQvPtnYBJHFgW+rH7ZE1xDdgfmgSRbcYh/jEnPZzFMTzhkzhI/g
         4oVgnatM9SawvWjbl9kc04y2c/7+Q2TQJDM/vKCbmCtZj9J1jtaP0rzcrMezA4He3Xiq
         gHboYUeGQtUgBNHIQ+v+0XE5hAViGkr46F0njMlbSKA93cz8xAKqwMjdMJvWf/g4bn9z
         XBxA==
X-Gm-Message-State: APjAAAXHpCmERHO+v6PP0VZfRZ4SCSet4d2MeKsExo1FzfgD7XC92g7B
        i0m8QZ6CfrV6iDShXqwFhfl5Wg==
X-Google-Smtp-Source: APXvYqyxizdSyGYaMjH4i42OelzyoNbKdbfbgvIpvKDNvD6i2SbdFgd3o1rCzRT0UKNUAf0uvT1PKg==
X-Received: by 2002:adf:8189:: with SMTP id 9mr26439649wra.71.1557999495611;
        Thu, 16 May 2019 02:38:15 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id v12sm4464290wrw.23.2019.05.16.02.38.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 02:38:14 -0700 (PDT)
Subject: Re: [PATCH V12 3/5] thermal: imx_sc: add i.MX system controller
 thermal support
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "agross@kernel.org" <agross@kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1555384609-7030-1-git-send-email-Anson.Huang@nxp.com>
 <1555384609-7030-3-git-send-email-Anson.Huang@nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <235e91be-f9e9-1e97-b404-17009a64771f@linaro.org>
Date:   Thu, 16 May 2019 11:38:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555384609-7030-3-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/04/2019 05:22, Anson Huang wrote:
> i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller
> inside, the system controller is in charge of controlling power,
> clock and thermal sensors etc..
> 
> This patch adds i.MX system controller thermal driver support,
> Linux kernel has to communicate with system controller via MU
> (message unit) IPC to get each thermal sensor's temperature,
> it supports multiple sensors which are passed from device tree,
> please see the binding doc for details.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V11:
> 	- move the API of getting thermal zone sensor ID to of-thermal.c as generic API;
> 	- remove unnecessary __packed.

The patch itself sounds good to me but the getting thermal zone by
sensor id patch seems to be controversial. It would be nice to rise a
discussion with this new function you proposed in 2/5.

> ---
>  drivers/thermal/Kconfig          |  11 ++++
>  drivers/thermal/Makefile         |   1 +
>  drivers/thermal/imx_sc_thermal.c | 137 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 149 insertions(+)
>  create mode 100644 drivers/thermal/imx_sc_thermal.c
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 653aa27..4e4fa7e 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -223,6 +223,17 @@ config IMX_THERMAL
>  	  cpufreq is used as the cooling device to throttle CPUs when the
>  	  passive trip is crossed.
>  
> +config IMX_SC_THERMAL
> +	tristate "Temperature sensor driver for NXP i.MX SoCs with System Controller"
> +	depends on (ARCH_MXC && IMX_SCU) || COMPILE_TEST
> +	depends on OF
> +	help
> +	  Support for Temperature Monitor (TEMPMON) found on NXP i.MX SoCs with
> +	  system controller inside, Linux kernel has to communicate with system
> +	  controller via MU (message unit) IPC to get temperature from thermal
> +	  sensor. It supports one critical trip point and one
> +	  passive trip point for each thermal sensor.
> +
>  config MAX77620_THERMAL
>  	tristate "Temperature sensor driver for Maxim MAX77620 PMIC"
>  	depends on MFD_MAX77620
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 486d682..4062627 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_DB8500_THERMAL)	+= db8500_thermal.o
>  obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
>  obj-$(CONFIG_TANGO_THERMAL)	+= tango_thermal.o
>  obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
> +obj-$(CONFIG_IMX_SC_THERMAL)	+= imx_sc_thermal.o
>  obj-$(CONFIG_MAX77620_THERMAL)	+= max77620_thermal.o
>  obj-$(CONFIG_QORIQ_THERMAL)	+= qoriq_thermal.o
>  obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
> diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
> new file mode 100644
> index 0000000..dcf16fc
> --- /dev/null
> +++ b/drivers/thermal/imx_sc_thermal.c
> @@ -0,0 +1,137 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2018-2019 NXP.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/firmware/imx/sci.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/thermal.h>
> +
> +#include "thermal_core.h"
> +
> +#define IMX_SC_MISC_FUNC_GET_TEMP	13
> +#define IMX_SC_C_TEMP			0
> +
> +static struct imx_sc_ipc *thermal_ipc_handle;
> +
> +struct imx_sc_sensor {
> +	struct thermal_zone_device *tzd;
> +	u32 resource_id;
> +};
> +
> +struct req_get_temp {
> +	u16 resource_id;
> +	u8 type;
> +} __packed;
> +
> +struct resp_get_temp {
> +	u16 celsius;
> +	u8 tenths;
> +} __packed;
> +
> +struct imx_sc_msg_misc_get_temp {
> +	struct imx_sc_rpc_msg hdr;
> +	union {
> +		struct req_get_temp req;
> +		struct resp_get_temp resp;
> +	} data;
> +};
> +
> +static int imx_sc_thermal_get_temp(void *data, int *temp)
> +{
> +	struct imx_sc_msg_misc_get_temp msg;
> +	struct imx_sc_rpc_msg *hdr = &msg.hdr;
> +	struct imx_sc_sensor *sensor = data;
> +	int ret;
> +
> +	msg.data.req.resource_id = sensor->resource_id;
> +	msg.data.req.type = IMX_SC_C_TEMP;
> +
> +	hdr->ver = IMX_SC_RPC_VERSION;
> +	hdr->svc = IMX_SC_RPC_SVC_MISC;
> +	hdr->func = IMX_SC_MISC_FUNC_GET_TEMP;
> +	hdr->size = 2;
> +
> +	ret = imx_scu_call_rpc(thermal_ipc_handle, &msg, true);
> +	if (ret) {
> +		pr_err("read temp sensor %d failed, ret %d\n",
> +			sensor->resource_id, ret);
> +		return ret;
> +	}
> +
> +	*temp = msg.data.resp.celsius * 1000 + msg.data.resp.tenths * 100;
> +
> +	return 0;
> +}
> +
> +static const struct thermal_zone_of_device_ops imx_sc_thermal_ops = {
> +	.get_temp = imx_sc_thermal_get_temp,
> +};
> +
> +static int imx_sc_thermal_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np, *child;
> +	int ret;
> +
> +	ret = imx_scu_get_handle(&thermal_ipc_handle);
> +	if (ret)
> +		return ret;
> +
> +	np = of_find_node_by_name(NULL, "thermal-zones");
> +	if (!np)
> +		return -ENODEV;
> +
> +	for_each_available_child_of_node(np, child) {
> +		struct of_phandle_args sensor_specs;
> +		struct imx_sc_sensor *sensor =
> +			devm_kzalloc(&pdev->dev, sizeof(*sensor), GFP_KERNEL);
> +		if (!sensor)
> +			return -ENOMEM;
> +
> +		ret = thermal_zone_of_get_sensor_id(child,
> +						    &sensor_specs,
> +						    &sensor->resource_id);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev,
> +				"failed to get valid sensor resource id: %d\n",
> +				ret);
> +			break;
> +		}
> +
> +		sensor->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev,
> +								   sensor->resource_id,
> +								   sensor,
> +								   &imx_sc_thermal_ops);
> +		if (IS_ERR(sensor->tzd)) {
> +			dev_err(&pdev->dev, "failed to register thermal zone\n");
> +			ret = PTR_ERR(sensor->tzd);
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id imx_sc_thermal_table[] = {
> +	{ .compatible = "fsl,imx-sc-thermal", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, imx_sc_thermal_table);
> +
> +static struct platform_driver imx_sc_thermal_driver = {
> +		.probe = imx_sc_thermal_probe,
> +		.driver = {
> +			.name = "imx-sc-thermal",
> +			.of_match_table = imx_sc_thermal_table,
> +		},
> +};
> +module_platform_driver(imx_sc_thermal_driver);
> +
> +MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
> +MODULE_DESCRIPTION("Thermal driver for NXP i.MX SoCs with system controller");
> +MODULE_LICENSE("GPL v2");
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

