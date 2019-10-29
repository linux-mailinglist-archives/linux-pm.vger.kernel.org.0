Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3D4E9001
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 20:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbfJ2TeJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 15:34:09 -0400
Received: from mga04.intel.com ([192.55.52.120]:15752 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729253AbfJ2TeJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 29 Oct 2019 15:34:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 12:34:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,245,1569308400"; 
   d="scan'208";a="199013716"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga007.fm.intel.com with ESMTP; 29 Oct 2019 12:34:07 -0700
Message-ID: <10eef14e434375ef4bb7cf23ecb987b3591064a6.camel@linux.intel.com>
Subject: Re: [PATCH] Revert "sched/fair: Fix O(nr_cgroups) in the load
 balancing path"
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Doug Smythies <doug.smythies@gmail.com>, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Doug Smythies <dsmythies@telus.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, sargun@sargun.me,
        tj@kernel.org, xiexiuqi@huawei.com, xiezhipeng1@huawei.com
Date:   Tue, 29 Oct 2019 12:34:08 -0700
In-Reply-To: <1572018904-5234-1-git-send-email-dsmythies@telus.net>
References: <1572018904-5234-1-git-send-email-dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2019-10-25 at 08:55 -0700, Doug Smythies wrote:

[...]

> Experiment method:
> 
> enable only idle state 1
> Dountil stopped
>   apply a 100% load (all CPUs)
>   after awhile (about 50 seconds) remove the load.
>   allow a short transient delay (1 second).
>   measure the processor package joules used over the next 149
> seconds.
> Enduntil
> 
> Kernel k5.4-rc2 + reversion (this method)
> Average processor package power: 9.148 watts (128 samples, > 7 hours)
> Minimum: 9.02 watts
> Maximum: 9.29 watts
> Note: outlyer data point group removed, as it was assumed the
> computer
> had something to do and wasn't actually "idle".
> 
> Kernel 5.4-rc2:
> Average processor package power: 9.969 watts (150 samples, > 8 hours)
> Or 9% more energy for the idle phases of the work load.
> Minimum: 9.15 watts
> Maximum: 13.79 watts (51% more power)
Hi Doug,

Do you have intel_pstate_tracer output? I guess that when started
request to measure the measure joules, it started at higher P-state
without revert.
Other way is check by fixing the max and min scaling frequency to some
frequency, then we shouldn't see power difference.

Thanks,
Srinivas


> 
> ---
>  kernel/sched/fair.c | 43 +++++++++----------------------------------
>  1 file changed, 9 insertions(+), 34 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 83ab35e..51625b8 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -381,10 +381,9 @@ static inline void
> assert_list_leaf_cfs_rq(struct rq *rq)
>  	SCHED_WARN_ON(rq->tmp_alone_branch != &rq->leaf_cfs_rq_list);
>  }
>  
> -/* Iterate thr' all leaf cfs_rq's on a runqueue */
> -#define for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos)			
> \
> -	list_for_each_entry_safe(cfs_rq, pos, &rq->leaf_cfs_rq_list,	
> \
> -				 leaf_cfs_rq_list)
> +/* Iterate through all cfs_rq's on a runqueue in bottom-up order */
> +#define for_each_leaf_cfs_rq(rq, cfs_rq) \
> +	list_for_each_entry_rcu(cfs_rq, &rq->leaf_cfs_rq_list,
> leaf_cfs_rq_list)
>  
>  /* Do the two (enqueued) entities belong to the same group ? */
>  static inline struct cfs_rq *
> @@ -481,8 +480,8 @@ static inline void assert_list_leaf_cfs_rq(struct
> rq *rq)
>  {
>  }
>  
> -#define for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos)	\
> -		for (cfs_rq = &rq->cfs, pos = NULL; cfs_rq; cfs_rq =
> pos)
> +#define for_each_leaf_cfs_rq(rq, cfs_rq)	\
> +		for (cfs_rq = &rq->cfs; cfs_rq; cfs_rq = NULL)
>  
>  static inline struct sched_entity *parent_entity(struct sched_entity
> *se)
>  {
> @@ -7502,27 +7501,10 @@ static inline void
> update_blocked_load_status(struct rq *rq, bool has_blocked) {
>  
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  
> -static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
> -{
> -	if (cfs_rq->load.weight)
> -		return false;
> -
> -	if (cfs_rq->avg.load_sum)
> -		return false;
> -
> -	if (cfs_rq->avg.util_sum)
> -		return false;
> -
> -	if (cfs_rq->avg.runnable_load_sum)
> -		return false;
> -
> -	return true;
> -}
> -
>  static void update_blocked_averages(int cpu)
>  {
>  	struct rq *rq = cpu_rq(cpu);
> -	struct cfs_rq *cfs_rq, *pos;
> +	struct cfs_rq *cfs_rq;
>  	const struct sched_class *curr_class;
>  	struct rq_flags rf;
>  	bool done = true;
> @@ -7534,7 +7516,7 @@ static void update_blocked_averages(int cpu)
>  	 * Iterates the task_group tree in a bottom up fashion, see
>  	 * list_add_leaf_cfs_rq() for details.
>  	 */
> -	for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos) {
> +	for_each_leaf_cfs_rq(rq, cfs_rq) {
>  		struct sched_entity *se;
>  
>  		if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq),
> cfs_rq))
> @@ -7545,13 +7527,6 @@ static void update_blocked_averages(int cpu)
>  		if (se && !skip_blocked_update(se))
>  			update_load_avg(cfs_rq_of(se), se, 0);
>  
> -		/*
> -		 * There can be a lot of idle CPU cgroups.  Don't let
> fully
> -		 * decayed cfs_rqs linger on the list.
> -		 */
> -		if (cfs_rq_is_decayed(cfs_rq))
> -			list_del_leaf_cfs_rq(cfs_rq);
> -
>  		/* Don't need periodic decay once load/util_avg are
> null */
>  		if (cfs_rq_has_blocked(cfs_rq))
>  			done = false;
> @@ -10444,10 +10419,10 @@ const struct sched_class fair_sched_class =
> {
>  #ifdef CONFIG_SCHED_DEBUG
>  void print_cfs_stats(struct seq_file *m, int cpu)
>  {
> -	struct cfs_rq *cfs_rq, *pos;
> +	struct cfs_rq *cfs_rq;
>  
>  	rcu_read_lock();
> -	for_each_leaf_cfs_rq_safe(cpu_rq(cpu), cfs_rq, pos)
> +	for_each_leaf_cfs_rq(cpu_rq(cpu), cfs_rq)
>  		print_cfs_rq(m, cpu, cfs_rq);
>  	rcu_read_unlock();
>  }

