Return-Path: <linux-pm+bounces-7962-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F01F8C90BF
	for <lists+linux-pm@lfdr.de>; Sat, 18 May 2024 14:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4A031F21CDD
	for <lists+linux-pm@lfdr.de>; Sat, 18 May 2024 12:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3B539AD6;
	Sat, 18 May 2024 12:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHiwqUQE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA69622EE8;
	Sat, 18 May 2024 12:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716034373; cv=none; b=XqiNKTe3C9lWb/GBQXHiRW6dv7UkST8Bgu2Tcj/NFhauMkeIA+2khnIa3ZqNW+Uo2FrZwvVFJdInYZz7FlOQJFxYS2IGs8f+JH7qpvcuVmPe0Rtb9UJaiu/VLIRodLvoobR13wFbjLH4tM9xl2ZNA+488qHTSvjURu2VPsWEch4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716034373; c=relaxed/simple;
	bh=2gq4nbz/zVcBtPtB6vTGsOpFaQvv6Hw5NAMu06fIFKg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f9e809On/FYCW3C6UVAC9ey4tkGlJES1qzORFu4s0BFAGJv8mcIOjkmMvfgMdsIDqYIN7yZDONQ0qxl8n/wWs3zgLq6IpTuErOs5kB1YxdSNc6UsjAo6Ol7MRVmugYJvMqPx2LM0nuH7XEoeMSV77mmUvYCxT0h4E02iA/QT71o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHiwqUQE; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51fc01b6fe7so1594570e87.0;
        Sat, 18 May 2024 05:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716034370; x=1716639170; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iZK4uEAHMWC7+OzKf8O0ygaLmakDxoLTPfLX2sxqysQ=;
        b=ZHiwqUQE7Uc59nXbdDfufQcQJa83E/0Ic9Np0L9l1ZH1uNA2nbRpD9/4WFK9V1qpjj
         CLaugB9taQH0ImeCf9TrJLYXvIKpHFH/q2puSb7FPd8Tu08sQtInrxX/M4CoZ3H23bBi
         nDPCEEEAq+S/jIz3lA/InTHhA4uoz+db9bwy65UoBubQgyxgCpFSwC7RpvfV9tzuI90W
         NDKxkXssfkjw1zgwYwTYoPn7d3JFewJ/jeybewZIlZpmqT4y25syfJBFO1ifMS7jXpCR
         XYPKBIZzS47/5ILIVb+n5SdFQyzZNYw46QmlTkgQ64m037RIG4Oa//KYqPgz7AZVEZZd
         nQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716034370; x=1716639170;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZK4uEAHMWC7+OzKf8O0ygaLmakDxoLTPfLX2sxqysQ=;
        b=XJrtaGfjWcYJZZyy6h01pON0o6GpBX6gBda6sF1Kpigz4LphuwtD7/mlIshBIePk3d
         3S0aw+MKIH2INfa6RtzLyqkd60Q0qV8EaQBmH2vfFrMQzdzyxSpn1Qz5NJrLuWH9i9Nj
         gU379nvXtD3QmlaBYrm3QA4sf2bdU+5IKxLhxpkS1AyMiVc5ZqkLH1dz7wIYnm6hkviQ
         V9oKM3QkSJPg8T4Z8zCZ6yXSl31brmcvyHCi0Vxz0NojfWcv4MxgbCK6DIXsaM9Q8sH3
         1P/VAziQ9cGnQAqUOXg6ei0LAIfCpSeUtPFeVg8f03gg04LKWplChw5BoR60u9scb6wF
         T9YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfpkzy/H9KFW/x9PBI/jW+BjPR23mbEqZ8dZ5On+i5UfWN5bqRljOqH3SvhoK99tvuysv/RmoBxXhgFC8HUpMiiHHDjMhmQao5qs4yHWWn43C1R8vvSI8hh3e1iu89ZjfV07wm0PKN+Q==
X-Gm-Message-State: AOJu0YwMOW7q+jALGKNrlex2QJP+lQZtIdEyJc8ev6H6EFZEuKwB3zOu
	jg4TKJ8Q358FzpF2TtrdIAuUj72waupB9RX7J+thi4Y65auppXJV
X-Google-Smtp-Source: AGHT+IEgVLnhmwBYh/F3A7zypWfD3dPLiM8lgaXLecPRLfLx6gkZ5jPCjuVL5Z1h01pYyi0ORRYBqg==
X-Received: by 2002:ac2:46e2:0:b0:523:8744:54ae with SMTP id 2adb3069b0e04-52387445634mr6715047e87.63.1716034369520;
        Sat, 18 May 2024 05:12:49 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-523713d5081sm1636086e87.244.2024.05.18.05.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 05:12:49 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Sat, 18 May 2024 14:12:04 +0200
Subject: [PATCH 1/3] thermal: st: switch from CONFIG_PM_SLEEP guards to
 pm_sleep_ptr()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240518-thermal-v1-1-7dfca3ed454b@gmail.com>
References: <20240518-thermal-v1-0-7dfca3ed454b@gmail.com>
In-Reply-To: <20240518-thermal-v1-0-7dfca3ed454b@gmail.com>
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
X-Mailer: b4 0.13.0

Letting the compiler remove these functions when the kernel is built
without CONFIG_PM_SLEEP support is simpler and less error prone than the
use of #ifdef based kernel configuration guards.

Remove those guards on every ST thermal related drivers.

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
2.45.1


