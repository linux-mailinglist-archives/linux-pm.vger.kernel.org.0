Return-Path: <linux-pm+bounces-2744-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF23883C6E4
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 16:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EE7CB21C1C
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jan 2024 15:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E53F74E14;
	Thu, 25 Jan 2024 15:35:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D90C73172
	for <linux-pm@vger.kernel.org>; Thu, 25 Jan 2024 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706196904; cv=none; b=fZ8CYVK4Q31hiGObYD87VT96zSvqyhSQCxY95E3eXCp1hdIepBxszi400mhMT3gyle39cCchvt39I4DNB1ojGKib15c8ypyhQO2wqPYe4atAONlOszvEacQXcS01byQtECdQBXKuS/h+duO2TOzVd4CihR5KGSpW1SVHmjQ4Ed8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706196904; c=relaxed/simple;
	bh=7PpPWIBo+Wj25eDfAIA4ZvmWOY7i4fMJH2wRLGst5tM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dq6VzWWlmAcgUyu8AgbPnh70AKg6tFZvMm+5awGasIEPUhjSn47KVsvTQvP/8B/BEAA1cztGq+bLcGHMkEsfPv5Ersr1Q7JE7D4JPteYROToApRsvc08n1UFAA3Jzr6gilnwC5N4HRgWPaWHI9O+/5OhSkJZZ7JQavtE9fv2h30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:bc9e:fcb8:8aa3:5dc0])
	by albert.telenet-ops.be with bizsmtp
	id f3am2B00H58agq2063am9T; Thu, 25 Jan 2024 16:34:56 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rT1jo-00GUvz-5C;
	Thu, 25 Jan 2024 16:34:46 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rT1kc-00Fs2q-42;
	Thu, 25 Jan 2024 16:34:46 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Magnus Damm <magnus.damm@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Cong Dang <cong.dang.xn@renesas.com>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	Hai Pham <hai.pham.ud@renesas.com>,
	Linh Phung <linh.phung.jy@renesas.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 08/15] clk: renesas: cpg-mssr: Add support for R-Car V4M
Date: Thu, 25 Jan 2024 16:34:36 +0100
Message-Id: <c678ef7164e3777fa91572f72e47ef385cea64b8.1706194617.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706194617.git.geert+renesas@glider.be>
References: <cover.1706194617.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Dang <cong.dang.xn@renesas.com>

Initial CPG support for the R-Car V4M (R8A779H0).

Signed-off-by: Cong Dang <cong.dang.xn@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Add vendor-prefix to DT binding definition header file,
  - Add missing CP core clock.

Changes compared to the BSP:
  - Merge two patches,
  - Fix whitespace in Makefile,
  - Rename VIOSCR/VCSCR to VIOSRC/VCSRC,
  - Rename "zN" to "zcN" to match documentation,
  - Change register bitfield offsets for zc[1-3] from 0 to actual
    values,
  - Change parent of IMPBSRC/VIOSRC/VCSRC from PLL1_DIV2 to PLL1,
  - Add missing SD0H clock,
  - Change parent of SD0 from SDSRC to SD0H,
  - Fix No newline at end of file.
---
 drivers/clk/renesas/Kconfig             |   5 +
 drivers/clk/renesas/Makefile            |   1 +
 drivers/clk/renesas/r8a779h0-cpg-mssr.c | 241 ++++++++++++++++++++++++
 drivers/clk/renesas/renesas-cpg-mssr.c  |   6 +
 drivers/clk/renesas/renesas-cpg-mssr.h  |   1 +
 5 files changed, 254 insertions(+)
 create mode 100644 drivers/clk/renesas/r8a779h0-cpg-mssr.c

diff --git a/drivers/clk/renesas/Kconfig b/drivers/clk/renesas/Kconfig
index 69396e19795903e8..d252150402e86366 100644
--- a/drivers/clk/renesas/Kconfig
+++ b/drivers/clk/renesas/Kconfig
@@ -33,6 +33,7 @@ config CLK_RENESAS
 	select CLK_R8A779A0 if ARCH_R8A779A0
 	select CLK_R8A779F0 if ARCH_R8A779F0
 	select CLK_R8A779G0 if ARCH_R8A779G0
+	select CLK_R8A779H0 if ARCH_R8A779H0
 	select CLK_R9A06G032 if ARCH_R9A06G032
 	select CLK_R9A07G043 if ARCH_R9A07G043
 	select CLK_R9A07G044 if ARCH_R9A07G044
@@ -165,6 +166,10 @@ config CLK_R8A779G0
 	bool "R-Car V4H clock support" if COMPILE_TEST
 	select CLK_RCAR_GEN4_CPG
 
+config CLK_R8A779H0
+	bool "R-Car V4M clock support" if COMPILE_TEST
+	select CLK_RCAR_GEN4_CPG
+
 config CLK_R9A06G032
 	bool "RZ/N1D clock support" if COMPILE_TEST
 
diff --git a/drivers/clk/renesas/Makefile b/drivers/clk/renesas/Makefile
index 879a07d445f9056a..f7e18679c3b81b97 100644
--- a/drivers/clk/renesas/Makefile
+++ b/drivers/clk/renesas/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_CLK_R8A77995)		+= r8a77995-cpg-mssr.o
 obj-$(CONFIG_CLK_R8A779A0)		+= r8a779a0-cpg-mssr.o
 obj-$(CONFIG_CLK_R8A779F0)		+= r8a779f0-cpg-mssr.o
 obj-$(CONFIG_CLK_R8A779G0)		+= r8a779g0-cpg-mssr.o
+obj-$(CONFIG_CLK_R8A779H0)		+= r8a779h0-cpg-mssr.o
 obj-$(CONFIG_CLK_R9A06G032)		+= r9a06g032-clocks.o
 obj-$(CONFIG_CLK_R9A07G043)		+= r9a07g043-cpg.o
 obj-$(CONFIG_CLK_R9A07G044)		+= r9a07g044-cpg.o
diff --git a/drivers/clk/renesas/r8a779h0-cpg-mssr.c b/drivers/clk/renesas/r8a779h0-cpg-mssr.c
new file mode 100644
index 0000000000000000..1259b8544980f07a
--- /dev/null
+++ b/drivers/clk/renesas/r8a779h0-cpg-mssr.c
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * r8a779h0 Clock Pulse Generator / Module Standby and Software Reset
+ *
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ *
+ * Based on r8a779g0-cpg-mssr.c
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/soc/renesas/rcar-rst.h>
+
+#include <dt-bindings/clock/renesas,r8a779h0-cpg-mssr.h>
+
+#include "renesas-cpg-mssr.h"
+#include "rcar-gen4-cpg.h"
+
+enum clk_ids {
+	/* Core Clock Outputs exported to DT */
+	LAST_DT_CORE_CLK = R8A779H0_CLK_R,
+
+	/* External Input Clocks */
+	CLK_EXTAL,
+	CLK_EXTALR,
+
+	/* Internal Core Clocks */
+	CLK_MAIN,
+	CLK_PLL1,
+	CLK_PLL2,
+	CLK_PLL3,
+	CLK_PLL4,
+	CLK_PLL5,
+	CLK_PLL6,
+	CLK_PLL1_DIV2,
+	CLK_PLL2_DIV2,
+	CLK_PLL3_DIV2,
+	CLK_PLL4_DIV2,
+	CLK_PLL4_DIV5,
+	CLK_PLL5_DIV2,
+	CLK_PLL5_DIV4,
+	CLK_PLL6_DIV2,
+	CLK_S0,
+	CLK_S0_VIO,
+	CLK_S0_VC,
+	CLK_S0_HSC,
+	CLK_SASYNCPER,
+	CLK_SV_VIP,
+	CLK_SV_IR,
+	CLK_IMPASRC,
+	CLK_IMPBSRC,
+	CLK_VIOSRC,
+	CLK_VCSRC,
+	CLK_SDSRC,
+	CLK_RPCSRC,
+	CLK_OCO,
+
+	/* Module Clocks */
+	MOD_CLK_BASE
+};
+
+static const struct cpg_core_clk r8a779h0_core_clks[] = {
+	/* External Clock Inputs */
+	DEF_INPUT("extal",	CLK_EXTAL),
+	DEF_INPUT("extalr",	CLK_EXTALR),
+
+	/* Internal Core Clocks */
+	DEF_BASE(".main", CLK_MAIN,	CLK_TYPE_GEN4_MAIN,	CLK_EXTAL),
+	DEF_BASE(".pll1", CLK_PLL1,	CLK_TYPE_GEN4_PLL1,	CLK_MAIN),
+	DEF_BASE(".pll2", CLK_PLL2,	CLK_TYPE_GEN4_PLL2,	CLK_MAIN),
+	DEF_BASE(".pll3", CLK_PLL3,	CLK_TYPE_GEN4_PLL3,	CLK_MAIN),
+	DEF_BASE(".pll4", CLK_PLL4,	CLK_TYPE_GEN4_PLL4,	CLK_MAIN),
+	DEF_BASE(".pll5", CLK_PLL5,	CLK_TYPE_GEN4_PLL5,	CLK_MAIN),
+	DEF_BASE(".pll6", CLK_PLL6,	CLK_TYPE_GEN4_PLL6,	CLK_MAIN),
+
+	DEF_FIXED(".pll1_div2",	CLK_PLL1_DIV2,	CLK_PLL1,	2, 1),
+	DEF_FIXED(".pll2_div2",	CLK_PLL2_DIV2,	CLK_PLL2,	2, 1),
+	DEF_FIXED(".pll3_div2",	CLK_PLL3_DIV2,	CLK_PLL3,	2, 1),
+	DEF_FIXED(".pll4_div2",	CLK_PLL4_DIV2,	CLK_PLL4,	2, 1),
+	DEF_FIXED(".pll4_div5",	CLK_PLL4_DIV5,	CLK_PLL4,	5, 1),
+	DEF_FIXED(".pll5_div2",	CLK_PLL5_DIV2,	CLK_PLL5,	2, 1),
+	DEF_FIXED(".pll5_div4",	CLK_PLL5_DIV4,	CLK_PLL5_DIV2,	2, 1),
+	DEF_FIXED(".pll6_div2",	CLK_PLL6_DIV2,	CLK_PLL6,	2, 1),
+	DEF_FIXED(".s0",	CLK_S0,		CLK_PLL1_DIV2,	2, 1),
+	DEF_FIXED(".s0_vio",	CLK_S0_VIO,	CLK_PLL1_DIV2,	2, 1),
+	DEF_FIXED(".s0_vc",	CLK_S0_VC,	CLK_PLL1_DIV2,	2, 1),
+	DEF_FIXED(".s0_hsc",	CLK_S0_HSC,	CLK_PLL1_DIV2,	2, 1),
+	DEF_FIXED(".sasyncper",	CLK_SASYNCPER,	CLK_PLL5_DIV4,	3, 1),
+	DEF_FIXED(".sv_vip",	CLK_SV_VIP,	CLK_PLL1,	5, 1),
+	DEF_FIXED(".sv_ir",	CLK_SV_IR,	CLK_PLL1,	5, 1),
+	DEF_FIXED(".impasrc",	CLK_IMPASRC,	CLK_PLL1_DIV2,	2, 1),
+	DEF_FIXED(".impbsrc",	CLK_IMPBSRC,	CLK_PLL1,	4, 1),
+	DEF_FIXED(".viosrc",	CLK_VIOSRC,	CLK_PLL1,	6, 1),
+	DEF_FIXED(".vcsrc",	CLK_VCSRC,	CLK_PLL1,	6, 1),
+	DEF_BASE(".sdsrc",	CLK_SDSRC,	CLK_TYPE_GEN4_SDSRC, CLK_PLL5),
+	DEF_BASE(".rpcsrc",	CLK_RPCSRC,	CLK_TYPE_GEN4_RPCSRC, CLK_PLL5),
+	DEF_RATE(".oco",	CLK_OCO,	32768),
+
+	/* Core Clock Outputs */
+	DEF_GEN4_Z("zc0",	R8A779H0_CLK_ZC0,	CLK_TYPE_GEN4_Z,	CLK_PLL2_DIV2,	2, 0),
+	DEF_GEN4_Z("zc1",	R8A779H0_CLK_ZC1,	CLK_TYPE_GEN4_Z,	CLK_PLL2_DIV2,	2, 8),
+	DEF_GEN4_Z("zc2",	R8A779H0_CLK_ZC2,	CLK_TYPE_GEN4_Z,	CLK_PLL2_DIV2,	2, 32),
+	DEF_GEN4_Z("zc3",	R8A779H0_CLK_ZC3,	CLK_TYPE_GEN4_Z,	CLK_PLL2_DIV2,	2, 40),
+	DEF_FIXED("s0d2",	R8A779H0_CLK_S0D2,	CLK_S0,		2, 1),
+	DEF_FIXED("s0d3",	R8A779H0_CLK_S0D3,	CLK_S0,		3, 1),
+	DEF_FIXED("s0d4",	R8A779H0_CLK_S0D4,	CLK_S0,		4, 1),
+	DEF_FIXED("cl16m",	R8A779H0_CLK_CL16M,	CLK_S0,		48, 1),
+	DEF_FIXED("s0d2_rt",	R8A779H0_CLK_S0D2_RT,	CLK_S0,		2, 1),
+	DEF_FIXED("s0d3_rt",	R8A779H0_CLK_S0D3_RT,	CLK_S0,		3, 1),
+	DEF_FIXED("s0d4_rt",	R8A779H0_CLK_S0D4_RT,	CLK_S0,		4, 1),
+	DEF_FIXED("s0d6_rt",	R8A779H0_CLK_S0D6_RT,	CLK_S0,		6, 1),
+	DEF_FIXED("cl16m_rt",	R8A779H0_CLK_CL16M_RT,	CLK_S0,		48, 1),
+	DEF_FIXED("s0d2_per",	R8A779H0_CLK_S0D2_PER,	CLK_S0,		2, 1),
+	DEF_FIXED("s0d3_per",	R8A779H0_CLK_S0D3_PER,	CLK_S0,		3, 1),
+	DEF_FIXED("s0d4_per",	R8A779H0_CLK_S0D4_PER,	CLK_S0,		4, 1),
+	DEF_FIXED("s0d6_per",	R8A779H0_CLK_S0D6_PER,	CLK_S0,		6, 1),
+	DEF_FIXED("s0d12_per",	R8A779H0_CLK_S0D12_PER,	CLK_S0,		12, 1),
+	DEF_FIXED("s0d24_per",	R8A779H0_CLK_S0D24_PER,	CLK_S0,		24, 1),
+	DEF_FIXED("cl16m_per",	R8A779H0_CLK_CL16M_PER,	CLK_S0,		48, 1),
+	DEF_FIXED("s0d2_mm",	R8A779H0_CLK_S0D2_MM,	CLK_S0,		2, 1),
+	DEF_FIXED("s0d4_mm",	R8A779H0_CLK_S0D4_MM,	CLK_S0,		4, 1),
+	DEF_FIXED("cl16m_mm",	R8A779H0_CLK_CL16M_MM,	CLK_S0,		48, 1),
+	DEF_FIXED("s0d2_u3dg",	R8A779H0_CLK_S0D2_U3DG,	CLK_S0,		2, 1),
+	DEF_FIXED("s0d4_u3dg",	R8A779H0_CLK_S0D4_U3DG,	CLK_S0,		4, 1),
+	DEF_FIXED("s0d1_vio",	R8A779H0_CLK_S0D1_VIO,	CLK_S0_VIO,	1, 1),
+	DEF_FIXED("s0d2_vio",	R8A779H0_CLK_S0D2_VIO,	CLK_S0_VIO,	2, 1),
+	DEF_FIXED("s0d4_vio",	R8A779H0_CLK_S0D4_VIO,	CLK_S0_VIO,	4, 1),
+	DEF_FIXED("s0d8_vio",	R8A779H0_CLK_S0D8_VIO,	CLK_S0_VIO,	8, 1),
+	DEF_FIXED("s0d1_vc",	R8A779H0_CLK_S0D1_VC,	CLK_S0_VC,	1, 1),
+	DEF_FIXED("s0d2_vc",	R8A779H0_CLK_S0D2_VC,	CLK_S0_VC,	2, 1),
+	DEF_FIXED("s0d4_vc",	R8A779H0_CLK_S0D4_VC,	CLK_S0_VC,	4, 1),
+	DEF_FIXED("s0d1_hsc",	R8A779H0_CLK_S0D1_HSC,	CLK_S0_HSC,	1, 1),
+	DEF_FIXED("s0d2_hsc",	R8A779H0_CLK_S0D2_HSC,	CLK_S0_HSC,	2, 1),
+	DEF_FIXED("s0d4_hsc",	R8A779H0_CLK_S0D4_HSC,	CLK_S0_HSC,	4, 1),
+	DEF_FIXED("s0d8_hsc",	R8A779H0_CLK_S0D8_HSC,	CLK_S0_HSC,	8, 1),
+	DEF_FIXED("cl16m_hsc",	R8A779H0_CLK_CL16M_HSC,	CLK_S0_HSC,	48, 1),
+	DEF_FIXED("sasyncrt",	R8A779H0_CLK_SASYNCRT,	CLK_PLL5_DIV4,	48, 1),
+	DEF_FIXED("sasyncperd1", R8A779H0_CLK_SASYNCPERD1, CLK_SASYNCPER, 1, 1),
+	DEF_FIXED("sasyncperd2", R8A779H0_CLK_SASYNCPERD2, CLK_SASYNCPER, 2, 1),
+	DEF_FIXED("sasyncperd4", R8A779H0_CLK_SASYNCPERD4, CLK_SASYNCPER, 4, 1),
+	DEF_FIXED("svd1_vip",	R8A779H0_CLK_SVD1_VIP,	CLK_SV_VIP,	1, 1),
+	DEF_FIXED("svd2_vip",	R8A779H0_CLK_SVD2_VIP,	CLK_SV_VIP,	2, 1),
+	DEF_FIXED("svd1_ir",	R8A779H0_CLK_SVD1_IR,	CLK_SV_IR,	1, 1),
+	DEF_FIXED("svd2_ir",	R8A779H0_CLK_SVD2_IR,	CLK_SV_IR,	2, 1),
+	DEF_FIXED("cbfusa",	R8A779H0_CLK_CBFUSA,	CLK_EXTAL,	2, 1),
+	DEF_FIXED("cpex",	R8A779H0_CLK_CPEX,	CLK_EXTAL,	2, 1),
+	DEF_FIXED("cp",		R8A779H0_CLK_CP,	CLK_EXTAL,	2, 1),
+	DEF_FIXED("impad1",	R8A779H0_CLK_IMPAD1,	CLK_IMPASRC,	1, 1),
+	DEF_FIXED("impad4",	R8A779H0_CLK_IMPAD4,	CLK_IMPASRC,	4, 1),
+	DEF_FIXED("impb",	R8A779H0_CLK_IMPB,	CLK_IMPBSRC,	1, 1),
+	DEF_FIXED("viobusd1",	R8A779H0_CLK_VIOBUSD1,	CLK_VIOSRC,	1, 1),
+	DEF_FIXED("viobusd2",	R8A779H0_CLK_VIOBUSD2,	CLK_VIOSRC,	2, 1),
+	DEF_FIXED("vcbusd1",	R8A779H0_CLK_VCBUSD1,	CLK_VCSRC,	1, 1),
+	DEF_FIXED("vcbusd2",	R8A779H0_CLK_VCBUSD2,	CLK_VCSRC,	2, 1),
+	DEF_DIV6P1("canfd",	R8A779H0_CLK_CANFD,	CLK_PLL5_DIV4,	0x878),
+	DEF_DIV6P1("csi",	R8A779H0_CLK_CSI,	CLK_PLL5_DIV4,	0x880),
+	DEF_FIXED("dsiref",	R8A779H0_CLK_DSIREF,	CLK_PLL5_DIV4,	48, 1),
+	DEF_DIV6P1("dsiext",	R8A779H0_CLK_DSIEXT,	CLK_PLL5_DIV4,	0x884),
+	DEF_DIV6P1("mso",	R8A779H0_CLK_MSO,	CLK_PLL5_DIV4,	0x87c),
+
+	DEF_GEN4_SDH("sd0h",	R8A779H0_CLK_SD0H,	CLK_SDSRC,	   0x870),
+	DEF_GEN4_SD("sd0",	R8A779H0_CLK_SD0,	R8A779H0_CLK_SD0H, 0x870),
+
+	DEF_BASE("rpc",		R8A779H0_CLK_RPC,	CLK_TYPE_GEN4_RPC, CLK_RPCSRC),
+	DEF_BASE("rpcd2",	R8A779H0_CLK_RPCD2,	CLK_TYPE_GEN4_RPCD2, R8A779H0_CLK_RPC),
+
+	DEF_GEN4_OSC("osc",	R8A779H0_CLK_OSC,	CLK_EXTAL,	8),
+	DEF_GEN4_MDSEL("r",	R8A779H0_CLK_R, 29, CLK_EXTALR, 1, CLK_OCO, 1),
+};
+
+static const struct mssr_mod_clk r8a779h0_mod_clks[] = {
+	DEF_MOD("hscif0",	514,	R8A779H0_CLK_SASYNCPERD1),
+	DEF_MOD("hscif1",	515,	R8A779H0_CLK_SASYNCPERD1),
+	DEF_MOD("hscif2",	516,	R8A779H0_CLK_SASYNCPERD1),
+	DEF_MOD("hscif3",	517,	R8A779H0_CLK_SASYNCPERD1),
+};
+
+/*
+ * CPG Clock Data
+ */
+/*
+ *   MD	 EXTAL		PLL1	PLL2	PLL3	PLL4	PLL5	PLL6	OSC
+ * 14 13 (MHz)
+ * ------------------------------------------------------------------------
+ * 0  0	 16.66 / 1	x192	x204	x192	x144	x192	x168	/16
+ * 0  1	 20    / 1	x160	x170	x160	x120	x160	x140	/19
+ * 1  0	 Prohibited setting
+ * 1  1	 33.33 / 2	x192	x204	x192	x144	x192	x168	/32
+ */
+#define CPG_PLL_CONFIG_INDEX(md)	((((md) & BIT(14)) >> 13) | \
+					 (((md) & BIT(13)) >> 13))
+
+static const struct rcar_gen4_cpg_pll_config cpg_pll_configs[4] = {
+	/* EXTAL div	PLL1 mult/div	PLL2 mult/div	PLL3 mult/div	PLL4 mult/div	PLL5 mult/div	PLL6 mult/div	OSC prediv */
+	{ 1,		192,	1,	240,	1,	192,	1,	240,	1,	192,	1,	168,	1,	16,	},
+	{ 1,		160,	1,	200,	1,	160,	1,	200,	1,	160,	1,	140,	1,	19,	},
+	{ 0,		0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	},
+	{ 2,		192,	1,	240,	1,	192,	1,	240,	1,	192,	1,	168,	1,	32,	},
+};
+
+static int __init r8a779h0_cpg_mssr_init(struct device *dev)
+{
+	const struct rcar_gen4_cpg_pll_config *cpg_pll_config;
+	u32 cpg_mode;
+	int error;
+
+	error = rcar_rst_read_mode_pins(&cpg_mode);
+	if (error)
+		return error;
+
+	cpg_pll_config = &cpg_pll_configs[CPG_PLL_CONFIG_INDEX(cpg_mode)];
+	if (!cpg_pll_config->extal_div) {
+		dev_err(dev, "Prohibited setting (cpg_mode=0x%x)\n", cpg_mode);
+		return -EINVAL;
+	}
+
+	return rcar_gen4_cpg_init(cpg_pll_config, CLK_EXTALR, cpg_mode);
+}
+
+const struct cpg_mssr_info r8a779h0_cpg_mssr_info __initconst = {
+	/* Core Clocks */
+	.core_clks = r8a779h0_core_clks,
+	.num_core_clks = ARRAY_SIZE(r8a779h0_core_clks),
+	.last_dt_core_clk = LAST_DT_CORE_CLK,
+	.num_total_core_clks = MOD_CLK_BASE,
+
+	/* Module Clocks */
+	.mod_clks = r8a779h0_mod_clks,
+	.num_mod_clks = ARRAY_SIZE(r8a779h0_mod_clks),
+	.num_hw_mod_clks = 30 * 32,
+
+	/* Callbacks */
+	.init = r8a779h0_cpg_mssr_init,
+	.cpg_clk_register = rcar_gen4_cpg_clk_register,
+
+	.reg_layout = CLK_REG_LAYOUT_RCAR_GEN4,
+};
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 23e5a2b46ac132c6..1b421b8097965b70 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -871,6 +871,12 @@ static const struct of_device_id cpg_mssr_match[] = {
 		.compatible = "renesas,r8a779g0-cpg-mssr",
 		.data = &r8a779g0_cpg_mssr_info,
 	},
+#endif
+#ifdef CONFIG_CLK_R8A779H0
+	{
+		.compatible = "renesas,r8a779h0-cpg-mssr",
+		.data = &r8a779h0_cpg_mssr_info,
+	},
 #endif
 	{ /* sentinel */ }
 };
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.h b/drivers/clk/renesas/renesas-cpg-mssr.h
index 80c5b462924ac343..a1d6e0cbcff94813 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.h
+++ b/drivers/clk/renesas/renesas-cpg-mssr.h
@@ -180,6 +180,7 @@ extern const struct cpg_mssr_info r8a77995_cpg_mssr_info;
 extern const struct cpg_mssr_info r8a779a0_cpg_mssr_info;
 extern const struct cpg_mssr_info r8a779f0_cpg_mssr_info;
 extern const struct cpg_mssr_info r8a779g0_cpg_mssr_info;
+extern const struct cpg_mssr_info r8a779h0_cpg_mssr_info;
 
 void __init cpg_mssr_early_init(struct device_node *np,
 				const struct cpg_mssr_info *info);
-- 
2.34.1


