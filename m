Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8264DB616
	for <lists+linux-pm@lfdr.de>; Wed, 16 Mar 2022 17:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345585AbiCPQ0f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Mar 2022 12:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345290AbiCPQ0e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2022 12:26:34 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6E669CF7
        for <linux-pm@vger.kernel.org>; Wed, 16 Mar 2022 09:25:19 -0700 (PDT)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 308373F366
        for <linux-pm@vger.kernel.org>; Wed, 16 Mar 2022 16:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647447918;
        bh=DnCQ1QLFqi0VtLlcsdHh4Lvuz6d6d+u2naMI+BNHWF8=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=GFxYaG5A5BLCQg7c4QCYwW/243T2ys+18pfF9u9iUFqwi0vF5IdtGCZEsCkXdKo94
         IDTQ+yet1xYCDCuxLA/ucxRjDsrCg+/JSgSVUtfdlZzyyBweQi6ErZKSxWf0Gb2WRC
         qNZhiHqscepjvO8A9QGX+iv5oXE9ln2Imj2jpTnQMfwRkxClSeFNSSkPtbF3DBMeMS
         a7UeaPlOJC4RzU6a7rmc+4pFY/1dBsiRQcBeP6bhDaVAJy+VYrkSu3d7kCCOQ5gRpP
         Tkj4zDEkqNL9m3l440Qc7zPMWsDbsaZufjKDAtEGWlqqfmB99Y+s/O0tQ+UUpjC00Z
         1ogJubRZwk/yw==
Received: by mail-wm1-f70.google.com with SMTP id h127-20020a1c2185000000b0038c6f7e22a4so988880wmh.9
        for <linux-pm@vger.kernel.org>; Wed, 16 Mar 2022 09:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DnCQ1QLFqi0VtLlcsdHh4Lvuz6d6d+u2naMI+BNHWF8=;
        b=fPsiqWtGymI6e1Hap1kKpMh6u+1E4IVLykGsb7NrjgOIf+plL0egvUrB26/NYE31hj
         /M/Bh9LtH14jvyR6sW4FbN6BLNk8njLUApcuPyN6yW0RokCQXoRG4tc53E8oRuPDucZc
         GWn+x/qCGVzDfQwxk22P87+QZsJL760o09abru0AArvLFMYejwWy2C4gDYLZleHnF5TV
         KoYSdQr2szIgT1HDIHA5s+X1Bow+1UxB9ES/QKohbch8ncXVEXlqi3ER+25+CsA94/e/
         2WkHFE8B8wWwHjMsV8lKKF22ZnmDhSIRVBASLgmIR7T5E4GF5T4w0Qpls+TVhtbg/WNc
         yZYA==
X-Gm-Message-State: AOAM530e88TDlsaK9qaCgSiUgC38ynBDJRAk6X8xjNUfY5szhGh/45jX
        k59leL1MdXdQWCv/hN96jE0qxp7ZxUQ1zhhMgAVM1m1pB5/C92dw7abM0T3RlUNnQqSqzucTyKE
        twyDT243Y9LR0v/4KDWJ5keNkdzXhpzTEcOKH
X-Received: by 2002:a05:600c:3511:b0:38a:1ca:da21 with SMTP id h17-20020a05600c351100b0038a01cada21mr393750wmq.170.1647447917534;
        Wed, 16 Mar 2022 09:25:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypNzqP/EIb12WR9o80En1IWIF7M6gwFF0Da+1rVTpOA6wk563rkijXOvNp6OigMqx6oY2yBw==
X-Received: by 2002:a05:600c:3511:b0:38a:1ca:da21 with SMTP id h17-20020a05600c351100b0038a01cada21mr393739wmq.170.1647447917316;
        Wed, 16 Mar 2022 09:25:17 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id z5-20020a05600c0a0500b0037bb8df81a2sm6888239wmp.13.2022.03.16.09.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 09:25:16 -0700 (PDT)
Message-ID: <9b263f80-15df-efd3-2682-0adda06f5b5f@canonical.com>
Date:   Wed, 16 Mar 2022 17:25:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 1/2] thermal: Add thermal driver for Sunplus SP7021
Content-Language: en-US
To:     Li-hao Kuo <lhjeff911@gmail.com>, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com
References: <cover.1647399369.git.lhjeff911@gmail.com>
 <a658d7513a62e067086d8e2a73920bb892293569.1647399369.git.lhjeff911@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <a658d7513a62e067086d8e2a73920bb892293569.1647399369.git.lhjeff911@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/03/2022 04:01, Li-hao Kuo wrote:
> Add thermal driver for Sunplus SP7021.
> 
> Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
> ---
> Changes in v5:
>  - Modify yaml file remove reg name and change nvmem name
>  - Addressed comments from Mr. Daniel Lezcano
> 
>  MAINTAINERS                       |   6 ++
>  drivers/thermal/Kconfig           |  10 +++
>  drivers/thermal/Makefile          |   1 +
>  drivers/thermal/sunplus_thermal.c | 140 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 157 insertions(+)
>  create mode 100644 drivers/thermal/sunplus_thermal.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e127c2f..96d5218 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18542,6 +18542,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/rtc/sunplus,sp7021-rtc.yaml
>  F:	drivers/rtc/rtc-sunplus.c
>  
> +SUNPLUS THERMAL DRIVER
> +M:	Li-hao Kuo <lhjeff911@gmail.com>
> +L:	linux-pm@vger.kernel.org
> +S:	Maintained
> +F:	drivers/thermal/sunplus_thermal.c
> +
>  SUPERH
>  M:	Yoshinori Sato <ysato@users.sourceforge.jp>
>  M:	Rich Felker <dalias@libc.org>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index e37691e..98647c7 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -502,4 +502,14 @@ config KHADAS_MCU_FAN_THERMAL
>  	  If you say yes here you get support for the FAN controlled
>  	  by the Microcontroller found on the Khadas VIM boards.
>  
> +config SUNPLUS_THERMAL
> +	tristate "Sunplus thermal drivers"
> +	depends on SOC_SP7021

|| COMPILE_TEST
(and test if it compiles on other archs)

> +	help
> +	  This the Sunplus SP7021 thermal driver, which supports the primitive
> +	  temperature sensor embedded in Sunplus SP7021 SoC.
> +
> +	  If you have a Sunplus SP7021 platform say Y here and enable this option
> +	  to have support for thermal management
> +
>  endif
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index f0c36a1..2f7417a 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -61,3 +61,4 @@ obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
>  obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
>  obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
>  obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
> +obj-$(CONFIG_SUNPLUS_THERMAL)	+= sunplus_thermal.o
> \ No newline at end of file

Patch error here.

> diff --git a/drivers/thermal/sunplus_thermal.c b/drivers/thermal/sunplus_thermal.c
> new file mode 100644
> index 0000000..e2e955e
> --- /dev/null
> +++ b/drivers/thermal/sunplus_thermal.c
> @@ -0,0 +1,140 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Sunplus Inc.
> + * Author: Li-hao Kuo <lhjeff911@gmail.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +#include <linux/thermal.h>
> +
> +#define DISABLE_THERMAL		(BIT(31) | BIT(15))
> +#define ENABLE_THERMAL		BIT(31)
> +#define SP_THERMAL_MASK		GENMASK(10, 0)
> +#define SP_TCODE_HIGH_MASK	GENMASK(10, 8)
> +#define SP_TCODE_LOW_MASK	GENMASK(7, 0)
> +
> +#define TEMP_RATE		608
> +#define TEMP_BASE		3500
> +#define TEMP_OTP_BASE		1518
> +
> +#define SP_THERMAL_CTL0_REG	0x0000
> +#define SP_THERMAL_STS0_REG	0x0030
> +
> +/* common data structures */
> +struct sp_thermal_data {
> +	struct thermal_zone_device *pcb_tz;
> +	struct platform_device *pdev;
> +	enum thermal_device_mode mode;
> +	void __iomem *regs;
> +	int otp_temp0;
> +	u32 id;
> +};
> +
> +static char sp7021_get_otp_temp_coef(struct sp_thermal_data *sp_data, struct device *dev)

Why does it return char?

> +{
> +	struct nvmem_cell *cell;
> +	ssize_t otp_l;
> +	char *otp_v;
> +
> +	cell = nvmem_cell_get(dev, "calib");
> +	if (IS_ERR(cell))
> +		return ERR_CAST(cell);
> +
> +	otp_v = nvmem_cell_read(cell, &otp_l);
> +	nvmem_cell_put(cell);
> +
> +	if (otp_l < 3)
> +		return -EINVAL;
> +	sp_data->otp_temp0 = FIELD_PREP(SP_TCODE_LOW_MASK, otp_v[0]) |
> +			     FIELD_PREP(SP_TCODE_HIGH_MASK, otp_v[1]);
> +	if (sp_data->otp_temp0 == 0)
> +		sp_data->otp_temp0 = TEMP_OTP_BASE;
> +	return 0;
> +}
> +
> +static int sp_thermal_get_sensor_temp(void *data, int *temp)
> +{
> +	struct sp_thermal_data *sp_data = data;
> +	int t_code;
> +
> +	t_code = readl(sp_data->regs + SP_THERMAL_STS0_REG);
> +	t_code = FIELD_GET(SP_THERMAL_MASK, t_code);
> +	*temp = ((sp_data->otp_temp0 - t_code) * 10000 / TEMP_RATE) + TEMP_BASE;
> +	*temp *= 10;
> +	return 0;
> +}
> +
> +static struct thermal_zone_of_device_ops sp_of_thermal_ops = {

This should be const.

> +	.get_temp = sp_thermal_get_sensor_temp,
> +};
> +
> +static int sp_thermal_register_sensor(struct platform_device *pdev,
> +				      struct sp_thermal_data *data, int index)
> +{
> +	data->id = index;
> +	data->pcb_tz = devm_thermal_zone_of_sensor_register(&pdev->dev,
> +							    data->id,
> +							    data, &sp_of_thermal_ops);
> +	if (IS_ERR_OR_NULL(data->pcb_tz))
> +		return PTR_ERR(data->pcb_tz);
> +	return 0;
> +}
> +
> +static int sp7021_thermal_probe(struct platform_device *pdev)
> +{
> +	struct sp_thermal_data *sp_data;
> +	struct resource *res;
> +	int ret;
> +
> +	sp_data = devm_kzalloc(&pdev->dev, sizeof(*sp_data), GFP_KERNEL);
> +	if (!sp_data)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (IS_ERR(res))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(res), "resource get fail\n");
> +
> +	sp_data->regs = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> +	if (IS_ERR(sp_data->regs))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(sp_data->regs), "mas_base get fail\n");

Use devm_platform_ioremap_resource() instead.

> +
> +	writel(ENABLE_THERMAL, sp_data->regs + SP_THERMAL_CTL0_REG);
> +
> +	platform_set_drvdata(pdev, sp_data);
> +	ret = sp7021_get_otp_temp_coef(sp_data, &pdev->dev);

Ignored return code.

> +	ret = sp_thermal_register_sensor(pdev, sp_data, 0);
> +
> +	return ret;
> +}
> +
> +static int sp7021_thermal_remove(struct platform_device *pdev)
> +{
> +	return 0;

No need for empty code.

> +}
> +
> +static const struct of_device_id of_sp7021_thermal_ids[] = {
> +	{ .compatible = "sunplus,sp7021-thermal" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, of_sp7021_thermal_ids);
> +
> +static struct platform_driver sp7021_thermal_driver = {
> +	.probe	= sp7021_thermal_probe,
> +	.remove	= sp7021_thermal_remove,
> +	.driver	= {
> +		.name	= "sp7021-thermal",
> +		.of_match_table = of_match_ptr(of_sp7021_thermal_ids),

of_match_ptr looks incorrect - of_device_id is always present. If you
want to handle such case - build !OF - then you need maybe_unused to
of_device_id.

Best regards,
Best regards,
Krzysztof
