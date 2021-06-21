Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B5B3AF1B8
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 19:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFURR1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 13:17:27 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:37698 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhFURRZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 13:17:25 -0400
Received: by mail-ot1-f47.google.com with SMTP id 102-20020a9d0eef0000b02903fccc5b733fso18438330otj.4;
        Mon, 21 Jun 2021 10:15:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jXm4NUtSsDnuPgFRz6Ycu8nMt+U8kUvdPj/gorMrW8Q=;
        b=dnQu4yM+INZNFSogRkvEieI8Lnv1TW93WKN5ejEseWKBq1ofra4iHrW4UJE+vr3KPo
         17k+YmBoypzRQUBQa3xpUeM6d/DEq/MLchtHebYdfgRbOBtHlQPFoyjNv+ESt7EfyBdL
         SVeqxCxnlLM6FBuh1WY8W7I23nEhMTJCEcRuYa0RBJjRNuNl1n5mscCHgnDPI2VfwZv7
         VgtZI1p9al/Ds5/J8281E3ReksywwxZmBatMoKNzQzi0mYLgvBMNHip15Pb9qPI80wUt
         GC+OqjhXbA678xRXkjs2Xwz7Hp/DP7Jyp+iNJF+kEFvuRCd+WTp8/X9lOrqOnMI/0DoH
         mQlQ==
X-Gm-Message-State: AOAM530kl40aQdbTsLZAPGYbuoLfLuNIJA7jMy9s3YXojsLj8StIKDQG
        NyBrHgcCYedRwSvjwVSr5yssAYduuAuhfXLjIJE=
X-Google-Smtp-Source: ABdhPJzSwGsGfGepxGsiL+hQYZ1zqB9QAIz3cRvElmUbwzCWuT06q+OkKyQ0Ghm2bN5RhpEhNV6LxcX4Q3Vmty3OVwE=
X-Received: by 2002:a9d:674b:: with SMTP id w11mr14327789otm.260.1624295710230;
 Mon, 21 Jun 2021 10:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <5c8da9d378dee39d9c6063713b093f51d271fa9d.1623825358.git.viresh.kumar@linaro.org>
 <c31424b7962608eb13f946a665ba6848c4986856.1623986349.git.viresh.kumar@linaro.org>
 <CAJZ5v0h37bs0xLUCeD7ZuZfXLPBx=6Mpr-Y+Ef=qcnDA4aoLbQ@mail.gmail.com>
 <20210621030949.tng5xzq7dm7ngaez@vireshk-i7> <CAJZ5v0jM3nusF1fjcMHLRHPk2PhFErhBXijpWHiSNnunzPFjeA@mail.gmail.com>
 <CAJZ5v0iHDk6Te0KogYToWSyquNcpS2edQzp1UbW3KFAVL31Hnw@mail.gmail.com>
In-Reply-To: <CAJZ5v0iHDk6Te0KogYToWSyquNcpS2edQzp1UbW3KFAVL31Hnw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Jun 2021 19:14:59 +0200
Message-ID: <CAJZ5v0g2tCZptcqh+c55YYiO7rDHmZivMLsmpq_7005zNPN1xg@mail.gmail.com>
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

On Mon, Jun 21, 2021 at 4:26 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Jun 21, 2021 at 4:17 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Mon, Jun 21, 2021 at 5:09 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 18-06-21, 14:00, Rafael J. Wysocki wrote:
> > > > On Fri, Jun 18, 2021 at 5:22 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > > >
> > > > > commit 367dc4aa932b ("cpufreq: Add stop CPU callback to cpufreq_driver
> > > > > interface") added the stop_cpu() callback to allow the drivers to do
> > > > > clean up before the CPU is completely down and its state can't be
> > > > > modified.
> > > > >
> > > > > At that time the CPU hotplug framework used to call the cpufreq core's
> > > > > registered notifier for different events like CPU_DOWN_PREPARE and
> > > > > CPU_POST_DEAD. The stop_cpu() callback was called during the
> > > > > CPU_DOWN_PREPARE event.
> > > > >
> > > > > This is no longer the case, cpuhp_cpufreq_offline() is called only once
> > > > > by the CPU hotplug core now and we don't really need to separately
> > > > > call stop_cpu() for cpufreq drivers.
> > > > >
> > > > > Migrate to using the exit() and offline() callbacks instead of
> > > > > stop_cpu().
> > > > >
> > > > > We need to clear util hook from both the callbacks, exit() and
> > > > > offline(), since it is possible that only exit() gets called sometimes
> > > > > (specially on errors) or both get called at other times.
> > > > > intel_pstate_clear_update_util_hook() anyway have enough protection in
> > > > > place if it gets called a second time and will return early then.
> > > > >
> > > > > Cc: Dirk Brandewie <dirk.brandewie@gmail.com>
> > > > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > > > ---
> > > > > V2->V3:
> > > > > - Update intel_pstate_cpu_offline() as well.
> > > > > - Improved commit log.
> > > > >
> > > > >  drivers/cpufreq/intel_pstate.c | 12 ++++--------
> > > > >  1 file changed, 4 insertions(+), 8 deletions(-)
> > > > >
> > > > > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > > > > index 0e69dffd5a76..8f8a2d9d7daa 100644
> > > > > --- a/drivers/cpufreq/intel_pstate.c
> > > > > +++ b/drivers/cpufreq/intel_pstate.c
> > > > > @@ -2335,6 +2335,8 @@ static int intel_pstate_cpu_offline(struct cpufreq_policy *policy)
> > > > >
> > > > >         pr_debug("CPU %d going offline\n", cpu->cpu);
> > > > >
> > > > > +       intel_pstate_clear_update_util_hook(policy->cpu);
> > > > > +
> > > > >         if (cpu->suspended)
> > > > >                 return 0;
> > > > >
> > > > > @@ -2374,17 +2376,12 @@ static int intel_pstate_cpu_online(struct cpufreq_policy *policy)
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > -static void intel_pstate_stop_cpu(struct cpufreq_policy *policy)
> > > > > -{
> > > > > -       pr_debug("CPU %d stopping\n", policy->cpu);
> > > > > -
> > > > > -       intel_pstate_clear_update_util_hook(policy->cpu);
> > > > > -}
> > > > > -
> > > > >  static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
> > > > >  {
> > > > >         pr_debug("CPU %d exiting\n", policy->cpu);
> > > > >
> > > > > +       intel_pstate_clear_update_util_hook(policy->cpu);
> > > >
> > > > This change is not needed now, because ->offline always runs before
> > > > ->exit if present.
> > >
> > > Not necessarily, we don't call ->offline() for many error paths in
> > > cpufreq_online().
> >
> > I guess you mean the error paths in cpufreq_offline()?
>
> s/offline/online/
>
> > IMO this is confusing/broken, because ->offline should always be
> > called after ->online has returned success.
> >
> > > offline() only comes into play after driver is registered properly once.
> >
> > The relevant intel_pstate case is a ->setpolicy driver where
> > ->setpolicy or ->online, if successful, need to be followed by
> > ->offline.
> >
> > If ->setpolicy is successful in the cpufreq_online() path, the entire
> > cpufreq_online() is successful and the error paths in question are not
> > executed.
> >
> > So the change I was talking about is not needed AFAICS.

Regardless of all of the above, the ->online, ->offline and ->exit
callback routines are used by intel_pstate both in the active mode and
the passive mode, so some more work is needed to migrate it away from
using ->stop_cpu.
