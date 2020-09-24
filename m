Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F4F276BB0
	for <lists+linux-pm@lfdr.de>; Thu, 24 Sep 2020 10:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgIXIWD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Sep 2020 04:22:03 -0400
Received: from foss.arm.com ([217.140.110.172]:38358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbgIXIWC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 24 Sep 2020 04:22:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C809930E;
        Thu, 24 Sep 2020 01:22:01 -0700 (PDT)
Received: from [10.57.51.181] (unknown [10.57.51.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA8183F70D;
        Thu, 24 Sep 2020 01:21:59 -0700 (PDT)
Subject: Re: is 'dynamic-power-coefficient' expected to be based on 'real'
 power measurements?
To:     Rajendra Nayak <rnayak@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-pm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>
References: <248bb01e-1746-c84c-78c4-3cf7d2541a70@codeaurora.org>
 <20200915172444.GA2771744@google.com>
 <406d5d4e-d7d7-8a37-5501-119b734facb3@linaro.org>
 <20200915175808.GB2771744@google.com>
 <27785351-ba14-dc92-6761-d64962c29596@linaro.org>
 <b0d32e2b-1e21-b921-2d5f-335abafd0a37@arm.com>
 <20200916164840.GI2771744@google.com>
 <c8367a0e-ee58-37f3-b306-648ddc0a3e2b@codeaurora.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <6bb2dab0-5d5a-3a32-6ff2-ec322f6d6004@arm.com>
Date:   Thu, 24 Sep 2020 09:21:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c8367a0e-ee58-37f3-b306-648ddc0a3e2b@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 9/24/20 7:09 AM, Rajendra Nayak wrote:
> 
> On 9/16/2020 10:18 PM, Matthias Kaehlcke wrote:
>> On Wed, Sep 16, 2020 at 10:53:48AM +0100, Lukasz Luba wrote:
>>>
>>>
>>> On 9/15/20 9:55 PM, Daniel Lezcano wrote:
>>>> On 15/09/2020 19:58, Matthias Kaehlcke wrote:
>>>>> On Tue, Sep 15, 2020 at 07:50:10PM +0200, Daniel Lezcano wrote:
>>>>>> On 15/09/2020 19:24, Matthias Kaehlcke wrote:
>>>>>>> +Thermal folks
>>>>>>>
>>>>>>> Hi Rajendra,
>>>>>>>
>>>>>>> On Tue, Sep 15, 2020 at 11:14:00AM +0530, Rajendra Nayak wrote:
>>>>>>>> Hi Rob,
>>>>>>>>
>>>>>>>> There has been some discussions on another thread [1] around the 
>>>>>>>> DPC (dynamic-power-coefficient) values
>>>>>>>> for CPU's being relative vs absolute (based on real power) and 
>>>>>>>> should they be used to derive 'real' power
>>>>>>>> at various OPPs in order to calculate things like 
>>>>>>>> 'sustainable-power' for thermal zones.
>>>>>>>> I believe relative values work perfectly fine for scheduling 
>>>>>>>> decisions, but with others using this for
>>>>>>>> calculating power values in mW, is there a need to document the 
>>>>>>>> property as something that *has* to be
>>>>>>>> based on real power measurements?
>>>>>>>
>>>>>>> Relative values may work for scheduling decisions, but not for 
>>>>>>> thermal
>>>>>>> management with the power allocator, at least not when CPU 
>>>>>>> cooling devices
>>>>>>> are combined with others that specify their power consumption in 
>>>>>>> absolute
>>>>>>> values. Such a configuration should be supported IMO.
>>>>>>
>>>>>> The energy model is used in the cpufreq cooling device and if the
>>>>>> sustainable power is consistent with the relative values then 
>>>>>> there is
>>>>>> no reason it shouldn't work.
>>>>>
>>>>> Agreed on thermal zones that exclusively use CPUs as cooling 
>>>>> devices, but
>>>>> what when you have mixed zones, with CPUs with their pseudo-unit 
>>>>> and e.g. a
>>>>> GPU that specifies its power in mW?
>>>>
>>>> Well, if a SoC vendor decides to mix the units, then there is 
>>>> nothing we
>>>> can do.
>>>>
>>>> When specifying the power numbers available for the SoC, they could be
>>>> all scaled against the highest power number.
>>>>
>>>> There are so many factors on the hardware, the firmware, the kernel and
>>>> the userspace sides having an impact on the energy efficiency, I don't
>>>> understand why SoC vendors are so shy to share the power numbers...
>>>>
>>>
>>> Unfortunately (because it might confuse engineers in some cases like
>>> this one), even in the SCMI spec DEN0056B [1] we have this statement
>>> which allows to expose an 'abstract scale' values from firmware:
>>> '4.5.1 Performance domain management protocol background
>>> ...The power can be expressed in mW or in an abstract scale. Vendors
>>> are not obliged to reveal power costs if it is undesirable, but a linear
>>> scale is required.'
>>>
>>> This is the source of our Energy Model values when we use SCMI cpufreq
>>> driver [2].
>>>
>>> So this might be an issue in the future, when some SoC vendor decides to
>>> not expose the real mW, but the phone OEM would then take the SoC and
>>> try to add some other cooling device into the thermal zone. That new
>>> device is not part of the SCMI perf but some custom and has the real mW.
>>>
>>> Do you think Daniel it should be somewhere documented in the kernel
>>> thermal that the firmware might silently populate EM with 'abstract
>>> scale'? Then special care should be taken when combining new
>>> cooling devices.
>>>
>>> Regards,
>>> Lukasz
>>>
>>> [1] https://developer.arm.com/documentation/den0056/b/?lang=en
>>> [2] 
>>> https://elixir.bootlin.com/linux/latest/source/drivers/cpufreq/scmi-cpufreq.c#L121 
>>>
>>
>> If an 'abstract scale' is explicitly allowed I think it should be 
>> documented
>> to avoid confusion and make engineers aware of the peril of combining 
>> cooling
>> devices of different types in the same thermal zone.
> 
> Rob, we should perhaps also document this as part of the DT bindings 
> document
> to be consistent, that an abstract scale is allowed when specifying the DPC
> values in DT.
> if you agree, I can spin a quick patch to update the documentation.
> 

The 'dynamic-power-coefficient' which is in the:
Documentation/devicetree/bindings/arm/cpus.yaml does not need any update
because it expects units of 'uW/MHz/V^2' to calculate dynamic power.

You have two ways to register Energy Model for a device:
1. em_dev_register_perf_domain() where you provide the callback function
and that can feed the 'abstract scale' (like the scmi-cpufreq.c)
2. dev_pm_opp_of_register_em() where the 'dynamic-power-coefficient'
is going to be involved.

If the developer would see that the platform might face potential issue
of mixing devices in one thermal zone of two scales, it should not use
the 2nd registration, but the 1st API and provide callback with
consistent scale to all devices. It is also very unlikely that the
device like GPU or DSP would not be part of the scmi perf domains
and would not expose a consistent abstract scale.

I have a patch spinning in our internal review to update EAS, EM, IPA
documentation and that would be updated soon.

Regards,
Lukasz

