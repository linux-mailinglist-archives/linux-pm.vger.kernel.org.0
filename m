Return-Path: <linux-pm+bounces-9977-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 459C591738C
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 23:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680831C212AE
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 21:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFBE17E47D;
	Tue, 25 Jun 2024 21:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/DwY2r7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6928C1369B6;
	Tue, 25 Jun 2024 21:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719351198; cv=none; b=OVsczrtNAVCs9AZdoXbxSXzLOk7GOC9Eul326mkrbU8Qh77qU51RK+Q1n2l5OeyWgdkX3oJ5dGs40k9wIOXMTwIYZrCevoiGkoGUBtnbNVz8xK8sEeCv4HeIS5F+e36bRfEPAiC6nhFFQ9asO8AVEXLJitOSMydSwURU0eobKuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719351198; c=relaxed/simple;
	bh=vF378iF9/szJSAJWna+ftEYzp+8iuC0Xg1MQKdgKe6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ovG4tcgRpJZVje5SNs6iE7i+uC/5QXcMhaWbQoPZSIbEX5gQza6EmN8P2jztBILa861pjhYcBXztyFZ3geeKEEunepqDENSktQGintCZySO95Oeu5Y3VAciSSzdwVuMl5IJlBj4wS4JinoDbk8K/zBGN3ooLgrIUhuDCq2VmTks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/DwY2r7; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-421cd1e5f93so45241725e9.0;
        Tue, 25 Jun 2024 14:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719351195; x=1719955995; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wOp5UqGNK/+aHc+mtLWt/FVtlNV3iPD/WbMrczGg2CE=;
        b=l/DwY2r7o16YrvCNI9ccXLe99VRGhjnsEF7rS13gi091qryxG+8IMnrU8lVIzjFUmC
         kXloNHLt97RqP0FMX6NOsXCrIWVQbtaqeZRNosWytvm7MAOUWJ2xHzco1+VLMVV7FCho
         oLg8TRwKGNRv816QS2mHSWD6EBYdJ95YeAZZWzL1zsIodAAjhbusfriXSUDkzyOeZWz5
         5+pEulaFZJYNGXFCvIuvicWk626BTtoFw0BePF94nwBXdPdezTm0hK55Y9+80sRpjr/3
         qTFCshna8K+3e22eYypQufWnvpheoWtinitUTOQmo+CAxf2IH/ZDjdyUdTHLbjYrXJEt
         AlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719351195; x=1719955995;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOp5UqGNK/+aHc+mtLWt/FVtlNV3iPD/WbMrczGg2CE=;
        b=gI6WwwTA1MwcePA+1yxdCVqLwzFZI6hlSRm2ZNfxqYhMUMTt//QVj2fIgvZpbvP/LV
         Y/dVtPOM4dT76rcffz5ago/mn4efXTGYm5DORDdNFchVoGCJF3mQ2MAQ6rVoSdMWpOOi
         XWzzq6/tPXbO8iORqQxCSjdaxNxVJK3oEOz0GghCM1iEu6/QRdFKB0E1OtsekcyTcK+M
         3rZTj9YvAk55z1ejsZS3EFn5k1vbF3ow6vs0H1rlaCCIvg8h+WMrQc1b0ITkCLjT4rjh
         +NjezT6P45BPfjdsA4628qVBKv7Nwur85HePOjP40doy/TcNLIL+FCuwPlZCGWDcGmFk
         XYMw==
X-Forwarded-Encrypted: i=1; AJvYcCUqp5RnaptBJKtOiK76nL1Miua+WmI+71BmenmkyoUYiXWJA9oE6ew7ktVY4O0oBXlaiSuuPaREOWO2NMiFm5foQgdOzznLVTM/qhMnNcrkT+GX8jtU6/FpyYVbj8s6XMlqHHx3ElPh7Q==
X-Gm-Message-State: AOJu0YwNhFaSSfT+XUVr+PHct0nGkMq8Mubk0acX5FWRXRxJhm0fs8Rr
	bFSaeAJs7Dzqsy6lyZrN1IMFg0j5c0JOgWbMJCA/mvUtF4YV+3KO
X-Google-Smtp-Source: AGHT+IHM8lLa8Kw/PfBSHM/pQpWPKRg70VziGzuKcSwEmlPeW/23VjI1c7PTAH1z3JhKQC5WZ+U1BQ==
X-Received: by 2002:a5d:518c:0:b0:360:9175:2c33 with SMTP id ffacd0b85a97d-366e9461f67mr6558659f8f.8.1719351193778;
        Tue, 25 Jun 2024 14:33:13 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366389b861bsm13854978f8f.29.2024.06.25.14.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 14:33:13 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Tue, 25 Jun 2024 23:32:40 +0200
Subject: [PATCH v2 1/3] thermal: st: switch from CONFIG_PM_SLEEP guards to
 pm_sleep_ptr()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-thermal-v2-1-bf8354ed51ee@gmail.com>
References: <20240625-thermal-v2-0-bf8354ed51ee@gmail.com>
In-Reply-To: <20240625-thermal-v2-0-bf8354ed51ee@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.0

Letting the compiler remove these functions when the kernel is built
without CONFIG_PM_SLEEP support is simpler and less error prone than the
use of #ifdef based kernel configuration guards.

Remove those guards on every ST thermal related drivers.

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 drivers/thermal/st/st_thermal.c        | 4 +---
 drivers/thermal/st/st_thermal_memmap.c | 2 +-
 drivers/thermal/st/stm_thermal.c       | 8 +++-----
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/st/st_thermal.c b/drivers/thermal/st/st_thermal.c
index 2a105409864e..5f33543a3a54 100644
--- a/drivers/thermal/st/st_thermal.c
+++ b/drivers/thermal/st/st_thermal.c
@@ -236,7 +236,6 @@ void st_thermal_unregister(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(st_thermal_unregister);
 
-#ifdef CONFIG_PM_SLEEP
 static int st_thermal_suspend(struct device *dev)
 {
 	struct st_thermal_sensor *sensor = dev_get_drvdata(dev);
@@ -265,9 +264,8 @@ static int st_thermal_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-SIMPLE_DEV_PM_OPS(st_thermal_pm_ops, st_thermal_suspend, st_thermal_resume);
+DEFINE_SIMPLE_DEV_PM_OPS(st_thermal_pm_ops, st_thermal_suspend, st_thermal_resume);
 EXPORT_SYMBOL_GPL(st_thermal_pm_ops);
 
 MODULE_AUTHOR("STMicroelectronics (R&D) Limited <ajitpal.singh@st.com>");
diff --git a/drivers/thermal/st/st_thermal_memmap.c b/drivers/thermal/st/st_thermal_memmap.c
index 29c2269b0fb3..28b380013956 100644
--- a/drivers/thermal/st/st_thermal_memmap.c
+++ b/drivers/thermal/st/st_thermal_memmap.c
@@ -180,7 +180,7 @@ static void st_mmap_remove(struct platform_device *pdev)
 static struct platform_driver st_mmap_thermal_driver = {
 	.driver = {
 		.name	= "st_thermal_mmap",
-		.pm     = &st_thermal_pm_ops,
+		.pm     = pm_sleep_ptr(&st_thermal_pm_ops),
 		.of_match_table = st_mmap_thermal_of_match,
 	},
 	.probe		= st_mmap_probe,
diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index 34785b9276fc..ffd988600ed6 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -440,7 +440,6 @@ static int stm_thermal_prepare(struct stm_thermal_sensor *sensor)
 	return ret;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int stm_thermal_suspend(struct device *dev)
 {
 	struct stm_thermal_sensor *sensor = dev_get_drvdata(dev);
@@ -466,10 +465,9 @@ static int stm_thermal_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
 
-static SIMPLE_DEV_PM_OPS(stm_thermal_pm_ops,
-			 stm_thermal_suspend, stm_thermal_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(stm_thermal_pm_ops,
+				stm_thermal_suspend, stm_thermal_resume);
 
 static const struct thermal_zone_device_ops stm_tz_ops = {
 	.get_temp	= stm_thermal_get_temp,
@@ -580,7 +578,7 @@ static void stm_thermal_remove(struct platform_device *pdev)
 static struct platform_driver stm_thermal_driver = {
 	.driver = {
 		.name	= "stm_thermal",
-		.pm     = &stm_thermal_pm_ops,
+		.pm     = pm_sleep_ptr(&stm_thermal_pm_ops),
 		.of_match_table = stm_thermal_of_match,
 	},
 	.probe		= stm_thermal_probe,

-- 
2.45.2


