Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 091D8FCAAF
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 17:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfKNQXj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Nov 2019 11:23:39 -0500
Received: from foss.arm.com ([217.140.110.172]:45768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfKNQXj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 Nov 2019 11:23:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 486E9328;
        Thu, 14 Nov 2019 08:23:38 -0800 (PST)
Received: from [192.168.1.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0134C3F52E;
        Thu, 14 Nov 2019 08:23:34 -0800 (PST)
Subject: Re: [PATCH v3] sched/freq: move call to cpufreq_update_util
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        mgorman@suse.de, dsmythies@telus.net
Cc:     linux-pm@vger.kernel.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, sargun@sargun.me, tj@kernel.org,
        xiexiuqi@huawei.com, xiezhipeng1@huawei.com,
        srinivas.pandruvada@linux.intel.com
References: <1573676461-7990-1-git-send-email-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <5a56358b-83f5-09db-17f0-dbdeecba2ff3@arm.com>
Date:   Thu, 14 Nov 2019 17:23:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573676461-7990-1-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13.11.19 21:21, Vincent Guittot wrote:
> update_cfs_rq_load_avg() calls cfs_rq_util_change() everytime pelt decays,
> which might be inefficient when cpufreq driver has rate limitation.
> 
> When a task is attached on a CPU, we have call path:
> 
> update_load_avg()
>   update_cfs_rq_load_avg()
>     cfs_rq_util_change -- > trig frequency update
>   attach_entity_load_avg()
>     cfs_rq_util_change -- > trig frequency update
> 
> The 1st frequency update will not take into account the utilization of the
> newly attached task and the 2nd one might be discard because of rate
> limitation of the cpufreq driver.
> 
> update_cfs_rq_load_avg() is only called by update_blocked_averages()
> and update_load_avg() so we can move the call to
> cfs_rq_util_change/cpufreq_update_util() into these 2 functions. It's also
> interesting to notice that update_load_avg() already calls directly
> cfs_rq_util_change() for !SMP case.
> 
> This changes will also ensure that cpufreq_update_util() is called even
> when there is no more CFS rq in the leaf_cfs_rq_list to update but only
> irq, rt or dl pelt signals.
> 
> Reported-by: Doug Smythies <dsmythies@telus.net>
> Fixes: 039ae8bcf7a5 ("sched/fair: Fix O(nr_cgroups) in the load balancing path")
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

> ---
> 
> changes for v3:
> - fix typo
> - test the decay of root cfs_rq even for !CONFIG_FAIR_GROUP_SCHED case

nit: s/!CONFIG_FAIR_GROUP_SCHED/CONFIG_FAIR_GROUP_SCHED

[...]

> @@ -7543,6 +7544,7 @@ static void update_blocked_averages(int cpu)
>  	const struct sched_class *curr_class;
>  	struct rq_flags rf;
>  	bool done = true;
> +	int decayed;
>  
>  	rq_lock_irqsave(rq, &rf);
>  	update_rq_clock(rq);
> @@ -7552,9 +7554,9 @@ static void update_blocked_averages(int cpu)
>  	 * that RT, DL and IRQ signals have been updated before updating CFS.
>  	 */

tip/sched/urgent's b90f7c9d2198 ("sched/pelt: Fix update of blocked PELT
ordering") adds this comment to both update_blocked_averages()
implementations. It mentions explicitly that update_cfs_rq_load_avg()
can call cpufreq_update_util(). Something this patch changes. Might be
good to update the comments with this patch as well.

[...]
