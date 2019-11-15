Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB71FDF9D
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 15:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfKOOGl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 09:06:41 -0500
Received: from merlin.infradead.org ([205.233.59.134]:60810 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfKOOGl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2019 09:06:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EESgAJ1TE14/ilPJDdeHT/O0bpBL1CggBzBhGTo6EWE=; b=nNcoGdvPpOOcrwHD4iBeEos0Z
        5SdalHvw7KysG2cLC6tdPL5DFTCV0pHbDR+8q1XfA8vh+/NGLfXEmN62JKgw08OCt32TQLFUxxGbi
        DimiCNSsn86tm0YraVMI5gInN9S2R8B+izsblgDyZsroEwlQ39D8FLIOoPKskG+O04/6JL4Tq4YXe
        ftWhl0ley4MkYw8lLfEJHY8fNKrnHZWLvzTjxguL+xd1yCcelOXqEtlY7J5y9zCq2F8fuT6wTOHPt
        +KVUxcvM77HydlF7OLSi7JE6NxvFR0eCQEf2OCEPSj0rbvSq2rXn2bq7qL+wKmGYxrVjIssf2FI0B
        OqEBbxw1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVcEZ-0008V3-42; Fri, 15 Nov 2019 14:05:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4433F304637;
        Fri, 15 Nov 2019 15:04:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6691E2B12E78E; Fri, 15 Nov 2019 15:05:55 +0100 (CET)
Date:   Fri, 15 Nov 2019 15:05:55 +0100
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
Message-ID: <20191115140555.GL4131@hirez.programming.kicks-ass.net>
References: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org>
 <20191115132520.GJ4131@hirez.programming.kicks-ass.net>
 <CAKfTPtB4UGmZ53iVRsOV+k4MiS=Dzqw2-6_sBhko0bHRMAed2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtB4UGmZ53iVRsOV+k4MiS=Dzqw2-6_sBhko0bHRMAed2g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 15, 2019 at 02:37:27PM +0100, Vincent Guittot wrote:
> On Fri, 15 Nov 2019 at 14:25, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Nov 14, 2019 at 06:07:31PM +0100, Vincent Guittot wrote:

> > > +     decayed = update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
> > > +     decayed |= update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
> > > +     decayed |= update_irq_load_avg(rq, 0);
> >
> > Should not all 3 have their windows aligned and thus alway return the
> > exact same value?
> 
> rt and dl yes but not irq

Any reason for IRQ not to be aligned?

> But having aligned window doesn't mean that they will all decay.
> One can have been updated just before (during a dequeue as an example)
> or at least less than 1ms before

Bah... true.
