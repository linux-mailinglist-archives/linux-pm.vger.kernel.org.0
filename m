Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A05B3018A7
	for <lists+linux-pm@lfdr.de>; Sat, 23 Jan 2021 23:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbhAWWUE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 23 Jan 2021 17:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbhAWWUD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 23 Jan 2021 17:20:03 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04FAC06178B
        for <linux-pm@vger.kernel.org>; Sat, 23 Jan 2021 14:19:22 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id q8so12556665lfm.10
        for <linux-pm@vger.kernel.org>; Sat, 23 Jan 2021 14:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w3IZh6Sr3KpjXM0LqFQFqH1i8vaQmDVN35tRH7/mbAU=;
        b=Pel+8Yp8fo5WhTw+yETNHp9WPuCEQufhXwbqQa7SsblscnjE91i15m2h0/YN/sAz7e
         uTCfOWnOQy0zSjJHGhKPgaoQClVC35lJHLYWN1na5G8SnTD6hvvj/3wMrUnPclqY7lNi
         QbI+j01ssiMQBnD4KUbwznLjPfGw08sREh4pjx7wlMUGXkrPwvgABXqFVGQFKqzZgFh6
         3b+3cR3Nq2Mq1cYmajnxgMA2qN69Moxtx0G1rfSJERgKKt3gtLuaXze8vVGwspudYnSl
         GbwSUnQec0GdNGkrd+07W+KgzNtoH++PP0vkDo4XsDsy38ORzkvsMrWES6HSoW4vH4uD
         ikBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w3IZh6Sr3KpjXM0LqFQFqH1i8vaQmDVN35tRH7/mbAU=;
        b=gK44xwNOCg3Ku/7Jdmbg/iGnhQ/1Ii9UXMqBv4aShArZAtACrpQF+vo9M8w0uYkveX
         LXeGx8imu4ksT3ef6+evMM96e+3UODLib/s35Wf1f78ZebBlmKiawXBJ/QjVkOmbA4EJ
         rRZs+yeLxevciJBq9HJTPtK69rG+5Ydicg/CuDdvuklyy99q/p4vj0a26rg8C0HDbsDi
         mn9MvZ5OR0pCtnh/rqxUrYDPuTA0ClHecrCwuei5gzehqpm7LfEf4kynduoiL7Ea/3N9
         48RMSlKGWp7jEic+rLNgJqCSPe4Gof5fISxTqmdsYeSCv71FO5I/vOguDmSiNTgaiJIm
         OU6A==
X-Gm-Message-State: AOAM530zMK7ee+vGGwfoQrM4vufQG5oNJe+IPIyOUBMEIgojxn8C/V1V
        FTdIWru+bsjSpKepQvWATG9khQ==
X-Google-Smtp-Source: ABdhPJwpBrLnnVZDRlFXR/20AhSKTvv2LBBbbj08IuPCK6hz+/+h4DKZ98YD052detwqewsRRqFo8A==
X-Received: by 2002:ac2:52a6:: with SMTP id r6mr292402lfm.255.1611440361313;
        Sat, 23 Jan 2021 14:19:21 -0800 (PST)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id x17sm1313956lfg.0.2021.01.23.14.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 14:19:20 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 03/10] power: supply: ab8500: Push algorithm to power supply code
Date:   Sat, 23 Jan 2021 23:19:01 +0100
Message-Id: <20210123221908.2993388-4-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210123221908.2993388-1-linus.walleij@linaro.org>
References: <20210123221908.2993388-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The charging algorithm header is only used locally in the
power supply subsystem so push this down into
drivers/power/supply and rename from the confusing
"ux500_chargalg.h" to "ab8500-chargalg.h" for clarity:
it is only used with the AB8500.

This is another remnant of non-DT code needing to pass
data from boardfiles, which we don't do anymore.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../power/supply/ab8500-chargalg.h                          | 6 +++---
 drivers/power/supply/ab8500_charger.c                       | 2 +-
 drivers/power/supply/abx500_chargalg.c                      | 2 +-
 drivers/power/supply/pm2301_charger.c                       | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)
 rename include/linux/mfd/abx500/ux500_chargalg.h => drivers/power/supply/ab8500-chargalg.h (93%)

diff --git a/include/linux/mfd/abx500/ux500_chargalg.h b/drivers/power/supply/ab8500-chargalg.h
similarity index 93%
rename from include/linux/mfd/abx500/ux500_chargalg.h
rename to drivers/power/supply/ab8500-chargalg.h
index 9b97d284d0ce..94a6f9068bc5 100644
--- a/include/linux/mfd/abx500/ux500_chargalg.h
+++ b/drivers/power/supply/ab8500-chargalg.h
@@ -4,8 +4,8 @@
  * Author: Johan Gardsmark <johan.gardsmark@stericsson.com> for ST-Ericsson.
  */
 
-#ifndef _UX500_CHARGALG_H
-#define _UX500_CHARGALG_H
+#ifndef _AB8500_CHARGALG_H_
+#define _AB8500_CHARGALG_H_
 
 #include <linux/power_supply.h>
 
@@ -48,4 +48,4 @@ struct ux500_charger {
 
 extern struct blocking_notifier_head charger_notifier_list;
 
-#endif
+#endif /* _AB8500_CHARGALG_H_ */
diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 50989a5ec95c..a9be10eb2c22 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -28,12 +28,12 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/abx500/ab8500.h>
 #include <linux/mfd/abx500.h>
-#include <linux/mfd/abx500/ux500_chargalg.h>
 #include <linux/usb/otg.h>
 #include <linux/mutex.h>
 #include <linux/iio/consumer.h>
 
 #include "ab8500-bm.h"
+#include "ab8500-chargalg.h"
 
 /* Charger constants */
 #define NO_PW_CONN			0
diff --git a/drivers/power/supply/abx500_chargalg.c b/drivers/power/supply/abx500_chargalg.c
index 5b28d58041b4..f5b792243727 100644
--- a/drivers/power/supply/abx500_chargalg.c
+++ b/drivers/power/supply/abx500_chargalg.c
@@ -28,10 +28,10 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/abx500.h>
 #include <linux/mfd/abx500/ab8500.h>
-#include <linux/mfd/abx500/ux500_chargalg.h>
 #include <linux/notifier.h>
 
 #include "ab8500-bm.h"
+#include "ab8500-chargalg.h"
 
 /* Watchdog kick interval */
 #define CHG_WD_INTERVAL			(6 * HZ)
diff --git a/drivers/power/supply/pm2301_charger.c b/drivers/power/supply/pm2301_charger.c
index 5aeff75db33b..d53e0c37c059 100644
--- a/drivers/power/supply/pm2301_charger.c
+++ b/drivers/power/supply/pm2301_charger.c
@@ -18,13 +18,13 @@
 #include <linux/i2c.h>
 #include <linux/workqueue.h>
 #include <linux/mfd/abx500/ab8500.h>
-#include <linux/mfd/abx500/ux500_chargalg.h>
 #include <linux/pm2301_charger.h>
 #include <linux/gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm.h>
 
 #include "ab8500-bm.h"
+#include "ab8500-chargalg.h"
 #include "pm2301_charger.h"
 
 #define to_pm2xxx_charger_ac_device_info(x) container_of((x), \
-- 
2.29.2

