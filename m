Return-Path: <linux-pm+bounces-22172-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C045A37752
	for <lists+linux-pm@lfdr.de>; Sun, 16 Feb 2025 20:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FA981688D3
	for <lists+linux-pm@lfdr.de>; Sun, 16 Feb 2025 19:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A561A23B9;
	Sun, 16 Feb 2025 19:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJqjEqAa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DF819A288;
	Sun, 16 Feb 2025 19:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739735957; cv=none; b=swQdS4aW9iq2CFOCtRMDeAVQPFKQxIgVWXV7ZZPZocnXnyfkZFSXS1PJapJPdikqKmplcIk4VY5Ho4WPDbftY32DwfQwoFPtp9iB/t2yjT6hd/Ohwx2WPUHh26BrCRKMwzZNn5sRPSB6RxQEwbYQ8u8pCMYDzmvfvMqRwvA1qe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739735957; c=relaxed/simple;
	bh=u9+wjtzAj/ec4p1ybslaMQR+8HQzN/GJAMqyl2xc7CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXJRYXdNzFiv3Iw4LfGD/YmmGRwhY1HLkmKcPFlhFerDATvV1U7K5Luc/uyJzybMfA2rZYbhoZvB/QNWEIAwf2ZCiLw34sFRSdYqBbQsQVBWvcks7SbiLOp0NbnANF4tPpiJpzt9aTvWD8TUufL9tSMOImTKr0LrC0MFC+cHmDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJqjEqAa; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22104c4de96so19265575ad.3;
        Sun, 16 Feb 2025 11:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739735954; x=1740340754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3vOplXPBv9vPD9lBSm7Gge48LGWl9qyZ2ygjv1+YJc=;
        b=hJqjEqAawtKyDD5oMYQrugDAlFbj6seoiMTnDKvqVMKb7xoOPOAUq4586a9f9y+7bg
         Y5zFRth4gdVB7fbWt6FkE2GYt3cmyNa4hUl5nHD2YEIXaSh9MkA0MwhrMYwf40dajGmX
         dhrFzLFngmszuZ1xgUAWjqdEOoUxyFOJZDvRTExUpK4OCZyqn+2arfr7syOIIZkCkXR8
         tOghdSSXYnPGjjbP320ovNjobQFJHa5+905iiYzYAXKGQ2xzxzrzc0kwtwmS7+Ru+sJq
         ohAronbENuTL8kYu3k1wgsKysrc9HQl9tDU6LRUAxImoHITHEkbIgcKh/rfkVQBQK85j
         bq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739735954; x=1740340754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3vOplXPBv9vPD9lBSm7Gge48LGWl9qyZ2ygjv1+YJc=;
        b=wyH2SVja4ziI5jglunIBVtkAQgSoRKwF2stZ94L+KFp/M6OXOFSkeKCfnA8OqoxnVo
         wgv6UlPQEZBfWgwt7RrKMoLLaIKjdd6FmvsQvT85VXbUU+GxRs9MAsgQj2+veVUPkqEo
         nXMRbtzDnshbtbvw/a4nurmMaAStBd25PSPh+GsodwH1JgxxgeYg9ZZRP3oEe3S1cNXO
         LrEy1abRRxUbM2pZBsP+2QNnKSHP1Ga0uQbgO49JpmO6VjgFwUAA0FnqHiYlAZyXIu3M
         hNJ+oKKhOons499VIoGO+CCLVH/FV43xPtNgxoXIX/gODoeD8HHcg7vBPAze+nCnBAIe
         cy5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTCBNvVRlXdsAL9wtto+wi08mFjSIgyOGAd/Ez1Qh44JcIhGhofSlO+RWlRE+6wRePyngVw520OIVlnbE=@vger.kernel.org, AJvYcCVYxoPKWiSSc8aOsm9wQuHvsVOvVTI9/zt44otNgC2sbNpIN3J4ToO3099hNOLnj/hOyxxmiA8doXZteMNUDaEmLvc=@vger.kernel.org, AJvYcCVi2rIr61HJafHzdcvuiJCC4Wzx9pIydh68ew9C+E+KaD1bW+9YkQ3nSvOAEdk+zG6lj+l2t8pOh6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFQLFSfW8PijA2IYGX9414/a2jq/txSyXQZj5oQrZmMae4oEKJ
	F3FraMlcmfKdeayWrAFFJ44Pz4+LCx1usLDyL7nvr92rFE+JE/+Q
X-Gm-Gg: ASbGnctlwA8Y4wG+siqLH1Bs15suC9K1HZ1fXtx+9omLdbS+mkKU9AwSPaJ4GC1miPw
	0dKliTK9+Sic+dem2ihkCF+nB69IMDYp6yp9IgA/24CYrQzYIxlV9I8pBkvPMQZPChBhUkgfKCK
	N+8VfgOTHcxraViYlSxxoxMm4y7jCIHnF0LwBMUrXjvvvvXQfJCdcAYGpYZt7AswUnyvaVONvaH
	6jc6qaNG6NgWpZR4anMxB17QszSZvXJrjApg6AuH5muJrOqHhdb+bGG7NziRivAOF7iEMvB3/Ei
	eKw1ORwn7tVbNdbQ/Xu1S6ZbALpmJA==
X-Google-Smtp-Source: AGHT+IFGbwIDWIhyF8K5CcWFvD31AIlgT3bB8i3xIlYwtNFzuT2rTMPreGlTXLOnQJiYl5U3hxxNmQ==
X-Received: by 2002:a05:6a20:6a1e:b0:1e1:b727:1801 with SMTP id adf61e73a8af0-1ee8cbc1aeamr12185284637.27.1739735954530;
        Sun, 16 Feb 2025 11:59:14 -0800 (PST)
Received: from localhost.localdomain ([110.44.101.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73265098570sm3023559b3a.22.2025.02.16.11.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 11:59:12 -0800 (PST)
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
Subject: [PATCH v3 1/4] drivers/thermal/exynos: Refactor clk_sec initialization inside SOC-specific case
Date: Mon, 17 Feb 2025 01:28:34 +0530
Message-ID: <20250216195850.5352-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250216195850.5352-1-linux.amoon@gmail.com>
References: <20250216195850.5352-1-linux.amoon@gmail.com>
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
thereby simplifying the code.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v3: improve the commit message
---
 drivers/thermal/samsung/exynos_tmu.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 47a99b3c5395..9c138772d380 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1040,19 +1040,6 @@ static int exynos_tmu_probe(struct platform_device *pdev)
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
@@ -1060,6 +1047,19 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	}
 
 	switch (data->soc) {
+	case SOC_ARCH_EXYNOS5420_TRIMINFO:
+		data->clk_sec = devm_clk_get(dev, "tmu_triminfo_apbif");
+		if (IS_ERR(data->clk_sec)) {
+			return dev_err_probe(dev, PTR_ERR(data->clk_sec),
+					     "Failed to get triminfo clock\n");
+		} else {
+			ret = clk_prepare(data->clk_sec);
+			if (ret) {
+				dev_err(dev, "Failed to get clock\n");
+				return ret;
+			}
+		}
+	break;
 	case SOC_ARCH_EXYNOS5433:
 	case SOC_ARCH_EXYNOS7:
 		data->sclk = devm_clk_get(dev, "tmu_sclk");
-- 
2.48.1


