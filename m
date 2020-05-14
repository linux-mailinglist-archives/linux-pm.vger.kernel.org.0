Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7481D3296
	for <lists+linux-pm@lfdr.de>; Thu, 14 May 2020 16:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgENOUY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 10:20:24 -0400
Received: from foss.arm.com ([217.140.110.172]:37366 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbgENOUY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 May 2020 10:20:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38AB51045;
        Thu, 14 May 2020 07:20:23 -0700 (PDT)
Received: from bogus (unknown [10.37.8.154])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7DAE3F71E;
        Thu, 14 May 2020 07:20:20 -0700 (PDT)
Date:   Thu, 14 May 2020 15:20:15 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] cpuidle: psci: Fixup execution order when entering a
 domain idle state
Message-ID: <20200514142015.GA23401@bogus>
References: <20200511133346.21706-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511133346.21706-1-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 11, 2020 at 03:33:46PM +0200, Ulf Hansson wrote:
> Moving forward, platforms are going to need to execute specific "last-man"
> operations before a domain idle state can be entered.

I need to dig the thread details, but I remember commenting on one of
the similar discussion. It was something to do with voting which wasn't
necessary at all. I am interested in the details here.

> In one way or the other, these operations needs to be triggered while
> walking the  hierarchical topology via runtime PM and genpd, as it's at that
> point the last-man becomes known.
>
> Moreover, executing last-man operations needs to be done after the CPU PM
> notifications are sent through cpu_pm_enter(), as otherwise it's likely
> that some notifications would fail. Therefore, let's re-order the sequence
> in psci_enter_domain_idle_state(), so cpu_pm_enter() gets called prior
> pm_runtime_put_sync().
>

More details on why notifications fail ?

> Fixes: ce85aef570df ("cpuidle: psci: Manage runtime PM in the idle path")
> Reported-by: Lina Iyer <ilina@codeaurora.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/cpuidle/cpuidle-psci.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index bae9140a65a5..d0fb585073c6 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -58,6 +58,10 @@ static int psci_enter_domain_idle_state(struct cpuidle_device *dev,
>  	u32 state;
>  	int ret;
>  
> +	ret = cpu_pm_enter();
> +	if (ret)
> +		return -1;
> +

This change is ignoring the retention case psci_enter_state handles and
this may affect performance by doing unnecessary save/restore.

-- 
Regards,
Sudeep
