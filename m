Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A296FE6041
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2019 03:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfJ0Cag (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 26 Oct 2019 22:30:36 -0400
Received: from foss.arm.com ([217.140.110.172]:53628 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbfJ0Cag (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 26 Oct 2019 22:30:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A9291FB;
        Sat, 26 Oct 2019 19:30:36 -0700 (PDT)
Received: from e107533-lin.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84FF53F6C4;
        Sat, 26 Oct 2019 19:30:28 -0700 (PDT)
Date:   Sun, 27 Oct 2019 02:30:23 +0000
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
Subject: Re: [PATCH 10/13] cpuidle: psci: Add a helper to attach a CPU to its
 PM domain
Message-ID: <20191027023023.GC18111@e107533-lin.cambridge.arm.com>
References: <20191010113937.15962-1-ulf.hansson@linaro.org>
 <20191010113937.15962-11-ulf.hansson@linaro.org>
 <20191024163117.GB22036@bogus>
 <CAPDyKFo2Fma1_JMSd39bmQ3X1PV4SmQ0AfEuKyX5KLLe83ycmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFo2Fma1_JMSd39bmQ3X1PV4SmQ0AfEuKyX5KLLe83ycmA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 24, 2019 at 06:47:43PM +0200, Ulf Hansson wrote:
> On Thu, 24 Oct 2019 at 18:31, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Thu, Oct 10, 2019 at 01:39:34PM +0200, Ulf Hansson wrote:
> > > Introduce a PSCI DT helper function, psci_dt_attach_cpu(), which takes a
> > > CPU number as an in-parameter and tries to attach the CPU's struct device
> > > to its corresponding PM domain.
> > >
> > > Let's makes use of dev_pm_domain_attach_by_name(), as it allows us to
> > > specify "psci" as the "name" of the PM domain to attach to. Additionally,
> > > let's also prepare the attached device to be power managed via runtime PM.
> > >
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >  drivers/cpuidle/cpuidle-psci-domain.c | 21 +++++++++++++++++++++
> > >  drivers/cpuidle/cpuidle-psci.h        |  6 ++++++
> > >  2 files changed, 27 insertions(+)
> > >
> > > diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> > > index 3f5143ccc3e0..7429fd7626a1 100644
> > > --- a/drivers/cpuidle/cpuidle-psci-domain.c
> > > +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> > > @@ -9,9 +9,11 @@
> > >
> > >  #define pr_fmt(fmt) "CPUidle PSCI: " fmt
> > >
> > > +#include <linux/cpu.h>
> > >  #include <linux/device.h>
> > >  #include <linux/kernel.h>
> > >  #include <linux/pm_domain.h>
> > > +#include <linux/pm_runtime.h>
> > >  #include <linux/psci.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/string.h>
> > > @@ -279,3 +281,22 @@ static int __init psci_idle_init_domains(void)
> > >       return ret;
> > >  }
> > >  subsys_initcall(psci_idle_init_domains);
> > > +
> > > +struct device *psci_dt_attach_cpu(int cpu)
> > > +{
> > > +     struct device *dev;
> > > +
> > > +     /* Currently limit the hierarchical topology to be used in OSI mode. */
> > > +     if (!psci_has_osi_support())
> > > +             return NULL;
> > > +
> > > +     dev = dev_pm_domain_attach_by_name(get_cpu_device(cpu), "psci");
> >
> > This clarifies the need for the fixed name. But why not just go by index 0
> > as the consumer of these psci power-domains will have only one power domain
> > entry. Why do we need this name compulsory ?
>
> The idea is to be future proof. If I recall correctly, the CPU node on
> some QCOM SoCs may also have "CPR" PM domain specified, thus
> "multiple" power-domains could be specified.
>

I am sure we don't want to mx-n-match any power domain provider with
psci. And also I expect in these above mentioned cases, there won't be any
psci power domains.

> In any case, using "psci" doesn't really hurt, right?
>

Doesn't but I don't see need for one as only one should exist, as mentioned
above we don't want mix-n-match with psci ever.

> > Further, it's specified as
> > optional in the generic binding, do we make it "required" for this psci
> > idle states binding anywhere that I missed ?
>
> Good point! Unless you tell me differently, I will update the DT doc
> to clarify this is "required".
>

No but why is my question ? We don't have to. If firmware/DT wants to
specify the name, sure. But it must remain optional IMO.

--
Regards,
Sudeep
