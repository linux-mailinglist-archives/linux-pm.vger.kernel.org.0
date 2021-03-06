Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233F932F751
	for <lists+linux-pm@lfdr.de>; Sat,  6 Mar 2021 01:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhCFAjd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Mar 2021 19:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhCFAja (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Mar 2021 19:39:30 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48005C06175F;
        Fri,  5 Mar 2021 16:39:27 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id w18so3226555pfu.9;
        Fri, 05 Mar 2021 16:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wSQMvz/uoD2V+0F+KZdBHyVqbtrZWTT88VchY3bdcS4=;
        b=NuRnefGmXN2vvJG7JmVEslN1zqs41d4SXv3ARZprMRDJd/7rUaOUG03fK0oXGBmYT7
         mP5T0eG7UYHV7jyFqeM0a/SOKEMav/6DQW1OLwnf16+8gmCD62D2V0SPlvF+q+Ci5Y45
         gTdnkndtybksZgQ0VmwZhyx6Lps8V4hBRiPxENhCC/YY2BJoS88E9sVPeI+t+sGhEkAf
         pWWNrNl2ngn0qf4st8QN0suqTrwKOL8l412qo8j5KzKmCLZq1PJyCEMrqGjNtO/9XPSi
         ecOaKE5/f/yaoVVT5AQzS4UhhFO1zZGhy5bqWigw5+HBAfTsPF3gRwgs61SlgG7bC6GV
         8Jpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wSQMvz/uoD2V+0F+KZdBHyVqbtrZWTT88VchY3bdcS4=;
        b=ZaRdOTuJFMqKDWeOmbdHj3RlNVyE7nVy1zGicI+4UrhY0F79lGQ3sXi4E48ON0ORcj
         UaLsQPdM9+ge0TGQq+2PZM1QENhjo1RMc0vscO8clwsKh11easMaeq2HRw0Ur47JMOKP
         pU1MUri2camOCUYWEEzp9Yd10Ldyi2EjCTBHPipCxjETk5EBgfdW9XZU6yO9YsX+a1+u
         yGlZicx5O23ZGI7ZMoFb7EzcVCKSOTkasGwzAGkviDSfiYvQjRIYzPJzaZ6Alo/PkdKg
         TUGrbFeGyNGPfA85HQ30dyAGoPJBO9bGgGaW3/CNe7koilEz5hXiPTo4b4HQ+H0L58Uz
         ZjuA==
X-Gm-Message-State: AOAM533JEzanc0Mry9LSQibh3jmb9cBkcaehiNggu4AtcBiiRn1y6FYF
        GFjGve6Vm0smIej/9wgMesmMasYD1MTGGA==
X-Google-Smtp-Source: ABdhPJzR0LRPvO2I7DVrGhZVkWhb35ITb2RKsavQMrDIYX9yahufg9+OGuHqH4KyI0G1jSVekQNpow==
X-Received: by 2002:a63:5863:: with SMTP id i35mr1132052pgm.228.1614991165717;
        Fri, 05 Mar 2021 16:39:25 -0800 (PST)
Received: from [172.30.1.19] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id r30sm3774793pgu.86.2021.03.05.16.39.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 16:39:24 -0800 (PST)
Subject: Re: [PATCH v2 1/4] devfreq: Register devfreq as a cooling device on
 demand
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, steven.price@arm.com,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20210305170338.13647-1-daniel.lezcano@linaro.org>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <7d51cdb7-e833-f267-1dca-e75a68b635ad@gmail.com>
Date:   Sat, 6 Mar 2021 09:39:20 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210305170338.13647-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 21. 3. 6. 오전 2:03, Daniel Lezcano wrote:
> Currently the default behavior is to manually having the devfreq
> backend to register themselves as a devfreq cooling device.
> 
> Instead of adding the code in the drivers for the thermal cooling
> device registering, let's provide a flag in the devfreq's profile to
> tell the common devfreq code to register the newly created devfreq as
> a cooling device.
> 
> Suggested-by: Chanwoo Choi <cwchoi00@gmail.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/devfreq/devfreq.c | 11 +++++++++++
>   include/linux/devfreq.h   |  7 +++++++
>   2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index b6d63f02d293..5c0fdd3a48d2 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -11,6 +11,7 @@
>   #include <linux/kmod.h>
>   #include <linux/sched.h>
>   #include <linux/debugfs.h>
> +#include <linux/devfreq_cooling.h>
>   #include <linux/errno.h>
>   #include <linux/err.h>
>   #include <linux/init.h>
> @@ -26,6 +27,7 @@
>   #include <linux/hrtimer.h>
>   #include <linux/of.h>
>   #include <linux/pm_qos.h>
> +#include <linux/thermal.h> >   #include <linux/units.h>

Acutally, current devfreq-next branch doesn't contain previous
your patch about units clean-up. So that when I applied it to next
branch, merge conflict happen because of '<linux/units.h>'.

Just send the patches again regardless of 'devfreq: Use HZ macros'.

>   #include "governor.h"
>   
> @@ -935,6 +937,13 @@ struct devfreq *devfreq_add_device(struct device *dev,
>   
>   	mutex_unlock(&devfreq_list_lock);
>   
> +	if (devfreq->profile->is_cooling_device) {
> +		devfreq->cdev = devfreq_cooling_em_register(devfreq, NULL);
> +		if (IS_ERR(devfreq->cdev))
> +			dev_info(dev, "Failed to register devfreq "
> +				 "cooling device\n");

Have to initialize devfreq->cdev by NULL when error happen.
Because of just returning from thermal_cooling_device_unregister
when cdev is not used.

> +	}
> +
>   	return devfreq;
>   
>   err_init:
> @@ -960,6 +969,8 @@ int devfreq_remove_device(struct devfreq *devfreq)
>   	if (!devfreq)
>   		return -EINVAL;
>   
> +	thermal_cooling_device_unregister(devfreq->cdev);
> +
>   	if (devfreq->governor) {
>   		devfreq->governor->event_handler(devfreq,
>   						 DEVFREQ_GOV_STOP, NULL);
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 26ea0850be9b..554e7904b0c5 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -98,11 +98,15 @@ struct devfreq_dev_status {
>    * @freq_table:		Optional list of frequencies to support statistics
>    *			and freq_table must be generated in ascending order.
>    * @max_state:		The size of freq_table.
> + *
> + * @is_cooling_device: A self-explanatory boolean giving the device a
> + *                     cooling effect property.
>    */
>   struct devfreq_dev_profile {
>   	unsigned long initial_freq;
>   	unsigned int polling_ms;
>   	enum devfreq_timer timer;
> +	bool is_cooling_device;
>   
>   	int (*target)(struct device *dev, unsigned long *freq, u32 flags);
>   	int (*get_dev_status)(struct device *dev,
> @@ -198,6 +202,9 @@ struct devfreq {
>   
>   	struct srcu_notifier_head transition_notifier_list;
>   
> +	/* Pointer to the cooling device if used for thermal mitigation */ > +	struct thermal_cooling_device *cdev;
> +
You need to the description of cdev instance to 'struct devfreq'.

>   	struct notifier_block nb_min;
>   	struct notifier_block nb_max;
>   };
> 


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
