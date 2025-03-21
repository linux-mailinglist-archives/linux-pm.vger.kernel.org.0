Return-Path: <linux-pm+bounces-24369-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5D1A6B831
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 10:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1696B188B680
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 09:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E23E20B20A;
	Fri, 21 Mar 2025 09:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2XwhqCx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A1A1F2B85;
	Fri, 21 Mar 2025 09:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742550982; cv=none; b=rpmo6ahVLU1zut3CLyblnwgl73VymOrqqh8Gkko9eaAqk6mGGuNtSbhdwR2Y4fg5mv44ADAKqpDEtoaXQMvkG9c61OdSMpjI7QUL2M37dDXqBOSA+aQkC4vSoAVfFvZzKLHNBENssJy46gyIy3s5u4xzNIa7S7UOEJ/a6dmTbSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742550982; c=relaxed/simple;
	bh=4IrE+KBuXzXdZrEAze0qjF3GXIyvk793zpOwG5w/tcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3aQMm4p4MaPEOoc1xMADQMK7A7p0BznxHXVonVdDd0Yibs1D9QvY+OMiaf1M21NRkO4qlElIYLUETJ+q7o2z8zZ5msYn9uO6AdwjFtEQAIEvtw2I5bqqgVR5AM8zzoIT6qcO3J1hq6+iEEwbucESKGD8dr7bZqSrzCRkcjfLpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2XwhqCx; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac345bd8e13so316696366b.0;
        Fri, 21 Mar 2025 02:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742550979; x=1743155779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXHXVamYGC6fZGnqv0UAI7Mo52X4Mkew83EQyZ9SD1w=;
        b=b2XwhqCxeauxYCt1J67pia1sgDkNv2jLd6Z595XK1BsR5EqoFo0tJEJ72+NI+HlDj6
         PKcVpEuduivRkRNUgUQC6MZFVF0Gh8bY5BhZvRS87pYr7pK+oQx81X09ygiFK5PEPDIt
         f/3V4WIUuOHoMqtWyOh5H3P6qraQKB7A+IjvgwJZ1AizPC0l77rWKdf6ncjQ6SKiO45V
         BjMLTWL/ckyM8kLptMusfo714hUUaoPh7DQ5nIhmijqjyL0Spa8zTQ4rhqcm2ABJZdju
         BQkXhsajX7a5CiOyxJpG3TWdCO7wmgNiFF852ytwZqSPOTmhvTeLCzx76NndJ/OR7qjS
         xz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742550979; x=1743155779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zXHXVamYGC6fZGnqv0UAI7Mo52X4Mkew83EQyZ9SD1w=;
        b=oDEJpqZP/iB+rN5j0SNjESFNtdXbJ3LBRdgKvBiNKOb0VXxiZMtXdbHSCcm73B1CP3
         l01DLAxcMLVuPGZbBx7HIP4AxKZh0ad2BqWX28kAaQyF2zSlfyyHqIox8hS4SU3NKl47
         PQuazhfvMYttbjvaBi7kj7DcZFpnlbn5uWmAhuzuTkzF66dPlPmFLG0ZXGX6WnMT9MSc
         mBL6qb3aLDR1LlYrvoLNDFFnZCfFsBMsZ0qJxJaYDglWC32Z2EfDCQXykXlonJqI4ldY
         pN6pdf2O8Z8KPmN4+EEXMdul8wYT9H3Hmlj71pMyoSQEbn/T4F6XYdz960UalKGNj4Mw
         USUw==
X-Forwarded-Encrypted: i=1; AJvYcCVNLCl3qUl5u/rMAOcZIG2mFoayVrcxTo11xNgNxgMzYAVQfCwBTEZFP1mEG3u3K/vXPwpkA7Q+tUY=@vger.kernel.org, AJvYcCVP1S1ofBuCXGYYLbqt+vd/TxYWYl47OibPeE2zzg5skRYY13IyXb9EvN+4BS2mFUuMjMH+8Ms6Gys=@vger.kernel.org, AJvYcCWyM5PpyeiVo65Ofvbb1dLxq9HwOZNV8zMLAcxZa+rI+O9E2DWZQMr94EKNVmLuHbDjF6zVDKZvjGdjG5Mg@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5NscCYZziJf+xFw7RpR6O8823nRzSf0C+XviTVS9mOyNl+6so
	AQPuUDPGY9yt4o6mUEYO/CRm6O73ZeTYVOXQLzWVQJMxlSFKNnGn
X-Gm-Gg: ASbGncso/js2CHgI7RK5zdz4R2Ncc/CQR0nKL1rOyYP/sxmotI8IiGRmT+3SHmVtC6o
	0bwHD+rkjt+XU4RaVbXlV3M+UB2ckREmqqFXKghHendVs36Q4i1Ug75j0Z55b/qHRr/sO8Yrmog
	FB9qZmovNSLJ7XWEcr6f+rz3+LnyJ101EMpFmKRiNiPh89SAei0ojXy1w/Isby7MVvVDsE4JreW
	yxu6UmSY9aALaNlOXi2B7DTXjAeyeNBBh4tmXyayn3nUYaQa8wlIKm/hjKX1l8NvqdlCHaswO1y
	2J9iOkCBQQ/EQ1dUPbV4bpru3H5mMNYn4uS+
X-Google-Smtp-Source: AGHT+IHMa3C9Be4vKDRpZQ05UKm9bDBxkmzhwBlivAHU8sF1b0Wl7g1q3q4jSB0/7Bs0WbGkuhOWjQ==
X-Received: by 2002:a17:907:d7c8:b0:ac3:3f84:4055 with SMTP id a640c23a62f3a-ac3f20d8b71mr282454666b.4.1742550978458;
        Fri, 21 Mar 2025 02:56:18 -0700 (PDT)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef869f19sm122300866b.33.2025.03.21.02.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 02:56:18 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Peter De Schrijver <pdeschrijver@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v1 2/3] drivers: clk: tegra: add DFLL support for Tegra 4
Date: Fri, 21 Mar 2025 11:55:55 +0200
Message-ID: <20250321095556.91425-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321095556.91425-1-clamor95@gmail.com>
References: <20250321095556.91425-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the Tegra124 driver to include DFLL configuration settings required
for Tegra114 compatibility.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/clk/tegra/Kconfig                  |   2 +-
 drivers/clk/tegra/clk-tegra114.c           |  30 +++++-
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c | 104 +++++++++++++++++++++
 drivers/clk/tegra/clk.h                    |   2 -
 include/dt-bindings/reset/tegra114-car.h   |  13 +++
 5 files changed, 144 insertions(+), 7 deletions(-)
 create mode 100644 include/dt-bindings/reset/tegra114-car.h

diff --git a/drivers/clk/tegra/Kconfig b/drivers/clk/tegra/Kconfig
index 90df619dc087..62147a069606 100644
--- a/drivers/clk/tegra/Kconfig
+++ b/drivers/clk/tegra/Kconfig
@@ -4,7 +4,7 @@ config CLK_TEGRA_BPMP
 	depends on TEGRA_BPMP
 
 config TEGRA_CLK_DFLL
-	depends on ARCH_TEGRA_124_SOC || ARCH_TEGRA_210_SOC
+	depends on ARCH_TEGRA_114_SOC || ARCH_TEGRA_124_SOC || ARCH_TEGRA_210_SOC
 	select PM_OPP
 	def_bool y
 
diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index b19dd4e6e17c..9b6794b951a2 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -11,6 +11,7 @@
 #include <linux/export.h>
 #include <linux/clk/tegra.h>
 #include <dt-bindings/clock/tegra114-car.h>
+#include <dt-bindings/reset/tegra114-car.h>
 
 #include "clk.h"
 #include "clk-id.h"
@@ -1260,7 +1261,7 @@ EXPORT_SYMBOL(tegra114_clock_tune_cpu_trimmers_init);
  *
  * Assert the reset line of the DFLL's DVCO.  No return value.
  */
-void tegra114_clock_assert_dfll_dvco_reset(void)
+static void tegra114_clock_assert_dfll_dvco_reset(void)
 {
 	u32 v;
 
@@ -1269,7 +1270,6 @@ void tegra114_clock_assert_dfll_dvco_reset(void)
 	writel_relaxed(v, clk_base + RST_DFLL_DVCO);
 	tegra114_car_barrier();
 }
-EXPORT_SYMBOL(tegra114_clock_assert_dfll_dvco_reset);
 
 /**
  * tegra114_clock_deassert_dfll_dvco_reset - deassert the DFLL's DVCO reset
@@ -1277,7 +1277,7 @@ EXPORT_SYMBOL(tegra114_clock_assert_dfll_dvco_reset);
  * Deassert the reset line of the DFLL's DVCO, allowing the DVCO to
  * operate.  No return value.
  */
-void tegra114_clock_deassert_dfll_dvco_reset(void)
+static void tegra114_clock_deassert_dfll_dvco_reset(void)
 {
 	u32 v;
 
@@ -1286,7 +1286,26 @@ void tegra114_clock_deassert_dfll_dvco_reset(void)
 	writel_relaxed(v, clk_base + RST_DFLL_DVCO);
 	tegra114_car_barrier();
 }
-EXPORT_SYMBOL(tegra114_clock_deassert_dfll_dvco_reset);
+
+static int tegra114_reset_assert(unsigned long id)
+{
+	if (id == TEGRA114_RST_DFLL_DVCO)
+		tegra114_clock_assert_dfll_dvco_reset();
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static int tegra114_reset_deassert(unsigned long id)
+{
+	if (id == TEGRA114_RST_DFLL_DVCO)
+		tegra114_clock_deassert_dfll_dvco_reset();
+	else
+		return -EINVAL;
+
+	return 0;
+}
 
 #ifdef CONFIG_TEGRA124_CLK_EMC
 static struct clk *tegra114_clk_src_onecell_get(struct of_phandle_args *clkspec,
@@ -1357,6 +1376,9 @@ static void __init tegra114_clock_init(struct device_node *np)
 	tegra_super_clk_gen4_init(clk_base, pmc_base, tegra114_clks,
 					&pll_x_params);
 
+	tegra_init_special_resets(1, tegra114_reset_assert,
+				  tegra114_reset_deassert);
+
 #ifdef CONFIG_TEGRA124_CLK_EMC
 	tegra_add_of_provider(np, tegra114_clk_src_onecell_get);
 	clks[TEGRA114_CLK_EMC] = tegra124_clk_register_emc(clk_base, np,
diff --git a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
index 0251618b82c8..7a43380ce519 100644
--- a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
+++ b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
@@ -28,6 +28,99 @@ struct dfll_fcpu_data {
 	unsigned int cpu_cvb_tables_size;
 };
 
+/* Maximum CPU frequency, indexed by CPU speedo id */
+static const unsigned long tegra114_cpu_max_freq_table[] = {
+	[0] = 2040000000UL,
+	[1] = 1810500000UL,
+	[2] = 1912500000UL,
+	[3] = 1810500000UL,
+};
+
+#define T114_CPU_CVB_TABLE \
+	.min_millivolts = 1000, \
+	.max_millivolts = 1320, \
+	.speedo_scale = 100,    \
+	.voltage_scale = 1000,  \
+	.entries = {            \
+		{  306000000UL, { 2190643, -141851, 3576 } }, \
+		{  408000000UL, { 2250968, -144331, 3576 } }, \
+		{  510000000UL, { 2313333, -146811, 3576 } }, \
+		{  612000000UL, { 2377738, -149291, 3576 } }, \
+		{  714000000UL, { 2444183, -151771, 3576 } }, \
+		{  816000000UL, { 2512669, -154251, 3576 } }, \
+		{  918000000UL, { 2583194, -156731, 3576 } }, \
+		{ 1020000000UL, { 2655759, -159211, 3576 } }, \
+		{ 1122000000UL, { 2730365, -161691, 3576 } }, \
+		{ 1224000000UL, { 2807010, -164171, 3576 } }, \
+		{ 1326000000UL, { 2885696, -166651, 3576 } }, \
+		{ 1428000000UL, { 2966422, -169131, 3576 } }, \
+		{ 1530000000UL, { 3049183, -171601, 3576 } }, \
+		{ 1606500000UL, { 3112179, -173451, 3576 } }, \
+		{ 1708500000UL, { 3198504, -175931, 3576 } }, \
+		{ 1810500000UL, { 3304747, -179126, 3576 } }, \
+		{ 1912500000UL, { 3395401, -181606, 3576 } }, \
+		{          0UL, {       0,       0,    0 } }, \
+	}, \
+	.cpu_dfll_data = {      \
+		.tune0_low = 0x00b0039d,          \
+		.tune0_high = 0x00b0009d,         \
+		.tune1 = 0x0000001f,              \
+		.tune_high_min_millivolts = 1050, \
+	}
+
+static const struct cvb_table tegra114_cpu_cvb_tables[] = {
+	{
+		.speedo_id = 0,
+		.process_id = -1,
+		.min_millivolts = 1000,
+		.max_millivolts = 1250,
+		.speedo_scale = 100,
+		.voltage_scale = 100,
+		.entries = {
+			{  306000000UL, { 107330, -1569,   0 } },
+			{  408000000UL, { 111250, -1666,   0 } },
+			{  510000000UL, { 110000, -1460,   0 } },
+			{  612000000UL, { 117290, -1745,   0 } },
+			{  714000000UL, { 122700, -1910,   0 } },
+			{  816000000UL, { 125620, -1945,   0 } },
+			{  918000000UL, { 130560, -2076,   0 } },
+			{ 1020000000UL, { 137280, -2303,   0 } },
+			{ 1122000000UL, { 146440, -2660,   0 } },
+			{ 1224000000UL, { 152190, -2825,   0 } },
+			{ 1326000000UL, { 157520, -2953,   0 } },
+			{ 1428000000UL, { 166100, -3261,   0 } },
+			{ 1530000000UL, { 176410, -3647,   0 } },
+			{ 1632000000UL, { 189620, -4186,   0 } },
+			{ 1734000000UL, { 203190, -4725,   0 } },
+			{ 1836000000UL, { 222670, -5573,   0 } },
+			{ 1938000000UL, { 256210, -7165,   0 } },
+			{ 2040000000UL, { 250050, -6544,   0 } },
+			{          0UL, {      0,     0,   0 } },
+		},
+		.cpu_dfll_data = {
+			.tune0_low = 0x00b0019d,
+			.tune0_high = 0x00b0019d,
+			.tune1 = 0x0000001f,
+			.tune_high_min_millivolts = 1000,
+		}
+	},
+	{
+		.speedo_id = 1,
+		.process_id = -1,
+		T114_CPU_CVB_TABLE
+	},
+	{
+		.speedo_id = 2,
+		.process_id = -1,
+		T114_CPU_CVB_TABLE
+	},
+	{
+		.speedo_id = 3,
+		.process_id = -1,
+		T114_CPU_CVB_TABLE
+	},
+};
+
 /* Maximum CPU frequency, indexed by CPU speedo id */
 static const unsigned long tegra124_cpu_max_freq_table[] = {
 	[0] = 2014500000UL,
@@ -494,6 +587,13 @@ static struct cvb_table tegra210_cpu_cvb_tables[] = {
 	},
 };
 
+static const struct dfll_fcpu_data tegra114_dfll_fcpu_data = {
+	.cpu_max_freq_table = tegra114_cpu_max_freq_table,
+	.cpu_max_freq_table_size = ARRAY_SIZE(tegra114_cpu_max_freq_table),
+	.cpu_cvb_tables = tegra114_cpu_cvb_tables,
+	.cpu_cvb_tables_size = ARRAY_SIZE(tegra114_cpu_cvb_tables)
+};
+
 static const struct dfll_fcpu_data tegra124_dfll_fcpu_data = {
 	.cpu_max_freq_table = tegra124_cpu_max_freq_table,
 	.cpu_max_freq_table_size = ARRAY_SIZE(tegra124_cpu_max_freq_table),
@@ -509,6 +609,10 @@ static const struct dfll_fcpu_data tegra210_dfll_fcpu_data = {
 };
 
 static const struct of_device_id tegra124_dfll_fcpu_of_match[] = {
+	{
+		.compatible = "nvidia,tegra114-dfll",
+		.data = &tegra114_dfll_fcpu_data,
+	},
 	{
 		.compatible = "nvidia,tegra124-dfll",
 		.data = &tegra124_dfll_fcpu_data,
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index 5d80d8b79b8e..58e860b18e5e 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -898,8 +898,6 @@ static inline bool tegra124_clk_emc_driver_available(struct clk_hw *emc_hw)
 void tegra114_clock_tune_cpu_trimmers_high(void);
 void tegra114_clock_tune_cpu_trimmers_low(void);
 void tegra114_clock_tune_cpu_trimmers_init(void);
-void tegra114_clock_assert_dfll_dvco_reset(void);
-void tegra114_clock_deassert_dfll_dvco_reset(void);
 
 typedef void (*tegra_clk_apply_init_table_func)(void);
 extern tegra_clk_apply_init_table_func tegra_clk_apply_init_table;
diff --git a/include/dt-bindings/reset/tegra114-car.h b/include/dt-bindings/reset/tegra114-car.h
new file mode 100644
index 000000000000..d7908d810ddf
--- /dev/null
+++ b/include/dt-bindings/reset/tegra114-car.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * This header provides Tegra114-specific constants for binding
+ * nvidia,tegra114-car.
+ */
+
+#ifndef _DT_BINDINGS_RESET_TEGRA114_CAR_H
+#define _DT_BINDINGS_RESET_TEGRA114_CAR_H
+
+#define TEGRA114_RESET(x)		(5 * 32 + (x))
+#define TEGRA114_RST_DFLL_DVCO		TEGRA114_RESET(0)
+
+#endif	/* _DT_BINDINGS_RESET_TEGRA114_CAR_H */
-- 
2.43.0


