Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F019E391C
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2019 19:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405976AbfJXRB6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Oct 2019 13:01:58 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39269 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730622AbfJXRB5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Oct 2019 13:01:57 -0400
Received: by mail-vs1-f67.google.com with SMTP id y129so16677373vsc.6
        for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2019 10:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NtQVfUVz2FV0gTSPzMm+cpXFmzct1iFbD6hJDcVtKUA=;
        b=t77I8kGwdUnaDJulyJxolE1Luw8F7JqtXHn7quj7/fUKnmi2K2rRZgTah11TU7kgPF
         7PmziGtitlWlatAceURR8G10nlYdBfzZ8Q5HvVUYWCwu4cH+ANF96V8FO+45ffUkDnxT
         RmTpNtrF8OAACZev9ZvchjpdwWLA0KBBBTeD8uGFbv1hBaRgmZTrL05hJOKbMrY0ZheS
         /8k8YMx7PjONZjEteNbEQdtoCmW2oBNTfcvFz1xXmsPJeN5EQG6D74BwzKpyEZX6Cvob
         SW6/kSweOfZDbkHWcspOdN7/bxo3hHqEqYSVfi+TJ0u7BG7ThMludvlAPJyxwTgR9nHx
         x6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NtQVfUVz2FV0gTSPzMm+cpXFmzct1iFbD6hJDcVtKUA=;
        b=mgy6Osgrloz6O7/e3VUmjuDRcGrSb/P1JoFlx8I3SB6vMWHI9JU/N/bEK5CMBOrWoX
         RCde7nS4FiR+HYTGGyC+LoP7d2yrBl4Sn0YDZcoOaPB4t154nKN8GCX4V5/r69Znpmqn
         ptAuEHXCnSEL5y7hYmnJKwRKYOFAgvsoWpPAJbNdVrgVam/e+A8rV/dp8MwLUS+wwgoq
         LbXbPFFIOALKtvHTpetN8WuyRx8H+xkgy/KpM3zwWnl+aAFCarLh3syo1LpbmFilsSbH
         tLibrJlC0mCD5baIvtD/10wFl3HewP29gI1Ez1NF0n7ecNXY8sX74dAwPSy09qdRldc8
         MfgA==
X-Gm-Message-State: APjAAAWOftWFxxJZe38DvuV17sHiCxxTd9g+ReBfLXY1mMcbARpR/GlK
        5q4GMfR2dr0r/D6ybf55DI9IAxGu5OjwlNY2Njb43A==
X-Google-Smtp-Source: APXvYqwEQrfMYEQUWIJNCSq021TdmBydPjq8g8NeoBcj8NbB+JWZn8Qj6wMLt4Lhu5OVOw9XhknTHcJMharuO317lxE=
X-Received: by 2002:a67:ead4:: with SMTP id s20mr7390409vso.165.1571936516180;
 Thu, 24 Oct 2019 10:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20191010113937.15962-1-ulf.hansson@linaro.org>
 <20191010113937.15962-9-ulf.hansson@linaro.org> <20191024154204.GB21622@bogus>
In-Reply-To: <20191024154204.GB21622@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 24 Oct 2019 19:01:20 +0200
Message-ID: <CAPDyKFpd2d8RSa5dg1Ry94rdtCgose-+46ywXu=n7XH86D5msQ@mail.gmail.com>
Subject: Re: [PATCH 08/13] cpuidle: psci: Prepare to use OS initiated suspend
 mode via PM domains
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Lina Iyer <lina.iyer@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 24 Oct 2019 at 17:42, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Oct 10, 2019 at 01:39:32PM +0200, Ulf Hansson wrote:
> > The per CPU variable psci_power_state, contains an array of fixed values,
> > which reflects the corresponding arm,psci-suspend-param parsed from DT, for
> > each of the available CPU idle states.
> >
> > This isn't sufficient when using the hierarchical CPU topology in DT, in
> > combination with having PSCI OS initiated (OSI) mode enabled. More
> > precisely, in OSI mode, Linux is responsible of telling the PSCI FW what
> > idle state the cluster (a group of CPUs) should enter, while in PSCI
> > Platform Coordinated (PC) mode, each CPU independently votes for an idle
> > state of the cluster.
> >
> > For this reason, introduce a per CPU variable called domain_state and
> > implement two helper functions to read/write its value. Then let the
> > domain_state take precedence over the regular selected state, when idling
> > the CPU in psci_enter_idle_state().
> >
> > This allows subsequent patches that implements support for PM domains for
> > cpuidle-psci, to write the selected idle state parameter for the cluster
> > into the domain_state variable. Furthermore, let's share the needed
> > functions in a header file, to enable the support for PM domains to be
> > implemented in a separate c-file.
> >
> > Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> > Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/cpuidle/cpuidle-psci.c | 31 ++++++++++++++++++++++++++++---
> >  drivers/cpuidle/cpuidle-psci.h | 11 +++++++++++
> >  2 files changed, 39 insertions(+), 3 deletions(-)
> >  create mode 100644 drivers/cpuidle/cpuidle-psci.h
> >
> > diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> > index 5c30f23a8a7b..a16467daf99d 100644
> > --- a/drivers/cpuidle/cpuidle-psci.c
> > +++ b/drivers/cpuidle/cpuidle-psci.c
> > @@ -20,17 +20,42 @@
> >
> >  #include <asm/cpuidle.h>
> >
> > +#include "cpuidle-psci.h"
> >  #include "dt_idle_states.h"
> >
> >  static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
> > +static DEFINE_PER_CPU(u32, domain_state);
> > +
>
> [nit] for me name 'domain_state' is per domain and for one each in the
> hierarchical topology. But here it's per cpu, just wondering if we can
> rename it to provide implicit meaning ?

Feel free to suggest something. I couldn't find any better. :-)

>
> > +void psci_set_domain_state(u32 state)
> > +{
> > +     __this_cpu_write(domain_state, state);
> > +}
> > +
> > +static inline u32 psci_get_domain_state(void)
> > +{
> > +     return __this_cpu_read(domain_state);
> > +}
> > +
> > +static int __psci_enter_idle_state(int idx, u32 state)
> > +{
> > +     return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter, idx, state);
> > +}
> >
> >  static int psci_enter_idle_state(struct cpuidle_device *dev,
> >                               struct cpuidle_driver *drv, int idx)
> >  {
> > +     int ret;
> >       u32 *states = __this_cpu_read(psci_power_state);
> > -     u32 state = idx ? states[idx - 1] : 0;
> > +     u32 state = psci_get_domain_state();
> >
> > -     return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter, idx, state);
> > +     if (!state && idx)
> > +             state = states[idx - 1];
>
> This can go as mentioned earlier once we have entry for WFI also.
>
> > +
> > +     ret = __psci_enter_idle_state(idx, state);
> > +
> > +     /* Clear the domain state to start fresh when back from idle. */
> > +     psci_set_domain_state(0);
> > +     return ret;
> >  }
> >
> >  static struct cpuidle_driver psci_idle_driver __initdata = {
> > @@ -56,7 +81,7 @@ static const struct of_device_id psci_idle_state_match[] __initconst = {
> >       { },
> >  };
> >
> > -static int __init psci_dt_parse_state_node(struct device_node *np, u32 *state)
> > +int __init psci_dt_parse_state_node(struct device_node *np, u32 *state)
>
> Can this me made part of patch that uses it instead of here ?

Sure, just wanted to keep the all the preparations for the PM domains
support together.

But you have a point, let me move this part to the patch that needs it.

Kind regards
Uffe
