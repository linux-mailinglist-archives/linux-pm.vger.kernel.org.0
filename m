Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74764FE3B7
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 18:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfKORNm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 12:13:42 -0500
Received: from foss.arm.com ([217.140.110.172]:34036 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727567AbfKORNl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 Nov 2019 12:13:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D726531B;
        Fri, 15 Nov 2019 09:13:40 -0800 (PST)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D05C03F6C4;
        Fri, 15 Nov 2019 09:13:38 -0800 (PST)
Date:   Fri, 15 Nov 2019 17:13:36 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Kevin Hilman <khilman@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 08/13] cpuidle: psci: Add a helper to attach a CPU to
 its PM domain
Message-ID: <20191115171336.GC27170@bogus>
References: <20191029164438.17012-1-ulf.hansson@linaro.org>
 <20191029164438.17012-9-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029164438.17012-9-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 29, 2019 at 05:44:33PM +0100, Ulf Hansson wrote:
> Introduce a PSCI DT helper function, psci_dt_attach_cpu(), which takes a
> CPU number as an in-parameter and tries to attach the CPU's struct device
> to its corresponding PM domain.
>
> Let's makes use of dev_pm_domain_attach_by_name(), as it allows us to
> specify "psci" as the "name" of the PM domain to attach to. Additionally,
> let's also prepare the attached device to be power managed via runtime PM.
>
> Note that, the implementation of the new helper function is in a new
> separate c-file, which may seems a bit too much at this point. However,
> subsequent changes that implements the remaining part of the PM domain
> support for cpuidle-psci, helps to justify this split.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v2:
> 	- Reorder patch to be the first one that starts adding the PM domain
> 	  support.
> 	- Rebased.
>
> ---
>  drivers/cpuidle/Makefile              |  4 ++-
>  drivers/cpuidle/cpuidle-psci-domain.c | 36 +++++++++++++++++++++++++++
>  drivers/cpuidle/cpuidle-psci.h        | 12 +++++++++
>  3 files changed, 51 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/cpuidle/cpuidle-psci-domain.c
>  create mode 100644 drivers/cpuidle/cpuidle-psci.h
>
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index ee70d5cc5b99..cc8c769d7fa9 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -21,7 +21,9 @@ obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
>  obj-$(CONFIG_ARM_AT91_CPUIDLE)          += cpuidle-at91.o
>  obj-$(CONFIG_ARM_EXYNOS_CPUIDLE)        += cpuidle-exynos.o
>  obj-$(CONFIG_ARM_CPUIDLE)		+= cpuidle-arm.o
> -obj-$(CONFIG_ARM_PSCI_CPUIDLE)		+= cpuidle-psci.o
> +obj-$(CONFIG_ARM_PSCI_CPUIDLE)		+= cpuidle_psci.o
> +cpuidle_psci-y				:= cpuidle-psci.o
> +cpuidle_psci-$(CONFIG_PM_GENERIC_DOMAINS_OF) += cpuidle-psci-domain.o

This was super confusing for a minute until I noticed the difference
between _ and - used here. I know such pattern is used in the kernel,
just that it's difficult to notice on first go :)

>
>  ###############################################################################
>  # MIPS drivers
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> new file mode 100644
> index 000000000000..bc7df4dc0686
> --- /dev/null
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PM domains for CPUs via genpd - managed by cpuidle-psci.
> + *
> + * Copyright (C) 2019 Linaro Ltd.
> + * Author: Ulf Hansson <ulf.hansson@linaro.org>
> + *
> + */
> +
> +#include <linux/cpu.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/psci.h>
> +
> +#include "cpuidle-psci.h"
> +
> +struct device *psci_dt_attach_cpu(int cpu)
> +{
> +	struct device *dev;
> +
> +	/* Currently limit the hierarchical topology to be used in OSI mode. */
> +	if (!psci_has_osi_support())
> +		return NULL;
> +
> +	dev = dev_pm_domain_attach_by_name(get_cpu_device(cpu), "psci");
> +	if (IS_ERR_OR_NULL(dev))
> +		return dev;
> +
> +	pm_runtime_irq_safe(dev);
> +	if (cpu_online(cpu))
> +		pm_runtime_get_sync(dev);

I probably have to wait till I see the user of this, but until then I
assume we have some way to deal with CPU HP machinery for this.

Other than that, it looks fine. I will get back to this to ack or with
more questions as I review further.

--
Regards,
Sudeep
