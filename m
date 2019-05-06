Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2889D14FC1
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2019 17:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfEFPNo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 May 2019 11:13:44 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49970 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfEFPMP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 May 2019 11:12:15 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190506151213euoutp021e2eb98ced55f269a38bc5ad389d434c~cILURDDhB3023330233euoutp02Z
        for <linux-pm@vger.kernel.org>; Mon,  6 May 2019 15:12:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190506151213euoutp021e2eb98ced55f269a38bc5ad389d434c~cILURDDhB3023330233euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557155533;
        bh=j8Ch1cCUwAsIkp+KzHX0OQq7o5n5aghNqXMGrOsBPw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mdOmJRIHG4n4P3e5gaCBQfoZOgVS0lCCSAGXUCiEOsbgDXMm3WV0RuDcbCdOYlOi5
         FS3wfJCORONXizql9VloR3Db4ztay0JCZ7FEuYv9xJLb2Vg74/n5mYABo9DuT1mfbX
         kktsBvGNljub6WI4WV/pgFjubHRMRhvG0btzSam4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190506151212eucas1p2ff076b6d1cfa2758532dd2caa556e293~cILTi0fKG1252212522eucas1p22;
        Mon,  6 May 2019 15:12:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 95.E1.04325.CCE40DC5; Mon,  6
        May 2019 16:12:12 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190506151211eucas1p2d96d7eaa4cda8f8d1787d8f1f1461b9b~cILSxYvYI1272612726eucas1p2L;
        Mon,  6 May 2019 15:12:11 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190506151211eusmtrp27b868ba3ac79abce3a6ceba6fb7d8aa2~cILSs1ViV0409004090eusmtrp2I;
        Mon,  6 May 2019 15:12:11 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-72-5cd04ecc4de7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 88.5D.04146.BCE40DC5; Mon,  6
        May 2019 16:12:11 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190506151210eusmtip17e307923248a9318872699d51ab621dc~cILR8PVtt3248532485eusmtip1r;
        Mon,  6 May 2019 15:12:10 +0000 (GMT)
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
Subject: [PATCH v7 02/13] clk: samsung: add new clocks for DMC for
 Exynos5422 SoC
Date:   Mon,  6 May 2019 17:11:50 +0200
Message-Id: <1557155521-30949-3-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsWy7djP87pn/C7EGEw7z2WxccZ6VovrX56z
        Wsw/co7VYvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7jVIGNxedccNovPvUcYLWac
        38dksfbIXXaL240r2CwOv2lntdh/xcvi9m8+i28nHjE6CHt8+zqJxWN2w0UWj52z7rJ7bFrV
        yebR2/yOzePguz1MHn1bVjF6bD5d7fF5k1wAZxSXTUpqTmZZapG+XQJXxvr7O5gLHhpW/Lix
        jrmBcYtWFyMnh4SAicTMNS+Yuhi5OIQEVjBKNP6ZC+V8YZToaFnMBuF8ZpRYuGUGI0zLh78/
        oaqWM0o82NPJDtdyds4T1i5GDg42AT2JHasKQRpEBKol7lzfzwxSwyzwhkni7K8fLCAJYYFg
        iTvdTYwg9SwCqhLf3vKAmLwCXhJrf0PtkpO4ea6TGcTmFPCW+NtxiBFkjITAPXaJ1kebWSCK
        XCT6Nm1mhrCFJV4d38IOYctI/N85nwnCLpZo6F0INbRG4nH/XKgaa4nDxy+CncwsoCmxfpc+
        RNhRouvLCrCwhACfxI23giBhZiBz0rbpzBBhXomONiGIag2JLT0XoBaJSSxfMw1quIfExSW9
        0CCcxyjR8/Mp6wRG+VkIyxYwMq5iFE8tLc5NTy02zkst1ytOzC0uzUvXS87P3cQITFun/x3/
        uoNx35+kQ4wCHIxKPLwTnC7ECLEmlhVX5h5ilOBgVhLhTXx2LkaINyWxsiq1KD++qDQntfgQ
        ozQHi5I4bzXDg2ghgfTEktTs1NSC1CKYLBMHp1QD45kmI3adRL2E32qS4QERP9q/XBPVy2DQ
        NAqvixCz0nS3ZwiyjuvkUZkxnTGkYIHno+SXgUrXXm4zXez7K05Ru/FlwY5l/Cm7Hs29WS82
        7WjMEo2/e9n0AnpNfhXq+MfZXHzzYdMZ641yjqr+O2J23XnmrxH1Puvoqr3/ltUslG/8+cJx
        u0eoEktxRqKhFnNRcSIAS9IyMFcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xu7qn/S7EGPyYKmuxccZ6VovrX56z
        Wsw/co7VYvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7jVIGNxedccNovPvUcYLWac
        38dksfbIXXaL240r2CwOv2lntdh/xcvi9m8+i28nHjE6CHt8+zqJxWN2w0UWj52z7rJ7bFrV
        yebR2/yOzePguz1MHn1bVjF6bD5d7fF5k1wAZ5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
        pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexvr7O5gLHhpW/LixjrmBcYtWFyMnh4SAicSHvz+Z
        uhi5OIQEljJKLFw9iwkiISYxad92dghbWOLPtS42iKJPjBIrJ+0Fcjg42AT0JHasKgSpERGo
        l+h/cwmshlmggVlizfarrCAJYYFAiQVn25lB6lkEVCW+veUBMXkFvCTW/maEGC8ncfNcJzOI
        zSngLfG34xBYXAioZN/H3ywTGPkWMDKsYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIyjbcd+
        bt7BeGlj8CFGAQ5GJR7eB7YXYoRYE8uKK3MPMUpwMCuJ8CY+OxcjxJuSWFmVWpQfX1Sak1p8
        iNEU6KSJzFKiyfnAGM8riTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp
        1cA44cS+HcbqDY/t/ARZVb4KHBO05ptmMnlX37H06N/tvvMXvfWb39unO8f4+a7p//YebQ0N
        q77htD3p4FMNMZflF2Mm8YrkKG3V3hnj4c8ZIS7PklkYKT/L62y/5PJ/q2yfVkzfWv6aqfL6
        vZ9hRhwzi8XnLvJ+bC877/KTlNVfuA07pidEblyixFKckWioxVxUnAgAikYtI7kCAAA=
X-CMS-MailID: 20190506151211eucas1p2d96d7eaa4cda8f8d1787d8f1f1461b9b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190506151211eucas1p2d96d7eaa4cda8f8d1787d8f1f1461b9b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190506151211eucas1p2d96d7eaa4cda8f8d1787d8f1f1461b9b
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190506151211eucas1p2d96d7eaa4cda8f8d1787d8f1f1461b9b@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch provides support for clocks needed for Dynamic Memory Controller
in Exynos5422 SoC. It adds CDREX base register addresses, new DIV, MUX and
GATE entries.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 58 +++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 34cce3c..af62b6d 100644
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
@@ -817,6 +840,7 @@ static const struct samsung_div_clock exynos5x_div_clks[] __initconst = {
 	DIV(CLK_DOUT_CLK2X_PHY0, "dout_clk2x_phy0", "dout_sclk_cdrex",
 			DIV_CDREX0, 3, 5),
 
+
 	DIV(CLK_DOUT_PCLK_CORE_MEM, "dout_pclk_core_mem", "mout_mclk_cdrex",
 			DIV_CDREX1, 8, 3),
 
@@ -1170,6 +1194,32 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
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
2.7.4

