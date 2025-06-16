Return-Path: <linux-pm+bounces-28840-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1018ADB727
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 18:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C038516A366
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 16:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5D4288537;
	Mon, 16 Jun 2025 16:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaoFuEBX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9997E287508;
	Mon, 16 Jun 2025 16:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750091943; cv=none; b=blW3P5fUgS9FK7IS1JNXR9HZ/2rpmEOKIyydwmIhbwJ0a/Iy3r/yBHHHVfPohZ0EO3lwxgKgQwf/g8E6snMvwtXG8vapbpYbuCQ76gR8B8PbawnRSv63ZVXckwXVxX0VZU+7VfjB/YLReM8rMRT9OrgVUtSKYlVHdIe+urSyqcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750091943; c=relaxed/simple;
	bh=JHwI4bSXu2TwYqi6AtexeppNIMEdlznZcrt0pgVx8Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7NEi2nqjTrauyZNXD6a57MGgFxIIxpwsWyNzsAsRdeZe217gHt9YnMOZ0V0oOcq+jwD//17R1SZrFQ3gtxF11vFoVNPJXTsgGM7uUqnpTNwoQVZOl4fB4At9w/boXnu2a8XUevi5jcxXHm/C6Je47+Nr9zDpvKdOsIbNzIwd7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaoFuEBX; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b3182c6d03bso2951915a12.0;
        Mon, 16 Jun 2025 09:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750091941; x=1750696741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpVHF9b+TYLO9CyHvJ3z28yz3dh71Y+srhHA13+SNnY=;
        b=KaoFuEBXV7fFbtLGki2YTZDM+CNEnlahO0A0wE09Luf2gVG1G+Ml9O8BewD0yNd4Kw
         Kq63qmoqfyUukBDBNqsyDxREnGgoZzhTMdQrmoyHBI9yGKrJ/VqEwbcx0lag28FL9kki
         WZIOBkcBkIWA5NVRI8B/Xwt5tvcUlXvlukWpMO/lPIv7TPqjIw3XIjLqu8XZXl5uoGt8
         rE+lOUQN859gcli1oWg3gsnf/mGFyUmnQgiGzLQK9SvH5IWVA5yxWpFNth5nDM0VJrAo
         zIPDVRrV6sCuEHc1L5WWVh4iyuv2fOTJuHHmkxOx9AtTUpBvLrRvtarNSzzkWKK9P4yv
         GzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750091941; x=1750696741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VpVHF9b+TYLO9CyHvJ3z28yz3dh71Y+srhHA13+SNnY=;
        b=ZD5RarQDwQCvdQMR0bp925k6G2LWre5a4DsJzla6pRfRMvRtUCWd4BVeMworWRp+tR
         SdCS2v3yzCIAXPigkIER2GOdRuHC2VYBVVKLEINKWzwAa11QYlxHP5BeAIW+5Bb8QIs7
         jGuZ74yfFtpiaM9WYstS9bdOJEz6b+maqxWRqj2ocviLu5vDqkdeCFh23NM43Kv9HoqV
         rbmgJzEujebeiTBmn5V1VO179zdU0s6erUsoRjvN9KcZIX1WXzYto+oFeJ+NCsPDXuCa
         a7eVEnIa4GUaXLqOamTX1WbwEpSSImu35MxsqtQcR4AMJhlcefey4TbfcCccmG3R4r8S
         Vjeg==
X-Forwarded-Encrypted: i=1; AJvYcCUnzDhY/D9EWTcnKdddRc1wFplz+/BzxHmBgGFCBHdIH1j18Mozfwt7nY9lbevGDuGq7YDB7VIudykLr/SiZWGiiHU=@vger.kernel.org, AJvYcCWLcb5FWpB4estUx9cuWrTwVQ6iexiNlAAEP44RGdpBodoqtmjIYX7uAEM3WhyhRZwEVV/0Nly/5EFDQpA=@vger.kernel.org, AJvYcCXHkgjjFhJVxpSYt9VRF2NjTUjBRwvFghJVel8vLbn3s/OyEHq54OXtpZGVZLOiPQzG6Q9YZkIEWu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAaUIC2MHGLwXUvVyU3qSWY0rXnsTmrlt9wq0TQ3lV6hFqVXfY
	ZS6Vxe6bLLtqny9HsHsXihB/IClAKc9hPqvTpkl1ZAdMLLaQG6kENfk1
X-Gm-Gg: ASbGnctmIZZTtf0dKOx3ZLgM86uh2+57wx2T7yEUs1xbfMwTbxBxz88ccgMI7j7Xm59
	mdSLK080h6Fof/21/Y+iYQgVYQ0xfOaOZsGz0Y+02qDowreGuLl/0KVXKAkB87xjN78rOhy/K3I
	R1hk6heGTtAdvxQAs6vyVdaTeSekWi6CUJBGGzmW4R0hWNT8lbpH4FHz97U09Toxf23hxyWJ+O3
	rUUB4zCPjM6U6IoAELEzP8zNzTFT9Jb65sJcfQOQSG3pIzKMggstiW2AdKx1FA/IOcxwoUj8i/Y
	mG2o/vJSIDvI1ViL7X1UmkzT9UrYXOLlge8uzgbcqG3ChQPPhZvqxaytIfKbyTyzHe+j1+A8wYp
	xjnHfuBj77Q==
X-Google-Smtp-Source: AGHT+IHksnpc6Nrc2cLyvfXLBdusiyK6+4cw/aWIy5ueWnJxdLHpYjX6PbGSrX/CQnj0tbplZYI92Q==
X-Received: by 2002:a05:6a20:a115:b0:218:c01:ddce with SMTP id adf61e73a8af0-21fbd5d90aemr16898139637.40.1750091940932;
        Mon, 16 Jun 2025 09:39:00 -0700 (PDT)
Received: from localhost.localdomain ([45.112.0.181])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1680c6asm6067882a12.42.2025.06.16.09.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 09:39:00 -0700 (PDT)
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
Subject: [RRC v1 1/3] thermal/drivers/exynos: Remove unused base_second mapping and references
Date: Mon, 16 Jun 2025 22:08:22 +0530
Message-ID: <20250616163831.8138-2-linux.amoon@gmail.com>
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

Following change removes the base_second field eliminates its mapping
in exynos_map_dt_data(), and updates the TRIMINFO access logic in
exynos4412_tmu_initialize() to use base for both Exynos5420 and
Exynos5420_TRIMINFO SoCs, as base_second is not used further in
in this code.
This cleanup simplifies the code and reduces unnecessary
memory mapping.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 47a99b3c5395..c625eddcb9f3 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -139,12 +139,11 @@ enum soc_type {
  * struct exynos_tmu_data : A structure to hold the private data of the TMU
  *			    driver
  * @base: base address of the single instance of the TMU controller.
- * @base_second: base address of the common registers of the TMU controller.
  * @irq: irq number of the TMU controller.
  * @soc: id of the SOC type.
  * @lock: lock to implement synchronization.
  * @clk: pointer to the clock structure.
- * @clk_sec: pointer to the clock structure for accessing the base_second.
+ * @clk_sec: pointer to the clock structure for accessing the gpu clk.
  * @sclk: pointer to the clock structure for accessing the tmu special clk.
  * @cal_type: calibration type for temperature
  * @efuse_value: SoC defined fuse value
@@ -172,7 +171,6 @@ enum soc_type {
  */
 struct exynos_tmu_data {
 	void __iomem *base;
-	void __iomem *base_second;
 	int irq;
 	enum soc_type soc;
 	struct mutex lock;
@@ -460,12 +458,11 @@ static void exynos4412_tmu_initialize(struct platform_device *pdev)
 	}
 
 	/* On exynos5420 the triminfo register is in the shared space */
-	if (data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO)
-		trim_info = readl(data->base_second + EXYNOS_TMU_REG_TRIMINFO);
-	else
+	if (data->soc == SOC_ARCH_EXYNOS5420 ||
+			data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO) {
 		trim_info = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
-
-	sanitize_temp_error(data, trim_info);
+		sanitize_temp_error(data, trim_info);
+	}
 }
 
 static void exynos5433_tmu_set_low_temp(struct exynos_tmu_data *data, u8 temp)
@@ -964,13 +961,6 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	data->base_second = devm_ioremap(&pdev->dev, res.start,
-					resource_size(&res));
-	if (!data->base_second) {
-		dev_err(&pdev->dev, "Failed to ioremap memory\n");
-		return -ENOMEM;
-	}
-
 	return 0;
 }
 
-- 
2.49.0


