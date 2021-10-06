Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458C2424788
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 21:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239370AbhJFTxO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 15:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhJFTxN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Oct 2021 15:53:13 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296C1C061753
        for <linux-pm@vger.kernel.org>; Wed,  6 Oct 2021 12:51:21 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r7so12076901wrc.10
        for <linux-pm@vger.kernel.org>; Wed, 06 Oct 2021 12:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ai+3e+yiFoC0J7qCJE8CRMoYpaETZPv1B+QsKQNKBxU=;
        b=vq92d5MG8j8llq6Xph+KAv7K4wXgj0wJmuOKotV38cwtMqtlgj4lWKv/JntIbU5EeK
         Hn5l1OQ8Qo/+Nt34hF9ra5wLzYJJfOeE+kvUh89usr5JpWK2TkFyV3iPYR+Zx5NhrWb1
         NkPOALpBL2vYCt6DfKuDV4HJCTE0n2UDBSYPbldzzZeIHf9HtY+bbxMRfE8gB57m0g2t
         8BIfqB2gOfOEN4b/zyQkf0PvlN/xKK4WTUCGktDUwUWNpxCNo/RPOwpzegZ4TrSU/yMV
         DDqtyIWtCzKS/WFS0d9jGsFPBZ3iZSeOl3FSqW50nQpcmcYqZiDz0rHymhHG/JJeqZnq
         jQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ai+3e+yiFoC0J7qCJE8CRMoYpaETZPv1B+QsKQNKBxU=;
        b=iwf0YzZWqYz1CDEcsOECUyZZne0BvMhRZs87Aksvk0T6pPNqLKTCyxFuOSRL13m7BZ
         w+2lvlfKb1V5Aw0FpxVsvTPp6ZNwIut6ruXkn8GhK4ZBx08XELgO29PXPrMASph3pbm4
         lOnbBrUk7YjRvIMaJGiSZLdr0dv31nB4HSV8drN7effA81TYYgxdnxHgncFxzG72YqO/
         byRJHQafqRwU5ETotEEC6IVlvsQoY2LuEL/OyCDiSp4hdAhyGduLkcT1OVbEUzcbkdcZ
         VrL9wezZY239Dl5MdLvqAtS/9ophlTU2kZ7lfJXEGHnORcPB3SJmfIf3+ims/C5iKWA+
         VzuQ==
X-Gm-Message-State: AOAM531q4gdM/9oonUs2CHArfCht0mGAC3S6xaAhzepqY8Sucsomj/S5
        zGjqCrzSTjPETLqSg9pQAmWaLQ==
X-Google-Smtp-Source: ABdhPJx77kifp8RGOMEluU2Yx0AvabGAllw9zyaPv/0lhbrR2NS6U+KBh4ugFKXFnmWOTjBVHzRObg==
X-Received: by 2002:a1c:2358:: with SMTP id j85mr11972972wmj.1.1633549879474;
        Wed, 06 Oct 2021 12:51:19 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:278:1f59:2992:87fe? ([2a01:e34:ed2f:f020:278:1f59:2992:87fe])
        by smtp.googlemail.com with ESMTPSA id j11sm3746772wrp.27.2021.10.06.12.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 12:51:18 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Add a generic virtual thermal sensor
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ben.tseng@mediatek.com, Kevin Hilman <khilman@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>
References: <20210917072732.611140-1-abailon@baylibre.com>
 <bd347d14-0b42-f9ed-bf15-080c929e1cb7@linaro.org>
 <7cddcdb7-4efd-bfdb-3d86-f5862ea0b7fe@baylibre.com>
 <8a9e5f13-6253-2d0d-35a8-789090af4521@linaro.org>
 <c395abad-598b-c06a-9252-c8e62c977188@baylibre.com>
 <794e62ea-d867-3827-de5f-24ddc86c3524@linaro.org>
 <4446577e-c7fa-daeb-e0fe-8a530633ef5d@baylibre.com>
 <d24ce6ec-eced-4e16-eb59-7c87f596ccca@linaro.org>
 <CAJZ5v0iJCS+nRcnHXiprtJsBf6Q4=k4TFcUV2ma_GiK=MttFug@mail.gmail.com>
 <03aeb132-bc0c-93f7-c7db-8575a665d2a7@linaro.org>
 <CAJZ5v0gVgw4qT9jmfr8U+t0j3JdmAAuVFf785NHozQxuKr56MA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <566c8f70-1445-caef-811d-398729869719@linaro.org>
Date:   Wed, 6 Oct 2021 21:51:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gVgw4qT9jmfr8U+t0j3JdmAAuVFf785NHozQxuKr56MA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/10/2021 20:00, Rafael J. Wysocki wrote:
> On Wed, Oct 6, 2021 at 6:06 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 05/10/2021 18:45, Rafael J. Wysocki wrote:
>>> On Mon, Oct 4, 2021 at 3:42 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> On 04/10/2021 12:24, Alexandre Bailon wrote:
>>>>>
>>>>> On 9/22/21 10:10 AM, Daniel Lezcano wrote:
>>>>>> On 20/09/2021 15:12, Alexandre Bailon wrote:
>>>>>>> On 9/17/21 4:03 PM, Daniel Lezcano wrote:
>>>>>>>> On 17/09/2021 15:33, Alexandre Bailon wrote:
>>>>>>>>> Hi Daniel,
>>>>>>>>>
>>>>>>>>> On 9/17/21 2:41 PM, Daniel Lezcano wrote:
>>>>>>>>>> On 17/09/2021 09:27, Alexandre Bailon wrote:
>>>>>>>>>>> This series add a virtual thermal sensor.
>>>>>>>>>>> It could be used to get a temperature using some thermal sensors.
>>>>>>>>>>> Currently, the supported operations are max, min and avg.
>>>>>>>>>>> The virtual sensor could be easily extended to support others
>>>>>>>>>>> operations.
>>>>>>>>>>>
>>>>>>>>>>> Note:
>>>>>>>>>>> Currently, thermal drivers must explicitly register their sensors to
>>>>>>>>>>> make them
>>>>>>>>>>> available to the virtual sensor.
>>>>>>>>>>> This doesn't seem a good solution to me and I think it would be
>>>>>>>>>>> preferable to
>>>>>>>>>>> update the framework to register the list of each available sensors.
>>>>>>>>>> Why must the drivers do that ?
>>>>>>>>> Because there are no central place where thermal sensor are
>>>>>>>>> registered.
>>>>>>>>> The only other way I found was to update thermal_of.c,
>>>>>>>>> to register the thermal sensors and make them available later to the
>>>>>>>>> virtual thermal sensor.
>>>>>>>>>
>>>>>>>>> To work, the virtual thermal need to get the sensor_data the ops from
>>>>>>>>> the thermal sensor.
>>>>>>>>> And as far I know, this is only registered in thermal_of.c, in the
>>>>>>>>> thermal zone data
>>>>>>>>> but I can't access it directly from the virtual thermal sensor.
>>>>>>>>>
>>>>>>>>> How would you do it ?
>>>>>>>> Via the phandles when registering the virtual sensor ?
>>>>>>> As far I know, we can't get the ops or the sensor_data from the phandle
>>>>>>> of a thermal sensor.
>>>>>>> The closest solution I found so far would be to aggregate the thermal
>>>>>>> zones instead of thermal sensors.
>>>>>>> thermal_zone_device has the data needed and a thermal zone could be find
>>>>>>> easily using its name.
>>>>>> Yeah, the concept of the thermal zone and the sensor are very close.
>>>>>>
>>>>>> There is the function in thermal_core.h:
>>>>>>
>>>>>>   -> for_each_thermal_zone()
>>>>>>
>>>>>> You should be able for each 'slave' sensor, do a lookup to find the
>>>>>> corresponding thermal_zone_device_ops.
>>>>>>
>>>>>>> But, using a thermal_zone_device, I don't see how to handle module
>>>>>>> unloading.
>>>>>> I think try_module_get() / module_put() are adequate for this situation
>>>>>> as it is done on an external module and we can not rely on the exported
>>>>>> symbols.
>>>>> I don't see how it would be possible to use these functions.
>>>>> The thermal zone doesn't have the data required to use it.
>>>>
>>>> Actually I was able to crash the kernel by doing:
>>>>
>>>> console 1:
>>>>
>>>> while $(true); do insmod <module> && rmmod <module>; done
>>>>
>>>> console 2:
>>>>
>>>> while $(true); cat /sys/class/thermal/thermal_zone0/temp; done
>>>>
>>>> So there is something wrong already in the thermal framework.
>>>
>>> Hmmm.
>>>
>>>> IMO, the first thing would be to fix this critical issue by getting the
>>>> sensor module refcount when the thermal zone is enabled and dropping it
>>>> when it is disabled.
>>>>
>>>> With that fixed, perhaps it will possible to get the device associated
>>>> with the sensor and then try_module_get(dev->driver->owner)
>>>>
>>>>> Maybe a more easier way is to use the thermal_zone_device mutex.
>>>>> If I get a lock before to use the thermal_zone_device ops, I have the
>>>>> guaranty that module won't be unloaded.
>>>
>>> That would be my approach too.
>>
>> The mutex is private to the thermal core. The virtual sensor should not
>> touch it :/
>>
>> Perhaps, it can work with a private spin_lock with a try_spinlock() ?
> 
> IIUC this is a case when module A refers to some memory in module B
> and if the latter goes away, an access to that memory from the former
> is a use-after-free, so it is not sufficient to use a local spinlock.

> This can be avoided by having a lock and a flag such that the flag is
> set under the lock by module B when making the memory in question
> available and cleared under the lock when freeing that memory.  Then,
> module A needs to check the flag under the lock on every access to
> that memory.  Also, the lock and the flag must be accessible all the
> time to both modules (ie. must not go away along with any of them if
> they don't depend on each other).

Just to clarify, the idea behind the virtual sensor is the same as the
network bridge: the network interfaces are not aware they are attached
to a bridge.

The virtual sensor should attach and detach the physical sensors.

The sensors should not un|register themselves from|to the virtual
sensor, nor having specific code related to the virtual sensor. De
facto, all the existing sensors will be compatible with the virtual sensor.

Do we have a solution other than grabbing a module reference and
self-contained to the virtual sensor ?

>>>>> When a "thermal of sensor" is unloaded, it calls
>>>>> thermal_zone_of_sensor_unregister which takes a lock before
>>>>> update ops.
>>>>
>>>> I'm not sure to understand. The goal is to have the refcount on the
>>>> modules to be incremented when the virtual sensor is using them.
>>>
>>> IMO the goal is to prevent the code from crashing when modules get
>>> unloaded.  I'm not really sure if refcounts alone are sufficient for
>>> that.
>>
>> The problem is in the loop:
>>
>> +static int virtual_thermal_sensor_get_temp(void *data, int *temperature)
>> +{
>> +       struct virtual_thermal_sensor *sensor = data;
>> +       int max_temp = INT_MIN;
>> +       int temp;
>> +       int i;
>> +
>> +       for (i = 0; i < sensor->count; i++) {
>> +               struct thermal_sensor_data *hw_sensor;
>> +
>> +               hw_sensor = &sensor->sensors[i];
>> +               if (!hw_sensor->ops)
>> +                       return -ENODEV;
>> +
>> +               hw_sensor->ops->get_temp(hw_sensor->sensor_data, &temp);
>> +               max_temp = sensor->aggr_temp(max_temp, temp);
>> +       }
>> +
>> +       *temperature = max_temp;
>> +
>> +       return 0;
>> +}
>>
>> If one of the sensor is unloaded when get_temp is called,
>> hw_sensor->ops->get_temp will crash.
> 
> Right.
> 
> Dereferencing hw_sensor itself is not safe in this loop if the module
> holding the memory pointed to by it may go away.
> 
> However, presumably, the hw_sensor object needs to be registered with
> the core in order to be used here and unregistered when it goes away,
> so it looks like this loop could use a wrapper like
> thermal_get_sensor_temp(hw_sensor, &temp) which would return a
> negative error code if the sensor in question went away.
> 
> Of course, that would require the core to check the list of available
> sensors every time, but that may be implemented efficiently with the
> help of an xarray, for example.
> 
>> So the proposal is virtual_sensor_add_sensor() does try_get_module()
>> and virtual_sensor_remove_sensor() does put_module().
>>
>> The ref on the 'slave' modules will be release only if the virtual
>> sensor is unregistered.
>>
>> So until, the virtual sensor is unregistered, the 'slaves' modules can
>> not be unloaded.
>>
>> That is what we find with eg. the wifi modules.
> 
> Yes, but that's a bit cumbersome from the sysadmin perspective IMO,
> especially when one wants to unload one of the modules and doesn't
> know exactly what other modules hold references to it.

Well, sysadmin are not supposed to unload a thermal sensor and I would
say if he unloads the module, which is not an usual operation, up to him
to 'lsmod' and check what module is holding the reference.

> IIUC ref_module() might be nicer, but it is still more convenient if
> the modules can just go away independently.

"for desesperate users" :)


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
