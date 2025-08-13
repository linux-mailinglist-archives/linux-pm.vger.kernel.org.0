Return-Path: <linux-pm+bounces-32285-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEC8B24A39
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 15:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161CE586ABD
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 13:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533922E716D;
	Wed, 13 Aug 2025 13:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kb1t9BZ3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39DA26FA6E;
	Wed, 13 Aug 2025 13:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090628; cv=none; b=lfuiAwRJC98RNQajvuyrWqaSTNNw/aVoItOJIhLLGhP8r2noxiColWQcIBp2MFeIuLjWff+N/Rt04h8OUqAsb9WD44V9x8WdLp2znHbPGeWTqQDb/t3nPDWuWmuvO+QxIT9nCEiOSYUTXDYAiea5oPxdG334OHQeTHWGp2763mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090628; c=relaxed/simple;
	bh=oD0dmmV1YNsrgoSjywsnehfaZYq1IVn7uaJwmsHT/BA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=coqDJF6eekhHq7VHc/4146glqqRqVpsi1qgndlBhqGpGshsXppNzqZN+rgqPzAtXfqhBF5g3cMFwZgyWKChLl5THL6WaYQBYz4tR75Ah30LtaC4FYydWZjiA4TGucslEF/gbHMNOl3Cyyomo4AYgV2Y9cf0hSRHZYjz2uDqp3js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kb1t9BZ3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24312129a53so3812505ad.0;
        Wed, 13 Aug 2025 06:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755090626; x=1755695426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UG4pARlDAw18OrFTiRSr5DlsNU8/MwRx1OXaTCPN6v8=;
        b=Kb1t9BZ30f0aRsydqjaxS1BN+V9UUTpHhgyQh/7J0lI4pv5gVrhG9wRjz2TsgbFveR
         ty/XR1UqmDNYtc+Qg1KNhN+qCxXaXGAay8HqD7Z6vC/IAvjgiaq+loRe2WT/fuqR+pwn
         mcoaqaCMHiQ5vpUTwfSE1jY+MAoqmESEb7zu4SNP8NtY9U6tSh94ldI+2dAyVJn+r97Y
         /4BVJ4ZMCr2mp/Sh7T0EJy4My4DkOkHoOS8Jf+LgY1lH9ShRYGal/XJK6w/kCHefddUR
         u2H1QOpBY5yq2sm0yCu9QAfMywMaxdrinmPNCmLi9QOGXXvSCfOS00I+KisAbMT0MF2z
         RUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755090626; x=1755695426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UG4pARlDAw18OrFTiRSr5DlsNU8/MwRx1OXaTCPN6v8=;
        b=uvATmmzwbyXfY6U2GzLmFyvVjGC4MyOKHcQ0iizpPBm+x3xlghv3R4mi5Iaz1CNrGB
         PpN1KIp6+vNNIiC2wLFTsIZko7yQmmsF8oaJNVvkC+5RIWbMkon7LBAkHg5YoAdUlU55
         QekEv0A2mxRh2FScxW06Kdv7Oqf+44Un0m7bJjN+3qa8hJoPYWxm6Su7qU3RUkNWvn9W
         sCuNa51Be8Wn5oq3wZCwcTUi2k9GkUH9kYyk04OKS8K+KVEQTuYMHotb4fVqZ/YA/V2/
         oCK7WaIKSyIaEQW+N0/oGzECRKF7hP7HG3dHMAg+b+6jIY29l8LQXz0qbrNQihCHayR/
         67GQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1GPD3GTexM8k+8N8thCbbektX+Uu1tH5sBpbWL9PDV5WVsssYDC91novguozLKTDoF0niNy1teNmyjSWD2gdAtSY=@vger.kernel.org, AJvYcCVPuPjjS+CmWmgHElIvwuWYrwxIQEhcCiPfUBiDKYFWyWgi9KdrlT8JZC/5WBzzNjpQd+cd5GE5IlnSq0c=@vger.kernel.org, AJvYcCXP3Q51Yd8NKdBCkmvLV/19UVLlIBUuoLbMkkkauXffCWt4Exc7hjm2YIlk5P/kSp8Mr+kZ2r2XNX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvvd5Y4IDAZfdWb4+9A2NUW295HeEr2dtlicZ+Ggni7EqxhFwC
	PZAgv7WtcyEGB4+S/3MOFxXTXlZ14C3TdJQFJqJc2nE+LBwIjQ97Y7rT
X-Gm-Gg: ASbGncugUet47qIb+Xw5BBEDiFpnxCym9T9WfbEmC44B/GIaHRvVpyNCKzhnNc/LuRP
	zslnQMrrnX6eOHGPrBh9IsPpHZ7j5v3WR5iY94tPGgXtdrH5vyUVE/9eOG6NKDpaxZSnbbsSUi9
	Zz1aysTe7OdQnEhz/kh0/wjXr14W+HHMLuT0zAMh3ZKFoJ0SDaHMB0g+iE7ew3Qs+nwXVz5xPBA
	043svPCV5IOf/v3sfh0fDZYDC9jp6n4quwkvrsLjzZTix2vgpS4FGl91pLkkIUyZKFcXao88O2m
	J3oQEqovEdkOtyrNQjSFAg1RwgZ/N4AuRwzubsuIX/wZRAf85SG7fdKdJvom6lQdkS/2MBS7CJZ
	9plXihUoI6nMEmmh3ZPxHim7TPO8Uj6A=
X-Google-Smtp-Source: AGHT+IFd57vkbF7WYJea3UbzrtHWKTatJ8rhcobI1fZJUuNQHNPJZ1FbYMb+zauhjR0/EwOIHErpFA==
X-Received: by 2002:a17:903:2290:b0:243:3c4:ccaa with SMTP id d9443c01a7336-2430d0d4d45mr48870055ad.19.1755090625823;
        Wed, 13 Aug 2025 06:10:25 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32325765df6sm161504a91.12.2025.08.13.06.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:10:25 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-pm@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES),
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Mateusz Majewski <m.majewski2@samsung.com>
Subject: [PATCH v7 1/7] thermal/drivers/exynos: Refactor clk_sec initialization inside SOC-specific case
Date: Wed, 13 Aug 2025 18:39:45 +0530
Message-ID: <20250813131007.343402-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813131007.343402-1-linux.amoon@gmail.com>
References: <20250813131007.343402-1-linux.amoon@gmail.com>
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

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v7: None
v6: Add Rb Lukasz and try to address Daniel review coments.
v5: None
v4: Fix the aligment of code clk for clk_prepare in proper if/else block.
    update the commit for clk_sec used.
    checked to goto clean up all the clks are proper.
    drop IS_ERR() check for clk_sec.
v3: improve the commit message.
---
 drivers/thermal/samsung/exynos_tmu.c | 36 +++++++++++++---------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 47a99b3c5395..04517d52afbd 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1040,26 +1040,26 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	if (IS_ERR(data->clk))
 		return dev_err_probe(dev, PTR_ERR(data->clk), "Failed to get clock\n");
 
-	data->clk_sec = devm_clk_get(dev, "tmu_triminfo_apbif");
-	if (IS_ERR(data->clk_sec)) {
-		if (data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO)
-			return dev_err_probe(dev, PTR_ERR(data->clk_sec),
-					     "Failed to get triminfo clock\n");
-	} else {
-		ret = clk_prepare(data->clk_sec);
-		if (ret) {
-			dev_err(dev, "Failed to get clock\n");
-			return ret;
-		}
-	}
-
 	ret = clk_prepare(data->clk);
 	if (ret) {
 		dev_err(dev, "Failed to get clock\n");
-		goto err_clk_sec;
+		return ret;
 	}
 
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
@@ -1112,11 +1112,10 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 
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
 
@@ -1128,8 +1127,7 @@ static void exynos_tmu_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(data->sclk);
 	clk_unprepare(data->clk);
-	if (!IS_ERR(data->clk_sec))
-		clk_unprepare(data->clk_sec);
+	clk_unprepare(data->clk_sec);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.50.1


