Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE9A28B40B
	for <lists+linux-pm@lfdr.de>; Mon, 12 Oct 2020 13:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388135AbgJLLqZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Oct 2020 07:46:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56075 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388070AbgJLLqY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Oct 2020 07:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602503182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MPOxMq+F8ph56ff+X8V9f90cV/Mc4fJb08APecd2if8=;
        b=heMIBJvh0xoujHDEUZafOJbW3d8ZP2OEYNZ+fldiZz3dqVdmYZVJmB0L5G+icIVM8j41TN
        GCj5dONhVdMkA+tPJnXLdRpilDeVnPkeakG6GX2Hz/UAMcIz2Gqvuz+rYZFqbJx970nPyR
        5ZpSMk6M686WXeI261T/qHZHZ20QPoQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-uo7eOsARPpiiHO3VWelygA-1; Mon, 12 Oct 2020 07:46:20 -0400
X-MC-Unique: uo7eOsARPpiiHO3VWelygA-1
Received: by mail-ej1-f72.google.com with SMTP id p19so6207392ejy.11
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2020 04:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MPOxMq+F8ph56ff+X8V9f90cV/Mc4fJb08APecd2if8=;
        b=nncawGVL0uvhM3DoR9lGYOo7C4JbLSF9D3y7wMKSa+C9JACqFOLgP4e/MKh2C3LtqW
         VvFbrAcu7je6SUbUHC7jLuXr62CeUKqQg5F4f0m5/Ai/x3MzNz2r90gqg3h4yV9tsXQb
         x81zYego2N3iyb4mbqK2nEWgdIXJQx6FIaTFGVinki50T+hczWFQF7xTDeI2vkOR8lKj
         LCp95BJjaQ3D0JlCBV4EMXYpnhzfE6CW4mBgeuFA/nAdWMSGZ+jDBsI+9oOOCDPFAPTW
         1WWeh5lzmaci7sPZGh5cLhmWnVRUuXhL+rNvPBNI+9XBtNn6UCgCP1Gs57r94oPSmbQl
         uuvg==
X-Gm-Message-State: AOAM531zSZMedbN6H+pDNYzp/e1bJLzCoDbrFzFoldEidWgLvDU0CblW
        7drt7x+VEfC+hDkujqEn6E0lrX1czGbtJo61GT7hMTpb7yiRGi0xMesUlCK4MGAQPj9KMt7Wbdg
        525ZVWqqPiAXLUTbJDy8=
X-Received: by 2002:a05:6402:744:: with SMTP id p4mr13245306edy.190.1602503178826;
        Mon, 12 Oct 2020 04:46:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxgS7fuYft0E4VSk86TJ480HWHxhGEz4kkZwvpi6R3og3eSUHOtcLYgXqEyHl7XDOc+k3J2A==
X-Received: by 2002:a05:6402:744:: with SMTP id p4mr13245274edy.190.1602503178524;
        Mon, 12 Oct 2020 04:46:18 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id r27sm10550629edx.33.2020.10.12.04.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 04:46:17 -0700 (PDT)
Subject: Re: [PATCH 0/4] powercap/dtpm: Add the DTPM framework
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com
References: <20201006122024.14539-1-daniel.lezcano@linaro.org>
 <eb26a00d-eee0-a4d1-ed25-61a661ad5683@redhat.com>
 <8be66efd-7833-2c8a-427d-b0055c2f6ec1@linaro.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <97e5368b-228d-eca1-85a5-b918dfcfd336@redhat.com>
Date:   Mon, 12 Oct 2020 13:46:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8be66efd-7833-2c8a-427d-b0055c2f6ec1@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On 10/12/20 12:30 PM, Daniel Lezcano wrote:
> 
> Hi Hans,
> 
> On 07/10/2020 12:43, Hans de Goede wrote:
>> Hi,
>>
>> On 10/6/20 2:20 PM, Daniel Lezcano wrote:
>>> The density of components greatly increased the last decade bringing a
>>> numerous number of heating sources which are monitored by more than 20
>>> sensors on recent SoC. The skin temperature, which is the case
>>> temperature of the device, must stay below approximately 45°C in order
>>> to comply with the legal requirements.
>>>
>>> The skin temperature is managed as a whole by an user space daemon,
>>> which is catching the current application profile, to allocate a power
>>> budget to the different components where the resulting heating effect
>>> will comply with the skin temperature constraint.
>>>
>>> This technique is called the Dynamic Thermal Power Management.
>>>
>>> The Linux kernel does not provide any unified interface to act on the
>>> power of the different devices. Currently, the thermal framework is
>>> changed to export artificially the performance states of different
>>> devices via the cooling device software component with opaque values.
>>> This change is done regardless of the in-kernel logic to mitigate the
>>> temperature. The user space daemon uses all the available knobs to act
>>> on the power limit and those differ from one platform to another.
>>>
>>> This series provides a Dynamic Thermal Power Management framework to
>>> provide an unified way to act on the power of the devices.
>>
>> Interesting, we have a discussion going on about a related
>> (while at the same time almost orthogonal) discussion for
>> setting policies for if the code managing the restraints
>> (which on x86 is often hidden in firmware or ACPI DPTF tables)
>> should have a bias towards trying to have as long a battery life
>> as possible, vs maximum performance. I know those 2 aren't
>> always opposite ends of a spectrum with race-to-idle, yet most
>> modern x86 hardware has some notion of what I call performance-profiles
>> where we can tell the firmware managing this to go for a bias towards
>> low-power / balanced / performance.
>>
>> I've send a RFC / sysfs API proposal for this here:
>> https://lore.kernel.org/linux-pm/20201003131938.9426-1-hdegoede@redhat.com/
>>
>> I've read the patches in this thread and as said already I think
>> the 2 APIs are mostly orthogonal. The API in this thread is giving
>> userspace direct access to detailed power-limits allowing userspace
>> to configure things directly (and for things to work optimal userspace
>> must do this). Where as in the x86 case with which I'm dealing everything
>> is mostly handled in a black-box and userspace can merely configure
>> the low-power / balanced / performance bias (*) of that black-box.
>>
>> Still I think it is good if we are aware of each-others efforts here.
>>
>> So Daniel, if you can take a quick look at my proposal:
>> https://lore.kernel.org/linux-pm/20201003131938.9426-1-hdegoede@redhat.com/
>>
>> That would be great. I think we definitely want to avoid having 2
>> APIs for the same thing here. Again I don't think that is actually
>> the case, but maybe you see this differently ?
> 
> Thanks for pointing this out. Actually, it is a different feature as you
> mentioned. The profile is the same knob we have with the BIOS where we
> can choose power/ balanced power / balanced/balanced
> performance / performance, AFAICT.

Right.

> Here the proposed interface is already exported in userspace via the
> powercap framework which supports today the backend driver for the RAPL
> register.

You say that some sort of power/ balanced power / balanced /
balanced performance / performance setting in is already exported
through the powercap interface today (if I understand you correctly)?

But I'm not seeing any such setting in:
Documentation/ABI/testing/sysfs-class-powercap

Nor can I find it under /sys/class/powercap/intel-rapl* on a ThinkPad
X1 carbon 8th gen.

Note, if there indeed is an existing userspace API for this I would
greatly prefer for the thinkpad_acpi and hp-wmi (and possibly other)
drivers to use this, so if you can point me to this interface then
that would be great.

> The userspace will be in charge of handling the logic to have the
> correct power/performance profile tuned against the current application
> running foreground. The DTPM framework gives the unified access to the
> power limitation to the individual devices the userspace logic can act on.
> 
> A side note, related to your proposal, not this patch. IMO it suits
> better to have /sys/power/profile.
> 
> cat /sys/power/profile
> 
> power
> balanced_power *
> balanced
> balanced_performance
> performance
> 
> The (*) being the active profile.

Interesting the same thing was brought up in the discussion surrounding
RFC which I posted.

The downside against this approach is that it assumes that there
only is a single system-wide settings. AFAIK that is not always
the case, e.g. (AFAIK):

1. The intel pstate driver has something like this
    (might this be the rapl setting you mean? )

2. The X1C8 has such a setting for the embedded-controller, controlled
    through the ACPI interfaces which thinkpad-acpi used

3. The hp-wmi interface allows selecting a profile which in turn
    (through AML code) sets a bunch of variables which influence how
    the (dynamic, through mjg59's patches) DPTF code controls various
    things

At least the pstate setting and the vendor specific settings can
co-exist. Also the powercap API has a notion of zones, I can see the
same thing here, with a desktop e.g. having separate performance-profile
selection for the CPU and a discrete GPU.

So limiting the API to a single /sys/power/profile setting seems a
bit limited and I have the feeling we will regret making this
choice in the future.

With that said your proposal would work well for the current
thinkpad_acpi / hp-wmi cases, so I'm not 100% against it.

This would require adding some internal API to the code which
owns the /sys/power root-dir to allow registering a profile
provider I guess. But that would also immediately bring the
question, what if multiple drivers try to register themselves
as /sys/power/profile provider ?

Regards,

Hans


