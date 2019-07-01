Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40AC35BC90
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2019 15:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbfGANMf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jul 2019 09:12:35 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57944 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728632AbfGANL4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jul 2019 09:11:56 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190701131155euoutp015a590c3b177f9235a1ee5384824baf7f~tSqQ9PslF2458924589euoutp01e
        for <linux-pm@vger.kernel.org>; Mon,  1 Jul 2019 13:11:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190701131155euoutp015a590c3b177f9235a1ee5384824baf7f~tSqQ9PslF2458924589euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561986715;
        bh=PSpbcy1xgNd8/2kjxf5bZqTrKbNFeF3rhjwBcmGppfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jqjOqKl56R69AwKwjHKddD119ZJfkgbu6NFph4wTyg8S3AlVoOYxfimakSS5vgmG8
         cdyB0JWMiepoc5QbuNNkKtaUUt148fgVSQiEuK+Ag9jtOl4ES9dyzmem17V63pLeZ/
         VQam3F+GzCvIQXmeyoNU+MeYLbO3SiBfr5a+38ec=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190701131154eucas1p1d856e4aa3d99362836813b855d51223f~tSqQK43GQ1002510025eucas1p1J;
        Mon,  1 Jul 2019 13:11:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id E1.87.04325.9960A1D5; Mon,  1
        Jul 2019 14:11:53 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190701131153eucas1p100567483c17b63e4707c21c63f780437~tSqPYZlIQ0134601346eucas1p11;
        Mon,  1 Jul 2019 13:11:53 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190701131153eusmtrp2dd94184e2a7ee1c1b19ae8039a35f791~tSqPKEcRL0788807888eusmtrp2-;
        Mon,  1 Jul 2019 13:11:53 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-d9-5d1a0699685e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 24.02.04146.8960A1D5; Mon,  1
        Jul 2019 14:11:52 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190701131152eusmtip12b4905b4626ca5c68cb41734513ac3b7~tSqONp5Ch2677926779eusmtip10;
        Mon,  1 Jul 2019 13:11:52 +0000 (GMT)
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
Subject: [PATCH v11 4/9] dt-bindings: memory-controllers: add Exynos5422 DMC
 device description
Date:   Mon,  1 Jul 2019 15:11:33 +0200
Message-Id: <20190701131138.22666-5-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190701131138.22666-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSaUwTURSFfZ2lA1IdC5EnopBGEpWwRX88g1EUMeNuYoJGJTLCBIi0aIe6
        JxaIyC4B1II0gGLEFlLAqiCEpUVZqiIqLiDEiAkuBUUEY8SFcar+O+/e79xzc/MoTD5IeFBx
        qkROrWLjFaQzfvPut26/QtIjItCYhlCNzkSgZ1+GCVTS9oBAxrEhgFIum0iU36WXoHuZSnR2
        6AOGururpeh+sl2K+rSeaCxrkECPbxeTaDy7DSBdd5MEVbUNSFFPVxjqT6ogkdV+hkA/n9bg
        qPnJRtT/fRaa7HgNQtyZyYk8nPn4/LSUuajtwZn6ogEpU2tIJ5lmfaWUyU4ZJZnW0UYJk2M2
        AOa67QQzXrtw+8zdziujufi4w5w6YFWkc6w5KfpgjtfR+mu9hBYMz8sAFAXp5bChjskATpSc
        rgCwZVKVAZyn9RcAK1MaCPExDmBSfodUoARDr6kWFxtXATSNNpL/LMnDLzBhLEn7wzrDIcHg
        RusAvPh2h8Bg9C0MjvS/BALjSrNwyLpXkDjtA78aTwq4jF4NizsNjiwvaKxuwQTtRIfARxMD
        f6IgnU3BfPsIEKF10PI0lxS1K3zfbnaYPeGv+hKJqHmozS5z8Cfh0Fm9gwmG1vYeQtgBo5dA
        0+0AsbwG5nVacPFAs+DzkTlCGZuWeTcvYGJZBtNS5SK9GJqzHjqC5sKrlecdwxlYYLMD8Tj5
        AKb2ppO5wKvof1gpAAbgzml4ZQzHL1NxR/x5VslrVDH+UQnKWjD962w/2yfqQNPUfgugKaBw
        kWlfwgg5wR7mjyktAFKYwk3WXDEvQi6LZo8d59QJ+9SaeI63gPkUrnCXnZjxao+cjmETuQMc
        d5BT/+1KKCcPLQj3cOFLw6+UKx82jCFb5JFQPq0v6p1LyXvdjZ15vuUXYkL0pTxahBK2jfho
        2LJG+dY7p3LX+wXbQk8fqnq1IPBc2Ir9rde4tVN8s2ITferzmy0uPzRmb/9dn4ILOyKswd+C
        CjIvbejZPJvwHlMYY6s1R61PPPU+urjXKXa97+AWBc7HskFLMTXP/gZzYVR3cQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsVy+t/xu7oz2KRiDaZctLHYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aL5sXr2Swmn5rLZHGmO9ei//FrZovz5zewW5xtesNucatBxuJjzz1Wi8u7
        5rBZfO49wmgx4/w+Jou1R+6yW1w85Wpxu3EFm8XhN+2sFv+ubWSx2H/Fy+L2bz6LbyceMTqI
        e3z7OonF4/2NVnaP2Q0XWTx2zrrL7rFpVSebx/65a9g9epvfsXkcfLeHyaNvyypGj82nqz0+
        b5IL4I7SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQ
        y9jSmFLQJ1+xc+VV1gbG55JdjJwcEgImElfXb2LpYuTiEBJYyihx6d1RdoiEmMSkfduhbGGJ
        P9e62CCKPjFKfFl0i7WLkYODTUBPYseqQpC4iMAcRomfXdsYQRxmgbPMErtXvGEC6RYWiJfo
        /r6PBaSBRUBV4vvqGpAwr4C9xJyTq6AWyEus3nCAGcTmFHCQuPT1LhuILQRUs27xDcYJjHwL
        GBlWMYqklhbnpucWG+oVJ+YWl+al6yXn525iBMbgtmM/N+9gvLQx+BCjAAejEg+vxi2JWCHW
        xLLiytxDjBIczEoivPtXSMYK8aYkVlalFuXHF5XmpBYfYjQFumkis5Rocj4wPeSVxBuaGppb
        WBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamCMe3xB8OwK1brgY5fv+L0TVF82
        bapDj7+Kyfo8lyZLhoO7FnO+i8kuK3J92SzBX/Pw4tuXgZLX0suu/ozz5OW0q5znJHnf7O37
        kEfSjEGdC8UFeIP3nk69toLN51vNlqJPFpyKl7X1DBz3fHzF1vJocu7yTW+2BQv66Xnf+Lcu
        5PxMq9fC9o5KLMUZiYZazEXFiQDR1YUA1wIAAA==
X-CMS-MailID: 20190701131153eucas1p100567483c17b63e4707c21c63f780437
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190701131153eucas1p100567483c17b63e4707c21c63f780437
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190701131153eucas1p100567483c17b63e4707c21c63f780437
References: <20190701131138.22666-1-l.luba@partner.samsung.com>
        <CGME20190701131153eucas1p100567483c17b63e4707c21c63f780437@eucas1p1.samsung.com>
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

