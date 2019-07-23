Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B665F71A1E
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 16:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731466AbfGWOTK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 10:19:10 -0400
Received: from foss.arm.com ([217.140.110.172]:55576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729961AbfGWOTK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Jul 2019 10:19:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B26328;
        Tue, 23 Jul 2019 07:19:09 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 252A33F71F;
        Tue, 23 Jul 2019 07:19:08 -0700 (PDT)
Date:   Tue, 23 Jul 2019 15:19:05 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>, Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        LAKML <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/6] ARM: psci: cpuidle: PSCI CPUidle rework
Message-ID: <20190723141905.GB22025@e121166-lin.cambridge.arm.com>
References: <20190722153745.32446-1-lorenzo.pieralisi@arm.com>
 <CAPDyKFqAMhx_8T5FF7MujYc7HuNVAfCYx4j1UEfesuCc-TE-rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqAMhx_8T5FF7MujYc7HuNVAfCYx4j1UEfesuCc-TE-rw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 23, 2019 at 01:49:15PM +0200, Ulf Hansson wrote:
> On Mon, 22 Jul 2019 at 17:37, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> >
> > Current PSCI CPUidle driver is built on top of the generic ARM
> > CPUidle infrastructure that relies on the architectural back-end
> > idle operations to initialize and enter idle states.
> >
> > On ARM64 systems, PSCI is the only interface the kernel ever uses
> > to enter idle states, so, having to rely on a generic ARM CPUidle
> > driver when there is and there will always be only one method
> > for entering idle states proved to be overkill, more so given
> > that on ARM 32-bit systems (that can also enable the generic
> > ARM CPUidle driver) only one additional idle back-end was
> > ever added:
> >
> > drivers/soc/qcom/spm.c
> >
> > and it can be easily converted to a full-fledged CPUidle driver
> > without requiring the generic ARM CPUidle framework.
> >
> > Furthermore, the generic ARM CPUidle infrastructure forces the
> > PSCI firmware layer to keep CPUidle specific information in it,
> > which does not really fit its purpose that should be kernel
> > control/data structure agnostic.
> >
> > Lastly, the interface between the generic ARM CPUidle driver and
> > the arch back-end requires an idle state index to be passed to
> > suspend operations, with idle states back-end internals (such
> > as idle state parameters) hidden in architectural back-ends and
> > not available to the generic ARM CPUidle driver.
> >
> > To improve the above mentioned shortcomings, implement a stand
> > alone PSCI CPUidle driver; this improves the current kernel
> > code from several perspective:
> >
> > - Move CPUidle internal knowledge into CPUidle driver out of
> >   the PSCI firmware interface
> > - Give the PSCI CPUidle driver control over power state parameters,
> >   in particular in preparation for PSCI OSI support
> > - Remove generic CPUidle operations infrastructure from the kernel
> >
> > This patchset does not go as far as removing the generic ARM CPUidle
> > infrastructure in order to collect feedback on the new approach
> > before completing the removal from the kernel, the generic and PSCI
> > CPUidle driver are left to co-exist.
> 
> I like the approach and I think this series definitely moves things in
> the right direction.
> 
> Of course, some additional cleanups/re-works on top are needed to show
> its full benefit, but step by step we reach that point.

I pushed code out as we agreed.

git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git

branch: cpuidle/psci-driver

I will version the code as I update the patches, I will leave
them on the list for this week before sending a v2.

> > Tested on Juno platform with both DT and ACPI boot firmwares.
> >
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >
> > Lorenzo Pieralisi (6):
> >   ARM: cpuidle: Remove useless header include
> >   ARM: cpuidle: Remove overzealous error logging
> >   drivers: firmware: psci: Decouple checker from generic ARM CPUidle
> >   ARM: psci: cpuidle: Introduce PSCI CPUidle driver
> >   ARM: psci: cpuidle: Enable PSCI CPUidle driver
> >   PSCI: cpuidle: Refactor CPU suspend power_state parameter handling
> >
> >  MAINTAINERS                          |   8 +
> >  arch/arm/configs/imx_v6_v7_defconfig |   1 +
> >  arch/arm64/configs/defconfig         |   1 +
> >  arch/arm64/kernel/cpuidle.c          |  50 +++++-
> >  arch/arm64/kernel/psci.c             |   4 -
> >  drivers/cpuidle/Kconfig.arm          |   7 +
> >  drivers/cpuidle/Makefile             |   1 +
> >  drivers/cpuidle/cpuidle-arm.c        |  13 +-
> >  drivers/cpuidle/cpuidle-psci.c       | 235 +++++++++++++++++++++++++++
> >  drivers/firmware/psci/psci.c         | 167 +------------------
> >  drivers/firmware/psci/psci_checker.c |  16 +-
> >  include/linux/cpuidle.h              |  17 +-
> >  include/linux/psci.h                 |   4 +-
> >  13 files changed, 338 insertions(+), 186 deletions(-)
> >  create mode 100644 drivers/cpuidle/cpuidle-psci.c
> >
> > --
> > 2.21.0
> >
> 
> For the series, besides the minor comments I had on patch 4, feel free to add:
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks !
Lorenzo
