Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBAC106E3
	for <lists+linux-pm@lfdr.de>; Wed,  1 May 2019 12:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbfEAKT1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 06:19:27 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55722 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfEAKT0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 06:19:26 -0400
Received: from 79.184.254.69.ipv4.supernova.orange.pl (79.184.254.69) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 70b3b62544c16d63; Wed, 1 May 2019 12:19:24 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Kyle Lin <linkyle0915@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: stats: Use lock by stat to replace global spin lock
Date:   Wed, 01 May 2019 12:19:24 +0200
Message-ID: <10618804.orJkbRSvsU@kreacher>
In-Reply-To: <20190409092752.kvaiq2gqjqjmy3pr@vireshk-i7>
References: <20190409084304.35855-1-linkyle0915@gmail.com> <20190409092752.kvaiq2gqjqjmy3pr@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday, April 9, 2019 11:27:52 AM CEST Viresh Kumar wrote:
> On 09-04-19, 16:43, Kyle Lin wrote:
> > Stats is updated by each policy, using the lock by stat can
> > reduce the contention.
> > 
> > Signed-off-by: Kyle Lin <linkyle0915@gmail.com>
> > ---
> > Changes in v2:
> >   - Drop the comment of the lock.
> > 
> >  drivers/cpufreq/cpufreq_stats.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> > index e2db5581489a..08b192eb22c6 100644
> > --- a/drivers/cpufreq/cpufreq_stats.c
> > +++ b/drivers/cpufreq/cpufreq_stats.c
> > @@ -14,7 +14,6 @@
> >  #include <linux/module.h>
> >  #include <linux/slab.h>
> >  
> > -static DEFINE_SPINLOCK(cpufreq_stats_lock);
> >  
> >  struct cpufreq_stats {
> >  	unsigned int total_trans;
> > @@ -23,6 +22,7 @@ struct cpufreq_stats {
> >  	unsigned int state_num;
> >  	unsigned int last_index;
> >  	u64 *time_in_state;
> > +	spinlock_t lock;
> >  	unsigned int *freq_table;
> >  	unsigned int *trans_table;
> >  };
> > @@ -39,12 +39,12 @@ static void cpufreq_stats_clear_table(struct cpufreq_stats *stats)
> >  {
> >  	unsigned int count = stats->max_state;
> >  
> > -	spin_lock(&cpufreq_stats_lock);
> > +	spin_lock(&stats->lock);
> >  	memset(stats->time_in_state, 0, count * sizeof(u64));
> >  	memset(stats->trans_table, 0, count * count * sizeof(int));
> >  	stats->last_time = get_jiffies_64();
> >  	stats->total_trans = 0;
> > -	spin_unlock(&cpufreq_stats_lock);
> > +	spin_unlock(&stats->lock);
> >  }
> >  
> >  static ssize_t show_total_trans(struct cpufreq_policy *policy, char *buf)
> > @@ -62,9 +62,9 @@ static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
> >  	if (policy->fast_switch_enabled)
> >  		return 0;
> >  
> > -	spin_lock(&cpufreq_stats_lock);
> > +	spin_lock(&stats->lock);
> >  	cpufreq_stats_update(stats);
> > -	spin_unlock(&cpufreq_stats_lock);
> > +	spin_unlock(&stats->lock);
> >  
> >  	for (i = 0; i < stats->state_num; i++) {
> >  		len += sprintf(buf + len, "%u %llu\n", stats->freq_table[i],
> > @@ -211,6 +211,7 @@ void cpufreq_stats_create_table(struct cpufreq_policy *policy)
> >  	stats->state_num = i;
> >  	stats->last_time = get_jiffies_64();
> >  	stats->last_index = freq_table_get_index(stats, policy->cur);
> > +	spin_lock_init(&stats->lock);
> >  
> >  	policy->stats = stats;
> >  	ret = sysfs_create_group(&policy->kobj, &stats_attr_group);
> > @@ -242,11 +243,11 @@ void cpufreq_stats_record_transition(struct cpufreq_policy *policy,
> >  	if (old_index == -1 || new_index == -1 || old_index == new_index)
> >  		return;
> >  
> > -	spin_lock(&cpufreq_stats_lock);
> > +	spin_lock(&stats->lock);
> >  	cpufreq_stats_update(stats);
> >  
> >  	stats->last_index = new_index;
> >  	stats->trans_table[old_index * stats->max_state + new_index]++;
> >  	stats->total_trans++;
> > -	spin_unlock(&cpufreq_stats_lock);
> > +	spin_unlock(&stats->lock);
> >  }
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Patch applied, thanks!



