Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9AEF38F1A
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 17:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbfFGPbU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jun 2019 11:31:20 -0400
Received: from foss.arm.com ([217.140.110.172]:42804 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729293AbfFGPbT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Jun 2019 11:31:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 069B2499;
        Fri,  7 Jun 2019 08:31:19 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55FE43F718;
        Fri,  7 Jun 2019 08:31:16 -0700 (PDT)
Date:   Fri, 7 Jun 2019 16:31:14 +0100
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
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/18] drivers: firmware: psci: Support CPU hotplug for
 the hierarchical model
Message-ID: <20190607153114.GI15577@e107155-lin>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
 <20190513192300.653-16-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513192300.653-16-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 13, 2019 at 09:22:57PM +0200, Ulf Hansson wrote:
> When the hierarchical CPU topology is used and when a CPU has been put
> offline (hotplug), that same CPU prevents its PM domain and thus also
> potential master PM domains, from being powered off. This is because genpd
> observes the CPU's attached device as being active from a runtime PM point
> of view.
> 
> To deal with this, let's decrease the runtime PM usage count by calling
> pm_runtime_put_sync_suspend() of the attached struct device when putting
> the CPU offline. Consequentially, we must then increase the runtime PM
> usage count, while putting the CPU online again.
> 

Why is this firmware/driver specific ? Why can't this be dealt in core
pm-domain ? I am concerned that if any other architectures or firmware
method decides to use this feature, this need to be duplicated there.

The way I see this is pure reference counting and is hardware/firmware/
driver agnostic and can be made generic.

--
Regards,
Sudeep
