Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5C443345F
	for <lists+linux-pm@lfdr.de>; Tue, 19 Oct 2021 13:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbhJSLHR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 07:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235531AbhJSLHK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 07:07:10 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2D4C061746
        for <linux-pm@vger.kernel.org>; Tue, 19 Oct 2021 04:04:49 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id d198-20020a1c1dcf000000b00322f53b9b89so2694719wmd.0
        for <linux-pm@vger.kernel.org>; Tue, 19 Oct 2021 04:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CN/Dv/6YKgAeJCJI90wMy0Tdo+rJz4ywym+xK0hXggo=;
        b=duggVdUJFiCRdR5CntOD0hhuCZWwSEbeyStMXPL5gwVl/9dkSoekIY0hx7nQgdnFXx
         tEwhASQVAoctPS1RK4pCYinTaKXNqFIvSnQC/hh1UmD9eMq8xQUcTCPTdUfJdnt9WuUX
         icSV1bRV8iCAa69LPSCTUWFj7rQr8BZOG1+9b3bywMnJHDsjr83+54i43U/gXJWhiJJh
         hLyHPXQGp/kAQla0Y5ugx/SWlqzsxwOCSmHHGBH1m7Nz+zaHKRxNKvNO08lo7qtJAM5J
         38/ZTuExHfXJTnTAhJi+ntuORbGfEmyIhHrAAkHEmSqLOSzpzC0Ae1D27kSnALZ4pptz
         /YAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CN/Dv/6YKgAeJCJI90wMy0Tdo+rJz4ywym+xK0hXggo=;
        b=4I2oX878iMUv9Si83XbkmbWAxREOfdHDwwVqyVAGsfrM4lwrqkqP1/zUwfjgI8mJuE
         VaxavQDIHatJyRyFrW9SLSgFQ+HHM+nKahwEFDVEQAVTpsqm9MkzJ4tQZHJt53pWZ1N8
         pj/XjQwGkPZHXS/18tLbFGHTKjc3fKpsnGKYYZc5BnrWjdfBdmS6iJknqQA/55wobICS
         ++TEB9xRNSInM+6rHNCW8AP8ZlSjkFfx9a6Wbhjc+eLp7gujNmIFQYgNMa2Trf9+Dgv7
         4v2X/RDuUdCItHykuh9fXjPXANyPlQrClAA/wCWqg6lVYzIQ+G6WqBO4rl/NlXGEl3TJ
         P19g==
X-Gm-Message-State: AOAM532sKRCjwKf1jfgeHBgzfH8iWPe+fxK4oFVmPt1qrss3RdDu5Zah
        UOL2PH2n0uRTHtrxHmiXwPF9CQ==
X-Google-Smtp-Source: ABdhPJyMmIrLWdpEFKzPt947QN9m+CxjJXudkw85sGlwfvTuG9BCcPh5I7OwznrE9eE4gBJl5PsH+g==
X-Received: by 2002:a05:600c:ac1:: with SMTP id c1mr5232929wmr.99.1634641488060;
        Tue, 19 Oct 2021 04:04:48 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:c590:9206:d20a:23bd? ([2a01:e34:ed2f:f020:c590:9206:d20a:23bd])
        by smtp.googlemail.com with ESMTPSA id a63sm1912233wmd.34.2021.10.19.04.04.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 04:04:47 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] thermal: imx: implement runtime PM support
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, David Jander <david@protonic.nl>,
        Petr Benes <petrben@gmail.com>
References: <20210924115032.29684-1-o.rempel@pengutronix.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <19b2ab33-aa56-75fb-f6ef-3c928be9c50c@linaro.org>
Date:   Tue, 19 Oct 2021 13:04:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210924115032.29684-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24/09/2021 13:50, Oleksij Rempel wrote:
> Starting with commit d92ed2c9d3ff ("thermal: imx: Use driver's local
> data to decide whether to run a measurement") this driver stared using
> irq_enabled flag to make decision to power on/off the thermal core. This
> triggered a regression, where after reaching critical temperature, alarm
> IRQ handler set irq_enabled to false,  disabled thermal core and was not
> able read temperature and disable cooling sequence.
> 
> In case the cooling device is "CPU/GPU freq", the system will run with
> reduce performance until next reboot.
> 
> To solve this issue, we need to move all parts implementing hand made
> runtime power management and let it handle actual runtime PM framework.
> 
> Fixes: d92ed2c9d3ff ("thermal: imx: Use driver's local data to decide whether to run a measurement")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thanks for this fix.

Petr or Oleksij,

could you confirm it is tested and working without CONFIG_PM ?

> ---
>  drivers/thermal/imx_thermal.c | 145 +++++++++++++++++++++-------------
>  1 file changed, 91 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index 2c7473d86a59..1db7ce6221b1 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -15,6 +15,7 @@
>  #include <linux/regmap.h>
>  #include <linux/thermal.h>
>  #include <linux/nvmem-consumer.h>
> +#include <linux/pm_runtime.h>
>  
>  #define REG_SET		0x4
>  #define REG_CLR		0x8
> @@ -194,6 +195,7 @@ static struct thermal_soc_data thermal_imx7d_data = {
>  };
>  
>  struct imx_thermal_data {
> +	struct device *dev;
>  	struct cpufreq_policy *policy;
>  	struct thermal_zone_device *tz;
>  	struct thermal_cooling_device *cdev;
> @@ -252,44 +254,15 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
>  	const struct thermal_soc_data *soc_data = data->socdata;
>  	struct regmap *map = data->tempmon;
>  	unsigned int n_meas;
> -	bool wait, run_measurement;
>  	u32 val;
> +	int ret;
>  
> -	run_measurement = !data->irq_enabled;
> -	if (!run_measurement) {
> -		/* Check if a measurement is currently in progress */
> -		regmap_read(map, soc_data->temp_data, &val);
> -		wait = !(val & soc_data->temp_valid_mask);
> -	} else {
> -		/*
> -		 * Every time we measure the temperature, we will power on the
> -		 * temperature sensor, enable measurements, take a reading,
> -		 * disable measurements, power off the temperature sensor.
> -		 */
> -		regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
> -			    soc_data->power_down_mask);
> -		regmap_write(map, soc_data->sensor_ctrl + REG_SET,
> -			    soc_data->measure_temp_mask);
> -
> -		wait = true;
> -	}
> -
> -	/*
> -	 * According to the temp sensor designers, it may require up to ~17us
> -	 * to complete a measurement.
> -	 */
> -	if (wait)
> -		usleep_range(20, 50);
> +	ret = pm_runtime_resume_and_get(data->dev);
> +	if (ret < 0)
> +		return ret;
>  
>  	regmap_read(map, soc_data->temp_data, &val);
>  
> -	if (run_measurement) {
> -		regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
> -			     soc_data->measure_temp_mask);
> -		regmap_write(map, soc_data->sensor_ctrl + REG_SET,
> -			     soc_data->power_down_mask);
> -	}
> -
>  	if ((val & soc_data->temp_valid_mask) == 0) {
>  		dev_dbg(&tz->device, "temp measurement never finished\n");
>  		return -EAGAIN;
> @@ -328,6 +301,8 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
>  		enable_irq(data->irq);
>  	}
>  
> +	pm_runtime_put(data->dev);
> +
>  	return 0;
>  }
>  
> @@ -335,24 +310,16 @@ static int imx_change_mode(struct thermal_zone_device *tz,
>  			   enum thermal_device_mode mode)
>  {
>  	struct imx_thermal_data *data = tz->devdata;
> -	struct regmap *map = data->tempmon;
> -	const struct thermal_soc_data *soc_data = data->socdata;
>  
>  	if (mode == THERMAL_DEVICE_ENABLED) {
> -		regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
> -			     soc_data->power_down_mask);
> -		regmap_write(map, soc_data->sensor_ctrl + REG_SET,
> -			     soc_data->measure_temp_mask);
> +		pm_runtime_get(data->dev);
>  
>  		if (!data->irq_enabled) {
>  			data->irq_enabled = true;
>  			enable_irq(data->irq);
>  		}
>  	} else {
> -		regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
> -			     soc_data->measure_temp_mask);
> -		regmap_write(map, soc_data->sensor_ctrl + REG_SET,
> -			     soc_data->power_down_mask);
> +		pm_runtime_put(data->dev);
>  
>  		if (data->irq_enabled) {
>  			disable_irq(data->irq);
> @@ -393,6 +360,11 @@ static int imx_set_trip_temp(struct thermal_zone_device *tz, int trip,
>  			     int temp)
>  {
>  	struct imx_thermal_data *data = tz->devdata;
> +	int ret;
> +
> +	ret = pm_runtime_resume_and_get(data->dev);
> +	if (ret < 0)
> +		return ret;
>  
>  	/* do not allow changing critical threshold */
>  	if (trip == IMX_TRIP_CRITICAL)
> @@ -406,6 +378,8 @@ static int imx_set_trip_temp(struct thermal_zone_device *tz, int trip,
>  
>  	imx_set_alarm_temp(data, temp);
>  
> +	pm_runtime_put(data->dev);
> +
>  	return 0;
>  }
>  
> @@ -681,6 +655,8 @@ static int imx_thermal_probe(struct platform_device *pdev)
>  	if (!data)
>  		return -ENOMEM;
>  
> +	data->dev = &pdev->dev;
> +
>  	map = syscon_regmap_lookup_by_phandle(pdev->dev.of_node, "fsl,tempmon");
>  	if (IS_ERR(map)) {
>  		ret = PTR_ERR(map);
> @@ -801,6 +777,14 @@ static int imx_thermal_probe(struct platform_device *pdev)
>  	regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
>  		     data->socdata->measure_temp_mask);
>  
> +	/* the core was configured and enabled just before */
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(data->dev);
> +
> +	ret = pm_runtime_resume_and_get(data->dev);
> +	if (ret < 0)
> +		goto disable_runtime_pm;
> +
>  	data->irq_enabled = true;
>  	ret = thermal_zone_device_enable(data->tz);
>  	if (ret)
> @@ -814,10 +798,17 @@ static int imx_thermal_probe(struct platform_device *pdev)
>  		goto thermal_zone_unregister;
>  	}
>  
> +	ret = pm_runtime_put(data->dev);
> +	if (ret < 0)
> +		goto disable_runtime_pm;
> +
>  	return 0;
>  
>  thermal_zone_unregister:
>  	thermal_zone_device_unregister(data->tz);
> +disable_runtime_pm:
> +	pm_runtime_put_noidle(data->dev);
> +	pm_runtime_disable(data->dev);
>  clk_disable:
>  	clk_disable_unprepare(data->thermal_clk);
>  legacy_cleanup:
> @@ -829,13 +820,9 @@ static int imx_thermal_probe(struct platform_device *pdev)
>  static int imx_thermal_remove(struct platform_device *pdev)
>  {
>  	struct imx_thermal_data *data = platform_get_drvdata(pdev);
> -	struct regmap *map = data->tempmon;
>  
> -	/* Disable measurements */
> -	regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
> -		     data->socdata->power_down_mask);
> -	if (!IS_ERR(data->thermal_clk))
> -		clk_disable_unprepare(data->thermal_clk);
> +	pm_runtime_put_noidle(data->dev);
> +	pm_runtime_disable(data->dev);
>  
>  	thermal_zone_device_unregister(data->tz);
>  	imx_thermal_unregister_legacy_cooling(data);
> @@ -858,29 +845,79 @@ static int __maybe_unused imx_thermal_suspend(struct device *dev)
>  	ret = thermal_zone_device_disable(data->tz);
>  	if (ret)
>  		return ret;
> +
> +	return pm_runtime_force_suspend(data->dev);
> +}
> +
> +static int __maybe_unused imx_thermal_resume(struct device *dev)
> +{
> +	struct imx_thermal_data *data = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = pm_runtime_force_resume(data->dev);
> +	if (ret)
> +		return ret;
> +	/* Enabled thermal sensor after resume */
> +	return thermal_zone_device_enable(data->tz);
> +}
> +
> +static int __maybe_unused imx_thermal_runtime_suspend(struct device *dev)
> +{
> +	struct imx_thermal_data *data = dev_get_drvdata(dev);
> +	const struct thermal_soc_data *socdata = data->socdata;
> +	struct regmap *map = data->tempmon;
> +	int ret;
> +
> +	ret = regmap_write(map, socdata->sensor_ctrl + REG_CLR,
> +			   socdata->measure_temp_mask);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(map, socdata->sensor_ctrl + REG_SET,
> +			   socdata->power_down_mask);
> +	if (ret)
> +		return ret;
> +
>  	clk_disable_unprepare(data->thermal_clk);
>  
>  	return 0;
>  }
>  
> -static int __maybe_unused imx_thermal_resume(struct device *dev)
> +static int __maybe_unused imx_thermal_runtime_resume(struct device *dev)
>  {
>  	struct imx_thermal_data *data = dev_get_drvdata(dev);
> +	const struct thermal_soc_data *socdata = data->socdata;
> +	struct regmap *map = data->tempmon;
>  	int ret;
>  
>  	ret = clk_prepare_enable(data->thermal_clk);
>  	if (ret)
>  		return ret;
> -	/* Enabled thermal sensor after resume */
> -	ret = thermal_zone_device_enable(data->tz);
> +
> +	ret = regmap_write(map, socdata->sensor_ctrl + REG_CLR,
> +			   socdata->power_down_mask);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(map, socdata->sensor_ctrl + REG_SET,
> +			   socdata->measure_temp_mask);
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * According to the temp sensor designers, it may require up to ~17us
> +	 * to complete a measurement.
> +	 */
> +	usleep_range(20, 50);
> +
>  	return 0;
>  }
>  
> -static SIMPLE_DEV_PM_OPS(imx_thermal_pm_ops,
> -			 imx_thermal_suspend, imx_thermal_resume);
> +static const struct dev_pm_ops imx_thermal_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(imx_thermal_suspend, imx_thermal_resume)
> +	SET_RUNTIME_PM_OPS(imx_thermal_runtime_suspend,
> +			   imx_thermal_runtime_resume, NULL)
> +};
>  
>  static struct platform_driver imx_thermal = {
>  	.driver = {
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
