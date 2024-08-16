Return-Path: <linux-pm+bounces-12342-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DDE954719
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 12:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3943C28823D
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 10:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A752B1AAE07;
	Fri, 16 Aug 2024 10:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h+Oo44s1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1302E19E7E9
	for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 10:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805694; cv=none; b=hlUtmK7gwySEsrS4NOGza1ec1eUh8UoeDaqkXExASXn36YJxM2TuVZol2IKx09b7j4NVgcNAPT4HvEA6aONT0kYMK7zq/aOyMcFsSp4MAPOQqASoqCCFtvapSpAHE2k9OC7gwkhEuycjfVDbX3cdfdvgFxAsWImL7/U1Sf3IsVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805694; c=relaxed/simple;
	bh=vlPrg74sTTRgZv6b3DWpJX4RlTR0m5zTMsyPufQEkhM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QAV7iFkx6K6EVyqnKejNq0GVQXEXg3k4MHhmnzVy/fH/DZlwYz1fPFEtFnHYNeLul0eUWldCy7LOjUAiLk9i9rtDVggc9jUzU7XogVg5vBSznrW8ColzEtCd9WBBfS924ueiFUo0Bz0t2+EVt3tuiTjj5zIdtK2OOyb7BbN/frY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h+Oo44s1; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-530e2235688so2002617e87.3
        for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 03:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723805690; x=1724410490; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vjjz5PQxtXSt4zeT/RkSGh8NQkwY8peMKp36Eteyrx8=;
        b=h+Oo44s1QEpiOLR4SBspq+Nr9rzqshpkzRZ3GINcc956t0HTD22WDPkKpftLsI+384
         KVN7z1YryNU9IReRxrQ6xLKPbEGvuKmwrhUdSppeprTM1SuU0nfCPb6UGOmZLMWsIcDd
         qnyBvqjoF0TD2f3vS4E64UCN9XbObh+hm7lAt33gUvWTUOBNnYBcy+DRtcpfd0rRdrCX
         ICqxA5N3v+MytIUQ/nDW3dhZs8N2kL1M0MlhO8X/7ZVVrF3UQboxyO8X+2IvEZR7BqM4
         nmfv8nNXpDgJH6H82AUhKCqbf7qbWsT263E/8Zf54Kf4YMnLX7U3iZvNAZ4wvlZem7gu
         hh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723805690; x=1724410490;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vjjz5PQxtXSt4zeT/RkSGh8NQkwY8peMKp36Eteyrx8=;
        b=ZVHFJnvERiD8pjGb4n8X5x0NKdB2p7jwViceJQKRGWQwFaqe1KT92kMXe/EPLGQRC7
         SDxjTxmhkBft54/6gdhRZWPuhGQKmteWcNUiZ0iqfRYO7cLc/+zmBNLLGOkUhcmHjQu8
         JL5/NI3YJdBJz84NgzCWBGQZ7JQh0TLIRL4T1K6RkExluVPr7OKwCGNSwVocs5hqJ9od
         nF9/9KyFPNpeZQa4bvFiKX/4O1JZOlUzw8/IKHJZEzyfSQ3PA3gbMJAAEpH2yHLKS8i2
         1ExMQRnNrodYx30f14bQkAG0a+TREtbxPKLyUdhBjkDb2vhEnIB6hj5ubuwp2LVUdtjJ
         OQyA==
X-Forwarded-Encrypted: i=1; AJvYcCUNMH0ON9HHDvqLrx9/l0Q0icF5E0PmRsIdXyU7uBd9XVGVc/FddgYekcYag0q9I7ZCkA8fKEvfOw+ihRgArFTG4nN8Pe1hR2c=
X-Gm-Message-State: AOJu0YxdbCcZCi3AEu+ZfEnX1tp3xe2bZ7DHwyU8AyKESR8KIdChBLdJ
	+p+/7WF5CiH5lUjUr16NjRPBP3mI+J3Y5H1LSbGUsYvmtspz8Adu2k4oJy2cFL8=
X-Google-Smtp-Source: AGHT+IF98iCU21qh48ym9eALe83DFj+NaqQe0ww3kus6+d1nOigexYI9Bj36AT3UON4kRaajmBPYkA==
X-Received: by 2002:a05:6512:b10:b0:52c:859c:91dd with SMTP id 2adb3069b0e04-5331c69592dmr1563994e87.5.1723805689671;
        Fri, 16 Aug 2024 03:54:49 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed7945cesm19461935e9.40.2024.08.16.03.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 03:54:49 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 16 Aug 2024 12:54:27 +0200
Subject: [PATCH v2 03/13] memory: samsung: exynos5422-dmc: simplify
 dmc->dev usage
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-cleanup-h-of-node-put-memory-v2-3-9eed0ee16b78@linaro.org>
References: <20240816-cleanup-h-of-node-put-memory-v2-0-9eed0ee16b78@linaro.org>
In-Reply-To: <20240816-cleanup-h-of-node-put-memory-v2-0-9eed0ee16b78@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Lukasz Luba <lukasz.luba@arm.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6832;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=vlPrg74sTTRgZv6b3DWpJX4RlTR0m5zTMsyPufQEkhM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmvy/psDysJ5IZQg/Exa9zRiD8qS7v1C4oWjmAa
 +iF22nhqXyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZr8v6QAKCRDBN2bmhouD
 19SRD/9Hhb+f4qcsW1fTUSeFE2GDuq4WG6xHi1qC4sA05BAgtLQw9EEnWYmjsx1rBvDZPVfUNKG
 X/SKAfHMcVSkpntMyL+q7y3b28SBYUAkR/eGFOXcgaR2yEvn/R0A4uVgSfWQeYhlv1IZVssV4BL
 P3utZVIRzMiF6bFcOdbDNnLBI8ROVgxm6d7Q4Dj9tySZU8efIMiT9UvMAlVUjd9NtZy5dGcdSgS
 NSPvTNVXiTv2Zern8yNwUPlbogkf/qvH9qZj1oA68fS7Eh0n18grGuxS2eOAvxhsrQ5aWiO1ITk
 Va0MrmaBq0d1KoRyu3WAwXSESmwNr+rKFT+S9Zf9xiWho8o3tumEi+eqdnpOPKn8PA3TLfRJqVo
 TD5rZwqPvYaYAlhafcbh5Vd5ZXsUXhHA9hUeNPaYWuRHZFo++Kwqkk32ZE0WliNX42nBWIt1wrJ
 5UI0O3CT93wzQyoE7ZL4KSw+/xgvOs0+JkS68qR6zw3L+6ikGKUP5XT2mHZiZjfUc53IjHg1QjZ
 kzE8x9RiROA0xwLhEOgmuzmcyAtldA3XDc/Ift3Q9T7n6Ndcq8Eu2y2vrO2nejvebkVFDmdAB7o
 pp3kv7f2TiFlKGkHjkj3WB9dLwByWBYH/vU1b+QiZihk6Q0K4T9HBwvCrNM3xNjDANZkXTde50O
 kAxRJo+pBYUT3sw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Store 'dmc->dev' in local 'dev' variable, to make several pieces of code
using it shorter and easier to read.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/samsung/exynos5422-dmc.c | 61 +++++++++++++++++----------------
 1 file changed, 31 insertions(+), 30 deletions(-)

diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index da7ecd921c72..48ef41b8eaa0 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -339,19 +339,20 @@ static int exynos5_switch_timing_regs(struct exynos5_dmc *dmc, bool set)
 static int exynos5_init_freq_table(struct exynos5_dmc *dmc,
 				   struct devfreq_dev_profile *profile)
 {
+	struct device *dev = dmc->dev;
 	int i, ret;
 	int idx;
 	unsigned long freq;
 
-	ret = devm_pm_opp_of_add_table(dmc->dev);
+	ret = devm_pm_opp_of_add_table(dev);
 	if (ret < 0) {
-		dev_err(dmc->dev, "Failed to get OPP table\n");
+		dev_err(dev, "Failed to get OPP table\n");
 		return ret;
 	}
 
-	dmc->opp_count = dev_pm_opp_get_opp_count(dmc->dev);
+	dmc->opp_count = dev_pm_opp_get_opp_count(dev);
 
-	dmc->opp = devm_kmalloc_array(dmc->dev, dmc->opp_count,
+	dmc->opp = devm_kmalloc_array(dev, dmc->opp_count,
 				      sizeof(struct dmc_opp_table), GFP_KERNEL);
 	if (!dmc->opp)
 		return -ENOMEM;
@@ -360,7 +361,7 @@ static int exynos5_init_freq_table(struct exynos5_dmc *dmc,
 	for (i = 0, freq = ULONG_MAX; i < dmc->opp_count; i++, freq--) {
 		struct dev_pm_opp *opp;
 
-		opp = dev_pm_opp_find_freq_floor(dmc->dev, &freq);
+		opp = dev_pm_opp_find_freq_floor(dev, &freq);
 		if (IS_ERR(opp))
 			return PTR_ERR(opp);
 
@@ -1175,49 +1176,50 @@ static int create_timings_aligned(struct exynos5_dmc *dmc, u32 *reg_timing_row,
 static int of_get_dram_timings(struct exynos5_dmc *dmc)
 {
 	int ret = 0;
+	struct device *dev = dmc->dev;
 	int idx;
 	struct device_node *np_ddr;
 	u32 freq_mhz, clk_period_ps;
 
-	np_ddr = of_parse_phandle(dmc->dev->of_node, "device-handle", 0);
+	np_ddr = of_parse_phandle(dev->of_node, "device-handle", 0);
 	if (!np_ddr) {
-		dev_warn(dmc->dev, "could not find 'device-handle' in DT\n");
+		dev_warn(dev, "could not find 'device-handle' in DT\n");
 		return -EINVAL;
 	}
 
-	dmc->timing_row = devm_kmalloc_array(dmc->dev, TIMING_COUNT,
+	dmc->timing_row = devm_kmalloc_array(dev, TIMING_COUNT,
 					     sizeof(u32), GFP_KERNEL);
 	if (!dmc->timing_row) {
 		ret = -ENOMEM;
 		goto put_node;
 	}
 
-	dmc->timing_data = devm_kmalloc_array(dmc->dev, TIMING_COUNT,
+	dmc->timing_data = devm_kmalloc_array(dev, TIMING_COUNT,
 					      sizeof(u32), GFP_KERNEL);
 	if (!dmc->timing_data) {
 		ret = -ENOMEM;
 		goto put_node;
 	}
 
-	dmc->timing_power = devm_kmalloc_array(dmc->dev, TIMING_COUNT,
+	dmc->timing_power = devm_kmalloc_array(dev, TIMING_COUNT,
 					       sizeof(u32), GFP_KERNEL);
 	if (!dmc->timing_power) {
 		ret = -ENOMEM;
 		goto put_node;
 	}
 
-	dmc->timings = of_lpddr3_get_ddr_timings(np_ddr, dmc->dev,
+	dmc->timings = of_lpddr3_get_ddr_timings(np_ddr, dev,
 						 DDR_TYPE_LPDDR3,
 						 &dmc->timings_arr_size);
 	if (!dmc->timings) {
-		dev_warn(dmc->dev, "could not get timings from DT\n");
+		dev_warn(dev, "could not get timings from DT\n");
 		ret = -EINVAL;
 		goto put_node;
 	}
 
-	dmc->min_tck = of_lpddr3_get_min_tck(np_ddr, dmc->dev);
+	dmc->min_tck = of_lpddr3_get_min_tck(np_ddr, dev);
 	if (!dmc->min_tck) {
-		dev_warn(dmc->dev, "could not get tck from DT\n");
+		dev_warn(dev, "could not get tck from DT\n");
 		ret = -EINVAL;
 		goto put_node;
 	}
@@ -1254,34 +1256,34 @@ static int of_get_dram_timings(struct exynos5_dmc *dmc)
 static int exynos5_dmc_init_clks(struct exynos5_dmc *dmc)
 {
 	int ret;
+	struct device *dev = dmc->dev;
 	unsigned long target_volt = 0;
 	unsigned long target_rate = 0;
 	unsigned int tmp;
 
-	dmc->fout_spll = devm_clk_get(dmc->dev, "fout_spll");
+	dmc->fout_spll = devm_clk_get(dev, "fout_spll");
 	if (IS_ERR(dmc->fout_spll))
 		return PTR_ERR(dmc->fout_spll);
 
-	dmc->fout_bpll = devm_clk_get(dmc->dev, "fout_bpll");
+	dmc->fout_bpll = devm_clk_get(dev, "fout_bpll");
 	if (IS_ERR(dmc->fout_bpll))
 		return PTR_ERR(dmc->fout_bpll);
 
-	dmc->mout_mclk_cdrex = devm_clk_get(dmc->dev, "mout_mclk_cdrex");
+	dmc->mout_mclk_cdrex = devm_clk_get(dev, "mout_mclk_cdrex");
 	if (IS_ERR(dmc->mout_mclk_cdrex))
 		return PTR_ERR(dmc->mout_mclk_cdrex);
 
-	dmc->mout_bpll = devm_clk_get(dmc->dev, "mout_bpll");
+	dmc->mout_bpll = devm_clk_get(dev, "mout_bpll");
 	if (IS_ERR(dmc->mout_bpll))
 		return PTR_ERR(dmc->mout_bpll);
 
-	dmc->mout_mx_mspll_ccore = devm_clk_get(dmc->dev,
-						"mout_mx_mspll_ccore");
+	dmc->mout_mx_mspll_ccore = devm_clk_get(dev, "mout_mx_mspll_ccore");
 	if (IS_ERR(dmc->mout_mx_mspll_ccore))
 		return PTR_ERR(dmc->mout_mx_mspll_ccore);
 
-	dmc->mout_spll = devm_clk_get(dmc->dev, "ff_dout_spll2");
+	dmc->mout_spll = devm_clk_get(dev, "ff_dout_spll2");
 	if (IS_ERR(dmc->mout_spll)) {
-		dmc->mout_spll = devm_clk_get(dmc->dev, "mout_sclk_spll");
+		dmc->mout_spll = devm_clk_get(dev, "mout_sclk_spll");
 		if (IS_ERR(dmc->mout_spll))
 			return PTR_ERR(dmc->mout_spll);
 	}
@@ -1329,38 +1331,37 @@ static int exynos5_dmc_init_clks(struct exynos5_dmc *dmc)
  */
 static int exynos5_performance_counters_init(struct exynos5_dmc *dmc)
 {
+	struct device *dev = dmc->dev;
 	int ret, i;
 
-	dmc->num_counters = devfreq_event_get_edev_count(dmc->dev,
-							"devfreq-events");
+	dmc->num_counters = devfreq_event_get_edev_count(dev, "devfreq-events");
 	if (dmc->num_counters < 0) {
-		dev_err(dmc->dev, "could not get devfreq-event counters\n");
+		dev_err(dev, "could not get devfreq-event counters\n");
 		return dmc->num_counters;
 	}
 
-	dmc->counter = devm_kcalloc(dmc->dev, dmc->num_counters,
+	dmc->counter = devm_kcalloc(dev, dmc->num_counters,
 				    sizeof(*dmc->counter), GFP_KERNEL);
 	if (!dmc->counter)
 		return -ENOMEM;
 
 	for (i = 0; i < dmc->num_counters; i++) {
 		dmc->counter[i] =
-			devfreq_event_get_edev_by_phandle(dmc->dev,
-						"devfreq-events", i);
+			devfreq_event_get_edev_by_phandle(dev, "devfreq-events", i);
 		if (IS_ERR_OR_NULL(dmc->counter[i]))
 			return -EPROBE_DEFER;
 	}
 
 	ret = exynos5_counters_enable_edev(dmc);
 	if (ret < 0) {
-		dev_err(dmc->dev, "could not enable event counter\n");
+		dev_err(dev, "could not enable event counter\n");
 		return ret;
 	}
 
 	ret = exynos5_counters_set_event(dmc);
 	if (ret < 0) {
 		exynos5_counters_disable_edev(dmc);
-		dev_err(dmc->dev, "could not set event counter\n");
+		dev_err(dev, "could not set event counter\n");
 		return ret;
 	}
 

-- 
2.43.0


