Return-Path: <linux-pm+bounces-23544-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F08A5462B
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 10:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8FCC3AE6B1
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 09:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F09019CCFC;
	Thu,  6 Mar 2025 09:22:50 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9843D3D68;
	Thu,  6 Mar 2025 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741252970; cv=none; b=cOH5jtZCPDmnUwjy3I+jHSa6BxdiEJjIDXZ8Bn2EqeXsirPggIw0Y6Vu5LNzrKaGjVGuP3JtnanfltXpzfziTb2qXKZ7ULTkg8yfNqH7QGqW6Wt5aFUg2SYo83zIjNhdy5ByFQi3WFtNLUCO4pPTx7D52No+o0SpC9fawRUqjIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741252970; c=relaxed/simple;
	bh=IdoNQjVtAHqJey1aYxsMjH24LlhppEYBJRnQo0p6aUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fi8yYazca7UrrHeZpcY1xBbIKW5PdgwyqH+cgqY+oum0jxVIHl8gFiLf+h1BCrtncp1qc1UH+usJpDNmMrbV2SejgIUA1CnGqYop6ozD+y6XGGHtD32BiF4BHJHKFV+l8wMlHQF3HcwbM6eh6ZgIa0JOewV9jLbhan9feWQ5CAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF1E4FEC;
	Thu,  6 Mar 2025 01:22:59 -0800 (PST)
Received: from [10.57.83.26] (unknown [10.57.83.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E1DF3F673;
	Thu,  6 Mar 2025 01:22:45 -0800 (PST)
Message-ID: <9a9bdf37-1462-4aca-b513-268b4f2b235c@arm.com>
Date: Thu, 6 Mar 2025 09:22:43 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] PM: EM: Consify two parameters of
 em_dev_register_perf_domain()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Linux PM <linux-pm@vger.kernel.org>
References: <5880743.DvuYhMxLoT@rjwysocki.net>
 <4648962.LvFx2qVVIh@rjwysocki.net>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <4648962.LvFx2qVVIh@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/5/25 21:08, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Notice that em_dev_register_perf_domain() and the functions called by it
> do not update objects pointed to by its cb and cpus parameters, so the
> const modifier can be added to them.
> 
> This allows the return value of cpumask_of() or a pointer to a
> struct em_data_callback declared as const to be passed to
> em_dev_register_perf_domain() directly without explicit type
> casting which is rather handy.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   include/linux/energy_model.h |    8 ++++----
>   kernel/power/energy_model.c  |   11 ++++++-----
>   2 files changed, 10 insertions(+), 9 deletions(-)
> 
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -169,8 +169,8 @@
>   int em_dev_update_perf_domain(struct device *dev,
>   			      struct em_perf_table __rcu *new_table);
>   int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
> -				struct em_data_callback *cb, cpumask_t *span,
> -				bool microwatts);
> +				const struct em_data_callback *cb,
> +				const cpumask_t *cpus, bool microwatts);
>   void em_dev_unregister_perf_domain(struct device *dev);
>   struct em_perf_table __rcu *em_table_alloc(struct em_perf_domain *pd);
>   void em_table_free(struct em_perf_table __rcu *table);
> @@ -346,8 +346,8 @@
>   
>   static inline
>   int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
> -				struct em_data_callback *cb, cpumask_t *span,
> -				bool microwatts)
> +				const struct em_data_callback *cb,
> +				const cpumask_t *cpus, bool microwatts)
>   {
>   	return -EINVAL;
>   }
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -231,7 +231,7 @@
>   }
>   
>   static int em_compute_costs(struct device *dev, struct em_perf_state *table,
> -			    struct em_data_callback *cb, int nr_states,
> +			    const struct em_data_callback *cb, int nr_states,
>   			    unsigned long flags)
>   {
>   	unsigned long prev_cost = ULONG_MAX;
> @@ -333,7 +333,7 @@
>   
>   static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
>   				struct em_perf_state *table,
> -				struct em_data_callback *cb,
> +				const struct em_data_callback *cb,
>   				unsigned long flags)
>   {
>   	unsigned long power, freq, prev_freq = 0;
> @@ -388,7 +388,8 @@
>   }
>   
>   static int em_create_pd(struct device *dev, int nr_states,
> -			struct em_data_callback *cb, cpumask_t *cpus,
> +			const struct em_data_callback *cb,
> +			const cpumask_t *cpus,
>   			unsigned long flags)
>   {
>   	struct em_perf_table __rcu *em_table;
> @@ -548,8 +549,8 @@
>    * Return 0 on success
>    */
>   int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
> -				struct em_data_callback *cb, cpumask_t *cpus,
> -				bool microwatts)
> +				const struct em_data_callback *cb,
> +				const cpumask_t *cpus, bool microwatts)
>   {
>   	unsigned long cap, prev_cap = 0;
>   	unsigned long flags = 0;
> 
> 
> 

LGTM,

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

