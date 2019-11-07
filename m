Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F175FF2536
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 03:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732954AbfKGCUj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Nov 2019 21:20:39 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46572 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfKGCUj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2019 21:20:39 -0500
Received: by mail-pf1-f196.google.com with SMTP id 193so1090000pfc.13
        for <linux-pm@vger.kernel.org>; Wed, 06 Nov 2019 18:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7nVUVPTizlGkprPOHGMGuKiTavG+4pamQJDarm5kvv0=;
        b=G4sld1CnF+WGUMEYhkeg7b2c/ddWHkENgd9t/sjURqESd/spTRn3DckkUV+ggVqpxs
         DX9+prVgoROWZ5ZTikOoUSh3NE/f56x4Np5XPl2GPeFRBsBi+riqR1pLcOWV0xUehBKf
         wmp5tm/wSCDSFyRRXxKDWl6js6NUHbeQ5AnxmEHoYGfK13eYs+rAXMrJjSP7M7pX2ldn
         i0v+116tgdd7LnHQ8iJ9Grkx8U7+zNxOumG3V2S6JaYKQm/sTmaVAi9KggcL62NTKoNH
         sKC2yS3w1LireYqKif9W7OwD+6eWDWBfqJVc/eB1HBlNPY0DLVBj4/tFqdZKKbhpfWpk
         /BoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7nVUVPTizlGkprPOHGMGuKiTavG+4pamQJDarm5kvv0=;
        b=cOx7g5ouy9bCJDLvSJ/sWZlj3qwifHQ2tVIznv4Fv1tgYMX+2eq22VCiVxZHImqEOQ
         nNC4ogZCef3q0YUgemmQj+e39CGlsTLSsNInC//n0J7p7JRrSHMwYYkYtskYpt/WvvlV
         5Q6XmIkzUzFZ/eOg7CUoTJ2HzURfSp1J7H0Bc+yvqXJ8DVl3ORNQP2bCzSR2sN2M+CVf
         n7WUBH4AtPRxlBfiXvI9niLj3nOh/2vooQcEi994OEq2NTJwYptedU5zGswg4AJIDBRr
         pzKyAV9IqOANGAPjKlc1NLeczF70PyVYreBi/s8RghPraWsLbgT0mlok1yQ8ZQDMOu2X
         seSA==
X-Gm-Message-State: APjAAAU3xz11Cam78ZC0ubbLHb+wkxm0rXNRws+/a4nOfs3I9csmAHQl
        x8wMaQVev+iEBB07Us2pqaZZjw==
X-Google-Smtp-Source: APXvYqwONm0UK9rYybGAoObi3hSqRbZAToeZCLsdFmnHfwr+0izG5T3e9gW6wi0eJH6dtm/LZyXAwg==
X-Received: by 2002:a17:90a:634c:: with SMTP id v12mr1614939pjs.27.1573093236794;
        Wed, 06 Nov 2019 18:20:36 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id w2sm342736pfj.22.2019.11.06.18.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 18:20:36 -0800 (PST)
Date:   Thu, 7 Nov 2019 07:50:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, edubezval@gmail.com,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Javi Merino <javi.merino@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jun Nie <jun.nie@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 07/11] thermal: rockchip: Appease the kernel-doc deity
Message-ID: <20191107022032.feqnv3gguywai6cj@vireshk-i7>
References: <cover.1573046440.git.amit.kucheria@linaro.org>
 <290895a22aa8a13c13b3a4ae77c13244b4ecee58.1573046440.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <290895a22aa8a13c13b3a4ae77c13244b4ecee58.1573046440.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-11-19, 18:58, Amit Kucheria wrote:
> Replace a comment starting with /** by simply /* to avoid having it
> interpreted as a kernel-doc comment. Describe missing function
> parameters where needed.
> 
> Fixes up the following warnings when compiled with make W=1:
> 
> linux.git/drivers/thermal/rockchip_thermal.c:27: warning: cannot
> understand function prototype: 'enum tshut_mode '
> linux.git/drivers/thermal/rockchip_thermal.c:37: warning: cannot
> understand function prototype: 'enum tshut_polarity '
> linux.git/drivers/thermal/rockchip_thermal.c:46: warning: cannot
> understand function prototype: 'enum sensor_id '
> linux.git/drivers/thermal/rockchip_thermal.c:56: warning: cannot
> understand function prototype: 'enum adc_sort_mode '
> linux.git/drivers/thermal/rockchip_thermal.c:123: warning: Function
> parameter or member 'chn_id' not described in 'rockchip_tsadc_chip'
> linux.git/drivers/thermal/rockchip_thermal.c:123: warning: Function
> parameter or member 'control' not described in 'rockchip_tsadc_chip'
> linux.git/drivers/thermal/rockchip_thermal.c:167: warning: Function
> parameter or member 'sensors' not described in 'rockchip_thermal_data'
> linux.git/drivers/thermal/rockchip_thermal.c:608: warning: Function
> parameter or member 'grf' not described in 'rk_tsadcv2_initialize'
> linux.git/drivers/thermal/rockchip_thermal.c:608: warning: Function
> parameter or member 'regs' not described in 'rk_tsadcv2_initialize'
> linux.git/drivers/thermal/rockchip_thermal.c:608: warning: Function
> parameter or member 'tshut_polarity' not described in
> 'rk_tsadcv2_initialize'
> linux.git/drivers/thermal/rockchip_thermal.c:644: warning: Function
> parameter or member 'grf' not described in 'rk_tsadcv3_initialize'
> linux.git/drivers/thermal/rockchip_thermal.c:644: warning: Function
> parameter or member 'regs' not described in 'rk_tsadcv3_initialize'
> linux.git/drivers/thermal/rockchip_thermal.c:644: warning: Function
> parameter or member 'tshut_polarity' not described in
> 'rk_tsadcv3_initialize'
> linux.git/drivers/thermal/rockchip_thermal.c:732: warning: Function
> parameter or member 'regs' not described in 'rk_tsadcv3_control'
> linux.git/drivers/thermal/rockchip_thermal.c:732: warning: Function
> parameter or member 'enable' not described in 'rk_tsadcv3_control'
> linux.git/drivers/thermal/rockchip_thermal.c:1211: warning: Function
> parameter or member 'reset' not described in
> 'rockchip_thermal_reset_controller'
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/rockchip_thermal.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index 343c2f5c5a259..9ed8085bb7924 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -19,7 +19,7 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/pinctrl/consumer.h>
>  
> -/**
> +/*
>   * If the temperature over a period of time High,
>   * the resulting TSHUT gave CRU module,let it reset the entire chip,
>   * or via GPIO give PMIC.
> @@ -29,7 +29,7 @@ enum tshut_mode {
>  	TSHUT_MODE_GPIO,
>  };
>  
> -/**
> +/*
>   * The system Temperature Sensors tshut(tshut) polarity
>   * the bit 8 is tshut polarity.
>   * 0: low active, 1: high active
> @@ -39,7 +39,7 @@ enum tshut_polarity {
>  	TSHUT_HIGH_ACTIVE,
>  };
>  
> -/**
> +/*
>   * The system has two Temperature Sensors.
>   * sensor0 is for CPU, and sensor1 is for GPU.
>   */
> @@ -48,7 +48,7 @@ enum sensor_id {
>  	SENSOR_GPU,
>  };
>  
> -/**
> +/*
>   * The conversion table has the adc value and temperature.
>   * ADC_DECREMENT: the adc value is of diminishing.(e.g. rk3288_code_table)
>   * ADC_INCREMENT: the adc value is incremental.(e.g. rk3368_code_table)
> @@ -80,13 +80,14 @@ struct chip_tsadc_table {
>  
>  /**
>   * struct rockchip_tsadc_chip - hold the private data of tsadc chip
> - * @chn_id[SOC_MAX_SENSORS]: the sensor id of chip correspond to the channel
> + * @chn_id: array of sensor ids of chip corresponding to the channel
>   * @chn_num: the channel number of tsadc chip
>   * @tshut_temp: the hardware-controlled shutdown temperature value
>   * @tshut_mode: the hardware-controlled shutdown mode (0:CRU 1:GPIO)
>   * @tshut_polarity: the hardware-controlled active polarity (0:LOW 1:HIGH)
>   * @initialize: SoC special initialize tsadc controller method
>   * @irq_ack: clear the interrupt
> + * @control: enable/disable method for the tsadc controller
>   * @get_temp: get the temperature
>   * @set_alarm_temp: set the high temperature interrupt
>   * @set_tshut_temp: set the hardware-controlled shutdown temperature
> @@ -139,7 +140,7 @@ struct rockchip_thermal_sensor {
>   * @chip: pointer to the platform/configuration data
>   * @pdev: platform device of thermal
>   * @reset: the reset controller of tsadc
> - * @sensors[SOC_MAX_SENSORS]: the thermal sensor
> + * @sensors: array of thermal sensors
>   * @clk: the controller clock is divided by the exteral 24MHz
>   * @pclk: the advanced peripherals bus clock
>   * @grf: the general register file will be used to do static set by software
> @@ -590,6 +591,9 @@ static int rk_tsadcv2_code_to_temp(const struct chip_tsadc_table *table,
>  
>  /**
>   * rk_tsadcv2_initialize - initialize TASDC Controller.
> + * @grf: the general register file will be used to do static set by software
> + * @regs: the base address of tsadc controller
> + * @tshut_polarity: the hardware-controlled active polarity (0:LOW 1:HIGH)
>   *
>   * (1) Set TSADC_V2_AUTO_PERIOD:
>   *     Configure the interleave between every two accessing of
> @@ -624,6 +628,9 @@ static void rk_tsadcv2_initialize(struct regmap *grf, void __iomem *regs,
>  
>  /**
>   * rk_tsadcv3_initialize - initialize TASDC Controller.
> + * @grf: the general register file will be used to do static set by software
> + * @regs: the base address of tsadc controller
> + * @tshut_polarity: the hardware-controlled active polarity (0:LOW 1:HIGH)
>   *
>   * (1) The tsadc control power sequence.
>   *
> @@ -723,6 +730,8 @@ static void rk_tsadcv2_control(void __iomem *regs, bool enable)
>  
>  /**
>   * rk_tsadcv3_control - the tsadc controller is enabled or disabled.
> + * @regs: the base address of tsadc controller
> + * @enable: boolean flag to enable the controller
>   *
>   * NOTE: TSADC controller works at auto mode, and some SoCs need set the
>   * tsadc_q_sel bit on TSADCV2_AUTO_CON[1]. The (1024 - tsadc_q) as output
> @@ -1206,6 +1215,7 @@ rockchip_thermal_register_sensor(struct platform_device *pdev,
>  
>  /**
>   * Reset TSADC Controller, reset all tsadc registers.
> + * @reset: the reset controller of tsadc
>   */
>  static void rockchip_thermal_reset_controller(struct reset_control *reset)
>  {

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
