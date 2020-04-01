Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB4219A637
	for <lists+linux-pm@lfdr.de>; Wed,  1 Apr 2020 09:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731849AbgDAH3k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Apr 2020 03:29:40 -0400
Received: from foss.arm.com ([217.140.110.172]:44370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731680AbgDAH3k (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Apr 2020 03:29:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B82A31B;
        Wed,  1 Apr 2020 00:29:39 -0700 (PDT)
Received: from [10.37.12.63] (unknown [10.37.12.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB4DD3F52E;
        Wed,  1 Apr 2020 00:33:46 -0700 (PDT)
Subject: Re: [PATCH 2/2] thermal: core: Remove pointless debug traces
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200331165449.30355-1-daniel.lezcano@linaro.org>
 <20200331165449.30355-2-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <809b3d48-b8a9-75e6-aafc-0999e78611e2@arm.com>
Date:   Wed, 1 Apr 2020 08:29:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200331165449.30355-2-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On 3/31/20 5:54 PM, Daniel Lezcano wrote:
> The last temperature and the current temperature are show via a
> dev_debug. The line before, those temperature are also traced.
> 
> It is pointless to duplicate the traces for the temperatures,
> remove the dev_dbg traces.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/thermal/thermal_core.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 9a321dc548c8..c06550930979 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -447,12 +447,6 @@ static void update_temperature(struct thermal_zone_device *tz)
>   	mutex_unlock(&tz->lock);
>   
>   	trace_thermal_temperature(tz);
> -	if (tz->last_temperature == THERMAL_TEMP_INVALID)
> -		dev_dbg(&tz->device, "last_temperature N/A, current_temperature=%d\n",
> -			tz->temperature);
> -	else
> -		dev_dbg(&tz->device, "last_temperature=%d, current_temperature=%d\n",
> -			tz->last_temperature, tz->temperature);
>   }
>   
>   static void thermal_zone_device_init(struct thermal_zone_device *tz)
> 

This prints really deserve to be removed.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
