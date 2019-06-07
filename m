Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB86F38D62
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 16:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbfFGOhD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jun 2019 10:37:03 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50149 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729259AbfFGOfa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jun 2019 10:35:30 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190607143527euoutp014a4228812f5aad7e9db507f237e95a68~l8UWmaGMa0124901249euoutp01g
        for <linux-pm@vger.kernel.org>; Fri,  7 Jun 2019 14:35:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190607143527euoutp014a4228812f5aad7e9db507f237e95a68~l8UWmaGMa0124901249euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559918127;
        bh=2ngHfOBEYocX9CkGDapktNZGAkA7rLNRQygJopZxD+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PpDXnOMmXh8/NiTqX5gIU2ID/oyojPHoc6E6G7tsCDgiIZvYSkgB4uLS2eCemlDLl
         87anjO8lwCGpLEi6at5eTt41u7du0WDQ4zWweadYWVjlU16Gt9TQnO/bVoAcIuj336
         5eqjPs/fpDVVyZDWrDKvcbPajefCsevXxtCl43AE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190607143526eucas1p2c7d65259db825cf93a41ac969239d172~l8UVwhFA42700327003eucas1p2T;
        Fri,  7 Jun 2019 14:35:26 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id FA.A3.04298.E267AFC5; Fri,  7
        Jun 2019 15:35:26 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190607143525eucas1p15a57ab0f8b9e6ce2e77702f04ebf0c22~l8UU9xqpG1208812088eucas1p1R;
        Fri,  7 Jun 2019 14:35:25 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190607143525eusmtrp145b9731465b65f9ce30d27c24678e037~l8UUuA-zW1284512845eusmtrp1T;
        Fri,  7 Jun 2019 14:35:25 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-7f-5cfa762e735f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D5.C0.04140.D267AFC5; Fri,  7
        Jun 2019 15:35:25 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190607143524eusmtip1ee5da7a9611cf8e8549029f7d46855b6~l8UT2jgla2644726447eusmtip1t;
        Fri,  7 Jun 2019 14:35:24 +0000 (GMT)
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
Subject: [PATCH v9 02/13] clk: samsung: add new clocks for DMC for
 Exynos5422 SoC
Date:   Fri,  7 Jun 2019 16:34:56 +0200
Message-Id: <20190607143507.30286-3-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190607143507.30286-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSaUhUURT2zpu3ODXyGiUPWkkTQSpu6I9LSgttjzAK7E8l1ZgPtRyzeWmZ
        BaNm5palVINmGUGKuaSZ6aCpM5LmbrZYLmQTJeVWpqWWNOOb6N93v+V8h8NlCMUI6cRERJ3m
        NVGqSCUlk1Y/m+vy8IydD/aub6Jxha6cxG9+fCbxneYuEj/4ZkI46V45hXPa8iW4I12Ns0xf
        Cdzd/ZDGnYljNH6nXYW/ZQyTuE9/i8LTmc0I67qfSnBp8xCNe9t24IGEIgobx1JIvPi6Qoob
        Xu7GAwt2eLb1A9riyM3OZEu5yf5kmsvT9kq52twhmqssTqW4hvwSmstMmqC4pok6CXelqhhx
        j9rjuenKNfuWHZQFhPKREbG8xmvTUVn49dRkKrrH5+y9hk6kRXq3NGTLAOsHrWVNVBqSMQq2
        CMFiw3PSIijYHwjackAUphHc1xmIfwl96qJEFAoR6KYKrHFzIs84YX4wDMV6Qk3xKUvAgdWZ
        +dEgi4dgnxAwPjCILII9GwRJ06VLU6XsepgcqV/CcnYzGBL6aLHNBR48bFzibdktkFdds1QG
        bCoDg4Va60rbYfxVhxXbw5eWKmt4FbTnZEhFLIA28y4S8XkwZeVbPf5gbOklLUsTrCuU671E
        eitc/P1SYqGBtYP+8RUWmjDD7OqbhEjL4fIlhejeAFUZPRIRr4TCkhvW4Rzc/1SIxIPmIEhp
        9L2KXHL/dxUgVIwc+RhBHcYLPlH8GU9BpRZiosI8j51UVyLzx2tfbPleg2ZehBgQyyDlcjlH
        zwUrSFWsEKc2IGAIpYM8tudXsEIeqoo7x2tOHtHERPKCATkzUqWjPN7m/SEFG6Y6zZ/g+Whe
        80+VMLZOWnS4CY4b50L8Nu/8WRdhXFvyy9URJbnrE5MX4lNcPlZ4EVOl/DZd7dvA9QcOrLbT
        L/dbXYb+PHay9UgbndQdkf0MWCGDqYCxdenKV7tuu1+Y8O6bSc/es9fHtKbb22a+Q7Er5sXG
        Yd+joRrepKznp05dk2Xu35AS6FQ0G6Jz9lf1K6VCuMrHjdAIqr+n1v1vdAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xu7q6Zb9iDD49FbXYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aL5sXr2Swmn5rLZHGmO9ei//FrZovz5zewW5xtesNucatBxuJjzz1Wi8u7
        5rBZfO49wmgx4/w+Jou1R+6yW1w85Wpxu3EFm8XhN+2sFv+ubWSx2H/Fy+L2bz6LbyceMTqI
        e3z7OonF4/2NVnaP2Q0XWTx2zrrL7rFpVSebx/65a9g9epvfsXkcfLeHyaNvyypGj82nqz0+
        b5IL4I7SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQ
        y5ja2cpWcMGwYvH+s4wNjLu0uhg5OSQETCR2df5j6mLk4hASWMooMfHiZ3aIhJjEpH3boWxh
        iT/Xutggij4xShxY/Yq1i5GDg01AT2LHqkKQuIjAHEaJn13bGEEcZoGzzBK7V7xhAukWFgiU
        aJ3RwAxiswioSrx/uBfM5hWwlzjUeBlqg7zE6g0HwOKcAg4Ss7ftYANZIARUs+q5wwRGvgWM
        DKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECo3DbsZ9bdjB2vQs+xCjAwajEwzuD6WeMEGti
        WXFl7iFGCQ5mJRHesgs/YoR4UxIrq1KL8uOLSnNSiw8xmgLdNJFZSjQ5H5gg8kriDU0NzS0s
        Dc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MCr1u7kdv35W0cDKLa9uw/8Va5wq
        zvVYCq10uJ68tdUicgK/oZOm6J9DfYG+9rkzrp/WDJLOX5SayWpdUvJ6poK543pl/Qlv4tr+
        97Vvl/y9d/WZ6fsrl6y4+iR6ZbCTdOschlez3KJ8hWdYvcjQm/f46YS4RX1LKti+v4yJ63h7
        TKVgmeLH6UosxRmJhlrMRcWJALaHMXrYAgAA
X-CMS-MailID: 20190607143525eucas1p15a57ab0f8b9e6ce2e77702f04ebf0c22
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190607143525eucas1p15a57ab0f8b9e6ce2e77702f04ebf0c22
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190607143525eucas1p15a57ab0f8b9e6ce2e77702f04ebf0c22
References: <20190607143507.30286-1-l.luba@partner.samsung.com>
        <CGME20190607143525eucas1p15a57ab0f8b9e6ce2e77702f04ebf0c22@eucas1p1.samsung.com>
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

