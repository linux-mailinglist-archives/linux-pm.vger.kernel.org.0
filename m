Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99CF2D27CF
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 10:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbgLHJhq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 04:37:46 -0500
Received: from foss.arm.com ([217.140.110.172]:46318 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbgLHJhq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Dec 2020 04:37:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A791130E;
        Tue,  8 Dec 2020 01:37:00 -0800 (PST)
Received: from [10.57.1.242] (unknown [10.57.1.242])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD07A3F68F;
        Tue,  8 Dec 2020 01:36:58 -0800 (PST)
Subject: Re: [PATCH] thermal/core: Emit a warning if the thermal zone is
 updated without ops
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, Thara Gopinath <thara.gopinath@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201207190530.30334-1-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <2b8ce280-cb91-fb23-d19a-00dcee2a3e5a@arm.com>
Date:   Tue, 8 Dec 2020 09:36:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201207190530.30334-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On 12/7/20 7:05 PM, Daniel Lezcano wrote:
> The actual code is silently ignoring a thermal zone update when a
> driver is requesting it without a get_temp ops set.
> 
> That looks not correct, as the caller should not have called this
> function if the thermal zone is unable to read the temperature.
> 
> That makes the code less robust as the check won't detect the driver
> is inconsistently using the thermal API and that does not help to
> improve the framework as these circumvolutions hide the problem at the
> source.

Make sense.

> 
> In order to detect the situation when it happens, let's add a warning
> when the update is requested without the get_temp() ops set.
> 
> Any warning emitted will have to be fixed at the source of the
> problem: the caller must not call thermal_zone_device_update if there
> is not get_temp callback set.
> 
> As the check is done in thermal_zone_get_temperature() via the
> update_temperature() function, it is pointless to have the check and
> the WARN in the thermal_zone_device_update() function. Just remove the
> check and let the next call to raise the warning.
> 
> Cc: Thara Gopinath <thara.gopinath@linaro.org>
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/thermal/thermal_core.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 90e38cc199f4..1bd23ff2247b 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -448,17 +448,17 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
>   	monitor_thermal_zone(tz);
>   }
>   
> -static void update_temperature(struct thermal_zone_device *tz)
> +static int update_temperature(struct thermal_zone_device *tz)
>   {
>   	int temp, ret;
>   
>   	ret = thermal_zone_get_temp(tz, &temp);
>   	if (ret) {
>   		if (ret != -EAGAIN)
> -			dev_warn(&tz->device,
> -				 "failed to read out thermal zone (%d)\n",
> -				 ret);
> -		return;
> +			dev_warn_once(&tz->device,
> +				      "failed to read out thermal zone (%d)\n",
> +				      ret);
> +		return ret;
>   	}
>   
>   	mutex_lock(&tz->lock);
> @@ -469,6 +469,8 @@ static void update_temperature(struct thermal_zone_device *tz)
>   	trace_thermal_temperature(tz);
>   
>   	thermal_genl_sampling_temp(tz->id, temp);
> +
> +	return 0;
>   }
>   
>   static void thermal_zone_device_init(struct thermal_zone_device *tz)
> @@ -553,11 +555,9 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
>   	if (atomic_read(&in_suspend))
>   		return;
>   
> -	if (!tz->ops->get_temp)
> +	if (update_temperature(tz))
>   		return;
>   
> -	update_temperature(tz);
> -

I think the patch does a bit more. Previously we continued running the
code below even when the thermal_zone_get_temp() returned an error (due
to various reasons). Now we stop and probably would not schedule next
polling, not calling:
handle_thermal_trip() and monitor_thermal_zone()

I would left update_temperature(tz) as it was and not check the return.
The function thermal_zone_get_temp() can protect itself from missing
tz->ops->get_temp(), so we should be safe.

What do you think?

Regards,
Lukasz
