Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41A42178ED8
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2020 11:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgCDKun (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Mar 2020 05:50:43 -0500
Received: from foss.arm.com ([217.140.110.172]:60826 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbgCDKun (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Mar 2020 05:50:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0C0030E;
        Wed,  4 Mar 2020 02:50:42 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 553B13F534;
        Wed,  4 Mar 2020 02:50:41 -0800 (PST)
Date:   Wed, 4 Mar 2020 10:50:39 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/4] cpuidle: psci: Fixup support for domain idle
 states being zero
Message-ID: <20200304105039.GC25004@bogus>
References: <20200303203559.23995-1-ulf.hansson@linaro.org>
 <20200303203559.23995-3-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303203559.23995-3-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 03, 2020 at 09:35:57PM +0100, Ulf Hansson wrote:
> The current code intends to allow a PSCI PM domain to have none domain idle
> states defined in DT. However, a few minor things needs to be fixed to make
> this correctly supported, so let's do that.
>
> Reported-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> Fixes: a65a397f2451 ("cpuidle: psci: Add support for PM domains by using genpd")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/cpuidle/cpuidle-psci-domain.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> index 423f03bbeb74..c34b12c4069a 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -49,6 +49,9 @@ static int __init psci_pd_parse_state_nodes(struct genpd_power_state *states,
>  	int i, ret;
>  	u32 psci_state, *psci_state_buf;
>
> +	if (!states)
> +		return 0;
> +

Was any issue found ? Or just code inspection ? If states = NULL,
state_count = 0, and I don't see anything blowing up. It may save couple
of extra instruction execution.

>  	for (i = 0; i < state_count; i++) {
>  		ret = psci_dt_parse_state_node(to_of_node(states[i].fwnode),
>  					&psci_state);
> @@ -96,6 +99,9 @@ static void psci_pd_free_states(struct genpd_power_state *states,
>  {
>  	int i;
>
> +	if (!states)
> +		return;
> +

Same here and kfree(NULL) is also valid.

--
Regards,
Sudeep
