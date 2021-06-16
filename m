Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CBD3A957D
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 11:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhFPJFk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 05:05:40 -0400
Received: from foss.arm.com ([217.140.110.172]:59388 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232108AbhFPJFi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 16 Jun 2021 05:05:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F042831B;
        Wed, 16 Jun 2021 02:03:25 -0700 (PDT)
Received: from [10.57.9.31] (unknown [10.57.9.31])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6327F3F70D;
        Wed, 16 Jun 2021 02:03:24 -0700 (PDT)
Subject: Re: [PATCH v3 3/6] cpufreq: Add an interface to mark inefficient
 frequencies
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
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
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <a4971ab0-87d7-4457-49ec-ce20106be358@arm.com>
Date:   Wed, 16 Jun 2021 10:03:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210616073500.b5wazdssoa5djp5o@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/16/21 8:35 AM, Viresh Kumar wrote:
> On 15-06-21, 18:15, Vincent Donnefort wrote:
>> On Tue, Jun 15, 2021 at 03:47:06PM +0530, Viresh Kumar wrote:
>>> The point is that I don't want cpufreq to carry this for users, we
>>> have EM today, tomorrow we may want to mark a frequency as inefficient
>>> from somewhere else. The call need to initiate from EM core.
>>
>> In the current version of this patchset, any driver can mark inefficiencies
>> without relying on the EM, just by adding the flag CPUFREQ_INEFFICIENT_FREQ in
>> cpufreq_frequency_table.
> 
> Yeah, I wasn't really talking about cpufreq drivers but external
> entities, like EM.
> 
>> Populating cpufreq_frequency_table from the EM in cpufreq was just an attempt to
>> a less intrusive set of changes.
>   
>>> And this isn't a cpufreq only thing, but is going to be generic along
>>> with other device types.
>>>
>>> This is exactly why I asked you earlier to play with OPP core for
>>> this. That is the central place for data for all such users.
>>>
>>> If this information is present at the OPP table (somehow), then we can
>>> just fix dev_pm_opp_init_cpufreq_table() to set this for cpufreq core
>>> as well.
>>>
>>> This is the sequence that is followed in cpufreq drivers today:
>>>
>>> dev_pm_opp_of_cpumask_add_table();
>>> dev_pm_opp_init_cpufreq_table();
>>> dev_pm_opp_of_register_em();
>>>
>>> What about changing this to:
>>>
>>> dev_pm_opp_of_cpumask_add_table();
>>>
>>> /* Mark OPPs are inefficient here */
>>> dev_pm_opp_of_register_em();
>>>
>>> /* This should automatically pick the right set */
>>> dev_pm_opp_init_cpufreq_table();
>>>
>>> Will this break anything ?
>>
>> Probably not, but with this approach I'll have to modify all the cpufreq drivers
>> that are registering the EM, which I tried to avoid as much as possible so far.
> 
> Hmm. You are right as well, but I just want to get the right API in
> place which lives a longer life :)
> 
>> But if we sum-up:
>>
>> 1. em_dev_register_perf_domain() find inefficiencies
>>
>> 2. dev_pm_opp_of_register_em() apply EM inefficiencies into the OPP structures
> 
> I was looking to add a new API to the OPP core
> (dev_pm_opp_mark_inefficient()) to mark an OPP inefficient. And then
> get it called from em_create_perf_table().
> 
> But I now see that EM core rather has callbacks to call into and with

Exactly, that's what I was trying to stress.

> that I think you should rather add another callback
> (.mark_inefficient()) in struct em_data_callback, to set inefficient
> frequencies.

I disagree. That's why I prefer Vincent's approach in this patch set.
This proposal would cause more mess.

Vincent proposed a small and clean modification. This modification
can be done easily in this cpufreq place because we have EM in
device cpu struct.

Let's don't over-engineering. The inefficient information is only valid
for schedutil, thus IMHO it can live like this patch set made - in the
cpufreq table.

Compare the v1 (I still don't understand why it was blocked), this v3
and your proposal.

