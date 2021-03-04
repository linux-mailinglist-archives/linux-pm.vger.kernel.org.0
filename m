Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF84932D60F
	for <lists+linux-pm@lfdr.de>; Thu,  4 Mar 2021 16:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbhCDPHc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Mar 2021 10:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbhCDPHD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Mar 2021 10:07:03 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F9EC061756;
        Thu,  4 Mar 2021 07:06:23 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id t29so19118577pfg.11;
        Thu, 04 Mar 2021 07:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/QrIaJJECqAQuVCu6ecLBggrZjnStxzCneNlAu9rQH0=;
        b=WNrllo6qutFLtKmW2zMn9wyg58xipjSAugZEZVwBPLSd5w6dwxFM/fup2Vjfwx9NA0
         7+y+dS5WOKHFqlsZg/BPmT/boSCvksDlz1+HSCjWJ0OOli1cfXyC4KG3R2SxyLpP2yU0
         JJY/U1O8I//nVi2vBqFJuI4/+Z70tJHzxs0xj2U2bMMsrfk1B9DrNXa5IbzwXgiuoE/z
         FVoo3Cul2tkebCvyEVoxB9T/wtCM5W/FVi9clMKAe2iD6r+y84XgeizcKAXJg8n0+8dI
         iAPOxLlQzQGrpicjAYGG0iGhVHbObg/8FD2hkfzqbTz4PDgtR76CDUHMyk5C7KnbqD1x
         BypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/QrIaJJECqAQuVCu6ecLBggrZjnStxzCneNlAu9rQH0=;
        b=BSbcFtdJHAZfVuiYnvHppExLhfRfGiUSYl/uoDNKgYL4iMrWja8WxJ6b/d2mG7hVGK
         UojdkCYVkXPNNOoZDxmub+slWjPt4m+zdWwUffpV9k3BZ6LOT709RcZ/KmRxe5nXlR0p
         pM/w2MC0cdtUAeZivHGs8ys51NQn4ng+nVn5OD84OXeB6QtY5RlqoT36lbYo79r3yLO9
         QfuJ0Kvoxl4kRgApAyOs9LjthN7wuZPIR/hk+zT7twJ0AJ4EmfpATfol4rsuYlD7hHzw
         mpgffHIqv86bW+WtCEf1oYV88AbjTp3PEo/W/KMkH+BAT9FrZLDV6j6KQoJigzIePqk2
         iBlQ==
X-Gm-Message-State: AOAM533Ir6RkMG1QE+GttXc+LanT9DRjbJ03kepbpDNWaB6LjkXyxvDZ
        WpRh2mJ2D+RhfrywcSUTMtM=
X-Google-Smtp-Source: ABdhPJyhYfIzEnbnLJQBpi6jN7iB+nLoCLGnVtstYnd8ZUUyttHXqjaIk2Afe9h8M1lyqLaJ3yZ/bw==
X-Received: by 2002:a62:2746:0:b029:1ec:df4a:3a8 with SMTP id n67-20020a6227460000b02901ecdf4a03a8mr4199041pfn.15.1614870382377;
        Thu, 04 Mar 2021 07:06:22 -0800 (PST)
Received: from [172.30.1.19] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id a9sm9838656pjq.17.2021.03.04.07.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 07:06:21 -0800 (PST)
Subject: Re: [PATCH] devfreq: Register devfreq as a cooling device
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        kyungmin.park@samsung.com, myungjoo.ham@samsung.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        "open list:DRM DRIVERS FOR LIMA" <dri-devel@lists.freedesktop.org>,
        "moderated list:DRM DRIVERS FOR LIMA" <lima@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>
References: <20210304125034.28404-1-daniel.lezcano@linaro.org>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <97e495cb-c685-e163-0909-0311530a5332@gmail.com>
Date:   Fri, 5 Mar 2021 00:06:13 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210304125034.28404-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

As Lukasz's comment, actually some devfreq devices like memory bus
might not affect the thermal critically. In the mainline,
there are four types devfreq as following:
1. GPU
2. UFS Storage
3. DMC (Memory Controller)
4. Memory bus like AMBA AXI

I think that you can specify this devfreq device will be used
for cooling device by editing the devfreq_dev_profile structure.

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index bf3047896e41..77966a17d03f 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -935,6 +935,13 @@ struct devfreq *devfreq_add_device(struct device *dev,

         mutex_unlock(&devfreq_list_lock);

+       if (devfreq->profile->is_cooling_device) {
+               devfreq->cdev = devfreq_cooling_em_register(devfreq, NULL);
+               if (IS_ERR(devfreq->cdev))
+                       dev_info(dev,
+                               "Failed to register devfreq cooling 
device\n");
+       }
+
         return devfreq;

  err_init:
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 26ea0850be9b..26dc69f1047b 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -103,6 +103,7 @@ struct devfreq_dev_profile {
         unsigned long initial_freq;
         unsigned int polling_ms;
         enum devfreq_timer timer;
+       bool is_cooling_device;

         int (*target)(struct device *dev, unsigned long *freq, u32 flags);
         int (*get_dev_status)(struct device *dev,


Thanks
Chanwoo Choi

On 21. 3. 4. 오후 9:50, Daniel Lezcano wrote:
> Currently the default behavior is to manually having the devfreq
> backend to register themselves as a devfreq cooling device.
> 
> There are no so many and actually it makes more sense to register the
> devfreq device when adding it.
> 
> Consequently, every devfreq becomes a cooling device like cpufreq is.
> 
> Having a devfreq being registered as a cooling device can not mitigate
> a thermal zone if it is not bound to this one. Thus, the current
> configurations are not impacted by this change.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/devfreq/devfreq.c                   |  8 ++++++++
>   drivers/gpu/drm/lima/lima_devfreq.c         | 13 -------------
>   drivers/gpu/drm/lima/lima_devfreq.h         |  2 --
>   drivers/gpu/drm/msm/msm_gpu.c               | 11 -----------
>   drivers/gpu/drm/msm/msm_gpu.h               |  2 --
>   drivers/gpu/drm/panfrost/panfrost_devfreq.c | 13 -------------
>   include/linux/devfreq.h                     |  3 +++
>   7 files changed, 11 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index b6d63f02d293..19149b31b000 100644
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
>   #include <linux/units.h>
>   #include "governor.h"
>   
> @@ -935,6 +937,10 @@ struct devfreq *devfreq_add_device(struct device *dev,
>   
>   	mutex_unlock(&devfreq_list_lock);
>   
> +	devfreq->cdev = devfreq_cooling_em_register(devfreq, NULL);
> +	if (IS_ERR(devfreq->cdev))
> +		dev_info(dev, "Failed to register devfreq cooling device\n");
> +
>   	return devfreq;
>   
>   err_init:
> @@ -960,6 +966,8 @@ int devfreq_remove_device(struct devfreq *devfreq)
>   	if (!devfreq)
>   		return -EINVAL;
>   
> +	thermal_cooling_device_unregister(devfreq->cdev);
> +
>   	if (devfreq->governor) {
>   		devfreq->governor->event_handler(devfreq,
>   						 DEVFREQ_GOV_STOP, NULL);
> diff --git a/drivers/gpu/drm/lima/lima_devfreq.c b/drivers/gpu/drm/lima/lima_devfreq.c
> index 5686ad4aaf7c..a696eff1642c 100644
> --- a/drivers/gpu/drm/lima/lima_devfreq.c
> +++ b/drivers/gpu/drm/lima/lima_devfreq.c
> @@ -7,7 +7,6 @@
>    */
>   #include <linux/clk.h>
>   #include <linux/devfreq.h>
> -#include <linux/devfreq_cooling.h>
>   #include <linux/device.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm_opp.h>
> @@ -90,11 +89,6 @@ void lima_devfreq_fini(struct lima_device *ldev)
>   {
>   	struct lima_devfreq *devfreq = &ldev->devfreq;
>   
> -	if (devfreq->cooling) {
> -		devfreq_cooling_unregister(devfreq->cooling);
> -		devfreq->cooling = NULL;
> -	}
> -
>   	if (devfreq->devfreq) {
>   		devm_devfreq_remove_device(ldev->dev, devfreq->devfreq);
>   		devfreq->devfreq = NULL;
> @@ -110,7 +104,6 @@ void lima_devfreq_fini(struct lima_device *ldev)
>   
>   int lima_devfreq_init(struct lima_device *ldev)
>   {
> -	struct thermal_cooling_device *cooling;
>   	struct device *dev = ldev->dev;
>   	struct opp_table *opp_table;
>   	struct devfreq *devfreq;
> @@ -173,12 +166,6 @@ int lima_devfreq_init(struct lima_device *ldev)
>   
>   	ldevfreq->devfreq = devfreq;
>   
> -	cooling = of_devfreq_cooling_register(dev->of_node, devfreq);
> -	if (IS_ERR(cooling))
> -		dev_info(dev, "Failed to register cooling device\n");
> -	else
> -		ldevfreq->cooling = cooling;
> -
>   	return 0;
>   
>   err_fini:
> diff --git a/drivers/gpu/drm/lima/lima_devfreq.h b/drivers/gpu/drm/lima/lima_devfreq.h
> index 2d9b3008ce77..c43a2069e5d3 100644
> --- a/drivers/gpu/drm/lima/lima_devfreq.h
> +++ b/drivers/gpu/drm/lima/lima_devfreq.h
> @@ -9,7 +9,6 @@
>   
>   struct devfreq;
>   struct opp_table;
> -struct thermal_cooling_device;
>   
>   struct lima_device;
>   
> @@ -17,7 +16,6 @@ struct lima_devfreq {
>   	struct devfreq *devfreq;
>   	struct opp_table *clkname_opp_table;
>   	struct opp_table *regulators_opp_table;
> -	struct thermal_cooling_device *cooling;
>   
>   	ktime_t busy_time;
>   	ktime_t idle_time;
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index ab7c167b0623..d7f80ebfe9df 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -14,7 +14,6 @@
>   #include <generated/utsrelease.h>
>   #include <linux/string_helpers.h>
>   #include <linux/devfreq.h>
> -#include <linux/devfreq_cooling.h>
>   #include <linux/devcoredump.h>
>   #include <linux/sched/task.h>
>   
> @@ -112,14 +111,6 @@ static void msm_devfreq_init(struct msm_gpu *gpu)
>   	}
>   
>   	devfreq_suspend_device(gpu->devfreq.devfreq);
> -
> -	gpu->cooling = of_devfreq_cooling_register(gpu->pdev->dev.of_node,
> -			gpu->devfreq.devfreq);
> -	if (IS_ERR(gpu->cooling)) {
> -		DRM_DEV_ERROR(&gpu->pdev->dev,
> -				"Couldn't register GPU cooling device\n");
> -		gpu->cooling = NULL;
> -	}
>   }
>   
>   static int enable_pwrrail(struct msm_gpu *gpu)
> @@ -1056,6 +1047,4 @@ void msm_gpu_cleanup(struct msm_gpu *gpu)
>   	if (gpu->worker) {
>   		kthread_destroy_worker(gpu->worker);
>   	}
> -
> -	devfreq_cooling_unregister(gpu->cooling);
>   }
> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> index d7cd02cd2109..93419368bac8 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -155,8 +155,6 @@ struct msm_gpu {
>   	struct msm_gpu_state *crashstate;
>   	/* True if the hardware supports expanded apriv (a650 and newer) */
>   	bool hw_apriv;
> -
> -	struct thermal_cooling_device *cooling;
>   };
>   
>   static inline struct msm_gpu *dev_to_gpu(struct device *dev)
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> index 56b3f5935703..2cb6300de1f1 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -3,7 +3,6 @@
>   
>   #include <linux/clk.h>
>   #include <linux/devfreq.h>
> -#include <linux/devfreq_cooling.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm_opp.h>
>   
> @@ -90,7 +89,6 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>   	struct device *dev = &pfdev->pdev->dev;
>   	struct devfreq *devfreq;
>   	struct opp_table *opp_table;
> -	struct thermal_cooling_device *cooling;
>   	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
>   
>   	opp_table = dev_pm_opp_set_regulators(dev, pfdev->comp->supply_names,
> @@ -139,12 +137,6 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>   	}
>   	pfdevfreq->devfreq = devfreq;
>   
> -	cooling = devfreq_cooling_em_register(devfreq, NULL);
> -	if (IS_ERR(cooling))
> -		DRM_DEV_INFO(dev, "Failed to register cooling device\n");
> -	else
> -		pfdevfreq->cooling = cooling;
> -
>   	return 0;
>   
>   err_fini:
> @@ -156,11 +148,6 @@ void panfrost_devfreq_fini(struct panfrost_device *pfdev)
>   {
>   	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
>   
> -	if (pfdevfreq->cooling) {
> -		devfreq_cooling_unregister(pfdevfreq->cooling);
> -		pfdevfreq->cooling = NULL;
> -	}
> -
>   	if (pfdevfreq->opp_of_table_added) {
>   		dev_pm_opp_of_remove_table(&pfdev->pdev->dev);
>   		pfdevfreq->opp_of_table_added = false;
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 26ea0850be9b..690bd4affe18 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -198,6 +198,9 @@ struct devfreq {
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
