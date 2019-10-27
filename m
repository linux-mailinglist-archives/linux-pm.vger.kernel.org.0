Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27CF3E6049
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2019 03:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfJ0Cea (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 26 Oct 2019 22:34:30 -0400
Received: from foss.arm.com ([217.140.110.172]:53724 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbfJ0Cea (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 26 Oct 2019 22:34:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B27421FB;
        Sat, 26 Oct 2019 19:34:29 -0700 (PDT)
Received: from e107533-lin.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9AF503F6C4;
        Sat, 26 Oct 2019 19:34:22 -0700 (PDT)
Date:   Sun, 27 Oct 2019 02:34:14 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
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
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 12/13] cpuidle: psci: Manage runtime PM in the idle path
Message-ID: <20191027023414.GE18111@e107533-lin.cambridge.arm.com>
References: <20191010113937.15962-1-ulf.hansson@linaro.org>
 <20191010113937.15962-13-ulf.hansson@linaro.org>
 <20191024163257.GC22036@bogus>
 <CAPDyKFpwrfHj-az5x5dW92VAxi887FgWW6GKhfPv_kuj14TDjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpwrfHj-az5x5dW92VAxi887FgWW6GKhfPv_kuj14TDjQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 24, 2019 at 07:00:38PM +0200, Ulf Hansson wrote:
> On Thu, 24 Oct 2019 at 18:33, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Thu, Oct 10, 2019 at 01:39:36PM +0200, Ulf Hansson wrote:
> > > In case we have succeeded to attach a CPU to its PM domain, let's deploy
> > > runtime PM support for the corresponding attached device, to allow the CPU
> > > to be powered-managed accordingly.
> > >
> > > To set the triggering point for when runtime PM reference counting should
> > > be done, let's store the index of deepest idle state for the CPU in the per
> > > CPU struct. Then use this index to compare the selected idle state index
> > > when entering idle, as to understand whether runtime PM reference counting
> > > is needed or not.
> > >
> > > Note that, from the hierarchical point view, there may be good reasons to
> > > do runtime PM reference counting even on shallower idle states, but at this
> > > point this isn't supported, mainly due to limitations set by the generic PM
> > > domain.
> > >
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >  drivers/cpuidle/cpuidle-psci.c | 21 +++++++++++++++++++--
> > >  1 file changed, 19 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> > > index 1510422c7a53..0919b40c1a85 100644
> > > --- a/drivers/cpuidle/cpuidle-psci.c
> > > +++ b/drivers/cpuidle/cpuidle-psci.c
> > > @@ -16,6 +16,7 @@
> > >  #include <linux/of.h>
> > >  #include <linux/of_device.h>
> > >  #include <linux/psci.h>
> > > +#include <linux/pm_runtime.h>
> > >  #include <linux/slab.h>
> > >
> > >  #include <asm/cpuidle.h>
> > > @@ -25,6 +26,7 @@
> > >
> > >  struct psci_cpuidle_data {
> > >       u32 *psci_states;
> > > +     u32 rpm_state_id;
> > >       struct device *dev;
> > >  };
> > >
> > > @@ -50,14 +52,28 @@ static int psci_enter_idle_state(struct cpuidle_device *dev,
> > >                               struct cpuidle_driver *drv, int idx)
> > >  {
> > >       int ret;
> > > -     u32 *states = __this_cpu_read(psci_cpuidle_data.psci_states);
> > > -     u32 state = psci_get_domain_state();
> > > +     struct psci_cpuidle_data *data = this_cpu_ptr(&psci_cpuidle_data);
> > > +     u32 *states = data->psci_states;
> > > +     struct device *pd_dev = data->dev;
> > > +     bool runtime_pm = (pd_dev && data->rpm_state_id == idx);
> > > +     u32 state;
> >
> > Wonder if we can have separate psci_enter_idle_state for OSI mode so
> > that all these runtime extra check can be reduced ? It will also make
> > sure there's no additional latency for PC mode because of OSI.
> 
> Good idea, that's the plan. See previous answer.
> 
> Perhaps if I add a patch on top, implementing your suggestion, would
> you be happy with that?

No, I prefer to amend this itself to keep it easy to be able to bisect.

--
Regards,
Sudeep
