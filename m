Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB651136DD
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2019 22:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfLDVF2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 16:05:28 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45213 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbfLDVF1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2019 16:05:27 -0500
Received: by mail-wr1-f68.google.com with SMTP id j42so857034wrj.12
        for <linux-pm@vger.kernel.org>; Wed, 04 Dec 2019 13:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pCvZJU1LLJvDUB1G3/9Ogy+cUN7IJ9DJnSumKiA4mLU=;
        b=iK9OwSXTtq5gOw+4oNEiAG+k3yAuysmjZBzRMoaWUEq9hjcZ9vp+W47ggFB+8jTwc1
         Nsem8wsR6xqBAQo1PfZ2+Qlh/WQVYLGLwI9cOKHO8DlvSdcMvYYVx3a14ruBWievqfV4
         kQzJdSXmK6tAWtJbithPWvTwZN7wGB+OwOKggdBmPFx0sd0KJ6m1cAVE284koUgRVMQ8
         30+LRAaVZdRQ+bE5R+H9uSlgLaI80VJb4sfy8dztN0WuOsxGZtYj+stWHOCQTGRvxDm8
         YsZkS2qrFrxs3Ush3EvxZ0JxQ8Y8YkuJt5/4h/pxhf/8QhIOsQu6ZklneTke1xP/2vMQ
         3gOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pCvZJU1LLJvDUB1G3/9Ogy+cUN7IJ9DJnSumKiA4mLU=;
        b=LpqgQLdGCBU7sZv7gIMZzKQJyApDVCEpW40/nKNvzRVa6QjhNrn6pUe3T0eOoFlENe
         04D4ROm+7YkZPl84DxK81ZCa7rp6IOf8LmppO9a0PhTAzR9ha+AH+I7NVbIlvBVHbnPS
         BfdGzQMkek+QgmginrHqliD+ENwQ++BtS7CydjWEV07Fgy+xVhtvDnWCQuQwt7QOatFf
         2WyNtQUB+P6I9H84meZx/Wr2jgG0vn8iW1acidiiaI+yEryahg8vJB+NYmPIvr7VHP8b
         rV4NvqFCwFbjOOexHPqNebOvtLkrfPLi4GAjRpFmN9yfUBSTsytTNfpXxky+7KucZj92
         Uv9w==
X-Gm-Message-State: APjAAAX9AIUNAD09lKKy+0MrtCJrN+gZ+Qj9mI58fOeKuZ4SvPkPjuIQ
        vWVCrxatY7l0lH3Beynj9UXMcQ==
X-Google-Smtp-Source: APXvYqwTtSzbJkrzuZm6vwHchEHpIP9b3IKF5oT4sZk+LHvJ60h9TPftWWSrFwb0RbtGJc2IMg+vsA==
X-Received: by 2002:adf:dc86:: with SMTP id r6mr6752156wrj.68.1575493525175;
        Wed, 04 Dec 2019 13:05:25 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:d965:ceae:a314:6edb? ([2a01:e34:ed2f:f020:d965:ceae:a314:6edb])
        by smtp.googlemail.com with ESMTPSA id g9sm8457863wro.67.2019.12.04.13.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 13:05:24 -0800 (PST)
Subject: Re: [PATCH v2 1/5] thermal: stm32: remove hardware irq handler
To:     Pascal Paillet <p.paillet@st.com>, rui.zhang@intel.com,
        edubezval@gmail.com, amit.kucheria@verdurent.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        david.hernandezsanchez@st.com, horms+renesas@verge.net.au,
        wsa+renesas@sang-engineering.com, linux-pm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191104133020.8820-1-p.paillet@st.com>
 <20191104133020.8820-2-p.paillet@st.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3b1b690b-71f1-95e7-704b-b3d0073c68de@linaro.org>
Date:   Wed, 4 Dec 2019 22:05:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191104133020.8820-2-p.paillet@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04/11/2019 14:30, Pascal Paillet wrote:
> Remove hardware irq handler because it is not needed to disable the
> interrupt before the threaded handler. The goal is to simplify
> the code.

Please elaborate the explanation here. I guess all the code removed is
because of:

	/* read IT reason in SR and clear flags */
	value = readl_relaxed(sensor->base + DTS_SR_OFFSET);

Right?

> Change-Id: Ida967e8543c8dafc6a24508000f64f6405add31d

Remove Change-Id.

Missing SoB.

> ---
>  drivers/thermal/st/stm_thermal.c | 25 +------------------------
>  1 file changed, 1 insertion(+), 24 deletions(-)
> 
> diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
> index cf9ddc52f30e..31aa63fb3db1 100644
> --- a/drivers/thermal/st/stm_thermal.c
> +++ b/drivers/thermal/st/stm_thermal.c
> @@ -98,21 +98,10 @@ struct stm_thermal_sensor {
>  	unsigned int low_temp_enabled;
>  	int num_trips;
>  	int irq;
> -	unsigned int irq_enabled;
>  	void __iomem *base;
>  	int t0, fmt0, ramp_coeff;
>  };
>  
> -static irqreturn_t stm_thermal_alarm_irq(int irq, void *sdata)
> -{
> -	struct stm_thermal_sensor *sensor = sdata;
> -
> -	disable_irq_nosync(irq);
> -	sensor->irq_enabled = false;
> -
> -	return IRQ_WAKE_THREAD;
> -}
> -
>  static irqreturn_t stm_thermal_alarm_irq_thread(int irq, void *sdata)
>  {
>  	u32 value;
> @@ -464,16 +453,6 @@ static int stm_thermal_get_temp(void *data, int *temp)
>  			if (ret)
>  				return ret;
>  		}
> -
> -		/*
> -		 * Re-enable alarm IRQ if temperature below critical
> -		 * temperature
> -		 */
> -		if (!sensor->irq_enabled &&
> -		    (celsius(*temp) < sensor->temp_critical)) {
> -			sensor->irq_enabled = true;
> -			enable_irq(sensor->irq);
> -		}
>  	}
>  
>  	return 0;
> @@ -493,7 +472,7 @@ static int stm_register_irq(struct stm_thermal_sensor *sensor)
>  	}
>  
>  	ret = devm_request_threaded_irq(dev, sensor->irq,
> -					stm_thermal_alarm_irq,
> +					NULL,
>  					stm_thermal_alarm_irq_thread,
>  					IRQF_ONESHOT,
>  					dev->driver->name, sensor);
> @@ -503,8 +482,6 @@ static int stm_register_irq(struct stm_thermal_sensor *sensor)
>  		return ret;
>  	}
>  
> -	sensor->irq_enabled = true;
> -
>  	dev_dbg(dev, "%s: thermal IRQ registered", __func__);
>  
>  	return 0;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

