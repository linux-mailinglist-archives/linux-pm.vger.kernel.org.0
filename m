Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095032D6A25
	for <lists+linux-pm@lfdr.de>; Thu, 10 Dec 2020 22:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404925AbgLJV1i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 16:27:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:38786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404919AbgLJV1g (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Dec 2020 16:27:36 -0500
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
Subject: [RFC 15/18] mfd: max77693: Do not enforce (incorrect) interrupt trigger type
Date:   Thu, 10 Dec 2020 22:25:31 +0100
Message-Id: <20201210212534.216197-15-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201210212534.216197-1-krzk@kernel.org>
References: <20201210212534.216197-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Interrupt line can be configured on different hardware in different way,
even inverted.  Therefore driver should not enforce specific trigger
type - edge falling - but instead rely on Devicetree to configure it.

The Maxim 77693 datasheet describes the interrupt line as active low
with a requirement of acknowledge from the CPU therefore the edge
falling is not correct.

The interrupt line is shared between PMIC and RTC driver, so using level
sensitive interrupt is here especially important to avoid races.  With
an edge configuration in case if first PMIC signals interrupt followed
shortly after by the RTC, the interrupt might not be yet cleared/acked
thus the second one would not be noticed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

This patch should wait till DTS changes are merged, as it relies on
proper Devicetree.
---
 Documentation/devicetree/bindings/mfd/max77693.txt |  2 +-
 drivers/mfd/max77693.c                             | 12 ++++--------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/max77693.txt b/Documentation/devicetree/bindings/mfd/max77693.txt
index 0ced96e16c16..1032df14498b 100644
--- a/Documentation/devicetree/bindings/mfd/max77693.txt
+++ b/Documentation/devicetree/bindings/mfd/max77693.txt
@@ -139,7 +139,7 @@ Example:
 		compatible = "maxim,max77693";
 		reg = <0x66>;
 		interrupt-parent = <&gpx1>;
-		interrupts = <5 2>;
+		interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
 
 		regulators {
 			esafeout@1 {
diff --git a/drivers/mfd/max77693.c b/drivers/mfd/max77693.c
index 596ed85cab3b..4e6244e17559 100644
--- a/drivers/mfd/max77693.c
+++ b/drivers/mfd/max77693.c
@@ -222,8 +222,7 @@ static int max77693_i2c_probe(struct i2c_client *i2c,
 	}
 
 	ret = regmap_add_irq_chip(max77693->regmap, max77693->irq,
-				IRQF_ONESHOT | IRQF_SHARED |
-				IRQF_TRIGGER_FALLING, 0,
+				IRQF_ONESHOT | IRQF_SHARED, 0,
 				&max77693_led_irq_chip,
 				&max77693->irq_data_led);
 	if (ret) {
@@ -232,8 +231,7 @@ static int max77693_i2c_probe(struct i2c_client *i2c,
 	}
 
 	ret = regmap_add_irq_chip(max77693->regmap, max77693->irq,
-				IRQF_ONESHOT | IRQF_SHARED |
-				IRQF_TRIGGER_FALLING, 0,
+				IRQF_ONESHOT | IRQF_SHARED, 0,
 				&max77693_topsys_irq_chip,
 				&max77693->irq_data_topsys);
 	if (ret) {
@@ -242,8 +240,7 @@ static int max77693_i2c_probe(struct i2c_client *i2c,
 	}
 
 	ret = regmap_add_irq_chip(max77693->regmap, max77693->irq,
-				IRQF_ONESHOT | IRQF_SHARED |
-				IRQF_TRIGGER_FALLING, 0,
+				IRQF_ONESHOT | IRQF_SHARED, 0,
 				&max77693_charger_irq_chip,
 				&max77693->irq_data_chg);
 	if (ret) {
@@ -252,8 +249,7 @@ static int max77693_i2c_probe(struct i2c_client *i2c,
 	}
 
 	ret = regmap_add_irq_chip(max77693->regmap_muic, max77693->irq,
-				IRQF_ONESHOT | IRQF_SHARED |
-				IRQF_TRIGGER_FALLING, 0,
+				IRQF_ONESHOT | IRQF_SHARED, 0,
 				&max77693_muic_irq_chip,
 				&max77693->irq_data_muic);
 	if (ret) {
-- 
2.25.1

