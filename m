Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83EB2A7F31
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 13:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730676AbgKEM4u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 07:56:50 -0500
Received: from foss.arm.com ([217.140.110.172]:60024 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730784AbgKEM4t (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Nov 2020 07:56:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F2E914BF;
        Thu,  5 Nov 2020 04:56:48 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (e108754-lin.cambridge.arm.com [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3A8CA3F719;
        Thu,  5 Nov 2020 04:56:47 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, lenb@kernel.org,
        sudeep.holla@arm.com
Cc:     morten.rasmussen@arm.com, jeremy.linton@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com
Subject: [PATCH 5/8] cppc_cpufreq: use policy->cpu as driver of frequency setting
Date:   Thu,  5 Nov 2020 12:55:21 +0000
Message-Id: <20201105125524.4409-6-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201105125524.4409-1-ionela.voinescu@arm.com>
References: <20201105125524.4409-1-ionela.voinescu@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Considering only the currently supported coordination types (ANY, HW,
NONE), this change only makes a difference for the ANY type, when
policy->cpu is hotplugged out. In that case the new policy->cpu will
be different from ((struct cppc_cpudata *)policy->driver_data)->cpu.

While in this case the controls of *ANY* CPU could be used to drive
frequency changes, it's more consistent to use policy->cpu as the
leading CPU, as used in all other cppc_cpufreq functions. Additionally,
the debug prints in cppc_set_perf() would no longer create confusion
when referring to a CPU that is hotplugged out.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cppc_cpufreq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index ac95b4424a2e..fd2daeb59b49 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -150,6 +150,7 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
 
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
+	unsigned int cpu = policy->cpu;
 	struct cpufreq_freqs freqs;
 	u32 desired_perf;
 	int ret = 0;
@@ -164,12 +165,12 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
 	freqs.new = target_freq;
 
 	cpufreq_freq_transition_begin(policy, &freqs);
-	ret = cppc_set_perf(cpu_data->cpu, &cpu_data->perf_ctrls);
+	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
 	cpufreq_freq_transition_end(policy, &freqs, ret != 0);
 
 	if (ret)
 		pr_debug("Failed to set target on CPU:%d. ret:%d\n",
-			 cpu_data->cpu, ret);
+			 cpu, ret);
 
 	return ret;
 }
-- 
2.17.1

