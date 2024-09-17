Return-Path: <linux-pm+bounces-14379-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7657897B54D
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 23:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32CEB281F51
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 21:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD22918DF78;
	Tue, 17 Sep 2024 21:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IWphPGPh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2C91531C5;
	Tue, 17 Sep 2024 21:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726609080; cv=none; b=mJOM1f0W7LKcCRzp6LAQUBz8QjvM2bccbNcmUMcKYbWAy5EJFONNenX8H757ZgWFiaDn23++IT5ror9reM8jOv/9euo705nyYquDQlPMujfjkvIFF+Ls35xH4vMmwNCwS/h2kXfMsZo0yHPOdiJTR5y/iJSN7BC2sLDnKrJ7cG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726609080; c=relaxed/simple;
	bh=r4yu7OaAkw2nHJ5m2iWzbbbfoy+QdCsQhP0wHKG9pyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NID6YwyY8d2Y1OdK+ekWNQLoy8dij6OA75GmO69yPdGl/3Mz55+qXgFZ8l/SX+yJQDMalWQX4ha3Tu8RhABVfcyDFRV3/pvPcfi/HQsedLCFnEBiBeMgH/zLWOchoXWkZIGj4ZvNLtqiATiEXM9yvMcdrTKeVxFW5rPjbJMkYdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IWphPGPh; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726609078; x=1758145078;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r4yu7OaAkw2nHJ5m2iWzbbbfoy+QdCsQhP0wHKG9pyw=;
  b=IWphPGPhURbjathUSkcE5b4OwyGgxz+f6qzJ4J++CgwxHYMNjET3LkvT
   YzzcgmnMaAoprQ37Ho2gUtL9GJh4PGt0GRp4GnT698EkiCkb//xgHMA16
   TTL80GK/zvTtntbo5qn2CBeej8K0WIrTSfoxhR4/MZXNjIp7A+IzmO9Fu
   LPjZ3kJ2xg9Dl8OnoKVNjlhu2uGViwNMvcuOarigqzW6UEirp/OXmqk3c
   qHwTOIe09NQK11aZkvlwBhB/48zt5xemGor/68z9uVZ81PiJLF/eX3a4I
   POxuPvMvfEHjj8N2v2YMccqAuWVqoFOZCyn/Es7BOKQeHCdMPsJmumd8C
   g==;
X-CSE-ConnectionGUID: gM9CNxzQTuaX8+qnJLgaOQ==
X-CSE-MsgGUID: sxPmm42lQiqC8pQWeWEXfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="25379339"
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="25379339"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 14:37:58 -0700
X-CSE-ConnectionGUID: he5jR1jZScmWRbBMkc2/og==
X-CSE-MsgGUID: lIFX4D4WSTSNW9zy31G0Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="73424010"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 14:37:57 -0700
Date: Tue, 17 Sep 2024 14:43:37 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 11/16] sched/qos: Add rampup multiplier QoS
Message-ID: <20240917214337.GA10143@ranerica-svr.sc.intel.com>
References: <20240820163512.1096301-1-qyousef@layalina.io>
 <20240820163512.1096301-12-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820163512.1096301-12-qyousef@layalina.io>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Tue, Aug 20, 2024 at 05:35:07PM +0100, Qais Yousef wrote:
> Bursty tasks are hard to predict. To use resources efficiently, the
> system would like to be exact as much as possible. But this poses
> a challenge for these bursty tasks that need to get access to more
> resources quickly.
> 
> The new SCHED_QOS_RAMPUP_MULTIPLIER allows userspace to do that. As the
> name implies, it only helps them to transition to a higher performance
> state when they get _busier_. That is perfectly periodic tasks by
> definition are not going through a transition and will run at a constant
> performance level. It is the tasks that need to transition from one
> periodic state to another periodic state that is at a higher level that
> this rampup_multiplier will help with. It also slows down the ewma decay
> of util_est which should help those bursty tasks to keep their faster
> rampup.
> 
> This should work complimentary with uclamp. uclamp tells the system
> about min and max perf requirements which can be applied immediately.
> 
> rampup_multiplier is about reactiveness of the task to change.
> Specifically to a change for a higher performance level. The task might
> necessary need to have a min perf requirements, but it can have sudden
> burst of changes that require higher perf level and it needs the system
> to provide this faster.
> 
> TODO: update the sched_qos docs
> 
> Signed-off-by: Qais Yousef <qyousef@layalina.io>
> ---
>  include/linux/sched.h      |  7 ++++
>  include/uapi/linux/sched.h |  2 ++
>  kernel/sched/core.c        | 66 ++++++++++++++++++++++++++++++++++++++
>  kernel/sched/fair.c        |  6 ++--
>  kernel/sched/syscalls.c    | 38 ++++++++++++++++++++--
>  5 files changed, 115 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 2e8c5a9ffa76..a30ee43a25fb 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -404,6 +404,11 @@ struct sched_info {
>  #endif /* CONFIG_SCHED_INFO */
>  };
>  
> +struct sched_qos {
> +	DECLARE_BITMAP(user_defined, SCHED_QOS_MAX);
> +	unsigned int rampup_multiplier;
> +};
> +
>  /*
>   * Integer metrics need fixed point arithmetic, e.g., sched/fair
>   * has a few: load, load_avg, util_avg, freq, and capacity.
> @@ -882,6 +887,8 @@ struct task_struct {
>  
>  	struct sched_info		sched_info;
>  
> +	struct sched_qos		sched_qos;
> +
>  	struct list_head		tasks;
>  #ifdef CONFIG_SMP
>  	struct plist_node		pushable_tasks;
> diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> index 67ef99f64ddc..0baba91ba5b8 100644
> --- a/include/uapi/linux/sched.h
> +++ b/include/uapi/linux/sched.h
> @@ -104,6 +104,8 @@ struct clone_args {
>  };
>  
>  enum sched_qos_type {
> +	SCHED_QOS_RAMPUP_MULTIPLIER,
> +	SCHED_QOS_MAX,
>  };
>  #endif
>  
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index c91e6a62c7ab..54faa845cb29 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -152,6 +152,8 @@ __read_mostly int sysctl_resched_latency_warn_once = 1;
>   */
>  const_debug unsigned int sysctl_sched_nr_migrate = SCHED_NR_MIGRATE_BREAK;
>  
> +unsigned int sysctl_sched_qos_default_rampup_multiplier	= 1;
> +
>  __read_mostly int scheduler_running;
>  
>  #ifdef CONFIG_SCHED_CORE
> @@ -4488,6 +4490,47 @@ static int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
>  #endif /* CONFIG_SCHEDSTATS */
>  
>  #ifdef CONFIG_SYSCTL
> +static void sched_qos_sync_sysctl(void)
> +{
> +	struct task_struct *g, *p;
> +
> +	guard(rcu)();
> +	for_each_process_thread(g, p) {
> +		struct rq_flags rf;
> +		struct rq *rq;
> +
> +		rq = task_rq_lock(p, &rf);
> +		if (!test_bit(SCHED_QOS_RAMPUP_MULTIPLIER, p->sched_qos.user_defined))
> +			p->sched_qos.rampup_multiplier = sysctl_sched_qos_default_rampup_multiplier;
> +		task_rq_unlock(rq, p, &rf);
> +	}
> +}
> +
> +static int sysctl_sched_qos_handler(struct ctl_table *table, int write,
> +				    void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	unsigned int old_rampup_mult;
> +	int result;
> +
> +	old_rampup_mult = sysctl_sched_qos_default_rampup_multiplier;
> +
> +	result = proc_dointvec(table, write, buffer, lenp, ppos);
> +	if (result)
> +		goto undo;
> +	if (!write)
> +		return 0;
> +
> +	if (old_rampup_mult != sysctl_sched_qos_default_rampup_multiplier) {
> +		sched_qos_sync_sysctl();
> +	}
> +
> +	return 0;
> +
> +undo:
> +	sysctl_sched_qos_default_rampup_multiplier = old_rampup_mult;
> +	return result;
> +}
> +
>  static struct ctl_table sched_core_sysctls[] = {
>  #ifdef CONFIG_SCHEDSTATS
>  	{
> @@ -4534,6 +4577,13 @@ static struct ctl_table sched_core_sysctls[] = {
>  		.extra2		= SYSCTL_FOUR,
>  	},
>  #endif /* CONFIG_NUMA_BALANCING */
> +	{
> +		.procname	= "sched_qos_default_rampup_multiplier",
> +		.data           = &sysctl_sched_qos_default_rampup_multiplier,
> +		.maxlen         = sizeof(unsigned int),

IIUC, user space needs to select a value between 0 and (2^32 - 1). Does
this mean that it will need fine-tuning for each product and application?

Could there be some translation to a fewer number of QoS levels that are
qualitatively?

Also, I think about Intel processors. They work with hardware-controlled
performance scaling. The proposed interface would help us to communicate
per-task multipliers to hardware, but they would be used as hints to
hardware and not acted upon by the kernel to scale frequency.

