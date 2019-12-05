Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD5E611477A
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 20:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbfLETJu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 14:09:50 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43503 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729154AbfLETJu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 14:09:50 -0500
Received: by mail-vs1-f65.google.com with SMTP id x4so3195612vsx.10
        for <linux-pm@vger.kernel.org>; Thu, 05 Dec 2019 11:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ILaMMkvaYZdTEn9N5ID+w+KajntPsh0cUlzTBSDC4p4=;
        b=IFt+drSUROavwJPYugNH2X/YbWSRwxG/BdxhW2v81LkP8A2ULAE7Z8E2Dk22utRjfA
         W1BBoeKfNfxyul73LoOrDEaFk7y1HB8NBQuBibwCUuI741JObkqFldT3cqBxGyrXx2aG
         E4CqZQk1+b73+OSJn4TogwMEFEgfqt6Bu2dTT1uskULcRiZBH99dQvsuHu1NHwAQ25Dg
         J+fqapkJHLhisMlwzGKrwF1qPAerWGsfr9SCBfy+JWwozPGBMARlKU+zg538Ih58V3J2
         M9Pf9pMb/kYJ+n7oUvb3Hm1UjAUVlo8NOfq332/bGMEET6WQH7kxcOVNKTXM4Ws+B971
         4cxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ILaMMkvaYZdTEn9N5ID+w+KajntPsh0cUlzTBSDC4p4=;
        b=biavo9GPRLTY3q22/GP7DCKigpsU8BkLfG5XsgYiGEQ+N7yJriBo7pOrMngXRsji6m
         KcXEhoDvvytctfAIxOoKXj/daB1BsfNclpzJQEFDeCF6CHbr7KjpB4FqHHXeyXAMtpnI
         hAbxUOxDsJCvtGaRbaPIZ9slqh0J0bYz/p9ChkTCEDTyOL1waDcQFy6iDFxoKpAykJBK
         owKQoVITR7pPNsH6mQxDgEbiXbSS/PnglN6sqnlAqjglHX7dA4OWPqfiLXiEZTS+Frju
         iBaAha3VIe7WRsDXNKiZ0a3BmFyhiwgy2Ge1zjbRpIpBQhzv+kpYUpXsR7CgivHyr7iC
         rQyw==
X-Gm-Message-State: APjAAAWlvPRkFztpatgKUD7/Y90vPRz1SiRVmQ/51rR2ITELzyeCVaa4
        5SLz9TI8bZFbD/k6QRMWGkmGjbGaoaCEkWxLd4141Ymp0fE=
X-Google-Smtp-Source: APXvYqxTBWC9tDgc9MGtVq+ND3cgq49rt/p2HN7s/qmqVdeTi9khHm8G2DQOeq1Q0i+EIvq5qez4iIOFXgOcXQOZCiM=
X-Received: by 2002:a67:2087:: with SMTP id g129mr6827450vsg.191.1575572989281;
 Thu, 05 Dec 2019 11:09:49 -0800 (PST)
MIME-Version: 1.0
References: <20191205103330.27166-1-ulf.hansson@linaro.org> <20191205180653.GA1516@e121166-lin.cambridge.arm.com>
In-Reply-To: <20191205180653.GA1516@e121166-lin.cambridge.arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Dec 2019 20:09:13 +0100
Message-ID: <CAPDyKFpvkjVKFSMRNgen7JWi5DMvTC3H1nqwcSoR3dQkHzfQZw@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: psci: Support CPU hotplug for the hierarchical model
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 5 Dec 2019 at 19:07, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Thu, Dec 05, 2019 at 11:33:30AM +0100, Ulf Hansson wrote:
> > When the hierarchical CPU topology is used and when a CPU is put offline,
> > that CPU prevents its PM domain from being powered off, which is because
> > genpd observes the corresponding attached device as being active from a
> > runtime PM point of view. Furthermore, any potential master PM domains are
> > also prevented from being powered off.
> >
> > To address this limitation, let's add add a new CPU hotplug state
> > (CPUHP_AP_CPU_PM_STARTING) and register up/down callbacks for it, which
> > allows us to deal with runtime PM accordingly.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Lorenzo, Sudeep, Rafael, Daniel,
> >
> > Note that, this patch is based upon a recently posted series [1] and the intent
> > is to queue it on top. I can fold it into the series and resend it all, if that
> > makes it easier for people. Just tell me what you prefer.
> >
> > Kind regards
> > Uffe
> >
> > [1]
> > https://patchwork.kernel.org/cover/11263735/
> >
> > ---
> >  drivers/cpuidle/cpuidle-psci.c | 45 +++++++++++++++++++++++++++++++++-
> >  include/linux/cpuhotplug.h     |  1 +
> >  2 files changed, 45 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> > index 835c7c3aa118..46b481c524cc 100644
> > --- a/drivers/cpuidle/cpuidle-psci.c
> > +++ b/drivers/cpuidle/cpuidle-psci.c
> > @@ -8,6 +8,7 @@
> >
> >  #define pr_fmt(fmt) "CPUidle PSCI: " fmt
> >
> > +#include <linux/cpuhotplug.h>
> >  #include <linux/cpuidle.h>
> >  #include <linux/cpumask.h>
> >  #include <linux/cpu_pm.h>
> > @@ -31,6 +32,7 @@ struct psci_cpuidle_data {
> >
> >  static DEFINE_PER_CPU_READ_MOSTLY(struct psci_cpuidle_data, psci_cpuidle_data);
> >  static DEFINE_PER_CPU(u32, domain_state);
> > +static bool psci_cpuidle_use_cpuhp;
> >
> >  void psci_set_domain_state(u32 state)
> >  {
> > @@ -72,6 +74,44 @@ static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
> >       return ret;
> >  }
> >
> > +static int psci_idle_cpuhp_up(unsigned int cpu)
> > +{
> > +     struct device *pd_dev = __this_cpu_read(psci_cpuidle_data.dev);
> > +
> > +     if (pd_dev)
> > +             pm_runtime_get_sync(pd_dev);
> > +
> > +     return 0;
> > +}
> > +
> > +static int psci_idle_cpuhp_down(unsigned int cpu)
> > +{
> > +     struct device *pd_dev = __this_cpu_read(psci_cpuidle_data.dev);
> > +
> > +     if (pd_dev) {
> > +             pm_runtime_put_sync(pd_dev);
> > +             /* Clear domain state to start fresh at next online. */
> > +             psci_set_domain_state(0);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void psci_idle_init_cpuhp(void)
> > +{
> > +     int err;
> > +
> > +     if (!psci_cpuidle_use_cpuhp)
> > +             return;
> > +
> > +     err = cpuhp_setup_state_nocalls(CPUHP_AP_CPU_PM_STARTING,
> > +                                     "cpuidle/psci:online",
> > +                                     psci_idle_cpuhp_up,
> > +                                     psci_idle_cpuhp_down);
>
> I would make it a cpuhp_setup_state() call and remove
>
> if (cpu_online(cpu))
>         pm_runtime_get_sync_dev(dev);
>
> in check in psci_dt_attach_cpu().
>
> Lorenzo

Thanks for the suggestion, but that doesn't work when
CONFIG_CPU_HOTPLUG is unset.

As a matter of fact, I just realized that I haven't tried to compile
without that Kconfig option. I should probably add a stub for
psci_idle_init_cpuhp() to address that.

>
> > +     if (err)
> > +             pr_warn("Failed %d while setup cpuhp state\n", err);
> > +}
> > +
> >  static int psci_enter_idle_state(struct cpuidle_device *dev,
> >                               struct cpuidle_driver *drv, int idx)
> >  {
> > @@ -161,9 +201,11 @@ static int __init psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
> >       }
> >
> >       /* Manage the deepest state via a dedicated enter-function. */
> > -     if (dev)
> > +     if (dev) {
> >               drv->states[state_count - 1].enter =
> >                       psci_enter_domain_idle_state;
> > +             psci_cpuidle_use_cpuhp = true;
> > +     }
> >
> >       data->dev = dev;
> >
> > @@ -285,6 +327,7 @@ static int __init psci_idle_init(void)
> >                       goto out_fail;
> >       }
> >
> > +     psci_idle_init_cpuhp();
> >       return 0;
> >
> >  out_fail:
> > diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> > index e51ee772b9f5..01f04ed6ad92 100644
> > --- a/include/linux/cpuhotplug.h
> > +++ b/include/linux/cpuhotplug.h
> > @@ -95,6 +95,7 @@ enum cpuhp_state {
> >       CPUHP_AP_OFFLINE,
> >       CPUHP_AP_SCHED_STARTING,
> >       CPUHP_AP_RCUTREE_DYING,
> > +     CPUHP_AP_CPU_PM_STARTING,
> >       CPUHP_AP_IRQ_GIC_STARTING,
> >       CPUHP_AP_IRQ_HIP04_STARTING,
> >       CPUHP_AP_IRQ_ARMADA_XP_STARTING,
> > --
> > 2.17.1
> >

Kind regards
Uffe
