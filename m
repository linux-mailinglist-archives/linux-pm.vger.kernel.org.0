Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F8A3A9AD4
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 14:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbhFPMsR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 08:48:17 -0400
Received: from foss.arm.com ([217.140.110.172]:36290 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232869AbhFPMsJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 16 Jun 2021 08:48:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 418451042;
        Wed, 16 Jun 2021 05:46:03 -0700 (PDT)
Received: from [10.57.9.31] (unknown [10.57.9.31])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0C583F719;
        Wed, 16 Jun 2021 05:46:01 -0700 (PDT)
Subject: Re: [PATCH v3 3/6] cpufreq: Add an interface to mark inefficient
 frequencies
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        peterz@infradead.org, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        dietmar.eggemann@arm.com
References: <20210614072835.z2tjoaffcflry7pk@vireshk-i7>
 <20210614133522.GA34061@e120877-lin.cambridge.arm.com>
 <20210615050211.5gpx4faha6heytad@vireshk-i7>
 <20210615084418.GA167242@e120877-lin.cambridge.arm.com>
 <20210615101706.mabloqrmakeiwcf5@vireshk-i7>
 <20210615171530.GA277695@e120877-lin.cambridge.arm.com>
 <20210616073500.b5wazdssoa5djp5o@vireshk-i7>
 <a4971ab0-87d7-4457-49ec-ce20106be358@arm.com>
 <20210616093127.lfpi4rje56b3dhwx@vireshk-i7>
 <ff9a9daa-7d25-ea08-2cd9-fc56f778acde@arm.com>
 <20210616105327.wnppsau4gg5ihrlv@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <4d975236-943c-ea82-547b-04f2bead9f48@arm.com>
Date:   Wed, 16 Jun 2021 13:45:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210616105327.wnppsau4gg5ihrlv@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/16/21 11:53 AM, Viresh Kumar wrote:
> On 16-06-21, 11:33, Lukasz Luba wrote:
>> On 6/16/21 10:31 AM, Viresh Kumar wrote:
>>> On 16-06-21, 10:03, Lukasz Luba wrote:
>>> Clean is not lesser number of lines for me, but rather having the
>>> right ownership of such things.
>>
>> Some developers do like patches which removes more lines then adds ;)
> 
> :)
> 

[snip]

>>
>> What could be the modified v1 [2]:
>> - LUT which holds two IDs: efficient, inefficient, take one
>>    according to the clamp f_max
>> - add new argument 'policy->max' to em_pd_get_efficient_freq()
>>
>> freq = em_pd_get_efficient_freq(em_cpu_get(policy->cpu), freq, policy->max);
>>
>> The problem was that EAS couldn't know the clamp freq_max,
>> which shouldn't be the blocker now.
> 
> If you can do that without adding any EM specific stuff in the cpufreq
> core, I will mostly be fine.
> 
> But honestly speaking, creating more data structures to keep related
> information doesn't scale well.
> 
> We already have so many tables for keeping freq/voltage pairs, OPP,
> cpufreq, EM. You tried to add one more in EM I think V1, not sure.
> 
> It is always better to consolidate and we almost reached to a point
> where that could have been done very easily. I understand that you
> didn't want to touch so many different parts, but anyway..

Yes, I don't want to touch some many generic parts because they
are intended to be generic. This heuristic is only for EM platforms,
which are arm, arm64 battery powered (not servers or other).
Thus, I wanted to keep it locally. The cost of EM extra structures
(the LUT) will only be for platforms for which EM discovers that
they have inefficient performance levels.
The code would even not be compiled in for x86, ppc, etc, in hot path.

>   
>>>> this v3 and your proposal.
>>>
>>> IMHO, adding such callbacks to the EM core, like .mark_efficient(),
>>> will only make this easier to handle for all different frameworks, and
>>> not otherwise. The code will look much cleaner everywhere..
>>>
>>
>> What about coming back to the slightly modified v1 idea?
>> That was really self-contained modification for this
>> inefficient opps heuristic.
> 
> I am not sure if I really understand what that would be, but again
> adding another table is going to create more problems then it should.

IMHO your proposals are more invasive for the generic code, while
not always being even used. Plenty of architectures don't even set EM,
even arm64 for servers doesn't use it. You and Rafael would have to
maintain these modifications in generic code. It might be hard to remove
it. While I recommend to keep this heuristic feature inside the EM and
we will maintain it. If we decide after a few years that new arm64
platforms use some smarter FW for performance level, we might just
disable this heuristic.

> 
> Anyway, that's my view, which can be wrong as well.
> 
> Rafael: You have any suggestions here ?
> 

I would also like to hear Rafael's opinion :)
