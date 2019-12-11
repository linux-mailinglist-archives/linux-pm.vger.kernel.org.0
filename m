Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC29911AC24
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 14:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbfLKNfG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 08:35:06 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35368 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbfLKNfG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 08:35:06 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so2654707wmb.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2019 05:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vnmajKbayCHVlTrwrM/1cDM8n1pxfeJ84A7PeM73xww=;
        b=dQdEKHU6KM5UR2wF66a6qkhbblZ6utNr+M69nfCpDu/PF/L0B06XjPCNE4Kb0XWSnZ
         ddPrZn3mXUAMvk164xpZ+HFkixj260JKPxLOHsi71DEmwtfvGtwSeyjUr3FuhWxr5Hk6
         zUawx9ADRUiFie0Fi0kKP622AcuyEvbraody9SVRM7I85v5Iu5PO5uBbNhaoJ1GgR+aK
         6LVy9Dv6pB6r1A3Gg0NjF4JwYmwwENRNVM+QK1vIMwmWD5/uGis7/0h24si67dKFJMYh
         Uc0RDYCDPZXmd5T0OZOkD/VEQ2MjGTChNrTTCGAyU2VVKGz9JMQzF1Iekeaij3oRF9Zo
         GMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vnmajKbayCHVlTrwrM/1cDM8n1pxfeJ84A7PeM73xww=;
        b=KzoHtUGdGYJnsr6mSI/HCSLBUiwhcSSGz/SZYx6+hS+fKd4BzVLK/7NDdPEp0Zv9AM
         EhvxyZ1GDLYNHWFIoBESxA6qgcdoIq01cVdhEev3dUkNv/wNnwvWa3PnZqFLg08VT95j
         w0zaEW6PAlQwGgy5kgmW9qdFJ1iDbbqmOlMxlEi93wov5Vym/fCTpdQIEIVz6dKmUo6f
         NROCbHKBOZ42hQKx9I/buJaPr83mudJxIi8YvXmiTmEoqWVGMiCveBQygTASHpEsFvVU
         CmcGLxoeICT4yWZbinuOS5PWYwWle8a9S113gjeb4quT+SW3y41F6R0Hky31ABrC2Cf6
         Ex8g==
X-Gm-Message-State: APjAAAXxHZolhblgmvWkl/Wsb1mMQD1Q8wcfV6BrSBgXTGhcj4IoOAJi
        7YqYjcClwzc2TTU2jKpFvbYqK+LlQQQ=
X-Google-Smtp-Source: APXvYqzN4jbAWzafeTfkz4+sFeaHdV/bMoteDPoF+ozY89Fy6vvhOUimZcHvewVZ16hAVVFNAqnJPA==
X-Received: by 2002:a1c:2e51:: with SMTP id u78mr3858356wmu.11.1576071302811;
        Wed, 11 Dec 2019 05:35:02 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:e505:be10:23e:110d? ([2a01:e34:ed2f:f020:e505:be10:23e:110d])
        by smtp.googlemail.com with ESMTPSA id q3sm2243626wmj.38.2019.12.11.05.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 05:35:02 -0800 (PST)
Subject: Re: [PATCH] drivers: thermal: step_wise: add support for hysteresis
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org, j-keerthy@ti.com,
        thara.gopinath@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     Ram Chandrasekar <rkumbako@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org
References: <8e812065f4a76325097c5f9c17f3386736d8c1d4.1574315190.git.amit.kucheria@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <962d48d2-87fd-1236-0623-148352a98de6@linaro.org>
Date:   Wed, 11 Dec 2019 14:35:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <8e812065f4a76325097c5f9c17f3386736d8c1d4.1574315190.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/11/2019 06:50, Amit Kucheria wrote:
> From: Ram Chandrasekar <rkumbako@codeaurora.org>
> 
> Currently, step wise governor increases the mitigation when the
> temperature goes above a threshold and decreases the mitigation when the
> temperature goes below the threshold. 
>
> If there is a case where the
> temperature is wavering around the threshold, the mitigation will be
> applied and removed every iteration, which is not very efficient.
>
> The use of hysteresis temperature could avoid this ping-pong of
> mitigation by relaxing the mitigation to happen only when the
> temperature goes below this lower hysteresis value.

What I'm worried about is how the hysteresis is used in the current
code, where the destination of this data is to set the value in the
sensor hardware if it is supported.

Using the hysteresis in the governor seems like abusing the initial
purpose of this information.

Moreover, the hysteresis creates a gray area where the above algorithm
(DROPPING && !throttle) => state-- or (RAISING && throttle) => state++
may drop the performances because we will continue mitigating even below
the threshold.

As the governor is an open-loop controller, I'm not sure if we can do
something except adding some kind of low pass filter to prevent
mitigation bounces.

> Signed-off-by: Ram Chandrasekar <rkumbako@codeaurora.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> [Rebased patch from downstream]
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/step_wise.c | 35 ++++++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
> index 6e051cbd824ff..2c8a34a7cf959 100644
> --- a/drivers/thermal/step_wise.c
> +++ b/drivers/thermal/step_wise.c
> @@ -24,7 +24,7 @@
>   *       for this trip point
>   *    d. if the trend is THERMAL_TREND_DROP_FULL, use lower limit
>   *       for this trip point
> - * If the temperature is lower than a trip point,
> + * If the temperature is lower than a hysteresis temperature,
>   *    a. if the trend is THERMAL_TREND_RAISING, do nothing
>   *    b. if the trend is THERMAL_TREND_DROPPING, use lower cooling
>   *       state for this trip point, if the cooling state already
> @@ -115,30 +115,31 @@ static void update_passive_instance(struct thermal_zone_device *tz,
>  
>  static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
>  {
> -	int trip_temp;
> +	int trip_temp, hyst_temp;
>  	enum thermal_trip_type trip_type;
>  	enum thermal_trend trend;
>  	struct thermal_instance *instance;
> -	bool throttle = false;
> +	bool throttle;
>  	int old_target;
>  
>  	if (trip == THERMAL_TRIPS_NONE) {
> -		trip_temp = tz->forced_passive;
> +		hyst_temp = trip_temp = tz->forced_passive;
>  		trip_type = THERMAL_TRIPS_NONE;
>  	} else {
>  		tz->ops->get_trip_temp(tz, trip, &trip_temp);
> +		hyst_temp = trip_temp;
> +		if (tz->ops->get_trip_hyst) {
> +			tz->ops->get_trip_hyst(tz, trip, &hyst_temp);
> +			hyst_temp = trip_temp - hyst_temp;
> +		}
>  		tz->ops->get_trip_type(tz, trip, &trip_type);
>  	}
>  
>  	trend = get_tz_trend(tz, trip);
>  
> -	if (tz->temperature >= trip_temp) {
> -		throttle = true;
> -		trace_thermal_zone_trip(tz, trip, trip_type);
> -	}
> -
> -	dev_dbg(&tz->device, "Trip%d[type=%d,temp=%d]:trend=%d,throttle=%d\n",
> -				trip, trip_type, trip_temp, trend, throttle);
> +	dev_dbg(&tz->device,
> +		"Trip%d[type=%d,temp=%d,hyst=%d]:trend=%d,throttle=%d\n",
> +		trip, trip_type, trip_temp, hyst_temp, trend, throttle);
>  
>  	mutex_lock(&tz->lock);
>  
> @@ -147,6 +148,18 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
>  			continue;
>  
>  		old_target = instance->target;
> +		throttle = false;
> +		/*
> +		 * Lower the mitigation only if the temperature
> +		 * goes below the hysteresis temperature.
> +		 */
> +		if (tz->temperature >= trip_temp ||
> +		    (tz->temperature >= hyst_temp &&
> +		     old_target != THERMAL_NO_TARGET)) {
> +			throttle = true;
> +			trace_thermal_zone_trip(tz, trip, trip_type);
> +		}
> +
>  		instance->target = get_target_state(instance, trend, throttle);
>  		dev_dbg(&instance->cdev->device, "old_target=%d, target=%d\n",
>  					old_target, (int)instance->target);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

