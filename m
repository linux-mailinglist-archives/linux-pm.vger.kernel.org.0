Return-Path: <linux-pm+bounces-26299-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B9FA9E370
	for <lists+linux-pm@lfdr.de>; Sun, 27 Apr 2025 16:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3635C3BD74C
	for <lists+linux-pm@lfdr.de>; Sun, 27 Apr 2025 14:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD26FBF6;
	Sun, 27 Apr 2025 14:07:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3551AC88A;
	Sun, 27 Apr 2025 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745762844; cv=none; b=XNJ0lWkOaj6x/Xgj5lJ7d8FQiM/Im1W2EmzzMYuk4/7+oZxHfpouo4a3+dTdHZWkw91EgKpb1ZgRCiTVUvudohdsLxQk4sP0J3vM4D+pjmIGi5G1B54JM+G2hKq5yeZ/Gim7yE7UIuPw4/SsBmqYXVghh6pob9wmI7Gd0UjhApM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745762844; c=relaxed/simple;
	bh=/NuX/kzXUHNm5l65ud/S9tlUN73pCHMwQuH34Z/ek18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=szowrwvzDZvyTfBZB9dE5jwdEigVMEu5kDuD5hEfSiFenyocesVIZ9HoBK+asJPoRGozTZstijv2r+hv6m+fkt24FgbzMufRN4sXqDxDXT+IoEnrqP1hMMzTsbAhhLtWPMEEDsM6jCNwccwgVJWOI+W7lPh5Y0wlCuqGEz4zexU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DF12106F;
	Sun, 27 Apr 2025 07:01:40 -0700 (PDT)
Received: from [192.168.2.88] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A5F03F66E;
	Sun, 27 Apr 2025 07:01:44 -0700 (PDT)
Message-ID: <61cd69f5-6790-4480-8fe7-77ef763ed82b@arm.com>
Date: Sun, 27 Apr 2025 16:01:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT][PATCH v1 5/8] PM: EM: Introduce em_adjust_cpu_capacity()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Christian Loehle <christian.loehle@arm.com>
References: <3344336.aeNJFYEL58@rjwysocki.net>
 <2649447.Lt9SDvczpP@rjwysocki.net>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <2649447.Lt9SDvczpP@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/04/2025 20:06, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add a function for updating the Energy Model for a CPU after its
> capacity has changed, which subsequently will be used by the
> intel_pstate driver.
> 
> An EM_PERF_DOMAIN_ARTIFICIAL check is added to em_adjust_new_capacity()
> to prevent it from calling em_compute_costs() for an "artificial" perf
> domain with a NULL cb parameter which would cause it to crash.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
> 
> v0.3 -> v1:
>      * Added R-by from Lukasz.
> 
> ---
>  include/linux/energy_model.h |    2 ++
>  kernel/power/energy_model.c  |   28 ++++++++++++++++++++++++----
>  2 files changed, 26 insertions(+), 4 deletions(-)
> 
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -179,6 +179,7 @@
>  int em_dev_update_chip_binning(struct device *dev);
>  int em_update_performance_limits(struct em_perf_domain *pd,
>  		unsigned long freq_min_khz, unsigned long freq_max_khz);
> +void em_adjust_cpu_capacity(unsigned int cpu);
>  void em_rebuild_sched_domains(void);
>  
>  /**
> @@ -405,6 +406,7 @@
>  {
>  	return -EINVAL;
>  }
> +static inline void em_adjust_cpu_capacity(unsigned int cpu) {}
>  static inline void em_rebuild_sched_domains(void) {}
>  #endif
>  
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -698,10 +698,12 @@
>  {
>  	int ret;
>  
> -	ret = em_compute_costs(dev, em_table->state, NULL, pd->nr_perf_states,
> -			       pd->flags);
> -	if (ret)
> -		goto free_em_table;
> +	if (!(pd->flags & EM_PERF_DOMAIN_ARTIFICIAL)) {

This looks weird to me. How can an artificial EM ever have a non-ZERO
em_data_callback here?

There is already EM_PERF_DOMAIN_ARTIFICIAL specific handling in
em_compute_costs(). Which probably works well for the
em_create_perf_table() call-site.

Will there be cases for Hybrid CPU EM's in which 'em_max_perf !=
cpu_capacity':

em_adjust_new_capacity()

  if (em_max_perf == cpu_capacity)
    return

  em_recalc_and_update()
    em_compute_costs()

so that em_compute_costs() might be called?

Maybe:

@@ -233,11 +237,17 @@ static int em_compute_costs(struct device *dev,
struct em_perf_state *table,
        unsigned long prev_cost = ULONG_MAX;
        int i, ret;

+       if (!cb && (flags & EM_PERF_DOMAIN_ARTIFICIAL))
+               return 0;

is somehow clearer in this case?

[...]

