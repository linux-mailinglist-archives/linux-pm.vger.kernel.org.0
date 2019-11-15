Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB24CFDB63
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 11:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfKOK3T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 05:29:19 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42816 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbfKOK3S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2019 05:29:18 -0500
Received: by mail-lj1-f194.google.com with SMTP id n5so10124356ljc.9
        for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2019 02:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PNO7uhgp1dcpLp+jSsP4cB4QzEUZpe1GKQTX+AAJeuY=;
        b=q0G6wd3wtT1g3Ze5W4bLdIwUj2olQvXCc26kmtZu4cGRHUgr0c2yofqR/zp1BazHVd
         4GurAZcPwsvrmGAMNxAnQLpstMvjDpGtH0cbKMLR8ZauXVjV76MPSante0JjgH8u0JhN
         1tY882Wfa50TCIHKGdfprKC990u64sTz9OwKHeoeV3nj5Qfeox4tA0qEMn1OZuDvvQMM
         n+i0DaoCXK3ULsgRg1BV+JFn+ySXVebWnu6u842J5Ps6TMSfFAkuYFmxUMNnpCVZoD06
         pf7ZUXgpfAmis/wJagvkYIqnCznjwZBfMMLaSQOO4TR0ZlmjGK/owvZA3snF4CV/F34n
         taQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PNO7uhgp1dcpLp+jSsP4cB4QzEUZpe1GKQTX+AAJeuY=;
        b=kTPQwqlfZV9HbacUwRAC/LAFqJiunSKM1ImdoG7vXUAynQ+dcKzj0oMx3STh4VdFQE
         AJOEhaIzY6hCDOuRE87XiPhxVDmTSqmdaSs5AimTZojmlpKcguOp4G4r3mXav5oML9v8
         ho7J0H4omYwL0SS6gNJYBS00AcbhU18z3Cd84i2nv8obvJamROuAcwNt/bMDFfbiTPlR
         icOTw2DKDQdljfDPMtNKtuQFaDwYeL/o2BuQt+IMtDdArRC6uLNWcnrFMcfKB1Retemn
         cJ38bCikIAX/IxJwz/6GdQsjGJdu6IbqPJGnandRKT8HemqHaKpQATkuG0d0y9D5lwza
         hqNA==
X-Gm-Message-State: APjAAAUX++TargNmkWaMTbzFV0mmI9IGcDM4zGB6k7I3OoekWvlXQglR
        aySSKMOdMOXD02j2H7fYAsw2S6KNcO1+HaKpagDt2g==
X-Google-Smtp-Source: APXvYqxS72HHnU9jyNroqC25BDaEGu7VNx5qQYXeMTZC7ZEf2Rk0L9H2sBLv3DCxNHHvulZNf2UsHJOXSc7+dOL5STM=
X-Received: by 2002:a2e:b0e3:: with SMTP id h3mr10169336ljl.193.1573813755258;
 Fri, 15 Nov 2019 02:29:15 -0800 (PST)
MIME-Version: 1.0
References: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org>
 <20191115095447.GU4114@hirez.programming.kicks-ass.net> <CAKfTPtCTcrq1E1H8A3TL1xvALUrQ7ybPoERJ+C2O2+QXpVEZGQ@mail.gmail.com>
In-Reply-To: <CAKfTPtCTcrq1E1H8A3TL1xvALUrQ7ybPoERJ+C2O2+QXpVEZGQ@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 15 Nov 2019 11:29:03 +0100
Message-ID: <CAKfTPtA-up_9WHfTka33WRxXCatUZioYS0v5gY9jjzOGT98oLQ@mail.gmail.com>
Subject: Re: [PATCH v4] sched/freq: move call to cpufreq_update_util
To:     Peter Zijlstra <peterz@infradead.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 15 Nov 2019 at 11:18, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Fri, 15 Nov 2019 at 10:55, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Nov 14, 2019 at 06:07:31PM +0100, Vincent Guittot wrote:
> > > update_cfs_rq_load_avg() calls cfs_rq_util_change() everytime pelt decays,
> > > which might be inefficient when cpufreq driver has rate limitation.
> > >
> > > When a task is attached on a CPU, we have call path:
> > >
> > > update_load_avg()
> > >   update_cfs_rq_load_avg()
> > >     cfs_rq_util_change -- > trig frequency update
> > >   attach_entity_load_avg()
> > >     cfs_rq_util_change -- > trig frequency update
> > >
> > > The 1st frequency update will not take into account the utilization of the
> > > newly attached task and the 2nd one might be discard because of rate
> > > limitation of the cpufreq driver.
> >
> > Doesn't this just show that a dumb rate limit in the driver is broken?
>
> But the rate limit may come from HW constraints that forces to wait
> let say 4ms or even 10ms between each frequency update.
>
> >
> > > update_cfs_rq_load_avg() is only called by update_blocked_averages()
> > > and update_load_avg() so we can move the call to
> > > cfs_rq_util_change/cpufreq_update_util() into these 2 functions. It's also
> > > interesting to notice that update_load_avg() already calls directly
> > > cfs_rq_util_change() for !SMP case.
> > >
> > > This changes will also ensure that cpufreq_update_util() is called even
> > > when there is no more CFS rq in the leaf_cfs_rq_list to update but only
> > > irq, rt or dl pelt signals.
> >
> > I don't think it does that; that is, iirc the return value of
> > ___update_load_sum() is 1 every time a period lapses. So even if the avg
> > is 0 and doesn't change, it'll still return 1 on every period.
> >
> > Which is what that dumb rate-limit thing wants of course. But I'm still
> > thinking that it's stupid to do. If nothing changes, don't generate
> > events.
>
> When everything (irq, dl, rt, cfs) is 0, we don't generate events
> because update_blocked_averages is no more called because
> rq->has_blocked_load is clear
>
> With current implementation, if cfs is 0 but not irq, dl or rt, we
> don't call cpufreq_update_util because it is only called through cfs
>
> >
> > If anything, update_blocked_avgerages() should look at
> > @done/others_have_blocked() to emit events for rt,dl,irq.
>
> other_have_blocked can be set but no decay happened during the update
> and we don't need to call cpufreq_update_util
>
> >
> > So why are we making the scheduler code more ugly instead of fixing that
> > driver?

Also, I think that calling cfs_rq_util_change in
attach_entity_load_avg is not optimal because the attach can happen at
a child level before it has been propagated down to root
So I'm working on trying to remove it from attach_entity_load_avg and
keep it in update_load_avg. this would help cleaning the ugly

-       } else if (decayed && (flags & UPDATE_TG))
-               update_tg_load_avg(cfs_rq, 0);
+       } else if (decayed) {
+               cfs_rq_util_change(cfs_rq, 0);
+
+               if (flags & UPDATE_TG)
+                       update_tg_load_avg(cfs_rq, 0);
+       }
 }
