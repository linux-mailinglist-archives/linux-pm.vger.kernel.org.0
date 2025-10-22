Return-Path: <linux-pm+bounces-36613-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01964BF9907
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 03:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC6DE19A6465
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 01:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3841DE4E1;
	Wed, 22 Oct 2025 01:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsAAb13T"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22DD51022;
	Wed, 22 Oct 2025 01:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761095339; cv=none; b=aqT0e9E/3ra0NOIAbQyd7lVjuk7/7fS9fkNl8FBq5t4jz0vdwuICXnbveW+21+6XyHEcGsWBewcxFtgt3srhHJdJGBBfMqq1hlK4mNFuiImX/MZ453DonOcFGd9UWoYqxht9a6AK5CHlVtrjWbuDTt90z+jamTh0EhtUi3zpuoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761095339; c=relaxed/simple;
	bh=J0BFvJJP+aTm1jmbwbefTGBfY2KC/lHx29BncuTHw6A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ohsYy2L5OdG2N/l5YiMgszcH2mHy1d2Djj0blD9xzlrVgxwJ40APbEkb/LNhi5Mn0oGPKFV9KvgAc0xPAkA01MS5fyXWtxo9uGUKPDcv3Muxotn9g+JDxSIM1jfgKFGk1yf64sC9+hCPKO8LLs1mZMVuWS+ELkAJaDhkdcfcTvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tsAAb13T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09377C4CEF1;
	Wed, 22 Oct 2025 01:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761095338;
	bh=J0BFvJJP+aTm1jmbwbefTGBfY2KC/lHx29BncuTHw6A=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=tsAAb13Tqf7xInQexpZ0U+Egw+H/oenweqK3q4oShqzlgx8Zu8V5tJZsGhLtBmlex
	 7qxiXl8RlAF6UlDpuLfd0qS7f2PMwd+JQjmVskOyrN7IyalMlN7y8opcLaGM67OX13
	 shZt0PpTUb77uP5h5jPhBnvLQ/v1TEk2Vc4KY81ZFvRW24GZopvSYefqCnWdx1Mil/
	 j/U6tQ+/yw1YtC/Eo14fRMjawk6dZLg5y1agxCAgNkNgNMYmz+9d4zlS8v6eKE+DeQ
	 Q+q9oauGU2/AKPYHbqzHU1FB9JW09e4yh7nE7tQnr1n1iSy6v4zN3NZXnL9PZF1h2R
	 3fVRfPTe8Edww==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99DECCD1AF;
	Wed, 22 Oct 2025 01:08:57 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Tue, 21 Oct 2025 20:08:36 -0500
Subject: [PATCH v3] cpufreq: tegra186: add OPP support and set bandwidth
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-tegra186-icc-p1-v3-1-7e6db3b070c4@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJMu+GgC/3WNywqDMBBFf0Vm3SmZaES66n8UFzKZ6kB9kEhok
 fx7U/ddngP33AOiBJUIt+qAIEmjrkuB+lIBT8MyCqovDNZYR8YS7jKGgboWlRk3wq5xTlryjas
 9lNUW5Knvs/joC08a9zV8zoNEP/u/lQgJje9EvDhmZ+7jPOjryusMfc75C7vDOR6uAAAA
X-Change-ID: 20251021-tegra186-icc-p1-8455e61d453d
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761095337; l=8972;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=S1v1h669mNaikq9IaG/GwbWV/RhBYWkR1lb/b9m9HfE=;
 b=suTUluNoiw1PqMYvHig+n4rIsv6b7vC9P4YjZKbEO8GLSNKE3YGtXNHb8Qfxh95qhKEa2XfCW
 tBH1cQumWyyBmYC587fy2KFq6MArvurg/BW5UEFEBkQ73yReVP41XOe
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
Changes in v3:
- Split series
- Fix potential free of an uninitialized pointer
- Link to v2: https://lore.kernel.org/r/20250909-tegra186-icc-v2-0-09413724e781@gmail.com

Changes in v2:
- Use opp scoped free in patch 3
- Cleanup as requested in patch 3
- Move patch 3 to the start of the series to keep subsystems grouped
- Link to v1: https://lore.kernel.org/r/20250831-tegra186-icc-v1-0-607ddc53b507@gmail.com
---
 drivers/cpufreq/tegra186-cpufreq.c | 152 +++++++++++++++++++++++++++++++++++--
 1 file changed, 145 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
index 136ab102f636aa57741639ed1909d095881c14d3..35f1c1371f6a1688c35f3ba012b9f008fba83d74 100644
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
+	struct device *dev;
+	int ret;
+
+	dev = get_cpu_device(policy->cpu);
+	if (!dev)
+		return -ENODEV;
+
+	struct dev_pm_opp *opp __free(put_opp) =
+		dev_pm_opp_find_freq_exact(dev, freq_khz * HZ_PER_KHZ, true);
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
 
@@ -134,7 +258,7 @@ static struct cpufreq_driver tegra186_cpufreq_driver = {
 	.init = tegra186_cpufreq_init,
 };
 
-static struct cpufreq_frequency_table *init_vhint_table(
+static struct cpufreq_frequency_table *tegra_cpufreq_bpmp_read_lut(
 	struct platform_device *pdev, struct tegra_bpmp *bpmp,
 	struct tegra186_cpufreq_cluster *cluster, unsigned int cluster_id,
 	int *num_rates)
@@ -229,6 +353,7 @@ static int tegra186_cpufreq_probe(struct platform_device *pdev)
 {
 	struct tegra186_cpufreq_data *data;
 	struct tegra_bpmp *bpmp;
+	struct device *cpu_dev;
 	unsigned int i = 0, err, edvd_offset;
 	int num_rates = 0;
 	u32 edvd_val, cpu;
@@ -254,9 +379,9 @@ static int tegra186_cpufreq_probe(struct platform_device *pdev)
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
@@ -265,7 +390,7 @@ static int tegra186_cpufreq_probe(struct platform_device *pdev)
 
 		for (cpu = 0; cpu < ARRAY_SIZE(tegra186_cpus); cpu++) {
 			if (data->cpus[cpu].bpmp_cluster_id == i) {
-				edvd_val = cluster->table[num_rates - 1].driver_data;
+				edvd_val = cluster->bpmp_lut[num_rates - 1].driver_data;
 				edvd_offset = data->cpus[cpu].edvd_offset;
 				writel(edvd_val, data->regs + edvd_offset);
 			}
@@ -274,6 +399,19 @@ static int tegra186_cpufreq_probe(struct platform_device *pdev)
 
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

---
base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
change-id: 20251021-tegra186-icc-p1-8455e61d453d

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>



