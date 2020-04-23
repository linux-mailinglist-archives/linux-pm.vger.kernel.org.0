Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191121B6655
	for <lists+linux-pm@lfdr.de>; Thu, 23 Apr 2020 23:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgDWVli (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Apr 2020 17:41:38 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:7839 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727820AbgDWVlh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Apr 2020 17:41:37 -0400
X-IronPort-AV: E=Sophos;i="5.73,309,1583161200"; 
   d="scan'208";a="45339795"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 24 Apr 2020 06:41:35 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id A43AF4004BB2;
        Fri, 24 Apr 2020 06:41:31 +0900 (JST)
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
Subject: [PATCH 07/10] clk: renesas: Add r8a7742 CPG Core Clock Definitions
Date:   Thu, 23 Apr 2020 22:40:47 +0100
Message-Id: <1587678050-23468-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587678050-23468-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1587678050-23468-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add all RZ/G1H Clock Pulse Generator Core Clock Outputs, as listed in
Table 7.2a ("List of Clocks [RZ/G1H]") of the RZ/G1 Hardware User's
Manual.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 include/dt-bindings/clock/r8a7742-cpg-mssr.h | 42 ++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 include/dt-bindings/clock/r8a7742-cpg-mssr.h

diff --git a/include/dt-bindings/clock/r8a7742-cpg-mssr.h b/include/dt-bindings/clock/r8a7742-cpg-mssr.h
new file mode 100644
index 0000000..e68191c
--- /dev/null
+++ b/include/dt-bindings/clock/r8a7742-cpg-mssr.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0+
+ *
+ * Copyright (C) 2020 Renesas Electronics Corp.
+ */
+#ifndef __DT_BINDINGS_CLOCK_R8A7742_CPG_MSSR_H__
+#define __DT_BINDINGS_CLOCK_R8A7742_CPG_MSSR_H__
+
+#include <dt-bindings/clock/renesas-cpg-mssr.h>
+
+/* r8a7742 CPG Core Clocks */
+#define R8A7742_CLK_Z		0
+#define R8A7742_CLK_Z2		1
+#define R8A7742_CLK_ZG		2
+#define R8A7742_CLK_ZTR		3
+#define R8A7742_CLK_ZTRD2	4
+#define R8A7742_CLK_ZT		5
+#define R8A7742_CLK_ZX		6
+#define R8A7742_CLK_ZS		7
+#define R8A7742_CLK_HP		8
+#define R8A7742_CLK_B		9
+#define R8A7742_CLK_LB		10
+#define R8A7742_CLK_P		11
+#define R8A7742_CLK_CL		12
+#define R8A7742_CLK_M2		13
+#define R8A7742_CLK_ZB3		14
+#define R8A7742_CLK_ZB3D2	15
+#define R8A7742_CLK_DDR		16
+#define R8A7742_CLK_SDH		17
+#define R8A7742_CLK_SD0		18
+#define R8A7742_CLK_SD1		19
+#define R8A7742_CLK_SD2		20
+#define R8A7742_CLK_SD3		21
+#define R8A7742_CLK_MMC0	22
+#define R8A7742_CLK_MMC1	23
+#define R8A7742_CLK_MP		24
+#define R8A7742_CLK_QSPI	25
+#define R8A7742_CLK_CP		26
+#define R8A7742_CLK_RCAN	27
+#define R8A7742_CLK_R		28
+#define R8A7742_CLK_OSC		29
+
+#endif /* __DT_BINDINGS_CLOCK_R8A7742_CPG_MSSR_H__ */
-- 
2.7.4

