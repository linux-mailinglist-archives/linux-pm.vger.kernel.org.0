Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A77C3BDE30
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jul 2021 21:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhGFTxo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Jul 2021 15:53:44 -0400
Received: from foss.arm.com ([217.140.110.172]:49122 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229793AbhGFTxn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Jul 2021 15:53:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2AA31042;
        Tue,  6 Jul 2021 12:51:04 -0700 (PDT)
Received: from [10.57.7.228] (unknown [10.57.7.228])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D085C3F5A1;
        Tue,  6 Jul 2021 12:51:01 -0700 (PDT)
Subject: Re: [PATCH 3/3] PM: EM: Increase energy calculation precision
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Chris.Redpath@arm.com, morten.rasmussen@arm.com,
        qperret@google.com, linux-pm@vger.kernel.org, peterz@infradead.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, mingo@redhat.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, segall@google.com,
        mgorman@suse.de, bristot@redhat.com, CCj.Yeh@mediatek.com
References: <20210625152603.25960-1-lukasz.luba@arm.com>
 <20210625152603.25960-4-lukasz.luba@arm.com>
 <be567416-e7ac-e672-ddfe-f9175ba1c016@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <fa2bac05-1992-9166-0b5f-2477af39bb55@arm.com>
Date:   Tue, 6 Jul 2021 20:51:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <be567416-e7ac-e672-ddfe-f9175ba1c016@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/5/21 1:45 PM, Dietmar Eggemann wrote:
> On 25/06/2021 17:26, Lukasz Luba wrote:
>> The Energy Model (EM) provides useful information about device power in
>> each performance state to other subsystems like: Energy Aware Scheduler
>> (EAS). The energy calculation in EAS does arithmetic operation based on
>> the EM em_cpu_energy(). Current implementation of that function uses
>> em_perf_state::cost as a pre-computed cost coefficient equal to:
>> cost = power * max_frequency / frequency.
>> The 'power' is expressed in milli-Watts (or in abstract scale).
>>
>> There are corner cases then the EAS energy calculation for two Performance
>              ^^^^^^^^^^^^
> 
> Again, an easy to understand example to describe in which situation this
> change would bring a benefit would help.
> 
>> Domains (PDs) return the same value, e.g. 10mW. The EAS compares these
>> values to choose smaller one. It might happen that this values are equal
>> due to rounding error. In such scenario, we need better precision, e.g.
>> 10000 times better. To provide this possibility increase the precision on
>> the em_perf_state::cost.
>>
>> This patch allows to avoid the rounding to milli-Watt errors, which might
>> occur in EAS energy estimation for each Performance Domains (PD). The
>> rounding error is common for small tasks which have small utilization
>> values.
> 
> What's the influence of the CPU utilization 'cpu_util_next()' here?
> 
> compute_energy()
>      em_cpu_energy()
>              return ps->cost * sum_util / scale_cpu
>                                ^^^^^^^^

This is the place where the rounding error triggers. If sum_util is
small and scale_cpu is e.g. 1024, then we have a small fraction here.
It depends on the EM 'cost', but for most platforms we have small
power and cost values, so we suffer this rounding.
The example that I gave in my response in patch 2/3 shows this.

>> The rest of the EM code doesn't change, em_perf_state::power is still
>> expressed in milli-Watts (or in abstract scale). Thus, all existing
>> platforms don't have to change their reported power. The same applies to
> 
> Not only existing platforms since there are no changes. So why
> highlighting `existing` here.?

I just wanted to be clear that it doesn't affect existing platforms
at all. We don't require to report power in better resolution e.g.
micro-Watts.
Also, the clients in the kernel won't be affected, since they use
EM 'power' filed, not 'cost'.
