Return-Path: <linux-pm+bounces-900-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DC180D1AB
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 17:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5F2EB20E46
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 16:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C65E4CB42;
	Mon, 11 Dec 2023 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CrENPrpO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081E9B3
	for <linux-pm@vger.kernel.org>; Mon, 11 Dec 2023 08:28:43 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c25973988so49312745e9.2
        for <linux-pm@vger.kernel.org>; Mon, 11 Dec 2023 08:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702312121; x=1702916921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UY6XrDoqDxgMJunuedrsiS+ICxcRp6UXL9LejdoCOD4=;
        b=CrENPrpOV1/yyW/9NLQUEJl11Z+8XDyfLztUWzdKZRhxvFzQ3yuohxRcWViGj3HBsB
         O53GIlAOpCCZAwPYa/cHBO78aej4lWN81kDhVwvYteREkk9vcg5vYb1qcJiKpkitrvKr
         OOXtBoahOsDZV99nqS6Y6ZQaxpR87l42v5V+kTcaE1yz6Ogqcls+SoEhuV81L3APmgNh
         k3Q+eA5hCBigXEYBGvXp+Ka4EwJ4xvRpqBQgi0fsT4s9GniXsERUNuJ0DrROFGtPUDLO
         s+lEpjoKTwMuFVYvWgBnISyFxhhCAAHoRM/omycZBAR+kP+rVbc3xDh++YpBeDZwsMKw
         EBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702312121; x=1702916921;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UY6XrDoqDxgMJunuedrsiS+ICxcRp6UXL9LejdoCOD4=;
        b=aQgLml7gq+rsFqv0u6F1QLPQ6CZnjfUaIFWy/X7ql1ITBrdvBmcwpbXU2YLzMx+5EJ
         nPJyhGCC0qoO5695hCdVGtLM7X2dAm/RWiUMCXQkjMnMMpClUcuNi57jb2dNd+TC+sZA
         z91fXQLO41vTid5LSsNyVV7REzDhDhEkX2hChmIJNcHgbMybhvtNEYr07SFnVX8cy9rK
         JczT2HPlXaay7f/PXzWTHRvcYADUmbXmrol6UXw/oy/mkYcQww+x/pRrtPpvMlxCntUS
         cwkmpYjY1qS/I4VR0w+ZezY+hqqzgJchLO44Dvv3lkuu4LqJXIXiT3sldDXBbx3iPuNM
         R6mQ==
X-Gm-Message-State: AOJu0YyCD86Ye1+23bboFQ/R5WtJkUsE2+S/SehaeLq7OKjn/Q+UWo6N
	yTpd1ufY8M9lQiPe3jQQ00xuTg==
X-Google-Smtp-Source: AGHT+IHBsm/CTenTQgPxsm08dI8dghwmYiAmdNPjkI9vO5iNGsL5XiNwaAN+3CsbQ2la7U56Bd6VLA==
X-Received: by 2002:a7b:cb90:0:b0:40c:337e:cbb with SMTP id m16-20020a7bcb90000000b0040c337e0cbbmr2344436wmi.88.1702312121331;
        Mon, 11 Dec 2023 08:28:41 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id a19-20020a05600c349300b004064cd71aa8sm13425670wmq.34.2023.12.11.08.28.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 08:28:40 -0800 (PST)
Message-ID: <0a0d5dd4-6b7a-428b-8ef1-bb6aff76fb51@linaro.org>
Date: Mon, 11 Dec 2023 17:28:40 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] thermal: core: Make
 thermal_zone_device_unregister() return after freeing the zone
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <1880915.tdWV9SEqCh@kreacher> <13414639.uLZWGnKmhe@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <13414639.uLZWGnKmhe@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/12/2023 20:13, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make thermal_zone_device_unregister() wait until all of the references
> to the given thermal zone object have been dropped and free it before
> returning.
> 
> This guarantees that when thermal_zone_device_unregister() returns,
> there is no leftover activity regarding the thermal zone in question
> which is required by some of its callers (for instance, modular driver
> code that wants to know when it is safe to let the module go away).
> 
> Subsequently, this will allow some confusing device_is_registered()
> checks to be dropped from the thermal sysfs and core code.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Definitively agree on the change

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Would it make sense to use kref_get/put ?


>   drivers/thermal/thermal_core.c |    6 +++++-
>   include/linux/thermal.h        |    2 ++
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -822,7 +822,7 @@ static void thermal_release(struct devic
>   		tz = to_thermal_zone(dev);
>   		thermal_zone_destroy_device_groups(tz);
>   		mutex_destroy(&tz->lock);
> -		kfree(tz);
> +		complete(&tz->removal);
>   	} else if (!strncmp(dev_name(dev), "cooling_device",
>   			    sizeof("cooling_device") - 1)) {
>   		cdev = to_cooling_device(dev);
> @@ -1315,6 +1315,7 @@ thermal_zone_device_register_with_trips(
>   	INIT_LIST_HEAD(&tz->thermal_instances);
>   	ida_init(&tz->ida);
>   	mutex_init(&tz->lock);
> +	init_completion(&tz->removal);
>   	id = ida_alloc(&thermal_tz_ida, GFP_KERNEL);
>   	if (id < 0) {
>   		result = id;
> @@ -1494,6 +1495,9 @@ void thermal_zone_device_unregister(stru
>   	put_device(&tz->device);
>   
>   	thermal_notify_tz_delete(tz_id);
> +
> +	wait_for_completion(&tz->removal);
> +	kfree(tz);
>   }
>   EXPORT_SYMBOL_GPL(thermal_zone_device_unregister);
>   
> Index: linux-pm/include/linux/thermal.h
> ===================================================================
> --- linux-pm.orig/include/linux/thermal.h
> +++ linux-pm/include/linux/thermal.h
> @@ -117,6 +117,7 @@ struct thermal_cooling_device {
>    * @id:		unique id number for each thermal zone
>    * @type:	the thermal zone device type
>    * @device:	&struct device for this thermal zone
> + * @removal:	removal completion
>    * @trip_temp_attrs:	attributes for trip points for sysfs: trip temperature
>    * @trip_type_attrs:	attributes for trip points for sysfs: trip type
>    * @trip_hyst_attrs:	attributes for trip points for sysfs: trip hysteresis
> @@ -156,6 +157,7 @@ struct thermal_zone_device {
>   	int id;
>   	char type[THERMAL_NAME_LENGTH];
>   	struct device device;
> +	struct completion removal;
>   	struct attribute_group trips_attribute_group;
>   	struct thermal_attr *trip_temp_attrs;
>   	struct thermal_attr *trip_type_attrs;
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


