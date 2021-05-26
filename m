Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9053391DDF
	for <lists+linux-pm@lfdr.de>; Wed, 26 May 2021 19:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbhEZRWs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 May 2021 13:22:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36747 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbhEZRWa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 May 2021 13:22:30 -0400
Received: from mail-vs1-f69.google.com ([209.85.217.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1llxDF-0003Z2-7A
        for linux-pm@vger.kernel.org; Wed, 26 May 2021 17:20:57 +0000
Received: by mail-vs1-f69.google.com with SMTP id p14-20020a67e94e0000b029023fa53ce6e9so551106vso.14
        for <linux-pm@vger.kernel.org>; Wed, 26 May 2021 10:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YhVs5+yDO9h9on9x1DPcrehgvWwWuJdLjHq3isSOMC0=;
        b=dQOzEuJPyiZss0eKkhqojCujf+Jt6edVBwjbeubskhKhscKV/63QEeEkLvpk4oWZqC
         COOSMAmHC/A/8q8x8VbmzpksrdEIcjwfkJWr15nNSmTSWE7p73sFlsxpqehqcG1PSqm0
         L6OuZCMvVHkjMhp0z1ASN135nq+qd1MY5xTNDyMxP7DBb/iUC2wrYNopQjkKdlyVxVGS
         01PDSGzsNop7iwuWk9FXkckRO2A24mSY2jgca15n8fNRbLrvNOvrjRLsdwlPobf7GEiX
         SS26ObUY77i9L8ZRboF5Fe08dCyd9kNGpuviJFjv3j3iDHsQckrl0dCYEHgsfX16ISKr
         fwlg==
X-Gm-Message-State: AOAM531Peic8+OaBnj4KRxgZ9stSnegA24ShuSBEIeqlQfWQj1oROpGb
        PERtOjqU1E7LvlJpCs7E7wd0YqeQ7wiAeQVRU21zVeQqhwxb144SiqVftLN3wuxkmhJr01jD2x7
        9dFLn1V6n75T5VOMIABg+9GqJ/fN9Ogq+0MT9
X-Received: by 2002:ab0:6f02:: with SMTP id r2mr33618243uah.31.1622049656100;
        Wed, 26 May 2021 10:20:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznNGBF65KAS8chvjL6us7rire90bwMPPmSIuEwlY/ZA4rDNWqSgtKFauAvzClPt5u8qAAkJw==
X-Received: by 2002:ab0:6f02:: with SMTP id r2mr33618172uah.31.1622049655728;
        Wed, 26 May 2021 10:20:55 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.6])
        by smtp.gmail.com with ESMTPSA id u195sm2036032vsc.10.2021.05.26.10.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 10:20:55 -0700 (PDT)
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
Subject: [PATCH v2 4/7] mfd: max14577: Do not enforce (incorrect) interrupt trigger type
Date:   Wed, 26 May 2021 13:20:33 -0400
Message-Id: <20210526172036.183223-5-krzysztof.kozlowski@canonical.com>
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

The Maxim 14577/77836 datasheets describe the interrupt line as active
low with a requirement of acknowledge from the CPU therefore the edge
falling is not correct.

The interrupt line is shared between PMIC and charger driver, so using
level sensitive interrupt is here especially important to avoid races.
With an edge configuration in case if first PMIC signals interrupt
followed shortly after by the RTC, the interrupt might not be yet
cleared/acked thus the second one would not be noticed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>

---

Changes since v1:
1. Add Ack
---
 Documentation/devicetree/bindings/mfd/max14577.txt | 4 ++--
 drivers/mfd/max14577.c                             | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/max14577.txt b/Documentation/devicetree/bindings/mfd/max14577.txt
index 92070b346756..be11943a0560 100644
--- a/Documentation/devicetree/bindings/mfd/max14577.txt
+++ b/Documentation/devicetree/bindings/mfd/max14577.txt
@@ -71,7 +71,7 @@ max14577@25 {
 	compatible = "maxim,max14577";
 	reg = <0x25>;
 	interrupt-parent = <&gpx1>;
-	interrupts = <5 IRQ_TYPE_NONE>;
+	interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
 
 	muic: max14577-muic {
 		compatible = "maxim,max14577-muic";
@@ -106,7 +106,7 @@ max77836@25 {
 	compatible = "maxim,max77836";
 	reg = <0x25>;
 	interrupt-parent = <&gpx1>;
-	interrupts = <5 IRQ_TYPE_NONE>;
+	interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
 
 	muic: max77836-muic {
 		compatible = "maxim,max77836-muic";
diff --git a/drivers/mfd/max14577.c b/drivers/mfd/max14577.c
index be185e9d5f16..6c487fa14e9c 100644
--- a/drivers/mfd/max14577.c
+++ b/drivers/mfd/max14577.c
@@ -332,7 +332,7 @@ static int max77836_init(struct max14577 *max14577)
 	}
 
 	ret = regmap_add_irq_chip(max14577->regmap_pmic, max14577->irq,
-			IRQF_TRIGGER_FALLING | IRQF_ONESHOT | IRQF_SHARED,
+			IRQF_ONESHOT | IRQF_SHARED,
 			0, &max77836_pmic_irq_chip,
 			&max14577->irq_data_pmic);
 	if (ret != 0) {
@@ -418,14 +418,14 @@ static int max14577_i2c_probe(struct i2c_client *i2c,
 		irq_chip = &max77836_muic_irq_chip;
 		mfd_devs = max77836_devs;
 		mfd_devs_size = ARRAY_SIZE(max77836_devs);
-		irq_flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT | IRQF_SHARED;
+		irq_flags = IRQF_ONESHOT | IRQF_SHARED;
 		break;
 	case MAXIM_DEVICE_TYPE_MAX14577:
 	default:
 		irq_chip = &max14577_irq_chip;
 		mfd_devs = max14577_devs;
 		mfd_devs_size = ARRAY_SIZE(max14577_devs);
-		irq_flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
+		irq_flags = IRQF_ONESHOT;
 		break;
 	}
 
-- 
2.27.0

