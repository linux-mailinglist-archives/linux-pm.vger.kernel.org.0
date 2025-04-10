Return-Path: <linux-pm+bounces-25078-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35542A83990
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 08:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21B3F3A580E
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 06:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2242045A0;
	Thu, 10 Apr 2025 06:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jfm1RLEU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8BD204089;
	Thu, 10 Apr 2025 06:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744267100; cv=none; b=FRN7Qg6FgnSOolQXEI93zQV3e6yb1xIFxsHi2Bu2G/22po5kBfDt+M7XLEKLpcs9i5yYkrKQAttqE6ueVzXum0sFDWlpBPXbjzfNO4xctAc8DKp28xBlzCihyZnsvQJgY7oMhex8ysS6n845s7qhMZxKLQOG6TpWLhHvHsIYSQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744267100; c=relaxed/simple;
	bh=AM77C8w9LbzArLDjWF8A9ECWZ8/cFLOdaTOdMygyMpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BR4WSrrApHwWFVkH8G2LbZ0GfRuacTjw74hFV50r1vd0N0/xPcyTsLFvuDuWNvhHj2Gu8YF/EVbo4JJLFiQrgCuh56NT7etrk0g+PE7OsMWqoMb+emc7t5x/pqgP03fJkhuxUWR2GVX7t35DXXO81d9gw+fH8QZiLaJeRhY29+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jfm1RLEU; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-af5085f7861so313605a12.3;
        Wed, 09 Apr 2025 23:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744267097; x=1744871897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5763eRzYt1jege0RTd8JYUTEayhCQNbQrkkrycefYs=;
        b=Jfm1RLEUN6AdX2BKEeINdzbcBcHyMLLlKiYx5lqa/ulll67s68eqewaTQwIGQ7rHCr
         8rc0jCxZbzyAERLt4nfZTVxAPIpVkN6KY4AHSJLSO4JT+FTNtypHoMlHBDYchZD/Yp1R
         Wa8w43KdRgdHBkriJ2RDSrLBN8fVMM3Ufh+ismlI2DwauJg2Svff7V+6Szd8FplAqVWF
         11Bvm5sG45U4cc7JfEuhcrazz5llFn9DVRQmGZ7JwkyJllU0FhSVaH6LAD2ItS3qIixL
         qoQSJhfuPLUWqlFDsNxZeiYkEuLBlcCsQoJRCBQLIpd3VJ2WexCZRsHxlFiwrWsGH6Yj
         GW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744267097; x=1744871897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5763eRzYt1jege0RTd8JYUTEayhCQNbQrkkrycefYs=;
        b=FaL5hEB1RlVEywkpMui/CRbRt1Kde+8t0KOD/T9BtRIuGLO+r5W5BzmHoRVx7n0FOk
         MLJ26Ra8fJ83ad6YFv48T2/fUpvkRmlL4GLsgD62q88gXRbAaFjzaToKci5+LySoRSU4
         aJUAE+rUYRRGRxQEXM6nlQmANnsySYMYtfDbvOhuyy+5TSQRTu8wnvjZrf8SOuthriPY
         /+ie6y4RndHrbex09CkmaFPO79UCtr/Ryxjox0+ycm2ZRg2Q89c6ZGB0e38Rlff/PQp4
         KcqHhkoAl5wtNzNN7Zv1MwCi1sstu05x3PM4lb7LeOjfqqYoRpuiTs5iGyzR8/4AsXph
         NFbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuW3k5Fq10u6dfESh2dkPyrDguJSRwqDgrw3MOvYHbdmws1pbWfwQuk6CDbs/PUFc2/0WtkNNmxAQU68hh7DDvaAk=@vger.kernel.org, AJvYcCW03OOIOZ+lrCCf6T66paSnrSyFoxxNgi+kf2whaLvheJZhF/EAtZlv05xph6H73YwriAdEv34CRDgVuno=@vger.kernel.org, AJvYcCX0jNQ/8vaHfHn5u+j6t+7KPriXi8GvmQP0j7Irqm4HYx0kBWI6bipxb0BUZxpNbX/03t1A8p2Iyx8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4rebk3TvCf8gTJs5eunvA8gfNc+o6vm8laYB274l8h0wffVJe
	joZP0cchUbwkO/wOmoXpLrx6CT51f76rOHO1A+C/d4+46Q/HRLoH
X-Gm-Gg: ASbGncvfNeu7463kZ1a2lcBRC8eglWA9eNWl6lWhnveGBnNXKSbFI3KaKpmmWU8S6BN
	l+Sxj38HbWqAIh9HqfVp7fE5A6pYjg2i9tuSYYwm/tx12J8QFwIpIwhwOaUyJo0qD98SHwKqgFE
	LtH5MttvAAbk+hUjygLrP4s0+oJ51xNr8CYLD3Bu/l0fKgiXMd4c7BBDfJT4GdFOQnrw/N+x/Xb
	gwTU3/eXfVAddoknTSrI7gDz4lnfaX2GHu+ik654n7VkEmxK6C9g1seeIjjzCLlRwqPP1RpLnmb
	G/1L+f5gv378GAN6u6e+Th1vkEGQFE1xGRe6So3b5sYLqwuXS6tBNom8qHT8Q/e/ZQ==
X-Google-Smtp-Source: AGHT+IFitF6h5bRSdwbPKPWR+Ues28TptvWHWuXicvpvF1hdtwOY+l5uGQZAnwPkm7WTvTojhw5pzQ==
X-Received: by 2002:a17:90a:d64b:b0:2fa:13d9:39c with SMTP id 98e67ed59e1d1-30718b75cebmr3246029a91.14.1744267097017;
        Wed, 09 Apr 2025 23:38:17 -0700 (PDT)
Received: from localhost.localdomain ([103.221.69.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd57865csm973145a91.2.2025.04.09.23.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 23:38:16 -0700 (PDT)
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
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v5 1/3] drivers/thermal/exynos: Refactor clk_sec initialization inside SOC-specific case
Date: Thu, 10 Apr 2025 12:07:48 +0530
Message-ID: <20250410063754.5483-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410063754.5483-1-linux.amoon@gmail.com>
References: <20250410063754.5483-1-linux.amoon@gmail.com>
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
v5: None
v4: Fix the aligment of code clk for clk_prepare in proper if/else block.
    update the commit for clk_sec used.
    checked to goto clean up all the clks are proper.
    drop IS_ERR() check for clk_sec.
v3: improve the commit message.
---
 drivers/thermal/samsung/exynos_tmu.c | 37 ++++++++++++++--------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 47a99b3c5395..3657920de000 100644
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
2.49.0


