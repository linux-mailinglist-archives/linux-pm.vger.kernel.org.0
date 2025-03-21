Return-Path: <linux-pm+bounces-24385-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0519A6BDAE
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 15:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C05E47A5275
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 14:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3117522578A;
	Fri, 21 Mar 2025 14:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTXm30RO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173BF1E47CC;
	Fri, 21 Mar 2025 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742568838; cv=none; b=IcUwXbBsq2HTefrhbOJFuFGTX8LLL28kgHv5CvcUpBvbJwcBTseHp9lERMBIs2hH0TKJlhlUcJjm1DsOpjRO915ebuL1lQ6GpX2HMTG+AQ2ZmPLqmM0f95aTI69V/OsbIhjMJpx5JeXJlf0rdTtGOGg53q14IpiAVsTmwrv31MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742568838; c=relaxed/simple;
	bh=2FLoquHqkq95j+BTbbuoOmsirAu6SJ/x5gWiBCwV75s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pIZK/KymPtiuylzVpGhJmd7nriA31aj2BeasuvQcWDEujzprf88PiXJNAAafK0k4+ha1pTYaU8QIJTiU4LAuzowZ0HYHO8PAkB0LOhZBOiU4lZwveJNW4lE1sLHytssc8PFoupTYzaL+egBD9dA6rp5fJj5oAn2EdOJf++Swld4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTXm30RO; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso455490666b.3;
        Fri, 21 Mar 2025 07:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742568834; x=1743173634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWzJ96XhJyfSEt2rZUbqK0RHcX7x8UDPEhWBIKTUabE=;
        b=TTXm30ROLP3EJbER0hSUQekJ5FuUCAm9O6sNhV5Lx47ndllFsqpisTVvnwLRgN6Jgc
         Va7S1PgT5bjJ9nBTG2FpRXHjwxueuW2FbAnbJeHTI4/ApdLrfVKP+ui6eX8BMlFGn5/+
         0bBacbYaAooo5NKva3QolH2HvmBFKTjuPdgQwTpRoZEg3f5ONxPpIMaZYZsqxl6NN0o8
         4RXxucml3cTT4Kev3rcuCOSQQ4shWmNv5j4sAi3p7b5m87JrjOrxG0TRUaDLNjKUkNZT
         wkKkjOQujdUm3+tZ9HxgMW5PlzxlYyR7ZKVc3AsdsypXp4dcaHwN7iVabDtMOjt8TLve
         uv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742568834; x=1743173634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWzJ96XhJyfSEt2rZUbqK0RHcX7x8UDPEhWBIKTUabE=;
        b=TSXU0sJ8ZYKwbsmTuaJPEnUUymEeSITDiIoRjcf9raq0EQKBYtf3Tl2zHDxKXZktJ7
         aJGSD6yn6cewgHUA3O8EOrjsba8dea5/lWvQGteDG5iG6jx+UjqeaQjqMCtnX9Yw1WfQ
         of9aFag3Wk6XcAHWQHu8edxaXkPL62qwFs7ElExiK++X14pyu0d//WqfcwopxVQPsYzH
         mgWs28p8qHDL8WEnpUfssRxRMagMXJxydZZoZ8bISW8cSQrTSdMLDzu1GOo9rvLf6734
         zU7yY8EZdi4RfGf5Y+kIm1qXAhq01jxp65Is3IBLFPu5bnBkoOBX5FEmZYNeDcaM67Od
         BA2A==
X-Forwarded-Encrypted: i=1; AJvYcCUq4XscQF/zqzj2axPjepDa9RL3AePmW4QDEXTTucH7zGjHxs/i4UAn4g/o4y0MKPhc3GQgteVL/irs@vger.kernel.org, AJvYcCWduP3a1ak/8QtSBy0IbR9mAJOHE+/wn+2n9L4860A2tdj2BgBOPWgawL08JDabTPNrSn58xhoy9iR3gunw@vger.kernel.org, AJvYcCXCkF0BnFuu4RFoLPNWnu2O228jHXlHqgEWDofYB7DptxKj4T7kskjbnMEK3xbXCHve8vVGwPEV94eBUQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4gVMD2ZYcKD8dTxZ4NRNes3r01FGCP7dwyUxlgDUKypM4u7FP
	O9AiNEj4urzzPd/5w7Pbb2w1NvABA+bqCuKvZGgDIn2ReJge2OWO
X-Gm-Gg: ASbGncvrMmZmJ0qAImLDtcMHIwbulQNXfnN3yF5sJA/dNrYPbZ17hzaoW5Jd7S8QnXg
	/O68O2LnxxXKlUl2nbxQaI5VyvMSRR3fWyaatBjaydy+FLYILtC9OdQW1V8sTsXc8LhDeELoT6Y
	sRWxXpPYh6LhDFXrlCf9YVQoo67DSBlC5YkxfmfTfEcZHhQ4ew5kE/5QprOcZTx2rlcYj6hKvfD
	6x78Ba5IOAZfOSEVnWho3xfPhsI3KBUuvHGdoyxhA1dKUg0d8igfuwZoMzCvLbHn/4PC0RS0BD9
	1mOrAu47WGRqqJuHzbF6p0efOkkn3Il3uH7t
X-Google-Smtp-Source: AGHT+IGvDqpGgtceIfeAeqB5ZtatDYIz2iQuH7UnIToWNO8bF88kEkOM8yDIRQ4SI/yoMWRi41gcyw==
X-Received: by 2002:a17:906:c109:b0:ac2:49de:45c1 with SMTP id a640c23a62f3a-ac3f257dd1amr395095366b.50.1742568834074;
        Fri, 21 Mar 2025 07:53:54 -0700 (PDT)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efbe038dsm163224666b.138.2025.03.21.07.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:53:53 -0700 (PDT)
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
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/5] thermal: tegra: add Tegra114 specific SOCTHERM driver
Date: Fri, 21 Mar 2025 16:53:25 +0200
Message-ID: <20250321145326.113211-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321145326.113211-1-clamor95@gmail.com>
References: <20250321145326.113211-1-clamor95@gmail.com>
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
index a023c948afbd..78da82dc3b53 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -2049,6 +2049,12 @@ static void soctherm_init(struct platform_device *pdev)
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
2.43.0


