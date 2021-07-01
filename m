Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B5C3B90CE
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jul 2021 12:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbhGALAN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 07:00:13 -0400
Received: from relay07.th.seeweb.it ([5.144.164.168]:52757 "EHLO
        relay07.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236155AbhGALAK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 07:00:10 -0400
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 3D8DB3F416;
        Thu,  1 Jul 2021 12:57:38 +0200 (CEST)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     bjorn.andersson@linaro.org
Cc:     viresh.kumar@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        amit.kucheria@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jami.kettunen@somainline.org,
        paul.bouchara@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, jeffrey.l.hugo@gmail.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH v6 5/9] cpufreq: qcom-hw: Add kerneldoc to some functions
Date:   Thu,  1 Jul 2021 12:57:26 +0200
Message-Id: <20210701105730.322718-6-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210701105730.322718-1-angelogioacchino.delregno@somainline.org>
References: <20210701105730.322718-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some functions may not be very straightforward to understand:
add kerneldoc to some ones in order to improve readability.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 54 +++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index f86859bf76f1..af1b59310249 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -39,6 +39,13 @@ struct qcom_cpufreq_data {
 static unsigned long cpu_hw_rate, xo_rate;
 static bool icc_scaling_enabled;
 
+/**
+ * qcom_cpufreq_set_bw() - Set interconnect bandwidth
+ * @policy:   CPUFreq policy structure
+ * @freq_khz: CPU Frequency in KHz
+ *
+ * Returns: Zero for success, otherwise negative value on errors
+ */
 static int qcom_cpufreq_set_bw(struct cpufreq_policy *policy,
 			       unsigned long freq_khz)
 {
@@ -60,6 +67,20 @@ static int qcom_cpufreq_set_bw(struct cpufreq_policy *policy,
 	return ret;
 }
 
+/**
+ * qcom_cpufreq_update_opp() - Update CPU OPP tables
+ * @policy:   CPUFreq policy structure
+ * @freq_khz: CPU Frequency for OPP entry in KHz
+ * @volt:     CPU Voltage for OPP entry in microvolts
+ *
+ * The CPU frequencies and voltages are being read from the Operating
+ * State Manager (OSM) and the related OPPs, read from DT, need to be
+ * updated to reflect what the hardware will set for each p-state.
+ * If there is no OPP table specified in DT, then this function will
+ * add dynamic ones.
+ *
+ * Returns: Zero for success, otherwise negative value on errors
+ */
 static int qcom_cpufreq_update_opp(struct device *cpu_dev,
 				   unsigned long freq_khz,
 				   unsigned long volt)
@@ -80,6 +101,17 @@ static int qcom_cpufreq_update_opp(struct device *cpu_dev,
 	return dev_pm_opp_enable(cpu_dev, freq_hz);
 }
 
+/**
+ * qcom_cpufreq_hw_target_index() - Set frequency/voltage
+ * @policy:   CPUFreq policy structure
+ * @index:    Performance state index to be set
+ *
+ * This function sends a request to the Operating State Manager
+ * to set a Performance State index, so, to set frequency and
+ * voltage for the target CPU/cluster.
+ *
+ * Returns: Always zero
+ */
 static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
 					unsigned int index)
 {
@@ -95,6 +127,12 @@ static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
 	return 0;
 }
 
+/**
+ * qcom_cpufreq_hw_get() - Get current Performance State from OSM
+ * @cpu:      CPU number
+ *
+ * Returns: Current CPU/Cluster frequency or zero
+ */
 static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
 {
 	struct qcom_cpufreq_data *data;
@@ -128,6 +166,17 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
 	return policy->freq_table[index].frequency;
 }
 
+/**
+ * qcom_cpufreq_hw_read_lut() - Read Lookup Table from the OSM
+ * @cpu_dev:   CPU device
+ * @policy:    CPUFreq policy structure
+ *
+ * The Operating State Manager Lookup Table can always be read, even
+ * in case it was pre-programmed by the bootloader or by TrustZone.
+ * Read the LUT from it in order to build OPPs containing DVFS info.
+ *
+ * Returns: Zero for success, otherwise negative number on errors.
+ */
 static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
 				    struct cpufreq_policy *policy)
 {
@@ -228,6 +277,11 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
 	return 0;
 }
 
+/*
+ * qcom_get_related_cpus - Get mask of CPUs in the same frequency domain
+ * @index: CPU number
+ * @m:     Returned CPU mask
+ */
 static void qcom_get_related_cpus(int index, struct cpumask *m)
 {
 	struct device_node *cpu_np;
-- 
2.32.0

