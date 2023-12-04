Return-Path: <linux-pm+bounces-685-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15ADE803AF2
	for <lists+linux-pm@lfdr.de>; Mon,  4 Dec 2023 17:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B947B1F211B6
	for <lists+linux-pm@lfdr.de>; Mon,  4 Dec 2023 16:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E1228E0B;
	Mon,  4 Dec 2023 16:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H24e38KD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAF7C6
	for <linux-pm@vger.kernel.org>; Mon,  4 Dec 2023 08:55:27 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c05ce04a8so23871755e9.0
        for <linux-pm@vger.kernel.org>; Mon, 04 Dec 2023 08:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701708926; x=1702313726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3gdwaTpLNBr7sA7AwFQ/+pGFdvl9soWUtB8Z1U9cjJk=;
        b=H24e38KDCSflSRDhe/MKHM50QJuvaWyLD7eewxK7UTV9jsIiyrLyBxLsN4ujkLbTY0
         x9qS/rwx0/lchdnATxx0TzmKD2Ci0jkb3cdzmAdkwTivkh7RK2bl8jFxeBART0rO4M/X
         VFrlpEc4qvAl6RUi6vuT20CwrmPGUOkM1fln/IEqMkx3GJSiCAWUHGns5JmjXUyN/ZPY
         NnHVyJ7qzde9WgzrfdVnRcKkApLjRUO3I4PDmM468zUomHYA0EFFMEZWGa9LzSOIIaTE
         EIAFF9AA1kbiJY4t96afrcaIPkZ9BplJaA+7wUHtcEkATtq3KfaAAVkJvTXpgWpW0SY8
         9VwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701708926; x=1702313726;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3gdwaTpLNBr7sA7AwFQ/+pGFdvl9soWUtB8Z1U9cjJk=;
        b=fTi8ZHpUftqyxNgC1Rd3/2S60Sc9RGTtpkVVxXWByqwHlPd75csHNBzQyqHHajtDfI
         NDtBb/zIyYeVIjj4iUMrA56MG4ZV2VifbEQZlN3okCjFeRyOveH1jHetNGqHnSTGyKfg
         ouzLs6G4a/jZHxY1Nig940jfT0QyB+Ft9wx2whrDOEQdzfnHNF/2Bgt86ol/hyb7I2wF
         yLDyW9iJ6ZAf2SkctTYVBTAkccjJOMF0NvolW6VpL4zgfGALxgqAVoMxv3gzoeOPWs3j
         AYx1ZoejYOUbQU8FU9GeIRJI5F4o5qWCb0TyUvILbvm3crbtXU2y95c3FMHOuKz7UHk3
         RnzA==
X-Gm-Message-State: AOJu0YyHV8jB/8+mCyPc6a7iBkBHOjEWGR1Obnbezyjt5gan1ymnoIHS
	nKby58UWx1tjHFDfmxojsfAuEg==
X-Google-Smtp-Source: AGHT+IEDltZ3Re0khBvM5AY2nz+sa1kkygHRHGWkxzz9Jb4ph4xPFgeiPbj9o7n9hM3b8YiuI+TXzw==
X-Received: by 2002:a05:600c:851a:b0:40b:5392:7ee9 with SMTP id gw26-20020a05600c851a00b0040b53927ee9mr1258612wmb.0.1701708925944;
        Mon, 04 Dec 2023 08:55:25 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c831:1e47:2:5b96? ([2a05:6e02:1041:c10:c831:1e47:2:5b96])
        by smtp.googlemail.com with ESMTPSA id o15-20020a05600c510f00b004064cd71aa8sm14340224wms.34.2023.12.04.08.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 08:55:25 -0800 (PST)
Message-ID: <b3c86caf-635d-416b-af98-9e26f2a68948@linaro.org>
Date: Mon, 4 Dec 2023 17:55:24 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] thermal: sysfs: Rework the handling of trip point
 updates
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lukasz Luba <lukasz.luba@arm.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <12338384.O9o76ZdvQC@kreacher> <4883151.31r3eYUQgx@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <4883151.31r3eYUQgx@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Rafael,

On 04/12/2023 15:50, Rafael J. Wysocki wrote:
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
> Moreover, input processing need not be done under the thermal zone lock
> in any of these functions.
> 
> Rework trip_point_temp_store() and trip_point_hyst_store() to address
> the above, move the part of thermal_zone_set_trip() that is still
> useful to a new function called thermal_zone_trip_updated() and drop
> the rest of it.
> 
> While at it, make trip_point_hyst_store() reject negative hysteresis
> values.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v2 -> v3: No changes
> 
> v1 -> v2: Still check device_is_registered() under the zone lock
> 
> ---
>   drivers/thermal/thermal_core.h  |    2 +
>   drivers/thermal/thermal_sysfs.c |   75 ++++++++++++++++++++++++++++------------
>   drivers/thermal/thermal_trip.c  |   45 ++++--------------------
>   include/linux/thermal.h         |    4 --
>   4 files changed, 64 insertions(+), 62 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_sysfs.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_sysfs.c
> +++ linux-pm/drivers/thermal/thermal_sysfs.c
> @@ -78,6 +78,19 @@ mode_store(struct device *dev, struct de
>   	return count;
>   }
>   
> +static int check_thermal_zone_and_trip_id(struct device *dev,
> +					  struct thermal_zone_device *tz,
> +					  int trip_id)
> +{
> +	if (!device_is_registered(dev))
> +		return -ENODEV;
> +
> +	if (trip_id < 0 || trip_id >= tz->num_trips)
> +		return -EINVAL;

I'm not sure if this check is useful. The function is called from 
trip_point_*_store() which is providing the trip id from the file name 
parsing which is in turn built from an existing trip id. There is no 
reason the trip id is going to be wrong.

[ ... ]


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


