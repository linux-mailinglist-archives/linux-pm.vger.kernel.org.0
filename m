Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF552A7F45
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 13:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbgKEM4w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 07:56:52 -0500
Received: from foss.arm.com ([217.140.110.172]:60042 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730808AbgKEM4v (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Nov 2020 07:56:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B56C14BF;
        Thu,  5 Nov 2020 04:56:50 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (e108754-lin.cambridge.arm.com [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4709A3F719;
        Thu,  5 Nov 2020 04:56:49 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, lenb@kernel.org,
        sudeep.holla@arm.com
Cc:     morten.rasmussen@arm.com, jeremy.linton@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com
Subject: [PATCH 6/8] cppc_cpufreq: clarify support for coordination types
Date:   Thu,  5 Nov 2020 12:55:22 +0000
Message-Id: <20201105125524.4409-7-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201105125524.4409-1-ionela.voinescu@arm.com>
References: <20201105125524.4409-1-ionela.voinescu@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The previous coordination type handling in the cppc_cpufreq init code
created some confusion: the comment mentioned "Support only SW_ANY for
now" while only the SW_ALL/ALL case resulted in a failure. The other
coordination types (HW_ALL/HW, NONE) were silently supported.

Clarify support for coordination types while describing in comments the
intended behavior.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cppc_cpufreq.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index fd2daeb59b49..60ac7f8049b5 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -363,11 +363,22 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	policy->transition_delay_us = cppc_cpufreq_get_transition_delay_us(cpu);
 	policy->shared_type = domain->shared_type;
 
-	if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY) {
+	switch (policy->shared_type) {
+	case CPUFREQ_SHARED_TYPE_HW:
+	case CPUFREQ_SHARED_TYPE_NONE:
+		/* Nothing to be done - we'll have a policy for each CPU */
+		break;
+	case CPUFREQ_SHARED_TYPE_ANY:
+		/*
+		 * All CPUs in the domain will share a policy and all cpufreq
+		 * operations will use a single cppc_cpudata structure stored
+		 * in policy->driver_data.
+		 */
 		cpumask_copy(policy->cpus, domain->shared_cpu_map);
-	} else if (policy->shared_type == CPUFREQ_SHARED_TYPE_ALL) {
-		/* Support only SW_ANY for now. */
-		pr_debug("Unsupported CPU co-ord type\n");
+		break;
+	default:
+		pr_info("Unsupported cpufreq CPU co-ord type: %d\n",
+			policy->shared_type);
 		return -EFAULT;
 	}
 
-- 
2.17.1

