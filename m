Return-Path: <linux-pm+bounces-17316-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA5D9C3D20
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 12:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A48C0B249D0
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 11:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A5619DF45;
	Mon, 11 Nov 2024 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PootRFnf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0326A19D8BD
	for <linux-pm@vger.kernel.org>; Mon, 11 Nov 2024 11:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731324167; cv=none; b=fD/fx6GoX0vuiP5vMA30IE43FjTlfXbBouZVVMH2s+sYDf4sdya+M/zXpBhyiLPY1Mf/OjQaTChvyQGgNoxhLjEuBfVTxcL9gKrUOh3hcERVcV5rmgKcTDalvAXjuBQu6tAJ91UHtC1etlE6XV4uCPTu4fgaV2Nw1kInWYzqmhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731324167; c=relaxed/simple;
	bh=FK4ixumk7uIFu4HoD9RKoP3Fky2rGGbSMcVJmfmJaxE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nSjBnTj+a1JRpx55HKpOEWbNQ3i7nYbyvF66pUEworBbf0Ccg4LCfkoQzae6nft+xbHaPnhTXJo1avshqz4QU2uW5kmTnmEA/NjOsKDZX6CQ9vOiNDJCLDHhcMLs+J57k+UQsP0+lTg1ANOonm8+07J/wrM7qjrY4Rt6ZqJiJD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PootRFnf; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d4c1b1455so2954177f8f.3
        for <linux-pm@vger.kernel.org>; Mon, 11 Nov 2024 03:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731324163; x=1731928963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r15fp6TOLoxxUhTToaZ5PCMMfFRPaQfw/v7oNpDzym4=;
        b=PootRFnf26lY5YaEqqD5CAQHNRGGaWTWk60ubKXXO2vbZDWHbiUWkXMi/6FHkURL4u
         P29Mym9P3QcKNokJmOavI/iSukz+1zN0imWdfiYXJsWVtuA3BZzzEO5UhpLYdMnIZOZ5
         SjCzJNzHbAS7NUKG/MG2dRHRMYhNmRpDyPU4WTQcE+VN4fHcI1Wwv2KT0FLNj5rEhPfG
         mgOR2PUn3okT5n4NV0SXsXRMnmjeBDyMTZ23LPbmccD1S3CPkOeOafvJADnxcwPcJlUP
         rCw7W6ueuKEjIm6pMMJq0ef1RFUyIR8BWbRwoAHH6MyUKPRZUZbRGGcTKXW+XDWiLZgT
         19Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731324163; x=1731928963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r15fp6TOLoxxUhTToaZ5PCMMfFRPaQfw/v7oNpDzym4=;
        b=TZd2H3o0xlijmeFOj30Mxnc0rl9+ontw55/B+ZwxG/DniaBvB/YPjOSNkxg4Pjn7QQ
         OEyI3sHoi3+IDS3m3baWnV59crQI6eJ5WKboWape/KX+NHu5QWxxuQDCCK7kwN8QxZzh
         l9W99LWkk6Yrxu62tuuMzNsFNATLVSKnoxJjY/IgHf0W9xxjAt9Z+uSGWFrm6ma1lHyl
         VtWPHFBFnaTzYCao5uD+uOdUsTV4u4UPirqLrmFEjGRCVEJ5o8xllRNMNSF7wonBgLRx
         vXAmXx9vb0kMtBlJem98HTlCH4Q7qiu0odWTqDsGieg9fd4+mcEzu4QqrjchYZl9KAEJ
         Ie9Q==
X-Gm-Message-State: AOJu0Ywnb/fM0pBSuaU0D8YELxp4p4SOCczSpeKZN1b41J0mUtAbfILQ
	mpFlpA30ubuJxWScliBmmRHT++2IuSWY+P9BDLWETpywxI7Cwmb9ffDB/7Iemu8=
X-Google-Smtp-Source: AGHT+IGflZEXP/JVJEfxJwMnj4NDWxpO4U33EWb9Gjbu/Uy04kSnSbAmH7N8NQ7ot39D/FsHYvNz2Q==
X-Received: by 2002:a05:6000:1543:b0:374:baeb:2ec with SMTP id ffacd0b85a97d-381f182e8damr10825440f8f.19.1731324163396;
        Mon, 11 Nov 2024 03:22:43 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed970e18sm12550504f8f.10.2024.11.11.03.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 03:22:43 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH] PM / devfreq: sun8i-a33-mbus: Simplify by using more devm functions
Date: Mon, 11 Nov 2024 12:22:36 +0100
Message-ID: <20241111112237.336310-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3290; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=FK4ixumk7uIFu4HoD9RKoP3Fky2rGGbSMcVJmfmJaxE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnMej9tGYutcJk0Z66Gb2L70DkS0eDqx3OEWRcV HW1ZB/UODuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZzHo/QAKCRCPgPtYfRL+ Tli1B/43Y9j/Yb34j2TVEDZ32am9t3NigQmtFIu52ikB0nMkeZGexX1amtgjCdHOhrmUOqy6dO7 yICIA3vjmKXSlgKyHuXraCV4bQ78s4RxlWvwOmxg69l827la7WkkThrNLv7gQ25P2XJdZbIoJke rRNrk7iV4kSZKkj+rmRS7bBh+R+1T+Plf6Cp8OFcZPmkcTfyEytVexghYJT9g0Sgt7RKKO7NMIs Y55HxP/TJfYWR/+qek0gwIMzubeFkkiOjqTh8+kmT+gadN7nmFRIwf7JcddYwxebyXi88fl6e17 Q7gz0pLMcUY70QLr+yppkWNuwj++V7kdY/T9qVB4HVGyIzpY
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Use devm allocators for enabling the bus clock and
clk_rate_exclusive_get(). This simplifies error handling and the remove
callback.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/devfreq/sun8i-a33-mbus.c | 38 ++++++++------------------------
 1 file changed, 9 insertions(+), 29 deletions(-)

diff --git a/drivers/devfreq/sun8i-a33-mbus.c b/drivers/devfreq/sun8i-a33-mbus.c
index bcf654f4ff96..5b630c6e602e 100644
--- a/drivers/devfreq/sun8i-a33-mbus.c
+++ b/drivers/devfreq/sun8i-a33-mbus.c
@@ -360,7 +360,7 @@ static int sun8i_a33_mbus_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->reg_mbus))
 		return PTR_ERR(priv->reg_mbus);
 
-	priv->clk_bus = devm_clk_get(dev, "bus");
+	priv->clk_bus = devm_clk_get_enabled(dev, "bus");
 	if (IS_ERR(priv->clk_bus))
 		return dev_err_probe(dev, PTR_ERR(priv->clk_bus),
 				     "failed to get bus clock\n");
@@ -375,24 +375,15 @@ static int sun8i_a33_mbus_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(priv->clk_mbus),
 				     "failed to get mbus clock\n");
 
-	ret = clk_prepare_enable(priv->clk_bus);
-	if (ret)
-		return dev_err_probe(dev, ret,
-				     "failed to enable bus clock\n");
-
 	/* Lock the DRAM clock rate to keep priv->nominal_bw in sync. */
-	ret = clk_rate_exclusive_get(priv->clk_dram);
-	if (ret) {
-		err = "failed to lock dram clock rate\n";
-		goto err_disable_bus;
-	}
+	ret = devm_clk_rate_exclusive_get(dev, priv->clk_dram);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to lock dram clock rate\n");
 
 	/* Lock the MBUS clock rate to keep MBUS_TMR_PERIOD in sync. */
-	ret = clk_rate_exclusive_get(priv->clk_mbus);
-	if (ret) {
-		err = "failed to lock mbus clock rate\n";
-		goto err_unlock_dram;
-	}
+	ret = devm_clk_rate_exclusive_get(priv->clk_mbus);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to lock mbus clock rate\n");
 
 	priv->gov_data.upthreshold	= 10;
 	priv->gov_data.downdifferential	=  5;
@@ -405,10 +396,8 @@ static int sun8i_a33_mbus_probe(struct platform_device *pdev)
 	priv->profile.max_state		= max_state;
 
 	ret = devm_pm_opp_set_clkname(dev, "dram");
-	if (ret) {
-		err = "failed to add OPP table\n";
-		goto err_unlock_mbus;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add OPP table\n");
 
 	base_freq = clk_get_rate(clk_get_parent(priv->clk_dram));
 	for (i = 0; i < max_state; ++i) {
@@ -448,12 +437,6 @@ static int sun8i_a33_mbus_probe(struct platform_device *pdev)
 
 err_remove_opps:
 	dev_pm_opp_remove_all_dynamic(dev);
-err_unlock_mbus:
-	clk_rate_exclusive_put(priv->clk_mbus);
-err_unlock_dram:
-	clk_rate_exclusive_put(priv->clk_dram);
-err_disable_bus:
-	clk_disable_unprepare(priv->clk_bus);
 
 	return dev_err_probe(dev, ret, err);
 }
@@ -472,9 +455,6 @@ static void sun8i_a33_mbus_remove(struct platform_device *pdev)
 		dev_warn(dev, "failed to restore DRAM frequency: %d\n", ret);
 
 	dev_pm_opp_remove_all_dynamic(dev);
-	clk_rate_exclusive_put(priv->clk_mbus);
-	clk_rate_exclusive_put(priv->clk_dram);
-	clk_disable_unprepare(priv->clk_bus);
 }
 
 static const struct sun8i_a33_mbus_variant sun50i_a64_mbus = {

base-commit: 6d59cab07b8d74d0f0422b750038123334f6ecc2
-- 
2.45.2


