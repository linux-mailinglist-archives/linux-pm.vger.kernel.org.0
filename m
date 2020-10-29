Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D4929E7EB
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 10:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgJ2J4N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 05:56:13 -0400
Received: from foss.arm.com ([217.140.110.172]:58096 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgJ2J4N (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 29 Oct 2020 05:56:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BD84139F;
        Thu, 29 Oct 2020 02:56:12 -0700 (PDT)
Received: from [10.57.13.20] (unknown [10.57.13.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AEB43F66E;
        Thu, 29 Oct 2020 02:56:08 -0700 (PDT)
Subject: Re: [PATCH 0/4] Add sustainable OPP concept
To:     Viresh Kumar <viresh.kumar@linaro.org>, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        vireshk@kernel.org, robh+dt@kernel.org, sboyd@kernel.org,
        nm@ti.com, rafael@kernel.org, sudeep.holla@arm.com,
        daniel.lezcano@linaro.org, Dietmar.Eggemann@arm.com
References: <20201028140847.1018-1-lukasz.luba@arm.com>
 <20201029074057.6ugmwyzna52x3oli@vireshk-i7>
 <20201029075356.rruej6jlerhfa4oy@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <228fa1b3-bbd3-6941-fd4b-06581016d839@arm.com>
Date:   Thu, 29 Oct 2020 09:56:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201029075356.rruej6jlerhfa4oy@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/29/20 7:53 AM, Viresh Kumar wrote:
> On 29-10-20, 13:10, Viresh Kumar wrote:
>> On 28-10-20, 14:08, Lukasz Luba wrote:
>>> Hi all,
>>>
>>> This patch set introduces a concept of sustainable OPP, which then can be used
>>> by kernel frameworks or governors for estimating system sustainable system
>>> state. This kind of estimation is done e.g. in thermal governor Intelligent
>>> Power Allocation (IPA), which calculates sustainable power of the whole system
>>> and then derives some coefficients for internal algorithm.
>>>
>>> The patch set introduces a new DT bindings 'opp-sustainable', with parsing
>>> code. It also adds a function (in patch 3/4) which allows device drivers to set
>>> directly the sustainable OPP. This is helpful when the device drivers populate
>>> the OPP table by themself (example in patch 4/4).
>>>
>>
>> Can we please have some more information about this ? What does the
>> sustainable OPP mean ? How will platform guys know or learn about this
>> ? How we are going to use it finally ? What does it have to do with
>> temperature of the SoC or the thermal affects, etc.

There were discussions about Energy Model (EM), scale of values (mW or
abstract scale) and relation to EAS and IPA. You can find quite long
discussion below v2 [1] (there is also v3 send after agreement [2]).
We have in thermal DT binding: 'sustainable-power' expressed in mW,
which is used by IPA, but it would not support bogoWatts.
The sustainable power is used for estimation of internal coefficients
(also for power budget), which I am trying to change to work with
'abstract scale' [3][4].

This would allow to estimate sustainable power of the system based on
CPUs, GPU opp-sustainable points, where we don't have
'sustainable-power' or devices using bogoWatts.

> 
> And that we need a real user of this first if it is ever going to be
> merged.
> 

IPA would be the first user of this in combination with scmi-cpufreq.c,
which can feed 'abstract scale' in to EM.
Currently IPA takes lowest allowed OPPs into account for this estimation
which is not optimal. This marked OPPs would make estimation a lot
better.

Regards,
Lukasz


[1] https://lore.kernel.org/lkml/20201002114426.31277-1-lukasz.luba@arm.com/
[2] https://lore.kernel.org/lkml/20201019140601.3047-1-lukasz.luba@arm.com/
[3] 
https://lore.kernel.org/linux-pm/5f682bbb-b250-49e6-dbb7-aea522a58595@arm.com/
[4] https://lore.kernel.org/lkml/20201009135850.14727-1-lukasz.luba@arm.com/
