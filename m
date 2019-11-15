Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5BCFDB12
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 11:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfKOKSO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 05:18:14 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42348 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbfKOKSO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2019 05:18:14 -0500
Received: by mail-lj1-f193.google.com with SMTP id n5so10088543ljc.9
        for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2019 02:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pCyqOdp+ZndERcZb5iv1sm6YH8+z1aM4ycI4+c8RSn4=;
        b=rcgSsPfU+Q97tOFNKOrVXTIZo5atGipqubSqP/Zb1Qy3QZH31sW7nEYJ/3pb294IST
         tDNnwxKaF24pgsnVbJi7SCE/y42+d+VvKJdJbiuGRQciM7uSi/mtLQlkhqy8exd9vIhx
         a56YtyxTQQn3tHCwIK5QMEa44XQ8nV5ZW3WYlEWLd4jMtaalMOF+NVU8VSU/oE+XQ/d3
         nw1ySTNoE585b+1VAaDyZsbOkao9SFZIgIbYbS2gERD/c3P1Z8CiVdAZGuA3NRCSZ/6k
         mCavaQR2o0D0s1ZJKWQN9pP6WcaK/fCllOY4pg4O/jiCvfBhgoNGlZ4JYUtefzD9zSYp
         60eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pCyqOdp+ZndERcZb5iv1sm6YH8+z1aM4ycI4+c8RSn4=;
        b=L0fnqggVCikO8BK5jtBqODAcDzSrtHtlmzFu/WupKecr5KyXtEXxktUZZ3QUp26lMC
         yJPXtBaZF/EpjJMBT7X4lpk6ACXZEl/2h3luxFapcfgBozoifxWA8Scv2l/4DwVEkBdk
         aMEh1p68xaWLOsDvFKxeey68maLCVwSvVg26t1JwZmfTShyqJEQtTcBQS9GJ/8RsSpks
         zzNcCV35Ic5fmWihwVUTJ6YlRWOSzxpVfnNzMwZ92hdm8ZFHiGhuqKeBTMBjNszYmHqW
         05iMGGDSFu57w6kveOwJXjxprunC93ZCQWjoHHr6KoGGJPsIgDfHJUcuLilZ0hd7ffX5
         t3vA==
X-Gm-Message-State: APjAAAX3LTudXsMd3s6gAxtDPGKkvFUuSK92G0qQuAlLc1SqGhBYuOIc
        Xpvux/D9smXGY5yIkota/pVGMVhR0nHFRtCfDsaS4w==
X-Google-Smtp-Source: APXvYqw4nG6xeDVRRT2y9ygXD8V2W7ROQTkc/+zE6SYLloLLqV10hMqTILv/0ihg/0vC+GzCo0u/uuerAQVwKblA97I=
X-Received: by 2002:a2e:b0e3:: with SMTP id h3mr10133730ljl.193.1573813091777;
 Fri, 15 Nov 2019 02:18:11 -0800 (PST)
MIME-Version: 1.0
References: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org> <20191115095447.GU4114@hirez.programming.kicks-ass.net>
In-Reply-To: <20191115095447.GU4114@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 15 Nov 2019 11:18:00 +0100
Message-ID: <CAKfTPtCTcrq1E1H8A3TL1xvALUrQ7ybPoERJ+C2O2+QXpVEZGQ@mail.gmail.com>
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

On Fri, 15 Nov 2019 at 10:55, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Nov 14, 2019 at 06:07:31PM +0100, Vincent Guittot wrote:
> > update_cfs_rq_load_avg() calls cfs_rq_util_change() everytime pelt decays,
> > which might be inefficient when cpufreq driver has rate limitation.
> >
> > When a task is attached on a CPU, we have call path:
> >
> > update_load_avg()
> >   update_cfs_rq_load_avg()
> >     cfs_rq_util_change -- > trig frequency update
> >   attach_entity_load_avg()
> >     cfs_rq_util_change -- > trig frequency update
> >
> > The 1st frequency update will not take into account the utilization of the
> > newly attached task and the 2nd one might be discard because of rate
> > limitation of the cpufreq driver.
>
> Doesn't this just show that a dumb rate limit in the driver is broken?

But the rate limit may come from HW constraints that forces to wait
let say 4ms or even 10ms between each frequency update.

>
> > update_cfs_rq_load_avg() is only called by update_blocked_averages()
> > and update_load_avg() so we can move the call to
> > cfs_rq_util_change/cpufreq_update_util() into these 2 functions. It's also
> > interesting to notice that update_load_avg() already calls directly
> > cfs_rq_util_change() for !SMP case.
> >
> > This changes will also ensure that cpufreq_update_util() is called even
> > when there is no more CFS rq in the leaf_cfs_rq_list to update but only
> > irq, rt or dl pelt signals.
>
> I don't think it does that; that is, iirc the return value of
> ___update_load_sum() is 1 every time a period lapses. So even if the avg
> is 0 and doesn't change, it'll still return 1 on every period.
>
> Which is what that dumb rate-limit thing wants of course. But I'm still
> thinking that it's stupid to do. If nothing changes, don't generate
> events.

When everything (irq, dl, rt, cfs) is 0, we don't generate events
because update_blocked_averages is no more called because
rq->has_blocked_load is clear

With current implementation, if cfs is 0 but not irq, dl or rt, we
don't call cpufreq_update_util because it is only called through cfs

>
> If anything, update_blocked_avgerages() should look at
> @done/others_have_blocked() to emit events for rt,dl,irq.

other_have_blocked can be set but no decay happened during the update
and we don't need to call cpufreq_update_util

>
> So why are we making the scheduler code more ugly instead of fixing that
> driver?
