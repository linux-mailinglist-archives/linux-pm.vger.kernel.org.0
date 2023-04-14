Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10A36E1F1E
	for <lists+linux-pm@lfdr.de>; Fri, 14 Apr 2023 11:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjDNJUp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Apr 2023 05:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDNJUo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2023 05:20:44 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F5C59FF;
        Fri, 14 Apr 2023 02:20:43 -0700 (PDT)
Received: from stefanw-SCHENKER ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N8X9L-1qQnTW2gUL-014RZd; Fri, 14 Apr 2023 11:20:11 +0200
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
Subject: [PATCH V3 3/6] dt-bindings: imx-thermal: add imx6sll and imx6ul compatible
Date:   Fri, 14 Apr 2023 11:19:44 +0200
Message-Id: <20230414091947.7831-4-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414091947.7831-1-stefan.wahren@i2se.com>
References: <20230414091947.7831-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yhVLvdOtotpcDXG6lxpSO4LOeUKBcNbf9LpLbV/9MnR3OlD+Ttj
 GR5NmFY7sFWd/sGUYtTg1kiWDWMczU/jUX8FpwS83xxBWTX9d2I+6U7VQf9uYBU5BCDZdji
 cV26mP7jBSQRSF5Q+9D5LDaBf6UvEeLaKMhweNXe+fQeptU81b5JkN2R1Fqge3+A7hLi1Dg
 SoZwiewyvQCWZYEt0YoOQ==
UI-OutboundReport: notjunk:1;M01:P0:rDISmrQLwxc=;Ki/zD+XBOrmhx9wA7kHnYw5dyFg
 CH7yv0LZEQK0zsViWPmQVjJZOi4RYTTTJKmQB8xWtlZQAjme9vvifMGVnEEnRkogQ31gxtJMy
 d502Ff7m3gsCQDo2dYJBLqkhlGBgsUFtHu354fhi4gnS0TmgITYCU1FEEg3/7y4ghDLJnZDOI
 +gIAIYId+D3+GXgsG7pYSTJwYYMVswv0vHfroVnpyYE2I3pkMzltQtJBvH0v+Vu7Gswz1bfEb
 FONzLodS1ERhzl9KfDl8kuC4yMmNJJZiJlrx0e3u7gOZUm+FBRSPz80vGxD1ppXhf08xoiOry
 tzsohwwGEt/Q4jdgJtqDx1WZ4sUMRL6gwFfS99+IXYSB/yn4l3ZgPQdbKJwCoepg1P+X8i//J
 FpzRCO/IWsCnGMCcMcPZngQYHaqrg3k5qGkl36QnYfl+GYAsOzLGI589mhdmxfaOhRZH0zZN0
 32/XmSvi/dgoeAEcY0cjrsaGbjxxxe5PZ1VhaK87oIoytnw5gtcATKQF/c+j//HKESp1BeQVh
 USd/ULRvdZqIzvcbJuIVXw89vbr+k1e5iDkZ0z+qouiKV0YwqEQ6eg85BrWim6WKp5MNey739
 UdWV4U0h3ZSwRK+ytGKWJxZjJb51QYWmTk3R9GsR0btSbexk5/oYwqOxv34uGjWXVjQPO/rb8
 Sq8hWuOBUkfkbaQtXF1Oy2OQuz9c2tJyKKvYpKqM5Q==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the dtbs_check for imx6 generates warnings like this:

['fsl,imx6sll-tempmon', 'fsl,imx6sx-tempmon'] is too long

So add them to the devicetree binding.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/thermal/imx-thermal.yaml   | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.yaml b/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
index b22c8b59d5c7..8902e9499c96 100644
--- a/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
@@ -12,10 +12,16 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - fsl,imx6q-tempmon
-      - fsl,imx6sx-tempmon
-      - fsl,imx7d-tempmon
+    oneOf:
+      - enum:
+          - fsl,imx6q-tempmon
+          - fsl,imx6sx-tempmon
+          - fsl,imx7d-tempmon
+      - items:
+          - enum:
+              - fsl,imx6sll-tempmon
+              - fsl,imx6ul-tempmon
+          - const: fsl,imx6sx-tempmon
 
   interrupts:
     description: |
-- 
2.34.1

