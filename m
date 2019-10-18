Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8A1DC932
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 17:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505181AbfJRPmm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 11:42:42 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:51121 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505167AbfJRPmk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 11:42:40 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mq2rM-1hiK9j1L1e-00n5fL; Fri, 18 Oct 2019 17:42:33 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH 39/46] power: tosa: simplify probe function
Date:   Fri, 18 Oct 2019 17:41:54 +0200
Message-Id: <20191018154201.1276638-39-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191018154052.1276506-1-arnd@arndb.de>
References: <20191018154052.1276506-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hl7BVkd0yWFJrOmiZHbeobrWCSoJQ+ScQbAwl6PsnGpuJOJIEHu
 W0QV/e5+JWq7TsLgc2PtBEnls5NuarY449LGFoJViTSJWvMdHcLlMDX2XoWwFZEcbYPI5WZ
 TdOdhaetEZ7yT8ULxFUd+U0PpVPf/ceYiuCvUo7SyrqiG5srZ7uqgbND4fJK/5Lkt+TFsTD
 40f6kuITqgYxlt9LHI6UQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:H4Ylysjy0ZA=:/XEzK/9RniR7YFlZoEyvOt
 96k2I0vU6eFeQVYNinRZYLqMtbg2Zj3rAQyQGnOHBs5u+TB+8sRWhVmJUdvbPrx8+i9jhXxCa
 cux8jIgrcfoGgiVR6hzJQ6XSCkrVw+f63GS8MXKzgu/KDRmHn+IVrCd/fvzEpKw8zW3Xy8AYl
 6nY4dEbC9HxJ8XyC4ueDhKV7gZOE+plXzxxtAy01EeW/ip8d0apUcP9fnPKiNsv0RkAa2hUA3
 eeiKt5kZ2hiCv912MsTwG/rWA0kw47V9mr2FdA/yLy9Ib+Xe4hqPFgHzSlu5aMBm4rJYSOYUU
 Ufn5VqBmUuwUkgDtn2PLMzwRt8Ed4z0LgxO+QXZGIpgxIeV+jtxBXNquKQHq0Ul5IrQ9sZik8
 mRVvKqm1SOknx18e/pj/6I8uCfwaa+A0KA+iKP0kV5Yrjd6XmlAp49azsORHHnDByVUC/yf9x
 EEgrc9tI9Axi5IHvUcCYwhgkijFLu8xgiXAbvsQuSlALU/QSjPatNYqXiZ5Ax+0ucplamJd2G
 81jEcjedwI+C4nr8ELmgS93/M5QldzfaizY3neyNehWGgJOKieaJyUmwBBL8dwEauT54HsvH/
 u1+1jCkw1CCq4yUZn3fwV/ywmTttv9TfeYXlj1tE9dAkp19dOQhmw8sSPt1aPq+jQe1W2IRN5
 oQLZMuDv6cNAldguZPFT+8gjHn/w8hqf/0WP63uJ0l33g32WBLUCxEH82OtVBaSU9BXRYoeJh
 nfxJr+55wQNqDBa2UfH3ccIHTo7sEoRuG2Zl5dA9xiYnJDgneAxAoINw1wy5S/8r/AmkA31Gk
 yFfFbUaXdiJS8WT0H2tVEaW6xyOc0+EcuV7zwq7+0PX/PEzKDk1u/p/TAir1FIPGtgX3w7iq1
 0VQp6qh9uRbkEH8o4DZA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We have three power supplies that need similar initialization.
As a preparation for the gpio lookup table conversion, split
out the initialization into a separate function.

Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/power/supply/tosa_battery.c | 50 ++++++++++++++---------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/power/supply/tosa_battery.c b/drivers/power/supply/tosa_battery.c
index 32cc31cd4761..b26b0eca33e1 100644
--- a/drivers/power/supply/tosa_battery.c
+++ b/drivers/power/supply/tosa_battery.c
@@ -343,12 +343,24 @@ static int tosa_bat_resume(struct platform_device *dev)
 #define tosa_bat_resume NULL
 #endif
 
+static int tosa_power_supply_register(struct device *dev,
+			struct tosa_bat *bat,
+			const struct power_supply_desc *desc)
+{
+	struct power_supply_config cfg = {
+		.drv_data = bat,
+	};
+
+	mutex_init(&bat->work_lock);
+	bat->psy = power_supply_register(dev, desc, &cfg);
+
+	return PTR_ERR_OR_ZERO(bat->psy);
+}
+
+
 static int tosa_bat_probe(struct platform_device *dev)
 {
 	int ret;
-	struct power_supply_config main_psy_cfg = {},
-				   jacket_psy_cfg = {},
-				   bu_psy_cfg = {};
 
 	if (!machine_is_tosa())
 		return -ENODEV;
@@ -357,36 +369,22 @@ static int tosa_bat_probe(struct platform_device *dev)
 	if (ret)
 		return ret;
 
-	mutex_init(&tosa_bat_main.work_lock);
-	mutex_init(&tosa_bat_jacket.work_lock);
-
 	INIT_WORK(&bat_work, tosa_bat_work);
 
-	main_psy_cfg.drv_data = &tosa_bat_main;
-	tosa_bat_main.psy = power_supply_register(&dev->dev,
-						  &tosa_bat_main_desc,
-						  &main_psy_cfg);
-	if (IS_ERR(tosa_bat_main.psy)) {
-		ret = PTR_ERR(tosa_bat_main.psy);
+	ret = tosa_power_supply_register(&dev->dev, &tosa_bat_main,
+					 &tosa_bat_main_desc);
+	if (ret)
 		goto err_psy_reg_main;
-	}
 
-	jacket_psy_cfg.drv_data = &tosa_bat_jacket;
-	tosa_bat_jacket.psy = power_supply_register(&dev->dev,
-						    &tosa_bat_jacket_desc,
-						    &jacket_psy_cfg);
-	if (IS_ERR(tosa_bat_jacket.psy)) {
-		ret = PTR_ERR(tosa_bat_jacket.psy);
+	ret = tosa_power_supply_register(&dev->dev, &tosa_bat_jacket,
+					 &tosa_bat_jacket_desc);
+	if (ret)
 		goto err_psy_reg_jacket;
-	}
 
-	bu_psy_cfg.drv_data = &tosa_bat_bu;
-	tosa_bat_bu.psy = power_supply_register(&dev->dev, &tosa_bat_bu_desc,
-						&bu_psy_cfg);
-	if (IS_ERR(tosa_bat_bu.psy)) {
-		ret = PTR_ERR(tosa_bat_bu.psy);
+	ret = tosa_power_supply_register(&dev->dev, &tosa_bat_bu,
+					 &tosa_bat_bu_desc);
+	if (ret)
 		goto err_psy_reg_bu;
-	}
 
 	ret = request_irq(gpio_to_irq(TOSA_GPIO_BAT0_CRG),
 				tosa_bat_gpio_isr,
-- 
2.20.0

