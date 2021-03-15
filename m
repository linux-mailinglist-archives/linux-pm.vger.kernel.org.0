Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B6033AF48
	for <lists+linux-pm@lfdr.de>; Mon, 15 Mar 2021 10:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhCOJvX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Mar 2021 05:51:23 -0400
Received: from foss.arm.com ([217.140.110.172]:56520 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229614AbhCOJvS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Mar 2021 05:51:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 347921FB;
        Mon, 15 Mar 2021 02:51:18 -0700 (PDT)
Received: from [10.57.12.51] (unknown [10.57.12.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 213063F70D;
        Mon, 15 Mar 2021 02:51:15 -0700 (PDT)
Subject: Re: [PATCH] thermal: power_allocator: using round the division when
 re-divvying up power
To:     gao.yunxiao6@gmail.com, daniel.lezcano@linaro.org
Cc:     rui.zhang@intel.com, amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, "jeson.gao" <jeson.gao@unisoc.com>
References: <1615796737-4688-1-git-send-email-gao.yunxiao6@gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <9c14451e-be6f-0713-4c26-8b67e1fa51a5@arm.com>
Date:   Mon, 15 Mar 2021 09:51:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1615796737-4688-1-git-send-email-gao.yunxiao6@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3/15/21 8:25 AM, gao.yunxiao6@gmail.com wrote:
> From: "jeson.gao" <jeson.gao@unisoc.com>
> 
> The division is used directly in re-divvying up power, the decimal part will
> be discarded, devices will get less than the extra_actor_power - 1.
> if using round the division to make the calculation more accurate.
> 
> For example:
> actor0 received more than it's max_power, it has the extra_power 759
> actor1 received less than it's max_power, it require extra_actor_power 395
> actor2 received less than it's max_power, it require extra_actor_power 365
> actor1 and actor2 require the total capped_extra_power 760
> 
> using division in re-divvying up power
> actor1 would actually get the extra_actor_power 394
> actor2 would actually get the extra_actor_power 364
> 
> if using round the division in re-divvying up power
> actor1 would actually get the extra_actor_power 394
> actor2 would actually get the extra_actor_power 365
> 
> Signed-off-by: Jeson Gao <jeson.gao@unisoc.com>
> ---
>   drivers/thermal/gov_power_allocator.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index 92acae53df49..2802a0e13c88 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -374,9 +374,11 @@ static void divvy_up_power(u32 *req_power, u32 *max_power, int num_actors,
>   	 */
>   	extra_power = min(extra_power, capped_extra_power);
>   	if (capped_extra_power > 0)
> -		for (i = 0; i < num_actors; i++)
> -			granted_power[i] += (extra_actor_power[i] *
> -					extra_power) / capped_extra_power;
> +		for (i = 0; i < num_actors; i++) {
> +			u64 extra_range = (u64)extra_actor_power[i] * extra_power;
> +			granted_power[i] += DIV_ROUND_CLOSEST_ULL(extra_range,
> +							 capped_extra_power);
> +		}
>   }
>   
>   static int allocate_power(struct thermal_zone_device *tz,
> 

Make sense. There is already DIV_ROUND_CLOSEST_ULL() in that function,
so let's align both. There might be a bit overhead on 32bit machines,
but IPA polling isn't so often there.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
