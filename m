Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF953301E4
	for <lists+linux-pm@lfdr.de>; Sun,  7 Mar 2021 15:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhCGOPJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Mar 2021 09:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbhCGOPJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Mar 2021 09:15:09 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006EFC06174A;
        Sun,  7 Mar 2021 06:15:08 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso1655649pjb.4;
        Sun, 07 Mar 2021 06:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ipLIvxmXFEp/52jBUxtNr8uo8Uz63NhczbFOPgGp9eU=;
        b=eTWA6KFYfUmie1OZqJRYRnwhZxvhyHMcPLD3qq8VvyJyj/x4pm3PrPwpcsDoT0AZI2
         5wK+VTCj+R9dI1p39rZkxgjXupcdBoKxyiVaX9Gyr5i2QJuzYAZ3wScGDZH4UWeMUaxd
         uIRaM0fbAuVNwACeMcYFSnskoD4WLbAjJ6pKQQgMLxWR2+lLjuLHcAGTp4aAbWIRtYJW
         3551EQseelPVIMJT6FnMQxhg6T4ykk3pWltDxyaLggSIZUuAbhHzO1wIa5jbQaBFQgt7
         qI3jbdb4c/wgjgZ3q/kAUI7MlT9I4BmrBLi0oL6emoaifnySjjsMvwzWpCWgyRS3601G
         D/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ipLIvxmXFEp/52jBUxtNr8uo8Uz63NhczbFOPgGp9eU=;
        b=OCSEy6eqpe56yoTvkW3foQb2poU5HmXnT1o4BvZB8QywoQok8kaIPJUqD1zLsaJnJx
         ufnUczxGBtiVhrJ9WkbCLiv7LZy1WvlGtmFrDu7o3lDBwl1/cHt8m3WCtOLob8YoVtTZ
         wiChCpWcUtYbX5ZfgFMmpzCACbHl9LdgzK03pw5O/nf/aNTC7E+TtEtWKdBONdB0jWcb
         IGKDjDHpLSNgiGli1n9f/rvBSrL6ELJlZzj6LQFjXv6s/iuN701J9UX2hh73LMc1NwaQ
         oegcrG0vXUmZgKOIjD2eT1FqK82vdXBABbeM3urvYqxfEanbTytroeOU1VnkZUqxSKXO
         ZN8w==
X-Gm-Message-State: AOAM5301/uSelphmUXKS+hNlfJKNsWyFXY6BarOtBljgbSgKwCHLw9+0
        5KtofYhAQhvdY9PMJc0nuaZbiYH1gz3bkA==
X-Google-Smtp-Source: ABdhPJzmA4dYYtXSdm/OyaWI16VRIdgPYeM8m1tOcJXdtvAGqrGftYKHioOd2wyON9GGzRrJCvn5VA==
X-Received: by 2002:a17:90a:ba8b:: with SMTP id t11mr20633656pjr.177.1615126508506;
        Sun, 07 Mar 2021 06:15:08 -0800 (PST)
Received: from [172.30.1.19] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id z2sm7690268pfa.121.2021.03.07.06.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Mar 2021 06:15:07 -0800 (PST)
Subject: Re: [PATCH v3 1/4] devfreq: Register devfreq as a cooling device on
 demand
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, steven.price@arm.com,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20210307094519.9032-1-daniel.lezcano@linaro.org>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <63c715bf-5bae-4251-f826-baa81b1d3e1c@gmail.com>
Date:   Sun, 7 Mar 2021 23:15:03 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210307094519.9032-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21. 3. 7. 오후 6:45, Daniel Lezcano wrote:
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
>   V3:
>     - Rebased on linux-pm branch without units.h
>     - Set the cdev to NULL in case of error
>     - Added description for the cdev field in the devfreq structure
>   V2:
>     - Added is_cooling_device boolean in profile structure
>     - Register cooling device when the is_cooling_device boolean is set
>     - Remove devfreq cooling device registration in the backend drivers
>   V1:
>     - Register devfreq as a cooling device unconditionnally
> ---
>   drivers/devfreq/devfreq.c | 13 +++++++++++++
>   include/linux/devfreq.h   |  8 ++++++++
>   2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index bf3047896e41..cf64aeec468f 100644
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
> +#include <linux/thermal.h>
>   #include "governor.h"
>   
>   #define CREATE_TRACE_POINTS
> @@ -935,6 +937,15 @@ struct devfreq *devfreq_add_device(struct device *dev,
>   
>   	mutex_unlock(&devfreq_list_lock);
>   
> +	if (devfreq->profile->is_cooling_device) {
> +		devfreq->cdev = devfreq_cooling_em_register(devfreq, NULL);
> +		if (IS_ERR(devfreq->cdev)) {
> +			dev_info(dev, "Failed to register devfreq "
> +				 "cooling device\n");
> +			devfreq->cdev = NULL;
> +		}
> +	}
> +
>   	return devfreq;
>   
>   err_init:
> @@ -960,6 +971,8 @@ int devfreq_remove_device(struct devfreq *devfreq)
>   	if (!devfreq)
>   		return -EINVAL;
>   
> +	thermal_cooling_device_unregister(devfreq->cdev);

I have a question. Why don't you use devfreq_cooling_unregister()?
When thermal_cooling_device_unregister(), how can we remove
the pm_qos_request of devfreq device?

> +
>   	if (devfreq->governor) {
>   		devfreq->governor->event_handler(devfreq,
>   						 DEVFREQ_GOV_STOP, NULL);
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 26ea0850be9b..aba7ace11b72 100644
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
> @@ -156,6 +160,7 @@ struct devfreq_stats {
>    * @suspend_count:	 suspend requests counter for a device.
>    * @stats:	Statistics of devfreq device behavior
>    * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER notifier
> + * @cdev:	Cooling device pointer if the devfreq has cooling property
>    * @nb_min:		Notifier block for DEV_PM_QOS_MIN_FREQUENCY
>    * @nb_max:		Notifier block for DEV_PM_QOS_MAX_FREQUENCY
>    *
> @@ -198,6 +203,9 @@ struct devfreq {
>   
>   	struct srcu_notifier_head transition_notifier_list;
>   
> +	/* Pointer to the cooling device if used for thermal mitigation */
> +	struct thermal_cooling_device *cdev;
> +
>   	struct notifier_block nb_min;
>   	struct notifier_block nb_max;
>   };
> 


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
