Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2711459A5
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 11:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfFNJyf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 05:54:35 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35842 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbfFNJxY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2019 05:53:24 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190614095322euoutp013f15daed7c63672e875138daa76d6f4f~oB-ECs1Yi0866608666euoutp01Q
        for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2019 09:53:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190614095322euoutp013f15daed7c63672e875138daa76d6f4f~oB-ECs1Yi0866608666euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560506002;
        bh=VRDKye2EsO1AxFVr5sLghiB3/pqyTiHrDNIPj88z9vw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n1mKsNsNynOOtWGTaPmIyBoAOQ74X3JEXe+PtjWYrtSi0YXeKQNUprhd69KlGEibt
         VAzL5/wl8cP7CKfytnvvBNLs0iDQcNgdFavi220qYb23xh+lhGBQd+qzv42zLDs5NG
         w6GseG9U3gvJmjrLMyzmMhaBNXmXuKlQ52fcV4HQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190614095321eucas1p25ce0807b519ac9d672f35b6c86befaf3~oB-DLT-qp0491404914eucas1p2x;
        Fri, 14 Jun 2019 09:53:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 10.F1.04325.19E630D5; Fri, 14
        Jun 2019 10:53:21 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190614095320eucas1p2919a6169c997bb81c80416e8a0ede538~oB-CYnlER0493104931eucas1p21;
        Fri, 14 Jun 2019 09:53:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190614095320eusmtrp285e6e8b91811b632afb9bd6ebeaf5c9f~oB-CX5U-a2148521485eusmtrp2x;
        Fri, 14 Jun 2019 09:53:20 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-0a-5d036e916fc7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 79.30.04146.09E630D5; Fri, 14
        Jun 2019 10:53:20 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190614095319eusmtip2bc51f0a36a033d54d5b0ff46ba566799~oB-Bff0YW2266622666eusmtip2u;
        Fri, 14 Jun 2019 09:53:19 +0000 (GMT)
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
Subject: [PATCH v10 01/13] clk: samsung: add needed IDs for DMC clocks in
 Exynos5420
Date:   Fri, 14 Jun 2019 11:52:57 +0200
Message-Id: <20190614095309.24100-2-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614095309.24100-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSWUwTURSGvZ2ZdgCrYyVyRJSkxoAkgAvGq7hh1Iw8GBONMSKRChNcaIUO
        KILGqhEtUNEapFJZ1AewQMoWLEjYFwOyVI0bYgyoRQUMoSBGUqS26tt//vOd+5+cXJqQDFCe
        9HFFPKdUyGKkQleyqu1nj/9NBRG+ylLojst0Rgq/sloonNfSTeGisUGELz8wCvGtjhwBfpom
        xxmD3wjc01Mqwl2XhkX4rcoLj6W/p/DzmrtCPK5pQVjXUyfAJS39Imzu2In7LhYKcfPwVQrb
        XpaRuP5FKO77NQ9PPhlA2zzYyQktyX5/fUXE6lVmkq3O7hex5Qa1kK3PKRaxmsujQrZxtFbA
        Xq80ILaiM5kdL1+21+2Q66YoLub4aU4ZuCXC9Zi+tA3F1s5PrLDokAqpxanIhQYmCDLNWkEq
        cqUlTCGCmSGrs7AiqPqmFzqKcQSN6ir0d+Tq0BDpaBQg+NyYT/0bmXjWNUvRtJAJAJMhzj7g
        zugQ6If22RmCeUTASN+7P8xC5gDobW52hmRWgPrVDGXXYmYrVBRMO8O8oai0gbBrF2YbtOYN
        /9kIGA0NJqPNCe2AhuJMwqEXwtf2SpFDe8FMdZ7AoXlQae45+XMwmJHjZIKhud1M2fchmJVg
        rAl02CFQ25RL2m1g5sHrkQV2m5iV2qoswmGL4VqKxEH7QmV6rzNoERQU33Y+zoLNmOs81S0E
        A2/GiBvIO/t/WD5CBuTBJfDyaI5fq+DOBPAyOZ+giA6IPCUvR7M/r9PWPmFCddNHmxBDI+lc
        ccNGQbiEkp3mz8qbENCE1F2cG0yES8RRsrNJnPLUEWVCDMc3oSU0KfUQJ8/5ECZhomXx3EmO
        i+WUf7sC2sVThWI/UcHPitI2r+632rRJiR/X3PhxMTgla8S0PLSOnZl037U+5UJ7d83NsGVT
        OSFra7NrFltN5sO9cWXbr/hHxELoUot6w2PD+qiPFecjbbt/7g/6cvDE8H2fvheJPiXZumL9
        Hm1Y63SE77uoqc7ehxZFvqZNqfdrXZeUaZv61TF1p1dK8sdkq/0IJS/7DSB1wyJ1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xe7oT8phjDXpu61tsnLGe1eL6l+es
        FvOPnGO1WP3xMaNF8+L1bBaTT81lsjjTnWvR//g1s8X58xvYLc42vWG3uNUgY/Gx5x6rxeVd
        c9gsPvceYbSYcX4fk8XaI3fZLS6ecrW43biCzeLwm3ZWi3/XNrJY7L/iZXH7N5/FtxOPGB3E
        Pb59ncTi8f5GK7vH7IaLLB47Z91l99i0qpPNY//cNewevc3v2DwOvtvD5NG3ZRWjx+bT1R6f
        N8kFcEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXo
        ZczecIyxYA9/xebnMxgbGDt5uxg5OSQETCTaX7xg6WLk4hASWMoosWjiFiaIhJjEpH3b2SFs
        YYk/17rYIIo+MUqsaLkB1MHBwSagJ7FjVSFIXERgDqPEz65tjCAOs8BZZondK96ATRIWCJE4
        NukAmM0ioCrRef0/K4jNK2AvsXn5H0aIDfISqzccYAaxOQUcJI7Of8MGskAIqOb7DP4JjHwL
        GBlWMYqklhbnpucWG+oVJ+YWl+al6yXn525iBEbhtmM/N+9gvLQx+BCjAAejEg/vASumWCHW
        xLLiytxDjBIczEoivPOsmWOFeFMSK6tSi/Lji0pzUosPMZoC3TSRWUo0OR+YIPJK4g1NDc0t
        LA3Njc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQxcXBKNTDmzL43pTGnY35e/NGj818tOHfC
        TzJpWcUCsxvmfby91+5+jblo/M4jTqrl8E1XaeFqrlDWdyLKjd3PLlpdjP8n4ZjWnjvlfRrr
        Ktvs6dNaa3O7s7T/z9/b/rYwcs2TaXuiYwwyYxf19iaEzXOImRMdJCF246nUpeVLHwXnNayR
        ePh032dF/T9KLMUZiYZazEXFiQDXjeGl2AIAAA==
X-CMS-MailID: 20190614095320eucas1p2919a6169c997bb81c80416e8a0ede538
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190614095320eucas1p2919a6169c997bb81c80416e8a0ede538
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190614095320eucas1p2919a6169c997bb81c80416e8a0ede538
References: <20190614095309.24100-1-l.luba@partner.samsung.com>
        <CGME20190614095320eucas1p2919a6169c997bb81c80416e8a0ede538@eucas1p2.samsung.com>
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

