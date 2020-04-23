Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7E81B6670
	for <lists+linux-pm@lfdr.de>; Thu, 23 Apr 2020 23:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgDWVl4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Apr 2020 17:41:56 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:11728 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725777AbgDWVlQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Apr 2020 17:41:16 -0400
X-IronPort-AV: E=Sophos;i="5.73,309,1583161200"; 
   d="scan'208";a="45553076"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 24 Apr 2020 06:41:15 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id ACEBC400C420;
        Fri, 24 Apr 2020 06:41:11 +0900 (JST)
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
Subject: [PATCH 02/10] dt-bindings: power: rcar-sysc: Add r8a7742 power domain index macros
Date:   Thu, 23 Apr 2020 22:40:42 +0100
Message-Id: <1587678050-23468-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587678050-23468-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1587678050-23468-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add power domain indices for RZ/G1H (R8A7742) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 include/dt-bindings/power/r8a7742-sysc.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 include/dt-bindings/power/r8a7742-sysc.h

diff --git a/include/dt-bindings/power/r8a7742-sysc.h b/include/dt-bindings/power/r8a7742-sysc.h
new file mode 100644
index 0000000..1b1bd3c
--- /dev/null
+++ b/include/dt-bindings/power/r8a7742-sysc.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2020 Renesas Electronics Corp.
+ */
+#ifndef __DT_BINDINGS_POWER_R8A7742_SYSC_H__
+#define __DT_BINDINGS_POWER_R8A7742_SYSC_H__
+
+/*
+ * These power domain indices match the numbers of the interrupt bits
+ * representing the power areas in the various Interrupt Registers
+ * (e.g. SYSCISR, Interrupt Status Register)
+ */
+
+#define R8A7742_PD_CA15_CPU0		 0
+#define R8A7742_PD_CA15_CPU1		 1
+#define R8A7742_PD_CA15_CPU2		 2
+#define R8A7742_PD_CA15_CPU3		 3
+#define R8A7742_PD_CA7_CPU0		 5
+#define R8A7742_PD_CA7_CPU1		 6
+#define R8A7742_PD_CA7_CPU2		 7
+#define R8A7742_PD_CA7_CPU3		 8
+#define R8A7742_PD_CA15_SCU		12
+#define R8A7742_PD_RGX			20
+#define R8A7742_PD_CA7_SCU		21
+
+/* Always-on power area */
+#define R8A7742_PD_ALWAYS_ON		32
+
+#endif /* __DT_BINDINGS_POWER_R8A7742_SYSC_H__ */
-- 
2.7.4

