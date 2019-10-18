Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48E5ADC203
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 12:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442378AbfJRKDf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 06:03:35 -0400
Received: from [217.140.110.172] ([217.140.110.172]:60546 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2389081AbfJRKDf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 18 Oct 2019 06:03:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E944494;
        Fri, 18 Oct 2019 03:03:10 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE8F43F6C4;
        Fri, 18 Oct 2019 03:03:08 -0700 (PDT)
Date:   Fri, 18 Oct 2019 11:03:04 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
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
Subject: Re: [PATCH 01/13] cpuidle: psci: Fix potential access to unmapped
 memory
Message-ID: <20191018100304.GA28830@e121166-lin.cambridge.arm.com>
References: <20191010113937.15962-1-ulf.hansson@linaro.org>
 <20191010113937.15962-2-ulf.hansson@linaro.org>
 <20191018093839.GB25918@e121166-lin.cambridge.arm.com>
 <CAPDyKFqcHY6+Eq9d6xTPYMDrUOtGs+64YuwZ1EbFtqQZe0+xEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqcHY6+Eq9d6xTPYMDrUOtGs+64YuwZ1EbFtqQZe0+xEw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 18, 2019 at 11:51:11AM +0200, Ulf Hansson wrote:
> On Fri, 18 Oct 2019 at 11:38, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> >
> > On Thu, Oct 10, 2019 at 01:39:25PM +0200, Ulf Hansson wrote:
> > > When the WFI state have been selected, the in-parameter idx to
> > > psci_enter_idle_state() is zero. In this case, we must not index the state
> > > array as "state[idx - 1]", as it means accessing data outside the array.
> > > Fix the bug by pre-checking if idx is zero.
> > >
> > > Fixes: 9ffeb6d08c3a ("PSCI: cpuidle: Refactor CPU suspend power_state parameter handling")
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >  drivers/cpuidle/cpuidle-psci.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> > > index f3c1a2396f98..2e91c8d6c211 100644
> > > --- a/drivers/cpuidle/cpuidle-psci.c
> > > +++ b/drivers/cpuidle/cpuidle-psci.c
> > > @@ -27,10 +27,10 @@ static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
> > >  static int psci_enter_idle_state(struct cpuidle_device *dev,
> > >                               struct cpuidle_driver *drv, int idx)
> > >  {
> > > -     u32 *state = __this_cpu_read(psci_power_state);
> > > +     u32 *states = __this_cpu_read(psci_power_state);
> > > +     u32 state = idx ? states[idx - 1] : 0;
> > >
> > > -     return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter,
> > > -                                        idx, state[idx - 1]);
> > > +     return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter, idx, state);
> >
> > Technically we don't dereference that array entry but I agree this
> > is ugly and potentially broken.
> 
> No sure understand the non-deference part.
> 
> If the governor selects WFI, the idx will be 0 - and thus we end up
> using state[-1], doesn't that dereference an invalid address, no?

No because CPU_PM_CPU_IDLE_ENTER_PARAM is a macro, the code it
preprocesses to won't dereference state[idx - 1] if idx == 0.

I agree it is *very* ugly but technically code is not broken.

> > My preference is aligning it with ACPI code and allocate one more
> > entry in the psci_power_state array (useless for wfi, agreed but
> > at least we remove this (-1) handling from the code).
> 
> I can do that, but sounds like a slightly bigger change. Are you fine
> if I do that on top, so we can get this sent as fix for v5.4-rc[n]?

Technically we are not fixing anything; it is not such a big
change, we need to allocate one entry more and update the array
indexing.

Lorenzo
