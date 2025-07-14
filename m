Return-Path: <linux-pm+bounces-30774-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C61B03973
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 10:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484A1176BB4
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 08:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC717241668;
	Mon, 14 Jul 2025 08:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTZupbhV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C127523E350;
	Mon, 14 Jul 2025 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752481398; cv=none; b=Jx4ipMSBMzgf3sdTRo88CvCXZvqxRMFxQ5sSEtCz2H/qjFvfF5YzeYFBzB7ykXhcpMGbeEZwPM0KVElHztpGANR6jMbrzLC4afNo1xm8F40cskZj/1hKdQGRWJtJ0FkaAhnwWdOZiyiqm+IcJPYQeYvidlzIWuPP7vzunGZv6CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752481398; c=relaxed/simple;
	bh=HN4x+rGbwFeeGQ9jkNrN2rjGKUNghNgRdAhOiIYBkVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RbtjY2w4YHYZgaHbHFGzKoVVY6UNDE+mZ5BSogRpHUis/kWk4untOQTlT1FuyF05RBOeFhoXh9TzE9nGBwl4xhu/VTKReDkk6jrr9VmIUzRcJeDch5wUaNfY/m5mWON2kIRynuS3T5xQMvQiUUzo2dtSQ2sM0wqT/PtkQr+Vz5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTZupbhV; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55a10c74f31so1019381e87.1;
        Mon, 14 Jul 2025 01:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752481394; x=1753086194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n161/sPnFiwcbLYbE50unUbqsgVzUjhparEDLVM1oPc=;
        b=jTZupbhVunmiPEQMgv0ex3m5ebJLCHdV7n0WyD3TbJ10cDGaLLUKPqGNJrfEo8eSZ6
         VV0KQ/yaImUQVT2qG/qhWAl7/OmYjJq8LgIpK4qfl5QXy0s4BRwxWLLBgLjBRX145Dv5
         XibYLN4rAVsG7mhCTMW/yc9FA58aIrQcMGCuxANnfr/zX6kRKFDCk/VwTMe6S7FYAi8X
         jf9wqIFkG2aoCyoEofODhffdQo3LczmFskB+USVOGJ+N948LoYQPq6ec5ee3sB3kYwEQ
         vBoBXkXKHn36B/CXglAp44uSigqWcycAXcmyaxhUYGzZAwITqU/d9cnkK8o1LBJW2QE8
         /Jug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752481394; x=1753086194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n161/sPnFiwcbLYbE50unUbqsgVzUjhparEDLVM1oPc=;
        b=ttu/D0Jr8l8c/dJpMwpqQ42XyyKPIjJM2ThK3udV6HGUK5Ug08bqmTBBgaawYd5XqB
         J8Gjsvxg19659lOdRWml2Nz3zeg4iY5tgINNoMFfw3j5zensukRIxgh5und6NVXjfWea
         0jqPbtC71J2qLUS+DgQlYHeNWFqriOP20qriBuumlPnRivOX7z8dLndGicqmDfubaPoz
         L/qRtF1jqH3gxeT/6zMrM/UoJSAeJqBbpci2iJWUBaaox5FrO5mgTOu8qEFavURB6mQu
         dLjwYUAqbA8J4XhXOC9j+5WlXiJG3EJcwWLXC56kAUL5omKLBUnKeYRCXFfBXlZB8rDE
         A60A==
X-Forwarded-Encrypted: i=1; AJvYcCUjNe3Hm5gZl+YpuV5c/EqQhDfLSgzWAcL8+TAlWSy8ibTTcI6XSMwF81zf0UQBnSDa2sSguIeam31UUb2I@vger.kernel.org, AJvYcCW3fXROFxMSilqBLXfo2ilx8iBVZZuvJrVWtWGZXu9DF3vu6rkpr4gK6GLtNjgr8X0VvFKJAfRHIszS@vger.kernel.org, AJvYcCW8RHfjK1KrIbZQCPTANsp8RwmWIa7QDds6D/fsXCx/+hbbPihhmf96dowGMmd/8WbXNfEzOj6AHo8Ik1U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu4GJ9ufn1ZHLf5BmeHK5qirpriUTx9PIJOKssadRnQnsL0CDh
	0NDn35Vk/aQ5DKEOC3Rhz0mZL3fBjJCTqvi0QfaIebacYLu7brJIuB6v
X-Gm-Gg: ASbGncsWn5ekXk9UVUNX/fdalSLeXSPJV9kppeJwvVdgXbuOhXCAmgu1gQTJM+s3e4j
	u50mdK+Y1tJzVh5N515OIln81ENOWJyWn4mAyPXN2OcLQG4bugKBvSQEfnhsPMti2d5WEtlPFHh
	FnWcFORRwdrrxNCIdGzUMIRl5Au1x/G7xrz18QVkdc2mR1Jp8b14JAbIwn6YKn6RRFO5qZ0tHtF
	W1/5KaS3YAEK8TqcluZk6OETFreb4NNh1im2NGRCObcNFcVf6+Lf8EnvdoVQFuQEaBoAin7+z8u
	kDuXC2Y0mXx48bFjP2oASt89VJSOGgBC0tzwv3u5ZCeoE1WVX+9oZXF7FIFcC8rgnLxDfiFldaY
	Ur0zKgEZ4Nejlbw==
X-Google-Smtp-Source: AGHT+IEUUG5cBKShW5NaWvde+aF8M8RHEwkoUq29euhOPK2At83JPy6xfJiQTYlcS4gbwVfx4SRVug==
X-Received: by 2002:a05:6512:10d6:b0:553:a3b0:4d2b with SMTP id 2adb3069b0e04-55a044c96cdmr3265169e87.6.1752481393583;
        Mon, 14 Jul 2025 01:23:13 -0700 (PDT)
Received: from xeon.. ([188.163.112.60])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7bbd55sm1885717e87.23.2025.07.14.01.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 01:23:13 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] thermal: tegra: add Tegra114 specific SOCTHERM driver
Date: Mon, 14 Jul 2025 11:22:51 +0300
Message-ID: <20250714082252.9028-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250714082252.9028-1-clamor95@gmail.com>
References: <20250714082252.9028-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Tegra114 specific SOCTHERM driver.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/thermal/tegra/Makefile            |   1 +
 drivers/thermal/tegra/soctherm.c          |   6 +
 drivers/thermal/tegra/soctherm.h          |   4 +
 drivers/thermal/tegra/tegra114-soctherm.c | 213 ++++++++++++++++++++++
 4 files changed, 224 insertions(+)
 create mode 100644 drivers/thermal/tegra/tegra114-soctherm.c

diff --git a/drivers/thermal/tegra/Makefile b/drivers/thermal/tegra/Makefile
index eb27d194c583..9b3e91f7fb97 100644
--- a/drivers/thermal/tegra/Makefile
+++ b/drivers/thermal/tegra/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_TEGRA_BPMP_THERMAL)	+= tegra-bpmp-thermal.o
 obj-$(CONFIG_TEGRA30_TSENSOR)		+= tegra30-tsensor.o
 
 tegra-soctherm-y				:= soctherm.o soctherm-fuse.o
+tegra-soctherm-$(CONFIG_ARCH_TEGRA_114_SOC)	+= tegra114-soctherm.o
 tegra-soctherm-$(CONFIG_ARCH_TEGRA_124_SOC)	+= tegra124-soctherm.o
 tegra-soctherm-$(CONFIG_ARCH_TEGRA_132_SOC)	+= tegra132-soctherm.o
 tegra-soctherm-$(CONFIG_ARCH_TEGRA_210_SOC)	+= tegra210-soctherm.o
diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 2c5ddf0db40c..7bdab2add7af 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -2048,6 +2048,12 @@ static void soctherm_init(struct platform_device *pdev)
 }
 
 static const struct of_device_id tegra_soctherm_of_match[] = {
+#ifdef CONFIG_ARCH_TEGRA_114_SOC
+	{
+		.compatible = "nvidia,tegra114-soctherm",
+		.data = &tegra114_soctherm,
+	},
+#endif
 #ifdef CONFIG_ARCH_TEGRA_124_SOC
 	{
 		.compatible = "nvidia,tegra124-soctherm",
diff --git a/drivers/thermal/tegra/soctherm.h b/drivers/thermal/tegra/soctherm.h
index 6c0e0cc594a5..75ee2a520886 100644
--- a/drivers/thermal/tegra/soctherm.h
+++ b/drivers/thermal/tegra/soctherm.h
@@ -148,6 +148,10 @@ int tegra_calc_tsensor_calib(const struct tegra_tsensor *sensor,
 			     const struct tsensor_shared_calib *shared,
 			     u32 *calib);
 
+#ifdef CONFIG_ARCH_TEGRA_114_SOC
+extern const struct tegra_soctherm_soc tegra114_soctherm;
+#endif
+
 #ifdef CONFIG_ARCH_TEGRA_124_SOC
 extern const struct tegra_soctherm_soc tegra124_soctherm;
 #endif
diff --git a/drivers/thermal/tegra/tegra114-soctherm.c b/drivers/thermal/tegra/tegra114-soctherm.c
new file mode 100644
index 000000000000..eca65ec6f8c1
--- /dev/null
+++ b/drivers/thermal/tegra/tegra114-soctherm.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2014-2018, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2024, Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <dt-bindings/thermal/tegra124-soctherm.h>
+
+#include "soctherm.h"
+
+#define TEGRA114_THERMTRIP_ANY_EN_MASK		(0x1 << 28)
+#define TEGRA114_THERMTRIP_MEM_EN_MASK		(0x1 << 27)
+#define TEGRA114_THERMTRIP_GPU_EN_MASK		(0x1 << 26)
+#define TEGRA114_THERMTRIP_CPU_EN_MASK		(0x1 << 25)
+#define TEGRA114_THERMTRIP_TSENSE_EN_MASK	(0x1 << 24)
+#define TEGRA114_THERMTRIP_GPUMEM_THRESH_MASK	(0xff << 16)
+#define TEGRA114_THERMTRIP_CPU_THRESH_MASK	(0xff << 8)
+#define TEGRA114_THERMTRIP_TSENSE_THRESH_MASK	0xff
+
+#define TEGRA114_THERMCTL_LVL0_UP_THRESH_MASK	(0xff << 17)
+#define TEGRA114_THERMCTL_LVL0_DN_THRESH_MASK	(0xff << 9)
+
+#define TEGRA114_THRESH_GRAIN			1000
+#define TEGRA114_BPTT				8
+
+static const struct tegra_tsensor_configuration tegra114_tsensor_config = {
+	.tall = 16300,
+	.tiddq_en = 1,
+	.ten_count = 1,
+	.tsample = 163,
+	.tsample_ate = 655,
+};
+
+static const struct tegra_tsensor_group tegra114_tsensor_group_cpu = {
+	.id = TEGRA124_SOCTHERM_SENSOR_CPU,
+	.name = "cpu",
+	.sensor_temp_offset = SENSOR_TEMP1,
+	.sensor_temp_mask = SENSOR_TEMP1_CPU_TEMP_MASK,
+	.pdiv = 10,
+	.pdiv_ate = 10,
+	.pdiv_mask = SENSOR_PDIV_CPU_MASK,
+	.pllx_hotspot_diff = 10,
+	.pllx_hotspot_mask = SENSOR_HOTSPOT_CPU_MASK,
+	.thermtrip_any_en_mask = TEGRA114_THERMTRIP_ANY_EN_MASK,
+	.thermtrip_enable_mask = TEGRA114_THERMTRIP_CPU_EN_MASK,
+	.thermtrip_threshold_mask = TEGRA114_THERMTRIP_CPU_THRESH_MASK,
+	.thermctl_isr_mask = THERM_IRQ_CPU_MASK,
+	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_CPU,
+	.thermctl_lvl0_up_thresh_mask = TEGRA114_THERMCTL_LVL0_UP_THRESH_MASK,
+	.thermctl_lvl0_dn_thresh_mask = TEGRA114_THERMCTL_LVL0_DN_THRESH_MASK,
+};
+
+static const struct tegra_tsensor_group tegra114_tsensor_group_gpu = {
+	.id = TEGRA124_SOCTHERM_SENSOR_GPU,
+	.name = "gpu",
+	.sensor_temp_offset = SENSOR_TEMP1,
+	.sensor_temp_mask = SENSOR_TEMP1_GPU_TEMP_MASK,
+	.pdiv = 10,
+	.pdiv_ate = 10,
+	.pdiv_mask = SENSOR_PDIV_GPU_MASK,
+	.pllx_hotspot_diff = 5,
+	.pllx_hotspot_mask = SENSOR_HOTSPOT_GPU_MASK,
+	.thermtrip_any_en_mask = TEGRA114_THERMTRIP_ANY_EN_MASK,
+	.thermtrip_enable_mask = TEGRA114_THERMTRIP_GPU_EN_MASK,
+	.thermtrip_threshold_mask = TEGRA114_THERMTRIP_GPUMEM_THRESH_MASK,
+	.thermctl_isr_mask = THERM_IRQ_GPU_MASK,
+	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_GPU,
+	.thermctl_lvl0_up_thresh_mask = TEGRA114_THERMCTL_LVL0_UP_THRESH_MASK,
+	.thermctl_lvl0_dn_thresh_mask = TEGRA114_THERMCTL_LVL0_DN_THRESH_MASK,
+};
+
+static const struct tegra_tsensor_group tegra114_tsensor_group_pll = {
+	.id = TEGRA124_SOCTHERM_SENSOR_PLLX,
+	.name = "pll",
+	.sensor_temp_offset = SENSOR_TEMP2,
+	.sensor_temp_mask = SENSOR_TEMP2_PLLX_TEMP_MASK,
+	.pdiv = 10,
+	.pdiv_ate = 10,
+	.pdiv_mask = SENSOR_PDIV_PLLX_MASK,
+	.thermtrip_any_en_mask = TEGRA114_THERMTRIP_ANY_EN_MASK,
+	.thermtrip_enable_mask = TEGRA114_THERMTRIP_TSENSE_EN_MASK,
+	.thermtrip_threshold_mask = TEGRA114_THERMTRIP_TSENSE_THRESH_MASK,
+	.thermctl_isr_mask = THERM_IRQ_TSENSE_MASK,
+	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_TSENSE,
+	.thermctl_lvl0_up_thresh_mask = TEGRA114_THERMCTL_LVL0_UP_THRESH_MASK,
+	.thermctl_lvl0_dn_thresh_mask = TEGRA114_THERMCTL_LVL0_DN_THRESH_MASK,
+};
+
+static const struct tegra_tsensor_group tegra114_tsensor_group_mem = {
+	.id = TEGRA124_SOCTHERM_SENSOR_MEM,
+	.name = "mem",
+	.sensor_temp_offset = SENSOR_TEMP2,
+	.sensor_temp_mask = SENSOR_TEMP2_MEM_TEMP_MASK,
+	.pdiv = 10,
+	.pdiv_ate = 10,
+	.pdiv_mask = SENSOR_PDIV_MEM_MASK,
+	.pllx_hotspot_diff = 0,
+	.pllx_hotspot_mask = SENSOR_HOTSPOT_MEM_MASK,
+	.thermtrip_any_en_mask = TEGRA114_THERMTRIP_ANY_EN_MASK,
+	.thermtrip_enable_mask = TEGRA114_THERMTRIP_MEM_EN_MASK,
+	.thermtrip_threshold_mask = TEGRA114_THERMTRIP_GPUMEM_THRESH_MASK,
+	.thermctl_isr_mask = THERM_IRQ_MEM_MASK,
+	.thermctl_lvl0_offset = THERMCTL_LEVEL0_GROUP_MEM,
+	.thermctl_lvl0_up_thresh_mask = TEGRA114_THERMCTL_LVL0_UP_THRESH_MASK,
+	.thermctl_lvl0_dn_thresh_mask = TEGRA114_THERMCTL_LVL0_DN_THRESH_MASK,
+};
+
+static const struct tegra_tsensor_group *tegra114_tsensor_groups[] = {
+	&tegra114_tsensor_group_cpu,
+	&tegra114_tsensor_group_gpu,
+	&tegra114_tsensor_group_pll,
+	&tegra114_tsensor_group_mem,
+};
+
+static const struct tegra_tsensor tegra114_tsensors[] = {
+	{
+		.name = "cpu0",
+		.base = 0xc0,
+		.config = &tegra114_tsensor_config,
+		.calib_fuse_offset = 0x098,
+		.fuse_corr_alpha = 1196400,
+		.fuse_corr_beta = -13600000,
+		.group = &tegra114_tsensor_group_cpu,
+	}, {
+		.name = "cpu1",
+		.base = 0xe0,
+		.config = &tegra114_tsensor_config,
+		.calib_fuse_offset = 0x084,
+		.fuse_corr_alpha = 1196400,
+		.fuse_corr_beta = -13600000,
+		.group = &tegra114_tsensor_group_cpu,
+	}, {
+		.name = "cpu2",
+		.base = 0x100,
+		.config = &tegra114_tsensor_config,
+		.calib_fuse_offset = 0x088,
+		.fuse_corr_alpha = 1196400,
+		.fuse_corr_beta = -13600000,
+		.group = &tegra114_tsensor_group_cpu,
+	}, {
+		.name = "cpu3",
+		.base = 0x120,
+		.config = &tegra114_tsensor_config,
+		.calib_fuse_offset = 0x12c,
+		.fuse_corr_alpha = 1196400,
+		.fuse_corr_beta = -13600000,
+		.group = &tegra114_tsensor_group_cpu,
+	}, {
+		.name = "mem0",
+		.base = 0x140,
+		.config = &tegra114_tsensor_config,
+		.calib_fuse_offset = 0x158,
+		.fuse_corr_alpha = 1000000,
+		.fuse_corr_beta = 0,
+		.group = &tegra114_tsensor_group_mem,
+	}, {
+		.name = "mem1",
+		.base = 0x160,
+		.config = &tegra114_tsensor_config,
+		.calib_fuse_offset = 0x15c,
+		.fuse_corr_alpha = 1000000,
+		.fuse_corr_beta = 0,
+		.group = &tegra114_tsensor_group_mem,
+	}, {
+		.name = "gpu",
+		.base = 0x180,
+		.config = &tegra114_tsensor_config,
+		.calib_fuse_offset = 0x154,
+		.fuse_corr_alpha = 1124500,
+		.fuse_corr_beta = -9793100,
+		.group = &tegra114_tsensor_group_gpu,
+	}, {
+		.name = "pllx",
+		.base = 0x1a0,
+		.config = &tegra114_tsensor_config,
+		.calib_fuse_offset = 0x160,
+		.fuse_corr_alpha = 1224200,
+		.fuse_corr_beta = -14665000,
+		.group = &tegra114_tsensor_group_pll,
+	},
+};
+
+static const struct tegra_soctherm_fuse tegra114_soctherm_fuse = {
+	.fuse_base_cp_mask = 0x3ff,
+	.fuse_base_cp_shift = 0,
+	.fuse_shift_cp_mask = 0x3f << 10,
+	.fuse_shift_cp_shift = 10,
+	.fuse_base_ft_mask = 0x7ff << 16,
+	.fuse_base_ft_shift = 16,
+	.fuse_shift_ft_mask = 0x1f << 27,
+	.fuse_shift_ft_shift = 27,
+	.fuse_shift_cp_bits = 6,
+	.fuse_shift_ft_bits = 5,
+	.fuse_common_reg = FUSE_VSENSOR_CALIB,
+	.fuse_spare_realignment = 0,
+	.nominal_calib_cp = NOMINAL_CALIB_CP,
+	.nominal_calib_ft = T114X_CALIB_FT,
+	.lower_precision = true,
+};
+
+const struct tegra_soctherm_soc tegra114_soctherm = {
+	.tsensors = tegra114_tsensors,
+	.num_tsensors = ARRAY_SIZE(tegra114_tsensors),
+	.ttgs = tegra114_tsensor_groups,
+	.num_ttgs = ARRAY_SIZE(tegra114_tsensor_groups),
+	.tfuse = &tegra114_soctherm_fuse,
+	.thresh_grain = TEGRA114_THRESH_GRAIN,
+	.bptt = TEGRA114_BPTT,
+	.use_ccroc = false,
+};
-- 
2.48.1


