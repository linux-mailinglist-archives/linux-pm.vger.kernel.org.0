Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E350AE37EB
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2019 18:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393927AbfJXQbh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Oct 2019 12:31:37 -0400
Received: from foss.arm.com ([217.140.110.172]:55962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393925AbfJXQbh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 24 Oct 2019 12:31:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1545C32B;
        Thu, 24 Oct 2019 09:31:21 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B0643F71F;
        Thu, 24 Oct 2019 09:31:19 -0700 (PDT)
Date:   Thu, 24 Oct 2019 17:31:17 +0100
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
        Sudeep Holla <sudeep.holla@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 10/13] cpuidle: psci: Add a helper to attach a CPU to its
 PM domain
Message-ID: <20191024163117.GB22036@bogus>
References: <20191010113937.15962-1-ulf.hansson@linaro.org>
 <20191010113937.15962-11-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010113937.15962-11-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 10, 2019 at 01:39:34PM +0200, Ulf Hansson wrote:
> Introduce a PSCI DT helper function, psci_dt_attach_cpu(), which takes a
> CPU number as an in-parameter and tries to attach the CPU's struct device
> to its corresponding PM domain.
> 
> Let's makes use of dev_pm_domain_attach_by_name(), as it allows us to
> specify "psci" as the "name" of the PM domain to attach to. Additionally,
> let's also prepare the attached device to be power managed via runtime PM.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/cpuidle/cpuidle-psci-domain.c | 21 +++++++++++++++++++++
>  drivers/cpuidle/cpuidle-psci.h        |  6 ++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> index 3f5143ccc3e0..7429fd7626a1 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -9,9 +9,11 @@
>  
>  #define pr_fmt(fmt) "CPUidle PSCI: " fmt
>  
> +#include <linux/cpu.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/psci.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> @@ -279,3 +281,22 @@ static int __init psci_idle_init_domains(void)
>  	return ret;
>  }
>  subsys_initcall(psci_idle_init_domains);
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

This clarifies the need for the fixed name. But why not just go by index 0
as the consumer of these psci power-domains will have only one power domain
entry. Why do we need this name compulsory ? Further, it's specified as
optional in the generic binding, do we make it "required" for this psci
idle states binding anywhere that I missed ?

--
Regards,
Sudeep
