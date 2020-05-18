Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BA31D7F2E
	for <lists+linux-pm@lfdr.de>; Mon, 18 May 2020 18:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgERQvD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 May 2020 12:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbgERQvD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2020 12:51:03 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B755C05BD09
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2020 09:51:03 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f13so189386wmc.5
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2020 09:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rRdH9wSpot0NrcZPFvHZWOLU6dqlCA3ptvEFBk4r7OE=;
        b=Tr+7QO/ElHxeYDWXbWC5zGXwAzNcr0ia39LJGWhGpidg5GNj5Ksu/F+pGOsek0BR8M
         qSjr2EYsjTGv/ejUFu+C3SK9ZqAyECr4Io1IDcpD1s43rQ7ugSjqbiYKetYN6rEFqLgw
         5+9zNs80eSmD/52xKvmP0Y9Wk8lWraoR8G5zeXEUts0a/eP892jJsR7FRaoZNX0MKPHP
         NOd0vSskWcS5EPHjAXtCAseBuEKr15ROlm1pYIlVHKbh9KHyhoWGVKIfn3bJm10kOWW7
         EcInw/h5y7X7nukjH5EWsy/o1PADALkfnFglLkxrBwc9Yn7mjnHW+HsPPrpma8rGWhy7
         uHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rRdH9wSpot0NrcZPFvHZWOLU6dqlCA3ptvEFBk4r7OE=;
        b=S1LQzCXJ/V8JBAw3k2hslBa8cxEpocLzYw1uY/ICJPyK2yBTzJINrf0EjzoUbjCPLB
         3RCePcv8WS9DB5VDJF/HcUttmRULMIjh6Jggmxmx00gGExFqs6+QFbbMPOKs5q/2wmT/
         6H7531G/k7llBvAJOzpT3oAAbVL75bTqUXJsmD6kXZPv9LxcAshytY7DS6g5rr85kV9A
         aa7oi5SeVVeJ5x1IQAVKS7H8u2ivbobSy9Q8XDfpsrj8074MChiZrErir8e/FNI5EIDd
         V3qPrH1aKPCUMxA+BbHZI5pAgEHGPz/c9pO31hfK6Zr7hSz2It8epOquveVZGyXX1qmN
         aE5Q==
X-Gm-Message-State: AOAM5313umi8Z8cyc7Ee6PSEAHn6bzLKVYg42PrxY0qD/mCChFhmfbUq
        GnMGQkMiRk/sdXpazB1HESSIT2wpf/4=
X-Google-Smtp-Source: ABdhPJx0zzjrFy7VftFdwzWAwm0lEENm7xU7BLBqWdjcpiSAl70WARM/F9HxlUwjeQIDwTEPtH+uEg==
X-Received: by 2002:a1c:7410:: with SMTP id p16mr306095wmc.134.1589820661545;
        Mon, 18 May 2020 09:51:01 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9e7:3ac5:a930:2cd8? ([2a01:e34:ed2f:f020:9e7:3ac5:a930:2cd8])
        by smtp.googlemail.com with ESMTPSA id b145sm161741wme.41.2020.05.18.09.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 09:51:01 -0700 (PDT)
Subject: Re: [RFC][PATCH 4/5] thermal: Add support for setting polling
 interval
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rui.zhang@intel.com, amit.kucheria@verdurent.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20200504181616.175477-1-srinivas.pandruvada@linux.intel.com>
 <20200504181616.175477-5-srinivas.pandruvada@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c2aad548-32c2-f008-5ce4-97b76a19271d@linaro.org>
Date:   Mon, 18 May 2020 18:51:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504181616.175477-5-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04/05/2020 20:16, Srinivas Pandruvada wrote:
> Add new attribute in the thermal syfs for setting temperature sampling
> interval when CONFIG_THERMAL_USER_EVENT_INTERFACE is defined. The default
> value is 0, which means no polling.
> 
> At this interval user space will get an event THERMAL_TEMP_SAMPLE with
> temperature sample. This reuses existing polling mecahnism when polling
> or passive delay is specified during zone registry. To avoid interference
> with passive and polling delay, this new polling attribute can't be used
> for those zones.

The userspace can get the temperature whenever it wants via the
temperature file. The polling is designed for a specific hardware and
the slope of the temperature graphic.

The userspace has the alternative of reading the temperature based on
its own timer or wait for (and stick to) the thermal framework sampling
rate. Adding a notification in the update is enough IMO.


> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/thermal/thermal_core.c  |  7 +++++++
>  drivers/thermal/thermal_sysfs.c | 36 +++++++++++++++++++++++++++++++--
>  include/linux/thermal.h         |  1 +
>  3 files changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 14770d882d42..17cd799b0073 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -313,6 +313,8 @@ static void monitor_thermal_zone(struct thermal_zone_device *tz)
>  		thermal_zone_device_set_polling(tz, tz->passive_delay);
>  	else if (tz->polling_delay)
>  		thermal_zone_device_set_polling(tz, tz->polling_delay);
> +	else if (tz->temp_polling_delay)
> +		thermal_zone_device_set_polling(tz, tz->temp_polling_delay);
>  	else
>  		thermal_zone_device_set_polling(tz, 0);
>  
> @@ -446,6 +448,11 @@ static void update_temperature(struct thermal_zone_device *tz)
>  	tz->temperature = temp;
>  	mutex_unlock(&tz->lock);
>  
> +	if (tz->temp_polling_delay) {
> +		thermal_dev_send_event(tz->id, THERMAL_TEMP_SAMPLE, temp);
> +		monitor_thermal_zone(tz);
> +	}
> +
>  	trace_thermal_temperature(tz);
>  	if (tz->last_temperature == THERMAL_TEMP_INVALID)
>  		dev_dbg(&tz->device, "last_temperature N/A, current_temperature=%d\n",
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index aa85424c3ac4..0df7997993fe 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -248,6 +248,36 @@ create_thres_attr(temp_thres_low);
>  create_thres_attr(temp_thres_high);
>  create_thres_attr(temp_thres_hyst);
>  
> +static ssize_t
> +temp_polling_delay_store(struct device *dev, struct device_attribute *attr,
> +		   const char *buf, size_t count)
> +{
> +	struct thermal_zone_device *tz = to_thermal_zone(dev);
> +	int val;
> +
> +	if (kstrtoint(buf, 10, &val))
> +		return -EINVAL;
> +
> +	if (val && val < 1000)
> +		return -EINVAL;
> +
> +	tz->temp_polling_delay = val;
> +	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
> +
> +	return count;
> +}
> +
> +static ssize_t
> +temp_polling_delay_show(struct device *dev, struct device_attribute *attr,
> +		     char *buf)
> +{
> +	struct thermal_zone_device *tz = to_thermal_zone(dev);
> +
> +	return sprintf(buf, "%d\n", tz->temp_polling_delay);
> +}
> +
> +static DEVICE_ATTR_RW(temp_polling_delay);
> +
>  static int create_user_events_attrs(struct thermal_zone_device *tz)
>  {
>  	struct attribute **attrs;
> @@ -260,8 +290,8 @@ static int create_user_events_attrs(struct thermal_zone_device *tz)
>  	if (tz->ops->get_temp_thres_high)
>  		++index;
>  
> -	/* One additional space for NULL */
> -	attrs = kcalloc(index + 1, sizeof(*attrs), GFP_KERNEL);
> +	/* One additional space for NULL and temp_pollling_delay */
> +	attrs = kcalloc(index + 2, sizeof(*attrs), GFP_KERNEL);
>  	if (!attrs)
>  		return -ENOMEM;
>  
> @@ -312,6 +342,8 @@ static int create_user_events_attrs(struct thermal_zone_device *tz)
>  		attrs[index] = &tz->threshold_attrs[index].attr.attr;
>  		++index;
>  	}
> +	if (!tz->polling_delay && !tz->passive_delay)
> +		attrs[index++] = &dev_attr_temp_polling_delay.attr;
>  	attrs[index] = NULL;
>  	tz->threshold_attribute_group.attrs = attrs;
>  
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index ee9d79ace7ce..0ec4bd8c9c5c 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -216,6 +216,7 @@ struct thermal_zone_device {
>  	enum thermal_notify_event notify_event;
>  	struct attribute_group threshold_attribute_group;
>  	struct thermal_attr *threshold_attrs;
> +	int temp_polling_delay;
>  };
>  
>  /**
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
