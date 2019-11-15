Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB09FDBA0
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 11:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfKOKqQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 05:46:16 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35838 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfKOKqQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2019 05:46:16 -0500
Received: by mail-lj1-f196.google.com with SMTP id r7so10201087ljg.2
        for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2019 02:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XzeCp6VRB5u6E5bejznBe7WgeQhKhCBDQs+PEE9AFyo=;
        b=lSLPjY+cHxzqvPfuZR/I3YQzsJjDkX3DkVtGZ2YD4UZxNL5x8MrhKwPIe7CyIQ7Uq9
         vXnZMOGbPrJ6/8LOqyb149Ol14iBcc0XW38PihnilC6NmSHvY7PX+EFMa7BkDqcO4/P8
         9BnD8Jqt5L2PZf+DUwxTd4OZTSsr69n/6bcEAqDMFD995W4fQV3tqhYI9knv97Sh8FTB
         PJ1KOIqvdmJG6KDQWj1ohYXdihKE3DGENCUgJLJlHKXI3Z06nA5tRIBRmv8TyOHKr6HW
         PkjTQ0VBl5uEF9SAdRmsTqDeLfZt8QlCL5cH7T0pmwXUMDYPMFf6lYzt9nQq/ltV3cLL
         cfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XzeCp6VRB5u6E5bejznBe7WgeQhKhCBDQs+PEE9AFyo=;
        b=m5n0YxICx8uQEMzAaN0LWbp83yPZqwqDUkNoOkubeNwthOsw262PdniwF6jJn/GR6F
         VbSgZAcyn2eshp2mwiMaBK9k1HbaNKyzUwLGPmH8SVxBh/eKlIQcmVTovlzIiOUhmEcB
         ywuYNohDaH1azbTkHr5mRaH0ThJ8yqrERauqj24g9iyC6rLVoK6bPcqUD1CHs1kLNw8G
         hsDoZWFOCQZrG+ekOgAKiSMNqqUcO609OGvQ6dcRm1i1XfDeFKau848RjcFxXspMEg5l
         5eJigp85dwc7++1MDyAPzhi0LGNvP6i/zZHYvX8QP1iTBSyzqd2tNnxNVeg47uu+LhbF
         aAcQ==
X-Gm-Message-State: APjAAAUqv3TyVGqccwKp+i+rdEWy9Ll0ijKoXQJIcxNQI9r4XL3n6PRU
        ILrzZbr8AqAO3D8KF51CDtnoh8kFBoZAuwK+jZWPYw==
X-Google-Smtp-Source: APXvYqxP70WABGHvCmIS6igkDhawaWM4g9i3gHqSIXFSPpJqOrxblXOVHwMXSTQNNjsz3TWLuonU4x4mfQNgLroS1m8=
X-Received: by 2002:a2e:b0e3:: with SMTP id h3mr10224545ljl.193.1573814773542;
 Fri, 15 Nov 2019 02:46:13 -0800 (PST)
MIME-Version: 1.0
References: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org>
 <20191115095447.GU4114@hirez.programming.kicks-ass.net> <CAKfTPtCTcrq1E1H8A3TL1xvALUrQ7ybPoERJ+C2O2+QXpVEZGQ@mail.gmail.com>
 <20191115103735.GE4131@hirez.programming.kicks-ass.net>
In-Reply-To: <20191115103735.GE4131@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 15 Nov 2019 11:46:01 +0100
Message-ID: <CAKfTPtDi_-h6g+rhV04XXjqpWprC2vT6hgLZSrTW5rdD54PrQA@mail.gmail.com>
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

On Fri, 15 Nov 2019 at 11:37, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Nov 15, 2019 at 11:18:00AM +0100, Vincent Guittot wrote:
> > On Fri, 15 Nov 2019 at 10:55, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Thu, Nov 14, 2019 at 06:07:31PM +0100, Vincent Guittot wrote:
> > > > update_cfs_rq_load_avg() calls cfs_rq_util_change() everytime pelt decays,
> > > > which might be inefficient when cpufreq driver has rate limitation.
> > > >
> > > > When a task is attached on a CPU, we have call path:
> > > >
> > > > update_load_avg()
> > > >   update_cfs_rq_load_avg()
> > > >     cfs_rq_util_change -- > trig frequency update
> > > >   attach_entity_load_avg()
> > > >     cfs_rq_util_change -- > trig frequency update
> > > >
> > > > The 1st frequency update will not take into account the utilization of the
> > > > newly attached task and the 2nd one might be discard because of rate
> > > > limitation of the cpufreq driver.
> > >
> > > Doesn't this just show that a dumb rate limit in the driver is broken?
> >
> > But the rate limit may come from HW constraints that forces to wait
> > let say 4ms or even 10ms between each frequency update.
>
> Sure, but then it can still remember the value passed in last and use
> that state later.
>
> It doesn't _have_ to completely discard values.

yes but it means that we run at the "wrong" frequency during this
period and also that the cpufreq must in this case set a kind of timer
to resubmit a new frequency change out of scheduler event

>
> > > > update_cfs_rq_load_avg() is only called by update_blocked_averages()
> > > > and update_load_avg() so we can move the call to
> > > > cfs_rq_util_change/cpufreq_update_util() into these 2 functions. It's also
> > > > interesting to notice that update_load_avg() already calls directly
> > > > cfs_rq_util_change() for !SMP case.
> > > >
> > > > This changes will also ensure that cpufreq_update_util() is called even
> > > > when there is no more CFS rq in the leaf_cfs_rq_list to update but only
> > > > irq, rt or dl pelt signals.
> > >
> > > I don't think it does that; that is, iirc the return value of
> > > ___update_load_sum() is 1 every time a period lapses. So even if the avg
> > > is 0 and doesn't change, it'll still return 1 on every period.
> > >
> > > Which is what that dumb rate-limit thing wants of course. But I'm still
> > > thinking that it's stupid to do. If nothing changes, don't generate
> > > events.
> >
> > When everything (irq, dl, rt, cfs) is 0, we don't generate events
> > because update_blocked_averages is no more called because
> > rq->has_blocked_load is clear
>
> Aah.. Ok, let me look at this thing again.
>
> > > If anything, update_blocked_avgerages() should look at
> > > @done/others_have_blocked() to emit events for rt,dl,irq.
> >
> > other_have_blocked can be set but no decay happened during the update
> > and we don't need to call cpufreq_update_util
>
> True.
