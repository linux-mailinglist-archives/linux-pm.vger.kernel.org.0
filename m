Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66AB3ED904
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 16:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhHPOg5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 10:36:57 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:42603 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhHPOgv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Aug 2021 10:36:51 -0400
Received: by mail-oi1-f172.google.com with SMTP id t35so26957310oiw.9
        for <linux-pm@vger.kernel.org>; Mon, 16 Aug 2021 07:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2gyXJ2fQfNgEbfIyUhG5VcSL/HbXX36cgu0vdiQlNpA=;
        b=mfalqnDAswSx4vaCKL1/BQ43YUHUgnjOzDT735E2k7GZZk7MjST9+Xckreo/DwAlk2
         CNISM2/WKfOoBDBGK4TiTUXqRCdVV0kThucotUgH3rDOj9tsPHFelnKTuXQeYaxwydjt
         OVOvp0rDNxI4dl56MJQgvzbMsiNF/dZUrBqdhH22z1o+ezt9vMrShxO+4GNo/t/JbDI/
         3599lleCW3I8VB0EQ5yFSZCFbZTVegCV31uAZVax8gj00zm/xyn97KRb/hPLV+5VpB1y
         mEgB7QW2asyNy3wY+62TV3t22hROqbBNR/6xAD9G8W+UXCDSvmKYzYUVJVjuzayrLiz5
         u84Q==
X-Gm-Message-State: AOAM533edgHS/bHZ6JooHIS3TIwD0CXdeuatk5zanwXF033x6tnxyFTh
        b9MxzKLydnrKmu2v8iO5GA5agr46wbl5yWqaIwk=
X-Google-Smtp-Source: ABdhPJxSBVYGv8CheJknkfwZYe0tCJIOvJW5PGLUNFTxCvzUR3FMVRLmPDw0xCWWZBMdkjnN1bGSNr3Q6coEYigZK3M=
X-Received: by 2002:a05:6808:220c:: with SMTP id bd12mr12303928oib.157.1629124579942;
 Mon, 16 Aug 2021 07:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <1625738946-295849-1-git-send-email-vincent.donnefort@arm.com>
 <CAJZ5v0jLzj48-Bu1-i4=r3aratJwRzVYuaPvycUb--4jKSRkHw@mail.gmail.com>
 <20210810061323.kc5kvy6m6566z3gz@vireshk-i7> <78bc08fe-71c2-398c-9a10-caa54b8bd866@arm.com>
 <YRKINFhDmYqvgxsN@google.com> <cf9d78fe-cff0-1992-2c15-7053e4431296@arm.com>
 <b888407c-d444-8184-cbb7-ce8e925b254b@arm.com> <YRKfluMP8G41/P61@google.com>
 <20210811050327.3yxrk4kqxjjwaztx@vireshk-i7> <165735fc-1d03-42cb-b5eb-8a9c1d3c4387@arm.com>
In-Reply-To: <165735fc-1d03-42cb-b5eb-8a9c1d3c4387@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Aug 2021 16:35:53 +0200
Message-ID: <CAJZ5v0jc4KNeM2CotsPrD_Mnen57x3wCneGYzy5yNOdJ27wWOg@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] Inefficient OPPs
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Quentin Perret <qperret@google.com>, r@google.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 11, 2021 at 1:38 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 8/11/21 6:03 AM, Viresh Kumar wrote:
> > On 10-08-21, 16:47, Quentin Perret wrote:
> >> On Tuesday 10 Aug 2021 at 16:12:29 (+0100), Lukasz Luba wrote:
> >>> I've checked that. It's not the policy notifier and arch_topology which
> >>> cause an issue, but the cpufreq governor setup code. Anyway, we cannot
> >>> wait so late with the EM registration, till e.g. ::ready() callback.
> >>
> >> Aha, yes, because by the time the arch_topology driver rebuilds the
> >> sched domains, the governor is not 'installed', which means the
> >> scheduler is not in a position to enable EAS yet. So we need to wait
> >> until sched_cpufreq_governor_change() is called for that. Makes sense,
> >> thanks for checking, and +1 to your conclusion.
> >
> > What about this then ?
>
> If it doesn't break the current drivers which implement this callback,
> then looks good.

It was introduced by

7c45cf31b3ab cpufreq: Introduce ->ready() callback for cpufreq drivers

and appears to be still suitable for the purpose stated in the changelog.

Anyway, the vexpress-spc driver is the only one doing anything
significant in this callback AFAICS.

> >
> > Author: Viresh Kumar <viresh.kumar@linaro.org>
> > Date:   Wed Aug 11 10:24:28 2021 +0530
> >
> >      cpufreq: Call ->ready() before initializing governor
> >
> >      The driver may want to do stuff from the ->ready() callback, like
> >      registering with the EM core, after the policy is initialized, but
> >      before the governor is setup (since governor may end up using that
> >      information).
> >
> >      Call the ->ready() callback before setting up the governor.
> >
> >      Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >   drivers/cpufreq/cpufreq.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index a060dc2aa2f2..2df41b98bbb3 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -1494,6 +1494,10 @@ static int cpufreq_online(unsigned int cpu)
> >                  write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> >          }
> >
> > +       /* Callback for handling stuff after policy is ready */
> > +       if (cpufreq_driver->ready)
> > +               cpufreq_driver->ready(policy);
> > +
> >          ret = cpufreq_init_policy(policy);
> >          if (ret) {
> >                  pr_err("%s: Failed to initialize policy for cpu: %d (%d)\n",
> > @@ -1505,10 +1509,6 @@ static int cpufreq_online(unsigned int cpu)
> >
> >          kobject_uevent(&policy->kobj, KOBJ_ADD);
> >
> > -       /* Callback for handling stuff after policy is ready */
> > -       if (cpufreq_driver->ready)
> > -               cpufreq_driver->ready(policy);
> > -
> >          if (cpufreq_thermal_control_enabled(cpufreq_driver))
> >                  policy->cdev = of_cpufreq_cooling_register(policy);
> >
