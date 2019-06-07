Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F14DD38EC8
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 17:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbfFGPRW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jun 2019 11:17:22 -0400
Received: from foss.arm.com ([217.140.110.172]:42484 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728446AbfFGPRW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Jun 2019 11:17:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B5A6367;
        Fri,  7 Jun 2019 08:17:21 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F0F83F718;
        Fri,  7 Jun 2019 08:17:18 -0700 (PDT)
Date:   Fri, 7 Jun 2019 16:17:16 +0100
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
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH 07/18] drivers: firmware: psci: Prepare to use OS
 initiated suspend mode
Message-ID: <20190607151716.GF15577@e107155-lin>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
 <20190513192300.653-8-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513192300.653-8-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 13, 2019 at 09:22:49PM +0200, Ulf Hansson wrote:
> The per CPU variable psci_power_state, contains an array of fixed values,
> which reflects the corresponding arm,psci-suspend-param parsed from DT, for
> each of the available CPU idle states.
>
> This isn't sufficient when using the hierarchical CPU topology in DT in
> combination with having PSCI OS initiated (OSI) mode enabled. More
> precisely, in OSI mode, Linux is responsible of telling the PSCI FW what
> idle state the cluster (a group of CPUs) should enter, while in PSCI
> Platform Coordinated (PC) mode, each CPU independently votes for an idle
> state of the cluster.
>
> For this reason, let's introduce an additional per CPU variable called
> domain_state and implement two helper functions to read/write its values.
> Following patches, which implements PM domain support for PSCI, will use
> the domain_state variable and set it to corresponding bits that represents
> the selected idle state for the cluster.
>
> Finally, in psci_cpu_suspend_enter() and psci_suspend_finisher(), let's
> take into account the values in the domain_state, as to get the complete
> suspend parameter.
>

I understand it was split to ease review, but this patch also does
nothing as domain_state = 0 always. I was trying hard to find where it's
set, but I assume it will be done in later patches. Again may be this
can be squashed into the first caller of psci_set_domain_state

--
Regards,
Sudeep
