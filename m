Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5228F84AF9
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2019 13:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbfHGLp6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Aug 2019 07:45:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48010 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728592AbfHGLp5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Aug 2019 07:45:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5D34560E42; Wed,  7 Aug 2019 11:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565178356;
        bh=7MLbyRKJqEYHBK8k42Bf4KgbYjxrgaFNcZjAenCYYLA=;
        h=From:To:Cc:Subject:Date:From;
        b=NGY9Z4zLWwyyyiz2DBo9uzQ1x/CnBD5Xy7fb44bDM65yv++nIDnJn0RALckpVmXp+
         BKJFTBhp9xWBlRptKDABdvrqMANhoFbAECuUXfIyZEpWotrGo85a7WTvipzuB7YeN3
         s6d7ht+/XJXM9Z0w8JRo02yupANcOigDp1mLOAIk=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B9D4160275;
        Wed,  7 Aug 2019 11:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565178355;
        bh=7MLbyRKJqEYHBK8k42Bf4KgbYjxrgaFNcZjAenCYYLA=;
        h=From:To:Cc:Subject:Date:From;
        b=mbi26Zn+BAxdxBNDsr5iZORnWZ6ZvrpHblTpZYwLQcVKzgEwSw50y0V5/Y5StVi2N
         UotkeluE31IR1WH4KP8e403dSH1lKVRa78ay9MRwyOEnj+R+winCLGIcHeFNfjRC0S
         UErHk8379KsWlXnzh7vnD+xuDLXkMm1+T/WVu5X4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B9D4160275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     tdas@codeaurora.org, viresh.kumar@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        rjw@rjwysocki.net, agross@kernel.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH] cpufreq: qcom-hw: Update logic to detect turbo frequency
Date:   Wed,  7 Aug 2019 17:15:43 +0530
Message-Id: <20190807114543.7187-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The core count read back from the each domain's look up table serves
as an indicator for the onset of the turbo frequency and not accurate
representation of number of cores in a paticular domain. Update turbo
detection logic accordingly to add support for SM8150 SoCs.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---

Source Referenoce:
CAF msm-4.14:
https://source.codeaurora.org/quic/la/kernel/msm-4.14/tree/drivers/clk/qcom/clk-cpu-osm.c?h=LA.UM.7.1.r1-14000-sm8150.0#n666

 drivers/cpufreq/qcom-cpufreq-hw.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 4b0b50403901b..6b456cd67b767 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -20,6 +20,7 @@
 #define LUT_VOLT			GENMASK(11, 0)
 #define LUT_ROW_SIZE			32
 #define CLK_HW_DIV			2
+#define LUT_TURBO_IND			1
 
 /* Register offsets */
 #define REG_ENABLE			0x0
@@ -79,7 +80,6 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
 {
 	u32 data, src, lval, i, core_count, prev_cc = 0, prev_freq = 0, freq;
 	u32 volt;
-	unsigned int max_cores = cpumask_weight(policy->cpus);
 	struct cpufreq_frequency_table	*table;
 
 	table = kcalloc(LUT_MAX_ENTRIES + 1, sizeof(*table), GFP_KERNEL);
@@ -102,12 +102,12 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
 		else
 			freq = cpu_hw_rate / 1000;
 
-		if (freq != prev_freq && core_count == max_cores) {
+		if (freq != prev_freq && core_count != LUT_TURBO_IND) {
 			table[i].frequency = freq;
 			dev_pm_opp_add(cpu_dev, freq * 1000, volt);
 			dev_dbg(cpu_dev, "index=%d freq=%d, core_count %d\n", i,
 				freq, core_count);
-		} else {
+		} else if (core_count == LUT_TURBO_IND) {
 			table[i].frequency = CPUFREQ_ENTRY_INVALID;
 		}
 
@@ -115,14 +115,14 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
 		 * Two of the same frequencies with the same core counts means
 		 * end of table
 		 */
-		if (i > 0 && prev_freq == freq && prev_cc == core_count) {
+		if (i > 0 && prev_freq == freq) {
 			struct cpufreq_frequency_table *prev = &table[i - 1];
 
 			/*
 			 * Only treat the last frequency that might be a boost
 			 * as the boost frequency
 			 */
-			if (prev_cc != max_cores) {
+			if (prev->frequency == CPUFREQ_ENTRY_INVALID) {
 				prev->frequency = prev_freq;
 				prev->flags = CPUFREQ_BOOST_FREQ;
 				dev_pm_opp_add(cpu_dev,	prev_freq * 1000, volt);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

