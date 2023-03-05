Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177546AB320
	for <lists+linux-pm@lfdr.de>; Mon,  6 Mar 2023 00:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjCEXAC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Mar 2023 18:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjCEW7v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Mar 2023 17:59:51 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF159EB75;
        Sun,  5 Mar 2023 14:59:50 -0800 (PST)
Received: from stefanw-SCHENKER ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MnJZ4-1qG1Jo3YDE-00jLIX; Sun, 05 Mar 2023 23:59:32 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     linux-imx@nxp.com, Marek Vasut <marex@denx.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-crypto@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 1/6] dt-bindings: crypto: fsl-dcp: add imx6sl and imx6ull compatible
Date:   Sun,  5 Mar 2023 23:58:55 +0100
Message-Id: <20230305225901.7119-2-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230305225901.7119-1-stefan.wahren@i2se.com>
References: <20230305225901.7119-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:G3bGCGot+rVZxnY4Or+qVYy3i4Syg8T7FshWAbQbrs6JsjMp6Of
 xv95BletxPKhw6zcDz6AzE9wHkP+sg4/vi2xgptoNx+SE0dgMN9UvxGwQV9jrelmj4ZBAss
 S46IrE6ibcg2bX1upHAJkeghzi3vCV1R5ESC9Bz5huOy+x5tG4xVn9oz11cEQmxMRkv8AVk
 JTIlir4pGx/A6Bu+cfF8A==
UI-OutboundReport: notjunk:1;M01:P0:Fk4F8bjkPhs=;lzqEDGGtIQOlamGjzi+33bcwkGA
 L8vBATucy9eCIJQ8tG0fp4xhn9KoflmcM0oMQUWBWFMU0g+ObatzzE/MFzvswv9M/1HMTrj+S
 yRrerBXwOVr1CCsVBdka4yRMZrVqPwNRdjc58R9C0abgGvxXObNVQ7NyBRSx1bvVYk7RuZVZW
 +Udz2aVPwga2ng75nvmhmvEwoY3t3yU4G6dRTS3muFeFzT7fDKkcwTuAyycCh8fryVxlifSPR
 TWxfH4T+2VGw4j677yR5LV/QrbBxiX9MQv4igkOzIKJ3ECe5X5tph8CXBsO9orgsji2/RqR42
 tIOKrzBMR9UA/viQJBKpblQ6BsTgjXha2kC6Ex7YpOKynE5K85p33lhBXI/eMOu5CrHAJMqlD
 4CMboacSP85OdlOgo80l6+KyaSTVpTBOFYOdAd6m40HXdn5Lxz0NPgiD9Hv9pHrbxS66PutsR
 uuKQglWLt2Mbns1NOSlFOkOfSQkO1mzo2o0bvR3tvY/cq3IEhBxk5FRVxTKJOk2x4qrUg71NJ
 C2ZonutHlPZm2sWLx87TWg705dsK5duo4Bt/Bcki1TyJYvpWkbk/HsPNbOnmNUw/YusYyiY4p
 f7zmselFxcKN0YfHwCNsCu7974ckk5triZzRrYuq849E5LrD+Ftjx5EuSBcsgLj02BsR3UUay
 I0GQEWomoWkJ0RpAZ2NScO9V/6jFNqjcgZ1iR1gFzg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 Documentation/devicetree/bindings/crypto/fsl-dcp.yaml | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/fsl-dcp.yaml b/Documentation/devicetree/bindings/crypto/fsl-dcp.yaml
index 99be01539fcd..1695c4c58dc8 100644
--- a/Documentation/devicetree/bindings/crypto/fsl-dcp.yaml
+++ b/Documentation/devicetree/bindings/crypto/fsl-dcp.yaml
@@ -11,9 +11,14 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - fsl,imx23-dcp
-      - fsl,imx28-dcp
+    oneOf:
+      - const: fsl,imx23-dcp
+      - const: fsl,imx28-dcp
+      - items:
+          - enum:
+              - fsl,imx6sl-dcp
+              - fsl,imx6ull-dcp
+          - const: fsl,imx28-dcp
 
   reg:
     maxItems: 1
-- 
2.34.1

