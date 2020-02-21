Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 388CE167DC1
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 13:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgBUMxI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 07:53:08 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38442 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbgBUMxH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 07:53:07 -0500
Received: by mail-wr1-f67.google.com with SMTP id e8so1936041wrm.5
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2020 04:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1Ecw0TwcU7uRxX0RbgoPbcukxSNyerj4Gg5H+/7jGU4=;
        b=Is97m+zF/OlL47unjgTyrlN2h5LOz7b+bCuBXaZ7I4NfCKXkYB+eEn9tr8HWToU5hS
         LcgaMH98pZ8E1XJVjarNN4j5rDbOg0TvWZqonAeorXDYmylpc5/p3a6zdZo0+OViPxVf
         vjaBs1HwK+d066WsYLlvTd/cfgCUGAocMJZCBxAbIYOmchE4hYYwfT2fgcgtO/lDa6n+
         s46hilc6kKO54iNjcQIKiz/zMeNqSx8RMh2L/6aFfRv62MCyYyw9TIi26wXy7zkiHsnO
         0qJx6mpEC9etxLhetlmYRb+0QZ7ItHTVG67ZgyBXOa2HCHtlIL/DA/fAs1ZuOWKYzTqv
         60OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1Ecw0TwcU7uRxX0RbgoPbcukxSNyerj4Gg5H+/7jGU4=;
        b=mquCyySOwaTSUIhIuJijMUTGYsFZmZ392rkkB3oQIeEFrb8sJ9qp+fg2LIHNsUMEpc
         MRcRMtEwDsgsoE4VmqvGFyWPrzeypkKt47S5gDfhfCr8L0RALYT1w0+mO27+IM+/b31F
         DQkFCTytZBaFxYZopSlUun0vjpIj0GQqt/r9adgGikcZNO2KBiL/UfEdNI+LrUnX3wOh
         L0s/iFXbbkIm2FG7VvKRxNVrVlN4LWV6rK7zih1xKAPFtn76uQXYwyffL3cLt3zn0onl
         jsuTzNj5imaz3x09uvuvSinQ5HShD0/uIpA3jkqdqb65tdPvgHxS0gEi/+Dh4TnxUpJU
         L4Yw==
X-Gm-Message-State: APjAAAXIAMKIcAY0lBbbEaj2GGDUb3o1130l2kPaXcMl5dy6xTDgijUs
        GjFJNaVgeBFAZ6blhWLnrnz/7w==
X-Google-Smtp-Source: APXvYqxlFnvz5Oqlv3ZiF1S9hXG57kU+AY4Dg2xiBGuM31y83G3pczXUHHnhoRpdAgUpGaKfUCxWBQ==
X-Received: by 2002:a05:6000:124b:: with SMTP id j11mr45114087wrx.285.1582289584497;
        Fri, 21 Feb 2020 04:53:04 -0800 (PST)
Received: from linaro.org ([2a01:e34:ed2f:f020:2dfb:b5ce:9043:4adb])
        by smtp.gmail.com with ESMTPSA id k10sm3781715wrd.68.2020.02.21.04.53.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 04:53:03 -0800 (PST)
Date:   Fri, 21 Feb 2020 13:53:00 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, aisheng.dong@nxp.com,
        linux@roeck-us.net, srinivas.kandagatla@linaro.org,
        krzk@kernel.org, fugang.duan@nxp.com, peng.fan@nxp.com,
        daniel.baluta@nxp.com, bjorn.andersson@linaro.org, olof@lixom.net,
        dinguyen@kernel.org, leonard.crestez@nxp.com,
        marcin.juszkiewicz@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V15 RESEND 3/5] thermal: imx_sc: add i.MX system
 controller thermal support
Message-ID: <20200221125300.GB10516@linaro.org>
References: <1582161028-2844-1-git-send-email-Anson.Huang@nxp.com>
 <1582161028-2844-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1582161028-2844-3-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Anson,

sorry for the delay with this review, hopefully the upstreaming will be now a
bit more smooth.

Apart the comments below, the driver looks good to me.

On Thu, Feb 20, 2020 at 09:10:26AM +0800, Anson Huang wrote:
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
> No change.
> ---
>  drivers/thermal/Kconfig          |  11 +++
>  drivers/thermal/Makefile         |   1 +
>  drivers/thermal/imx_sc_thermal.c | 142 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 154 insertions(+)
>  create mode 100644 drivers/thermal/imx_sc_thermal.c
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 5a05db5..d1cb8dc 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -251,6 +251,17 @@ config IMX_THERMAL
>  	  cpufreq is used as the cooling device to throttle CPUs when the
>  	  passive trip is crossed.
>  
> +config IMX_SC_THERMAL
> +	tristate "Temperature sensor driver for NXP i.MX SoCs with System Controller"
> +	depends on ARCH_MXC && IMX_SCU

IMX_SCU depends on IMX_MBOX which depends on ARCH_MXC. This dependency could be
simplified.

Also add the COMPILE_TEST option to improve compilation test coverage.

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
> index 9fb88e2..a11a6d8 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -43,6 +43,7 @@ obj-$(CONFIG_DB8500_THERMAL)	+= db8500_thermal.o
>  obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
>  obj-$(CONFIG_TANGO_THERMAL)	+= tango_thermal.o
>  obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
> +obj-$(CONFIG_IMX_SC_THERMAL)	+= imx_sc_thermal.o
>  obj-$(CONFIG_MAX77620_THERMAL)	+= max77620_thermal.o
>  obj-$(CONFIG_QORIQ_THERMAL)	+= qoriq_thermal.o
>  obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
> diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
> new file mode 100644
> index 0000000..d406ecb
> --- /dev/null
> +++ b/drivers/thermal/imx_sc_thermal.c
> @@ -0,0 +1,142 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2018-2019 NXP.

*sigh* 2020 now ...

[ ... ]

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

Can you explain this 'size' value?

[ ... ]

> +MODULE_DEVICE_TABLE(of, imx_sc_thermal_table);
> +
> +static struct platform_driver imx_sc_thermal_driver = {
> +		.probe = imx_sc_thermal_probe,

The driver can be compiled as module but there is no 'remove' callback

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



-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
