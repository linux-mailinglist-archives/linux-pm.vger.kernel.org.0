Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC2E2A0119
	for <lists+linux-pm@lfdr.de>; Fri, 30 Oct 2020 10:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgJ3JT4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Oct 2020 05:19:56 -0400
Received: from foss.arm.com ([217.140.110.172]:56812 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbgJ3JTy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 30 Oct 2020 05:19:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4796139F;
        Fri, 30 Oct 2020 02:19:53 -0700 (PDT)
Received: from [10.57.13.192] (unknown [10.57.13.192])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 946443F719;
        Fri, 30 Oct 2020 02:19:50 -0700 (PDT)
Subject: Re: [PATCH 0/4] Add sustainable OPP concept
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, vireshk@kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, nm@ti.com, rafael@kernel.org,
        sudeep.holla@arm.com, daniel.lezcano@linaro.org,
        Dietmar.Eggemann@arm.com
References: <20201028140847.1018-1-lukasz.luba@arm.com>
 <20201029074057.6ugmwyzna52x3oli@vireshk-i7>
 <20201029075356.rruej6jlerhfa4oy@vireshk-i7>
 <228fa1b3-bbd3-6941-fd4b-06581016d839@arm.com>
 <20201030082937.xgjmko2ohwhkt6f5@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <a0a6db69-fc3e-c39f-7586-5ac3227b746e@arm.com>
Date:   Fri, 30 Oct 2020 09:19:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201030082937.xgjmko2ohwhkt6f5@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/30/20 8:29 AM, Viresh Kumar wrote:
> On 29-10-20, 09:56, Lukasz Luba wrote:
>> There were discussions about Energy Model (EM), scale of values (mW or
>> abstract scale) and relation to EAS and IPA. You can find quite long
>> discussion below v2 [1] (there is also v3 send after agreement [2]).
>> We have in thermal DT binding: 'sustainable-power' expressed in mW,
>> which is used by IPA, but it would not support bogoWatts.
> 
> Why so ? (I am sorry, can't dig into such long threads without knowing
> which message I am looking for :( ). Lets assume if that same property
> can be used for bogoWatts, will that be sufficient for you ? Or you
> will still need this patch set ?

I had a patch for that, but I know Rob's opinion on this one [1] (which
is below in that thread).

> 
>> The sustainable power is used for estimation of internal coefficients
>> (also for power budget), which I am trying to change to work with
>> 'abstract scale' [3][4].
>>
>> This would allow to estimate sustainable power of the system based on
>> CPUs, GPU opp-sustainable points, where we don't have
>> 'sustainable-power' or devices using bogoWatts.
> 
> Then maybe we should ahve sustainable-power in those cases too instead
> of adding a meaningless (IMHO) binding.

How about dropping the DT binding, but just adding this new field into
dev_pm_opp? There will be no DT parsing code, just the get/set
functions, which will be used in SCMI patch 4/4 and in IPA?
That would not require to change any DT bindings.

> 
> Honestly speaking, as Nishanth said, there is nothing like a
> sustainable OPP in reality. Moreover, the DT needs to describe the
> hardware as it is (and in some cases the behavior of the firmware).
> And what you are trying to add here is none of them and so it should
> not go in DT as such. There are too many factors which play a part
> here, ambient temperature is one of the biggest ones, and the software
> needs to find the sustainable OPP by itself based on the current
> situation.
> 
> So I don't really see a good reason why such a property should be
> added here.

I see. Just for your information SCMI supports 'Sustained Performance'
  expressed in kHz.

> 
> Coming to properties like suspend-opp, it made sense for some of the
> platforms as the last configured frequency of the CPU plays a part in
> deciding the power consumed by the SoC even when the system is
> suspended. And finding an optimal OPP (normally the lowest) there
> would make sense and so was that property added.
> 

I also found that suspend-opp (83f8ca45afbf041e312909).
I hope you wouldn't mind if I add this new field into dev_pm_opp (no DT
support, just FW).


[1] https://lore.kernel.org/lkml/20201002114426.31277-4-lukasz.luba@arm.com/
