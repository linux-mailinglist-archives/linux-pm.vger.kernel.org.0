Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C438FAEAA0
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2019 14:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404484AbfIJMgr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Sep 2019 08:36:47 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:37724 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404340AbfIJMgr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Sep 2019 08:36:47 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190910123645euoutp0189ce80b6f03fd0351014ce9dcbe6b514~DE_15e_3f1257812578euoutp01T
        for <linux-pm@vger.kernel.org>; Tue, 10 Sep 2019 12:36:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190910123645euoutp0189ce80b6f03fd0351014ce9dcbe6b514~DE_15e_3f1257812578euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568119005;
        bh=/st2sHUtSHpK29wSDV5RRbNy6rWv74hdtmw8g6Da7HY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SFTsH2KB/e73VjS9TBKb1cJrR0X6FKFWOotwcgW9xAHULI9vOXhmLNt2x43SBZ0VM
         DD9yXoQ8330S9laOEUzNfMDWJ+5LBAiG/8pHZs69B5G77Ql0stOSreJ06IZE+XQZdv
         kCZ5RKNdTilI9CoWjodiUfJNSOozq/Tv92iMmsaI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190910123645eucas1p123f3ed458be9672ccef08aeaa85fd3b5~DE_1MUPqD2641926419eucas1p1a;
        Tue, 10 Sep 2019 12:36:45 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E4.F6.04309.CD8977D5; Tue, 10
        Sep 2019 13:36:44 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190910123644eucas1p234a55b19e68046900539195f55ea60dd~DE_0iNP381360413604eucas1p2x;
        Tue, 10 Sep 2019 12:36:44 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190910123644eusmtrp1c5904d9fcbf495cda7b5bf0564b2b32d~DE_0TmcF52381323813eusmtrp1W;
        Tue, 10 Sep 2019 12:36:44 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-d9-5d7798dcfccc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E1.FC.04117.CD8977D5; Tue, 10
        Sep 2019 13:36:44 +0100 (BST)
Received: from AMDC3061.DIGITAL.local (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190910123643eusmtip178f4201fdedfe656c43931711d9edf6c~DE_zw0J6e0745507455eusmtip1Q;
        Tue, 10 Sep 2019 12:36:43 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org, vireshk@kernel.org
Cc:     robh+dt@kernel.org, kgene@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v4 5/6] ARM: dts: Add "syscon" compatible string to chipid
 node
Date:   Tue, 10 Sep 2019 14:36:17 +0200
Message-Id: <20190910123618.27985-6-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190910123618.27985-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsWy7djPc7p3ZpTHGjzZZm6xccZ6Vov5R86x
        WvQ/fs1scf78BnaLTY+vsVpc3jWHzeJz7xFGixnn9zFZrD1yl92ide8RdovDb9pZLTY/OMbm
        wOOxaVUnm8fmJfUefVtWMXp83iQXwBLFZZOSmpNZllqkb5fAlbFow0WWgk3sFb/ezGBuYGxl
        62Lk5JAQMJE4ueY/UxcjF4eQwApGiYYNOxkhnC+MEifvfGODcD4DZe7/Y4Rp2XGwEaplOaPE
        sZYDrCAJsJYlm71AbDYBQ4neo31gDSIC6hKvTv1nBmlgFljHJLFs1jKwhLBAoMTZy9PAbBYB
        VYm52xeyg9i8AtYS/Ye/MEFsk5dYveEAM4jNKWAjcWr3LrDNEgLd7BJ7vhyCOslF4t71c+wQ
        trDEq+NboGwZidOTe1ggGpoZJXp232aHcCYwStw/vgCq21ri8PGLQD9wAN2nKbF+lz5E2FFi
        +8pHjCBhCQE+iRtvBUHCzEDmpG3TmSHCvBIdbUIQ1SoSv1dNh7pZSqL7yX8WCNtD4vWvhyyQ
        0OpnlLh25T/LBEb5WQjLFjAyrmIUTy0tzk1PLTbKSy3XK07MLS7NS9dLzs/dxAhMJ6f/Hf+y
        g3HXn6RDjAIcjEo8vA/aymOFWBPLiitzDzFKcDArifBe7yuNFeJNSaysSi3Kjy8qzUktPsQo
        zcGiJM5bzfAgWkggPbEkNTs1tSC1CCbLxMEp1cCYrcNT4O31JCiOjU3rMhfri7tl6srKPyVT
        +JkjL7au/qp9ftXebWtW5dys0V8v1hATbvHK+c4aLvMmz5hfyU2rrG7mB7Tebvd9Gc3zN1Oh
        cGJJ002vTYuuZ+5/1DBnj+FBxVa2jLSr0zf1lzor6ZziLt3DciNca/onyYTdF8quShdstb3J
        oK7EUpyRaKjFXFScCAB5+ykIIwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsVy+t/xu7p3ZpTHGiz8wW2xccZ6Vov5R86x
        WvQ/fs1scf78BnaLTY+vsVpc3jWHzeJz7xFGixnn9zFZrD1yl92ide8RdovDb9pZLTY/OMbm
        wOOxaVUnm8fmJfUefVtWMXp83iQXwBKlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwe
        a2VkqqRvZ5OSmpNZllqkb5egl7Fow0WWgk3sFb/ezGBuYGxl62Lk5JAQMJHYcbCRCcQWEljK
        KNHTVdDFyAEUl5KY36IEUSIs8edaF1A5F1DJJ0aJT51HWEESbAKGEr1H+xhB6kUENCX2rgOr
        YRbYwSSx99lfsPnCAv4Sjc1tYPUsAqoSc7cvZAexeQWsJfoPf2GCWCAvsXrDAWYQm1PARuLU
        7l1Q91hLvP44hXUCI98CRoZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgWG97djPLTsYu94F
        H2IU4GBU4uHtaCmPFWJNLCuuzD3EKMHBrCTCe72vNFaINyWxsiq1KD++qDQntfgQoynQUROZ
        pUST84Exl1cSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgVF5pfNf
        06k7XnKq/byZp8HgL/zpqRj/rOMWgn6u0vNKGl65ntymlNK+JT/zSMt9s+L3h35dlwlLt7++
        oSK5/qTVSaYVi+eXXTtSVWA24Vh9Xpg388qqTocl0e+cNzhEGv0+mDXXOWc5a42G6VQetxk+
        /+ye73opVLfjlKforDnGj2d3GNR6xSmxFGckGmoxFxUnAgCVc75rgQIAAA==
X-CMS-MailID: 20190910123644eucas1p234a55b19e68046900539195f55ea60dd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190910123644eucas1p234a55b19e68046900539195f55ea60dd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190910123644eucas1p234a55b19e68046900539195f55ea60dd
References: <20190910123618.27985-1-s.nawrocki@samsung.com>
        <CGME20190910123644eucas1p234a55b19e68046900539195f55ea60dd@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The CHIP ID block in addition to exact chip revision information
contains data and control registers for ASV (Adaptive Supply Voltage)
and ABB (Adaptive Body Bias). Add "syscon" compatible so the CHIPID
block can be shared by respective drivers.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes since v2:
 - none

Changes since v1 (RFC):
 - new patch
---
 arch/arm/boot/dts/exynos5.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index 67f9b4504a42..4801ca759feb 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -35,8 +35,8 @@
 		#size-cells = <1>;
 		ranges;

-		chipid@10000000 {
-			compatible = "samsung,exynos4210-chipid";
+		chipid: chipid@10000000 {
+			compatible = "samsung,exynos4210-chipid", "syscon";
 			reg = <0x10000000 0x100>;
 		};

--
2.17.1

