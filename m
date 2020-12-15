Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DEB2DAF15
	for <lists+linux-pm@lfdr.de>; Tue, 15 Dec 2020 15:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgLOOi7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Dec 2020 09:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729423AbgLOOiu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2020 09:38:50 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A28BC0617A7
        for <linux-pm@vger.kernel.org>; Tue, 15 Dec 2020 06:38:09 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id z3so14631122qtw.9
        for <linux-pm@vger.kernel.org>; Tue, 15 Dec 2020 06:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w7jpjH1Jbgu804AfDst7MSgkMyAd/mh6khKgn3kKLTc=;
        b=V7w0ZMkw6xKCNSAW0VAuR5Un2XMk0yafWlbkOSxQg9JutJyIkRrSdKarM3+gXZDsLL
         Q4DeWWqB9ClfoNf5b/4ZNZjc9AXNbIP6pbD/QtKLLYo0IVdQTcPod/SZ9uuiW56WV+6V
         sMu/V8FKT3H2mCxUui5QXGzTGG+rm1XGBfAeKjGCxSaUOmFlbpVkxrEIRNVlEpSQn2n3
         YVZolF7bq5CzyfqlOXce/eIMcQeyejqThqZj1KH4tB9zPFYiPfKRVcl7O12/jHa4Kt4/
         k0CjorpVWkFzFHeerJgdIAAa9H2zM/nqDjLaB2cHtQyzGnoKTD5iWw+C6C1RplvYSZye
         Wu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w7jpjH1Jbgu804AfDst7MSgkMyAd/mh6khKgn3kKLTc=;
        b=noWcGPMLta8j4evslgJU0ifvzg3S/L5Yx8e6HJfW1KK5q2BjyQ1IOJtx6Ma3XmBtCv
         OkjWuiSUXczSHliYTIyGn8pL8RkBQ+98Hw7jLXxcJqJKvi2gwSjNSqW1smEY3LYVRCxq
         FjUbV9EO0YNUq9YT4NVEufLa8AXVh1A44QrxKUlOIyI4MnvCOmB0K6lfLsrxqLRxeTwX
         HCvPcYT26wtp6xlozIhl1zivjKb9giWqA0Q9VA3FE/d6PhLJRlnU5azXg26k5LvX44e7
         Hpploy3wFdQD64wSi1/w8+CkrgFeu/1bTbRwpJ3/YOUkrff3UjP39GmM3vcHNq3rjaaM
         TWPQ==
X-Gm-Message-State: AOAM532f9O/jPZH+QNAjZmi59gTKLgnCUsSKREm1lvK38E/a9OEVoPH7
        eQXjNDoVioQiqZZHD1cv8YDaicO8uQdRXw==
X-Google-Smtp-Source: ABdhPJxOaC0n7+XXIS6ZI6MMKP5M3A+89QYy4enzXD/zj/tBM8VS5Ef0yLT4wL0rsaH7vRoK7kZbuA==
X-Received: by 2002:ac8:5a95:: with SMTP id c21mr37113165qtc.115.1608043087777;
        Tue, 15 Dec 2020 06:38:07 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id r128sm17235414qke.94.2020.12.15.06.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 06:38:07 -0800 (PST)
Subject: Re: [PATCH 2/4] thermal/core: Precompute the jiffies
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com
Cc:     amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20201202120657.1969-1-daniel.lezcano@linaro.org>
 <20201202120657.1969-2-daniel.lezcano@linaro.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <1c909a38-1777-556d-fe87-29394a1b1d56@linaro.org>
Date:   Tue, 15 Dec 2020 09:38:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201202120657.1969-2-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On 12/2/20 7:06 AM, Daniel Lezcano wrote:
> The delays are stored in ms units and when the polling function is
> called this delay is converted into jiffies at each call.
> 
> Instead of doing the conversion again and again, compute the jiffies
> at init time and use the value directly when setting the polling.

A generic comment. You can avoid patch 1 of this series and directly
have patch 2 , right? There is no need to rename 
polling_delay/passive_delay to *_delay_ms and then remove it again?

> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/thermal/thermal_core.c  |  5 +++--
>   drivers/thermal/thermal_core.h  | 18 ++++++++++++++++++
>   drivers/thermal/thermal_sysfs.c |  4 ++--
>   include/linux/thermal.h         |  7 +++++++
>   4 files changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 53f55ceca220..3111ca2c87a1 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1340,8 +1340,9 @@ thermal_zone_device_register(const char *type, int trips, int mask,
>   	tz->device.class = &thermal_class;
>   	tz->devdata = devdata;
>   	tz->trips = trips;
> -	tz->passive_delay_ms = passive_delay;
> -	tz->polling_delay_ms = polling_delay;
> +
> +	thermal_zone_set_passive_delay(tz, passive_delay);
> +	thermal_zone_set_polling_delay(tz, polling_delay);
>   
>   	/* sys I/F */
>   	/* Add nodes that are always present via .groups */
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index 8df600fa7b79..2c9551ed5ef8 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -128,6 +128,24 @@ int thermal_build_list_of_policies(char *buf);
>   /* Helpers */
>   void thermal_zone_set_trips(struct thermal_zone_device *tz);
>   
> +static inline void thermal_zone_set_passive_delay(
> +	struct thermal_zone_device *tz, int delay_ms)
> +{
> +	tz->passive_delay_ms = delay_ms;
> +	tz->passive_delay_jiffies = msecs_to_jiffies(delay_ms);
> +	if (delay_ms > 1000)
> +		tz->passive_delay_jiffies = round_jiffies(tz->passive_delay_jiffies);
> +}
> +
> +static inline void thermal_zone_set_polling_delay(
> +	struct thermal_zone_device *tz, int delay_ms)
> +{
> +	tz->polling_delay_ms = delay_ms;
> +	tz->polling_delay_jiffies = msecs_to_jiffies(delay_ms);
> +	if (delay_ms > 1000)
> +		tz->polling_delay_jiffies = round_jiffies(tz->polling_delay_jiffies);
> +}

How about one function instead?
static inline void thermal_zone_set_delay_jiffies(int *delay_jiffes, int 
delay_ms)
{
	*delay_jiffies = msecs_to_jiffies(delay_ms);
	if (delay_ms > 1000)
		*delay_jiffies = round_jiffies(*delay_jiffies);
}

And then calling 
thermal_zone_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay)..

Regards
Thara
> +
>   /* sysfs I/F */
>   int thermal_zone_create_device_groups(struct thermal_zone_device *, int);
>   void thermal_zone_destroy_device_groups(struct thermal_zone_device *);
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index f465462d8aa1..9598b288a0a1 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -234,11 +234,11 @@ passive_store(struct device *dev, struct device_attribute *attr,
>   
>   	if (state && !tz->forced_passive) {
>   		if (!tz->passive_delay_ms)
> -			tz->passive_delay_ms = 1000;
> +			thermal_zone_set_passive_delay(tz, 1000);
>   		thermal_zone_device_rebind_exception(tz, "Processor",
>   						     sizeof("Processor"));
>   	} else if (!state && tz->forced_passive) {
> -		tz->passive_delay_ms = 0;
> +		thermal_zone_set_passive_delay(tz, 0);
>   		thermal_zone_device_unbind_exception(tz, "Processor",
>   						     sizeof("Processor"));
>   	}
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 230d451bf335..5dd9bdb6c6ad 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -118,9 +118,14 @@ struct thermal_cooling_device {
>    * @trips_disabled;	bitmap for disabled trips
>    * @passive_delay_ms:	number of milliseconds to wait between polls when
>    *			performing passive cooling.
> + * @passive_delay_jiffies: number of jiffies to wait between polls when
> + *			performing passive cooling.
>    * @polling_delay_ms:	number of milliseconds to wait between polls when
>    *			checking whether trip points have been crossed (0 for
>    *			interrupt driven systems)
> + * @polling_delay_jiffies: number of jiffies to wait between polls when
> + *			checking whether trip points have been crossed (0 for
> + *			interrupt driven systems)
>    * @temperature:	current temperature.  This is only for core code,
>    *			drivers should use thermal_zone_get_temp() to get the
>    *			current temperature
> @@ -161,6 +166,8 @@ struct thermal_zone_device {
>   	unsigned long trips_disabled;	/* bitmap for disabled trips */
>   	int passive_delay_ms;
>   	int polling_delay_ms;
> +	int passive_delay_jiffies;
> +	int polling_delay_jiffies;
>   	int temperature;
>   	int last_temperature;
>   	int emul_temperature;
> 

-- 
Warm Regards
Thara
