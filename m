Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E566DCC6F
	for <lists+linux-pm@lfdr.de>; Mon, 10 Apr 2023 22:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjDJU66 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Apr 2023 16:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjDJU64 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Apr 2023 16:58:56 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B26E6F;
        Mon, 10 Apr 2023 13:58:55 -0700 (PDT)
Received: from stefanw-SCHENKER ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MlwJv-1qDJ3K0TsR-00j5dn; Mon, 10 Apr 2023 22:58:25 +0200
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
Subject: [PATCH V2 2/6] dt-bindings: crypto: fsl-dcp: add imx6sl and imx6ull compatible
Date:   Mon, 10 Apr 2023 22:57:59 +0200
Message-Id: <20230410205803.45853-3-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230410205803.45853-1-stefan.wahren@i2se.com>
References: <20230410205803.45853-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:u4UCiJkTnoSzdaA3kq33v+s/Pi1vopzInEGk01LNGa+mKCiScvd
 y165hMXMv0tjOC6jUzkbAG3kGIj24s7q8e3etyYqgt7COomH2Q/CZCWDD12B4MEnTskbY5G
 D8faRUTtU2l3pO8II9uZJjLIkz/RbZUqkn5gF9V+fSaIlWupGzn88cUBcuTI+poCo4gaoKH
 RKR5Dj/Wf57UwjIeklo4g==
UI-OutboundReport: notjunk:1;M01:P0:+uG4vE/bgsA=;4t/3vismX//bq75J5wiQHANcPzt
 bBmsDvFYUbaH2USTbaQpZdbpV2XSpuywitpRLQ1OL1MN6i5qJD065KqLF5bcwNH/jKTqvWt8Z
 QtwjQSwsmvyE98AFy5OSEJ6ofcoTq3exO7rPMeozndW+hPIFRgJRFInKNXZOgOKvuWeUtgJSZ
 vR/bpPTe3i2MRkJmmVZgxvB0+RyT/tRjaZlRKOpnXscgIauKHcWQMIFG01RqyIj0eN/MNdk/u
 W9yL+0DyJ2n5jlpoJMZ4NI989JV3VV40TzdWoVYMt0f27SWkPxFq2e2wTiJ8Um42o+i96WgnK
 SLjDCMxGYAZ0EyDWxvLLZL9JsfQSmK8wJJTr6bEkMEq/UwzLivMxXzVFVjxvHBO+AhGgxr1G4
 +EBnRDMVkzF0eYlXHwA/Mh/eaHzqpihuqIaAnkscJXymtQQfTboGGSRaOmJz9ydBVFQ5HRKpl
 z+BCdC2CQGBOs6ZP/TJHPJ8A7+K8VmG7B4fem0mUXAZav3sHjS+Y73V0jHxsFnP+IwnHykpOJ
 3yRUURSn0pF4IUtQVTJLHmGTXXKQr8WL09fM5Mdl0JdulLQZ0OIcCNNJI36kwqj10jt4stn4j
 A8xBvHG0DOXsezjdQgiS0ffAQ42xdRxIE4hnQq8PzKux+Cum3pqyXiDaa149XEzX9h/7T4Xjh
 e8vTOd4uXZhVldFrfhys0ogyLEmfVbJWTUvaZ5h7Cg==
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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

