Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64CE4333CD
	for <lists+linux-pm@lfdr.de>; Tue, 19 Oct 2021 12:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbhJSKqg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 06:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbhJSKqf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 06:46:35 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3FDC06161C
        for <linux-pm@vger.kernel.org>; Tue, 19 Oct 2021 03:44:22 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e3so46625291wrc.11
        for <linux-pm@vger.kernel.org>; Tue, 19 Oct 2021 03:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u1emP74LMR8/SvGoouwH++0x/p6OWG+7EYKvBz2UYg8=;
        b=of5XTyT0K3CPL1nTRDT8JDcSH2dpt4BaIJGz42QaY2MJkw8Pj9kPOn05hWWo1FN/i1
         BdacScUTT5bwFpPLeUTjLfVGSNiGq9UO1fiG6qPQ+2iSVLu+5xwLvIYdicuxpOVl+NMk
         JavBQ80EGM3/fZzbs3enCHN4p3UXmsZ/ov/gLYdDATLbPiyHH7miUPcagf6/n+GWHu4K
         CBkyiYVKXvUH3hwZ0wa+4iG/kg1yjRohlIaMT+cgrckN7nLLSySjg/nSSCgIY30l8WrR
         McAPZ9sV6VQ2K12G9WabbYNra6JeugiIIn/UIJ4Tb6cXW886ObmSp1P6CFcQZF3z2eDG
         3wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u1emP74LMR8/SvGoouwH++0x/p6OWG+7EYKvBz2UYg8=;
        b=Se9vVBiQItWsxilqc7JKE0xgfKER/cEPNToBmaiJS299i+va4ioMw0c9RFh6ERLMWU
         +toJYGSuX3RnSLQb9cwVsFkHaMfP9K3VnzdQczcBQNfs83oTvguMEBc1uyd3227nfikw
         Gp5Piv1wLlGKYbM7bctF18f661EtuGA1SHDfNYjG+rrSKww7sh8ZV4bFORCVQaknLbgC
         GVxO2VK1m7XkzjVkgY9mMky+k59ochKkW4lEeiqIgpComSfaJMwA5UwJPPW94wgehj8T
         MKQGwkMt0vw6465pNREe1x8SRsjJicOOS5CS4hg7rpnRSFfMzXEg+Qf1KLdzhtG2N9F6
         aZ9w==
X-Gm-Message-State: AOAM532hIoAJda0bwTpUHajadviGlQY0wMbZJnZ0bMLayeM7NDRg/nJv
        ZxcojLJTjxZ701hxHgqudYCNqQ==
X-Google-Smtp-Source: ABdhPJyZjIHKYWT4pQlfal1tLcBol+nlDGLcHvkF/ANdHRtITNxC1BrufddcAkjHys1sUUpuIxkwlg==
X-Received: by 2002:a5d:4a0c:: with SMTP id m12mr43634922wrq.27.1634640261228;
        Tue, 19 Oct 2021 03:44:21 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:c590:9206:d20a:23bd? ([2a01:e34:ed2f:f020:c590:9206:d20a:23bd])
        by smtp.googlemail.com with ESMTPSA id h11sm14071179wrz.5.2021.10.19.03.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 03:44:20 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] thermal: mediatek: add MT8365 thermal driver
 support
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, fparent@baylibre.com,
        khilman@baylibre.com
References: <20211019093404.1913357-1-msp@baylibre.com>
 <20211019093404.1913357-5-msp@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d796b9ea-210a-1385-8823-f697b7ac7fa7@linaro.org>
Date:   Tue, 19 Oct 2021 12:44:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211019093404.1913357-5-msp@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19/10/2021 11:34, Markus Schneider-Pargmann wrote:
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
> 
> Notes:
>     Changes v1 -> v2:
>     - Use of ARRAY_SIZE to avoid NUM macros.
>     - Remove (void*) cast.
>     - Use macros for mt7622 buffer_ctl operations.
> 
>  drivers/thermal/mtk_thermal.c | 90 ++++++++++++++++++++++++++++++++---
>  1 file changed, 84 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index af6cd11eb221..fc4ea58d00ec 100644
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
> @@ -212,6 +213,8 @@ enum mtk_thermal_version {
>  #define MT7622_NUM_SENSORS_PER_ZONE	1
>  #define MT7622_TS1	0
>  #define MT7622_NUM_CONTROLLER		1
> +#define MT7622_BUFFER_CTL_MASK		~0x37
> +#define MT7622_BUFFER_CTL_SET		0x1
>  
>  /* The maximum number of banks */
>  #define MAX_NUM_ZONES		8
> @@ -245,6 +248,14 @@ enum mtk_thermal_version {
>  /* The calibration coefficient of sensor  */
>  #define MT8183_CALIBRATION	153
>  
> +/* MT8365 */
> +#define MT8365_TEMP_AUXADC_CHANNEL 11
> +#define MT8365_CALIBRATION 164
> +#define MT8365_NUM_BANKS 1
> +#define MT8365_TS1 0
> +#define MT8365_TS2 1
> +#define MT8365_TS3 2
> +
>  struct mtk_thermal;
>  
>  struct thermal_bank_cfg {
> @@ -271,6 +282,9 @@ struct mtk_thermal_data {
>  	bool need_switch_bank;
>  	struct thermal_bank_cfg bank_data[MAX_NUM_ZONES];
>  	enum mtk_thermal_version version;
> +	u32 apmixed_buffer_ctl_reg;
> +	u32 apmixed_buffer_ctl_mask;
> +	u32 apmixed_buffer_ctl_set;
>  };
>  
>  struct mtk_thermal {
> @@ -386,6 +400,25 @@ static const int mt7622_mux_values[MT7622_NUM_SENSORS] = { 0, };
>  static const int mt7622_vts_index[MT7622_NUM_SENSORS] = { VTS1 };
>  static const int mt7622_tc_offset[MT7622_NUM_CONTROLLER] = { 0x0, };
>  
> +/* MT8365 thermal sensor data */
> +static const int mt8365_bank_data[] = {
> +	MT8365_TS1, MT8365_TS2, MT8365_TS3
> +};
> +
> +static const int mt8365_msr[ARRAY_SIZE(mt8365_bank_data)] = {
> +	TEMP_MSR0, TEMP_MSR1, TEMP_MSR2
> +};
> +
> +static const int mt8365_adcpnp[ARRAY_SIZE(mt8365_bank_data)] = {
> +	TEMP_ADCPNP0, TEMP_ADCPNP1, TEMP_ADCPNP2
> +};
> +
> +static const int mt8365_mux_values[ARRAY_SIZE(mt8365_bank_data)] = { 0, 1, 2 };

This portion of declaration shows it should be *one* array of structures :/

This comment applies for all the existing code.

TBH, I think the code could be simplified and consolidated in this
driver. But that would be out of the scope of your changes as I
understand you are sticking to the current implementation.


> +static const int mt8365_tc_offset[] = { 0 };

0x0, to be consistent with the rest of the code.

> +
> +static const int mt8365_vts_index[ARRAY_SIZE(mt8365_bank_data)] = { VTS1, VTS2,
> +								    VTS3 };
> +
>  /*
>   * The MT8173 thermal controller has four banks. Each bank can read up to
>   * four temperature sensors simultaneously. The MT8173 has a total of 5
> @@ -460,6 +493,39 @@ static const struct mtk_thermal_data mt2701_thermal_data = {
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
> +	.num_sensors = ARRAY_SIZE(mt8365_bank_data),
> +	.vts_index = mt8365_vts_index,
> +	.cali_val = MT8365_CALIBRATION,
> +	.num_controller = ARRAY_SIZE(mt8365_tc_offset),
> +	.controller_offset = mt8365_tc_offset,
> +	.need_switch_bank = false,
> +	.bank_data = {
> +		{
> +			.num_sensors = ARRAY_SIZE(mt8365_bank_data),
> +			.sensors = mt8365_bank_data
> +		},
> +	},
> +	.msr = mt8365_msr,
> +	.adcpnp = mt8365_adcpnp,
> +	.sensor_mux_values = mt8365_mux_values,
> +	.version = MTK_THERMAL_V1,
> +	.apmixed_buffer_ctl_reg = APMIXED_SYS_TS_CON0,
> +	.apmixed_buffer_ctl_mask = ~(u32)GENMASK(29, 28),
> +};
>
>  /*
>   * The MT2712 thermal controller has one bank, which can read up to
>   * four temperature sensors simultaneously. The MT2712 has a total of 4
> @@ -514,6 +580,9 @@ static const struct mtk_thermal_data mt7622_thermal_data = {
>  	.adcpnp = mt7622_adcpnp,
>  	.sensor_mux_values = mt7622_mux_values,
>  	.version = MTK_THERMAL_V2,
> +	.apmixed_buffer_ctl_reg = APMIXED_SYS_TS_CON1,
> +	.apmixed_buffer_ctl_mask = MT7622_BUFFER_CTL_MASK,
> +	.apmixed_buffer_ctl_set = MT7622_BUFFER_CTL_SET,
>  };
>  
>  /*
> @@ -958,19 +1027,27 @@ static const struct of_device_id mtk_thermal_of_match[] = {
>  	{
>  		.compatible = "mediatek,mt8183-thermal",
>  		.data = &mt8183_thermal_data,
> +	},
> +	{
> +		.compatible = "mediatek,mt8365-thermal",
> +		.data = &mt8365_thermal_data,
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
> +	writel(tmp, apmixed_base + mt->conf->apmixed_buffer_ctl_reg);
>  	udelay(200);
>  }
>  
> @@ -1070,8 +1147,9 @@ static int mtk_thermal_probe(struct platform_device *pdev)
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
