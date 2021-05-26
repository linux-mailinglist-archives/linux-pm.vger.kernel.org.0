Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6218391DE5
	for <lists+linux-pm@lfdr.de>; Wed, 26 May 2021 19:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbhEZRXC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 May 2021 13:23:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36774 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234884AbhEZRWd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 May 2021 13:22:33 -0400
Received: from mail-vs1-f71.google.com ([209.85.217.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1llxDI-0003am-RK
        for linux-pm@vger.kernel.org; Wed, 26 May 2021 17:21:00 +0000
Received: by mail-vs1-f71.google.com with SMTP id y13-20020a67d20d0000b02902354e7b1beaso557913vsi.5
        for <linux-pm@vger.kernel.org>; Wed, 26 May 2021 10:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SNm8r3qL/2kiXiJIVKuFq4DIG33CzdI9IizzknKRELw=;
        b=Z+SURuAxnL/VwvWmlGnav5pdPz+cQUsz7GL7jBgg2RJ2ERuMFL/XKz6v7xQYVScg5k
         I27FUjL4J/dSYaVKkoItjmDdLCThvYj2Y9oSxcIIlaYQj83IjU0nCg4JavX/vU12dhvI
         Y8XTn7oM1a+E37ccJIgcTnBbd6o/BJFMEni/HOmSimyoUGGDC6w4ySWDY5tvuevC8MaS
         lLFniLkpc2yY5Vd48iz0dvvUAroZlpiSDL03xOSedWBhqeUByIuTtPbX1RDwk2Az+CA1
         ZyKne0v4UXlDBXOsW/Om73h/sIGkieidMYfwN8HCUzf43Znr77OaP7q8cN4FGousyrGo
         27Aw==
X-Gm-Message-State: AOAM530tJ7/cTUE6TSgkNTw0kwBPJzvWBCTrJ/+uw3dSr0HIhNpNESRU
        49Mp83U0fzN7gkTJPdXwlrqAJTTb9BKutb006kL80m/oofXtidjDA1vullViRvOCdJnE5aieXjB
        1jAMghIRyr/kh7OugljXJcUS3JI2qGWCVsLnK
X-Received: by 2002:ab0:6d8c:: with SMTP id m12mr21071472uah.49.1622049659956;
        Wed, 26 May 2021 10:20:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKbreCdzxPHok0y1tVuHyOgZULUrZT2VgOqfxTb2af4jPjxbiLuaf5zi62GiVO/GnTLXh37w==
X-Received: by 2002:ab0:6d8c:: with SMTP id m12mr21071448uah.49.1622049659760;
        Wed, 26 May 2021 10:20:59 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.6])
        by smtp.gmail.com with ESMTPSA id u195sm2036032vsc.10.2021.05.26.10.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 10:20:58 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 5/7] rtc: max77686: Do not enforce (incorrect) interrupt trigger type
Date:   Wed, 26 May 2021 13:20:34 -0400
Message-Id: <20210526172036.183223-6-krzysztof.kozlowski@canonical.com>
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

---

Changes since v1:
1. None
---
 drivers/rtc/rtc-max77686.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index d51cc12114cb..eae7cb9faf1e 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -717,8 +717,8 @@ static int max77686_init_rtc_regmap(struct max77686_rtc_info *info)
 
 add_rtc_irq:
 	ret = regmap_add_irq_chip(info->rtc_regmap, info->rtc_irq,
-				  IRQF_TRIGGER_FALLING | IRQF_ONESHOT |
-				  IRQF_SHARED, 0, info->drv_data->rtc_irq_chip,
+				  IRQF_ONESHOT | IRQF_SHARED,
+				  0, info->drv_data->rtc_irq_chip,
 				  &info->rtc_irq_data);
 	if (ret < 0) {
 		dev_err(info->dev, "Failed to add RTC irq chip: %d\n", ret);
-- 
2.27.0

