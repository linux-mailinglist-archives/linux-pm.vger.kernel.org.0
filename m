Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5732AB84E
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 13:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgKIMeX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 07:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgKIMeW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 07:34:22 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2EEC0613CF;
        Mon,  9 Nov 2020 04:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DwDvxv7WLb7DK+KemO72iTYuMK2pG/etdrz51DTPEF0=; b=QxVbTOuA/n7a37SnWclYr3N0Ug
        yXUd1batHmKaLkwRSK2tLisODgZKHzM2nm0XtE+MMRZ3k4/tRCvQ6q2i7z9Z3WHNoVGqphsheYol/
        hkITLN65MF8qW1cpXrbiEsjr4OJCe2eXbYkGc1UdrllsFeKi39MPaKOgpTYlV/XkC6RCy8PnEMokn
        0/dgQN7/wk5REx8ofrLbrC7zwUpAZBnjWVJ/Y809YAjX/IAoB+fo9SsNEl5z95r3Cn+50+ZWkYNpw
        cIrDT0h3AkDciyF23fHAF8azXMKHCGf9uhuPRfriYR7J604lKJ73pdyFrI/t5Ml2SdXboMafR7y3u
        HxOzLJVg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kc6NF-0003hq-Ik; Mon, 09 Nov 2020 12:34:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 46080301324;
        Mon,  9 Nov 2020 13:34:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2AF76203E2240; Mon,  9 Nov 2020 13:34:16 +0100 (CET)
Date:   Mon, 9 Nov 2020 13:34:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 4/5] cpuidle: governor: Export the needed symbols
Message-ID: <20201109123416.GO2594@hirez.programming.kicks-ass.net>
References: <20201015144431.9979-1-daniel.lezcano@linaro.org>
 <20201015144431.9979-4-daniel.lezcano@linaro.org>
 <CAJZ5v0i-1eZ+j_6C83qs1-q1FSw0Yx96yQyy0KQBvDxX6KF=3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i-1eZ+j_6C83qs1-q1FSw0Yx96yQyy0KQBvDxX6KF=3w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 05, 2020 at 03:04:10PM +0100, Rafael J. Wysocki wrote:
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 2d95dc3f4644..ceba61bb364d 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3838,6 +3838,7 @@ unsigned long nr_iowait_cpu(int cpu)
> >  {
> >         return atomic_read(&cpu_rq(cpu)->nr_iowait);
> >  }
> > +EXPORT_SYMBOL_GPL(nr_iowait_cpu);
> 
> Hmm.  See below.

Did anyone read the comment above this function? It's garbage, it should
be deleted, not made available to a wider audience.

> >  /*
> >   * IO-wait accounting, and how its mostly bollocks (on SMP).
> > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > index f0199a4ba1ad..537716124d46 100644
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -500,12 +500,19 @@ static int __init setup_tick_nohz(char *str)
> >
> >  __setup("nohz=", setup_tick_nohz);
> >
> > +bool tick_nohz_is_enabled(void)
> > +{
> > +       return tick_nohz_enabled;
> > +}
> > +EXPORT_SYMBOL_GPL(tick_nohz_is_enabled);
> > +
> >  bool tick_nohz_tick_stopped(void)
> >  {
> >         struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
> >
> >         return ts->tick_stopped;
> >  }
> > +EXPORT_SYMBOL_GPL(tick_nohz_tick_stopped);
> >
> >  bool tick_nohz_tick_stopped_cpu(int cpu)
> >  {
> > @@ -1066,6 +1073,7 @@ bool tick_nohz_idle_got_tick(void)
> >         }
> >         return false;
> >  }
> > +EXPORT_SYMBOL_GPL(tick_nohz_idle_got_tick);
> >
> >  /**
> >   * tick_nohz_get_next_hrtimer - return the next expiration time for the hrtimer
> > @@ -1117,6 +1125,7 @@ ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
> >
> >         return ktime_sub(next_event, now);
> >  }
> > +EXPORT_SYMBOL_GPL(tick_nohz_get_sleep_length);
> 
> Peter please correct me if I'm mistaken, but IMV the above are core
> kernel internals and they should not be accessible to random modular
> stuff.

Yeah,... making this available seems unfortunate. Also, I don't really
see the point, why do we want the idle governors as modules? On the
cpufreq side we're trying to move away from modules and multiple
governors.
