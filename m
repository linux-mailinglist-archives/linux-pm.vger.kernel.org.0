Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C017D3A85E6
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jun 2021 18:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbhFOQCs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Jun 2021 12:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbhFOQCn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Jun 2021 12:02:43 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01125C08ECA6
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 08:55:24 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id j11-20020a9d738b0000b02903ea3c02ded8so14777164otk.5
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 08:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4U+6VOy8piCwCU/wIp1TdfkeFmWvFkSF3Yw0z+6ssNY=;
        b=rZ8XT/Mbjssq3qvk1c7DJgzCNYSZVT8cM1/23nmDx7S8hQCtYEJRcOlhP1KOUGZTiU
         5OlqWvsx8NVzTOlERqA0jAYfW86CaTaZE3NlKvKMg8Kld0htJvLWj0Be5KyOSMmzXVJ0
         LAB1tCcZVpKh2Fn5OVlD8A33hwOLtBsk+9wPtJHv4F6peoR9Y6bRXTyRDS4mZreXt3AF
         dGLXw+8/0H3p2I9b3y/BOwcWY1qlVVrA6g1vxnFzA53vgjizZcrSXKst8vl70LR2HdIv
         Gqnfq9nMa87z6J3eCDiYsaUwc61LqjLEBtVFZ1/SpFkM3Sj13Hg2kxGG0Khsj4qyGmbK
         kypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4U+6VOy8piCwCU/wIp1TdfkeFmWvFkSF3Yw0z+6ssNY=;
        b=rrSgXdgiu8gBsVLdXcluWbotZMTHgf7THVnylZE5FHMcjrr6czS1FYB/J5xsqI+1AN
         Y6Vck4uKQYoSSbGbOWBYz6O/kQY+TpVXp+BZ3LPTuTt1wcZoQ/sMzl20s+4aeYyhD3J+
         qSO7XmUpCqUBvDsiGxvjIoFPo5NYiWMG3ywYCS6xqbdp3jSyEr3IFb5XNWFHc4T2EB4b
         JCp/EYPLg7fGo6FCo+ePQ6Po0hA1zXBBqIowJ01UjmaEBz2hpp+UOOHwEwtsPnnWx4Lq
         U7QaDmOVmeHPuYpQ2As5RSEM3JIiBmQ7wpcFcF5KrUYxYK2St9WPW/iR92AA+bdJ6UFV
         f6lw==
X-Gm-Message-State: AOAM533PuQcjRYDqDCluMUzedAhDiRsH3YxzS7xpu/A5DonVKizi4cu/
        3jUu4d0+JOysitcUtBsJjfYPxg==
X-Google-Smtp-Source: ABdhPJxciL6DQT0drKUzihKqgUqRMmOS1IktJGswoChLHQmL4ghHUOyNLEGlGfKxbK0HaVmVGxr0Mw==
X-Received: by 2002:a9d:147:: with SMTP id 65mr9178671otu.315.1623772523083;
        Tue, 15 Jun 2021 08:55:23 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t39sm3892138ooi.42.2021.06.15.08.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 08:55:22 -0700 (PDT)
Date:   Tue, 15 Jun 2021 10:55:20 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] PM: domain: use per-genpd lockdep class
Message-ID: <YMjNaM0z+OzhAeO/@yoga>
References: <20210611101540.3379937-1-dmitry.baryshkov@linaro.org>
 <20210611101540.3379937-3-dmitry.baryshkov@linaro.org>
 <CAPDyKFo5mUZZcPum9A5mniYSsbG2KBxqw628M622FaP+piG=Pw@mail.gmail.com>
 <CAA8EJprSj8FUuHkFUcinrbfd3oukeLqOivWianBrnt_9Si8ZRQ@mail.gmail.com>
 <CAPDyKFoMC_7kJx_Wb4LKgxvRCoqHYFtwsJ2b7Cr4OvjA94DtHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFoMC_7kJx_Wb4LKgxvRCoqHYFtwsJ2b7Cr4OvjA94DtHg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue 15 Jun 05:17 CDT 2021, Ulf Hansson wrote:

> + Mark
> 
> On Fri, 11 Jun 2021 at 16:34, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > Added Stephen to Cc list
> >
> > On Fri, 11 Jun 2021 at 16:50, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Fri, 11 Jun 2021 at 12:15, Dmitry Baryshkov
> > > <dmitry.baryshkov@linaro.org> wrote:
> > > >
> > > > In case of nested genpds it is easy to get the following warning from
> > > > lockdep, because all genpd's mutexes share same locking class. Use the
> > > > per-genpd locking class to stop lockdep from warning about possible
> > > > deadlocks. It is not possible to directly use genpd nested locking, as
> > > > it is not the genpd code calling genpd. There are interim calls to
> > > > regulator core.
> > > >
> > > > [    3.030219] ============================================
> > > > [    3.030220] WARNING: possible recursive locking detected
> > > > [    3.030221] 5.13.0-rc3-00054-gf8f0a2f2b643-dirty #2480 Not tainted
> > > > [    3.030222] --------------------------------------------
> > > > [    3.030223] kworker/u16:0/7 is trying to acquire lock:
> > > > [    3.030224] ffffde0eabd29aa0 (&genpd->mlock){+.+.}-{3:3}, at: genpd_lock_mtx+0x18/0x2c
> > > > [    3.030236]
> > > > [    3.030236] but task is already holding lock:
> > > > [    3.030236] ffffde0eabcfd6d0 (&genpd->mlock){+.+.}-{3:3}, at: genpd_lock_mtx+0x18/0x2c
> > > > [    3.030240]
> > > > [    3.030240] other info that might help us debug this:
> > > > [    3.030240]  Possible unsafe locking scenario:
> > > > [    3.030240]
> > > > [    3.030241]        CPU0
> > > > [    3.030241]        ----
> > > > [    3.030242]   lock(&genpd->mlock);
> > > > [    3.030243]   lock(&genpd->mlock);
> > > > [    3.030244]
> > > > [    3.030244]  *** DEADLOCK ***
> > > > [    3.030244]
> > > > [    3.030244]  May be due to missing lock nesting notation
> > > > [    3.030244]
> > > > [    3.030245] 6 locks held by kworker/u16:0/7:
> > > > [    3.030246]  #0: ffff6cca00010938 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1f0/0x730
> > > > [    3.030252]  #1: ffff8000100c3db0 (deferred_probe_work){+.+.}-{0:0}, at: process_one_work+0x1f0/0x730
> > > > [    3.030255]  #2: ffff6cca00ce3188 (&dev->mutex){....}-{3:3}, at: __device_attach+0x3c/0x184
> > > > [    3.030260]  #3: ffffde0eabcfd6d0 (&genpd->mlock){+.+.}-{3:3}, at: genpd_lock_mtx+0x18/0x2c
> > > > [    3.030264]  #4: ffff8000100c3968 (regulator_ww_class_acquire){+.+.}-{0:0}, at: regulator_lock_dependent+0x6c/0x1b0
> > > > [    3.030270]  #5: ffff6cca00a59158 (regulator_ww_class_mutex){+.+.}-{3:3}, at: regulator_lock_recursive+0x94/0x1d0
> > > > [    3.030273]
> > > > [    3.030273] stack backtrace:
> > > > [    3.030275] CPU: 6 PID: 7 Comm: kworker/u16:0 Not tainted 5.13.0-rc3-00054-gf8f0a2f2b643-dirty #2480
> > > > [    3.030276] Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
> > > > [    3.030278] Workqueue: events_unbound deferred_probe_work_func
> > > > [    3.030280] Call trace:
> > > > [    3.030281]  dump_backtrace+0x0/0x1a0
> > > > [    3.030284]  show_stack+0x18/0x24
> > > > [    3.030286]  dump_stack+0x108/0x188
> > > > [    3.030289]  __lock_acquire+0xa20/0x1e0c
> > > > [    3.030292]  lock_acquire.part.0+0xc8/0x320
> > > > [    3.030294]  lock_acquire+0x68/0x84
> > > > [    3.030296]  __mutex_lock+0xa0/0x4f0
> > > > [    3.030299]  mutex_lock_nested+0x40/0x50
> > > > [    3.030301]  genpd_lock_mtx+0x18/0x2c
> > > > [    3.030303]  dev_pm_genpd_set_performance_state+0x94/0x1a0
> > > > [    3.030305]  reg_domain_enable+0x28/0x4c
> > > > [    3.030308]  _regulator_do_enable+0x420/0x6b0
> > > > [    3.030310]  _regulator_enable+0x178/0x1f0
> > > > [    3.030312]  regulator_enable+0x3c/0x80
> > >
> > > At a closer look, I am pretty sure that it's the wrong code design
> > > that triggers this problem, rather than that we have a real problem in
> > > genpd. To put it simply, the code in genpd isn't designed to work like
> > > this. We will end up in circular looking paths, leading to deadlocks,
> > > sooner or later if we allow the above code path.
> > >
> > > To fix it, the regulator here needs to be converted to a proper PM
> > > domain. This PM domain should be assigned as the parent to the one
> > > that is requested to be powered on.
> >
> > This more or less resembles original design, replaced per review
> > request to use separate regulator
> > (https://lore.kernel.org/linux-arm-msm/160269659638.884498.4031967462806977493@swboyd.mtv.corp.google.com/,
> > https://lore.kernel.org/linux-arm-msm/20201023131925.334864-1-dmitry.baryshkov@linaro.org/).
> 
> Thanks for the pointers. In hindsight, it looks like the
> "regulator-fixed-domain" DT binding wasn't the right thing.
> 
> Fortunately, it looks like the problem can be quite easily fixed, by
> moving to a correct model of the domain hierarchy.
> 

Can you give some pointers to how we actually fix this?

The problem that lead us down this path is that drivers/clk/qcom/gdsc.c
describes power domains, which are parented by domains provided by
drivers/soc/qcom/rpmhpd.c.

But I am unable to find a way for the gdsc driver to get hold of the
struct generic_pm_domain of the resources exposed by the rpmhpd driver.


The second thing that Dmitry's regulator driver does is to cast the
appropriate performance state vote on the rpmhpd resource, but I _think_
we can do that using OPP tables in the gdsc client's node...

> Beyond this, perhaps we should consider removing the
> "regulator-fixed-domain" DT property, as to avoid similar problems
> from cropping up?
> 

Currently there's a single user upstream, but we have the exact same
problem in at least 3-4 platforms with patches in the pipeline.

In order to avoid breakage with existing DT I would prefer to see
regulator-fixed-domain to live for at least one kernel release beyond
the introduction of the other model.

Regards,
Bjorn

> Mark, what do you think?
> 
> >
> > Stephen, would it be fine to you to convert the mmcx regulator into
> > the PM domain?
> >
> > > > [    3.030314]  gdsc_toggle_logic+0x30/0x124
> > > > [    3.030317]  gdsc_enable+0x60/0x290
> > > > [    3.030318]  _genpd_power_on+0xc0/0x134
> > > > [    3.030320]  genpd_power_on.part.0+0xa4/0x1f0
> > > > [    3.030322]  __genpd_dev_pm_attach+0xf4/0x1b0
> > > > [    3.030324]  genpd_dev_pm_attach+0x60/0x70
> > > > [    3.030326]  dev_pm_domain_attach+0x54/0x5c
> > > > [    3.030329]  platform_probe+0x50/0xe0
> > > > [    3.030330]  really_probe+0xe4/0x510
> > > > [    3.030332]  driver_probe_device+0x64/0xcc
> > > > [    3.030333]  __device_attach_driver+0xb8/0x114
> > > > [    3.030334]  bus_for_each_drv+0x78/0xd0
> > > > [    3.030337]  __device_attach+0xdc/0x184
> > > > [    3.030338]  device_initial_probe+0x14/0x20
> > > > [    3.030339]  bus_probe_device+0x9c/0xa4
> > > > [    3.030340]  deferred_probe_work_func+0x88/0xc4
> > > > [    3.030342]  process_one_work+0x298/0x730
> > > > [    3.030343]  worker_thread+0x74/0x470
> > > > [    3.030344]  kthread+0x168/0x170
> > > > [    3.030346]  ret_from_fork+0x10/0x34
> > > >
> > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> [...]
> 
> Kind regards
> Uffe
