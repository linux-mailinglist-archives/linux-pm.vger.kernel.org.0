Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28B7BAEAA3
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2019 14:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404426AbfIJMgv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Sep 2019 08:36:51 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47049 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404619AbfIJMgt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Sep 2019 08:36:49 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190910123648euoutp02aae266984feb91d82a7211bb13a22e78~DE_4f39Yt2647326473euoutp02p
        for <linux-pm@vger.kernel.org>; Tue, 10 Sep 2019 12:36:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190910123648euoutp02aae266984feb91d82a7211bb13a22e78~DE_4f39Yt2647326473euoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568119008;
        bh=RSuWB2xKQuhROQTDhZij7BzEdzlLgFlLbdhuBzwZOp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hB0X5E2jPHBVUw8U8g1VnUNZye/kYUNyAijWlrom4v4kecxlHYgoqYgDkxX7EwjA7
         HvMONdPMeWannMasAXmq3yAd5kJcRLQJaIywUYcTTPX6zn3QTErcFYSvpQ4Bs9isIh
         pY05c9sFCIn7xBqbR1PyucSrQXaggj4KVh/EHTG0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190910123647eucas1p20b5977a2fa4ebd7c1eb0d84e3ea6f8ad~DE_3y2sp91358413584eucas1p2F;
        Tue, 10 Sep 2019 12:36:47 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 17.F6.04309.FD8977D5; Tue, 10
        Sep 2019 13:36:47 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190910123647eucas1p176bc817bbdae813e5aa9ab4745f9c285~DE_27XTxx1067210672eucas1p1l;
        Tue, 10 Sep 2019 12:36:47 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190910123646eusmtrp1adf092844cf47c08a81772e54a8efac2~DE_2tHPgi2381323813eusmtrp1f;
        Tue, 10 Sep 2019 12:36:46 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-e1-5d7798dfcb8d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 16.88.04166.ED8977D5; Tue, 10
        Sep 2019 13:36:46 +0100 (BST)
Received: from AMDC3061.DIGITAL.local (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190910123646eusmtip198c8b1c4f53d6d2961b8c402bdebf128~DE_2HdSg90745507455eusmtip1S;
        Tue, 10 Sep 2019 12:36:46 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org, vireshk@kernel.org
Cc:     robh+dt@kernel.org, kgene@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v4 6/6] ARM: dts: Add samsung,asv-bin property for
 odroidxu3-lite
Date:   Tue, 10 Sep 2019 14:36:18 +0200
Message-Id: <20190910123618.27985-7-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190910123618.27985-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42LZduznOd37M8pjDb4t0bDYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vFpsfXWC0u75rDZvG59wijxYzz+5gs1h65y27RuvcIu8XhN+2sFpsfHGNz
        4PHYtKqTzWPzknqPvi2rGD0+b5ILYInisklJzcksSy3St0vgyrj+rJOp4Atbxc7eG4wNjDdY
        uxg5OSQETCROd78Asrk4hARWMEo0/XgC5XxhlFhzcz4jhPOZUWL54k3sXYwcYC3Pe1gg4ssZ
        JXYsaWaD6+j+/40dZC6bgKFE79E+RhBbREBd4tWp/8wgRcwC65gkls1aBpYQFgiWaHj7HayB
        RUBVYmHPfjYQm1fAWuLwnL1sEAfKS6zecIAZxOYUsJE4tXsXE8ggCYF+dokVG/awQxS5SMzp
        PQr1kbDEq+NboOIyEqcnQ9wqIdDMKNGz+zY7hDOBUeL+8QWMEFVA645fZAV5jllAU2L9Ln2I
        sKPEpDMvGSF+5pO48VYQJMwMZE7aNp0ZIswr0dEmBFGtIvF71XQmCFtKovvJfxaIEg+JPX3Q
        AOpnlHg6bQ3LBEb5WQi7FjAyrmIUTy0tzk1PLTbKSy3XK07MLS7NS9dLzs/dxAhMJqf/Hf+y
        g3HXn6RDjAIcjEo8vA/aymOFWBPLiitzDzFKcDArifBe7yuNFeJNSaysSi3Kjy8qzUktPsQo
        zcGiJM5bzfAgWkggPbEkNTs1tSC1CCbLxMEp1cAYZLHm+IPD9clnqw0XHzC8/f3/K6n9zi7N
        oeFiAVsfPMvYXcnCH3o/7CvfPaOCf3f8V7P3vRda+rH75uSbqk83C+ptFnzupaAqMsX14sfw
        yBWn8k59sKw0f88dOM1g/0Rt1x4he1XveXGrVRi/xgR825qdPm+HekFnmumXFV4rLFmkQ7t4
        Kp8osRRnJBpqMRcVJwIA2vQ1wyIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsVy+t/xu7r3ZpTHGjz8om2xccZ6Vov5R86x
        WvQ/fs1scf78BnaLTY+vsVpc3jWHzeJz7xFGixnn9zFZrD1yl92ide8RdovDb9pZLTY/OMbm
        wOOxaVUnm8fmJfUefVtWMXp83iQXwBKlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwe
        a2VkqqRvZ5OSmpNZllqkb5egl3H9WSdTwRe2ip29NxgbGG+wdjFycEgImEg872HpYuTiEBJY
        yigx4/sydoi4lMT8FqUuRk4gU1jiz7UuNoiaT4wSf6/fYAZJsAkYSvQe7WMEqRcR0JTYuw6s
        hllgB5PE3md/2UBqhAUCJdqPvWQBsVkEVCUW9uwHi/MKWEscnrOXDWKBvMTqDQfAZnIK2Eic
        2r2LCcQWAqp5/XEK6wRGvgWMDKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECw3rbsZ+bdzBe
        2hh8iFGAg1GJh/dBW3msEGtiWXFl7iFGCQ5mJRHe632lsUK8KYmVValF+fFFpTmpxYcYTYGO
        msgsJZqcD4y5vJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFINjDaa
        EfExV/5/8xCeclx+OeMfJan1wod5Jgc+F/N4Ji2a4V127Sxj1ZUZu/n7JwYWFx55YcMY+Pbe
        lNdXPaK/Hb11ll/6a+OO6nVnn56IcRU9fNrxhbH5RJ4Gl3OCG5U4/33SiFoUk39wia/ajp4U
        K6HavYU/956adfHfeuGS8M7nZmUrnwcG3ldiKc5INNRiLipOBACk+bOigQIAAA==
X-CMS-MailID: 20190910123647eucas1p176bc817bbdae813e5aa9ab4745f9c285
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190910123647eucas1p176bc817bbdae813e5aa9ab4745f9c285
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190910123647eucas1p176bc817bbdae813e5aa9ab4745f9c285
References: <20190910123618.27985-1-s.nawrocki@samsung.com>
        <CGME20190910123647eucas1p176bc817bbdae813e5aa9ab4745f9c285@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Exynos5422 SoC used on Odroid XU3 Lite boards belongs to
a special ASV bin but this information cannot be read from the
CHIPID block registers. Add samsung,asv-bin property for XU3
Lite to ensure the ASV bin is properly determined.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes since v2:
 - none

Changes since v1 (RFC):
 - new patch
---
 arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts b/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
index c19b5a51ca44..a31ca2ef750f 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
@@ -26,6 +26,10 @@
 	status = "disabled";
 };

+&chipid {
+	samsung,asv-bin = <2>;
+};
+
 &pwm {
 	/*
 	 * PWM 0 -- fan
--
2.17.1

