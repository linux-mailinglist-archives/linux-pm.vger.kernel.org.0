Return-Path: <linux-pm+bounces-23766-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6561DA597A9
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 15:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF5F16D32C
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 14:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9981022B581;
	Mon, 10 Mar 2025 14:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqmoc2xR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BC1227EBB;
	Mon, 10 Mar 2025 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741617313; cv=none; b=pmTR1IZTKGDvmWJ3aYI9W0fCSl4058jU3ZYolK3o0hcsWJe0WDl2Fq06SuPKPG9RziPV45jzfOv7LnEYHSgkmofnF8OX0wlPJADaXo8g34RcnasMdDdGzaUwdymR6yRY3XlInGEbbOJj/T+3QPY4tzTmOxjWQPS9uAOVa1uqbj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741617313; c=relaxed/simple;
	bh=jt7NDGc8noYexdYzv/8Lg3bRt9IuUj8K8Bh1YPqYeHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emtObuveJJ19IxxUZ8vTffjaMaAdiswspepVEETpPokvfDi73DTDYcrcDv8ISumbtO+YQrrYacZxjBm2YPUo79LV1XNtihwEchOhorf4HzanLEbzJIZ66RnJXMDHLdT2VB/7VPSrz2qtBHQr4Crpm7mflvRfvY4bnxc0IAyeI3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqmoc2xR; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-223fb0f619dso80743755ad.1;
        Mon, 10 Mar 2025 07:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741617311; x=1742222111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3PCN1rM0WbHIM2gIVr2uSVcfKomlI7ImWzVGLtI+Ys=;
        b=gqmoc2xRJLcxH4pWuEMHRb9n/n1Y2FYqFaizutBrDSNVT/2WIH1ponUMROsELxFnRa
         ts8Hr5U6PI+uakVKvPMz66bJ/Ye5fnh/R6fwccEPqO2WQ+kkKAzFChm0ARtfG3zsUYmO
         ePhymFPmmNYc9MJEJt5cUEcMPLecWyMwQqXRsD9pnuOlEN5quSB7/hCZJeKCdk7O1HCa
         yN9nZx2sFSxr/6mqOW1mHYaB53I+sP+xuoLnEc66aMmTZCozYCpe5j6OuB8AVbgvbj8C
         exOAO9rE2Ebsh3O1Kf/XWDH+r0tYp4R/8Dw75gkrBQ4ziQAk6AixTR7sp93JRHRAHRvA
         +r8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741617311; x=1742222111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3PCN1rM0WbHIM2gIVr2uSVcfKomlI7ImWzVGLtI+Ys=;
        b=TD1FlHRq1OWIg17FtM8euAgFYCV6t8QjiQGqwVOZ4UxZ6wFyP7YUCJicbmOIUwPhYc
         RP3PNOq+nyVOrhR2Q2JdK7uhDUaRZc7a1BMm+Bn7KWAKa5vaNnC6b+0aE12IF638cuaS
         N5qv8L86vg09sb3tzNPQ/6mlQPo7YPuGMDtGrqIzmH/MgzAwNdXrqYIv6s/nBynWyQ09
         Mh2lRA1VnmvW6SrnUvmo6iixMCwfSk4NrHPGuVU8lHAXx9dJZWeEr4ZVLGYwW9ayBjbU
         TGrL41cSBWJxbElZ+3IBZDCUIWwxXjsZJFuXv47qXSxxDGhY+c/9rDE/9n37++XE5vdM
         Z7kg==
X-Forwarded-Encrypted: i=1; AJvYcCVkAl4TihBU8RXrwxgY8KuD7P7QbcGgFf4x39OZy8wO8UvzqBHsTmtE2bUUiSTqHw/Q6MlDft5EtdT7ySamsd463A0=@vger.kernel.org, AJvYcCVkFO0B+RdpnhWWufcdEZC1xweGsL3kCLPiqWltBExV08hcYcs4VxYcOWrXGWe/YaEFgu8v60uYl3VWn7E=@vger.kernel.org, AJvYcCWtM1UPb2Jtbk0vF3HMfD/RdgEIovA5283k8cU9G1NK0v6wJyV5mcfSd27sE6YxaL1ahxmZOQxUC9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjcV1blVlYdwhTchLXJKj3mUGCavmZyIKjDPiG2nC/Zyf4m9UL
	ZpFFnJwuaYoMAJKnuTElMENzfuJ8RPNPLqdxKv1U7um9DOvNlu1E
X-Gm-Gg: ASbGncvHxv1H80A4hUvfcdFepSNRKI3G0aqT5iFAbDb2dvuY0nyScW9I0pDZKbcCR28
	B7aP4E7FT2z0ktDga+h3DCgv68yOANQ4KZjwESVfGze+W3jYtciTMKFgYwN2ENGGorZqUusA5y4
	xw+hJZQ0DdkuchI4TVd3jHHqbkk8x2vIpHT5kUdRv/SGKiTsY6hjI0A+4xfIF99HLx8zosX56Ba
	UwsiEgpRgG+TMosTxOErc58/OF9A2UKbwAN+oWLHsrjVJLXTx7nlBCmLOLqVyjQy6/xYrnxsDpa
	48bLTcStrmiZ7XfnGuVEgn6AgxzNvGdYT1YG2+CjSXyobmo3Dkbaf4/yLec=
X-Google-Smtp-Source: AGHT+IGRjAcGVcNUlBufVXhtdKF6feTENZiruX3FJiNFzexU5+dfH+syt6bCsQK3e8kMsxDHJZJ4HQ==
X-Received: by 2002:a05:6a21:46c4:b0:1f5:6d00:ba05 with SMTP id adf61e73a8af0-1f58cbefa96mr2309637.38.1741617309689;
        Mon, 10 Mar 2025 07:35:09 -0700 (PDT)
Received: from localhost.localdomain ([103.221.69.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af281096763sm7785900a12.30.2025.03.10.07.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:35:09 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-pm@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v4 1/4] drivers/thermal/exynos: Refactor clk_sec initialization inside SOC-specific case
Date: Mon, 10 Mar 2025 20:04:42 +0530
Message-ID: <20250310143450.8276-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310143450.8276-1-linux.amoon@gmail.com>
References: <20250310143450.8276-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the initialization of the clk_sec clock to be inside the
SOC_ARCH_EXYNOS5420_TRIMINFO case. It ensures that the clk_sec clock
is only initialized for the specified SOC and not for other SOCs,
thereby simplifying the code. The clk_sec clock is used by the TMU
for GPU on the Exynos 542x platform.

Removed redundant IS_ERR() checks for the clk_sec clock since error
handling is already managed internally by clk_unprepare() functions.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v4: Fix the aligment of code clk for clk_prepare in proper if/else block.
    update the commit for clk_sec used.
    checked to goto clean up all the clks are proper.
    drop IS_ERR() check for clk_sec.
v3: improve the commit message.
---
 drivers/thermal/samsung/exynos_tmu.c | 37 ++++++++++++++--------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 47a99b3c53958..3657920de0004 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1037,29 +1037,30 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		return ret;
 
 	data->clk = devm_clk_get(dev, "tmu_apbif");
-	if (IS_ERR(data->clk))
+	if (IS_ERR(data->clk)) {
 		return dev_err_probe(dev, PTR_ERR(data->clk), "Failed to get clock\n");
-
-	data->clk_sec = devm_clk_get(dev, "tmu_triminfo_apbif");
-	if (IS_ERR(data->clk_sec)) {
-		if (data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO)
-			return dev_err_probe(dev, PTR_ERR(data->clk_sec),
-					     "Failed to get triminfo clock\n");
 	} else {
-		ret = clk_prepare(data->clk_sec);
+		ret = clk_prepare(data->clk);
 		if (ret) {
 			dev_err(dev, "Failed to get clock\n");
 			return ret;
 		}
 	}
 
-	ret = clk_prepare(data->clk);
-	if (ret) {
-		dev_err(dev, "Failed to get clock\n");
-		goto err_clk_sec;
-	}
-
 	switch (data->soc) {
+	case SOC_ARCH_EXYNOS5420_TRIMINFO:
+		data->clk_sec = devm_clk_get(dev, "tmu_triminfo_apbif");
+		if (IS_ERR(data->clk_sec)) {
+			ret = dev_err_probe(dev, PTR_ERR(data->clk_sec),
+					    "Failed to get clk_sec clock\n");
+			goto err_clk;
+		}
+		ret = clk_prepare(data->clk_sec);
+		if (ret) {
+			dev_err(dev, "Failed to prepare clk_sec clock\n");
+			goto err_clk_sec;
+		}
+		break;
 	case SOC_ARCH_EXYNOS5433:
 	case SOC_ARCH_EXYNOS7:
 		data->sclk = devm_clk_get(dev, "tmu_sclk");
@@ -1112,11 +1113,10 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 
 err_sclk:
 	clk_disable_unprepare(data->sclk);
+err_clk_sec:
+	clk_unprepare(data->clk_sec);
 err_clk:
 	clk_unprepare(data->clk);
-err_clk_sec:
-	if (!IS_ERR(data->clk_sec))
-		clk_unprepare(data->clk_sec);
 	return ret;
 }
 
@@ -1128,8 +1128,7 @@ static void exynos_tmu_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(data->sclk);
 	clk_unprepare(data->clk);
-	if (!IS_ERR(data->clk_sec))
-		clk_unprepare(data->clk_sec);
+	clk_unprepare(data->clk_sec);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.48.1


