Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7FACDA84E
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 11:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392102AbfJQJ34 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 05:29:56 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53811 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393479AbfJQJ34 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 05:29:56 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191017092954euoutp02a981126dfbdd1da6a3773f0c3586ae1e~OZTQXFpPm1000410004euoutp02U
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2019 09:29:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191017092954euoutp02a981126dfbdd1da6a3773f0c3586ae1e~OZTQXFpPm1000410004euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1571304594;
        bh=AZdVAI8mpGcBE9pPmmB/AtQ4Fwrc9hnMXEZrXafSrJk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=h0ogVYM70aSf7Tp0Rz6S8W67pcy/l8B+nVbg7z0v1OkG5HSfIrF9oES6MYlF2xke/
         Zv84X7rKYodU1VxBAdS2MnNtwQNUDNslRigi3/OoXSiLBwylMw/ZeYGJ5X9mI5nNdr
         aXmDlUba/uG+vUFiPAt8X8jMABFtMe+iULH/Cp3E=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191017092954eucas1p140e423338f18e841fd670ec99aca6734~OZTQBxuxI2126021260eucas1p1V;
        Thu, 17 Oct 2019 09:29:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A0.96.04469.19438AD5; Thu, 17
        Oct 2019 10:29:53 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191017092953eucas1p259c1e03eb2cb4d19aa48eaa2e3cca2dc~OZTPtAhJM0648306483eucas1p2e;
        Thu, 17 Oct 2019 09:29:53 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191017092953eusmtrp17f62f839f61fa99d9025415421ea344e~OZTPsTIIP1633216332eusmtrp1K;
        Thu, 17 Oct 2019 09:29:53 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-50-5da83491a45c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 48.BD.04166.19438AD5; Thu, 17
        Oct 2019 10:29:53 +0100 (BST)
Received: from AMDC3061.DIGITAL.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191017092953eusmtip2f4ef56add6868611954ec7fd29136e49~OZTPNNBIX2907729077eusmtip2K;
        Thu, 17 Oct 2019 09:29:53 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     robh+dt@kernel.org
Cc:     krzk@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v6] dt-bindings: arm: samsung: Update the CHIPID binding for
 ASV
Date:   Thu, 17 Oct 2019 11:29:39 +0200
Message-Id: <20191017092939.25899-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsWy7djPc7oTTVbEGvRNsrHYOGM9q8X8I+dY
        Lc6f38BusenxNVaLz71HGC1mnN/HZLH2yF12i9a9R9gtDr9pZ3Xg9Ni0qpPNY/OSeo++LasY
        PT5vkgtgieKySUnNySxLLdK3S+DKuDt1E3PBVqGKtat7WBoYD/N1MXJySAiYSOyc283YxcjF
        ISSwglFi+e4HUM4XRokv/WeYIZzPjBL/vj5jhmlZcvMGK0RiOaPE/Ul9YAmwljlbxEBsNgFD
        id6jfUCjODhEBMQk9q4VBQkzC/xklHj0WgLEFhYIktj9fAsjiM0ioCoxb80ZJpByXgFridat
        JhCr5CVWbzgAdoOEwH02iWU397NCJFwkpv/cDWULS7w6voUdwpaROD25hwWioZlRomf3bXYI
        ZwLQoccXMEJUWUscPn6RFWQbs4CmxPpd+hBhR4nl07rBbpYQ4JO48VYQ4mY+iUnbpjNDhHkl
        OtqEIKpVJH6vms4EYUtJdD/5zwJR4iEx4UcyJEBiJW7M/Mk4gVFuFsKqBYyMqxjFU0uLc9NT
        iw3zUsv1ihNzi0vz0vWS83M3MQLTwel/xz/tYPx6KekQowAHoxIP7wTG5bFCrIllxZW5hxgl
        OJiVRHjntyyJFeJNSaysSi3Kjy8qzUktPsQozcGiJM5bzfAgWkggPbEkNTs1tSC1CCbLxMEp
        1cDYP/nZwoasRSo53RzTKtaf5V3RGuCbufXdAq24LPGfslwf6h/F/Gjcurzh9KJ5MoeqFz6O
        CsgI3GPjd+xFmUXg5zXrOs7eKQ57WF8xdXtf763G+W83/ji14+rsTfpfd1xbk/XNjdvSsyrk
        bEJad8udWKXbvr8yfX721BXXP8psusd8k1MrgbtLiaU4I9FQi7moOBEAArexdQMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOLMWRmVeSWpSXmKPExsVy+t/xe7oTTVbEGmx8o2KxccZ6Vov5R86x
        Wpw/v4HdYtPja6wWn3uPMFrMOL+PyWLtkbvsFq17j7BbHH7TzurA6bFpVSebx+Yl9R59W1Yx
        enzeJBfAEqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRv
        l6CXcXfqJuaCrUIVa1f3sDQwHubrYuTkkBAwkVhy8wZrFyMXh5DAUkaJg71HWLoYOYASUhLz
        W5QgaoQl/lzrYoOo+cQocfzdcUaQBJuAoUTv0T5GkHoRATGJvWtFQWqYBRqZJG5smwVWIywQ
        IPHkHUgzJweLgKrEvDVnmEDqeQWsJVq3mkDMl5dYveEA8wRGngWMDKsYRVJLi3PTc4sN9YoT
        c4tL89L1kvNzNzECA3HbsZ+bdzBe2hh8iFGAg1GJh3cC4/JYIdbEsuLK3EOMEhzMSiK881uW
        xArxpiRWVqUW5ccXleakFh9iNAXaPZFZSjQ5HxgleSXxhqaG5haWhubG5sZmFkrivB0CB2OE
        BNITS1KzU1MLUotg+pg4OKUaGJM38n/oc5+cs2Udp0718TYvnTUZtiFiJl1/KqTb513jeND3
        Z/7VH63Ldye+93h5e/bhCcYvDKOERMvaXR3uPu0R/yt9KTmF337VKn4ft6OHjDzj5Vb1yX1i
        urv8C+NBvkmZa6a1FqYG/XlgvrBP77WS79uon0z5Bd1ZaqtuHlk2OZNdbOWjG0osxRmJhlrM
        RcWJAAP7r5xaAgAA
X-CMS-MailID: 20191017092953eucas1p259c1e03eb2cb4d19aa48eaa2e3cca2dc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191017092953eucas1p259c1e03eb2cb4d19aa48eaa2e3cca2dc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191017092953eucas1p259c1e03eb2cb4d19aa48eaa2e3cca2dc
References: <CGME20191017092953eucas1p259c1e03eb2cb4d19aa48eaa2e3cca2dc@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds documentation of new optional "samsung,asv-bin"
property in the chipid device node and documents requirement of
"syscon" compatible string.  These additions are needed to support
Exynos ASV (Adaptive Supply Voltage) feature.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Depends on patch ("8d0daa4c89c9 dt-bindings: arm: samsung: Convert
Exynos Chipid bindings to json-schema") already applied to Rob's
dt/next.

Changes since v5:
 - removed uneeded allOf from 'compatible' property section

Changes since v4:
 - converted to YAML

Changes since v3:
 - none

Changes since v2:
 - corrected patch summary line prefix, the patch moved in the
   sequence

Changes since v1 (RFC):
 - new patch
---
 .../bindings/arm/samsung/exynos-chipid.yaml   | 26 ++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml b/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml
index 9c573ad7dc7d..c7f06aa1963c 100644
--- a/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml
@@ -9,17 +9,41 @@ title: Samsung Exynos SoC series Chipid driver
 maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>

+# Custom select to avoid matching all nodes with 'syscon'
+select:
+  properties:
+    compatible:
+      contains:
+        const: samsung,exynos4210-chipid
+  required:
+    - compatible
+
 properties:
   compatible:
     items:
       - const: samsung,exynos4210-chipid
+      - const: syscon

   reg:
     maxItems: 1

+  samsung,asv-bin:
+    description:
+      Adaptive Supply Voltage bin selection. This can be used
+      to determine the ASV bin of an SoC if respective information
+      is missing in the CHIPID registers or in the OTP memory.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum: [ 0, 1, 2, 3 ]
+
+required:
+  - compatible
+  - reg
+
 examples:
   - |
     chipid@10000000 {
-      compatible = "samsung,exynos4210-chipid";
+      compatible = "samsung,exynos4210-chipid", "syscon";
       reg = <0x10000000 0x100>;
+      samsung,asv-bin = <2>;
     };
--
2.17.1

