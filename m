Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0049D6E1F41
	for <lists+linux-pm@lfdr.de>; Fri, 14 Apr 2023 11:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjDNJ0O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Apr 2023 05:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjDNJ0N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2023 05:26:13 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF10210A;
        Fri, 14 Apr 2023 02:26:12 -0700 (PDT)
Received: from stefanw-SCHENKER ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MZk1p-1pt79P49MV-00WlRr; Fri, 14 Apr 2023 11:20:13 +0200
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
Subject: [PATCH V3 5/6] ARM: dts: imx: Adjust dma-apbh node name
Date:   Fri, 14 Apr 2023 11:19:46 +0200
Message-Id: <20230414091947.7831-6-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414091947.7831-1-stefan.wahren@i2se.com>
References: <20230414091947.7831-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NRNPh3BpQ+BjhLfRznBBdYdDO+A5MYq9E+lVY0pK1fteDl4SyQB
 dwLHhpgbQO2P6TOiH0edt4WnLckDaFf43cIoQMKhw4R5juOaL5oETxK5gbZIRCQdVysnKMH
 2iUGUnGxEm4pWVtgXRM33RA6dF4Bwk/beGd+O5Jsh9nFZxX+XkcFOGuQhxgamzg+tppfMzw
 k45kFQBd1Qx8DP2fVm0fA==
UI-OutboundReport: notjunk:1;M01:P0:JH8s12BWlLI=;sOuYv+jA6kqRGFy2YWPZ+tkdqm2
 hELifqDCje/aXXBZG7l/FtbTcTselvA/ABuSFqNwGmnf9h6k/C2lZCma7T6O18lcB1tV7Kdtl
 YkhrOs4HzfZK+NhbUn+gKGVjDNT5lPzyQplmHZPM1VB9tgQBPOfdKhs1QZLwVk7tppFeUApVb
 sFkIMwRIouZyPJhJnAP7ZBBiudpYUB5dQrBx34LyMFH99yMBXTYx4sjDPVi/Csbty2uI+6ZOW
 uGJXh2vI1Wet83Jxm+//IeDSYFUIN/ObNZTruNg4P5rBEjze502x1HKyWgIqhNPhHbbAavBif
 1Wzr6wYCMvlP64qH6WPPnGC0DGRjWCJ+2JuVVYEvsRIttPPf8AfwLC3J4lGPEqZBUvAP7FVCn
 C+U64AzULCTn1JPDq07KUHhw4m4Pp3ItwyJXdhKl/zba49UlwmfrBBcQfbVivtcXvxNMestiW
 Y2SuPlQ1YeWxAoRQUoZTCBhWu8PAW2LiJNuFiM8TYRVqiI3PWtYbhzHV/+dce/8GS82ZJdvOJ
 8K4IUjzg2m2l1XwQ+2zCX/vmjbbqjhkKDyg7KEAXzsg2WpaBNusU/kZ2zu4g1SIRX+IEVIN16
 zw68N1olDX5tAo0E9uEmr7bXPK7snnlMqj+NI0n5xJGA/S7oxcYQ+N0xYqoVFHNMjHMySSHkW
 w4Z9RW/zq8Vp+pUS32q7G1Iuvp67zDSzcc5+8q2sQQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index b72ec745f6d1..bda182edc589 100644
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
index 3d9d0f823568..118764c50d92 100644
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

