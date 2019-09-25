Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C262CBE24C
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2019 18:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502053AbfIYQSp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 12:18:45 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59781 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502049AbfIYQSo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2019 12:18:44 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190925161843euoutp017f83eadf65453d8ac58fa800620f7e48~Hur7Bvxrq0250602506euoutp01O
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2019 16:18:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190925161843euoutp017f83eadf65453d8ac58fa800620f7e48~Hur7Bvxrq0250602506euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569428323;
        bh=NF2N/S20/e2RXIugwPEq47HsjE64dwZqFwSGJRS+CyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PEEsAUE4ZuTN7BOTZP6so72yki29oRIZ5mfNhZpjmTuGtkwEtrgXalMrt2L3HFPIB
         q6303tDluoZXdmucdeSqAUQ+GrrJX5Z76YANoxT+G2GzA2RgMfctREzJvaWOXXlU7x
         kyazl08s3oY9ZQ8mOQVcKx2ziUaRxbfqVXHIBTJc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190925161843eucas1p214551349ed1914488e477c3e95721d72~Hur6fre9R1054910549eucas1p2t;
        Wed, 25 Sep 2019 16:18:43 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 08.4E.04309.2639B8D5; Wed, 25
        Sep 2019 17:18:43 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190925161842eucas1p271a9cf4f62b3d7af02c0a5d0d1eb9c4f~Hur6JMZMY1051410514eucas1p21;
        Wed, 25 Sep 2019 16:18:42 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190925161842eusmtrp218a93e11860085ac46bc8f67aa8bcbcf~Hur6IP_qa0276502765eusmtrp2P;
        Wed, 25 Sep 2019 16:18:42 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-52-5d8b9362d376
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 04.0B.04117.2639B8D5; Wed, 25
        Sep 2019 17:18:42 +0100 (BST)
Received: from AMDC3778.digital.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190925161841eusmtip1a293a21a446454d9fe561e59dad25dd4~Hur5WL0Kl0374503745eusmtip1t;
        Wed, 25 Sep 2019 16:18:41 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        robh+dt@kernel.org, willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH 1/3] ARM: dts: exynos: Add interrupt to DMC controller in
 Exynos5422
Date:   Wed, 25 Sep 2019 18:18:11 +0200
Message-Id: <20190925161813.21117-2-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190925161813.21117-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfUhTURjGO/fu7l6Xk+uUPJkkjISUUpOoE0UaJF3wHyFS/MKWXj9Qp+36
        WUGaZqVORSHNNAszZWrqEnFWYtvwq3R+lEZhziZkNhXURpJYzmv23+887/Oc5z1wKFyiJpyp
        eHkqq5DLEqVCkaCzb33kaFR5YYS3xRG1V7YSaGrtG4Fq9SMEKjH9wJHB0Eai4VtmEn3KdkFq
        0ySBJrqrhWhVqQeo0tCDoRb9NInqp8Yw9DmnUYhuv9aTSGe+QyDLwFfgZ880P2oGjKZqmmTU
        qntC5sXTm8ybpVcYU9yhAsyq+mAgGSo6E80mxqezCq+zl0VxvXWzwhQtmZmjzCOyQa2wANhQ
        kD4OHy4PbrGIktCNAE7lvRPwhzUA6yvXAX9YBbCytHg3op/7jvODBgBVFRv4bkT7s3wrT1FC
        2hN2qa5aA450HYAWXajVg9OdGDSqLIR14EAHwYnS/G0W0G6wqm1wu0FM+8ISTZ2Ab3OFTW29
        uJVtaD+4sqjBrBdBeoiEs+qZHdN5aG4f3VnPAS70d5A8u8A/mlqMZw5mK58Anm9AU0nNjuc0
        1PWPEdalcdodtnZ78fI52DfesP0WSNvBj4v2VhnfwrLOCpyXxfBuvoR3H4YdRaM7RftgQ/N9
        krcwcKg6xCpL6HIAF2pSSoFr1f+qxwCogBObxiXFspyPnM3w5GRJXJo81jMqOUkNtn7S283+
        tS7QvXFFC2gKSG3FvUGFERJCls5lJWkBpHCpo7jKpSBCIo6WZV1jFcmRirREltOCA5RA6iS+
        vscYJqFjZalsAsumsIp/U4yycc4GLeX+gTPhycuHwoOB78nm0F92l+Yn3LvGv8S4Yh6pGU0x
        KyeWo/3nNv1sRgz7R/dOnuo2eufO9/uYlfFMnu2QUMktBYpe2rkF1Two+22X6ZtsoEVHBt5f
        CMjN0AUWmZ5reoIX1Mj0IdSYUPasCbu4KHAKCBlGC2GzkSNLLWFGqYCLkx3zwBWc7C/dboty
        RQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsVy+t/xu7pJk7tjDda9VbLYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht7jVIGOx6fE1VovLu+awWXzuPcJoMeP8PiaLtUfuslss
        vX6RyeJ24wo2i9a9R9gtDr9pZ7X4duIRo4Ogx5p5axg9ds66y+6xaVUnm8fmJfUeB9/tYfLo
        27KK0ePzJrkA9ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy
        1CJ9uwS9jAOLH7IVHGKvaOxtYW1gnM/WxcjJISFgInHkyUvmLkYuDiGBpYwSizdtYIRIiElM
        2redHcIWlvhzrQusQUjgE6PE5L0cXYwcHGwCehI7VhWC9IoILGeUOLbqLdggZoEjTBJHV18D
        GyQsECLRcuUZE4jNIqAqMWvDSbBBvAL2Ev07F7NALJCXWL3hADOIzSngIPHp7U4miGX2Es/X
        nGCawMi3gJFhFaNIamlxbnpusZFecWJucWleul5yfu4mRmCkbDv2c8sOxq53wYcYBTgYlXh4
        JSK7Y4VYE8uKK3MPMUpwMCuJ8M6S6YoV4k1JrKxKLcqPLyrNSS0+xGgKdNREZinR5HxgFOeV
        xBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamA867lQe8Oy1U+/Gf/k
        f+uuJBhQtXfx5U3zFA0eTahM1Ak2Fjn0tIzxwHZjB/Zv4rcrdQJOzbiy6PsrQ+m7325mZa9Z
        uVFqx2wxF16LA4ZV/9JjQ2UuRBzOy2g+v0RaapZfS8cv1j6T9NsnHhw05PPSvBzO/GG77fpA
        rfl1T7caPtzSJvt4Axu/EktxRqKhFnNRcSIA9f/jeaoCAAA=
X-CMS-MailID: 20190925161842eucas1p271a9cf4f62b3d7af02c0a5d0d1eb9c4f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190925161842eucas1p271a9cf4f62b3d7af02c0a5d0d1eb9c4f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190925161842eucas1p271a9cf4f62b3d7af02c0a5d0d1eb9c4f
References: <20190925161813.21117-1-l.luba@partner.samsung.com>
        <CGME20190925161842eucas1p271a9cf4f62b3d7af02c0a5d0d1eb9c4f@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add interrupt to Dynamic Memory Controller in Exynos5422 and Odroid
XU3-family boards. It will be used instead of devfreq polling mode
governor. The interrupt is connected to performance counters private
for DMC, which might track utilisation of the memory channels.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index ac49373baae7..72738e620d11 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -240,6 +240,8 @@
 		dmc: memory-controller@10c20000 {
 			compatible = "samsung,exynos5422-dmc";
 			reg = <0x10c20000 0x100>, <0x10c30000 0x100>;
+			interrupt-parent = <&combiner>;
+			interrupts = <16 0>;
 			clocks = <&clock CLK_FOUT_SPLL>,
 				 <&clock CLK_MOUT_SCLK_SPLL>,
 				 <&clock CLK_FF_DOUT_SPLL2>,
-- 
2.17.1

