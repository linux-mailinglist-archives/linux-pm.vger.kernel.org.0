Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C7C26C051
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 11:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgIPJS7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 05:18:59 -0400
Received: from foss.arm.com ([217.140.110.172]:57150 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgIPJSo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 16 Sep 2020 05:18:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB8D7101E;
        Wed, 16 Sep 2020 02:18:43 -0700 (PDT)
Received: from [10.37.12.50] (unknown [10.37.12.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A00853F718;
        Wed, 16 Sep 2020 02:18:41 -0700 (PDT)
Subject: Re: is 'dynamic-power-coefficient' expected to be based on 'real'
 power measurements?
To:     Matthias Kaehlcke <mka@chromium.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
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
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <6b5f3130-a9e7-3240-b5ab-63f87e0d53d3@arm.com>
Date:   Wed, 16 Sep 2020 10:18:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200915175808.GB2771744@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 9/15/20 6:58 PM, Matthias Kaehlcke wrote:
> On Tue, Sep 15, 2020 at 07:50:10PM +0200, Daniel Lezcano wrote:
>> On 15/09/2020 19:24, Matthias Kaehlcke wrote:
>>> +Thermal folks
>>>
>>> Hi Rajendra,
>>>
>>> On Tue, Sep 15, 2020 at 11:14:00AM +0530, Rajendra Nayak wrote:
>>>> Hi Rob,
>>>>
>>>> There has been some discussions on another thread [1] around the DPC (dynamic-power-coefficient) values
>>>> for CPU's being relative vs absolute (based on real power) and should they be used to derive 'real' power
>>>> at various OPPs in order to calculate things like 'sustainable-power' for thermal zones.
>>>> I believe relative values work perfectly fine for scheduling decisions, but with others using this for
>>>> calculating power values in mW, is there a need to document the property as something that *has* to be
>>>> based on real power measurements?
>>>
>>> Relative values may work for scheduling decisions, but not for thermal
>>> management with the power allocator, at least not when CPU cooling devices
>>> are combined with others that specify their power consumption in absolute
>>> values. Such a configuration should be supported IMO.
>>
>> The energy model is used in the cpufreq cooling device and if the
>> sustainable power is consistent with the relative values then there is
>> no reason it shouldn't work.
> 
> Agreed on thermal zones that exclusively use CPUs as cooling devices, but
> what when you have mixed zones, with CPUs with their pseudo-unit and e.g. a
> GPU that specifies its power in mW?
> 

These two (pmW and mW) shouldn't be combined in one thermal
zone with IPA as a governor, but IPA will try to recover.
It will be more unstable meaning the OPPs capping might jump from
lowest to highest, which will be spotted in the testing.

For example, we have CPU with abstract scale where max is 10 and
GPU with real mW max = 2990. They both have the same 'weight' = 1.
Let's say IPA is seeing 3000 as a total budget and splits it:
10/3000 * 3000 = 10
2990/3000 * 3000 = 2990
Which means both actors can run at max speed. Unfortunately, the real
consumption of the CPU could be ~4000mW. The temperature in the next
period will rise above the threshold for which the budget was estimated.
Next time both devices are likely to be capped at minimum freq because
there is no budget and temperature is to high.

After a while the PID would realize this and try to recover, but this
shouldn't be the main solution.

Regards,
Lukasz


