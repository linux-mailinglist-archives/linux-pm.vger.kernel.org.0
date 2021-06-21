Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0523AEB07
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 16:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhFUOU0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 10:20:26 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:40515 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhFUOUY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 10:20:24 -0400
Received: by mail-ot1-f52.google.com with SMTP id v11-20020a9d340b0000b0290455f7b8b1dcso4931961otb.7;
        Mon, 21 Jun 2021 07:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YxXuShRhaJKj+ypQ+PFD/lwyGK+czyVuDkhKy+fj/VQ=;
        b=gJYxXgOTLs5iNf+sDOEVBTmvjBGpws0zmeKUNAdRyPAYEboFf8fdFPoA7Jh0Ybw+gB
         Grj9sHGzSq9n1gBq8YEw8uJ6dy1d5kdPQEJqVxZ5X4PuulcURvzO2W9pX01MI+PQeIPW
         IpwFZ7L7o8/5eiLg86WzbKOV687SnaLa5lHlzwdtqMtXAjY6FSNZ8O4z+PC0G5UtF3qi
         QaoSalTWBUuazBLr/pI1XV3zFuU6L5wVDyhwgiHPD5W8w+kUCgz5Mv6KGtoUtm6I9gw3
         VhXvfRW9C8fEHXFxPPV8MavpqLi1cMqAGoGUGfTtfbGpSCSlxVfX1te63cu3geUU0kEM
         OAoA==
X-Gm-Message-State: AOAM533gqTaUvt1dHbAy05I/FO1ep8QwnF9n8QYTylJHNtJZBjVPfdTb
        e+N76OgzRzKRsc7C1OUoqIx9FmnBOFJMEjC5n48=
X-Google-Smtp-Source: ABdhPJwnJJaZbmmjz7m6awl2bjreJn6w2WEElHent/0RL7h2wQUyoQ4keiT4yCq3Fb8rUGc6wztK/NAtJ7k5mSlUIx0=
X-Received: by 2002:a9d:674b:: with SMTP id w11mr13625126otm.260.1624285090434;
 Mon, 21 Jun 2021 07:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <5c8da9d378dee39d9c6063713b093f51d271fa9d.1623825358.git.viresh.kumar@linaro.org>
 <c31424b7962608eb13f946a665ba6848c4986856.1623986349.git.viresh.kumar@linaro.org>
 <CAJZ5v0h37bs0xLUCeD7ZuZfXLPBx=6Mpr-Y+Ef=qcnDA4aoLbQ@mail.gmail.com> <20210621030949.tng5xzq7dm7ngaez@vireshk-i7>
In-Reply-To: <20210621030949.tng5xzq7dm7ngaez@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Jun 2021 16:17:59 +0200
Message-ID: <CAJZ5v0jM3nusF1fjcMHLRHPk2PhFErhBXijpWHiSNnunzPFjeA@mail.gmail.com>
Subject: Re: [PATCH V3 2/3] cpufreq: intel_pstate: Migrate away from
 ->stop_cpu() callback
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dirk Brandewie <dirk.brandewie@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 21, 2021 at 5:09 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 18-06-21, 14:00, Rafael J. Wysocki wrote:
> > On Fri, Jun 18, 2021 at 5:22 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > commit 367dc4aa932b ("cpufreq: Add stop CPU callback to cpufreq_driver
> > > interface") added the stop_cpu() callback to allow the drivers to do
> > > clean up before the CPU is completely down and its state can't be
> > > modified.
> > >
> > > At that time the CPU hotplug framework used to call the cpufreq core's
> > > registered notifier for different events like CPU_DOWN_PREPARE and
> > > CPU_POST_DEAD. The stop_cpu() callback was called during the
> > > CPU_DOWN_PREPARE event.
> > >
> > > This is no longer the case, cpuhp_cpufreq_offline() is called only once
> > > by the CPU hotplug core now and we don't really need to separately
> > > call stop_cpu() for cpufreq drivers.
> > >
> > > Migrate to using the exit() and offline() callbacks instead of
> > > stop_cpu().
> > >
> > > We need to clear util hook from both the callbacks, exit() and
> > > offline(), since it is possible that only exit() gets called sometimes
> > > (specially on errors) or both get called at other times.
> > > intel_pstate_clear_update_util_hook() anyway have enough protection in
> > > place if it gets called a second time and will return early then.
> > >
> > > Cc: Dirk Brandewie <dirk.brandewie@gmail.com>
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > > V2->V3:
> > > - Update intel_pstate_cpu_offline() as well.
> > > - Improved commit log.
> > >
> > >  drivers/cpufreq/intel_pstate.c | 12 ++++--------
> > >  1 file changed, 4 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > > index 0e69dffd5a76..8f8a2d9d7daa 100644
> > > --- a/drivers/cpufreq/intel_pstate.c
> > > +++ b/drivers/cpufreq/intel_pstate.c
> > > @@ -2335,6 +2335,8 @@ static int intel_pstate_cpu_offline(struct cpufreq_policy *policy)
> > >
> > >         pr_debug("CPU %d going offline\n", cpu->cpu);
> > >
> > > +       intel_pstate_clear_update_util_hook(policy->cpu);
> > > +
> > >         if (cpu->suspended)
> > >                 return 0;
> > >
> > > @@ -2374,17 +2376,12 @@ static int intel_pstate_cpu_online(struct cpufreq_policy *policy)
> > >         return 0;
> > >  }
> > >
> > > -static void intel_pstate_stop_cpu(struct cpufreq_policy *policy)
> > > -{
> > > -       pr_debug("CPU %d stopping\n", policy->cpu);
> > > -
> > > -       intel_pstate_clear_update_util_hook(policy->cpu);
> > > -}
> > > -
> > >  static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
> > >  {
> > >         pr_debug("CPU %d exiting\n", policy->cpu);
> > >
> > > +       intel_pstate_clear_update_util_hook(policy->cpu);
> >
> > This change is not needed now, because ->offline always runs before
> > ->exit if present.
>
> Not necessarily, we don't call ->offline() for many error paths in
> cpufreq_online().

I guess you mean the error paths in cpufreq_offline()?

IMO this is confusing/broken, because ->offline should always be
called after ->online has returned success.

> offline() only comes into play after driver is registered properly once.

The relevant intel_pstate case is a ->setpolicy driver where
->setpolicy or ->online, if successful, need to be followed by
->offline.

If ->setpolicy is successful in the cpufreq_online() path, the entire
cpufreq_online() is successful and the error paths in question are not
executed.

So the change I was talking about is not needed AFAICS.
