Return-Path: <linux-pm+bounces-32286-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37822B24A40
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 15:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44661586993
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 13:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90AD2E716D;
	Wed, 13 Aug 2025 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0+f/2gQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EC726FA6E;
	Wed, 13 Aug 2025 13:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090636; cv=none; b=LTxJfEEZ8CCEFJGK3HeEmJCMUlY/4BGw8O8uKfLOQuoAaiywGZS2v5vZMxyYBlTZLrgLoA5v+58XvM6P/mXE5UgY+Auo6+x2neSkgoQIJsMqXRM5BhIXg/21jiYfVOm7iMhffBBgbBytD1fndyfF8M0F1IBoMAsqTwX04egL628=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090636; c=relaxed/simple;
	bh=pErvtY3ihK17Sb6LHbdNsewtgB3895221qeOyAaYxy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1XFNTaNZeqWpw5w7qJYmx5wPt+n0AfNrJCpio11m4r0kd5QDL/lf7rjLEFfqv0BU5nMiAtczeGRn7tolkOI+qqqhsgqnpGn6yE2eMcDNQKXbc1rUmyADMXREM4XjG1k0T6GgwjlX7rbyp6R8HC9AwY285qUzHj/He4JPL5WNmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0+f/2gQ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-31f3b54da19so4503441a91.1;
        Wed, 13 Aug 2025 06:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755090634; x=1755695434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=af3N+2yRmzcUJywzp/ZUMgm21c6Xt/FcL9OpDD1I9wg=;
        b=L0+f/2gQKW/XmH06LoKkJtmW/QY3uOu8mewrnJBaS17p/pF5oF7v/YmloVKiMrnQQZ
         /ZwAMgOO8QDMwz/jTX+rtgT+amPISNqRjnpFbkBFy3t4RnvHHsWSwHD9YazNjlc8fyj/
         SO3VeoB/6arHNGLu78OLQQiaI4bkLcRPF0lqWfT/ymGurqYjAfMKH/dzjFXZ3ZIO3N8z
         hR2d1HJal2fsh2KAcROd1m/3Kz6jINwchueDQJzvQCEldWwffzL/M/mRRkxni+yHHUJ2
         SNMScE2rEocyP28o1NXGzGscNgq7nuN3VxcLOfuq3O4R59fS9b0SRZrnE0cNEA5ai6ch
         olPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755090634; x=1755695434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=af3N+2yRmzcUJywzp/ZUMgm21c6Xt/FcL9OpDD1I9wg=;
        b=ABLVBcXTemHuUkBHRXB7mnbeSaM4REhYS7joTdQKUx9I2nEC+b5hAHnoZB5mhwr53S
         J+3Zj/cJ/11Mxswcb9WhOL644+kB4PaF9mJwysCaArAPtlp9SP/A85HL+yG+dvOk+x2o
         IvetKB4FigFQNjN/YLh5rmwrr0nJ3FVqURxBigGX7IgYy75/0qt8Hnh95Lph0ADn7b/m
         Sg8zWFNmE1caZ/Ac9NEISntf5aoLMC8p5riIjuTua0+cOh6mOWs70e5pPMXDKPuX0N0k
         IaLPG3i3xyPfNc8XAE5KwjCh0YMjwXWXc6Vw4wT7xxlxpif8KJjXYsqRyl1dTl3F0+Za
         i5dg==
X-Forwarded-Encrypted: i=1; AJvYcCUnPMLddCwhbal2M/OoBgjE5+3qhFOZpn3dOs6XPBbPruITDHV4ualCeD3DDK1175nmJKzs6WmT9riOkAM=@vger.kernel.org, AJvYcCWLe9EOi8yQzFI6u09cclEpOonNSwnGYIZxE9pvGdcaCwRWg2HU9BzPTEhog3Fblcr2N4vXiQgwNIY=@vger.kernel.org, AJvYcCXyh2gIaxtsI2eEVCV7JSqQ0FunTiYH9PHQ5n4BLtQU9+UTJ8AeC5AkBoYTynVbnVgd9Zzdrbyn/SRTy4Ym2VmA1UY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfQpcCas/kMmYYP+GXF5amuQsDEvGT0QgsVMmU8DOkWqMYk4ws
	89ZqW0/YcOFz7qjYOSIKXXisOvRIibZaipAP060rZL+XjWHDigHVhRe9
X-Gm-Gg: ASbGncsR41o724SGRcjf5rlsOtLTCsj1YOvF0bl5NthRgrY0T49CXktJTAX574LYAm4
	2c/06hRL93S12dQz7z/WJy629Mh10ACIxt4gBnLq95J/w00nmo+fqGyrri7gAl/zSmyv9S4HcnH
	piJkP8PiZtNoaDXcFXQQ5F8zQY0Dk1CITPyeiGjsd+gd0YRmqpPDSI73DVCWqyx5Bay2pqX9GAX
	SmeoNGXvNaZaKjPCcDB/SUAru2YHFVJz2ozWAIPhh0fecnVQLCrZLtloNZc94E5quMoE2qWtW7k
	+l8+geO+47ayZsGMI+ahfzynXHaZLPhKPWCKAtELWygM3h77PApB/qKiP28qtUMssHFObG1Y/D0
	FDVDDYcRKO8W7b3H1sEtP9Ikn0/JAxT4=
X-Google-Smtp-Source: AGHT+IGEeZfwc8KgJ5Ns1b2FIvyMA302/9ltr/X8zgoJP35tdZsAS0jyCBmXwRQduH4q6OrS/apLgA==
X-Received: by 2002:a17:90a:d006:b0:31e:5cc7:133 with SMTP id 98e67ed59e1d1-321d0d68ae1mr4148290a91.11.1755090633811;
        Wed, 13 Aug 2025 06:10:33 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32325765df6sm161504a91.12.2025.08.13.06.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:10:33 -0700 (PDT)
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
Subject: [PATCH v7 2/7] thermal/drivers/exynos: Use devm_clk_get_enabled() helpers
Date: Wed, 13 Aug 2025 18:39:46 +0530
Message-ID: <20250813131007.343402-3-linux.amoon@gmail.com>
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

Use devm_clk_get_enabled() helper instead of calling devm_clk_get() and
then clk_prepare_enable(). It simplifies the error handling and makes
the code more compact.

Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v7: None
v6: New patch as per Daniel request.
---
 drivers/thermal/samsung/exynos_tmu.c | 77 ++++++++--------------------
 1 file changed, 20 insertions(+), 57 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 04517d52afbd..aa0726b33c84 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1036,65 +1036,41 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	data->clk = devm_clk_get(dev, "tmu_apbif");
+	data->clk = devm_clk_get_enabled(dev, "tmu_apbif");
 	if (IS_ERR(data->clk))
-		return dev_err_probe(dev, PTR_ERR(data->clk), "Failed to get clock\n");
-
-	ret = clk_prepare(data->clk);
-	if (ret) {
-		dev_err(dev, "Failed to get clock\n");
-		return ret;
-	}
-
-	switch (data->soc) {
-	case SOC_ARCH_EXYNOS5420_TRIMINFO:
-		data->clk_sec = devm_clk_get(dev, "tmu_triminfo_apbif");
-		if (IS_ERR(data->clk_sec)) {
-			ret = dev_err_probe(dev, PTR_ERR(data->clk_sec),
-					    "Failed to get clk_sec clock\n");
-			goto err_clk;
-		}
-		ret = clk_prepare(data->clk_sec);
-		if (ret) {
-			dev_err(dev, "Failed to prepare clk_sec clock\n");
-			goto err_clk_sec;
-		}
-		break;
-	case SOC_ARCH_EXYNOS5433:
-	case SOC_ARCH_EXYNOS7:
-		data->sclk = devm_clk_get(dev, "tmu_sclk");
-		if (IS_ERR(data->sclk)) {
-			ret = dev_err_probe(dev, PTR_ERR(data->sclk), "Failed to get sclk\n");
-			goto err_clk;
-		} else {
-			ret = clk_prepare_enable(data->sclk);
-			if (ret) {
-				dev_err(dev, "Failed to enable sclk\n");
-				goto err_clk;
-			}
-		}
-		break;
-	default:
-		break;
+		return dev_err_probe(dev, PTR_ERR(data->clk),
+				     "Failed to get clock\n");
+
+	if (data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO) {
+		data->clk_sec = devm_clk_get_enabled(dev, "tmu_triminfo_apbif");
+		if (IS_ERR(data->clk_sec))
+			return dev_err_probe(dev, PTR_ERR(data->clk_sec),
+					     "Failed to get clk_sec clock\n");
+	} else if (data->soc == SOC_ARCH_EXYNOS5433 ||
+		   data->soc == SOC_ARCH_EXYNOS7) {
+		data->sclk = devm_clk_get_enabled(dev, "tmu_sclk");
+		if (IS_ERR(data->sclk))
+			return dev_err_probe(dev, PTR_ERR(data->sclk),
+					     "Failed to get sclk\n");
 	}
 
 	ret = exynos_tmu_initialize(pdev);
 	if (ret) {
 		dev_err(dev, "Failed to initialize TMU\n");
-		goto err_sclk;
+		return ret;
 	}
 
 	data->tzd = devm_thermal_of_zone_register(dev, 0, data,
 						  &exynos_sensor_ops);
 	if (IS_ERR(data->tzd)) {
-		ret = dev_err_probe(dev, PTR_ERR(data->tzd), "Failed to register sensor\n");
-		goto err_sclk;
+		return dev_err_probe(dev, PTR_ERR(data->tzd),
+				     "Failed to register sensor\n");
 	}
 
 	ret = exynos_thermal_zone_configure(pdev);
 	if (ret) {
 		dev_err(dev, "Failed to configure the thermal zone\n");
-		goto err_sclk;
+		return ret;
 	}
 
 	ret = devm_request_threaded_irq(dev, data->irq, NULL,
@@ -1104,30 +1080,17 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 					dev_name(dev), data);
 	if (ret) {
 		dev_err(dev, "Failed to request irq: %d\n", data->irq);
-		goto err_sclk;
+		return ret;
 	}
 
 	exynos_tmu_control(pdev, true);
-	return 0;
 
-err_sclk:
-	clk_disable_unprepare(data->sclk);
-err_clk_sec:
-	clk_unprepare(data->clk_sec);
-err_clk:
-	clk_unprepare(data->clk);
 	return ret;
 }
 
 static void exynos_tmu_remove(struct platform_device *pdev)
 {
-	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-
 	exynos_tmu_control(pdev, false);
-
-	clk_disable_unprepare(data->sclk);
-	clk_unprepare(data->clk);
-	clk_unprepare(data->clk_sec);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.50.1


