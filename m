Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4A3216A3A
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jul 2020 12:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgGGK3A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jul 2020 06:29:00 -0400
Received: from condef-03.nifty.com ([202.248.20.68]:34565 "EHLO
        condef-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgGGK3A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2020 06:29:00 -0400
Received: from conuserg-10.nifty.com ([10.126.8.73])by condef-03.nifty.com with ESMTP id 067AP9tJ010043
        for <linux-pm@vger.kernel.org>; Tue, 7 Jul 2020 19:25:09 +0900
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 067ANfmE026850;
        Tue, 7 Jul 2020 19:23:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 067ANfmE026850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1594117421;
        bh=zq83RdcrauiJcJsiQaH1vrrVn5BqvuzN8MJjggFF8WU=;
        h=From:To:Cc:Subject:Date:From;
        b=Isv3af9anEuxoNIIgnBE00XkO0Tn7KWOw1gkoNxDJ3WkDybVoa1Vu+qkltJChiPhC
         gmpn0hOFPKWhQSqyfBvW/XTBQ6YuB0H6/jmVnvPJAQR68yiVmP9sD7B/6qF+/eqT4q
         o6QVDaXCkal/dhOuwV8jghSMEaDQa32dGRba7a/D2UYCw1aacbJvYDuYXlZSumLTO0
         +gT7IF5y2J2hVFjzZdutzZnL9GssXWEVx3DU6/3BIlf9ifSeLvxUik7nz4L3jsTH83
         BMhycsMTjvilRR5BEgHYPohEddCgpVSk/bU6tq0/qbl4ySJ4nenjSNCZy4mcLmM3u/
         I8nNxzQulk1xw==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH] dt-bindings: uniphier-thermal: add minItems to socionext,tmod-calibration
Date:   Tue,  7 Jul 2020 19:23:38 +0900
Message-Id: <20200707102338.989660-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As the description says, this property contains a pair of calibration
values. The number of items must be exactly 2.

Add minItems to check a too short property.

While I was here, I also added this property to the example because
this is the case in the real DT file,
arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi

Also, fix the interrupt type (edge -> level) to align with the
real DT.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 .../bindings/thermal/socionext,uniphier-thermal.yaml          | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml b/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
index 553c9dcdaeeb..57ffd0c4c474 100644
--- a/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
@@ -29,6 +29,7 @@ properties:
 
   socionext,tmod-calibration:
     $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 2
     maxItems: 2
     description:
       A pair of calibrated values referred from PVT, in case that the values
@@ -52,7 +53,8 @@ examples:
 
         pvtctl: thermal {
             compatible = "socionext,uniphier-ld20-thermal";
-            interrupts = <0 3 1>;
+            interrupts = <0 3 4>;
             #thermal-sensor-cells = <0>;
+            socionext,tmod-calibration = <0x0f22 0x68ee>;
         };
     };
-- 
2.25.1

