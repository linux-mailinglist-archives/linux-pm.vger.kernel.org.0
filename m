Return-Path: <linux-pm+bounces-30801-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E0DB0410B
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 16:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBC131721B2
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 14:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89162571AC;
	Mon, 14 Jul 2025 14:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="J3yoWZvM"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0100256C73;
	Mon, 14 Jul 2025 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502145; cv=pass; b=sKvI5/Jw6MbDqcx4OL+EhuIQwNtaAZfLRhaYKDj7u9otKKeQ+vWm0pKoWIA9dZ2zYjKXESkscs6mj5EMGcjiqDtXGSn7ft51jlJ8xImydqunAmJva2tIVvuRbPV1xKhgQTBPKYCfd8rJfkrNSv30Cp2ViKbVeScovbTU7DkZ5H8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502145; c=relaxed/simple;
	bh=iiE856a8qrn9eSAZP9zr22J4JnHQvG6Myo0VZp/y/FA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f2gNg2X2i+OFDnzE/Pq7TCBko8kxUUcvo1p+d+TbXrIhZq7EB2iGhRXK16ZHGBJJ16HFATvEXSBCiL9wJYgHV2EVskCmQKw7QGpfLznyklhsIDeeLnbeF2h+gscO+uHHvT0VvioMU/uXF/9LvL7sk3LInHSp8EMLUmyXvIH6Fo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=J3yoWZvM; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752502119; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=P8UDvgsVwVciUQt96dTQIa29Smi8epcHkilTE2jhIgd25ttH4jxGxPNoo13IiFXfyBA/N3vcvjoopzouIj4G8Ren6bSpvtsQfm61MBPg/v86KAVYD8rapcbrTi2/kkkxbm6OS0Se2RqUMwzb5jNhrQYtfZDwpkWrUw9+ae8uAcI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752502119; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zwvjge2GeqaMg396NhQCN7JdiOQJJjUcM4eCQwiwFj0=; 
	b=Q3bGZySeLOjOLGbTE28edXMK/4B1OWTFsS6Rta9+IGG+mevcQDAEjnjJ7RggU3CAnI9oRVs/WItK/boZdd3K6Ojcq3coYcZoHzgis1sUBjH6nV3N1Hrp13rM9thy+D7zWS4xnx328vLPfFpI77NetCi5H8n/gtgFMgObaEnkkbY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752502119;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=zwvjge2GeqaMg396NhQCN7JdiOQJJjUcM4eCQwiwFj0=;
	b=J3yoWZvM9Jb01k3qPIHdkpDSGi1HcXftJdv58jzN7Dy2B2xViu4dNzDrbt0aDNnT
	wlAEaVrvrJzGBk4UrK3EbJOtXDKTiqv2Lk7wczEEvay2HN6JdTDf4cjz+63KcGwhfXM
	Y4BVqMxykVj1u9yYaKqYay79QxhRa7R+6SF+fQyE=
Received: by mx.zohomail.com with SMTPS id 1752502117056801.62164174365;
	Mon, 14 Jul 2025 07:08:37 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 14 Jul 2025 16:08:15 +0200
Subject: [PATCH v2 2/4] cpufreq: mediatek-hw: Refactor match data into
 struct
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-mt8196-cpufreq-v2-2-cc85e78855c7@collabora.com>
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

While the driver could get away with having the per-compatible match
data just be an array of the reg offsets, the only thing it used it for
right now, this doesn't really allow it to be extended in any meaningful
way if some other per-variant information needs to be communicated.

Refactor the code to make the DT match data a struct, which currently
only contains a single member: the reg offsets. This will allow this
struct to be extended with other members for other hardware variants.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/cpufreq/mediatek-cpufreq-hw.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index 74f1b4c796e4cc9ebccf50dd4e165a1eba03136a..b2aba1842226c7d24a8b9599ea62408cac9f803c 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -41,15 +41,22 @@ struct mtk_cpufreq_data {
 	struct resource *res;
 	void __iomem *base;
 	int nr_opp;
+	const struct mtk_cpufreq_variant *variant;
 };
 
-static const u16 cpufreq_mtk_offsets[REG_ARRAY_SIZE] = {
-	[REG_FREQ_LUT_TABLE]	= 0x0,
-	[REG_FREQ_ENABLE]	= 0x84,
-	[REG_FREQ_PERF_STATE]	= 0x88,
-	[REG_FREQ_HW_STATE]	= 0x8c,
-	[REG_EM_POWER_TBL]	= 0x90,
-	[REG_FREQ_LATENCY]	= 0x110,
+struct mtk_cpufreq_variant {
+	const u16 reg_offsets[REG_ARRAY_SIZE];
+};
+
+static const struct mtk_cpufreq_variant cpufreq_mtk_base_variant = {
+	.reg_offsets = {
+		[REG_FREQ_LUT_TABLE]	= 0x0,
+		[REG_FREQ_ENABLE]	= 0x84,
+		[REG_FREQ_PERF_STATE]	= 0x88,
+		[REG_FREQ_HW_STATE]	= 0x8c,
+		[REG_EM_POWER_TBL]	= 0x90,
+		[REG_FREQ_LATENCY]	= 0x110,
+	},
 };
 
 static int __maybe_unused
@@ -157,7 +164,7 @@ static int mtk_cpu_create_freq_table(struct platform_device *pdev,
 
 static int mtk_cpu_resources_init(struct platform_device *pdev,
 				  struct cpufreq_policy *policy,
-				  const u16 *offsets)
+				  const struct mtk_cpufreq_variant *variant)
 {
 	struct mtk_cpufreq_data *data;
 	struct device *dev = &pdev->dev;
@@ -200,9 +207,10 @@ static int mtk_cpu_resources_init(struct platform_device *pdev,
 
 	data->base = base;
 	data->res = res;
+	data->variant = variant;
 
 	for (i = REG_FREQ_LUT_TABLE; i < REG_ARRAY_SIZE; i++)
-		data->reg_bases[i] = base + offsets[i];
+		data->reg_bases[i] = base + variant->reg_offsets[i];
 
 	ret = mtk_cpu_create_freq_table(pdev, data);
 	if (ret) {
@@ -336,7 +344,7 @@ static void mtk_cpufreq_hw_driver_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id mtk_cpufreq_hw_match[] = {
-	{ .compatible = "mediatek,cpufreq-hw", .data = &cpufreq_mtk_offsets },
+	{ .compatible = "mediatek,cpufreq-hw", .data = &cpufreq_mtk_base_variant },
 	{}
 };
 MODULE_DEVICE_TABLE(of, mtk_cpufreq_hw_match);

-- 
2.50.1


