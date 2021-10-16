Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8437A4304DB
	for <lists+linux-pm@lfdr.de>; Sat, 16 Oct 2021 22:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244524AbhJPUIk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 Oct 2021 16:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244507AbhJPUIk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Oct 2021 16:08:40 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D690AC061765
        for <linux-pm@vger.kernel.org>; Sat, 16 Oct 2021 13:06:31 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k7so32609290wrd.13
        for <linux-pm@vger.kernel.org>; Sat, 16 Oct 2021 13:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tqWkVmqraGpT9gt8hOkOwjhPgaiwTxED6JEqS6Skcng=;
        b=xqKHdteVyd6dnadUU+tepraGJDExm26Otn34G7x4xfrACzTVK6bIFczvMUCLeYRv4F
         mpv/05LowJ0oTwncA9Au379Jb7f8UVg4+AHxMlGbi/W4i8Ymd6/+eKDsxVLywVeJpIbp
         YFjWhey0yVxKol2GMj8HndwOKvzhz/JXrqIwUP17yNQodvvuJvecNBOP5nPuTdjVTXJo
         vDSQ5SU1M5Gs+cFp7R9rw1G9kYCOk+0hAGU7T/QRjGXyFKQCBNAbEwM55X9xNg87hFSV
         5eKtz+Z1A0NYjnoJ3Bc9FX5O/5thYcb57jB1QPIq27PigXvEn5kvzsBxaiQFqBVed/gt
         IGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tqWkVmqraGpT9gt8hOkOwjhPgaiwTxED6JEqS6Skcng=;
        b=c7Hf3nA1QgVlE8PbeeKw9Ht6OyxYLcyLQ4gkiCTBCgj0taNLVquxF0Epy2EyBZ+sdE
         cQbk2f+DB4JPCBip6rhKxpcLMxfG0VyA/LX8VRZfiAZ9tfuaNIo+IyAKWvksHmdrqwxw
         /z0vVGMwrTSmgQK1qo8V2CMB9kd0Jg2jPtGj7U19nkOu/3eyCOqP5QpC9fpGmpSaCmiX
         0v6GvywmRF6iX+EATvF8dmDyYu/k5aQFThH4rkyilqIiculWYS3tTbCeci4nOmYWpjpZ
         iR816cjL80mzcWNKPC9FGjJ2tKSF2ne/4Csk5mA+SYV18/zC2WBwELwmBJCPjfFJS9dB
         WKbg==
X-Gm-Message-State: AOAM530OvlODPzpr5We8sL4VC4Vgzu3Fh7YHx6HAoncHKRzjr6YU8K99
        kwMB8CD5tTy7/LwVHNvD18D/yA==
X-Google-Smtp-Source: ABdhPJxWka+mhCqqZGhBTEGVr2ngGCW9Q5olDSi+tX7UIqvefkLXnAyWINDwWjf9KWX6L+vaiPNrpg==
X-Received: by 2002:a5d:6d8c:: with SMTP id l12mr23728874wrs.80.1634414790161;
        Sat, 16 Oct 2021 13:06:30 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:f04d:f65f:efd5:698? ([2a01:e34:ed2f:f020:f04d:f65f:efd5:698])
        by smtp.googlemail.com with ESMTPSA id f127sm13185359wmf.16.2021.10.16.13.06.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Oct 2021 13:06:29 -0700 (PDT)
Subject: Re: [PATCH 3/3] thermal: mediatek: add MT8365 thermal driver support
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, fparent@baylibre.com,
        khilman@baylibre.com
References: <20211014135636.3644166-1-msp@baylibre.com>
 <20211014135636.3644166-4-msp@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <33815817-0f64-836a-5417-c614e66e231e@linaro.org>
Date:   Sat, 16 Oct 2021 22:06:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211014135636.3644166-4-msp@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14/10/2021 15:56, Markus Schneider-Pargmann wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> mt8365 is similar to the other SoCs supported by the driver. It has only
> one bank and 3 sensors that can be multiplexed.
> 
> Additionally the buffer has to be enabled and connected to AUXADC
> similar to the V2 version but at a different register offset. That's why
> I added three new configuration values to define the register, mask and
> bits to be set to be able to use it for both V2 and mt8365.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> [Added apmixed control register logic]
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  drivers/thermal/mtk_thermal.c | 91 ++++++++++++++++++++++++++++++++---
>  1 file changed, 85 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index 93ee043d70da..7a75ae8231f2 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -31,6 +31,7 @@
>  #define AUXADC_CON2_V		0x010
>  #define AUXADC_DATA(channel)	(0x14 + (channel) * 4)
>  
> +#define APMIXED_SYS_TS_CON0	0x600
>  #define APMIXED_SYS_TS_CON1	0x604
>  
>  /* Thermal Controller Registers */
> @@ -245,6 +246,17 @@ enum mtk_thermal_version {
>  /* The calibration coefficient of sensor  */
>  #define MT8183_CALIBRATION	153
>  
> +/* MT8365 */
> +#define MT8365_TEMP_AUXADC_CHANNEL 11
> +#define MT8365_CALIBRATION 164
> +#define MT8365_NUM_CONTROLLER 1
> +#define MT8365_NUM_BANKS 1
> +#define MT8365_NUM_SENSORS 3
> +#define MT8365_NUM_SENSORS_PER_ZONE 3

You can get rid of these macros by using ARRAY_SIZE.

eg.

static const int mt8365_bank_data[] = {
	MT8365_TS1,
	MT8365_TS2,
	MT8365_TS3
};

...

	.num_sensors = ARRAY_SIZE(mt8365_bank_data);
...


> +#define MT8365_TS1 0
> +#define MT8365_TS2 1
> +#define MT8365_TS3 2
> +
>  struct mtk_thermal;
>  
>  struct thermal_bank_cfg {
> @@ -271,6 +283,9 @@ struct mtk_thermal_data {
>  	bool need_switch_bank;
>  	struct thermal_bank_cfg bank_data[MAX_NUM_ZONES];
>  	enum mtk_thermal_version version;
> +	u32 apmixed_buffer_ctl_reg;
> +	u32 apmixed_buffer_ctl_mask;
> +	u32 apmixed_buffer_ctl_set;
>  };
>  
>  struct mtk_thermal {
> @@ -386,6 +401,24 @@ static const int mt7622_mux_values[MT7622_NUM_SENSORS] = { 0, };
>  static const int mt7622_vts_index[MT7622_NUM_SENSORS] = { VTS1 };
>  static const int mt7622_tc_offset[MT7622_NUM_CONTROLLER] = { 0x0, };
>  
> +/* MT8365 thermal sensor data */
> +static const int mt8365_bank_data[MT8365_NUM_SENSORS] = {
> +	MT8365_TS1, MT8365_TS2, MT8365_TS3
> +};
> +
> +static const int mt8365_msr[MT8365_NUM_SENSORS_PER_ZONE] = {
> +	TEMP_MSR0, TEMP_MSR1, TEMP_MSR2
> +};
> +
> +static const int mt8365_adcpnp[MT8365_NUM_SENSORS_PER_ZONE] = {
> +	TEMP_ADCPNP0, TEMP_ADCPNP1, TEMP_ADCPNP2
> +};
> +
> +static const int mt8365_mux_values[MT8365_NUM_SENSORS] = { 0, 1, 2 };
> +static const int mt8365_tc_offset[MT8365_NUM_CONTROLLER] = { 0 };
> +
> +static const int mt8365_vts_index[MT8365_NUM_SENSORS] = { VTS1, VTS2, VTS3 };
> +
>  /*
>   * The MT8173 thermal controller has four banks. Each bank can read up to
>   * four temperature sensors simultaneously. The MT8173 has a total of 5
> @@ -460,6 +493,40 @@ static const struct mtk_thermal_data mt2701_thermal_data = {
>  	.version = MTK_THERMAL_V1,
>  };
>  
> +/*
> + * The MT8365 thermal controller has one bank, which can read up to
> + * four temperature sensors simultaneously. The MT8365 has a total of 3
> + * temperature sensors.
> + *
> + * The thermal core only gets the maximum temperature of this one bank,
> + * so the bank concept wouldn't be necessary here. However, the SVS (Smart
> + * Voltage Scaling) unit makes its decisions based on the same bank
> + * data.
> + */
> +static const struct mtk_thermal_data mt8365_thermal_data = {
> +	.auxadc_channel = MT8365_TEMP_AUXADC_CHANNEL,
> +	.num_banks = MT8365_NUM_BANKS,
> +	.num_sensors = MT8365_NUM_SENSORS,
> +	.vts_index = mt8365_vts_index,
> +	.cali_val = MT8365_CALIBRATION,
> +	.num_controller = MT8365_NUM_CONTROLLER,
> +	.controller_offset = mt8365_tc_offset,
> +	.need_switch_bank = false,
> +	.bank_data = {
> +		{
> +			.num_sensors = MT8365_NUM_SENSORS,
> +			.sensors = mt8365_bank_data
> +		},
> +	},
> +	.msr = mt8365_msr,
> +	.adcpnp = mt8365_adcpnp,
> +	.sensor_mux_values = mt8365_mux_values,
> +	.version = MTK_THERMAL_V1,
> +	.apmixed_buffer_ctl_reg = APMIXED_SYS_TS_CON0,
> +	.apmixed_buffer_ctl_mask = ~(u32)GENMASK(29, 28),
> +	.apmixed_buffer_ctl_set = 0,
> +};
> +
>  /*
>   * The MT2712 thermal controller has one bank, which can read up to
>   * four temperature sensors simultaneously. The MT2712 has a total of 4
> @@ -514,6 +581,9 @@ static const struct mtk_thermal_data mt7622_thermal_data = {
>  	.adcpnp = mt7622_adcpnp,
>  	.sensor_mux_values = mt7622_mux_values,
>  	.version = MTK_THERMAL_V2,
> +	.apmixed_buffer_ctl_reg = APMIXED_SYS_TS_CON1,
> +	.apmixed_buffer_ctl_mask = ~0x37,
> +	.apmixed_buffer_ctl_set = 0x1,

Please change those literal into macros

>  };
>  
>  /*
> @@ -958,19 +1028,27 @@ static const struct of_device_id mtk_thermal_of_match[] = {
>  	{
>  		.compatible = "mediatek,mt8183-thermal",
>  		.data = (void *)&mt8183_thermal_data,
> +	},
> +	{
> +		.compatible = "mediatek,mt8365-thermal",
> +		.data = (void *)&mt8365_thermal_data,

Is this cast really needed ?

>  	}, {
>  	},
>  };
>  MODULE_DEVICE_TABLE(of, mtk_thermal_of_match);
>  
> -static void mtk_thermal_turn_on_buffer(void __iomem *apmixed_base)
> +static void mtk_thermal_turn_on_buffer(struct mtk_thermal *mt,
> +				       void __iomem *apmixed_base)
>  {
>  	int tmp;
>  
> -	tmp = readl(apmixed_base + APMIXED_SYS_TS_CON1);
> -	tmp &= ~(0x37);
> -	tmp |= 0x1;
> -	writel(tmp, apmixed_base + APMIXED_SYS_TS_CON1);
> +	if (!mt->conf->apmixed_buffer_ctl_reg)
> +		return;
> +
> +	tmp = readl(apmixed_base + mt->conf->apmixed_buffer_ctl_reg);
> +	tmp &= mt->conf->apmixed_buffer_ctl_mask;
> +	tmp |= mt->conf->apmixed_buffer_ctl_set;

What is the goal of these two bits operations ?

> +	writel(tmp, apmixed_base + mt->conf->apmixed_buffer_ctl_reg);
>  	udelay(200);
>  }
>  
> @@ -1070,8 +1148,9 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>  		goto err_disable_clk_auxadc;
>  	}
>  
> +	mtk_thermal_turn_on_buffer(mt, apmixed_base);
> +
>  	if (mt->conf->version == MTK_THERMAL_V2) {
> -		mtk_thermal_turn_on_buffer(apmixed_base);
>  		mtk_thermal_release_periodic_ts(mt, auxadc_base);
>  	}
>  
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
