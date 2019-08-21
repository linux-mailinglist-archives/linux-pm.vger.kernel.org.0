Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 995F797763
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 12:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbfHUKnu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 06:43:50 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35674 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728210AbfHUKnZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 06:43:25 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190821104323euoutp02406de1ede47a1bc96697623f2fa41684~86iJlHLIo0294502945euoutp02f
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2019 10:43:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190821104323euoutp02406de1ede47a1bc96697623f2fa41684~86iJlHLIo0294502945euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566384203;
        bh=PSpbcy1xgNd8/2kjxf5bZqTrKbNFeF3rhjwBcmGppfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RJAokdFCF6VfjJF6XgiOIqJaY8c/jdEMSEmULKrgTPAhhjLomZLsPHvB3M0SkMPKc
         K46I13liqwY6ZwZ+qMYE47zxjNGts8d9IiunxHhTwqhNtK2jTK6y8b3NhJza/Yl+vS
         GgEwRKc1pQ5FtP7MM7wmWy89RifiBlr3TLXb18WA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190821104322eucas1p22190ad75abd043164d5a333c31239aca~86iIYJ0Yk2889728897eucas1p2w;
        Wed, 21 Aug 2019 10:43:22 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 5B.A6.04374.A402D5D5; Wed, 21
        Aug 2019 11:43:22 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190821104321eucas1p284816ade1890e9660008c0428c6d56e0~86iHjN-r80909709097eucas1p2S;
        Wed, 21 Aug 2019 10:43:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190821104321eusmtrp2b1cd66dcfb09613f8e274b6aa20b45f5~86iHU7Enk2827528275eusmtrp28;
        Wed, 21 Aug 2019 10:43:21 +0000 (GMT)
X-AuditID: cbfec7f5-92d689c000001116-5f-5d5d204a012a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3B.38.04117.9402D5D5; Wed, 21
        Aug 2019 11:43:21 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190821104320eusmtip22013ef5d9a804467bdcbab1003fc5b2f~86iGNMDus1420714207eusmtip2O;
        Wed, 21 Aug 2019 10:43:20 +0000 (GMT)
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
Subject: [PATCH v13 4/8] dt-bindings: memory-controllers: add Exynos5422 DMC
 device description
Date:   Wed, 21 Aug 2019 12:42:59 +0200
Message-Id: <20190821104303.32079-5-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821104303.32079-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa1BMYRju23POnrON5bQ19SYjszNMDCEyn9G4zLicMSMN44eaRktnKnYr
        e1q5jdmYxNYWcmm6uYSS1XbZSUVh25HuLVI0GYSMSyShoWidxb/nfd7n+Z5n3vkYQvGRmszE
        xCbw2liVWil1JSvvjrTNWTstPHyeoWoSLssyU7jrSz+Fz9raKHx1sA/hQwVmKc5sypPgllQN
        zuh7R+D29lIatx58T+Mn+il4MO0phR/U5ErxkNGGcFZ7nQRfs/XS+FKXXYLtTatwT1KRFCfX
        2mhc/z6FwmOPykh86+Fa3PNjIv567wVa7s2Z8k2I+zp8guQ+difTXI7eTnLV2b00V158VMrd
        yjPRnPHQgJS7M3BTwqVbihFX0byPGyqfGjIh1DUoklfH7OK1c5dGuEZbkiLj0313V1/ppPSo
        39uAZAywC8Fq7pYakCujYIsQjLzsIMThC4Kkb62kOAwhyBwokfy1HDmZ7rQUIrAeHyP/WR5X
        jtIGxDBS1h+qinc6DB5sFoKcNxsdGoJ9TkD6tVzkWLizKjAOi3qSnQ6Db3QOWs4ug3MXsygx
        zBeult4mHFjGLoexY42U4x1g8xgwp712ilZCb0knLWJ3eNtgceIp8Kv6rLO1AHrjeSTi/dCX
        kefULIH6Bjvl6ECwM8FcM1ekV0B14cs/1YCdCN0f3Bw0MQ5PVJ4hRFoORw4rRLUfWNI6nEGe
        UGg67XRyUGCWiMfJRPCupoc8hnyz/2edQ6gYefE6QRPFCwti+UR/QaURdLFR/tviNOVo/Bs2
        jzUMV6G6n1utiGWQcoI8oissXEGpdgl7NFYEDKH0kO/ODQ1XyCNVe/by2rgtWp2aF6zIhyGV
        XvJ9Ls/CFGyUKoHfwfPxvPbvVsLIJutR6HePAO/r91MD1SPui74bE4K9Ita4yBbf8aN/PJV5
        K9Ylrs9XJCce0G+f3YJ04Ea+2mhJianI78i2ddWm9O/0ejtasOiJIdgnKIjJUQ+wPptCAm60
        azxJbBjtdlv9cIbnBrtn2eVPppitvbW50Z8bi0oDi1oDEjNWX1ix+VNE3SklKUSr5s8itILq
        N31b1tuCAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xe7qeCrGxBn/axS02zljPanH9y3NW
        i/lHzrFarP74mNGiefF6NovJp+YyWZzpzrXof/ya2eL8+Q3sFmeb3rBb3GqQsfjYc4/V4vKu
        OWwWn3uPMFrMOL+PyWLtkbvsFkuvX2SyuHjK1eJ24wo2i9a9R9gtDr9pZ7X4d20ji8X+K14W
        t3/zWXw78YjRQdJjzbw1jB7fvk5i8Xh/o5XdY3bDRRaPnbPusntsWtXJ5rF/7hp2j97md2we
        B9/tYfLo27KK0WPz6WqPz5vkAnii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62M
        TJX07WxSUnMyy1KL9O0S9DK2NKYU9MlX7Fx5lbWB8blkFyMnh4SAiUTHlD62LkYuDiGBpYwS
        f5a/YYZIiElM2redHcIWlvhzrQuq6BOjRP/CE0BFHBxsAnoSO1YVgsRFBOYwSvzs2sYI4jAL
        /GaWOHi3H6xbWCBe4tjvH6wgDSwCqhIfX5SChHkF7CUWLJnBCrFAXmL1hgNgizkFHCT+TTgJ
        FhcCqpm64S3rBEa+BYwMqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQIjdNuxn1t2MHa9Cz7E
        KMDBqMTDu+NmdKwQa2JZcWXuIUYJDmYlEd6KOVGxQrwpiZVVqUX58UWlOanFhxhNgW6ayCwl
        mpwPTB55JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoY+5XM433/
        c6jr/Tn20GNq7Dr3/7cEtA0uxvCvV52mf/hkQt0m34N76lYfX+A5+5wK+8GfpRs3K1inGTDp
        VYjkvn7atDmcYZ6jh/N/C7ZlsRs2W15vi+58WOXM+jD29zymGR5uAfP/as/sU1WdmcNz0lnx
        +u3p511ldZzMM0RdWU+fDOZ5eXqpEktxRqKhFnNRcSIAgzYIleYCAAA=
X-CMS-MailID: 20190821104321eucas1p284816ade1890e9660008c0428c6d56e0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190821104321eucas1p284816ade1890e9660008c0428c6d56e0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190821104321eucas1p284816ade1890e9660008c0428c6d56e0
References: <20190821104303.32079-1-l.luba@partner.samsung.com>
        <CGME20190821104321eucas1p284816ade1890e9660008c0428c6d56e0@eucas1p2.samsung.com>
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

