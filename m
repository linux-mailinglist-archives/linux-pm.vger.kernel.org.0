Return-Path: <linux-pm+bounces-21788-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EF3A305B9
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 09:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674193A16EB
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 08:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3261EEA4B;
	Tue, 11 Feb 2025 08:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A/2tLAUw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E74D1EE039
	for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 08:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739262443; cv=none; b=qS7rddP78eWVYl+V/nYL8p3yRP8Gfy34E3QX4RUV1M5N3MuihKJGP38c9/iNVVPsEcWXwh+SUL9VyqBR+rXW1MGl0B+MGoTp2/nMPSD/QGSjo/SgpLicMMGJZscBV8f34iYK5pXYyvOfxPlpPYg9CePhpKPuzIPEQQKG17M4E24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739262443; c=relaxed/simple;
	bh=7PEr5vXNnHG/al4C9FudH3cz0W0EHziN3Q/37zXewFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mIN0drMOIDdYwOt8M9JlAidI/U3ReJ0Bin92uOO69ByZQJgoOYB6Zoj8dt7xeVFcbj8XwgaTtwY+R5P+XhsBm772/V4EDJGW4t/7E1I5E9rC8k5YcJoSx58/9oRBKCy3RYVhYsq4uVPesKkjQSL0jAnBqhcvfcLt1Og3TuTbWbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A/2tLAUw; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361b0ec57aso52569875e9.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 00:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739262440; x=1739867240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iGPScCwF0Nc0sPkczZKY4s+fhukvxGIGwHM1Uyf0Phc=;
        b=A/2tLAUwcTRQ6BzSGQ2bSWDIV4cnU7Bzwn2L+ZhR6GcTGTNrX+AWFYZF6p6hfxYwqp
         nEh9e96o/XwJK+Z7WhVnkq/Gz/4lybPuwLLY6/lZYtQSwvGwYpFU4pPzMehf/RN+WUdH
         oRnBaxXGBvHYneMRyCJ7utV1YMsuj8ro62w4POrbqY7fAnvnx74dWIeOP6nGXmoxWecs
         Lf+XKZeJ+8fiYGzh/tZSmtnjNiXkpJW/sbzTYVUBuUoYQmZQux57roXcodWYbJMZ9lUN
         Uxi8gfEjitGqTPCejpymsTgExAQp5FXiVV13sxdJZm9xU0IMiyvp/rmVvzsUYsvqyzZI
         bZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739262440; x=1739867240;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iGPScCwF0Nc0sPkczZKY4s+fhukvxGIGwHM1Uyf0Phc=;
        b=TTk3S6gRlDLU/xVCGfWKD2dzulIkRi84qU/bIomXZDUAWr7FmTf6yhvC4JkNdUZRFy
         n/z0RG2Dee/08U3PucBnI3v3o9O20l9T3HPhNzuB+0M7otLYBSCkIIVuicxU9C1b/cU+
         F5UIdowGQOSAxrt40iI3PBqtDCVRUzHbWre9jgIiuIQmJqp4bxhuI/CVgtoXynTDn0XO
         acAZxk8PedMZO6dQmfCs7FHg/TI8lS0kCvbuTAd/ESjmsyUFqs1iL5FNafSA8i3iVuqp
         BhRFsuK64rGXlRtJDGjtMuRYfTy93mm7WSBto/X8FrHdDBXJy08olY6kDfj3Yj2xWPJ4
         eV2A==
X-Forwarded-Encrypted: i=1; AJvYcCU4+V7WRTX9pWSdSIHRYHXYeCbcuYiXPVPVCirfyTUbFBlqId2nAQwGR42XLB4vYykXgVGCqjKSYw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYsBzObksgpu+0ji4/8Mma66F0eGQwC883wO4NABMRogQRIIl4
	EB1oht0k6xhlbDLlzI3E66MyZ8PWDXTGirD2iVXjs7oeydNXDIOtpC0eesPK6rU=
X-Gm-Gg: ASbGncsU8jKa3fyyQwsurnxeh2Qe6qzs17rREIdh24mrjzhAKPecX7FlQbYAIb3jAaZ
	/1sAPEmX2PhDuGsYkRwxP7xeq1L2r/PRDLzI3jkeQxHHViRBhuB9jDWu7Nf2xKm/GPcjGP9Whhz
	UF3RzJNjDpfgtkAFZZa/4AwU2g2zx3WutfJwqLu8xMybLkxxOUHeX3guJrHBUYayYTSW0gQYffq
	Bjyel9zDfwwkjYVA0uuSpHo2a1BnVqnqQ6dbqwQDaXOhXiHq1Yz+UobGtdEEI/m49Y6fwom8Mpg
	YMZp923g4X4/lKqp2/tygJT9titS+cuLtb0nmcCMbaDIMBEG1jBX92s=
X-Google-Smtp-Source: AGHT+IGj+eItcjxqnhE5t4siEYVroq9Zz3bsD8xAJcQlnUW0m3PyDJePHNydvvCbsZR52PqdYT6haQ==
X-Received: by 2002:a05:600c:1d91:b0:439:4dcc:f6ac with SMTP id 5b1f17b1804b1-4394dccf8ffmr11222595e9.1.1739262439718;
        Tue, 11 Feb 2025 00:27:19 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4392fc0856csm102468065e9.34.2025.02.11.00.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 00:27:18 -0800 (PST)
Message-ID: <88d17e4c-7dda-4e87-bb6e-58116d1b2f9f@linaro.org>
Date: Tue, 11 Feb 2025 09:27:17 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] thermal: imx91: Add support for i.MX91 thermal
 monitoring unit
To: Frank Li <Frank.li@nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Pengfei Li <pengfei.li_1@nxp.com>,
 Marco Felsch <m.felsch@pengutronix.de>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Peng Fan <peng.fan@nxp.com>
References: <20241216-imx91tmu-v4-0-75caef7481b8@nxp.com>
 <20241216-imx91tmu-v4-2-75caef7481b8@nxp.com>
 <b69fe059-5aff-4fbd-879e-166d67310563@linaro.org>
 <Z51NOg24I/zsHz9Z@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <Z51NOg24I/zsHz9Z@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 31/01/2025 23:22, Frank Li wrote:
> On Fri, Jan 31, 2025 at 11:19:54AM +0100, Daniel Lezcano wrote:
>> On 16/12/2024 20:25, Frank Li wrote:
>>> From: Pengfei Li <pengfei.li_1@nxp.com>
>>>
>>> Introduce support for the i.MX91 thermal monitoring unit, which features a
>>> single sensor for the CPU. The register layout differs from other chips,
>>> necessitating the creation of a dedicated file for this.
>>
>> Please a bit more information about the sensor (eg. resolution, I guess 1°C)
> 
> How about add
> 
> "This sensor provides a resolution of 1/64°C (6-bit fraction). For actual
> accuracy, refer to the datasheet, as it varies depending on the chip grade."

A bit of more information is welcome :) eg is it interrupt driven ?

Also Link: <link to the datasheet>

>>> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>>> ---
>>> Change from v3 to v4
>>> - Add Macro's review tag
>>> - Use devm_add_action()
>>> - Move pm_runtim_put before thermal_of_zone_register()
>>>
>>> change from v2 to v3
>>> - add IMX91_TMU_ prefix for register define
>>> - remove unused register define
>>> - fix missed pm_runtime_put() at error path in imx91_tmu_get_temp()
>>> - use dev variable in probe function
>>> - use pm_runtime_set_active() in probe
>>> - move START to imx91_tmu_get_temp()
>>> - use DEFINE_RUNTIME_DEV_PM_OPS()
>>> - keep set reset value because there are not sw "reset" bit in controller,
>>> uboot may change and enable tmu.
>>>
>>> change from v1 to v2
>>> - use low case for hexvalue
>>> - combine struct imx91_tmu and tmu_sensor
>>> - simplify imx91_tmu_start() and imx91_tmu_enable()
>>> - use s16 for imx91_tmu_get_temp(), which may negative value
>>> - use reverse christmas tree style
>>> - use run time pm
>>> - use oneshot to sample temp
>>> - register thermal zone after hardware init
>>> ---
>>>    drivers/thermal/Kconfig         |  10 ++
>>>    drivers/thermal/Makefile        |   1 +
>>>    drivers/thermal/imx91_thermal.c | 263 ++++++++++++++++++++++++++++++++++++++++
>>>    3 files changed, 274 insertions(+)
>>>
>>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>>> index d3f9686e26e71..da403ed86aeb1 100644
>>> --- a/drivers/thermal/Kconfig
>>> +++ b/drivers/thermal/Kconfig
>>> @@ -296,6 +296,16 @@ config IMX8MM_THERMAL
>>>    	  cpufreq is used as the cooling device to throttle CPUs when the passive
>>>    	  trip is crossed.
>>> +config IMX91_THERMAL
>>> +	tristate "Temperature sensor driver for NXP i.MX91 SoC"
>>> +	depends on ARCH_MXC || COMPILE_TEST
>>> +	depends on OF
>>
>> s/OF/THERMAL_OF/
>>
>>> +	help
>>> +	  Support for Temperature sensor found on NXP i.MX91 SoC.
>>> +	  It supports one critical trip point and one passive trip point. The
>>> +	  cpufreq is used as the cooling device to throttle CPUs when the passive
>>> +	  trip is crossed.
>>
>> This help message is inaccurate. It should describe the sensor not the
>> thermal configuration which is coming from the device tree for a specific
>> platform.
> 
> How about
> 
> It includes one sensor and six comparators. Each of them compares the
> temperature value (from the sensor) against the programmable threshold
> values. Support program the direction of comparison (greater than or
> less than).

Sounds good except the last sentence, I suggest " ... values. The 
direction of the comparison is configurable (greater / lesser than).

>>>    config K3_THERMAL
>>>    	tristate "Texas Instruments K3 thermal support"
>>>    	depends on ARCH_K3 || COMPILE_TEST
>>> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
>>> index 9abf43a74f2bb..08da241e6a598 100644
>>> --- a/drivers/thermal/Makefile
>>> +++ b/drivers/thermal/Makefile
>>> @@ -50,6 +50,7 @@ obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
>>>    obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
>>>    obj-$(CONFIG_IMX_SC_THERMAL)	+= imx_sc_thermal.o
>>>    obj-$(CONFIG_IMX8MM_THERMAL)	+= imx8mm_thermal.o
>>> +obj-$(CONFIG_IMX91_THERMAL)	+= imx91_thermal.o
>>>    obj-$(CONFIG_MAX77620_THERMAL)	+= max77620_thermal.o
>>>    obj-$(CONFIG_QORIQ_THERMAL)	+= qoriq_thermal.o
>>>    obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
>>> diff --git a/drivers/thermal/imx91_thermal.c b/drivers/thermal/imx91_thermal.c
>>> new file mode 100644
>>> index 0000000000000..ef5e8e181dd0f
>>> --- /dev/null
>>> +++ b/drivers/thermal/imx91_thermal.c
>>> @@ -0,0 +1,263 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright 2024 NXP.
>>> + */
>>> +
>>> +#include <linux/bitfield.h>
>>> +#include <linux/clk.h>
>>> +#include <linux/err.h>
>>> +#include <linux/iopoll.h>
>>> +#include <linux/nvmem-consumer.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/pm_runtime.h>
>>> +#include <linux/thermal.h>
>>> +
>>> +#define IMX91_TMU_STAT0				0x10
>>> +#define IMX91_TMU_STAT0_DRDY0_IF_MASK		BIT(16)
>>> +
>>> +#define IMX91_TMU_DATA0				0x20
>>> +
>>> +#define IMX91_TMU_CTRL1_SET			0x204
>>> +#define IMX91_TMU_CTRL1_CLR			0x208
>>> +#define IMX91_TMU_CTRL1_EN			BIT(31)
>>> +#define IMX91_TMU_CTRL1_START			BIT(30)
>>> +#define IMX91_TMU_CTRL1_STOP			BIT(29)
>>> +#define IMX91_TMU_CTRL1_RES_MASK		GENMASK(19, 18)
>>> +#define IMX91_TMU_CTRL1_MEAS_MODE_MASK		GENMASK(25, 24)
>>> +#define   IMX91_TMU_CTRL1_MEAS_MODE_SINGLE	0
>>> +#define   IMX91_TMU_CTRL1_MEAS_MODE_CONTINUES	1
>>> +#define   IMX91_TMU_CTRL1_MEAS_MODE_PERIODIC	2
>>> +
>>> +#define IMX91_TMU_REF_DIV			0x280
>>> +#define IMX91_TMU_DIV_EN			BIT(31)
>>> +#define IMX91_TMU_DIV_MASK			GENMASK(23, 16)
>>> +#define IMX91_TMU_DIV_MAX			255
>>> +
>>> +#define IMX91_TMU_PUD_ST_CTRL			0x2b0
>>> +#define IMX91_TMU_PUDL_MASK			GENMASK(23, 16)
>>> +
>>> +#define IMX91_TMU_TRIM1				0x2e0
>>> +#define IMX91_TMU_TRIM2				0x2f0
>>> +
>>> +#define IMX91_TMU_TEMP_LOW_LIMIT		-40000
>>> +#define IMX91_TMU_TEMP_HIGH_LIMIT		125000
>>> +
>>> +#define IMX91_TMU_DEFAULT_TRIM1_CONFIG		0xb561bc2d
>>> +#define IMX91_TMU_DEFAULT_TRIM2_CONFIG		0x65d4
>>> +
>>> +struct imx91_tmu {
>>> +	void __iomem *base;
>>> +	struct clk *clk;
>>> +	struct device *dev;
>>> +	struct thermal_zone_device *tzd;
>>
>> This field is pointless because used only in the probe function.
>>
>>> +};
>>> +
>>> +static void imx91_tmu_start(struct imx91_tmu *tmu, bool start)
>>> +{
>>> +	u32 val = start ? IMX91_TMU_CTRL1_START : IMX91_TMU_CTRL1_STOP;
>>> +
>>> +	writel_relaxed(val, tmu->base + IMX91_TMU_CTRL1_SET);
>>> +}
>>> +
>>> +static void imx91_tmu_enable(struct imx91_tmu *tmu, bool enable)
>>> +{
>>> +	u32 reg = enable ? IMX91_TMU_CTRL1_SET : IMX91_TMU_CTRL1_CLR;
>>> +
>>> +	writel_relaxed(IMX91_TMU_CTRL1_EN, tmu->base + reg);
>>> +}
>>> +
>>> +static int imx91_tmu_get_temp(struct thermal_zone_device *tz, int *temp)
>>> +{
>>> +	struct imx91_tmu *tmu = thermal_zone_device_priv(tz);
>>> +	s16 data;
>>> +	int ret;
>>> +	u32 val;
>>> +
>>> +	ret = pm_runtime_resume_and_get(tmu->dev);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	imx91_tmu_start(tmu, true);
>>
>> Same question as [1]
>>
>> Do you really want to start and stop the sensor between two reads ?
> 
> This version use simple oneshot mode. So need call start every time.

The question remains the same. Why is one shot / single preferred than 
'continuous' ?

Stopping the measurement between two reads can have an impact on the 
accuracy and it adds an overhead when doing a poll read which is not 
desirable when reaching the thermal pressure where the mitigation kicks in.


>>> +	ret = readl_relaxed_poll_timeout(tmu->base + IMX91_TMU_STAT0, val,
>>> +					 val & IMX91_TMU_STAT0_DRDY0_IF_MASK, 1000, 40000);
>>> +	if (ret) {
>>> +		ret = -EAGAIN;
>>> +		goto out;
>>> +	}
>>> +
>>> +	/* DATA0 is 16bit signed number */
>>> +	data = readw_relaxed(tmu->base + IMX91_TMU_DATA0);
>>> +	*temp = data * 1000 / 64;
>>
>> cf units.h
>>
>> 	*temp = (data * MILLIDEGREE_PER_DEGREE) / A_LITERAL;
>>
>>> +	if (*temp < IMX91_TMU_TEMP_LOW_LIMIT || *temp > IMX91_TMU_TEMP_HIGH_LIMIT)
>>> +		ret = -EAGAIN;
>>> +
>>> +out:
>>> +	pm_runtime_put(tmu->dev);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static struct thermal_zone_device_ops tmu_tz_ops = {
>>> +	.get_temp = imx91_tmu_get_temp,
>>
>> Why not add the change_mode ops ?
> 
> I plan add later when add .set_trip_temp and irq support.
> 
> Frank
>>
>>> +};
>>> +
>>> +static int imx91_init_from_nvmem_cells(struct imx91_tmu *tmu)
>>> +{
>>> +	struct device *dev = tmu->dev;
>>> +	u32 trim1, trim2;
>>> +	int ret;
>>> +
>>> +	ret = nvmem_cell_read_u32(dev, "trim1", &trim1);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = nvmem_cell_read_u32(dev, "trim2", &trim2);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	if (trim1 == 0 || trim2 == 0)
>>> +		return -EINVAL;
>>> +
>>> +	writel_relaxed(trim1, tmu->base + IMX91_TMU_TRIM1);
>>> +	writel_relaxed(trim2, tmu->base + IMX91_TMU_TRIM2);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static void imx91_tmu_action_remove(void *data)
>>> +{
>>> +	struct imx91_tmu *tmu = data;
>>> +
>>> +	/* disable tmu */
>>> +	imx91_tmu_enable(tmu, false);
>>> +}
>>> +
>>> +static int imx91_tmu_probe(struct platform_device *pdev)
>>> +{
>>> +	struct device *dev = &pdev->dev;
>>> +	struct imx91_tmu *tmu;
>>> +	unsigned long rate;
>>> +	u32 div;
>>> +	int ret;
>>> +
>>> +	tmu = devm_kzalloc(dev, sizeof(struct imx91_tmu), GFP_KERNEL);
>>> +	if (!tmu)
>>> +		return -ENOMEM;
>>> +
>>> +	tmu->dev = dev;
>>> +
>>> +	tmu->base = devm_platform_ioremap_resource(pdev, 0);
>>> +	if (IS_ERR(tmu->base))
>>> +		return dev_err_probe(dev, PTR_ERR(tmu->base), "failed to get io resource");
>>> +
>>> +	tmu->clk = devm_clk_get_enabled(dev, NULL);
>>> +	if (IS_ERR(tmu->clk))
>>> +		return dev_err_probe(dev, PTR_ERR(tmu->clk), "failed to get tmu clock\n");
>>> +
>>> +	platform_set_drvdata(pdev, tmu);
>>> +
>>> +	/* disable the monitor during initialization */
>>> +	imx91_tmu_enable(tmu, false);
>>> +	imx91_tmu_start(tmu, false);
>>> +
>>> +	ret = imx91_init_from_nvmem_cells(tmu);
>>> +	if (ret) {
>>> +		writel_relaxed(IMX91_TMU_DEFAULT_TRIM1_CONFIG, tmu->base + IMX91_TMU_TRIM1);
>>> +		writel_relaxed(IMX91_TMU_DEFAULT_TRIM2_CONFIG, tmu->base + IMX91_TMU_TRIM2);
>>> +	}
>>> +
>>> +	/* The typical conv clk is 4MHz, the output freq is 'rate / (div + 1)' */
>>> +	rate = clk_get_rate(tmu->clk);
>>> +	div = (rate / 4000000) - 1;
>>
>> Use literals please (eg. 4 * HZ_PER_MHZ)
>>
>>> +	if (div > IMX91_TMU_DIV_MAX)
>>> +		return dev_err_probe(dev, -EINVAL, "clock divider exceed hardware limitation");
>>> +
>>> +	/* Set divider value and enable divider */
>>> +	writel_relaxed(IMX91_TMU_DIV_EN | FIELD_PREP(IMX91_TMU_DIV_MASK, div),
>>> +		       tmu->base + IMX91_TMU_REF_DIV);
>>> +
>>> +	/* Set max power up delay: 'Tpud(ms) = 0xFF * 1000 / 4000000' */
>>> +	writel_relaxed(FIELD_PREP(IMX91_TMU_PUDL_MASK, 100U), tmu->base + IMX91_TMU_PUD_ST_CTRL);
>>> +
>>> +	/*
>>> +	 * Set resolution mode
>>> +	 * 00b - Conversion time = 0.59325 ms
>>> +	 * 01b - Conversion time = 1.10525 ms
>>> +	 * 10b - Conversion time = 2.12925 ms
>>> +	 * 11b - Conversion time = 4.17725 ms
>>> +	 */
>>> +	writel_relaxed(FIELD_PREP(IMX91_TMU_CTRL1_RES_MASK, 0x3), tmu->base + IMX91_TMU_CTRL1_CLR);
>>> +	writel_relaxed(FIELD_PREP(IMX91_TMU_CTRL1_RES_MASK, 0x1), tmu->base + IMX91_TMU_CTRL1_SET);
>>> +
>>> +	writel_relaxed(IMX91_TMU_CTRL1_MEAS_MODE_MASK, tmu->base + IMX91_TMU_CTRL1_CLR);
>>> +	writel_relaxed(FIELD_PREP(IMX91_TMU_CTRL1_MEAS_MODE_MASK, IMX91_TMU_CTRL1_MEAS_MODE_SINGLE),
>>> +		       tmu->base + IMX91_TMU_CTRL1_SET);
>>> +
>>> +	pm_runtime_set_active(dev);
>>> +	devm_pm_runtime_enable(dev);
>>> +	pm_runtime_put(dev);
>>> +
>>> +	tmu->tzd = devm_thermal_of_zone_register(dev, 0, tmu, &tmu_tz_ops);
>>> +	if (IS_ERR(tmu->tzd))
>>> +		return dev_err_probe(dev, PTR_ERR(tmu->tzd),
>>> +				     "failed to register thermal zone sensor\n");
>>> +
>>> +	ret = devm_add_action(dev, imx91_tmu_action_remove, tmu);
>>
>> Should it be moved before devm_thermal_of_zone_register(), so if the thermal
>> zone creation fails, it will stop the sensor which was previously started ?
> 
> pm_runtime_put already disable sensor before call
> devm_thermal_of_zone_register().
> 
> imx91_tmu_get_temp() will call runtime_get when devm_thermal_of_zone_register()
> call to it.
> 
> Frank
> 
>>
>>> +	if (ret)
>>> +		return dev_err_probe(dev, ret, "Failure to add action imx91_tmu_action_remove()\n");
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int imx91_tmu_runtime_suspend(struct device *dev)
>>> +{
>>> +	struct imx91_tmu *tmu = dev_get_drvdata(dev);
>>> +
>>> +	/* disable tmu */
>>> +	imx91_tmu_enable(tmu, false);
>>> +
>>> +	clk_disable_unprepare(tmu->clk);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int imx91_tmu_runtime_resume(struct device *dev)
>>> +{
>>> +	struct imx91_tmu *tmu = dev_get_drvdata(dev);
>>> +	int ret;
>>> +
>>> +	ret = clk_prepare_enable(tmu->clk);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	imx91_tmu_enable(tmu, true);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static DEFINE_RUNTIME_DEV_PM_OPS(imx91_tmu_pm_ops, imx91_tmu_runtime_suspend,
>>> +				 imx91_tmu_runtime_resume, NULL);
>>> +
>>> +static const struct of_device_id imx91_tmu_table[] = {
>>> +	{ .compatible = "fsl,imx91-tmu", },
>>> +	{ },
>>> +};
>>> +MODULE_DEVICE_TABLE(of, imx91_tmu_table);
>>> +
>>> +static struct platform_driver imx91_tmu = {
>>> +	.driver = {
>>> +		.name	= "imx91_thermal",
>>> +		.pm	= pm_ptr(&imx91_tmu_pm_ops),
>>> +		.of_match_table = imx91_tmu_table,
>>> +	},
>>> +	.probe = imx91_tmu_probe,
>>> +};
>>> +module_platform_driver(imx91_tmu);
>>> +
>>> +MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
>>> +MODULE_DESCRIPTION("i.MX91 Thermal Monitor Unit driver");
>>> +MODULE_LICENSE("GPL");
>>>
>>
>>
>> --
>> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

