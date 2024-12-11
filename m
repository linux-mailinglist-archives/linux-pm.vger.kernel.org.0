Return-Path: <linux-pm+bounces-18996-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7660B9ECA5B
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 11:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894E52831E9
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 10:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86267211A08;
	Wed, 11 Dec 2024 10:32:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852C37080E;
	Wed, 11 Dec 2024 10:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733913138; cv=none; b=EU+7GAmMOKAZpx230NkdDUghtzOoCHRXQgqj84H3bo8jNU6JEbb+sV42DWbi0XOahdffWuyIqelI3k5huADSw1oaLdAsK0cnHcGRK36sHyVkpYbjdX//WSw4bX7SJpgEudRUXBNQfX5xLA4Ccp2o7BBOnmS5Bm2GfZS83QAkv2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733913138; c=relaxed/simple;
	bh=STzh6WEM1fq0QQhRzf22g0yvKjAPNiZGPXUjdBp6f4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hxru3eV5YUul1Rmo4yrawlUi5eqCFXe3h+FIvKWcqRfLK5KheCwn2EyHH+uAJ2mSr7RP8Mm5H7pvc25xXI0+CSTUluQEtOE3+9DfhDzgBNeWcVeJC6bo9TgTjxi5KH00PUFJba6vkZpWhZOuWe5ifqKDVNHusgdu4NGG1NOPVDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D370F1063;
	Wed, 11 Dec 2024 02:32:42 -0800 (PST)
Received: from [10.1.37.59] (e127648.arm.com [10.1.37.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E56873F720;
	Wed, 11 Dec 2024 02:32:12 -0800 (PST)
Message-ID: <76c73761-a8ce-4f30-8eed-2a4a4061b8ca@arm.com>
Date: Wed, 11 Dec 2024 10:32:10 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v021 3/9] PM: EM: Move perf rebuilding function from
 schedutil to EM
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>
References: <5861970.DvuYhMxLoT@rjwysocki.net>
 <2229205.irdbgypaU6@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <2229205.irdbgypaU6@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/29/24 15:59, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The sugov_eas_rebuild_sd() function defined in the schedutil cpufreq
> governor implements generic functionality that may be useful in other
> places.  In particular, going forward it will be used in the intel_pstate
> driver.
> 
> For this reason, move it from schedutil to the energy model code and
> rename it to em_rebuild_perf_domains().
> 
> This also helps to get rid of some #ifdeffery in schedutil which is a
> plus.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v0.1 -> v0.2:
>      * Update the comment regarding :register_em() in cpufreq.
>      * Changelog edits.
> 
> ---
>  drivers/cpufreq/cpufreq.c        |    2 +-
>  include/linux/energy_model.h     |    2 ++
>  kernel/power/energy_model.c      |   17 +++++++++++++++++
>  kernel/sched/cpufreq_schedutil.c |   33 ++++++---------------------------
>  4 files changed, 26 insertions(+), 28 deletions(-)
> 
> Index: linux-pm/kernel/power/energy_model.c
> ===================================================================
> --- linux-pm.orig/kernel/power/energy_model.c
> +++ linux-pm/kernel/power/energy_model.c
> @@ -908,3 +908,20 @@ int em_update_performance_limits(struct
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(em_update_performance_limits);
> +
> +static void rebuild_sd_workfn(struct work_struct *work)
> +{
> +	rebuild_sched_domains_energy();
> +}
> +
> +static DECLARE_WORK(rebuild_sd_work, rebuild_sd_workfn);
> +
> +void em_rebuild_perf_domains(void)
> +{
> +	/*
> +	 * When called from the cpufreq_register_driver() path, the
> +	 * cpu_hotplug_lock is already held, so use a work item to
> +	 * avoid nested locking in rebuild_sched_domains().
> +	 */
> +	schedule_work(&rebuild_sd_work);
> +}
> Index: linux-pm/kernel/sched/cpufreq_schedutil.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
> +++ linux-pm/kernel/sched/cpufreq_schedutil.c
> @@ -604,31 +604,6 @@ static const struct kobj_type sugov_tuna
>  
>  /********************** cpufreq governor interface *********************/
>  
> -#ifdef CONFIG_ENERGY_MODEL
> -static void rebuild_sd_workfn(struct work_struct *work)
> -{
> -	rebuild_sched_domains_energy();
> -}
> -
> -static DECLARE_WORK(rebuild_sd_work, rebuild_sd_workfn);
> -
> -/*
> - * EAS shouldn't be attempted without sugov, so rebuild the sched_domains
> - * on governor changes to make sure the scheduler knows about it.
> - */
> -static void sugov_eas_rebuild_sd(void)
> -{
> -	/*
> -	 * When called from the cpufreq_register_driver() path, the
> -	 * cpu_hotplug_lock is already held, so use a work item to
> -	 * avoid nested locking in rebuild_sched_domains().
> -	 */
> -	schedule_work(&rebuild_sd_work);
> -}
> -#else
> -static inline void sugov_eas_rebuild_sd(void) { };
> -#endif
> -
>  struct cpufreq_governor schedutil_gov;
>  
>  static struct sugov_policy *sugov_policy_alloc(struct cpufreq_policy *policy)
> @@ -784,7 +759,11 @@ static int sugov_init(struct cpufreq_pol
>  		goto fail;
>  
>  out:
> -	sugov_eas_rebuild_sd();
> +	/*
> +	 * EAS shouldn't be attempted without sugov, so rebuild the sched_domains
> +	 * on governor changes to make sure the scheduler knows about them.
> +	 */
> +	em_rebuild_perf_domains();

The sugov mention might be considered stale after the next patch?
Apart from that LGTM.


