Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD8F481F3F
	for <lists+linux-pm@lfdr.de>; Thu, 30 Dec 2021 19:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236845AbhL3ShP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Dec 2021 13:37:15 -0500
Received: from mail-qt1-f177.google.com ([209.85.160.177]:43974 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbhL3ShP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Dec 2021 13:37:15 -0500
Received: by mail-qt1-f177.google.com with SMTP id q14so22398001qtx.10;
        Thu, 30 Dec 2021 10:37:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fhGsxiqOztFUsXOimjyLadSKjkkpVTlAK+RVmvwk//w=;
        b=z0qokK/pTglM7uOuDy2crfCB7k3oI2p3l6Rbrz6xhFF/u6QGNsiUnQFOha/pYSi5d4
         OglOAfFdXG9iAW3BO/jGrT3cn3xy/+QQPNk/luIdx6CuRmw6ubze8hIE6M0L9DltblNd
         jqUJoW7yjE6OCGf23ge9RB+L2iPJl4CW1VRhx2HbLBPTbX4UFQ7b9iBtqjfU4qABUwaB
         kgZDpjgErtBAIABg7cPsDujGPvh1Jg7FLZQWUVvjEYma7hAPaP8OJhPiCOTrw9CyMRfn
         eAf136BEop9FecH9sy4CRzK/OsS60wz/7PYxP11LUJaLMkczd+ctsEH/jFuFNuKEXlYA
         eGlw==
X-Gm-Message-State: AOAM5306RHRpekOaVtnM8fF/IFsMCNOCApp0phq/JBIksHYbkQ8b8pG5
        XjyqUwWSQr6ni8Fu5kwVQiF2IdcMB/9JbTOu8QQ=
X-Google-Smtp-Source: ABdhPJxmAhjjpO7/fc+ZUB+FyD8oJR87JhdjmmXv7M8sJsdJGpef+sByXrasH4ASdIHinuLeC/OkV644vFbAK6rnTlg=
X-Received: by 2002:ac8:5c91:: with SMTP id r17mr28588113qta.18.1640889434764;
 Thu, 30 Dec 2021 10:37:14 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2112132215060.215073@hadrien>
 <87r1abt1d2.fsf@riseup.net> <alpine.DEB.2.22.394.2112172258480.2968@hadrien>
 <87fsqqu6by.fsf@riseup.net> <alpine.DEB.2.22.394.2112180654470.3139@hadrien>
 <878rwitdu3.fsf@riseup.net> <alpine.DEB.2.22.394.2112181138210.3130@hadrien>
 <871r29tvdj.fsf@riseup.net> <alpine.DEB.2.22.394.2112190734070.3181@hadrien>
 <87wnk0s0tf.fsf@riseup.net> <CAJZ5v0i7gBtm6x+zUUzhxXjmYhPwr=JxvOuMZ0aD9qxnjE9YKw@mail.gmail.com>
 <878rwdse9o.fsf@riseup.net> <alpine.DEB.2.22.394.2112281745240.24929@hadrien>
 <CAJZ5v0i4xnesG=vfx7Y-wyeaGvjDeGcsaOVqhRLnV8YXk-m2gA@mail.gmail.com>
 <alpine.DEB.2.22.394.2112281845180.24929@hadrien> <CAJZ5v0grayg9evWsB5ktKSFq=yA_AHoEWSfpSkQ=MVQ-=butfA@mail.gmail.com>
 <alpine.DEB.2.22.394.2112291012030.24929@hadrien> <CAJZ5v0g5wDxYXA-V=Ex_Md82hgnj5K6Vr0tavFFVz=uBqo8wag@mail.gmail.com>
 <alpine.DEB.2.22.394.2112301840360.15550@hadrien> <CAJZ5v0h38jh3gyTp9W0ws0yXyfK=F+TQ7VYRVx4aGXhNeSObEg@mail.gmail.com>
 <alpine.DEB.2.22.394.2112301919240.15550@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2112301919240.15550@hadrien>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Dec 2021 19:37:03 +0100
Message-ID: <CAJZ5v0haa5QWvTUUg+wwSHvuWyk8pic1N0kox=E1ZKNrHSFuzw@mail.gmail.com>
Subject: Re: cpufreq: intel_pstate: map utilization into the pstate range
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Francisco Jerez <currojerez@riseup.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 30, 2021 at 7:21 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Thu, 30 Dec 2021, Rafael J. Wysocki wrote:
>
> > On Thu, Dec 30, 2021 at 6:54 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> > >
> > > > > The effect is the same.  But that approach is indeed simpler than patching
> > > > > the kernel.
> > > >
> > > > It is also applicable when intel_pstate runs in the active mode.
> > > >
> > > > As for the results that you have reported, it looks like the package
> > > > power on these systems is dominated by package voltage and going from
> > > > P-state 20 to P-state 21 causes that voltage to increase significantly
> > > > (the observed RAM energy usage pattern is consistent with that).  This
> > > > means that running at P-states above 20 is only really justified if
> > > > there is a strict performance requirement that can't be met otherwise.
> > > >
> > > > Can you please check what value is there in the base_frequency sysfs
> > > > attribute under cpuX/cpufreq/?
> > >
> > > 2100000, which should be pstate 21
> > >
> > > >
> > > > I'm guessing that the package voltage level for P-states 10 and 20 is
> > > > the same, so the power difference between them is not significant
> > > > relative to the difference between P-state 20 and 21 and if increasing
> > > > the P-state causes some extra idle time to appear in the workload
> > > > (even though there is not enough of it to prevent to overall
> > > > utilization from increasing), then the overall power draw when running
> > > > at P-state 10 may be greater that for P-state 20.
> > >
> > > My impression is that the package voltage level for P-states 10 to 20 is
> > > high enough that increasing the frequency has little impact.  But the code
> > > runs twice as fast, which reduces the execution time a lot, saving energy.
> > >
> > > My first experiment had only one running thread.  I also tried running 32
> > > spinning threads for 10 seconds, ie using up one package and leaving the
> > > other idle.  In this case, instead of staying around 600J for pstates
> > > 10-20, the pstate rises from 743 to 946.  But there is still a gap between
> > > 20 and 21, with 21 being 1392J.
> > >
> > > > You can check if there is any C-state residency difference between
> > > > these two cases by running the workload under turbostat in each of
> > > > them.
> > >
> > > The C1 and C6 cases (CPU%c1 and CPU%c6) are about the same between 20 and
> > > 21, whether with 1 thread or with 32 thread.
> >
> > I meant to compare P-state 10 and P-state 20.
> >
> > 20 and 21 are really close as far as the performance is concerned, so
> > I wouldn't expect to see any significant C-state residency difference
> > between them.
>
> There's also no difference between 10 and 20.  This seems normal, because
> the same cores are either fully used or fully idle in both cases.  The
> idle ones are almost always in C6.

The turbostat output sent by you previously shows that the CPUs doing
the work are only about 15-or-less percent busy, though, and you get
quite a bit of C-state residency on them.  I'm assuming that this is
for 1 running thread.

Can you please run the 32 spinning threads workload (ie. on one
package) and with P-state locked to 10 and then to 20 under turbostat
and send me the turbostat output for both runs?
