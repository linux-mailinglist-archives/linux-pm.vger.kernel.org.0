Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2058C6A418
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 10:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbfGPIq2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 04:46:28 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:45771 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbfGPIq1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 04:46:27 -0400
Received: by mail-ua1-f66.google.com with SMTP id v18so7851354uad.12
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 01:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NBVHquOpHCj1lFm8EjHsR8Y4yEo3VOFxQv1yTdErFMI=;
        b=ImcB64YsoZNyYRw61c36XDOwtCGTj3HynvPTU9TSL1vV4eQfqWk9cFiJzJncZbKUqZ
         cZFFCwdDDohk/80qZU6xQeR5vixhx5Z8UfLfdbq988cxJaPcTlE5sSARFyqIoxvaLd5p
         nyWveUgv1khGANlpDp2raHrCrcUMtxyhz8sAtz41ntvwMAW3LE32DbDl8apfq8dGkRDZ
         UX2Lz+7rWzY32m7eI9KQOfRS1Fn6G07QF3tpo7xfOGuM05xuLIkkOXk/7EpE/9skZ1c6
         PyW44Ifn8NU967I5TZvxBpz7Q8x1U2J3bkLSKK43QDMMj+8+qsIUF5HdJUki448yd0WV
         SPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NBVHquOpHCj1lFm8EjHsR8Y4yEo3VOFxQv1yTdErFMI=;
        b=GEoaWl0lDni9BRXxu39c4hTHz15ObaNjBlwO3Wn3eBU+9eH2f3uyWcYUmBxnxCs3nS
         GoUXwXjN0pTAk/EJvhgXLMF3jq3K9a8SQ7I9hXkDPlNVVAiLjthnnZSkAIAFEvwyDNnw
         39O2AITem4XM9UdLo/lGUYoK3zi2QVR2CXdLdEVx8l72PT4lbX7v2SIV8U60B6msfOCn
         yFuIg2VylfN7HwxVjj5Kfq5C+uqMWfd7Gj9wTzvkGAaqf0jxw3svuMkkRgRU1El0ZMrB
         00v8T+yHIjVbFy3oDNhB52aU550a4UrHrFSQoVJV6YMUXynuUD5W88UsaJRxRbcszomB
         d6YQ==
X-Gm-Message-State: APjAAAWcGXHye4tTATLLnG86ZHjM13DWZl0QT6ftv4cGpagNlyGzk0el
        GpF9V1rJegqNRfX4D33b6AsS4B1xUV8d5MraSQsXYw==
X-Google-Smtp-Source: APXvYqxIvVm10Yc/2DFCYMqoQDjDY7D+QeQkssOr3Ej7Wxfoj9xy2xeuXyFo8DffbncEmwhEsMTG2NXyw6eP2QdDvpE=
X-Received: by 2002:ab0:60ad:: with SMTP id f13mr8811202uam.129.1563266786313;
 Tue, 16 Jul 2019 01:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190513192300.653-1-ulf.hansson@linaro.org> <20190513192300.653-11-ulf.hansson@linaro.org>
 <20190709153138.GA22871@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190709153138.GA22871@e121166-lin.cambridge.arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 16 Jul 2019 10:45:49 +0200
Message-ID: <CAPDyKFpd5Jip+ZDENXVC115JJgCReJa4G92aKa45Lna6BeV5-g@mail.gmail.com>
Subject: Re: [PATCH 10/18] drivers: firmware: psci: Add hierarchical domain
 idle states converter
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Lorenzo,

Just wanted to give some feedback to you in public, even if we have
already discussed this series, offlist, last week.

On Tue, 9 Jul 2019 at 17:31, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Mon, May 13, 2019 at 09:22:52PM +0200, Ulf Hansson wrote:
> > If the hierarchical CPU topology is used, but the OS initiated mode isn't
> > supported, we need to rely solely on the regular cpuidle framework to
> > manage the idle state selection, rather than using genpd and its governor.
> >
> > For this reason, introduce a new PSCI DT helper function,
> > psci_dt_pm_domains_parse_states(), which parses and converts the
> > hierarchically described domain idle states from DT, into regular flattened
> > cpuidle states. The converted states are added to the existing cpuidle
> > driver's array of idle states, which make them available for cpuidle.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes:
> >       - Some simplification of the code.
> >
> > ---
> >  drivers/firmware/psci/psci.h           |   5 ++
> >  drivers/firmware/psci/psci_pm_domain.c | 118 +++++++++++++++++++++++++
> >  2 files changed, 123 insertions(+)
> >
> > diff --git a/drivers/firmware/psci/psci.h b/drivers/firmware/psci/psci.h
> > index 00d2e3dcef49..c36e0e6649e9 100644
> > --- a/drivers/firmware/psci/psci.h
> > +++ b/drivers/firmware/psci/psci.h
> > @@ -3,6 +3,7 @@
> >  #ifndef __PSCI_H
> >  #define __PSCI_H
> >
> > +struct cpuidle_driver;
> >  struct device_node;
> >
> >  int psci_set_osi_mode(void);
> > @@ -13,8 +14,12 @@ void psci_set_domain_state(u32 state);
> >  int psci_dt_parse_state_node(struct device_node *np, u32 *state);
> >  #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
> >  int psci_dt_init_pm_domains(struct device_node *np);
> > +int psci_dt_pm_domains_parse_states(struct cpuidle_driver *drv,
> > +             struct device_node *cpu_node, u32 *psci_states);
> >  #else
> >  static inline int psci_dt_init_pm_domains(struct device_node *np) { return 0; }
> > +static inline int psci_dt_pm_domains_parse_states(struct cpuidle_driver *drv,
> > +             struct device_node *cpu_node, u32 *psci_states) { return 0; }
> >  #endif
> >  #endif
> >
> > diff --git a/drivers/firmware/psci/psci_pm_domain.c b/drivers/firmware/psci/psci_pm_domain.c
> > index 3c6ca846caf4..3aa645dba81b 100644
> > --- a/drivers/firmware/psci/psci_pm_domain.c
> > +++ b/drivers/firmware/psci/psci_pm_domain.c
> > @@ -14,6 +14,10 @@
> >  #include <linux/pm_domain.h>
> >  #include <linux/slab.h>
> >  #include <linux/string.h>
> > +#include <linux/cpuidle.h>
> > +#include <linux/cpu_pm.h>
> > +
> > +#include <asm/cpuidle.h>
> >
> >  #include "psci.h"
> >
> > @@ -104,6 +108,53 @@ static void psci_pd_free_states(struct genpd_power_state *states,
> >       kfree(states);
> >  }
> >
> > +static int psci_pd_enter_pc(struct cpuidle_device *dev,
> > +                     struct cpuidle_driver *drv, int idx)
> > +{
> > +     return CPU_PM_CPU_IDLE_ENTER(arm_cpuidle_suspend, idx);
> > +}
> > +
> > +static void psci_pd_enter_s2idle_pc(struct cpuidle_device *dev,
> > +                     struct cpuidle_driver *drv, int idx)
> > +{
> > +     psci_pd_enter_pc(dev, drv, idx);
> > +}
> > +
> > +static void psci_pd_convert_states(struct cpuidle_state *idle_state,
> > +                     u32 *psci_state, struct genpd_power_state *state)
> > +{
> > +     u32 *state_data = state->data;
> > +     u64 target_residency_us = state->residency_ns;
> > +     u64 exit_latency_us = state->power_on_latency_ns +
> > +                     state->power_off_latency_ns;
> > +
> > +     *psci_state = *state_data;
> > +     do_div(target_residency_us, 1000);
> > +     idle_state->target_residency = target_residency_us;
> > +     do_div(exit_latency_us, 1000);
> > +     idle_state->exit_latency = exit_latency_us;
> > +     idle_state->enter = &psci_pd_enter_pc;
> > +     idle_state->enter_s2idle = &psci_pd_enter_s2idle_pc;
> > +     idle_state->flags |= CPUIDLE_FLAG_TIMER_STOP;
>
> This is arbitrary and not necessarily true.

The arbitrary thing you refer to here, is that the
CPUIDLE_FLAG_TIMER_STOP? Or are you referring to the complete function
psci_pd_convert_states()?

>
> I think that this patch is useful to represent my reservations about the
> current approach. As a matter of fact, idle state entry will always be a
> CPUidle decision.
>
> You only need PM domain information to understand when all CPUs
> in a power domain are actually idle but that's all genPD can do
> in this respect.
>
> I think this patchset would be much simpler if both CPUidle and
> genPD governor would work on *one* set of idle states, globally
> indexed (and that would be true for PSCI suspend parameters too).
>
> To work with a unified set of idle states between CPUidle and genPD
> (tossing some ideas around):
>
> - We can implement a genPD CPUidle governor that in its select method
>   takes into account genPD information (for instance by avoiding
>   selection of idle states that require multiple cpus to be in idle
>   to be effectively active)
> - We can use genPD to enable/disable CPUidle states through runtime
>   PM information

I don't understand how to make this work.

The CPUidle governor works on per CPU basis. The genpd governor works
on per PM domain basis, which typically can be a group of CPUs (and
even other devices) via subdomains, for example.

1.
In case of Linux being in *charge* of what idle state to pick for a
group of CPUs, that decision is best done by the genpd governor as it
operates on "groups" of CPUs. This is used for PSCI OSI mode. Of
course, there are idle states also per CPU, which potentially could be
managed by the genpd governor as well, but at this point I decided to
re-use the cpuidle governor as it's already doing the job.

2. In case the decision of what idle state to enter for the group is
done by the FW, we can rely solely on the cpuidle governor and let it
select states per CPU basis. This is used for PSCI PC mode.

>
> There may be other ways. My point is that current code, with two (or
> more if the hierarchy grows) sets of idle states across two subsystems
> (CPUidle and genPD) is not very well defined and honestly very hard to
> grasp and prone to errors.

The complexity is there, I admit that.

I guess some deeper insight about genpd+its governor+runtime PM are
needed when reviewing this, of course. As an option, you may also have
a look at my slides [1] from OSPM (Pisa) in May this year, which via
flow charts try to describes things in more detail.

In our offlist meeting, we discussed that perhaps moving some of the
new PSCI code introduced in this series, into a cpuidle driver
instead, could make things more clear. For sure, I can explore that
option, but before I go there, I think we should agree on it publicly.

In principle what it means is to invent a special cpuidle driver for
PSCI, so we would need access to some of the PSCI internal functions,
for example.

One thing though, the initialization of the PSCI PM domain topology is
a separate step, managed via the new initcall, psci_dt_topology_init()
(introduced in patch 11). That part still seems to be belong to the
PSCI code, don't you think?

>
> > +
> > +     strncpy(idle_state->name, to_of_node(state->fwnode)->name,
> > +             CPUIDLE_NAME_LEN - 1);
> > +     strncpy(idle_state->desc, to_of_node(state->fwnode)->name,
> > +             CPUIDLE_NAME_LEN - 1);
> > +}
> > +
> > +static bool psci_pd_is_provider(struct device_node *np)
> > +{
> > +     struct psci_pd_provider *pd_prov, *it;
> > +
> > +     list_for_each_entry_safe(pd_prov, it, &psci_pd_providers, link) {
> > +             if (pd_prov->node == np)
> > +                     return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> >  static int psci_pd_init(struct device_node *np)
> >  {
> >       struct generic_pm_domain *pd;
> > @@ -265,4 +316,71 @@ int psci_dt_init_pm_domains(struct device_node *np)
> >       pr_err("failed to create CPU PM domains ret=%d\n", ret);
> >       return ret;
> >  }
> > +
> > +int psci_dt_pm_domains_parse_states(struct cpuidle_driver *drv,
> > +                     struct device_node *cpu_node, u32 *psci_states)
> > +{
> > +     struct genpd_power_state *pd_states;
> > +     struct of_phandle_args args;
> > +     int ret, pd_state_count, i, state_idx, psci_idx;
> > +     u32 cpu_psci_state = psci_states[drv->state_count - 2];
>
> This (-2) is very dodgy and I doubt it would work on hierarchies going
> above "cluster" level.
>
> As I say above, I think we should work towards a single array of
> idle states to be selected by a CPUidle governor using genPD
> runtime information to bias the results according to the number
> of CPUs in a genPD that entered/exit idle.
>
> To be more precise, all idles states should be "domain-idle-state"
> compatible, even the CPU ones, the distinction between what CPUidle
> and genPD manage is a bit stretched IMO in this patchset.
>
> We will have a chance to talk about this but I thought I would
> comment publically if anyone else is willing to chime in, this
> is not a PSCI problem at all, it is a CPUidle/genPD coexistence
> design problem which is much broader.

To move this forward, I think we need to move from vague ideas to
clear and distinct plans. Whatever that means. :-)

I understand you are concerned about the level of changes introduced
to the PSCI code. As I stated somewhere in earlier replies, I picked
that approach as I thought it was better to implement things in a PSCI
specific manner to start with, then we could move things around, when
we realize that it make sense.

Anyway, as a suggestion to address your concern, how about this:

1. Move some things out to a PSCI cpuidle driver. We need to decide
more exactly on what to move and find the right level for the
interfaces.
2. Don't attach the CPU to the PM domain topology in case the PSCI PC
mode is used. I think this makes it easier, at least as a first step,
to understand when runtime PM needs to be used/enabled.
3. Would it help if I volunteer to help you guys as a maintainer for
PSCI. At least for the part of the new code that becomes introduced?

[...]

Kind regards
Uffe
