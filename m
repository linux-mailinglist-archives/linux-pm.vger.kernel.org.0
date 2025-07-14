Return-Path: <linux-pm+bounces-30767-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A2CB03914
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 10:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E93516304D
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 08:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7AA23ED5A;
	Mon, 14 Jul 2025 08:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsL+cWK5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B9323D285;
	Mon, 14 Jul 2025 08:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752481070; cv=none; b=fzQw/n3QS78EfFirURcM0Ir/6lynHMGSktEvoFhAv4zwHUEYhMYzabxaBc2NZyqYTDYdoDydU83KdXSP29/q1tFhTOan68R2hG9tD5K785D5p0hv6qR5y26CQnmoc3fxCV5rTI/czad0VSBQZnGkn/12KpDnlErMiT0r3vk8zeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752481070; c=relaxed/simple;
	bh=L1MgRS9LUygw4xk4x4V1TUS5jp6bIWIncx92EPkeZGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EdSHlPkfTQ7U7W4CIxzhILyxgVYJGYtndk8kUwErIFgj0IQbkiFIA2kzikBfBS+Jb5TSOddFVllhJ0DMHW4Kow4b3vGy3ZOzP9i0FbzPQ9U5/Jy36ISBzWHIlkVwxL0JQ4EnoqBjSBpXivJoL/uGm1RTVlRkfsUL4wvMlU4ugRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsL+cWK5; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae0bc7aa21bso848094666b.2;
        Mon, 14 Jul 2025 01:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752481067; x=1753085867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtDIhsx1T97NEaGa0JzD/KWw0/JJi6MxdYtXaBJldco=;
        b=NsL+cWK5neAb+MRTHlaO5B19D5Ld0R8kcxe2v+jIIcFXkbtRSZue5tDc3Ekpd/fFdY
         a5hfPF5SfeqklpMdJbmQjwsO0Bbs7JLsPhLqglvrHslyE3eiczZKt32SCnIYsODAzfu2
         4IwS7ekywUvp81hK5IWZGxsC0NiQkfcVPEZAnicL4AIzbTHpVDVL+m4SNC5KDh0kqg6V
         TN6wqcyueQffEKVRvPkzEk2qCPrexWzdLuRsHnnYXYsGu/skLujQs/5Sc0sI6qrhKLsT
         7otZkDXqUBNbyplGC097m9C3ntcS+dikVtfYocmLTXLbeBmvX77KLVJn7IwFl7ZAXRWM
         zQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752481067; x=1753085867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HtDIhsx1T97NEaGa0JzD/KWw0/JJi6MxdYtXaBJldco=;
        b=pAMKFL7lnL5aDScc69MqDGgCNPsFn42hQHln1ZimHcGDoOnI2tQhlk4ZYAuokR9khr
         rMEzZSInewzFAjn3Frv3GQ9OYzB3k6gQI4bTH7gok7CNYkZJPk62OUlLOx+lTVQuPFPS
         KHkte4H3ZW9i69dznN1tmEIj+FkfODM0sQZuvqdvT3T5sbl9UvLI+JE83TaVaCtknP6D
         W5NyFHCakSEBlxKl4ErIBnDYxiAsChpvboE/ordlG+epL4xtnNV4Gr+GTIwIbAFa2Ry2
         iNPKBCeyYrALYdCveZ1QMaN2AYSgqyjvZxVWqamSIYcz7vjmh0ZF/jqBbq7b/Ztrq88/
         XEwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGro69FRSFzilJO1XVlhlOsw9QZBSoCGio3etcmZWhoIvY1AOzNfAFnwF+SV4XqovBXXhY0xQ59/M=@vger.kernel.org, AJvYcCWHOLzGJhNMTtowBApDO6jo7j8svu+pim2m7+0NMusLuWeKOTcbh60/0kqS0uy8nviNFTiNUjyMH/hVHxEQ@vger.kernel.org, AJvYcCXkh+rUrwXS5aan+38AbnamQO+qurTeGxeRqB8H7r2asQv2fBIqBQU0RoPw19lIUndAvIerC3mWuDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrrQmBy/H4r2yAk2NZSu8HiXaqTUa32H/iHySvksMZRrTestMx
	5enivZ6eTu/2IlO93iyxJQ0brFP3Gt2zbnvrV1ed3i1aD1DbL+rxgR1oyMYnTw==
X-Gm-Gg: ASbGnctsKWmi/rKXo0RP7sYN3kZbuDDSeCbjcqUFAgbEMCRIg8nX+wOMt6aXfj0XzFc
	nH4StPIgdXqDOWzYnalRImlrhRBKhNEs24Iy8y6aaDZnJYiSXV4LFTL+Y7nIOsk9wdpKIVXa0cc
	y4MyapYckKKcBudpmOWaRx0dmYV5BrbkZ8dw4DynAiTZC/mnKxLAqD0qE7TglCGVPgHVKkQzRFY
	PCf5mKnfzrwLUXMVmvclfVht+cyWz5vZiTio/d8iXF3NzR9lwQkLgV6nVpYPr6gfTn+28PjcQrW
	DeOSekI0ZdrnTf7UQ3tIT9tpbdWqqs50wfRdJOu6614uuDLEm4K3Ye8jC2pjLNgYgPpLKFBEp6K
	Uw74e8m/00W0N3Q==
X-Google-Smtp-Source: AGHT+IGGm8sKjQ8VtKLvG5Lj5vrjiNDtUl0XjiAuOGazJbr0jkGtWjvugW5K1rlCw5HAK/kl7OHn8A==
X-Received: by 2002:a17:907:7e92:b0:ae0:c441:d54b with SMTP id a640c23a62f3a-ae6fca037admr1081411766b.9.1752481066689;
        Mon, 14 Jul 2025 01:17:46 -0700 (PDT)
Received: from xeon.. ([188.163.112.60])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e949f2sm787867166b.34.2025.07.14.01.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 01:17:46 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
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
Subject: [PATCH v2 2/3] clk: tegra: add DFLL support for Tegra114
Date: Mon, 14 Jul 2025 11:17:12 +0300
Message-ID: <20250714081713.8409-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250714081713.8409-1-clamor95@gmail.com>
References: <20250714081713.8409-1-clamor95@gmail.com>
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
index 73303458e886..126c0a55a6d0 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -11,6 +11,7 @@
 #include <linux/export.h>
 #include <linux/clk/tegra.h>
 #include <dt-bindings/clock/tegra114-car.h>
+#include <dt-bindings/reset/tegra114-car.h>
 
 #include "clk.h"
 #include "clk-id.h"
@@ -1272,7 +1273,7 @@ EXPORT_SYMBOL(tegra114_clock_tune_cpu_trimmers_init);
  *
  * Assert the reset line of the DFLL's DVCO.  No return value.
  */
-void tegra114_clock_assert_dfll_dvco_reset(void)
+static void tegra114_clock_assert_dfll_dvco_reset(void)
 {
 	u32 v;
 
@@ -1281,7 +1282,6 @@ void tegra114_clock_assert_dfll_dvco_reset(void)
 	writel_relaxed(v, clk_base + RST_DFLL_DVCO);
 	tegra114_car_barrier();
 }
-EXPORT_SYMBOL(tegra114_clock_assert_dfll_dvco_reset);
 
 /**
  * tegra114_clock_deassert_dfll_dvco_reset - deassert the DFLL's DVCO reset
@@ -1289,7 +1289,7 @@ EXPORT_SYMBOL(tegra114_clock_assert_dfll_dvco_reset);
  * Deassert the reset line of the DFLL's DVCO, allowing the DVCO to
  * operate.  No return value.
  */
-void tegra114_clock_deassert_dfll_dvco_reset(void)
+static void tegra114_clock_deassert_dfll_dvco_reset(void)
 {
 	u32 v;
 
@@ -1298,7 +1298,26 @@ void tegra114_clock_deassert_dfll_dvco_reset(void)
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
 
 static void __init tegra114_clock_init(struct device_node *np)
 {
@@ -1344,6 +1363,9 @@ static void __init tegra114_clock_init(struct device_node *np)
 	tegra_super_clk_gen4_init(clk_base, pmc_base, tegra114_clks,
 					&pll_x_params);
 
+	tegra_init_special_resets(1, tegra114_reset_assert,
+				  tegra114_reset_deassert);
+
 	tegra_add_of_provider(np, of_clk_src_onecell_get);
 	tegra_register_devclks(devclks, ARRAY_SIZE(devclks));
 
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
2.48.1


