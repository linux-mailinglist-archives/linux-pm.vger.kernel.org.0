Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847382D69C1
	for <lists+linux-pm@lfdr.de>; Thu, 10 Dec 2020 22:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404870AbgLJV0s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 16:26:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:38092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404864AbgLJV0r (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Dec 2020 16:26:47 -0500
From:   Krzysztof Kozlowski <krzk@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-rtc@vger.kernel.org
Cc:     Iskren Chernev <iskren.chernev@gmail.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Angus Ainslie <angus@akkea.ca>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 05/18] ARM: dts: exynos: correct PMIC interrupt trigger level on Midas family
Date:   Thu, 10 Dec 2020 22:25:21 +0100
Message-Id: <20201210212534.216197-5-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201210212534.216197-1-krzk@kernel.org>
References: <20201210212534.216197-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Maxim PMIC datasheets describe the interrupt line as active low
with a requirement of acknowledge from the CPU.  Without specifying the
interrupt type in Devicetree, kernel might apply some fixed
configuration, not necessarily working for this hardware.

Additionally, the interrupt line is shared so using level sensitive
interrupt is here especially important to avoid races.

Fixes: 15dfdfad2d4a ("ARM: dts: Add basic dts for Exynos4412-based Trats 2 board")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4412-midas.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
index d75f554efde0..fc77c1bfd844 100644
--- a/arch/arm/boot/dts/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
@@ -665,7 +665,7 @@ &i2c_7 {
 	max77686: pmic@9 {
 		compatible = "maxim,max77686";
 		interrupt-parent = <&gpx0>;
-		interrupts = <7 IRQ_TYPE_NONE>;
+		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-0 = <&max77686_irq>;
 		pinctrl-names = "default";
 		reg = <0x09>;
-- 
2.25.1

