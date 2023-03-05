Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698226AB327
	for <lists+linux-pm@lfdr.de>; Mon,  6 Mar 2023 00:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjCEXAF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Mar 2023 18:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjCEW7w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Mar 2023 17:59:52 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D331041E;
        Sun,  5 Mar 2023 14:59:50 -0800 (PST)
Received: from stefanw-SCHENKER ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MNso2-1pxCH814Ho-00OE0T; Sun, 05 Mar 2023 23:59:34 +0100
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
Subject: [PATCH 4/6] ARM: dts: imx6ul: Fix second GPT compatible
Date:   Sun,  5 Mar 2023 23:58:58 +0100
Message-Id: <20230305225901.7119-5-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230305225901.7119-1-stefan.wahren@i2se.com>
References: <20230305225901.7119-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:FwwLBpPoq3keAJK7WAOh6jpSlvAluVqG3UFyirkwDd53+H+PmXN
 Fi1u5k61sMFrLcb3p1rD3WiyMyWjWW6sQjLqUDiFkBz3OjgE6/VY3rGgFsjPfZmw80Gjcgs
 M9HCLXahtOBnCBndgJO7Bv1rz3x0oYmUuorHR/qasleejZMpBUIIp0MHjwvb206NZ0ElE0D
 YHC8xEngkR3kP2GU/vQ+A==
UI-OutboundReport: notjunk:1;M01:P0:OslH39Jbv78=;QurxNe/i0wIVF3L+aUmAHTHAzBK
 vhS31PA8tO+D/+FZjurTcOpdLYvqzTzLmHvRSv/YsXhWprT3koR0lEI1xd4YV7/tC0UrEwPsP
 2/ULHGLkLR7gL/Zxs1X+FfBOMmZYSxCkqZ6I9LY9Id7GFPcMMpVX1FxuoCT2Z6EVBMwrgZm37
 ZoiAzV0MGqTxSUNDg9B6i58aMWblDm6N7zZKc/NFuEhz7rGEAYI1ml5BZAksYBeomWwGxGam8
 ONyeAz1UhgpEXIyyYBSpkPrsiX+fUsUYUlyTdUs9tecMCwZ1+Qfqi8rhhokdGH1ana25NCxXV
 Ce5wDWmZvNFNFiA8lxyE8U4tDQ4hzMYuVwu+LZaT5P9yq3Kk09v4LIpaDQdx22r7Pj0L1ljw3
 byv79I6i9O/RcHLQOQRUKd8oVPlVa7sYgYHb4NxwTSNKDpai1rVqs1vPOcW6PqWKN8DMpmSM6
 d2Z43pPaZW8abLw7ulVoTjdCe+PDSKCpFucONjRBC4i4RYdUOPCBe/5lKQvEsFJrnK0BpSMT2
 g4BDGVNC+JFsOqsnv+f59JKPJSOx774D1Tz7/7uVxHuL0hIB5eVWFRdFmbNdct/duhQliFqHN
 ah0PYXMjuXKshP3aGxF9nKbPrBk3ntM3nitDO8CvZzdSJCFS9DV4BrfJYHrOOan1CHRQiMR1G
 7ZeYAHc2eFFRAv48AYRJN8rQCrM2EdJSDxIO/T+YBg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

According to the imxgpt DT schema all i.MX6 GPT IP is
derived from imx6dl. So fix the imx6ul DTS accordingly
and avoid dtbs_check warnings.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/imx6ul.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index f0a9139748b8..65b2c6c131b3 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -448,7 +448,7 @@ can2: can@2094000 {
 			};
 
 			gpt1: timer@2098000 {
-				compatible = "fsl,imx6ul-gpt", "fsl,imx6sx-gpt";
+				compatible = "fsl,imx6ul-gpt", "fsl,imx6dl-gpt";
 				reg = <0x02098000 0x4000>;
 				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6UL_CLK_GPT1_BUS>,
@@ -734,7 +734,7 @@ gpr: iomuxc-gpr@20e4000 {
 			};
 
 			gpt2: timer@20e8000 {
-				compatible = "fsl,imx6ul-gpt", "fsl,imx6sx-gpt";
+				compatible = "fsl,imx6ul-gpt", "fsl,imx6dl-gpt";
 				reg = <0x020e8000 0x4000>;
 				interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6UL_CLK_GPT2_BUS>,
-- 
2.34.1

