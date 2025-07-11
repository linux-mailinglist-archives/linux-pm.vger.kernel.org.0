Return-Path: <linux-pm+bounces-30700-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB25CB01FFF
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 17:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C5571890B90
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 14:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D212EACF7;
	Fri, 11 Jul 2025 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="SPa+zi99"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749602EAB9A;
	Fri, 11 Jul 2025 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752245901; cv=pass; b=dB6vNQRGPbZCxKMHZukeISF+mq3aszOut6AwQIYdPxMU5z7F2fwGTT4lI6fdgyZykfE2pWmC+mvqwBUgPVHjvtyDIqHMr4+je3aYnA6pP5HVL7CdQABGe1H9flstzNup+qxghMtyJmHPPyQQtoRNrPCSFzunTia3lqE0N4lv3v8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752245901; c=relaxed/simple;
	bh=qMclNpzGYbS+Q7USxYi/UnTZUg7gHMhWOtWCzSJYThk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F0jzjkO6JZrqNXHuuQ7qus8y3TvvhFmCPlMm2WVpne283B37surivhXt34fVWfdwbQtDBJfl0tjqcwKRTeb5MeoieDORPIv52C4fbLjH7ByvJdgVg9LdQoA7eos13kyYC33OdWYIXhNgToMIOhZtUvevlzORLW8DjkpaPKAN0es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=SPa+zi99; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752245883; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BzoeaZuSu+JRG0pFQ+xUn68OpDDvKtH+YKqA8bMHOW2fgc4hsVwy1m88p/+EEKqAi3V5roE+vslzi6X4WFspVCBGsV7r+QmHLhcQLg+qcSc37+tMjspP3MbK71OqpPOOWyk62CBjj/zpmZRuw9qytAwa/70Qe3uQV+Bk9KOgj6k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752245883; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jAwpf6q1OAFUYW1t8tkYML5f6zAM037csqTvRpDmGTU=; 
	b=eSow1R8+JV1i64Kz3PoE3U92JXsMO059EIf0pVQg3TMoeTgj4P2x1QYro6Opk/U6XjJEWmBPVAlkOlA0kWlsG/oJHuIYbY6hGtPtblevVBYBgkPaSAclF4lt+y/bFmEOTMiFstibAAzS4eG5S9I0TfWmDKGWv3zJXxRTa87ayeo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752245883;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=jAwpf6q1OAFUYW1t8tkYML5f6zAM037csqTvRpDmGTU=;
	b=SPa+zi99oU6Unbg+q6UO0emr1sdI2hzr3J/zNeRtH/p6jGavSlY6l1E0p3c0+tW4
	miDMp3nda+WdXis4P+pGaxefrbH87abt//RaAZwWZP46m96QZV//Aj6DsxPsiMEWIRn
	YI9NVge+junQ/IYbsIZ4bCad8GBb2gUd4hwXJm6A=
Received: by mx.zohomail.com with SMTPS id 175224588104259.94795638566734;
	Fri, 11 Jul 2025 07:58:01 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 11 Jul 2025 16:57:37 +0200
Subject: [PATCH 5/5] cpufreq: mediatek-hw: Add support for MT8196
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-mt8196-cpufreq-v1-5-e1b0a3b4ac61@collabora.com>
References: <20250711-mt8196-cpufreq-v1-0-e1b0a3b4ac61@collabora.com>
In-Reply-To: <20250711-mt8196-cpufreq-v1-0-e1b0a3b4ac61@collabora.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Hector Yuan <hector.yuan@mediatek.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

The MT8196 SoC uses DVFS to set a desired target frequency for each CPU
core. It also uses slightly different register offsets.

Add support for it, which necessitates acquiring some syscons as regmaps
to both check for the FDVFS magic number and to set target frequencies
for FDVFS.

I've verified with both `sysbench cpu run` and `head -c 10G \
/dev/urandom | pigz -p 8 -c - | pv -ba > /dev/null` that we don't just
get a higher reported clock frequency, but that the observed performance
also increases, by a factor of 2.64 in an 8 thread sysbench test.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/cpufreq/mediatek-cpufreq-hw.c | 78 ++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index 53611077d0d9a2d9865cf771568ab71abc0e6fbd..30cf038babb6d02a0666ed39b926f3977a164236 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -9,10 +9,12 @@
 #include <linux/init.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
@@ -24,6 +26,8 @@
 #define POLL_USEC			1000
 #define TIMEOUT_USEC			300000
 
+#define MT8196_FDVFS_MAGIC		0xABCD0001UL
+
 enum {
 	REG_FREQ_LUT_TABLE,
 	REG_FREQ_ENABLE,
@@ -36,7 +40,10 @@ enum {
 };
 
 struct mtk_cpufreq_priv {
+	struct device *dev;
 	const struct mtk_cpufreq_variant *variant;
+	struct regmap *fdvfs_config;
+	struct regmap *fdvfs;
 };
 
 struct mtk_cpufreq_domain {
@@ -49,7 +56,9 @@ struct mtk_cpufreq_domain {
 };
 
 struct mtk_cpufreq_variant {
+	int (*init)(struct mtk_cpufreq_priv *priv);
 	const u16 reg_offsets[REG_ARRAY_SIZE];
+	const unsigned int fdvfs_fdiv;
 };
 
 static const struct mtk_cpufreq_variant cpufreq_mtk_base_variant = {
@@ -63,6 +72,38 @@ static const struct mtk_cpufreq_variant cpufreq_mtk_base_variant = {
 	},
 };
 
+static int mtk_cpufreq_hw_mt8196_init(struct mtk_cpufreq_priv *priv)
+{
+	u32 val;
+
+	priv->fdvfs_config = syscon_regmap_lookup_by_compatible("mediatek,mt8196-fdvfs-config");
+	if (!priv->fdvfs_config)
+		return dev_err_probe(priv->dev, PTR_ERR(priv->fdvfs_config),
+				     "failed to get fdvfs-config syscon\n");
+
+	if (!regmap_read(priv->fdvfs_config, 0x0, &val) && val == MT8196_FDVFS_MAGIC) {
+		priv->fdvfs = syscon_regmap_lookup_by_compatible("mediatek,mt8196-fdvfs");
+		if (!priv->fdvfs)
+			return dev_err_probe(priv->dev, PTR_ERR(priv->fdvfs),
+					     "failed to get fdvfs syscon\n");
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
+};
+
 static int __maybe_unused
 mtk_cpufreq_get_cpu_power(struct device *cpu_dev, unsigned long *uW,
 			  unsigned long *KHz)
@@ -91,10 +132,34 @@ mtk_cpufreq_get_cpu_power(struct device *cpu_dev, unsigned long *uW,
 	return 0;
 }
 
+static int mtk_cpufreq_hw_fdvfs_switch(unsigned int target_freq,
+				       struct cpufreq_policy *policy)
+{
+	struct mtk_cpufreq_domain *data = policy->driver_data;
+	struct mtk_cpufreq_priv *priv = data->parent;
+	unsigned int cpu;
+	int ret;
+
+	target_freq = DIV_ROUND_UP(target_freq, priv->variant->fdvfs_fdiv);
+	for_each_cpu(cpu, policy->real_cpus) {
+		ret = regmap_write(priv->fdvfs, cpu * 4, target_freq);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int mtk_cpufreq_hw_target_index(struct cpufreq_policy *policy,
 				       unsigned int index)
 {
 	struct mtk_cpufreq_domain *data = policy->driver_data;
+	unsigned int target_freq;
+
+	if (data->parent->fdvfs) {
+		target_freq = policy->freq_table[index].frequency;
+		return mtk_cpufreq_hw_fdvfs_switch(target_freq, policy);
+	}
 
 	writel_relaxed(index, data->reg_bases[REG_FREQ_PERF_STATE]);
 
@@ -127,7 +192,10 @@ static unsigned int mtk_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
 
 	index = cpufreq_table_find_index_dl(policy, target_freq, false);
 
-	writel_relaxed(index, data->reg_bases[REG_FREQ_PERF_STATE]);
+	if (data->parent->fdvfs)
+		mtk_cpufreq_hw_fdvfs_switch(target_freq, policy);
+	else
+		writel_relaxed(index, data->reg_bases[REG_FREQ_PERF_STATE]);
 
 	return policy->freq_table[index].frequency;
 }
@@ -339,6 +407,13 @@ static int mtk_cpufreq_hw_driver_probe(struct platform_device *pdev)
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
@@ -357,6 +432,7 @@ static void mtk_cpufreq_hw_driver_remove(struct platform_device *pdev)
 
 static const struct of_device_id mtk_cpufreq_hw_match[] = {
 	{ .compatible = "mediatek,cpufreq-hw", .data = &cpufreq_mtk_base_variant },
+	{ .compatible = "mediatek,mt8196-cpufreq-hw", .data = &cpufreq_mtk_mt8196_variant },
 	{}
 };
 MODULE_DEVICE_TABLE(of, mtk_cpufreq_hw_match);

-- 
2.50.0


