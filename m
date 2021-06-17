Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E123AAF4C
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jun 2021 11:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhFQJJx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Jun 2021 05:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhFQJJw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jun 2021 05:09:52 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8F5C061574
        for <linux-pm@vger.kernel.org>; Thu, 17 Jun 2021 02:07:43 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id j19so1240064vkj.0
        for <linux-pm@vger.kernel.org>; Thu, 17 Jun 2021 02:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wXHJ7ss3OtBtqBAeFZEzYKlhCeBHxtiwTpmWUd/NWDM=;
        b=Z4Rj3kpkc5jZPGLcD2bVuGjbTkUQHbRePGY25Bfpmh+ykfEXHyhUouBKBNIaffz0Ql
         ycQXFOy/i36aor27toKh+Qw13Q8tmHElBuSC06bznCg+E1AnbimyDtH3uNbQc23bLO4M
         br6RuaCIaKLXQtEVqZV3sjPCTeE1yPFz50G70O/9+ejnWPbjpFxluoOyNTmhnh7Np1em
         5Zr1D5bSE6mkbGVEXWZQmGpdXx0t6dWhIwOevL9yzJuy0EDAx3fEnew97M805rOKnXZO
         CbzXFLQ6QDjOmkviHWRnZZVe+HkByejaZVFcy+dnrpy2KIlvcQOV7qkAs6o+mEN/yYqS
         c03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wXHJ7ss3OtBtqBAeFZEzYKlhCeBHxtiwTpmWUd/NWDM=;
        b=I56CUliW9ATvJfb4PZxWhX3T0aSogvQdtuQOhTWmLou90gs3HvDhTMiBRtpCBWBSQ7
         UyMb0y8l9IBkAmrSlXrqjBzPetkTZdiu1Zue1aaTUuE46QmJVi4q5n5KDA1wFWMjLZIP
         44QabrpbN/mwRJeH4p6QO3dYudWQYTLEj+DrWhrzvtcNQysWIgWraj4zc8WjCkTYxlFe
         4UUu9EwMO57PHu/ZM960fvHl4jq+DYrUXpWq9IfT1JywZmCFBAoOEH1yAllKxgF7NBQl
         KGpFzgbOsntYeM5kND3DCjtYj0VDHRZ05WOhHjxkygP6b0t7vf1URvqw7xzq2HQN91kh
         ceJA==
X-Gm-Message-State: AOAM531zzbYwhLwwH4QLle7sAZNCkTN3s3I7wv6QQ4usNItnb/KB0nPc
        NqGyaBL2BxZ0glU+5QfS1LFvf+r6LwyH92IQTyfwPw==
X-Google-Smtp-Source: ABdhPJwsJbOl/h0XxpwZ5ApmB06rowa2s6aG7gZ8PpXfjBG6cq6wvSVLfgxujkX4WdL82WHn85SUKUS8Lp3ou0oDK90=
X-Received: by 2002:a1f:9542:: with SMTP id x63mr2943949vkd.15.1623920862482;
 Thu, 17 Jun 2021 02:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210611101540.3379937-1-dmitry.baryshkov@linaro.org>
 <20210611101540.3379937-3-dmitry.baryshkov@linaro.org> <CAPDyKFo5mUZZcPum9A5mniYSsbG2KBxqw628M622FaP+piG=Pw@mail.gmail.com>
 <CAA8EJprSj8FUuHkFUcinrbfd3oukeLqOivWianBrnt_9Si8ZRQ@mail.gmail.com>
 <CAPDyKFoMC_7kJx_Wb4LKgxvRCoqHYFtwsJ2b7Cr4OvjA94DtHg@mail.gmail.com> <YMjNaM0z+OzhAeO/@yoga>
In-Reply-To: <YMjNaM0z+OzhAeO/@yoga>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Jun 2021 11:07:06 +0200
Message-ID: <CAPDyKFo_eNwEx5rryg3bHt_-pxBeeYfVrUZuTOHoL-x94LBwDA@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM: domain: use per-genpd lockdep class
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

+ Rajendra

On Tue, 15 Jun 2021 at 17:55, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Tue 15 Jun 05:17 CDT 2021, Ulf Hansson wrote:
>
> > + Mark
> >
> > On Fri, 11 Jun 2021 at 16:34, Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > Added Stephen to Cc list
> > >
> > > On Fri, 11 Jun 2021 at 16:50, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > On Fri, 11 Jun 2021 at 12:15, Dmitry Baryshkov
> > > > <dmitry.baryshkov@linaro.org> wrote:
> > > > >
> > > > > In case of nested genpds it is easy to get the following warning from
> > > > > lockdep, because all genpd's mutexes share same locking class. Use the
> > > > > per-genpd locking class to stop lockdep from warning about possible
> > > > > deadlocks. It is not possible to directly use genpd nested locking, as
> > > > > it is not the genpd code calling genpd. There are interim calls to
> > > > > regulator core.
> > > > >
> > > > > [    3.030219] ============================================
> > > > > [    3.030220] WARNING: possible recursive locking detected
> > > > > [    3.030221] 5.13.0-rc3-00054-gf8f0a2f2b643-dirty #2480 Not tainted
> > > > > [    3.030222] --------------------------------------------
> > > > > [    3.030223] kworker/u16:0/7 is trying to acquire lock:
> > > > > [    3.030224] ffffde0eabd29aa0 (&genpd->mlock){+.+.}-{3:3}, at: genpd_lock_mtx+0x18/0x2c
> > > > > [    3.030236]
> > > > > [    3.030236] but task is already holding lock:
> > > > > [    3.030236] ffffde0eabcfd6d0 (&genpd->mlock){+.+.}-{3:3}, at: genpd_lock_mtx+0x18/0x2c
> > > > > [    3.030240]
> > > > > [    3.030240] other info that might help us debug this:
> > > > > [    3.030240]  Possible unsafe locking scenario:
> > > > > [    3.030240]
> > > > > [    3.030241]        CPU0
> > > > > [    3.030241]        ----
> > > > > [    3.030242]   lock(&genpd->mlock);
> > > > > [    3.030243]   lock(&genpd->mlock);
> > > > > [    3.030244]
> > > > > [    3.030244]  *** DEADLOCK ***
> > > > > [    3.030244]
> > > > > [    3.030244]  May be due to missing lock nesting notation
> > > > > [    3.030244]
> > > > > [    3.030245] 6 locks held by kworker/u16:0/7:
> > > > > [    3.030246]  #0: ffff6cca00010938 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1f0/0x730
> > > > > [    3.030252]  #1: ffff8000100c3db0 (deferred_probe_work){+.+.}-{0:0}, at: process_one_work+0x1f0/0x730
> > > > > [    3.030255]  #2: ffff6cca00ce3188 (&dev->mutex){....}-{3:3}, at: __device_attach+0x3c/0x184
> > > > > [    3.030260]  #3: ffffde0eabcfd6d0 (&genpd->mlock){+.+.}-{3:3}, at: genpd_lock_mtx+0x18/0x2c
> > > > > [    3.030264]  #4: ffff8000100c3968 (regulator_ww_class_acquire){+.+.}-{0:0}, at: regulator_lock_dependent+0x6c/0x1b0
> > > > > [    3.030270]  #5: ffff6cca00a59158 (regulator_ww_class_mutex){+.+.}-{3:3}, at: regulator_lock_recursive+0x94/0x1d0
> > > > > [    3.030273]
> > > > > [    3.030273] stack backtrace:
> > > > > [    3.030275] CPU: 6 PID: 7 Comm: kworker/u16:0 Not tainted 5.13.0-rc3-00054-gf8f0a2f2b643-dirty #2480
> > > > > [    3.030276] Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
> > > > > [    3.030278] Workqueue: events_unbound deferred_probe_work_func
> > > > > [    3.030280] Call trace:
> > > > > [    3.030281]  dump_backtrace+0x0/0x1a0
> > > > > [    3.030284]  show_stack+0x18/0x24
> > > > > [    3.030286]  dump_stack+0x108/0x188
> > > > > [    3.030289]  __lock_acquire+0xa20/0x1e0c
> > > > > [    3.030292]  lock_acquire.part.0+0xc8/0x320
> > > > > [    3.030294]  lock_acquire+0x68/0x84
> > > > > [    3.030296]  __mutex_lock+0xa0/0x4f0
> > > > > [    3.030299]  mutex_lock_nested+0x40/0x50
> > > > > [    3.030301]  genpd_lock_mtx+0x18/0x2c
> > > > > [    3.030303]  dev_pm_genpd_set_performance_state+0x94/0x1a0
> > > > > [    3.030305]  reg_domain_enable+0x28/0x4c
> > > > > [    3.030308]  _regulator_do_enable+0x420/0x6b0
> > > > > [    3.030310]  _regulator_enable+0x178/0x1f0
> > > > > [    3.030312]  regulator_enable+0x3c/0x80
> > > >
> > > > At a closer look, I am pretty sure that it's the wrong code design
> > > > that triggers this problem, rather than that we have a real problem in
> > > > genpd. To put it simply, the code in genpd isn't designed to work like
> > > > this. We will end up in circular looking paths, leading to deadlocks,
> > > > sooner or later if we allow the above code path.
> > > >
> > > > To fix it, the regulator here needs to be converted to a proper PM
> > > > domain. This PM domain should be assigned as the parent to the one
> > > > that is requested to be powered on.
> > >
> > > This more or less resembles original design, replaced per review
> > > request to use separate regulator
> > > (https://lore.kernel.org/linux-arm-msm/160269659638.884498.4031967462806977493@swboyd.mtv.corp.google.com/,
> > > https://lore.kernel.org/linux-arm-msm/20201023131925.334864-1-dmitry.baryshkov@linaro.org/).
> >
> > Thanks for the pointers. In hindsight, it looks like the
> > "regulator-fixed-domain" DT binding wasn't the right thing.
> >
> > Fortunately, it looks like the problem can be quite easily fixed, by
> > moving to a correct model of the domain hierarchy.
> >
>
> Can you give some pointers to how we actually fix this?
>
> The problem that lead us down this path is that drivers/clk/qcom/gdsc.c
> describes power domains, which are parented by domains provided by
> drivers/soc/qcom/rpmhpd.c.
>
> But I am unable to find a way for the gdsc driver to get hold of the
> struct generic_pm_domain of the resources exposed by the rpmhpd driver.

You don't need a handle to the struct generic_pm_domain, to assign a
parent/child domain. Instead you can use of_genpd_add_subdomain(),
which takes two "struct of_phandle_args*" corresponding to the
parent/child device nodes of the genpd providers and then let genpd
internally do the look up.

As an example, you may have a look at how the PM domain topology in
drivers/cpuidle/cpuidle-psci-domain.c are being created.

>
>
> The second thing that Dmitry's regulator driver does is to cast the
> appropriate performance state vote on the rpmhpd resource, but I _think_
> we can do that using OPP tables in the gdsc client's node...

Yes, it looks like using an OPP table and to specify a
"required-opps", at some device node is the right thing to do.

In this case, I wonder if the "required-opps" belongs to the genpd
provider node of the new power-domain (as it seems like it only
supports one fixed performance state when it's powered on). On the
other hand, specifying this at the consumer node should work as well,
I think.

Actually, this relates to the changes [1] that Rajendra is working on
with "assigned-performance-state" (that we agreed to move to
OPP/required-opps) for genpd.

>
> > Beyond this, perhaps we should consider removing the
> > "regulator-fixed-domain" DT property, as to avoid similar problems
> > from cropping up?
> >
>
> Currently there's a single user upstream, but we have the exact same
> problem in at least 3-4 platforms with patches in the pipeline.
>
> In order to avoid breakage with existing DT I would prefer to see
> regulator-fixed-domain to live for at least one kernel release beyond
> the introduction of the other model.

Yes, this seems reasonable to me.

As Mark suggested, let's mark the regulator-fixed-domain DT property
as deprecated and remove it once we have the new solution in place.

[...]

Kind regards
Uffe
