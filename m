Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848D136A18B
	for <lists+linux-pm@lfdr.de>; Sat, 24 Apr 2021 16:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhDXOOo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 24 Apr 2021 10:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbhDXOOn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Apr 2021 10:14:43 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF0EC06174A
        for <linux-pm@vger.kernel.org>; Sat, 24 Apr 2021 07:14:03 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id i129so564143wma.3
        for <linux-pm@vger.kernel.org>; Sat, 24 Apr 2021 07:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yEV9Vfi6k8yPSdjdFWWfpN6I3p7j7bxmcNzDqwiFJu8=;
        b=R7dzx1vXGVkZJQ+OC33Rx61kKne3uW3g3wEFwDnewpiBq7erBZuYtcZyc9W2/18h2U
         /HlfvQ1OGfXD7dUOxFJZHJJ6hqjB8ul/hMH+FVgbuOYkPGBh4wUoe4XxxcNXJ2sLNU5h
         x1jMLu8Kzf6kZEpqYhxgCqZrvAD4BaHXW2XnyTQfYXbhBQvCQ9yfgvGYTnVKI6NRH/1k
         vq414mYOQTcAAsAyOQb5ysCFSpK5w7XU1n4wq+NNyEAj0LjAaQhGC+VA8HAKp0UzQwKS
         3uhdRCJTuI3RAf/SopnoNk3h2nj5gcOmzrPQBss+Noh9kX01zKNwfLYZLO7ghpbf3J8x
         Ty+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yEV9Vfi6k8yPSdjdFWWfpN6I3p7j7bxmcNzDqwiFJu8=;
        b=Hln64Xy+RPQi0Rta3cJqcRB3LH3/q0MgTOwTWF9GYZ/4RxObkV+bzJm8Hv+puEQrx4
         T07gzt+NVj5LqUvQFww7robQVVEURMJPwc5wHp16enKAnOO73OcHbNBVIs9dwoxk8Nry
         wAMqgnnPMAEI5Muk2mX6+7+gqTZM/nxeaaCYB0Z+LOSGeSbJ5ZNo2s21h3XNJ+ZjC6+b
         nB7F6onDanDubS4Yq+EDH/wTgWpW5mvKF+4ozIRgfOlRm1jGByhXcLJj5OWbZbtHLyV/
         weTupTkN/mx8TwWyX7RlLov/chfEN8mJtGMNMvh8hLvkf3RIAPHFzZjaz3OmoOtpOpRp
         CQ3A==
X-Gm-Message-State: AOAM533CbMeLY37S16MZI4qNEaRMfWBj8pHiVGsjZrG5GicPVYJR+Nv/
        S3cE++x4r+9PpyiDrG05ypoBzw==
X-Google-Smtp-Source: ABdhPJx8tQzLxxZLKT4GC6X8qAIHKfZGSViRWvK2OFJ1IeSJB7VpLcUdzqefv7/tzNPdoDQvCOzRJg==
X-Received: by 2002:a1c:f305:: with SMTP id q5mr10916950wmq.96.1619273641796;
        Sat, 24 Apr 2021 07:14:01 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:85f7:144e:18c:5cfc? ([2a01:e34:ed2f:f020:85f7:144e:18c:5cfc])
        by smtp.googlemail.com with ESMTPSA id s10sm12546073wrt.23.2021.04.24.07.14.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Apr 2021 07:14:01 -0700 (PDT)
Subject: Re: [PATCH 2/2] thermal/rockchip: Support RK3568 SoCs in the thermal
 driver
To:     Ezequiel Garcia <ezequiel@collabora.com>, linux-pm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Finley Xiao <finley.xiao@rock-chips.com>, kernel@collabora.com
References: <20210421200445.32977-1-ezequiel@collabora.com>
 <20210421200445.32977-2-ezequiel@collabora.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ef9140da-c996-512a-b459-53461bd8198e@linaro.org>
Date:   Sat, 24 Apr 2021 16:14:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210421200445.32977-2-ezequiel@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/04/2021 22:04, Ezequiel Garcia wrote:
> From: Finley Xiao <finley.xiao@rock-chips.com>
> 
> The RK3568 SoCs have two Temperature Sensors, channel 0 is for CPU,
> channel 1 is for GPU.
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
>  drivers/thermal/rockchip_thermal.c | 107 +++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
> 
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index aa9e0e31ef98..8e26f2685003 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -211,7 +211,11 @@ struct rockchip_thermal_data {
>  #define TSADCV3_AUTO_PERIOD_TIME		1875 /* 2.5ms */
>  #define TSADCV3_AUTO_PERIOD_HT_TIME		1875 /* 2.5ms */
>  
> +#define TSADCV5_AUTO_PERIOD_TIME		1622 /* 2.5ms */
> +#define TSADCV5_AUTO_PERIOD_HT_TIME		1622 /* 2.5ms */
> +
>  #define TSADCV2_USER_INTER_PD_SOC		0x340 /* 13 clocks */
> +#define TSADCV5_USER_INTER_PD_SOC		0xfc0 /* 97us, at least 90us */
>  
>  #define GRF_SARADC_TESTBIT			0x0e644
>  #define GRF_TSADC_TESTBIT_L			0x0e648
> @@ -219,6 +223,12 @@ struct rockchip_thermal_data {
>  
>  #define PX30_GRF_SOC_CON2			0x0408
>  
> +#define RK3568_GRF_TSADC_CON			0x0600
> +#define RK3568_GRF_TSADC_ANA_REG0		(0x10001 << 0)
> +#define RK3568_GRF_TSADC_ANA_REG1		(0x10001 << 1)
> +#define RK3568_GRF_TSADC_ANA_REG2		(0x10001 << 2)
> +#define RK3568_GRF_TSADC_TSEN			(0x10001 << 8)
> +
>  #define GRF_SARADC_TESTBIT_ON			(0x10001 << 2)
>  #define GRF_TSADC_TESTBIT_H_ON			(0x10001 << 2)
>  #define GRF_TSADC_VCM_EN_L			(0x10001 << 7)
> @@ -474,6 +484,45 @@ static const struct tsadc_table rk3399_code_table[] = {
>  	{TSADCV3_DATA_MASK, 125000},
>  };
>  
> +static const struct tsadc_table rk3568_code_table[] = {
> +	{0, -40000},
> +	{1584, -40000},
> +	{1620, -35000},
> +	{1652, -30000},
> +	{1688, -25000},
> +	{1720, -20000},
> +	{1756, -15000},
> +	{1788, -10000},
> +	{1824, -5000},
> +	{1856, 0},
> +	{1892, 5000},
> +	{1924, 10000},
> +	{1956, 15000},
> +	{1992, 20000},
> +	{2024, 25000},
> +	{2060, 30000},
> +	{2092, 35000},
> +	{2128, 40000},
> +	{2160, 45000},
> +	{2196, 50000},
> +	{2228, 55000},
> +	{2264, 60000},
> +	{2300, 65000},
> +	{2332, 70000},
> +	{2368, 75000},
> +	{2400, 80000},
> +	{2436, 85000},
> +	{2468, 90000},
> +	{2500, 95000},
> +	{2536, 100000},
> +	{2572, 105000},
> +	{2604, 110000},
> +	{2636, 115000},
> +	{2672, 120000},
> +	{2704, 125000},
> +	{TSADCV2_DATA_MASK, 125000},
> +};
> +
>  static u32 rk_tsadcv2_temp_to_code(const struct chip_tsadc_table *table,
>  				   int temp)
>  {
> @@ -701,6 +750,35 @@ static void rk_tsadcv4_initialize(struct regmap *grf, void __iomem *regs,
>  	regmap_write(grf, PX30_GRF_SOC_CON2, GRF_CON_TSADC_CH_INV);
>  }
>  
> +static void rk_tsadcv7_initialize(struct regmap *grf, void __iomem *regs,
> +				  enum tshut_polarity tshut_polarity)
> +{
> +	writel_relaxed(TSADCV5_USER_INTER_PD_SOC, regs + TSADCV2_USER_CON);
> +	writel_relaxed(TSADCV5_AUTO_PERIOD_TIME, regs + TSADCV2_AUTO_PERIOD);
> +	writel_relaxed(TSADCV2_HIGHT_INT_DEBOUNCE_COUNT,
> +		       regs + TSADCV2_HIGHT_INT_DEBOUNCE);
> +	writel_relaxed(TSADCV5_AUTO_PERIOD_HT_TIME,
> +		       regs + TSADCV2_AUTO_PERIOD_HT);
> +	writel_relaxed(TSADCV2_HIGHT_TSHUT_DEBOUNCE_COUNT,
> +		       regs + TSADCV2_HIGHT_TSHUT_DEBOUNCE);
> +
> +	if (tshut_polarity == TSHUT_HIGH_ACTIVE)
> +		writel_relaxed(0U | TSADCV2_AUTO_TSHUT_POLARITY_HIGH,
> +			       regs + TSADCV2_AUTO_CON);
> +	else
> +		writel_relaxed(0U & ~TSADCV2_AUTO_TSHUT_POLARITY_HIGH,
> +			       regs + TSADCV2_AUTO_CON);
> +
> +	if (!IS_ERR(grf)) {

That is strange to do this check with a parameter. Is the sensor
functional if the regmap failed ?

> +		regmap_write(grf, RK3568_GRF_TSADC_CON, RK3568_GRF_TSADC_TSEN);
> +		udelay(15);
> +		regmap_write(grf, RK3568_GRF_TSADC_CON, RK3568_GRF_TSADC_ANA_REG0);
> +		regmap_write(grf, RK3568_GRF_TSADC_CON, RK3568_GRF_TSADC_ANA_REG1);
> +		regmap_write(grf, RK3568_GRF_TSADC_CON, RK3568_GRF_TSADC_ANA_REG2);
> +		usleep_range(100, 200);

Is it possible to put a comment on why these delays are necessary (if
you have the info) ?

> +	}
> +}
> +
>  static void rk_tsadcv2_irq_ack(void __iomem *regs)
>  {
>  	u32 val;
> @@ -1027,6 +1105,31 @@ static const struct rockchip_tsadc_chip rk3399_tsadc_data = {
>  	},
>  };
>  
> +static const struct rockchip_tsadc_chip rk3568_tsadc_data = {
> +	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
> +	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
> +	.chn_num = 2, /* two channels for tsadc */
> +
> +	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
> +	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
> +	.tshut_temp = 95000,
> +
> +	.initialize = rk_tsadcv7_initialize,
> +	.irq_ack = rk_tsadcv3_irq_ack,
> +	.control = rk_tsadcv3_control,
> +	.get_temp = rk_tsadcv2_get_temp,
> +	.set_alarm_temp = rk_tsadcv2_alarm_temp,
> +	.set_tshut_temp = rk_tsadcv2_tshut_temp,
> +	.set_tshut_mode = rk_tsadcv2_tshut_mode,
> +
> +	.table = {
> +		.id = rk3568_code_table,
> +		.length = ARRAY_SIZE(rk3568_code_table),
> +		.data_mask = TSADCV2_DATA_MASK,
> +		.mode = ADC_INCREMENT,
> +	},
> +};
> +
>  static const struct of_device_id of_rockchip_thermal_match[] = {
>  	{	.compatible = "rockchip,px30-tsadc",
>  		.data = (void *)&px30_tsadc_data,
> @@ -1059,6 +1162,10 @@ static const struct of_device_id of_rockchip_thermal_match[] = {
>  		.compatible = "rockchip,rk3399-tsadc",
>  		.data = (void *)&rk3399_tsadc_data,
>  	},
> +	{
> +		.compatible = "rockchip,rk3568-tsadc",
> +		.data = (void *)&rk3568_tsadc_data,
> +	},
>  	{ /* end */ },
>  };
>  MODULE_DEVICE_TABLE(of, of_rockchip_thermal_match);
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
