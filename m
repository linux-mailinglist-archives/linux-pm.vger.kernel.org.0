Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30696DCC76
	for <lists+linux-pm@lfdr.de>; Mon, 10 Apr 2023 22:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjDJU7I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Apr 2023 16:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjDJU7F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Apr 2023 16:59:05 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7521BE8;
        Mon, 10 Apr 2023 13:59:01 -0700 (PDT)
Received: from stefanw-SCHENKER ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MBUVj-1pf4AQ2zol-00D3Ct; Mon, 10 Apr 2023 22:58:25 +0200
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
Subject: [PATCH V2 3/6] dt-bindings: imx-thermal: add imx6sll and imx6ul compatible
Date:   Mon, 10 Apr 2023 22:58:00 +0200
Message-Id: <20230410205803.45853-4-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230410205803.45853-1-stefan.wahren@i2se.com>
References: <20230410205803.45853-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8dNgJ+ctAsZfATtczzCYJdQw0jbKXFJ5ntlgxYBGKZMhVqbUsbD
 btpJGg0y32cTDTIOW2j26MrZXuBmy1pLfqiBrEU41knHxGXpk28uVuVBOrQyzs1wyg2jZJV
 7ekOWa19ilga3RdzDH4sv0GvJ95Fo9PwiAG2JeCksPGYB72g2E2eaMmcXVnybKESbsWLFBH
 SzEGYE5qQNuzYpJUvjmpw==
UI-OutboundReport: notjunk:1;M01:P0:fy84CBLQy68=;jglXnytI3pSsomz7TWhCAfdrXzq
 IVg4HEw6SRSdHFZWV5Qc1z3cFXaoV0VBQelwd3a3xZklwO05gdhPHMbBDQ56iL0uKbsAOi/wA
 pYQ/W4ikkopjCXsOMv6LhTDypZqi0dzct5isH0y2izPK31XEQpAEfUnETD3U6lfcTmiMBvkVN
 KhMWe0xi7UdydRjOhu9DWYjLTgY9rNcFVCTkVvXmi9FSVZkHuVPQU4flZWlA4PAp9R5R2hnI2
 ZFPPCISKWn4hsfIanhxFjeJXLqrnxbHK7a3xf63yIASCRcMLFCD+Tatx5bGBnQrVjU04EgBh1
 P1s9wWVcwu2XaGr6WLgSXXbb303Suf5UqVvQoFXaqb0SOPJn/EKn1gnLj8Uq513WjuAEwMPCo
 9GHiEW3sxHA8dhcUOU8IQNWhTb31YvXd9JkPE/YKekC0V5n7MnLk8uclXktdjiXiEzV4oBe+w
 Asly3D+Rwa6z+mDZLA+idMjo4vkCM+AlgGYonBaprpalIXceTQ1cJxE/kTefFBvYdBKRnETNH
 aJ6mPsf/inSRaFaekoR74d34rTJf9+2Gcw6sS3yDlKyuLc6gofmzwfPjeKTrf/Sm2+fW5G0oJ
 L6sp7WAa9Eu0XBJG1IVCwBT9VPj+m/C3Yxnm2gflj+L3lgjzJ4vlRq7hhRgnesczVmed9DNtU
 jJNGBXh4WwYthUbCFiizURcATcrAAjUKdCLACdhjYQ==
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the dtbs_check for imx6 generates warnings like this:

['fsl,imx6sll-tempmon', 'fsl,imx6sx-tempmon'] is too long

So add them to the devicetree binding.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
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

