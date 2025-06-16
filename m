Return-Path: <linux-pm+bounces-28842-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9981ADB72E
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 18:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6A2188AAF3
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 16:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6873B288528;
	Mon, 16 Jun 2025 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWE69wHQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A638E288526;
	Mon, 16 Jun 2025 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750091959; cv=none; b=OJ1iC0FIigQJTlv1oLireyLsa9DQdgCtIrtfCi5q0KN1QWVQSz+xaeZeQ1ATOTBSMVnsLDO56rq7Mg+KAnfQtok6lQoKhauq4rBs8kz4ecA2P2bbcY6SdaAt4Pqs0nzdGtNDu8zO1mrKKvHWmIz7biTHPVQsitNUknmu6S2hXK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750091959; c=relaxed/simple;
	bh=5Jf/daIPASnAH44EY0GFABrkhKx0d/E/507Dge2MJxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thpdza2EUWc5LiKDZyS+5PSZpmupUd4K8oatGLvclcebP1nGH4QWeR/O3cfiJQZQ3BiH1vZof9T83z93AVKJXYvcbJpAC0wvLLa36ti4iJdVNk8xvT6qGGOCL2NKPJNIfoDIhZoZtoxbiVSBVWi5BM5F4D+6K2B0NHu5bfco+EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWE69wHQ; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b2fc93728b2so3835447a12.0;
        Mon, 16 Jun 2025 09:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750091957; x=1750696757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgaiOiiIv8UyT/OK2no2aphPsCtckyR44JUNKUXKM+Y=;
        b=VWE69wHQIJ73nOkNOwgXMHo03EIxCJvnVYQFB4iHKKV7ApHkQagUvs7SAG4mDdqtHP
         f/dFRWuDqunTweSb4Ve9rQxYJocC56/5uP0M3DTjECjeuMF6WTaY2YgbT6677D42/PW0
         TY98xTIKI4Gf8F3h7KUP0dsWrhWFxqsIbNI/KndWfUgjYPXO/fPuaXUkyRxbMlXwR7s7
         VSfVsyheeTcpzuez8tuJ3laowrYWEuZpe0+tW4Va6nLmGbk90KL8LgOiJe+s04JAGIs0
         H5kFKSqErUFxCmkNFmJgMB3/Sxl7d5ESoUH64fQDGe5z2YcH8rzgw78Welwr+OrpXSHK
         JKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750091957; x=1750696757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgaiOiiIv8UyT/OK2no2aphPsCtckyR44JUNKUXKM+Y=;
        b=ROuSVmIY6pvKmB+u0Tt9DNmGVofAR1E9ywr2uu1pXInYpuDQxYvh2s++SCQie+HeEV
         2LJuxA+zUPEuE2lBAkb9eLGma05ujkmRX9RoWQoFidAfAwg8bIkO+3LX7qWnI9zZsstw
         Tumlq52LT693H9obiKvNRxgyOnnGphL+9N/9TboLbY/ZZRf3ct9B/3uwH1ty8J1pMKQK
         CgGWBqvW5EMX32mNmbQ0d7jBu34bjdhiTXOTJ52CBEVHnQQdRM/dZp7Lwt2Bvvzdb6p8
         5eBn3xGPM5jEE6SxZvbxpQLk62ENksNu76s5GKv6FOgI7+eKRcOmNpxJd/iTzZLTLhiu
         /onA==
X-Forwarded-Encrypted: i=1; AJvYcCUQltPo/TzDFHRQYg0R9G3uU6384UiDullP8tDcsaTwpKagxoNoowPdQJn26Q6bCjnBaif7ERE1zzrYhY4=@vger.kernel.org, AJvYcCVWITIWCW3rge1TMsOZJ1yahZri8TK5G+Ha51uI7PXX0EshzUhLcHiBSlYHYY3erbuUpSXDiSHhBL8=@vger.kernel.org, AJvYcCVZSBZGAIKLp9ybk6bByjekFd3hGTUkuUPitcHSf+YS0I5UsErhzvGyGwYd9iOS9M7cBHyYsOYlv4nvnZ8UrILi6fI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDyR3koljek8pHSY9dnEV5sre8fMle6NXhrGiG7ZJaM8b2P/gQ
	aPPhwT1T9h6nthwahGeqDXcuPqalk5eHZ36v0+OilGyLh5P1yHQYPL1FVIwrMA==
X-Gm-Gg: ASbGncvHxX1FYts5viXxbhl4gl7P5/c7580H9NV3NFlwfzj3lgPAUFengfwX8FfCDve
	suMSzhNBPOnueFaDCaFix15kWcCq9R0VzwpR6TJnDW14XXajZ4/1c3YJNPa98xZ+/XZnbwN81AW
	oGZ8tBg3eEfCwkz7oMkx5VNO46X9hQOEoLe4/Qd6YBFHNBZb1/hZJj8wD3qZOQrEGByN9F0bfX0
	n8Llc4MyIauNguHpID5PvYGEqVxtiCxF+z/LmCS/549+J2CT/TLuoIdy7aX5VCpThS3a8DpldST
	GHq1GlqlNpm6KmV+RblmtN0TnmIM1eiB7IhWAE27Toj8T7o1zqk2ABduTSfO4pWLZorujvLGEYt
	VacL0Ou3kAw==
X-Google-Smtp-Source: AGHT+IHsD566uR2iJmA1x5dTinmhbSc92nzu4ptM9O+HZPszU2hE5Hk8Ch3KBvp7WkOFDhYtt71tSA==
X-Received: by 2002:a05:6a21:4a41:b0:218:75de:d924 with SMTP id adf61e73a8af0-21fbd631648mr13177925637.19.1750091956904;
        Mon, 16 Jun 2025 09:39:16 -0700 (PDT)
Received: from localhost.localdomain ([45.112.0.181])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1680c6asm6067882a12.42.2025.06.16.09.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 09:39:16 -0700 (PDT)
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
Subject: [RRC v1 3/3] thermal/drivers/exynos: Refactor IRQ clear logic using SoC-specific config
Date: Mon, 16 Jun 2025 22:08:24 +0530
Message-ID: <20250616163831.8138-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616163831.8138-1-linux.amoon@gmail.com>
References: <20250616163831.8138-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactors the IRQ clear logic in the Exynos TMU driver to eliminate
redundant code and enhance maintainability. Previously, the driver
relied on multiple SoC-specific functions or conditional branching
based on data->soc to handle differences in IRQ register behavior.

Change introduces a unified exynos_tmu_clear_irqs() function
that adapts its behavior using SoC-specific configuration fields
(tmu_intstat, tmu_intclear, and irq_clear_direct) defined in the
exynos_tmu_data structure. These fields are initialized per SoC
during device setup.

This refactor reduces code duplication, simplifies the addition of
new SoC support, and improves overall code clarity.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 52 +++++++++++++++++-----------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index b7522b7b1230..cd21b36674c3 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -172,6 +172,9 @@ enum soc_type {
  *	0 < reference_voltage <= 31
  * @tzd: pointer to thermal_zone_device structure
  * @enabled: current status of TMU device
+ * @tmu_intstat: interrupt status register
+ * @tmu_intclear: interrupt clear register
+ * @irq_clear_support: SoC supports clear IRQ
  * @tmu_set_low_temp: SoC specific method to set trip (falling threshold)
  * @tmu_set_high_temp: SoC specific method to set trip (rising threshold)
  * @tmu_set_crit_temp: SoC specific method to set critical temperature
@@ -198,6 +201,9 @@ struct exynos_tmu_data {
 	u8 reference_voltage;
 	struct thermal_zone_device *tzd;
 	bool enabled;
+	u32 tmu_intstat;
+	u32 tmu_intclear;
+	bool irq_clear_support;
 
 	void (*tmu_set_low_temp)(struct exynos_tmu_data *data, u8 temp);
 	void (*tmu_set_high_temp)(struct exynos_tmu_data *data, u8 temp);
@@ -785,28 +791,15 @@ static irqreturn_t exynos_tmu_threaded_irq(int irq, void *id)
 	return IRQ_HANDLED;
 }
 
-static void exynos4210_tmu_clear_irqs(struct exynos_tmu_data *data)
+static void exynos_tmu_clear_irqs(struct exynos_tmu_data *data)
 {
 	unsigned int val_irq, clearirq = 0;
-	u32 tmu_intstat, tmu_intclear;
-
-	if (data->soc == SOC_ARCH_EXYNOS5260) {
-		tmu_intstat = EXYNOS5260_TMU_REG_INTSTAT;
-		tmu_intclear = EXYNOS5260_TMU_REG_INTCLEAR;
-	} else if (data->soc == SOC_ARCH_EXYNOS7) {
-		tmu_intstat = EXYNOS7_TMU_REG_INTPEND;
-		tmu_intclear = EXYNOS7_TMU_REG_INTPEND;
-	} else if (data->soc == SOC_ARCH_EXYNOS5433) {
-		tmu_intstat = EXYNOS5433_TMU_REG_INTPEND;
-		tmu_intclear = EXYNOS5433_TMU_REG_INTPEND;
-	} else {
-		tmu_intstat = EXYNOS_TMU_REG_INTSTAT;
-		tmu_intclear = EXYNOS_TMU_REG_INTCLEAR;
-	}
+	u32 tmu_intstat = data->tmu_intstat;
+	u32 tmu_intclear = data->tmu_intclear;
 
 	val_irq = readl(data->base + tmu_intstat);
 
-	if (data->soc == SOC_ARCH_EXYNOS4210) {
+	if (!data->irq_clear_support) {
 		writel(val_irq, data->base + tmu_intclear);
 		return;
 	}
@@ -900,12 +893,15 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_initialize = exynos4210_tmu_initialize;
 		data->tmu_control = exynos4210_tmu_control;
 		data->tmu_read = exynos4210_tmu_read;
-		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
+		data->tmu_clear_irqs = exynos_tmu_clear_irqs;
 		data->gain = 15;
 		data->reference_voltage = 7;
 		data->efuse_value = 55;
 		data->min_efuse_value = 40;
 		data->max_efuse_value = 100;
+		data->tmu_intstat = EXYNOS_TMU_REG_INTSTAT;
+		data->tmu_intclear = EXYNOS_TMU_REG_INTCLEAR;
+		data->irq_clear_support = false;
 		break;
 	case SOC_ARCH_EXYNOS3250:
 	case SOC_ARCH_EXYNOS4412:
@@ -922,7 +918,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_control = exynos4210_tmu_control;
 		data->tmu_read = exynos4412_tmu_read;
 		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
-		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
+		data->tmu_clear_irqs = exynos_tmu_clear_irqs;
 		data->gain = 8;
 		data->reference_voltage = 16;
 		data->efuse_value = 55;
@@ -932,6 +928,14 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		else
 			data->min_efuse_value = 0;
 		data->max_efuse_value = 100;
+		data->irq_clear_support = true;
+		if (data->soc == SOC_ARCH_EXYNOS5260) {
+			data->tmu_intstat = EXYNOS5260_TMU_REG_INTSTAT;
+			data->tmu_intclear = EXYNOS5260_TMU_REG_INTCLEAR;
+		} else {
+			data->tmu_intstat = EXYNOS_TMU_REG_INTSTAT;
+			data->tmu_intclear = EXYNOS_TMU_REG_INTCLEAR;
+		}
 		break;
 	case SOC_ARCH_EXYNOS5433:
 		data->tmu_set_low_temp = exynos5433_tmu_set_low_temp;
@@ -943,7 +947,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_control = exynos5433_tmu_control;
 		data->tmu_read = exynos4412_tmu_read;
 		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
-		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
+		data->tmu_clear_irqs = exynos_tmu_clear_irqs;
 		data->gain = 8;
 		if (res.start == EXYNOS5433_G3D_BASE)
 			data->reference_voltage = 23;
@@ -952,6 +956,9 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->efuse_value = 75;
 		data->min_efuse_value = 40;
 		data->max_efuse_value = 150;
+		data->tmu_intstat = EXYNOS5433_TMU_REG_INTPEND;
+		data->tmu_intclear = EXYNOS5433_TMU_REG_INTPEND;
+		data->irq_clear_support = true;
 		break;
 	case SOC_ARCH_EXYNOS7:
 		data->tmu_set_low_temp = exynos7_tmu_set_low_temp;
@@ -963,12 +970,15 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_control = exynos7_tmu_control;
 		data->tmu_read = exynos7_tmu_read;
 		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
-		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
+		data->tmu_clear_irqs = exynos_tmu_clear_irqs;
 		data->gain = 9;
 		data->reference_voltage = 17;
 		data->efuse_value = 75;
 		data->min_efuse_value = 15;
 		data->max_efuse_value = 100;
+		data->tmu_intstat = EXYNOS7_TMU_REG_INTPEND;
+		data->tmu_intclear = EXYNOS7_TMU_REG_INTPEND;
+		data->irq_clear_support = true;
 		break;
 	default:
 		dev_err(&pdev->dev, "Platform not supported\n");
-- 
2.49.0


