Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9982158C6
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jul 2020 15:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgGFNqQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jul 2020 09:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729151AbgGFNqP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jul 2020 09:46:15 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD45C061794
        for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2020 06:46:15 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l17so39431036wmj.0
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2020 06:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MZyQPOMczNHbaYO2QB7Fnl+OekFYCcPdnajxmT+RLok=;
        b=opSlrEPhbvi4sPAqVPrrDHLerBDcNt6yKujCF4KMl4YV7AeL/8Z/NUqNty5YpTaE9o
         yo1Ln8ToTwcaKIOjfW45FA/1A7vLZbVPKcFqPf2KC1J/EjQgp3b7xFB0xm26umge7SQS
         KoTJbqfvApa7q2hoCZ86GOru89CXbJByJ6Dz+xGDKi1+ApVvwP2w77hcEXem3X+NVJRL
         AQWxVQmw7mAFRDdy8yyY/zvkOErTOXOpFICiH3NTja0fqEbaHOwPBCUOOSwTFYMRJ/qy
         NOjyIk6YHEtNTghkHX0Era1ssJnc/Ix0SpWOVhNnGC7A41QDqcp+3M8Ryd8lVWjMmJhg
         PAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MZyQPOMczNHbaYO2QB7Fnl+OekFYCcPdnajxmT+RLok=;
        b=tTbYb8dCQR3vX1JAzIx+G8qdTi/qEQaArMdYwZkdjLMBbvWHbZeLT3S0I4qGnws62H
         Tw4xY6URnwF7PRtR13hhzVSRudiaBui2FFinoDkAsSKO30rGMkk99FCgjY8qxGZicNWg
         snhvLyG8Yy6J+IHa+zzONC1yqPuLZbmYYh8lnd2KXDxdIlJhfFkI6NvpF25G/LbV+rgx
         jAWP3RLyNH4TFGZKVcbJvWhu9mYSJfU3ZWS6jQdgnc2NIXlc84idxckmTLlMRGEy+bFo
         Eu+NN70ZxH7d/43CgCfzaNwGxFA/m/kcrLH5NEozDA/MiBr6A5fZGaHLC0IO6/pTwMLA
         UnsA==
X-Gm-Message-State: AOAM531mTMhTMmDk55jt+uF634xEhuBzWL36Gf2fYGYSOVwErvJUs131
        x2e9bxMIalHFm06qsbew+0MGwQ==
X-Google-Smtp-Source: ABdhPJzjmydMrQ+1z0sFSMCKPT5a3jlwVLV3GcU7fdKAOd91lZSsQXjWhG4ckUU/PlbYpJHGdQjqGw==
X-Received: by 2002:a1c:9d07:: with SMTP id g7mr49509502wme.160.1594043173784;
        Mon, 06 Jul 2020 06:46:13 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:f9e8:8c05:eb6f:1865? ([2a01:e34:ed2f:f020:f9e8:8c05:eb6f:1865])
        by smtp.googlemail.com with ESMTPSA id 65sm26163278wre.6.2020.07.06.06.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 06:46:13 -0700 (PDT)
Subject: Re: [PATCH v4 4/4] thermal: core: Add notifications call in the
 framework
To:     Marek Szyprowski <m.szyprowski@samsung.com>, rui.zhang@intel.com
Cc:     srinivas.pandruvada@linux.intel.com, rkumbako@codeaurora.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <20200706105538.2159-1-daniel.lezcano@linaro.org>
 <20200706105538.2159-4-daniel.lezcano@linaro.org>
 <CGME20200706131708eucas1p1487955a7632584c17df724399f48825a@eucas1p1.samsung.com>
 <c7ed6c63-cbb5-07dc-c292-2c473af8c4fb@samsung.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <23c5830d-0a7c-9e87-e859-821d2dccb200@linaro.org>
Date:   Mon, 6 Jul 2020 15:46:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <c7ed6c63-cbb5-07dc-c292-2c473af8c4fb@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/07/2020 15:17, Marek Szyprowski wrote:
> Hi Daniel,
> 
> On 06.07.2020 12:55, Daniel Lezcano wrote:
>> The generic netlink protocol is implemented but the different
>> notification functions are not yet connected to the core code.
>>
>> These changes add the notification calls in the different
>> corresponding places.
>>
>> Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> This patch landed in today's linux-next 20200706 as commit 5df786e46560 
> ("thermal: core: Add notifications call in the framework"). Sadly it 
> breaks booting various Samsung Exynos based boards. Here is an example 
> log from Odroid U3 board:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000010
> pgd = (ptrval)
> [00000010] *pgd=00000000
> Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.8.0-rc3-00015-g5df786e46560 
> #1146
> Hardware name: Samsung Exynos (Flattened Device Tree)
> PC is at kmem_cache_alloc+0x13c/0x418
> LR is at kmem_cache_alloc+0x48/0x418
> pc : [<c02b5cac>]    lr : [<c02b5bb8>]    psr: 20000053
> ...
> Flags: nzCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 4000404a  DAC: 00000051
> Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
> Stack: (0xee8f1cf8 to 0xee8f2000)
> ...
> [<c02b5cac>] (kmem_cache_alloc) from [<c08cd170>] (__alloc_skb+0x5c/0x170)
> [<c08cd170>] (__alloc_skb) from [<c07ec19c>] 
> (thermal_genl_send_event+0x24/0x174)
> [<c07ec19c>] (thermal_genl_send_event) from [<c07ec648>] 
> (thermal_notify_tz_create+0x58/0x74)
> [<c07ec648>] (thermal_notify_tz_create) from [<c07e9058>] 
> (thermal_zone_device_register+0x358/0x650)
> [<c07e9058>] (thermal_zone_device_register) from [<c1028d34>] 
> (of_parse_thermal_zones+0x304/0x7a4)
> [<c1028d34>] (of_parse_thermal_zones) from [<c1028964>] 
> (thermal_init+0xdc/0x154)
> [<c1028964>] (thermal_init) from [<c0102378>] (do_one_initcall+0x8c/0x424)
> [<c0102378>] (do_one_initcall) from [<c1001158>] 
> (kernel_init_freeable+0x190/0x204)
> [<c1001158>] (kernel_init_freeable) from [<c0ab85f4>] 
> (kernel_init+0x8/0x118)
> [<c0ab85f4>] (kernel_init) from [<c0100114>] (ret_from_fork+0x14/0x20)
> 
> Reverting it on top of linux-next fixes the boot issue. I will 
> investigate it further soon.

Thanks for reporting this.

Can you send the addr2line result and code it points to ?


>> ---
>>    v4:
>>       - Fixed missing static declaration, reported by kbuild-bot
>>       - Removed max state notification
>> ---
>>   drivers/thermal/thermal_core.c    | 21 +++++++++++++++++++++
>>   drivers/thermal/thermal_helpers.c | 13 +++++++++++--
>>   drivers/thermal/thermal_sysfs.c   | 15 ++++++++++++++-
>>   3 files changed, 46 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>> index 5fae1621fb01..25ef29123f72 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -215,6 +215,8 @@ int thermal_zone_device_set_policy(struct thermal_zone_device *tz,
>>   	mutex_unlock(&tz->lock);
>>   	mutex_unlock(&thermal_governor_lock);
>>   
>> +	thermal_notify_tz_gov_change(tz->id, policy);
>> +
>>   	return ret;
>>   }
>>   
>> @@ -406,12 +408,25 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
>>   static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
>>   {
>>   	enum thermal_trip_type type;
>> +	int trip_temp, hyst = 0;
>>   
>>   	/* Ignore disabled trip points */
>>   	if (test_bit(trip, &tz->trips_disabled))
>>   		return;
>>   
>> +	tz->ops->get_trip_temp(tz, trip, &trip_temp);
>>   	tz->ops->get_trip_type(tz, trip, &type);
>> +	if (tz->ops->get_trip_hyst)
>> +		tz->ops->get_trip_hyst(tz, trip, &hyst);
>> +
>> +	if (tz->last_temperature != THERMAL_TEMP_INVALID) {
>> +		if (tz->last_temperature < trip_temp &&
>> +		    tz->temperature >= trip_temp)
>> +			thermal_notify_tz_trip_up(tz->id, trip);
>> +		if (tz->last_temperature >= trip_temp &&
>> +		    tz->temperature < (trip_temp - hyst))
>> +			thermal_notify_tz_trip_down(tz->id, trip);
>> +	}
>>   
>>   	if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)
>>   		handle_critical_trips(tz, trip, type);
>> @@ -443,6 +458,8 @@ static void update_temperature(struct thermal_zone_device *tz)
>>   	mutex_unlock(&tz->lock);
>>   
>>   	trace_thermal_temperature(tz);
>> +
>> +	thermal_genl_sampling_temp(tz->id, temp);
>>   }
>>   
>>   static void thermal_zone_device_init(struct thermal_zone_device *tz)
>> @@ -1405,6 +1422,8 @@ thermal_zone_device_register(const char *type, int trips, int mask,
>>   	if (atomic_cmpxchg(&tz->need_update, 1, 0))
>>   		thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
>>   
>> +	thermal_notify_tz_create(tz->id, tz->type);
>> +
>>   	return tz;
>>   
>>   unregister:
>> @@ -1476,6 +1495,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>>   	ida_destroy(&tz->ida);
>>   	mutex_destroy(&tz->lock);
>>   	device_unregister(&tz->device);
>> +
>> +	thermal_notify_tz_delete(tz->id);
>>   }
>>   EXPORT_SYMBOL_GPL(thermal_zone_device_unregister);
>>   
>> diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
>> index 87b1256fa2f2..c94bc824e5d3 100644
>> --- a/drivers/thermal/thermal_helpers.c
>> +++ b/drivers/thermal/thermal_helpers.c
>> @@ -175,6 +175,16 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz)
>>   	mutex_unlock(&tz->lock);
>>   }
>>   
>> +static void thermal_cdev_set_cur_state(struct thermal_cooling_device *cdev,
>> +				       int target)
>> +{
>> +	if (cdev->ops->set_cur_state(cdev, target))
>> +		return;
>> +
>> +	thermal_notify_cdev_state_update(cdev->id, target);
>> +	thermal_cooling_device_stats_update(cdev, target);
>> +}
>> +
>>   void thermal_cdev_update(struct thermal_cooling_device *cdev)
>>   {
>>   	struct thermal_instance *instance;
>> @@ -197,8 +207,7 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
>>   			target = instance->target;
>>   	}
>>   
>> -	if (!cdev->ops->set_cur_state(cdev, target))
>> -		thermal_cooling_device_stats_update(cdev, target);
>> +	thermal_cdev_set_cur_state(cdev, target);
>>   
>>   	cdev->updated = true;
>>   	mutex_unlock(&cdev->lock);
>> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
>> index aa99edb4dff7..ff449943f757 100644
>> --- a/drivers/thermal/thermal_sysfs.c
>> +++ b/drivers/thermal/thermal_sysfs.c
>> @@ -124,7 +124,8 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
>>   {
>>   	struct thermal_zone_device *tz = to_thermal_zone(dev);
>>   	int trip, ret;
>> -	int temperature;
>> +	int temperature, hyst = 0;
>> +	enum thermal_trip_type type;
>>   
>>   	if (!tz->ops->set_trip_temp)
>>   		return -EPERM;
>> @@ -139,6 +140,18 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
>>   	if (ret)
>>   		return ret;
>>   
>> +	if (tz->ops->get_trip_hyst) {
>> +		ret = tz->ops->get_trip_hyst(tz, trip, &hyst);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	ret = tz->ops->get_trip_type(tz, trip, &type);
>> +	if (ret)
>> +		return ret;
>> +
>> +	thermal_notify_tz_trip_change(tz->id, trip, type, temperature, hyst);
>> +
>>   	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
>>   
>>   	return count;
> 
> Best regards
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
