Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 858AAFE443
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 18:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbfKORoZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 12:44:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49488 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfKORoZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2019 12:44:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Elg7Tj8yjS/b/ScYw/Zf/Uu5gZwsbcJit98EjXWYU08=; b=QHwa1471lA8KkwjDIvNIB3sRN
        HRVpVP0oiyqHlfm/pRAycgcBULkejAuVLVsv/za4wK6oe7fFSiyCYxtA08V6Ps2efmGqKZzX//t4F
        wEso6OHL4yD/69r4T9Ixj6snzrB8bAK5B0mDOi/RAd3rSOvmAVRe5D2Wi/JcTaFgcFg6YC/DyImFb
        dpA0GBz6XRDZzZzod2xAc/YEpwA3OolGB0XyVpnTLSp2Oh6TJIVF9EhoRt0aYP+UHKiJwcoJDdPDf
        VRe11Q7oVDQ3I8/F7Je+uc07+02jmIzBGR9pIe0b4Znp2ojwyXLjYMcPvsrjuh+5fJeoEcAv9ycdc
        wexEl+qpw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVfdX-0008VF-1i; Fri, 15 Nov 2019 17:43:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 91517303D9F;
        Fri, 15 Nov 2019 18:42:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A520B2B130F61; Fri, 15 Nov 2019 18:43:55 +0100 (CET)
Date:   Fri, 15 Nov 2019 18:43:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Doug Smythies <dsmythies@telus.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sargun Dhillon <sargun@sargun.me>, Tejun Heo <tj@kernel.org>,
        Xie XiuQi <xiexiuqi@huawei.com>, xiezhipeng1@huawei.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v4] sched/freq: move call to cpufreq_update_util
Message-ID: <20191115174355.GP4131@hirez.programming.kicks-ass.net>
References: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org>
 <20191115132520.GJ4131@hirez.programming.kicks-ass.net>
 <CAKfTPtB4UGmZ53iVRsOV+k4MiS=Dzqw2-6_sBhko0bHRMAed2g@mail.gmail.com>
 <20191115151220.GO4131@hirez.programming.kicks-ass.net>
 <CAKfTPtCg-zEysYmGSFTa4bjh0D=sf1UsT0WpeWcVrb9SLt+VZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCg-zEysYmGSFTa4bjh0D=sf1UsT0WpeWcVrb9SLt+VZw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 15, 2019 at 04:31:35PM +0100, Vincent Guittot wrote:

> > @@ -7476,10 +7477,14 @@ static void update_blocked_averages(int cpu)
> >          * list_add_leaf_cfs_rq() for details.
> >          */
> >         for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos) {
> > +               bool last = cfs_rq == &rq->cfs;
> >                 struct sched_entity *se;
> >
> > -               if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq))
> > +               if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq)) {
> >                         update_tg_load_avg(cfs_rq, 0);
> > +                       if (last)
> 
> using this last make code more readable
> 
> > +                               decayed = true;
> > +               }
> >
> >                 /* Propagate pending load changes to the parent, if any: */
> >                 se = cfs_rq->tg->se[cpu];
> > @@ -7490,7 +7495,7 @@ static void update_blocked_averages(int cpu)
> >                  * There can be a lot of idle CPU cgroups.  Don't let fully
> >                  * decayed cfs_rqs linger on the list.
> >                  */
> > -               if (cfs_rq_is_decayed(cfs_rq))
> > +               if (!last && cfs_rq_is_decayed(cfs_rq))
> >                         list_del_leaf_cfs_rq(cfs_rq);
> 
> Keeping root cfs in the list will not change anything now that
> cfs_rq_util_change is in update_load_avg()
> cfs_rq_util_change will not be called

Oh but it does, since it will then keep triggering that hunk above on
every period.

> >
> >                 /* Don't need periodic decay once load/util_avg are null */
> > @@ -7498,6 +7503,9 @@ static void update_blocked_averages(int cpu)
> >                         done = false;
> >         }
> >
> > +       if (decayed || done)
> 
> I'm not sure to get why you want to call cpufreq when done is true
> which means that everything reaches 0
> Why do you prefer to use done instead of ORing the decay of  rt, dl,
> irq and cfs ?
> 
> > +               cpufreq_update_util(rq, 0);

Because we don't care about the rt,dl,irq decay anywhere else either. We
only call cpufreq_update_util() for rq->cfs changes.

Also, as I argued, realistically rt,dl and cfs decay on the same edge,
so aside from some fuzz on the first period, they're all the same. But
even if they were not, why would we care about their exact edges here
when we do no anywhere else.

Not caring reduces the number of cpufreq_update_util() calls to one per
period, instead of potentially many more.

Doing the || done ensures never miss the all 0 case.
