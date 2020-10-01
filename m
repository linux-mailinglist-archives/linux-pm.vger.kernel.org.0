Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19EB227FE70
	for <lists+linux-pm@lfdr.de>; Thu,  1 Oct 2020 13:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731877AbgJALci (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Oct 2020 07:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731692AbgJALci (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Oct 2020 07:32:38 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7A3C0613D0
        for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2020 04:32:38 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id e23so2413114vsk.2
        for <linux-pm@vger.kernel.org>; Thu, 01 Oct 2020 04:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZH7jQBZB/HAgbtO2SyW4qZYiSqlYjSnLc4Kr6Sf3SKo=;
        b=X5xzrmcuaHdC7I6CXrtmKYwn0e2PBPyTDiCM1g91kWFgnSHdukQEKfvBqync+gLs2z
         zfIxSTQa1JmB2eoYaxNrAapsun4mJo2DXPRIU6FeY9/bSVnra561UOK0BzozdEV3Y5vw
         WeHkv5N5Z8MPGAZUP6A/LDoJ8dPWzwSxZX+9BcyywfGvdKrOSmVI25k1QCcd6EUxcJqW
         M44c7ofafE8SxXgh8DSKr9wSKZyGg5Yqcd6MlxRFZKNfIzuQhNJP0vTHc1nYQzkXOeRw
         a/70vMe9a9nff91G6U4Gi6vtLqDcKsu0s+OJcvlf//OjSRhLBCqiL8oqZO4DA8get3Gq
         udZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZH7jQBZB/HAgbtO2SyW4qZYiSqlYjSnLc4Kr6Sf3SKo=;
        b=dsGAzyvWXGozdaz3Rz9t/K5oAzDPiLwJ4KXeiYg/nxrAXFvG8mqFZIqJBh3NPmGDtF
         f7D2K+Vb6lE1Zwmg+ox9QiJ6sDbkQUN0Abu0fylqf1FaGNFCfgYkXXFwdjFPjr0S+Fhh
         i/Jo4XR+8ayTpJKppE5p/jDlrnh7XIS7WCYqzJDtINhDYGxWUpyPrFG0Ynf00EXfzAl4
         KqAkgjOut0sd1iVqFWg3Urr7kSGqJ1JHbkUsDpV8i4WXzbTBbf064zMtQu9A8gTtTVzW
         x4cekQte8lbgc21UlTUDlWVgbTX6birQmJlZ+ba4+rlkqeG4Rt7CKu475Gm1+NvCNjER
         S68Q==
X-Gm-Message-State: AOAM533nyrvjWLNqF21R4mav3aEp5u26xLH/bF3AhfOei8iAGzODSXmG
        8Q7NZ3CfqH4kqzvmnxArkEEFIDXbQDzHw1Kyuc/ZuOu1ZYp7qJMG
X-Google-Smtp-Source: ABdhPJwIUwSb8US1bsUI9Cki9ak9E8E3ghISXCekOeQoSN809EI/DJ7HuH2flSLcln77z2tdqhf0JN5mpLZuqfN9484=
X-Received: by 2002:a05:6102:910:: with SMTP id x16mr4271658vsh.42.1601551957226;
 Thu, 01 Oct 2020 04:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200901082707.106860-1-ulf.hansson@linaro.org>
 <20200901082707.106860-3-ulf.hansson@linaro.org> <20201001101756.GB906@bogus>
In-Reply-To: <20201001101756.GB906@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 1 Oct 2020 13:32:00 +0200
Message-ID: <CAPDyKFqNrCo=jGWMp67bKstErE5ZYR+3JzoPyYUtb4y2rK+dOA@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpuidle: psci: Enable s2idle when using OSI with the
 PM domain topology
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 1 Oct 2020 at 12:18, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Tue, Sep 01, 2020 at 10:27:07AM +0200, Ulf Hansson wrote:
> > To select domain idle states for cpuidle-psci, the PM domains via genpd are
> > being managed by using runtime PM. This works fine for the regular idle
> > path, but it doesn't when doing s2idle.
> >
> > More precisely, the domain idle states becomes temporarily disabled, which
> > is because the PM core disables runtime PM for devices during system
> > suspend.
>
> When you refer system suspend above, you mean both S2R and S2I ?

Correct.

Although, there is no problem with S2R to reach the proper idlestate,
because of the way we offline all but the boot CPU.

>
> > Even if genpd tries to power off the PM domain in the
> > suspend_noirq phase, that doesn't help to properly select a domain idle
> > state, as this needs to be done on per CPU basis.
> >
>
> And what prevents doing per CPU basis ?

The PM core doesn't execute the system suspend callbacks on a per CPU basis.

>
> > Let's address the issue by enabling the syscore flag for the attached CPU
> > devices. This prevents genpd from trying to power off the corresponding PM
> > domains in the suspend_noirq phase. Moreover, let's assign a specific
> > ->enter_s2idle() callback for the corresponding domain idle state and let
> > it invoke pm_genpd_syscore_poweroff|poweron(), rather than using runtime
> > PM.
> >
>
> The syscore_suspend is not executed for S2I and using syscore APIs here
> is bit confusing IMO. If Rafael is fine, I have no objections.

That's correct, the syscore phase doesn't exist in the S2I path.

However, in some cases the same functions that are being called in the
syscore phase, are also being called for S2I. For example, have a look
at timekeeping_suspend(), which is being called from both paths.

In the end, I think the confusing part is the name of the genpd functions.

Maybe we should rename pm_genpd_syscore_poweroff|poweron() to
pm_genpd_suspend|resume() - or something along those lines.

Kind regards
Uffe

>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/cpuidle/cpuidle-psci-domain.c |  2 ++
> >  drivers/cpuidle/cpuidle-psci.c        | 30 +++++++++++++++++++++++----
> >  2 files changed, 28 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> > index b6e9649ab0da..65437ba5fa78 100644
> > --- a/drivers/cpuidle/cpuidle-psci-domain.c
> > +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> > @@ -324,6 +324,8 @@ struct device *psci_dt_attach_cpu(int cpu)
> >       if (cpu_online(cpu))
> >               pm_runtime_get_sync(dev);
> >
> > +     dev_pm_syscore_device(dev, true);
> > +
> >       return dev;
> >  }
> >
> > diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> > index 74463841805f..6322d55a0a7d 100644
> > --- a/drivers/cpuidle/cpuidle-psci.c
> > +++ b/drivers/cpuidle/cpuidle-psci.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/psci.h>
> > +#include <linux/pm_domain.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/slab.h>
> >  #include <linux/string.h>
> > @@ -52,8 +53,9 @@ static inline int psci_enter_state(int idx, u32 state)
> >       return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter, idx, state);
> >  }
> >
> > -static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
> > -                                     struct cpuidle_driver *drv, int idx)
> > +static int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
> > +                                       struct cpuidle_driver *drv, int idx,
> > +                                       bool s2idle)
> >  {
> >       struct psci_cpuidle_data *data = this_cpu_ptr(&psci_cpuidle_data);
> >       u32 *states = data->psci_states;
> > @@ -66,7 +68,10 @@ static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
> >               return -1;
> >
> >       /* Do runtime PM to manage a hierarchical CPU toplogy. */
> > -     pm_runtime_put_sync_suspend(pd_dev);
> > +     if (s2idle)
> > +             pm_genpd_syscore_poweroff(pd_dev);
> > +     else
> > +             pm_runtime_put_sync_suspend(pd_dev);
>
> Since CPU genpd is special and handled so in core, can this be moved to core ?
> I mean pm_runtime_put_sync_suspend handle that based genpd_is_cpu_domain.
>
> --
> Regards,
> Sudeep
