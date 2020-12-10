Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517282D60A8
	for <lists+linux-pm@lfdr.de>; Thu, 10 Dec 2020 16:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391137AbgLJOiO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 09:38:14 -0500
Received: from foss.arm.com ([217.140.110.172]:45598 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391130AbgLJOiF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Dec 2020 09:38:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB5B01FB;
        Thu, 10 Dec 2020 06:37:19 -0800 (PST)
Received: from [10.57.1.60] (unknown [10.57.1.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33D433F718;
        Thu, 10 Dec 2020 06:37:18 -0800 (PST)
Subject: Re: [PATCH 5/5] thermal/core: Remove notify ops
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com
Cc:     kai.heng.feng@canonical.com, srinivas.pandruvada@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>
References: <20201210121514.25760-1-daniel.lezcano@linaro.org>
 <20201210121514.25760-5-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <9f6eb881-5be5-fa91-e087-0b899c0cf639@arm.com>
Date:   Thu, 10 Dec 2020 14:37:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201210121514.25760-5-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 12/10/20 12:15 PM, Daniel Lezcano wrote:
> With the remove of the notify user in a previous patch, the ops is no
> longer needed, remove it.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/thermal/thermal_core.c | 3 ---
>   include/linux/thermal.h        | 2 --
>   2 files changed, 5 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index cee0b31b5cd7..d7481fdf4e4c 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -407,9 +407,6 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
>   
>   	trace_thermal_zone_trip(tz, trip, trip_type);
>   
> -	if (tz->ops->notify)
> -		tz->ops->notify(tz, trip, trip_type);
> -
>   	if (trip_type == THERMAL_TRIP_HOT && tz->ops->hot)
>   		tz->ops->hot(tz);
>   	else if (trip_type == THERMAL_TRIP_CRITICAL)
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 125c8a4d52e6..7e051b4cf715 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -77,8 +77,6 @@ struct thermal_zone_device_ops {
>   	int (*set_emul_temp) (struct thermal_zone_device *, int);
>   	int (*get_trend) (struct thermal_zone_device *, int,
>   			  enum thermal_trend *);
> -	int (*notify) (struct thermal_zone_device *, int,
> -		       enum thermal_trip_type);
>   	void (*hot)(struct thermal_zone_device *);
>   	void (*critical)(struct thermal_zone_device *);
>   };
> 

I couldn't find other users apart from those in patch 3/5 and 4/5.
I will leave to someone else to review those patches.
This patch looks good

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
