Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1321BC3B5
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 17:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgD1PaJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Apr 2020 11:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727931AbgD1PaI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Apr 2020 11:30:08 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DA3C03C1AB
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2020 08:30:08 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t14so25123496wrw.12
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2020 08:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gauwVclIV+e8Frz/1f+prutYjm++yrOKvLzkWVUtHsU=;
        b=HC/NX2E1Y8aQY5lBYYTkrizcrUkGhE3ln0zPxPZvsH3BzzL+7cQb/4oXhOsmUWU4TD
         bgD6Sv4Cr/2mGu/VyEjEpr8Sauw9uUk/tJC26h3OKMS2/Tlgfdh1JqejVzJTd/x4Q3W6
         8WlHf2T89qV4t8QhwiHcUGlOQDEFXHcoGBteeonTjK8/8BPiRU5iX1EXmaZGiGOF7D1K
         6R7l/yx+AMDCWppcRyKD3+IwFer8eiAZWCWgoTiACin86X7ZTaNALd7KXRUjHswsJqLu
         csj1DAwx65NZegZ7EeZ6CkXSSwLu6Ztp+JKrXKuFBcf4UMemXwzUzSu3YVIQfGQUNXFC
         Cyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gauwVclIV+e8Frz/1f+prutYjm++yrOKvLzkWVUtHsU=;
        b=XbTgjswMa1iZM5YkGsCwpMAb6RKFyfMHFC5ezwpsDfC2W/RMV4HeMAzRQIRiTaLN8b
         9z8/JPb+QfRrZSvnSdT2sNY6TwiRFra8lbOc1wFuk2XYkdVP1uix2832JNE9DfeOOgqP
         zvywFaiygobOn5BiXWB1usZWu6fFuFqoJmgZfriO8UAZ8znpA+/C4GVzCY2rM2+SImeG
         miyAJXwNJErpgIxj/7mJXJWsrZkooNpkopcTUblLnHj1dFZsNmzrvSNPXmBIk3zLXmiq
         NqDlUt/lEIH3XTGWWgWrQVwicThoCHty6pURs7qWm4885t+2yUcxPnCHPT5VAzKcaZKS
         ZLaw==
X-Gm-Message-State: AGi0PuZWGm8GfGDRrAFu4l10Y180NL7gn+Agm22nv64SQngDjYcXpDrp
        Vx0UICfRUBRJWaMvcik3KRdeng==
X-Google-Smtp-Source: APiQypJTmBcHpbtsW21xaYaE/ehqyHTbUvunr6RDFNGCkwj49JdUj43sxWA/wG6e27gOTlrZLuNl5w==
X-Received: by 2002:adf:fc4f:: with SMTP id e15mr34026835wrs.415.1588087806772;
        Tue, 28 Apr 2020 08:30:06 -0700 (PDT)
Received: from [192.168.0.41] (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.googlemail.com with ESMTPSA id s14sm3905547wme.33.2020.04.28.08.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 08:30:06 -0700 (PDT)
Subject: Re: [PATCH v3 3/4] thermal/drivers/cpuidle_cooling: Change the
 registration function
To:     Lukasz Luba <lukasz.luba@arm.com>, rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        "open list:THERMAL/CPU_COOLING" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200414220837.9284-1-daniel.lezcano@linaro.org>
 <20200414220837.9284-3-daniel.lezcano@linaro.org>
 <4a8483a5-b481-5e97-9d03-f1ad3ae163d5@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <88ae483d-2239-5af6-7ba1-2c5e7acb4042@linaro.org>
Date:   Tue, 28 Apr 2020 17:30:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <4a8483a5-b481-5e97-9d03-f1ad3ae163d5@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Lukasz,

On 28/04/2020 17:20, Lukasz Luba wrote:
> Hi Daniel,
> 
> I have checked the patches and run them on Juno.
> Please find my comments below.

thanks a lot for the review and the testing.



> On 4/14/20 11:08 PM, Daniel Lezcano wrote:
>> Today, there is no user for the cpuidle cooling device. The targetted
>> platform is ARM and ARM64.
>>
>> The cpuidle and the cpufreq cooling device are based on the device tree.
>>
>> As the cpuidle cooling device can have its own configuration depending
>> on the platform and the available idle states. The DT node description
>> will give the optional properties to set the cooling device up.
>>
>> Do no longer rely on the CPU node which is prone to error and will
>> lead to a confusion in the DT because the cpufreq cooling device is
>> also using it. Let initialize the cpuidle cooling device with the DT
>> binding.
>>
>> This was tested on:
>>   - hikey960
>>   - hikey6220
>>   - rock960
>>   - db845c
>>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   drivers/thermal/cpuidle_cooling.c | 58 +++++++++++++++++++++++++------
>>   include/linux/cpu_cooling.h       |  7 ----
>>   2 files changed, 47 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/thermal/cpuidle_cooling.c
>> b/drivers/thermal/cpuidle_cooling.c
>> index 0bb843246f59..b2c81c427f05 100644
>> --- a/drivers/thermal/cpuidle_cooling.c
>> +++ b/drivers/thermal/cpuidle_cooling.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/err.h>
>>   #include <linux/idle_inject.h>
>>   #include <linux/idr.h>
>> +#include <linux/of_device.h>
>>   #include <linux/slab.h>
>>   #include <linux/thermal.h>
>>   @@ -154,22 +155,25 @@ static struct thermal_cooling_device_ops
>> cpuidle_cooling_ops = {
>>   };
>>     /**
>> - * cpuidle_of_cooling_register - Idle cooling device initialization
>> function
>> + * __cpuidle_cooling_register: register the cooling device
>>    * @drv: a cpuidle driver structure pointer
>> - * @np: a node pointer to a device tree cooling device node
>> + * @np: a device node structure pointer used for the thermal binding
>>    *
>> - * This function is in charge of creating a cooling device per cpuidle
>> - * driver and register it to thermal framework.
>> + * This function is in charge of allocating the cpuidle cooling device
>> + * structure, the idle injection, initialize them and register the
>> + * cooling device to the thermal framework.
>>    *
>> - * Return: zero on success, or negative value corresponding to the
>> - * error detected in the underlying subsystems.
>> + * Return: zero on success, a negative value returned by one of the
>> + * underlying subsystem in case of error
>>    */
>> -int cpuidle_of_cooling_register(struct device_node *np,
>> -                struct cpuidle_driver *drv)
>> +static int __cpuidle_cooling_register(struct device_node *np,
>> +                      struct cpuidle_driver *drv)
>>   {
>>       struct idle_inject_device *ii_dev;
>>       struct cpuidle_cooling_device *idle_cdev;
>>       struct thermal_cooling_device *cdev;
>> +    unsigned int idle_duration_us = TICK_USEC;
>> +    unsigned int latency_us = UINT_MAX;
>>       char dev_name[THERMAL_NAME_LENGTH];
>>       int id, ret;
>>   @@ -191,7 +195,11 @@ int cpuidle_of_cooling_register(struct
>> device_node *np,
>>           goto out_id;
>>       }
>>   -    idle_inject_set_duration(ii_dev, TICK_USEC, TICK_USEC);
>> +    of_property_read_u32(np, "duration", &idle_duration_us);
> 
> This probably is 'duration-us' according to DT bindings.
> 
>> +    of_property_read_u32(np, "latency", &latency_us);
> 
> the same here s/latency/exit-latency-us/
> 
>> +
>> +    idle_inject_set_duration(ii_dev, TICK_USEC, idle_duration_us);
>> +    idle_inject_set_latency(ii_dev, latency_us);
>>         idle_cdev->ii_dev = ii_dev;
>>   @@ -204,6 +212,9 @@ int cpuidle_of_cooling_register(struct
>> device_node *np,
>>           goto out_unregister;
>>       }
>>   +    pr_info("%s: Idle injection set with idle duration=%u,
>> latency=%u\n",
>> +        dev_name, idle_duration_us, latency_us);
> 
> 1. It is more like a 'debug' rather than 'info', I would change it.
> 2. This is going to be printed for every CPU which has the
> 'thermal-idle' feature in DT. For platforms with many CPUs, it's a lot
> of log entries
> 
>> +
>>       return 0;
>>     out_unregister:
>> @@ -221,12 +232,37 @@ int cpuidle_of_cooling_register(struct
>> device_node *np,
>>    * @drv: a cpuidle driver structure pointer
>>    *
>>    * This function is in charge of creating a cooling device per cpuidle
>> - * driver and register it to thermal framework.
>> + * driver and register it to the thermal framework.
>>    *
>>    * Return: zero on success, or negative value corresponding to the
>>    * error detected in the underlying subsystems.
>>    */
>>   int cpuidle_cooling_register(struct cpuidle_driver *drv)
>>   {
>> -    return cpuidle_of_cooling_register(NULL, drv);
>> +    struct device_node *cooling_node;
>> +    struct device_node *cpu_node;
>> +    int cpu, ret;
>> +
>> +    for_each_cpu(cpu, drv->cpumask) {
>> +
>> +        cpu_node = of_cpu_device_node_get(cpu);
>> +
>> +        cooling_node = of_get_child_by_name(cpu_node, "idle-thermal");
> 
> In DT binding this is 'thermal-idle'.
> 
>> +
>> +        of_node_put(cpu_node);
>> +
>> +        if (!cooling_node)
>> +            continue;
> 
> This 'continue' is suspicious because it won't tell if there was no
> node "idle-thermal" but still the function will return 0. This was
> my case when I tried to enable it on Juno.
> 
> Maybe a debug print that the node hasn't been found would be a
> good idea. Or somehow return different value than 0 taking into
> account that every CPU was skipped.
> 
>> +
>> +        ret = __cpuidle_cooling_register(cooling_node, drv);
>> +
>> +        of_node_put(cooling_node);
>> +
>> +        if (ret)
>> +            return ret;
>> +
>> +        cooling_node = NULL;
>> +    }
>> +
>> +    return 0;
>>   }
>> diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
>> index 65501d8f9778..4d7b4a303327 100644
>> --- a/include/linux/cpu_cooling.h
>> +++ b/include/linux/cpu_cooling.h
>> @@ -64,18 +64,11 @@ struct cpuidle_driver;
>>     #ifdef CONFIG_CPU_IDLE_THERMAL
>>   int cpuidle_cooling_register(struct cpuidle_driver *drv);
>> -int cpuidle_of_cooling_register(struct device_node *np,
>> -                struct cpuidle_driver *drv);
>>   #else /* CONFIG_CPU_IDLE_THERMAL */
>>   static inline int cpuidle_cooling_register(struct cpuidle_driver *drv)
>>   {
>>       return 0;
>>   }
>> -static inline int cpuidle_of_cooling_register(struct device_node *np,
>> -                          struct cpuidle_driver *drv)
>> -{
>> -    return 0;
>> -}
>>   #endif /* CONFIG_CPU_IDLE_THERMAL */
>>     #endif /* __CPU_COOLING_H__ */
>>
> 
> Apart from that, looks good to me.
> 
> Regards,
> Lukasz


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
