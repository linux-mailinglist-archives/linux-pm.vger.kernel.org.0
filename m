Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39668330A8F
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 10:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhCHJv0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 04:51:26 -0500
Received: from foss.arm.com ([217.140.110.172]:35034 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230466AbhCHJvF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Mar 2021 04:51:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13933D6E;
        Mon,  8 Mar 2021 01:51:05 -0800 (PST)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7481E3F73C;
        Mon,  8 Mar 2021 01:51:03 -0800 (PST)
Subject: Re: [PATCH v5 3/4] PM / devfreq: panfrost: Use devfreq cooling device
 registration
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, cwchoi00@gmail.com
Cc:     lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:ARM MALI PANFROST DRM DRIVER" 
        <dri-devel@lists.freedesktop.org>
References: <20210308091646.28096-1-daniel.lezcano@linaro.org>
 <20210308091646.28096-3-daniel.lezcano@linaro.org>
From:   Steven Price <steven.price@arm.com>
Message-ID: <59627ba5-2602-73cd-c24c-b6695a4fd650@arm.com>
Date:   Mon, 8 Mar 2021 09:51:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210308091646.28096-3-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/03/2021 09:16, Daniel Lezcano wrote:
> The devfreq core code is able to register the devfreq device as a
> cooling device if the 'is_cooling_device' flag is set in the profile.
> 
> Use this flag and remove the cooling device registering code.
> 
> Tested on rock960.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>   drivers/gpu/drm/panfrost/panfrost_devfreq.c | 14 +-------------
>   drivers/gpu/drm/panfrost/panfrost_devfreq.h |  3 ---
>   2 files changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> index 56b3f5935703..4d96edf1bc54 100644
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
> @@ -80,6 +79,7 @@ static struct devfreq_dev_profile panfrost_devfreq_profile = {
>   	.polling_ms = 50, /* ~3 frames */
>   	.target = panfrost_devfreq_target,
>   	.get_dev_status = panfrost_devfreq_get_dev_status,
> +	.is_cooling_device = true,
>   };
>   
>   int panfrost_devfreq_init(struct panfrost_device *pfdev)
> @@ -90,7 +90,6 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>   	struct device *dev = &pfdev->pdev->dev;
>   	struct devfreq *devfreq;
>   	struct opp_table *opp_table;
> -	struct thermal_cooling_device *cooling;
>   	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
>   
>   	opp_table = dev_pm_opp_set_regulators(dev, pfdev->comp->supply_names,
> @@ -139,12 +138,6 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
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
> @@ -156,11 +149,6 @@ void panfrost_devfreq_fini(struct panfrost_device *pfdev)
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
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.h b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
> index db6ea48e21f9..470f5c974703 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
> @@ -9,14 +9,11 @@
>   
>   struct devfreq;
>   struct opp_table;
> -struct thermal_cooling_device;
> -
>   struct panfrost_device;
>   
>   struct panfrost_devfreq {
>   	struct devfreq *devfreq;
>   	struct opp_table *regulators_opp_table;
> -	struct thermal_cooling_device *cooling;
>   	bool opp_of_table_added;
>   
>   	ktime_t busy_time;
> 

