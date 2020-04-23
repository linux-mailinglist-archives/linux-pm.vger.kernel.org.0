Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB971B6641
	for <lists+linux-pm@lfdr.de>; Thu, 23 Apr 2020 23:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgDWVlX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Apr 2020 17:41:23 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:48596 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726976AbgDWVlV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Apr 2020 17:41:21 -0400
X-IronPort-AV: E=Sophos;i="5.73,309,1583161200"; 
   d="scan'208";a="45339779"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 24 Apr 2020 06:41:19 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id AADDA4004BB2;
        Fri, 24 Apr 2020 06:41:15 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     Marian-Cristian Rotariu 
        <marian-cristian.rotariu.rb@bp.renesas.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 03/10] soc: renesas: rcar-sysc: add R8A7742 support
Date:   Thu, 23 Apr 2020 22:40:43 +0100
Message-Id: <1587678050-23468-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587678050-23468-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1587678050-23468-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for RZ/G1H (R8A7742) SoC power areas to the R-Car SYSC driver.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 drivers/soc/renesas/Kconfig        |  4 ++++
 drivers/soc/renesas/Makefile       |  1 +
 drivers/soc/renesas/r8a7742-sysc.c | 42 ++++++++++++++++++++++++++++++++++++++
 drivers/soc/renesas/rcar-sysc.c    |  3 +++
 drivers/soc/renesas/rcar-sysc.h    |  1 +
 5 files changed, 51 insertions(+)
 create mode 100644 drivers/soc/renesas/r8a7742-sysc.c

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 1982c7f..1eff82c 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -261,6 +261,10 @@ config ARCH_R8A77995
 endif # ARM64
 
 # SoC
+config SYSC_R8A7742
+	bool "RZ/G1H System Controller support" if COMPILE_TEST
+	select SYSC_RCAR
+
 config SYSC_R8A7743
 	bool "RZ/G1M System Controller support" if COMPILE_TEST
 	select SYSC_RCAR
diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index e595c3c..08296d7 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -3,6 +3,7 @@
 obj-$(CONFIG_SOC_RENESAS)	+= renesas-soc.o
 
 # SoC
+obj-$(CONFIG_SYSC_R8A7742)	+= r8a7742-sysc.o
 obj-$(CONFIG_SYSC_R8A7743)	+= r8a7743-sysc.o
 obj-$(CONFIG_SYSC_R8A7745)	+= r8a7745-sysc.o
 obj-$(CONFIG_SYSC_R8A77470)	+= r8a77470-sysc.o
diff --git a/drivers/soc/renesas/r8a7742-sysc.c b/drivers/soc/renesas/r8a7742-sysc.c
new file mode 100644
index 0000000..219a675
--- /dev/null
+++ b/drivers/soc/renesas/r8a7742-sysc.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/G1H System Controller
+ *
+ * Copyright (C) 2020 Renesas Electronics Corp.
+ */
+
+#include <linux/kernel.h>
+
+#include <dt-bindings/power/r8a7742-sysc.h>
+
+#include "rcar-sysc.h"
+
+static const struct rcar_sysc_area r8a7742_areas[] __initconst = {
+	{ "always-on",	    0, 0, R8A7742_PD_ALWAYS_ON,	-1, PD_ALWAYS_ON },
+	{ "ca15-scu",	0x180, 0, R8A7742_PD_CA15_SCU,	R8A7742_PD_ALWAYS_ON,
+	  PD_SCU },
+	{ "ca15-cpu0",	 0x40, 0, R8A7742_PD_CA15_CPU0,	R8A7742_PD_CA15_SCU,
+	  PD_CPU_NOCR },
+	{ "ca15-cpu1",	 0x40, 1, R8A7742_PD_CA15_CPU1,	R8A7742_PD_CA15_SCU,
+	  PD_CPU_NOCR },
+	{ "ca15-cpu2",	 0x40, 2, R8A7742_PD_CA15_CPU2,	R8A7742_PD_CA15_SCU,
+	  PD_CPU_NOCR },
+	{ "ca15-cpu3",	 0x40, 3, R8A7742_PD_CA15_CPU3,	R8A7742_PD_CA15_SCU,
+	  PD_CPU_NOCR },
+	{ "ca7-scu",	0x100, 0, R8A7742_PD_CA7_SCU,	R8A7742_PD_ALWAYS_ON,
+	  PD_SCU },
+	{ "ca7-cpu0",	0x1c0, 0, R8A7742_PD_CA7_CPU0,	R8A7742_PD_CA7_SCU,
+	  PD_CPU_NOCR },
+	{ "ca7-cpu1",	0x1c0, 1, R8A7742_PD_CA7_CPU1,	R8A7742_PD_CA7_SCU,
+	  PD_CPU_NOCR },
+	{ "ca7-cpu2",	0x1c0, 2, R8A7742_PD_CA7_CPU2,	R8A7742_PD_CA7_SCU,
+	  PD_CPU_NOCR },
+	{ "ca7-cpu3",	0x1c0, 3, R8A7742_PD_CA7_CPU3,	R8A7742_PD_CA7_SCU,
+	  PD_CPU_NOCR },
+	{ "rgx",	 0xc0, 0, R8A7742_PD_RGX,	R8A7742_PD_ALWAYS_ON },
+};
+
+const struct rcar_sysc_info r8a7742_sysc_info __initconst = {
+	.areas = r8a7742_areas,
+	.num_areas = ARRAY_SIZE(r8a7742_areas),
+};
diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index f0b291e..04ea87a 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -273,6 +273,9 @@ static int __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
 }
 
 static const struct of_device_id rcar_sysc_matches[] __initconst = {
+#ifdef CONFIG_SYSC_R8A7742
+	{ .compatible = "renesas,r8a7742-sysc", .data = &r8a7742_sysc_info },
+#endif
 #ifdef CONFIG_SYSC_R8A7743
 	{ .compatible = "renesas,r8a7743-sysc", .data = &r8a7743_sysc_info },
 	/* RZ/G1N is identical to RZ/G2M w.r.t. power domains. */
diff --git a/drivers/soc/renesas/rcar-sysc.h b/drivers/soc/renesas/rcar-sysc.h
index 0fc3b11..e417f26 100644
--- a/drivers/soc/renesas/rcar-sysc.h
+++ b/drivers/soc/renesas/rcar-sysc.h
@@ -49,6 +49,7 @@ struct rcar_sysc_info {
 	u32 extmask_val;	/* SYSCEXTMASK register mask value */
 };
 
+extern const struct rcar_sysc_info r8a7742_sysc_info;
 extern const struct rcar_sysc_info r8a7743_sysc_info;
 extern const struct rcar_sysc_info r8a7745_sysc_info;
 extern const struct rcar_sysc_info r8a77470_sysc_info;
-- 
2.7.4

