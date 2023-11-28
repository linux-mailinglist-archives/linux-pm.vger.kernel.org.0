Return-Path: <linux-pm+bounces-419-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D56CF7FC826
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 22:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 138301C20F28
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 21:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F2C481A0;
	Tue, 28 Nov 2023 21:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1153BD;
	Tue, 28 Nov 2023 13:43:04 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F198C1FB;
	Tue, 28 Nov 2023 13:43:51 -0800 (PST)
Received: from [10.57.2.117] (unknown [10.57.2.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DC6F3F73F;
	Tue, 28 Nov 2023 13:43:03 -0800 (PST)
Message-ID: <23b21239-4268-43e2-acc3-4ebc454944e7@arm.com>
Date: Tue, 28 Nov 2023 21:44:04 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] thermal: trip: Drop a redundant check from
 thermal_zone_set_trip()
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <6010559.lOV4Wx5bFT@kreacher> <4544904.LvFx2qVVIh@kreacher>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <4544904.LvFx2qVVIh@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/28/23 13:56, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After recent changes in the thermal framework, a trip points array is
> required for registering a thermal zone that is not tripless, so the
> tz->trips pointer in thermal_zone_set_trip() is never NULL and the
> check involving it is redundant.  Drop that check.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> New patch in v2.
> 
> ---
>   drivers/thermal/thermal_trip.c |    3 ---
>   1 file changed, 3 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_trip.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_trip.c
> +++ linux-pm/drivers/thermal/thermal_trip.c
> @@ -153,9 +153,6 @@ int thermal_zone_set_trip(struct thermal
>   	struct thermal_trip t;
>   	int ret;
>   
> -	if (!tz->ops->set_trip_temp && !tz->ops->set_trip_hyst && !tz->trips)
> -		return -EINVAL;
> -
>   	ret = __thermal_zone_get_trip(tz, trip_id, &t);
>   	if (ret)
>   		return ret;
> 
> 
> 

LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

