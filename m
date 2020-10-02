Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B89281827
	for <lists+linux-pm@lfdr.de>; Fri,  2 Oct 2020 18:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387856AbgJBQkk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Oct 2020 12:40:40 -0400
Received: from foss.arm.com ([217.140.110.172]:41068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387692AbgJBQkk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 2 Oct 2020 12:40:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D0B81396;
        Fri,  2 Oct 2020 09:40:39 -0700 (PDT)
Received: from [10.57.50.3] (unknown [10.57.50.3])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D9283F6CF;
        Fri,  2 Oct 2020 09:40:35 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] dt-bindings: thermal: update sustainable-power
 with abstract scale
To:     Doug Anderson <dianders@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, linux-doc@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        amitk@kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dietmar.Eggemann@arm.com, Quentin Perret <qperret@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20201002114426.31277-1-lukasz.luba@arm.com>
 <20201002114426.31277-4-lukasz.luba@arm.com>
 <CAD=FV=UbNP5-G1z95F37Fmv8=n0JPSSwnPQO_K==WpAc4vAHWQ@mail.gmail.com>
 <e9b6fc5a-45d3-168d-db38-6c068da26f6b@arm.com>
 <CAD=FV=Xkg1zpsMW5rERbibnjrgY6opZi8Z9DUFkWebb7NHtU5w@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <bc5d21c1-ea84-9132-2e52-ae84fbb0515a@arm.com>
Date:   Fri, 2 Oct 2020 17:40:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=Xkg1zpsMW5rERbibnjrgY6opZi8Z9DUFkWebb7NHtU5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/2/20 4:47 PM, Doug Anderson wrote:
> Hi,
> 
> On Fri, Oct 2, 2020 at 8:13 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Hi Doug,
>>
>> On 10/2/20 3:31 PM, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Fri, Oct 2, 2020 at 4:45 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>>
>>>> Update the documentation for the binding 'sustainable-power' and allow
>>>> to provide values in an abstract scale. It is required when the cooling
>>>> devices use an abstract scale for their power values.
>>>>
>>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>>> ---
>>>>    .../devicetree/bindings/thermal/thermal-zones.yaml  | 13 +++++++++----
>>>>    1 file changed, 9 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
>>>> index 3ec9cc87ec50..4d8f2e37d1e6 100644
>>>> --- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
>>>> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
>>>> @@ -99,10 +99,15 @@ patternProperties:
>>>>          sustainable-power:
>>>>            $ref: /schemas/types.yaml#/definitions/uint32
>>>>            description:
>>>> -          An estimate of the sustainable power (in mW) that this thermal zone
>>>> -          can dissipate at the desired control temperature. For reference, the
>>>> -          sustainable power of a 4-inch phone is typically 2000mW, while on a
>>>> -          10-inch tablet is around 4500mW.
>>>> +          An estimate of the sustainable power (in mW or in an abstract scale)
>>>> +         that this thermal zone can dissipate at the desired control
>>>> +         temperature. For reference, the sustainable power of a 4-inch phone
>>>> +         is typically 2000mW, while on a 10-inch tablet is around 4500mW.
>>>> +
>>>> +         It is possible to express the sustainable power in an abstract
>>>> +         scale. This is the case when the related cooling devices use also
>>>> +         abstract scale to express their power usage. The scale must be
>>>> +         consistent.
>>>
>>> Two thoughts:
>>>
>>> 1. If we're going to allow "sustainable-power" to be in abstract
>>> scale, why not allow "dynamic-power-coefficient" to be in abstract
>>> scale too?  I assume that the whole reason against that originally was
>>> the idea of device tree purity, but if we're allowing the abstract
>>> scale here then there seems no reason not to allow it for
>>> "dynamic-power-coefficient".
>>
>> With this binding it's a bit more tricky.
>> I also have to discuss a few things internally. This requirement of
>> uW/MHz/V^2 makes the code easier also for potential drivers
>> like GPU (which are going to register the devfreq cooling with EM).
>>
>> Let me think about it, but for now I would just update these bits.
>> These are required to proper IPA operation, the dyn.-pow.-coef. is a
>> nice to have and possible next step.
> 
> I guess the problem is that Rajendra is currently planning to remove
> all the "dynamic-power-coefficient" values from device tree right now
> and move them to the source code because the numbers we currently have
> in the device tree _are_ in abstract scale and thus violate the
> bindings.  Moving this to source code won't help us get to more real
> power numbers (since it'll still be abstract scale), it'll just be
> pure churn.  If we're OK with the abstract scale in general then we
> should allow it everywhere and not add churn for no reason.

IIUC he is still going to use the Energy Model, but with different
registration function. We have such a driver: scmi-cpufreq.c, which
uses em_dev_register_perf_domain(). He can still use EM, EAS, IPA
not violating anything.

The real problem that we want to address is with sustainable-power in
IPA. It is used in power budget calculation and if the devices operate
in abstract scale, then there is an issue.
There are two options to get that value:
1. from DT, which can have optimized value, stored by OEM engineer
2. from IPA estimation code, which just calculates it as a sum of
minimum OPP power for each cooling device.

The 2nd option might not be the best for a platform, so vendor/OEM
engineer might want to provide a better value in DT -> 1st option.
This is currently against the binding description and I have to fix it.

> 
> 
>>> 2. Is it worth adding some type of indication of what type of units
>>> "sustainable-power" is represented in?  Maybe even a made up unit so
>>> that you could tell the difference between made up units in the same
>>> system?  I'd envision something like:
>>>
>>> sustainable-power-units = "qualcomm,sc7180-bogoWatts"
>>>
>>> ...and on the dynamic-power-coefficient side, the same:
>>>
>>> dynamic-power-coefficient-units = "qualcomm,sc7180-bogoWatts"
>>>
>>> One could imagine someone even later (after devices are widely
>>> distributed) figuring out translations between these bogoWatts numbers
>>> and real Watts if someone could come up with a case where it matters.
>>
>> To figure this out we don't need a new binding.
>> I think a simple comment in the DT would be enough for this, even e.g.:
>>
>> sustainable-power = <100> /* bogoWatts */
> 
> There are some important differences:
> 
> a) Your comment is gone when the device tree is compiled.  If we
> actually add a string to the device tree then, in theory, we can add
> conversions in code (without touching the device tree) down the road.

We don't need code and binding with a bogoscale. It is up to the
platform integrator to make sure the scale in consistent in all devices.
Comment in DT is good enough.

> 
> b) I believe there can be more than one abstract scale present in a
> single device tree, at least in theory.  Adding a string allows you to
> know if you're comparing apples to apples or apples to organges.

IMHO DT is not the place for such abstractions, but Rob might correct me
here.

Regards,
Lukasz
