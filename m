Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7661947E
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2019 23:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfEIVTj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 May 2019 17:19:39 -0400
Received: from shell.v3.sk ([90.176.6.54]:45823 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726764AbfEIVTj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 May 2019 17:19:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 5535657F2F;
        Thu,  9 May 2019 23:19:36 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id jfaHUI51auJT; Thu,  9 May 2019 23:19:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id F3972104033;
        Thu,  9 May 2019 23:19:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YwV1a_cSPCh1; Thu,  9 May 2019 23:19:18 +0200 (CEST)
Received: from furthur.local (g-server-2.ign.cz [91.219.240.2])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 0243A104027;
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
Subject: [PATCH RFC 4/7] clk: mmp2: add GPU clocks
Date:   Thu,  9 May 2019 23:19:08 +0200
Message-Id: <20190509211911.17998-5-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509211911.17998-1-lkundrak@v3.sk>
References: <20190509211911.17998-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The GC860 uses two different clocks for the GPU core and the AXI bus
interface, along with respective parent clock multiplexors.

Meaning of the relevant APMU_GPU bites were gotten from James Cameron's
message and [1] and the OLPC OS kernel source [2].

[1] http://lists.laptop.org/pipermail/devel/2019-April/039053.html
[2] http://dev.laptop.org/git/olpc-kernel/commit/arch/arm/mach-mmp/mmp2.c=
?h=3Darm-3.0-wip&id=3D8ce9f6122

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/clk/mmp/clk-of-mmp2.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.=
c
index a60a1be937ad..45f94c89cdc1 100644
--- a/drivers/clk/mmp/clk-of-mmp2.c
+++ b/drivers/clk/mmp/clk-of-mmp2.c
@@ -53,6 +53,7 @@
 #define APMU_DISP1	0x110
 #define APMU_CCIC0	0x50
 #define APMU_CCIC1	0xf4
+#define APMU_GPU	0xcc
 #define MPMU_UART_PLL	0x14
=20
 struct mmp2_clk_unit {
@@ -202,6 +203,13 @@ static const char *disp_parent_names[] =3D {"pll1", =
"pll1_16", "pll2", "vctcxo"};
 static DEFINE_SPINLOCK(ccic0_lock);
 static DEFINE_SPINLOCK(ccic1_lock);
 static const char *ccic_parent_names[] =3D {"pll1_2", "pll1_16", "vctcxo=
"};
+
+static DEFINE_SPINLOCK(gpu_lock);
+static const char *gpu_gc_parent_names[] =3D {"pll1_2", "pll1_3", "pll2_=
2", "pll2_3", "pll2", "usb_pll"};
+static u32 gpu_gc_parent_table[] =3D         {0x0000,   0x0040,   0x0080=
,   0x00c0,   0x1000, 0x1040   };
+static const char *gpu_bus_parent_names[] =3D {"pll1_4", "pll2", "pll2_2=
", "usb_pll"};
+static u32 gpu_bus_parent_table[] =3D         {0x0000,   0x0020, 0x0030,=
   0x4020   };
+
 static struct mmp_clk_mix_config ccic0_mix_config =3D {
 	.reg_info =3D DEFINE_MIX_REG_INFO(4, 17, 2, 6, 32),
 };
@@ -240,6 +248,8 @@ static struct mmp_param_gate_clk apmu_gate_clks[] =3D=
 {
 	{MMP2_CLK_CCIC1, "ccic1_clk", "ccic1_mix_clk", CLK_SET_RATE_PARENT, APM=
U_CCIC1, 0x1b, 0x1b, 0x0, 0, &ccic1_lock},
 	{MMP2_CLK_CCIC1_PHY, "ccic1_phy_clk", "ccic1_mix_clk", CLK_SET_RATE_PAR=
ENT, APMU_CCIC1, 0x24, 0x24, 0x0, 0, &ccic1_lock},
 	{MMP2_CLK_CCIC1_SPHY, "ccic1_sphy_clk", "ccic1_sphy_div", CLK_SET_RATE_=
PARENT, APMU_CCIC1, 0x300, 0x300, 0x0, 0, &ccic1_lock},
+	{MMP2_CLK_GPU_GC, "gpu_gc_clk", "gpu_gc_mux", CLK_SET_RATE_PARENT, APMU=
_GPU, 0x5, 0x5, 0x0, MMP_CLK_GATE_NEED_DELAY, &gpu_lock},
+	{MMP2_CLK_GPU_BUS, "gpu_bus_clk", "gpu_bus_mux", CLK_SET_RATE_PARENT, A=
PMU_GPU, 0xa, 0xa, 0x0, MMP_CLK_GATE_NEED_DELAY, &gpu_lock},
 };
=20
 static void mmp2_axi_periph_clk_init(struct mmp2_clk_unit *pxa_unit)
@@ -270,6 +280,22 @@ static void mmp2_axi_periph_clk_init(struct mmp2_clk=
_unit *pxa_unit)
 	mmp_register_mux_clks(unit, apmu_mux_clks, pxa_unit->apmu_base,
 				ARRAY_SIZE(apmu_mux_clks));
=20
+	clk =3D clk_register_mux_table(NULL, "gpu_gc_mux", gpu_gc_parent_names,
+					ARRAY_SIZE(gpu_gc_parent_names),
+					CLK_SET_RATE_PARENT,
+					pxa_unit->apmu_base + APMU_GPU,
+					0, 0x10c0, 0,
+					gpu_gc_parent_table, &gpu_lock);
+	mmp_clk_add(unit, MMP2_CLK_GPU_GC_MUX, clk);
+
+	clk =3D clk_register_mux_table(NULL, "gpu_bus_mux", gpu_bus_parent_name=
s,
+					ARRAY_SIZE(gpu_bus_parent_names),
+					CLK_SET_RATE_PARENT,
+					pxa_unit->apmu_base + APMU_GPU,
+					0, 0x4030, 0,
+					gpu_bus_parent_table, &gpu_lock);
+	mmp_clk_add(unit, MMP2_CLK_GPU_BUS_MUX, clk);
+
 	mmp_register_div_clks(unit, apmu_div_clks, pxa_unit->apmu_base,
 				ARRAY_SIZE(apmu_div_clks));
=20
--=20
2.21.0

