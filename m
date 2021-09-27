Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D9341A134
	for <lists+linux-pm@lfdr.de>; Mon, 27 Sep 2021 23:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbhI0VOY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Sep 2021 17:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhI0VOY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Sep 2021 17:14:24 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA515C061575
        for <linux-pm@vger.kernel.org>; Mon, 27 Sep 2021 14:12:45 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id r11-20020a1c440b000000b0030cf0f01fbaso710551wma.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Sep 2021 14:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ydx4ZROsmBmui+VzICRvZRbGEELEd7vUMm7wkwD9Q3M=;
        b=n1eSY42VtXOuI+r9C+quTvjMSNSeu0RktKFtcDlnRLYa/uq/zvfouf0C+x3MZ977Up
         xBIe0Ub9QHPz1O4swuE/Vg7QCcyY8h5oplTpu/UePVrucwl6h4mkUlM1Z2N7CR4ZYn+1
         kWdxiEXhTsVbI8BVZ7I6udM8F4lSdU7wWwniLS4m3j9B8BU5vsPLCzl6xM3SzfZgHBkE
         nj+egmSrmsq13ppZUqEOl4GrEtbA0idWo+I/CY2ChpqqA9erB8O/jYG7rv/XR2tJC9Pr
         7qVxuqYW9gD8oaM7mveGL2UDN8idU7B++Z7xTOptPxLwB4TibHltwdTnwccmpDlF8Sea
         JCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ydx4ZROsmBmui+VzICRvZRbGEELEd7vUMm7wkwD9Q3M=;
        b=QtAo8DwaZgRhelf3v4goWqv17TaS57hEK90YYQdfAu67m3dmZLb2wfLfRzbl8jmJMX
         mnTma9jH5DCwJv6XmaUIqC1ZYLFWn39L6SqFSCBVU/qga7JvkMWEQEr1q2dq6Q1IJ1Ha
         0FmGKXA6YTSJfgJJORmBEaQ+/0EWBpAT7VdwzmAqB/cBs0T7jJ/fshtqCElhJfZJyuTM
         Ug7bWwlgiT207OccQ1sQUj7MJn2SKp9Y0CPQFvDYtlpv6FN0ytm75dvtEcV1U8zhXNsN
         JoOrvTpec9EMSoImpkGva12yfsmFKV9d0Kuyq7Nc5kgpewFiTapS3e4uybYAn0mjU3AA
         uQhw==
X-Gm-Message-State: AOAM533MwViZ4ZFtpqf8V0GM8GHh4SmMBRa8aQKmVZOY+Q6RtVLHGvud
        vyXUbh6ynVSagVcEPofYg5/rlA==
X-Google-Smtp-Source: ABdhPJwmNonNEvV+IeB04r1swy/P4SJEwPXHNpSUF4iGkzHF+CJObeedrnuQCCXoVYJuwU5km4amWA==
X-Received: by 2002:a1c:7302:: with SMTP id d2mr1223495wmb.92.1632777164191;
        Mon, 27 Sep 2021 14:12:44 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:34f3:60a8:c3cc:641b? ([2a01:e34:ed2f:f020:34f3:60a8:c3cc:641b])
        by smtp.googlemail.com with ESMTPSA id v17sm8251641wro.34.2021.09.27.14.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 14:12:43 -0700 (PDT)
Subject: Re: [PATCH thermal 1/1] thermal/core: Skip cooling device statistics
 update for configuration operation
To:     Vadim Pasternak <vadimp@nvidia.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Ido Schimmel <idosch@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20210927082421.2358851-1-vadimp@nvidia.com>
 <9aca37cb-1629-5c67-1895-1fdc45c0244e@linaro.org>
 <BN9PR12MB53814545BAE8C5A45E81220FAFA79@BN9PR12MB5381.namprd12.prod.outlook.com>
 <942558b3-e884-a907-0cc6-5eddf07c358a@linaro.org>
 <BN9PR12MB5381EADD601B87E4F2C60EBFAFA79@BN9PR12MB5381.namprd12.prod.outlook.com>
 <d87227b8-57b9-fdb9-bb87-f01c6d0e23cc@linaro.org>
 <BN9PR12MB538128B5C2A0B04531E5775CAFA79@BN9PR12MB5381.namprd12.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <af9857f2-578e-de3a-e62b-6baff7e69fd4@linaro.org>
Date:   Mon, 27 Sep 2021 23:12:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <BN9PR12MB538128B5C2A0B04531E5775CAFA79@BN9PR12MB5381.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27/09/2021 19:52, Vadim Pasternak wrote:
> 
> 
>> -----Original Message-----
>> From: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Sent: Monday, September 27, 2021 4:56 PM
>> To: Vadim Pasternak <vadimp@nvidia.com>; rui.zhang@intel.com
>> Cc: linux-pm@vger.kernel.org; Ido Schimmel <idosch@nvidia.com>; Rafael J.
>> Wysocki <rjw@rjwysocki.net>
>> Subject: Re: [PATCH thermal 1/1] thermal/core: Skip cooling device statistics
>> update for configuration operation
>>
>> On 27/09/2021 15:29, Vadim Pasternak wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> Sent: Monday, September 27, 2021 3:32 PM
>>>> To: Vadim Pasternak <vadimp@nvidia.com>; rui.zhang@intel.com
>>>> Cc: linux-pm@vger.kernel.org; Ido Schimmel <idosch@nvidia.com>;
>> Rafael J.
>>>> Wysocki <rjw@rjwysocki.net>
>>>> Subject: Re: [PATCH thermal 1/1] thermal/core: Skip cooling device
>>>> statistics update for configuration operation
>>>>
>>>>
>>>>
>>>>
>>>> On 27/09/2021 13:22, Vadim Pasternak wrote:
>>>>> Hi Daniel,
>>>>>
>>>>> Thank you for quick reply.
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>>> Sent: Monday, September 27, 2021 1:42 PM
>>>>>> To: Vadim Pasternak <vadimp@nvidia.com>; rui.zhang@intel.com
>>>>>> Cc: =idosch@nvidia.com; linux-pm@vger.kernel.org
>>>>>> Subject: Re: [PATCH thermal 1/1] thermal/core: Skip cooling device
>>>>>> statistics update for configuration operation
>>>>>>
>>>>>>
>>>>>> Hi Vadim,
>>>>>>
>>>>>>
>>>>>> On 27/09/2021 10:24, Vadim Pasternak wrote:
>>>>>>> The thermal subsystem maintains a transition table between states
>>>>>>> that is allocated according to the maximum state supported by the
>>>>>>> cooling device.
>>>>>>>
>>>>>>> When the table needs to be updated, the thermal subsystem does
>> not
>>>>>>> validate that the new state does not exceed the maximum state,
>>>>>>> leading to out-of-bounds memory accesses [1].
>>>>>>
>>>>>> Actually, thermal_cooling_device_stats_update() is called if the
>>>>>> set_cur_state is successful.
>>>>>>
>>>>>> With a state greater than the max state, the set_cur_state should
>>>>>> fail and
>>>>>> thermal_cooling_device_stats_update() is not called.
>>>>>>
>>>>>> Perhaps the problem is in mlxsw_thermal_set_cur_state() ?
>>>>>
>>>>> "mlxsw" thermal drivers has additional use of 'sysfs' 'cur_state'
>>>>> for configuration purpose to limit minimum fan speed.
>>>>> Fan speed minimum is enforced by setting 'cur_state' with value
>>>>> exceeding actual fan speed maximum.
>>>>
>>>> Yes, and that is the problem because the driver is doing weird things
>>>> with the cooling device state resulting in an abuse of the sysfs API
>>>> and conflicting with the thermal internals.
>>>>
>>>>
>>>>> This feature provides ability to limit fan speed according to some
>>>>> system wise considerations, like absence of some replaceable units
>>>>> or high system ambient temperature, or some other factors which
>>>>> indirectly impacts system airflow.
>>>>
>>>> Is that a static thermal profile depending on the platform set by
>>>> userspace or something which can be changed dynamically at runtime via
>> eg. a daemon ?
>>>
>>> Yes, this is some profiles/rules, which are system specific and
>>> according to these rules userspace can limit fan speed. Like, for example:
>>> - if one of power supplies is removed, system fan should be enforced to
>> full
>>>   speed, because it makes a hole in a box, and it has hard impact on airflow.
>>> - If port side ambient temperature reaches some threshold X1, fan speed
>> should
>>>   be limited by Y1%, X2 - Y2%, etcetera.
>>> - if temperature fault is detected for any optical transceivers - some limit is
>>>   required.
>>
>> I see, thanks for the information.
>>
>>>>> For example, if cooling devices operates at cooling levels from 1 to
>>>>> 10
>>>>> (1 for 10% fan speed, 10 for 100% fan speed), cooling device minimal
>>>>> speed can be limited by setting 'cur_state' attribute through 'sysfs'
>>>>> to the values from 'max_state' + 1 to 'max_state * 2' (from 11 to 20).
>>>>> Following this example if value is set to 14 (40%) cooling levels
>>>>> vector will be set to 4, 4, 4, 4, 4, 5, 6, 7, 8, 9, 10 for setting
>>>>> device speed cooling states respectively in 40, 40, 40, 40, 40, 50,
>>>>> 60. 70, 80, 90,
>>>>> 100 percent. And it limits cooling device to operate only at 40%
>>>>> speed and above.
>>>>>
>>>>> Maybe it would be worth adding earlier some dedicated 'cur_state_limit'
>>>>> attribute for this feature, but it was not done.
>>>>>
>>>>> We have another driver required this feature and one new we are
>>>>> developing now, which require fan minim speed limit as well.
>>>>
>>>> The use case is valid but I think the approach is wrong. Probably the
>>>> simplest thing to do is to set a low trip point with a minimal fan speed.
>>>
>>> For "trip_point_0_temp" there is the below definition:
>>> 	{	/* In range - 0-40% PWM */
>>> 		.type		= THERMAL_TRIP_ACTIVE,
>>> 		.temp		= MLXSW_THERMAL_ASIC_TEMP_NORM,
>>> 		.hyst		= MLXSW_THERMAL_HYSTERESIS_TEMP,
>>> 		.min_state	= 0,
>>> 		.max_state	= (4 * MLXSW_THERMAL_MAX_STATE) / 10,
>> (40%)
>>> 	},
>>> For "trip_point_1_temp":
>>> 	{
>>> 		/* In range - 40-100% PWM */
>>> 		.type		= THERMAL_TRIP_ACTIVE,
>>> 		.temp		= MLXSW_THERMAL_ASIC_TEMP_HIGH,
>>> 		.hyst		= MLXSW_THERMAL_HYSTERESIS_TEMP,
>>> 		.min_state	= (4 * MLXSW_THERMAL_MAX_STATE) / 10,
>> (100%)
>>> 		.max_state	= MLXSW_THERMAL_MAX_STATE,
>>> 	},
>>>
>>> To limit cooling device by f.e 70%, I should change dynamically 'min_state'
>> and 'max_state'
>>> for both trips to (70%, 70%) and (70%, 100%). I am not sure I can do it?
>>>
>>> And we have many customers, using this user space interface, it would
>>> be not so good to change it.
>>
>> The issue is the driver is wrong here. The change you referred in the past
>> should have not been merged. I note there is no thermal maintainer blessing
>> in the tags.
>>
>>> I understand it is possible to handle this issue inside driver's
>>> set_cur_stat() callback by returning positive value for configuration
>> request.
>>> But maybe this feature could you useful for other developers and it
>>> could be some common interface to support it?
>>
>> I suggest to revert a421ce088ac8 and switch to hwmon to set the fan speed.
>> At the first glance, it is already supported by the mlx driver, no ?
>>
> 
> Yes, hwmon is supported.
> But setting fan trough hwmon means we'll have two owners controlling same device.

Whatever the solution, there are several components acting on the device
at the same time (userspace and in-kernel) :/


> If speed is set through hwmon for example to 100%, thermal could decide to decrease
> it, since it does not know what the reason was for setting full speed.
> And it could make a completion between hwmon and thermal for cooling control.
> 
> Maybe adding new set_min_state()/get_min_state() callback could work?
> In such case user space can limit speed through "min_state" attrbbute.
> 
> Maybe some other approach, but within thermal subsystem?

I'm very reluctant to let the userspace to deal with the cooling device
because that is prone to abuse. And this driver is another example :(

Actually, the thermal framework should be dedicated to protect Tj,
nothing else.

However, as the hwmon is already supported, what is possible is to set
the min state in the driver when it is set via hwmon and use this min
state from the cooling device to prevent going below in set_cur_state.

So instead of dealing with out-of-boundaries values with the state, just
ignore requests which are below the min_state set by the hwmon in
set_cur_state.

There is no consistent mapping between what is a cooling device state
and hwmon, so it is hard to do generic code ATM.

Dealing with the state in the driver, makes the code self-encapsulate
and consistent.

Please revert commit a421ce088ac8 and check the code in mlxreg-fan.c
which sounds the exact copy of what provided a421ce088ac8.


>> --
>> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter | <http://www.linaro.org/linaro-
>> blog/> Blog


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
