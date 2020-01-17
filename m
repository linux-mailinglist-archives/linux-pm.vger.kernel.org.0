Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D91E140949
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 12:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgAQLwZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jan 2020 06:52:25 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39263 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgAQLwY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jan 2020 06:52:24 -0500
Received: by mail-wm1-f67.google.com with SMTP id 20so7305151wmj.4
        for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2020 03:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BvPv/4a6yAkphN4LwLR2jYIuL5/kd7x2OvuXU09MQxM=;
        b=hRbtavNVKSpvbNMCt2dvp8TEjMUfiTCQYtSSXprPSuwd5e0eaPBUQ90+f/jRehMH65
         g+Gy5sdLZnpwjgKZvkq4nPSJdqULzQlJvBEb65Al8tXFJkooPSHvuQbgppArnuWh5Kq7
         MUY8OqsYR9JBZOYP4EupRp9G8waZuimKJbrKkiOjRaF7eVugP9JKT6pXZmnjPxs37qkE
         i7qpFZTNl3A4eqmz3PtX9dsdnQwl83kEZ/dxNkbFaHJ/TTKP1d3WQ69QR7xlpAAv2PT6
         oPfc3kowT2cBGz/3DXgtbniJ/Wzp1E+vTwdrYKlP89oDkkCvRzeH2R3N/kGMdGDXQsuB
         BWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BvPv/4a6yAkphN4LwLR2jYIuL5/kd7x2OvuXU09MQxM=;
        b=ew/AUfUp+7NzhfYrbIY9E/eFqL2t5WJbYr9b2SqbDVau84UxMqzKwsAoLJx5qgws3d
         g5jt7Q/VPzTqvhi3jgY3JtAFlbVQS2gtFKpkTz1GLMDwEYE+VOMuhbSKx3yGL9l9fs9C
         NJ7GvOmIPsycUTAfPmM5PR1Hu48FBD/Mv759hhvbuD0AutP5vXBDjParogCxg/1uEJIX
         hsoSDI2JOkLXb4DUfJSoKKE97Cy13cWFu5gWkT2EdwvQKq9WulDmpda1z5lcFDMwBBG0
         2DaP2YMO4rsMz/Ts4HtocRYgF00JX7wtv7tKbT3Tx0Qsb8rHC4lnwhdl6L55D5yKEoj+
         9Rqg==
X-Gm-Message-State: APjAAAWD8db9rU0Vk8iM63d780WVXYSsIKtIFeAchMrCpLu6+/tNWa+I
        PanYCCoXzr5wUFKCGHTOAvBgIVjgjp54mQ==
X-Google-Smtp-Source: APXvYqxxGLbgbotVkw7VVAiySWXS2rw1Iwll3YBReefOF21Z3BzA5IGOpn03gKC5hXFVNKdet3fq8g==
X-Received: by 2002:a1c:7918:: with SMTP id l24mr3969063wme.125.1579261941461;
        Fri, 17 Jan 2020 03:52:21 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:bd8d:1fed:63a3:4952? ([2a01:e34:ed2f:f020:bd8d:1fed:63a3:4952])
        by smtp.googlemail.com with ESMTPSA id a1sm33717310wrr.80.2020.01.17.03.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 03:52:20 -0800 (PST)
Subject: Re: [PATCH v2 2/2] thermal: sprd: Add Spreadtrum thermal driver
 support
To:     Baolin Wang <baolin.wang7@gmail.com>, rui.zhang@intel.com,
        edubezval@gmail.com, amit.kucheria@verdurent.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org,
        freeman.liu@unisoc.com, zhang.lyra@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <8d5358a67746b2aff5f6995cabd11d0d7c9e579e.1575978484.git.baolin.wang7@gmail.com>
 <dd3303a956e7dd5c065ac2b92b1dea7ee5d1df17.1575978484.git.baolin.wang7@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b653521a-0296-786c-072d-7f1962f3021a@linaro.org>
Date:   Fri, 17 Jan 2020 12:52:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <dd3303a956e7dd5c065ac2b92b1dea7ee5d1df17.1575978484.git.baolin.wang7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/12/2019 13:07, Baolin Wang wrote:
> From: Freeman Liu <freeman.liu@unisoc.com>
> 
> This patch adds the support for Spreadtrum thermal sensor controller,
> which can support maximum 8 sensors.
> 
> Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> ---
> Changes from v1:
>  - None.
> ---
>  drivers/thermal/Kconfig        |    7 +
>  drivers/thermal/Makefile       |    1 +
>  drivers/thermal/sprd_thermal.c |  548 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 556 insertions(+)
>  create mode 100644 drivers/thermal/sprd_thermal.c
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 59b79fc..646873d 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -429,4 +429,11 @@ config UNIPHIER_THERMAL
>  	  Enable this to plug in UniPhier on-chip PVT thermal driver into the
>  	  thermal framework. The driver supports CPU thermal zone temperature
>  	  reporting and a couple of trip points.
> +
> +config SPRD_THERMAL
> +	tristate "Temperature sensor on Spreadtrum SoCs"
> +	depends on ARCH_SPRD || COMPILE_TEST
> +	help
> +	  Support for the Spreadtrum thermal sensor driver in the Linux thermal
> +	  framework.
>  endif
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index baeb70b..544d867 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -55,3 +55,4 @@ obj-$(CONFIG_GENERIC_ADC_THERMAL)	+= thermal-generic-adc.o
>  obj-$(CONFIG_ZX2967_THERMAL)	+= zx2967_thermal.o
>  obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
>  obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
> +obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
> diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
> new file mode 100644
> index 0000000..d9b6074
> --- /dev/null
> +++ b/drivers/thermal/sprd_thermal.c
> @@ -0,0 +1,548 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2019 Spreadtrum Communications Inc.
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/thermal.h>
> +
> +#define SPRD_THM_CTL			0x0
> +#define SPRD_THM_INT_EN			0x4
> +#define SPRD_THM_INT_STS		0x8
> +#define SPRD_THM_INT_RAW_STS		0xc
> +#define SPRD_THM_DET_PERIOD		0x10
> +#define SPRD_THM_INT_CLR		0x14
> +#define SPRD_THM_INT_CLR_ST		0x18
> +#define SPRD_THM_MON_PERIOD		0x4c
> +#define SPRD_THM_MON_CTL		0x50
> +#define SPRD_THM_INTERNAL_STS1		0x54
> +#define SPRD_THM_RAW_READ_MSK		0x3ff
> +
> +#define SPRD_THM_OFFSET(id)		((id) * 0x4)
> +#define SPRD_THM_TEMP(id)		(SPRD_THM_OFFSET(id) + 0x5c)
> +#define SPRD_THM_THRES(id)		(SPRD_THM_OFFSET(id) + 0x2c)
> +
> +#define SPRD_THM_SEN(id)		BIT((id) + 2)
> +#define SPRD_THM_SEN_OVERHEAT_EN(id)	BIT((id) + 8)
> +#define SPRD_THM_SEN_OVERHEAT_ALARM_EN(id)	BIT((id) + 0)
> +
> +/* bits definitions for register THM_CTL */
> +#define SPRD_THM_SET_RDY_ST		BIT(13)
> +#define SPRD_THM_SET_RDY		BIT(12)
> +#define SPRD_THM_MON_EN			BIT(1)
> +#define SPRD_THM_EN			BIT(0)
> +
> +/* bits definitions for register THM_INT_CTL */
> +#define SPRD_THM_BIT_INT_EN		BIT(26)
> +#define SPRD_THM_OVERHEAT_EN		BIT(25)
> +#define SPRD_THM_OTP_TRIP_SHIFT		10
> +
> +/* bits definitions for register SPRD_THM_INTERNAL_STS1 */
> +#define SPRD_THM_TEMPER_RDY		BIT(0)
> +
> +#define SPRD_THM_DET_PERIOD_DATA	0x800
> +#define SPRD_THM_DET_PERIOD_MASK	GENMASK(19, 0)
> +#define SPRD_THM_MON_MODE		0x7
> +#define SPRD_THM_MON_MODE_MASK		GENMASK(3, 0)
> +#define SPRD_THM_MON_PERIOD_DATA	0x10
> +#define SPRD_THM_MON_PERIOD_MASK	GENMASK(15, 0)
> +#define SPRD_THM_THRES_MASK		GENMASK(19, 0)
> +#define SPRD_THM_INT_CLR_MASK		GENMASK(24, 0)
> +
> +/* thermal sensor calibration parameters */
> +#define SPRD_THM_TEMP_LOW		-40000
> +#define SPRD_THM_TEMP_HIGH		120000
> +#define SPRD_THM_OTP_TEMP		120000
> +#define SPRD_THM_HOT_TEMP		75000
> +#define SPRD_THM_RAW_DATA_LOW		0
> +#define SPRD_THM_RAW_DATA_HIGH		1000
> +#define SPRD_THM_SEN_NUM		8
> +#define SPRD_THM_DT_OFFSET		24
> +#define SPRD_THM_RATION_OFFSET		17
> +#define SPRD_THM_RATION_SIGN		16
> +
> +#define SPRD_THM_RDYST_POLLING_TIME	10
> +#define SPRD_THM_RDYST_TIMEOUT		700
> +#define SPRD_THM_TEMP_READY_POLL_TIME	10000
> +#define SPRD_THM_TEMP_READY_TIMEOUT	600000
> +#define SPRD_THM_MAX_SENSOR		8
> +
> +struct sprd_thermal_sensor {
> +	struct thermal_zone_device *thmzone_dev;
> +	struct sprd_thermal_data *data;
> +	struct device *dev;
> +	bool ready;
> +	int cal_slope;
> +	int cal_offset;
> +	int last_temp;
> +	int id;
> +};
> +
> +struct sprd_thermal_data {
> +	const struct sprd_thm_variant_data *var_data;
> +	struct sprd_thermal_sensor *sensor[SPRD_THM_MAX_SENSOR];
> +	struct clk *clk;
> +	void __iomem *base;
> +	u32 ratio_off;
> +	u32 ratio_sign;
> +	int nr_sensors;
> +};
> +
> +/*
> + * The conversion between ADC and temperature is based on linear relationship,
> + * and use idea_k to specify the slope and ideal_b to specify the offset.
> + *
> + * Since different Spreadtrum SoCs have different ideal_k and ideal_b,
> + * we should save ideal_k and ideal_b in the device data structure.
> + */
> +struct sprd_thm_variant_data {
> +	u32 ideal_k;
> +	u32 ideal_b;
> +};
> +
> +static const struct sprd_thm_variant_data ums512_data = {
> +	.ideal_k = 262,
> +	.ideal_b = 66400,
> +};
> +
> +static inline void sprd_thm_update_bits(void __iomem *reg, u32 mask, u32 val)
> +{
> +	u32 tmp, orig;
> +
> +	orig = readl(reg);
> +	tmp = orig & ~mask;
> +	tmp |= val & mask;
> +	writel(tmp, reg);

Please have a look at linux/bitops.h and check if a macro does not fit
your need (eg. set_mask_bits and set_bit). AFAICT, most of the operation
are clear/set bits.

> +}
> +
> +static int sprd_thm_cal_read(struct device_node *np, const char *cell_id,
> +			     u32 *val)
> +{
> +	struct nvmem_cell *cell;
> +	void *buf;
> +	size_t len;
> +
> +	cell = of_nvmem_cell_get(np, cell_id);
> +	if (IS_ERR(cell))
> +		return PTR_ERR(cell);
> +
> +	buf = nvmem_cell_read(cell, &len);
> +	nvmem_cell_put(cell);
> +	if (IS_ERR(buf))
> +		return PTR_ERR(buf);
> +
> +	memcpy(val, buf, min(len, sizeof(u32)));

I'm probably nitpicking but what if the len is different from the u32,
the result will be inconsistent. If that can happen, wouldn't make sense
to bail out before with an error ?

> +	kfree(buf);
> +	return 0;
> +}
> +
> +static int sprd_thm_senor_calibration(struct device_node *np,
> +				      struct sprd_thermal_data *thm,
> +				      struct sprd_thermal_sensor *sen)

"senor_calibration" or "sensor_calibration" ?

> +{
> +	int ret;
> +	/*
> +	 * According to thermal datasheet, the default calibration offset is 64,
> +	 * and the default ratio is 1000.
> +	 */
> +	int dt_offset = 64, ratio = 1000;
> +
> +	ret = sprd_thm_cal_read(np, "sen_delta_cal", &dt_offset);
> +	if (ret)
> +		return ret;
> +
> +	if (thm->ratio_sign == 1)
> +		ratio = 1000 - thm->ratio_off;
> +	else
> +		ratio = 1000 + thm->ratio_off;

Store ratio_sign = -1 | 1 at init time, then :

  ratio += ratio_sign * thm->ratio_off

> +	/*
> +	 * According to the ideal slope K and ideal offset B, combined with
> +	 * calibration value of thermal from efuse, then calibrate the real
> +	 * slope k and offset b:
> +	 * k_cal = (k * ratio) / 1000.
> +	 * b_cal = b + (dt_offset - 64) * 500.
> +	 */
> +	sen->cal_slope = (thm->var_data->ideal_k * ratio) / 1000;
> +	sen->cal_offset = thm->var_data->ideal_b + (dt_offset - 128) * 250;
> +
> +	return 0;
> +}
> +
> +static int sprd_thm_rawdata_to_temp(struct sprd_thermal_sensor *sen,
> +				    u32 rawdata)
> +{
> +	if (rawdata < SPRD_THM_RAW_DATA_LOW)
> +		rawdata = SPRD_THM_RAW_DATA_LOW;
> +	else if (rawdata > SPRD_THM_RAW_DATA_HIGH)
> +		rawdata = SPRD_THM_RAW_DATA_HIGH;

check clamp() macro in kernel.h

> +	/*
> +	 * According to the thermal datasheet, the formula of converting
> +	 * adc value to the temperature value should be:
> +	 * T_final = k_cal * x - b_cal.
> +	 */
> +	return sen->cal_slope * rawdata - sen->cal_offset;
> +}
> +
> +static int sprd_thm_temp_to_rawdata(int temp, struct sprd_thermal_sensor *sen)
> +{
> +	u32 val;
> +
> +	if (temp < SPRD_THM_TEMP_LOW)
> +		temp = SPRD_THM_TEMP_LOW;
> +	else if (temp > SPRD_THM_TEMP_HIGH)
> +		temp = SPRD_THM_TEMP_HIGH;

check clamp() macro in kernel.h

> +	/*
> +	 * According to the thermal datasheet, the formula of converting
> +	 * adc value to the temperature value should be:
> +	 * T_final = k_cal * x - b_cal.
> +	 */
> +	val = (temp + sen->cal_offset) / sen->cal_slope;
> +
> +	return val >= SPRD_THM_RAW_DATA_HIGH ? (SPRD_THM_RAW_DATA_HIGH - 1) : val;

check clamp() macro in kernel.h

> +}
> +
> +static int sprd_thm_read_temp(void *devdata, int *temp)
> +{
> +	struct sprd_thermal_sensor *sen = devdata;
> +	int sensor_temp;
> +	u32 data;
> +
> +	data = readl(sen->data->base + SPRD_THM_TEMP(sen->id)) &
> +		SPRD_THM_RAW_READ_MSK;
> +
> +	if (sen->ready) {
> +		sensor_temp = sprd_thm_rawdata_to_temp(sen, data);
> +		sen->last_temp = sensor_temp;
> +		*temp = sensor_temp;

If the initialization is done in the right order and using the
THERMAL_DEVICE_DISABLED, this test should not be needed. And de facto,
neither the last_temp.

As a side note, if the sensor is not ready it should return an error
like -EBUSY instead of the previous value.

> +	} else {
> +		/*
> +		 * If the sensor is not ready, then just return last
> +		 * temperature value.
> +		 */
> +		*temp = sen->last_temp;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct thermal_zone_of_device_ops sprd_thm_ops = {
> +	.get_temp = sprd_thm_read_temp,
> +};
> +
> +static int sprd_thm_poll_ready_status(struct sprd_thermal_data *thm)
> +{
> +	u32 val;
> +	int ret;
> +
> +	/*
> +	 * Wait for thermal ready status before configuring thermal parameters.
> +	 */
> +	ret = readl_poll_timeout(thm->base + SPRD_THM_CTL, val,
> +				 !(val & SPRD_THM_SET_RDY_ST),
> +				 SPRD_THM_RDYST_POLLING_TIME,
> +				 SPRD_THM_RDYST_TIMEOUT);
> +	if (ret)
> +		return ret;
> +
> +	sprd_thm_update_bits(thm->base + SPRD_THM_CTL, SPRD_THM_MON_EN,
> +			     SPRD_THM_MON_EN);
> +	sprd_thm_update_bits(thm->base + SPRD_THM_CTL, SPRD_THM_SET_RDY,
> +			     SPRD_THM_SET_RDY);
> +	return 0;
> +}
> +
> +static int sprd_thm_wait_temp_ready(struct sprd_thermal_data *thm)
> +{
> +	u32 val;
> +
> +	/* Wait for first temperature data ready before reading temperature */
> +	return readl_poll_timeout(thm->base + SPRD_THM_INTERNAL_STS1, val,
> +				  !(val & SPRD_THM_TEMPER_RDY),
> +				  SPRD_THM_TEMP_READY_POLL_TIME,
> +				  SPRD_THM_TEMP_READY_TIMEOUT);
> +}
> +
> +static int sprd_thm_set_ready(struct sprd_thermal_data *thm)
> +{
> +	int ret;
> +
> +	ret = sprd_thm_poll_ready_status(thm);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Clear interrupt status, enable thermal interrupt and enable thermal.
> +	 */
> +	writel(SPRD_THM_INT_CLR_MASK, thm->base + SPRD_THM_INT_CLR);
> +	sprd_thm_update_bits(thm->base + SPRD_THM_INT_EN,
> +			     SPRD_THM_BIT_INT_EN, SPRD_THM_BIT_INT_EN);
> +	sprd_thm_update_bits(thm->base + SPRD_THM_CTL,
> +			     SPRD_THM_EN, SPRD_THM_EN);

Why enabling the interrupt while there is no handler for it?

> +	return 0;
> +}
> +
> +static void sprd_thm_sensor_init(struct sprd_thermal_data *thm,
> +				 struct sprd_thermal_sensor *sen)
> +{
> +	u32 otp_rawdata, hot_rawdata;
> +
> +	otp_rawdata = sprd_thm_temp_to_rawdata(SPRD_THM_OTP_TEMP, sen);
> +	hot_rawdata = sprd_thm_temp_to_rawdata(SPRD_THM_HOT_TEMP, sen);
> +
> +	/* Enable the sensor' overheat temperature protection interrupt */
> +	sprd_thm_update_bits(thm->base + SPRD_THM_INT_EN,
> +			     SPRD_THM_SEN_OVERHEAT_ALARM_EN(sen->id),
> +			     SPRD_THM_SEN_OVERHEAT_ALARM_EN(sen->id));
> +
> +	/* Set the sensor' overheat and hot threshold temperature */
> +	sprd_thm_update_bits(thm->base + SPRD_THM_THRES(sen->id),
> +			     SPRD_THM_THRES_MASK,
> +			     (otp_rawdata << SPRD_THM_OTP_TRIP_SHIFT) |
> +			     hot_rawdata);
> +
> +	/* Enable the corresponding sensor */
> +	sprd_thm_update_bits(thm->base + SPRD_THM_CTL, SPRD_THM_SEN(sen->id),
> +			     SPRD_THM_SEN(sen->id));
> +}
> +
> +static void sprd_thm_para_config(struct sprd_thermal_data *thm)
> +{
> +	/* Set the period of two valid temperature detection action */
> +	sprd_thm_update_bits(thm->base + SPRD_THM_DET_PERIOD,
> +			     SPRD_THM_DET_PERIOD_MASK, SPRD_THM_DET_PERIOD);
> +
> +	/* Set the sensors' monitor mode */
> +	sprd_thm_update_bits(thm->base + SPRD_THM_MON_CTL,
> +			     SPRD_THM_MON_MODE_MASK, SPRD_THM_MON_MODE);
> +
> +	/* Set the sensors' monitor period */
> +	sprd_thm_update_bits(thm->base + SPRD_THM_MON_PERIOD,
> +			     SPRD_THM_MON_PERIOD_MASK, SPRD_THM_MON_PERIOD);
> +}
> +
> +static int sprd_thm_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *sen_child;
> +	struct sprd_thermal_data *thm;
> +	struct sprd_thermal_sensor *sen;
> +	const struct sprd_thm_variant_data *pdata;
> +	int ret, i;
> +
> +	pdata = of_device_get_match_data(&pdev->dev);
> +	if (!pdata) {
> +		dev_err(&pdev->dev, "No matching driver data found\n");
> +		return -EINVAL;
> +	}
> +
> +	thm = devm_kzalloc(&pdev->dev, sizeof(*thm), GFP_KERNEL);
> +	if (!thm)
> +		return -ENOMEM;
> +
> +	thm->var_data = pdata;
> +	thm->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (!thm->base)
> +		return -ENOMEM;
> +
> +	thm->nr_sensors = of_get_child_count(np);
> +	if (thm->nr_sensors == 0 || thm->nr_sensors > SPRD_THM_MAX_SENSOR) {
> +		dev_err(&pdev->dev, "incorrect sensor count\n");
> +		return -EINVAL;
> +	}
> +
> +	thm->clk = devm_clk_get(&pdev->dev, "enable");
> +	if (IS_ERR(thm->clk)) {
> +		dev_err(&pdev->dev, "failed to get enable clock\n");
> +		return PTR_ERR(thm->clk);
> +	}
> +
> +	ret = clk_prepare_enable(thm->clk);
> +	if (ret)
> +		return ret;
> +
> +	sprd_thm_para_config(thm);
> +
> +	ret = sprd_thm_cal_read(np, "thm_sign_cal", &thm->ratio_sign);
> +	if (ret)
> +		goto disable_clk;
> +
> +	ret = sprd_thm_cal_read(np, "thm_ratio_cal", &thm->ratio_off);
> +	if (ret)
> +		goto disable_clk;
> +
> +	for_each_child_of_node(np, sen_child) {
> +		sen = devm_kzalloc(&pdev->dev, sizeof(*sen), GFP_KERNEL);
> +		if (!sen) {
> +			ret = -ENOMEM;
> +			goto disable_clk;
> +		}
> +
> +		sen->ready = false;
> +		sen->data = thm;
> +		sen->dev = &pdev->dev;
> +
> +		ret = of_property_read_u32(sen_child, "reg", &sen->id);
> +		if (ret) {
> +			dev_err(&pdev->dev, "get sensor reg failed");
> +			goto disable_clk;
> +		}
> +
> +		ret = sprd_thm_senor_calibration(sen_child, thm, sen);
> +		if (ret) {
> +			dev_err(&pdev->dev, "efuse cal analysis failed");
> +			goto disable_clk;
> +		}
> +
> +		sprd_thm_sensor_init(thm, sen);
> +
> +		sen->thmzone_dev =
> +			devm_thermal_zone_of_sensor_register(sen->dev, sen->id,
> +							     sen, &sprd_thm_ops);
> +		if (IS_ERR(sen->thmzone_dev)) {
> +			dev_err(&pdev->dev, "register thermal zone failed %d\n",
> +				sen->id);
> +			ret = PTR_ERR(sen->thmzone_dev);
> +			goto disable_clk;
> +		}
> +
> +		thm->sensor[sen->id] = sen;
> +	}
> +
> +	ret = sprd_thm_set_ready(thm);
> +	if (ret)
> +		goto disable_clk;
> +
> +	ret = sprd_thm_wait_temp_ready(thm);
> +	if (ret)
> +		goto disable_clk;
> +
> +	for (i = 0; i < thm->nr_sensors; i++)
> +		thm->sensor[i]->ready = true;

You should replace 'ready' by the THERMAL_DEVICE_ENABLED/DISABLED (grep
it on the other drivers for reference) and/or call
devm_thermal_zone_of_sensor_register() here.

> +	platform_set_drvdata(pdev, thm);
> +	return 0;
> +
> +disable_clk:
> +	clk_disable_unprepare(thm->clk);
> +	return ret;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static void sprd_thm_hw_suspend(struct sprd_thermal_data *thm)
> +{
> +	int i;
> +
> +	for (i = 0; i < thm->nr_sensors; i++) {
> +		sprd_thm_update_bits(thm->base + SPRD_THM_CTL,
> +				     SPRD_THM_SEN(thm->sensor[i]->id), 0);
> +	}
> +
> +	sprd_thm_update_bits(thm->base + SPRD_THM_CTL,
> +			     SPRD_THM_EN, 0x0);
> +}
> +
> +static int sprd_thm_suspend(struct device *dev)
> +{
> +	struct sprd_thermal_data *thm = dev_get_drvdata(dev);
> +	int i;
> +
> +	for (i = 0; i < thm->nr_sensors; i++)
> +		thm->sensor[i]->ready = false;
> +
> +	sprd_thm_hw_suspend(thm);
> +	clk_disable_unprepare(thm->clk);
> +
> +	return 0;
> +}
> +
> +static int sprd_thm_hw_resume(struct sprd_thermal_data *thm)
> +{
> +	int ret, i;
> +
> +	for (i = 0; i < thm->nr_sensors; i++) {
> +		sprd_thm_update_bits(thm->base + SPRD_THM_CTL,
> +				     SPRD_THM_SEN(thm->sensor[i]->id),
> +				     SPRD_THM_SEN(thm->sensor[i]->id));
> +	}
> +
> +	ret = sprd_thm_poll_ready_status(thm);
> +	if (ret)
> +		return ret;
> +
> +	writel(SPRD_THM_INT_CLR_MASK, thm->base + SPRD_THM_INT_CLR);
> +	sprd_thm_update_bits(thm->base + SPRD_THM_CTL,
> +			     SPRD_THM_EN, SPRD_THM_EN);
> +	return sprd_thm_wait_temp_ready(thm);
> +}
> +
> +static int sprd_thm_resume(struct device *dev)
> +{
> +	struct sprd_thermal_data *thm = dev_get_drvdata(dev);
> +	int ret, i;
> +
> +	ret = clk_prepare_enable(thm->clk);
> +	if (ret)
> +		return ret;
> +
> +	ret = sprd_thm_hw_resume(thm);
> +	if (ret)
> +		goto disable_clk;
> +
> +	for (i = 0; i < thm->nr_sensors; i++)
> +		thm->sensor[i]->ready = true;
> +
> +	return 0;
> +
> +disable_clk:
> +	clk_disable_unprepare(thm->clk);
> +	return ret;
> +}
> +#endif
> +
> +static int sprd_thm_remove(struct platform_device *pdev)
> +{
> +	struct sprd_thermal_data *thm = platform_get_drvdata(pdev);
> +	int i;
> +
> +	for (i = 0; i < thm->nr_sensors; i++) {
> +		devm_thermal_zone_of_sensor_unregister(&pdev->dev,
> +						       thm->sensor[i]->thmzone_dev);
> +	}
> +
> +	clk_disable_unprepare(thm->clk);
> +	return 0;
> +}
> +
> +static const struct of_device_id sprd_thermal_of_match[] = {
> +	{ .compatible = "sprd,ums512-thermal", .data = &ums512_data },
> +	{ },
> +};
> +
> +static const struct dev_pm_ops sprd_thermal_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(sprd_thm_suspend, sprd_thm_resume)
> +};
> +
> +static struct platform_driver sprd_thermal_driver = {
> +	.probe = sprd_thm_probe,
> +	.remove = sprd_thm_remove,
> +	.driver = {
> +		.name = "sprd-thermal",
> +		.pm = &sprd_thermal_pm_ops,
> +		.of_match_table = sprd_thermal_of_match,
> +	},
> +};
> +
> +module_platform_driver(sprd_thermal_driver);
> +
> +MODULE_AUTHOR("Freeman Liu <freeman.liu@unisoc.com>");
> +MODULE_DESCRIPTION("Spreadtrum thermal driver");
> +MODULE_LICENSE("GPL v2");
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

