Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E9B29ECF6
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 14:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725613AbgJ2Ndt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 09:33:49 -0400
Received: from foss.arm.com ([217.140.110.172]:37132 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgJ2Nds (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 29 Oct 2020 09:33:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDEE9139F;
        Thu, 29 Oct 2020 06:33:47 -0700 (PDT)
Received: from [10.57.13.20] (unknown [10.57.13.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A0F23F719;
        Thu, 29 Oct 2020 06:33:44 -0700 (PDT)
Subject: Re: [PATCH 1/4] dt-bindings: opp: Introduce opp-sustainable bindings
To:     Nishanth Menon <nm@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        vireshk@kernel.org, robh+dt@kernel.org, sboyd@kernel.org,
        rafael@kernel.org, sudeep.holla@arm.com, daniel.lezcano@linaro.org,
        Dietmar.Eggemann@arm.com
References: <20201028140847.1018-1-lukasz.luba@arm.com>
 <20201028140847.1018-2-lukasz.luba@arm.com>
 <20201028214713.zttk47qtua5jhieo@pureness>
 <5b3a99a8-6972-5c60-6cc5-00ec84387b97@arm.com>
 <20201029125932.fvhaj6fsgt3qvmoc@gloomily>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <792cce7c-a316-fee4-fbf6-3cfc688b7088@arm.com>
Date:   Thu, 29 Oct 2020 13:33:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201029125932.fvhaj6fsgt3qvmoc@gloomily>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/29/20 12:59 PM, Nishanth Menon wrote:
> On 10:04-20201029, Lukasz Luba wrote:
>>
>>
>> On 10/28/20 9:47 PM, Nishanth Menon wrote:
>>> On 14:08-20201028, Lukasz Luba wrote:
>>>> Add opp-sustainable as an additional property in the OPP node to describe
>>>> the sustainable performance level of the device. This will help to
>>>> estimate the sustainable performance of the whole system.
>>>>
>>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/opp/opp.txt | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
>>>> index 9847dfeeffcb..cd01028de305 100644
>>>> --- a/Documentation/devicetree/bindings/opp/opp.txt
>>>> +++ b/Documentation/devicetree/bindings/opp/opp.txt
>>>> @@ -154,6 +154,10 @@ Optional properties:
>>>>    - opp-suspend: Marks the OPP to be used during device suspend. If multiple OPPs
>>>>      in the table have this, the OPP with highest opp-hz will be used.
>>>> +- opp-sustainable: Marks the OPP as sustainable. This property can be used for
>>>> +  estimating sustainable performance of the whole system. If multiple OPPs in
>>>> +  the table have this, the OPP with highest opp-hz will be used.
>>>
>>>
>>> By "sustainable", do you mean sustainable across Process, Voltage and
>>> Temperature corners upto the max rated operational Power-ON hours
>>> without IDLE state being achieved on the processor?
>>
>> Yes, in case of CPU: running 100% without idle at that particular OPP.
>> Running above that OPP would lead to cross control temperature.
> 
> We need to tighten the definitions a lot more here and add that to the
> binding. What we are stating, if I am not misunderstanding is an OPP
> that is guaranteed by SoC vendor that across Process Voltage and
> Temperature corners - aka across the entire production spectrum
> for the part number, *all* devices will operate at this OPP for the
> mandated power-on-hours rating without hitting IDLE.
> 
> Example: So -40C to 125C, across the process (hot/cold/nominal), 100s of
> thousands/millions of units can operate upto 125,0000 power-on-hours
> while running a tight deadloop OR maybe high processing function or even
> cpuburn[1]?

I think I know what you mean. But this would lead to redefining a lot
more that just this optional field. This wide range -40C to 125C is for
automotive chips, then what about opp-suspend, when the device cannot
even reach that OPP under some stress test e.g. outside temp
~100-110C...
Or opp-turbo, shell all the OPPs have multidimensional table to reflect
the temperature dependency for all affected optional fields?

> 
> 
> Can you give me one SoC vendor and part that guarantees this? I am
> wondering if this is all theoretical... There are tons of parameters
> that come into play for "reliability" "sustainability" etc. Those are
> tricky terminology that typically makes legal folks pretty happy to
> debate for decades..

Yes, but the outside temperature is probably most important for this use
case.

> 
> just my 2 cents.
>>
>>>
>>> OR do you mean to leave it up to interpretation?
>>
>> I can tell how I would use them. There is thermal governor IPA, which
>> needs sustainable power either form DT or uses internal algorithm to
>> estimate it based on lowest allowed freq OPPs. Then it estimated
>> internal coefficients based on that value, which is not optimal
>> for lowest OPPs. When some higher OPP could be marked as sustainable,
>> it would lead to better estimation and better power budget split.
> 
> Seeing your series, I got an idea about how you plan on using it, I
> just think we need to be more precise in our definition..

Thank you for having a look on that and understanding the motivation
behind this series.

How about adding a description that this sustainable OPP is considered
for normal room temp (20-25C)?

BTW, in the Arm SCMI spec definition of that value (used in patch 4/4),
there is no specific temperature for it, just:
'This is the maximum performance level that the platform can
sustain under normal conditions. In exceptional circumstances,
such as thermal runaway, the platform might not be be able to
guarantee this level.'

I can put this whole description into the DT binding, if you like.

> 
> [1] https://patrickmn.com/projects/cpuburn/
> 
