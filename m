Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC00DC139
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 11:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404308AbfJRJjJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 05:39:09 -0400
Received: from [217.140.110.172] ([217.140.110.172]:59874 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1727917AbfJRJjI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 18 Oct 2019 05:39:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AE093E8;
        Fri, 18 Oct 2019 02:38:43 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE60F3F718;
        Fri, 18 Oct 2019 02:38:41 -0700 (PDT)
Date:   Fri, 18 Oct 2019 10:38:39 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 01/13] cpuidle: psci: Fix potential access to unmapped
 memory
Message-ID: <20191018093839.GB25918@e121166-lin.cambridge.arm.com>
References: <20191010113937.15962-1-ulf.hansson@linaro.org>
 <20191010113937.15962-2-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010113937.15962-2-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 10, 2019 at 01:39:25PM +0200, Ulf Hansson wrote:
> When the WFI state have been selected, the in-parameter idx to
> psci_enter_idle_state() is zero. In this case, we must not index the state
> array as "state[idx - 1]", as it means accessing data outside the array.
> Fix the bug by pre-checking if idx is zero.
> 
> Fixes: 9ffeb6d08c3a ("PSCI: cpuidle: Refactor CPU suspend power_state parameter handling")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/cpuidle/cpuidle-psci.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index f3c1a2396f98..2e91c8d6c211 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -27,10 +27,10 @@ static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
>  static int psci_enter_idle_state(struct cpuidle_device *dev,
>  				struct cpuidle_driver *drv, int idx)
>  {
> -	u32 *state = __this_cpu_read(psci_power_state);
> +	u32 *states = __this_cpu_read(psci_power_state);
> +	u32 state = idx ? states[idx - 1] : 0;
>  
> -	return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter,
> -					   idx, state[idx - 1]);
> +	return CPU_PM_CPU_IDLE_ENTER_PARAM(psci_cpu_suspend_enter, idx, state);

Technically we don't dereference that array entry but I agree this
is ugly and potentially broken.

My preference is aligning it with ACPI code and allocate one more
entry in the psci_power_state array (useless for wfi, agreed but
at least we remove this (-1) handling from the code).

Thanks,
Lorenzo

>  }
>  
>  static struct cpuidle_driver psci_idle_driver __initdata = {
> -- 
> 2.17.1
> 
