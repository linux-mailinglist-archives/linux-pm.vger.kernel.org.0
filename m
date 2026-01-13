Return-Path: <linux-pm+bounces-40734-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAA9D19110
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 14:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9ECB73048144
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 13:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3753C3904C5;
	Tue, 13 Jan 2026 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="MQuMJtwh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159D238FEFD
	for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 13:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768309902; cv=none; b=SwFndVTODrbcmakbn5hbHOq67Mm66sShZQgFVB6e4JSbQFGx0gR2fL/c+w+G8fP2r/AtQfZyxAxSqvEtE+amrkuFYrYts2w2H0eM27ELQjpTCgl3ZaiW6Vi7V9LAzGgxfL5RG34V5/kS2AFMxRiuz3uVV8m9L9aNXXWNGzM68tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768309902; c=relaxed/simple;
	bh=g0J6163nPqIdSvx2ZcRKcNzQ6hRwgDzWBUK8kJFpYGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfrlWga5iWqku7bxS/xavJq9fyuEiJj7JrhbpItaOl4hAfbUms2dmKz4zeDmBrS9XWJZNYXEp0NZHQfIkJiQ1l3XO6wXj+A4sinkqFwI3ViY53LTnp1aMOtqSz+1Js6bZqVYedFIIfkHzW0Dnks2oDnHzjESSsn8k2krddW4NM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=MQuMJtwh; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47ee0291921so1835685e9.3
        for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 05:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1768309895; x=1768914695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5SFTz9iRqzCXmi0INb7uW0+c/Pd8bFrKl3MzDBqPrUQ=;
        b=MQuMJtwhMY5TH0i4h+VnEsrRm96bsg5zn4VHoQHjyyYsxoa0YxR2JdBj6rF+Sd4Nix
         JxRxgckueI6L4HbcWQhI/0ClDT0QFb04hxvXYQeGPkfNd36Px4UwXYOhgkYWCKO9Z36t
         g7SWI1yCgCaXPDKgAzKHTN8AeYlRdswuIwsd0o169rWeBwKTJZRA7OUbh0b/kADsUBND
         RwuF4kGZrKhzEvPeWdB2uIneVTHcTIxjM8nx7TLyHdAYBj4O5ngEcZwgQaM0JF0xacqn
         +0fs3RK39B2RkvKfrmLtp3ZSYoPVvm4R6VXThsrzxYAVHgg1HzYVkLF4UdZxjjG17SGZ
         gJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768309895; x=1768914695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SFTz9iRqzCXmi0INb7uW0+c/Pd8bFrKl3MzDBqPrUQ=;
        b=eRhb/122nAX+FZCdBcFponbK+6xhr4m7Oh1m83VkdiXE2t8PD12/v84QMjNixKJF8n
         WAErLUtY7SD715NDNwFHa1fkerP7aOVjYPebDj8bL8AWgXARrWoAWkCtvmMDeW7t6U5c
         jg9jBJOojIprEwWBU5NjV4kToZdrWEjQ5iZzbLoOdOduOlV5OYxiPwo78C+6lu/COmud
         Aq04tWL8w3XYAAneqA8VwGd5NKNmx87S9Q9Dd1Oa/iX8F/cdk0nliMNDT3wK/4HbFtJQ
         YdNVdgJnpZzzLN2yX7/qopgjT5mpgUxQG5OlXeDjxtSp1/P6aTK/w1EJ0fmkxq8VZTYC
         JcmQ==
X-Gm-Message-State: AOJu0Yxqd0VCby7ytKty1DI8AqEHiA8Q0TFihzr48hxxOwfVvqHahHkd
	8UiVuakhVuQoYWBtm86k0MvTBc8pFnCMQg/LeTXDrY0+MWfP0J4vTWqZeiPm7Mxz+Us=
X-Gm-Gg: AY/fxX6aTB8NQP917rWGzBEGQozYaF8/ihM9hfRpCi3eKwtZisWE/1vYddE2LtBmrPL
	M3dcnFZpi0lQA6p6NcRyHiphhxMwOmANDUOjNOB6kBkHjA8zmyyEabIcf2FlSL0YKX020rN3HGL
	XoJSPtd50+xs7gNwWu3eFXItQW9BsK5pIGCXrwvQraEfGQbk72xZ0N9WNc09orC37D7rcco0So7
	0rfXRzfksf58thpuhbU38MShUVroNK3i5oGChJX5mnvDFmJF7qvLsXu2jBTYHz7xCoKd1tCEjj5
	r2qTiPNflGs3zVjAYERpIyrNVnnCTnyAtZQwDi4Hee75j81OABwJT0UkMTvLBi5KdZMlJNd0liw
	yfCg38gICZwoTOvsIu2f2N16asSX42ibZXIfyP8PEmEXQxfpN0IWhqIYlG2mDSDDybTJOibRRFy
	EPJfPpjSGZpRLe3CzvsIjrQtLuQcCXPuq/HFbm42EnwrG171UULmOAr+JwoI/aCN5Nnw==
X-Google-Smtp-Source: AGHT+IGEWMw4hr1CYLNx7QZOU973apvjCwKH+eZgAIBTlHEMNzL98TZOsFrXzk0wyL/zL2pc4nlQvA==
X-Received: by 2002:a05:600c:3143:b0:46e:49fb:4776 with SMTP id 5b1f17b1804b1-47d84b1a14emr259159025e9.11.1768309895380;
        Tue, 13 Jan 2026 05:11:35 -0800 (PST)
Received: from airbuntu (host109-153-232-117.range109-153.btcentralplus.com. [109.153.232.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f68f4ddsm415470025e9.2.2026.01.13.05.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 05:11:35 -0800 (PST)
Date: Tue, 13 Jan 2026 13:11:34 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Christian Loehle <christian.loehle@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rafael@kernel.org, peterz@infradead.org, pierre.gondois@arm.com,
	qperret@google.com, sven@svenpeter.dev
Subject: Re: [PATCH 0/1] sched: Ignore overutilized by lone task on max-cap
 CPU
Message-ID: <20260113131134.n4ixed2awnikgmeq@airbuntu>
References: <20251230093037.427141-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251230093037.427141-1-christian.loehle@arm.com>

On 12/30/25 09:30, Christian Loehle wrote:
> I'm trying to deliver on my overdue promise of redefining overutilized state.
> My investigation basically lead to redefinition of overutilized state
> bringing very little hard improvements, while it comes with at least
> some risk of worsening platforms and workload combinations I might've
> overlooked, therefore I only concentrate on one, the least
> controversial, for now.

What are the controversial bits?

This is a step forward, but not sure it is in the right direction. The concept
of a *cpu* being overutilized === rd is overutilized no longer makes sense
since misfit was decoupled from this logic which was the sole reason to
require this check at CPU level.  Overutilized state is, rightly, set at the
rootdomain level. And the check makes sense to be done at that level too by
traversing the perf domains and seeing if we are in a state that requires
moving tasks around. Which should be done in update_{sg,sd}_lb_stats() logic
only.

I guess the difficult question (which might be what you're referring to as
controversial), is at what point we can no longer pack (use EAS) and must
distribute tasks around?

I think this question is limited by what the lb can do today. With push lb,
I believe the current global lb is likely to be unnecessary in small systems
(single LLC) since it can shuffle things around immediately to handle misfit
and overload.

On top of that, what can the existing global lb do? I am not sure to be honest.
The system has to have a number of long running tasks > num_cpus for it to be
useful. But given util signal will lose its meaning under these circumstances,
I am not sure the global lb can do a better job than push lb trying to move
these tasks around. But it could do a more comprehensive job in one go? I'll
defer to Vincent, he probably more able to answer this from the top of his
head. But the answer to this question is the key to how we want to define this
*system* is overutilized state.

Assuming this is on top of push lb, I believe something like below which will
trigger overutilized only if all cpus are overutilized (ie system is nearly
maxed out (has 20% or less headroom)) is a good starting point at least.



diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index da46c3164537..ba08f4aefa03 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6814,17 +6814,6 @@ static inline void set_rd_overutilized(struct root_domain *rd, bool flag)
 	trace_sched_overutilized_tp(rd, flag);
 }
 
-static inline void check_update_overutilized_status(struct rq *rq)
-{
-	/*
-	 * overutilized field is used for load balancing decisions only
-	 * if energy aware scheduler is being used
-	 */
-
-	if (!is_rd_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
-		set_rd_overutilized(rq->rd, 1);
-}
-
 /* Runqueue only has SCHED_IDLE tasks enqueued */
 static int sched_idle_rq(struct rq *rq)
 {
@@ -6968,23 +6957,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	/* At this point se is NULL and we are at root level*/
 	add_nr_running(rq, 1);
 
-	/*
-	 * Since new tasks are assigned an initial util_avg equal to
-	 * half of the spare capacity of their CPU, tiny tasks have the
-	 * ability to cross the overutilized threshold, which will
-	 * result in the load balancer ruining all the task placement
-	 * done by EAS. As a way to mitigate that effect, do not account
-	 * for the first enqueue operation of new tasks during the
-	 * overutilized flag detection.
-	 *
-	 * A better way of solving this problem would be to wait for
-	 * the PELT signals of tasks to converge before taking them
-	 * into account, but that is not straightforward to implement,
-	 * and the following generally works well enough in practice.
-	 */
-	if (!task_new)
-		check_update_overutilized_status(rq);
-
 	assert_list_leaf_cfs_rq(rq);
 
 	hrtick_update(rq);
@@ -10430,8 +10402,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		nr_running = rq->nr_running;
 		sgs->sum_nr_running += nr_running;
 
-		if (cpu_overutilized(i))
-			*sg_overutilized = 1;
+		*sg_overutilized &= cpu_overutilized(i);
 
 		/*
 		 * No need to call idle_cpu() if nr_running is not 0
@@ -11087,7 +11058,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	struct sg_lb_stats *local = &sds->local_stat;
 	struct sg_lb_stats tmp_sgs;
 	unsigned long sum_util = 0;
-	bool sg_overloaded = 0, sg_overutilized = 0;
+	bool sg_overloaded = 0, sg_overutilized = 1;
 
 	do {
 		struct sg_lb_stats *sgs = &tmp_sgs;
@@ -13378,7 +13349,6 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 		task_tick_numa(rq, curr);
 
 	update_misfit_status(curr, rq);
-	check_update_overutilized_status(task_rq(curr));
 
 	task_tick_core(rq, curr);
 }

