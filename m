Return-Path: <linux-pm+bounces-35719-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C227BBD51E
	for <lists+linux-pm@lfdr.de>; Mon, 06 Oct 2025 10:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFC7A3AFEBA
	for <lists+linux-pm@lfdr.de>; Mon,  6 Oct 2025 08:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8B01EC01B;
	Mon,  6 Oct 2025 08:17:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BD51C3BE0;
	Mon,  6 Oct 2025 08:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759738647; cv=none; b=IJeGD/l3FNxpa1ckCpriQWt/b5QZM5/gxE4vs9SuWng0xEvqXw5MaZIxuFNJPKro4vtqTfof8iC0veAYEpS69AingHzvfCQEjE0pOdFR17fPhXN/7AAo/rklSjjWflUMopoyxt3ridXueauj1D9iqA9U0FtoIrUVKnqs2ARzPrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759738647; c=relaxed/simple;
	bh=91NGgeU0Lxk81ktZH9chiaamZ0sYOIN8XpLkLkr5/v0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GzQLqfH3THGEJiyRFQxYosCniwZAUUeUanolKqebjnGvnmhSek9e8R/3UGyJRZSAGIKNU7mYId2EHQYHZjhazmgtWf3rQYLrzysdXQ4Zg4f+KgBYgbOPBmjfnszbloQy23zgCbr6sVe0in7b1OX+5734/9DUP+fQHBZNdKSs8JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7862F1515;
	Mon,  6 Oct 2025 01:17:15 -0700 (PDT)
Received: from [10.57.81.187] (unknown [10.57.81.187])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BDA43F59E;
	Mon,  6 Oct 2025 01:17:21 -0700 (PDT)
Message-ID: <05359260-336f-4047-bc3a-003ace5ad7c4@arm.com>
Date: Mon, 6 Oct 2025 09:17:43 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4 01/10] PM: EM: Assign a unique ID when creating
 a performance domain
To: Changwoo Min <changwoo@igalia.com>
Cc: christian.loehle@arm.com, tj@kernel.org, pavel@kernel.org,
 len.brown@intel.com, rafael@kernel.org, kernel-dev@igalia.com,
 linux-pm@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250921031928.205869-1-changwoo@igalia.com>
 <20250921031928.205869-2-changwoo@igalia.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20250921031928.205869-2-changwoo@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Chanwoo,

My apologies to delay on this topic.

On 9/21/25 04:19, Changwoo Min wrote:
> It is necessary to refer to a specific performance domain from a
> userspace. For example, the energy model of a particular performance
> domain is updated.
> 
> To this end, assign a unique ID to each performance domain to address it,

Is this related to the sched_ext view on the EM that we cannot re-use
the allocated ID for the given domain?

> and manage them in a global linked list to look up a specific one by
> matching ID. IDA is used for ID assignment, and the mutex is used to
> protect the global list from concurrent access.
> 
> Note that the mutex (em_pd_list_mutex) is not supposed to hold while
> holding em_pd_mutex to avoid ABBA deadlock.

This might be tricky design, but I have seen in some other
patches you've added the lockdep, so we might have some safety net.

> 
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>   include/linux/energy_model.h |  4 ++++
>   kernel/power/energy_model.c  | 33 ++++++++++++++++++++++++++++++++-
>   2 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index 61d50571ad88..43aa6153dc57 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -54,6 +54,8 @@ struct em_perf_table {
>   /**
>    * struct em_perf_domain - Performance domain
>    * @em_table:		Pointer to the runtime modifiable em_perf_table
> + * @node:		node in	em_pd_list (in energy_model.c)
> + * @id:			A unique ID number for each performance domain
>    * @nr_perf_states:	Number of performance states
>    * @min_perf_state:	Minimum allowed Performance State index
>    * @max_perf_state:	Maximum allowed Performance State index
> @@ -71,6 +73,8 @@ struct em_perf_table {
>    */
>   struct em_perf_domain {
>   	struct em_perf_table __rcu *em_table;
> +	struct list_head node;
> +	int id;
>   	int nr_perf_states;
>   	int min_perf_state;
>   	int max_perf_state;
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 8df55397414a..3fe562b6230e 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -23,6 +23,16 @@
>    */
>   static DEFINE_MUTEX(em_pd_mutex);
>   
> +/*
> + * Manage performance domains with IDs. One can iterate the performance domains
> + * through the list and pick one with their associated ID. The mutex serializes
> + * the list access. When holding em_pd_list_mutex, em_pd_mutex should not be
> + * taken to avoid potential deadlock.
> + */
> +static DEFINE_IDA(em_pd_ida);
> +static LIST_HEAD(em_pd_list);
> +static DEFINE_MUTEX(em_pd_list_mutex);
> +
>   static void em_cpufreq_update_efficiencies(struct device *dev,
>   					   struct em_perf_state *table);
>   static void em_check_capacity_update(void);
> @@ -396,7 +406,7 @@ static int em_create_pd(struct device *dev, int nr_states,
>   	struct em_perf_table *em_table;
>   	struct em_perf_domain *pd;
>   	struct device *cpu_dev;
> -	int cpu, ret, num_cpus;
> +	int cpu, ret, num_cpus, id;
>   
>   	if (_is_cpu_device(dev)) {
>   		num_cpus = cpumask_weight(cpus);
> @@ -420,6 +430,13 @@ static int em_create_pd(struct device *dev, int nr_states,
>   
>   	pd->nr_perf_states = nr_states;
>   
> +	INIT_LIST_HEAD(&pd->node);
> +
> +	id = ida_alloc(&em_pd_ida, GFP_KERNEL);
> +	if (id < 0)
> +		return -ENOMEM;
> +	pd->id = id;
> +
>   	em_table = em_table_alloc(pd);
>   	if (!em_table)
>   		goto free_pd;
> @@ -444,6 +461,7 @@ static int em_create_pd(struct device *dev, int nr_states,
>   	kfree(em_table);
>   free_pd:
>   	kfree(pd);
> +	ida_free(&em_pd_ida, id);
>   	return -EINVAL;
>   }
>   
> @@ -660,6 +678,13 @@ int em_dev_register_pd_no_update(struct device *dev, unsigned int nr_states,
>   unlock:
>   	mutex_unlock(&em_pd_mutex);
>   
> +	if (_is_cpu_device(dev))
> +		em_check_capacity_update();
> +
> +	mutex_lock(&em_pd_list_mutex);
> +	list_add_tail(&dev->em_pd->node, &em_pd_list);
> +	mutex_unlock(&em_pd_list_mutex);
> +
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(em_dev_register_pd_no_update);
> @@ -678,6 +703,10 @@ void em_dev_unregister_perf_domain(struct device *dev)
>   	if (_is_cpu_device(dev))
>   		return;
>   
> +	mutex_lock(&em_pd_list_mutex);
> +	list_del_init(&dev->em_pd->node);
> +	mutex_unlock(&em_pd_list_mutex);
> +
>   	/*
>   	 * The mutex separates all register/unregister requests and protects
>   	 * from potential clean-up/setup issues in the debugfs directories.
> @@ -689,6 +718,8 @@ void em_dev_unregister_perf_domain(struct device *dev)
>   	em_table_free(rcu_dereference_protected(dev->em_pd->em_table,
>   						lockdep_is_held(&em_pd_mutex)));
>   
> +	ida_free(&em_pd_ida, dev->em_pd->id);
> +
>   	kfree(dev->em_pd);
>   	dev->em_pd = NULL;
>   	mutex_unlock(&em_pd_mutex);

Apart from that, the code itself looks sane.

Regards,
Lukasz

