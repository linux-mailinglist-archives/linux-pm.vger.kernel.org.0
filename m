Return-Path: <linux-pm+bounces-14422-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BEA97C145
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 23:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0FB928417F
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 21:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02538178CF6;
	Wed, 18 Sep 2024 21:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iygo4ztY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7921113792B;
	Wed, 18 Sep 2024 21:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726694150; cv=none; b=V870CoPbhK+FhAvW/l5n30+Bfk+1Vzj1YwPZbe4cJrlFQbdR4Y0NfnGu/6iaeRFz8KgBEwAR8QOp7jKaFvE9kM2ujDHbilfV1BObGTdJIc6GuI+kAmPCO3Hy8460OnyqRkMysbNApwyKwwejZ2S909FnAWn9X723rEik9njVG3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726694150; c=relaxed/simple;
	bh=zfyMhNUVek2todfuBYRopUBFHYSMvVqJHIgM8KIawjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTIx6FpBy9JOYFDkfzBtQ629HKzmDLJvF2YGpvwV3DOaU4GBY7xmIivVsX3AxfkNadqGddzI6WUjbLMfVgbwLPQc5zSyZdffxhkaow3YgEXBRbPb0o7hNnyP208DkiTlmTh84zsPeMTgH7+DFKffgU1xm9fH5hpssJYhXOY4N7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iygo4ztY; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726694148; x=1758230148;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zfyMhNUVek2todfuBYRopUBFHYSMvVqJHIgM8KIawjM=;
  b=iygo4ztY2frapyC/UW95UT8UZkLzja4jCcl28Yn//U55K9wgKK+j5I+u
   zPBzMd7HHIsjP7hvs10q7jRAbydKxsPtwDhkckWrCcBfd6gCiifhLfids
   nn8L8SZz7YXPP3NJ9pRcA0r36mLOsBIPu5h47G+a6u0ncJCXEO/4GnyJ2
   3L30MjsGSmmihuwSj2wzVznz4Im7j+JN/jr6jI4sQ4K23+CCnEr2g9/hj
   b07gGT4NOvsDzJfk5V9wEABPliW6TGQzQoeII91Ah6S5VfDax5VW/vaKf
   hGjRcGicGjbfhhhMk8OkUmwZ2TG9gFquZ924snxJ7BFqSKL3IA/7o23sU
   w==;
X-CSE-ConnectionGUID: ePhUtHZKRT6dLQeo/gUkEA==
X-CSE-MsgGUID: HQYbmAZLRZuPGl6F+k++jg==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="51036986"
X-IronPort-AV: E=Sophos;i="6.10,239,1719903600"; 
   d="scan'208";a="51036986"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 14:15:47 -0700
X-CSE-ConnectionGUID: L22pZY1cSQW1gUT2uOGgxw==
X-CSE-MsgGUID: NFtm3rgNTFyjnMAE0yP8Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,239,1719903600"; 
   d="scan'208";a="74493718"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 14:15:47 -0700
Date: Wed, 18 Sep 2024 14:21:26 -0700
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
Message-ID: <20240918212126.GA11943@ranerica-svr.sc.intel.com>
References: <20240820163512.1096301-1-qyousef@layalina.io>
 <20240820163512.1096301-12-qyousef@layalina.io>
 <20240917214337.GA10143@ranerica-svr.sc.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917214337.GA10143@ranerica-svr.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Tue, Sep 17, 2024 at 02:43:37PM -0700, Ricardo Neri wrote:
> On Tue, Aug 20, 2024 at 05:35:07PM +0100, Qais Yousef wrote:
> > Bursty tasks are hard to predict. To use resources efficiently, the
> > system would like to be exact as much as possible. But this poses
> > a challenge for these bursty tasks that need to get access to more
> > resources quickly.
> > 
> > The new SCHED_QOS_RAMPUP_MULTIPLIER allows userspace to do that. As the
> > name implies, it only helps them to transition to a higher performance
> > state when they get _busier_. That is perfectly periodic tasks by
> > definition are not going through a transition and will run at a constant
> > performance level. It is the tasks that need to transition from one
> > periodic state to another periodic state that is at a higher level that
> > this rampup_multiplier will help with. It also slows down the ewma decay
> > of util_est which should help those bursty tasks to keep their faster
> > rampup.
> > 
> > This should work complimentary with uclamp. uclamp tells the system
> > about min and max perf requirements which can be applied immediately.
> > 
> > rampup_multiplier is about reactiveness of the task to change.
> > Specifically to a change for a higher performance level. The task might
> > necessary need to have a min perf requirements, but it can have sudden
> > burst of changes that require higher perf level and it needs the system
> > to provide this faster.
> > 
> > TODO: update the sched_qos docs
> > 
> > Signed-off-by: Qais Yousef <qyousef@layalina.io>
> > ---
> >  include/linux/sched.h      |  7 ++++
> >  include/uapi/linux/sched.h |  2 ++
> >  kernel/sched/core.c        | 66 ++++++++++++++++++++++++++++++++++++++
> >  kernel/sched/fair.c        |  6 ++--
> >  kernel/sched/syscalls.c    | 38 ++++++++++++++++++++--
> >  5 files changed, 115 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 2e8c5a9ffa76..a30ee43a25fb 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -404,6 +404,11 @@ struct sched_info {
> >  #endif /* CONFIG_SCHED_INFO */
> >  };
> >  
> > +struct sched_qos {
> > +	DECLARE_BITMAP(user_defined, SCHED_QOS_MAX);
> > +	unsigned int rampup_multiplier;
> > +};
> > +
> >  /*
> >   * Integer metrics need fixed point arithmetic, e.g., sched/fair
> >   * has a few: load, load_avg, util_avg, freq, and capacity.
> > @@ -882,6 +887,8 @@ struct task_struct {
> >  
> >  	struct sched_info		sched_info;
> >  
> > +	struct sched_qos		sched_qos;
> > +
> >  	struct list_head		tasks;
> >  #ifdef CONFIG_SMP
> >  	struct plist_node		pushable_tasks;
> > diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> > index 67ef99f64ddc..0baba91ba5b8 100644
> > --- a/include/uapi/linux/sched.h
> > +++ b/include/uapi/linux/sched.h
> > @@ -104,6 +104,8 @@ struct clone_args {
> >  };
> >  
> >  enum sched_qos_type {
> > +	SCHED_QOS_RAMPUP_MULTIPLIER,
> > +	SCHED_QOS_MAX,
> >  };
> >  #endif
> >  
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index c91e6a62c7ab..54faa845cb29 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -152,6 +152,8 @@ __read_mostly int sysctl_resched_latency_warn_once = 1;
> >   */
> >  const_debug unsigned int sysctl_sched_nr_migrate = SCHED_NR_MIGRATE_BREAK;
> >  
> > +unsigned int sysctl_sched_qos_default_rampup_multiplier	= 1;
> > +
> >  __read_mostly int scheduler_running;
> >  
> >  #ifdef CONFIG_SCHED_CORE
> > @@ -4488,6 +4490,47 @@ static int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
> >  #endif /* CONFIG_SCHEDSTATS */
> >  
> >  #ifdef CONFIG_SYSCTL
> > +static void sched_qos_sync_sysctl(void)
> > +{
> > +	struct task_struct *g, *p;
> > +
> > +	guard(rcu)();
> > +	for_each_process_thread(g, p) {
> > +		struct rq_flags rf;
> > +		struct rq *rq;
> > +
> > +		rq = task_rq_lock(p, &rf);
> > +		if (!test_bit(SCHED_QOS_RAMPUP_MULTIPLIER, p->sched_qos.user_defined))
> > +			p->sched_qos.rampup_multiplier = sysctl_sched_qos_default_rampup_multiplier;
> > +		task_rq_unlock(rq, p, &rf);
> > +	}
> > +}
> > +
> > +static int sysctl_sched_qos_handler(struct ctl_table *table, int write,
> > +				    void *buffer, size_t *lenp, loff_t *ppos)
> > +{
> > +	unsigned int old_rampup_mult;
> > +	int result;
> > +
> > +	old_rampup_mult = sysctl_sched_qos_default_rampup_multiplier;
> > +
> > +	result = proc_dointvec(table, write, buffer, lenp, ppos);
> > +	if (result)
> > +		goto undo;
> > +	if (!write)
> > +		return 0;
> > +
> > +	if (old_rampup_mult != sysctl_sched_qos_default_rampup_multiplier) {
> > +		sched_qos_sync_sysctl();
> > +	}
> > +
> > +	return 0;
> > +
> > +undo:
> > +	sysctl_sched_qos_default_rampup_multiplier = old_rampup_mult;
> > +	return result;
> > +}
> > +
> >  static struct ctl_table sched_core_sysctls[] = {
> >  #ifdef CONFIG_SCHEDSTATS
> >  	{
> > @@ -4534,6 +4577,13 @@ static struct ctl_table sched_core_sysctls[] = {
> >  		.extra2		= SYSCTL_FOUR,
> >  	},
> >  #endif /* CONFIG_NUMA_BALANCING */
> > +	{
> > +		.procname	= "sched_qos_default_rampup_multiplier",
> > +		.data           = &sysctl_sched_qos_default_rampup_multiplier,
> > +		.maxlen         = sizeof(unsigned int),
> 
> IIUC, user space needs to select a value between 0 and (2^32 - 1). Does
> this mean that it will need fine-tuning for each product and application?
> 
> Could there be some translation to a fewer number of QoS levels that are
> qualitatively?
> 
> Also, I think about Intel processors. They work with hardware-controlled
> performance scaling. The proposed interface would help us to communicate
> per-task multipliers to hardware, but they would be used as hints to
> hardware and not acted upon by the kernel to scale frequency.

Also, as discussed during LPC 2024 it might be good to have an interface
that is compatible with other operating systems. They have qualitative
descriptions of QoS levels (see Len Brown's LPC 2022 presentation [1]).

It can be this hint or a new one.

[1]. https://lpc.events/event/16/contributions/1276/attachments/1070/2039/Brown-Shankar%20LPC%202022.09.13%20Sched%20QOS%20API.pdf

