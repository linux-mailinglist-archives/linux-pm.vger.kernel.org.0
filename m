Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2458AEAA9
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2019 14:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404712AbfIJMhB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Sep 2019 08:37:01 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:37668 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404272AbfIJMgk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Sep 2019 08:36:40 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190910123639euoutp0107d14eba0433a98b8a7cb2b3baee8764~DE_vscsCk1126611266euoutp01K
        for <linux-pm@vger.kernel.org>; Tue, 10 Sep 2019 12:36:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190910123639euoutp0107d14eba0433a98b8a7cb2b3baee8764~DE_vscsCk1126611266euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568118999;
        bh=ageHcoP5yyUcbBzIKRba9vlDt9YVjqT0KkoUSzxprYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZSpzF0/gmUzByPQj4mapOlwqx6g8v0VJDQIxhmSYcsHbb3kXitR1hRol4DQozavQX
         2vFRy8EJRvNiwnQRE9dCrGlKnirR2QZweiVEJvNF54lxNNbeOQw+tr5kzKJceAWSfM
         gGQ1awj1Kwd6jKdH1dYO3DKLu5/sBDbd+WGuPP9Q=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190910123638eucas1p217975a57a3d938b79bcd3c9afecdc6fb~DE_u3Qcb-1661016610eucas1p2u;
        Tue, 10 Sep 2019 12:36:38 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 52.EB.04469.6D8977D5; Tue, 10
        Sep 2019 13:36:38 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190910123637eucas1p26d2051f9bdd1bdf4510f1908ea98f641~DE_uIU1DJ1360413604eucas1p2u;
        Tue, 10 Sep 2019 12:36:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190910123637eusmtrp17d93565418338fe6a8edb22585aa325c~DE_uHa7Ij2381323813eusmtrp16;
        Tue, 10 Sep 2019 12:36:37 +0000 (GMT)
X-AuditID: cbfec7f2-569ff70000001175-68-5d7798d6b9fa
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EB.EC.04117.5D8977D5; Tue, 10
        Sep 2019 13:36:37 +0100 (BST)
Received: from AMDC3061.DIGITAL.local (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190910123636eusmtip11189d73e0cd292dac1eb81a70cbae68d~DE_tjHbJ71089810898eusmtip1v;
        Tue, 10 Sep 2019 12:36:36 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org, vireshk@kernel.org
Cc:     robh+dt@kernel.org, kgene@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v4 2/6] dt-bindings: samsung: Update the CHIP ID binding
 documentation
Date:   Tue, 10 Sep 2019 14:36:14 +0200
Message-Id: <20190910123618.27985-3-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190910123618.27985-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42LZduzned1rM8pjDfZPZLHYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vFpsfXWC0u75rDZvG59wijxYzz+5gs1h65y27RuvcIu8XhN+2sFpsfHGNz
        4PHYtKqTzWPzknqPvi2rGD0+b5ILYInisklJzcksSy3St0vgynjw6gBrQS9vxY0JT1gbGH9y
        dTFyckgImEjseTiNuYuRi0NIYAWjRNveVkYI5wujxOLr05ggnM+MEkeergbKcIC1nDnmBBFf
        ziixfWYDG1zH9pajLCBz2QQMJXqP9jGC2CIC6hKvTv0H28EssI5JYtmsZWCThAUiJJZMjACp
        YRFQlTi37hVYPa+AtcTKRZuZIe6Tl1i94QCYzSlgI3Fq9y6wiyQEutkl1izqY4O4yEVi+vMQ
        iHphiVfHt7BD2DISpyf3sEDUNzNK9Oy+zQ7hTGCUuH98ASNElbXE4eMXWUEGMQtoSqzfpQ8R
        dpS4tOYB1Hw+iRtvBUHCzEDmpG3TmSHCvBIdbUIQ1SoSv1dNZ4KwpSS6n/xngbA9JOYs2Qm2
        SEign1Hi5U7rCYzysxB2LWBkXMUonlpanJueWmyYl1quV5yYW1yal66XnJ+7iRGYSE7/O/5p
        B+PXS0mHGAU4GJV4eDtaymOFWBPLiitzDzFKcDArifBe7yuNFeJNSaysSi3Kjy8qzUktPsQo
        zcGiJM5bzfAgWkggPbEkNTs1tSC1CCbLxMEp1cAoejuT4+IaC3U3DplpqcuaEnfe/qUu4jjP
        147X/ezEa/yNQTs1BD0k85i8xM9mXv9+95arks/UuIZ5fe5T2hI8xV0CNsnHHJyykUd2cTf3
        v3/Ljrsm7U+v/cG7bWrq7zXtJ1S2ZyT5uEmJKf9gqGM4lrs07lCC7taMhUpPnX9O/q5fUtuq
        u1+JpTgj0VCLuag4EQAiRUw0IAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsVy+t/xu7pXZ5THGjw4K2uxccZ6Vov5R86x
        WvQ/fs1scf78BnaLTY+vsVpc3jWHzeJz7xFGixnn9zFZrD1yl92ide8RdovDb9pZLTY/OMbm
        wOOxaVUnm8fmJfUefVtWMXp83iQXwBKlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwe
        a2VkqqRvZ5OSmpNZllqkb5egl/Hg1QHWgl7eihsTnrA2MP7k6mLk4JAQMJE4c8ypi5GLQ0hg
        KaPExQu3WSDiUhLzW5S6GDmBTGGJP9e62CBqPjFKrDs5hRUkwSZgKNF7tI8RpF5EQFNi7zqw
        GmaBHUwSe5/9ZQOJCwuESey5pQhSziKgKnFu3StGEJtXwFpi5aLNzBDz5SVWbzgAZnMK2Eic
        2r2LCcQWAqp5/XEK6wRGvgWMDKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECg3rbsZ9bdjB2
        vQs+xCjAwajEw9vRUh4rxJpYVlyZe4hRgoNZSYT3el9prBBvSmJlVWpRfnxRaU5q8SFGU6Cj
        JjJLiSbnAyMuryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDo+XE
        ffOsHuW8Zwl4WPjm+JzfX+Kbwv2mWU8J2/uqRDPJMsbdosNGsEqsffWtLZyueY92CZ0wZvS4
        uoN5y3PLPw+WZBvmxa4xFmsJf25xeUJ2/EvZSYt4zzTnL+zg33FieZqqAYvtgitz/ySqlnqv
        Lp2SLTMxhFl26u8DEYf0Otk860L6/HbsVWIpzkg01GIuKk4EAE9kh36AAgAA
X-CMS-MailID: 20190910123637eucas1p26d2051f9bdd1bdf4510f1908ea98f641
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190910123637eucas1p26d2051f9bdd1bdf4510f1908ea98f641
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190910123637eucas1p26d2051f9bdd1bdf4510f1908ea98f641
References: <20190910123618.27985-1-s.nawrocki@samsung.com>
        <CGME20190910123637eucas1p26d2051f9bdd1bdf4510f1908ea98f641@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds documentation of a new optional "samsung,asv-bin"
property in the chipid device node and documents requirement of
"syscon" compatible string.  These additions are needed to support
Exynos ASV (Adaptive Supply Voltage) feature.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes since v3:
 - none

Changes since v2:
 - corrected patch summary line prefix, the patch moved in the
   sequence

Changes since v1 (RFC):
 - new patch
---
 .../devicetree/bindings/arm/samsung/exynos-chipid.txt  | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.txt b/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.txt
index 85c5dfd4a720..be3657e6c00c 100644
--- a/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.txt
@@ -1,12 +1,18 @@
-SAMSUNG Exynos SoCs Chipid driver.
+SAMSUNG Exynos SoC series CHIPID subsystem

 Required properties:
-- compatible : Should at least contain "samsung,exynos4210-chipid".
+- compatible : Should at least contain "samsung,exynos4210-chipid", "syscon".

 - reg: offset and length of the register set

+Optional properties:
+ - samsung,asv-bin : Adaptive Supply Voltage bin selection. This can be used
+   to determine the ASV bin of an SoC if respective information is missing
+   in the CHIPID registers or in the OTP memory. Possible values: 0...3.
+
 Example:
 	chipid@10000000 {
 		compatible = "samsung,exynos4210-chipid";
 		reg = <0x10000000 0x100>;
+		samsung,asv-bin = <2>;
 	};
--
2.17.1

