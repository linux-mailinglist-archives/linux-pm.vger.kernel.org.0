Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A43878BC89
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 17:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbfHMPJC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 11:09:02 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45928 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbfHMPJC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2019 11:09:02 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190813150900euoutp01a0d93e91cd4532bf69127d30f2fa56cc~6g-xdFq0k2748427484euoutp01H
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2019 15:09:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190813150900euoutp01a0d93e91cd4532bf69127d30f2fa56cc~6g-xdFq0k2748427484euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565708940;
        bh=wXzGqmIiM4g/8jlmRMR0TMihFYWxqj3/S01UAEO/Wqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S7G8F/WQ4Xvy1wesuUDpR/YGmygooyjSxRB7qWwVej8ADfyVH/lbaJyhYpQUzD58/
         StVjHAKcY0x/OhhxjoAn6UUrYBgL4clZJE5D/yFfxIgnAbBFsRpDRRkexdSQP5Vhtt
         +7X5WImygeUpmnhNJ2UwxfMOJ1etrSj400nVxkWs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190813150859eucas1p1a772b5b1247300150f17a509184d9284~6g-wqymDb2542925429eucas1p1H;
        Tue, 13 Aug 2019 15:08:59 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 95.5B.04469.B82D25D5; Tue, 13
        Aug 2019 16:08:59 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190813150858eucas1p1a5fbf425753e4911c50631c3a6d34ffd~6g-vph9Bx2552325523eucas1p1F;
        Tue, 13 Aug 2019 15:08:58 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190813150858eusmtrp1bb1b6866719503646f9f2c13eccb5562~6g-vZtKNw1601316013eusmtrp18;
        Tue, 13 Aug 2019 15:08:58 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-b4-5d52d28bd712
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B0.D1.04166.A82D25D5; Tue, 13
        Aug 2019 16:08:58 +0100 (BST)
Received: from AMDC3061.DIGITAL.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190813150857eusmtip24b15a9bd426f668841122b42c658106d~6g-uxuSu-1702317023eusmtip2D;
        Tue, 13 Aug 2019 15:08:57 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org
Cc:     robh+dt@kernel.org, vireshk@kernel.org, devicetree@vger.kernel.org,
        kgene@kernel.org, pankaj.dubey@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 7/9] soc: samsung: Update the CHIP ID DT binding
 documentation
Date:   Tue, 13 Aug 2019 17:08:25 +0200
Message-Id: <20190813150827.31972-8-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190813150827.31972-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRju2znbOS5np2n4skJh2Y8sb9mPA0pUCE1BMOtXYjbzoKZO27yk
        /lCaqXk3CU0D7YbX2txUvOSyOR1lNrwimDfMhMwEL2mJ1o5H6d/zPs/zvs/Dx0di4sd8CRmt
        SGSUCnmsVCDE2/p/W9zyh4NDPQunRHRzhYZPV5s+8+ni+SWMtli0BK2bH+fTI51PBfRaoQnR
        FRYDj35tmiLo563rBP2g20TQvT9y+LR+tl9wUSTTNTwUyPQvM2RFLQ1ItqZzCsJvCH0jmNjo
        ZEbpceGWMKo0+wuWoLG9t9rbhDKRRpiHbEigzkNNqR7LQ0JSTNUhWFls47GCmFpHUGdw5YQ1
        BDVbtYKDjc3Wn4gTahGMLg7yuMG60Zy9g7MuAeUFhX1FiMUOlD1Mv6olWBNGTfNgYGFwL8Oe
        ugbP5sYJFuPUKWhdKtzjRZQP6Dbe8Lg4Z2jU9mAstqF8oaN8hc8eAqqMgK2pXZwz+cFYvXof
        28N3cwvB4RMwUFaAcwtqBAVdkwQ3lCCYMdcgzuUDveYh61nS2u80aDo9OPoSPMkZwlkaKDuY
        WD7K0pgVPmorxzhaBLnZYs7tAtsN5fudJZD/9e9+HRnot7tx7oWKESy0NBElyLnyf1gNQg3I
        kUlSxUUyKi8Fk+KuksepkhSR7rfj43TI+lkGds2r7WhjONyIKBJJbUVBLcGhYr48WZUaZ0RA
        YlIHUcmQlRJFyFPTGGV8mDIpllEZ0XESlzqK0g/NhoipSHkiE8MwCYzyQOWRNpJMVDmb9CHs
        zMeIsUBd2g4dGGNz2a6qx3ciPdrlsNtdWWrAzFpghv/85DuFzs/P27sR6mfOBmglfzqWosey
        9S+W75x7G3Xz/WyM7mpxitEwanaayzppOKLO1fqYRnYcPP2qNoPtQr71MZ+OZU1Uz4XbzXgE
        bd3v+qX2L/C3tKPrV7qkuCpK7uWKKVXyf/blT9coAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsVy+t/xe7pdl4JiDRZuY7HYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vFpsfXWC0u75rDZvG59wijxYzz+5gs1h65y26xaOsXdovWvUfYLQ6/aWe1
        2PzgGJsDr8emVZ1sHpuX1Hv0bVnF6PF5k1wAS5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
        pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexsS2O8wF63kqPh1ew9jAuJ6ri5GTQ0LAROL71neM
        XYxcHEICSxklHk79yNTFyAGUkJKY36IEUSMs8edaFxtEzSdGicbVn1lBEmwChhK9R/sYQWwR
        oKJ7S5ezgxQxC7xikrg97z8TSEJYIFBiy8rNYA0sAqoSW1/3gsV5BawlNn1dxwSxQV5i9YYD
        zCA2p4CNxM7p78HqhYBqnr5bzzyBkW8BI8MqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwCDf
        duzn5h2MlzYGH2IU4GBU4uEN2BIUK8SaWFZcmXuIUYKDWUmEd8JFoBBvSmJlVWpRfnxRaU5q
        8SFGU6CjJjJLiSbnAyMwryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMH
        p1QDo5mawtOLBwvVPFwEtFkZL1QERPjytZVx9Tc9vJLg5+1SeqmtJPhu60GRCZsfZ9T3L3jQ
        fHNpw36312tEVj32yHl0NlDBqe9JTYVIUi733e4sjeB/f+oiNcJWvXY7tFNS4tTco4sv+NW7
        Or90CJ0ckBJ8PeV1yGKDi+4CjxSFdmg4vrpTrLVUiaU4I9FQi7moOBEAsqHqx4gCAAA=
X-CMS-MailID: 20190813150858eucas1p1a5fbf425753e4911c50631c3a6d34ffd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190813150858eucas1p1a5fbf425753e4911c50631c3a6d34ffd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190813150858eucas1p1a5fbf425753e4911c50631c3a6d34ffd
References: <20190813150827.31972-1-s.nawrocki@samsung.com>
        <CGME20190813150858eucas1p1a5fbf425753e4911c50631c3a6d34ffd@eucas1p1.samsung.com>
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
Changes since v2:
 - none

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

