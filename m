Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0597038D5A
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 16:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbfFGOf2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jun 2019 10:35:28 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50134 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729193AbfFGOf2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jun 2019 10:35:28 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190607143527euoutp0172af80de571efd5919f6ec9f93b538bc~l8UWOxWju0114101141euoutp01t
        for <linux-pm@vger.kernel.org>; Fri,  7 Jun 2019 14:35:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190607143527euoutp0172af80de571efd5919f6ec9f93b538bc~l8UWOxWju0114101141euoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559918127;
        bh=VRDKye2EsO1AxFVr5sLghiB3/pqyTiHrDNIPj88z9vw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iBOXjycCYRWD6Con90v0kCTXCr9EPAeaITIuNDv7HMcpZToVqG0vJuAvfqlANFVPz
         VxO53iV1ElHJ6DONN543mwe0wzxoaDUYlneGKfeZtuYcmSY7q3SA9SteoBRZCbmgOi
         BtCo/oMIRnqxwyVR2HDkeLUGtK0TJKCUxXsuOTF0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190607143525eucas1p2408cbf845366ae26cf4713312d614e69~l8UVG3k0V2161821618eucas1p2P;
        Fri,  7 Jun 2019 14:35:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 6D.89.04377.D267AFC5; Fri,  7
        Jun 2019 15:35:25 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190607143524eucas1p22e6310f1a5f6e4bab771ebbbcc40f88c~l8UUKE1hj2700727007eucas1p2N;
        Fri,  7 Jun 2019 14:35:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190607143524eusmtrp179429087b4d7ee937310acc01f73a833~l8UT6PaEJ1284512845eusmtrp1R;
        Fri,  7 Jun 2019 14:35:24 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-b1-5cfa762d4492
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 34.C0.04140.C267AFC5; Fri,  7
        Jun 2019 15:35:24 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190607143523eusmtip12cb8a1fa24dec44a025b466df2ca3c6d~l8US93pol2927929279eusmtip1w;
        Fri,  7 Jun 2019 14:35:23 +0000 (GMT)
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
Subject: [PATCH v9 01/13] clk: samsung: add needed IDs for DMC clocks in
 Exynos5420
Date:   Fri,  7 Jun 2019 16:34:55 +0200
Message-Id: <20190607143507.30286-2-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190607143507.30286-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSeUiTYRzu3Xfs22r6tY69mCZMogzUiogXuuyCj6CIjj9Ss1Z+qOUs9+m6
        aWVpy5PWIU7RrNTUmhemw6ttac1yeaW2kuGgwytCi9SSnJ/Vf8/vOX7Py8uPwqT9hAcVGR3L
        qqIVUXJSjFc1jdv8/NQTIasMNi9UlmEgUPfYJwLlWFoJVPzNCVD8fQOJdNZsAXqVpERpzkEM
        2WylQvT6ypAQvdN4om/JfQTqMGaRaDTFAlCGrV6AHls+CFGbdQeyXy4kkXkokUBTb8tw1NC5
        E9kn3dCPF/0gUMb8+H4TZ772XBMyek0bztRkfhAy5UVakmnILhEyKfEjJPNspFbApFYWAaai
        5TwzWr50z9wg8YYwNipSzaoCNh0RR+hLm8CpWvczFZ8ygAZoJTeAiIL0Wqizp+M3gJiS0oUA
        pmudgB/GABzI7iL4YRTAr53F2N9I1+3HQl4oALA1v478F2kf/jKtUBRJ+8PqohhXYCGdAaD+
        8z6XB6OfYnDY/h64hAX0AXirspF0+XF6GZywCly0hN4MnaZBgi/zhsWljTPFIjoQ6quqZ7og
        raVgifEqyZu2w4mc3tnAAjjQXCnksSds0SXjPOagJuUe4PEF6EzLnvWsh+bmNsL1Boz2hQZj
        AE9vgY11zhka0m6wZ3i+i8am4c2quxhPS+D1BCnvXgErk98IeLwYFpTcmV3OwIQuh4D/HR2A
        SZpUkA68M/+X5QJQBGRsHKcMZ7k10expf06h5OKiw/2PnVSWg+nLa5lqHqsGxl9HTYCmgHye
        JHDOeIiUUKi5s0oTgBQmXyhRv/kZIpWEKc6eY1UnD6violjOBJZQuFwmOT/HESylwxWx7AmW
        PcWq/qoCSuShAaKP5ku92s5Huy6C7YW6vv72zjtlvsa8B8Gluw/GmTLTLMt8vLZObjxmfhlB
        PrFv6/NmB0IjgjY7nB0xTTV69VAu9rR7b8fI0KHj1ocBofLBWvfEfDfxqOm57N39/QbHeG1+
        6PLgPKU560yfPTbWZ2er2+/lpwcNhLVnHR7SUL9IjnMRitUrMRWn+APeltQNdQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsVy+t/xu7o6Zb9iDNb/kbDYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aL5sXr2Swmn5rLZHGmO9ei//FrZovz5zewW5xtesNucatBxuJjzz1Wi8u7
        5rBZfO49wmgx4/w+Jou1R+6yW1w85Wpxu3EFm8XhN+2sFv+ubWSx2H/Fy+L2bz6LbyceMTqI
        e3z7OonF4/2NVnaP2Q0XWTx2zrrL7rFpVSebx/65a9g9epvfsXkcfLeHyaNvyypGj82nqz0+
        b5IL4I7SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQ
        y5i94RhjwR7+is3PZzA2MHbydjFyckgImEhcnbqWvYuRi0NIYCmjREPnE2aIhJjEpH3b2SFs
        YYk/17rYIIo+MUosPb0SKMHBwSagJ7FjVSFIXERgDqPEz65tjCAOs8BZZondK94wgXQLCwRL
        tD7/ygrSwCKgKvHrFFiYV8Be4vGh16wQC+QlVm84ALaYU8BBYva2HWwg5UJANaueO0xg5FvA
        yLCKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMAa3Hfu5ZQdj17vgQ4wCHIxKPLwzmH7GCLEm
        lhVX5h5ilOBgVhLhLbvwI0aINyWxsiq1KD++qDQntfgQoynQSROZpUST84HpIa8k3tDU0NzC
        0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA6PuuWXFi3+rfWxP++AQnJseuet2
        t8/F3Hy973tDt8rwHwt0lXJSP3h7ycor05MtdhhG636fl2jqUV/16aHbqefagf2XvaWV5aX8
        dqoVsRuIf+zQ8UqfsO6Q2MPamrXadw56c6XLHt2pszSSwSzn/6FLSbvfqPGW/A7TOdHkL+z6
        z0zl77OZQkosxRmJhlrMRcWJAG40kqjXAgAA
X-CMS-MailID: 20190607143524eucas1p22e6310f1a5f6e4bab771ebbbcc40f88c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190607143524eucas1p22e6310f1a5f6e4bab771ebbbcc40f88c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190607143524eucas1p22e6310f1a5f6e4bab771ebbbcc40f88c
References: <20190607143507.30286-1-l.luba@partner.samsung.com>
        <CGME20190607143524eucas1p22e6310f1a5f6e4bab771ebbbcc40f88c@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Define new IDs for clocks used by Dynamic Memory Controller in
Exynos5422 SoC.

Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 include/dt-bindings/clock/exynos5420.h | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
index 355f469943f1..02d5ac469a3d 100644
--- a/include/dt-bindings/clock/exynos5420.h
+++ b/include/dt-bindings/clock/exynos5420.h
@@ -60,6 +60,7 @@
 #define CLK_MAU_EPLL		159
 #define CLK_SCLK_HSIC_12M	160
 #define CLK_SCLK_MPHY_IXTAL24	161
+#define CLK_SCLK_BPLL		162
 
 /* gate clocks */
 #define CLK_UART0		257
@@ -195,6 +196,16 @@
 #define CLK_ACLK432_CAM		518
 #define CLK_ACLK_FL1550_CAM	519
 #define CLK_ACLK550_CAM		520
+#define CLK_CLKM_PHY0		521
+#define CLK_CLKM_PHY1		522
+#define CLK_ACLK_PPMU_DREX0_0	523
+#define CLK_ACLK_PPMU_DREX0_1	524
+#define CLK_ACLK_PPMU_DREX1_0	525
+#define CLK_ACLK_PPMU_DREX1_1	526
+#define CLK_PCLK_PPMU_DREX0_0	527
+#define CLK_PCLK_PPMU_DREX0_1	528
+#define CLK_PCLK_PPMU_DREX1_0	529
+#define CLK_PCLK_PPMU_DREX1_1	530
 
 /* mux clocks */
 #define CLK_MOUT_HDMI		640
@@ -217,6 +228,8 @@
 #define CLK_MOUT_EPLL		657
 #define CLK_MOUT_MAU_EPLL	658
 #define CLK_MOUT_USER_MAU_EPLL	659
+#define CLK_MOUT_SCLK_SPLL	660
+#define CLK_MOUT_MX_MSPLL_CCORE_PHY	661
 
 /* divider clocks */
 #define CLK_DOUT_PIXEL		768
@@ -248,8 +261,11 @@
 #define CLK_DOUT_CCLK_DREX0	794
 #define CLK_DOUT_CLK2X_PHY0	795
 #define CLK_DOUT_PCLK_CORE_MEM	796
+#define CLK_FF_DOUT_SPLL2	797
+#define CLK_DOUT_PCLK_DREX0	798
+#define CLK_DOUT_PCLK_DREX1	799
 
 /* must be greater than maximal clock id */
-#define CLK_NR_CLKS		797
+#define CLK_NR_CLKS		800
 
 #endif /* _DT_BINDINGS_CLOCK_EXYNOS_5420_H */
-- 
2.17.1

