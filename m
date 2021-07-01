Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0773B90D8
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jul 2021 12:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236289AbhGALAU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 07:00:20 -0400
Received: from relay06.th.seeweb.it ([5.144.164.167]:60393 "EHLO
        relay06.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbhGALAP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 07:00:15 -0400
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 4C2613F641;
        Thu,  1 Jul 2021 12:57:39 +0200 (CEST)
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
Subject: [PATCH v6 7/9] cpufreq: qcom-hw: Allow getting the maximum transition latency for OPPs
Date:   Thu,  1 Jul 2021 12:57:28 +0200
Message-Id: <20210701105730.322718-8-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210701105730.322718-1-angelogioacchino.delregno@somainline.org>
References: <20210701105730.322718-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to fine-tune the frequency scaling from various governors,
allow to set a maximum transition latency from OPPs, which may be
different depending on the SoC.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 35 +++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 54b79fe772b6..0b80c65a22a8 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -1331,6 +1331,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 	void __iomem *base;
 	struct qcom_cpufreq_data *data;
 	char fdom_resname[] = "freq-domainX";
+	unsigned int transition_latency;
 	int cpu_count, index, ret;
 
 	cpu_dev = get_cpu_device(policy->cpu);
@@ -1381,22 +1382,31 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 	data->soc_data = of_device_get_match_data(&pdev->dev);
 	data->base = base;
 	data->res = res;
+	policy->driver_data = data;
 
-	/* HW should be in enabled state to proceed */
-	if (!(readl_relaxed(base + data->soc_data->reg_enable) & 0x1)) {
-		dev_err(dev, "Domain-%d cpufreq hardware not enabled\n", index);
-		ret = -ENODEV;
-		goto error;
-	}
-
-	qcom_get_related_cpus(index, policy->cpus);
+	cpu_count = qcom_get_related_cpus(index, policy->cpus);
 	if (!cpumask_weight(policy->cpus)) {
 		dev_err(dev, "Domain-%d failed to get related CPUs\n", index);
 		ret = -ENOENT;
 		goto error;
 	}
 
-	policy->driver_data = data;
+	if (!data->soc_data->uses_tz) {
+		ret = qcom_cpufreq_hw_osm_setup(cpu_dev, policy,
+						cpu_count, index);
+		if (ret) {
+			dev_err(dev, "Cannot setup the OSM for CPU%d: %d\n",
+				policy->cpu, ret);
+			goto error;
+		}
+	}
+
+	/* HW should be in enabled state to proceed */
+	if (!(readl_relaxed(base + data->soc_data->reg_enable) & 0x1)) {
+		dev_err(dev, "Domain-%d cpufreq hardware not enabled\n", index);
+		ret = -ENODEV;
+		goto error;
+	}
 
 	ret = qcom_cpufreq_hw_read_lut(cpu_dev, policy);
 	if (ret) {
@@ -1411,6 +1421,12 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 		goto error;
 	}
 
+	transition_latency = dev_pm_opp_get_max_transition_latency(cpu_dev);
+	if (!transition_latency)
+		transition_latency = CPUFREQ_ETERNAL;
+
+	policy->cpuinfo.transition_latency = transition_latency;
+
 	dev_pm_opp_of_register_em(cpu_dev, policy->cpus);
 
 	if (policy_has_boost_freq(policy)) {
@@ -1421,6 +1437,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 
 	return 0;
 error:
+	policy->driver_data = NULL;
 	kfree(data);
 unmap_base:
 	iounmap(base);
-- 
2.32.0

