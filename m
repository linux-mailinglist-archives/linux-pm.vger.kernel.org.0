Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 230311947B
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2019 23:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfEIVTd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 May 2019 17:19:33 -0400
Received: from shell.v3.sk ([90.176.6.54]:45801 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbfEIVTd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 May 2019 17:19:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 22EA2104036;
        Thu,  9 May 2019 23:19:31 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id tVSJ4BL4c0AJ; Thu,  9 May 2019 23:19:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 53AC310402F;
        Thu,  9 May 2019 23:19:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Q5kk3_USBzoz; Thu,  9 May 2019 23:19:17 +0200 (CEST)
Received: from furthur.local (g-server-2.ign.cz [91.219.240.2])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 3192E104025;
        Thu,  9 May 2019 23:19:17 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     linux-pm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        James Cameron <quozl@laptop.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH RFC 2/7] dt-bindings: marvell,mmp2: Add clock ids for the GPU clocks
Date:   Thu,  9 May 2019 23:19:06 +0200
Message-Id: <20190509211911.17998-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509211911.17998-1-lkundrak@v3.sk>
References: <20190509211911.17998-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The GC860 GPU uses two distinct clocks for the graphics core, and the AXI
bus interface, along with respective parent clock multiplexers.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 include/dt-bindings/clock/marvell,mmp2.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/marvell,mmp2.h b/include/dt-bindin=
gs/clock/marvell,mmp2.h
index e785c6eb3561..4b31abd998f1 100644
--- a/include/dt-bindings/clock/marvell,mmp2.h
+++ b/include/dt-bindings/clock/marvell,mmp2.h
@@ -72,6 +72,10 @@
 #define MMP2_CLK_CCIC1_PHY		118
 #define MMP2_CLK_CCIC1_SPHY		119
 #define MMP2_CLK_DISP0_LCDC		120
+#define MMP2_CLK_GPU_GC_MUX		121
+#define MMP2_CLK_GPU_GC			122
+#define MMP2_CLK_GPU_BUS_MUX		123
+#define MMP2_CLK_GPU_BUS		124
=20
 #define MMP2_NR_CLKS			200
 #endif
--=20
2.21.0

