Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0D8A6FCB3
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2019 11:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbfGVJsE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 05:48:04 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52325 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729233AbfGVJrc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2019 05:47:32 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190722094730euoutp01e10a4ad0fa05ba0278448805cf12ad7b~zsayLo6FN1399813998euoutp01N
        for <linux-pm@vger.kernel.org>; Mon, 22 Jul 2019 09:47:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190722094730euoutp01e10a4ad0fa05ba0278448805cf12ad7b~zsayLo6FN1399813998euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563788850;
        bh=PSpbcy1xgNd8/2kjxf5bZqTrKbNFeF3rhjwBcmGppfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AhFqqzamTZS148WN6mEoto2gSYrlePY3EdenV016mcIr/LvU24UwuizR+PoU5iP/i
         kZla9Acb9AepPUa7BRdUfKIJSMw/bETyN8RPPnEtS/46DqRPexBt9Vv6S0L7xJDiq1
         Vet7Ca1OseHs6XJCEacTn5lOjMzlcenXrjGQubq8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190722094729eucas1p2aa661535c01e40ec7ad3fdcb9fb228de~zsaxHl39i2318723187eucas1p2U;
        Mon, 22 Jul 2019 09:47:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 66.85.04298.036853D5; Mon, 22
        Jul 2019 10:47:28 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190722094728eucas1p17e68d3d93202fb089822b376e5d2f37b~zsawN4FR73210332103eucas1p1C;
        Mon, 22 Jul 2019 09:47:28 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190722094727eusmtrp28c51ed6788f8e8b9160e96c199ba4ed0~zsav-oREN2448224482eusmtrp2o;
        Mon, 22 Jul 2019 09:47:27 +0000 (GMT)
X-AuditID: cbfec7f2-3615e9c0000010ca-ac-5d3586303e3d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 31.E1.04146.F26853D5; Mon, 22
        Jul 2019 10:47:27 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190722094726eusmtip2f7a9c0bd501d9415860143b139145f5b~zsau-UysB1005410054eusmtip2K;
        Mon, 22 Jul 2019 09:47:26 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, gregkh@linuxfoundation.org,
        willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v12 4/9] dt-bindings: memory-controllers: add Exynos5422 DMC
 device description
Date:   Mon, 22 Jul 2019 11:46:41 +0200
Message-Id: <20190722094646.13342-5-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190722094646.13342-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSW0wTQRR1urvdhVBdCpERCSWNJkoilCjJqAQxotn4YYj6IRrEKpuC0IJd
        UR5+FHkpyiMYsfJGELXSALUhoigIKAoCFh8QBSI2EQVBkUdEQpVla/w759xzzp2ZDIVJJwh3
        KkpzmtVqlDFysSPe8Gy+Z5Miwz9MYSvYjOr1tQTqnxklUFl7D4HuTlkBSq2sFaMrnSUi9PKS
        GuVaxzHU21tHou7z30j0XueBpi4PE+j1g2Ixms5uB0jf+1iEjO1DJLrZbxEhS+du9CHlthil
        P2onUdu3TALZ3tXjqPnNXvRhYSWae/4JBK1hakprADM3m48z3wfSSaZIZ8GZxsIhkjEZLoqZ
        5pIakslOnRQzTyabREyO2QCYe13JzLTJM8TpsGNABBsTdYbV+gYec4w0p0TE5cgSGu+8JXRg
        dE0WcKAgvQUaq4dEWcCRktK3AcxLN4gFMgPgR1OfnUwD2G2tXCLUciS7LFnQbwE4WlWN81XL
        ib6CAN4jpn3gfcMpXnal9QAWfTnA+zF6BIM5xmLAD1xoJezW/1rGOL0elpaMYzyW0DugqXiG
        FI4ng3frWjC+04EOgl871HwPpCsoWFR4Axc8wbCq7SEQsAsc6zDbsx7wT2OZSMAc1GVX2D3n
        oDW3xO7ZDts6LATfj9EbYe0DX0HeCUfG5knhuivhwIQzL2NLML/hGibIEnghQyq4N0Dz5Vf2
        RavhrZoCezkDF3OH7I9zBcCM/vA8ICv8v6scAANwY+M5tYrl/DTsWR9OqebiNSqfE7FqE1j6
        hF22jp/3wWzf8VZAU0DuJFE0bAmTEsozXKK6FUAKk7tKNAr/MKkkQpmYxGpjw7XxMSzXCtZS
        uNxNkrzi4xEprVKeZqNZNo7V/puKKAd3Hdg47n2k6cWqIL+tI19Vg8Fm2/GqkOsm2Z60tMWH
        u87ZnlqTJn87nd033cSsS4hYSBv0aikbO3mHKtcbZlvn4w8N7zemWx9bX8xVhMuYYosrRfg3
        dhk9nRWnKkObr/Ynfm4Om++O3uuyOrn6teaZ/P0Pr9BHk8OZodGBo9tUR3UHB+U4F6n088a0
        nPIvGKrD7IADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsVy+t/xe7r6baaxBjtWGFpsnLGe1eL6l+es
        FvOPnGO1WP3xMaNF8+L1bBaTT81lsjjTnWvR//g1s8X58xvYLc42vWG3uNUgY/Gx5x6rxeVd
        c9gsPvceYbSYcX4fk8XaI3fZLZZev8hkcfGUq8XtxhVsFq17j7BbHH7Tzmrx79pGFov9V7ws
        bv/ms/h24hGjg6THmnlrGD2+fZ3E4vH+Riu7x+yGiyweO2fdZffYtKqTzWP/3DXsHr3N79g8
        Dr7bw+TRt2UVo8fm09UenzfJBfBE6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZ
        mSrp29mkpOZklqUW6dsl6GVsaUwp6JOv2LnyKmsD43PJLkYODgkBE4ne+dVdjJwcQgJLGSXu
        3BUGsSUExCQm7dvODmELS/y51sXWxcgFVPOJUeLGrvPMIL1sAnoSO1YVgsRFBOYwSvzs2sYI
        4jAL/GaWOHi3H6xbWCBe4u+eSUwgNouAqsS8ua+ZQWxeAXuJTXO+QG2Ql1i94QDYUE4BB4mX
        x3MhDrKX2P9iO+MERr4FjAyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAqNz27Gfm3cwXtoY
        fIhRgINRiYfXYJtJrBBrYllxZe4hRgkOZiUR3jwD01gh3pTEyqrUovz4otKc1OJDjKZAN01k
        lhJNzgcmjrySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1MHJxSDYxNDebf
        +MsvvJk2Qatl3n81h7YLCUvOL+Dw12e8+jns9mtROWHHNpenvwueJEVu7EqO8TnzxcXoxkSB
        OwyLqm5v+bdiTbnOtcTMDxPmCH497L3kFHueSmDJ4fY1SZJfZoSdYFC4JpM/L1Js3vT26S4u
        8fWhHamT960QqMnePeFazcNN95c8fyuqxFKckWioxVxUnAgA9a4NtOQCAAA=
X-CMS-MailID: 20190722094728eucas1p17e68d3d93202fb089822b376e5d2f37b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190722094728eucas1p17e68d3d93202fb089822b376e5d2f37b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190722094728eucas1p17e68d3d93202fb089822b376e5d2f37b
References: <20190722094646.13342-1-l.luba@partner.samsung.com>
        <CGME20190722094728eucas1p17e68d3d93202fb089822b376e5d2f37b@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The patch adds description for DT binding for a new Exynos5422 Dynamic
Memory Controller device.

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 .../memory-controllers/exynos5422-dmc.txt     | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
new file mode 100644
index 000000000000..02aeb3b5a820
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
@@ -0,0 +1,73 @@
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
+  "mout_mclk_cdrex"  entries
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
+			 <&clock CLK_MOUT_MCLK_CDREX>,
+		clock-names = "fout_spll",
+			      "mout_sclk_spll",
+			      "ff_dout_spll2",
+			      "fout_bpll",
+			      "mout_bpll",
+			      "sclk_bpll",
+			      "mout_mx_mspll_ccore",
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

