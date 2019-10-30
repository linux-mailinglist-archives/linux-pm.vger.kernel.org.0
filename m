Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77BD3E9436
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 01:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfJ3Aut (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 20:50:49 -0400
Received: from foss.arm.com ([217.140.110.172]:58784 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfJ3Aut (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 29 Oct 2019 20:50:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B640C1FB;
        Tue, 29 Oct 2019 17:50:48 -0700 (PDT)
Received: from e107533-lin.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B7A23F71E;
        Tue, 29 Oct 2019 17:50:40 -0700 (PDT)
Date:   Wed, 30 Oct 2019 08:50:32 +0800
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
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
Message-ID: <20191030005032.GA9448@e107533-lin.cambridge.arm.com>
References: <20191010113937.15962-1-ulf.hansson@linaro.org>
 <20191010113937.15962-11-ulf.hansson@linaro.org>
 <20191024163117.GB22036@bogus>
 <CAPDyKFo2Fma1_JMSd39bmQ3X1PV4SmQ0AfEuKyX5KLLe83ycmA@mail.gmail.com>
 <20191027023023.GC18111@e107533-lin.cambridge.arm.com>
 <CAPDyKFr1LJ_HP1kcfMh7LE5j7nUT9KzH4vhdCSEE9wg6RfYErQ@mail.gmail.com>
 <20191028074905.GA27884@e107533-lin.cambridge.arm.com>
 <CAPDyKFotv0Fu5jXqhv7tCqYb44HaAnOjWnQS0B3nS04sUmTrUg@mail.gmail.com>
 <20191029053414.GA4481@e107533-lin.cambridge.arm.com>
 <20191029094444.GA12635@centauri>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029094444.GA12635@centauri>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 29, 2019 at 10:44:44AM +0100, Niklas Cassel wrote:
> On Tue, Oct 29, 2019 at 01:34:24PM +0800, Sudeep Holla wrote:
> > On Mon, Oct 28, 2019 at 10:45:22AM +0100, Ulf Hansson wrote:
> > > + Niklas
> > >
> > > On Mon, 28 Oct 2019 at 08:49, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > >
> > > > On Mon, Oct 28, 2019 at 08:35:55AM +0100, Ulf Hansson wrote:
> > > > > On Sun, 27 Oct 2019 at 03:30, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > > > >
> > > > > > On Thu, Oct 24, 2019 at 06:47:43PM +0200, Ulf Hansson wrote:
> > > > > > > On Thu, 24 Oct 2019 at 18:31, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Oct 10, 2019 at 01:39:34PM +0200, Ulf Hansson wrote:
> > > > > > > > > Introduce a PSCI DT helper function, psci_dt_attach_cpu(), which takes a
> > > > > > > > > CPU number as an in-parameter and tries to attach the CPU's struct device
> > > > > > > > > to its corresponding PM domain.
> > > > > > > > >
> > > > > > > > > Let's makes use of dev_pm_domain_attach_by_name(), as it allows us to
> > > > > > > > > specify "psci" as the "name" of the PM domain to attach to. Additionally,
> > > > > > > > > let's also prepare the attached device to be power managed via runtime PM.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > > > > > ---
> > > > > > > > >  drivers/cpuidle/cpuidle-psci-domain.c | 21 +++++++++++++++++++++
> > > > > > > > >  drivers/cpuidle/cpuidle-psci.h        |  6 ++++++
> > > > > > > > >  2 files changed, 27 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> > > > > > > > > index 3f5143ccc3e0..7429fd7626a1 100644
> > > > > > > > > --- a/drivers/cpuidle/cpuidle-psci-domain.c
> > > > > > > > > +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> > > > > > > > > @@ -9,9 +9,11 @@
> > > > > > > > >
> > > > > > > > >  #define pr_fmt(fmt) "CPUidle PSCI: " fmt
> > > > > > > > >
> > > > > > > > > +#include <linux/cpu.h>
> > > > > > > > >  #include <linux/device.h>
> > > > > > > > >  #include <linux/kernel.h>
> > > > > > > > >  #include <linux/pm_domain.h>
> > > > > > > > > +#include <linux/pm_runtime.h>
> > > > > > > > >  #include <linux/psci.h>
> > > > > > > > >  #include <linux/slab.h>
> > > > > > > > >  #include <linux/string.h>
> > > > > > > > > @@ -279,3 +281,22 @@ static int __init psci_idle_init_domains(void)
> > > > > > > > >       return ret;
> > > > > > > > >  }
> > > > > > > > >  subsys_initcall(psci_idle_init_domains);
> > > > > > > > > +
> > > > > > > > > +struct device *psci_dt_attach_cpu(int cpu)
> > > > > > > > > +{
> > > > > > > > > +     struct device *dev;
> > > > > > > > > +
> > > > > > > > > +     /* Currently limit the hierarchical topology to be used in OSI mode. */
> > > > > > > > > +     if (!psci_has_osi_support())
> > > > > > > > > +             return NULL;
> > > > > > > > > +
> > > > > > > > > +     dev = dev_pm_domain_attach_by_name(get_cpu_device(cpu), "psci");
> > > > > > > >
> > > > > > > > This clarifies the need for the fixed name. But why not just go by index 0
> > > > > > > > as the consumer of these psci power-domains will have only one power domain
> > > > > > > > entry. Why do we need this name compulsory ?
> > > > > > >
> > > > > > > The idea is to be future proof. If I recall correctly, the CPU node on
> > > > > > > some QCOM SoCs may also have "CPR" PM domain specified, thus
> > > > > > > "multiple" power-domains could be specified.
> > > > > > >
> > > > > >
> > > > > > I am sure we don't want to mx-n-match any power domain provider with
> > > > > > psci. And also I expect in these above mentioned cases, there won't be any
> > > > > > psci power domains.
> > > > > >
> > > > > > > In any case, using "psci" doesn't really hurt, right?
> > > > > > >
> > > > > >
> > > > > > Doesn't but I don't see need for one as only one should exist, as mentioned
> > > > > > above we don't want mix-n-match with psci ever.
> > > > >
> > > > > Not sure I get your point, sorry.
> > > > >
> > > > > The CPU could very well be attached to more than one power-domain. Of
> > > > > course not multiple "PSCI power-domains". One could be an PSCI power
> > > > > domain and another one could be the QCOM CPR (Core power reduction)
> > > > > power domain.
> > > > >
> > > >
> > > > And who controls QCOM CPR ? If it's OSPM, this model is broken.
> > > > I mean OSPM can vote, but the control *has* to be in PSCI firmware to
> > > > change any CPU power state.
> > > >
> > > > If it's firmware controlled, then there's no need to explicitly specify
> > > > both to OSPM.
> > >
> > > This is about OPP and CPUFreq, so it has nothing to do with PSCI.
> > >
> > > >
> > > > > Have a look at these binding, there are already upstream, perhaps that
> > > > > clarifies this?
> > > > > Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
> > > > >
> > > >
> > > > OK, I will have a look.
> > >
> > > Great.
> > >
> > > I have looped in Niklas Casell, he should be able to answer any more
> > > detailed questions in regards to QCOM CPR, if that is needed.
> > >
> >
> > So had a look at the DT bindings and standalone it looks fine.
> > But when it's mixed like the way you describe: yikes!
> >
> > Why does a power(oh wait it's actually performance domain!) is combined
> > with a device whose actual power is controlled by only by PSCI/firmware
> > is associated along with another power(again actally performance)
> > domain.
> >
> > This whole representation of performance domain as power domain in the
> > bindings is a *mess*. If Linux kernel chose to implement it as part
> > of genpd, that's fine. But we should have had a separate binding for
> > that.
> >
> > > In any case, we are discussing whether we should require a
> > > power-domain-names set to "psci" for the CPU node - and I don't see
> > > how that could hurt. Right?
> > >
> >
> > Honestly I don't like this, but we don't have any choice I think.
> > So yes, but you need to update the binding. Hope new platform move
> > all these performance domain control part into firmware and have single
> > control from kernel unlike the present generation which OPP through
> > clock or cpufreq and the voltage/performance comtrol via genpd.
>
> FWIW, in newer generation Qualcomm SoCs like SDM845,
> the voltage/performance control is done in firmware,
> by the OSM (drivers/cpufreq/qcom-cpufreq-hw.c).
>

Indeed, I was implicitly referring to this platform but just wanted to be
assured that we are not going back.

--
Regards,
Sudeep
