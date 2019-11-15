Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3EBFFDF3A
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 14:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfKONqe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 08:46:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57842 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbfKONqe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2019 08:46:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wC+9uuEJp26Sj5A4rHzaYFSX5ziFMg0AaRJ7JE8csaM=; b=PUqTHT4C8uDgsWsoQ004rD5AI
        6TrCbBj9b8PF9AYXQy5mO4S+YtrhDUba9Q02j5wUf32DvVWcI+oOZBDnOGcDBSZmU+aVoO3kyB0t1
        mrlk1xGNKhEgZsjVyqhVDgLn5eJEkt2akcwzTA4nW1jW6Ncc2Yf9smYfo12ophM02Dhl8b/EDp5uK
        lHjuVluUavnUbUCdTwxUczBj9OSRnwTQUnbEiLOyrXf4LlZZvGLMktU5HxkMs1nEdR+a/CNa+GEr7
        pX6C0CfDYX1hFxFDkdq9HENLAQg6Gd1oBovaTKJmptausmB/UwW8WA54eZtKHEwMXOXh2uDQeXpPw
        7QQAtGkow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVbvK-0002Oo-9N; Fri, 15 Nov 2019 13:46:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 325083006FB;
        Fri, 15 Nov 2019 14:44:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 523F72B12DAAC; Fri, 15 Nov 2019 14:46:03 +0100 (CET)
Date:   Fri, 15 Nov 2019 14:46:03 +0100
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
Message-ID: <20191115134603.GK4131@hirez.programming.kicks-ass.net>
References: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org>
 <20191115095447.GU4114@hirez.programming.kicks-ass.net>
 <CAKfTPtCTcrq1E1H8A3TL1xvALUrQ7ybPoERJ+C2O2+QXpVEZGQ@mail.gmail.com>
 <20191115103735.GE4131@hirez.programming.kicks-ass.net>
 <CAKfTPtDi_-h6g+rhV04XXjqpWprC2vT6hgLZSrTW5rdD54PrQA@mail.gmail.com>
 <20191115105110.GG4131@hirez.programming.kicks-ass.net>
 <CAKfTPtC3g4iCxvAJo9Km9fZ0fPSw5Jt9TY2+xF7kxGmOZ66gxw@mail.gmail.com>
 <20191115130144.GA4097@hirez.programming.kicks-ass.net>
 <CAKfTPtBrxqkoFeWkxX1J1QmhBpRfDh6nYs1wRA-WR8y15AmaYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBrxqkoFeWkxX1J1QmhBpRfDh6nYs1wRA-WR8y15AmaYQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 15, 2019 at 02:30:58PM +0100, Vincent Guittot wrote:
> On Fri, 15 Nov 2019 at 14:02, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Nov 15, 2019 at 12:03:31PM +0100, Vincent Guittot wrote:
> >
> > > This patch does 2 things:
> > > - fix the spurious call to cpufreq just before attaching a task
> >
> > Right, so that one doesn't concern me too much.
> >
> > > - make sure cpufreq is still called when cfs is 0 but not irq/rt or dl
> >
> > But per the rq->has_blocked_load logic we would mostly stop sending
> > events once we reach all 0s.
> >
> > Now, most of those updates will be through _nohz_idle_balance() ->
> > update_nohz_stats(), which are remote, which means intel_pstate is
> > ignoring them anyway.
> >
> > Now the _nohz_idle_balance() -> update_blocked_averages() thing runs
> > local, and that will update the one random idle CPU we picked to run
> > nohz balance, but all others will be left where they were.
> >
> > So why does intel_pstate care... Esp. on SKL+ with per-core P state this
> > is of dubious value.
> 
> Doug mentioned some periodic timers that were running on the CPUs
> 
> >
> > Also, and maybe I should go read back, why do we care what the P state
> > is when we're mostly in C states anyway? These are all idle CPUs,
> > otherwise we wouldkn't be running update_blocked_averages() on them
> > anyway.
> 
> AFAIU, there is not 100% idle but they have periodic timers that will
> fire and run at higher P state

If it is pure timers, I don't see how those CPUs end up calling
cpufreq_update_util().

Per the above argument, only the CPU that ran nohz balance gets an
update call, all the other CPUs that remain idle (or only serve IRQs)
never get the call.
