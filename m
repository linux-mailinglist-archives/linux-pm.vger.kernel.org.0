Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08AE93A4426
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jun 2021 16:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhFKOhX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Jun 2021 10:37:23 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]:45023 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhFKOhX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Jun 2021 10:37:23 -0400
Received: by mail-qt1-f177.google.com with SMTP id d9so544337qtp.11
        for <linux-pm@vger.kernel.org>; Fri, 11 Jun 2021 07:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N7xLtR6wwfwdyklvarz4WBE3RQ2vMZmVsTn+Ut4XgCk=;
        b=yrKPqiOr+wEuE8yFmhupTukkreGFuO1DwnZ7PaSwKIzCrl7h/yEjlyDx75IUBifHTz
         s3f2XzGsamw3keK9lNSD5C/+XE1p+GLu/acUmEIxCkXNON9iIeLCgqj9s1P+EMfqMf/S
         l7WKAuZvnxrITxYgyPc2nBOgEPqoHaWsM2xPOI9CFF8RNYBnshaf5E2Hqx8Q/dgdDTJL
         LPuLfx6XIM+wUqtvZdgvkK0BSt0tpNzQ/Lm1WJgwyR1Pb8lkDmzC7w/Rkr5imi+RyGZI
         J8aiD51rgh9Zzpq6XTXztQaF/x5AqTSAWYQkF1UNiLjcmIJpJIfLjiHRy1JWmu3IW7j4
         9ZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N7xLtR6wwfwdyklvarz4WBE3RQ2vMZmVsTn+Ut4XgCk=;
        b=ZyMsCinEyQVjWLGtzr5cTMTNg/IRG2nTUpzaBXJHbO/talTGaK+NT0AgVq95EPDq9y
         xmF/+ATO+Z/OZ9Bjwkz9ZQ7UrbvnkwEW2WirUij2q0if11KoZhuzr8kQD2Ca2h1KBrw/
         JwIeNVZrnL0YBfOKSaJeXK2eq/SVbDl/80ursB/RqVG9l/UxJaSRH8cKas0z18ixqh31
         7T6bauX/6uab6HO87dciFg+JhCW0EKQ6Kfaoko5dcXxMLXV9lNUQtexLZQpC4RiaoYgJ
         00h6wTf2JJf8hSTDv9JU38myjCUhv0+9/AmMSb0jPwYM2L6c7SCUqbRClpv0HH0wA7y7
         Mu0A==
X-Gm-Message-State: AOAM532+5xe5KGZjnnTmK3lp8OK6mjFvEf0qPlDNcHwtw+yRv5DjzEMX
        dgFC7PXMuYYhVRBtbEA41s01eeSu2pNbXGPaOv/qT+NKUNL6gA==
X-Google-Smtp-Source: ABdhPJzTF7w5iaBY/15//jWHa3aBgg8bCJQRjPv7SajFfNO3yw3P6Xkyd+HHiFmZD7zf1/EOkpYSGyCWFQiNQmfWB5M=
X-Received: by 2002:ac8:46d1:: with SMTP id h17mr4074536qto.135.1623422051741;
 Fri, 11 Jun 2021 07:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210611101540.3379937-1-dmitry.baryshkov@linaro.org>
 <20210611101540.3379937-3-dmitry.baryshkov@linaro.org> <CAPDyKFo5mUZZcPum9A5mniYSsbG2KBxqw628M622FaP+piG=Pw@mail.gmail.com>
In-Reply-To: <CAPDyKFo5mUZZcPum9A5mniYSsbG2KBxqw628M622FaP+piG=Pw@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 11 Jun 2021 17:34:00 +0300
Message-ID: <CAA8EJprSj8FUuHkFUcinrbfd3oukeLqOivWianBrnt_9Si8ZRQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM: domain: use per-genpd lockdep class
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Added Stephen to Cc list

On Fri, 11 Jun 2021 at 16:50, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 11 Jun 2021 at 12:15, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > In case of nested genpds it is easy to get the following warning from
> > lockdep, because all genpd's mutexes share same locking class. Use the
> > per-genpd locking class to stop lockdep from warning about possible
> > deadlocks. It is not possible to directly use genpd nested locking, as
> > it is not the genpd code calling genpd. There are interim calls to
> > regulator core.
> >
> > [    3.030219] ============================================
> > [    3.030220] WARNING: possible recursive locking detected
> > [    3.030221] 5.13.0-rc3-00054-gf8f0a2f2b643-dirty #2480 Not tainted
> > [    3.030222] --------------------------------------------
> > [    3.030223] kworker/u16:0/7 is trying to acquire lock:
> > [    3.030224] ffffde0eabd29aa0 (&genpd->mlock){+.+.}-{3:3}, at: genpd_lock_mtx+0x18/0x2c
> > [    3.030236]
> > [    3.030236] but task is already holding lock:
> > [    3.030236] ffffde0eabcfd6d0 (&genpd->mlock){+.+.}-{3:3}, at: genpd_lock_mtx+0x18/0x2c
> > [    3.030240]
> > [    3.030240] other info that might help us debug this:
> > [    3.030240]  Possible unsafe locking scenario:
> > [    3.030240]
> > [    3.030241]        CPU0
> > [    3.030241]        ----
> > [    3.030242]   lock(&genpd->mlock);
> > [    3.030243]   lock(&genpd->mlock);
> > [    3.030244]
> > [    3.030244]  *** DEADLOCK ***
> > [    3.030244]
> > [    3.030244]  May be due to missing lock nesting notation
> > [    3.030244]
> > [    3.030245] 6 locks held by kworker/u16:0/7:
> > [    3.030246]  #0: ffff6cca00010938 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1f0/0x730
> > [    3.030252]  #1: ffff8000100c3db0 (deferred_probe_work){+.+.}-{0:0}, at: process_one_work+0x1f0/0x730
> > [    3.030255]  #2: ffff6cca00ce3188 (&dev->mutex){....}-{3:3}, at: __device_attach+0x3c/0x184
> > [    3.030260]  #3: ffffde0eabcfd6d0 (&genpd->mlock){+.+.}-{3:3}, at: genpd_lock_mtx+0x18/0x2c
> > [    3.030264]  #4: ffff8000100c3968 (regulator_ww_class_acquire){+.+.}-{0:0}, at: regulator_lock_dependent+0x6c/0x1b0
> > [    3.030270]  #5: ffff6cca00a59158 (regulator_ww_class_mutex){+.+.}-{3:3}, at: regulator_lock_recursive+0x94/0x1d0
> > [    3.030273]
> > [    3.030273] stack backtrace:
> > [    3.030275] CPU: 6 PID: 7 Comm: kworker/u16:0 Not tainted 5.13.0-rc3-00054-gf8f0a2f2b643-dirty #2480
> > [    3.030276] Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
> > [    3.030278] Workqueue: events_unbound deferred_probe_work_func
> > [    3.030280] Call trace:
> > [    3.030281]  dump_backtrace+0x0/0x1a0
> > [    3.030284]  show_stack+0x18/0x24
> > [    3.030286]  dump_stack+0x108/0x188
> > [    3.030289]  __lock_acquire+0xa20/0x1e0c
> > [    3.030292]  lock_acquire.part.0+0xc8/0x320
> > [    3.030294]  lock_acquire+0x68/0x84
> > [    3.030296]  __mutex_lock+0xa0/0x4f0
> > [    3.030299]  mutex_lock_nested+0x40/0x50
> > [    3.030301]  genpd_lock_mtx+0x18/0x2c
> > [    3.030303]  dev_pm_genpd_set_performance_state+0x94/0x1a0
> > [    3.030305]  reg_domain_enable+0x28/0x4c
> > [    3.030308]  _regulator_do_enable+0x420/0x6b0
> > [    3.030310]  _regulator_enable+0x178/0x1f0
> > [    3.030312]  regulator_enable+0x3c/0x80
>
> At a closer look, I am pretty sure that it's the wrong code design
> that triggers this problem, rather than that we have a real problem in
> genpd. To put it simply, the code in genpd isn't designed to work like
> this. We will end up in circular looking paths, leading to deadlocks,
> sooner or later if we allow the above code path.
>
> To fix it, the regulator here needs to be converted to a proper PM
> domain. This PM domain should be assigned as the parent to the one
> that is requested to be powered on.

This more or less resembles original design, replaced per review
request to use separate regulator
(https://lore.kernel.org/linux-arm-msm/160269659638.884498.4031967462806977493@swboyd.mtv.corp.google.com/,
https://lore.kernel.org/linux-arm-msm/20201023131925.334864-1-dmitry.baryshkov@linaro.org/).

Stephen, would it be fine to you to convert the mmcx regulator into
the PM domain?

> > [    3.030314]  gdsc_toggle_logic+0x30/0x124
> > [    3.030317]  gdsc_enable+0x60/0x290
> > [    3.030318]  _genpd_power_on+0xc0/0x134
> > [    3.030320]  genpd_power_on.part.0+0xa4/0x1f0
> > [    3.030322]  __genpd_dev_pm_attach+0xf4/0x1b0
> > [    3.030324]  genpd_dev_pm_attach+0x60/0x70
> > [    3.030326]  dev_pm_domain_attach+0x54/0x5c
> > [    3.030329]  platform_probe+0x50/0xe0
> > [    3.030330]  really_probe+0xe4/0x510
> > [    3.030332]  driver_probe_device+0x64/0xcc
> > [    3.030333]  __device_attach_driver+0xb8/0x114
> > [    3.030334]  bus_for_each_drv+0x78/0xd0
> > [    3.030337]  __device_attach+0xdc/0x184
> > [    3.030338]  device_initial_probe+0x14/0x20
> > [    3.030339]  bus_probe_device+0x9c/0xa4
> > [    3.030340]  deferred_probe_work_func+0x88/0xc4
> > [    3.030342]  process_one_work+0x298/0x730
> > [    3.030343]  worker_thread+0x74/0x470
> > [    3.030344]  kthread+0x168/0x170
> > [    3.030346]  ret_from_fork+0x10/0x34
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
> Kind regards
> Uffe
>
> > ---
> >  drivers/base/power/domain.c | 25 ++++++++++++++++++++-----
> >  1 file changed, 20 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 74219d032910..bdf439b48763 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -1899,20 +1899,33 @@ static int genpd_set_default_power_state(struct generic_pm_domain *genpd)
> >         return 0;
> >  }
> >
> > -static void genpd_lock_init(struct generic_pm_domain *genpd)
> > +static int genpd_lock_init(struct generic_pm_domain *genpd)
> >  {
> >         if (genpd->flags & GENPD_FLAG_IRQ_SAFE) {
> >                 spin_lock_init(&genpd->slock);
> >                 genpd->lock_ops = &genpd_spin_ops;
> >         } else {
> > -               mutex_init(&genpd->mlock);
> > +               /* Some genpds are static, some are dynamically allocated. To
> > +                * make lockdep happy always allocate the key dynamically and
> > +                * register it. */
> > +               genpd->mlock_key = kzalloc(sizeof(genpd->mlock_key), GFP_KERNEL);
> > +               if (!genpd->mlock_key)
> > +                       return -ENOMEM;
> > +
> > +               lockdep_register_key(genpd->mlock_key);
> > +
> > +               __mutex_init(&genpd->mlock, genpd->name, genpd->mlock_key);
> >                 genpd->lock_ops = &genpd_mtx_ops;
> >         }
> > +
> > +       return 0;
> >  }
> >
> >  static void genpd_lock_destroy(struct generic_pm_domain *genpd) {
> > -       if (!(genpd->flags & GENPD_FLAG_IRQ_SAFE))
> > +       if (!(genpd->flags & GENPD_FLAG_IRQ_SAFE)) {
> >                 mutex_destroy(&genpd->mlock);
> > +               kfree(genpd->mlock_key);
> > +       }
> >  }
> >
> >  /**
> > @@ -1935,7 +1948,10 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
> >         INIT_LIST_HEAD(&genpd->child_links);
> >         INIT_LIST_HEAD(&genpd->dev_list);
> >         RAW_INIT_NOTIFIER_HEAD(&genpd->power_notifiers);
> > -       genpd_lock_init(genpd);
> > +       ret = genpd_lock_init(genpd);
> > +       if (ret)
> > +               return ret;
> > +
> >         genpd->gov = gov;
> >         INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
> >         atomic_set(&genpd->sd_count, 0);
> > @@ -2040,7 +2056,6 @@ static int genpd_remove(struct generic_pm_domain *genpd)
> >                 free_cpumask_var(genpd->cpus);
> >         if (genpd->free_states)
> >                 genpd->free_states(genpd->states, genpd->state_count);
> > -       genpd_lock_destroy(genpd);
> >
> >         pr_debug("%s: removed %s\n", __func__, genpd->name);
> >
> > --
> > 2.30.2
> >



-- 
With best wishes
Dmitry
