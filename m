Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED618202E96
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jun 2020 05:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbgFVC76 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Jun 2020 22:59:58 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:41278 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731063AbgFVC75 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Jun 2020 22:59:57 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.8599358|0.1215216;CH=green;DM=|AD|false|;DS=CONTINUE|ham_system_inform|0.0515633-0.00127516-0.947161;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03294;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=27;RT=27;SR=0;TI=SMTPD_---.HqMydez_1592794774;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.HqMydez_1592794774)
          by smtp.aliyun-inc.com(10.147.40.44);
          Mon, 22 Jun 2020 10:59:49 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     robh+dt@kernel.org, mripard@kernel.org, wens@csie.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        srinivas.kandagatla@linaro.org, linus.walleij@linaro.org,
        anarsoul@gmail.com, tiny.windzz@gmail.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        p.zabel@pengutronix.de, clabbe@baylibre.com, icenowy@aosc.io,
        megous@megous.com, karlp@tweak.net.au, bage@linutronix.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        huangshuosheng@allwinnertech.com, liyong@allwinnertech.com,
        Frank Lee <frank@allwinnertech.com>
Subject: [PATCH v2 03/11] dt-bindings: pinctrl: sunxi: Add A100 pinctrl bindings
Date:   Mon, 22 Jun 2020 10:58:59 +0800
Message-Id: <20200622025907.32574-4-frank@allwinnertech.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200622025907.32574-1-frank@allwinnertech.com>
References: <20200622025907.32574-1-frank@allwinnertech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add device tree binding Documentation details for A100 pinctrl driver,
whic has an r pin controller and a pin controller with more irq lines.

Signed-off-by: Frank Lee <frank@allwinnertech.com>
---
 .../pinctrl/allwinner,sun4i-a10-pinctrl.yaml       | 72 +++++++++++++---------
 1 file changed, 43 insertions(+), 29 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
index bfefd09..2ac5eb5 100644
--- a/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
@@ -48,6 +48,8 @@ properties:
       - allwinner,sun9i-a80-r-pinctrl
       - allwinner,sun50i-a64-pinctrl
       - allwinner,sun50i-a64-r-pinctrl
+      - allwinner,sun50i-a100-pinctrl
+      - allwinner,sun50i-a100-r-pinctrl
       - allwinner,sun50i-h5-pinctrl
       - allwinner,sun50i-h6-pinctrl
       - allwinner,sun50i-h6-r-pinctrl
@@ -144,75 +146,87 @@ allOf:
   # FIXME: We should have the pin bank supplies here, but not a lot of
   # boards are defining it at the moment so it would generate a lot of
   # warnings.
-
   - if:
       properties:
         compatible:
           enum:
-            - allwinner,sun9i-a80-pinctrl
+            - allwinner,sun50i-a100-pinctrl
 
     then:
       properties:
         interrupts:
-          minItems: 5
-          maxItems: 5
+          minItems: 7
+          maxItems: 7
 
     else:
       if:
         properties:
           compatible:
             enum:
-              - allwinner,sun6i-a31-pinctrl
-              - allwinner,sun6i-a31s-pinctrl
-              - allwinner,sun50i-h6-pinctrl
+              - allwinner,sun9i-a80-pinctrl
 
       then:
         properties:
           interrupts:
-            minItems: 4
-            maxItems: 4
+            minItems: 5
+            maxItems: 5
 
       else:
         if:
           properties:
             compatible:
               enum:
-                - allwinner,sun8i-a23-pinctrl
-                - allwinner,sun8i-a83t-pinctrl
-                - allwinner,sun50i-a64-pinctrl
-                - allwinner,sun50i-h5-pinctrl
-                - allwinner,suniv-f1c100s-pinctrl
+                - allwinner,sun6i-a31-pinctrl
+                - allwinner,sun6i-a31s-pinctrl
+                - allwinner,sun50i-h6-pinctrl
 
         then:
           properties:
             interrupts:
-              minItems: 3
-              maxItems: 3
+              minItems: 4
+              maxItems: 4
 
         else:
           if:
             properties:
               compatible:
                 enum:
-                  - allwinner,sun6i-a31-r-pinctrl
-                  - allwinner,sun8i-a33-pinctrl
-                  - allwinner,sun8i-h3-pinctrl
-                  - allwinner,sun8i-v3-pinctrl
-                  - allwinner,sun8i-v3s-pinctrl
-                  - allwinner,sun9i-a80-r-pinctrl
-                  - allwinner,sun50i-h6-r-pinctrl
+                  - allwinner,sun8i-a23-pinctrl
+                  - allwinner,sun8i-a83t-pinctrl
+                  - allwinner,sun50i-a64-pinctrl
+                  - allwinner,sun50i-h5-pinctrl
+                  - allwinner,suniv-f1c100s-pinctrl
 
           then:
             properties:
               interrupts:
-                minItems: 2
-                maxItems: 2
+                minItems: 3
+                maxItems: 3
 
           else:
-            properties:
-              interrupts:
-                minItems: 1
-                maxItems: 1
+            if:
+              properties:
+                compatible:
+                  enum:
+                    - allwinner,sun6i-a31-r-pinctrl
+                    - allwinner,sun8i-a33-pinctrl
+                    - allwinner,sun8i-h3-pinctrl
+                    - allwinner,sun8i-v3-pinctrl
+                    - allwinner,sun8i-v3s-pinctrl
+                    - allwinner,sun9i-a80-r-pinctrl
+                    - allwinner,sun50i-h6-r-pinctrl
+
+            then:
+              properties:
+                interrupts:
+                  minItems: 2
+                  maxItems: 2
+
+            else:
+              properties:
+                interrupts:
+                  minItems: 1
+                  maxItems: 1
 
 additionalProperties: false
 
-- 
1.9.1

