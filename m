Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B882C2331
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 11:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732209AbgKXKoN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 05:44:13 -0500
Received: from foss.arm.com ([217.140.110.172]:53228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732203AbgKXKoM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Nov 2020 05:44:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75FE51396;
        Tue, 24 Nov 2020 02:44:12 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.29.140])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 021F93F71F;
        Tue, 24 Nov 2020 02:44:09 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     lukasz.luba@arm.com, Dietmar.Eggemann@arm.com,
        cristian.marussi@arm.com, morten.rasmussen@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org
Subject: [PATCH 2/2] cpufreq: arm_scmi: Discover the power scale in performance protocol
Date:   Tue, 24 Nov 2020 10:43:46 +0000
Message-Id: <20201124104346.27167-3-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201124104346.27167-1-lukasz.luba@arm.com>
References: <20201124104346.27167-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add mechanism to discover the power scale present in the performance
protocol for all domains. Provide this information to Energy Model,
which then can be checked in other frameworks, e.g. thermal.

Suggested-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index dfd87752f054..491a0a24fb1e 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -126,6 +126,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	struct scmi_data *priv;
 	struct cpufreq_frequency_table *freq_table;
 	struct em_data_callback em_cb = EM_DATA_CB(scmi_get_cpu_power);
+	bool power_scale_mw;
 
 	cpu_dev = get_cpu_device(policy->cpu);
 	if (!cpu_dev) {
@@ -189,8 +190,9 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	policy->fast_switch_possible =
 		handle->perf_ops->fast_switch_possible(handle, cpu_dev);
 
+	power_scale_mw = handle->perf_ops->power_scale_mw_get(handle);
 	em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb, policy->cpus,
-				    false);
+				    power_scale_mw);
 
 	return 0;
 
-- 
2.17.1

