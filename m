Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3592F414342
	for <lists+linux-pm@lfdr.de>; Wed, 22 Sep 2021 10:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbhIVIMD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Sep 2021 04:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbhIVIMC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Sep 2021 04:12:02 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC64CC061574
        for <linux-pm@vger.kernel.org>; Wed, 22 Sep 2021 01:10:32 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id w17so4128212wrv.10
        for <linux-pm@vger.kernel.org>; Wed, 22 Sep 2021 01:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sjfqFtjdJ7BBJE8A/g20sALymYT3IpdH2eEO6YWS1Ds=;
        b=NNr9niA+rBKeMBi4aYpw3WOaB0s1c/Z+kBCqwKQ3VhAQqBU8VvqNqHRcw8dyFIhbll
         hAUlZD7/S9i0b6btgaCsEwp1bmXYA6x8BpEif/8Y9WhBiGRmbqtVtTo/n+V+mCrg41In
         HvvCul9Or1Kx07sjTLimYABtPLaV+xIYyyfNmAjYqH/P41OGQWbgnI7Qwctvl2uRH1Va
         2Bzub4Uge2VG9mAwAklB4EVK8qnQTzPeYwyWVoZxQckjBv54trntvgB2QC8PLyOGv1Sx
         xSyoHhlHQZ21hBTt35bBYxvv+oJQfldUXKWwdf5IA+0lCIGu92Sbeb95aVRsMXKdxWke
         /w8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sjfqFtjdJ7BBJE8A/g20sALymYT3IpdH2eEO6YWS1Ds=;
        b=MdOhOzgUohsnIrJYDxBq3YtW+nvqPpGyeoxIgoa2hrfidZKvDf8jb6Qe0w6kwTb2X8
         AaP0czbia9jpecZlHWvlNshClRWXtRWd2xoE2BwHu82tGEO99HYI1VISTmhOvK4/n359
         9YN47piUqqkTd2VlHsl7g6HRE5rhOMWCg7UzHxO5WCqj+RQw1hdk+7SmWucvVo0Dqz8N
         Nh34LScm1JbJ7RDryIawbdkLpgbKjJQyuT2/pC4c7TWnT3ytsXzHWnqgcTtDomRd3Rrm
         EhPgAIOoqo1JCt11KU4FSVnLjyxM2Nab2AXCXb3keqPZRUh6fVgmcTcNGaXvEAMXwyI6
         ZGxA==
X-Gm-Message-State: AOAM533+YCdR0kqpPPt8c0N9X7RZK4i5z/hPa9Qs2T13110ysCiOqHiR
        thp7mYY1VQKUOEEwvXR4pKdrLw==
X-Google-Smtp-Source: ABdhPJxG6e+7AIuhMraVYfb7CeqUJw+ynj10bI0dkQNUJ6u4beKg1vJHhRjSB9PtKdYqRLY11TnjhA==
X-Received: by 2002:a5d:5541:: with SMTP id g1mr41009909wrw.402.1632298231387;
        Wed, 22 Sep 2021 01:10:31 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:8ccc:47ef:19b:1063? ([2a01:e34:ed2f:f020:8ccc:47ef:19b:1063])
        by smtp.googlemail.com with ESMTPSA id k18sm1375822wrh.68.2021.09.22.01.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 01:10:30 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Add a generic virtual thermal sensor
To:     Alexandre Bailon <abailon@baylibre.com>, rui.zhang@intel.com,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com, mka@chromium.org
References: <20210917072732.611140-1-abailon@baylibre.com>
 <bd347d14-0b42-f9ed-bf15-080c929e1cb7@linaro.org>
 <7cddcdb7-4efd-bfdb-3d86-f5862ea0b7fe@baylibre.com>
 <8a9e5f13-6253-2d0d-35a8-789090af4521@linaro.org>
 <c395abad-598b-c06a-9252-c8e62c977188@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <794e62ea-d867-3827-de5f-24ddc86c3524@linaro.org>
Date:   Wed, 22 Sep 2021 10:10:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <c395abad-598b-c06a-9252-c8e62c977188@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20/09/2021 15:12, Alexandre Bailon wrote:
> 
> On 9/17/21 4:03 PM, Daniel Lezcano wrote:
>> On 17/09/2021 15:33, Alexandre Bailon wrote:
>>> Hi Daniel,
>>>
>>> On 9/17/21 2:41 PM, Daniel Lezcano wrote:
>>>> On 17/09/2021 09:27, Alexandre Bailon wrote:
>>>>> This series add a virtual thermal sensor.
>>>>> It could be used to get a temperature using some thermal sensors.
>>>>> Currently, the supported operations are max, min and avg.
>>>>> The virtual sensor could be easily extended to support others
>>>>> operations.
>>>>>
>>>>> Note:
>>>>> Currently, thermal drivers must explicitly register their sensors to
>>>>> make them
>>>>> available to the virtual sensor.
>>>>> This doesn't seem a good solution to me and I think it would be
>>>>> preferable to
>>>>> update the framework to register the list of each available sensors.
>>>> Why must the drivers do that ?
>>> Because there are no central place where thermal sensor are registered.
>>> The only other way I found was to update thermal_of.c,
>>> to register the thermal sensors and make them available later to the
>>> virtual thermal sensor.
>>>
>>> To work, the virtual thermal need to get the sensor_data the ops from
>>> the thermal sensor.
>>> And as far I know, this is only registered in thermal_of.c, in the
>>> thermal zone data
>>> but I can't access it directly from the virtual thermal sensor.
>>>
>>> How would you do it ?
>> Via the phandles when registering the virtual sensor ?
> As far I know, we can't get the ops or the sensor_data from the phandle
> of a thermal sensor.
> The closest solution I found so far would be to aggregate the thermal
> zones instead of thermal sensors.
> thermal_zone_device has the data needed and a thermal zone could be find
> easily using its name.

Yeah, the concept of the thermal zone and the sensor are very close.

There is the function in thermal_core.h:

 -> for_each_thermal_zone()

You should be able for each 'slave' sensor, do a lookup to find the
corresponding thermal_zone_device_ops.

> But, using a thermal_zone_device, I don't see how to handle module
> unloading.

I think try_module_get() / module_put() are adequate for this situation
as it is done on an external module and we can not rely on the exported
symbols.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
