Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539756E1F2B
	for <lists+linux-pm@lfdr.de>; Fri, 14 Apr 2023 11:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjDNJU7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Apr 2023 05:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjDNJUt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2023 05:20:49 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AE176B3;
        Fri, 14 Apr 2023 02:20:47 -0700 (PDT)
Received: from stefanw-SCHENKER ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N1PLB-1qTYMD42zz-012p0R; Fri, 14 Apr 2023 11:20:11 +0200
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
Subject: [PATCH V3 2/6] dt-bindings: crypto: fsl-dcp: add imx6sl and imx6ull compatible
Date:   Fri, 14 Apr 2023 11:19:43 +0200
Message-Id: <20230414091947.7831-3-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414091947.7831-1-stefan.wahren@i2se.com>
References: <20230414091947.7831-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lkYmIKrsu5se5qvzrGx1mB5+kd2LraF0H8djqvuSD8kkSZBSPf7
 YCHAFHYGDyKCn99qTMv3XBxSCPWoRkA3Z1VGjyKbYIEf+6yu3X0uXWm1PXqdTij9nZoMEp9
 zRERCHxErwAcFjl6ijNXdxjU0qtPH9w9Wf3X8157GdgRF+dx8cPHnHqW3r7fBTwopu4LoSL
 tTrWwrfrooL6r2/Ib5Uyg==
UI-OutboundReport: notjunk:1;M01:P0:pEiDW3vTvy4=;HccE/kh9FnZuYSPGfPqb6p0COat
 fvkFl8CTKmE502V/rV1EzgjFGOMa9EYMFQuBynXvd+IVBovvJJJVzXtVfjPOMxAgF1hHdSGOe
 D6drzG4SnXKXWnpvpPxkJESB62c6ddZyqrctUuEkYvY/RcXOntCPe7XvvHLD+EiDKFqAMKVVl
 4JwLUzZLFU70TAKZrTKJsRay2mAnQAi7ZqlJQATjl4cPCbYxlGVKNQryLuV7TG39APZF30CZp
 XFtDUcJZc6T6OTHvfECvJXWCg+LW7QD0HJMoj4M+MlANkUFvqqgMCXUPkeSg580gb7C2XVolO
 HqUSKpT2nZI+dtWj/Cva90+F3u/2QZUY/8nJmLLd0EjH7ZchXBBfjyhDEqpIoHj8dFHITGaRT
 nLnLoa/fd/C88HaUIDZM4D9S3YjB6jUFkVINsvuu+iYGQKALHI15VqQ3hcVtqNREu2R+Vi9ng
 20Onq31mBnIdAlTSCHiAZsjwmMKX6K1Yy6+S0yzenKURf67jnGmvISXwUN7KaMTtbwcgF5DAm
 IV8mWLVDdyxZp3fBusIyJ6ptN9QlgU9SsE50Uqsr7EP1lkUpAmIMdrZlBoi8RSE0nrfJbABe6
 vVRCJ2xIJ7z35tQ0vpkQ0Sm3OWbgj/XmQIaxWhibqNAq61TsJ/q47CD+HPZDHmnYLNGXnCx2W
 RW7iAwPX4dh4NIOKRduZBDIR2+OdaEl9SnTMfqn90g==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the dtbs_check for imx6 generates warnings like this:

'fsl,imx6sl-dcp' is not one of ['fsl,imx23-dcp', 'fsl,imx28-dcp']
['fsl,imx6sl-dcp', 'fsl,imx28-dcp'] is too long

or

'fsl,imx6ull-dcp' is not one of ['fsl,imx23-dcp', 'fsl,imx28-dcp']
['fsl,imx6ull-dcp', 'fsl,imx28-dcp'] is too long

So add them to the devicetree binding.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/crypto/fsl-dcp.yaml          | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/fsl-dcp.yaml b/Documentation/devicetree/bindings/crypto/fsl-dcp.yaml
index 99be01539fcd..8dd36c2f76fd 100644
--- a/Documentation/devicetree/bindings/crypto/fsl-dcp.yaml
+++ b/Documentation/devicetree/bindings/crypto/fsl-dcp.yaml
@@ -11,9 +11,15 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - fsl,imx23-dcp
-      - fsl,imx28-dcp
+    oneOf:
+      - enum:
+          - fsl,imx23-dcp
+          - fsl,imx28-dcp
+      - items:
+          - enum:
+              - fsl,imx6sl-dcp
+              - fsl,imx6ull-dcp
+          - const: fsl,imx28-dcp
 
   reg:
     maxItems: 1
-- 
2.34.1

