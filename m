Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC9A367BA0
	for <lists+linux-pm@lfdr.de>; Thu, 22 Apr 2021 09:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbhDVH7Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Apr 2021 03:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhDVH7Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Apr 2021 03:59:24 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F2AC06138B
        for <linux-pm@vger.kernel.org>; Thu, 22 Apr 2021 00:58:48 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m9so31046530wrx.3
        for <linux-pm@vger.kernel.org>; Thu, 22 Apr 2021 00:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kf6gsxqxNpN3Lm3SbeRjTYefxpY3XJBMkCmIX6J25y4=;
        b=PYul1bn3yexdXahhBqWZTF/Sa1sV9GlStt10ZBj9QH7RNxxi7o/QdCG4X37Qn1KNLf
         8GeHvMD+q2WaJkHFDWmZ1jU30AHsW5RyXpgbi+6Xo6ohjW4u2HvJSMQhtLLcoesYarjr
         +NfR3T+9KQpleMiJOFRt9/2JCzVsPuq0fCglvITtUFihTstUMlf9s/ZZyD4QgZgMcefj
         /QFiWR3zYzaadScM3lwGtMQ/H4e9tpvenCHUacZMmyrnhqOv7Q1PXPZ4IV40H1iA45SI
         5Dqt+jtYroWYb/VnywRnmKj9dzPzm0xdl9GbgVc3eQ2KI7j2ILxDsGMeY5+i12RrsIX/
         Lb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kf6gsxqxNpN3Lm3SbeRjTYefxpY3XJBMkCmIX6J25y4=;
        b=cjOdDqHhO3et5qjotmr9VnouVN9ewAGZEKcKO8vBh4hDB92eNU4t46qx+ibQhvBKYR
         tMLAyzqQrBvwSU6OUxDC8dnV+a/Drb6r7tlq0rKXM25PUswXWZPfITiYEZ1HTj9Pzz1Z
         8Q2sTNMN8uBFexsr3bswiCcb4Q100/+4a9+IXlsQxPa7+p/edVJ4yUKLTNGlbC2p197s
         oDglL+4WCwZ6CHtIZpz1z7FtCHpeq261+71dSGFSLy7PwEDdJGiy2jZTK//Boobj2U8T
         QACQBhnD80BT1TBu+pUcxmhEcecrLqG1RxC8JrjvXzYisGl1M1b14/LcN9o8l3NZfWq2
         pSew==
X-Gm-Message-State: AOAM530042PBpeHPoCGSO/vcaWNc8mlmFQpdDK+IJfVuMJeRbCVn2VKz
        GVInBbT4rYC0i9rDct0jMSR2CA==
X-Google-Smtp-Source: ABdhPJxVgtke38xD1dnxDE+rhklJfkCiRbSCSBv7OOAz4ajCMImvrFxR7SU6+HHGbAnk9sTNqJdJhQ==
X-Received: by 2002:adf:f588:: with SMTP id f8mr2409505wro.277.1619078326991;
        Thu, 22 Apr 2021 00:58:46 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:e88d:2580:c20:b786? ([2a01:e34:ed2f:f020:e88d:2580:c20:b786])
        by smtp.googlemail.com with ESMTPSA id t14sm2200498wrz.55.2021.04.22.00.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 00:58:46 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] thermal: create a helper __thermal_cdev_update()
 without a lock
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, amitk@kernel.org, rui.zhang@intel.com
References: <20210421174145.8213-1-lukasz.luba@arm.com>
 <20210421174145.8213-4-lukasz.luba@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <3d08d5cf-9e3b-ae26-cfd5-bf9a40d11643@linaro.org>
Date:   Thu, 22 Apr 2021 09:58:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210421174145.8213-4-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/04/2021 19:41, Lukasz Luba wrote:
> There is a need to have a helper function which updates cooling device
> state from the governors code. With this change governor can use
> lock and unlock while calling helper function. This avoid unnecessary
> second time lock/unlock which was in previous solution present in
> governor implementation. This new helper function must be called
> with mutex 'cdev->lock' hold.
> 
> The changed been discussed and part of code presented in thread:
> https://lore.kernel.org/linux-pm/20210419084536.25000-1-lukasz.luba@arm.com/
> 
> Co-developed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/gov_power_allocator.c |  5 +----
>  drivers/thermal/thermal_core.h        |  1 +
>  drivers/thermal/thermal_helpers.c     | 28 +++++++++++++++++----------

Why not add this patch first (without the ipa changes) and then replace
patch 2 by using the new function ? That will prevent to go back and forth.


>  3 files changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index f379f1aaa3b5..a6cdb2e892da 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -595,12 +595,9 @@ static void allow_maximum_power(struct thermal_zone_device *tz, bool update)
>  		cdev->ops->get_requested_power(cdev, &req_power);
>  
>  		if (update)
> -			instance->cdev->updated = false;
> +			__thermal_cdev_update(instance->cdev);
>  
>  		mutex_unlock(&instance->cdev->lock);
> -
> -		if (update)
> -			thermal_cdev_update(instance->cdev);
>  	}
>  	mutex_unlock(&tz->lock);
>  }
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index 86b8cef7310e..726e327b4205 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -66,6 +66,7 @@ static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev)
>  }
>  
>  void thermal_cdev_update(struct thermal_cooling_device *);
> +void __thermal_cdev_update(struct thermal_cooling_device *cdev);
>  
>  /**
>   * struct thermal_trip - representation of a point in temperature domain
> diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
> index 7f50f412e02a..3d7fd46104de 100644
> --- a/drivers/thermal/thermal_helpers.c
> +++ b/drivers/thermal/thermal_helpers.c
> @@ -192,18 +192,12 @@ static void thermal_cdev_set_cur_state(struct thermal_cooling_device *cdev,
>  	thermal_cooling_device_stats_update(cdev, target);
>  }
>  
> -void thermal_cdev_update(struct thermal_cooling_device *cdev)
> +
> +void __thermal_cdev_update(struct thermal_cooling_device *cdev)
>  {
>  	struct thermal_instance *instance;
>  	unsigned long target = 0;
>  
> -	mutex_lock(&cdev->lock);
> -	/* cooling device is updated*/
> -	if (cdev->updated) {
> -		mutex_unlock(&cdev->lock);
> -		return;
> -	}
> -
>  	/* Make sure cdev enters the deepest cooling state */
>  	list_for_each_entry(instance, &cdev->thermal_instances, cdev_node) {
>  		dev_dbg(&cdev->device, "zone%d->target=%lu\n",
> @@ -216,11 +210,25 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
>  
>  	thermal_cdev_set_cur_state(cdev, target);
>  
> -	cdev->updated = true;
> -	mutex_unlock(&cdev->lock);
>  	trace_cdev_update(cdev, target);
>  	dev_dbg(&cdev->device, "set to state %lu\n", target);
>  }
> +
> +/**
> + * thermal_cdev_update - update cooling device state if needed
> + * @cdev:	pointer to struct thermal_cooling_device
> + *
> + * Update the cooling device state if there is a need.
> + */
> +void thermal_cdev_update(struct thermal_cooling_device *cdev)
> +{
> +	mutex_lock(&cdev->lock);
> +	if (!cdev->updated) {
> +		__thermal_cdev_update(cdev);
> +		cdev->updated = true;
> +	}
> +	mutex_unlock(&cdev->lock);
> +}
>  EXPORT_SYMBOL(thermal_cdev_update);
>  
>  /**
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
