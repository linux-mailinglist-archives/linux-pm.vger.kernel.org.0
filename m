Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D72A3BE41B
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 10:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhGGILz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jul 2021 04:11:55 -0400
Received: from foss.arm.com ([217.140.110.172]:59318 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230398AbhGGILy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Jul 2021 04:11:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99274ED1;
        Wed,  7 Jul 2021 01:09:14 -0700 (PDT)
Received: from [10.57.1.129] (unknown [10.57.1.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B20833F694;
        Wed,  7 Jul 2021 01:09:11 -0700 (PDT)
Subject: Re: [PATCH 2/3] PM: EM: Make em_cpu_energy() able to return bigger
 values
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Chris.Redpath@arm.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, vincent.guittot@linaro.org,
        mingo@redhat.com, juri.lelli@redhat.com, rostedt@goodmis.org,
        segall@google.com, mgorman@suse.de, bristot@redhat.com,
        CCj.Yeh@mediatek.com
References: <20210625152603.25960-1-lukasz.luba@arm.com>
 <20210625152603.25960-3-lukasz.luba@arm.com>
 <YOVSu08LpHX5cx/+@hirez.programming.kicks-ass.net>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <ca9853d1-5ff2-bdac-7581-61bffa3fdaaa@arm.com>
Date:   Wed, 7 Jul 2021 09:09:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <YOVSu08LpHX5cx/+@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/7/21 8:07 AM, Peter Zijlstra wrote:
> On Fri, Jun 25, 2021 at 04:26:02PM +0100, Lukasz Luba wrote:
>> The Energy Model (EM) em_cpu_energy() is responsible for providing good
>> estimation regarding CPUs energy. It contains proper data structures which
>> are then used during calculation. The values stored in there are in
>> milli-Watts precision (or in abstract scale) smaller that 0xffff, which use
>> sufficient unsigned long even on 32-bit machines. There are scenarios where
>> we would like to provide calculated estimations in a better precision and
>> the values might be 1000 times bigger. This patch makes possible to use
>> quite big values for also 32-bit machines.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   include/linux/energy_model.h | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
>> index 3f221dbf5f95..2016f5a706e0 100644
>> --- a/include/linux/energy_model.h
>> +++ b/include/linux/energy_model.h
>> @@ -101,7 +101,7 @@ void em_dev_unregister_perf_domain(struct device *dev);
>>    * Return: the sum of the energy consumed by the CPUs of the domain assuming
>>    * a capacity state satisfying the max utilization of the domain.
>>    */
>> -static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>> +static inline u64 em_cpu_energy(struct em_perf_domain *pd,
>>   				unsigned long max_util, unsigned long sum_util,
>>   				unsigned long allowed_cpu_cap)
>>   {
>> @@ -180,7 +180,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>>   	 *   pd_nrg = ------------------------                       (4)
>>   	 *                  scale_cpu
>>   	 */
>> -	return ps->cost * sum_util / scale_cpu;
>> +	return div_u64((u64)ps->cost * sum_util, scale_cpu);
> 
> So these patches are all rather straight forward, however.. the above is
> pretty horrific on a 32bit box, and we do quite a few of them per
> wakeup. Is this really worth the performance penalty on 32bit CPUs?

True, for 2 cluster SoC we might do this 5 times (or less, depends on
system state). We don't have new 32bit big.LITTLE platforms, the newest
is ~7years old and is actually the only one using EAS. It's not put
into new devices AFAIK.

> 
> Do you really still care about 32bit CPUs, or is this mostly an artifact
> of wanting to unconditionally increase the precision?
> 

We discussed this internally and weighted the 32bit old big.little.

There is a solution, but needs more work and a lot of changes in the
whole kernel due to modified EM (affects IPA, DTPM, registration, ...).

I have been working on a next step for code that you've pointed:
get rid of this runtime division.
It would be possible to pre-calculate the:
'ps->cost / scale_cpu' at the moment when EM is registered and store
it in the ps->cost. So we would have just:
return ps->cost * sum_util

The only issue is a late boot of biggest cores, which would destroy
the old scale_cpu values for other PDs. I need to probably add
RCU locking into the EM and update the other PDs' EMs when
the last biggest CPU boots after a few second and registers its
EM.

For now we would live with this simple code which improves
all recent 64bit platforms and is easy to take it into Android
common kernel. The next step would be more scattered across
other subsystems, so harder to backport to Android 5.4 and others.
