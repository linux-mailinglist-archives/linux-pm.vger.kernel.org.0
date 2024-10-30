Return-Path: <linux-pm+bounces-16723-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A73BD9B623B
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 12:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52D371F21E1E
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 11:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4A81E571F;
	Wed, 30 Oct 2024 11:49:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275581DC759;
	Wed, 30 Oct 2024 11:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730288989; cv=none; b=I0b7zDnbYAOXn1pl9rBwtKbWi8Ib0QHRK11Aq6ZevsEr0eCOrRTEp1M89VeIlpE834bKRXLv05IbbBRdqwCLH5fNDeJUytllEQDw9ezCoEDhwcJ/1HYXog7HPVt1phG8+OZGfV5i8Q2Znt9gFrtFJ05aa3MdtI7eZqQKXYVdms4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730288989; c=relaxed/simple;
	bh=UwzFLOS1OD/Sl8K2cn4QESITJVZRa2vCSspDyTtIels=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VOMwidWKSroS4Gbloq2uXKHPRnbtTO/Kajl9znJGqyjOH3s2cz40IixLjRxrZctaGHIC6xyd/uItASfR3QmfoY8mDwxv1tq8cy1D3hBWp5imIsLPZVkIk7t9Om4hdCw0HcrE6MAH4glwnG4GUVVYYe7aFQ3MaMRNVesik+0p7R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E6D8113E;
	Wed, 30 Oct 2024 04:50:14 -0700 (PDT)
Received: from [10.57.58.72] (unknown [10.57.58.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A55503F73B;
	Wed, 30 Oct 2024 04:49:43 -0700 (PDT)
Message-ID: <96e694e3-2a65-4f39-ad35-3d1e1459102f@arm.com>
Date: Wed, 30 Oct 2024 11:50:57 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] PM: EM: Add min/max available performance state
 limits
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 dietmar.eggemann@arm.com
References: <20241029094452.495439-1-lukasz.luba@arm.com>
 <20241029094452.495439-2-lukasz.luba@arm.com>
 <CAJZ5v0jOYw6md9tnb1d=pQ_u06=rSiZ6FAEk1iaN47TO0w+XZQ@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0jOYw6md9tnb1d=pQ_u06=rSiZ6FAEk1iaN47TO0w+XZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/30/24 11:40, Rafael J. Wysocki wrote:
> On Tue, Oct 29, 2024 at 10:43 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> On some devices there are HW dependencies for shared frequency and voltage
>> between devices. It will impact Energy Aware Scheduler (EAS) decision,
>> where CPUs share the voltage & frequency domain with other CPUs or devices
>> e.g.
>> - Mid CPUs + Big CPU
>> - Little CPU + L3 cache in DSU
>> - some other device + Little CPUs
>>
>> Detailed explanation of one example:
>> When the L3 cache frequency is increased, the affected Little CPUs might
>> run at higher voltage and frequency. That higher voltage causes higher CPU
>> power and thus more energy is used for running the tasks. This is
>> important for background running tasks, which try to run on energy
>> efficient CPUs.
>>
>> Therefore, add performance state limits which are applied for the device
>> (in this case CPU). This is important on SoCs with HW dependencies
>> mentioned above so that the Energy Aware Scheduler (EAS) does not use
>> performance states outside the valid min-max range for energy calculation.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   include/linux/energy_model.h | 24 ++++++++++++++---
>>   kernel/power/energy_model.c  | 52 ++++++++++++++++++++++++++++++++++++
>>   2 files changed, 72 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
>> index 1ff52020cf757..e83bf230e18d1 100644
>> --- a/include/linux/energy_model.h
>> +++ b/include/linux/energy_model.h
>> @@ -55,6 +55,8 @@ struct em_perf_table {
>>    * struct em_perf_domain - Performance domain
>>    * @em_table:          Pointer to the runtime modifiable em_perf_table
>>    * @nr_perf_states:    Number of performance states
>> + * @min_ps:            Minimum allowed Performance State index
>> + * @max_ps:            Maximum allowed Performance State index
> 
> Any problem with renaming these to min_perf_state and max_perf_state
> respectively?

OK, I will change those names.

> 
> That would improve the code clarity quite a bit IMV.
> 

[snip]

>>   static inline int
>>   em_pd_get_efficient_state(struct em_perf_state *table, int nr_perf_states,
>> -                         unsigned long max_util, unsigned long pd_flags)
>> +                         unsigned long max_util, unsigned long pd_flags,
>> +                         int min_ps, int max_ps)
>>   {
>>          struct em_perf_state *ps;
>>          int i;
>>
>> -       for (i = 0; i < nr_perf_states; i++) {
>> +       for (i = min_ps; i <= max_ps; i++) {
>>                  ps = &table[i];
>>                  if (ps->performance >= max_util) {
>>                          if (pd_flags & EM_PERF_DOMAIN_SKIP_INEFFICIENCIES &&
>> @@ -204,7 +213,7 @@ em_pd_get_efficient_state(struct em_perf_state *table, int nr_perf_states,
>>                  }
>>          }
>>
>> -       return nr_perf_states - 1;
>> +       return max_ps;
>>   }
>>
>>   /**
>> @@ -254,7 +263,8 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>>           */
>>          em_table = rcu_dereference(pd->em_table);
>>          i = em_pd_get_efficient_state(em_table->state, pd->nr_perf_states,
>> -                                     max_util, pd->flags);
>> +                                     max_util, pd->flags, pd->min_ps,
>> +                                     pd->max_ps);
> 
> Couldn't em_pd_get_efficient_state() just take pd as an argument and
> dereference it by itself?
> 
> The code would be much easier to follow then.

That's possible. I will keep the em_table rcu_dereference as is, so
only the rest of arguments with 'pd->' will be taken inside
em_pd_get_efficient_state().

So the call would look like:
em_pd_get_efficient_state(em_table->state, pd, max_util);


Thanks for the review. I will send a v3.

