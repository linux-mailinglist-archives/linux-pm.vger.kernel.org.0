Return-Path: <linux-pm+bounces-11176-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0613932F2F
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 19:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D9451F23D82
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 17:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CE21A00E7;
	Tue, 16 Jul 2024 17:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J37r/DvU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA36819E832;
	Tue, 16 Jul 2024 17:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721151316; cv=none; b=PAf15ZfCkl+h7mGt8IaBWQg2b2wgCD5iPaSL+ij9vx6d6aIlbria7rmkXer5KeR1GDNgUvnE7TvQbfSwbUYmGDc2xlZjOQKw+2EPjQ8b4VvcsXnyFMYyAVPSX3vrZTCmuerZMZv3skp9UUoFFxm0/fApTlC+Gu2hrzCKJ8V7zwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721151316; c=relaxed/simple;
	bh=UsdQKRPBrwcAm6UkHIIOsfCTs4IaLlXnSwNEux6Nx7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qgksAPBOgSHhN0xz1LQgRGuE+nnbbuwv175VGRNbVgFgFxnnjwPL2sOs64JA2sWKx2zMfA+imudBsb6+2aRneLNlqot7Pe948DvQHBehQY3igKPVEk41HtH7nZZ/gbosYPZi2nTHLr88ixxw3VfhtaE0C5l0EjG9wKKzbIP1gDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J37r/DvU; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4266dc7591fso40717575e9.0;
        Tue, 16 Jul 2024 10:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721151313; x=1721756113; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bAQWEK46ZWZIRZK4a1Nbp7rquUK8x0wTaH1JyzdX3Kg=;
        b=J37r/DvUKY8nklPyBfYUMEN66R2n93Wj8FASLY721EXkVnJMotzgrDnucLn9MP93aP
         KuljED+bLEUusWO4Xrk5pCUbm0Yv/78jv/sNIXGg/nmCp7Z0U5nguZHhYfvJ7TX9B6wM
         vQA++j9VhbX6gVQXOFmns3UjWPONfWY6gMWAxFgJ5oXN13eq0aZXUcbcEg7jK/l7sHq/
         p9T3q3I6RweWk5zVcmWK5OHT2p3TRIHOCb5sFY8DGVaDXXqi3D1IGUIUmBhTobAXHbf6
         MoHagN9tpGI3OghFoYuwf7QtyF4GSh1D7/eFF0aPBRCTgzHIvnoChvbQN6KFjxvetlhI
         5s6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721151313; x=1721756113;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAQWEK46ZWZIRZK4a1Nbp7rquUK8x0wTaH1JyzdX3Kg=;
        b=Ynmt17ow4cWg+d7qnu1ARMyOdylIBFSWICjYKFgmRMAwJZ/43xUj9SnO0fO0DCvEU2
         58/1c7Ty9usIOQPJxCqGWifmDRAi+MuTHXP5zyu7XcBHGzRLY/5kD0dWYkvm4L3HCoVK
         EqdmqAAi/BbT+FDmR43utEixhQrGSLyIkXl7aod6F9zCPTFU6+e5Ztrg0CiSPv3OZFkq
         54Jv2Yi5UilzNNzHloOW0LpPUJQqCdKXTRWtEtPY3anPRUc3IVQ4N9TgCuF1KlhLpaqp
         r08jLdTAUROzK9hDpqcbFA+B62UvfJeq9uTL1MeVxxC+Q8Ymikk87QNo/wi9ez9c1ymb
         lDAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0T3VgM4LrDNVy8Omc8F1VehMLlYZPBXcQMO51zfp54TKYxqrjiwf0RnVdMxaYdiUOCB8dhKXP1VmrWu2w+1rqHqkaiKNIjAKss7eXr5rtffwQ/La5hv/UG4dyITG8kOVGyq8G9CO8Gg==
X-Gm-Message-State: AOJu0Yzn0uwWsR5wLUPdKCVuHAK2DcHzMtf2YLRS47k4PzDFQvM8/X/z
	NJwJfNxbV/cvoFmhKL7DLaDsScyN0qcszNhQ/u4H3oua13bx7cTs
X-Google-Smtp-Source: AGHT+IFsEJAoNxLYSE5KxDRk11nslRcJ+xQxLGcEtecc0HTGqboFocwxBD4yicc4yd2u8CqRnVX0ig==
X-Received: by 2002:a05:6000:2c1:b0:367:9ab5:2c80 with SMTP id ffacd0b85a97d-3682635d007mr1853778f8f.57.1721151312578;
        Tue, 16 Jul 2024 10:35:12 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680db04841sm9612414f8f.101.2024.07.16.10.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 10:35:12 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Tue, 16 Jul 2024 19:34:51 +0200
Subject: [PATCH v4 1/2] thermal: st: switch from CONFIG_PM_SLEEP guards to
 pm_sleep_ptr()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-thermal-v4-1-947b327e165c@gmail.com>
References: <20240716-thermal-v4-0-947b327e165c@gmail.com>
In-Reply-To: <20240716-thermal-v4-0-947b327e165c@gmail.com>
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
index e427117381a4..97493d2b2f49 100644
--- a/drivers/thermal/st/st_thermal_memmap.c
+++ b/drivers/thermal/st/st_thermal_memmap.c
@@ -170,7 +170,7 @@ static void st_mmap_remove(struct platform_device *pdev)
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


