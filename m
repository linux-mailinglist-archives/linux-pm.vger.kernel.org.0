Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B947C476F
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 08:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfJBGFH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 02:05:07 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45464 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbfJBGFH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2019 02:05:07 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191002060505euoutp0164b9e52a12acc85614126c60290e09f8~Jv1JZgkNv1488214882euoutp01Y
        for <linux-pm@vger.kernel.org>; Wed,  2 Oct 2019 06:05:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191002060505euoutp0164b9e52a12acc85614126c60290e09f8~Jv1JZgkNv1488214882euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569996305;
        bh=Ug7S/ZE6QUpnX3bV0nuiz2vhWYXfhV5caDeoQLh5WRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IeouzOu8cMuJqlIyFZk7R9j6VCnZ7m61x0QZg6kBYcUR2vfEaUNaReWoWbYg7bEIe
         5/u8SIxDyrI5inhXdJk+D6HYZIVB0OYzVJoT6cRdtZG7fRfJDUJ3t1LIPgZaOixQ9v
         o5NmfLX1kF4k8KC5gO4Ctvnxs9BsS2Yfo0i00rXg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191002060505eucas1p12765bb350b5dc9a32fa717e7ad3135b5~Jv1I_39i51280312803eucas1p1P;
        Wed,  2 Oct 2019 06:05:05 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 43.62.04374.01E349D5; Wed,  2
        Oct 2019 07:05:04 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191002060504eucas1p2f023677bb85a7f6a1efebf891e8d81df~Jv1IgQHtj0451004510eucas1p2w;
        Wed,  2 Oct 2019 06:05:04 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191002060504eusmtrp2fb088467c3645c18ce8aa0bb80a5df94~Jv1IfZLdU0112001120eusmtrp2y;
        Wed,  2 Oct 2019 06:05:04 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-9f-5d943e1051b9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BD.14.04166.01E349D5; Wed,  2
        Oct 2019 07:05:04 +0100 (BST)
Received: from AMDC3778.digital.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191002060503eusmtip2ad095572e421552af8ac29e1ce16d181~Jv1Hul76X3226032260eusmtip2e;
        Wed,  2 Oct 2019 06:05:03 +0000 (GMT)
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
Subject: [PATCH v3 1/4] dt-bindings: memory-controllers: Add Exynos5422 DMC
 interrupts description
Date:   Wed,  2 Oct 2019 08:04:52 +0200
Message-Id: <20191002060455.3834-2-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002060455.3834-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0hTYRjHe3d2tjNzdjZFX8ySJkIaalbQm4oV+GEggoF9MSRXHlRyTnfU
        tAtNKyuvpaYiXrFQ1so1h5dpUs60sjYlvKCJMgPzNiLNLt7a8Uz69nv+z/95/g8vL4GJdbg7
        kZicRimTZUkSngO3rf+PyY8MLYs5OrkehF5WtuBobHUOR3V9JhwVzy5iyGzW8tGnnCU+mlB5
        IN3sKI4+G6p5aKWwD6BKcw8HPe+b4qOnY8McNJndzEN3X/XxkXHpHo7W3lnAGZFUU6sB0s6q
        Kb5Up37Ak7Y+uSV9Y+3mSIv0aiBd0R2M5Ec7hMRRSYkZlDIgNNYhwazdBCmPhZk/5r/gKlCw
        Nw8ICEiegOtrZsCwmGwGsPWFnOVVANeGwvOAg41XAOxq78Z2B7Y+ZnPZRhOAGvVfwBa2iZrl
        SVtBEDzSH3aoU5kBF7LRtskYzXgwso0DZ9RrOONxJuNghVbGeLikN9zM6eIyLCRDoX5ilMuG
        ecJn2tc7wQLyNLROj2PMHkia+HBmJJvPmsKgpbYFZ9kZLgzo7boH3O6s47BMQ1VhA2D5Bpwt
        rrF7gqFxYHjnHoz0gS2GAFY+CzsXRzFGhqQTHF8WMTJmw5K2CrsshPdzxaz7MNQXDNmDXGGT
        pty+XAq3cmo57OuUAFhXr8IeAs+q/2H1AKiBG5VOy+Mp+ngyddWflsnp9OR4/8sKuQ7YftLg
        1sDPDtCzcakXkASQOArHo0pjxLgsg86S9wJIYBIXYchGSYxYGCfLukYpFReV6UkU3Qv2E1yJ
        m/D6npkLYjJelkZdoagUSrnb5RACdxWINM63lsUKsI6wNNdHXjedqlwHR879PlkWgb0nKXFU
        2rE7fop8b5NvWPt319QFUbmo4YhiJGN+wfqhwOz1Ldd4PtbCKWssnYvoCvfJ91pJsvhgC/uU
        KtGpiWaB1q0l+ICh4au12EKP/Uq8jZky6zVtHY791YHTh0xBRX7bbw0SLp0gC/TFlLTsHyyz
        o/NFAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsVy+t/xe7oCdlNiDWZMVLDYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht7jVIGOx6fE1VovLu+awWXzuPcJoMeP8PiaLtUfuslss
        vX6RyeJ24wo2i9a9R9gtDr9pZ7X4duIRo4Ogx5p5axg9ds66y+6xaVUnm8fmJfUeB9/tYfLo
        27KK0ePzJrkA9ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy
        1CJ9uwS9jPMb/jIWTOWt+PTyDmsDYw93FyMnh4SAicS/M40sXYxcHEICSxklGvf+Z4NIiElM
        2redHcIWlvhzrYsNougTo0TfouWsXYwcHGwCehI7VhWCxEUEljNKHFv1lhnEYRY4wiRxdPU1
        RpBuYYEkiVkrj7GC2CwCqhJ/m3azgNi8AnYSW25dY4HYIC+xesMBZhCbU8Be4t39G8wgC4SA
        av6fqZzAyLeAkWEVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYKRsO/Zz8w7GSxuDDzEKcDAq
        8fA2BE2OFWJNLCuuzD3EKMHBrCTCa/NnUqwQb0piZVVqUX58UWlOavEhRlOgmyYyS4km5wOj
        OK8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA2NsaKRo8ib9+66S
        X/b07TM7/6Hh641H69efeB2aa5v2fkbyrqY3jwwWaqUGBoYcbjvUKsZ29CWPFIe+d9h9Ga70
        v62fhLWr7Tw337p8yu7VWY7HjsZpHAdZlvC9Xb6cK3bPlbIVjUqty47e+Kz/v6/wyct/F87a
        dacodC+75muf3hG1gN057L0SS3FGoqEWc1FxIgDSu1YsqgIAAA==
X-CMS-MailID: 20191002060504eucas1p2f023677bb85a7f6a1efebf891e8d81df
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191002060504eucas1p2f023677bb85a7f6a1efebf891e8d81df
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191002060504eucas1p2f023677bb85a7f6a1efebf891e8d81df
References: <20191002060455.3834-1-l.luba@partner.samsung.com>
        <CGME20191002060504eucas1p2f023677bb85a7f6a1efebf891e8d81df@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add description for optional interrupt lines. It provides a new operation
mode, which uses internal performance counters interrupt when overflow.
This is more reliable than using default polling mode implemented in
devfreq.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 .../bindings/memory-controllers/exynos5422-dmc.txt    | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
index 02aeb3b5a820..e2434cac4858 100644
--- a/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
@@ -31,6 +31,14 @@ Required properties for DMC device for Exynos5422:
 	The register offsets are in the driver code and specyfic for this SoC
 	type.
 
+Optional properties for DMC device for Exynos5422:
+- interrupt-parent : The parent interrupt controller.
+- interrupts : Contains the IRQ line numbers for the DMC internal performance
+  event counters in DREX0 and DREX1 channels. Align with specification of the
+  interrupt line(s) in the interrupt-parent controller.
+- interrupt-names : IRQ names "drex_0" and "drex_1", the order should be the
+  same as in the 'interrupts' list above.
+
 Example:
 
 	ppmu_dmc0_0: ppmu@10d00000 {
@@ -70,4 +78,7 @@ Example:
 		device-handle = <&samsung_K3QF2F20DB>;
 		vdd-supply = <&buck1_reg>;
 		samsung,syscon-clk = <&clock>;
+		interrupt-parent = <&combiner>;
+		interrupts = <16 0>, <16 1>;
+		interrupt-names = "drex_0", "drex_1";
 	};
-- 
2.17.1

