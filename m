Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD8B2D6A4E
	for <lists+linux-pm@lfdr.de>; Thu, 10 Dec 2020 22:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404847AbgLJVmo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 16:42:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:38460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404885AbgLJV1T (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Dec 2020 16:27:19 -0500
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
Subject: [PATCH 09/18] ARM: dts: exynos: correct PMIC interrupt trigger level on Snow
Date:   Thu, 10 Dec 2020 22:25:25 +0100
Message-Id: <20201210212534.216197-9-krzk@kernel.org>
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

Fixes: c61248afa819 ("ARM: dts: Add max77686 RTC interrupt to cros5250-common")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5250-snow-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5250-snow-common.dtsi b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
index 6635f6184051..2335c4687349 100644
--- a/arch/arm/boot/dts/exynos5250-snow-common.dtsi
+++ b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
@@ -292,7 +292,7 @@ &i2c_0 {
 	max77686: pmic@9 {
 		compatible = "maxim,max77686";
 		interrupt-parent = <&gpx3>;
-		interrupts = <2 IRQ_TYPE_NONE>;
+		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&max77686_irq>;
 		wakeup-source;
-- 
2.25.1

