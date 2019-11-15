Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1621CFDBC1
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 11:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfKOKwG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 05:52:06 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41949 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfKOKwG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2019 05:52:06 -0500
Received: by mail-oi1-f193.google.com with SMTP id e9so8240110oif.8;
        Fri, 15 Nov 2019 02:52:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nOv8JeNlC2mI252aSJXP+QMtS/qGUyMu0OgZ22k7dKk=;
        b=fejNYyEJoXzyV8WdENnyLgsHWa+IjpyC15OwA5K0EKJnN3a5hos7bNM9kEvKVMZlvi
         YvlUiTyt6yjEYhqohTdQmVGogjvfwzYRvbVdy8pLtVVPHdg6OPA8KjpbM17a+9qDkMIj
         Gp38t23/OiBcozVg9b9HW3Nx4u/IPhK5RjhGWbPaX+Q9SjKLnZmcrR/ofiNGvRB4vQn8
         ditbegsOR3MXIjRz86ypWdsCseXAH30BZE/vcqUKkgjIkRf9dSXvPINl/A8VCcCN9V+Z
         +nnA4O0/6aQatJZlrqnVy16OcTwKfCNv4Tq5oNrNNc0zQqtoBlmmMmAeUd2q1SN59YtY
         W/uw==
X-Gm-Message-State: APjAAAUhIqZORG5zMwvV0cbCfScgLbL+7AGu+pVVyi/+qR8mYU/Nr+IB
        qu9wUiOG4fECk+gEMawsIbu4zCf61Tdw09YDVEY=
X-Google-Smtp-Source: APXvYqyTP0AhxC4iysEpy1bSC77jZ1CGXL9oZp/Aqz0IrV6eOeDilANFiQYp+VTO0GgLvrD61ZDyJFMxcwkbnmTxqNc=
X-Received: by 2002:aca:d4c6:: with SMTP id l189mr7152376oig.68.1573815124814;
 Fri, 15 Nov 2019 02:52:04 -0800 (PST)
MIME-Version: 1.0
References: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org>
 <20191115095447.GU4114@hirez.programming.kicks-ass.net> <CAKfTPtCTcrq1E1H8A3TL1xvALUrQ7ybPoERJ+C2O2+QXpVEZGQ@mail.gmail.com>
 <20191115103735.GE4131@hirez.programming.kicks-ass.net> <CAKfTPtDi_-h6g+rhV04XXjqpWprC2vT6hgLZSrTW5rdD54PrQA@mail.gmail.com>
In-Reply-To: <CAKfTPtDi_-h6g+rhV04XXjqpWprC2vT6hgLZSrTW5rdD54PrQA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Nov 2019 11:51:53 +0100
Message-ID: <CAJZ5v0hs96oq_AmYa0mVxWZa=fAsFqC8Ce4JPjLkgfWQ9P18Fg@mail.gmail.com>
Subject: Re: [PATCH v4] sched/freq: move call to cpufreq_update_util
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 15, 2019 at 11:46 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Fri, 15 Nov 2019 at 11:37, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Nov 15, 2019 at 11:18:00AM +0100, Vincent Guittot wrote:
> > > On Fri, 15 Nov 2019 at 10:55, Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Thu, Nov 14, 2019 at 06:07:31PM +0100, Vincent Guittot wrote:
> > > > > update_cfs_rq_load_avg() calls cfs_rq_util_change() everytime pelt decays,
> > > > > which might be inefficient when cpufreq driver has rate limitation.
> > > > >
> > > > > When a task is attached on a CPU, we have call path:
> > > > >
> > > > > update_load_avg()
> > > > >   update_cfs_rq_load_avg()
> > > > >     cfs_rq_util_change -- > trig frequency update
> > > > >   attach_entity_load_avg()
> > > > >     cfs_rq_util_change -- > trig frequency update
> > > > >
> > > > > The 1st frequency update will not take into account the utilization of the
> > > > > newly attached task and the 2nd one might be discard because of rate
> > > > > limitation of the cpufreq driver.
> > > >
> > > > Doesn't this just show that a dumb rate limit in the driver is broken?
> > >
> > > But the rate limit may come from HW constraints that forces to wait
> > > let say 4ms or even 10ms between each frequency update.
> >
> > Sure, but then it can still remember the value passed in last and use
> > that state later.
> >
> > It doesn't _have_ to completely discard values.
>
> yes but it means that we run at the "wrong" frequency during this
> period and also that the cpufreq must in this case set a kind of timer
> to resubmit a new frequency change out of scheduler event

The driver would need to do that, because from the cpufreq core
perspective it is in-band.

Which would kind of defeat the purpose of driving it from the
scheduler, wouldn't it?
