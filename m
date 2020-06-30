Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB75F20F293
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jun 2020 12:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732454AbgF3KXX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jun 2020 06:23:23 -0400
Received: from foss.arm.com ([217.140.110.172]:35892 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732473AbgF3KXN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 30 Jun 2020 06:23:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D98830E;
        Tue, 30 Jun 2020 03:23:07 -0700 (PDT)
Received: from [10.37.12.67] (unknown [10.37.12.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B51ED3F68F;
        Tue, 30 Jun 2020 03:23:04 -0700 (PDT)
Subject: Re: [PATCH 0/5] cpuidle: psci: Various improvements for PSCI PM
 domains
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        linux-arm-kernel@lists.infradead.org
References: <20200615152054.6819-1-ulf.hansson@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <f924de32-f780-e921-fe45-cf26e70e1c66@arm.com>
Date:   Tue, 30 Jun 2020 11:23:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200615152054.6819-1-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ulf,

On 6/15/20 4:20 PM, Ulf Hansson wrote:
> The main change in this series is done in patch 5/5, which implements support
> to prevent domain idlestates until all PSCI PM domain consumers are ready for
> it. To reach that point the corresponding code for cpuidle-psci and
> cpuidle-psci-domain, needed to be converted into platform drivers, which is
> done by the earlier changes in the series.
> 
> Additionally, some improvements have been made to the error path, which becomes
> easier when the code gets converted to platform drivers.
> 
> Deployment for a Qcom SoC, which actually takes full benefit of these changes
> are also in the pipe, but deferring then a bit until $subject series have been
> discussed.
> 
> Kind regards
> Ulf Hansson
> 
> Ulf Hansson (5):
>    cpuidle: psci: Fail cpuidle registration if set OSI mode failed
>    cpuidle: psci: Fix error path via converting to a platform driver
>    cpuidle: psci: Split into two separate build objects
>    cpuidle: psci: Convert PM domain to platform driver
>    cpuidle: psci: Prevent domain idlestates until consumers are ready
> 
>   drivers/cpuidle/Kconfig.arm           |  10 ++
>   drivers/cpuidle/Makefile              |   5 +-
>   drivers/cpuidle/cpuidle-psci-domain.c |  74 +++++++++-----
>   drivers/cpuidle/cpuidle-psci.c        | 141 +++++++++++++++-----------
>   drivers/cpuidle/cpuidle-psci.h        |  11 +-
>   5 files changed, 150 insertions(+), 91 deletions(-)
> 

Since I am interested in some CPU idle statistics (residency, etc),
I would like to help you and Sudeep in reviewing the patch set.

Could you clarify some bit below?
1. There is Qcom SoC which has dependencies between PSCI PM domain
consumers and this CPU idle - thus we cannot register and use CPU
idle driver till related drivers fully setup.
2. The proposed solution is to use platform driver and plat. device
for this CPU idle driver, to have access to deferred probe mechanism and
wait for the consumer drivers fully probed state.
3. Do you have maybe some estimations how long it takes for these
consumers to be fully probed?
4. Changing just this CPU idle driver registration point (to
late_initcall()) phase in time is not a solution.

Regards,
Lukasz
