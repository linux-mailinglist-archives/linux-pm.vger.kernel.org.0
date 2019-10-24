Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC425E3856
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2019 18:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407680AbfJXQk7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Oct 2019 12:40:59 -0400
Received: from foss.arm.com ([217.140.110.172]:56418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405516AbfJXQkt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 24 Oct 2019 12:40:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF60232B;
        Thu, 24 Oct 2019 09:35:19 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E738E3F71F;
        Thu, 24 Oct 2019 09:35:17 -0700 (PDT)
Date:   Thu, 24 Oct 2019 17:35:15 +0100
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
Subject: Re: [PATCH 11/13] cpuidle: psci: Attach CPU devices to their PM
 domains
Message-ID: <20191024163515.GD22036@bogus>
References: <20191010113937.15962-1-ulf.hansson@linaro.org>
 <20191010113937.15962-12-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010113937.15962-12-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 10, 2019 at 01:39:35PM +0200, Ulf Hansson wrote:
> In order to enable a CPU to be power managed through its PM domain, let's
> try to attach it by calling psci_dt_attach_cpu() during the cpuidle
> initialization.
>
> psci_dt_attach_cpu() returns a pointer to the attached struct device, which
> later should be used for runtime PM, hence we need to store it somewhere.
> Rather than adding yet another per CPU variable, let's create a per CPU
> struct to collect the relevant per CPU variables.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/cpuidle/cpuidle-psci.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index a16467daf99d..1510422c7a53 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -23,7 +23,12 @@
>  #include "cpuidle-psci.h"
>  #include "dt_idle_states.h"
>
> -static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
> +struct psci_cpuidle_data {
> +	u32 *psci_states;
> +	struct device *dev;
> +};
> +
> +static DEFINE_PER_CPU_READ_MOSTLY(struct psci_cpuidle_data, psci_cpuidle_data);
>  static DEFINE_PER_CPU(u32, domain_state);
>

/me just thinking still: If it make sense to keep psci_states separate
and domain_state and only other things needed for RPM/OSI in the
structure. I do understand that we modify domain_state and hence
we can't use READ_MOSTLY then. Let's see, for now keep it as is, thought
I will think out aloud.

--
Regards,
Sudeep
