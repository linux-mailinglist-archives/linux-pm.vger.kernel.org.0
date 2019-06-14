Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFB945961
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 11:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfFNJxa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 05:53:30 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35862 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbfFNJxa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2019 05:53:30 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190614095328euoutp01eb3ea3fd5e28c13f7a2b2adfc466b571~oB-Jp3qpI0866608666euoutp01a
        for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2019 09:53:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190614095328euoutp01eb3ea3fd5e28c13f7a2b2adfc466b571~oB-Jp3qpI0866608666euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560506008;
        bh=2JvLbY7btvKfjDQu5LODtAv/gzWHpnWzkZVQbhFYX3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H4Fa/+AsA0q1n9w4lUlxHU+u0oBdoAfcwmCsMWoK61rL8gQrE28N9SJZtNsxViZJr
         rAhmf7X1lGgAdQ8QOtMK9rsvt0QYnIEQ23uU0j7+flZrwba6JjTwvNSS9FkCdAl6l8
         cp8+fKJD3xnqaaiwFEQfJs1PikHlftsv/W8C13Ic=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190614095327eucas1p2c267fb76e5578549ab8298fcf0447a10~oB-IzrLCx0482804828eucas1p2t;
        Fri, 14 Jun 2019 09:53:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B5.F1.04325.79E630D5; Fri, 14
        Jun 2019 10:53:27 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190614095326eucas1p22e27d86d886d7a33acdd59c7f0f6d7d8~oB-IBEB7c0479404794eucas1p2x;
        Fri, 14 Jun 2019 09:53:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190614095326eusmtrp27e0ff904cd1be6d16be626e1eac68523~oB-HxakmZ2148521485eusmtrp2_;
        Fri, 14 Jun 2019 09:53:26 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-1b-5d036e976a81
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B3.EA.04140.69E630D5; Fri, 14
        Jun 2019 10:53:26 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190614095325eusmtip20c8fd47061cc53e9bde7051e6aeb8bc0~oB-G3qi0y2266622666eusmtip2z;
        Fri, 14 Jun 2019 09:53:25 +0000 (GMT)
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
Subject: [PATCH v10 07/13] dt-bindings: memory-controllers: add Exynos5422
 DMC device description
Date:   Fri, 14 Jun 2019 11:53:03 +0200
Message-Id: <20190614095309.24100-8-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614095309.24100-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSayyVYRzveW/npQ6vw/IkS52pZEuaLg+nRZvWu+aD1taHynTiHZZz6Lzo
        otVB7k6UDR33+eA+HJcwcztKURxqJaKLlVZopaQJOd5Tffv9f5f/5dlD45K3pB0doozgVEp5
        qJQyJ5oe/BrYna3E/Vzn725CdTk1JHrxfYpEhT0DJKr8OglQXEkNhTL78jH0OFWB0ic/42hw
        sFaEnsROi9Co2h59TZsg0dPWPArNaXoAyhlsx1B1z7gIDfUdRWMxZRTSTyeSaPl5HYE6nh1H
        Y4sWaP7hO+Bly87/uEOwX0biRWyueohgW7TjIlZXkUyxHflVIlYTN0uxXbNtGHuroQKw9f3R
        7Jxui+/60+aHArnQkChOtefwOfPg9+XxRPiiw+XUnwmkGnTZpQCahsw+WKT1SAHmtIQpA3Cq
        fIQSiu8AZqQ1YUIxB+DL2HEiBZitJUZH0ghBKAXQMFWG/YsULH8Axr4U4wKbKy4aAzZMDoC5
        H08aPThzD4czY6+AUbBmAmBe+xBpxASzHU7ezV3jxYwnfBJz2zTNAVbWduJGbMZ4wfuF02v7
        QUZDw9iMfko4whumzNkLfmv4qbdBJGB7uNJSiAmYh2pNMRDwNTiZnm/yyKC+17gDvbrcLljT
        ukegj0B1nd7U3QKOzFgZaXwV3mnKxgVaDJMSJILbCTakGUyDNsLSqixTcxYmN9WaXicTwIYP
        S1QGcND+H1YEQAWw5SJ5RRDHuym5Sy68XMFHKoNcAsIUOrD68fqXe380g/bf57sBQwPpBnGn
        B+YnIeVR/BVFN4A0LrURF8hwP4k4UH7lKqcK81dFhnJ8N9hME1JbcfS6N2ckTJA8grvAceGc
        6q+K0WZ2anAq2yBznLEY190o+fZoIfOa7KxO7EEVl7kHk9WyEzcN5ZYR7hhQ8Ve3fT4Q7Omm
        JKZiuRLr4h0JR2/oXZfGspxaZoOKHZ31w20xiZoJm95j9X2+W60uvLaUZPmkeg/s3F/amLRw
        PZX29nNQ1DprvH0CDlpHb1qp0w77FxiuLzRKCT5YvtcZV/HyP4Mxd2x0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xe7rT8phjDf5+ULTYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aL5sXr2Swmn5rLZHGmO9ei//FrZovz5zewW5xtesNucatBxuJjzz1Wi8u7
        5rBZfO49wmgx4/w+Jou1R+6yW1w85Wpxu3EFm8XhN+2sFv+ubWSx2H/Fy+L2bz6LbyceMTqI
        e3z7OonF4/2NVnaP2Q0XWTx2zrrL7rFpVSebx/65a9g9epvfsXkcfLeHyaNvyypGj82nqz0+
        b5IL4I7SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQ
        y3i6spWl4Ld8Rff3NtYGxoNSXYycHBICJhK3bvSwdDFycQgJLGWUeLPlBjNEQkxi0r7t7BC2
        sMSfa11sEEWfGCWe3rnB2MXIwcEmoCexY1UhSFxEYA6jxM+ubYwgDrPAWWaJ3SveMIF0Cwsk
        ShzZ9oANxGYRUJV4PHM2I4jNK2AvcbZxIgvEBnmJ1RsOgG3mFHCQODr/DRvIAiGgmu8z+Ccw
        8i1gZFjFKJJaWpybnltspFecmFtcmpeul5yfu4kRGIXbjv3csoOx613wIUYBDkYlHt4DVkyx
        QqyJZcWVuYcYJTiYlUR451kzxwrxpiRWVqUW5ccXleakFh9iNAW6aSKzlGhyPjBB5JXEG5oa
        mltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi4JRqYDymd+9u8nmnlIWZFW5lUk3G
        UvO/W1zVKej6lHTlitt9tmtVN+ccnzfrcc/XLTG1HVcK9/fvW5v8afXqZoEzrT7hUw9zBAl9
        nGMj2LJnkZu6vs0+DX9LdweTY53CP7K9vb7NZ0txXnO+4PCS0tS+5/m6yau/h/w6vc+AuYdB
        qckocYZsbMFcHyWW4oxEQy3mouJEAFTe3TLYAgAA
X-CMS-MailID: 20190614095326eucas1p22e27d86d886d7a33acdd59c7f0f6d7d8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190614095326eucas1p22e27d86d886d7a33acdd59c7f0f6d7d8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190614095326eucas1p22e27d86d886d7a33acdd59c7f0f6d7d8
References: <20190614095309.24100-1-l.luba@partner.samsung.com>
        <CGME20190614095326eucas1p22e27d86d886d7a33acdd59c7f0f6d7d8@eucas1p2.samsung.com>
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

