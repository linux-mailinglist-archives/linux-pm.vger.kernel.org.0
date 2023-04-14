Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D1E6E1F2E
	for <lists+linux-pm@lfdr.de>; Fri, 14 Apr 2023 11:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjDNJVI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Apr 2023 05:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjDNJU7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2023 05:20:59 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D204183CF;
        Fri, 14 Apr 2023 02:20:49 -0700 (PDT)
Received: from stefanw-SCHENKER ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Md66H-1qMrKj1Fkh-00aFUl; Fri, 14 Apr 2023 11:20:10 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
        linux-imx@nxp.com, "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V3 1/6] dt-bindings: serial: fsl-imx-uart: add missing properties
Date:   Fri, 14 Apr 2023 11:19:42 +0200
Message-Id: <20230414091947.7831-2-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414091947.7831-1-stefan.wahren@i2se.com>
References: <20230414091947.7831-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VioDRxv3cyE25EFn6APl9PQCkeERmtccGLpNoVTuhpxmR8Ryy+l
 ooOfWTi9WlipRRAiIAowyL1kk7vengOZSu6gN0pXrJOIy+8GDBp2OZjBnzRqBL/zaOX7rJI
 HBlzAn4RZHyYg6VadyIxbM64W+vF30iN6OsBIUT0BJwoYm5AWgkkPgdGZNc9MX7+MebE5k2
 PymoQcrFqs87GTp6/mmAw==
UI-OutboundReport: notjunk:1;M01:P0:Gz7UI4zls1o=;AZQrNr6kqGDd4YXjZZTdY2ohqZM
 268QJuWTF86x7E/+ijtB4EZ2+gDJPJGZt/MCvWh+aBgQLzxT+Qu1H8y1afAZlbilB8zc5K31B
 NLVl4/3jj69Xmmw+uVb/M4Ce7J73T4Yj2Pv4hpECgXedhreKz5VHsNLrYAxnZIV2zNhUvmDCF
 5DR3+Pm9y/DnBGxrutHAnJe3PMKoRSTkxmClmX9k642OKYgx6JcFrSvl1tihJh/KjQcu5WF65
 3ZilVD/csUYMEFYKgNvZBvYIRQ6+0IBMVqQAjeD1Egdf3pfIpN6I/WKvvyGcQRl3y1/Kmyr2B
 YK2I2L0qSsg1IAE4UgDScYpeVmhE8hi4EDSdjNEEYAEBz+z4sixne8A2xrb+wTytCAcSSa0GY
 5xoXOH503o0uZ8D/NnJpZWj8O3rSQtFNjWlsb57fmEjGN4U0ehHTcML+WMcAqlABvDw+FzG8z
 SOnLVx9nSxvDBmeNjEzc/c80fO3Q+MYxDx1KpAXrp2SYOsBav+bGMGBymZ/Sq6SNLPAU0Y0F4
 9MVikikvgSZgpU++aPaGnmtN8QnjsGeZ/ofzfTT11NZvyayg54DTW9oRsOuaZWF90ekvVNHe3
 IOhrjld7q6Y3Iy8AIu0EMrpBTcremcb9EeZX58RqdMj8leGY2xIx5+wawGrawsLJyjFsRdvlG
 n6HbRB/Z/84083IgyxvCvtwxvTn9gdBRidSARojYEw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the dtbs_check for imx generates warnings like this:

serial@7000c000: Unevaluated properties are not allowed
('clock-names', 'clocks', 'dma-names', 'dmas' were unexpected)

So add the missing properties to the devicetree binding.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/serial/fsl-imx-uart.yaml         | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml b/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
index 4cbe76e1715b..06f4b02b0550 100644
--- a/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
@@ -52,6 +52,24 @@ properties:
   interrupts:
     maxItems: 1
 
+  clocks:
+    items:
+      - description: ipg clock
+      - description: per clock
+
+  clock-names:
+    items:
+      - const: ipg
+      - const: per
+
+  dmas:
+    maxItems: 2
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
   fsl,dte-mode:
     $ref: /schemas/types.yaml#/definitions/flag
     description: |
@@ -87,11 +105,15 @@ required:
   - compatible
   - reg
   - interrupts
+  - clocks
+  - clock-names
 
 unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/clock/imx5-clock.h>
+
     aliases {
         serial0 = &uart1;
     };
@@ -100,6 +122,9 @@ examples:
         compatible = "fsl,imx51-uart", "fsl,imx21-uart";
         reg = <0x73fbc000 0x4000>;
         interrupts = <31>;
+        clocks = <&clks IMX5_CLK_UART1_IPG_GATE>,
+                 <&clks IMX5_CLK_UART1_PER_GATE>;
+        clock-names = "ipg", "per";
         uart-has-rtscts;
         fsl,dte-mode;
     };
-- 
2.34.1

