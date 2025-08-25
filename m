Return-Path: <linux-pm+bounces-33012-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D87DB33D00
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 12:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BA15163692
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 10:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685CE2E0B47;
	Mon, 25 Aug 2025 10:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRjLQfsA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431182DFF22;
	Mon, 25 Aug 2025 10:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756118458; cv=none; b=stEBBd85onrI8HLR6HgnyXI0JBK4G+GPOY4DoGwGNbp2mPTqst4YLFoyxoGBG9oKJM9IcYO4yxryAkSDCBFAEeeVchlkJcTWimLF57EfoJDwT7nlTgN1zAC+od+elCzz9zO8PwJSWiTiLRRyhvOxlJtma7YbUphpjREmhT3YiDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756118458; c=relaxed/simple;
	bh=CMXGyan1mmi1dMEqZVsTBl5PSLejoP74ZPwN8+ompKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUNJtpEXxCaG3USMWMAb5kwiarD7QJWO/JYGD8vs6mPSuGwFqkDID+3L1zDmlEABo9MsOHzJY5ZQ0laqLTdmIzcd/VBYnwqG+/Q6j36rA2wv1vAQe+GbTXdg/ZvkaYhAAy7G6Rdrr4tZczKYgyrGqYzdBj3t0wybrLCltwNUWiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRjLQfsA; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb7a0442bso683910266b.2;
        Mon, 25 Aug 2025 03:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756118454; x=1756723254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnKIz9nHEJ95XCItaOfD3Ca0Wjon4QgJyPWYb+yhaeY=;
        b=jRjLQfsAg77u5a1Z3gUUK4Q+MnuQMQTCvRTSyClviKIuFTyA6Le+I8O1JT+1clThZs
         mcyPsogRtEXL1Kle26dF0h8B8MMS/2i4lBWyhKfshKXFUKHANLQwhyLffO+UA+2iEaYS
         pfkjk4wxLrCB6CnVE4WsbC7SID9641sKFcgZZo5TFBNJgaH4CWLD6O5Qei/kg1vhg5MA
         wvEfBeE38nKHNoRdJi3BbDIBaXdzFf142/CS8f5gjbMkONTYL+ulYUyKKbaA6M/ubf8g
         KkmDA01ATG74iiOFYRUFu4OzMi2/SYmSks5ye6JXV52p5F307GjZCiphgO27HjLQHQKu
         QK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756118454; x=1756723254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wnKIz9nHEJ95XCItaOfD3Ca0Wjon4QgJyPWYb+yhaeY=;
        b=Ld1ouLbe0xkkVsDFGKetOaNxFA+ogfNMMYXXRC7UYT/Z+vQuoWppHpRI62Zy1Jlue0
         Wi78Ch/Cpwn/AudYeKcWrKeIkzQNvQiUIDgz58CHRR6VFdv1IhZaLilkrZkOn9bzf59E
         BRDGzDEjW6scsulZRZdMFq9dmsKla+JGvgQNp7CnXFQvQJ3E9QnBBpHBrOjQadWB93HQ
         X+DOoIadjA/tTi39TVZar2I3npYu8U4kPiA09qbEOrHZjQaGxuz3Cd01+EPovk+t7yKK
         1d2SiJsI+ns7yOo1eGb/SEkEl0lOSxanlV3JrOKVWr+LhHOkrt84D6R9anTccHpLXTo+
         K3qQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4qjwBDkOCQ7z7zH13HF0IQezZDreAjlYMuBzsbjwlyuNt/khvbyQIR/58x/QDxuNNELY8KWTySlCA@vger.kernel.org, AJvYcCXojsXeRLGXavpkF6xb+HLSA3XrOxy/gBO2hEmNpF/8Z9jPvbTAIcpPKZGH3OqC+HKq5X7nav0KVfh0XWM=@vger.kernel.org, AJvYcCXusZLLPiBapfIy23rDJ2xs8UEDMOR4rOd7E5JIWeVm5U+vLPCVKPB19b+Rqt4xo0QM5TNSAx6ZNt8cpcJf@vger.kernel.org
X-Gm-Message-State: AOJu0YwjFJY9jMmJkckiuTzheVENraQj1GL4xDeAWi+kU/0h3GU6ShJT
	XQ594uni1EZSwjA+//Qb0Z0/9I9XsVfKrV+nnG3O07swLE0p/jbM8X0l
X-Gm-Gg: ASbGncvQvTy1AfatPJtp756ajT7JSREkBSmikgMT1pzYplcjJm1pwzKwtW8yU+qpPt6
	8k2YK1cqrUAAFIyjJhSEDzsGYykyvIngjhthsx0DxVJS5PrsrqHK0sxzOokCZJKB55D2CYqnHhf
	lDCLvK36K9us90gqmK7upFTFwYmjYrs8Z+dhhBZwJp95r0FmHOdEyt68efgrUExWOKZYuH3TcZI
	z4IaVks5mF820tQnuvYcVkVS7Zp4sV3LgCHDmZckIXnP1CJrxNu8v53ftxap8ci6eMt88QAgF6w
	PuYRWJqJoNRWPGGeZbgYOkZK34P4PvTUZ6N0JIDb7Ta0o+hc3SR33Qw9WiKaX6UTQ4zBfjWj7M8
	htEGTjl+ztbmp+A==
X-Google-Smtp-Source: AGHT+IGfOGHbaewzwZHlD3JKTq0m9oqX3rR+1CiqKKvPziqMkYcR3fF61yk0PmVT02Gv8Am1qoToBQ==
X-Received: by 2002:a17:907:6e92:b0:af9:5b3f:2dfc with SMTP id a640c23a62f3a-afe2965ac9fmr925010466b.47.1756118454081;
        Mon, 25 Aug 2025 03:40:54 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe48fc0912sm531683166b.42.2025.08.25.03.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 03:40:53 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/6] thermal: tegra: add Tegra114 specific SOCTHERM driver
Date: Mon, 25 Aug 2025 13:40:25 +0300
Message-ID: <20250825104026.127911-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250825104026.127911-1-clamor95@gmail.com>
References: <20250825104026.127911-1-clamor95@gmail.com>
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
 drivers/thermal/tegra/tegra114-soctherm.c | 209 ++++++++++++++++++++++
 4 files changed, 220 insertions(+)
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
index 926f1052e6de..bfc438fbdc59 100644
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
index 083388094fd4..aa4af9268b05 100644
--- a/drivers/thermal/tegra/soctherm.h
+++ b/drivers/thermal/tegra/soctherm.h
@@ -142,6 +142,10 @@ int tegra_calc_tsensor_calib(const struct tegra_tsensor *sensor,
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
index 000000000000..a573a9d1439c
--- /dev/null
+++ b/drivers/thermal/tegra/tegra114-soctherm.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2014-2018, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2024, Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <dt-bindings/thermal/tegra114-soctherm.h>
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
+	.id = TEGRA114_SOCTHERM_SENSOR_CPU,
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
+	.id = TEGRA114_SOCTHERM_SENSOR_GPU,
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
+	.id = TEGRA114_SOCTHERM_SENSOR_PLLX,
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
+	.id = TEGRA114_SOCTHERM_SENSOR_MEM,
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
+	.fuse_common_reg = FUSE_VSENSOR_CALIB,
+	.fuse_spare_realignment = 0,
+	.nominal_calib_ft = 90,
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


