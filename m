Return-Path: <linux-pm+bounces-2080-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 882A0829C02
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jan 2024 15:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACE491C20F53
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jan 2024 14:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414684A989;
	Wed, 10 Jan 2024 14:08:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57DB495EB;
	Wed, 10 Jan 2024 14:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 118B42F4;
	Wed, 10 Jan 2024 06:09:04 -0800 (PST)
Received: from [10.57.87.179] (unknown [10.57.87.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0653B3F5A1;
	Wed, 10 Jan 2024 06:08:15 -0800 (PST)
Message-ID: <da5d4f05-e188-46ae-ae6a-227e394356a6@arm.com>
Date: Wed, 10 Jan 2024 14:09:38 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/23] PM: EM: Add API for memory allocations for new
 tables
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 dietmar.eggemann@arm.com, rui.zhang@intel.com, amit.kucheria@verdurent.com,
 amit.kachhap@gmail.com, daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
 len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io,
 wvw@google.com
References: <20240104171553.2080674-1-lukasz.luba@arm.com>
 <20240104171553.2080674-11-lukasz.luba@arm.com>
 <CAJZ5v0grn7RHLxf0Bfxh-PtwvQXfr0F8bGc9bWDuuD3_noLjGw@mail.gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0grn7RHLxf0Bfxh-PtwvQXfr0F8bGc9bWDuuD3_noLjGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/4/24 19:35, Rafael J. Wysocki wrote:
> On Thu, Jan 4, 2024 at 6:15 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> The runtime modified EM table can be provided from drivers. Create
>> mechanism which allows safely allocate and free the table for device
>> drivers. The same table can be used by the EAS in task scheduler code
>> paths, so make sure the memory is not freed when the device driver module
>> is unloaded.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   include/linux/energy_model.h | 11 +++++++++
>>   kernel/power/energy_model.c  | 43 ++++++++++++++++++++++++++++++++++--
>>   2 files changed, 52 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
>> index 5f842da3bb0c..753d70d0ce7e 100644
>> --- a/include/linux/energy_model.h
>> +++ b/include/linux/energy_model.h
>> @@ -5,6 +5,7 @@
>>   #include <linux/device.h>
>>   #include <linux/jump_label.h>
>>   #include <linux/kobject.h>
>> +#include <linux/kref.h>
>>   #include <linux/rcupdate.h>
>>   #include <linux/sched/cpufreq.h>
>>   #include <linux/sched/topology.h>
>> @@ -39,10 +40,12 @@ struct em_perf_state {
>>   /**
>>    * struct em_perf_table - Performance states table
>>    * @rcu:       RCU used for safe access and destruction
>> + * @refcount:  Reference count to track the owners
> 
> "Reference counter to track the users"
> 
> Also it is not really just a counter - it provides the memory release
> mechanism too.

Agree

> 
>>    * @state:     List of performance states, in ascending order
>>    */
>>   struct em_perf_table {
>>          struct rcu_head rcu;
>> +       struct kref refcount;
> 
> So I would just call it kref.

OK

> 
>>          struct em_perf_state state[];
>>   };
>>
>> @@ -184,6 +187,8 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
>>                                  struct em_data_callback *cb, cpumask_t *span,
>>                                  bool microwatts);
>>   void em_dev_unregister_perf_domain(struct device *dev);
>> +struct em_perf_table __rcu *em_allocate_table(struct em_perf_domain *pd);
>> +void em_free_table(struct em_perf_table __rcu *table);
>>
>>   /**
>>    * em_pd_get_efficient_state() - Get an efficient performance state from the EM
>> @@ -365,6 +370,12 @@ static inline int em_pd_nr_perf_states(struct em_perf_domain *pd)
>>   {
>>          return 0;
>>   }
>> +static inline
>> +struct em_perf_table __rcu *em_allocate_table(struct em_perf_domain *pd)
>> +{
>> +       return NULL;
>> +}
>> +static inline void em_free_table(struct em_perf_table __rcu *table) {}
>>   #endif
>>
>>   #endif
>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>> index c03010084208..bbc406db0be1 100644
>> --- a/kernel/power/energy_model.c
>> +++ b/kernel/power/energy_model.c
>> @@ -114,12 +114,46 @@ static void em_destroy_table_rcu(struct rcu_head *rp)
>>          kfree(table);
>>   }
>>
>> -static void em_free_table(struct em_perf_table __rcu *table)
>> +static void em_release_table_kref(struct kref *kref)
>>   {
>> +       struct em_perf_table __rcu *table;
>> +
>> +       /* It was the last owner of this table so we can free */
>> +       table = container_of(kref, struct em_perf_table, refcount);
>> +
>>          call_rcu(&table->rcu, em_destroy_table_rcu);
>>   }
>>
>> -static struct em_perf_table __rcu *
>> +static inline void em_table_inc(struct em_perf_table __rcu *table)
> 
> Why not em_table_get()?

I will change that...

> 
>> +{
>> +       kref_get(&table->refcount);
>> +}
>> +
>> +static void em_table_dec(struct em_perf_table __rcu *table)
> 
> And em_table_put() here?

and this as well.

> 
> Note that I do realize that the "put" and "get" terminology is used in
> one of the subsequent patches - I'll get to it later.
> 
>> +{
>> +       kref_put(&table->refcount, em_release_table_kref);
>> +}
>> +
>> +/**
>> + * em_free_table() - Handles safe free of the EM table when needed
>> + * @table : EM memory which is going to be freed
>> + *
>> + * No return values.
>> + */
>> +void em_free_table(struct em_perf_table __rcu *table)
>> +{
>> +       em_table_dec(table);
>> +}
> 
> Why is this necessary?  The function called by it could be extern
> instead and wrapped into a static inline wrapper in a header (if you
> really need the alias).

Sounds good, I'll change it.

> 
>> +
>> +/**
>> + * em_allocate_table() - Handles safe allocation of the new EM table
> 
> " - Allocate a new EM table"

OK

> 
> And I would call this em_table_alloc() and (maybe) add an
> em_table_free() alias for em_table_put().

OK

> 
>> + * @table : EM memory which is going to be freed
> 
> So the argument is called "pd" and it is not a table.  It is also used
> for computing the size of the new table AFAICS.

True, good catch.

> 
>> + *
>> + * Increments the reference counter to mark that there is an owner of that
> 
> "Allocate a new EM table and initialize its kref to indicate that it
> has a user."

OK

> 
>> + * EM table. That might be a device driver module or EAS.
>> + * Returns allocated table or error.
>> + */
>> +struct em_perf_table __rcu *
>>   em_allocate_table(struct em_perf_domain *pd)
>>   {
>>          struct em_perf_table __rcu *table;
>> @@ -128,6 +162,11 @@ em_allocate_table(struct em_perf_domain *pd)
>>          table_size = sizeof(struct em_perf_state) * pd->nr_perf_states;
>>
>>          table = kzalloc(sizeof(*table) + table_size, GFP_KERNEL);
>> +       if (!table)
>> +               return table;
> 
> I would return NULL from here explicitly.

OK

> 
>> +
>> +       kref_init(&table->refcount);
>> +
>>          return table;
>>   }
>>
>> --

