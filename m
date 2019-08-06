Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81E5A83724
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2019 18:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732834AbfHFQkY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Aug 2019 12:40:24 -0400
Received: from foss.arm.com ([217.140.110.172]:36726 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732729AbfHFQkY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Aug 2019 12:40:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9AD5344;
        Tue,  6 Aug 2019 09:40:23 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8522B3F575;
        Tue,  6 Aug 2019 09:40:22 -0700 (PDT)
Date:   Tue, 6 Aug 2019 17:40:20 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-pm@vger.kernel.org, Will Deacon <will@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        LAKML <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 5/6] ARM: psci: cpuidle: Enable PSCI CPUidle driver
Message-ID: <20190806164020.GD15498@e121166-lin.cambridge.arm.com>
References: <20190722153745.32446-1-lorenzo.pieralisi@arm.com>
 <20190722153745.32446-6-lorenzo.pieralisi@arm.com>
 <20190806161624.GE16546@e107155-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806161624.GE16546@e107155-lin>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 06, 2019 at 05:16:24PM +0100, Sudeep Holla wrote:
> On Mon, Jul 22, 2019 at 04:37:44PM +0100, Lorenzo Pieralisi wrote:
> > Allow selection of the PSCI CPUidle in the kernel by adding
> > the required Kconfig options.
> > 
> > Remove PSCI callbacks from ARM/ARM64 generic CPU ops
> > to prevent the PSCI idle driver from clashing with the generic
> > ARM CPUidle driver initialization, that relies on CPU ops
> > to initialize and enter idle states.
> > 
> > Update the affected defconfig files to guarantee seamingless
> > transition from the generic ARM CPUidle to the PSCI CPUidle
> > driver on arch/platforms using it.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > ---
> >  arch/arm/configs/imx_v6_v7_defconfig | 1 +
> >  arch/arm64/configs/defconfig         | 1 +
> 
> Better to keep above you as separate patch, though it may cause
> minor issues from bisectibility. It may be needed anyway for merging.

That's a good point, I will split these bits in a separate patch.

> >  arch/arm64/kernel/cpuidle.c          | 7 ++++---
> >  arch/arm64/kernel/psci.c             | 4 ----
> >  drivers/cpuidle/Kconfig.arm          | 8 ++++++--
> >  drivers/firmware/psci/psci.c         | 9 ---------
> >  6 files changed, 12 insertions(+), 18 deletions(-)
> > 
> > diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> > index a53b29251ed4..4174fd1b79e7 100644
> > --- a/arch/arm/configs/imx_v6_v7_defconfig
> > +++ b/arch/arm/configs/imx_v6_v7_defconfig
> > @@ -60,6 +60,7 @@ CONFIG_ARM_IMX6Q_CPUFREQ=y
> >  CONFIG_ARM_IMX_CPUFREQ_DT=y
> >  CONFIG_CPU_IDLE=y
> >  CONFIG_ARM_CPUIDLE=y
> > +CONFIG_ARM_PSCI_CPUIDLE=y
> >  CONFIG_VFP=y
> >  CONFIG_NEON=y
> >  CONFIG_PM_DEBUG=y
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index 0e58ef02880c..c0a7cfe3aebd 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -72,6 +72,7 @@ CONFIG_RANDOMIZE_BASE=y
> >  CONFIG_HIBERNATION=y
> >  CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
> >  CONFIG_ARM_CPUIDLE=y
> > +CONFIG_ARM_PSCI_CPUIDLE=y
> >  CONFIG_CPU_FREQ=y
> >  CONFIG_CPU_FREQ_STAT=y
> >  CONFIG_CPU_FREQ_GOV_POWERSAVE=m
> > diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
> > index d1048173fd8a..4bcd1bca0dfc 100644
> > --- a/arch/arm64/kernel/cpuidle.c
> > +++ b/arch/arm64/kernel/cpuidle.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/cpu_pm.h>
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> > +#include <linux/psci.h>
> >  
> >  #include <asm/cpuidle.h>
> >  #include <asm/cpu_ops.h>
> > @@ -48,15 +49,15 @@ int arm_cpuidle_suspend(int index)
> >  
> >  int acpi_processor_ffh_lpi_probe(unsigned int cpu)
> >  {
> > -	return arm_cpuidle_init(cpu);
> > +	return psci_acpi_cpu_init_idle(cpu);
> 
> This will break build as psci_acpi_cpu_init_idle is introduced in next patch.
> You can simply move it to next patch I assume.

Yes, it is a bisectability issue, I fixed it already but thanks
for spotting it anyway.

> >  }
> >  
> >  int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
> >  {
> >  	if (ARM64_LPI_IS_RETENTION_STATE(lpi->arch_flags))
> > -		return CPU_PM_CPU_IDLE_ENTER_RETENTION(arm_cpuidle_suspend,
> > +		return CPU_PM_CPU_IDLE_ENTER_RETENTION(psci_cpu_suspend_enter,
> >  						lpi->index);
> >  	else
> > -		return CPU_PM_CPU_IDLE_ENTER(arm_cpuidle_suspend, lpi->index);
> > +		return CPU_PM_CPU_IDLE_ENTER(psci_cpu_suspend_enter, lpi->index);
> >  }
> >  #endif
> > diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
> > index 85ee7d07889e..a543ab7e007c 100644
> > --- a/arch/arm64/kernel/psci.c
> > +++ b/arch/arm64/kernel/psci.c
> > @@ -105,10 +105,6 @@ static int cpu_psci_cpu_kill(unsigned int cpu)
> >  
> >  const struct cpu_operations cpu_psci_ops = {
> >  	.name		= "psci",
> > -#ifdef CONFIG_CPU_IDLE
> > -	.cpu_init_idle	= psci_cpu_init_idle,
> > -	.cpu_suspend	= psci_cpu_suspend_enter,
> > -#endif
> >  	.cpu_init	= cpu_psci_cpu_init,
> >  	.cpu_prepare	= cpu_psci_cpu_prepare,
> >  	.cpu_boot	= cpu_psci_cpu_boot,
> > diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> > index 929b57424ea4..b9c56c60ab98 100644
> > --- a/drivers/cpuidle/Kconfig.arm
> > +++ b/drivers/cpuidle/Kconfig.arm
> > @@ -14,8 +14,12 @@ config ARM_CPUIDLE
> >            provided by architecture code.
> >  
> >  config ARM_PSCI_CPUIDLE
> > -	bool
> > -
> > +	bool "PSCI CPU idle Driver"
> 
> As mentioned in previous patch, do you see issues having just above
> change in this patch and the below ones moved to the previous.

No you are right, I will make this change.

> > +	depends on ARM_PSCI_FW
> > +	select DT_IDLE_STATES
> > +	select CPU_IDLE_MULTIPLE_DRIVERS
> > +	help
> > +	  Select this to enable PSCI firmware based CPUidle driver for ARM.
> 
> You need extra blank line here.

OK.

Thanks,
Lorenzo
