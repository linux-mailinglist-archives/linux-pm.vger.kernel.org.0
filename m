Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49B1714C996
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2020 12:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgA2L22 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jan 2020 06:28:28 -0500
Received: from foss.arm.com ([217.140.110.172]:39784 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgA2L22 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Jan 2020 06:28:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E91B51FB;
        Wed, 29 Jan 2020 03:28:27 -0800 (PST)
Received: from [10.37.12.123] (unknown [10.37.12.123])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 365443F67D;
        Wed, 29 Jan 2020 03:28:25 -0800 (PST)
Subject: Re: [PATCH 2/2] PM / devfreq: Change to DEVFREQ_GOV_UPDATE_INTERVAL
 event name
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
References: <20200129112002.6998-1-cw00.choi@samsung.com>
 <CGME20200129111225epcas1p1c262e46a878ad68836a676bc351840bf@epcas1p1.samsung.com>
 <20200129112002.6998-2-cw00.choi@samsung.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <bc60b915-1975-b623-6b85-fc034cf649f3@arm.com>
Date:   Wed, 29 Jan 2020 11:28:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200129112002.6998-2-cw00.choi@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

Apart from small mistakes in the commit message, looks good to me.

On 1/29/20 11:20 AM, Chanwoo Choi wrote:
> DEVFREQ_GOV_INTERVAL event indicates that update the interval
> for polling mode of devfreq device. But, this event name doesn't
> specify exactly what to do.
> 
> Change DEVFREQ_GOV_INTERVAL event name to DEVFREQ_GOV_UPDATE_INTERVAL
> which specifies what to do by event name.
> 
> And modify the functio name for DEVFREQ_GOV_UPDATE_INTERVAL

s/functio/function

> with 'devfreq_' prefix + verb + obejct as following:

'obejct'?

> - devfreq_interval_update -> devfreq_updatee_interval
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>   drivers/devfreq/devfreq.c                 | 10 +++++-----
>   drivers/devfreq/governor.h                |  4 ++--
>   drivers/devfreq/governor_simpleondemand.c |  4 ++--
>   drivers/devfreq/tegra30-devfreq.c         |  4 ++--
>   4 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index cceee8bc3c2f..8494c5f05a73 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -550,14 +550,14 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
>   EXPORT_SYMBOL(devfreq_monitor_resume);
>   
>   /**
> - * devfreq_interval_update() - Update device devfreq monitoring interval
> + * devfreq_update_interval() - Update device devfreq monitoring interval
>    * @devfreq:    the devfreq instance.
>    * @delay:      new polling interval to be set.
>    *
>    * Helper function to set new load monitoring polling interval. Function
> - * to be called from governor in response to DEVFREQ_GOV_INTERVAL event.
> + * to be called from governor in response to DEVFREQ_GOV_UPDATE_INTERVAL event.
>    */
> -void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
> +void devfreq_update_interval(struct devfreq *devfreq, unsigned int *delay)
>   {
>   	unsigned int cur_delay = devfreq->profile->polling_ms;
>   	unsigned int new_delay = *delay;
> @@ -597,7 +597,7 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
>   out:
>   	mutex_unlock(&devfreq->lock);
>   }
> -EXPORT_SYMBOL(devfreq_interval_update);
> +EXPORT_SYMBOL(devfreq_update_interval);
>   
>   /**
>    * devfreq_notifier_call() - Notify that the device frequency requirements
> @@ -1426,7 +1426,7 @@ static ssize_t polling_interval_store(struct device *dev,
>   	if (ret != 1)
>   		return -EINVAL;
>   
> -	df->governor->event_handler(df, DEVFREQ_GOV_INTERVAL, &value);
> +	df->governor->event_handler(df, DEVFREQ_GOV_UPDATE_INTERVAL, &value);
>   	ret = count;
>   
>   	return ret;
> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
> index 5ba3e051b1d0..c07ce77c253d 100644
> --- a/drivers/devfreq/governor.h
> +++ b/drivers/devfreq/governor.h
> @@ -18,7 +18,7 @@
>   /* Devfreq events */
>   #define DEVFREQ_GOV_START			0x1
>   #define DEVFREQ_GOV_STOP			0x2
> -#define DEVFREQ_GOV_INTERVAL			0x3
> +#define DEVFREQ_GOV_UPDATE_INTERVAL		0x3
>   #define DEVFREQ_GOV_SUSPEND			0x4
>   #define DEVFREQ_GOV_RESUME			0x5
>   
> @@ -61,7 +61,7 @@ void devfreq_monitor_start(struct devfreq *devfreq);
>   void devfreq_monitor_stop(struct devfreq *devfreq);
>   void devfreq_monitor_suspend(struct devfreq *devfreq);
>   void devfreq_monitor_resume(struct devfreq *devfreq);
> -void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay);
> +void devfreq_update_interval(struct devfreq *devfreq, unsigned int *delay);
>   
>   int devfreq_add_governor(struct devfreq_governor *governor);
>   int devfreq_remove_governor(struct devfreq_governor *governor);
> diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
> index 3d809f228619..1b314e1df028 100644
> --- a/drivers/devfreq/governor_simpleondemand.c
> +++ b/drivers/devfreq/governor_simpleondemand.c
> @@ -96,8 +96,8 @@ static int devfreq_simple_ondemand_handler(struct devfreq *devfreq,
>   		devfreq_monitor_stop(devfreq);
>   		break;
>   
> -	case DEVFREQ_GOV_INTERVAL:
> -		devfreq_interval_update(devfreq, (unsigned int *)data);
> +	case DEVFREQ_GOV_UPDATE_INTERVAL:
> +		devfreq_update_interval(devfreq, (unsigned int *)data);
>   		break;
>   
>   	case DEVFREQ_GOV_SUSPEND:
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 0b65f89d74d5..28b2c7ca416e 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -734,7 +734,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
>   		devfreq_monitor_stop(devfreq);
>   		break;
>   
> -	case DEVFREQ_GOV_INTERVAL:
> +	case DEVFREQ_GOV_UPDATE_INTERVAL:
>   		/*
>   		 * ACTMON hardware supports up to 256 milliseconds for the
>   		 * sampling period.
> @@ -745,7 +745,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
>   		}
>   
>   		tegra_actmon_pause(tegra);
> -		devfreq_interval_update(devfreq, new_delay);
> +		devfreq_update_interval(devfreq, new_delay);
>   		ret = tegra_actmon_resume(tegra);
>   		break;
>   
> 


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>


Regards,
Lukasz
