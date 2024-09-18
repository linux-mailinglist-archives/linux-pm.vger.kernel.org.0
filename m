Return-Path: <linux-pm+bounces-14403-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 421CC97BB04
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 12:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AF641C23899
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 10:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FC218B468;
	Wed, 18 Sep 2024 10:40:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A1818A948;
	Wed, 18 Sep 2024 10:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726656012; cv=none; b=ZI3TIDJP+BB9kN/vcKEWfggeGDxSGd/Z2MoVrmnBnNP/htubLPGDXPuwnRsQKG77u4OAHOeHZuh5laoUKSVj3TZbU48pK6mCltGgMCuDq1wSJsqhn+1LJgFBQCf8Dd+8rKBn1JswO6xqDV7Y6YgcebJLayQR6NdAUbhPmahZPYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726656012; c=relaxed/simple;
	bh=1qUMxT6kYwD1jEGXfJNqRt0YDMAs+F89Tj8EYy1Smz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IE45FjReAH4Ouy0mC2koYtGn8qp/YblSTuI5o9dgn/d0I3iGiopUwU9kHlO0qIIH5+8KEa0R8K1bZ5d2EhAuUoZPBWp41/nJMc8f+fOsrErUe7vPv2Y1oj+K+hZrYDDjPRCjHDcla2PQdSQ3VSd1R2f1zsOMu0fbKm1oT1fPr7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42071FEC;
	Wed, 18 Sep 2024 03:40:38 -0700 (PDT)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E87B3F64C;
	Wed, 18 Sep 2024 03:40:07 -0700 (PDT)
Message-ID: <ea9ce34f-0eab-438c-ab80-45e92a654bdc@arm.com>
Date: Wed, 18 Sep 2024 11:40:05 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 14/16] sched/schedutil: Ignore dvfs headroom when util
 is decaying
To: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, John Stultz
 <jstultz@google.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240820163512.1096301-1-qyousef@layalina.io>
 <20240820163512.1096301-15-qyousef@layalina.io>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240820163512.1096301-15-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/24 17:35, Qais Yousef wrote:
> It means we're being idling or doing less work and are already running
> at a higher value. No need to apply any dvfs headroom in this case.
> 
> Signed-off-by: Qais Yousef <qyousef@layalina.io>
> ---
>  kernel/sched/cpufreq_schedutil.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 318b09bc4ab1..4a1a8b353d51 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -9,6 +9,7 @@
>  #define IOWAIT_BOOST_MIN	(SCHED_CAPACITY_SCALE / 8)
>  
>  DEFINE_PER_CPU_READ_MOSTLY(unsigned long, response_time_mult);
> +DEFINE_PER_CPU(unsigned long, last_update_util);
>  
>  struct sugov_tunables {
>  	struct gov_attr_set	attr_set;
> @@ -262,15 +263,19 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>   * Also take into accounting how long tasks have been waiting in runnable but
>   * !running state. If it is high, it means we need higher DVFS headroom to
>   * reduce it.
> - *
> - * XXX: Should we provide headroom when the util is decaying?
>   */
>  static inline unsigned long sugov_apply_dvfs_headroom(unsigned long util,  int cpu)
>  {
> -	unsigned long update_headroom, waiting_headroom;
> +	unsigned long update_headroom, waiting_headroom, prev_util;
>  	struct rq *rq = cpu_rq(cpu);
>  	u64 delay;
>  
> +	prev_util = per_cpu(last_update_util, cpu);
> +	per_cpu(last_update_util, cpu) = util;
> +
> +	if (util < prev_util)
> +		return util;
> +
>  	/*
>  	 * What is the possible worst case scenario for updating util_avg, ctx
>  	 * switch or TICK?

Kind of in the same vain as Sultan here, -/+1 util really doesn't tell much,
I would be wary to base any special behavior on that.
This goes for here but also for the 'periodic'-task detection in
[RFC PATCH 09/16] sched/fair: util_est: Take into account periodic tasks
in my experience as soon as we leave the world of rt-app workloads behind
these aren't stable enough on that granularity.

