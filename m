Return-Path: <linux-pm+bounces-10385-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D0992497B
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 22:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986191C229F8
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 20:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6038E20124D;
	Tue,  2 Jul 2024 20:41:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0B61CF8F;
	Tue,  2 Jul 2024 20:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719952897; cv=none; b=Sy4HIvdxqN5N9NtkOOCoTp5JqF1zClf3Djvdv8V7lQUebW4mDFPIf6EPnHcBgBcpOPLfOYL6tANxe/0IB4Y7a+G1yeTV58JadWSb2+pAy+m57RvoQZTE9Y5R0So1pZQGjWCv84RGnK/wIQGvcCM1rRKk+lPSEJ3tdwghbUZgJ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719952897; c=relaxed/simple;
	bh=hhH4iZXp8qOnFwnFupvfayXAquZLbQ+GU/0m8/x3+Qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IW5PzvlfQYftXPWOCSPfYy8FXmn3/TpNruqOsppK0e1A0t2S6SjtCJClWYLxhMYIUPTlyW/eSjofHd+xMC6QMfmBJ/aztvkSc/XuMQDtpfUup4GrKW3PfPsYEZ5t1fgvdxYB2u9t/VAPqS1MGWAoPffKGaAt3MO1cs9Iv47GSFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C2A7339;
	Tue,  2 Jul 2024 13:41:58 -0700 (PDT)
Received: from [10.57.82.69] (unknown [10.57.82.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F33893F766;
	Tue,  2 Jul 2024 13:41:31 -0700 (PDT)
Message-ID: <20208c07-1ea8-43a0-a499-51c9fd63b037@arm.com>
Date: Tue, 2 Jul 2024 21:41:30 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sched_ext: Add cpuperf support
To: Tejun Heo <tj@kernel.org>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 void@manifault.com, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 mingo@redhat.com, peterz@infradead.org, David Vernet <dvernet@meta.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20240619031250.2936087-1-tj@kernel.org>
 <20240619031250.2936087-3-tj@kernel.org>
 <63c76af4-6451-4d6a-8aeb-0bc4812c4101@arm.com>
 <ZoQs384bAMuaeDEs@slm.duckdns.org>
 <940a41d0-2660-4a7a-ad07-581b3ac24cca@arm.com>
 <ZoQ_XuXn1Y2Kp3Ba@slm.duckdns.org>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <ZoQ_XuXn1Y2Kp3Ba@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/07/2024 18:56, Tejun Heo wrote:
> Hello,
> 
> So, maybe something like this. It's not the prettiest but avoids adding
> indirect calls to fair and rt while allowing sched_ext to report what the
> BPF scheduler wants. Only compile tested. Would something like this work for
> the use cases you have on mind?
> 
> Thanks.
> 
> Index: work/kernel/sched/core.c
> ===================================================================
> --- work.orig/kernel/sched/core.c
> +++ work/kernel/sched/core.c
> @@ -1671,6 +1671,20 @@ static inline void uclamp_rq_dec_id(stru
>   	}
>   }
>   
> +bool sched_uclamp_enabled(void)
> +{
> +	return true;
> +}
> +
> +static bool class_supports_uclamp(const struct sched_class *class)
> +{
> +	if (likely(class->uclamp_enabled == sched_uclamp_enabled))
> +		return true;
> +	if (!class->uclamp_enabled)
> +		return false;
> +	return class->uclamp_enabled();
> +}
> +
>   static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
>   {
>   	enum uclamp_id clamp_id;
> @@ -1684,7 +1698,7 @@ static inline void uclamp_rq_inc(struct
>   	if (!static_branch_unlikely(&sched_uclamp_used))
>   		return;
>   
> -	if (unlikely(!p->sched_class->uclamp_enabled))
> +	if (class_supports_uclamp(p->sched_class))
>   		return;
>   
>   	for_each_clamp_id(clamp_id)
> @@ -1708,7 +1722,7 @@ static inline void uclamp_rq_dec(struct
>   	if (!static_branch_unlikely(&sched_uclamp_used))
>   		return;
>   
> -	if (unlikely(!p->sched_class->uclamp_enabled))
> +	if (class_supports_uclamp(p->sched_class))
>   		return;
>   
>   	for_each_clamp_id(clamp_id)
> Index: work/kernel/sched/ext.c
> ===================================================================
> --- work.orig/kernel/sched/ext.c
> +++ work/kernel/sched/ext.c
> @@ -116,10 +116,17 @@ enum scx_ops_flags {
>   	 */
>   	SCX_OPS_SWITCH_PARTIAL	= 1LLU << 3,
>   
> +	/*
> +	 * Disable built-in uclamp support. Can be useful when the BPF scheduler
> +	 * wants to implement custom uclamp support.
> +	 */
> +	SCX_OPS_DISABLE_UCLAMP	= 1LLU << 4,
> +
>   	SCX_OPS_ALL_FLAGS	= SCX_OPS_KEEP_BUILTIN_IDLE |
>   				  SCX_OPS_ENQ_LAST |
>   				  SCX_OPS_ENQ_EXITING |
> -				  SCX_OPS_SWITCH_PARTIAL,
> +				  SCX_OPS_SWITCH_PARTIAL |
> +				  SCX_OPS_DISABLE_UCLAMP,
>   };
>   
>   /* argument container for ops.init_task() */
> @@ -3437,6 +3444,13 @@ static void switched_from_scx(struct rq
>   static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p,int wake_flags) {}
>   static void switched_to_scx(struct rq *rq, struct task_struct *p) {}
>   
> +#ifdef CONFIG_UCLAMP_TASK
> +static bool uclamp_enabled_scx(void)
> +{
> +	return !(scx_ops.flags & SCX_OPS_DISABLE_UCLAMP);
> +}
> +#endif
> +
>   int scx_check_setscheduler(struct task_struct *p, int policy)
>   {
>   	lockdep_assert_rq_held(task_rq(p));
> @@ -3522,7 +3536,7 @@ DEFINE_SCHED_CLASS(ext) = {
>   	.update_curr		= update_curr_scx,
>   
>   #ifdef CONFIG_UCLAMP_TASK
> -	.uclamp_enabled		= 1,
> +	.uclamp_enabled		= uclamp_enabled_scx,
>   #endif
>   };
>   
> Index: work/kernel/sched/fair.c
> ===================================================================
> --- work.orig/kernel/sched/fair.c
> +++ work/kernel/sched/fair.c
> @@ -13228,9 +13228,7 @@ DEFINE_SCHED_CLASS(fair) = {
>   	.task_is_throttled	= task_is_throttled_fair,
>   #endif
>   
> -#ifdef CONFIG_UCLAMP_TASK
> -	.uclamp_enabled		= 1,
> -#endif
> +	SCHED_CLASS_UCLAMP_ENABLED
>   };
>   
>   #ifdef CONFIG_SCHED_DEBUG
> Index: work/kernel/sched/rt.c
> ===================================================================
> --- work.orig/kernel/sched/rt.c
> +++ work/kernel/sched/rt.c
> @@ -2681,9 +2681,7 @@ DEFINE_SCHED_CLASS(rt) = {
>   	.task_is_throttled	= task_is_throttled_rt,
>   #endif
>   
> -#ifdef CONFIG_UCLAMP_TASK
> -	.uclamp_enabled		= 1,
> -#endif
> +	SCHED_CLASS_UCLAMP_ENABLED
>   };
>   
>   #ifdef CONFIG_RT_GROUP_SCHED
> Index: work/kernel/sched/sched.h
> ===================================================================
> --- work.orig/kernel/sched/sched.h
> +++ work/kernel/sched/sched.h
> @@ -2339,11 +2339,6 @@ struct affinity_context {
>   extern s64 update_curr_common(struct rq *rq);
>   
>   struct sched_class {
> -
> -#ifdef CONFIG_UCLAMP_TASK
> -	int uclamp_enabled;
> -#endif
> -
>   	void (*enqueue_task) (struct rq *rq, struct task_struct *p, int flags);
>   	void (*dequeue_task) (struct rq *rq, struct task_struct *p, int flags);
>   	void (*yield_task)   (struct rq *rq);
> @@ -2405,8 +2400,21 @@ struct sched_class {
>   #ifdef CONFIG_SCHED_CORE
>   	int (*task_is_throttled)(struct task_struct *p, int cpu);
>   #endif
> +
> +#ifdef CONFIG_UCLAMP_TASK
> +	bool (*uclamp_enabled)(void);
> +#endif
>   };
>   
> +#ifdef CONFIG_UCLAMP_TASK
> +bool sched_uclamp_enabled(void);
> +
> +#define SCHED_CLASS_UCLAMP_ENABLED	\
> +	.uclamp_enabled = sched_uclamp_enabled,
> +#else
> +#define SCHED_CLASS_UCLAMP_ENABLED
> +#endif
> +
>   static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
>   {
>   	WARN_ON_ONCE(rq->curr != prev);

Looks good to me!

Actually, if we are okay with changing the sched_class struct and 
touching the code of other classes, I wonder if a cleaner solution is 
just to completely remove sched_class->uclamp_enabled and let each class 
decide what to do in enqueue and dequeue, so instead of

	uclamp_inc/dec();
	p->sched_class->enqueue/dequeue_task();

we can just

	p->sched_class->enqueue/dequeue_task();
		do_uclamp_inside_each_class();

and we export uclamp_inc/dec() functions from core.c to RT, fair and 
ext. For RT and fair, just

	enqueue/dequeue_task_fair/rt();
		uclamp_inc/dec();

For ext, maybe expose bpf_uclamp_inc/dec() to the custom scheduler. If a 
scheduler wants to reuse the current uclamp implementation, just call 
these. If not, skip them and implement its own.

