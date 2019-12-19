Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 728101268AC
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 19:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfLSSGe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 13:06:34 -0500
Received: from foss.arm.com ([217.140.110.172]:41654 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbfLSSGe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Dec 2019 13:06:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE13E1FB;
        Thu, 19 Dec 2019 10:06:32 -0800 (PST)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 199983F67D;
        Thu, 19 Dec 2019 10:06:30 -0800 (PST)
Date:   Thu, 19 Dec 2019 18:06:29 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
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
Subject: Re: [PATCH v4 13/14] cpuidle: psci: Add support for PM domains by
 using genpd
Message-ID: <20191219180629.GC21846@bogus>
References: <20191211154343.29765-1-ulf.hansson@linaro.org>
 <20191211154343.29765-14-ulf.hansson@linaro.org>
 <20191219143427.GF20746@bogus>
 <CAPDyKFpPmtXkP6LSNWBbfyTJowjQXF39_4LN5YEcDtW1BzVw-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpPmtXkP6LSNWBbfyTJowjQXF39_4LN5YEcDtW1BzVw-g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 19, 2019 at 04:48:39PM +0100, Ulf Hansson wrote:
> On Thu, 19 Dec 2019 at 15:34, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Wed, Dec 11, 2019 at 04:43:42PM +0100, Ulf Hansson wrote:
> > > When the hierarchical CPU topology layout is used in DT and the PSCI OSI
> > > mode is supported by the PSCI FW, let's initialize a corresponding PM
> > > domain topology by using genpd. This enables a CPU and a group of CPUs,
> > > when attached to the topology, to be power-managed accordingly.
> > >
> > > To trigger the attempt to initialize the genpd data structures let's use a
> > > subsys_initcall, which should be early enough to allow CPUs, but also other
> > > devices to be attached.
> > >
> > > The initialization consists of parsing the PSCI OF node for the topology
> > > and the "domain idle states" DT bindings. In case the idle states are
> > > compatible with "domain-idle-state", the initialized genpd becomes
> > > responsible of selecting an idle state for the PM domain, via assigning it
> > > a genpd governor.
> > >
> > > Note that, a successful initialization of the genpd data structures, is
> > > followed by a call to psci_set_osi_mode(), as to try to enable the OSI mode
> > > in the PSCI FW. In case this fails, we fall back into a degraded mode
> > > rather than bailing out and returning an error code.
> > >
> > > Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> > > Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >
> > > Changes in v4:
> > >       - None.
> > >
> > > ---
> > >  drivers/cpuidle/cpuidle-psci-domain.c | 267 ++++++++++++++++++++++++++
> > >  drivers/cpuidle/cpuidle-psci.c        |   4 +-
> > >  drivers/cpuidle/cpuidle-psci.h        |   5 +
> > >  3 files changed, 274 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> > > index 656ef3d59149..c2f94ba42222 100644
> > > --- a/drivers/cpuidle/cpuidle-psci-domain.c
> > > +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> > > @@ -7,14 +7,281 @@
> > >   *
> > >   */
> > >
> > > +#define pr_fmt(fmt) "CPUidle PSCI: " fmt
> > > +
> > >  #include <linux/cpu.h>
> > >  #include <linux/device.h>
> > >  #include <linux/kernel.h>
> > >  #include <linux/pm_domain.h>
> > >  #include <linux/pm_runtime.h>
> > > +#include <linux/psci.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/string.h>
> > >
> > >  #include "cpuidle-psci.h"
> > >
> > > +struct psci_pd_provider {
> > > +     struct list_head link;
> > > +     struct device_node *node;
> > > +};
> > > +
> > > +static LIST_HEAD(psci_pd_providers);
> > > +static bool osi_mode_enabled;
> > > +
> > > +static int psci_pd_power_off(struct generic_pm_domain *pd)
> > > +{
> > > +     struct genpd_power_state *state = &pd->states[pd->state_idx];
> > > +     u32 *pd_state;
> > > +
> > > +     /* If we have failed to enable OSI mode, then abort power off. */
> > > +     if (!osi_mode_enabled)
> > > +             return -EBUSY;
> > > +
> >
> > Why is above check needed ? Shouldn't we have disable/remove pd of
> > OSI is not enabled ?
>
> Well, failing to enable OSI should in practice not happen, while it
> theoretically it could.
>

I won't assume that. Since it's new and not tested yet, I prefer to assume
it can fail.

> My approach to this has been to fall back to use a "degraded mode",
> which seems quite common for these kind of situations. The degraded
> mode means, we are preventing domain states from being used.
>

But why can't we just fail registering or remove if already added.
They are useless for "degraded mode" anyways. And it will ensure that
data->dev is NULL. Sorry now I see why you said it can be NULL but I
would rather not leave those unused genpd in place in case of error.

> More importantly, it also keeps the code registering the PM domains, a
> bit simpler.
>

I feel it is simpler other way around especially if I am testing and
seeing failures but I see genpd succeeding. That's confusing.

--
Regards,
Sudeep
