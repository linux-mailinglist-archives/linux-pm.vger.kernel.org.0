Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE993556AE
	for <lists+linux-pm@lfdr.de>; Tue,  6 Apr 2021 16:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241997AbhDFOdA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Apr 2021 10:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239165AbhDFOdA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Apr 2021 10:33:00 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6610C06174A
        for <linux-pm@vger.kernel.org>; Tue,  6 Apr 2021 07:32:52 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e12so1419038wro.11
        for <linux-pm@vger.kernel.org>; Tue, 06 Apr 2021 07:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ABvfiatEaAgOGlUexoNa8C9CZPfoQ4JMW2QwnUmAO+k=;
        b=UKk6IcehDFx5Go/2xcSt6JUua9c4vbNfNtxl8gD79YljpArtYWbuia4csdie2BiCpk
         nK0jnUl8jaqsfcrl5+jL0fkKaW6t5h1lLG/sTf2PXUk3oOXtmOmYSEc7j8a+ZRbDFHiq
         rrnNl2uQnkqcCsOpkZ+PdXh4XucUP0JWzAlfsnCUpEdKumGPX+Lw02QLTlVNQC60QxUU
         Glc6RMN/qWVBmK5Xf9ji2LvGVROzQohhbMnzgkUXq8ZS60LvWWMgGo1b5J+NBWJ1MrqN
         JVHJPc5QTMJA9pgZceDKGBiyJFKeJzpkhL+owoxFMgvfo8/Ql9UfT3HT9p8HKDRZxkAt
         r8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ABvfiatEaAgOGlUexoNa8C9CZPfoQ4JMW2QwnUmAO+k=;
        b=eg3mLj9z23y6JQOG87+uu1FQBb1A9WRZdS3b48I/GSh1mvy5nQR5B2bMsSOj8oXexz
         WTJBK5gfuO+vfPxwiwG3quBi3pwx7qi8LF96JslS81KRhHHGhPORL4E0LF//LF8qeIy6
         JqC8FEpwki7FgY/Kwejq9dkHpst0FzavLPs+MWneqRW4g6LB3/L+9BsuZH1p+g7XEvLf
         iMvdex5WUDxz7EF/k0loiXObm3bHvjjc8d/eSDZm960a8cBLfxPD2A/uxBF+IrVTHLHl
         LL19YA+h/yDa91GYDU3+xyRXWweZIvvQbNGkPus0uhsywsj0mlQ8xbqc+xW3BM9qDBK6
         LXUg==
X-Gm-Message-State: AOAM531cym0HS3TOufB+HMbMG6f2xi6caUYZAxSfTWg6oE5eU8c5iHAK
        T9l7RG9EQpF8vCGcWtUIgggMxg==
X-Google-Smtp-Source: ABdhPJxBRNyFetA38tIlfHPf0ILE/9+6KqWgk+hiNjpApRf/lN4QYAlY0fsj1zLJONGD9Rj0it4nTw==
X-Received: by 2002:adf:a15e:: with SMTP id r30mr17146732wrr.101.1617719571199;
        Tue, 06 Apr 2021 07:32:51 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:90c5:36a9:5586:99b9? ([2a01:e34:ed2f:f020:90c5:36a9:5586:99b9])
        by smtp.googlemail.com with ESMTPSA id 187sm5062848wma.0.2021.04.06.07.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 07:32:50 -0700 (PDT)
Subject: Re: [PATCH 1/2] thermal: power_allocator: maintain the device
 statistics from going stale
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        amitk@kernel.org, rui.zhang@intel.com
References: <20210331163352.32416-1-lukasz.luba@arm.com>
 <20210331163352.32416-2-lukasz.luba@arm.com>
 <b27e0c79-de27-f9b1-ad16-17825b302615@linaro.org>
 <1f0710d5-cd78-dfff-1ce2-bba5f6e469b7@arm.com>
 <1a0b6e4a-1717-91d6-a664-d50e6aa8a809@linaro.org>
 <d74b8e8e-64b0-d724-d572-f98eb597a60e@arm.com>
 <cbc40019-8b2d-5d14-f0fd-b0018fb4a1f6@linaro.org>
 <f7dfced2-23f6-8d3e-d23d-291de368f472@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <7660a09b-51f8-c6f2-5678-77b6bff97af6@linaro.org>
Date:   Tue, 6 Apr 2021 16:32:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f7dfced2-23f6-8d3e-d23d-291de368f472@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Lukasz,


On 06/04/2021 14:25, Lukasz Luba wrote:
> 
> 
> On 4/6/21 12:24 PM, Daniel Lezcano wrote:
>> On 06/04/2021 12:39, Lukasz Luba wrote:
>>>
>>>
>>> On 4/6/21 11:16 AM, Daniel Lezcano wrote:
>>>> On 06/04/2021 10:44, Lukasz Luba wrote:
>>>>>
>>>>>
>>>>> On 4/2/21 4:54 PM, Daniel Lezcano wrote:
>>>>>> On 31/03/2021 18:33, Lukasz Luba wrote:
>>>>>>> When the temperature is below the first activation trip point the
>>>>>>> cooling
>>>>>>> devices are not checked, so they cannot maintain fresh
>>>>>>> statistics. It
>>>>>>> leads into the situation, when temperature crosses first trip
>>>>>>> point, the
>>>>>>> statistics are stale and show state for very long period.
>>>>>>
>>>>>> Can you elaborate the statistics you are referring to ?
>>>>>>
>>>>>> I can understand the pid controller needs temperature but I don't
>>>>>> understand the statistics with the cooling device.
>>>>>>
>>>>>>
>>>>>
>>>>> The allocate_power() calls cooling_ops->get_requested_power(),
>>>>> which is for CPUs cpufreq_get_requested_power() function.
>>>>> In that cpufreq implementation for !SMP we still has the
>>>>> issue of stale statistics. Viresh, when he introduced the usage
>>>>> of sched_cpu_util(), he fixed that 'long non-meaningful period'
>>>>> of the broken statistics and it can be found since v5.12-rc1.
>>>>>
>>>>> The bug is still there for the !SMP. Look at the way how idle time
>>>>> is calculated in get_load() [1]. It relies on 'idle_time->timestamp'
>>>>> for calculating the period. But when this function is not called,
>>>>> the value can be very far away in time, e.g. a few seconds back,
>>>>> when the last allocate_power() was called.
>>>>>
>>>>> The bug is there for both SMP and !SMP [2] for older kernels, which
>>>>> can
>>>>> be used in Android or ChromeOS. I've been considering to put this
>>>>> simple
>>>>> IPA fix also to some other kernels, because Viresh's change is more
>>>>> a 'feature' and does not cover both platforms.
>>>>
>>>> Ok, so IIUC, the temperature is needed as well as the power to do the
>>>> connection for the pid loop (temp vs power).
>>>>
>>>> I'm trying to figure out how to delegate the mitigation switch
>>>> on/off to
>>>> the core code instead of the governor (and kill tz->passive) but how
>>>> things are implemented for the IPA makes this very difficult.
>>>>
>>>> AFAICT, this fix is not correct.
>>>>
>>>> If the temperature is below the 'switch_on_temp' the passive is set to
>>>> zero and the throttle function is not called anymore (assuming it is
>>>> interrupt mode not polling mode), so the power number is not updated
>>>> also.
>>>
>>> IPA doesn't work well in asynchronous mode, because it needs this fixed
>>> length for the period. I have been experimenting with tsens IRQs and
>>> also both fixed polling + sporadic asynchronous IRQs, trying to fix it
>>> and have 'predictable' IPA, but without a luck.
>>> IPA needs synchronous polling events like we have for high temp e.g.
>>> 100ms and low temp e.g. 1000ms. The asynchronous events are root of
>>> undesirable states (too low or to high) calculated and set for cooling
>>> devices. It's also harder to escape these states with asynchronous
>>> events. I don't recommend using IPA with asynchronous events from IRQs,
>>> for now. It might change in future, though.
>>
>> I understand that but there is the 'switch_on_temp' trip point which is
>> supposed to begin to collect the power values ahead of the
>> 'desired_temp' (aka mitigation trip point / sustainable power).
>>
>>
>>> The patch 2/2 should calm down the unnecessary updates/notifications so
>>> your request.
>>> The longer polling, which we have for temperature below 'switch_on_temp'
>>> (e.g. every 1sec) shouldn't harm the performance of the system, but
>>> definitely makes IPA more predictable and stable.
>>
>> The change I proposed is correct then no ? The polling is still
>> effective.
> 
> In your proposed code there is 'tz->last_temperature < switch_on_temp'
> which then return 0 immediately. So we don't poke the devices.

Ah yes, I see your point.

Often the device tree is setup with an additional trip point to trigger
a stat collection. So I assumed we don't need to feed the pid loop below
this temperature.

What is the goal of sampling at polling time (not passive) ?

Here are the boards with the extra trip point:

- mt8173.dtsi
- hi6220.dtsi
- hi6220.dtsi
- px30.dts
- rk3328.dtsi
- rk3399-gru-kevin.dts

Those have an interrupt mode but do polling also.

See the configuration for:
- sc7180.dtsi (no polling delay and no pre-trip point)
- r8a77990.dtsi

>> If the IPA needs a sampling, it may be more adequate to separate the
>> sampling from the polling. So the other governors won't be impacted by
>> the IPA specific setup, and we do not end up with polling/passive delays
>> tricks for a governor. The IPA would have its own self-encapsulated
>> sampling rate and the thermal zone setup won't depend on the governor.
>>
>> What do you think ?
>>
> 
> IMHO having a private timer in the governor creates another complexity
> and confusion.

I would say we move the adherence between the thermal core and the IPA
into the governor only :)

Especially, we *have* to call throttle on a governor even if we are not
in the mitigation process.

And from a design POV, it should be the thermal core to be in control of
what is happening, not passively call the different callbacks and expect
them to behave correctly (eg. set tz->passive)


> What we have in thermal now is good enough. We have DT support for both
> periods so there is need even to write via sysfs:
> polling-delay-passive
> polling-delay
> The device driver developers can rely on this reliable check in the
> thermal framework.
> I don't agree that IPA forces any specific setup. 

Yes, it does IMO.

For instance, on the hi3660, the sensor is able to do interrupt mode, so
to be wake up when the first temperature threshold is reached.

But there is still the polling delay because the governor is IPA in this
case? There is also an additional trip-point0 which is not a target for
a cooling device, just put there to ensure the IPA has enough data when
reaching the second trip point which is the target.

If, for any reason, we want to switch to step_wise, where the interrupt
mode is enough to trigger the mitigation (eg. with passive polling), and
ensure the system is not constantly waking up (and AFAICT even 1s
periodic wake up can have a significant impact on battery life), it
won't be possible because of the device tree.

Moreover, some sensors do not use their interrupt mode because of IPA
setup or they use it incorrectly.

See my concern here ? IPA has an impact on the thermal core and the
sensor, while those should be governor agnostic.

> If the thermal is
> configured to do the polling of the temp sensor, because maybe there
> are no HW interrupts, then there is no other way. The Arm SCMI sensors
> were one of them, where we had to send a SCMI request. There was no
> notifications/IRQs that temp crossed some trip point. Now it should be
> better, but still it depends on vendor's FW implementation if there is
> IRQ.

I don't know all the platforms but so far the interrupt mode is largely
supported, to not say in the vast majority.

> The reliable polling is not IPA 'feature request'.
> We cannot avoid polling in some configurations. Thermal framework
> must support this scenario: polling/checking temp sensor even when
> the temp is low.

I agree with that, I'm not questioning about removing the polling.

> Thus, since framework must check the temp, calling
> the governor->throttle() doesn't harm (as I said every 1sec).
> Furthermore, the governor interprets what trip point and temperature to
> interpret and how to react.

Precisely, that is the reason why I disagree. The thermal core should
switch on/off the mitigation (say cool down / warm up) and the governor
applies its recipe. With polling and sampling tied together it is not
possible to create self-encapsulated components. As a result we have bug
like [1] :/

  -- Daniel

[1] https://bugzilla.kernel.org/show_bug.cgi?id=212507


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
