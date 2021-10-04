Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243C242094A
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 12:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhJDK0N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Oct 2021 06:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhJDK0N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Oct 2021 06:26:13 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE72C061746
        for <linux-pm@vger.kernel.org>; Mon,  4 Oct 2021 03:24:24 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id s24so13052149wmh.4
        for <linux-pm@vger.kernel.org>; Mon, 04 Oct 2021 03:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=qhMvue8MY09TlNhIY5O7l8PD+1ElyHRcW1aqF7WPAas=;
        b=BEjN7xJ7aKe7IcVE8EAFasILY2HSxM1bvEYN3LzfUxM4lWH0ryxDghWKgTQoNr8C1M
         dWB1K3KkMKtuN7nkyDiaL2zIzsfLApBMRDDKx0dYOGN5cEd9D30p7LazHlXI1QB6TWs7
         drOdWux3ZxlXoalW8eMKWqxfeneFUZlyl7lnBjXuciVkMVkzlPs5OvcXy9lioFLNioY+
         Ruz5Frc/yRTbqbUEtutMVin2B50ES7Yb3Zu4d83siGkQ05A/6EWrQG9FyedkScr0xES2
         /APmM9KNnYegiUFfNBb5EDoquHfbXdh6BrWii8xs7sRJwAlgL15oCo251BxsZI3lB+IQ
         OK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qhMvue8MY09TlNhIY5O7l8PD+1ElyHRcW1aqF7WPAas=;
        b=e33nHhAiRMuNwf68BwQA6/aRMGjm6kdOrD7ekR/1gZp4kDy19v/bautOfhNlvZ0aP0
         wpKUfmIfZ7Bxaa/ruKNh7Fj6Et0wAzjUmbM5tQmE81xIEEctV5VI0qKlW2hH8WWt2qxu
         OlbxtA1UjYH+0Q78/9Bec0leNlYXME96I2jG30QDK4YAy6kjN20zMZ9sIbUcstbk7IEf
         sluaUxNm+8TmcvvoiCPMZiFiZtAWIoTNqC6BNEx+FE2b4kRM8ynQ8aGbN56RuPEwJCgv
         krcDmet4M8qOr0KUVHi81elRmJOAtgyttP1lktg+yz/OoowoDB9tvp+AhqLH9or0JROq
         Fu0g==
X-Gm-Message-State: AOAM530b/pffaCSk8ydl7hAh7x84QXDnZkKaeXGJXmpLZNgTeuZ8oBF9
        px3dsJ49df15RdQePr73AGujfg==
X-Google-Smtp-Source: ABdhPJy7t/11I9x8pk5RAGuUz5/1RojADbVOJ366thVf9D6fKyfuGfH/AgNUXQjEsHaLloI6+yxZGQ==
X-Received: by 2002:a1c:14b:: with SMTP id 72mr2524159wmb.188.1633343063146;
        Mon, 04 Oct 2021 03:24:23 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 2sm721952wmf.30.2021.10.04.03.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 03:24:22 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Add a generic virtual thermal sensor
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com, mka@chromium.org
References: <20210917072732.611140-1-abailon@baylibre.com>
 <bd347d14-0b42-f9ed-bf15-080c929e1cb7@linaro.org>
 <7cddcdb7-4efd-bfdb-3d86-f5862ea0b7fe@baylibre.com>
 <8a9e5f13-6253-2d0d-35a8-789090af4521@linaro.org>
 <c395abad-598b-c06a-9252-c8e62c977188@baylibre.com>
 <794e62ea-d867-3827-de5f-24ddc86c3524@linaro.org>
From:   Alexandre Bailon <abailon@baylibre.com>
Message-ID: <4446577e-c7fa-daeb-e0fe-8a530633ef5d@baylibre.com>
Date:   Mon, 4 Oct 2021 12:24:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <794e62ea-d867-3827-de5f-24ddc86c3524@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 9/22/21 10:10 AM, Daniel Lezcano wrote:
> On 20/09/2021 15:12, Alexandre Bailon wrote:
>> On 9/17/21 4:03 PM, Daniel Lezcano wrote:
>>> On 17/09/2021 15:33, Alexandre Bailon wrote:
>>>> Hi Daniel,
>>>>
>>>> On 9/17/21 2:41 PM, Daniel Lezcano wrote:
>>>>> On 17/09/2021 09:27, Alexandre Bailon wrote:
>>>>>> This series add a virtual thermal sensor.
>>>>>> It could be used to get a temperature using some thermal sensors.
>>>>>> Currently, the supported operations are max, min and avg.
>>>>>> The virtual sensor could be easily extended to support others
>>>>>> operations.
>>>>>>
>>>>>> Note:
>>>>>> Currently, thermal drivers must explicitly register their sensors to
>>>>>> make them
>>>>>> available to the virtual sensor.
>>>>>> This doesn't seem a good solution to me and I think it would be
>>>>>> preferable to
>>>>>> update the framework to register the list of each available sensors.
>>>>> Why must the drivers do that ?
>>>> Because there are no central place where thermal sensor are registered.
>>>> The only other way I found was to update thermal_of.c,
>>>> to register the thermal sensors and make them available later to the
>>>> virtual thermal sensor.
>>>>
>>>> To work, the virtual thermal need to get the sensor_data the ops from
>>>> the thermal sensor.
>>>> And as far I know, this is only registered in thermal_of.c, in the
>>>> thermal zone data
>>>> but I can't access it directly from the virtual thermal sensor.
>>>>
>>>> How would you do it ?
>>> Via the phandles when registering the virtual sensor ?
>> As far I know, we can't get the ops or the sensor_data from the phandle
>> of a thermal sensor.
>> The closest solution I found so far would be to aggregate the thermal
>> zones instead of thermal sensors.
>> thermal_zone_device has the data needed and a thermal zone could be find
>> easily using its name.
> Yeah, the concept of the thermal zone and the sensor are very close.
>
> There is the function in thermal_core.h:
>
>   -> for_each_thermal_zone()
>
> You should be able for each 'slave' sensor, do a lookup to find the
> corresponding thermal_zone_device_ops.
>
>> But, using a thermal_zone_device, I don't see how to handle module
>> unloading.
> I think try_module_get() / module_put() are adequate for this situation
> as it is done on an external module and we can not rely on the exported
> symbols.
I don't see how it would be possible to use these functions.
The thermal zone doesn't have the data required to use it.

Maybe a more easier way is to use the thermal_zone_device mutex.
If I get a lock before to use the thermal_zone_device ops, I have the 
guaranty that module won't be unloaded.

When a "thermal of sensor" is unloaded, it calls 
thermal_zone_of_sensor_unregister which takes a lock before
update ops.

Thanks,
Alexandre

>
