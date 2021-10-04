Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3B74210C2
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 15:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238201AbhJDNzi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Oct 2021 09:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237843AbhJDNzf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Oct 2021 09:55:35 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F015C0F0B10
        for <linux-pm@vger.kernel.org>; Mon,  4 Oct 2021 06:42:15 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id o20so12861950wro.3
        for <linux-pm@vger.kernel.org>; Mon, 04 Oct 2021 06:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mtz35q9ABuFN+CK5hf2AG1t0ykowpejibjVVWQeLpP0=;
        b=Hzq5mvML2A0agWPVEdD0xmYlGsiiUHds44RNX5TZOo3ahI4uNEEDrvCeaglWRGfx2w
         B0TuKivDPHuxH1NVbXrfIZq/xlKtVdt1F3geJJop/Xszj0S/KHOPSqLlSEjfIeHQzYVZ
         Hkcl5QYQlel0QpgGLrcDXolzYRbUIaCJCU3D1Me6+0CUHM+coqtYCGg38EkAsH+59KEh
         yeo8+bPANMxa3f8VEKTY2TsfdiZLefPqsdBKdifOTMQDac/qsX4vNwnMotk27PskDhgQ
         7N3qijpg0kXwhbR7j0OvPxzmYujJKfeWvWWAYCVrdDTDJ3SdGZD5mDd9OWqC3dyDe1i1
         0Yog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mtz35q9ABuFN+CK5hf2AG1t0ykowpejibjVVWQeLpP0=;
        b=M147MGOfuuyF0agh8fxcY3mok9xojJtOvobNt+jSjmBNjUC78qQ89TtxdDlls554ls
         rI2HSkX5vsB8hsUaWmLLUDRQ7O/X7d88HLi9IahmA11sNHCaPn0xY/VgF7kLfZ5GGYS7
         +6+Pxk/yy3Ep98pnofaCcQGzoxxsRL4AA6wjKAcycylzpFGvY+esvsUZOoptalsEfW0U
         6SRjFbA/Ozvar/omuugLbgFcoHcX/7AowWwAtL/fNwAuxvKBU+f4SvpEoHmBdzvce6aV
         LNtYlkT/pzCA80Mw0ReNfUsGXrbmLJehd+XPmkYusA+nSqdaF5SzqD2Ex4LDbBOdDpjX
         aobg==
X-Gm-Message-State: AOAM531Tnnc8ymARQdyvjM02YaPFfB1w1y6KW3qRYmT/yeWUHY06qgvb
        3A2QdZtNbPo12vdMX4SwK6qgqQ==
X-Google-Smtp-Source: ABdhPJyqMowfZo4n6GIWwaewsjxxOPvjBdEZo4kthIj+8BcqLY8VgCjHMTEcDvZrUp8Mvig5Ab0+Sg==
X-Received: by 2002:a5d:4882:: with SMTP id g2mr13990446wrq.399.1633354933923;
        Mon, 04 Oct 2021 06:42:13 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:d626:282a:6f9d:3f57? ([2a01:e34:ed2f:f020:d626:282a:6f9d:3f57])
        by smtp.googlemail.com with ESMTPSA id y10sm4418338wrw.5.2021.10.04.06.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 06:42:13 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Add a generic virtual thermal sensor
To:     Alexandre Bailon <abailon@baylibre.com>, rui.zhang@intel.com,
        amitk@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com, mka@chromium.org
References: <20210917072732.611140-1-abailon@baylibre.com>
 <bd347d14-0b42-f9ed-bf15-080c929e1cb7@linaro.org>
 <7cddcdb7-4efd-bfdb-3d86-f5862ea0b7fe@baylibre.com>
 <8a9e5f13-6253-2d0d-35a8-789090af4521@linaro.org>
 <c395abad-598b-c06a-9252-c8e62c977188@baylibre.com>
 <794e62ea-d867-3827-de5f-24ddc86c3524@linaro.org>
 <4446577e-c7fa-daeb-e0fe-8a530633ef5d@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d24ce6ec-eced-4e16-eb59-7c87f596ccca@linaro.org>
Date:   Mon, 4 Oct 2021 15:42:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <4446577e-c7fa-daeb-e0fe-8a530633ef5d@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04/10/2021 12:24, Alexandre Bailon wrote:
> 
> On 9/22/21 10:10 AM, Daniel Lezcano wrote:
>> On 20/09/2021 15:12, Alexandre Bailon wrote:
>>> On 9/17/21 4:03 PM, Daniel Lezcano wrote:
>>>> On 17/09/2021 15:33, Alexandre Bailon wrote:
>>>>> Hi Daniel,
>>>>>
>>>>> On 9/17/21 2:41 PM, Daniel Lezcano wrote:
>>>>>> On 17/09/2021 09:27, Alexandre Bailon wrote:
>>>>>>> This series add a virtual thermal sensor.
>>>>>>> It could be used to get a temperature using some thermal sensors.
>>>>>>> Currently, the supported operations are max, min and avg.
>>>>>>> The virtual sensor could be easily extended to support others
>>>>>>> operations.
>>>>>>>
>>>>>>> Note:
>>>>>>> Currently, thermal drivers must explicitly register their sensors to
>>>>>>> make them
>>>>>>> available to the virtual sensor.
>>>>>>> This doesn't seem a good solution to me and I think it would be
>>>>>>> preferable to
>>>>>>> update the framework to register the list of each available sensors.
>>>>>> Why must the drivers do that ?
>>>>> Because there are no central place where thermal sensor are
>>>>> registered.
>>>>> The only other way I found was to update thermal_of.c,
>>>>> to register the thermal sensors and make them available later to the
>>>>> virtual thermal sensor.
>>>>>
>>>>> To work, the virtual thermal need to get the sensor_data the ops from
>>>>> the thermal sensor.
>>>>> And as far I know, this is only registered in thermal_of.c, in the
>>>>> thermal zone data
>>>>> but I can't access it directly from the virtual thermal sensor.
>>>>>
>>>>> How would you do it ?
>>>> Via the phandles when registering the virtual sensor ?
>>> As far I know, we can't get the ops or the sensor_data from the phandle
>>> of a thermal sensor.
>>> The closest solution I found so far would be to aggregate the thermal
>>> zones instead of thermal sensors.
>>> thermal_zone_device has the data needed and a thermal zone could be find
>>> easily using its name.
>> Yeah, the concept of the thermal zone and the sensor are very close.
>>
>> There is the function in thermal_core.h:
>>
>>   -> for_each_thermal_zone()
>>
>> You should be able for each 'slave' sensor, do a lookup to find the
>> corresponding thermal_zone_device_ops.
>>
>>> But, using a thermal_zone_device, I don't see how to handle module
>>> unloading.
>> I think try_module_get() / module_put() are adequate for this situation
>> as it is done on an external module and we can not rely on the exported
>> symbols.
> I don't see how it would be possible to use these functions.
> The thermal zone doesn't have the data required to use it.

Actually I was able to crash the kernel by doing:

console 1:

while $(true); do insmod <module> && rmmod <module>; done

console 2:

while $(true); cat /sys/class/thermal/thermal_zone0/temp; done

So there is something wrong already in the thermal framework.

IMO, the first thing would be to fix this critical issue by getting the
sensor module refcount when the thermal zone is enabled and dropping it
when it is disabled.

With that fixed, perhaps it will possible to get the device associated
with the sensor and then try_module_get(dev->driver->owner)

> Maybe a more easier way is to use the thermal_zone_device mutex.
> If I get a lock before to use the thermal_zone_device ops, I have the
> guaranty that module won't be unloaded.
> 
> When a "thermal of sensor" is unloaded, it calls
> thermal_zone_of_sensor_unregister which takes a lock before
> update ops.

I'm not sure to understand. The goal is to have the refcount on the
modules to be incremented when the virtual sensor is using them.

Until the virtual sensor is registered, it will prevent the other
modules to be unloaded.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
