Return-Path: <linux-pm+bounces-14374-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A089A97B451
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 21:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6C61F24213
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 19:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5E31865F5;
	Tue, 17 Sep 2024 19:21:22 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE12DBA3D;
	Tue, 17 Sep 2024 19:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726600882; cv=none; b=ILDwWlEdIbJuBMmdvfbFA3+8lufi+mxwXPNHyGo/E3PidYaUz1kwuHtvGZ//agtOG8ZTsnU4bz6WzP1rpUGOjXUs+U0bV5fcPMBxiYMp3h2ZjVxnon3spzR7ToC4tcEuvFvCrpc3FSoPq+/BUg3+SoB3rt9nQpQ4apIdILdGwp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726600882; c=relaxed/simple;
	bh=xUn0XCc6T7XufulnOlWs+oU5OtCfuNQRiODcgRiLHyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fYJxwbA1JO69GTLbeIl7lsr8GpRwNuJfOBjKpAqi51dKU5A/L8OHQuQsN/6Y7ghyUbVJU3/n9Vl61ZtNVUSQ+bRqG9WS3lqDVt9LNiiwZNSsBoN+KPL+eX4Cl67pR5UQh4vaCHXc/Dq7fydsZivivK39O0fSq2F9/FL3iAhhZ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C15E1007;
	Tue, 17 Sep 2024 12:21:48 -0700 (PDT)
Received: from [10.1.47.44] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B5643F64C;
	Tue, 17 Sep 2024 12:21:16 -0700 (PDT)
Message-ID: <a85e234d-def5-4915-9632-7228bcf0d9e1@arm.com>
Date: Tue, 17 Sep 2024 21:21:13 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/16] sched/fair: Extend util_est to improve rampup
 time
To: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240820163512.1096301-1-qyousef@layalina.io>
 <20240820163512.1096301-9-qyousef@layalina.io>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20240820163512.1096301-9-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/08/2024 18:35, Qais Yousef wrote:
> Utilization invariance can cause big delays. When tasks are running,
> accumulate non-invairiant version of utilization to help tasks to settle
> down to their new util_avg values faster.
> 
> Keep track of delta_exec during runnable across activations to help
> update util_est for a long running task accurately. util_est shoudl
> still behave the same at enqueue/dequeue.
> 
> Before this patch the a busy task tamping up would experience the
> following transitions, running on M1 Mac Mini

[...]

> @@ -4890,16 +4890,20 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
>  	if (!sched_feat(UTIL_EST))
>  		return;
>  
> -	/*
> -	 * Skip update of task's estimated utilization when the task has not
> -	 * yet completed an activation, e.g. being migrated.
> -	 */
> -	if (!task_sleep)
> -		return;
> -
>  	/* Get current estimate of utilization */
>  	ewma = READ_ONCE(p->se.avg.util_est);
>  
> +	/*
> +	 * If a task is running, update util_est ignoring utilization
> +	 * invariance so that if the task suddenly becomes busy we will rampup
> +	 * quickly to settle down to our new util_avg.
> +	 */
> +	if (!task_sleep) {
> +		ewma &= ~UTIL_AVG_UNCHANGED;
> +		ewma = approximate_util_avg(ewma, p->se.delta_exec / 1000);
> +		goto done;
> +	}
> +

Can you not use the UTIL_EST_FASTER idea for that? I mean speed up
ramp-up on little CPUs for truly ramp-up tasks to fight the influence of
invariant util_avg->util_est here.

https://lkml.kernel.org/r/Y2kLA8x40IiBEPYg@hirez.programming.kicks-ass.net

I do understand that runnable_avg boosting wont help here since we're
not fighting contention.

It uses the sum of all activations since wake-up so it should be faster
than just using the last activation.

It uses existing infrastructure: __accumulate_pelt_segments()

If you use it inside task- and/or cpu-util function, you don't need to
make util_est state handling more complicated (distinguish periodic and
ramp-up task, including PATCH 09/16).

From your workload analysis, do you have examples of Android tasks which
are clearly ramp-up tasks and maybe also affine to the little CPUs
(thanks to Android BACKGROUND group) which would require this correction
of the invariant util_avg->util_est signals?

[...]


