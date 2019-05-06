Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 301A914FAE
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2019 17:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfEFPMS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 May 2019 11:12:18 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50020 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfEFPMS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 May 2019 11:12:18 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190506151217euoutp02ac0747c3be488de5f22d9781333b2d4c~cILX3ueTi3103031030euoutp02B
        for <linux-pm@vger.kernel.org>; Mon,  6 May 2019 15:12:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190506151217euoutp02ac0747c3be488de5f22d9781333b2d4c~cILX3ueTi3103031030euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557155537;
        bh=Pg2sZDM0gGaQynWA3bIO7FltjqeWt1FWMCeBz72wzmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=idyCNmyPUlWHlr22XMKQrmhn22/S6V5+VbnArl2JyItbEXoWZ6Mk0J/IE0GFhS8rf
         RD+cFNHX1bw5T5Hy7d5rejgAzXRM9q2+Kcr78wia3ywPzbxE0mbI7yS7sF64srFqrY
         Y4oKsaR2LBM+LvmWauV8Asf8AlkwaDGJjfY9ij8E=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190506151216eucas1p239690b2c4bbb24a6120e9f2bcb160747~cILXWp3uO1324113241eucas1p26;
        Mon,  6 May 2019 15:12:16 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B7.A3.04377.0DE40DC5; Mon,  6
        May 2019 16:12:16 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190506151215eucas1p2c57147edac5671c5ec9a223efb6b4adc~cILWpjByy1450814508eucas1p2G;
        Mon,  6 May 2019 15:12:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190506151215eusmtrp272853cd92cc504a85cc9b168f312fb9f~cILWberVQ0409004090eusmtrp2Y;
        Mon,  6 May 2019 15:12:15 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-84-5cd04ed046cc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6F.5D.04146.FCE40DC5; Mon,  6
        May 2019 16:12:15 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190506151214eusmtip1920ff8fbabf174ac7fd54f33b341b80c~cILVsNmii3142531425eusmtip1M;
        Mon,  6 May 2019 15:12:14 +0000 (GMT)
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
Subject: [PATCH v7 07/13] dt-bindings: memory-controllers: add Exynos5422
 DMC device description
Date:   Mon,  6 May 2019 17:11:55 +0200
Message-Id: <1557155521-30949-8-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsWy7djP87oX/C7EGCy9w2OxccZ6VovrX56z
        Wsw/co7VYvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7jVIGNxedccNovPvUcYLWac
        38dksfbIXXaL240r2CwOv2lntdh/xcvi9m8+i28nHjE6CHt8+zqJxWN2w0UWj52z7rJ7bFrV
        yebR2/yOzePguz1MHn1bVjF6bD5d7fF5k1wAZxSXTUpqTmZZapG+XQJXxvQlz9gKNstUfOv3
        aWA8IN7FyMkhIWAi8WLXZfYuRi4OIYEVjBKL3pxmhHC+MEq87zrAAuF8ZpT4vfgUK0xL05ZL
        UFXLgVrmHmSDa5m+pZO5i5GDg01AT2LHqkKQBhGBaok71/czg9QwC7xhkjj76wcLSEJYIEli
        2onDYDaLgKpE1+3/TCA2r4CXxLwtd5kgtslJ3DwHMpOTg1PAW+JvxyFGiPg9donHXa4QtovE
        yrknmCFsYYlXx7ewQ9gyEv93zoeaUyzR0LsQqrdG4nH/XKgaa4nDxy+ygtzMLKApsX6XPogp
        IeAosf5cCITJJ3HjrSBIMTOQOWnbdGaIMK9ER5sQxAwNiS09F6D2iEksXzMNaraHxPyHH1gh
        gTOPUWLV9gnMExjlZyHsWsDIuIpRPLW0ODc9tdgoL7Vcrzgxt7g0L10vOT93EyMwaZ3+d/zL
        DsZdf5IOMQpwMCrx8E5wuhAjxJpYVlyZe4hRgoNZSYQ38dm5GCHelMTKqtSi/Pii0pzU4kOM
        0hwsSuK81QwPooUE0hNLUrNTUwtSi2CyTBycUg2MBVdeHb7Qpn5qh7CVcmLrOiXB973nZ1Z9
        ChXrE363np+dw/vH9TV/5DM912zcw/bvh8nJ0358K1fcfsXc9e/qxN07Nzmc+7pSS71lR1vu
        1GSZ/XYC7hOtI3eFbP2qUXlyQdveI1Mik7Znhl03yDX6ZLlO/9TM/C38Srv/nes3e7jydaf+
        zI85P5VYijMSDbWYi4oTAaaEn29WAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xu7rn/S7EGDw7K2exccZ6VovrX56z
        Wsw/co7VYvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7jVIGNxedccNovPvUcYLWac
        38dksfbIXXaL240r2CwOv2lntdh/xcvi9m8+i28nHjE6CHt8+zqJxWN2w0UWj52z7rJ7bFrV
        yebR2/yOzePguz1MHn1bVjF6bD5d7fF5k1wAZ5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
        pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexvQlz9gKNstUfOv3aWA8IN7FyMkhIWAi0bTlEmMX
        IxeHkMBSRomnbZMZIRJiEpP2bWeHsIUl/lzrYoMo+sQo0bb1ElCCg4NNQE9ix6pCkBoRgXqJ
        /jeXwGqYBRqYJdZsv8oKkhAWSJC4c3EGmM0ioCrRdfs/E4jNK+AlMW/LXSaIBXISN891MoPY
        nALeEn87DoEdIQRUs+/jb5YJjHwLGBlWMYqklhbnpucWG+oVJ+YWl+al6yXn525iBEbStmM/
        N+9gvLQx+BCjAAejEg/vA9sLMUKsiWXFlbmHGCU4mJVEeBOfnYsR4k1JrKxKLcqPLyrNSS0+
        xGgKdNREZinR5HxglOeVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCU
        amAs3vX2RUIAf22yPcd0zaYFgj+Vl2WsXfDGfVv3ZsX3WkVTXjBkvfbM2CDEm71ct3DztVvL
        vX5I8CeecytSZ9ZcU5Dzb+KTPWZBp9ib5P9pqMss8da2OPJ0R0DtD/Pu9sO5uh+XcsS8V1i5
        fNpvv5QIsbpQ94dGeyMvLKxpSH3j2jZF3cMob40SS3FGoqEWc1FxIgD79POiugIAAA==
X-CMS-MailID: 20190506151215eucas1p2c57147edac5671c5ec9a223efb6b4adc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190506151215eucas1p2c57147edac5671c5ec9a223efb6b4adc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190506151215eucas1p2c57147edac5671c5ec9a223efb6b4adc
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190506151215eucas1p2c57147edac5671c5ec9a223efb6b4adc@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The patch adds description for DT binding for a new Exynos5422 Dynamic
Memory Controller device.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 .../bindings/memory-controllers/exynos5422-dmc.txt | 74 ++++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
new file mode 100644
index 0000000..be602a9
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
@@ -0,0 +1,74 @@
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
+- clock-names : the name of clock used by the controller.
+- clocks : phandles for clock specified in "clock-names" property.
+- devfreq-events : phandles for PPMU devices connected to this DMC.
+- vdd-supply : phandle for voltage regulator which is connected.
+- reg : registers of two CDREX controllers.
+- operating-points-v2 : phandle for OPPs described in v2 definition.
+- device-handle : phandle of the connected DRAM memory device. For more
+	information please refer to Documentation
+- devfreq-events : phandles of the PPMU events used by the controller.
+- samsung,syscon-chipid : phandle of the ChipID used by the controller.
+- samsung,syscon-clk : phandle of the clock register set used by the controller.
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
+		samsung,syscon-chipid = <&chipid>;
+	};
-- 
2.7.4

