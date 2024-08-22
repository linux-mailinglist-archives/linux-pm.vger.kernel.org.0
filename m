Return-Path: <linux-pm+bounces-12760-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AA495BCFF
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 19:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B1951F21C65
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 17:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B0B1CEAAF;
	Thu, 22 Aug 2024 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ti2fFOzp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC921CE6E4
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724347246; cv=none; b=mCBXq7Bh8tGRHg4+1NO9NLpyRN2FxPBRfxufcvebBlTuOQgDGUidXQSe07/tDHaW8lHBT/3lLJhMBjU/6HXnEzGirOmp1czrHlv+kX9bCm0wbDy+qbrfGPg7hV/Ahg54PNw+5e6owNTMqFpqT9lC+z56qw4Jiln4Kt3a2Up2GY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724347246; c=relaxed/simple;
	bh=TwbUjdVo7musDqhFWqlZVR3QtXya49JebITBzfWz8ok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gtvQH/FBXDayXFnIXKam2969sSJW+QAQ6IeBD3ANLC+xSc8fOECNIXkPcETlpHDr49z4g/8+OKce5CQ5s79w4juIUAT7ZqI17Ak371LG20cFa3avto88OxI7d8+dlXcC5jdX4o3gJsproUNzu0OYQHnDEjQsuczP2fiS+a3oHcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ti2fFOzp; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42812945633so7950195e9.0
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 10:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724347243; x=1724952043; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Il1MQCxnrq6pJbL1vmhQO8Jvm/2+PkCXtFo2gvTKG3g=;
        b=Ti2fFOzphhwlQHg14m8oIH3/aRpw06jxoNN73VEtdQ43/PdIZWOGy1S0LfOFWmutBj
         5MHV6hdE6B2Hm5JDC6rwA7Q0ILO2kAap11NCSy5Lo1nvEq8IMP2zY+naSqMbnWJ1FmA4
         Q5eH6J0DYL9YXHNB40o8EnNqq1aek1Eu6hNaK75Sd4AqIHHxtg11iVVyb8m+3n1XJvrv
         084d9RzeO3iypNM0shLoMVe5+rYEaE/uqBvakhkAC664QgqmOSD+JWt3pJZSFXJWwGFR
         k2uarJ0FhRBVzPYT1m+9L73qeUlD+AocQYw7Lxheey7ZWiERrHQTFsUzRuFtp6FtixEX
         h1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724347243; x=1724952043;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Il1MQCxnrq6pJbL1vmhQO8Jvm/2+PkCXtFo2gvTKG3g=;
        b=tLGoiaUX3XfQoJB7CXeRkNLY4ipEbjUeoZJVHrPiVP7N/TkHEUq38uWRkD3zWA3c7/
         gXRxJT7YwrIXsC/As4iYbvuI8qsl7Y9oZ40MJ6WU12vWSV/8+NP+9yJ1B9USRXrewqUc
         JO0e5/tnTyLJsONcsh76AFeTwYHSdXVegy4mNsioDoInneknmit/e97cZGqyWtu3jNKx
         dqEA+eum3JvhUbJYBtl2EESL2z1jVsxClgABZTKoO7TCoKiVrU6VQ2SCrfiuiwzTWCS6
         qTm9Jjz/IqGB3QURYyN39LpgSk+Bq1t/6E9anY5txx6sj4qtzi7/s80wp6zyTqGsJUN6
         zuZw==
X-Gm-Message-State: AOJu0Yw2dz6vBhEwstbTbH78tWuT3gKU4lFPgXpWpP1XNMRLaFC9OsEK
	bcCO77u7Zchp6IoilfMIOysBtJDsBOgpWtLttS1mDbuSyDdS7NdhKerqabHkh3U=
X-Google-Smtp-Source: AGHT+IGhokaPvwCu40E36Wh/71/6wtE4HBtjvi29ZyUlakn1ypJ1odX315yqazZobaLHPNmBUI58BQ==
X-Received: by 2002:a05:600c:45c4:b0:426:6921:e3e5 with SMTP id 5b1f17b1804b1-42abf087bafmr45094435e9.24.1724347242315;
        Thu, 22 Aug 2024 10:20:42 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42ac516252asm30430315e9.26.2024.08.22.10.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 10:20:41 -0700 (PDT)
Message-ID: <77c1018e-2cfc-4c14-bd4a-fc2b7bc7c3b4@linaro.org>
Date: Thu, 22 Aug 2024 19:20:41 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] thermal/core: Add thresholds support
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, lukasz.luba@arm.com, quic_manafm@quicinc.com
References: <20240816081241.1925221-1-daniel.lezcano@linaro.org>
 <20240816081241.1925221-3-daniel.lezcano@linaro.org>
 <CAJZ5v0iY4jgnMEJeS97JYWa+DSwLk=feTDJCdKmJmF6UzWaYHw@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0iY4jgnMEJeS97JYWa+DSwLk=feTDJCdKmJmF6UzWaYHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/08/2024 22:05, Rafael J. Wysocki wrote:
> On Fri, Aug 16, 2024 at 10:12 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> The trip points are a firmware description of the temperature limits
>> of a specific thermal zone where we associate an action which is done
>> by the kernel. The time resolution is low.
>>
>> The userspace has to deal with a more complex thermal management based
>> on heuristics from different information coming from different
>> places. The logic is much more complex but based on a bigger time
>> resolution, usually one second based.
>>
>> The purpose of the userspace is to monitor the temperatures from
>> different places and take actions. However, it can not be constantly
>> reading the temperature to detect when a temperature threshold has
>> been reached. This is especially bad for mobile or embedded system as
>> that will lead to an unacceptable number of wakeup to check the
>> temperature with nothing to do.
>>
>> On the other side, the sensors are now most of the time interrupt
>> driven. That means the thermal framework will use the temperature trip
>> points to program the sensor to trigger an interrupt when a
>> temperature limit is crossed.
>>
>> Unfortunately, the userspace can not benefit this feature and current
>> solutions found here and there, iow out-of-tree, are to add fake trip
>> points in the firmware and enable the writable trip points.
>>
>> This is bad for different reasons, the trip points are for in-kernel
>> actions, the semantic of their types is used by the thermal framework
>> and by adding trip points in the device tree is a way to overcome the
>> current limitation but tampering with how the thermal framework is
>> supposed to work. The writable trip points is a way to adjust a
>> temperature limit given a specific platform if the firmware is not
>> accurate enough and TBH it is more a debug feature from my POV.
>>
>> The thresholds mechanism is a way to have the userspace to tell
>> thermal framework to send a notification when a temperature limit is
>> crossed. There is no id, no hysteresis, just the temperature and the
>> direction of the limit crossing. That means we can be notified when a
>> threshold is crossed the way up only, or the way down only or both
>> ways. That allows to create hysteresis values if it is needed.
>>
>> A threshold can be added, deleted or flushed. The latter means all
>> thresholds belonging to a thermal zone will be deleted.
>>
>> When a threshold is added:
>>
>>   - if the same threshold (temperature and direction) exists, an error
>>     is returned
>>
>>   - if a threshold is specified with the same temperature but a
>>     different direction, the specified direction is added
>>
>>   - if there is no threshold with the same temperature then it is
>>     created
>>
>> When a threshold is deleted:
>>
>>   - if the same threshold (temperature and direction) exists, it is
>>     deleted
>>
>>   - if a threshold is specified with the same temperature but a
>>     different direction, the specified direction is removed
>>
>>   - if there is no threshold with the same temperature, then an error
>>     is returned
>>
>> When the threshold are flushed:
>>
>>   - All thresholds related to a thermal zone are deleted
>>
>> When a threshold is crossed:
>>
>>   - the userspace does not need to know which threshold(s) have been
>>     crossed, it will be notified with the current temperature and the
>>     previous temperature
>>
>>   - if multiple thresholds have been crossed between two updates only
>>     one notification will be send to the userspace, it is pointless to
>>     send a notification per thresholds crossed as the userspace can
>>     handle that easily when it has the temperature delta information
> 
> The above seems to be an exact copy of the first part of the cover letter.

Yes, it is done on purpose as it is the commit bringing the feature. I 
thought it is convenient for the developer to read the description of 
the commit introducing the feature.

[ ... ]

>> +config THERMAL_THRESHOLDS
>> +       bool "Thermal thresholds notification mechanism"
>> +       depends on THERMAL_NETLINK
>> +       help
>> +         The userspace implements thermal engines which needs to get
>> +         notified when temperature thresholds are crossed the way up
>> +         and down. These notification allow them to analyze the
>> +         thermal situation of the platform and take decision to
>> +         fulfill specific thermal profile like 'balanced',
>> +         'performance' or 'power saving'. In addition, the
>> +         temperature of the skin sensor is very important in this
>> +         case and must be monitored as well.
>> +
>> +         If in doubt, say Y
>> +
> 
> I'm not sure if this needs an additional user-selectable Kconfig
> option.  It is not modular anyway and not so big, and distros don't
> like user-selectable Kconfig options.

Ok, I can drop the user selectable option.

[ ... ]

>> +#endif
>> +#ifdef CONFIG_THERMAL_THRESHOLDS
>> +       struct thresholds *thresholds;
> 
> Why does it need to be a pointer?
> 
> I would just use a plain struct list_head for it anyway.
> 
> Also, as stated in my reply to the cover letter, I would prefer to
> clearly distinguish these thresholds from trip thresholds, so I would
> call this user_thresholds.
> 
>>   #endif
>>          struct thermal_trip_desc trips[] __counted_by(num_trips);
>>   };
>> diff --git a/drivers/thermal/thermal_thresholds.c b/drivers/thermal/thermal_thresholds.c
>> new file mode 100644
>> index 000000000000..0241b468cfbd
>> --- /dev/null
>> +++ b/drivers/thermal/thermal_thresholds.c
>> @@ -0,0 +1,241 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright 2024 Linaro Limited
>> + *
>> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
>> + *
>> + * Thermal thresholds
>> + */
>> +#include <linux/list.h>
>> +#include <linux/list_sort.h>
>> +#include <linux/slab.h>
>> +
>> +#include "thermal_core.h"
> 
> +#include "thermal_thresholds.h"
> 
>> +
>> +struct thresholds {
>> +       struct list_head list;
>> +};
> 
> This duplicates the definition in the header file.

No actually it is plural.

struct threshold;
struct thresholds;

> Besides, why is the wrapper struct needed?

Because I think the threshold will continue to evolve. So instead of 
dealing with lists, we use a dedicated structure. In case we add new 
fields or we change the list by something else the functions prototypes 
are untouched. It is my way of coding in order to always set the scene 
for future changes.

>> +int thermal_thresholds_init(struct thermal_zone_device *tz)
>> +{
>> +       struct thresholds *thresholds;
>> +
>> +       thresholds = kmalloc(sizeof(*thresholds), GFP_KERNEL);
>> +       if (!thresholds)
>> +               return -ENOMEM;
>> +
>> +       INIT_LIST_HEAD(&thresholds->list);
>> +       tz->thresholds = thresholds;
>> +
>> +       return 0;
>> +}
> 
> I'd rather embed "thresholds" in struct thermal_zone_device and avoid
> allocating memory separately for it.  Less code, less complexity.

Ok

>> +static bool __thermal_threshold_is_crossed(struct threshold *threshold, int temperature,
>> +                                          int last_temperature, int direction,
>> +                                          int *low, int *high)
>> +{
>> +       if (temperature > threshold->temperature && threshold->temperature > *low &&
>> +           (THERMAL_THRESHOLD_WAY_DOWN & threshold->direction))
>> +               *low = threshold->temperature;
>> +
>> +       if (temperature < threshold->temperature && threshold->temperature < *high &&
>> +           (THERMAL_THRESHOLD_WAY_UP & threshold->direction))
>> +               *high = threshold->temperature;
>> +
>> +       if (temperature < threshold->temperature &&
>> +           last_temperature >= threshold->temperature &&
>> +           (threshold->direction & direction))
>> +               return true;
>> +
>> +       if (temperature >= threshold->temperature &&
>> +           last_temperature < threshold->temperature &&
>> +           (threshold->direction & direction))
>> +               return true;
> 
> I would combine the checks, so something like this
> 
> if (temperature >= threshold->temperature) {
>          if (threshold->temperature > *low &&
> THERMAL_THRESHOLD_WAY_DOWN & threshold->direction)
>                  *low = threshold->temperature;
>          if (last_temperature < threshold->temperature &&
> threshold->direction & direction)
>                  return true;
> } else {
>          if (threshold->temperature < *high && THERMAL_THRESHOLD_WAY_UP
> & threshold->direction)
>                *high = threshold->temperature;
> 
>          if (last_temperature >= threshold->temperature &&
> threshold->direction & direction)
>                  return true;
> }

Ok

[ ... ]

>> +void thermal_thresholds_flush(struct thermal_zone_device *tz)
>> +{
>> +       struct thresholds *thresholds = tz->thresholds;
>> +       struct threshold *entry, *tmp;
>> +
>> +       lockdep_assert_held(&tz->lock);
>> +
>> +       list_for_each_entry_safe(entry, tmp, &thresholds->list, list) {
>> +               list_del(&entry->list);
>> +               kfree(entry);
>> +       }
>> +
>> +       __thermal_zone_device_update(tz, THERMAL_THRESHOLD_FLUSHED);
>> +}
> 
> I'd move the function above before thermal_thresholds_exit() which
> uses it.  Having it here is somewhat confusing.

Sure

>> +
>> +int thermal_thresholds_handle(struct thermal_zone_device *tz, int *low, int *high)
> 
> This function doesn't return anything other than 0 AFAICS.  Make it void?

Ok

>> +{
>> +       struct thresholds *thresholds = tz->thresholds;
>> +
>> +       int temperature = tz->temperature;
>> +       int last_temperature = tz->last_temperature;
>> +       bool notify;
>> +
>> +       lockdep_assert_held(&tz->lock);
>> +
>> +       /*
>> +        * We need a second update in order to detect a threshold being crossed
>> +        */
>> +       if (last_temperature == THERMAL_TEMP_INVALID)
>> +               return 0;
> 
> So user space won't get notified when tz->temperature is above some
> thresholds the first time this runs.  Fair enough, but won't they be
> confused by subsequent notifications that will not cover some
> thresholds?

It is unlikely to happen.

When the thermal zone is created and enabled, it updates the temperature 
of the thermal zone so tz->temperature is no longer THERMAL_TEMP_INVALID.

At this step, there is no userspace set yet.

Assuming there is zero update until we create a threshold. When this one 
is created then the thermal zone is updated, the temperature is read, 
the tz->last_temperature = tz->temperature and tz->temperature has the 
new value. Then handle_thresholds is called and finally set_trips

If the temperature is above or below a threshold then it is detected and 
notified because tz->last_temperature is not equal to THERMAL_TEMP_INVALID.

Others situations are IMO resulting from a bogus driver/sensor and 
should be handled at the sensor level, not the core code.

[ ... ]

>> +int thermal_thresholds_add(struct thermal_zone_device *tz, int temperature, int direction)
>> +{
>> +       struct thresholds *thresholds = tz->thresholds;
> 
> So IMO it would be cleaner to just put "thresholds" into struct
> thermal_zone_device directly as a struct list_head because the above
> wouldn't be needed then.

I can change that to list directly but if we add anything (which can 
probably happen) then the API change as well as anything below again.

>> +       struct threshold *t;
>> +
>> +       lockdep_assert_held(&tz->lock);
>> +
>> +       t = __thermal_thresholds_find(thresholds, temperature);
>> +       if (t) {
>> +               if (t->direction == direction)
>> +                       return -EEXIST;
> 
> Why is it useful to return an error here?

I was expecting this comment :)

We have the choice between :
  * we do nothing
  * we return an error

Let's assume the userspace is misbehaving and because of an internal bug 
of a thermal engine it creates multiple times the same threshold (eg. 
index not incremented, etc ...). If the kernel reports nothing, then the 
user space will never detect this problem. If it reports the error the 
user space can choose to ignore it or follow it up.

The kernel is strict and it is up to the user space to ignore it or not.

>> +
>> +               t->direction |= direction;
>> +       } else {
>> +
>> +               t = kmalloc(sizeof(*t), GFP_KERNEL);
>> +               if (!t)
>> +                       return -ENOMEM;
>> +
>> +               INIT_LIST_HEAD(&t->list);
>> +               t->temperature = temperature;
>> +               t->direction = direction;
>> +               list_add(&t->list, &thresholds->list);
>> +               list_sort(NULL, &thresholds->list, __thermal_thresholds_cmp);
> 
> And the above would become
> 
> +        list_add(&t->list, &tz->thresholds);
> +        list_sort(NULL, &tz->thresholdst, __thermal_thresholds_cmp);
> 
> And analogously below.
> 
>> +       }
>> +
>> +       __thermal_zone_device_update(tz, THERMAL_THRESHOLD_ADDED);
>> +
>> +       return 0;
>> +}

[ ... ]

>> +struct threshold {
>> +       int temperature;
>> +       int direction;
>> +       struct list_head list;
>> +};
> 
> IMO it would be better to put the list field at the top for better
> alignment and such.  I would also call it something like list_node.
> 
> And I'd call this struct user_threshold as a whole (as per the
> previous remarks about the naming).

Ok

[ ... ]

>> @@ -55,6 +55,9 @@ enum thermal_notify_event {
>>          THERMAL_TZ_BIND_CDEV, /* Cooling dev is bind to the thermal zone */
>>          THERMAL_TZ_UNBIND_CDEV, /* Cooling dev is unbind from the thermal zone */
>>          THERMAL_INSTANCE_WEIGHT_CHANGED, /* Thermal instance weight changed */
> 
> There is an additional item here in the mainline (THERMAL_TZ_RESUME).
> 
>> +       THERMAL_THRESHOLD_ADDED, /* Threshold added */
>> +       THERMAL_THRESHOLD_DELETED, /* Threshold deleted */
>> +       THERMAL_THRESHOLD_FLUSHED, /* All thresholds deleted */
> 
> I'd add "TZ" to these names, eg. THERMAL_TZ_THRESHOLD_ADDED, or even
> THERMAL_TZ_ADD_THRESHOLD in analogy with the cdev events above.
> 
> And THERMAL_TZ_FLUSH_THRESHOLDS sounds more like proper English to me. ;-)

Ok, will do the change



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

