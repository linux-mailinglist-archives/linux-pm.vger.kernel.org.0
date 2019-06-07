Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2A4138D3C
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 16:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbfFGOgU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jun 2019 10:36:20 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50170 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729461AbfFGOfd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jun 2019 10:35:33 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190607143532euoutp0182a5c31e5dfd80a5be0bfc3173479347~l8Ubdnv9d0173401734euoutp01N
        for <linux-pm@vger.kernel.org>; Fri,  7 Jun 2019 14:35:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190607143532euoutp0182a5c31e5dfd80a5be0bfc3173479347~l8Ubdnv9d0173401734euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559918132;
        bh=R3RumMeD2vvHibveJNz69seTERGI3NNuA18iIt9sN8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uWnvyPRTRc7k6AiUVX5opYiBB57tqu/dzzw1t2MQu56SsQ0bY+AIp7QVU3JvRb9xf
         uK5W8cBFzYpIYO56GkKluC+/YMpXAnMDtwlrKlyyNrby6t1q4EuORfS5R2YCHXoPpr
         UfPD2Bp1FgMecdGNLs1Ik2oAY5NAIq+M2OW+PhOk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190607143531eucas1p170269b5cd4e2f004a699eb243b243fda~l8UaOc8BM1839218392eucas1p1Q;
        Fri,  7 Jun 2019 14:35:31 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 3B.D0.04325.2367AFC5; Fri,  7
        Jun 2019 15:35:30 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190607143530eucas1p15c794d0f1401fc3a48f1408c3435084a~l8UZd2Cn91838018380eucas1p19;
        Fri,  7 Jun 2019 14:35:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190607143530eusmtrp1dd5407926c37405e62ccc6e721aa546a~l8UZOLC5h1284512845eusmtrp1X;
        Fri,  7 Jun 2019 14:35:30 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-99-5cfa7632a2a9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 39.C0.04140.2367AFC5; Fri,  7
        Jun 2019 15:35:30 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190607143529eusmtip1ec2c60b444025b3b4c0436c20a28c687~l8UYRSm0n2929829298eusmtip14;
        Fri,  7 Jun 2019 14:35:29 +0000 (GMT)
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
Subject: [PATCH v9 07/13] dt-bindings: memory-controllers: add Exynos5422
 DMC device description
Date:   Fri,  7 Jun 2019 16:35:01 +0200
Message-Id: <20190607143507.30286-8-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190607143507.30286-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTURzv7N67e50trlPysCJhIJbQ1kPohGFGRZf6IgQJOqqZFyud2m5q
        adTUzJquVYOaU9GsUKbmMzMpn6OJj6akFvnoIWnkI3QqWhF5u6u+/f6/1/+cw6Ew2UdCTp2J
        P8/q4jVxCrEEb3i58mrrjuTv6m3z34NRjaWKQG8WJglUZH9FoPK5cYAyH1SJkbmrUIR6crTI
        ND6FIaezmkS9GdMkeqffiOZyxwj0uqlAjFxGO0AWZ7MIVdpHSdTfdRANp5eJUcd0NoF+DdXg
        qGXgMBr+sQ4tdX4Cob7M0uIdnPn2Notk8vX9OPPMOkoytbYbYqalsIJkjJmzYqZt9rmIuVlv
        A0xddxrjqt0U5hkh2RPNxp1JZnWqkJOS0x+NLiLR6XdhpOWCHljlBuBBQToIvqvMxw1AQsno
        MgAH3he5hwUAFyvfiITBBWCnuQT/GzFN1BGCUApgTsET7F+k5OXDVRdFiWklbLSd4wM+tAXA
        /C9HeQ9GP8XgzPAI4AVvOgreWxkkeT9O+8PPht08LaX3wtH2YvcyP1he3Yrx2IMOhfkNjWK+
        B9JGCo6ujGCC6QBsu1VOCtgbfnXUu/FG2G3OdRdxUG+8DwR8CY6bCt2eYNjh6Cf4M2D0FljV
        pBLoffC6bfjPVSC9Dr6d8eJpbBXeabiHCbQUXr8mE9ybYX1un0jA62FpxV13OQOvGqxAeB0z
        gLfTJ/BbwM/6f1kxADbgyyZx2hiW2xnPpig5jZZLio9RnkrQ1oLVj9f9y7HYCJp/RrUDmgKK
        tVKGXFHLCE0yd1HbDiCFKXykyX3Lapk0WnMxldUlnNAlxbFcO9hA4QpfadqaD5EyOkZzno1l
        2URW91cVUR5yPTibZjjifOx5N6q0mHhhSqk2hR9XZ9s/bOgvOzY5qLydEdDrGWLP89AEec9E
        cQcDBkfKxyyRCqP//inVo5hd+p4nrUN1eZd1rUOxzx2B2Q5p15Umr9q+YxlLpDV8ynHjUMBy
        EVNRkJeaFebSy2Ln/Od3DgYe7VNJ5B0RmfZdWdsVOHdasz0Q03Ga30FXHop0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsVy+t/xu7pGZb9iDObNZ7PYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aL5sXr2Swmn5rLZHGmO9ei//FrZovz5zewW5xtesNucatBxuJjzz1Wi8u7
        5rBZfO49wmgx4/w+Jou1R+6yW1w85Wpxu3EFm8XhN+2sFv+ubWSx2H/Fy+L2bz6LbyceMTqI
        e3z7OonF4/2NVnaP2Q0XWTx2zrrL7rFpVSebx/65a9g9epvfsXkcfLeHyaNvyypGj82nqz0+
        b5IL4I7SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQ
        y3jY+5m14Lx8xZ39FQ2Ms6S6GDk5JARMJPqfbWbtYuTiEBJYyijR9uMrC0RCTGLSvu3sELaw
        xJ9rXWwgtpDAJ0aJuS+Kuhg5ONgE9CR2rCoE6RURmMMo8bNrGyOIwyxwllli94o3TCANwgIJ
        En17brCANLAIqEo87bIECfMK2EvcPbQAape8xOoNB5hBbE4BB4nZ23awgZQLAdWseu4wgZFv
        ASPDKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMD423bs55YdjF3vgg8xCnAwKvHwzmD6GSPE
        mlhWXJl7iFGCg1lJhLfswo8YId6UxMqq1KL8+KLSnNTiQ4ymQCdNZJYSTc4Hpoa8knhDU0Nz
        C0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2MxWwL/24S4j+y2EPQfOk9y30u
        f1Kkdxm2+l28/u9BbYXrvjLe2UqbSt+EbPVfckx7/uQvWpLfglTPLsqOMpv34AvHb9GT6Z/F
        r0xzndLb9v/cRkM3c5Y9t5QPLPm4MjqTdfds133ZSv4e3E9kTj18mxq6aNIBX735G8IjFzcu
        muOjWN1/bmvzBiWW4oxEQy3mouJEACWKPrjVAgAA
X-CMS-MailID: 20190607143530eucas1p15c794d0f1401fc3a48f1408c3435084a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190607143530eucas1p15c794d0f1401fc3a48f1408c3435084a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190607143530eucas1p15c794d0f1401fc3a48f1408c3435084a
References: <20190607143507.30286-1-l.luba@partner.samsung.com>
        <CGME20190607143530eucas1p15c794d0f1401fc3a48f1408c3435084a@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The patch adds description for DT binding for a new Exynos5422 Dynamic
Memory Controller device.

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 .../memory-controllers/exynos5422-dmc.txt     | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
new file mode 100644
index 000000000000..3d9bfecf573b
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
@@ -0,0 +1,75 @@
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
+- clock-names : should include "fout_spll", "mout_sclk_spll", "ff_dout_spll2",
+  "fout_bpll", "mout_bpll", "sclk_bpll", "mout_mx_mspll_ccore",
+  "mout_mx_mspll_ccore_phy", "mout_mclk_cdrex"  entries
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
+		clocks = <&clock CLK_FOUT_SPLL>,
+			 <&clock CLK_MOUT_SCLK_SPLL>,
+			 <&clock CLK_FF_DOUT_SPLL2>,
+			 <&clock CLK_FOUT_BPLL>,
+			 <&clock CLK_MOUT_BPLL>,
+			 <&clock CLK_SCLK_BPLL>,
+			 <&clock CLK_MOUT_MX_MSPLL_CCORE>,
+			 <&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
+			 <&clock CLK_MOUT_MCLK_CDREX>,
+		clock-names = "fout_spll",
+			      "mout_sclk_spll",
+			      "ff_dout_spll2",
+			      "fout_bpll",
+			      "mout_bpll",
+			      "sclk_bpll",
+			      "mout_mx_mspll_ccore",
+			      "mout_mx_mspll_ccore_phy",
+			      "mout_mclk_cdrex",
+		operating-points-v2 = <&dmc_opp_table>;
+		devfreq-events = <&ppmu_event3_dmc0_0>,	<&ppmu_event3_dmc0_1>,
+				<&ppmu_event3_dmc1_0>, <&ppmu_event3_dmc1_1>;
+		device-handle = <&samsung_K3QF2F20DB>;
+		vdd-supply = <&buck1_reg>;
+		samsung,syscon-clk = <&clock>;
+	};
-- 
2.17.1

