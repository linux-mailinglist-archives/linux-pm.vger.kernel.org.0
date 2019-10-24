Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98517E3697
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2019 17:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503188AbfJXP0m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Oct 2019 11:26:42 -0400
Received: from foss.arm.com ([217.140.110.172]:54312 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503092AbfJXP0j (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 24 Oct 2019 11:26:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6950031F;
        Thu, 24 Oct 2019 08:26:24 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66B193F71F;
        Thu, 24 Oct 2019 08:26:22 -0700 (PDT)
Date:   Thu, 24 Oct 2019 16:26:16 +0100
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
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH 02/13] dt: psci: Update DT bindings to support
 hierarchical PSCI states
Message-ID: <20191024152504.GA11467@bogus>
References: <20191010113937.15962-1-ulf.hansson@linaro.org>
 <20191010113937.15962-3-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010113937.15962-3-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 10, 2019 at 01:39:26PM +0200, Ulf Hansson wrote:
> Update PSCI DT bindings to allow to represent idle states for CPUs and the
> CPU topology, by using a hierarchical layout. Primarily this is done by
> re-using the existing power domain description [1] and the domain idle
> state description [2].
>
> Let's also take the opportunity to update the examples to clarify the
> difference between the currently supported flattened layout vs the new
> hierarchical layout.
>

This looks fine to me. FWIW:

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

But before this gets merged, I would like to add another but "the golden"
example Qcom *always* referred during ACPI LPI discussions. Ofcourse, it
can be addition patch and if I get time, I can write this but no promise
ATM.

Hierarchical Representation:
System
1. SYSTEM_RET
2. SYSTEM_PG

	Cluster#0
	1. CLUSTER_RET
	2. CLUSTER_PG

		Core#0
		1. CORE_CG
		2. CORE_RET
		3. CORE_PG

		Core#1
		1. CORE_CG
		2. CORE_RET
		3. CORE_PG
	Cluster#1 (ditto)

Flattened Representation:

Core#0
	1 CORE_CG
	2 CORE_RET
	3 CORE_RET + CLUSTER_RET
	4 CORE_RET + CLUSTER_RET + SYSTEM_RET
	5 CORE_PG
	6 CORE_PG  + CLUSTER_RET
	7 CORE_PG  + CLUSTER_RET + SYSTEM_RET
	8 CORE_PG  + CLUSTER_PG
	9 CORE_PG  + CLUSTER_PG  + SYSTEM_RET
       10 CORE_PG  + CLUSTER_PG  + SYSTEM_PG

Though we may not implement everything needed to support this, but
we must ensure we don't have to end up in a situation breaking backward
compatibility trying to support the same.

--
Regards,
Sudeep
