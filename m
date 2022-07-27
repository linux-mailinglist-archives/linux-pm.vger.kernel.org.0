Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5900A583494
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jul 2022 23:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236948AbiG0VGH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jul 2022 17:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236171AbiG0VFh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jul 2022 17:05:37 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0336361734
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 14:04:21 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id j29-20020a05600c1c1d00b003a2fdafdefbso103158wms.2
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 14:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y6LxKgZwFvrUFcWeNV79IxBK5DkuqAc3CHWOKwe+2Kg=;
        b=tt0p3JZs0R0yuNowL53kk0xbk0w405mj53mkIbORzj2xLwYuMy5+VEq6l9jlKCQvXj
         ZEKIkHGI10P2Jf0+DSTbKfMySQBy/7G9+Tn2rEG4b2E9WKaf3JFs6/+WV7KBU3EefAUX
         xJfuesqeCOzQmC9zupbLuq3df+h6ht4lYG/3pxGDvZsgHm7CRJzivXrF1Qe9nRK6cfix
         GyB3dkST/SYpKQ0LhF0iigtX3WmKlE9Lo4nSwhHVaxTtRlLuQAVKndYESRkC5FSS4BwB
         Q2QlAVMGc3L6ZXyMT+peyoiru5LJYuFr1fdIT5A0c4jlGprvw0A6M7ErbETVj+eASBa2
         SlYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y6LxKgZwFvrUFcWeNV79IxBK5DkuqAc3CHWOKwe+2Kg=;
        b=7wqgNhqaMpYNnJpP2BsbK2DTgiL0h2CV8EaM8qmmcOYJFWdIP6JX2X5FT4oTh/JoUe
         aoaZZMgW7UFgCmj61TuGqa6ajcpyg7TIS0nHYqqJ964chvbdZccnovr2QPacp6vxofV3
         D0++RO4bsxT7UX7UJYpVOPHrniDk9UZQcMiVvBXtBmq6Yfl7Iguw1bki3imYq4N+Gy8q
         oef3VwRrGrrp9EXId/x4bRdyHSQRZNpTZCT1bZP2+5BLohYgXpgz48f29mum6iugr2+H
         xsCtnMZHQaEKmVOXMELaBdoUPQatSd69IJzmJgFqogyKB1rMJdsm9LjSsM/WnoDhV5cS
         Rd1w==
X-Gm-Message-State: AJIora+fj/KqIDMw/JebfMigAGX/WbESrg5N3uUMoi0YL9fnoPi+5NPO
        lVrIdL0eXs6lcyrol4attyYoeA==
X-Google-Smtp-Source: AGRyM1vYhT9FJiimBpV4z6Y36atVM/ld+uOXwYfSFzmmX1rYJ38mj3c4jANmt5gaMqBEQXyqJ0EAFA==
X-Received: by 2002:a05:600c:3229:b0:3a3:7d7b:c621 with SMTP id r41-20020a05600c322900b003a37d7bc621mr2953587wmp.108.1658955860081;
        Wed, 27 Jul 2022 14:04:20 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:65a8:ebd8:4098:d9d0])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c350600b003a38606385esm37908wmq.3.2022.07.27.14.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 14:04:19 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com, broonie@kernel.org,
        damien.lemoal@opensource.wdc.com, heiko@sntech.de,
        hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
        talel@amazon.com, thierry.reding@gmail.com, digetx@gmail.com,
        jonathanh@nvidia.com, anarsoul@gmail.com, tiny.windzz@gmail.com,
        baolin.wang7@gmail.com, f.fainelli@gmail.com,
        bjorn.andersson@linaro.org, mcoquelin.stm32@gmail.com,
        glaroque@baylibre.com, miquel.raynal@bootlin.com,
        shawnguo@kernel.org, niklas.soderlund@ragnatech.se,
        matthias.bgg@gmail.com, j-keerthy@ti.com,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v3 29/32] regulator/drivers/max8976: Switch to new of thermal API
Date:   Wed, 27 Jul 2022 23:02:50 +0200
Message-Id: <20220727210253.3794069-30-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
References: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach. The ops are no longer device
tree specific and are the generic ones provided by the core code.

Convert the ops to the thermal_zone_device_ops format and use the new
API to register the thermal zone with these generic ops.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Acked-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max8973-regulator.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/max8973-regulator.c b/drivers/regulator/max8973-regulator.c
index cb7e50003f70..61211c462b1a 100644
--- a/drivers/regulator/max8973-regulator.c
+++ b/drivers/regulator/max8973-regulator.c
@@ -447,9 +447,9 @@ static int max8973_init_dcdc(struct max8973_chip *max,
 	return ret;
 }
 
-static int max8973_thermal_read_temp(void *data, int *temp)
+static int max8973_thermal_read_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct max8973_chip *mchip = data;
+	struct max8973_chip *mchip = tz->devdata;
 	unsigned int val;
 	int ret;
 
@@ -478,7 +478,7 @@ static irqreturn_t max8973_thermal_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static const struct thermal_zone_of_device_ops max77621_tz_ops = {
+static const struct thermal_zone_device_ops max77621_tz_ops = {
 	.get_temp = max8973_thermal_read_temp,
 };
 
@@ -492,8 +492,8 @@ static int max8973_thermal_init(struct max8973_chip *mchip)
 	if (mchip->id != MAX77621)
 		return 0;
 
-	tzd = devm_thermal_zone_of_sensor_register(mchip->dev, 0, mchip,
-						   &max77621_tz_ops);
+	tzd = devm_thermal_of_zone_register(mchip->dev, 0, mchip,
+					    &max77621_tz_ops);
 	if (IS_ERR(tzd)) {
 		ret = PTR_ERR(tzd);
 		dev_err(mchip->dev, "Failed to register thermal sensor: %d\n",
-- 
2.25.1

