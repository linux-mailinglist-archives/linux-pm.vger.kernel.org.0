Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0200B38ED5
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 17:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbfFGPVU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jun 2019 11:21:20 -0400
Received: from foss.arm.com ([217.140.110.172]:42562 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728665AbfFGPVU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Jun 2019 11:21:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99207337;
        Fri,  7 Jun 2019 08:21:19 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9EEB3F718;
        Fri,  7 Jun 2019 08:21:16 -0700 (PDT)
Date:   Fri, 7 Jun 2019 16:21:14 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/18] drivers: firmware: psci: Prepare to support PM
 domains
Message-ID: <20190607152114.GG15577@e107155-lin>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
 <20190513192300.653-9-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513192300.653-9-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 13, 2019 at 09:22:50PM +0200, Ulf Hansson wrote:
> Subsequent changes implements support for PM domains to PSCI. Those changes
> are mainly implemented in a new separate c-file, hence a couple of the
> internal PSCI functions needs to be shared to be accessible. Let's do that
> via adding a new PSCI header file.
>
> Moreover, to implement support for PM domains, switching the PSCI FW into
> the OS initiated mode is sometimes needed. Therefore, let's share a new
> function that implement this.
>

This looks fine.

--
Regards,
Sudeep

> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes:
> 	- Convert psci_set_osi_mode() to return an int.
> 	- Don't share psci_get_domain_state() as that's no longer needed.
> 	- Update changelog.
>
> ---
>  drivers/firmware/psci/psci.c | 17 ++++++++++++++---
>  drivers/firmware/psci/psci.h | 16 ++++++++++++++++
>  2 files changed, 30 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/firmware/psci/psci.h
>
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index 4aec513136e4..0e91d864e346 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -34,6 +34,8 @@
>  #include <asm/smp_plat.h>
>  #include <asm/suspend.h>
>
> +#include "psci.h"
> +
>  /*
>   * While a 64-bit OS can make calls with SMC32 calling conventions, for some
>   * calls it is necessary to use SMC64 to pass or return 64-bit values.
> @@ -96,7 +98,7 @@ static inline bool psci_has_ext_power_state(void)
>  				PSCI_1_0_FEATURES_CPU_SUSPEND_PF_MASK;
>  }
>
> -static inline bool psci_has_osi_support(void)
> +bool psci_has_osi_support(void)
>  {
>  	return psci_cpu_suspend_feature & PSCI_1_0_OS_INITIATED;
>  }
> @@ -161,6 +163,15 @@ static u32 psci_get_version(void)
>  	return invoke_psci_fn(PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0);
>  }
>
> +int psci_set_osi_mode(void)
> +{
> +	int err;
> +
> +	err = invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE,
> +			     PSCI_1_0_SUSPEND_MODE_OSI, 0, 0);
> +	return psci_to_linux_errno(err);
> +}
> +
>  static int psci_cpu_suspend(u32 state, unsigned long entry_point)
>  {
>  	int err;
> @@ -292,12 +303,12 @@ static inline u32 psci_get_domain_state(void)
>  	return __this_cpu_read(domain_state);
>  }
>
> -static inline void psci_set_domain_state(u32 state)
> +void psci_set_domain_state(u32 state)
>  {
>  	__this_cpu_write(domain_state, state);
>  }
>
> -static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
> +int psci_dt_parse_state_node(struct device_node *np, u32 *state)
>  {
>  	int err = of_property_read_u32(np, "arm,psci-suspend-param", state);
>
> diff --git a/drivers/firmware/psci/psci.h b/drivers/firmware/psci/psci.h
> new file mode 100644
> index 000000000000..f2277c3ad405
> --- /dev/null
> +++ b/drivers/firmware/psci/psci.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __PSCI_H
> +#define __PSCI_H
> +
> +struct device_node;
> +
> +int psci_set_osi_mode(void);
> +bool psci_has_osi_support(void);
> +
> +#ifdef CONFIG_CPU_IDLE
> +void psci_set_domain_state(u32 state);
> +int psci_dt_parse_state_node(struct device_node *np, u32 *state);
> +#endif
> +
> +#endif /* __PSCI_H */
> --
> 2.17.1
>

