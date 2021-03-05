Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5591A32E36B
	for <lists+linux-pm@lfdr.de>; Fri,  5 Mar 2021 09:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbhCEIMA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Mar 2021 03:12:00 -0500
Received: from foss.arm.com ([217.140.110.172]:49198 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229464AbhCEILl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Mar 2021 03:11:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCEC9D6E;
        Fri,  5 Mar 2021 00:11:40 -0800 (PST)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 212A63F73B;
        Fri,  5 Mar 2021 00:11:37 -0800 (PST)
Subject: Re: [PATCH] devfreq: Register devfreq as a cooling device
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, cwchoi00@gmail.com,
        kyungmin.park@samsung.com, myungjoo.ham@samsung.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        "open list:DRM DRIVERS FOR LIMA" <dri-devel@lists.freedesktop.org>,
        "moderated list:DRM DRIVERS FOR LIMA" <lima@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>
References: <20210304125034.28404-1-daniel.lezcano@linaro.org>
From:   Steven Price <steven.price@arm.com>
Message-ID: <23db1b13-9418-91f5-4871-f45b983f6e3c@arm.com>
Date:   Fri, 5 Mar 2021 08:12:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210304125034.28404-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04/03/2021 12:50, Daniel Lezcano wrote:
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
[...]
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

You've removed all references to pfdevfreq->cooling, so please also 
remove the member from struct panfrost_devfreq (as already done with 
lima and msm).

Thanks,

Steve
