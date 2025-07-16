Return-Path: <linux-pm+bounces-30938-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD71B07C59
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 19:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E006A4E0D67
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 17:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A7B288C14;
	Wed, 16 Jul 2025 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="gWiklzTT"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767C428852E;
	Wed, 16 Jul 2025 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752688319; cv=pass; b=fWLPaW1caR9rsRcbSf/23r/5lLZC65jN4TPWbf9N2b/TIWIO8Pgonvn0kUQrz4AZL7fiNPRvC240hLPZrFs+1iF0NbNLDZJB/X2zEun6cP/fxYNkAGO2ut0c30TIxRo85KGlWUQz/NgeFJrwyexVkWUvh8X1rcnOxolCCalTih4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752688319; c=relaxed/simple;
	bh=2v3neK4iFC1rT0Q8CInwOC6/+wtUhMCpMwGN7hpoG2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qBXJTubVvQaaemLjUVe877io09wvtLqnOWDAW2I09oN2D8FGxTAgkPWFXWZB0tKjl4SMPmTIQQYqIL1bN+toZcu0YSgpQ9vhcs0l7nKiOi78nuRfmVGR2EKs3EH0h9EsPqUfM8JChBr8WuzvxIIJ1wYtHyTOVNCmeE6x6d1OEjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=gWiklzTT; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752688301; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CtcKNsRyUYAYob24gMiwY9gbf6Yw6RRUQE8Znuw7AkeW8muiVXufnUKBU85GhuC/oX25AQ1oievNFc/0nA4ALDmWraISgGEH+uEyIlXezGaewsLKWgMXXqxrxbs6wyA2T47I7HIRGQI8EMr8t9ahlO8zxj5Si0hKwqOZ/ddeMvE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752688301; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FdTJy+hTnMMhv0ByE1VmAHdLgDhK3u720le2ZYwEYBw=; 
	b=IhziMyv7PyefgE9/vnV5QMwXqNr0mPA6JpzJCVd1zTKan8YkJX7lmsQuFNTV0rkBZuJXWvncY2SrRLlUuuBRiYpCoFFKF5L0uLI04qvMW7r6j9mgDKKzUtmtXG7FmTUypEKHbdLhykvoQtuo27h89SE2mTrORPZgiJFSivDoKk4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752688301;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=FdTJy+hTnMMhv0ByE1VmAHdLgDhK3u720le2ZYwEYBw=;
	b=gWiklzTT/L2buszEqg82HEr2Tvq4XxrfahjOjVz6RnRdVlAyHwqDj8nuK2KOOhEa
	pb2js1DyKcjkCm2PDx+nAG4uulqwMHhcvoLf/H2m0T9xL2z3il+sYqTC7xn3URJPZcZ
	rOYhK+xLU3rn9Zkx5VeAjIfF2zouGFJltEpSACpw=
Received: by mx.zohomail.com with SMTPS id 175268829909280.288096823606;
	Wed, 16 Jul 2025 10:51:39 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 16 Jul 2025 19:51:25 +0200
Subject: [PATCH v3 4/4] cpufreq: mediatek-hw: Add support for MT8196
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-mt8196-cpufreq-v3-4-d440fb810d7e@collabora.com>
References: <20250716-mt8196-cpufreq-v3-0-d440fb810d7e@collabora.com>
In-Reply-To: <20250716-mt8196-cpufreq-v3-0-d440fb810d7e@collabora.com>
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
acquired, as mt8196 has the fdvfs register before the performance domain
registers.

I've verified with both `sysbench cpu run` and `head -c 10G \
/dev/urandom | pigz -p 8 -c - | pv -ba > /dev/null` that we don't just
get a higher reported clock frequency, but that the observed performance
also increases, by a factor of 2.64 in an 8 thread sysbench test.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/cpufreq/mediatek-cpufreq-hw.c | 70 ++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index 53611077d0d9a2d9865cf771568ab71abc0e6fbd..e4eadce6f937ceff51b34d22da83c51b4e9aa813 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -24,6 +24,8 @@
 #define POLL_USEC			1000
 #define TIMEOUT_USEC			300000
 
+#define FDVFS_FDIV_HZ (26 * 1000)
+
 enum {
 	REG_FREQ_LUT_TABLE,
 	REG_FREQ_ENABLE,
@@ -36,7 +38,9 @@ enum {
 };
 
 struct mtk_cpufreq_priv {
+	struct device *dev;
 	const struct mtk_cpufreq_variant *variant;
+	void __iomem *fdvfs;
 };
 
 struct mtk_cpufreq_domain {
@@ -49,7 +53,9 @@ struct mtk_cpufreq_domain {
 };
 
 struct mtk_cpufreq_variant {
+	int (*init)(struct mtk_cpufreq_priv *priv);
 	const u16 reg_offsets[REG_ARRAY_SIZE];
+	const bool is_hybrid_dvfs;
 };
 
 static const struct mtk_cpufreq_variant cpufreq_mtk_base_variant = {
@@ -63,6 +69,29 @@ static const struct mtk_cpufreq_variant cpufreq_mtk_base_variant = {
 	},
 };
 
+static int mtk_cpufreq_hw_mt8196_init(struct mtk_cpufreq_priv *priv)
+{
+	priv->fdvfs = devm_of_iomap(priv->dev, priv->dev->of_node, 0, NULL);
+	if (IS_ERR_OR_NULL(priv->fdvfs))
+		return dev_err_probe(priv->dev, PTR_ERR(priv->fdvfs),
+				     "failed to get fdvfs iomem\n");
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
+	.is_hybrid_dvfs = true,
+};
+
 static int __maybe_unused
 mtk_cpufreq_get_cpu_power(struct device *cpu_dev, unsigned long *uW,
 			  unsigned long *KHz)
@@ -91,12 +120,31 @@ mtk_cpufreq_get_cpu_power(struct device *cpu_dev, unsigned long *uW,
 	return 0;
 }
 
+static void mtk_cpufreq_hw_fdvfs_switch(unsigned int target_freq,
+					struct cpufreq_policy *policy)
+{
+	struct mtk_cpufreq_domain *data = policy->driver_data;
+	struct mtk_cpufreq_priv *priv = data->parent;
+	unsigned int cpu;
+
+	target_freq = DIV_ROUND_UP(target_freq, FDVFS_FDIV_HZ);
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
@@ -127,7 +175,10 @@ static unsigned int mtk_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
 
 	index = cpufreq_table_find_index_dl(policy, target_freq, false);
 
-	writel_relaxed(index, data->reg_bases[REG_FREQ_PERF_STATE]);
+	if (data->parent->fdvfs)
+		mtk_cpufreq_hw_fdvfs_switch(target_freq, policy);
+	else
+		writel_relaxed(index, data->reg_bases[REG_FREQ_PERF_STATE]);
 
 	return policy->freq_table[index].frequency;
 }
@@ -191,6 +242,13 @@ static int mtk_cpu_resources_init(struct platform_device *pdev,
 	index = args.args[0];
 	of_node_put(args.np);
 
+	/*
+	 * In a cpufreq with hybrid DVFS, such as the MT8196, the first declared
+	 * register range is for FDVFS, followed by the frequency domain MMIOs.
+	 */
+	if (priv->variant->is_hybrid_dvfs)
+		index++;
+
 	data->parent = priv;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
@@ -339,6 +397,13 @@ static int mtk_cpufreq_hw_driver_probe(struct platform_device *pdev)
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
@@ -357,6 +422,7 @@ static void mtk_cpufreq_hw_driver_remove(struct platform_device *pdev)
 
 static const struct of_device_id mtk_cpufreq_hw_match[] = {
 	{ .compatible = "mediatek,cpufreq-hw", .data = &cpufreq_mtk_base_variant },
+	{ .compatible = "mediatek,mt8196-cpufreq-hw", .data = &cpufreq_mtk_mt8196_variant },
 	{}
 };
 MODULE_DEVICE_TABLE(of, mtk_cpufreq_hw_match);

-- 
2.50.1


