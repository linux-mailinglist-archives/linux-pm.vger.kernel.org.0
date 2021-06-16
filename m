Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9203A9779
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 12:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbhFPKge (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 06:36:34 -0400
Received: from foss.arm.com ([217.140.110.172]:33328 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232602AbhFPKfr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 16 Jun 2021 06:35:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E81801042;
        Wed, 16 Jun 2021 03:33:41 -0700 (PDT)
Received: from [10.57.9.31] (unknown [10.57.9.31])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 563FF3F70D;
        Wed, 16 Jun 2021 03:33:40 -0700 (PDT)
Subject: Re: [PATCH v3 3/6] cpufreq: Add an interface to mark inefficient
 frequencies
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        peterz@infradead.org, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        dietmar.eggemann@arm.com
References: <1622804761-126737-1-git-send-email-vincent.donnefort@arm.com>
 <1622804761-126737-4-git-send-email-vincent.donnefort@arm.com>
 <20210614072835.z2tjoaffcflry7pk@vireshk-i7>
 <20210614133522.GA34061@e120877-lin.cambridge.arm.com>
 <20210615050211.5gpx4faha6heytad@vireshk-i7>
 <20210615084418.GA167242@e120877-lin.cambridge.arm.com>
 <20210615101706.mabloqrmakeiwcf5@vireshk-i7>
 <20210615171530.GA277695@e120877-lin.cambridge.arm.com>
 <20210616073500.b5wazdssoa5djp5o@vireshk-i7>
 <a4971ab0-87d7-4457-49ec-ce20106be358@arm.com>
 <20210616093127.lfpi4rje56b3dhwx@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <ff9a9daa-7d25-ea08-2cd9-fc56f778acde@arm.com>
Date:   Wed, 16 Jun 2021 11:33:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210616093127.lfpi4rje56b3dhwx@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/16/21 10:31 AM, Viresh Kumar wrote:
> On 16-06-21, 10:03, Lukasz Luba wrote:
>> On 6/16/21 8:35 AM, Viresh Kumar wrote:
>>> On 15-06-21, 18:15, Vincent Donnefort wrote:
>>>> But if we sum-up:
>>>>
>>>> 1. em_dev_register_perf_domain() find inefficiencies
>>>>
>>>> 2. dev_pm_opp_of_register_em() apply EM inefficiencies into the OPP structures
>>>
>>> I was looking to add a new API to the OPP core
>>> (dev_pm_opp_mark_inefficient()) to mark an OPP inefficient. And then
>>> get it called from em_create_perf_table().
>>>
>>> But I now see that EM core rather has callbacks to call into and with
>>
>> Exactly, that's what I was trying to stress.
>>
>>> that I think you should rather add another callback
>>> (.mark_inefficient()) in struct em_data_callback, to set inefficient
>>> frequencies.
>>
>> I disagree. That's why I prefer Vincent's approach in this patch set.
>> This proposal would cause more mess.
>>
>> Vincent proposed a small and clean modification. This modification
>> can be done easily in this cpufreq place because we have EM in
>> device cpu struct.
> 
> This may look clean to you, but not to me, sorry about that.
> 
> Clean is not lesser number of lines for me, but rather having the
> right ownership of such things.

Some developers do like patches which removes more lines then adds ;)

> 
> For example this patch:
> 
> https://lore.kernel.org/linux-pm/1622804761-126737-6-git-send-email-vincent.donnefort@arm.com/
> 
> tries to add EM stuff in cpufreq core. Cpufreq core doesn't care about
> EM and it shouldn't. And this piece of code doesn't belong here.
> 
> Would you guys like to add a cpufreq specific call into the EM core? I
> won't, that's not a place for cpufreq stuff. It is the EM core. I was
> fine with not including OPP core into this, and I gave up that
> argument earlier, but then we realized that the cpufreq core isn't
> ready at the time we register with EM core.
> 
> Honestly, OPP core looks to be a better place holder for such stuff.
> This is exactly the purpose of the OPP core. Moreover, we can apply
> the same logic to devfreq or other devices later, with or without EM
> core. Again, OPP core fits better.
> 
> The cpufreq core already has the relevant APIs in place to the OPP
> core and this won't require a new API there.

I don't see an API function in the OPP framework or a field in the
OPP struct which gives information that this freq is inefficient.
Thus, it will require new API changes: cpufreq --> OPP.

> 
>> Let's don't over-engineering. The inefficient information is only valid
>> for schedutil, thus IMHO it can live like this patch set made - in the
>> cpufreq table.
> 
> For now, yes. There is no guarantee though that we won't have more in
> future.

And there won't be in near future. We don't build massive interfaces
because there *might* be potential *oneday*.
Even for this idea, it was a massive work to do the research and prove
it that this is worth to put mainline so all vendors will get it.

The GPUs are slightly different beasts and they have different
workloads (not util + SchedUtil driven AFAIK).

> 
>> Compare the v1 (I still don't understand why it was blocked),
> 
> IIRC, it required more work to be done in the hotpath, i.e. traversing
> the freq list twice.

In v1 there was LUT. IMHO we have too easily gave and said:
'Remove the Look-up table as the numbers weren't strong enough to 
justify the implementation.'
But it had other benefits, which are now pointed.

There was different issue, which we could fix now.
With this patch set [1] EAS could have the freq_max limit, which
SchedUtil has in the hotpath.

What could be the modified v1 [2]:
- LUT which holds two IDs: efficient, inefficient, take one
   according to the clamp f_max
- add new argument 'policy->max' to em_pd_get_efficient_freq()

freq = em_pd_get_efficient_freq(em_cpu_get(policy->cpu), freq, policy->max);

The problem was that EAS couldn't know the clamp freq_max,
which shouldn't be the blocker now.

> 
>> this v3 and your proposal.
> 
> IMHO, adding such callbacks to the EM core, like .mark_efficient(),
> will only make this easier to handle for all different frameworks, and
> not otherwise. The code will look much cleaner everywhere..
> 

What about coming back to the slightly modified v1 idea?
That was really self-contained modification for this
inefficient opps heuristic.


[1] https://lore.kernel.org/lkml/20210614185815.15136-1-lukasz.luba@arm.com/
[2] 
https://lore.kernel.org/lkml/1617901829-381963-2-git-send-email-vincent.donnefort@arm.com/
