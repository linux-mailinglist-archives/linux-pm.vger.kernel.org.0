Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A388391DCD
	for <lists+linux-pm@lfdr.de>; Wed, 26 May 2021 19:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbhEZRW0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 May 2021 13:22:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36718 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbhEZRWY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 May 2021 13:22:24 -0400
Received: from mail-ua1-f69.google.com ([209.85.222.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1llxD9-0003Vz-Be
        for linux-pm@vger.kernel.org; Wed, 26 May 2021 17:20:51 +0000
Received: by mail-ua1-f69.google.com with SMTP id m11-20020a9f3fcb0000b029021dec910e95so1091833uaj.13
        for <linux-pm@vger.kernel.org>; Wed, 26 May 2021 10:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YMY2yvxHNG1nkzYJPg4/G4TbXbdFqsqs8hq2uBFV7DI=;
        b=JjQo5v1MaSlIM4bBwFYIrvE+kvZVnWFOp7WyDfR/hkSo1oOosrLjppS60eYNZPRJhe
         ni74/R8LQD92Rtay5qLcQvXWmqAzqJh7G3MS2IGr/FyZrUGlLjcTYAO+lsb38/l3U+tg
         JyjLviaAA5hZBWaefUQcEtv5Xd021tW1HMi9ntqtFaPdF/GQ6/lBfZrUYgx/nE6CNW5n
         3Dotf2eTdmU8y98Kz2N+lct2lgAePwyYEDd+qfxDLGNxeSAD8xYzrSi7vviaFJV7BRSx
         KQhihrP3gB/sv/RXJg3FBs2nkMskC0MaRojEN8qstP+KRqNhc5o0XJIJllVriRpIbdL8
         slPw==
X-Gm-Message-State: AOAM531n/sTilypNATr1sKhkLtNEEyjrMGuPpoRlVnmW29JQBCy+LZZm
        hfjbWKy44LPwIEdVP/uxAAslAvhOoooHyPbOsQp/0DXng+Jg3SfXiEkaaB/fCga7UJI5GWW3feM
        m4F9x15y+edv1Czl+CGVyTxbbGLV/OrMgDH7K
X-Received: by 2002:ab0:60c5:: with SMTP id g5mr33849452uam.5.1622049650413;
        Wed, 26 May 2021 10:20:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybUIvC2EVKiQpagnKWUZU70TWT6eIvSvzu8uRFmvzo4oT1pL7W1A2sY8ZZ5oe7mDhPI5A4nw==
X-Received: by 2002:ab0:60c5:: with SMTP id g5mr33849422uam.5.1622049650219;
        Wed, 26 May 2021 10:20:50 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.6])
        by smtp.gmail.com with ESMTPSA id u195sm2036032vsc.10.2021.05.26.10.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 10:20:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/7] mfd: max77686: Do not enforce (incorrect) interrupt trigger type
Date:   Wed, 26 May 2021 13:20:31 -0400
Message-Id: <20210526172036.183223-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210526172036.183223-1-krzysztof.kozlowski@canonical.com>
References: <20210526172036.183223-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

Interrupt line can be configured on different hardware in different way,
even inverted.  Therefore driver should not enforce specific trigger
type - edge falling - but instead rely on Devicetree to configure it.

The Maxim 77686 datasheet describes the interrupt line as active low
with a requirement of acknowledge from the CPU therefore the edge
falling is not correct.

The interrupt line is shared between PMIC and RTC driver, so using level
sensitive interrupt is here especially important to avoid races.  With
an edge configuration in case if first PMIC signals interrupt followed
shortly after by the RTC, the interrupt might not be yet cleared/acked
thus the second one would not be noticed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>

---

Changes since v1:
1. Add ack.
---
 Documentation/devicetree/bindings/clock/maxim,max77686.txt | 4 ++--
 Documentation/devicetree/bindings/mfd/max77686.txt         | 2 +-
 Documentation/devicetree/bindings/regulator/max77686.txt   | 2 +-
 drivers/mfd/max77686.c                                     | 3 +--
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/maxim,max77686.txt b/Documentation/devicetree/bindings/clock/maxim,max77686.txt
index 3472b461ca93..c10849efb444 100644
--- a/Documentation/devicetree/bindings/clock/maxim,max77686.txt
+++ b/Documentation/devicetree/bindings/clock/maxim,max77686.txt
@@ -49,7 +49,7 @@ Example:
 		max77686: max77686@9 {
 			compatible = "maxim,max77686";
 			interrupt-parent = <&wakeup_eint>;
-			interrupts = <26 0>;
+			interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
 			reg = <0x09>;
 			#clock-cells = <1>;
 
@@ -74,7 +74,7 @@ Example:
 		max77802: max77802@9 {
 			compatible = "maxim,max77802";
 			interrupt-parent = <&wakeup_eint>;
-			interrupts = <26 0>;
+			interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
 			reg = <0x09>;
 			#clock-cells = <1>;
 
diff --git a/Documentation/devicetree/bindings/mfd/max77686.txt b/Documentation/devicetree/bindings/mfd/max77686.txt
index 42968b7144e0..4447d074894a 100644
--- a/Documentation/devicetree/bindings/mfd/max77686.txt
+++ b/Documentation/devicetree/bindings/mfd/max77686.txt
@@ -21,6 +21,6 @@ Example:
 	max77686: pmic@9 {
 		compatible = "maxim,max77686";
 		interrupt-parent = <&wakeup_eint>;
-		interrupts = <26 0>;
+		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
 		reg = <0x09>;
 	};
diff --git a/Documentation/devicetree/bindings/regulator/max77686.txt b/Documentation/devicetree/bindings/regulator/max77686.txt
index e9f7578ca09a..ff3d2dec8c4b 100644
--- a/Documentation/devicetree/bindings/regulator/max77686.txt
+++ b/Documentation/devicetree/bindings/regulator/max77686.txt
@@ -43,7 +43,7 @@ Example:
 	max77686: pmic@9 {
 		compatible = "maxim,max77686";
 		interrupt-parent = <&wakeup_eint>;
-		interrupts = <26 IRQ_TYPE_NONE>;
+		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
 		reg = <0x09>;
 
 		voltage-regulators {
diff --git a/drivers/mfd/max77686.c b/drivers/mfd/max77686.c
index 2ad554b921d9..f9e12ab2bc75 100644
--- a/drivers/mfd/max77686.c
+++ b/drivers/mfd/max77686.c
@@ -209,8 +209,7 @@ static int max77686_i2c_probe(struct i2c_client *i2c)
 
 	ret = devm_regmap_add_irq_chip(&i2c->dev, max77686->regmap,
 				       max77686->irq,
-				       IRQF_TRIGGER_FALLING | IRQF_ONESHOT |
-				       IRQF_SHARED, 0, irq_chip,
+				       IRQF_ONESHOT | IRQF_SHARED, 0, irq_chip,
 				       &max77686->irq_data);
 	if (ret < 0) {
 		dev_err(&i2c->dev, "failed to add PMIC irq chip: %d\n", ret);
-- 
2.27.0

