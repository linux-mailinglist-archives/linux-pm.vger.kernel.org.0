Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6062D1A45A1
	for <lists+linux-pm@lfdr.de>; Fri, 10 Apr 2020 13:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgDJL0b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Apr 2020 07:26:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41800 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgDJL0a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Apr 2020 07:26:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9so1972639wrc.8
        for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2020 04:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yb6LpB8U1nM4uGZdoPTUGIuLgZwodT4yPN9UVySkWAA=;
        b=NedzWrksTu/mbEEoMMisw2+Nz6mapbFOjbmwdDjw4do5FE6CmFietyQVIq7lRNL32Q
         wlIt46UPimibuZ1znfvrmfFuL0fnRFXNHPrZFGzjaRJce2V8z9GMDlFIuVBcvDp4ae8K
         Ile86wzc8RBNv8Ua2NyHNhQZumJ1D3x0SKuctsHOKzZbL/rjQMVPFBDlraSkf8nvNHsr
         8wIaYcVpOxozOz3QSe+36YUkAHXWE2UlCMlhAK+8s8rc8+A0POW+P+/OkdKoUjc0s1Ct
         AzOySg7spDvJwZrftsWehPvbgch/7fz9AVRoIjBAmyeYGr8omtzCQgHot7jB3QwSlWa/
         arLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yb6LpB8U1nM4uGZdoPTUGIuLgZwodT4yPN9UVySkWAA=;
        b=G6bS7u0c0kAf/SawbWd3wMFqXQnOoYW7DyrOCUC9n110lU7gb27m9aEIWz1MC8VJ62
         IQOZn08Kf/0gpo1+l0b+Agd3IkySCbN7gnJpck5vKpOoGKUfFaCk3YRaBTyHtQtosYZV
         Da7X+qOVZTUAz0d6nwWv2pMvF8LnFOrKNJwy4SDCJMZ4KH8X/l3XGlkJtczEghm/i52/
         FmBYObCBxPtgQyAz2ybcEWTNbrxYuXLkk7heDKjD3tVUVTez/6tHY19N8AbYGVM1fv+p
         XtByrmtEXQslSS/NCF8qhDumaMkoGJLpoqVgSs2K85w2ZX0lsGspLV6VEo63A7dAzFfY
         Kdnw==
X-Gm-Message-State: AGi0PuawDsDSgMj6kV9lkRbqWDxmQ8nzZbWUJubGH0fkXPzMBYHFvZR4
        9teKxoDUKGrMePFYcirFlM8LrKzFcc8=
X-Google-Smtp-Source: APiQypKfF0TvXUP39/kWLwli35uk69bEkj7PzRJ1E39JhRzPVp742toAsqaJx4dNlnXARvZGYzNqtA==
X-Received: by 2002:adf:ee06:: with SMTP id y6mr4343897wrn.187.1586517986823;
        Fri, 10 Apr 2020 04:26:26 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:4e:2ab3:ef46:7bda? ([2a01:e34:ed2f:f020:4e:2ab3:ef46:7bda])
        by smtp.googlemail.com with ESMTPSA id q4sm6702974wmj.1.2020.04.10.04.26.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 04:26:26 -0700 (PDT)
Subject: Re: [PATCH 1/2] thermal: core: Move thermal_cdev_update next to
 updated=false
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-kernel@vger.kernel.org, amit.kucheria@verdurent.com,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
References: <20200409151515.6607-1-daniel.lezcano@linaro.org>
 <8e4c2825d71e5bf5602b92937a49c04187c68e17.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0c9796c5-95fe-0349-d128-393da9b344d6@linaro.org>
Date:   Fri, 10 Apr 2020 13:26:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <8e4c2825d71e5bf5602b92937a49c04187c68e17.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/04/2020 12:14, Zhang Rui wrote:
> Hi, Daniel,
> 
> On Thu, 2020-04-09 at 17:15 +0200, Daniel Lezcano wrote:
>> The call to the thermal_cdev_update() function is done after browsing
>> the thermal instances which sets the updated flag by browsing them
>> again.
>>
>> Instead of doing this, let's move the call right after setting the
>> cooling device 'updated' flag as it is done in the other governors.
> 
> The reason we do this in two steps is that we want to avoid redundant
> cooling device state changes.
> 
> Further more, I think it is better to move the thermal_cdev_update out
> of .throllte() callback, to thermal_zone_device_update(). So that we do
> not need to update the cooling device for each trip point.
> 
> is there any specific reason we need to do thermal_cdev_update() for
> every potential change?

I agree we can go further and move the cooling device update in the
thermal_zone_device_update() by letting the throttle callback let us
know an update is needed with the return value.

Makes sense to provide more changes on top of those two patches ?

>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/thermal/gov_bang_bang.c | 10 +---------
>>  drivers/thermal/step_wise.c     | 10 +---------
>>  2 files changed, 2 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/thermal/gov_bang_bang.c
>> b/drivers/thermal/gov_bang_bang.c
>> index 991a1c54296d..c292a69845bb 100644
>> --- a/drivers/thermal/gov_bang_bang.c
>> +++ b/drivers/thermal/gov_bang_bang.c
>> @@ -64,6 +64,7 @@ static void thermal_zone_trip_update(struct
>> thermal_zone_device *tz, int trip)
>>  		mutex_lock(&instance->cdev->lock);
>>  		instance->cdev->updated = false; /* cdev needs update
>> */
>>  		mutex_unlock(&instance->cdev->lock);
>> +		thermal_cdev_update(instance->cdev);
>>  	}
>>  
>>  	mutex_unlock(&tz->lock);
>> @@ -98,17 +99,8 @@ static void thermal_zone_trip_update(struct
>> thermal_zone_device *tz, int trip)
>>   */
>>  static int bang_bang_control(struct thermal_zone_device *tz, int
>> trip)
>>  {
>> -	struct thermal_instance *instance;
>> -
>>  	thermal_zone_trip_update(tz, trip);
>>  
>> -	mutex_lock(&tz->lock);
>> -
>> -	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
>> -		thermal_cdev_update(instance->cdev);
>> -
>> -	mutex_unlock(&tz->lock);
>> -
>>  	return 0;
>>  }
>>  
>> diff --git a/drivers/thermal/step_wise.c
>> b/drivers/thermal/step_wise.c
>> index 2ae7198d3067..298eedac0293 100644
>> --- a/drivers/thermal/step_wise.c
>> +++ b/drivers/thermal/step_wise.c
>> @@ -167,6 +167,7 @@ static void thermal_zone_trip_update(struct
>> thermal_zone_device *tz, int trip)
>>  		mutex_lock(&instance->cdev->lock);
>>  		instance->cdev->updated = false; /* cdev needs update
>> */
>>  		mutex_unlock(&instance->cdev->lock);
>> +		thermal_cdev_update(instance->cdev);
>>  	}
>>  
>>  	mutex_unlock(&tz->lock);
>> @@ -185,20 +186,11 @@ static void thermal_zone_trip_update(struct
>> thermal_zone_device *tz, int trip)
>>   */
>>  static int step_wise_throttle(struct thermal_zone_device *tz, int
>> trip)
>>  {
>> -	struct thermal_instance *instance;
>> -
>>  	thermal_zone_trip_update(tz, trip);
>>  
>>  	if (tz->forced_passive)
>>  		thermal_zone_trip_update(tz, THERMAL_TRIPS_NONE);
>>  
>> -	mutex_lock(&tz->lock);
>> -
>> -	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
>> -		thermal_cdev_update(instance->cdev);
>> -
>> -	mutex_unlock(&tz->lock);
>> -
>>  	return 0;
>>  }
>>  
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
