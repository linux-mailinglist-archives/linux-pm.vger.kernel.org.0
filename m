Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADE537086
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2019 11:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfFFJpi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jun 2019 05:45:38 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55420 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbfFFJph (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jun 2019 05:45:37 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190606094536euoutp02de61ec561b92e1b0a5d0c428def2eb60~lkt-WK9YY2740527405euoutp02g
        for <linux-pm@vger.kernel.org>; Thu,  6 Jun 2019 09:45:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190606094536euoutp02de61ec561b92e1b0a5d0c428def2eb60~lkt-WK9YY2740527405euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559814336;
        bh=zlH3bBR+P5usikNeVLM4OUrjiDC3GlD+c/+OesvzOXY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=AvsxlwIeublOHcpV5Y3fAJ4lHGV/4BDxYRiTgiFnCxZGNNDtq6MLpyPKmR8se6CiF
         PL4UyA9YzM+aacuvjdsvwgukQCWP55Q1jAorICEfp77Re+6z81iPINIWXChXiQg0UE
         Txv/n0es18sLfQfB9cZqSqw+wY3K5NkUycLHPF0o=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190606094535eucas1p21392aea13994213ba173148e9e5276ed~lkt_j-XDV1315313153eucas1p2z;
        Thu,  6 Jun 2019 09:45:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 02.AD.04325.EB0E8FC5; Thu,  6
        Jun 2019 10:45:34 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190606094534eucas1p1be0cda6cbc7979bf097767af27e900ed~lkt9yQ7xf0128601286eucas1p18;
        Thu,  6 Jun 2019 09:45:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190606094534eusmtrp27c34e32c8a83661a7e8592f7a5a34f87~lkt9iZir72910529105eusmtrp29;
        Thu,  6 Jun 2019 09:45:34 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-38-5cf8e0beb573
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 25.85.04146.DB0E8FC5; Thu,  6
        Jun 2019 10:45:33 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190606094533eusmtip22dc030ca4f624ee0d41b75c281cafe94~lkt8lwnaq1858418584eusmtip2G;
        Thu,  6 Jun 2019 09:45:33 +0000 (GMT)
Subject: Re: [PATCH v8 02/13] clk: samsung: add new clocks for DMC for
 Exynos5422 SoC
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <f070ab98-10bb-7ad4-f794-cfde9a75ddce@partner.samsung.com>
Date:   Thu, 6 Jun 2019 11:45:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPfW3QUH+6+g3NXPuogNxtr_uOtWKOwbgPwBVdqn4Y7a_Q@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUhUURTGu/OWeUpj18nyUFExFGWhVvbHlaIFoh4lklApZdTUPNRy1Oal
        2QKpRZZrWOg0jlaQCy6Y4+AykZVabuVCkq0gaaSmljlpYU45von873fO+c79zgeXo5RDzCIu
        LOK0oItQh6tYZ7ry2a82z9qen8Hrulo2kHJ9GUO6rZ8ZcruhjSHFo72I3GjJkZHnyVqS3vuF
        Iu3t9+XkRcKQnLy0GFkyltqAiL69VkZKGz7Iybv4QpbUDyUy5FHXbvJu0oWMN31E25T8+I8M
        ms+O66T5GsMHOW8qusbyqZdGWD7NXIT4itbz/Jhp6V7uoPNmjRAeFiPovLccdQ69ZL6Loqwb
        YyfTstk4dMMzCTlxgDdCvq1YnoScOSUuRHBV/14mFVYEuWWPHZMxBJnxTfS/lZTxPMegAMHn
        kk5GKoYRZJj6Z1TzcSA0pV9BdnbDHtA9NTEjonA5DVXVlul1jmOxF1QXnbJrFHgnpExmyOxM
        4xWQ8NTI2nkBDgJrjQlJGldovtU3874TDoAnjd8oO1PYHd723ZZJvAyqho2U3QvwLQ7e2zpY
        6ewdMNjdJ5d4Pgw2mh28BP7USMuARYhLvYskvgC96TkOzSaob7Sn5KYNPKDM4i21t0NJZzyy
        twG7wOthV+kEF8iozKKktgKuXlFK6tVgTulwGC2EgpJM+XWkMswKZpgVxjArjOG/7x1EFyF3
        IVrUhgiiT4RwxktUa8XoiBCv45FaE5r+g622xh/VqPb3sTqEOaSaq4DyiWAlo44Rz2rrEHCU
        yk0R0/EzWKnQqM+eE3SRR3TR4YJYhxZztMpdcX5OzyElDlGfFk4KQpSg+zeVcU6L4pD+uO+J
        5QmplydGwGdUvXj/vQAfTa7MttWo3WeJKvBvycKTPX57tj4s1u3anxMUVvbgkU5/c8r2inkd
        e7P4jan0Qtbhr0397KeCpMyLrYWJvl15HgHG5rUlU7nJMVObazUrD1RGB44yvgPx/t/5xNh5
        npzGr82iGvDMWZO/aluFTUWLoer1ayidqP4LU0UxXX8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42I5/e/4Pd29D37EGPS8trDYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aLyafmMlmc6c616H/8mtni/PkN7BZnm96wW1zeNYfN4nPvEUaLGef3MVms
        PXKX3eJ24wo2i8Nv2lkt9l/xsrj9m8/i24lHjA5CHt++TmLxmN1wkcVj56y77B6bVnWyefQ2
        v2Pz6NuyitFj8+lqj8+b5AI4ovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV
        9O1sUlJzMstSi/TtEvQymrcsZCz4YlLxu282WwPjZN0uRk4OCQETiZ5vS9m7GLk4hASWMkps
        OXKGFSIhJjFp33Z2CFtY4s+1LjaIoteMEi2r7rCAJIQFwiVO9LcxgtgiApoS1/9+ZwUpYhbY
        yCJx8VUvE0THBCaJthlXmbsYOTjYBPQkdqwqBGngFXCT6Pk9iQnEZhFQkWg6OocNxBYViJCY
        vauBBaJGUOLkzCdgNqdAoMTB4x+YQWxmAXWJP/MuQdniEreezGeCsOUltr+dwzyBUWgWkvZZ
        SFpmIWmZhaRlASPLKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMDY33bs5+YdjJc2Bh9iFOBg
        VOLhldj4PUaINbGsuDL3EKMEB7OSCG/ZhR8xQrwpiZVVqUX58UWlOanFhxhNgZ6byCwlmpwP
        TEt5JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoYnXk9I4LK+0P3
        lvr+mbnqyEzno8da3VlqQ2VX6v/0u65w96LYZo/H3qHvpFWLnRdsNj7o0LOQueqnEMOcvImL
        1H8KcU7dsPL6oV+q+3yZm7z9Rbc8tJJg03DRn7qBLyQmbdfnpezezx/PXr+52MDnhPWWrS4v
        D39Ov6iXleg5wenoyuWNJw83KbEUZyQaajEXFScCACeZCC0TAwAA
X-CMS-MailID: 20190606094534eucas1p1be0cda6cbc7979bf097767af27e900ed
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190605165428eucas1p11849754e0d0aa8f8d445ceb0cd6c2f61
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190605165428eucas1p11849754e0d0aa8f8d445ceb0cd6c2f61
References: <CGME20190605165428eucas1p11849754e0d0aa8f8d445ceb0cd6c2f61@eucas1p1.samsung.com>
        <20190605165410.14606-1-l.luba@partner.samsung.com>
        <20190605165410.14606-3-l.luba@partner.samsung.com>
        <CAJKOXPfW3QUH+6+g3NXPuogNxtr_uOtWKOwbgPwBVdqn4Y7a_Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From 9a7532004606875744eb67ad2ce17197ba2fe61e Mon Sep 17 00:00:00 2001
From: Lukasz Luba <l.luba@partner.samsung.com>
Date: Tue, 15 Jan 2019 17:12:16 +0100
Subject: [PATCH 02/13] clk: samsung: add new clocks for DMC for Exynos5422 SoC

This patch provides support for clocks needed for Dynamic Memory Controller
in Exynos5422 SoC. It adds CDREX base register addresses, new DIV, MUX and
GATE entries.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
Regarding the discussions of clocks mapped to the same registers,
this is a fix which adds the needed flag 'NOCACHE'.
It also has the ACK from Krzysztof.

Regards,
Lukasz

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

