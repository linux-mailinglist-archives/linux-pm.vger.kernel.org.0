Return-Path: <linux-pm+bounces-30936-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C340B07C52
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 19:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43A7B503E13
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 17:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22592874E5;
	Wed, 16 Jul 2025 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="IMgcm7ZO"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA53286D79;
	Wed, 16 Jul 2025 17:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752688313; cv=pass; b=iLP/lx8TPmZToKRhrb/aTw533Cd/ZNYRUJDPiYimCqmuXBHwB8pZSLPMMoLzaf4nk92ZuyDbFQRvrWtJtDEcEJyBPO8EVavjgBGbdJ2GYhGtqRu0mkSkkqJeFoqxXxhyrkPWAxlNlP+yyt9UuzKhaX++I9mf0Ph66UNpGjSvSKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752688313; c=relaxed/simple;
	bh=G3Pq16KWHuxCbAF/LJJ13waONyJ/abmpxN6LFPOa1FU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X5dcMetMjQlnUY2v/Tfd1TVFKTyVHBsXl2s2DZYTQf7+6D8RAGi1xvvVxFeWACOD5VsaWGi8QcSWY7p0BoiOryMywlPfkU8ZsEOUMESRRbxq2fcE6tglisID/AGhMmit6nDh6SbuqqDakKJRRdcdWUQ9eERNf660yMUlHcOOVl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=IMgcm7ZO; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752688295; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MeXqvEeEGB8Xf2pj+MTOTQQcWskKvwobxhUK6KHJwVg72M3EtBc9fsLbxpthwr0B+L+3Ker2zkGRx8sH5r24PNd9vrgZH0uho/WHFlszFemsstGI8Fmx5VEU8Q4iPob9x3SHUrQq57smfaTZHTvyOWNEGgWheCWPUkADwZZwWPY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752688295; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CFeYngD4ucIt7AO/MWX4ZQHUevaFxkhqhnDYFChGYVQ=; 
	b=mRMFHo7UxlZfPPBKFgsYWW59IzoMgOKLC4jaHqVlL7OyGq7jeMcUrrXY+CcXluIbfGSh5VxyiSezKoW63rqIyCNJKoS9O8uo68zjYqN4B1QRFWnJmm4aoxnEZJyVkfQ8sk/OeAPhQuSlcwbvp8YlZbsRYmFvbF0GhDokL8vkAAQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752688295;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=CFeYngD4ucIt7AO/MWX4ZQHUevaFxkhqhnDYFChGYVQ=;
	b=IMgcm7ZOsOXScxrQ6/9XkrD74GRW1FQUOTR7mRTC1YlsEQnYeOaGyJ2CC7k3d8Sh
	25K7l4+8jjxcluEq736lz++Jhvhxfkzsoko9j0pAAXb3Mlc14kg5WZhLZ738v7x+Y24
	7hV0TlyK5KMwnARLmgE6BXrNQqxrl3S4plA/ApPw=
Received: by mx.zohomail.com with SMTPS id 1752688292890516.4771910859703;
	Wed, 16 Jul 2025 10:51:32 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 16 Jul 2025 19:51:23 +0200
Subject: [PATCH v3 2/4] cpufreq: mediatek-hw: Refactor match data into
 struct
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-mt8196-cpufreq-v3-2-d440fb810d7e@collabora.com>
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

While the driver could get away with having the per-compatible match
data just be an array of the reg offsets, the only thing it used it for
right now, this doesn't really allow it to be extended in any meaningful
way if some other per-variant information needs to be communicated.

In preparation of adding support for hybrid "FDVFS" for MT8196, refactor
the code to make the DT match data a struct, which currently only
contains a single member: the reg offsets. This will allow this struct
to be extended with other members for other hardware variants.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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


