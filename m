Return-Path: <linux-pm+bounces-12073-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9114B94EE5F
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 15:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB8A7B2331E
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 13:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E29183CCA;
	Mon, 12 Aug 2024 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Njq+a92P"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84047183090
	for <linux-pm@vger.kernel.org>; Mon, 12 Aug 2024 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723469668; cv=none; b=kEGgdD9tnEyfBuOEbBKFHj9b19jpmKzEgBUYxYBZecgSNoBG/6LztUfsi5cBb+qhqaE6OCSEeBnXWO5prGbSQDQIpEOmbxNizBegvGitTMJDxiQAHTWnu34Plg60Gx2xRSjEuU66AB6xt9B/eGohxMg0vjua0FtIr3i0gDe2uis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723469668; c=relaxed/simple;
	bh=ZuL1arzThZP1bH0X88EKns0i/Pwsb1RnCMJkbCddCK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iXJbbQpLt41isHC9KE0B6hmYTe1a226PKbPUXkcx8/jUWg4x7qvXrz2cjHV4gaHB5eZZnM8CPvWtcrZ/O+VmFvC79zxBfH8MLDj52/lMDbypptYXxjmmpFHKlmvrTF80CQkqdeyHQQtl6FJ/hg87NIG65CC4zo1tY2F/xBRUY6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Njq+a92P; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f15dd0b489so55907901fa.3
        for <linux-pm@vger.kernel.org>; Mon, 12 Aug 2024 06:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723469665; x=1724074465; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQA/PjjohkpV6TqZg91y0zhylBtn0W2KyopE+/TT64c=;
        b=Njq+a92PA2Q6EkAKZRlyBDvjhntXSOHW7yyhPqZr39gEui1U7jcXKTLloxjXK+lGs9
         jzUYSCheWK2tHZ1HvtN8FGLSVZK044JQodhqk3Q+VUP1Z1FDun5ZVDLR/eETx0J+zrwK
         RI//+AzxILVjoV4Pj2JurVAKGwymfx6gj4p/Of2COs94d1DSKz0apR5CdxJboGmopq5m
         xQveEk2VD8NtAXo8f6sYkzmi2oyyyScegRY3V8XGGkxTYa5nA4hU+aFGMoGr9nBvPK2J
         VQbDwL/hOwgiAW3kKgiQYvD46z3CNgQlQb8OJeIAbvhITlRZEz9hdkErLUyLIhGOwHf5
         McNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723469665; x=1724074465;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQA/PjjohkpV6TqZg91y0zhylBtn0W2KyopE+/TT64c=;
        b=lcRcTau33HRNzeYzZtXAorUWI7Xg8wPjRhvuZcESNHnEzU6x7pLYUzX+laVd0Lpybg
         B9PO/LlU3l1cLUCgsINpwGCu49QCDVC3EnOBXKs3zP3rp+2wY2uQ4zAtUYdRJFBPtJrr
         7wDhql2Gy7d/DzSHuGr4TgdW/NFhLpnH5K9NGApmvM9LzY6zLv7MJVOcTBspFHTiuVUx
         ObvSYSlpJ2lLjQ9+qdB7tLJfVgpVGt06PlngKckEso1EPHxDGrUCOzelcbkftgPip0Di
         scb+uTMQnYgXyAFJYT1i/vm4o3K8p7k8sBvLqGEksLE01d9fBlpOgowv47lKo7XG2EJ0
         ZfUw==
X-Forwarded-Encrypted: i=1; AJvYcCWyOQFImxDWqY9Oald9pxdrWZzz8zFhQK2QIRuCBgb8L0Jb/ZeuUZ7JTP/wQzxGc0hQ47NJm3nfaB2oRGyHn5yzQhn7hjUAlo4=
X-Gm-Message-State: AOJu0YxkxE6TU28I2O+r6jcsC8QAX82QP7SBOhWGKwko2jwBQujaolk5
	ERr32eEpV2ftMfdZucLqEKB+7LYS2m6du+I1WFbdNveB+dYKdlwg9SqkzpWrHGM=
X-Google-Smtp-Source: AGHT+IFuG2qd+DzlKsP6QmlNw7cGw4vQwIOF5kCUyHlkAobIrwVs2DCtPwAfbJ5IawKIByi9iNKEWA==
X-Received: by 2002:a2e:d11:0:b0:2f1:9248:c325 with SMTP id 38308e7fff4ca-2f2b717bb9dmr2097961fa.31.1723469664458;
        Mon, 12 Aug 2024 06:34:24 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c7737c64sm102733975e9.31.2024.08.12.06.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 06:34:23 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 12 Aug 2024 15:33:57 +0200
Subject: [PATCH 3/9] memory: samsung: exynos5422-dmc: use scoped device
 node handling to simplify error paths
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240812-cleanup-h-of-node-put-memory-v1-3-5065a8f361d2@linaro.org>
References: <20240812-cleanup-h-of-node-put-memory-v1-0-5065a8f361d2@linaro.org>
In-Reply-To: <20240812-cleanup-h-of-node-put-memory-v1-0-5065a8f361d2@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2782;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ZuL1arzThZP1bH0X88EKns0i/Pwsb1RnCMJkbCddCK8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmug9THrzP+A1BH/yeTSMDTHI9G2M6wGjffRCSn
 dlrxuuifPyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZroPUwAKCRDBN2bmhouD
 188OEACJwoc0GJ4OOrq04S9Eqnai7E1TmoY+QS6g/X4/oh4fUgYz6R5MGupwE7ya/svO86v4gOl
 OLe8SdJZKjvqK76134ROWFAUJfVnt+x5RIg6hxI7LsqUOCxd4+P35lymy4T1T6M1Wm1YD+bzZcT
 b+hJuth2lbekjBDszhBlcuwsLCR+eP4qOP4X60dIIz/DTwLKRIsNKi1ZzceLBcnU3FxO29VYJo7
 gPDrthDsbabgcU/p+jDKZpqlwyVbYPGmOwXrB+qA/6UpNUkSgS3rEBGULDktmxaOWiCVYAf/uxU
 hnIEBvoqeT7dGdF/zxzP4IXa33L8dQ3nEhTktFn/KUFO7KSP0npI9YqxGe2wTq4U1Iu5Vv280pp
 ebL96l+uGfl7yGN0vm3XsrETWTo9jkdwTEC6nNhFbXQbMeZfppqiXSnheVM6pyTepzKzcHhmXOo
 0BysbLIOGMoxpcppLMfsoaimruRVTEn8PloUDzWjtD16zDFGKzngIrJuXFP0QKUiK7nLK+tFGiT
 kt4gMkJiRZCBIxDLPT2HkMhtyfSZMcKX/sIsKruL/TqdZ2oD4zY3RiNFWtZ9NDMNRI2wQP/yB6X
 Jbg4bT8+JbyRvvxHwF0/F4UaF2Wz9fGUB/XnfSw5mFRgs6GJP2sFYXsymEwhYpm/d8s6rmdQ643
 NIuOrNP6Z8e6AGA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Obtain the device node reference with scoped/cleanup.h to reduce error
handling and make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/samsung/exynos5422-dmc.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index da7ecd921c72..d3ae4d95a3ba 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -4,6 +4,7 @@
  * Author: Lukasz Luba <l.luba@partner.samsung.com>
  */
 
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/devfreq.h>
 #include <linux/devfreq-event.h>
@@ -1176,10 +1177,10 @@ static int of_get_dram_timings(struct exynos5_dmc *dmc)
 {
 	int ret = 0;
 	int idx;
-	struct device_node *np_ddr;
 	u32 freq_mhz, clk_period_ps;
 
-	np_ddr = of_parse_phandle(dmc->dev->of_node, "device-handle", 0);
+	struct device_node *np_ddr __free(device_node) = of_parse_phandle(dmc->dev->of_node,
+									  "device-handle", 0);
 	if (!np_ddr) {
 		dev_warn(dmc->dev, "could not find 'device-handle' in DT\n");
 		return -EINVAL;
@@ -1187,39 +1188,31 @@ static int of_get_dram_timings(struct exynos5_dmc *dmc)
 
 	dmc->timing_row = devm_kmalloc_array(dmc->dev, TIMING_COUNT,
 					     sizeof(u32), GFP_KERNEL);
-	if (!dmc->timing_row) {
-		ret = -ENOMEM;
-		goto put_node;
-	}
+	if (!dmc->timing_row)
+		return -ENOMEM;
 
 	dmc->timing_data = devm_kmalloc_array(dmc->dev, TIMING_COUNT,
 					      sizeof(u32), GFP_KERNEL);
-	if (!dmc->timing_data) {
-		ret = -ENOMEM;
-		goto put_node;
-	}
+	if (!dmc->timing_data)
+		return -ENOMEM;
 
 	dmc->timing_power = devm_kmalloc_array(dmc->dev, TIMING_COUNT,
 					       sizeof(u32), GFP_KERNEL);
-	if (!dmc->timing_power) {
-		ret = -ENOMEM;
-		goto put_node;
-	}
+	if (!dmc->timing_power)
+		return -ENOMEM;
 
 	dmc->timings = of_lpddr3_get_ddr_timings(np_ddr, dmc->dev,
 						 DDR_TYPE_LPDDR3,
 						 &dmc->timings_arr_size);
 	if (!dmc->timings) {
 		dev_warn(dmc->dev, "could not get timings from DT\n");
-		ret = -EINVAL;
-		goto put_node;
+		return -EINVAL;
 	}
 
 	dmc->min_tck = of_lpddr3_get_min_tck(np_ddr, dmc->dev);
 	if (!dmc->min_tck) {
 		dev_warn(dmc->dev, "could not get tck from DT\n");
-		ret = -EINVAL;
-		goto put_node;
+		return -EINVAL;
 	}
 
 	/* Sorted array of OPPs with frequency ascending */
@@ -1239,8 +1232,6 @@ static int of_get_dram_timings(struct exynos5_dmc *dmc)
 	dmc->bypass_timing_data = dmc->timing_data[idx - 1];
 	dmc->bypass_timing_power = dmc->timing_power[idx - 1];
 
-put_node:
-	of_node_put(np_ddr);
 	return ret;
 }
 

-- 
2.43.0


