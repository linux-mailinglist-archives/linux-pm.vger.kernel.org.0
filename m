Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82016AB325
	for <lists+linux-pm@lfdr.de>; Mon,  6 Mar 2023 00:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjCEXAD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Mar 2023 18:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjCEW7v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Mar 2023 17:59:51 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2901026B;
        Sun,  5 Mar 2023 14:59:50 -0800 (PST)
Received: from stefanw-SCHENKER ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N5VLY-1qfuhA35Ss-016wh5; Sun, 05 Mar 2023 23:59:34 +0100
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
Subject: [PATCH 5/6] ARM: dts: imx: Adjust dma-apbh node name
Date:   Sun,  5 Mar 2023 23:58:59 +0100
Message-Id: <20230305225901.7119-6-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230305225901.7119-1-stefan.wahren@i2se.com>
References: <20230305225901.7119-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2tkDkoVdpQ2dbABoVseCev+gvSjbPMEFYqrQjMuRrlEMLJ2JVhz
 P8Q+og2gUjvwxCFzyIgbtge3FE+xt3GgzlFSYGy0MCLJsJIWtzvQwSNC+HpD9D2zgXE2Mbu
 AEzj/NxzNULSJ2tiWVEv+mzN4rsmCNeIBIfkwUFJznoXQah+RhZ0/1zJA96R6Pjn4rkzKWo
 Z6vpO761FIKtmpLvOUc6w==
UI-OutboundReport: notjunk:1;M01:P0:ZLZnfpDLOcY=;19d3uOH504br4uTwjMeVOuyWOOB
 pu5q5OyGEdyyp2qrMKLqzsmNM3pjqOu0JZhSAvf0jtalW8kuQ7geDpN+yiYkRexEF9vRGDDWK
 L8KWW7Hu0RlfVTJNFChPtLVZbz/xWpVtTGxwKwxmbcLPs+RyWxZH9I4Gw2tUzWPekDD5bqMof
 pzZ42s1xP/LbgY8VytVt6OUG7dZ5NR+4cASMqf1ihHNWFU0WoaPo8xUs1ZqK+AOb39dW8N/YP
 V9562UY9yjpyMrpvQQOXKRvqz3v1eJrvGhmBocLnlA7DGNb+fziXMG2o7a5W7bZIiPIro/nlC
 G1WPS/X1o0NMaqrNkcUsiRHbaou5IkccPMbvlvYkO7bTRKUZ3ki59QhdxZFn1lOUENuxG/wh1
 IBTp47ynRPD+2YsOfP4dR0wM5kx95ztKAL0HN/WYOgn2vYyOn8h9WEI4WRI4bf9IXdbSqFdcG
 /j2WQbFLlJXcuJdhONrdWz95FRLwTwnYZvc7Iq9jJAAH5rSzEHUvVys7ZADB744zH1jm2WqIE
 sNwbDkWZEFr73iPZZesU1JT72Gi0+suD0XSu/M6VmvdScl9BKw5ceIc4CZN55pjbWWxdfomVT
 lvMXfFLGpWie+Imz8kuKspO1Ha3Oo+yfuaQJgB5Ru4mc5fn988sMf4q21QQiIT7SMg8IMaERt
 c4Z1P9cdzJM5oB3tR67SAoGM0HV2LcOtxv5mqg2uew==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the dtbs_check generates warnings like this:

$nodename:0: 'dma-apbh@110000' does not match '^dma-controller(@.*)?$'

So fix all affected dma-apbh node names.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/imx23.dtsi   | 2 +-
 arch/arm/boot/dts/imx28.dtsi   | 2 +-
 arch/arm/boot/dts/imx6qdl.dtsi | 2 +-
 arch/arm/boot/dts/imx6sx.dtsi  | 2 +-
 arch/arm/boot/dts/imx6ul.dtsi  | 2 +-
 arch/arm/boot/dts/imx7s.dtsi   | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index d19508c8f9ed..a3668a0827fc 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -59,7 +59,7 @@ icoll: interrupt-controller@80000000 {
 				reg = <0x80000000 0x2000>;
 			};
 
-			dma_apbh: dma-apbh@80004000 {
+			dma_apbh: dma-controller@80004000 {
 				compatible = "fsl,imx23-dma-apbh";
 				reg = <0x80004000 0x2000>;
 				interrupts = <0 14 20 0
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index a8d3c3113e0f..29e37b1fae66 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -78,7 +78,7 @@ hsadc: hsadc@80002000 {
 				status = "disabled";
 			};
 
-			dma_apbh: dma-apbh@80004000 {
+			dma_apbh: dma-controller@80004000 {
 				compatible = "fsl,imx28-dma-apbh";
 				reg = <0x80004000 0x2000>;
 				interrupts = <82 83 84 85
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 41e08fa23cce..6571f8a1553d 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -150,7 +150,7 @@ soc: soc {
 		interrupt-parent = <&gpc>;
 		ranges;
 
-		dma_apbh: dma-apbh@110000 {
+		dma_apbh: dma-controller@110000 {
 			compatible = "fsl,imx6q-dma-apbh", "fsl,imx28-dma-apbh";
 			reg = <0x00110000 0x2000>;
 			interrupts = <0 13 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 93ac2380ca1e..4233943a1cca 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -209,7 +209,7 @@ gpu: gpu@1800000 {
 			power-domains = <&pd_pu>;
 		};
 
-		dma_apbh: dma-apbh@1804000 {
+		dma_apbh: dma-controller@1804000 {
 			compatible = "fsl,imx6sx-dma-apbh", "fsl,imx28-dma-apbh";
 			reg = <0x01804000 0x2000>;
 			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 65b2c6c131b3..412baa848837 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -164,7 +164,7 @@ intc: interrupt-controller@a01000 {
 			      <0x00a06000 0x2000>;
 		};
 
-		dma_apbh: dma-apbh@1804000 {
+		dma_apbh: dma-controller@1804000 {
 			compatible = "fsl,imx6q-dma-apbh", "fsl,imx28-dma-apbh";
 			reg = <0x01804000 0x2000>;
 			interrupts = <0 13 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index efe2525b62fa..54026c2c93fa 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -1257,7 +1257,7 @@ fec1: ethernet@30be0000 {
 			};
 		};
 
-		dma_apbh: dma-apbh@33000000 {
+		dma_apbh: dma-controller@33000000 {
 			compatible = "fsl,imx7d-dma-apbh", "fsl,imx28-dma-apbh";
 			reg = <0x33000000 0x2000>;
 			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.34.1

