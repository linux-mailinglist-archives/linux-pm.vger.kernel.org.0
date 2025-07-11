Return-Path: <linux-pm+bounces-30698-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78729B01FFC
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 17:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BC7217345E
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 14:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140D22EAB76;
	Fri, 11 Jul 2025 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="dncZ4K9L"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5240B2EA49C;
	Fri, 11 Jul 2025 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752245896; cv=pass; b=T6sLa0jWhpw3kQn5o45p/90Rc5UTSktqr99Wek4hxmxH4NOmpa/BAPwybTTL3K00svdcRcRbPtoWaN8KGyVewiZrykKnLI77Mc67NE+cF2Yvv3Io9KXBRaGEzCQvnU4L/gOrcQpSxYxmGes1A9ActphShAHZGa4TAp7KJHdg9nE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752245896; c=relaxed/simple;
	bh=T/XZsQbQLrcIV9fFKHUv1e6mI5VjQpUWX7EjJia/LTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ltYBRpRqAJKDuvg284XLHG9mZpfo24nSSzvYBN03WGFkN19M/S1A4KvmtarBq8updavDyNX+pduE4OibV8uNvjMiIr+Mo5UguHXG+OZKKnkY4wfsyUvsg/Y0lvu0b0A9ZembKVkMNiOuFym2xVahV7mg66cxI8aBU8uFlLN/VIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=dncZ4K9L; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752245875; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Sbo7WLHYGAc49B5RUnp/nZKGY19T10UabJVAINX76rzQqrvbeqc237Ivdc2o8iTBsv6eSmGuuXKFBbbHIJSH3eujjCWEY57dOP2fpq5OtKH1hJFO1Ot1dwaBdk9DNyMUeOYrQRf7CRNPoypCq8cFM1QE47kd+zDVEjo/F050DqU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752245875; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Rl4uSsmt0R6ta2ds9zDGarKw8XggCRJaKwQecyR3iSA=; 
	b=lyWrtzxHomY1LT1lb/qyuScyIMV7gKCRPoE3c3Bx6CGpHjmvjPD0YIyWa0Zxepzx9yvjkOKGp2RTEl0Yyq3Rc1nXCD+TLExO2rnf25fssC0jUtv4yM8NI77cJzEXzp8cRLOxX2AdcMiPJArIk5ozi+BCZxDt7iAUhb+zUwQeWPc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752245875;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=Rl4uSsmt0R6ta2ds9zDGarKw8XggCRJaKwQecyR3iSA=;
	b=dncZ4K9LDZnJZA9Kb6hls19yvSMJ8g8zlHpM+d4wvBeBhxAehFfmRJIRFRrJBzbT
	JXbY8eTvgJNDmWUUUDm7hbUZMSKnQnjXNMaHI1iIIzPYDGyfvffjk8Qz3fsTsZxvclx
	p/8TpHl04CH1dmgCA9S+sLBk0E5ozS+M4pXkflkI=
Received: by mx.zohomail.com with SMTPS id 1752245874097527.3770039598888;
	Fri, 11 Jul 2025 07:57:54 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 11 Jul 2025 16:57:35 +0200
Subject: [PATCH 3/5] cpufreq: mediatek-hw: Refactor match data into struct
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-mt8196-cpufreq-v1-3-e1b0a3b4ac61@collabora.com>
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
2.50.0


