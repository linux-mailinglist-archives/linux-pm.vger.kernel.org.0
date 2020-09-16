Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C53226C12A
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 11:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgIPJx5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 05:53:57 -0400
Received: from foss.arm.com ([217.140.110.172]:57522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbgIPJxx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 16 Sep 2020 05:53:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7141B1FB;
        Wed, 16 Sep 2020 02:53:52 -0700 (PDT)
Received: from [10.37.12.50] (unknown [10.37.12.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 462573F718;
        Wed, 16 Sep 2020 02:53:50 -0700 (PDT)
Subject: Re: is 'dynamic-power-coefficient' expected to be based on 'real'
 power measurements?
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
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
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <b0d32e2b-1e21-b921-2d5f-335abafd0a37@arm.com>
Date:   Wed, 16 Sep 2020 10:53:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <27785351-ba14-dc92-6761-d64962c29596@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 9/15/20 9:55 PM, Daniel Lezcano wrote:
> On 15/09/2020 19:58, Matthias Kaehlcke wrote:
>> On Tue, Sep 15, 2020 at 07:50:10PM +0200, Daniel Lezcano wrote:
>>> On 15/09/2020 19:24, Matthias Kaehlcke wrote:
>>>> +Thermal folks
>>>>
>>>> Hi Rajendra,
>>>>
>>>> On Tue, Sep 15, 2020 at 11:14:00AM +0530, Rajendra Nayak wrote:
>>>>> Hi Rob,
>>>>>
>>>>> There has been some discussions on another thread [1] around the DPC (dynamic-power-coefficient) values
>>>>> for CPU's being relative vs absolute (based on real power) and should they be used to derive 'real' power
>>>>> at various OPPs in order to calculate things like 'sustainable-power' for thermal zones.
>>>>> I believe relative values work perfectly fine for scheduling decisions, but with others using this for
>>>>> calculating power values in mW, is there a need to document the property as something that *has* to be
>>>>> based on real power measurements?
>>>>
>>>> Relative values may work for scheduling decisions, but not for thermal
>>>> management with the power allocator, at least not when CPU cooling devices
>>>> are combined with others that specify their power consumption in absolute
>>>> values. Such a configuration should be supported IMO.
>>>
>>> The energy model is used in the cpufreq cooling device and if the
>>> sustainable power is consistent with the relative values then there is
>>> no reason it shouldn't work.
>>
>> Agreed on thermal zones that exclusively use CPUs as cooling devices, but
>> what when you have mixed zones, with CPUs with their pseudo-unit and e.g. a
>> GPU that specifies its power in mW?
> 
> Well, if a SoC vendor decides to mix the units, then there is nothing we
> can do.
> 
> When specifying the power numbers available for the SoC, they could be
> all scaled against the highest power number.
> 
> There are so many factors on the hardware, the firmware, the kernel and
> the userspace sides having an impact on the energy efficiency, I don't
> understand why SoC vendors are so shy to share the power numbers...
> 

Unfortunately (because it might confuse engineers in some cases like
this one), even in the SCMI spec DEN0056B [1] we have this statement
which allows to expose an 'abstract scale' values from firmware:
'4.5.1 Performance domain management protocol background
...The power can be expressed in mW or in an abstract scale. Vendors
are not obliged to reveal power costs if it is undesirable, but a linear
scale is required.'

This is the source of our Energy Model values when we use SCMI cpufreq
driver [2].

So this might be an issue in the future, when some SoC vendor decides to
not expose the real mW, but the phone OEM would then take the SoC and
try to add some other cooling device into the thermal zone. That new
device is not part of the SCMI perf but some custom and has the real mW.

Do you think Daniel it should be somewhere documented in the kernel
thermal that the firmware might silently populate EM with 'abstract
scale'? Then special care should be taken when combining new
cooling devices.

Regards,
Lukasz

[1] https://developer.arm.com/documentation/den0056/b/?lang=en
[2] 
https://elixir.bootlin.com/linux/latest/source/drivers/cpufreq/scmi-cpufreq.c#L121
