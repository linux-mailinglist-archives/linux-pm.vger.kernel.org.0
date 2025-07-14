Return-Path: <linux-pm+bounces-30803-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C4EB04110
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 16:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C56C1898924
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 14:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000F0255F3C;
	Mon, 14 Jul 2025 14:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="alwJWvB3"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15152255F24;
	Mon, 14 Jul 2025 14:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502149; cv=pass; b=hGF3mUWkSda8o2tY3QmB7H4/wx0NhjpAot7nRi1EKLy3ueM/Qj/NIlRfTYp4jVtLZtE3vLaal1ftmsQqTBwgspXWMXdIeV6mgPUcx9zp2jzFmDRR6hr9pZcpDzwhEEBbwuZY3phSKD6Ssba0RV2B/Prhg0vNkAcFStTjD7gACho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502149; c=relaxed/simple;
	bh=nhkuw18hHnTBS0LfnX5V2oCgCQ8MK3eUg/O46/Tmjfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uqmUE3EoBuXRVuYAx2W0tML223VYJYLungSa9Qk0uUwd9NiePxSaAzhev3T4Dwbrc4vK32abbTZdY+oyhPrvhZOBUl0K1e06ynW0dgJ9ZXvXRYWWMzNEIeInS0ZhH9I+8AynlmX3tTrUUUqoUcdbCNYbQXzy82ZZnHQUPMLtAtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=alwJWvB3; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752502127; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ORFqVihe5f5SSjorHR3QpRCpIff9qeAwgdKFoWmmO/U6LoQomf6QtkQjfmZN8q/9CPMMCHHNdophZmxdc9k2dFMlvz+HK9NmMCMhlQpibRU1ZPa9CwschtW+2FbXh2CyxoCdjyxM9tjhLiywM6ZOVxW18yng038OuUe+cVkMhmw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752502127; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GhgqMkvJ2gEVmIAD+4huwT8GCQ2yDInP6e75xTIEBvc=; 
	b=NV35unbIdVUBCUlXeWlUZT5Qr7I1T2jqE7f8WIcP+rIjwI2OP8PeVmTEA0icQPGjilVSp9U00n86gPshAmhVii7I22XLO94xmD+KQgixuZQHeVQQh+eMc3CUvjymNRnteYtnKultYQfixFU3AKF16U1GO76I2SxGUeYAYxUuyZI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752502127;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=GhgqMkvJ2gEVmIAD+4huwT8GCQ2yDInP6e75xTIEBvc=;
	b=alwJWvB3176m0cyaFtVNUB0GuVSjylv2ojd3Z5XYDNnBMcAMFkSxaOOBjIy0SbWJ
	zeE/hx+G4FVZ3CxlhQbVioYRS/55Pi5Nt/eWMsgLfL/k1hX1r0v92E+xG+cFf2BABi4
	oxNJ3VAnOaL+xDMh/gUhpyX5U+z//VxH8qCLCDJc=
Received: by mx.zohomail.com with SMTPS id 1752502125478993.0818009950015;
	Mon, 14 Jul 2025 07:08:45 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 14 Jul 2025 16:08:17 +0200
Subject: [PATCH v2 4/4] cpufreq: mediatek-hw: Add support for MT8196
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-mt8196-cpufreq-v2-4-cc85e78855c7@collabora.com>
References: <20250714-mt8196-cpufreq-v2-0-cc85e78855c7@collabora.com>
In-Reply-To: <20250714-mt8196-cpufreq-v2-0-cc85e78855c7@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

The MT8196 SoC uses DVFS to set a desired target frequency for each CPU
core. It also uses slightly different register offsets.

Add support for it, which necessitates reworking how the mmio regs are
acquired, as mt8196 has the fdvfs config register and the fdvfs
registers as two reg items before the performance domains.

I've verified with both `sysbench cpu run` and `head -c 10G \
/dev/urandom | pigz -p 8 -c - | pv -ba > /dev/null` that we don't just
get a higher reported clock frequency, but that the observed performance
also increases, by a factor of 2.64 in an 8 thread sysbench test.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/cpufreq/mediatek-cpufreq-hw.c | 75 +++++++++++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index 53611077d0d9a2d9865cf771568ab71abc0e6fbd..de6b2b8f6600f23148a7a24cafeae339903ba119 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -24,6 +24,8 @@
 #define POLL_USEC			1000
 #define TIMEOUT_USEC			300000
 
+#define MT8196_FDVFS_MAGIC		0xABCD0001UL
+
 enum {
 	REG_FREQ_LUT_TABLE,
 	REG_FREQ_ENABLE,
@@ -36,7 +38,10 @@ enum {
 };
 
 struct mtk_cpufreq_priv {
+	struct device *dev;
 	const struct mtk_cpufreq_variant *variant;
+	void __iomem *fdvfs_config;
+	void __iomem *fdvfs;
 };
 
 struct mtk_cpufreq_domain {
@@ -49,7 +54,10 @@ struct mtk_cpufreq_domain {
 };
 
 struct mtk_cpufreq_variant {
+	int (*init)(struct mtk_cpufreq_priv *priv);
 	const u16 reg_offsets[REG_ARRAY_SIZE];
+	const unsigned int fdvfs_fdiv;
+	const unsigned int domain_offset;
 };
 
 static const struct mtk_cpufreq_variant cpufreq_mtk_base_variant = {
@@ -63,6 +71,37 @@ static const struct mtk_cpufreq_variant cpufreq_mtk_base_variant = {
 	},
 };
 
+static int mtk_cpufreq_hw_mt8196_init(struct mtk_cpufreq_priv *priv)
+{
+	priv->fdvfs_config = devm_of_iomap(priv->dev, priv->dev->of_node, 0, NULL);
+	if (IS_ERR_OR_NULL(priv->fdvfs_config))
+		return dev_err_probe(priv->dev, PTR_ERR(priv->fdvfs_config),
+				     "failed to get fdvfs-config iomem\n");
+
+	if (readl_relaxed(priv->fdvfs_config) == MT8196_FDVFS_MAGIC) {
+		priv->fdvfs = devm_of_iomap(priv->dev, priv->dev->of_node, 1, NULL);
+		if (IS_ERR_OR_NULL(priv->fdvfs))
+			return dev_err_probe(priv->dev, PTR_ERR(priv->fdvfs),
+					     "failed to get fdvfs iomem\n");
+	}
+
+	return 0;
+}
+
+static const struct mtk_cpufreq_variant cpufreq_mtk_mt8196_variant = {
+	.init = mtk_cpufreq_hw_mt8196_init,
+	.reg_offsets = {
+		[REG_FREQ_LUT_TABLE]	= 0x0,
+		[REG_FREQ_ENABLE]	= 0x84,
+		[REG_FREQ_PERF_STATE]	= 0x88,
+		[REG_FREQ_HW_STATE]	= 0x8c,
+		[REG_EM_POWER_TBL]	= 0x90,
+		[REG_FREQ_LATENCY]	= 0x114,
+	},
+	.fdvfs_fdiv = 26000,
+	.domain_offset = 2,
+};
+
 static int __maybe_unused
 mtk_cpufreq_get_cpu_power(struct device *cpu_dev, unsigned long *uW,
 			  unsigned long *KHz)
@@ -91,12 +130,31 @@ mtk_cpufreq_get_cpu_power(struct device *cpu_dev, unsigned long *uW,
 	return 0;
 }
 
+static void mtk_cpufreq_hw_fdvfs_switch(unsigned int target_freq,
+				       struct cpufreq_policy *policy)
+{
+	struct mtk_cpufreq_domain *data = policy->driver_data;
+	struct mtk_cpufreq_priv *priv = data->parent;
+	unsigned int cpu;
+
+	target_freq = DIV_ROUND_UP(target_freq, priv->variant->fdvfs_fdiv);
+	for_each_cpu(cpu, policy->real_cpus) {
+		writel_relaxed(target_freq, priv->fdvfs + cpu * 4);
+	}
+}
+
 static int mtk_cpufreq_hw_target_index(struct cpufreq_policy *policy,
 				       unsigned int index)
 {
 	struct mtk_cpufreq_domain *data = policy->driver_data;
+	unsigned int target_freq;
 
-	writel_relaxed(index, data->reg_bases[REG_FREQ_PERF_STATE]);
+	if (data->parent->fdvfs) {
+		target_freq = policy->freq_table[index].frequency;
+		mtk_cpufreq_hw_fdvfs_switch(target_freq, policy);
+	} else {
+		writel_relaxed(index, data->reg_bases[REG_FREQ_PERF_STATE]);
+	}
 
 	return 0;
 }
@@ -127,7 +185,10 @@ static unsigned int mtk_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
 
 	index = cpufreq_table_find_index_dl(policy, target_freq, false);
 
-	writel_relaxed(index, data->reg_bases[REG_FREQ_PERF_STATE]);
+	if (data->parent->fdvfs)
+		mtk_cpufreq_hw_fdvfs_switch(target_freq, policy);
+	else
+		writel_relaxed(index, data->reg_bases[REG_FREQ_PERF_STATE]);
 
 	return policy->freq_table[index].frequency;
 }
@@ -188,7 +249,7 @@ static int mtk_cpu_resources_init(struct platform_device *pdev,
 	if (ret < 0)
 		return ret;
 
-	index = args.args[0];
+	index = args.args[0] + priv->variant->domain_offset;
 	of_node_put(args.np);
 
 	data->parent = priv;
@@ -339,6 +400,13 @@ static int mtk_cpufreq_hw_driver_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv->variant = data;
+	priv->dev = &pdev->dev;
+
+	if (priv->variant->init) {
+		ret = priv->variant->init(priv);
+		if (ret)
+			return ret;
+	}
 
 	platform_set_drvdata(pdev, priv);
 	cpufreq_mtk_hw_driver.driver_data = pdev;
@@ -357,6 +425,7 @@ static void mtk_cpufreq_hw_driver_remove(struct platform_device *pdev)
 
 static const struct of_device_id mtk_cpufreq_hw_match[] = {
 	{ .compatible = "mediatek,cpufreq-hw", .data = &cpufreq_mtk_base_variant },
+	{ .compatible = "mediatek,mt8196-cpufreq-hw", .data = &cpufreq_mtk_mt8196_variant },
 	{}
 };
 MODULE_DEVICE_TABLE(of, mtk_cpufreq_hw_match);

-- 
2.50.1


