Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4A23B711A
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jun 2021 13:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbhF2LIJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Jun 2021 07:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbhF2LIJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Jun 2021 07:08:09 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054C0C061766
        for <linux-pm@vger.kernel.org>; Tue, 29 Jun 2021 04:05:41 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id c17so4652169vke.3
        for <linux-pm@vger.kernel.org>; Tue, 29 Jun 2021 04:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WP9FCchbYJUzB6R/6/ON+Jxuohq8iRqrZSlVU+Rrjw4=;
        b=zNr+QhaljzVJUuIU6WIzFWUp2fx5Zye3NMgh8bh6xk0b2roPZpTtoVSfeLaT2XxQjS
         xdLhk5kJbjFk1+xksm0cEpgAHjr0/+emTpi1vydDyk1uP74+O1Yp4leXdmkCl8qIHxto
         V1bQDPVwF3QzMjvMuzEdzUhCED4YX5HknrFMp0sBqG05hVIgSLoFaeSQUI3W72g8O/vU
         SMbEkekpIK6mnmmE0DxLP67UdCNud2T4zSy+dXafM+5JrrgoFh9N0G3oG+C6RhqJiYy4
         9xkmzqR5CZnfXuOX0AV5D/Hr8AnoOZnuoRtF+91O3hIUCdtBw1uG9wSxgPGCYC20S8XF
         emVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WP9FCchbYJUzB6R/6/ON+Jxuohq8iRqrZSlVU+Rrjw4=;
        b=KUiA2VVKkpOIS+BB95G+Tog2S1vQbm5NRWyJO2KjQqwslJsuTFHZIO27MQqD25U6P0
         qdY7pCP7cxxB+pnpVjfwTJOcWfGyZ+xtWcV0T4OcNpoDpN1B1Kgaja1GXmtcqP7FNg74
         B1WGWzyBmz64TgrS4Z5xjbrbMHFm3qVLSJwQTw7cazqn89kRGd+Y9ybSKn8eGAsK4OgV
         U8JNtHevrvi+RX4qKHgbi3t3+9HUfYl7TVvnUvBQLI139sKBueF4YcNhkJfsz3Mv04dP
         B1fLneCgezUH8MoF48dmPUq4Mo2Nywz9+Q2WwvHnd/fNFRJm1X27zycFJh/SQt4C2iT2
         VZjA==
X-Gm-Message-State: AOAM5315EU9pkNdi1bnLA+M0Ypo/1858yCJyPYtRgV9HtCdC5/aZ0EhQ
        wIttlXMdpUglpZO1M2hCIzn1NyofccsScPNyPAUMIw==
X-Google-Smtp-Source: ABdhPJwXMYfdnb7T7AYFJna2nyocO4egiU9UjX+Mf3NaiSST/rUSiqCxhW5VJEWDTjoBKswtFQdyPzENurhdzMgN/2U=
X-Received: by 2002:a1f:1d94:: with SMTP id d142mr21604483vkd.6.1624964740826;
 Tue, 29 Jun 2021 04:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210611101540.3379937-1-dmitry.baryshkov@linaro.org>
 <20210611101540.3379937-3-dmitry.baryshkov@linaro.org> <CAPDyKFo5mUZZcPum9A5mniYSsbG2KBxqw628M622FaP+piG=Pw@mail.gmail.com>
 <CAA8EJprSj8FUuHkFUcinrbfd3oukeLqOivWianBrnt_9Si8ZRQ@mail.gmail.com>
 <CAPDyKFoMC_7kJx_Wb4LKgxvRCoqHYFtwsJ2b7Cr4OvjA94DtHg@mail.gmail.com>
 <YMjNaM0z+OzhAeO/@yoga> <CAPDyKFo_eNwEx5rryg3bHt_-pxBeeYfVrUZuTOHoL-x94LBwDA@mail.gmail.com>
 <c6e99362-56c1-f2bd-7170-7b001e0f96fe@linaro.org>
In-Reply-To: <c6e99362-56c1-f2bd-7170-7b001e0f96fe@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 29 Jun 2021 13:05:04 +0200
Message-ID: <CAPDyKFqEn2JNao3w9FYmxN92Hrf=e71W77_4ZB=d0NfSEqoY7A@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM: domain: use per-genpd lockdep class
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
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

On Mon, 28 Jun 2021 at 21:55, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> Hi,
>
> On 17/06/2021 12:07, Ulf Hansson wrote:
> > + Rajendra
> >
> > On Tue, 15 Jun 2021 at 17:55, Bjorn Andersson
> > <bjorn.andersson@linaro.org> wrote:
> >>
> >> On Tue 15 Jun 05:17 CDT 2021, Ulf Hansson wrote:
> >>
> >>> + Mark
> >>>
> >>> On Fri, 11 Jun 2021 at 16:34, Dmitry Baryshkov
> >>> <dmitry.baryshkov@linaro.org> wrote:
> >>>>
> >>>> Added Stephen to Cc list
> >>>>
> >>>> On Fri, 11 Jun 2021 at 16:50, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >>>>>
> >>>>> On Fri, 11 Jun 2021 at 12:15, Dmitry Baryshkov
> >>>>> <dmitry.baryshkov@linaro.org> wrote:
> >>>>>>
> >>>>>> In case of nested genpds it is easy to get the following warning from
> >>>>>> lockdep, because all genpd's mutexes share same locking class. Use the
> >>>>>> per-genpd locking class to stop lockdep from warning about possible
> >>>>>> deadlocks. It is not possible to directly use genpd nested locking, as
> >>>>>> it is not the genpd code calling genpd. There are interim calls to
> >>>>>> regulator core.
> >>>>>>
> >>>>>> [    3.030219] ============================================
> >>>>>> [    3.030220] WARNING: possible recursive locking detected
> >>>>>> [    3.030221] 5.13.0-rc3-00054-gf8f0a2f2b643-dirty #2480 Not tainted
> >>>>>> [    3.030222] --------------------------------------------
> >>>>>> [    3.030223] kworker/u16:0/7 is trying to acquire lock:
> >>>>>> [    3.030224] ffffde0eabd29aa0 (&genpd->mlock){+.+.}-{3:3}, at: genpd_lock_mtx+0x18/0x2c
> >>>>>> [    3.030236]
> >>>>>> [    3.030236] but task is already holding lock:
> >>>>>> [    3.030236] ffffde0eabcfd6d0 (&genpd->mlock){+.+.}-{3:3}, at: genpd_lock_mtx+0x18/0x2c
> >>>>>> [    3.030240]
> >>>>>> [    3.030240] other info that might help us debug this:
> >>>>>> [    3.030240]  Possible unsafe locking scenario:
> >>>>>> [    3.030240]
> >>>>>> [    3.030241]        CPU0
> >>>>>> [    3.030241]        ----
> >>>>>> [    3.030242]   lock(&genpd->mlock);
> >>>>>> [    3.030243]   lock(&genpd->mlock);
> >>>>>> [    3.030244]
> >>>>>> [    3.030244]  *** DEADLOCK ***
> >>>>>> [    3.030244]
> >>>>>> [    3.030244]  May be due to missing lock nesting notation
> >>>>>> [    3.030244]
> >>>>>> [    3.030245] 6 locks held by kworker/u16:0/7:
> >>>>>> [    3.030246]  #0: ffff6cca00010938 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1f0/0x730
> >>>>>> [    3.030252]  #1: ffff8000100c3db0 (deferred_probe_work){+.+.}-{0:0}, at: process_one_work+0x1f0/0x730
> >>>>>> [    3.030255]  #2: ffff6cca00ce3188 (&dev->mutex){....}-{3:3}, at: __device_attach+0x3c/0x184
> >>>>>> [    3.030260]  #3: ffffde0eabcfd6d0 (&genpd->mlock){+.+.}-{3:3}, at: genpd_lock_mtx+0x18/0x2c
> >>>>>> [    3.030264]  #4: ffff8000100c3968 (regulator_ww_class_acquire){+.+.}-{0:0}, at: regulator_lock_dependent+0x6c/0x1b0
> >>>>>> [    3.030270]  #5: ffff6cca00a59158 (regulator_ww_class_mutex){+.+.}-{3:3}, at: regulator_lock_recursive+0x94/0x1d0
> >>>>>> [    3.030273]
> >>>>>> [    3.030273] stack backtrace:
> >>>>>> [    3.030275] CPU: 6 PID: 7 Comm: kworker/u16:0 Not tainted 5.13.0-rc3-00054-gf8f0a2f2b643-dirty #2480
> >>>>>> [    3.030276] Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
> >>>>>> [    3.030278] Workqueue: events_unbound deferred_probe_work_func
> >>>>>> [    3.030280] Call trace:
> >>>>>> [    3.030281]  dump_backtrace+0x0/0x1a0
> >>>>>> [    3.030284]  show_stack+0x18/0x24
> >>>>>> [    3.030286]  dump_stack+0x108/0x188
> >>>>>> [    3.030289]  __lock_acquire+0xa20/0x1e0c
> >>>>>> [    3.030292]  lock_acquire.part.0+0xc8/0x320
> >>>>>> [    3.030294]  lock_acquire+0x68/0x84
> >>>>>> [    3.030296]  __mutex_lock+0xa0/0x4f0
> >>>>>> [    3.030299]  mutex_lock_nested+0x40/0x50
> >>>>>> [    3.030301]  genpd_lock_mtx+0x18/0x2c
> >>>>>> [    3.030303]  dev_pm_genpd_set_performance_state+0x94/0x1a0
> >>>>>> [    3.030305]  reg_domain_enable+0x28/0x4c
> >>>>>> [    3.030308]  _regulator_do_enable+0x420/0x6b0
> >>>>>> [    3.030310]  _regulator_enable+0x178/0x1f0
> >>>>>> [    3.030312]  regulator_enable+0x3c/0x80
> >>>>>
> >>>>> At a closer look, I am pretty sure that it's the wrong code design
> >>>>> that triggers this problem, rather than that we have a real problem in
> >>>>> genpd. To put it simply, the code in genpd isn't designed to work like
> >>>>> this. We will end up in circular looking paths, leading to deadlocks,
> >>>>> sooner or later if we allow the above code path.
> >>>>>
> >>>>> To fix it, the regulator here needs to be converted to a proper PM
> >>>>> domain. This PM domain should be assigned as the parent to the one
> >>>>> that is requested to be powered on.
> >>>>
> >>>> This more or less resembles original design, replaced per review
> >>>> request to use separate regulator
> >>>> (https://lore.kernel.org/linux-arm-msm/160269659638.884498.4031967462806977493@swboyd.mtv.corp.google.com/,
> >>>> https://lore.kernel.org/linux-arm-msm/20201023131925.334864-1-dmitry.baryshkov@linaro.org/).
> >>>
> >>> Thanks for the pointers. In hindsight, it looks like the
> >>> "regulator-fixed-domain" DT binding wasn't the right thing.
> >>>
> >>> Fortunately, it looks like the problem can be quite easily fixed, by
> >>> moving to a correct model of the domain hierarchy.
> >>>
> >>
> >> Can you give some pointers to how we actually fix this?
> >>
> >> The problem that lead us down this path is that drivers/clk/qcom/gdsc.c
> >> describes power domains, which are parented by domains provided by
> >> drivers/soc/qcom/rpmhpd.c.
> >>
> >> But I am unable to find a way for the gdsc driver to get hold of the
> >> struct generic_pm_domain of the resources exposed by the rpmhpd driver.
> >
> > You don't need a handle to the struct generic_pm_domain, to assign a
> > parent/child domain. Instead you can use of_genpd_add_subdomain(),
> > which takes two "struct of_phandle_args*" corresponding to the
> > parent/child device nodes of the genpd providers and then let genpd
> > internally do the look up.
>
> I've taken a look onto of_genpd_add_subdomain. Please correct me if I'm
> wrong, I have the feeling that this function is badly designed. It
> provokes to use the following sequence:
> - register child domain
> - register child's domain provider
> - mark child as a subdomain of a parent.
>
> So we have a (short) timeslice when users can get hold of child domain,
> but the system knows about a child domain, but does not about a
> parent/child relationship.

Correct!

This is tricky, but the best we have managed to come up with, so far.

Additionally, I think this hasn't been an issue, because providers and
subdomains have been registered way earlier than consumers. Of course,
it would be nice with a more robust solution.

>
> I think this function should be changed to take struct generic_pm_domain
> as a second argument. I will attempt refactoring cpuidle-psci-domain to
> follow this, let's see if this will work.

I am not sure what is the best approach here. You may be right.

>
> Another option would be to export genpd_get_from_provider() and to use
> genpd_add_subdomain() directly.

That could work too.

Another option would be to introduce an intermediate state for the
genpd provider, that can be used to prevent devices from getting
attached to it (returning -EPROBE_DEFER if that happens), until the
topology (child/parent domains) has been initialized as well. Just
thinking out loud...

>
> I think I'd need this function anyway for the gdsc code. During
> gdsc_init() we check gdsc status and this requires register access (and
> thus powering on the parent domain) before the gdsc is registered itself
> as a power domain.

As a workaround (temporary), perhaps you can add a ->sync_state()
callback to mitigate part of the problems (which gets called when
*all* consumers are attached), along the lines of what we also do in
the cpuidle-psci-domain.

Kind regards
Uffe
