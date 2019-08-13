Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CACD8BC8B
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 17:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbfHMPJP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 11:09:15 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54877 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbfHMPJE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2019 11:09:04 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190813150902euoutp02df98466d7c5613fb4dd6e99f133729bc~6g-zw9xO71988619886euoutp02p
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2019 15:09:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190813150902euoutp02df98466d7c5613fb4dd6e99f133729bc~6g-zw9xO71988619886euoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565708942;
        bh=RSuWB2xKQuhROQTDhZij7BzEdzlLgFlLbdhuBzwZOp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FNnU6/LNKWK9Fxz/Eeylw0hL3enUfb1V/kax3zEvxV7KO3CUQlv31gE2+pFsUqXRv
         nrsYcKPDlvD4NtMUJYpF92TdC3KrcXjIF/RJ4MV0lmUXt12VQ9BIVx2ZMSeVulCubk
         JYndVcNqx2Q2BLZYJpCEk9wrpcpre52ARtun/qwE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190813150902eucas1p1f5ce8352c88dcb2283b5d575b316a36c~6g-zCwXJZ2552325523eucas1p1I;
        Tue, 13 Aug 2019 15:09:02 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 0D.9E.04309.D82D25D5; Tue, 13
        Aug 2019 16:09:01 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190813150900eucas1p12fbf753613c727d8cb6992b6f77aca80~6g-x4xntO0107601076eucas1p1I;
        Tue, 13 Aug 2019 15:09:00 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190813150900eusmtrp1ef12e9ff19451c11121bb092049a0cd6~6g-xo0_cP1601316013eusmtrp1_;
        Tue, 13 Aug 2019 15:09:00 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-01-5d52d28d84ff
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B1.D1.04166.C82D25D5; Tue, 13
        Aug 2019 16:09:00 +0100 (BST)
Received: from AMDC3061.DIGITAL.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190813150859eusmtip204ac58fffdac289ffdfa45d6d91ec1f8~6g-xDo-_d1702317023eusmtip2E;
        Tue, 13 Aug 2019 15:08:59 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org
Cc:     robh+dt@kernel.org, vireshk@kernel.org, devicetree@vger.kernel.org,
        kgene@kernel.org, pankaj.dubey@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 9/9] ARM: dts: Add samsung,asv-bin property for
 odroidxu3-lite
Date:   Tue, 13 Aug 2019 17:08:27 +0200
Message-Id: <20190813150827.31972-10-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190813150827.31972-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djP87q9l4JiDZavMLDYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vFpsfXWC0u75rDZvG59wijxYzz+5gs1h65y26xaOsXdovWvUfYLQ6/aWe1
        2PzgGJsDr8emVZ1sHpuX1Hv0bVnF6PF5k1wASxSXTUpqTmZZapG+XQJXxsqr5gXf2Cp29t5g
        bGC8wdrFyMkhIWAicb7rCGMXIxeHkMAKRokZH06yQThfGCUav9xlh3A+M0r0HZoK17Jow21W
        iMRyRon9LXMY4VomLXkIVsUmYCjRe7SPEcQWERCWuLd0OdgoZoF7TBKnn55lAkkICwRL7Ghv
        AmtgEVCVuLPuAVgDr4CNxPqLGxgh1slLrN5wgBnE5gSK75z+Hmy1hMBkdolTky8wQxS5SDT9
        bYSyhSVeHd/CDmHLSJye3MMC0dDMKNGz+zY7hDOBUeL+8QVQK6wlDh+/CDSWA+g+TYn1u/RB
        TAkBR4krXfwQJp/EjbeCIMXMQOakbdOZIcK8Eh1tQhAzVCR+r5rOBGFLSXQ/+c8CYXtINH76
        Dw2tfmAwHtnEPIFRfhbCrgWMjKsYxVNLi3PTU4uN8lLL9YoTc4tL89L1kvNzNzEC08rpf8e/
        7GDc9SfpEKMAB6MSD2/AlqBYIdbEsuLK3EOMEhzMSiK8Ey4ChXhTEiurUovy44tKc1KLDzFK
        c7AoifNWMzyIFhJITyxJzU5NLUgtgskycXBKNTAKbhW4ZfN6bcvNYsPOqvm/G0271bZ+sq+Z
        J/9nukh+VvLEvwxBpWx9t7f3sE/Qy0hqiH3Lwvz8dWsg+6VZZYKvr97t6Fq3pVXguW3lhvBV
        S7r0I+bdmP+Iby9X6eoTd4uORPk3u6QLe7SdL0rdl7DurF2Y2ZrVpRPrGQO4/iZs/LTtqTpj
        fboSS3FGoqEWc1FxIgDctfmmJwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsVy+t/xe7o9l4JiDZ5PUbLYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vFpsfXWC0u75rDZvG59wijxYzz+5gs1h65y26xaOsXdovWvUfYLQ6/aWe1
        2PzgGJsDr8emVZ1sHpuX1Hv0bVnF6PF5k1wAS5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
        pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexsqr5gXf2Cp29t5gbGC8wdrFyMkhIWAisWjDbSCb
        i0NIYCmjxNObZ5i6GDmAElIS81uUIGqEJf5c62KDqPnEKDF/eSdYM5uAoUTv0T5GEFsEqOje
        0uXsIEXMAq+YJG7P+88EkhAWCJQ4s2UuC4jNIqAqcWfdA7AGXgEbifUXNzBCbJCXWL3hADOI
        zQkU3zn9PdgCIQFriafv1jNPYORbwMiwilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzDEtx37
        uXkH46WNwYcYBTgYlXh4A7YExQqxJpYVV+YeYpTgYFYS4Z1wESjEm5JYWZValB9fVJqTWnyI
        0RToqInMUqLJ+cD4yyuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnV
        wJh54eb3R/aLPeUWFdSVbe8MDWfw+8zmOVWPvTvwTcIRputzzTe/uNWv3sJ1fdL/otaqm8lr
        khcpKBgtbxP7F8Ly3iz12uZtp6bsW8j5bvqtAxo3l7EKqwQfnzl/oveDmC058qLRB0y41hi7
        T521bmlIUOAx29CoOM+E+/v3sSxZlNQn3aIm2KLEUpyRaKjFXFScCADlvQxshwIAAA==
X-CMS-MailID: 20190813150900eucas1p12fbf753613c727d8cb6992b6f77aca80
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190813150900eucas1p12fbf753613c727d8cb6992b6f77aca80
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190813150900eucas1p12fbf753613c727d8cb6992b6f77aca80
References: <20190813150827.31972-1-s.nawrocki@samsung.com>
        <CGME20190813150900eucas1p12fbf753613c727d8cb6992b6f77aca80@eucas1p1.samsung.com>
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

