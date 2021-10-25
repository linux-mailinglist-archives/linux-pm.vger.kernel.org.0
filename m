Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C212C43992B
	for <lists+linux-pm@lfdr.de>; Mon, 25 Oct 2021 16:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbhJYOvO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Oct 2021 10:51:14 -0400
Received: from marcansoft.com ([212.63.210.85]:38708 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233591AbhJYOuf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 Oct 2021 10:50:35 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 5BD8541E57;
        Mon, 25 Oct 2021 14:48:06 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>
Subject: [PATCH v2 8/8] arm64: dts: apple: t8103: Add UART2
Date:   Mon, 25 Oct 2021 23:47:18 +0900
Message-Id: <20211025144718.157794-9-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025144718.157794-1-marcan@marcan.st>
References: <20211025144718.157794-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This UART is connected to the debug port of the WLAN module. It is
mostly useless, but makes for a good test case for runtime-pm without
having to unbind the console from the main system UART.

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 arch/arm64/boot/dts/apple/t8103-j274.dts |  5 +++++
 arch/arm64/boot/dts/apple/t8103.dtsi     | 12 ++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8103-j274.dts b/arch/arm64/boot/dts/apple/t8103-j274.dts
index e0f6775b9878..16c5eb7f53b1 100644
--- a/arch/arm64/boot/dts/apple/t8103-j274.dts
+++ b/arch/arm64/boot/dts/apple/t8103-j274.dts
@@ -17,6 +17,7 @@ / {
 
 	aliases {
 		serial0 = &serial0;
+		serial2 = &serial2;
 	};
 
 	chosen {
@@ -43,3 +44,7 @@ memory@800000000 {
 &serial0 {
 	status = "okay";
 };
+
+&serial2 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index 1d0fac1747c7..92f938a1ad3b 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -126,6 +126,18 @@ serial0: serial@235200000 {
 			status = "disabled";
 		};
 
+		serial2: serial@235208000 {
+			compatible = "apple,s5l-uart";
+			reg = <0x2 0x35208000 0x0 0x1000>;
+			reg-io-width = <4>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 607 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clkref>, <&clkref>;
+			clock-names = "uart", "clk_uart_baud0";
+			power-domains = <&ps_uart2>;
+			status = "disabled";
+		};
+
 		aic: interrupt-controller@23b100000 {
 			compatible = "apple,t8103-aic", "apple,aic";
 			#interrupt-cells = <3>;
-- 
2.33.0

