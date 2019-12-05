Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0BA113FAA
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 11:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfLEKue (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 05:50:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51135 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbfLEKue (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 05:50:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so3152328wmg.0
        for <linux-pm@vger.kernel.org>; Thu, 05 Dec 2019 02:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pT++TqauxyCFz9tAUYcLNna94CTe8VQ//Ra/f4Yk86Q=;
        b=Ch/su0YNxkXux3HtXfPs9R0bVIlgEcD15Dr6tGs5aD+k6wkdUeX/7LkXfMHycsiPFU
         nuadpEJO851DlbZwifXdLJhGLp/DJg+5XDTXCAjcC4aYV3HzGBZUdxB5XnENc7aJULjl
         ZjdpVJ0ua7wIkWGLV+GuYkWdHJ3ztb2yLBv6q3Mo9OSTGXhZqEgucpEuPz0HeOIl2sfi
         gigk6y1fh8epbrfkrh5M/4bGUWrHu27VgUS5KCBV/8VvfCz8y9ZsIeuZEG1ohL6MhZH7
         yxG1FbX1nay/XRj8lN8zSFs+x0gesjZLnWlJ6aKrGIzL/HRg2XYV6INrLlSW+0ihOJ5k
         1B9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pT++TqauxyCFz9tAUYcLNna94CTe8VQ//Ra/f4Yk86Q=;
        b=RRbq8GOAivsU4f0btxe2NG4BHIqpkZPGbI70p1MauMQ0vCxh6A5A88n49/Yguc1fbQ
         y2zmOTEvEMQRbkYqXCASFE/fVSqG57amsZdbg7h02terrhOj1EeXxxPA1vVqoV5wW2Tl
         eKIoGCCuX2/Vfu5RDMjhksQoPjzWSAFlKvcGUhOehofJY2yLmM6EcblGmpeOsCwqoNkW
         EdfqaSgi53Tok5JiMITKcm4Q+ZXQ4sXlmIoFUsDQnPLVh3/YFKM6zPz/bXJulFZSodWr
         C8JRc+jGis0JYGwtiZ0sTw2zbT/vBo4tlTrZ0GgB03dVAASpNaBTLSfbJj5Xl2wpqpIy
         ZvFQ==
X-Gm-Message-State: APjAAAVBM/uY+EQyR+j+M/9lCbmCWXbg+OGSgdDvcYtUnue1NO9loxqX
        5c8uYVeDe46cy2HnzpUnygnx8A==
X-Google-Smtp-Source: APXvYqw34KaZl6yNII7zPIR53mC8SGmbsUqLzYoIfJSMUbpDfVhXVy0Lq0d37NZcE+YBs8RkKJGkEw==
X-Received: by 2002:a1c:9e49:: with SMTP id h70mr4735351wme.79.1575543028696;
        Thu, 05 Dec 2019 02:50:28 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:24c3:ebb3:9dd5:81c6? ([2a01:e34:ed2f:f020:24c3:ebb3:9dd5:81c6])
        by smtp.googlemail.com with ESMTPSA id z18sm9792009wmf.21.2019.12.05.02.50.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 02:50:28 -0800 (PST)
Subject: Re: [PATCH v2 3/5] thermal: stm32: handle multiple trip points
To:     Pascal Paillet <p.paillet@st.com>, rui.zhang@intel.com,
        edubezval@gmail.com, amit.kucheria@verdurent.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        david.hernandezsanchez@st.com, horms+renesas@verge.net.au,
        wsa+renesas@sang-engineering.com, linux-pm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191104133020.8820-1-p.paillet@st.com>
 <20191104133020.8820-4-p.paillet@st.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <fe6fa356-eef2-aeb7-b746-383feb31fee1@linaro.org>
Date:   Thu, 5 Dec 2019 11:50:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191104133020.8820-4-p.paillet@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



Hi Pascal,

On 04/11/2019 14:30, Pascal Paillet wrote:
> Let the thermal framework handle the trip points instead
> of custom code inside the driver. This leads to remove a lot
> of code and simplifies the driver.
> Implement set_trips callback to set the low and high thresholds,
> modify irq enable and disable to handle those thresholds.

there are a lot of changes in this patch, please split it into smaller
pieces with a good description.

Thanks


> Signed-off-by: Pascal Paillet <p.paillet@st.com>
> ---
>  drivers/thermal/st/stm_thermal.c | 283 +++++++++++--------------------
>  1 file changed, 95 insertions(+), 188 deletions(-)
> 
> diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
> index 7577242dadb4..cb72252f2800 100644
> --- a/drivers/thermal/st/stm_thermal.c
> +++ b/drivers/thermal/st/stm_thermal.c
> @@ -51,10 +51,17 @@
>  /* DTS_DR register mask definitions */
>  #define TS1_MFREQ_MASK		GENMASK(15, 0)
>  
> +/* DTS_ITENR register mask definitions */
> +#define ITENR_MASK		(GENMASK(2, 0) | GENMASK(6, 4))
> +
> +/* DTS_ICIFR register mask definitions */
> +#define ICIFR_MASK		(GENMASK(2, 0) | GENMASK(6, 4))
> +
>  /* Less significant bit position definitions */
>  #define TS1_T0_POS		16
>  #define TS1_SMP_TIME_POS	16
>  #define TS1_HITTHD_POS		16
> +#define TS1_LITTHD_POS		0
>  #define HSREF_CLK_DIV_POS	24
>  
>  /* DTS_CFGR1 bit definitions */
> @@ -91,32 +98,28 @@ struct stm_thermal_sensor {
>  	struct thermal_zone_device *th_dev;
>  	enum thermal_device_mode mode;
>  	struct clk *clk;
> -	int high_temp;
> -	int low_temp;
> -	int temp_critical;
> -	int temp_passive;
>  	unsigned int low_temp_enabled;
> -	int num_trips;
> +	unsigned int high_temp_enabled;
>  	int irq;
>  	void __iomem *base;
>  	int t0, fmt0, ramp_coeff;
>  };
>  
> +static int stm_enable_irq(struct stm_thermal_sensor *sensor);
> +

Move the function instead of adding a declaration.

>  static irqreturn_t stm_thermal_alarm_irq_thread(int irq, void *sdata)
>  {
> -	u32 value;
>  	struct stm_thermal_sensor *sensor = sdata;
>  
> -	/* read IT reason in SR and clear flags */
> -	value = readl_relaxed(sensor->base + DTS_SR_OFFSET);
> +	dev_dbg(sensor->dev, "sr:%d\n",
> +		readl_relaxed(sensor->base + DTS_SR_OFFSET));
>  
> -	if ((value & LOW_THRESHOLD) == LOW_THRESHOLD)
> -		writel_relaxed(LOW_THRESHOLD, sensor->base + DTS_ICIFR_OFFSET);
> +	thermal_zone_device_update(sensor->th_dev, THERMAL_EVENT_UNSPECIFIED);
>  
> -	if ((value & HIGH_THRESHOLD) == HIGH_THRESHOLD)
> -		writel_relaxed(HIGH_THRESHOLD, sensor->base + DTS_ICIFR_OFFSET);
> +	stm_enable_irq(sensor);
>  
> -	thermal_zone_device_update(sensor->th_dev, THERMAL_EVENT_UNSPECIFIED);
> +	/* Acknoledge all DTS irqs */
> +	writel_relaxed(ICIFR_MASK, sensor->base + DTS_ICIFR_OFFSET);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -149,6 +152,8 @@ static int stm_sensor_power_on(struct stm_thermal_sensor *sensor)
>  	writel_relaxed(value, sensor->base +
>  		       DTS_CFGR1_OFFSET);
>  
> +	sensor->mode = THERMAL_DEVICE_ENABLED;
> +
>  	return 0;
>  }
>  
> @@ -156,6 +161,8 @@ static int stm_sensor_power_off(struct stm_thermal_sensor *sensor)
>  {
>  	u32 value;
>  
> +	sensor->mode = THERMAL_DEVICE_DISABLED;
> +
>  	/* Stop measuring */
>  	value = readl_relaxed(sensor->base + DTS_CFGR1_OFFSET);
>  	value &= ~TS1_START;
> @@ -277,50 +284,15 @@ static int stm_thermal_calculate_threshold(struct stm_thermal_sensor *sensor,
>  	return 0;
>  }
>  
> -static int stm_thermal_set_threshold(struct stm_thermal_sensor *sensor)
> -{
> -	u32 value, th;
> -	int ret;
> -
> -	value = readl_relaxed(sensor->base + DTS_ITR1_OFFSET);
> -
> -	/* Erase threshold content */
> -	value &= ~(TS1_LITTHD_MASK | TS1_HITTHD_MASK);
> -
> -	/* Retrieve the sample threshold number th for a given temperature */
> -	ret = stm_thermal_calculate_threshold(sensor, sensor->high_temp, &th);
> -	if (ret)
> -		return ret;
> -
> -	value |= th & TS1_LITTHD_MASK;
> -
> -	if (sensor->low_temp_enabled) {
> -		/* Retrieve the sample threshold */
> -		ret = stm_thermal_calculate_threshold(sensor, sensor->low_temp,
> -						      &th);
> -		if (ret)
> -			return ret;
> -
> -		value |= (TS1_HITTHD_MASK  & (th << TS1_HITTHD_POS));
> -	}
> -
> -	/* Write value on the Low interrupt threshold */
> -	writel_relaxed(value, sensor->base + DTS_ITR1_OFFSET);
> -
> -	return 0;
> -}
> -
>  /* Disable temperature interrupt */
>  static int stm_disable_irq(struct stm_thermal_sensor *sensor)
>  {
>  	u32 value;
>  
> -	/* Disable IT generation for low and high thresholds */
> +	/* Disable IT generation */
>  	value = readl_relaxed(sensor->base + DTS_ITENR_OFFSET);
> -	writel_relaxed(value & ~(LOW_THRESHOLD | HIGH_THRESHOLD),
> -		       sensor->base + DTS_ITENR_OFFSET);
> -
> -	dev_dbg(sensor->dev, "%s: IT disabled on sensor side", __func__);
> +	value &= ~ITENR_MASK;
> +	writel_relaxed(value, sensor->base + DTS_ITENR_OFFSET);
>  
>  	return 0;
>  }
> @@ -330,62 +302,67 @@ static int stm_enable_irq(struct stm_thermal_sensor *sensor)
>  {
>  	u32 value;
>  
> -	/*
> -	 * Code below enables High temperature threshold using a low threshold
> -	 * sampling value
> -	 */
> -
> -	/* Make sure LOW_THRESHOLD IT is clear before enabling */
> -	writel_relaxed(LOW_THRESHOLD, sensor->base + DTS_ICIFR_OFFSET);
> +	dev_dbg(sensor->dev, "low:%d high:%d\n", sensor->low_temp_enabled,
> +		sensor->high_temp_enabled);
>  
> -	/* Enable IT generation for low threshold */
> +	/* Disable IT generation for low and high thresholds */
>  	value = readl_relaxed(sensor->base + DTS_ITENR_OFFSET);
> -	value |= LOW_THRESHOLD;
> -
> -	/* Enable the low temperature threshold if needed */
> -	if (sensor->low_temp_enabled) {
> -		/* Make sure HIGH_THRESHOLD IT is clear before enabling */
> -		writel_relaxed(HIGH_THRESHOLD, sensor->base + DTS_ICIFR_OFFSET);
> +	value &= ~(LOW_THRESHOLD | HIGH_THRESHOLD);
>  
> -		/* Enable IT generation for high threshold */
> +	if (sensor->low_temp_enabled)
>  		value |= HIGH_THRESHOLD;
> -	}
>  
> -	/* Enable thresholds */
> -	writel_relaxed(value, sensor->base + DTS_ITENR_OFFSET);
> +	if (sensor->high_temp_enabled)
> +		value |= LOW_THRESHOLD;
>  
> -	dev_dbg(sensor->dev, "%s: IT enabled on sensor side", __func__);
> +	/* Enable interrupts */
> +	writel_relaxed(value, sensor->base + DTS_ITENR_OFFSET);
>  
>  	return 0;
>  }
>  
> -static int stm_thermal_update_threshold(struct stm_thermal_sensor *sensor)
> +static int stm_thermal_set_trips(void *data, int low, int high)
>  {
> +	struct stm_thermal_sensor *sensor = data;
> +	u32 itr1, th;
>  	int ret;
>  
> -	sensor->mode = THERMAL_DEVICE_DISABLED;
> +	dev_dbg(sensor->dev, "set trips %d <--> %d\n", low, high);
>  
> -	ret = stm_sensor_power_off(sensor);
> -	if (ret)
> -		return ret;
> +	/* Erase threshold content */
> +	itr1 = readl_relaxed(sensor->base + DTS_ITR1_OFFSET);
> +	itr1 &= ~(TS1_LITTHD_MASK | TS1_HITTHD_MASK);
>  
> -	ret = stm_disable_irq(sensor);
> -	if (ret)
> -		return ret;
> +	/*
> +	 * Disable low-temp if "low" is too small. As per thermal framework
> +	 * API, we use -INT_MAX rather than INT_MIN.
> +	 */
>  
> -	ret = stm_thermal_set_threshold(sensor);
> -	if (ret)
> -		return ret;
> +	if (low > -INT_MAX) {
> +		sensor->low_temp_enabled = 1;
> +		ret = stm_thermal_calculate_threshold(sensor, low, &th);
> +		if (ret)
> +			return ret;
>  
> -	ret = stm_enable_irq(sensor);
> -	if (ret)
> -		return ret;
> +		itr1 |= (TS1_HITTHD_MASK  & (th << TS1_HITTHD_POS));
> +	} else {
> +		sensor->low_temp_enabled = 0;
> +	}
>  
> -	ret = stm_sensor_power_on(sensor);
> -	if (ret)
> -		return ret;
> +	/* Disable high-temp if "high" is too big. */
> +	if (high < INT_MAX) {
> +		sensor->high_temp_enabled = 1;
> +		ret = stm_thermal_calculate_threshold(sensor, high, &th);
> +		if (ret)
> +			return ret;
>  
> -	sensor->mode = THERMAL_DEVICE_ENABLED;
> +		itr1 |= (TS1_LITTHD_MASK  & (th << TS1_LITTHD_POS));
> +	} else {
> +		sensor->high_temp_enabled = 0;
> +	}
> +
> +	/* Write new threshod values*/
> +	writel_relaxed(itr1, sensor->base + DTS_ITR1_OFFSET);
>  
>  	return 0;
>  }
> @@ -429,32 +406,6 @@ static int stm_thermal_get_temp(void *data, int *temp)
>  	*temp = mcelsius(sensor->t0 + ((freqM - sensor->fmt0) /
>  			 sensor->ramp_coeff));
>  
> -	dev_dbg(sensor->dev, "%s: temperature = %d millicelsius",
> -		__func__, *temp);
> -
> -	/* Update thresholds */
> -	if (sensor->num_trips > 1) {
> -		/* Update alarm threshold value to next higher trip point */
> -		if (sensor->high_temp == sensor->temp_passive &&
> -		    celsius(*temp) >= sensor->temp_passive) {
> -			sensor->high_temp = sensor->temp_critical;
> -			sensor->low_temp = sensor->temp_passive;
> -			sensor->low_temp_enabled = true;
> -			ret = stm_thermal_update_threshold(sensor);
> -			if (ret)
> -				return ret;
> -		}
> -
> -		if (sensor->high_temp == sensor->temp_critical &&
> -		    celsius(*temp) < sensor->temp_passive) {
> -			sensor->high_temp = sensor->temp_passive;
> -			sensor->low_temp_enabled = false;
> -			ret = stm_thermal_update_threshold(sensor);
> -			if (ret)
> -				return ret;
> -		}
> -	}
> -
>  	return 0;
>  }
>  
> @@ -491,6 +442,8 @@ static int stm_thermal_sensor_off(struct stm_thermal_sensor *sensor)
>  {
>  	int ret;
>  
> +	stm_disable_irq(sensor);
> +
>  	ret = stm_sensor_power_off(sensor);
>  	if (ret)
>  		return ret;
> @@ -503,7 +456,6 @@ static int stm_thermal_sensor_off(struct stm_thermal_sensor *sensor)
>  static int stm_thermal_prepare(struct stm_thermal_sensor *sensor)
>  {
>  	int ret;
> -	struct device *dev = sensor->dev;
>  
>  	ret = clk_prepare_enable(sensor->clk);
>  	if (ret)
> @@ -517,26 +469,8 @@ static int stm_thermal_prepare(struct stm_thermal_sensor *sensor)
>  	if (ret)
>  		goto thermal_unprepare;
>  
> -	/* Set threshold(s) for IRQ */
> -	ret = stm_thermal_set_threshold(sensor);
> -	if (ret)
> -		goto thermal_unprepare;
> -
> -	ret = stm_enable_irq(sensor);
> -	if (ret)
> -		goto thermal_unprepare;
> -
> -	ret = stm_sensor_power_on(sensor);
> -	if (ret) {
> -		dev_err(dev, "%s: failed to power on sensor\n", __func__);
> -		goto irq_disable;
> -	}
> -
>  	return 0;
>  
> -irq_disable:
> -	stm_disable_irq(sensor);
> -
>  thermal_unprepare:
>  	clk_disable_unprepare(sensor->clk);
>  
> @@ -553,8 +487,6 @@ static int stm_thermal_suspend(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> -	sensor->mode = THERMAL_DEVICE_DISABLED;
> -
>  	return 0;
>  }
>  
> @@ -567,7 +499,12 @@ static int stm_thermal_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> -	sensor->mode = THERMAL_DEVICE_ENABLED;
> +	ret = stm_sensor_power_on(sensor);
> +	if (ret)
> +		return ret;
> +
> +	thermal_zone_device_update(sensor->th_dev, THERMAL_EVENT_UNSPECIFIED);
> +	stm_enable_irq(sensor);
>  
>  	return 0;
>  }
> @@ -577,6 +514,7 @@ SIMPLE_DEV_PM_OPS(stm_thermal_pm_ops, stm_thermal_suspend, stm_thermal_resume);
>  
>  static const struct thermal_zone_of_device_ops stm_tz_ops = {
>  	.get_temp	= stm_thermal_get_temp,
> +	.set_trips	= stm_thermal_set_trips,
>  };
>  
>  static const struct of_device_id stm_thermal_of_match[] = {
> @@ -589,9 +527,8 @@ static int stm_thermal_probe(struct platform_device *pdev)
>  {
>  	struct stm_thermal_sensor *sensor;
>  	struct resource *res;
> -	const struct thermal_trip *trip;
>  	void __iomem *base;
> -	int ret, i;
> +	int ret;
>  
>  	if (!pdev->dev.of_node) {
>  		dev_err(&pdev->dev, "%s: device tree node not found\n",
> @@ -622,10 +559,23 @@ static int stm_thermal_probe(struct platform_device *pdev)
>  		return PTR_ERR(sensor->clk);
>  	}
>  
> -	/* Register IRQ into GIC */
> -	ret = stm_register_irq(sensor);
> -	if (ret)
> +	stm_disable_irq(sensor);
> +
> +	/* Clear irq flags */
> +	writel_relaxed(ICIFR_MASK, sensor->base + DTS_ICIFR_OFFSET);
> +
> +	/* Configure and enable HW sensor */
> +	ret = stm_thermal_prepare(sensor);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Error preprare sensor: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = stm_sensor_power_on(sensor);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Error power on sensor: %d\n", ret);
>  		return ret;
> +	}
>  
>  	sensor->th_dev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0,
>  							      sensor,
> @@ -638,53 +588,12 @@ static int stm_thermal_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	if (!sensor->th_dev->ops->get_crit_temp) {
> -		/* Critical point must be provided */
> -		ret = -EINVAL;
> -		goto err_tz;
> -	}
> -
> -	ret = sensor->th_dev->ops->get_crit_temp(sensor->th_dev,
> -			&sensor->temp_critical);
> -	if (ret) {
> -		dev_err(&pdev->dev,
> -			"Not able to read critical_temp: %d\n", ret);
> +	/* Register IRQ into GIC */
> +	ret = stm_register_irq(sensor);
> +	if (ret)
>  		goto err_tz;
> -	}
> -
> -	sensor->temp_critical = celsius(sensor->temp_critical);
> -
> -	/* Set thresholds for IRQ */
> -	sensor->high_temp = sensor->temp_critical;
> -
> -	trip = of_thermal_get_trip_points(sensor->th_dev);
> -	sensor->num_trips = of_thermal_get_ntrips(sensor->th_dev);
> -
> -	/* Find out passive temperature if it exists */
> -	for (i = (sensor->num_trips - 1); i >= 0;  i--) {
> -		if (trip[i].type == THERMAL_TRIP_PASSIVE) {
> -			sensor->temp_passive = celsius(trip[i].temperature);
> -			/* Update high temperature threshold */
> -			sensor->high_temp = sensor->temp_passive;
> -			}
> -	}
> -
> -	/*
> -	 * Ensure low_temp_enabled flag is disabled.
> -	 * By disabling low_temp_enabled, low threshold IT will not be
> -	 * configured neither enabled because it is not needed as high
> -	 * threshold is set on the lowest temperature trip point after
> -	 * probe.
> -	 */
> -	sensor->low_temp_enabled = false;
>  
> -	/* Configure and enable HW sensor */
> -	ret = stm_thermal_prepare(sensor);
> -	if (ret) {
> -		dev_err(&pdev->dev,
> -			"Not able to enable sensor: %d\n", ret);
> -		goto err_tz;
> -	}
> +	stm_enable_irq(sensor);
>  
>  	/*
>  	 * Thermal_zone doesn't enable hwmon as default,
> @@ -695,8 +604,6 @@ static int stm_thermal_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_tz;
>  
> -	sensor->mode = THERMAL_DEVICE_ENABLED;
> -
>  	dev_info(&pdev->dev, "%s: Driver initialized successfully\n",
>  		 __func__);
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

