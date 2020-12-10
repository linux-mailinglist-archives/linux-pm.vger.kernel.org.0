Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99A62D6210
	for <lists+linux-pm@lfdr.de>; Thu, 10 Dec 2020 17:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390903AbgLJQDc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 11:03:32 -0500
Received: from foss.arm.com ([217.140.110.172]:49990 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389812AbgLJQD3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Dec 2020 11:03:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E2B51FB;
        Thu, 10 Dec 2020 08:02:42 -0800 (PST)
Received: from [10.57.1.60] (unknown [10.57.1.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E05B33F68F;
        Thu, 10 Dec 2020 08:02:40 -0800 (PST)
Subject: Re: [PATCH v2 3/4] thermal/core: Use precomputed jiffies for the
 polling
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, amitk@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20201207190902.30464-1-daniel.lezcano@linaro.org>
 <20201207190902.30464-3-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <76044831-8bdb-ad27-ccb4-73523cad757a@arm.com>
Date:   Thu, 10 Dec 2020 16:02:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201207190902.30464-3-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 12/7/20 7:09 PM, Daniel Lezcano wrote:
> The delays are also stored in jiffies based unit. Use them instead of
> the ms.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/thermal/thermal_core.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 08c6e4e36896..16ef5d652d85 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -291,14 +291,9 @@ static int __init thermal_register_governors(void)
>   static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
>   					    int delay)
>   {
> -	if (delay > 1000)
> +	if (delay)
>   		mod_delayed_work(system_freezable_power_efficient_wq,
> -				 &tz->poll_queue,
> -				 round_jiffies(msecs_to_jiffies(delay)));
> -	else if (delay)
> -		mod_delayed_work(system_freezable_power_efficient_wq,
> -				 &tz->poll_queue,
> -				 msecs_to_jiffies(delay));
> +				 &tz->poll_queue, delay);
>   	else
>   		cancel_delayed_work(&tz->poll_queue);
>   }
> @@ -317,9 +312,9 @@ static void monitor_thermal_zone(struct thermal_zone_device *tz)
>   	mutex_lock(&tz->lock);
>   
>   	if (!stop && tz->passive)
> -		thermal_zone_device_set_polling(tz, tz->passive_delay_ms);
> +		thermal_zone_device_set_polling(tz, tz->passive_delay_jiffies);
>   	else if (!stop && tz->polling_delay_ms)
> -		thermal_zone_device_set_polling(tz, tz->polling_delay_ms);
> +		thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);
>   	else
>   		thermal_zone_device_set_polling(tz, 0);
>   
> 


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
