Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC6FB37CA
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2019 12:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732226AbfIPKH3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Sep 2019 06:07:29 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40150 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732196AbfIPKHV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Sep 2019 06:07:21 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190916100720euoutp01a438f20ab873a4ceade61b6aab3a507d~E40Fk9VlH2526325263euoutp01U
        for <linux-pm@vger.kernel.org>; Mon, 16 Sep 2019 10:07:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190916100720euoutp01a438f20ab873a4ceade61b6aab3a507d~E40Fk9VlH2526325263euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568628440;
        bh=Uy8PbI8Ay//0lPtuuye0Cr4E/yS+/gJgE62W7KlqB88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OU5UqgGjGY6HuGv5V+CorBe0NhspzeUHj22GF68n4ohALSAkrlZkq41jakFiHbAeY
         U5VOwE4zf9MZrLktuDUxOBQhqrgaTNmFqWfkj6tX357GShUd+6aXUd5NijgtEbdafE
         O5c2iMvCXC2rdCsr4h4baLBPr2NREPEYci/3JJZw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190916100719eucas1p1e84d4fa680983ee4ec5878e476e7022c~E40Ey87c90424904249eucas1p1x;
        Mon, 16 Sep 2019 10:07:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 7F.DE.04469.7DE5F7D5; Mon, 16
        Sep 2019 11:07:19 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190916100718eucas1p1efcbabdf9dbe17a062ae83b8c19ac256~E40D-SBI20720607206eucas1p1N;
        Mon, 16 Sep 2019 10:07:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190916100718eusmtrp2b28c2b52b5b47de5f999ceecc557c737~E40DxPHpI2883028830eusmtrp25;
        Mon, 16 Sep 2019 10:07:18 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-ea-5d7f5ed77158
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DD.48.04117.6DE5F7D5; Mon, 16
        Sep 2019 11:07:18 +0100 (BST)
Received: from AMDC3778.digital.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190916100717eusmtip283feedbd6c1b28f23253ea84770886ce~E40DCHngk2339323393eusmtip2X;
        Mon, 16 Sep 2019 10:07:17 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v2 2/3] ARM: dts: exynos: fix too long line in memory device
Date:   Mon, 16 Sep 2019 12:07:03 +0200
Message-Id: <20190916100704.26692-3-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190916100704.26692-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRj229nZjqPFcUa+LFFZBSXkDYMPEjPox6B+SESRYTn1pJJbtqOW
        GbkC85Z5qdRE00pTlqJOGVM0vDVNTZ1SimWoIzIvWZtXsIvzrPr3vM/7PN/z8PJRhKSJlFIx
        qnhGrVLEygQivt64MXho7EJKqI9BS+CGojoSjy1/IXFZ9yCJc8zzBB4aqhfit3cWhHhC44p1
        5vckHm0pEWBrdjfCRUOveLi2e1KIK8dMPPzhdrUAp7Z1C3HXQhqJV3tnUJCTvOZJDZI3F08K
        5TpthkDeWJEi7/jWypPfb9IiuVXnFiwMEQVEMrExiYzaOzBMFG1oHyXivgiut318ytOgUTIT
        OVJA+8NiRpogE4koCV2N4Guf0T4sI3j8eZnHDVYEd6atxF/LsqWC5BZVCGZbf/D/WfSbj7b8
        FCWgvcCgvWoz7KKfI1jtCrFhgtbzIHvF1Yad6ZOwMLu03YNP74es3Axkw2L6KNSurAq4MHd4
        Wd++HexIB8F69WvClgW0UQjajVR7o+OQN7SEOOwMcz1NQg67wu/mMh6HWdBkP7VrboI5p9Su
        OQJdPSbS1pmgD0JdizdHH4Ppkk2+jQZ6J4wvOnH1d0K+vpDgaDGk35Vw6gPQdG/YHrQbqmoK
        7I/LYaK3wH7QBwgmlr7zc5F78f+wcoS0yIVJYJVRDOurYq55sQolm6CK8oq4otShrb/U/6vH
        YkArI+GdiKaQbIdYk3orVEIqEtkkZScCipDtEp9NTw6ViCMVSTcY9ZWL6oRYhu1Eeyi+zEWc
        7DB1XkJHKeKZywwTx6j/bnmUo1SD9nlID6+twehMXs6sXwM1GRMwIPV8E9geOlXqkm0YKUr0
        MOqDTk/8nK/s6BUXTlnKgoNGsupU/rFh3ubFF3PPyhs/G/1k0gGHyRO+p/JpT2tawplIXVFf
        /yXTulOvck5SGP7OrM03jfQNN1j81kTjPolu3nvPPVwLif4UYcpRyPhstMLXk1Czij/BbdFd
        RwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsVy+t/xe7rX4upjDbbu47fYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht7jVIGOx6fE1VovLu+awWXzuPcJoMeP8PiaLtUfuslss
        vX6RyeJ24wo2i9a9R9gtDr9pZ7X4duIRo4Ogx5p5axg9ds66y+6xaVUnm8fmJfUeB9/tYfLo
        27KK0ePzJrkA9ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy
        1CJ9uwS9jB0HLjMXPGer2HtnIVMD42XWLkZODgkBE4kvn5YA2VwcQgJLGSUabu1mh0iISUza
        tx3KFpb4c62LDaLoE6PE4ZVngTo4ONgE9CR2rCoEiYsILGeUOLbqLTOIwyxwhEmif9c8sBXC
        Aj4Sb168B7NZBFQluid0MoLYvAL2Emu/fmOD2CAvsXrDAWYQm1PAQeLHiqNgthBQzZTrPxgn
        MPItYGRYxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERgr24793LKDsetd8CFGAQ5GJR7ehta6
        WCHWxLLiytxDjBIczEoivOEd1bFCvCmJlVWpRfnxRaU5qcWHGE2BjprILCWanA+M47ySeENT
        Q3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1MHJxSDYwH9L5YTJk44/mTVPsTzLZb
        FTSdWCZvOProktQGvWmuNw/1i2uyOM24MuEKb1+oe53qdhHVGr7Fa0qeqAv5rLA87jOBO2f3
        qve2PYaSK6X8erg9laauWbRhzp5ZSs/ubYmW7DsT92aJ5Bwvp09X5h79djbx1kNP0Z0asaXv
        WA57vro+5dDOD/KzlFiKMxINtZiLihMBMglGiasCAAA=
X-CMS-MailID: 20190916100718eucas1p1efcbabdf9dbe17a062ae83b8c19ac256
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190916100718eucas1p1efcbabdf9dbe17a062ae83b8c19ac256
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190916100718eucas1p1efcbabdf9dbe17a062ae83b8c19ac256
References: <20190916100704.26692-1-l.luba@partner.samsung.com>
        <CGME20190916100718eucas1p1efcbabdf9dbe17a062ae83b8c19ac256@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Small fix moving the comment to line above making sure the lines do not
exceed 80 characters.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index fe885ca969af..059fa32d1a8f 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -103,7 +103,8 @@
 
 		timings_samsung_K3QF2F20DB_800mhz: lpddr3-timings@800000000 {
 			compatible	= "jedec,lpddr3-timings";
-			reg		= <800000000>; /* workaround: it shows max-freq */
+			/* workaround: 'reg' shows max-freq */
+			reg		= <800000000>;
 			min-freq	= <100000000>;
 			tRFC		= <65000>;
 			tRRD		= <6000>;
-- 
2.17.1

