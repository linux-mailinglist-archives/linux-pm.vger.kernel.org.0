Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C224B439916
	for <lists+linux-pm@lfdr.de>; Mon, 25 Oct 2021 16:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbhJYOuZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Oct 2021 10:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbhJYOuT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Oct 2021 10:50:19 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B33C061225;
        Mon, 25 Oct 2021 07:47:56 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 48AEF42181;
        Mon, 25 Oct 2021 14:47:50 +0000 (UTC)
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
Subject: [PATCH v2 5/8] arm64: dts: apple: t8103: Rename clk24 to clkref
Date:   Mon, 25 Oct 2021 23:47:15 +0900
Message-Id: <20211025144718.157794-6-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025144718.157794-1-marcan@marcan.st>
References: <20211025144718.157794-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We now know that this frequency comes from the external reference
oscillator and is used for various SoC blocks, and isn't just a random
24MHz clock, so let's call it something more appropriate.

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 arch/arm64/boot/dts/apple/t8103.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index a1e22a2ea2e5..9f60f9e48ea0 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -95,11 +95,11 @@ timer {
 			     <AIC_FIQ AIC_TMR_HV_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	clk24: clock-24m {
+	clkref: clock-ref {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <24000000>;
-		clock-output-names = "clk24";
+		clock-output-names = "clkref";
 	};
 
 	soc {
@@ -120,7 +120,7 @@ serial0: serial@235200000 {
 			 * TODO: figure out the clocking properly, there may
 			 * be a third selectable clock.
 			 */
-			clocks = <&clk24>, <&clk24>;
+			clocks = <&clkref>, <&clkref>;
 			clock-names = "uart", "clk_uart_baud0";
 			status = "disabled";
 		};
-- 
2.33.0

