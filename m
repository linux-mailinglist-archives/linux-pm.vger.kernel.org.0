Return-Path: <linux-pm+bounces-15884-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9269A274C
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 17:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B11561F21955
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 15:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E171DED44;
	Thu, 17 Oct 2024 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YMjui4jj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48DA1D47AC
	for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2024 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180177; cv=none; b=InpgOoNqaVLIKvSrwFa+ZAWNwpwdg+HZ+4yCvLqJ1syfihQa2LmcHe6pu/kvwznNckbqmU99pOT1SSP34mJGDMglwlwBf6uaMfdaby9iGWwlnNrim3fVG9EgTpSlOn81l0q13JWLR15VZ2LFDGss3p5NXl9anUfyoLT2wYdOtIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180177; c=relaxed/simple;
	bh=tGtCB0pny+fiZYyAI+wzZ7mEBd+wDhspUbyXeXDn0Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ar8yCWAzjOn5mBDyS1cc1zjaY9r8FTiUFdCE6BvCztCE4ef8uBqNT7/MFpqygcUQMEZ8QKqxxRJJ2OM+4Dm55OlnV4ixnW0mUoOAMU7NQLwIVXvjWtgAnDA1N6T9l/3SbqhrdauKKSJMdNIApY/FYWl0iJP5yxz0C96P4Ax0bkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YMjui4jj; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4315baec681so8227745e9.2
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2024 08:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729180170; x=1729784970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t8XEn+nG8yI8UNJcWQ0LBom1YumTjpuXc+eLYkok/Ok=;
        b=YMjui4jjkoJwOXwJ3ZtDOUBwJJ8e14llGViLPJ7Q8aRiStKQ20q0QEot/nna9iIzHn
         JR6w2fWDDLIyxblStsN6TWgxwgsI4IuA4P7bESf0rYOzjGt41rjMRyEKkbdDk17KxAwO
         YWkMIYR7zT2bQs8iXyH9fSg/Jl92aFR/v743MbAeUI4HUFkx/XkSvuVBWaAkcytHtIpO
         ApuqBk9wuxxy8JUAFVN2vrNP8W3WvE9IvGHwtvv2OnVm3LUKuoZd78HvYvSOV/UE9ww9
         hNHshTuo+OGtvfGWYmtK7OxyrNmDQnLRJOQz4sNiDdIa7yL4Z2ASEA444nT82cQLPqaq
         eJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729180170; x=1729784970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t8XEn+nG8yI8UNJcWQ0LBom1YumTjpuXc+eLYkok/Ok=;
        b=oXZMY9RG+B/V1w+rYR/3HHRodNkWj2njpWc8XYriKht1YQirjGIBoVeTVpBUE0IHf2
         +7kH4Q0G/1DM6C82Ud5LTiWktH75L1TDW05ejD1+9SWF1DtgM0SWlk8T3Dfdb+ESj+/n
         YV9h5tY+Mr5NbjF4ug3qgpB1NLN90gWutdcqZX8epXESelBs014zyzpp/WI+EKAmqGYD
         Lgx4xMAJhOXssQB2XmOw2VF72PLo3srPdCI/5zBZaMIigqE0PtZSbuKZb0FezRKRleMx
         eCgMHJpy3R1dK0nvOfUlJLDW9ii0+Jt5NWNpukdur0L6fS7hPR5R+XDcmQ94mSL+khUt
         zaEA==
X-Gm-Message-State: AOJu0YwwmF3DGoi1pVE03Znyn/6o0I3sCAvSSskSqZpMaNwW31vh1Y3r
	PeKGfa4uvzq+nmyq76Ro5CzZBkn8TmSUe9la07Mdtfse+IJ3R6XacaFX1Xp+rRH7lGjCut3HU+T
	E
X-Google-Smtp-Source: AGHT+IF4nx3U64ZTSrC6/W5z1b/nDCGozUq3GbSnqdmCU5npdNJNBOIO7mguyt82ksqTfIF4J7c4Zw==
X-Received: by 2002:a05:600c:1d20:b0:42f:6d3d:399f with SMTP id 5b1f17b1804b1-4314a3235c6mr69550445e9.21.1729180169926;
        Thu, 17 Oct 2024 08:49:29 -0700 (PDT)
Received: from localhost (p200300f65f19e3002f38cf427133ca7b.dip0.t-ipconnect.de. [2003:f6:5f19:e300:2f38:cf42:7133:ca7b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43158c4ceadsm29907675e9.32.2024.10.17.08.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 08:49:29 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-pm@vger.kernel.org
Subject: [PATCH] interconnect: Switch back to struct platform_driver::remove()
Date: Thu, 17 Oct 2024 17:49:21 +0200
Message-ID: <20241017154920.136220-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=24134; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=tGtCB0pny+fiZYyAI+wzZ7mEBd+wDhspUbyXeXDn0Fc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnETIA5J11tkexkZ7kmLBS96VExLhA+EV0+ulAi FBy2iTw93CJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZxEyAAAKCRCPgPtYfRL+ TqQ3CACHAo1lpy/3VL4PBsReu4VASVV/No9naGkabJht9xhlEBveKjhdmBgmZIRi6XZiyVJOx9x bnKCrHcuFrOMG/x18zo0wBgPN0iIGS22SE7iDz1WW6XsnieLQsZj0u0I+9NEPHA/0Rioex9czcW KK9TBkgNv1Nr6Ar1KEMv8P8SziEZFIxfs4wMtk6X2wwkcFoC4r47QCNlFEvfc8zRhTCx1WL6svE bw5iglSHmNB7NjHuRNG7KhYDLVtM9iIUN8g//Y+l65eSvyDHT5siSvE4143dtJbA0WsZhSNfeoS bz6ffV2+z/MMoGldjajEarRL+YXnXYqIrRbmkLVCQacS9/zV
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers.

Convert all platform drivers below drivers/interconnect to use
.remove(), with the eventual goal to drop struct
platform_driver::remove_new(). As .remove() and .remove_new() have the
same prototypes, conversion is done by just changing the structure
member name in the driver initializer.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

given the simplicity of the individual changes I do this all in a single
patch. I you don't agree, please tell and I will happily split it.

It's based on yesterday's next. Feel free to drop changes that result in
a conflict when you come around to apply this. I'll care for the fallout
at a later time then. (Having said that, if you use b4 am -3 and git am
-3, there should be hardly any conflict.)

Note I didn't Cc: all the individual driver maintainers to not trigger
sending limits and spam filters.

Best regards
Uwe

 drivers/interconnect/imx/imx8mm.c      | 2 +-
 drivers/interconnect/imx/imx8mn.c      | 2 +-
 drivers/interconnect/imx/imx8mp.c      | 2 +-
 drivers/interconnect/imx/imx8mq.c      | 2 +-
 drivers/interconnect/mediatek/mt8183.c | 2 +-
 drivers/interconnect/mediatek/mt8195.c | 2 +-
 drivers/interconnect/qcom/msm8909.c    | 2 +-
 drivers/interconnect/qcom/msm8916.c    | 2 +-
 drivers/interconnect/qcom/msm8937.c    | 2 +-
 drivers/interconnect/qcom/msm8939.c    | 2 +-
 drivers/interconnect/qcom/msm8953.c    | 2 +-
 drivers/interconnect/qcom/msm8974.c    | 2 +-
 drivers/interconnect/qcom/msm8976.c    | 2 +-
 drivers/interconnect/qcom/msm8996.c    | 2 +-
 drivers/interconnect/qcom/osm-l3.c     | 2 +-
 drivers/interconnect/qcom/qcm2290.c    | 2 +-
 drivers/interconnect/qcom/qcs404.c     | 2 +-
 drivers/interconnect/qcom/qdu1000.c    | 2 +-
 drivers/interconnect/qcom/sa8775p.c    | 2 +-
 drivers/interconnect/qcom/sc7180.c     | 2 +-
 drivers/interconnect/qcom/sc7280.c     | 2 +-
 drivers/interconnect/qcom/sc8180x.c    | 2 +-
 drivers/interconnect/qcom/sc8280xp.c   | 2 +-
 drivers/interconnect/qcom/sdm660.c     | 2 +-
 drivers/interconnect/qcom/sdm670.c     | 2 +-
 drivers/interconnect/qcom/sdm845.c     | 2 +-
 drivers/interconnect/qcom/sdx55.c      | 2 +-
 drivers/interconnect/qcom/sdx65.c      | 2 +-
 drivers/interconnect/qcom/sdx75.c      | 2 +-
 drivers/interconnect/qcom/sm6115.c     | 2 +-
 drivers/interconnect/qcom/sm6350.c     | 2 +-
 drivers/interconnect/qcom/sm7150.c     | 2 +-
 drivers/interconnect/qcom/sm8150.c     | 2 +-
 drivers/interconnect/qcom/sm8250.c     | 2 +-
 drivers/interconnect/qcom/sm8350.c     | 2 +-
 drivers/interconnect/qcom/sm8450.c     | 2 +-
 drivers/interconnect/qcom/sm8550.c     | 2 +-
 drivers/interconnect/qcom/sm8650.c     | 2 +-
 drivers/interconnect/qcom/smd-rpm.c    | 2 +-
 drivers/interconnect/qcom/x1e80100.c   | 2 +-
 drivers/interconnect/samsung/exynos.c  | 2 +-
 41 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/interconnect/imx/imx8mm.c b/drivers/interconnect/imx/imx8mm.c
index a36aaaf106ae..efed12d635c1 100644
--- a/drivers/interconnect/imx/imx8mm.c
+++ b/drivers/interconnect/imx/imx8mm.c
@@ -88,7 +88,7 @@ static int imx8mm_icc_probe(struct platform_device *pdev)
 
 static struct platform_driver imx8mm_icc_driver = {
 	.probe = imx8mm_icc_probe,
-	.remove_new = imx_icc_unregister,
+	.remove = imx_icc_unregister,
 	.driver = {
 		.name = "imx8mm-interconnect",
 	},
diff --git a/drivers/interconnect/imx/imx8mn.c b/drivers/interconnect/imx/imx8mn.c
index 2a97c74e875b..535fae791f2e 100644
--- a/drivers/interconnect/imx/imx8mn.c
+++ b/drivers/interconnect/imx/imx8mn.c
@@ -77,7 +77,7 @@ static int imx8mn_icc_probe(struct platform_device *pdev)
 
 static struct platform_driver imx8mn_icc_driver = {
 	.probe = imx8mn_icc_probe,
-	.remove_new = imx_icc_unregister,
+	.remove = imx_icc_unregister,
 	.driver = {
 		.name = "imx8mn-interconnect",
 	},
diff --git a/drivers/interconnect/imx/imx8mp.c b/drivers/interconnect/imx/imx8mp.c
index 86d4c1517b26..c5751ed18d51 100644
--- a/drivers/interconnect/imx/imx8mp.c
+++ b/drivers/interconnect/imx/imx8mp.c
@@ -241,7 +241,7 @@ static int imx8mp_icc_probe(struct platform_device *pdev)
 
 static struct platform_driver imx8mp_icc_driver = {
 	.probe = imx8mp_icc_probe,
-	.remove_new = imx_icc_unregister,
+	.remove = imx_icc_unregister,
 	.driver = {
 		.name = "imx8mp-interconnect",
 	},
diff --git a/drivers/interconnect/imx/imx8mq.c b/drivers/interconnect/imx/imx8mq.c
index f817d24aeefb..6aa4f06b4676 100644
--- a/drivers/interconnect/imx/imx8mq.c
+++ b/drivers/interconnect/imx/imx8mq.c
@@ -87,7 +87,7 @@ static int imx8mq_icc_probe(struct platform_device *pdev)
 
 static struct platform_driver imx8mq_icc_driver = {
 	.probe = imx8mq_icc_probe,
-	.remove_new = imx_icc_unregister,
+	.remove = imx_icc_unregister,
 	.driver = {
 		.name = "imx8mq-interconnect",
 		.sync_state = icc_sync_state,
diff --git a/drivers/interconnect/mediatek/mt8183.c b/drivers/interconnect/mediatek/mt8183.c
index 24245085c7a9..c212e79334cf 100644
--- a/drivers/interconnect/mediatek/mt8183.c
+++ b/drivers/interconnect/mediatek/mt8183.c
@@ -133,7 +133,7 @@ static struct platform_driver mtk_emi_icc_mt8183_driver = {
 		.sync_state = icc_sync_state,
 	},
 	.probe = mtk_emi_icc_probe,
-	.remove_new = mtk_emi_icc_remove,
+	.remove = mtk_emi_icc_remove,
 
 };
 module_platform_driver(mtk_emi_icc_mt8183_driver);
diff --git a/drivers/interconnect/mediatek/mt8195.c b/drivers/interconnect/mediatek/mt8195.c
index 710e14c5447c..3ca23469ab18 100644
--- a/drivers/interconnect/mediatek/mt8195.c
+++ b/drivers/interconnect/mediatek/mt8195.c
@@ -329,7 +329,7 @@ static struct platform_driver mtk_emi_icc_mt8195_driver = {
 		.sync_state = icc_sync_state,
 	},
 	.probe = mtk_emi_icc_probe,
-	.remove_new = mtk_emi_icc_remove,
+	.remove = mtk_emi_icc_remove,
 
 };
 module_platform_driver(mtk_emi_icc_mt8195_driver);
diff --git a/drivers/interconnect/qcom/msm8909.c b/drivers/interconnect/qcom/msm8909.c
index 0d0cd7282f5b..dd656ce7b64d 100644
--- a/drivers/interconnect/qcom/msm8909.c
+++ b/drivers/interconnect/qcom/msm8909.c
@@ -1316,7 +1316,7 @@ MODULE_DEVICE_TABLE(of, msm8909_noc_of_match);
 
 static struct platform_driver msm8909_noc_driver = {
 	.probe = qnoc_probe,
-	.remove_new = qnoc_remove,
+	.remove = qnoc_remove,
 	.driver = {
 		.name = "qnoc-msm8909",
 		.of_match_table = msm8909_noc_of_match,
diff --git a/drivers/interconnect/qcom/msm8916.c b/drivers/interconnect/qcom/msm8916.c
index 499b1a9ac413..35148880b3e8 100644
--- a/drivers/interconnect/qcom/msm8916.c
+++ b/drivers/interconnect/qcom/msm8916.c
@@ -1344,7 +1344,7 @@ MODULE_DEVICE_TABLE(of, msm8916_noc_of_match);
 
 static struct platform_driver msm8916_noc_driver = {
 	.probe = qnoc_probe,
-	.remove_new = qnoc_remove,
+	.remove = qnoc_remove,
 	.driver = {
 		.name = "qnoc-msm8916",
 		.of_match_table = msm8916_noc_of_match,
diff --git a/drivers/interconnect/qcom/msm8937.c b/drivers/interconnect/qcom/msm8937.c
index 052b14c28ef8..437d59d3ca23 100644
--- a/drivers/interconnect/qcom/msm8937.c
+++ b/drivers/interconnect/qcom/msm8937.c
@@ -1337,7 +1337,7 @@ MODULE_DEVICE_TABLE(of, msm8937_noc_of_match);
 
 static struct platform_driver msm8937_noc_driver = {
 	.probe = qnoc_probe,
-	.remove_new = qnoc_remove,
+	.remove = qnoc_remove,
 	.driver = {
 		.name = "qnoc-msm8937",
 		.of_match_table = msm8937_noc_of_match,
diff --git a/drivers/interconnect/qcom/msm8939.c b/drivers/interconnect/qcom/msm8939.c
index 8ff2c23b1ca0..b52c5ac1175c 100644
--- a/drivers/interconnect/qcom/msm8939.c
+++ b/drivers/interconnect/qcom/msm8939.c
@@ -1421,7 +1421,7 @@ MODULE_DEVICE_TABLE(of, msm8939_noc_of_match);
 
 static struct platform_driver msm8939_noc_driver = {
 	.probe = qnoc_probe,
-	.remove_new = qnoc_remove,
+	.remove = qnoc_remove,
 	.driver = {
 		.name = "qnoc-msm8939",
 		.of_match_table = msm8939_noc_of_match,
diff --git a/drivers/interconnect/qcom/msm8953.c b/drivers/interconnect/qcom/msm8953.c
index 62f8c0774b3e..be2b1a606612 100644
--- a/drivers/interconnect/qcom/msm8953.c
+++ b/drivers/interconnect/qcom/msm8953.c
@@ -1310,7 +1310,7 @@ static const struct of_device_id msm8953_noc_of_match[] = {
 
 static struct platform_driver msm8953_noc_driver = {
 	.probe = qnoc_probe,
-	.remove_new = qnoc_remove,
+	.remove = qnoc_remove,
 	.driver = {
 		.name = "qnoc-msm8953",
 		.of_match_table = msm8953_noc_of_match,
diff --git a/drivers/interconnect/qcom/msm8974.c b/drivers/interconnect/qcom/msm8974.c
index 241076b5f36b..469fc48ebfe9 100644
--- a/drivers/interconnect/qcom/msm8974.c
+++ b/drivers/interconnect/qcom/msm8974.c
@@ -762,7 +762,7 @@ MODULE_DEVICE_TABLE(of, msm8974_noc_of_match);
 
 static struct platform_driver msm8974_noc_driver = {
 	.probe = msm8974_icc_probe,
-	.remove_new = msm8974_icc_remove,
+	.remove = msm8974_icc_remove,
 	.driver = {
 		.name = "qnoc-msm8974",
 		.of_match_table = msm8974_noc_of_match,
diff --git a/drivers/interconnect/qcom/msm8976.c b/drivers/interconnect/qcom/msm8976.c
index ab963def77c3..4e2ac7ebe742 100644
--- a/drivers/interconnect/qcom/msm8976.c
+++ b/drivers/interconnect/qcom/msm8976.c
@@ -1427,7 +1427,7 @@ MODULE_DEVICE_TABLE(of, msm8976_noc_of_match);
 
 static struct platform_driver msm8976_noc_driver = {
 	.probe = qnoc_probe,
-	.remove_new = qnoc_remove,
+	.remove = qnoc_remove,
 	.driver = {
 		.name = "qnoc-msm8976",
 		.of_match_table = msm8976_noc_of_match,
diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
index 788131400cd1..b73566c9b21f 100644
--- a/drivers/interconnect/qcom/msm8996.c
+++ b/drivers/interconnect/qcom/msm8996.c
@@ -2108,7 +2108,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qnoc_probe,
-	.remove_new = qnoc_remove,
+	.remove = qnoc_remove,
 	.driver = {
 		.name = "qnoc-msm8996",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index 61a8695a9adc..6a656ed44d49 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -290,7 +290,7 @@ MODULE_DEVICE_TABLE(of, osm_l3_of_match);
 
 static struct platform_driver osm_l3_driver = {
 	.probe = qcom_osm_l3_probe,
-	.remove_new = qcom_osm_l3_remove,
+	.remove = qcom_osm_l3_remove,
 	.driver = {
 		.name = "osm-l3",
 		.of_match_table = osm_l3_of_match,
diff --git a/drivers/interconnect/qcom/qcm2290.c b/drivers/interconnect/qcom/qcm2290.c
index ccbdc6202c07..e120bc1395f3 100644
--- a/drivers/interconnect/qcom/qcm2290.c
+++ b/drivers/interconnect/qcom/qcm2290.c
@@ -1367,7 +1367,7 @@ MODULE_DEVICE_TABLE(of, qcm2290_noc_of_match);
 
 static struct platform_driver qcm2290_noc_driver = {
 	.probe = qnoc_probe,
-	.remove_new = qnoc_remove,
+	.remove = qnoc_remove,
 	.driver = {
 		.name = "qnoc-qcm2290",
 		.of_match_table = qcm2290_noc_of_match,
diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
index 63e9ff223ac4..ceac7a698769 100644
--- a/drivers/interconnect/qcom/qcs404.c
+++ b/drivers/interconnect/qcom/qcs404.c
@@ -1204,7 +1204,7 @@ MODULE_DEVICE_TABLE(of, qcs404_noc_of_match);
 
 static struct platform_driver qcs404_noc_driver = {
 	.probe = qnoc_probe,
-	.remove_new = qnoc_remove,
+	.remove = qnoc_remove,
 	.driver = {
 		.name = "qnoc-qcs404",
 		.of_match_table = qcs404_noc_of_match,
diff --git a/drivers/interconnect/qcom/qdu1000.c b/drivers/interconnect/qcom/qdu1000.c
index 9cb477d2bdfe..a7392eb73d4a 100644
--- a/drivers/interconnect/qcom/qdu1000.c
+++ b/drivers/interconnect/qcom/qdu1000.c
@@ -1046,7 +1046,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qnoc_probe,
-	.remove_new = qcom_icc_rpmh_remove,
+	.remove = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-qdu1000",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sa8775p.c b/drivers/interconnect/qcom/sa8775p.c
index a729775c2aa4..e2826af3ea2e 100644
--- a/drivers/interconnect/qcom/sa8775p.c
+++ b/drivers/interconnect/qcom/sa8775p.c
@@ -2519,7 +2519,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qcom_icc_rpmh_probe,
-	.remove_new = qcom_icc_rpmh_remove,
+	.remove = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sa8775p",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sc7180.c b/drivers/interconnect/qcom/sc7180.c
index 34a1d163d6e1..af2be1543840 100644
--- a/drivers/interconnect/qcom/sc7180.c
+++ b/drivers/interconnect/qcom/sc7180.c
@@ -1807,7 +1807,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qcom_icc_rpmh_probe,
-	.remove_new = qcom_icc_rpmh_remove,
+	.remove = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sc7180",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sc7280.c b/drivers/interconnect/qcom/sc7280.c
index 167971f8e8be..ef44f89e23c7 100644
--- a/drivers/interconnect/qcom/sc7280.c
+++ b/drivers/interconnect/qcom/sc7280.c
@@ -2111,7 +2111,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qcom_icc_rpmh_probe,
-	.remove_new = qcom_icc_rpmh_remove,
+	.remove = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sc7280",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sc8180x.c b/drivers/interconnect/qcom/sc8180x.c
index 03d626776ba1..a741badaa966 100644
--- a/drivers/interconnect/qcom/sc8180x.c
+++ b/drivers/interconnect/qcom/sc8180x.c
@@ -1889,7 +1889,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qcom_icc_rpmh_probe,
-	.remove_new = qcom_icc_rpmh_remove,
+	.remove = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sc8180x",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sc8280xp.c b/drivers/interconnect/qcom/sc8280xp.c
index 7acd152bf0dd..0270f6c64481 100644
--- a/drivers/interconnect/qcom/sc8280xp.c
+++ b/drivers/interconnect/qcom/sc8280xp.c
@@ -2391,7 +2391,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qcom_icc_rpmh_probe,
-	.remove_new = qcom_icc_rpmh_remove,
+	.remove = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sc8280xp",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
index ab91de446da8..7392bebba334 100644
--- a/drivers/interconnect/qcom/sdm660.c
+++ b/drivers/interconnect/qcom/sdm660.c
@@ -1714,7 +1714,7 @@ MODULE_DEVICE_TABLE(of, sdm660_noc_of_match);
 
 static struct platform_driver sdm660_noc_driver = {
 	.probe = qnoc_probe,
-	.remove_new = qnoc_remove,
+	.remove = qnoc_remove,
 	.driver = {
 		.name = "qnoc-sdm660",
 		.of_match_table = sdm660_noc_of_match,
diff --git a/drivers/interconnect/qcom/sdm670.c b/drivers/interconnect/qcom/sdm670.c
index e5ee7fbaa641..907e1ff4ff81 100644
--- a/drivers/interconnect/qcom/sdm670.c
+++ b/drivers/interconnect/qcom/sdm670.c
@@ -1533,7 +1533,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qcom_icc_rpmh_probe,
-	.remove_new = qcom_icc_rpmh_remove,
+	.remove = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sdm670",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index 584800ac871a..855802be93fe 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -1802,7 +1802,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qcom_icc_rpmh_probe,
-	.remove_new = qcom_icc_rpmh_remove,
+	.remove = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sdm845",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sdx55.c b/drivers/interconnect/qcom/sdx55.c
index e97f28b8d2b2..4117db046fa0 100644
--- a/drivers/interconnect/qcom/sdx55.c
+++ b/drivers/interconnect/qcom/sdx55.c
@@ -913,7 +913,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qcom_icc_rpmh_probe,
-	.remove_new = qcom_icc_rpmh_remove,
+	.remove = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sdx55",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sdx65.c b/drivers/interconnect/qcom/sdx65.c
index 2f3f5479d8a5..d3a6c6c148e5 100644
--- a/drivers/interconnect/qcom/sdx65.c
+++ b/drivers/interconnect/qcom/sdx65.c
@@ -897,7 +897,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qcom_icc_rpmh_probe,
-	.remove_new = qcom_icc_rpmh_remove,
+	.remove = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sdx65",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sdx75.c b/drivers/interconnect/qcom/sdx75.c
index 7f422c27488d..7ef1f17f3292 100644
--- a/drivers/interconnect/qcom/sdx75.c
+++ b/drivers/interconnect/qcom/sdx75.c
@@ -1083,7 +1083,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qcom_icc_rpmh_probe,
-	.remove_new = qcom_icc_rpmh_remove,
+	.remove = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sdx75",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sm6115.c b/drivers/interconnect/qcom/sm6115.c
index 271b07c74862..3ee12c8a4d56 100644
--- a/drivers/interconnect/qcom/sm6115.c
+++ b/drivers/interconnect/qcom/sm6115.c
@@ -1402,7 +1402,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qnoc_probe,
-	.remove_new = qnoc_remove,
+	.remove = qnoc_remove,
 	.driver = {
 		.name = "qnoc-sm6115",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sm6350.c b/drivers/interconnect/qcom/sm6350.c
index 20923e8e6110..f41d7e19ba26 100644
--- a/drivers/interconnect/qcom/sm6350.c
+++ b/drivers/interconnect/qcom/sm6350.c
@@ -1702,7 +1702,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qcom_icc_rpmh_probe,
-	.remove_new = qcom_icc_rpmh_remove,
+	.remove = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sm6350",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sm7150.c b/drivers/interconnect/qcom/sm7150.c
index dc0d1343f510..c8c77407cd50 100644
--- a/drivers/interconnect/qcom/sm7150.c
+++ b/drivers/interconnect/qcom/sm7150.c
@@ -1730,7 +1730,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qcom_icc_rpmh_probe,
-	.remove_new = qcom_icc_rpmh_remove,
+	.remove = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sm7150",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sm8150.c b/drivers/interconnect/qcom/sm8150.c
index f29b77556a79..edfe824cad35 100644
--- a/drivers/interconnect/qcom/sm8150.c
+++ b/drivers/interconnect/qcom/sm8150.c
@@ -1864,7 +1864,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qcom_icc_rpmh_probe,
-	.remove_new = qcom_icc_rpmh_remove,
+	.remove = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sm8150",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sm8250.c b/drivers/interconnect/qcom/sm8250.c
index 1879fa15761f..cc1b14c13529 100644
--- a/drivers/interconnect/qcom/sm8250.c
+++ b/drivers/interconnect/qcom/sm8250.c
@@ -1991,7 +1991,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qcom_icc_rpmh_probe,
-	.remove_new = qcom_icc_rpmh_remove,
+	.remove = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sm8250",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sm8350.c b/drivers/interconnect/qcom/sm8350.c
index 4236a43dc256..38105ead4f29 100644
--- a/drivers/interconnect/qcom/sm8350.c
+++ b/drivers/interconnect/qcom/sm8350.c
@@ -1807,7 +1807,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qcom_icc_rpmh_probe,
-	.remove_new = qcom_icc_rpmh_remove,
+	.remove = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sm8350",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sm8450.c b/drivers/interconnect/qcom/sm8450.c
index b3cd0087377c..eb7e17df32ba 100644
--- a/drivers/interconnect/qcom/sm8450.c
+++ b/drivers/interconnect/qcom/sm8450.c
@@ -1884,7 +1884,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qcom_icc_rpmh_probe,
-	.remove_new = qcom_icc_rpmh_remove,
+	.remove = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sm8450",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sm8550.c b/drivers/interconnect/qcom/sm8550.c
index 4d0e6fa9e003..fdb97d1f1d07 100644
--- a/drivers/interconnect/qcom/sm8550.c
+++ b/drivers/interconnect/qcom/sm8550.c
@@ -1645,7 +1645,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qcom_icc_rpmh_probe,
-	.remove_new = qcom_icc_rpmh_remove,
+	.remove = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sm8550",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sm8650.c b/drivers/interconnect/qcom/sm8650.c
index b962e6c233ef..20ac5bc5e1fb 100644
--- a/drivers/interconnect/qcom/sm8650.c
+++ b/drivers/interconnect/qcom/sm8650.c
@@ -1650,7 +1650,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qcom_icc_rpmh_probe,
-	.remove_new = qcom_icc_rpmh_remove,
+	.remove = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sm8650",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/smd-rpm.c b/drivers/interconnect/qcom/smd-rpm.c
index 3816bfb4e2f3..8316c87a2c60 100644
--- a/drivers/interconnect/qcom/smd-rpm.c
+++ b/drivers/interconnect/qcom/smd-rpm.c
@@ -85,7 +85,7 @@ static struct platform_driver qcom_interconnect_rpm_smd_driver = {
 		.name		= "icc_smd_rpm",
 	},
 	.probe = qcom_icc_rpm_smd_probe,
-	.remove_new = qcom_icc_rpm_smd_remove,
+	.remove = qcom_icc_rpm_smd_remove,
 };
 module_platform_driver(qcom_interconnect_rpm_smd_driver);
 MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org>");
diff --git a/drivers/interconnect/qcom/x1e80100.c b/drivers/interconnect/qcom/x1e80100.c
index 654abb9ce08e..2c46fdb4a054 100644
--- a/drivers/interconnect/qcom/x1e80100.c
+++ b/drivers/interconnect/qcom/x1e80100.c
@@ -1964,7 +1964,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qcom_icc_rpmh_probe,
-	.remove_new = qcom_icc_rpmh_remove,
+	.remove = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-x1e80100",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/samsung/exynos.c b/drivers/interconnect/samsung/exynos.c
index c9e5361e17c5..9e041365d909 100644
--- a/drivers/interconnect/samsung/exynos.c
+++ b/drivers/interconnect/samsung/exynos.c
@@ -180,7 +180,7 @@ static struct platform_driver exynos_generic_icc_driver = {
 		.sync_state = icc_sync_state,
 	},
 	.probe = exynos_generic_icc_probe,
-	.remove_new = exynos_generic_icc_remove,
+	.remove = exynos_generic_icc_remove,
 };
 module_platform_driver(exynos_generic_icc_driver);
 

base-commit: 15e7d45e786a62a211dd0098fee7c57f84f8c681
-- 
2.45.2

