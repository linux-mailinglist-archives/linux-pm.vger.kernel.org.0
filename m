Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03FF228BD27
	for <lists+linux-pm@lfdr.de>; Mon, 12 Oct 2020 18:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390203AbgJLQDE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Oct 2020 12:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388982AbgJLQDE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Oct 2020 12:03:04 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6407C0613D0
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2020 09:03:02 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id n18so19800347wrs.5
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2020 09:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D7jZJvslu9stMIs5zdM6ag+QiZdu9iBSwrqEDJqxgPM=;
        b=LcABs3efXeI3QQr3vPdqp+nR5p81Wh0icvrwmV7EtEfHllpnvuZlRFIPtdgZFc+JoI
         KfP+1paN5jkKjSQyvHBiE6j/mPbSUn2mDbB94P7qxxETfSad0ajCV46jy/e+Ff26yavN
         PPNE2ypVzF6/yWSx63E2PayIq5lEeOpWVXGh5RhCrc3H9W25x2eUhqa3iWB8YmOtw2nA
         csdxV+7r0TL5Er32ZU9GeZI3dlu0/o2FxD0ipqZae/S6rrqoMZhU29/PUsIirujAixcA
         7YmDks459UiZrbx3gIqZNCla/dQx9/ZuTVMJT8dmec/Nd0eqO74lImKtYBLuhV5C2ID/
         VFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D7jZJvslu9stMIs5zdM6ag+QiZdu9iBSwrqEDJqxgPM=;
        b=eAcYHzq+dfF1l7KlbA4N9g2EXqjgeM8zBflzo4AVeIdSyTuLbddmBmR9N1nlGS33TQ
         Ovk5CASLYVRzAL7I37rQZ9cn4C7O5VJtpmx2nlJTylULxE+iyyr0lpuCe0fhiGO54oE4
         4LpVlHcN0X9Z1jdncgLUvYTfzMNItWBbfmculr8OzIglcjQwu9u3QfXtCdvwYpXimouZ
         OoECMkpPIuZl7JokAw0f8NisTyazkNubV7WOzGjIwYUaj/bEOiKeSRQlfolgIqBGM0H3
         E/PAkisDsbV724sS/v/o7XHKIx4YpxLsTgDW/6fv0dNcWq1RGipD+qcTuu1oY8/o3KfK
         Dntg==
X-Gm-Message-State: AOAM5313SbY3iHeyQeF58cgIVlnd6cWGNg0nNoU+akY+60VKPZXijGkt
        1FLOdB78zMkOHm9krwVO/cX7Eg==
X-Google-Smtp-Source: ABdhPJx1zVdDYGuHrXvhDtTLHxP1+hZ4ACRK7I+JJ9D/bwul0j8B0X5t6Rx4J9oNvsJ1ZGmGp6eYWw==
X-Received: by 2002:adf:e589:: with SMTP id l9mr4668264wrm.110.1602518581090;
        Mon, 12 Oct 2020 09:03:01 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:8dea:c7dd:5d0e:51e6? ([2a01:e34:ed2f:f020:8dea:c7dd:5d0e:51e6])
        by smtp.googlemail.com with ESMTPSA id v8sm24173138wmb.20.2020.10.12.09.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 09:03:00 -0700 (PDT)
Subject: Re: [PATCH 0/4] powercap/dtpm: Add the DTPM framework
To:     Hans de Goede <hdegoede@redhat.com>, rafael@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com
References: <20201006122024.14539-1-daniel.lezcano@linaro.org>
 <eb26a00d-eee0-a4d1-ed25-61a661ad5683@redhat.com>
 <8be66efd-7833-2c8a-427d-b0055c2f6ec1@linaro.org>
 <97e5368b-228d-eca1-85a5-b918dfcfd336@redhat.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <bc1a0134-5242-65d7-a753-fbec0d3bb327@linaro.org>
Date:   Mon, 12 Oct 2020 18:02:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <97e5368b-228d-eca1-85a5-b918dfcfd336@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/10/2020 13:46, Hans de Goede wrote:
> Hi Daniel,
> 
> On 10/12/20 12:30 PM, Daniel Lezcano wrote:
>>
>> Hi Hans,
>>
>> On 07/10/2020 12:43, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 10/6/20 2:20 PM, Daniel Lezcano wrote:
>>>> The density of components greatly increased the last decade bringing a
>>>> numerous number of heating sources which are monitored by more than 20
>>>> sensors on recent SoC. The skin temperature, which is the case
>>>> temperature of the device, must stay below approximately 45°C in order
>>>> to comply with the legal requirements.
>>>>
>>>> The skin temperature is managed as a whole by an user space daemon,
>>>> which is catching the current application profile, to allocate a power
>>>> budget to the different components where the resulting heating effect
>>>> will comply with the skin temperature constraint.
>>>>
>>>> This technique is called the Dynamic Thermal Power Management.
>>>>
>>>> The Linux kernel does not provide any unified interface to act on the
>>>> power of the different devices. Currently, the thermal framework is
>>>> changed to export artificially the performance states of different
>>>> devices via the cooling device software component with opaque values.
>>>> This change is done regardless of the in-kernel logic to mitigate the
>>>> temperature. The user space daemon uses all the available knobs to act
>>>> on the power limit and those differ from one platform to another.
>>>>
>>>> This series provides a Dynamic Thermal Power Management framework to
>>>> provide an unified way to act on the power of the devices.
>>>
>>> Interesting, we have a discussion going on about a related
>>> (while at the same time almost orthogonal) discussion for
>>> setting policies for if the code managing the restraints
>>> (which on x86 is often hidden in firmware or ACPI DPTF tables)
>>> should have a bias towards trying to have as long a battery life
>>> as possible, vs maximum performance. I know those 2 aren't
>>> always opposite ends of a spectrum with race-to-idle, yet most
>>> modern x86 hardware has some notion of what I call performance-profiles
>>> where we can tell the firmware managing this to go for a bias towards
>>> low-power / balanced / performance.
>>>
>>> I've send a RFC / sysfs API proposal for this here:
>>> https://lore.kernel.org/linux-pm/20201003131938.9426-1-hdegoede@redhat.com/
>>>
>>>
>>> I've read the patches in this thread and as said already I think
>>> the 2 APIs are mostly orthogonal. The API in this thread is giving
>>> userspace direct access to detailed power-limits allowing userspace
>>> to configure things directly (and for things to work optimal userspace
>>> must do this). Where as in the x86 case with which I'm dealing
>>> everything
>>> is mostly handled in a black-box and userspace can merely configure
>>> the low-power / balanced / performance bias (*) of that black-box.
>>>
>>> Still I think it is good if we are aware of each-others efforts here.
>>>
>>> So Daniel, if you can take a quick look at my proposal:
>>> https://lore.kernel.org/linux-pm/20201003131938.9426-1-hdegoede@redhat.com/
>>>
>>>
>>> That would be great. I think we definitely want to avoid having 2
>>> APIs for the same thing here. Again I don't think that is actually
>>> the case, but maybe you see this differently ?
>>
>> Thanks for pointing this out. Actually, it is a different feature as you
>> mentioned. The profile is the same knob we have with the BIOS where we
>> can choose power/ balanced power / balanced/balanced
>> performance / performance, AFAICT.
> 
> Right.
> 
>> Here the proposed interface is already exported in userspace via the
>> powercap framework which supports today the backend driver for the RAPL
>> register.
> 
> You say that some sort of power/ balanced power / balanced /
> balanced performance / performance setting in is already exported
> through the powercap interface today (if I understand you correctly)?

Sorry, I was unclear. I meant 'Here the proposed interface' referring to
the powercap/dtpm. There is no profile interface in the powercap framework.

> But I'm not seeing any such setting in:
> Documentation/ABI/testing/sysfs-class-powercap
> 
> Nor can I find it under /sys/class/powercap/intel-rapl* on a ThinkPad
> X1 carbon 8th gen.
> 
> Note, if there indeed is an existing userspace API for this I would
> greatly prefer for the thinkpad_acpi and hp-wmi (and possibly other)
> drivers to use this, so if you can point me to this interface then
> that would be great.
> 
>> The userspace will be in charge of handling the logic to have the
>> correct power/performance profile tuned against the current application
>> running foreground. The DTPM framework gives the unified access to the
>> power limitation to the individual devices the userspace logic can act
>> on.
>>
>> A side note, related to your proposal, not this patch. IMO it suits
>> better to have /sys/power/profile.
>>
>> cat /sys/power/profile
>>
>> power
>> balanced_power *
>> balanced
>> balanced_performance
>> performance
>>
>> The (*) being the active profile.
> 
> Interesting the same thing was brought up in the discussion surrounding
> RFC which I posted.
> 
> The downside against this approach is that it assumes that there
> only is a single system-wide settings. AFAIK that is not always
> the case, e.g. (AFAIK):
> 
> 1. The intel pstate driver has something like this
>    (might this be the rapl setting you mean? )
> 
> 2. The X1C8 has such a setting for the embedded-controller, controlled
>    through the ACPI interfaces which thinkpad-acpi used
> 
> 3. The hp-wmi interface allows selecting a profile which in turn
>    (through AML code) sets a bunch of variables which influence how
>    the (dynamic, through mjg59's patches) DPTF code controls various
>    things
> 
> At least the pstate setting and the vendor specific settings can
> co-exist. Also the powercap API has a notion of zones, I can see the
> same thing here, with a desktop e.g. having separate performance-profile
> selection for the CPU and a discrete GPU.
> 
> So limiting the API to a single /sys/power/profile setting seems a
> bit limited and I have the feeling we will regret making this
> choice in the future.
> 
> With that said your proposal would work well for the current
> thinkpad_acpi / hp-wmi cases, so I'm not 100% against it.
> 
> This would require adding some internal API to the code which
> owns the /sys/power root-dir to allow registering a profile
> provider I guess. But that would also immediately bring the
> question, what if multiple drivers try to register themselves
> as /sys/power/profile provider ?

Did you consider putting the profile on a per device basis ?

eg.

/sys/devices/system/cpu/cpu[0-9]/power/profile

May be make 'energy_performance_preference' obsolete in
/sys/devices/system/cpu/cpufreq ?

When one device sets the profile, all children will have the same profile.

eg.

A change in /sys/devices/system/cpu/power/profile will impact all the
underlying cpu[0-9]/power/profile

Or a change in /sys/devices/power/profile will change all profiles below
/sys/devices.

Well that is a high level suggestion, I don't know how that can fit with
the cyclic sysfs hierarchy.







-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
