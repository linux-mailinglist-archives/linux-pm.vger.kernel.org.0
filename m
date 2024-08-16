Return-Path: <linux-pm+bounces-12340-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4015E95470C
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 12:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D95AB23D1B
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 10:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DF41990BD;
	Fri, 16 Aug 2024 10:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yC6sZbwx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC0B198A2A
	for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 10:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805690; cv=none; b=tKsNjmwZbXLEA3EaLI1qmLhkMEMkv6HLZa5rCtWr9PuC0qfbMtcP8nxtOvwBTg/XwrVjOWOijcUQ1OpkTLryPYSP8jBWz1csRFTfLwaPq710hU1Jc89+dnkI0fIM7zisWkplTcH2mkROpEiOb5d4uIQthiVgBj3uoglwMfVG8+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805690; c=relaxed/simple;
	bh=Y1tXQQLMiykATrg5422AQ20ni2RJaK4UYZemsQjrfo4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rHAUdGkWVTjvJ1MN0sCueg5EbTMMWMeAYDsPx9P4wBKsd9arp7ySrpyJzn8lm1bSZOi5/L+V33EvD4v09rwRHVrkWHQPgEJQLXRAbHXb7FmLs5eJdcc5oT/NqhDzQwdPNstD2fMz4nyauRPvMKXiHwAYroBlkL+5bxhc+lv08sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yC6sZbwx; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52f024f468bso2310550e87.1
        for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 03:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723805687; x=1724410487; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a+AKBEGtmBS5pejKHsx1RQDN0WL4LYiNHXE6IWWpnkE=;
        b=yC6sZbwxPs61KiEwiPGJ1iY79aiCMm6U5SbIOL59o0Krb0Od5C3eqeA+rodpRfYwsA
         Lm6CVSsNt+cd0s0cC01Z0m7BDDX62dPQ7P94RE6QCgMQuo25kqabyQ2ffnyOjX1X4nUO
         I5eMEvsFXhPIZIgZszSgd9PdQSDAIOxIYXxlYjXJqJZf4k0ndZAGa5spxucol9uPzETO
         iQmGoiD4i1N+LVJhaUw5K6+U/FuSlMRxji4gyF96ErT4FBTXZyCL+fy2gSmujQkDtYJJ
         +BIgxWzVZMLq6LC39grZw2fe5Q2Dufls7xxbsS2mKOHXuLBVrnsTFF/5Yf8vOrnw2Wls
         TA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723805687; x=1724410487;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+AKBEGtmBS5pejKHsx1RQDN0WL4LYiNHXE6IWWpnkE=;
        b=JVyH5EeAeWTy5SVN7xsWAX2+p1IAq0ufzDqLEwXlflp0TxXqUfuGNanEG/RyZovggv
         ob2EA69Hd+ktyeaKGhX4UjI1mzt+k2GFlNWzRFMz7gJrQyz1liURiA6NMxBwzhbiHDYy
         3brWHurlQzu3lx38AU5fZGQJPcX5x68aVAH1r6XwRlHP16lb6mMmPHZn3YpBqjBeYrEL
         YlrzVV3Gghbg42eg2QkIcaLEukFnhmLSZ2FeT6qteEdlOGFJtJ1vMpHKJztlutJBJt6S
         CPMdfDUIZmRgDOIMJxniUDrrDM1KSajFlle54Isd0h+fWaxIszvr1sSqaX/OjlcmxxxJ
         G1Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUxG+cRqgy1NK2hX6D/I6NS0ijkLwF7YehXQEqSSf8KbxdFZsojur+jrIdipT8kSAbZlKEfCueeri2g50w7tiX1PKflKgOMHhk=
X-Gm-Message-State: AOJu0YyvFOxCxwXs6c8X6Ar1DKqBFcv3ItV2pejGwlMoGtUbGrUURCZT
	FLH3gPRUN3vb81hXLEbtW0815wkyrSSsTOHZW16PcmhVLxkOCuCl3sL4Vg+57j0=
X-Google-Smtp-Source: AGHT+IEHCNscwqa+rPRNLeeVn6uCgC3dSDA6leygkbNxDpdQ8UnjMknEsIcEe+W0Kzt+2BBEbRz3Fg==
X-Received: by 2002:a05:6512:1114:b0:52f:d128:bd13 with SMTP id 2adb3069b0e04-5331c6dca4dmr1237555e87.39.1723805686484;
        Fri, 16 Aug 2024 03:54:46 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed7945cesm19461935e9.40.2024.08.16.03.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 03:54:46 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 16 Aug 2024 12:54:25 +0200
Subject: [PATCH v2 01/13] memory: atmel-ebi: use scoped device node
 handling to simplify error paths
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-cleanup-h-of-node-put-memory-v2-1-9eed0ee16b78@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2512;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Y1tXQQLMiykATrg5422AQ20ni2RJaK4UYZemsQjrfo4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmvy/nVH8+q0L69iLHcs6Nn94lY9P0zHH98yQG0
 wm6yDSp03iJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZr8v5wAKCRDBN2bmhouD
 1/CTD/4vBsb11t4ahtO9hgXQEOilBIsCGlpNiFvOhW+vWaNhLGR4ycmNq2tTW9pYLAxKoEhs9lm
 MmOy7g1tpQCAAH9pByIbx55vqIFfpDzKWPPo65H1k5tMHq19FOTxPLISCCxtG/p3bKMvmCuKUCQ
 PppZ5IiweAX7wT0y5MhYblCiSpuT0iS0A0C3zaS2NceA/pfLlsQciP1ryPAHSF0yGtDecLOjIZj
 kG93Ydr3phmWl239TCsc35QuetxOktkjec7toqqrJEP986JYxFde+IYseUDQlFdAl2/0oZp1zO9
 1MyuheP0T4lhBiWejSAP3VOFzzYHvFyYiJ0FuI+53lQpOh8u3fhQ33cxUA2Bu/mJ5651qQM7GWB
 Z+ybSqTaWtGJ/JhXAS7Vc5T3YpI1WuX7UAxAzqZ/h8aJGSmXBS4lJXKnl5Qvilqyda05uEHaA5K
 x+QuyXZW15sg3BFzrUWXfKkkPfCtQPGfOr0Jy1pPCq/dsXhP1j3UsmsiOg8oSIx7/bNqliCgnrC
 KCOilpLMjwlQUKl8ooZtIFY7akYK7Lo3chtMeoQ5B1zz90dQ/lkLudzm/tQs2eGqv8A8fDVpFHf
 Tt/1mJjmAMDAtjuHf5xdKj21jLN2y/aU797yDF3Bj6HaUwDYgntnKsO/rtn6kXZeubNG4QJO+lz
 ibM4wB69kv5gAZA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Obtain the device node reference with scoped/cleanup.h to reduce error
handling and make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Wrap line before of_parse_phandle()
---
 drivers/memory/atmel-ebi.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
index e8bb5f37f5cb..8f5b3302ee30 100644
--- a/drivers/memory/atmel-ebi.c
+++ b/drivers/memory/atmel-ebi.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2013 Jean-Jacques Hiblot <jjhiblot@traphandler.com>
  */
 
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/mfd/syscon.h>
@@ -517,7 +518,7 @@ static int atmel_ebi_dev_disable(struct atmel_ebi *ebi, struct device_node *np)
 static int atmel_ebi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *child, *np = dev->of_node, *smc_np;
+	struct device_node *child, *np = dev->of_node;
 	struct atmel_ebi *ebi;
 	int ret, reg_cells;
 	struct clk *clk;
@@ -541,30 +542,24 @@ static int atmel_ebi_probe(struct platform_device *pdev)
 
 	ebi->clk = clk;
 
-	smc_np = of_parse_phandle(dev->of_node, "atmel,smc", 0);
+	struct device_node *smc_np __free(device_node) =
+		of_parse_phandle(dev->of_node, "atmel,smc", 0);
 
 	ebi->smc.regmap = syscon_node_to_regmap(smc_np);
-	if (IS_ERR(ebi->smc.regmap)) {
-		ret = PTR_ERR(ebi->smc.regmap);
-		goto put_node;
-	}
+	if (IS_ERR(ebi->smc.regmap))
+		return PTR_ERR(ebi->smc.regmap);
 
 	ebi->smc.layout = atmel_hsmc_get_reg_layout(smc_np);
-	if (IS_ERR(ebi->smc.layout)) {
-		ret = PTR_ERR(ebi->smc.layout);
-		goto put_node;
-	}
+	if (IS_ERR(ebi->smc.layout))
+		return PTR_ERR(ebi->smc.layout);
 
 	ebi->smc.clk = of_clk_get(smc_np, 0);
 	if (IS_ERR(ebi->smc.clk)) {
-		if (PTR_ERR(ebi->smc.clk) != -ENOENT) {
-			ret = PTR_ERR(ebi->smc.clk);
-			goto put_node;
-		}
+		if (PTR_ERR(ebi->smc.clk) != -ENOENT)
+			return PTR_ERR(ebi->smc.clk);
 
 		ebi->smc.clk = NULL;
 	}
-	of_node_put(smc_np);
 	ret = clk_prepare_enable(ebi->smc.clk);
 	if (ret)
 		return ret;
@@ -615,10 +610,6 @@ static int atmel_ebi_probe(struct platform_device *pdev)
 	}
 
 	return of_platform_populate(np, NULL, NULL, dev);
-
-put_node:
-	of_node_put(smc_np);
-	return ret;
 }
 
 static __maybe_unused int atmel_ebi_resume(struct device *dev)

-- 
2.43.0


