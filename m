Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDAC2D69DA
	for <lists+linux-pm@lfdr.de>; Thu, 10 Dec 2020 22:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404970AbgLJV2G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 16:28:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:38460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404944AbgLJV1l (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Dec 2020 16:27:41 -0500
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
Subject: [RFC 18/18] power: supply: max17040: Do not enforce (incorrect) interrupt trigger type
Date:   Thu, 10 Dec 2020 22:25:34 +0100
Message-Id: <20201210212534.216197-18-krzk@kernel.org>
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

The Maxim 14577/77836 datasheets describe the interrupt line as active
low with a requirement of acknowledge from the CPU therefore the edge
falling is not correct.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

This patch should wait till DTS changes are merged, as it relies on
proper Devicetree.
---
 .../devicetree/bindings/power/supply/max17040_battery.txt       | 2 +-
 drivers/power/supply/max17040_battery.c                         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
index c802f664b508..194eb9fe574d 100644
--- a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
@@ -39,7 +39,7 @@ Example:
 		reg = <0x36>;
 		maxim,alert-low-soc-level = <10>;
 		interrupt-parent = <&gpio7>;
-		interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
+		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 		wakeup-source;
 	};
 
diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index d956c67d5155..f737de0470de 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -367,7 +367,7 @@ static int max17040_enable_alert_irq(struct max17040_chip *chip)
 
 	flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
 	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
-					max17040_thread_handler, flags,
+					max17040_thread_handler, IRQF_ONESHOT,
 					chip->battery->desc->name, chip);
 
 	return ret;
-- 
2.25.1

