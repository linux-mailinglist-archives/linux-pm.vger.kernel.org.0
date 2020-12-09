Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DA62D3ECB
	for <lists+linux-pm@lfdr.de>; Wed,  9 Dec 2020 10:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgLIJbG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Dec 2020 04:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbgLIJbG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2020 04:31:06 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4158C0613CF
        for <linux-pm@vger.kernel.org>; Wed,  9 Dec 2020 01:30:25 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id q75so900729wme.2
        for <linux-pm@vger.kernel.org>; Wed, 09 Dec 2020 01:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L61+JwkcFzkud7jR/ngEi5aVujc/do/nVLhcrDG/U8k=;
        b=k3RHRHtV5XNvz0FnIXPif1joM+tCHTwCDBCVYI7Fkq4M8PyR36rHWwZVqjJXxHp3QR
         bnfXyMEYEdGkGiprQvtkTXJiOtwSOC0D+O9nk5moay5UV0Ylc7q4QFxcTr2MURouNGmn
         7C93MSB4SgsK5E4IiQ/7ZYiTAHMCh7PDCyVQbIKDKkhfWlI5MtuwgjG8aR444jtUDXDQ
         QUpcCzgWiSEiOnkHysofod4gNjGzP/KjydFr/2dlxZIX2mUT8s66qZQXh+YYN3kO9nhj
         p45rN2rTcRaFWn59p8ud0TXlARrXzP6mo+f9SEz8/QSzT9Vv5tWscIQHk3KAsz4Ku4i4
         +fPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L61+JwkcFzkud7jR/ngEi5aVujc/do/nVLhcrDG/U8k=;
        b=s/1jUcXzUy4PMDWUDOGcuIKg77ltvXT3xNgnvFFrceegDWcBl2LFfNzobopVFpBGzC
         mjyRfibFT7VsYa1MKVrtffH1AlBzURS5dueupnm24t/pyRYudU1w+WBWcLvmvktLEn/3
         hvESCaZmmcwrGFmf4LAC4k3GzrPNbugG1uFTtnK5z86OwVxfzi5Wa3MO6oAojw5Az0W+
         NO7qRJ4JjJYIDCBeCuy74Pi4c80puF6B2WsD83xxF2+GdEqwoY3QeDd65u4kxCFkBOj0
         t8vVGQ6N/UWt3gp7CNQWD2vGO36TpjFNWljViEbwsQ1M9zYWzHnEUzpwrLzzYAQI72+D
         /qRg==
X-Gm-Message-State: AOAM5302u2IiinbcwHT2EzmZQU2iiu3xrjDei9+/ljkGQpM8KsKuYqmT
        lc89WbaFF8ztCeW3lobKr3cIvQ==
X-Google-Smtp-Source: ABdhPJwqcV0/86kY52CzPqXaDjCXA6dBC2F9HG+ByXzdzWJaOzBWEPskANgnY9UktMu/luOWbxK7Bg==
X-Received: by 2002:a1c:55ca:: with SMTP id j193mr1734133wmb.87.1607506224513;
        Wed, 09 Dec 2020 01:30:24 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:8cf2:3820:1fbd:70ad? ([2a01:e34:ed2f:f020:8cf2:3820:1fbd:70ad])
        by smtp.googlemail.com with ESMTPSA id d8sm2053234wrp.44.2020.12.09.01.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 01:30:23 -0800 (PST)
Subject: Re: [PATCH 1/3] thermal: core: Add indication for userspace usage
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>, amitk@kernel.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20201128175450.12456-1-kai.heng.feng@canonical.com>
 <004fe225-1009-06d8-b297-c03a4c67550f@linaro.org>
 <860126B8-1152-4EE3-B15E-B4E45EFE879F@canonical.com>
 <fc67ad02826fb3adfd8457e1a0baf234a8fa3fce.camel@linux.intel.com>
 <34348B03-5E27-49A0-A704-6332BAC00758@canonical.com>
 <585bb5d3ee5bea063795682108576c3464ba72b6.camel@linux.intel.com>
 <D53454A1-5ED0-4B4D-B22F-8663C9970ECD@canonical.com>
 <f863f2e1e322a8819c660f5eefbbc4acf7522990.camel@linux.intel.com>
 <FCFE1F21-2EC6-4D3A-8B2E-32C653816D58@canonical.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <4767b493-fa24-e294-66df-3989b72bfb01@linaro.org>
Date:   Wed, 9 Dec 2020 10:30:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <FCFE1F21-2EC6-4D3A-8B2E-32C653816D58@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/12/2020 06:36, Kai-Heng Feng wrote:
> 
> 
>> On Dec 1, 2020, at 02:39, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
>>
>> On Tue, 2020-12-01 at 02:22 +0800, Kai-Heng Feng wrote:
>>>> On Dec 1, 2020, at 02:13, Srinivas Pandruvada <
>>>> srinivas.pandruvada@linux.intel.com> wrote:
>>>
>>> [snipped] 
>>>
>>>>>> What about creating an new callback
>>>>>>
>>>>>> enum thermal_trip_status {
>>>>>> 	THERMAL_TRIP_DISABLED = 0,
>>>>>> 	THERMAL_TRIP_ENABLED,
>>>>>> };
>>>>>>
>>>>>> int get_trip_status(struct thermal_zone_device *, int trip,
>>>>>> enum
>>>>>> thermal_trip_status *state);
>>>>>>
>>>>>> Then in 
>>>>>> static void handle_thermal_trip(struct thermal_zone_device *tz,
>>>>>> int
>>>>>> trip)
>>>>>> {
>>>>>>
>>>>>> /* before tz->ops->get_trip_temp(tz, trip, &trip_temp); */
>>>>>> if (tz->ops->get_trip_status) {
>>>>>> 	enum thermal_trip_status *status;
>>>>>>
>>>>>> 	if (!tz->ops->get_trip_status(tz, trip, &status)) {
>>>>>> 		if (status == THERMAL_TRIP_DISABLED)
>>>>>> 			return;	
>>>>>> 	}
>>>>>> }
>>>>>> ...
>>>>>> ...
>>>>>>
>>>>>> }
>>>>>>
>>>>>>
>>>>>> This callback will help the cases:
>>>>>> - Allows drivers to selectively disable certain trips during
>>>>>> init
>>>>>> state
>>>>>> or system resume where there can be spikes or always. int340x
>>>>>> drivers
>>>>>> can disable always.
>>>>>
>>>>> This sounds really great. This is indeed can happen on system
>>>>> resume,
>>>>> before userspace process thaw.
>>>>>
>>>>>> - Still give options for drivers to handle critical trip even
>>>>>> if
>>>>>> they
>>>>>> are bound to user space governors. User space process may be
>>>>>> dead,
>>>>>> so
>>>>>> still allow kernel to process graceful shutdown
>>>>>
>>>>> To make the scenario happen, do we need a new sysfs to let
>>>>> usespace
>>>>> enable it with THERMAL_TRIP_ENABLED?
>>>> This should be drivers call not user space.
>>>
>>> Understood. So after thermal_zone_device_register(), the driver can
>>> decide to what to return on get_trip_temp().
>> get_trip_status()
>>
>>> Let me work on a new patch if there's no other concern.
>> Better to wait for confirmation from Daniel and others.
> 
> Daniel,
> 
> Do you like Srinivas' proposed solution?
> 
> I hope we can find a solution in upstream kernel soon.

(just trying to figure out the full context)

If the device is enumerated outside of a thermal zone, the sensor should
not register in the thermal zone no ?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
