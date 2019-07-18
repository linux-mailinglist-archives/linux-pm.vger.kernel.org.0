Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B61656CD1A
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 13:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389956AbfGRLEl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 07:04:41 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37924 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733131AbfGRLEl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 07:04:41 -0400
Received: by mail-vs1-f68.google.com with SMTP id k9so18806421vso.5
        for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2019 04:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b0wwbY2e6RbRH4G1F2pGlnS3oUwQ5tYaheKqHK1+rAU=;
        b=ttbeDTZWonMsXhhF6MKJjUbS9xB63ArZlyQGS0QGDUinoAJno6rTVe45koBlUp/Qjh
         NQVkV3+Uhr8LVEmlJkoTd3j1VUjoTle0yuSKtRst+PQkt/gZVYtUy6lqHTEGXjhT/c+g
         IQGDz/tqooHxFmm+bsy+QWxFnl/gJ3yFFGgnAhEwcoQT9j9yKAE847bZbd1nj2DTVUjQ
         4Eym5SbEmuUMvs4Bez2aMkN9joceM718Uj77COGoAbpsJLZM8viL9KtrIwGx7UFskjyi
         pLZSUBIJjDLvyPPpTNjVox8LYn55p7hVHfYjzWOLJ8OD+D/+a5uRfl9hwqYR1RVKk0l5
         gVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b0wwbY2e6RbRH4G1F2pGlnS3oUwQ5tYaheKqHK1+rAU=;
        b=FC3ven7QE9DQ4ecIPoKPjtcSkzwM2bAVvYGW30pUR6/NjWQULxZTJtnTgEgHPCazWP
         XNPz0rPN/QNsndKDAHzZk3SWttg99KZG+kpUEdk/piOzrvhMZcSB9B01SdEXdPVvCSwK
         mIdPKmkDjS1NuC0aP12ctlzMU42njmonnYkWm3GofZv7Vgw27vVYBAeqMR2Noxjkm0cX
         qsz2baFNkpY0YFLvk7LHdfcX8eqBT84WgoWmCm5DHEHRQESB3gCLq0MJU74RNTXGDfLc
         WadcOAsMSLtx271yRP6dErl2uwq1XmcD7epjdC3yvCOIfmdAN63H/io1E1kTaQebQQ0f
         6SQA==
X-Gm-Message-State: APjAAAUdEJUAuVWXwAWXX+WlxV/NJdTVS/jgYrlsfXaBMMsbIY1sHFrN
        g5AlgkS/NJsSSZsvZEw4yBQVyT/FePOpkAOXkBL/5Q==
X-Google-Smtp-Source: APXvYqySoFX2rcy6+ZHMwG7nItFm59GgexC/++PhaOS4J9XEwThQRKUsU9BuTaLZC+JTYiMmN5ylobCku0JfERVc6Vg=
X-Received: by 2002:a67:ee16:: with SMTP id f22mr28613664vsp.191.1563447879628;
 Thu, 18 Jul 2019 04:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190513192300.653-1-ulf.hansson@linaro.org> <20190513192300.653-10-ulf.hansson@linaro.org>
 <20190716150533.GD7250@e107155-lin>
In-Reply-To: <20190716150533.GD7250@e107155-lin>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 18 Jul 2019 13:04:03 +0200
Message-ID: <CAPDyKFqaE2L419siFY=LGDsotAnpBt+H_vpmG62AqQw8UQJZJA@mail.gmail.com>
Subject: Re: [PATCH 09/18] drivers: firmware: psci: Add support for PM domains
 using genpd
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lina Iyer <lina.iyer@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 16 Jul 2019 at 17:05, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Mon, May 13, 2019 at 09:22:51PM +0200, Ulf Hansson wrote:
> > When the hierarchical CPU topology layout is used in DT, we need to setup
> > the corresponding PM domain data structures, as to allow a CPU and a group
> > of CPUs to be power managed accordingly. Let's enable this by deploying
> > support through the genpd interface.
> >
> > Additionally, when the OS initiated mode is supported by the PSCI FW, let's
> > also parse the domain idle states DT bindings as to make genpd responsible
> > for the state selection, when the states are compatible with
> > "domain-idle-state". Otherwise, when only Platform Coordinated mode is
> > supported, we rely solely on the state selection to be managed through the
> > regular cpuidle framework.
> >
> > If the initialization of the PM domain data structures succeeds and the OS
> > initiated mode is supported, we try to switch to it. In case it fails,
> > let's fall back into a degraded mode, rather than bailing out and returning
> > an error code.
> >
> > Due to that the OS initiated mode may become enabled, we need to adjust to
> > maintain backwards compatibility for a kernel started through a kexec call.
> > Do this by explicitly switch to Platform Coordinated mode during boot.
> >
> > Finally, the actual initialization of the PM domain data structures, is
> > done via calling the new shared function, psci_dt_init_pm_domains().
> > However, this is implemented by subsequent changes.
> >
> > Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> > Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes:
> >       - Simplify code setting domain_state at power off.
> >       - Use the genpd ->free_state() callback to manage freeing of states.
> >       - Fixup a bogus while loop.
> >
> > ---
> >  drivers/firmware/psci/Makefile         |   2 +-
> >  drivers/firmware/psci/psci.c           |   7 +-
> >  drivers/firmware/psci/psci.h           |   5 +
> >  drivers/firmware/psci/psci_pm_domain.c | 268 +++++++++++++++++++++++++
> >  4 files changed, 280 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/firmware/psci/psci_pm_domain.c
> >
>
> [...]
>
> >  #endif /* __PSCI_H */
> > diff --git a/drivers/firmware/psci/psci_pm_domain.c b/drivers/firmware/psci/psci_pm_domain.c
> > new file mode 100644
> > index 000000000000..3c6ca846caf4
> > --- /dev/null
> > +++ b/drivers/firmware/psci/psci_pm_domain.c
> > @@ -0,0 +1,268 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * PM domains for CPUs via genpd - managed by PSCI.
> > + *
> > + * Copyright (C) 2019 Linaro Ltd.
> > + * Author: Ulf Hansson <ulf.hansson@linaro.org>
> > + *
> > + */
> > +
>
> [...]
>
> > +static int psci_pd_power_off(struct generic_pm_domain *pd)
> > +{
> > +     struct genpd_power_state *state = &pd->states[pd->state_idx];
> > +     u32 *pd_state;
> > +
> > +     /* If we have failed to enable OSI mode, then abort power off. */
> > +     if (psci_has_osi_support() && !osi_mode_enabled)
> > +             return -EBUSY;
> > +
> > +     if (!state->data)
> > +             return 0;
> > +
> > +     /* When OSI mode is enabled, set the corresponding domain state. */
> > +     pd_state = state->data;
> > +     psci_set_domain_state(*pd_state);
>
> I trying to understand how would this scale to level 2(cluster of
> clusters or for simply system). The current code for psci_set_domain_state
> just stores the value @pd_state into per-cpu domain_state. E.g.: Now if
> the system level pd is getting called after cluster PD, it will set the
> domain state to system level PD state. It won't work with original
> format and it may work with extended format if it's carefully crafted.
> In short, the point is just over-writing domain_state is asking for
> troubles IMO.

Thanks for spotting this!

While walking upwards in the PM domain topology, I thought I was ORing
the domain states, but clearly the code isn't doing that.

In principle we need to do the below instead.

pd_state = state->data;
composite_pd_state = *pd_state | psci_get_domain_state();
psci_set_domain_state(composite_pd_state);

Kind regards
Uffe
