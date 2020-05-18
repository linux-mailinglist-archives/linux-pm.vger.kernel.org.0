Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA5A1D7EAC
	for <lists+linux-pm@lfdr.de>; Mon, 18 May 2020 18:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgERQhL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 May 2020 12:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbgERQhL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2020 12:37:11 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC22FC05BD09
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2020 09:37:10 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w64so198085wmg.4
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2020 09:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pLMq4RspN08+KBIf5NTfKFLAQklkEesZlECI7b39+ZA=;
        b=oEcbu6d2WCURNEoZlq/I6NmJMWyx77Xioz7StSmvfmdArO0tS3v5pS6zHGro1UMusZ
         bYJSYQ+ftdzCPig5Qns59upojnFw0d/MDpeRYSLCabH0tc97OMIulp2QZ8HUWEU0oX9X
         IFU1z+bDUUAE3dPUoFrEMh9ItLMi26yGbIcYlXiSp7QDxz3EwbznqWkEl/PNTH9yEuPJ
         31knCVqqLjH2yXk3k3P3L9ChIJ9M/NC7b7ZYHECKWTUbpPiYb7cVX7qrwLdHIgy+g5Gk
         4hbgYzKYfBi0eGW6S/mYyROXxCdVmkOpz+7XT/bD+Y8Wb5ns5JViFGtJJKil1Mughg/b
         qeug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pLMq4RspN08+KBIf5NTfKFLAQklkEesZlECI7b39+ZA=;
        b=MGKSGevXL4WidICOi3kLubpLVZtQ8oaEmEfE9pFvU+DWCOtFBVu+NakAja6nfQRzNW
         v9G4Mzzy/u7Qtd0C0MGvPUSRfUv22aBRzWwZoSfxA/k22JO6J9naYyIhFPIGMfZzPjV1
         iGU/Y8jsCDGNR+h68qR1tZekglG7KQdw9c4IMYgDtQXl7/jrNMcItFTcb2jt4CxdkMwv
         r1W/d7S9+TNF7/J83NEhydTNZvTvsrDZhv8ZcH1QyxU4YRhQ6P9xou5u5kwsYa3DnPfe
         6mkdrhAEKlzK3Qa4d+xN1VxcdgaeT1ZCVS/GHpsBQgrFV2Ezwp++OpbvrK3A0vLP/1mM
         Tndw==
X-Gm-Message-State: AOAM530vLuGsrX1U4+Oj46wdodCiLFHV2AL36xTXBhxpVHlTB1I32z9t
        v4OKSs942ASL+n9EiEu8Gw0Wk+98V90=
X-Google-Smtp-Source: ABdhPJz/aJ6qf6PRlMaevwKJ0gIq+PsCnaSXhMljluPkiaAEtVZ7lSL6yXJJy6fPr3o1cbISq0ODgg==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr225202wmi.41.1589819829165;
        Mon, 18 May 2020 09:37:09 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9e7:3ac5:a930:2cd8? ([2a01:e34:ed2f:f020:9e7:3ac5:a930:2cd8])
        by smtp.googlemail.com with ESMTPSA id 7sm17809954wra.50.2020.05.18.09.37.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 09:37:08 -0700 (PDT)
Subject: Re: [RFC][PATCH 3/5] thermal: Add support for setting notification
 thresholds
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rui.zhang@intel.com, amit.kucheria@verdurent.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20200504181616.175477-1-srinivas.pandruvada@linux.intel.com>
 <20200504181616.175477-4-srinivas.pandruvada@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a9af415d-9fd0-dcea-79ee-0fb90f45045e@linaro.org>
Date:   Mon, 18 May 2020 18:37:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504181616.175477-4-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04/05/2020 20:16, Srinivas Pandruvada wrote:
> Add new attributes in thermal syfs when a thermal drivers provides
> callbacks for them and CONFIG_THERMAL_USER_EVENT_INTERFACE is defined.
> 
> These attribute allow user space to stop polling for temperature.
> 
> These attributes are:
> - temp_thres_low: Specify a notification temperature for a low
> temperature threshold event.
> temp_thres_high: Specify a notification temperature for a high
> temperature threshold event.
> temp_thres_hyst: Specify a change in temperature to send notification
> again.
> 
> This is implemented by adding additional sysfs attribute group. The
> changes in this patch are trivial to add new attributes in thermal
> sysfs as done for other attributes.

Isn't it duplicate with the trip point?




> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/thermal/thermal_sysfs.c | 136 +++++++++++++++++++++++++++++++-
>  include/linux/thermal.h         |  10 ++-
>  2 files changed, 143 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index aa99edb4dff7..aa85424c3ac4 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -215,6 +215,125 @@ trip_point_hyst_show(struct device *dev, struct device_attribute *attr,
>  	return ret ? ret : sprintf(buf, "%d\n", temperature);
>  }
>  
> +#if IS_ENABLED(CONFIG_THERMAL_USER_EVENT_INTERFACE)
> +
> +#define create_thres_attr(name)					\
> +	static ssize_t							\
> +	name##_show(struct device *dev, struct device_attribute *devattr, \
> +		char *buf)						\
> +	{								\
> +	struct thermal_zone_device *tz = to_thermal_zone(dev);	\
> +	int temperature, ret;						\
> +									\
> +	ret = tz->ops->get_##name(tz, &temperature);			\
> +									\
> +	return ret ? ret : sprintf(buf, "%d\n", temperature);	\
> +	}								\
> +									\
> +	static ssize_t							\
> +	name##_store(struct device *dev, struct device_attribute *devattr, \
> +		const char *buf, size_t count)				\
> +	{								\
> +		struct thermal_zone_device *tz = to_thermal_zone(dev);	\
> +		int temperature, ret;					\
> +									\
> +		if (kstrtoint(buf, 10, &temperature))			\
> +			return -EINVAL;				\
> +									\
> +		ret = tz->ops->set_##name(tz, temperature);		\
> +		return ret ? ret : count;				\
> +	}
> +
> +create_thres_attr(temp_thres_low);
> +create_thres_attr(temp_thres_high);
> +create_thres_attr(temp_thres_hyst);
> +
> +static int create_user_events_attrs(struct thermal_zone_device *tz)
> +{
> +	struct attribute **attrs;
> +	int index = 0;
> +
> +	if (tz->ops->get_temp_thres_low)
> +		++index;
> +	if (tz->ops->get_temp_thres_high)
> +		++index;
> +	if (tz->ops->get_temp_thres_high)
> +		++index;
> +
> +	/* One additional space for NULL */
> +	attrs = kcalloc(index + 1, sizeof(*attrs), GFP_KERNEL);
> +	if (!attrs)
> +		return -ENOMEM;
> +
> +	tz->threshold_attrs = kcalloc(index, sizeof(*tz->threshold_attrs), GFP_KERNEL);
> +	if (!tz->threshold_attrs) {
> +		kfree(attrs);
> +		return -ENOMEM;
> +	}
> +
> +	index = 0;
> +
> +	if (tz->ops->get_temp_thres_low) {
> +		snprintf(tz->threshold_attrs[index].name, THERMAL_NAME_LENGTH,
> +			 "temp_thres_low");
> +
> +		sysfs_attr_init(&tz->threshold_attrs[index].attr.attr);
> +		tz->threshold_attrs[index].attr.attr.name =
> +						tz->threshold_attrs[index].name;
> +		tz->threshold_attrs[index].attr.attr.mode = S_IWUSR | S_IRUGO;
> +		tz->threshold_attrs[index].attr.show = temp_thres_low_show;
> +		tz->threshold_attrs[index].attr.store = temp_thres_low_store;
> +		attrs[index] = &tz->threshold_attrs[index].attr.attr;
> +		++index;
> +	}
> +	if (tz->ops->get_temp_thres_high) {
> +		snprintf(tz->threshold_attrs[index].name, THERMAL_NAME_LENGTH,
> +			 "temp_thres_high");
> +
> +		sysfs_attr_init(&tz->threshold_attrs[index].attr.attr);
> +		tz->threshold_attrs[index].attr.attr.name =
> +						tz->threshold_attrs[index].name;
> +		tz->threshold_attrs[index].attr.attr.mode = S_IWUSR | S_IRUGO;
> +		tz->threshold_attrs[index].attr.show = temp_thres_high_show;
> +		tz->threshold_attrs[index].attr.store = temp_thres_high_store;
> +		attrs[index] = &tz->threshold_attrs[index].attr.attr;
> +		++index;
> +	}
> +	if (tz->ops->get_temp_thres_hyst) {
> +		snprintf(tz->threshold_attrs[index].name, THERMAL_NAME_LENGTH,
> +			 "temp_thres_hyst");
> +
> +		sysfs_attr_init(&tz->threshold_attrs[index].attr.attr);
> +		tz->threshold_attrs[index].attr.attr.name =
> +						tz->threshold_attrs[index].name;
> +		tz->threshold_attrs[index].attr.attr.mode = S_IWUSR | S_IRUGO;
> +		tz->threshold_attrs[index].attr.show = temp_thres_hyst_show;
> +		tz->threshold_attrs[index].attr.store = temp_thres_hyst_store;
> +		attrs[index] = &tz->threshold_attrs[index].attr.attr;
> +		++index;
> +	}
> +	attrs[index] = NULL;
> +	tz->threshold_attribute_group.attrs = attrs;
> +
> +	return 0;
> +}
> +
> +static void delete_user_events_attrs(struct thermal_zone_device *tz)
> +{
> +	kfree(tz->threshold_attrs);
> +	kfree(tz->threshold_attribute_group.attrs);
> +}
> +#else
> +static int create_user_events_attrs(struct thermal_zone_device *tz)
> +{
> +	return -EINVAL;
> +}
> +
> +static void delete_user_events_attrs(struct thermal_zone_device *tz)
> +{
> +}
> +#endif
> +
>  static ssize_t
>  passive_store(struct device *dev, struct device_attribute *attr,
>  	      const char *buf, size_t count)
> @@ -625,16 +744,27 @@ int thermal_zone_create_device_groups(struct thermal_zone_device *tz,
>  {
>  	const struct attribute_group **groups;
>  	int i, size, result;
> +	int start = 0;
>  
>  	/* we need one extra for trips and the NULL to terminate the array */
>  	size = ARRAY_SIZE(thermal_zone_attribute_groups) + 2;
> +
> +	result = create_user_events_attrs(tz);
> +	if (!result) {
> +		++size;
> +		++start;
> +	}
> +
>  	/* This also takes care of API requirement to be NULL terminated */
>  	groups = kcalloc(size, sizeof(*groups), GFP_KERNEL);
>  	if (!groups)
>  		return -ENOMEM;
>  
> -	for (i = 0; i < size - 2; i++)
> -		groups[i] = thermal_zone_attribute_groups[i];
> +	if (start)
> +		groups[0] = &tz->threshold_attribute_group;
> +
> +	for (i = 0; i < size - 2 - start; i++)
> +		groups[i + start] = thermal_zone_attribute_groups[i];
>  
>  	if (tz->trips) {
>  		result = create_trip_attrs(tz, mask);
> @@ -660,6 +790,8 @@ void thermal_zone_destroy_device_groups(struct thermal_zone_device *tz)
>  	if (tz->trips)
>  		destroy_trip_attrs(tz);
>  
> +	delete_user_events_attrs(tz);
> +
>  	kfree(tz->device.groups);
>  }
>  
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index f5e1e7c6a9a2..ee9d79ace7ce 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -102,6 +102,12 @@ struct thermal_zone_device_ops {
>  			  enum thermal_trend *);
>  	int (*notify) (struct thermal_zone_device *, int,
>  		       enum thermal_trip_type);
> +	int (*set_temp_thres_low)(struct thermal_zone_device *, int);
> +	int (*set_temp_thres_high)(struct thermal_zone_device *, int);
> +	int (*set_temp_thres_hyst)(struct thermal_zone_device *, int);
> +	int (*get_temp_thres_low)(struct thermal_zone_device *, int *);
> +	int (*get_temp_thres_high)(struct thermal_zone_device *, int *);
> +	int (*get_temp_thres_hyst)(struct thermal_zone_device *, int *);
>  };
>  
>  struct thermal_cooling_device_ops {
> @@ -208,6 +214,8 @@ struct thermal_zone_device {
>  	struct list_head node;
>  	struct delayed_work poll_queue;
>  	enum thermal_notify_event notify_event;
> +	struct attribute_group threshold_attribute_group;
> +	struct thermal_attr *threshold_attrs;
>  };
>  
>  /**
> @@ -558,7 +566,7 @@ enum thermal_device_events {
>  	THERMAL_PERF_CHANGED,
>  };
>  
> -#ifdef CONFIG_THERMAL_USER_EVENT_INTERFACE
> +#if IS_ENABLED(CONFIG_THERMAL_USER_EVENT_INTERFACE)
>  int thermal_dev_send_event(int zone_id, enum thermal_device_events event, u64 event_data);
>  #else
>  int thermal_dev_send_event(int zone_id, enum thermal_device_events event, u64 event_data)
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
