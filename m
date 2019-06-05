Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA834361EC
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 18:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfFEQzj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 12:55:39 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:32891 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728801AbfFEQyb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2019 12:54:31 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190605165430euoutp014f0d07a205b395e4daaf092750cd20f3~lW7L6qj4r3068430684euoutp01B
        for <linux-pm@vger.kernel.org>; Wed,  5 Jun 2019 16:54:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190605165430euoutp014f0d07a205b395e4daaf092750cd20f3~lW7L6qj4r3068430684euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559753670;
        bh=A8HnpCUReEUMVz/IBGX7wvwvTViRcrGotiz3i0a6drk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l2pgfRmOPrTccFibGrZyZGTyffgSvWRZm8oLJytrtAM6r4k1JTXvHpN2htaMDf3NB
         FQ+KMBgaOeEkWRNeQ5IbbbASQARgyjLdyOzB6IOCcHADyXe7mX2GgwNbcy3zK5FYNw
         00qs9/kD2fiF695UbcmoZzswlIlDSvRBB4/5qIMc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190605165429eucas1p1eb0544e2e097607c9bec9f037eddc5d4~lW7LI5UDj0321003210eucas1p10;
        Wed,  5 Jun 2019 16:54:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id FA.4E.04377.4C3F7FC5; Wed,  5
        Jun 2019 17:54:29 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190605165428eucas1p11849754e0d0aa8f8d445ceb0cd6c2f61~lW7KSo8ID0349303493eucas1p1b;
        Wed,  5 Jun 2019 16:54:28 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190605165428eusmtrp28015d54811c9973a3e87aec00032100b~lW7KDDO5n2868028680eusmtrp2I;
        Wed,  5 Jun 2019 16:54:28 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-ed-5cf7f3c47adf
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 62.B2.04146.4C3F7FC5; Wed,  5
        Jun 2019 17:54:28 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190605165427eusmtip166009aede1d12a541a224760be994470~lW7JIBe-F0338903389eusmtip1J;
        Wed,  5 Jun 2019 16:54:27 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v8 02/13] clk: samsung: add new clocks for DMC for
 Exynos5422 SoC
Date:   Wed,  5 Jun 2019 18:53:59 +0200
Message-Id: <20190605165410.14606-3-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605165410.14606-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSaUwTURSFfZ2ZzrRYGFsjF3FJmmhcIqAB86LGJSFx9JfBJVERrTIikaJ2
        AEHUFNSiRYSAyiKLRUmxaFisBIgBhSoimygEw5IgxGiwkrCIuKGOU/Xfl3POvee9l8cQagc1
        lwmPjOINkboIrVxJVj790rbiyfjnYL+eFhkuzyqlcPfEOwoXONooXDI6hHDG8zwZbknW49Sh
        DwRuby+jcWuik8Y9xnn4VU2uHI+nOBDOaq+V4XuOfhr3JhTLcYMzicJ1nVtx7zd3PPlsEG3U
        cJOf0knuhrGD5Kpz+mmuwnZJzqWcG5Fzj0ceyrgrdhvi7jfHc+MVC7Yp9ijXhfIR4TG8wXf9
        AeURq91JHh/zjS2+8wYZ0egSM1IwwPqD6Wo+ZUZKRs0WIzjXl0mLhpqdQNCSvUkyxhE86c1C
        fyfO5xhpybAiuFVUTf2bKJ7eZUYMI2d9oMp2QpRns/HQ111HiHmCdcqg9esUKRoadjtYktL+
        MMkugrIH3X9YxW4AS2IzKZUthJKyR4TICnYjXG+8T4qLgB2kocB6Wy6FAqG0tUkmsQaGG+20
        xPPgZ3WBSxfAmGJx3eA0DKXmuTJroaGxgxIPTbBLobTGV5I3wd2OBCTKwLrD64+zRJn4jemV
        mYQkq+CiSS2ll4D98gtX0Ryw3r3uWs6B+VsXkp4qA0FtWYM8DS3M+V92EyEb8uSjBX0YL6yK
        5E/6CDq9EB0Z5nPomL4C/f5bzdONE1Wo5vvBesQySDtTBeWfg9WULkaI09cjYAjtbJWudyJY
        rQrVxZ3iDcf2G6IjeKEeeTOk1lMVP2Ngr5oN00XxR3n+OG/468oYxVwjsgflG5NsITMGiNzE
        HRd4YvM+t67dHmfDvYDzqjJpphyKOqKw9q1f5c6QwMIz2ee7dgWtaihc/MPirlkeYB695GZC
        +WO5nYeTnYHJLUGm2CZTqPXq/PKvygQckO596qNH5poi8loGq7WMtb7fNpk7Ne27+k7aotQF
        L4dpfot/rJYUjuhWLiMMgu4XIn6S11cDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsVy+t/xu7pHPn+PMZh9l8ti44z1rBbXvzxn
        tZh/5ByrxeqPjxktJp+ay2RxpjvXov/xa2aL8+c3sFucbXrDbnGrQcbi8q45bBafe48wWsw4
        v4/JYu2Ru+wWtxtXsFkcftPOarH/ipfF7d98Ft9OPGJ0EPb49nUSi8fshossHjtn3WX32LSq
        k82jt/kdm8fBd3uYPPq2rGL02Hy62uPzJrkAzig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMT
        Sz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jOVb3rAUfNKvWLHyIWMD40eNLkZODgkBE4mWWQ3s
        XYxcHEICSxkl7n/vZIJIiElM2redHcIWlvhzrYsNougTo0RLawNjFyMHB5uAnsSOVYUgNSIC
        9RL9by6B1TALNDBLrNl+lRUkISwQKLF33y+wQSwCqhIbtl5nAbF5BewlFjadZoFYIC+xesMB
        ZhCbU8BBYtrxzWBxIaCaS9d/M09g5FvAyLCKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMJa2
        Hfu5eQfjpY3BhxgFOBiVeHglNn6PEWJNLCuuzD3EKMHBrCTCm3j7S4wQb0piZVVqUX58UWlO
        avEhRlOgoyYyS4km5wPjPK8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8T
        B6dUA6PbpPbN3TYS5+qt39W+3mHz9kr1zpIJp83b5R+fkFTTCd0f5v2n3GL/8fWnWRuF78qr
        Z/WL/bba8erc8fXLfttPXXz54OEHLxykmbqq1Rd7/Tx+0/UJ+ySFKIknTA7L85k2bTaXifr2
        fsdFN5uFnPzNeoJSU1oqme22bLg64+feoAi7aB8nx89KLMUZiYZazEXFiQCZp5A2uwIAAA==
X-CMS-MailID: 20190605165428eucas1p11849754e0d0aa8f8d445ceb0cd6c2f61
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190605165428eucas1p11849754e0d0aa8f8d445ceb0cd6c2f61
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190605165428eucas1p11849754e0d0aa8f8d445ceb0cd6c2f61
References: <20190605165410.14606-1-l.luba@partner.samsung.com>
        <CGME20190605165428eucas1p11849754e0d0aa8f8d445ceb0cd6c2f61@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch provides support for clocks needed for Dynamic Memory Controller
in Exynos5422 SoC. It adds CDREX base register addresses, new DIV, MUX and
GATE entries.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 57 ++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 34cce3c5898f..eecbfcc6b3cf 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -134,6 +134,8 @@
 #define SRC_CDREX		0x20200
 #define DIV_CDREX0		0x20500
 #define DIV_CDREX1		0x20504
+#define GATE_BUS_CDREX0		0x20700
+#define GATE_BUS_CDREX1		0x20704
 #define KPLL_LOCK		0x28000
 #define KPLL_CON0		0x28100
 #define SRC_KFC			0x28200
@@ -248,6 +250,8 @@ static const unsigned long exynos5x_clk_regs[] __initconst = {
 	DIV_CDREX1,
 	SRC_KFC,
 	DIV_KFC0,
+	GATE_BUS_CDREX0,
+	GATE_BUS_CDREX1,
 };
 
 static const unsigned long exynos5800_clk_regs[] __initconst = {
@@ -425,6 +429,9 @@ PNAME(mout_group13_5800_p)	= { "dout_osc_div", "mout_sw_aclkfl1_550_cam" };
 PNAME(mout_group14_5800_p)	= { "dout_aclk550_cam", "dout_sclk_sw" };
 PNAME(mout_group15_5800_p)	= { "dout_osc_div", "mout_sw_aclk550_cam" };
 PNAME(mout_group16_5800_p)	= { "dout_osc_div", "mout_mau_epll_clk" };
+PNAME(mout_mx_mspll_ccore_phy_p) = { "sclk_bpll", "mout_sclk_dpll",
+					"mout_sclk_mpll", "ff_dout_spll2",
+					"mout_sclk_spll", "mout_sclk_epll"};
 
 /* fixed rate clocks generated outside the soc */
 static struct samsung_fixed_rate_clock
@@ -450,7 +457,7 @@ static const struct samsung_fixed_factor_clock
 static const struct samsung_fixed_factor_clock
 		exynos5800_fixed_factor_clks[] __initconst = {
 	FFACTOR(0, "ff_dout_epll2", "mout_sclk_epll", 1, 2, 0),
-	FFACTOR(0, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),
+	FFACTOR(CLK_FF_DOUT_SPLL2, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),
 };
 
 static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
@@ -472,11 +479,14 @@ static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
 	MUX(0, "mout_aclk300_disp1", mout_group5_5800_p, SRC_TOP2, 24, 2),
 	MUX(0, "mout_aclk300_gscl", mout_group5_5800_p, SRC_TOP2, 28, 2),
 
+	MUX(CLK_MOUT_MX_MSPLL_CCORE_PHY, "mout_mx_mspll_ccore_phy",
+		mout_mx_mspll_ccore_phy_p, SRC_TOP7, 0, 3),
+
 	MUX(CLK_MOUT_MX_MSPLL_CCORE, "mout_mx_mspll_ccore",
-			mout_mx_mspll_ccore_p, SRC_TOP7, 16, 2),
+			mout_mx_mspll_ccore_p, SRC_TOP7, 16, 3),
 	MUX_F(CLK_MOUT_MAU_EPLL, "mout_mau_epll_clk", mout_mau_epll_clk_5800_p,
 			SRC_TOP7, 20, 2, CLK_SET_RATE_PARENT, 0),
-	MUX(0, "sclk_bpll", mout_bpll_p, SRC_TOP7, 24, 1),
+	MUX(CLK_SCLK_BPLL, "sclk_bpll", mout_bpll_p, SRC_TOP7, 24, 1),
 	MUX(0, "mout_epll2", mout_epll2_5800_p, SRC_TOP7, 28, 1),
 
 	MUX(0, "mout_aclk550_cam", mout_group3_5800_p, SRC_TOP8, 16, 3),
@@ -648,7 +658,7 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
 
 	MUX(0, "mout_sclk_mpll", mout_mpll_p, SRC_TOP6, 0, 1),
 	MUX(CLK_MOUT_VPLL, "mout_sclk_vpll", mout_vpll_p, SRC_TOP6, 4, 1),
-	MUX(0, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
+	MUX(CLK_MOUT_SCLK_SPLL, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
 	MUX(0, "mout_sclk_ipll", mout_ipll_p, SRC_TOP6, 12, 1),
 	MUX(0, "mout_sclk_rpll", mout_rpll_p, SRC_TOP6, 16, 1),
 	MUX_F(CLK_MOUT_EPLL, "mout_sclk_epll", mout_epll_p, SRC_TOP6, 20, 1,
@@ -806,8 +816,21 @@ static const struct samsung_div_clock exynos5x_div_clks[] __initconst = {
 			"mout_aclk400_disp1", DIV_TOP2, 4, 3),
 
 	/* CDREX Block */
+	/*
+	 * The three clocks below are controlled using the same register and
+	 * bits. They are put into one because there is a need of
+	 * synchronization between the BUS and DREXs (two external memory
+	 * interfaces).
+	 * They are put here to show this HW assumption and for clock
+	 * information summary completeness.
+	 */
 	DIV(CLK_DOUT_PCLK_CDREX, "dout_pclk_cdrex", "dout_aclk_cdrex1",
 			DIV_CDREX0, 28, 3),
+	DIV(CLK_DOUT_PCLK_DREX0, "dout_pclk_drex0", "dout_cclk_drex0",
+			DIV_CDREX0, 28, 3),
+	DIV(CLK_DOUT_PCLK_DREX1, "dout_pclk_drex1", "dout_cclk_drex0",
+			DIV_CDREX0, 28, 3),
+
 	DIV_F(CLK_DOUT_SCLK_CDREX, "dout_sclk_cdrex", "mout_mclk_cdrex",
 			DIV_CDREX0, 24, 3, CLK_SET_RATE_PARENT, 0),
 	DIV(CLK_DOUT_ACLK_CDREX1, "dout_aclk_cdrex1", "dout_clk2x_phy0",
@@ -1170,6 +1193,32 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
 			GATE_TOP_SCLK_ISP, 12, CLK_SET_RATE_PARENT, 0),
 
 	GATE(CLK_G3D, "g3d", "mout_user_aclk_g3d", GATE_IP_G3D, 9, 0, 0),
+
+	/* CDREX */
+	GATE(CLK_CLKM_PHY0, "clkm_phy0", "dout_sclk_cdrex",
+			GATE_BUS_CDREX0, 0, 0, 0),
+	GATE(CLK_CLKM_PHY1, "clkm_phy1", "dout_sclk_cdrex",
+			GATE_BUS_CDREX0, 1, 0, 0),
+	GATE(0, "mx_mspll_ccore_phy", "mout_mx_mspll_ccore_phy",
+			SRC_MASK_TOP7, 0, CLK_IGNORE_UNUSED, 0),
+
+	GATE(CLK_ACLK_PPMU_DREX1_1, "aclk_ppmu_drex1_1", "dout_aclk_cdrex1",
+			GATE_BUS_CDREX1, 12, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK_PPMU_DREX1_0, "aclk_ppmu_drex1_0", "dout_aclk_cdrex1",
+			GATE_BUS_CDREX1, 13, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK_PPMU_DREX0_1, "aclk_ppmu_drex0_1", "dout_aclk_cdrex1",
+			GATE_BUS_CDREX1, 14, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_ACLK_PPMU_DREX0_0, "aclk_ppmu_drex0_0", "dout_aclk_cdrex1",
+			GATE_BUS_CDREX1, 15, CLK_IGNORE_UNUSED, 0),
+
+	GATE(CLK_PCLK_PPMU_DREX1_1, "pclk_ppmu_drex1_1", "dout_pclk_cdrex",
+			GATE_BUS_CDREX1, 26, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_PCLK_PPMU_DREX1_0, "pclk_ppmu_drex1_0", "dout_pclk_cdrex",
+			GATE_BUS_CDREX1, 27, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_PCLK_PPMU_DREX0_1, "pclk_ppmu_drex0_1", "dout_pclk_cdrex",
+			GATE_BUS_CDREX1, 28, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_PCLK_PPMU_DREX0_0, "pclk_ppmu_drex0_0", "dout_pclk_cdrex",
+			GATE_BUS_CDREX1, 29, CLK_IGNORE_UNUSED, 0),
 };
 
 static const struct samsung_div_clock exynos5x_disp_div_clks[] __initconst = {
-- 
2.17.1

