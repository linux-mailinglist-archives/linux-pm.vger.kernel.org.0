Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A97A361B7
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 18:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbfFEQyh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 12:54:37 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:32948 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728868AbfFEQyg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2019 12:54:36 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190605165435euoutp0152ba07293541befe69af18413ff237a3~lW7Q-fGcJ3074630746euoutp01I
        for <linux-pm@vger.kernel.org>; Wed,  5 Jun 2019 16:54:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190605165435euoutp0152ba07293541befe69af18413ff237a3~lW7Q-fGcJ3074630746euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559753675;
        bh=JU/c9FNaZ7RzVeefWgeJBT2SNqHdshJDcyVQ50fa8DY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sNC5CX0Q1MHWAhb2vh9ECfWulSabhck9rt7N1WH/4japJQabb6dKoGjbWvn899/KX
         APemw1FEEb4y6zgc2l9EHuOosQRZ2Fh60+8eSSRx2PSc0I0veDeD5qWWimxzyM5aBf
         CClgxeeRjORckLy+V7YduQIVSI0TnPqsSvet6asQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190605165434eucas1p11524c373a7038d61c8eb475203d36ec1~lW7QE-F8p0320603206eucas1p1k;
        Wed,  5 Jun 2019 16:54:34 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id CD.4E.04377.AC3F7FC5; Wed,  5
        Jun 2019 17:54:34 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190605165433eucas1p1214f65106df03ae74bbdc95e3eee71f1~lW7PTjShA0136401364eucas1p1v;
        Wed,  5 Jun 2019 16:54:33 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190605165433eusmtrp23021f2eac00b6b33edfb23cb678a74e3~lW7PD4cDg2868028680eusmtrp2R;
        Wed,  5 Jun 2019 16:54:33 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-f6-5cf7f3caaf74
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 53.4D.04140.9C3F7FC5; Wed,  5
        Jun 2019 17:54:33 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190605165432eusmtip1f23e7ff2028a4c610d4aac8f3b787909~lW7OHAgDz0338903389eusmtip1N;
        Wed,  5 Jun 2019 16:54:32 +0000 (GMT)
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
Subject: [PATCH v8 07/13] dt-bindings: memory-controllers: add Exynos5422
 DMC device description
Date:   Wed,  5 Jun 2019 18:54:04 +0200
Message-Id: <20190605165410.14606-8-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605165410.14606-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSWUgUYRzvm5mdnbU2pjXyn0railBWliXxQWkJPky+dOBDpFFjTlrtbrWj
        ltnDarSp5YGCeYWFhObBpm2iEnnm2mG7UbHhJohbeEumaRcd42z09vv/zu/hY0hNp8KXOWVI
        EYwGXqelvaiWvm/2Lc/mFuO3FTjX4KZSiwI750cVuKr3pQLXz7oRLn52i8AvrutxgXuSxHb7
        fSUeyJpS4kGTP37dXknjubxehEvtjwnc2DukxK7MWhr3TF1T4I43Mdj1YyVe6B9Be725hS9F
        FFdhekVxbeVDSq65Lofm8q7M0FzXzCOCy7fWIe7B8wxurnndAdURr92Jgu5UmmDcGnncK7mk
        pYo+Z1l/0VFhRyY06peLVAyw4fC6rUaRi7wYDVuL4LNj3HPMIxifKCXkYw7BbE0T8S9S8WSI
        lIUaBNX5BUgSliKTOUG5iGFoNhRa685L9Go2A947O5b8JDtFwMD3r5QkeLMJ4Mhy0pKfYoNh
        oJCWaDW7Byz1C5S8FQD19ztJCavYvVBie0BJPcCOKOHtQ5dSygIbDflZsbLfGyZsVqWM/eF3
        W5XnzSKY8u4gGV8Gd8Etj2cX9NheKaQakt0IlvatcmMUZI/RMlwJ76ZXSWbyLyxquUnKtBqy
        zRq5YwNYbzg8O2ugpqHE081BbXU3Jdk1bDGCxouFKKD8/9JthOqQj5Aq6pMEcbtBuBAq8nox
        1ZAUeuKsvhn9/VfPf9nmW1H7z4RuxDJIu0INTYvxGgWfJqbruxEwpHa1mnfNx2vUiXz6JcF4
        9pgxVSeI3ciPobQ+6oxlw3EaNolPEc4IwjnB+E8lGJWvCUWfyfxgGp68e+Nb3NOhov5godh9
        /NPhRd/pgdBNbvMWa1tVYdeI2UY5SjcH+hO/vnZtNMdGhOzjd74fLFsY6zhd9jnse9kO19o+
        Iv1juIZPm2y4qhvjo4Sg8z4RUZWZVAgVeLAzLiyhN/zQ/tMR1rfmyyWR96wxLu5k7tHlfoRF
        S4nJfFgIaRT5Pyf7tXtTAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xu7onP3+PMXg2XdFi44z1rBbXvzxn
        tZh/5ByrxeqPjxktJp+ay2RxpjvXov/xa2aL8+c3sFucbXrDbnGrQcbi8q45bBafe48wWsw4
        v4/JYu2Ru+wWtxtXsFkcftPOarH/ipfF7d98Ft9OPGJ0EPb49nUSi8fshossHjtn3WX32LSq
        k82jt/kdm8fBd3uYPPq2rGL02Hy62uPzJrkAzig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMT
        Sz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jGnb5rMVrFesuDD7PGMD43PpLkZODgkBE4nZR+8y
        dzFycQgJLGWU2Nf3nA0iISYxad92dghbWOLPtS42iKJPjBKfzz1k6mLk4GAT0JPYsaoQpEZE
        oF6i/80lsBpmgQZmiTXbr7KCJIQFEiQOnHjCDlLPIqAqcXYC2HxeAXuJ9au/sUDMl5dYveEA
        M4jNKeAgMe34ZrC4EFDNpeu/mScw8i1gZFjFKJJaWpybnltspFecmFtcmpeul5yfu4kRGEnb
        jv3csoOx613wIUYBDkYlHl6Jjd9jhFgTy4orcw8xSnAwK4nwJt7+EiPEm5JYWZValB9fVJqT
        WnyI0RToponMUqLJ+cAozyuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE08fE
        wSnVwBjCsVgvObEov45tW5vHp1lcPcd2pKxi/eB067DR1h19VxfmyZuz+32Mqk93vX3uM8u/
        tDVe0Q0Pgt/Isp8/2huocM/eX/rC2f1aXb9jdf+Ee9TkGu6do7bkeKyEWP+Nosuci4wXJK/0
        s3pzY4rWVr4NM7rPdequXxuo+OLb3wW5rru275q+47ASS3FGoqEWc1FxIgDINxSuugIAAA==
X-CMS-MailID: 20190605165433eucas1p1214f65106df03ae74bbdc95e3eee71f1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190605165433eucas1p1214f65106df03ae74bbdc95e3eee71f1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190605165433eucas1p1214f65106df03ae74bbdc95e3eee71f1
References: <20190605165410.14606-1-l.luba@partner.samsung.com>
        <CGME20190605165433eucas1p1214f65106df03ae74bbdc95e3eee71f1@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The patch adds description for DT binding for a new Exynos5422 Dynamic
Memory Controller device.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 .../memory-controllers/exynos5422-dmc.txt     | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
new file mode 100644
index 000000000000..989ee0839fdf
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
@@ -0,0 +1,84 @@
+* Exynos5422 frequency and voltage scaling for Dynamic Memory Controller device
+
+The Samsung Exynos5422 SoC has DMC (Dynamic Memory Controller) to which the DRAM
+memory chips are connected. The driver is to monitor the controller in runtime
+and switch frequency and voltage. To monitor the usage of the controller in
+runtime, the driver uses the PPMU (Platform Performance Monitoring Unit), which
+is able to measure the current load of the memory.
+When 'userspace' governor is used for the driver, an application is able to
+switch the DMC and memory frequency.
+
+Required properties for DMC device for Exynos5422:
+- compatible: Should be "samsung,exynos5422-dmc".
+- clocks : list of clock specifiers, must contain an entry for each
+  required entry in clock-names for CLK_FOUT_SPLL, CLK_MOUT_SCLK_SPLL,
+  CLK_FF_DOUT_SPLL2, CLK_FOUT_BPLL, CLK_MOUT_BPLL, CLK_SCLK_BPLL,
+  CLK_MOUT_MX_MSPLL_CCORE, CLK_MOUT_MX_MSPLL_CCORE_PHY, CLK_MOUT_MCLK_CDREX,
+  CLK_DOUT_CLK2X_PHY0, CLK_CLKM_PHY0, CLK_CLKM_PHY1
+- clock-names : should include "fout_spll", "mout_sclk_spll", "ff_dout_spll2",
+  "fout_bpll", "mout_bpll", "sclk_bpll", "mout_mx_mspll_ccore",
+  "mout_mx_mspll_ccore_phy", "mout_mclk_cdrex", "dout_clk2x_phy0", "clkm_phy0",
+  "clkm_phy1" entries
+- devfreq-events : phandles for PPMU devices connected to this DMC.
+- vdd-supply : phandle for voltage regulator which is connected.
+- reg : registers of two CDREX controllers.
+- operating-points-v2 : phandle for OPPs described in v2 definition.
+- device-handle : phandle of the connected DRAM memory device. For more
+	information please refer to documentation file:
+	Documentation/devicetree/bindings/ddr/lpddr3.txt
+- devfreq-events : phandles of the PPMU events used by the controller.
+- samsung,syscon-clk : phandle of the clock register set used by the controller,
+	these registers are used for enabling a 'pause' feature and are not
+	exposed by clock framework but they must be used in a safe way.
+	The register offsets are in the driver code and specyfic for this SoC
+	type.
+
+Example:
+
+	ppmu_dmc0_0: ppmu@10d00000 {
+		compatible = "samsung,exynos-ppmu";
+		reg = <0x10d00000 0x2000>;
+		clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
+		clock-names = "ppmu";
+		events {
+			ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
+				event-name = "ppmu-event3-dmc0_0";
+			};
+		};
+	};
+
+	dmc: memory-controller@10c20000 {
+		compatible = "samsung,exynos5422-dmc";
+		reg = <0x10c20000 0x100>, <0x10c30000 0x100>,
+		clocks = 	<&clock CLK_FOUT_SPLL>,
+				<&clock CLK_MOUT_SCLK_SPLL>,
+				<&clock CLK_FF_DOUT_SPLL2>,
+				<&clock CLK_FOUT_BPLL>,
+				<&clock CLK_MOUT_BPLL>,
+				<&clock CLK_SCLK_BPLL>,
+				<&clock CLK_MOUT_MX_MSPLL_CCORE>,
+				<&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
+				<&clock CLK_MOUT_MCLK_CDREX>,
+				<&clock CLK_DOUT_CLK2X_PHY0>,
+				<&clock CLK_CLKM_PHY0>,
+				<&clock CLK_CLKM_PHY1>;
+		clock-names =	"fout_spll",
+				"mout_sclk_spll",
+				"ff_dout_spll2",
+				"fout_bpll",
+				"mout_bpll",
+				"sclk_bpll",
+				"mout_mx_mspll_ccore",
+				"mout_mx_mspll_ccore_phy",
+				"mout_mclk_cdrex",
+				"dout_clk2x_phy0",
+				"clkm_phy0",
+			        "clkm_phy1";
+		operating-points-v2 = <&dmc_opp_table>;
+		devfreq-events = <&ppmu_event3_dmc0_0>,	<&ppmu_event3_dmc0_1>,
+				<&ppmu_event3_dmc1_0>, <&ppmu_event3_dmc1_1>;
+		operating-points-v2 = <&dmc_opp_table>;
+		device-handle = <&samsung_K3QF2F20DB>;
+		vdd-supply = <&buck1_reg>;
+		samsung,syscon-clk = <&clock>;
+	};
-- 
2.17.1

