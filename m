Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1382AD66F
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 13:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgKJMgQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 07:36:16 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44306 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgKJMgQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 07:36:16 -0500
Received: by mail-ot1-f67.google.com with SMTP id f16so12293504otl.11;
        Tue, 10 Nov 2020 04:36:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w5f5uEO3r6sI5bF7NOkmG8gXoj1KbzEchukRim9NVXM=;
        b=jaFeMUIw3NIFMwCF8v6Yl5DQrDw/E0j6r19qdN7/g/lhVYyAI8EOGm+Jkj1HLa78/7
         yhyF6uInIWWeCI88jtvbeX0no98QN1+/6Lgx2xQhpGVgYgTFDNNq+c7bqpmWRSltKU7M
         qeW6pK8dTRzdVzsFf14QohqNj3yCeqrHjVXSkGm7RTcQhzvMhIOIdHgc8QLyTHI5Dc6A
         +a2p5mvuG3sFDSF0HUl5pKziWfsPkDaHax7oeDCd8dS+yUjwUwOiSxVr89hB262nGvCe
         nQaj/LXNLxuGnTdwzPTQETWpPGUl/LHPuJj/qYO4BNgDQVMDEQojzIlGnfD3ZtTcTDYI
         QrnA==
X-Gm-Message-State: AOAM5333+K893422dRdRb3uc+6o3mRmcW8Caz93J9G0kVQLCEwHSx+ov
        DY8AM7CyYZuotywkHtQBabMb2JyPxw0ZwhTzq3w=
X-Google-Smtp-Source: ABdhPJw7mPJnbOdO+7/bFNde1IAr06+jLWsQGqCoGogkClkKskzCXz49C20taI6hoTbLByE+OR4kS9he0j9Nwm6qQN4=
X-Received: by 2002:a9d:222f:: with SMTP id o44mr14179002ota.321.1605011775337;
 Tue, 10 Nov 2020 04:36:15 -0800 (PST)
MIME-Version: 1.0
References: <13269660.K2JYd4sGFX@kreacher> <1876249.M1ZxxmeKtZ@kreacher> <20201110024126.v4yxai5hpguj5p5b@vireshk-i7>
In-Reply-To: <20201110024126.v4yxai5hpguj5p5b@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Nov 2020 13:36:02 +0100
Message-ID: <CAJZ5v0jkdF7_JKBA0R0kvhzv-ZaLr3m9MS1g_D=vs3ZObv1VVw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] cpufreq: Introduce governor flags
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 10, 2020 at 3:41 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 09-11-20, 17:51, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > A new cpufreq governor flag will be added subsequently, so replace
> > the bool dynamic_switching fleid in struct cpufreq_governor with a
> > flags field and introduce CPUFREQ_GOV_FLAG_DYN_SWITCH to set for
> > the "dynamic switching" governors instead of it.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpufreq/cpufreq.c          |    2 +-
> >  drivers/cpufreq/cpufreq_governor.h |    2 +-
> >  include/linux/cpufreq.h            |    9 +++++++--
> >  kernel/sched/cpufreq_schedutil.c   |    2 +-
> >  4 files changed, 10 insertions(+), 5 deletions(-)
> >
> > Index: linux-pm/drivers/cpufreq/cpufreq.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> > +++ linux-pm/drivers/cpufreq/cpufreq.c
> > @@ -2254,7 +2254,7 @@ static int cpufreq_init_governor(struct
> >               return -EINVAL;
> >
> >       /* Platform doesn't want dynamic frequency switching ? */
> > -     if (policy->governor->dynamic_switching &&
>
> I completely forgot that we had something like this :)
>
> > +     if (policy->governor->flags & CPUFREQ_GOV_FLAG_DYN_SWITCH &&
> >           cpufreq_driver->flags & CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING) {
> >               struct cpufreq_governor *gov = cpufreq_fallback_governor();
> >
> > Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
> > ===================================================================
> > --- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
> > +++ linux-pm/drivers/cpufreq/cpufreq_governor.h
> > @@ -156,7 +156,7 @@ void cpufreq_dbs_governor_limits(struct
> >  #define CPUFREQ_DBS_GOVERNOR_INITIALIZER(_name_)                     \
> >       {                                                               \
> >               .name = _name_,                                         \
> > -             .dynamic_switching = true,                              \
> > +             .flags = CPUFREQ_GOV_FLAG_DYN_SWITCH,                   \
> >               .owner = THIS_MODULE,                                   \
> >               .init = cpufreq_dbs_governor_init,                      \
> >               .exit = cpufreq_dbs_governor_exit,                      \
> > Index: linux-pm/include/linux/cpufreq.h
> > ===================================================================
> > --- linux-pm.orig/include/linux/cpufreq.h
> > +++ linux-pm/include/linux/cpufreq.h
> > @@ -565,12 +565,17 @@ struct cpufreq_governor {
> >                                        char *buf);
> >       int     (*store_setspeed)       (struct cpufreq_policy *policy,
> >                                        unsigned int freq);
> > -     /* For governors which change frequency dynamically by themselves */
> > -     bool                    dynamic_switching;
> >       struct list_head        governor_list;
> >       struct module           *owner;
> > +     u8                      flags;
> >  };
> >
> > +/* Governor flags */
> > +
> > +/* For governors which change frequency dynamically by themselves */
> > +#define CPUFREQ_GOV_FLAG_DYN_SWITCH  BIT(0)
>
> Maybe just drop the FLAG_ part as we don't use it for other cpufreq related
> flags as well. That will also give us space to write DYN as DYNAMIC (it may be
> better as we use the full name in CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING).

OK, I'll rename the flag (and the new one too).

> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks!
