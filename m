Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA6A19CC40
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2019 11:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbfHZJKz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Aug 2019 05:10:55 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:45777 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730398AbfHZJKy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Aug 2019 05:10:54 -0400
Received: from 79.184.255.249.ipv4.supernova.orange.pl (79.184.255.249) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 60a20b9c8a8cb064; Mon, 26 Aug 2019 11:10:52 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Douglas RAILLARD <douglas.raillard@arm.com>, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com
Subject: Re: [PATCH] sched/cpufreq: Align trace event behavior of fast switching
Date:   Mon, 26 Aug 2019 11:10:52 +0200
Message-ID: <3316959.EEulJYEQYJ@kreacher>
In-Reply-To: <20190807153340.11516-1-douglas.raillard@arm.com>
References: <20190807153340.11516-1-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, August 7, 2019 5:33:40 PM CEST Douglas RAILLARD wrote:
> Fast switching path only emits an event for the CPU of interest, whereas the
> regular path emits an event for all the CPUs that had their frequency changed,
> i.e. all the CPUs sharing the same policy.
> 
> With the current behavior, looking at cpu_frequency event for a given CPU that
> is using the fast switching path will not give the correct frequency signal.
> 
> Signed-off-by: Douglas RAILLARD <douglas.raillard@arm.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 1f82ab108bab..975ccc3de807 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -153,6 +153,7 @@ static void sugov_fast_switch(struct sugov_policy *sg_policy, u64 time,
>  			      unsigned int next_freq)
>  {
>  	struct cpufreq_policy *policy = sg_policy->policy;
> +	int cpu;
>  
>  	if (!sugov_update_next_freq(sg_policy, time, next_freq))
>  		return;
> @@ -162,7 +163,11 @@ static void sugov_fast_switch(struct sugov_policy *sg_policy, u64 time,
>  		return;
>  
>  	policy->cur = next_freq;
> -	trace_cpu_frequency(next_freq, smp_processor_id());
> +
> +	if (trace_cpu_frequency_enabled()) {
> +		for_each_cpu(cpu, policy->cpus)
> +			trace_cpu_frequency(next_freq, cpu);
> +	}
>  }
>  
>  static void sugov_deferred_update(struct sugov_policy *sg_policy, u64 time,
> 

Peter, any comments here?



