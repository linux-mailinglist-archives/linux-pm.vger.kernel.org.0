Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72135F96FC
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2019 18:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKLRVL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Nov 2019 12:21:11 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33546 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfKLRVL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Nov 2019 12:21:11 -0500
Received: by mail-lf1-f66.google.com with SMTP id d6so13100177lfc.0
        for <linux-pm@vger.kernel.org>; Tue, 12 Nov 2019 09:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b5fDbApjKbQXmX0rR85/pftKRLxjK2Tg7QN5BVmg42M=;
        b=JKQJCuq9s0hJMHC/fLGFr+lsqMghhfoavYWjdyT6WGk/uIOLC7bMLfw8AeXc/3+Vk5
         W3sn6Iwcm5J03TnrOa0xllu1hQgpPx9D6e942muNF+yhl2OJ+Fy8ws4UyubhN2Rr+PIp
         H5D7OR78BS8WOCf4rm18xnyNcTlayW9qKBKNILd32t5lbOjmlSiStQhe+qqOco8+6b3N
         FTjlndP3N/cbxkCKQySywblvE42KASIK1eIf/CnOVG9ufTDm0YftuBERsDYqjaPjILuZ
         BE6+Xngj+Dm3CcCB0BMeuYczDNIG1iN0deNtKSXFk0mDG5oj0SzhgY7a5qDlcwfNhPEY
         8HCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b5fDbApjKbQXmX0rR85/pftKRLxjK2Tg7QN5BVmg42M=;
        b=lz3sXjyePyeZJNbEkfIVJFN58ndtJmEg2BvyX62naUfETqwkpnqIJJuIyxJSsxWT3H
         xU3tQlIPA3fEcwnNnoVgZJt1M6H/c/SWLc1wNBXa+73rngignR4n0yASQ1Ds/uhN+lcI
         UYzj8qiQUIatNPwmesBD8EQXZULU/T2V6OHz2vKVTz9bbIfHF3GRtauWgczg1Xiy4Ptk
         24vnfcuAxkfrxUMYz1nil1xVJrzJLCGOPHCt4R6AutygPm1VN8XSsyNw/maUboD9Bob3
         Hsfv0tAESgCFml2tiu/6gHP90CJnbV3V3531GQavJx5EdyhPeSo5Ti5hbn9EonpEzgH8
         0ymQ==
X-Gm-Message-State: APjAAAWIOLY1CtjfN4hN8QdaetfOZp3ze2cleKVVW9mpa7BOgYgbg0//
        pejVz5mZgMBxcG2HDSkiRkzFHEHDn+fvtgdr1b/DGg==
X-Google-Smtp-Source: APXvYqwpta/gsSZDZVP/J0C1gtL/VrrATsv2UTWozfFFXXndIiFUHXFw4NJYkeeIzbXDrA/NXRdJAHObql5bCcgyLKM=
X-Received: by 2002:a19:800a:: with SMTP id b10mr20916798lfd.15.1573579268285;
 Tue, 12 Nov 2019 09:21:08 -0800 (PST)
MIME-Version: 1.0
References: <1573570093-1340-1-git-send-email-vincent.guittot@linaro.org>
 <20191112150544.GA3664@linaro.org> <e6687868-835b-0d01-5e00-c3eaec1cd62c@arm.com>
In-Reply-To: <e6687868-835b-0d01-5e00-c3eaec1cd62c@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 12 Nov 2019 18:20:56 +0100
Message-ID: <CAKfTPtALVtNKCSbBG=EFL3+mLV=eierfrvdExkMJdczF+a9x_w@mail.gmail.com>
Subject: Re: [PATCH v2] sched/freq: move call to cpufreq_update_util
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 12 Nov 2019 at 18:11, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> Hi Vincent,
>
> I didn't see anything in that reply, was that just a spurious email?

there were a typo in one email address in the 1st message

>
> On 12/11/2019 15:05, Vincent Guittot wrote:
> > Le Tuesday 12 Nov 2019 =C3=A0 15:48:13 (+0100), Vincent Guittot a =C3=
=A9crit :
> >> update_cfs_rq_load_avg() calls cfs_rq_util_change() everytime pelt dec=
ays,
> >> which might be inefficient when cpufreq driver has rate limitation.
> >>
> >> When a task is attached on a CPU, we have call path:
> >>
> >> update_blocked_averages()
> >>   update_cfs_rq_load_avg()
> >>     cfs_rq_util_change -- > trig frequency update
> >>   attach_entity_load_avg()
> >>     cfs_rq_util_change -- > trig frequency update
> >>
> >> The 1st frequency update will not take into account the utilization of=
 the
> >> newly attached task and the 2nd one might be discard because of rate
> >> limitation of the cpufreq driver.
> >>
> >> update_cfs_rq_load_avg() is only called by update_blocked_averages()
> >> and update_load_avg() so we can move the call to
> >> {cfs_rq,cpufreq}_util_change() into these 2 functions. It's also
> >> interesting to notice that update_load_avg() already calls directly
> >> cfs_rq_util_change() for !SMP case.
> >>
> >> This changes will also ensure that cpufreq_update_util() is called eve=
n
> >> when there is no more CFS rq in the leaf_cfs_rq_list to update but onl=
y
> >> irq, rt or dl pelt signals.
> >>
> >> Reported-by: Doug Smythies <dsmythies@telus.net>
> >> Fixes: 039ae8bcf7a5 ("sched/fair: Fix O(nr_cgroups) in the load balanc=
ing path")
> >> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> >>
> >> ---
> >>
> >> I have just rebased the patch on latest tip/sched/core and made it a p=
roper
> >> patchset after Doug reported that the problem has diseappeared accordi=
ng to
> >> his 1st results but tests results are not all based on the same v5.4-r=
cX
> >> and with menu instead of teo governor.
> >>
> >>  kernel/sched/fair.c | 33 +++++++++++++++++++++------------
> >>  1 file changed, 21 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index e458f52..c93d534 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -3508,9 +3508,6 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *c=
fs_rq)
> >>      cfs_rq->load_last_update_time_copy =3D sa->last_update_time;
> >>  #endif
> >>
> >> -    if (decayed)
> >> -            cfs_rq_util_change(cfs_rq, 0);
> >> -
> >>      return decayed;
> >>  }
> >>
> >> @@ -3620,8 +3617,12 @@ static inline void update_load_avg(struct cfs_r=
q *cfs_rq, struct sched_entity *s
> >>              attach_entity_load_avg(cfs_rq, se, SCHED_CPUFREQ_MIGRATIO=
N);
> >>              update_tg_load_avg(cfs_rq, 0);
> >>
> >> -    } else if (decayed && (flags & UPDATE_TG))
> >> -            update_tg_load_avg(cfs_rq, 0);
> >> +    } else if (decayed) {
> >> +            cfs_rq_util_change(cfs_rq, 0);
> >> +
> >> +            if (flags & UPDATE_TG)
> >> +                    update_tg_load_avg(cfs_rq, 0);
> >> +    }
> >>  }
> >>
> >>  #ifndef CONFIG_64BIT
> >> @@ -7484,6 +7485,7 @@ static void update_blocked_averages(int cpu)
> >>      const struct sched_class *curr_class;
> >>      struct rq_flags rf;
> >>      bool done =3D true;
> >> +    int decayed =3D 0;
> >>
> >>      rq_lock_irqsave(rq, &rf);
> >>      update_rq_clock(rq);
> >> @@ -7493,9 +7495,9 @@ static void update_blocked_averages(int cpu)
> >>       * that RT, DL and IRQ signals have been updated before updating =
CFS.
> >>       */
> >>      curr_class =3D rq->curr->sched_class;
> >> -    update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class =3D=3D &r=
t_sched_class);
> >> -    update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class =3D=3D &d=
l_sched_class);
> >> -    update_irq_load_avg(rq, 0);
> >> +    decayed |=3D update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_cl=
ass =3D=3D &rt_sched_class);
> >> +    decayed |=3D update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_cl=
ass =3D=3D &dl_sched_class);
> >> +    decayed |=3D update_irq_load_avg(rq, 0);
> >>
> >>      /* Don't need periodic decay once load/util_avg are null */
> >>      if (others_have_blocked(rq))
> >> @@ -7529,6 +7531,9 @@ static void update_blocked_averages(int cpu)
> >>      }
> >>
> >>      update_blocked_load_status(rq, !done);
> >> +
> >> +    if (decayed)
> >> +            cpufreq_update_util(rq, 0);
> >>      rq_unlock_irqrestore(rq, &rf);
> >>  }
> >>
> >> @@ -7585,6 +7590,7 @@ static inline void update_blocked_averages(int c=
pu)
> >>      struct cfs_rq *cfs_rq =3D &rq->cfs;
> >>      const struct sched_class *curr_class;
> >>      struct rq_flags rf;
> >> +    int decayed =3D 0;
> >>
> >>      rq_lock_irqsave(rq, &rf);
> >>      update_rq_clock(rq);
> >> @@ -7594,13 +7600,16 @@ static inline void update_blocked_averages(int=
 cpu)
> >>       * that RT, DL and IRQ signals have been updated before updating =
CFS.
> >>       */
> >>      curr_class =3D rq->curr->sched_class;
> >> -    update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class =3D=3D &r=
t_sched_class);
> >> -    update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class =3D=3D &d=
l_sched_class);
> >> -    update_irq_load_avg(rq, 0);
> >> +    decayed |=3D update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_cl=
ass =3D=3D &rt_sched_class);
> >> +    decayed |=3D update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_cl=
ass =3D=3D &dl_sched_class);
> >> +    decayed |=3D update_irq_load_avg(rq, 0);
> >>
> >> -    update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
> >> +    decayed |=3D update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cf=
s_rq);
> >>
> >>      update_blocked_load_status(rq, cfs_rq_has_blocked(cfs_rq) || othe=
rs_have_blocked(rq));
> >> +
> >> +    if (decayed)
> >> +            cpufreq_update_util(rq, 0);
> >>      rq_unlock_irqrestore(rq, &rf);
> >>  }
> >>
> >> --
> >> 2.7.4
> >>
