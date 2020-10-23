Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D99296F4E
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 14:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463924AbgJWMfL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 08:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S463923AbgJWMfK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 08:35:10 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7059FC0613D2
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2020 05:35:10 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id x16so1393871ljh.2
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2020 05:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EXpmrkvu8zlC2xruLg/OSGhDpiXeBsCRsjiNOeLU1Ko=;
        b=ob8THlmSGowkz7phR4jo8AhZcnJZlbC7a3SJAQY+QN/d1jDZH0eB8kd03C43q25j8q
         KHjumT5jnupK/thX1b2BOk+9DI+l5norLBXzid7SdfiDydTiSFFD4KCQXESvXHFdKZ93
         ubrooeKF7Xywk+yKayBfNv43O1ui4BFCXFgQoAOEvbZ85QSqE72Z2Nol2R4zJj8M4OrX
         WQMYJ4LhzaGh/4leWqZiqjX5ULqd11BISA9so+vDT+Wui7q14lp7aOpeWV5yei2uexFL
         w4uM3/bDLVjL87J3E7dtB205TD/vlUU/KdWUpQOzAP5FVHEfHFpDT3t3O1Auv0fjczSM
         FIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EXpmrkvu8zlC2xruLg/OSGhDpiXeBsCRsjiNOeLU1Ko=;
        b=GSGptDcJalKUewLvbLAGmCpZfGE0Dfzma/jicDlo9FmvBXLa0npQUgl3aqxulFQBpV
         93w+Qa/gzAHMqgfy3QZ4FYiQC5heHuUIizyasr7UqaptgWidrMqMcFN6SQPjW8k1jing
         CiNs1p/MFeJXBRIONIbM0ZgTuXp1z9cqsfNv1H2TGuORqoDe8gr6kTllmuBkKCAtheTa
         pcWAUb0qNDFPEt2hiPP3xw0AMPuzY6aEQk0bYHngRNklp+BE7cJ04b4sU2PDTCsHxTzE
         q7mKQlU0NVQQ3a8i1SwbOFz9VNW8KQXAok/tOHUocjVG6Ab8OaZT7ydKvBGRL4f7/PO/
         Y7zw==
X-Gm-Message-State: AOAM533Nu7gbrkPzoxGF1qKZkfBRJlDZrr0iCBFVDeVi3pyW5Ne5zpeO
        QSR9yp+BIRc3JgHjqKiSSZALXyFyZsIatftdm55HjQ==
X-Google-Smtp-Source: ABdhPJz6usW+aAYfE9TyQ0cxzAQLfqJJuG5E+8VvUtJGsLR5/MdReVwJhZyRr2z3Eq3n5GTB7vWebzWkiAQBkdUO+zs=
X-Received: by 2002:a2e:7803:: with SMTP id t3mr718553ljc.156.1603456508850;
 Fri, 23 Oct 2020 05:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603448113.git.viresh.kumar@linaro.org> <80c66f55ac7f04b3ecd4ebf12d69d86c89480fa7.1603448113.git.viresh.kumar@linaro.org>
 <20201023103407.GK2594@hirez.programming.kicks-ass.net> <20201023105452.aivb5o6dws76evc3@vireshk-i7>
In-Reply-To: <20201023105452.aivb5o6dws76evc3@vireshk-i7>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 23 Oct 2020 14:34:57 +0200
Message-ID: <CAKfTPtBgqiR1zaoqL_q_sMNnXYrzZczTeE1TMF+WR6knHFjGRw@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] sched/core: Rename and move schedutil_cpu_util()
 to core.c
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Quentin Perret <qperret@google.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 23 Oct 2020 at 12:54, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 23-10-20, 12:34, Peter Zijlstra wrote:
> > On Fri, Oct 23, 2020 at 03:50:20PM +0530, Viresh Kumar wrote:
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index d2003a7d5ab5..369ff54d11d4 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -5117,6 +5117,119 @@ struct task_struct *idle_task(int cpu)
> > >     return cpu_rq(cpu)->idle;
> > >  }
> > >
> > > +/*
> > > + * This function computes an effective utilization for the given CPU, to be
> > > + * used for frequency selection given the linear relation: f = u * f_max.
> > > + *
> > > + * The scheduler tracks the following metrics:
> > > + *
> > > + *   cpu_util_{cfs,rt,dl,irq}()
> > > + *   cpu_bw_dl()
> > > + *
> > > + * Where the cfs,rt and dl util numbers are tracked with the same metric and
> > > + * synchronized windows and are thus directly comparable.
> > > + *
> > > + * The cfs,rt,dl utilization are the running times measured with rq->clock_task
> > > + * which excludes things like IRQ and steal-time. These latter are then accrued
> > > + * in the irq utilization.
> > > + *
> > > + * The DL bandwidth number otoh is not a measured metric but a value computed
> > > + * based on the task model parameters and gives the minimal utilization
> > > + * required to meet deadlines.
> > > + */
> > > +unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
> > > +                            unsigned long max, enum cpu_util_type type,
> > > +                            struct task_struct *p)
> > > +{
> >       ...
> > > +}
> > > +
> > > +unsigned long sched_cpu_util(int cpu, enum cpu_util_type type,
> > > +                        unsigned long max)
> > > +{
> > > +   return effective_cpu_util(cpu, cpu_util_cfs(cpu_rq(cpu)), max, type,
> > > +                             NULL);
> > > +}
> >
> > Shouldn't all that be: #ifdef CONFIG_SMP ?
>
> I didn't realize that these matrices are only available in case of SMP
> and that's why schedutil isn't available for !SMP. I wonder what we

Maybe it's time to make sched_util and pelt available for !SMP too.

With util_est and uclamp, I can see some benefits for !SMP compare to ondemand

> should be doing in cpufreq_cooling now ? Make it depend on SMP ? Or
> calculate load the traditional way (the stuff I just removed) for !SMP
> case ?
>
> :)
>
> --
> viresh
