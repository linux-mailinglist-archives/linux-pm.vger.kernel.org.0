Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322316E1F24
	for <lists+linux-pm@lfdr.de>; Fri, 14 Apr 2023 11:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjDNJUu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Apr 2023 05:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDNJUs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2023 05:20:48 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A0F5FDB;
        Fri, 14 Apr 2023 02:20:46 -0700 (PDT)
Received: from stefanw-SCHENKER ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N0WPK-1qawLR2nPI-00wRDM; Fri, 14 Apr 2023 11:20:13 +0200
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
Subject: [PATCH V3 6/6] ARM: dts: imx6ul: Add clock and PGC node to GPC
Date:   Fri, 14 Apr 2023 11:19:47 +0200
Message-Id: <20230414091947.7831-7-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414091947.7831-1-stefan.wahren@i2se.com>
References: <20230414091947.7831-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:evrJA8MM22+6SLfyF/L8UqSTqxmdsXKGyejbmw7WripfxHhfRjj
 AAumbvkax09UMWIBbsaBIjamNJ0EcWbWAL2NTojOlKK9g2ZrTK8YzhaLEb6c3oKKxUlCkt3
 CE2YdPhAlAZ30CpDhpqQatriy73Hc4MscF+Se6BqrgNtbLk1Hrm62+AD0mt6+jtTaBLjFJF
 ViueNyMZw1ps2eMh5YZ1Q==
UI-OutboundReport: notjunk:1;M01:P0:A18oXTTfw6Q=;TDAtKXytzyo3awLeAnBfcqEvlR0
 9pBZfLMvpWpxtIqkxrzQUKFAGoFNZOs2ptIHA0Q2xSRk5OTsmkZ/h4X+4TW190/QiCJHmR5Dq
 nzQMbmdzkF9+jt9+eh756iAt0kSIzgkWTZSoUMGcn6eQKSttO7lpb9XP2OPFsnURwujSfS/8r
 5/Tlm/7MJlh5qbrow4o5F1aK96NWTS3m+tLKZPeNfyh4w/+Bno5RVm/liwA4CIUsmE0NkNlW0
 i2gbVa4AqN73Bkj6jeI+hSGNwbYN5Sp/f4d+Uzfgctbi4Dva1th3hHWB97pvVc49Lh6UKsEDk
 /QWAgjZVHgR5ZWiT62W2yOkOW2Tqi8iBhajmgZrMjzPg/934wis7BRNfoktPW35BqZYQFhlLg
 I3FSelvslDYahmMRzFqIOA7Cz8VOf2O8PRT80YL1fFRJujM8ce1tv3eT6IldOc0OLtpaz9RLt
 zochIr7wgGSqe+lS+0xYxRTST9IC7OQe3/HcohEBoNxs0HXRDaJ77w5ekNMxUvIZwxmuPURsH
 e5Bd2a4HXodpCoELi7CLU9yvs8iqUDwBK96mi5zIryhlkeaFl8+vH6/hnByc6IfHR1jCdVv0Y
 jz+CJsQmb4viXWm99f6V6FLDel60RNOkHoGh9isKWwKR1resIjffTw32TpyuZd5vPkVtcaU+D
 VW4qa6pqHK2V50HyntLfHB5krkryOiweRI6wApMkXA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					power-domain@0 {
+						reg = <0>;
+						#power-domain-cells = <0>;
+					};
+				};
 			};
 
 			iomuxc: pinctrl@20e0000 {
-- 
2.34.1

