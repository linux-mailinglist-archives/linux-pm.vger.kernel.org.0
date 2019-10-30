Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA2EE9EE2
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 16:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfJ3P1Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 11:27:25 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35610 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfJ3P1X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 11:27:23 -0400
Received: by mail-lj1-f195.google.com with SMTP id m7so3176466lji.2
        for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2019 08:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7mZ3hdtUFZsghSAyhPspAG9N/gAftJ/UKlLExYxE09E=;
        b=AWLbv+osewTPSi/vLPVd5pQBM/2GgohGKpImcwCHp66lnoHDlebOgO6/T/itPeQt82
         lnJEtwhEWqY93eVMkA+vgu4zGeJNEpQQdE4Gjr2d0jJ2ddX5f2mOBY7GysGUwGE0ylRh
         ezKxa7AM3Gv3oEtBZiauKf4Wc5mzy0a3TBZgSan6bJf2Oy6+EQr701yCG9jJHrms+Jsu
         Q2B6DA4T/qWPaAp2fnIC7DoaZGV14MtiBA4D8SzpNP2IPwBF8meFCzFU7aNYL8rPdmiL
         A1VobGpDRWIFP2NrIINA8evRtg4K97nBoVQEpj+Ylm+OK1BbvaHX5rNGiyY4qNjhkbxX
         C3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7mZ3hdtUFZsghSAyhPspAG9N/gAftJ/UKlLExYxE09E=;
        b=qge9QrGA6eToPMgyMOuGSy07Omgy9G1L97ATXnUhEJcHfQKCcrXf4nF6KKyoh62iTl
         HSnAvZ4M2SGAIKPcK4P2Mt2pBBpM7JUwKuH/01zOveSArAnERQFDqSJCGCNJPmKINscB
         7rcuwEB+eXExpxkRr5Rqe2hThxlDnB8g2tELiGn1ekOiphJDZE5FTcfNeK4ywq38bzi5
         rFlBZEXhl8RKgJdKlusb7A0YUp4Vs84HgTEEx/688+YVZftgx6uVDB5sx88oKvgew70Q
         YANTol0DebBIb4G6Q4jnaGuRbdimxzfLur7GPZWZv9VSd9kpeamUBeU5g3ut5z7lloka
         rAgg==
X-Gm-Message-State: APjAAAWWLab+HU8t4ogGDi62jmXzzt4dQA10kaXLRjII381fUCXfGKHE
        ww9Dy8ttJxqu+mQE7TDv3RyH9vIYtkVNpM6gV4ps7Q==
X-Google-Smtp-Source: APXvYqyzInUrcF8c/QhRYg1Eb1OIgwXR80Ufflf62AWpz2Kzp1rGhOxHbcJr8EDpwdJMRwO8ntm8CVu/h6z5QBX2Xo4=
X-Received: by 2002:a2e:3e18:: with SMTP id l24mr252556lja.48.1572449240686;
 Wed, 30 Oct 2019 08:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <1572018904-5234-1-git-send-email-dsmythies@telus.net>
 <CAKfTPtDFAS3TiNaaPoEXFZbqdMt_-tfGm9ffVcQAN=Mu_KbRdQ@mail.gmail.com>
 <000c01d58bca$f5709b30$e051d190$@net> <CAKfTPtDx6nu7YtYN=JLRAseZS3Q6Nt-QdMQuG_XoUtmtR_101A@mail.gmail.com>
 <001201d58e68$eaa39630$bfeac290$@net> <20191029160210.GA8343@linaro.org> <000001d58f2a$fc593200$f50b9600$@net>
In-Reply-To: <000001d58f2a$fc593200$f50b9600$@net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 30 Oct 2019 16:27:08 +0100
Message-ID: <CAKfTPtCjhYKttEuWs9cqicUdJMiJVy5he+=xWofof_4xAWgKAw@mail.gmail.com>
Subject: Re: [PATCH] Revert "sched/fair: Fix O(nr_cgroups) in the load
 balancing path"
To:     Doug Smythies <dsmythies@telus.net>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sargun Dhillon <sargun@sargun.me>, Tejun Heo <tj@kernel.org>,
        Xie XiuQi <xiexiuqi@huawei.com>, xiezhipeng1@huawei.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 30 Oct 2019 at 15:04, Doug Smythies <dsmythies@telus.net> wrote:
>
> On 2019.10.29 09:02 Vincent Guittot wrote:
>
> > Could you try the patch below ? It ensures that at least the root cfs rq stays
> > in the list so each time update_blocked_averages is called, we will call update_cfs_rq_load_avg()
> > for the root cfs_rq at least and even if everything already reach zero.
> > This will ensure that cfs_rq_util_change is called even if nothing has
> > changed.
> >
> > ---
> >  kernel/sched/fair.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 151c0b7..ac0a549 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7552,6 +7552,8 @@ static inline void update_blocked_load_status(struct rq *rq, bool has_blocked) {
> >
> >  static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
> >  {
> > +     struct rq *rq = rq_of(cfs_rq);
> > +
> >       if (cfs_rq->load.weight)
> >               return false;
> >
> > @@ -7564,6 +7566,9 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
> >       if (cfs_rq->avg.runnable_load_sum)
> >               return false;
> >
> > +     if (cfs_rq == &rq->cfs)
> > +             return false;
> > +
> >       return true;
> > }
> >
> > --
> > 2.7.4
>
> Yes, this patch works and solves the long time
> between calls of the intel_pstate CPU frequency scaling
> driver issue.
> I see you sent a formal patch a few hours ago.
> I'll try it and report back.

The patch that I sent a few hours ago, doesn't solve your problem. It
solves item 1 of my previous email.

The fact that this hack fix your problem means that Intel pstate needs
to be called periodically even if the cfs pelt signals are null and
this is probably linked to the internal state machine of the driver.
The current behavior for CFS makes perfectly sense because cfs signal
is already null so we don't need to update freq because of cfs' signal
Then it remains the rt, dl and irq signals which might not be null yet
and which doesn't trigger a call to cpufreq_update_util whereas it
could worth calling it.

I have to prepare a patch for this part which is item 2

Regards,
Vincent


>
> ... Doug
>
>
