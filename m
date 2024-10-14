Return-Path: <linux-pm+bounces-15625-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AFE99D439
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 18:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F5D51F22929
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 16:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640531ABEB8;
	Mon, 14 Oct 2024 16:06:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC33175B1;
	Mon, 14 Oct 2024 16:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728921994; cv=none; b=G8IAynvqNvzioGhryXtRxS6XkmDrxqD3mF6W9lKo1NFDi44wa3xbvL9PlxwqoALJyLti781rWA4V9TYlf1mxT4kmaNrp2a2iAlb4s8Cy4ay/BDPA3WKfd+yBOcvT4prlFg83H8wxpI7Eoc5Fa/IbXVCbuH72HQe8qT0HcAyucEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728921994; c=relaxed/simple;
	bh=QmxPBuQbf6AaAehfcvHBb2IftsXisE5uXzJ8oSj13w4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UT72tXxcRQCkxvQZJzNS8Saub6YTs1n0EqIEXTNRDGtabTXFHDBnyVYrEmN4ulM42Mc0xrrZVH4Fm8z77C5q5B7hgTrc37+jli6fb81KSxoae9BNrGizgAE3X3Xzz9Xy0WBmyGqLbOCf3Rdyq7QVLyrebpIf6Vr4ol6iFC3xKMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46C0E1007;
	Mon, 14 Oct 2024 09:07:01 -0700 (PDT)
Received: from [10.1.33.17] (e127648.arm.com [10.1.33.17])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2E783F71E;
	Mon, 14 Oct 2024 09:06:28 -0700 (PDT)
Message-ID: <23d3a258-1beb-4d2b-bbd5-0c4ba5f49b02@arm.com>
Date: Mon, 14 Oct 2024 17:06:26 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 11/16] sched/qos: Add rampup multiplier QoS
To: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, John Stultz
 <jstultz@google.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240820163512.1096301-1-qyousef@layalina.io>
 <20240820163512.1096301-12-qyousef@layalina.io>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240820163512.1096301-12-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/24 17:35, Qais Yousef wrote:
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

table should be const struct ctl_table *table for this to build on 6.11 at least.


