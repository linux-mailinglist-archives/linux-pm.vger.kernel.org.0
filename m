Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4209B6AB32B
	for <lists+linux-pm@lfdr.de>; Mon,  6 Mar 2023 00:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjCEXAG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Mar 2023 18:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjCEW7w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Mar 2023 17:59:52 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4654BEB60;
        Sun,  5 Mar 2023 14:59:51 -0800 (PST)
Received: from stefanw-SCHENKER ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mk0BK-1qJJdv0vRw-00kRl7; Sun, 05 Mar 2023 23:59:35 +0100
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
        Stefan Wahren <stefan.wahren@i2se.com>,
        Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH 6/6] ARM: dts: imx6ul: Add clock and PGC node to GDC
Date:   Sun,  5 Mar 2023 23:59:00 +0100
Message-Id: <20230305225901.7119-7-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230305225901.7119-1-stefan.wahren@i2se.com>
References: <20230305225901.7119-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NJNkRYg9OEO39KB+kz0xQwZi8gmdaBzK6GliDzYEcMK4rDbBEh9
 iYU+haJJArV4sTupFoZVHpCqWff8PrFD4FEpkSmp51+s1HKozaVBd6BoD0uU/FVVaey0c0Q
 pxvNZwSoXI9p6za7fLAL3hXv+MOCkSUpYJDNw4n0qXR8lJWqaYpkD8SDaplfiGidPBMyCUb
 B09GDUaikOjFVbOspbigA==
UI-OutboundReport: notjunk:1;M01:P0:Ha7rwpkNLZ0=;umHxw3Nmac2GL4jtjlHSMwvlP97
 b4nfil2FM7hRpwl1XEGkysDYghsHTHnuWxmHGsg7zroazY8QfSaK7luep6pZX0Aal8xD02dtn
 sbh67fcQpD9IJr+sBaT6oJakbPIVX/75VtxeK68xEYMn2yoWAbdmWf//BgLsFk2s0h6yQZmu8
 rfUVxCdvztzPdj3hvrT/QY5cPXYWUnJz2QTqicLxghcjM219lmt9Nv5gakmuKeipB44oAHi/q
 jnM5shBbzfc1TT9vcnDh9tJVHaTNl7avk4vt2udktVCBuAVzjwahyxijzjVFT24vNkl6DoBfb
 J7+WmIX94c28KYyjtTLQlIdfX48/3f9sXUqJ1V8o0MIfRfcfEGO4nQl/pA7TaZmRa9LrTdrk2
 l3jgtVZFytXI0t8nLA9Fu/C896IXXdSYQkTwpfT3waU0CEFEh+NcVE0TdQIo70ZRiAvybXwnU
 aOyx6Ej2WoPRF7TUpqOfpischP25kybueKBuZQ1gAOHEjzAK3WLMdYl38+06/aoJHXUxNkOHy
 DKTFa5VaRCi9pumlhTsvqLEBcGj2bUei9kjBLD0txAlTFoCDzJbRRSCQ7hQKOC3zcO/dwLCQ8
 W9pYlMJyB5amjgtMTU0Z58AfJ1SEEA13OissqNYFDold98gXSzQZ41j2kCd9YqlHsF2knsZry
 YTLZeLEEhj6b6xvyPGdBcEyD+gppUn1Pfbe37uhyug==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
index 412baa848837..fd6c064fa032 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -720,6 +720,18 @@ gpc: gpc@20dc000 {
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

