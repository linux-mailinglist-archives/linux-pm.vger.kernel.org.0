Return-Path: <linux-pm+bounces-30937-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48027B07C55
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 19:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860561C25A0B
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 17:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA4E288506;
	Wed, 16 Jul 2025 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="lbMiQh6M"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B072877C6;
	Wed, 16 Jul 2025 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752688316; cv=pass; b=c5xroicEQTjEjMzeAaP2fyOjnxrTipdKgx8WdP1O9FJfKEVgNvFpiAOKuCqJp8Bp9qMtIT0ce46ABmBzIvpAdHJ/POvowQYlmwRqgaV6KwE7nmUbet/ltt67bTe/Gbo4qunNQCmQPXoHwoDrTrF5YD3P/LkzTXH/el8APvws3qA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752688316; c=relaxed/simple;
	bh=5OQkitAGg+k7nSDDrqr03IxG5f7jNWoM9K1kF964i7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=osONIEu1AC5Tn+ZYFgJX+xYx/tH/+XPEY5qEg0/di6UBlOt0Q/GHRr4Wzc39t8k7xVPzQthVvkqsXMu5+6NPKKyLZuaIz8TfATmZGtpV6K3IBZVP9aNyC4Je5eScZG6zvzPXObTZDpohJmAlBvlgBjQIcid7fCutOg8A9D7rFKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=lbMiQh6M; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752688297; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=G0ZVQLmEjkD6RWaQuiZkSKkAb2oK6LuRwgmw1OkyBpjBYMbQXylayjUrybvwSF22//ADr9L6xHGUfkAbDaxDiZhnthQojWufbcUSHfAgGvQG4klY/5dMfo30w9zj2nId4FWR4HOf7ljinlMCYoLwgnVQ+XdXJd14toxJQxr2MtA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752688297; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9RbBMJlOK/zToyiZFpQ4ckPXM32zr8GURxpNMWtjxWY=; 
	b=hczvp1EvUIT/OJbJxeXap1mi0BfQp9c+PqEQWuSAHLd3mbsdxCWmkOP+ypmuLPBuNhv3Rdsn1CgRVm+SCNhJYpoX+8UNVKU2poKG/mBFNrKdM6TKkbajJcOaktxX71Hfp5/9qFUl8O89cy5FRVk/txPXmclnVIvpXxqdgw12fQM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752688297;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=9RbBMJlOK/zToyiZFpQ4ckPXM32zr8GURxpNMWtjxWY=;
	b=lbMiQh6M6ZM8czBvvyne3yg9vXkXEzhahxJvzbJvovdoOWr/ENjbwiqNSPH3MAjU
	dZF6g9nfg/yv1cCSillA6KeIscRvp6uol/EhlJMvsPOVYSYrfmcULR0NCAlHuEmwS+C
	k1vdKXMvacQJJRDNCzpQ3HV9/Arnv3SNk9USfyxQ=
Received: by mx.zohomail.com with SMTPS id 1752688295860303.6109821929474;
	Wed, 16 Jul 2025 10:51:35 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 16 Jul 2025 19:51:24 +0200
Subject: [PATCH v3 3/4] cpufreq: mediatek-hw: Separate per-domain and
 per-instance data
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-mt8196-cpufreq-v3-3-d440fb810d7e@collabora.com>
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

As it stood, the mediatek cpufreq driver could get away with never
really having a private driver instance struct. This is because all data
was stored in the per-domain structs.

However, this complicates matters when actual per-instance data like the
variant struct is introduced. Instead of having a pointer to it for
every domain, have a pointer to a global "priv" struct that can be
extended over time, and rename the "data" struct to "domain" to
distinguish its purpose better.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/cpufreq/mediatek-cpufreq-hw.c | 42 ++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index b2aba1842226c7d24a8b9599ea62408cac9f803c..53611077d0d9a2d9865cf771568ab71abc0e6fbd 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -35,13 +35,17 @@ enum {
 	REG_ARRAY_SIZE,
 };
 
-struct mtk_cpufreq_data {
+struct mtk_cpufreq_priv {
+	const struct mtk_cpufreq_variant *variant;
+};
+
+struct mtk_cpufreq_domain {
+	struct mtk_cpufreq_priv *parent;
 	struct cpufreq_frequency_table *table;
 	void __iomem *reg_bases[REG_ARRAY_SIZE];
 	struct resource *res;
 	void __iomem *base;
 	int nr_opp;
-	const struct mtk_cpufreq_variant *variant;
 };
 
 struct mtk_cpufreq_variant {
@@ -63,7 +67,7 @@ static int __maybe_unused
 mtk_cpufreq_get_cpu_power(struct device *cpu_dev, unsigned long *uW,
 			  unsigned long *KHz)
 {
-	struct mtk_cpufreq_data *data;
+	struct mtk_cpufreq_domain *data;
 	struct cpufreq_policy *policy;
 	int i;
 
@@ -90,7 +94,7 @@ mtk_cpufreq_get_cpu_power(struct device *cpu_dev, unsigned long *uW,
 static int mtk_cpufreq_hw_target_index(struct cpufreq_policy *policy,
 				       unsigned int index)
 {
-	struct mtk_cpufreq_data *data = policy->driver_data;
+	struct mtk_cpufreq_domain *data = policy->driver_data;
 
 	writel_relaxed(index, data->reg_bases[REG_FREQ_PERF_STATE]);
 
@@ -99,7 +103,7 @@ static int mtk_cpufreq_hw_target_index(struct cpufreq_policy *policy,
 
 static unsigned int mtk_cpufreq_hw_get(unsigned int cpu)
 {
-	struct mtk_cpufreq_data *data;
+	struct mtk_cpufreq_domain *data;
 	struct cpufreq_policy *policy;
 	unsigned int index;
 
@@ -118,7 +122,7 @@ static unsigned int mtk_cpufreq_hw_get(unsigned int cpu)
 static unsigned int mtk_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
 					       unsigned int target_freq)
 {
-	struct mtk_cpufreq_data *data = policy->driver_data;
+	struct mtk_cpufreq_domain *data = policy->driver_data;
 	unsigned int index;
 
 	index = cpufreq_table_find_index_dl(policy, target_freq, false);
@@ -129,7 +133,7 @@ static unsigned int mtk_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
 }
 
 static int mtk_cpu_create_freq_table(struct platform_device *pdev,
-				     struct mtk_cpufreq_data *data)
+				     struct mtk_cpufreq_domain *data)
 {
 	struct device *dev = &pdev->dev;
 	u32 temp, i, freq, prev_freq = 0;
@@ -164,9 +168,9 @@ static int mtk_cpu_create_freq_table(struct platform_device *pdev,
 
 static int mtk_cpu_resources_init(struct platform_device *pdev,
 				  struct cpufreq_policy *policy,
-				  const struct mtk_cpufreq_variant *variant)
+				  struct mtk_cpufreq_priv *priv)
 {
-	struct mtk_cpufreq_data *data;
+	struct mtk_cpufreq_domain *data;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
 	struct of_phandle_args args;
@@ -187,6 +191,8 @@ static int mtk_cpu_resources_init(struct platform_device *pdev,
 	index = args.args[0];
 	of_node_put(args.np);
 
+	data->parent = priv;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
 	if (!res) {
 		dev_err(dev, "failed to get mem resource %d\n", index);
@@ -207,10 +213,9 @@ static int mtk_cpu_resources_init(struct platform_device *pdev,
 
 	data->base = base;
 	data->res = res;
-	data->variant = variant;
 
 	for (i = REG_FREQ_LUT_TABLE; i < REG_ARRAY_SIZE; i++)
-		data->reg_bases[i] = base + variant->reg_offsets[i];
+		data->reg_bases[i] = base + priv->variant->reg_offsets[i];
 
 	ret = mtk_cpu_create_freq_table(pdev, data);
 	if (ret) {
@@ -231,7 +236,7 @@ static int mtk_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 {
 	struct platform_device *pdev = cpufreq_get_driver_data();
 	int sig, pwr_hw = CPUFREQ_HW_STATUS | SVS_HW_STATUS;
-	struct mtk_cpufreq_data *data;
+	struct mtk_cpufreq_domain *data;
 	unsigned int latency;
 	int ret;
 
@@ -270,7 +275,7 @@ static int mtk_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 
 static void mtk_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
 {
-	struct mtk_cpufreq_data *data = policy->driver_data;
+	struct mtk_cpufreq_domain *data = policy->driver_data;
 	struct resource *res = data->res;
 	void __iomem *base = data->base;
 
@@ -283,7 +288,7 @@ static void mtk_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
 static void mtk_cpufreq_register_em(struct cpufreq_policy *policy)
 {
 	struct em_data_callback em_cb = EM_DATA_CB(mtk_cpufreq_get_cpu_power);
-	struct mtk_cpufreq_data *data = policy->driver_data;
+	struct mtk_cpufreq_domain *data = policy->driver_data;
 
 	em_dev_register_perf_domain(get_cpu_device(policy->cpu), data->nr_opp,
 				    &em_cb, policy->cpus, true);
@@ -305,6 +310,7 @@ static struct cpufreq_driver cpufreq_mtk_hw_driver = {
 
 static int mtk_cpufreq_hw_driver_probe(struct platform_device *pdev)
 {
+	struct mtk_cpufreq_priv *priv;
 	const void *data;
 	int ret, cpu;
 	struct device *cpu_dev;
@@ -328,7 +334,13 @@ static int mtk_cpufreq_hw_driver_probe(struct platform_device *pdev)
 	if (!data)
 		return -EINVAL;
 
-	platform_set_drvdata(pdev, (void *) data);
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->variant = data;
+
+	platform_set_drvdata(pdev, priv);
 	cpufreq_mtk_hw_driver.driver_data = pdev;
 
 	ret = cpufreq_register_driver(&cpufreq_mtk_hw_driver);

-- 
2.50.1


