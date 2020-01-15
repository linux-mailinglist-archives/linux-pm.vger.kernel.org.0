Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC3813BD61
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 11:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbgAOK2Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jan 2020 05:28:24 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:55103 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbgAOK2Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jan 2020 05:28:24 -0500
Received: from 79.184.255.90.ipv4.supernova.orange.pl (79.184.255.90) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id a19f27fe6dcc38b1; Wed, 15 Jan 2020 11:28:22 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] sched/fair: remove redundant call to cpufreq_update_util
Date:   Wed, 15 Jan 2020 11:28:21 +0100
Message-ID: <1877134.NLrey8JjuQ@kreacher>
In-Reply-To: <1579083620-24943-1-git-send-email-vincent.guittot@linaro.org>
References: <1579083620-24943-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, January 15, 2020 11:20:20 AM CET Vincent Guittot wrote:
> With commit bef69dd87828 ("sched/cpufreq: Move the cfs_rq_util_change() call to cpufreq_update_util()")
> update_load_avg() has become the central point for calling cpufreq (not
> including the update of blocked load). This change helps to simplify
> further the number of call to cpufreq_update_util() and to remove last

s/call/calls/

And the patch looks reasonable to me.

> redundant ones. With update_load_avg(), we are now sure that
> cpufreq_update_util() will be called after every task attachment to a
> cfs_rq and especially after propagating this event down to the util_avg of
> the root cfs_rq, which is the level that is used by cpufreq governors like
> schedutil to set the frequency of a CPU.
> 
> The SCHED_CPUFREQ_MIGRATION flag forces an early call to cpufreq when the
> migration happens in a cgroup whereas util_avg of root cfs_rq is not yet
> updated and this call is duplicated with the one that happens immediately
> after when the migration event reaches the root cfs_rq. The dedicated flag
> SCHED_CPUFREQ_MIGRATION is now useless and can be removed. The interface of
> attach_entity_load_avg() can also be simplified accordingly.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  include/linux/sched/cpufreq.h |  1 -
>  kernel/sched/fair.c           | 14 +++++++-------
>  2 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
> index cc6bcc1e96bc..3ed5aa18593f 100644
> --- a/include/linux/sched/cpufreq.h
> +++ b/include/linux/sched/cpufreq.h
> @@ -9,7 +9,6 @@
>   */
>  
>  #define SCHED_CPUFREQ_IOWAIT	(1U << 0)
> -#define SCHED_CPUFREQ_MIGRATION	(1U << 1)
>  
>  #ifdef CONFIG_CPU_FREQ
>  struct cpufreq_policy;
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2d170b5da0e3..023aa42aaac7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -801,7 +801,7 @@ void post_init_entity_util_avg(struct task_struct *p)
>  		 * For !fair tasks do:
>  		 *
>  		update_cfs_rq_load_avg(now, cfs_rq);
> -		attach_entity_load_avg(cfs_rq, se, 0);
> +		attach_entity_load_avg(cfs_rq, se);
>  		switched_from_fair(rq, p);
>  		 *
>  		 * such that the next switched_to_fair() has the
> @@ -3114,7 +3114,7 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
>  {
>  	struct rq *rq = rq_of(cfs_rq);
>  
> -	if (&rq->cfs == cfs_rq || (flags & SCHED_CPUFREQ_MIGRATION)) {
> +	if (&rq->cfs == cfs_rq) {
>  		/*
>  		 * There are a few boundary cases this might miss but it should
>  		 * get called often enough that that should (hopefully) not be
> @@ -3520,7 +3520,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>   * Must call update_cfs_rq_load_avg() before this, since we rely on
>   * cfs_rq->avg.last_update_time being current.
>   */
> -static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> +static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  {
>  	u32 divider = LOAD_AVG_MAX - 1024 + cfs_rq->avg.period_contrib;
>  
> @@ -3556,7 +3556,7 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  
>  	add_tg_cfs_propagate(cfs_rq, se->avg.load_sum);
>  
> -	cfs_rq_util_change(cfs_rq, flags);
> +	cfs_rq_util_change(cfs_rq, 0);
>  
>  	trace_pelt_cfs_tp(cfs_rq);
>  }
> @@ -3614,7 +3614,7 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  		 *
>  		 * IOW we're enqueueing a task on a new CPU.
>  		 */
> -		attach_entity_load_avg(cfs_rq, se, SCHED_CPUFREQ_MIGRATION);
> +		attach_entity_load_avg(cfs_rq, se);
>  		update_tg_load_avg(cfs_rq, 0);
>  
>  	} else if (decayed) {
> @@ -3871,7 +3871,7 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  static inline void remove_entity_load_avg(struct sched_entity *se) {}
>  
>  static inline void
> -attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags) {}
> +attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
>  static inline void
>  detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
>  
> @@ -10439,7 +10439,7 @@ static void attach_entity_cfs_rq(struct sched_entity *se)
>  
>  	/* Synchronize entity with its cfs_rq */
>  	update_load_avg(cfs_rq, se, sched_feat(ATTACH_AGE_LOAD) ? 0 : SKIP_AGE_LOAD);
> -	attach_entity_load_avg(cfs_rq, se, 0);
> +	attach_entity_load_avg(cfs_rq, se);
>  	update_tg_load_avg(cfs_rq, false);
>  	propagate_entity_cfs_rq(se);
>  }
> 




