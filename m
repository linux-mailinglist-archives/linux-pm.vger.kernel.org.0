Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3737214F84
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2019 17:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfEFPMO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 May 2019 11:12:14 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35500 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfEFPMN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 May 2019 11:12:13 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190506151212euoutp014a56197662a5b2b8e7f595e95c00c51c~cILT39DtN1953319533euoutp01S
        for <linux-pm@vger.kernel.org>; Mon,  6 May 2019 15:12:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190506151212euoutp014a56197662a5b2b8e7f595e95c00c51c~cILT39DtN1953319533euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557155532;
        bh=KkaYOtvu5JcmJXf2nPBmeM4X1TyONkn16gAkHP08Pp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dOnIgJmBhnV5O41MbZZcvsKT2TGLZwUP80ZcRevRzIczxPj8bX+pMglssoQemDyHQ
         HgcolZXTldDqb2joAzMFmEh9Of/N1CK7MVhrU3AuN5zliN1w+OpTKhrMaFQ2aITbVQ
         cYwAME3II5Q9jyseFqcUHOSxjq0cAskYrm+BIfpQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190506151212eucas1p2ac6711b0a3058343ed49d7b981d5e9f5~cILTQSiTO0846408464eucas1p2V;
        Mon,  6 May 2019 15:12:12 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 52.02.04298.BCE40DC5; Mon,  6
        May 2019 16:12:11 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190506151210eucas1p13c2a4b86a6f987ff34fbe1e2d705fbbf~cILSMDYes1902819028eucas1p1g;
        Mon,  6 May 2019 15:12:10 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190506151210eusmtrp2e84221e2fad6cd561c6039465b3fddf1~cILR9zjk10409004090eusmtrp2E;
        Mon,  6 May 2019 15:12:10 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-2f-5cd04ecb79fb
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F1.4B.04140.ACE40DC5; Mon,  6
        May 2019 16:12:10 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190506151209eusmtip1d6bfebc400cbc43643bd6f4d06a63451~cILRMbU0n3138931389eusmtip1y;
        Mon,  6 May 2019 15:12:09 +0000 (GMT)
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
Subject: [PATCH v7 01/13] clk: samsung: add needed IDs for DMC clocks in
 Exynos5420
Date:   Mon,  6 May 2019 17:11:49 +0200
Message-Id: <1557155521-30949-2-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSWUwTURSGubO002pxKCg3iEuaEBSlCDF4o8RIxGQCiTEmviAGqkwApYAd
        QKE+FAwIKrsLi0jhAbAIyBq2SCxlCWBBJVFZDNgILojI5kIQKVP07Tvn/P/5T24uhUs7SQcq
        LCKaVUUowmUCMdHY9cvo2ndyMOBAw5AHqsmtJtHrhSkSFRmMJKr4bgIop7cQQ/23lCjD9AVH
        AwNPhOh54rQQDWsc0auWBwI0n2YAKHfgKYYqDWNCNJJQLkAd0zdI1D7ki0aWrdFSz3twzJZZ
        WswmmALNC4Jpzh8TMrW6VAGTdn1GwDybacOY9HodYOr61Mx87c5TIn+xVzAbHhbLqtyOBolD
        q271CqJabK5mFqULNeCT9U0goiB9ECbqi8mbQExJ6XIA5/pNlmIBwMmCWsAX8wBWzNzFNyxZ
        2aUYPygDcDFPi/2ztCQkrfkpSkDLYZPustlgR6vh6Ot23KzB6WkMPv/9kzAPbOkzsHhuHDMz
        QTvBiQ7DOktoX5he029J2wnfGlPXWUT7wZUU/fpJkH4nhI9WsgTmMEj7wK5WT15vCz931wt5
        doSrzUUYzxzUpBUDnq9BU0ahRXMEdnS/WL8Zp/fC6hY3vu0NDaYGwG+3hm++2pjb+BpmN97H
        +bYEpiRLefUeWH970BK0DZY9vmdZzsCKzB6Cf52HAN6umsUzwa78/2FaAHTAno3hlCEs5x7B
        XpFzCiUXExEivxCprAVrn6vvT/dcE1h8eV4PaArINks++gwGSElFLBen1ANI4TI7iWLSGCCV
        BCvi4llVZKAqJpzl9GA7RcjsJWqr8bNSOkQRzV5i2ShWtTHFKJGDBoRoqxz2VfhvcUgebGzb
        kSuaEZ8r1y0R8aMP1JMlF4e95YEucunE1uWxGvdvdS7aWeeYO6k+ZHFQ8lTnIR/n016r5ZGT
        pFclUeqnyWlrjQzIqtpfaJUf9KN/2OiqOe6U7jFUgHo9vdNWyIKoD4djk3Lm8zrdL2ef2K3e
        tGpV0lokI7hQhbsLruIUfwHfezYOWAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsVy+t/xu7qn/C7EGCyYqGmxccZ6VovrX56z
        Wsw/co7VYvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7jVIGNxedccNovPvUcYLWac
        38dksfbIXXaL240r2CwOv2lntdh/xcvi9m8+i28nHjE6CHt8+zqJxWN2w0UWj52z7rJ7bFrV
        yebR2/yOzePguz1MHn1bVjF6bD5d7fF5k1wAZ5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
        pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexrruU2wFuwQrJszvY29gfMnXxcjJISFgIjFx0jKm
        LkYuDiGBpYwSFxses0EkxCQm7dvODmELS/y51sUGUfSJUaJnbitQBwcHm4CexI5VhSA1IgL1
        Ev1vLoHVMAs0MEus2X6VFSQhLBAssff2TDCbRUBV4uHhI0wgNq+Al0TfxjPMEAvkJG6e6wSz
        OQW8Jf52HGIEsYWAavZ9/M0ygZFvASPDKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMBY2nbs
        55YdjF3vgg8xCnAwKvHwPrC9ECPEmlhWXJl7iFGCg1lJhDfx2bkYId6UxMqq1KL8+KLSnNTi
        Q4ymQEdNZJYSTc4HxnleSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5O
        qQbGLVv3bKr6w+vb+kK46Yvcxkj/Uq77lfn/+A//DbohMbmp4cruqgN7Hm36o+KssVtGQMxH
        S7fG/VXnr6O5iqp/Lc6rSzXdquyq23/jnPcO69z2S4/PnfMLEpoT/Nnv4wydpfKaGTN0n5za
        uMe2TiJ+R/eVV7uPx9TLbJOcO8l9U8w2qytXTCdlKLEUZyQaajEXFScCAKFO+jC7AgAA
X-CMS-MailID: 20190506151210eucas1p13c2a4b86a6f987ff34fbe1e2d705fbbf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190506151210eucas1p13c2a4b86a6f987ff34fbe1e2d705fbbf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190506151210eucas1p13c2a4b86a6f987ff34fbe1e2d705fbbf
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190506151210eucas1p13c2a4b86a6f987ff34fbe1e2d705fbbf@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Define new IDs for clocks used by Dynamic Memory Controller in
Exynos5422 SoC.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 include/dt-bindings/clock/exynos5420.h | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
index 355f469..bf50d8a 100644
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
@@ -243,13 +256,16 @@
 #define CLK_DOUT_ACLK300_GSCL	789
 #define CLK_DOUT_ACLK400_DISP1	790
 #define CLK_DOUT_PCLK_CDREX	791
-#define CLK_DOUT_SCLK_CDREX	792
-#define CLK_DOUT_ACLK_CDREX1	793
-#define CLK_DOUT_CCLK_DREX0	794
-#define CLK_DOUT_CLK2X_PHY0	795
-#define CLK_DOUT_PCLK_CORE_MEM	796
+#define CLK_DOUT_PCLK_DREX0	792
+#define CLK_DOUT_PCLK_DREX1	793
+#define CLK_DOUT_SCLK_CDREX	794
+#define CLK_DOUT_ACLK_CDREX1	795
+#define CLK_DOUT_CCLK_DREX0	796
+#define CLK_DOUT_CLK2X_PHY0	797
+#define CLK_DOUT_PCLK_CORE_MEM	798
+#define CLK_FF_DOUT_SPLL2	799
 
 /* must be greater than maximal clock id */
-#define CLK_NR_CLKS		797
+#define CLK_NR_CLKS		800
 
 #endif /* _DT_BINDINGS_CLOCK_EXYNOS_5420_H */
-- 
2.7.4

