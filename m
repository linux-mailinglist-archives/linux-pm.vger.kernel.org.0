Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7450D1264C4
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 15:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfLSOak (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 09:30:40 -0500
Received: from foss.arm.com ([217.140.110.172]:39320 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfLSOak (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Dec 2019 09:30:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFA7831B;
        Thu, 19 Dec 2019 06:30:39 -0800 (PST)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C35DC3F6CF;
        Thu, 19 Dec 2019 06:30:37 -0800 (PST)
Date:   Thu, 19 Dec 2019 14:30:32 +0000
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
Subject: Re: [PATCH v4 08/14] cpuidle: psci: Add a helper to attach a CPU to
 its PM domain
Message-ID: <20191219143032.GA20746@bogus>
References: <20191211154343.29765-1-ulf.hansson@linaro.org>
 <20191211154343.29765-9-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211154343.29765-9-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 11, 2019 at 04:43:37PM +0100, Ulf Hansson wrote:
> Introduce a PSCI DT helper function, psci_dt_attach_cpu(), which takes a
> CPU number as an in-parameter and tries to attach the CPU's struct device
> to its corresponding PM domain.
>
> Let's makes use of dev_pm_domain_attach_by_name(), as it allows us to
> specify "psci" as the "name" of the PM domain to attach to. Additionally,
> let's also prepare the attached device to be power managed via runtime PM.
>
> Note that, the implementation of the new helper function is in a new
> separate c-file, which may seems a bit too much at this point. However,
> subsequent changes that implements the remaining part of the PM domain
> support for cpuidle-psci, helps to justify this split.
>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
