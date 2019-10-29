Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66215E8DAF
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 18:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390771AbfJ2RJu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 13:09:50 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34223 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390598AbfJ2RJr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 13:09:47 -0400
Received: by mail-lj1-f193.google.com with SMTP id 139so15954129ljf.1
        for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2019 10:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K88yaieKvcCeNpugsGLmfxIwpDDi0ZtEXOdEH+qf0fA=;
        b=KUSJJ6YqudPa6QLkK/BK60Zl842G3MRsmv2DW5kvVHh4p/kDenZrhnrEbOmPdTzvgw
         I8q1/6MQu6/LALbcoU8JqLT1S4P2VX78KCleLVqTouQ0Yep8qgOoUplT/Aed8C3clRzT
         m577opm7GhHFmdRVSaPLRsdevIt0u8rs4iJXrxs+edkSysqasOxDGMu/VbTZXc0Yn9+d
         VvOSHMNffEegB9CJmgKqrdO1UX29UB+Im+zXSj771bYCexPVTJb4ZHUleCOsl/7IGvj3
         D6Yc7zFZhHKDNA/gTRqyTeiOppfjROeADIOrgchGq06tNoigUixu7W0712Zs9nGPCrY9
         U95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K88yaieKvcCeNpugsGLmfxIwpDDi0ZtEXOdEH+qf0fA=;
        b=hN4Sectcw4+iS1mSGqLornzvi6T52ru/Dsbq/ujiwP7dDGzt7RkG9pd2SsXoQ8tacz
         8oV6EvVdFyLV2xWSswBhvcbCUP6pe9+JHMp1hNDB1+w3bBA7u08IFkH91rEoz5Z9V7tj
         9Lq4bSxbkR3M5kFPk6fmnwSnf/SCouzzbHq1CCZmnZnxyfGeIYdukNPjQYQFGtqh9s97
         mhWayBC86DuAqwKIxgDQGK+qiy5CHwrKjYomoky2sJ0lEsaLg3PPL4bkFEvbAIHrch7T
         zqI0a9E6uwmKp13Rlbb8jA8s90o88SmxzPGwMDMmH6/JGwMURrs4zAnHZ6KToaYCIYTE
         zQUQ==
X-Gm-Message-State: APjAAAWX6cLsYPr9xv0z377saxpNKE10X9qIHOFTdOOMVBnQb9iulZoz
        AVHmkeohJI9pzzpXGGzBWhEkyHq/i7awOwNuXvzPRg==
X-Google-Smtp-Source: APXvYqyJcslMrIOGNYE0X47a9sPVBXQLcpeAkCnxS1526iUdAKdcOTDZhZpnoBc4H7DFjrEOMOciu/zXkA+EWlIXABY=
X-Received: by 2002:a2e:96c1:: with SMTP id d1mr3590291ljj.87.1572368985549;
 Tue, 29 Oct 2019 10:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <1572018904-5234-1-git-send-email-dsmythies@telus.net>
 <CAKfTPtDFAS3TiNaaPoEXFZbqdMt_-tfGm9ffVcQAN=Mu_KbRdQ@mail.gmail.com>
 <000c01d58bca$f5709b30$e051d190$@net> <CAKfTPtDx6nu7YtYN=JLRAseZS3Q6Nt-QdMQuG_XoUtmtR_101A@mail.gmail.com>
 <001201d58e68$eaa39630$bfeac290$@net> <20191029153615.GP4114@hirez.programming.kicks-ass.net>
 <CAKfTPtD79VE+gqffpBAGd39bJKe7ao+jbmVSQ7PtS=dky0Wx6g@mail.gmail.com>
 <20191029164955.GO4131@hirez.programming.kicks-ass.net> <CAKfTPtDByO5xZaA1zHb-0WLq3PaodByfbnH0RkJjf+jn0O81-Q@mail.gmail.com>
In-Reply-To: <CAKfTPtDByO5xZaA1zHb-0WLq3PaodByfbnH0RkJjf+jn0O81-Q@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 29 Oct 2019 18:09:34 +0100
Message-ID: <CAKfTPtD-MD74Je7R1eURfrusCci9xt4dPVE0YLuAN4jWXcdEog@mail.gmail.com>
Subject: Re: [PATCH] Revert "sched/fair: Fix O(nr_cgroups) in the load
 balancing path"
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Doug Smythies <dsmythies@telus.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
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

On Tue, 29 Oct 2019 at 18:00, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Tue, 29 Oct 2019 at 17:50, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Oct 29, 2019 at 05:20:56PM +0100, Vincent Guittot wrote:
> > > On Tue, 29 Oct 2019 at 16:36, Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Tue, Oct 29, 2019 at 07:55:26AM -0700, Doug Smythies wrote:
> > > >
> > > > > I only know that the call to the intel_pstate driver doesn't
> > > > > happen, and that it is because cfs_rq_is_decayed returns TRUE.
> > > > > So, I am asserting that the request is not actually decayed, and
> > > > > should not have been deleted.
> > > >
> > > > So what cfs_rq_is_decayed() does is allow a cgroup's cfs_rq to be
> > > > removed from the list.
> > > >
> > > > Once it is removed, that cfs_rq will no longer be checked in the
> > > > update_blocked_averages() loop. Which means done has less chance of
> > > > getting false. Which in turn means that it's more likely
> > > > rq->has_blocked_load becomes 0.
> > > >
> > > > Which all sounds good.
> > > >
> > > > Can you please trace what keeps the CPU awake?
> > >
> > > I think that the sequence below is what intel pstate driver was using
> > >
> > > rt/dl task wakes up and run for some times
> > > rt/dl pelt signal is no more null so periodic decay happens.
> > >
> > > before optimization update_cfs_rq_load_avg() for root cfs_rq was
> > > called even if pelt was null,
> > > which calls cfs_rq_util_change,  which calls intel pstate
> > >
> > > after optimization its no more called.
> >
> > Not calling cfs_rq_util_change() when it doesn't change, seems like the
> > right thing. Why would intel_pstate want it called when it doesn't
> > change?
>
> Yes I agree
>
> My original thought was that either irq/rt ordl pelt signals was used
> to set frequency and it needs to be called to decrease this freq while
> pelt signals was decaying but it doesn't seem to use it but only needs
> to be called from time to time

Apart from Doug's problem, we have 2 possible problems with the
current update_blocked_averages()
1- irq, dl and rt are updated after cfs but it is the cfs update that
will call schedutil for updating the frequency which means that this
is done with old irq/rt/dl value. we should change the order and start
with irq/rt and dl
2- when cfs is null but not irq/rt or dl, we decay the values but we
never call schedutil to update the freq accordingly. The impact is
probably minimal because only irq and timer can really run without
call schedutil to update frequency but this can happen.

I'm going to prepare some patches
