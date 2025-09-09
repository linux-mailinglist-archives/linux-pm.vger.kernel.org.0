Return-Path: <linux-pm+bounces-34199-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835B2B4A1FF
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 08:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C67193AB907
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 06:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1790C315D36;
	Tue,  9 Sep 2025 06:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZ8But7X"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32783019B1;
	Tue,  9 Sep 2025 06:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757398894; cv=none; b=eWWeW/xeV+O7uc9WNDELvfc0cNAbMCrkmOiS92RR3OUPgwjNhAhK5xunaNfPGGU4mMkvUGy4vQdItrMxz1QoCESUZkxiKKx6ZfDWsEMgoLLMoDhmn3NYNR1f03zpG2HNlgr0unQx/9F/WDYG9Iec9aQwz/UI2VfX8OKa67+tFYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757398894; c=relaxed/simple;
	bh=Z0ytwrdU8Zy3z2M0PKSyDzd7L21tYMFmz7LhDS59cwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L/SdGEg8/zWdl71Hnhj6qg2c0eZpiblW60oG23XhIvFy2FenzmpAb/lSijQ1Vtx/WuFSh8IgIa3GzgBqmdoncvNeVeyNSCj3UAD+ZCTU8uLVqoDW8T1UYg5twRGV6wWgQ0Rwp6mrsjUVCMgDfCaTJFzqdynnLQ+zq7/QIzNCedQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZ8But7X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64140C4CEF5;
	Tue,  9 Sep 2025 06:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757398894;
	bh=Z0ytwrdU8Zy3z2M0PKSyDzd7L21tYMFmz7LhDS59cwE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bZ8But7XpEdM+O/nEpWaE4EqqmQxWTBG0Zw9lfAoLKwMk+uW0b3UDzuayBjrjT3Dw
	 GaAK3fqXvGGOGH1hxJ4nCuuNO3C1NBFflAU8LJx8ed0uFRC3zJJt5dn/M85cGu6ZGQ
	 HFbf+GEaklaJqOkHhL4LedngS2tQMptp+68ejI+BNYXE6Y30H6+7oLm+4XcoqsVbjO
	 Z4r9Yht3df+HdZ13rh6i5z+phXHbaJhFEKFu5ZVe4y3w5cSrQFghVQr8fCP1o0+GnB
	 IgtiKhyE1MkZCMx5wrM6ogMdwSenCcnf4Mfzb+SdLAg5VyAcjBJo4qt7Okakj0S3yK
	 hWzN8Qcsbzhyw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B41CA0FED;
	Tue,  9 Sep 2025 06:21:34 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Tue, 09 Sep 2025 01:21:29 -0500
Subject: [PATCH v2 1/8] cpufreq: tegra186: add OPP support and set
 bandwidth
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-tegra186-icc-v2-1-09413724e781@gmail.com>
References: <20250909-tegra186-icc-v2-0-09413724e781@gmail.com>
In-Reply-To: <20250909-tegra186-icc-v2-0-09413724e781@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757398893; l=8394;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=NZJsduZw7/XAh0XqzH09l51I14O7mE+MWIT2CwMrZHU=;
 b=wpYKN2+155wE9rOglp8skrW+dF+DGagpC4ATWh1bDpEXMRmb7dscSkWfTgvLj2L3Vh4ML/2AT
 Mm/KZJxG939BhNPSmmqcslI+vKwxEurNYTC1xPXaxlqRYpyknxmKUSG
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Add support to use OPP table from DT in Tegra186 cpufreq driver.
Tegra SoC's receive the frequency lookup table (LUT) from BPMP-FW.
Cross check the OPP's present in DT against the LUT from BPMP-FW
and enable only those DT OPP's which are present in LUT also.

The OPP table in DT has CPU Frequency to bandwidth mapping where
the bandwidth value is per MC channel. DRAM bandwidth depends on the
number of MC channels which can vary as per the boot configuration.
This per channel bandwidth from OPP table will be later converted by
MC driver to final bandwidth value by multiplying with number of
channels before being handled in the EMC driver.

If OPP table is not present in DT, then use the LUT from BPMP-FW
directy as the CPU frequency table and not do the DRAM frequency
scaling which is same as the current behavior.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/cpufreq/tegra186-cpufreq.c | 152 +++++++++++++++++++++++++++++++++++--
 1 file changed, 145 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
index bd94beebc4cc2fe6870e13ca55343cedb9729e99..cb7a033e8ae6e81b18bbf3bc63632c631e99129b 100644
--- a/drivers/cpufreq/tegra186-cpufreq.c
+++ b/drivers/cpufreq/tegra186-cpufreq.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/units.h>
 
 #include <soc/tegra/bpmp.h>
 #include <soc/tegra/bpmp-abi.h>
@@ -58,7 +59,7 @@ static const struct tegra186_cpufreq_cpu tegra186_cpus[] = {
 };
 
 struct tegra186_cpufreq_cluster {
-	struct cpufreq_frequency_table *table;
+	struct cpufreq_frequency_table *bpmp_lut;
 	u32 ref_clk_khz;
 	u32 div;
 };
@@ -66,16 +67,121 @@ struct tegra186_cpufreq_cluster {
 struct tegra186_cpufreq_data {
 	void __iomem *regs;
 	const struct tegra186_cpufreq_cpu *cpus;
+	bool icc_dram_bw_scaling;
 	struct tegra186_cpufreq_cluster clusters[];
 };
 
+static int tegra_cpufreq_set_bw(struct cpufreq_policy *policy, unsigned long freq_khz)
+{
+	struct tegra186_cpufreq_data *data = cpufreq_get_driver_data();
+	struct dev_pm_opp *opp __free(put_opp);
+	struct device *dev;
+	int ret;
+
+	dev = get_cpu_device(policy->cpu);
+	if (!dev)
+		return -ENODEV;
+
+	opp = dev_pm_opp_find_freq_exact(dev, freq_khz * HZ_PER_KHZ, true);
+	if (IS_ERR(opp))
+		return PTR_ERR(opp);
+
+	ret = dev_pm_opp_set_opp(dev, opp);
+	if (ret)
+		data->icc_dram_bw_scaling = false;
+
+	return ret;
+}
+
+static int tegra_cpufreq_init_cpufreq_table(struct cpufreq_policy *policy,
+					    struct cpufreq_frequency_table *bpmp_lut,
+					    struct cpufreq_frequency_table **opp_table)
+{
+	struct tegra186_cpufreq_data *data = cpufreq_get_driver_data();
+	struct cpufreq_frequency_table *freq_table = NULL;
+	struct cpufreq_frequency_table *pos;
+	struct device *cpu_dev;
+	unsigned long rate;
+	int ret, max_opps;
+	int j = 0;
+
+	cpu_dev = get_cpu_device(policy->cpu);
+	if (!cpu_dev) {
+		pr_err("%s: failed to get cpu%d device\n", __func__, policy->cpu);
+		return -ENODEV;
+	}
+
+	/* Initialize OPP table mentioned in operating-points-v2 property in DT */
+	ret = dev_pm_opp_of_add_table_indexed(cpu_dev, 0);
+	if (ret) {
+		dev_err(cpu_dev, "Invalid or empty opp table in device tree\n");
+		data->icc_dram_bw_scaling = false;
+		return ret;
+	}
+
+	max_opps = dev_pm_opp_get_opp_count(cpu_dev);
+	if (max_opps <= 0) {
+		dev_err(cpu_dev, "Failed to add OPPs\n");
+		return max_opps;
+	}
+
+	/* Disable all opps and cross-validate against LUT later */
+	for (rate = 0; ; rate++) {
+		struct dev_pm_opp *opp __free(put_opp);
+
+		opp = dev_pm_opp_find_freq_ceil(cpu_dev, &rate);
+		if (IS_ERR(opp))
+			break;
+
+		dev_pm_opp_disable(cpu_dev, rate);
+	}
+
+	freq_table = kcalloc((max_opps + 1), sizeof(*freq_table), GFP_KERNEL);
+	if (!freq_table)
+		return -ENOMEM;
+
+	/*
+	 * Cross check the frequencies from BPMP-FW LUT against the OPP's present in DT.
+	 * Enable only those DT OPP's which are present in LUT also.
+	 */
+	cpufreq_for_each_valid_entry(pos, bpmp_lut) {
+		struct dev_pm_opp *opp __free(put_opp);
+
+		opp = dev_pm_opp_find_freq_exact(cpu_dev, pos->frequency * HZ_PER_KHZ, false);
+		if (IS_ERR(opp))
+			continue;
+
+		ret = dev_pm_opp_enable(cpu_dev, pos->frequency * HZ_PER_KHZ);
+		if (ret < 0)
+			return ret;
+
+		freq_table[j].driver_data = pos->driver_data;
+		freq_table[j].frequency = pos->frequency;
+		j++;
+	}
+
+	freq_table[j].driver_data = pos->driver_data;
+	freq_table[j].frequency = CPUFREQ_TABLE_END;
+
+	*opp_table = &freq_table[0];
+
+	dev_pm_opp_set_sharing_cpus(cpu_dev, policy->cpus);
+
+	/* Prime interconnect data */
+	tegra_cpufreq_set_bw(policy, freq_table[j - 1].frequency);
+
+	return ret;
+}
+
 static int tegra186_cpufreq_init(struct cpufreq_policy *policy)
 {
 	struct tegra186_cpufreq_data *data = cpufreq_get_driver_data();
 	unsigned int cluster = data->cpus[policy->cpu].bpmp_cluster_id;
+	struct cpufreq_frequency_table *freq_table;
+	struct cpufreq_frequency_table *bpmp_lut;
 	u32 cpu;
+	int ret;
 
-	policy->freq_table = data->clusters[cluster].table;
 	policy->cpuinfo.transition_latency = 300 * 1000;
 	policy->driver_data = NULL;
 
@@ -85,6 +191,20 @@ static int tegra186_cpufreq_init(struct cpufreq_policy *policy)
 			cpumask_set_cpu(cpu, policy->cpus);
 	}
 
+	bpmp_lut = data->clusters[cluster].bpmp_lut;
+
+	if (data->icc_dram_bw_scaling) {
+		ret = tegra_cpufreq_init_cpufreq_table(policy, bpmp_lut, &freq_table);
+		if (!ret) {
+			policy->freq_table = freq_table;
+			return 0;
+		}
+	}
+
+	data->icc_dram_bw_scaling = false;
+	policy->freq_table = bpmp_lut;
+	pr_info("OPP tables missing from DT, EMC frequency scaling disabled\n");
+
 	return 0;
 }
 
@@ -102,6 +222,10 @@ static int tegra186_cpufreq_set_target(struct cpufreq_policy *policy,
 		writel(edvd_val, data->regs + edvd_offset);
 	}
 
+	if (data->icc_dram_bw_scaling)
+		tegra_cpufreq_set_bw(policy, tbl->frequency);
+
+
 	return 0;
 }
 
@@ -136,7 +260,7 @@ static struct cpufreq_driver tegra186_cpufreq_driver = {
 	.init = tegra186_cpufreq_init,
 };
 
-static struct cpufreq_frequency_table *init_vhint_table(
+static struct cpufreq_frequency_table *tegra_cpufreq_bpmp_read_lut(
 	struct platform_device *pdev, struct tegra_bpmp *bpmp,
 	struct tegra186_cpufreq_cluster *cluster, unsigned int cluster_id,
 	int *num_rates)
@@ -231,6 +355,7 @@ static int tegra186_cpufreq_probe(struct platform_device *pdev)
 {
 	struct tegra186_cpufreq_data *data;
 	struct tegra_bpmp *bpmp;
+	struct device *cpu_dev;
 	unsigned int i = 0, err, edvd_offset;
 	int num_rates = 0;
 	u32 edvd_val, cpu;
@@ -256,9 +381,9 @@ static int tegra186_cpufreq_probe(struct platform_device *pdev)
 	for (i = 0; i < TEGRA186_NUM_CLUSTERS; i++) {
 		struct tegra186_cpufreq_cluster *cluster = &data->clusters[i];
 
-		cluster->table = init_vhint_table(pdev, bpmp, cluster, i, &num_rates);
-		if (IS_ERR(cluster->table)) {
-			err = PTR_ERR(cluster->table);
+		cluster->bpmp_lut = tegra_cpufreq_bpmp_read_lut(pdev, bpmp, cluster, i, &num_rates);
+		if (IS_ERR(cluster->bpmp_lut)) {
+			err = PTR_ERR(cluster->bpmp_lut);
 			goto put_bpmp;
 		} else if (!num_rates) {
 			err = -EINVAL;
@@ -267,7 +392,7 @@ static int tegra186_cpufreq_probe(struct platform_device *pdev)
 
 		for (cpu = 0; cpu < ARRAY_SIZE(tegra186_cpus); cpu++) {
 			if (data->cpus[cpu].bpmp_cluster_id == i) {
-				edvd_val = cluster->table[num_rates - 1].driver_data;
+				edvd_val = cluster->bpmp_lut[num_rates - 1].driver_data;
 				edvd_offset = data->cpus[cpu].edvd_offset;
 				writel(edvd_val, data->regs + edvd_offset);
 			}
@@ -276,6 +401,19 @@ static int tegra186_cpufreq_probe(struct platform_device *pdev)
 
 	tegra186_cpufreq_driver.driver_data = data;
 
+	/* Check for optional OPPv2 and interconnect paths on CPU0 to enable ICC scaling */
+	cpu_dev = get_cpu_device(0);
+	if (!cpu_dev) {
+		err = -EPROBE_DEFER;
+		goto put_bpmp;
+	}
+
+	if (dev_pm_opp_of_get_opp_desc_node(cpu_dev)) {
+		err = dev_pm_opp_of_find_icc_paths(cpu_dev, NULL);
+		if (!err)
+			data->icc_dram_bw_scaling = true;
+	}
+
 	err = cpufreq_register_driver(&tegra186_cpufreq_driver);
 
 put_bpmp:

-- 
2.50.1



