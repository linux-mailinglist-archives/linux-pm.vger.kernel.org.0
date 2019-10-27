Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 927C0E6045
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2019 03:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfJ0Cc0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 26 Oct 2019 22:32:26 -0400
Received: from foss.arm.com ([217.140.110.172]:53672 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbfJ0Cc0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 26 Oct 2019 22:32:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4864E1FB;
        Sat, 26 Oct 2019 19:32:25 -0700 (PDT)
Received: from e107533-lin.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3417A3F6C4;
        Sat, 26 Oct 2019 19:32:17 -0700 (PDT)
Date:   Sun, 27 Oct 2019 02:32:13 +0000
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
Subject: Re: [PATCH 11/13] cpuidle: psci: Attach CPU devices to their PM
 domains
Message-ID: <20191027023213.GD18111@e107533-lin.cambridge.arm.com>
References: <20191010113937.15962-1-ulf.hansson@linaro.org>
 <20191010113937.15962-12-ulf.hansson@linaro.org>
 <20191024163515.GD22036@bogus>
 <CAPDyKFq43XrGLDOVZmOeBTLKG0BBvTji6c0Z+cT8uc6PPyp8YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFq43XrGLDOVZmOeBTLKG0BBvTji6c0Z+cT8uc6PPyp8YA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 24, 2019 at 06:55:50PM +0200, Ulf Hansson wrote:
> On Thu, 24 Oct 2019 at 18:35, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Thu, Oct 10, 2019 at 01:39:35PM +0200, Ulf Hansson wrote:
> > > In order to enable a CPU to be power managed through its PM domain, let's
> > > try to attach it by calling psci_dt_attach_cpu() during the cpuidle
> > > initialization.
> > >
> > > psci_dt_attach_cpu() returns a pointer to the attached struct device, which
> > > later should be used for runtime PM, hence we need to store it somewhere.
> > > Rather than adding yet another per CPU variable, let's create a per CPU
> > > struct to collect the relevant per CPU variables.
> > >
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >  drivers/cpuidle/cpuidle-psci.c | 23 +++++++++++++++++++----
> > >  1 file changed, 19 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> > > index a16467daf99d..1510422c7a53 100644
> > > --- a/drivers/cpuidle/cpuidle-psci.c
> > > +++ b/drivers/cpuidle/cpuidle-psci.c
> > > @@ -23,7 +23,12 @@
> > >  #include "cpuidle-psci.h"
> > >  #include "dt_idle_states.h"
> > >
> > > -static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
> > > +struct psci_cpuidle_data {
> > > +     u32 *psci_states;
> > > +     struct device *dev;
> > > +};
> > > +
> > > +static DEFINE_PER_CPU_READ_MOSTLY(struct psci_cpuidle_data, psci_cpuidle_data);
> > >  static DEFINE_PER_CPU(u32, domain_state);
> > >
> >
> > /me just thinking still: If it make sense to keep psci_states separate
> > and domain_state and only other things needed for RPM/OSI in the
> > structure. I do understand that we modify domain_state and hence
> > we can't use READ_MOSTLY then. Let's see, for now keep it as is, thought
> > I will think out aloud.
> 
> I believe we are striving towards the same goal, which likely means to
> separate the non-OSI path vs OSI path, as much as possible. Simply to
> avoid any unnecessary operation being done in the non-OSI path. Right?
>

Yes

> However, while I was trying to address that, I realized that it would
> probably introduce even more changes to the series. Therefore, it
> thought it may be better to address these kind of changes on top, as
> improvements.
>

If possible better to amend this unless it's too complicated.

--
Regards,
Sudeep
