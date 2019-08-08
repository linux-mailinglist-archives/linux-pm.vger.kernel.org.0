Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14E92862E5
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 15:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732866AbfHHNTX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 09:19:23 -0400
Received: from foss.arm.com ([217.140.110.172]:33288 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732643AbfHHNTX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Aug 2019 09:19:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC70515A2;
        Thu,  8 Aug 2019 06:19:22 -0700 (PDT)
Received: from e107049-lin.arm.com (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C4F9A3F694;
        Thu,  8 Aug 2019 06:19:21 -0700 (PDT)
From:   Douglas RAILLARD <douglas.raillard@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, agross@kernel.org
Subject: [PATCH 1/2] cpufreq: drivers: Enable frequency invariance in qcom-cpufreq-hw
Date:   Thu,  8 Aug 2019 14:18:57 +0100
Message-Id: <20190808131857.21082-1-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add calls to arch_set_freq_scale() in qcom-cpufreq-hw driver to enable
frequency invariance.

Signed-off-by: Douglas RAILLARD <douglas.raillard@arm.com>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 4b0b50403901..3bd3b8b268d9 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -34,9 +34,12 @@ static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
 					unsigned int index)
 {
 	void __iomem *perf_state_reg = policy->driver_data;
+	unsigned long freq = policy->freq_table[index].frequency;
 
 	writel_relaxed(index, perf_state_reg);
 
+	arch_set_freq_scale(policy->related_cpus, freq,
+			    policy->cpuinfo.max_freq);
 	return 0;
 }
 
@@ -63,6 +66,7 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
 {
 	void __iomem *perf_state_reg = policy->driver_data;
 	int index;
+	unsigned long freq;
 
 	index = policy->cached_resolved_idx;
 	if (index < 0)
@@ -70,7 +74,11 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
 
 	writel_relaxed(index, perf_state_reg);
 
-	return policy->freq_table[index].frequency;
+	freq = policy->freq_table[index].frequency;
+	arch_set_freq_scale(policy->related_cpus, freq,
+			    policy->cpuinfo.max_freq);
+
+	return freq;
 }
 
 static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
-- 
2.22.0

