Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98D52484D1
	for <lists+linux-pm@lfdr.de>; Tue, 18 Aug 2020 14:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgHRMfO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Aug 2020 08:35:14 -0400
Received: from foss.arm.com ([217.140.110.172]:40124 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbgHRMfN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Aug 2020 08:35:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05AEF31B;
        Tue, 18 Aug 2020 05:35:13 -0700 (PDT)
Received: from bogus (unknown [10.37.12.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 156243F6CF;
        Tue, 18 Aug 2020 05:35:09 -0700 (PDT)
Date:   Tue, 18 Aug 2020 13:35:07 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] cpuidle: psci: Allow PM domain to be initialized even if
 no OSI mode
Message-ID: <20200818123507.GD6873@bogus>
References: <20200814123436.61851-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814123436.61851-1-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 14, 2020 at 02:34:36PM +0200, Ulf Hansson wrote:
> If the PSCI OSI mode isn't supported or fails to be enabled, the PM domain
> topology with the genpd providers isn't initialized. This is perfectly fine
> from cpuidle-psci point of view.
>

Indeed.

> However, since the PM domain topology in the DTS files is a description of
> the HW, no matter of whether the PSCI OSI mode is supported or not, other
> consumers besides the CPUs may rely on it.
>

And why are they even registered as part of cpuidle-psci-domain ?
If they have to be, can be decouple it completely from cpuidle then ?

> Therefore, let's always allow the initialization of the PM domain topology
> to succeed, independently of whether the PSCI OSI mode is supported.
> Consequentially we need to track if we succeed to enable the OSI mode, as
> to know when a domain idlestate can be selected.
>

I thought we had discussed this in past, why are we back to the same
discussion ? I may need to read those again to get the context.

> Note that, CPU devices are still not being attached to the PM domain
> topology, unless the PSCI OSI mode is supported.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/cpuidle/cpuidle-psci-domain.c | 49 +++++++++++++--------------
>  1 file changed, 24 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> index b6e9649ab0da..55653c110e3a 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -28,6 +28,7 @@ struct psci_pd_provider {
> 
>  static LIST_HEAD(psci_pd_providers);
>  static bool psci_pd_allow_domain_state;
> +static bool psci_osi_mode_enabled;
> 
>  static int psci_pd_power_off(struct generic_pm_domain *pd)
>  {
> @@ -37,7 +38,7 @@ static int psci_pd_power_off(struct generic_pm_domain *pd)
>  	if (!state->data)
>  		return 0;
> 
> -	if (!psci_pd_allow_domain_state)
> +	if (!psci_pd_allow_domain_state || !psci_osi_mode_enabled)

I really don't like this check. Why do we have to keep checking
psci_osi_mode_enabled every single time and that is the reason IIRC
I was against this and just don't add the domains.

--
Regards,
Sudeep
