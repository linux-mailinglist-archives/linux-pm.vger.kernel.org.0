Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EECA459A1
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 11:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfFNJy3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 05:54:29 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54512 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfFNJxY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2019 05:53:24 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190614095323euoutp02cacaa90777523e966b2b8f110baa0809~oB-FIat0s1678716787euoutp02r
        for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2019 09:53:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190614095323euoutp02cacaa90777523e966b2b8f110baa0809~oB-FIat0s1678716787euoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560506003;
        bh=2ngHfOBEYocX9CkGDapktNZGAkA7rLNRQygJopZxD+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zch8DLX1Hkrf/RWXBDkSXTGOy9TyGmnFlr8a161WdGct4n4fhI791MasSnxIZjBTw
         UCggQfLFPrn7ZFBFMJerPUyOlaAn0p/W22QWHb3ZqvCi9BMBbYM9FjZdojIKskW8OL
         gaXsVfqC159xmtAx1ArLYXkGCrOGsCmCIMApej2k=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190614095322eucas1p1dfedf1bc7f2604b632654dd700087517~oB-EIfElN1132211322eucas1p1K;
        Fri, 14 Jun 2019 09:53:22 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 3A.30.04377.29E630D5; Fri, 14
        Jun 2019 10:53:22 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190614095321eucas1p2af62f3cdf78ba3c5a8013159da4f7502~oB-DXEq-v0482404824eucas1p2e;
        Fri, 14 Jun 2019 09:53:21 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190614095321eusmtrp2d214c4ae97a073d667584defb5da59fb~oB-DWcTpQ2148621486eusmtrp2z;
        Fri, 14 Jun 2019 09:53:21 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-1d-5d036e925d48
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6C.30.04146.19E630D5; Fri, 14
        Jun 2019 10:53:21 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190614095320eusmtip2e7443de2ccbd44afca2b1c8b67421d56~oB-CYKcy42320823208eusmtip2O;
        Fri, 14 Jun 2019 09:53:20 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        gregkh@linuxfoundation.org, willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v10 02/13] clk: samsung: add new clocks for DMC for
 Exynos5422 SoC
Date:   Fri, 14 Jun 2019 11:52:58 +0200
Message-Id: <20190614095309.24100-3-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614095309.24100-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfUhTYRTGe3d37+5Wk9uUfMmRtAhMaJakvWVWUsFFCILsn0Jq5U0jN3XX
        WWbEUjQ1P0ozbWZaisqm2NbIj8rptIzMrz5XS6mUDFuWuhIpra276r/fec553udweElM8h5f
        Th5TJTNqlSJeRoj4tx/M9a8tUmHR62rPQ2Qsa8LRS+c4jiq7+3FkmBoFKKO6iUDFjyp46PF5
        JSoc/YShgYGbAtSX7hCg11opmsobwdHTtqsEmsnvBqhsoJ2HGruHBWjo0S5kP1tPoC7HORwt
        vDDykeVZJLL/8ELfH74H233p79+K+PQXW6aALtcO8elW3bCANulzCNpS0SCg8zMmCbpz8i6P
        LjDrAX2rN42eMa3Ys3i/aEsME38shVEHbT0kiivJySQSB9efrLb0AS1oC8wFQhJSG+C9sWEs
        F4hICVUPYKldD7jCCWD7/E+CK2YAHDQ5eH8tX61OHteoA/BNZh7+z1Lz1eYqSJKg5LBFn+Q2
        +FBlAJZ/3OuewahmDH62vwHuhjcVBTsbav4wn1oNR573Em4WU9vguPkdn0vzh4abHZibhdR2
        eL/SQXD6RRJaBoUc74RdHVacY2840WMWcCyFv1orPVuzUJt/HXB8Go4WVnhmwmBXz9CfnTFq
        DWxqC+LkCKi70Uy4ZUh5QdvnpW4Zc2HR7VKMk8UwO0vCTQdAc96gJ2gZrGu47HmchvXzDs8N
        i12nmp3GLgB/3f+wKgD0wJfRsMpYhg1WMSfkrELJalSx8iMJShNw/bzehR5nC2j7edgKKBLI
        log7NvOiJbgihU1VWgEkMZmP+FoYFi0RxyhSTzHqhINqTTzDWoEfyZf5itMWvT0goWIVycxx
        hklk1H+7PFK4XAsiVmIZOddF2brpYGl1hs34QagpTsk+G2VwPt+fnbTxTEiLaiy9dsW7O/lx
        8r6A+rKQvprGifCdiYZXNTFYenfW5Lbj96QX5p6E+tPBQeZcH8NDfWlVRK093Hh0k1aG95b0
        izTeO9SFCfdX+RXII2/ZZi9dyTXp9k1khU6U7F56R8Zn4xTrAzE1q/gNTcbVCXUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsVy+t/xe7oT85hjDXpbdC02zljPanH9y3NW
        i/lHzrFarP74mNGiefF6NovJp+YyWZzpzrXof/ya2eL8+Q3sFmeb3rBb3GqQsfjYc4/V4vKu
        OWwWn3uPMFrMOL+PyWLtkbvsFhdPuVrcblzBZnH4TTurxb9rG1ks9l/xsrj9m8/i24lHjA7i
        Ht++TmLxeH+jld1jdsNFFo+ds+6ye2xa1cnmsX/uGnaP3uZ3bB4H3+1h8ujbsorRY/Ppao/P
        m+QCuKP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0
        MqZ2trIVXDCsWLz/LGMD4y6tLkZODgkBE4kPh74wdTFycQgJLGWUmNq4iBkiISYxad92dghb
        WOLPtS42EFtI4BOjxJHpkV2MHBxsAnoSO1YVgvSKCMxhlPjZtY0RxGEWOMsssXvFGyaQBmGB
        IIlpvWvBmlkEVCXuXT0NZvMK2Es83/KQBWKBvMTqDQfAFnMKOEgcnf+GDWSBEFDN9xn8Exj5
        FjAyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiMwW3Hfm7ewXhpY/AhRgEORiUe3gNWTLFC
        rIllxZW5hxglOJiVRHjnWTPHCvGmJFZWpRblxxeV5qQWH2I0BbppIrOUaHI+MD3klcQbmhqa
        W1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpgNDWXPnBZ5rYOT8Cr6d93bfu0
        amqMz70r0tVfNng+bbpz8pFxv4Xf3AlLr/v/XrH9zyO/tgsfCipdjh74aLRQy29BweqrC33b
        Fu3e8tF5QyuLw1GhOVdNzjrNr2eadP9nwfd8F0dh+ZdzQ0/Nv/MjdurylE/Wk8/6fbdYvV5Z
        993Vm3PWLfkUd/+GEktxRqKhFnNRcSIAHayblNcCAAA=
X-CMS-MailID: 20190614095321eucas1p2af62f3cdf78ba3c5a8013159da4f7502
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190614095321eucas1p2af62f3cdf78ba3c5a8013159da4f7502
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190614095321eucas1p2af62f3cdf78ba3c5a8013159da4f7502
References: <20190614095309.24100-1-l.luba@partner.samsung.com>
        <CGME20190614095321eucas1p2af62f3cdf78ba3c5a8013159da4f7502@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch provides support for clocks needed for Dynamic Memory Controller
in Exynos5422 SoC. It adds CDREX base register addresses, new DIV, MUX and
GATE entries.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 61 +++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 34cce3c5898f..514e16310227 100644
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
-	DIV(CLK_DOUT_PCLK_CDREX, "dout_pclk_cdrex", "dout_aclk_cdrex1",
-			DIV_CDREX0, 28, 3),
+	/*
+	 * The three clocks below are controlled using the same register and
+	 * bits. They are put into one because there is a need of
+	 * synchronization between the BUS and DREXs (two external memory
+	 * interfaces).
+	 * They are put here to show this HW assumption and for clock
+	 * information summary completeness.
+	 */
+	DIV_F(CLK_DOUT_PCLK_CDREX, "dout_pclk_cdrex", "dout_aclk_cdrex1",
+			DIV_CDREX0, 28, 3, CLK_GET_RATE_NOCACHE, 0),
+	DIV_F(CLK_DOUT_PCLK_DREX0, "dout_pclk_drex0", "dout_cclk_drex0",
+			DIV_CDREX0, 28, 3, CLK_GET_RATE_NOCACHE, 0),
+	DIV_F(CLK_DOUT_PCLK_DREX1, "dout_pclk_drex1", "dout_cclk_drex0",
+			DIV_CDREX0, 28, 3, CLK_GET_RATE_NOCACHE, 0),
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

