Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08236DCC72
	for <lists+linux-pm@lfdr.de>; Mon, 10 Apr 2023 22:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjDJU7I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Apr 2023 16:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjDJU7F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Apr 2023 16:59:05 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AD919AC;
        Mon, 10 Apr 2023 13:59:01 -0700 (PDT)
Received: from stefanw-SCHENKER ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mq33i-1q8c5J2ojK-00nCNa; Mon, 10 Apr 2023 22:58:27 +0200
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
        Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH V2 6/6] ARM: dts: imx6ul: Add clock and PGC node to GPC
Date:   Mon, 10 Apr 2023 22:58:03 +0200
Message-Id: <20230410205803.45853-7-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230410205803.45853-1-stefan.wahren@i2se.com>
References: <20230410205803.45853-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:WZWb9zy2e6xiV2Erw3KXRr3x/9eM39sIhOC1xwuV+9SfFMjKR5C
 wAEc10noMM6Rv6S1mfndJh0nrcRHq7I3BodHvQ3o6BIE4etPFTKIv2ll2YmLi5cP5YWWhaX
 WVSSlWl8qKZMujjt1WpaBH/hdvdKh9WVml/jPuy0vRluOtlQDIVSUGvkYppE7V1hhJmhC+N
 ULtuh4O+0a8xKs7cXXKkA==
UI-OutboundReport: notjunk:1;M01:P0:lJVF6llLldM=;wJzWl01m464IvovsGI/oyUDWGIc
 Mr2RZ4c2qJVIgSQuCkiZwGHQ77TCaYHpLTW89Y29PBQ0m9ZLL2BYWmKL9IVcRkMPXnZQy9Hzg
 EpLoopRfs/+0pbGWA2F0sTw+9gaRuBIizFU8k8QGZY7xpPn2UxFLYhxoaFQOU7hnUyQd2bW3Z
 EAjvkT1Qp/Sx1AT3Sx7UWv4dVIVlWSXPX/6DgHshpOz8LyGXSUytb/73SjtwgK9Fq1ErRFuv9
 unK6ywXlAgdA7U/VWN4rhPVjq6UjB4WK1mjGHvWGGm0Pv8METad21yokUBIQz5e7oJNxLRy+i
 tz1HysqsKVeIrQq0OvpnmGHBPm4YJNV37sYDuvYJRRHuy6MIq6lcA0a7+rpflo75QnQUU7hsZ
 3TxGQrBFqQzvNbA6IGy+UbJpIuyCxWuhq1ENkSPqvr+CjB0TUZ5MofoLX6wacTNcOu42CPS9Y
 t45HVyyLrQsfZvDsreXtVRoGsL+U/19fokT0GwSmSk7knJ0928pwMNryCuHWqnEC61cp95wk+
 EY/X4G8F4LLahwWUOi/M3/MgwDkQzlBDt+0FmoD9BVNRfmRgMl9s+pZ8AHiCb0duwOX/yjcIw
 0RIlJ3X3LKzQ9+Jhkjk4h/VvqzLiWJXV0pBq4VwH5BcA1H5Tw/5D0cf+Q82Dr3K/K1S8aPZ0a
 jDXEI3KO83hGDqhMo9NbgcwXLqKIGynXj+ngYqDu8w==
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

According to fsl,imx-gpc.yaml the General Power Control requires
a ipg clock and a Power Gating Control node. So add them to fix
the dtbs_check warnings on i.MX6UL boards:

gpc@20dc000: 'clocks' is a required property
gpc@20dc000: 'clock-names' is a required property
gpc@20dc000: 'pgc' is a required property

Suggested-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/imx6ul.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 118764c50d92..a8efaed69214 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -719,6 +719,18 @@ gpc: gpc@20dc000 {
 				#interrupt-cells = <3>;
 				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&intc>;
+				clocks = <&clks IMX6UL_CLK_IPG>;
+				clock-names = "ipg";
+
+				pgc {
+						#address-cells = <1>;
+						#size-cells = <0>;
+
+						power-domain@0 {
+							reg = <0>;
+							#power-domain-cells = <0>;
+						};
+				};
 			};
 
 			iomuxc: pinctrl@20e0000 {
-- 
2.34.1

