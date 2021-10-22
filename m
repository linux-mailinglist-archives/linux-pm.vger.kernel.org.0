Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DA74377B2
	for <lists+linux-pm@lfdr.de>; Fri, 22 Oct 2021 15:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbhJVNKf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Oct 2021 09:10:35 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:40745 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbhJVNKf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Oct 2021 09:10:35 -0400
Received: by mail-ot1-f45.google.com with SMTP id s18-20020a0568301e1200b0054e77a16651so4296601otr.7;
        Fri, 22 Oct 2021 06:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ea+dffKzojjtHMbhrke+o7EPuvNXQWSumCl4dU8Qqig=;
        b=4i6xGWRBoBlmCZATjMRmxLlwHHGMcX962FAND/yM7QCxVefn+BTJwdqcTZaJ9l8Z3l
         Tb4sGxfZIew5fSZbboID0/NAjZZrTceAO4IyIDOeDGVqTNIiTaDQpIihZeoC13lDHtvQ
         y/nJqR0R8FL0B0gk/I7wWxyQ3ZbvBqGW9PDmwx8AX8u475p9rUlf2/PstjTmQOQZSwTp
         CIIXbSf6QSfdzyWucrbdxzznw5MpvCTpniwtWtDZ20qfz/1Igi06fAu4BrqAr5vGy5Wk
         mZ7v4UrShNQiNdpZ88SbmWwSaBrHluUB3p2HzejRkgphjoGvRjj0E4QMweXjK7Q+/4Th
         CiqQ==
X-Gm-Message-State: AOAM530OdtyhBc8653OC74+9jlUkAGlHEQTBgnFMcPDFnr0wEQ38QA8K
        VIx2k0/RMNI+9vSqdx+BF2vGoiRjJsRcx0thCewA3NADRSw=
X-Google-Smtp-Source: ABdhPJwVN538gMKknUUa3nQaPjG1oX9Ha/E3NnrsQHxPcgMmQ76YFoE9DYKjOzQgSqA45RqB9kS6R7iNphBQyTsWI9o=
X-Received: by 2002:a05:6830:90b:: with SMTP id v11mr10046614ott.254.1634908097786;
 Fri, 22 Oct 2021 06:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210929144451.113334-1-ulf.hansson@linaro.org>
 <20210929144451.113334-3-ulf.hansson@linaro.org> <CAJZ5v0hgdQeJ+6mLMLQcvnM_+EiyDBERj54aT2cL=HiTO9nMNQ@mail.gmail.com>
 <CAPDyKFpep3aPmGGo=aA5dHZZjb-O51et47C9_hgVbZbXMJZX_g@mail.gmail.com>
 <CAJZ5v0j=Fi5vOh45de-u7FwsCm4zsAsHepp16xQ3U5_WjrtWJw@mail.gmail.com>
 <CAPDyKFqeAFhgCFSaFAWnp5xorxSVwAL=z2g6vHJ0PWjtt9GDNg@mail.gmail.com>
 <CAJZ5v0iA4O=tx7qiLKCOze87dcUtwtDJqi2B+2O=oOyCSzgmtQ@mail.gmail.com>
 <CAPDyKFr_-ON1JWXe3W7DAXUzKdrceqXPwLAdHnKeXajy=pFnug@mail.gmail.com>
 <CAJZ5v0itweerfbq8NE9rEonZ2Nfu_nfKgERv2tweeLO4fgAgLg@mail.gmail.com>
 <CAPDyKFrOSd2xEXuvDki9Em+xFLHfeTfZz3NtnWwNmWB1H6i=Kg@mail.gmail.com>
 <CAJZ5v0j3a_m5T9nbxk4VSuABOq12JEC0fi=0SQ8+=Vwv-qDeOA@mail.gmail.com>
 <CAPDyKFpjy5sZo6ayqPx07Jzs4J2yePy=cZk=k6VjhWB7zGeedg@mail.gmail.com>
 <CAPDyKFooeseEXW-O8DCAd5Jku1n0iNXfHFt_HVjcfMYFvw4a2g@mail.gmail.com>
 <CAJZ5v0i5qQ7bXoG3cK2LESibKRb3sahmaC-M2_mgwqSSS6Sz1Q@mail.gmail.com> <CAPDyKFr8fSBbQVknws0BEXX-3fFg8XCLSJToCXc-26wdKb83qA@mail.gmail.com>
In-Reply-To: <CAPDyKFr8fSBbQVknws0BEXX-3fFg8XCLSJToCXc-26wdKb83qA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Oct 2021 15:08:06 +0200
Message-ID: <CAJZ5v0gSPfZBc+0vH=1icJj1JYN8A6owXWUNOUgxX-dMeaiG9A@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM: sleep: Fix runtime PM based cpuidle support
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Len Brown <len.brown@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 22, 2021 at 2:57 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 22 Oct 2021 at 14:02, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Fri, Oct 22, 2021 at 12:18 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Thu, 21 Oct 2021 at 21:56, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > On Thu, 21 Oct 2021 at 21:02, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > >
> > > > > On Thu, Oct 21, 2021 at 8:12 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > >
> > > > > > On Thu, 21 Oct 2021 at 18:33, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > > >
> > > > > > > On Thu, Oct 21, 2021 at 6:17 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > >
> > > > > [cut]
> > > > >
> > > > > > > So in theory you could check the pm_runtime_put_sync_suspend() return
> > > > > > > value and fall back to something like WFI if that's an error code.
> > > > > >
> > > > > > I have already tried that, but it simply got too complicated. The main
> > > > > > issue was that runtime PM could become disabled for the device in the
> > > > > > middle of executing the ->enter() callback.
> > > > >
> > > > > So IIUC the problem is that you cannot resume after suspending in that case.
> > > > >
> > > > > IOW, you need to guarantee that if the suspend is successful, the
> > > > > resume also will take place, but if the suspend fails, you basically
> > > > > don't care.
> > > >
> > > > Exactly.
> > > >
> > > > >
> > > > > > For example, if pm_runtime_get_sync() fails, I still need to make sure
> > > > > > the reference counting in genpd becomes correct - and I can't do that
> > > > > > using dev_pm_genpd_resume(). That's because it's not designed to be
> > > > > > called in this "unknown" suspend phase, but should be called after the
> > > > > > noirq phase and be properly balanced with dev_pm_genpd_suspend().
> > > > > >
> > > > > > In other words, the error path didn't work out for me.
> > > > >
> > > > > It should be sufficient to call wake_up_all_idle_cpus() in the suspend
> > > > > path before dpm_suspend_late(), because system suspend acquires a
> > > > > PM-runtime reference on every device.  IOW, it won't let any devices
> > > > > runtime-suspend, so if your power domain devices are resumed in that
> > > > > path, they will never suspend again in it and the
> > > > > pm_runtime_put_sync_suspend() in __psci_enter_domain_idle_state()
> > > > > becomes a reference counter management call which works regardless of
> > > > > whether or not PM runtime is disabled.
> > > >
> > > > That sounds like a great idea, this should work too! Then the question
> > > > is, how to make that call to wake_up_all_idle_cpus() to become
> > > > optional - or only invoked for the cpuidle drivers that need it.
> >
> > It need not be optional.
> >
> > For suspend-to-idle it doesn't matter, because all CPUs will be woken
> > up from idle shortly anyway.
> >
> > For other suspend variants this doesn't matter, because all secondary
> > CPUs will be taken offline shortly and the primary CPU will call into
> > the platform "sleep" handler.
> >
> > > >
> > > > In any case, I will try this out, thanks for the suggestion!
> > >
> > > I now recall that I have already tried this, but unfortunately it doesn't work.
> > >
> > > The problem is that the dev->power.syscore flag is set for the device,
> > > which makes device_prepare() to bail out early and skip calling
> > > pm_runtime_get_noresume().
> >
> > This needs to be fixed, then.
>
> So bumping the usage count even if the dev->power.syscore is set,
> should be fine? (And of course dropping it in the complete phase).

Yes, please see
https://patchwork.kernel.org/project/linux-pm/patch/5773062.lOV4Wx5bFT@kreacher/

It should have been done this way from the outset, but I messed up a
merge (and said that it was "trivial" :-/).

> I can work with that, let me try!
