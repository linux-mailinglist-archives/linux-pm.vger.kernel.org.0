Return-Path: <linux-pm+bounces-418-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3C07FC822
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 22:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05CCF1C20E59
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 21:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F53F42AAF;
	Tue, 28 Nov 2023 21:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F49D98;
	Tue, 28 Nov 2023 13:42:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 418321FB;
	Tue, 28 Nov 2023 13:42:49 -0800 (PST)
Received: from [10.57.2.117] (unknown [10.57.2.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9ECE3F73F;
	Tue, 28 Nov 2023 13:42:00 -0800 (PST)
Message-ID: <8524d5f3-6204-44a2-aded-694769dfadd2@arm.com>
Date: Tue, 28 Nov 2023 21:43:00 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] thermal: trip: Rework thermal_zone_set_trip() and
 its callers
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <6010559.lOV4Wx5bFT@kreacher> <1887866.tdWV9SEqCh@kreacher>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <1887866.tdWV9SEqCh@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/28/23 13:58, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Both trip_point_temp_store() and trip_point_hyst_store() use
> thermal_zone_set_trip() to update a given trip point, but none of them
> actually needs to change more than one field in struct thermal_trip
> representing it.  However, each of them effectively calls
> __thermal_zone_get_trip() twice in a row for the same trip index value,
> once directly and once via thermal_zone_set_trip(), which is not
> particularly efficient, and the way in which thermal_zone_set_trip()
> carries out the update is not particularly straightforward.
> 
> Moreover, some checks done by them both need not go under the thermal
> zone lock and code duplication between them can be reduced quite a bit
> by moving the majority of logic into thermal_zone_set_trip().
> 
> Rework all of the above functions to address the above.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2:
>     * Fix 2 typos in the changelog (Lukasz).
>     * Split one change into the [1/2].
> 
> ---
>   drivers/thermal/thermal_core.h  |    9 ++++++
>   drivers/thermal/thermal_sysfs.c |   52 ++++++++--------------------------
>   drivers/thermal/thermal_trip.c  |   60 +++++++++++++++++++++++++++-------------
>   include/linux/thermal.h         |    3 --
>   4 files changed, 62 insertions(+), 62 deletions(-)
> 

[snip]

> Index: linux-pm/drivers/thermal/thermal_trip.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_trip.c
> +++ linux-pm/drivers/thermal/thermal_trip.c
> @@ -148,39 +148,61 @@ int thermal_zone_get_trip(struct thermal
>   EXPORT_SYMBOL_GPL(thermal_zone_get_trip);
>   
>   int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
> -			  const struct thermal_trip *trip)
> +			  enum thermal_set_trip_target what, const char *buf)
>   {
> -	struct thermal_trip t;
> -	int ret;
> +	struct thermal_trip *trip;
> +	int val, ret = 0;
>   
> -	ret = __thermal_zone_get_trip(tz, trip_id, &t);
> +	if (trip_id < 0 || trip_id >= tz->num_trips)
> +		ret = -EINVAL;

That shouldn't progress forward IMO, but simply 'return -EINVAL;'...

> +
> +	ret = kstrtoint(buf, 10, &val);
>   	if (ret)
>   		return ret;
>   
> -	if (t.type != trip->type)
> -		return -EINVAL;
> +	mutex_lock(&tz->lock);
>   
> -	if (t.temperature != trip->temperature && tz->ops->set_trip_temp) {
> -		ret = tz->ops->set_trip_temp(tz, trip_id, trip->temperature);
> -		if (ret)
> -			return ret;
> -	}
> +	trip = &tz->trips[trip_id];

... because here we might get an issue.


