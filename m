Return-Path: <linux-pm+bounces-32711-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F17B2DB92
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 13:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB741C805E8
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 11:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4AD2F39DC;
	Wed, 20 Aug 2025 11:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KF3bogee"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921092EF66A;
	Wed, 20 Aug 2025 11:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755690186; cv=none; b=sE0UPagUEc0GPtLXxSPhSTHuR7qY2JtzFVOrq5bxE/B2vinurLNqZ7Kkuthc+BiO0Pq/W5LDZW0EqQBSERHppxNFjAX06rzcvCRZcd04ZWqQaeR347eg3l2own6P/fooYM0NifoSEQ3oV0kDoP4qnwe3yKUBul3FPoYD1XW3dg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755690186; c=relaxed/simple;
	bh=lI97cAu+nx9eD9tUER/WcFEXIb4QdB4h/OqTuuqxWO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtcnLlutieb9WHbSx7q1iH9mW+3oS1BinGJn8TTWJ5hPqeM61XoJk6/mvS68FNE6rhLg/+D4khoBwxO+Xb2vV43AD77U1OtAxfShyDlKbIaMBcbwaN036nDqCpUsflA3lWXjqWMyb8GjGVeEPWZLnNv7ocBnA1cnX3XIj3oz5YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KF3bogee; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb732eee6so1027691266b.0;
        Wed, 20 Aug 2025 04:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755690183; x=1756294983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7U/FOKt8siWMhnTlVejCBSD82ngrEWU322Y+IFCdkEo=;
        b=KF3bogee7oynIFrS6+6cLbwY6hpcqbDm8rmOk5uRsZS830kBWQ0DyAqUUbwDHMPNeU
         ZT0eRPMtV0g+fPdLOi2KduxtWZq4yCUkNiRcBMaaNFxzlV2D2AK9rPWHe6iA0QHxWGFK
         TcIlCneWESkUDaVmOmkhlevCdyzqa0XhQQScl+c25MZnB0fwpjQMXU/7fCYw3QLLPJrz
         DTJWK4Nm0PilXRuw7rfdKjDkHvue5WgWYgbZbvwbpyvtuoHRLo7UIbI+z+ODrjxBXgRt
         fM0zqvp8ZUZYYZpHNU//u3kFCmgUK+mjp7IRmkh0Gf1/iZqh3tbHX2z+koz8UJABpiP2
         /ezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755690183; x=1756294983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7U/FOKt8siWMhnTlVejCBSD82ngrEWU322Y+IFCdkEo=;
        b=vS6AzpwWdbEcXhcQ/FMKCvEIcSa6PDUtnrylHvaIw26T3X21LES9hsJfPNfLEMzMHG
         X2xByDlud1WILBxzEprr9yN4EVmEtSRdY0XZO203G/xigBWAbKtrrl4wz/7t9BwLkh6e
         B5IzPyi0x8brnB6ESSeOwZ/LvOSeFlg9V/iL1y7I0A+FdhAmzg6JF7Hvv8XNzIoZqr+5
         YkIwDWOxQEyXJVzAmMbn4qLraa0wTQgJBwRHG+CPnDbWHQ52fyQVGNFTLij9l7qgW8U2
         B8AtjCN7iJF2Fxr5SsBJ/hbKPtW8kuatFkmZ09ZqbTpSIuQQ3DelxeESYA1PPKlK2MDJ
         S6xw==
X-Forwarded-Encrypted: i=1; AJvYcCVEnMnhuk9ilM+KRwh9BzjmHC9gK4jR7CkmuGHvW4sVVymQBcahWsibN3Z54cZjdOsiiBZCvS7lRGYFI3/2@vger.kernel.org, AJvYcCVUufoPto3cwED8NJtE3m/DdRvHFaY/WjczMGCDHJan9OFtm5v9lyJKcXb9AasWeuelxWppkguXBN/FPoM=@vger.kernel.org, AJvYcCWMl975DCxIRWS97qmtN4CpFA8ggy5gs6hiaMmG/3ffL6TQDsxJuSFQEO8+k9FJHMCFsYqh9LojM3sB@vger.kernel.org
X-Gm-Message-State: AOJu0Yyod+c4SkxGd3dAxOqxYTNSgNsQycmko76uZQ7LH8Tdq1j0HWde
	16sPv0gg5PwJZZek0L8GN+D6KuvAsQsrrx/CyZ+g3Dua8VEHHvolU9iU
X-Gm-Gg: ASbGncv2B6wPKS1NKlb+bm4MfiTrn9rMR+LZj7O1PszX5U/hB9+A7rKwQS4JVtiFEhr
	kJ0I9XCpCVl0NJpIMQvOU2dfZtyqSvxXukq16iJVU7kzgRbnfcLbI4AxyUDGIzvylC/dTEL8e+c
	RInudpUdpQgSHgQZGKi59t+1JSFSrZPLG1Fg/kJXe8PTz8naq5kjUdXqTW4PunBfQ8APGDEkWDg
	g8w9lg3og5fwkwG3zB5Tiqo8Xp8wm/Z+WwjJY6nO7qBYgYRXfuZ7zo5pcNXAo2Z8Tvnj5dRbVaL
	wjFK2jnHR1Zm7qCkLT9jU3i5sarLbaG3T5Zdh6Mx5AM4B+yrmILZ0nFOgKFXQ6sE8nWjAJffjMS
	w8AUqT/ne1OrAvw==
X-Google-Smtp-Source: AGHT+IFZSncbzrKnaFi8+RPcSdusW8sOemeQOGV3Rfqdz3/c4u/My8ZEI6FJe3642K+59G7JXS0lpQ==
X-Received: by 2002:a17:907:60cd:b0:afc:bf6c:5d82 with SMTP id a640c23a62f3a-afdf020ce37mr220497366b.37.1755690182794;
        Wed, 20 Aug 2025 04:43:02 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded4ca695sm161769566b.90.2025.08.20.04.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:43:02 -0700 (PDT)
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
Subject: [PATCH v3 5/6] thermal: tegra: add Tegra114 specific SOCTHERM driver
Date: Wed, 20 Aug 2025 14:42:30 +0300
Message-ID: <20250820114231.150441-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250820114231.150441-1-clamor95@gmail.com>
References: <20250820114231.150441-1-clamor95@gmail.com>
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
 drivers/thermal/tegra/tegra114-soctherm.c | 211 ++++++++++++++++++++++
 4 files changed, 222 insertions(+)
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
index f8d76ae716fe..3dad3956b59f 100644
--- a/drivers/thermal/tegra/soctherm.h
+++ b/drivers/thermal/tegra/soctherm.h
@@ -143,6 +143,10 @@ int tegra_calc_tsensor_calib(const struct tegra_tsensor *sensor,
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
index 000000000000..8cf57dc8a203
--- /dev/null
+++ b/drivers/thermal/tegra/tegra114-soctherm.c
@@ -0,0 +1,211 @@
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
+	.nominal_calib_cp = 105,
+	.nominal_calib_ft = 90,
+	.use_lower_precision = true,
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


