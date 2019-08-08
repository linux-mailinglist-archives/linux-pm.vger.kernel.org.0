Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5FA86697
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 18:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732698AbfHHQEX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 12:04:23 -0400
Received: from foss.arm.com ([217.140.110.172]:35484 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732845AbfHHQEX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Aug 2019 12:04:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6ACEB1684;
        Thu,  8 Aug 2019 09:04:22 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 169B13F706;
        Thu,  8 Aug 2019 09:04:20 -0700 (PDT)
Date:   Thu, 8 Aug 2019 17:04:14 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        LAKML <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 6/6] PSCI: cpuidle: Refactor CPU suspend power_state
 parameter handling
Message-ID: <20190808160414.GA19233@e107155-lin>
References: <20190722153745.32446-1-lorenzo.pieralisi@arm.com>
 <20190722153745.32446-7-lorenzo.pieralisi@arm.com>
 <20190808125516.GA2246@e107155-lin>
 <CAPDyKFqHHwq=3XhSH_=uu5QoFkP3VYJ+2h7ENG5DNs-YzM6bNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqHHwq=3XhSH_=uu5QoFkP3VYJ+2h7ENG5DNs-YzM6bNQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 08, 2019 at 05:29:24PM +0200, Ulf Hansson wrote:
> On Thu, 8 Aug 2019 at 14:55, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Mon, Jul 22, 2019 at 04:37:45PM +0100, Lorenzo Pieralisi wrote:
> > > Current PSCI code handles idle state entry through the
> > > psci_cpu_suspend_enter() API, that takes an idle state index as a
> > > parameter and convert the index into a previously initialized
> > > power_state parameter before calling the PSCI.CPU_SUSPEND() with it.
> > >
> > > This is unwieldly, since it forces the PSCI firmware layer to keep track
> > > of power_state parameter for every idle state so that the
> > > index->power_state conversion can be made in the PSCI firmware layer
> > > instead of the CPUidle driver implementations.
> > >
> > > Move the power_state handling out of drivers/firmware/psci
> > > into the respective ACPI/DT PSCI CPUidle backends and convert
> > > the psci_cpu_suspend_enter() API to get the power_state
> > > parameter as input, which makes it closer to its firmware
> > > interface PSCI.CPU_SUSPEND() API.
> > >
> > > A notable side effect is that the PSCI ACPI/DT CPUidle backends
> > > now can directly handle (and if needed update) power_state
> > > parameters before handing them over to the PSCI firmware
> > > interface to trigger PSCI.CPU_SUSPEND() calls.
> > >
> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> >
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> >
> > > +static __init int psci_cpu_init_idle(unsigned int cpu)
> > > +{
> > > +     struct device_node *cpu_node;
> > > +     int ret;
> > > +
> > > +     /*
> > > +      * If the PSCI cpu_suspend function hook has not been initialized
> > > +      * idle states must not be enabled, so bail out
> > > +      */
> > > +     if (!psci_ops.cpu_suspend)
> > > +             return -EOPNOTSUPP;
> > > +
> > > +     cpu_node = of_get_cpu_node(cpu, NULL);
> >
> > [nit] You could use of_cpu_device_node_get in linux/of_device.h as
> > it may avoid parsing if used later during the boot(i.e. after
> > cpu->of_node is populated). I think there's another instance in
> > psci_idle_init_cpu
>
> Good idea!
>
> However, as $subject patch more or less just moves code from the
> current psci firmware directory into cpuidle, perhaps it's better to
> defer improvements to be made on top?
>

I am fine either way. But since cpuidle-psci.c is new file introduced
in this series, we can have it as part of the original patch. I leave it
to Lorenzo to decide :)

--
Regards,
Sudeep
