Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98B601264DB
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 15:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfLSOdp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 09:33:45 -0500
Received: from foss.arm.com ([217.140.110.172]:39460 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbfLSOdp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Dec 2019 09:33:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90F9031B;
        Thu, 19 Dec 2019 06:33:44 -0800 (PST)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 982CF3F6CF;
        Thu, 19 Dec 2019 06:33:42 -0800 (PST)
Date:   Thu, 19 Dec 2019 14:33:40 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 12/14] cpuidle: psci: Support CPU hotplug for the
 hierarchical model
Message-ID: <20191219143340.GE20746@bogus>
References: <20191211154343.29765-1-ulf.hansson@linaro.org>
 <20191211154343.29765-13-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211154343.29765-13-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 11, 2019 at 04:43:41PM +0100, Ulf Hansson wrote:
> When the hierarchical CPU topology is used and when a CPU is put offline,
> that CPU prevents its PM domain from being powered off, which is because
> genpd observes the corresponding attached device as being active from a
> runtime PM point of view. Furthermore, any potential master PM domains are
> also prevented from being powered off.
>
> To address this limitation, let's add add a new CPU hotplug state
> (CPUHP_AP_CPU_PM_STARTING) and register up/down callbacks for it, which
> allows us to deal with runtime PM accordingly.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v4:
> 	- Folded in the patch to be part of the series.
> 	- Rebased on top of earlier changes.
>
> ---
>  drivers/cpuidle/cpuidle-psci.c | 45 +++++++++++++++++++++++++++++++++-
>  include/linux/cpuhotplug.h     |  1 +
>  2 files changed, 45 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index 6e7804e697ed..34a89d99bb0f 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -8,6 +8,7 @@
>
>  #define pr_fmt(fmt) "CPUidle PSCI: " fmt
>
> +#include <linux/cpuhotplug.h>
>  #include <linux/cpuidle.h>
>  #include <linux/cpumask.h>
>  #include <linux/cpu_pm.h>
> @@ -31,6 +32,7 @@ struct psci_cpuidle_data {
>
>  static DEFINE_PER_CPU_READ_MOSTLY(struct psci_cpuidle_data, psci_cpuidle_data);
>  static DEFINE_PER_CPU(u32, domain_state);
> +static bool psci_cpuidle_use_cpuhp;
>

[...]

> +
> +static void psci_idle_init_cpuhp(void)
> +{

Can this be made __init along with the boolean psci_cpuidle_use_cpuhp ?

With that,
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
