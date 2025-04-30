Return-Path: <linux-pm+bounces-26457-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C90B5AA4B44
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 14:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563671BC547B
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 12:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334B425A355;
	Wed, 30 Apr 2025 12:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ex5VHu3J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9148525A331;
	Wed, 30 Apr 2025 12:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746016422; cv=none; b=rbH6i0qSrad/14dB+UudIVA8H71V0TDppCtREVp0tdBafAvrLFSZBHmMoA1VhLB09H1QtCfL8Ydj2RNgolTP+KGAe/2PqB/6eKvux0tyC45B4rAtXcDlEbZXuuF55YdmbLhmsD0rFh9fAuNhibD5HY2yzl97X/EgQrCv2Jtmfok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746016422; c=relaxed/simple;
	bh=AMHriJWtg25hnFA/So3L/EOWUqqACE2Z4o1uB6xjZeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8mVpcOiQ30vyTmEjRwA57t5PVVyLf24qgxbizQ6hHehkE8SVBge4eLRgZes9Dy0XYbDsvlIenpVpykHJaPC6JJsOxGzo+68IRdGeH0U8CPRaTEd+7C8K17/AVuZPLEMIahQ8H+4Xm2gmOmRtLRazIGufbP5Q36sRLGnDpGZ91k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ex5VHu3J; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-736c3e7b390so7291927b3a.2;
        Wed, 30 Apr 2025 05:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746016420; x=1746621220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvhhvpDOxzlX5SAkLZgkSUnI6uZuO15oKBiHsWrIAXo=;
        b=Ex5VHu3Js3meZ6q6qVE6afZ3leFHXcitpzQ/u5Gozb3Nn9RT2bcAa360peSh0myCP4
         USNXxNXu4avrsr37XxVqHSiHTd15fo58ya2sfVEU3w68IEXg5yXnZnNShEAmkDFuerVO
         e/l2cb0ye6qm0dlT7hKcRjwieQPEvgg27WIwr+YX4d5UHICqekWLRAAhFK16MRyPC+19
         2j9rI7EuKiDnm9RPJWXnv063g0G8/s348ttIT7NaVEOJGTDVF7wfXQGW8ANA8MaO7aFz
         3TdEAwi1Bf6a5PYVeXlh8Bii7GiBT8jx4XpPoIO2z1dDjaYM9a6hxffCX5LsEc0oXKrf
         CrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746016420; x=1746621220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvhhvpDOxzlX5SAkLZgkSUnI6uZuO15oKBiHsWrIAXo=;
        b=hy54TzmRUOFYb6Upao9ZjwO7FYGsU0xZIDBXHQvXF/wMwmM/7f/seYMwDXKxacCnmo
         nvdUm5sf/Gerz7TKJQ5X7GIvu83kL4RCWWcOp2eHRyP2JL63652hlE3vmmPQ+rN12q0U
         csgQ4Asop4R+wC8pMkwLjYS3EahWsQQgYWU41fOR/Vla7tsW7O7ZHcAcVMzT1y0m/S3X
         GKpxtyJ9IcyowgtuWgfcHFxvn5D3Z2V3Qwj/ElJmERbQNjE4n4vcwg1j439FlOBZijpw
         xExl4AZGlJUojzKsYTvnZPdOPob/xtYHNLcDGcoyN5D9UsH5D9t7GjiyBXx74Ha5dEPi
         pCSg==
X-Forwarded-Encrypted: i=1; AJvYcCUmvSJQlKbYj7uGbYkkQjYLIt82KSMXoRLC31x1GwuxwNJS/5mQ0kjDolFR0ox8nnEyIJ18tSMpnIA=@vger.kernel.org, AJvYcCVM8Wpnf85heD/WbM7Hl01MKbICaD+geG51FzNkflVyfVHwtrIn8C4xHxnhl8f3syw3mHPkoEWliUQ/DkI=@vger.kernel.org, AJvYcCW8tUtdX0igdfcSnJNwYXXCll6ZR6TVU3bqpz4byUZFjUn8yZ/mWgBSsrRQG/eEBhSDBjwvMbV7BAaFajXObvwilpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZBXhzuzzgsObBnsT/9qoAyjPvg+3rtW5WA8FmwtCneYx4HX6T
	YQ0l/W3u5yKPsT6+xD9es7sk4J95z0PRJVrhzTN+lmgWGag0ffl1
X-Gm-Gg: ASbGnctHRDZA1/9Xf/1aSvXq6DS9xfMV78Vwvnnb3t7ICPJu8E+u9bFdSKbacpwJX4e
	P0Whr2Tg9YgTco11WDQToc0AAjN+eIMfYVG8cFgs/Gns88Gb0vx2ZK2OojrMV9iHxZHAQuw3MtB
	f5f8LTK9t/ZCKMqWrLweK6Qs2gqQQz36/p+inaHvwnQL6xGqcu++ceZa2NtwFDFjccOSThpWfKI
	dAodXT6B5cRomKM/2zKmnsZuB28i7uRGE/j2P5ODvjnzEHM4UbaE279ND5D4X2y+ujvhzsNb1bc
	HqO2sEo/E1OxS/SkwCqfCxLVPE1RlH5hVhfP9Vt0d273UFanMJhcvg==
X-Google-Smtp-Source: AGHT+IE32P919fQ5R/hcnyijMUiuE0NQgTE1aYia66YLx8XCG3ZA9kGC6cfX4skbXBq1rJ+lGp2Cug==
X-Received: by 2002:a05:6a00:1496:b0:730:75b1:7219 with SMTP id d2e1a72fcca58-740389cb685mr3926486b3a.12.1746016419699;
        Wed, 30 Apr 2025 05:33:39 -0700 (PDT)
Received: from localhost.localdomain ([110.44.101.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a62e23sm1522627b3a.147.2025.04.30.05.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 05:33:38 -0700 (PDT)
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
Subject: [PATCH v6 2/4] thermal/drivers/exynos: Use devm_clk_get_enabled() helpers
Date: Wed, 30 Apr 2025 18:02:58 +0530
Message-ID: <20250430123306.15072-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430123306.15072-1-linux.amoon@gmail.com>
References: <20250430123306.15072-1-linux.amoon@gmail.com>
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
2.49.0


