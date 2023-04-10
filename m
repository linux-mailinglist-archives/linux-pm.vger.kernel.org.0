Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648A76DCC6A
	for <lists+linux-pm@lfdr.de>; Mon, 10 Apr 2023 22:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjDJU64 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Apr 2023 16:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjDJU64 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Apr 2023 16:58:56 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965F5E51;
        Mon, 10 Apr 2023 13:58:54 -0700 (PDT)
Received: from stefanw-SCHENKER ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N8GhM-1qPahk1zKi-014B00; Mon, 10 Apr 2023 22:58:24 +0200
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
        linux-pm@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V2 1/6] dt-bindings: serial: fsl-imx-uart: add missing properties
Date:   Mon, 10 Apr 2023 22:57:58 +0200
Message-Id: <20230410205803.45853-2-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230410205803.45853-1-stefan.wahren@i2se.com>
References: <20230410205803.45853-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MmUcvjf9uOErE5b5IeVHw9tVnV3GPVyP+Y37OrSM5Ev2cGimvJH
 BjEwYCBp9fRTAcENB120/qRudJC9p3XQiOPj2vY9heUIJBJcYXmmAPrH6FQKcc4VxYte3Aj
 AZFl/l+j2DtcRW8UVLN/wFo91/oek9btvROxtsqJ0FeQdX/iXqDVcvdP3aojaS5yxHzbUCh
 QRFPjENYex3/TZo6zw0uA==
UI-OutboundReport: notjunk:1;M01:P0:M+1Vqlhijp4=;gPb84vtx26d9cmsKLaNzISHZvfj
 vNN0+nZJaCgKGig14WZKL1y2hyi9RK6nN8iFbi1KIcUKHG1+h0xYikgtPPVlCRT/n0FowXXBT
 Ncy0W/eFvqfuoxIJoTvc22rr2WanCjEsqKiokNOboqsQ/ZBulaKqGtTtXYXOrK4hvSv0/CjOp
 uVVhTMgL7PSw+iN5diaf6igrGPCpLVeCxXcLthlTChfV+/DuA+A3Z1EQaeUQdti9kgOifkN0n
 vkcWkIFTOCR7JOxvj786php9jt6L4t41hsBg0eepDnY3Qu2RkQ2ZKDHnDeqgEezS9yM96g4Nr
 TX1t7TE1RpmGVt5T/5AqjqfosoGXEu+EF+d6f30v6VRMy8p61tGD1YzZqsYKNG7QwHo9HRUC3
 H6OlpGdYKj6i1eVCS3APLXsApdsnfeYRt91aal0BT5XaB7vhXJSAHx2ZGZzq0Sxipi8gdMp1h
 k4Z3eViNoJXmEV0gZu7k3IfqTubK4dGM0RX3zsLV0jkQhBMFH4XmsFrcYNBJ6qncoP7mXaYhb
 UGWyJmV4CkFAmVpmqKLZQxUFpa/rpr6IiANPuq5Bcz9BsSIZcd7HrOPOqKAVzqcdVdauCObgE
 E/dTYkFwz2InCL9Neqpx/ki8vpzLL2hg6syM6YcDfB3oJP9akZAOZ9JWyCZ6uIUsg7teRjCnq
 Xm3De+B8hhOWYDkT89cFddg2VjeF4rWp1s/kt7nylQ==
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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

