Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6EBA3C7337
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jul 2021 17:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237082AbhGMPcH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Jul 2021 11:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237077AbhGMPcH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jul 2021 11:32:07 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C484EC0613DD
        for <linux-pm@vger.kernel.org>; Tue, 13 Jul 2021 08:29:16 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id h19so19678614ljl.4
        for <linux-pm@vger.kernel.org>; Tue, 13 Jul 2021 08:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HqnU72MCKRWkDij27ChHkC29ca9CD/06UjhFYrEKl70=;
        b=TreSgl8kmqxD4VKHIVh6U9S203qK2CpVrcyKRJa8znF1KCiexVpplHTCciqPwq+Igf
         dOxxtEkeQuufansYNB8MVZciBcN02ZRB1InUD0RXtVitYMaY+hFFYd211egtc/fK9ZI4
         4/vbqtvuFfQvt9Kq47KpvHRaEnCfEicrEJNb6V1zVwUGW6R6fWTlCT5rFfQFiZmC2/nA
         DPRh5aiWZ2i01miOdeOYWfswvpJE0Xo6KiV4XfLJNHar34S9/oV+GZx8Ubh2Vk002/sx
         RX9uJ1LbA7QzJ1Gn2xPD5CknSqOGsq0ZQ1eWcce6dWGPEyCtpFFDj8H93PH8wDKeXmFG
         BRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HqnU72MCKRWkDij27ChHkC29ca9CD/06UjhFYrEKl70=;
        b=LAjww++i34HLQlW6lOd2MmLa9oUiQDOImRRBLvrac/cTHiwk//6DbKY1jqLT42qeMw
         cvr053QieqFoCxfjbjXbJ/v7dmef0u0JHGjK0M9BwvVQY+lqs5eekms++KG5DQ+VugAx
         9rJ2QECPrtQcmllt1JzRg95J4zEKE+bOvcyYYHjOVEDdXo7P0KwVtQAbiSjYt3Rje8rg
         zPITG69E0Xm8BeBD8bGyiTWEGz1QPiTVpY95fbH9/YCumYfcZEeDW/+P7C23VDsluMl0
         lPGe0/gApJpC+qUFjZMGa99Q2MOhhuOvr7xvwgK52IuTGR1S7dY/RGwITSpVKxu3bKyP
         MpYg==
X-Gm-Message-State: AOAM533k9GppXXSulrakmYIVP8F5UHzpW3g/e6+Um5I2xhRyrUqjZgSV
        CDyb+GDrbtjmm06AE0nWVX5ZlA==
X-Google-Smtp-Source: ABdhPJyj+zOnZo3iBKbO4HA+VaWqPpoUZFgybHKQCmgMI1czmzSdpFsYeK++yNVGHwxWxrABicFoMg==
X-Received: by 2002:a2e:a78d:: with SMTP id c13mr4773538ljf.12.1626190155119;
        Tue, 13 Jul 2021 08:29:15 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id d8sm827395ljg.86.2021.07.13.08.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 08:29:14 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/5] power: supply: ab8500: Use library interpolation
Date:   Tue, 13 Jul 2021 17:27:05 +0200
Message-Id: <20210713152709.871833-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The kernel already has a static inline for linear interpolation
so use that instead of rolling our own.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500_btemp.c |  6 ++++--
 drivers/power/supply/ab8500_fg.c    | 14 +++++++-------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index dbdcff32f353..24958b935d39 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -27,6 +27,7 @@
 #include <linux/mfd/abx500.h>
 #include <linux/mfd/abx500/ab8500.h>
 #include <linux/iio/consumer.h>
+#include <linux/fixp-arith.h>
 
 #include "ab8500-bm.h"
 
@@ -437,8 +438,9 @@ static int ab8500_btemp_res_to_temp(struct ab8500_btemp *di,
 			i++;
 	}
 
-	return tbl[i].temp + ((tbl[i + 1].temp - tbl[i].temp) *
-		(res - tbl[i].resist)) / (tbl[i + 1].resist - tbl[i].resist);
+	return fixp_linear_interpolate(tbl[i].resist, tbl[i].temp,
+				       tbl[i + 1].resist, tbl[i + 1].temp,
+				       res);
 }
 
 /**
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 3d45ed0157c6..bdbf3f13bee0 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -34,6 +34,7 @@
 #include <linux/mfd/abx500/ab8500.h>
 #include <linux/iio/consumer.h>
 #include <linux/kernel.h>
+#include <linux/fixp-arith.h>
 
 #include "ab8500-bm.h"
 
@@ -56,9 +57,6 @@
 /* FG constants */
 #define BATT_OVV			0x01
 
-#define interpolate(x, x1, y1, x2, y2) \
-	((y1) + ((((y2) - (y1)) * ((x) - (x1))) / ((x2) - (x1))));
-
 /**
  * struct ab8500_fg_interrupts - ab8500 fg interrupts
  * @name:	name of the interrupt
@@ -868,11 +866,12 @@ static int ab8500_fg_volt_to_capacity(struct ab8500_fg *di, int voltage)
 	}
 
 	if ((i > 0) && (i < tbl_size)) {
-		cap = interpolate(voltage,
+		cap = fixp_linear_interpolate(
 			tbl[i].voltage,
 			tbl[i].capacity * 10,
 			tbl[i-1].voltage,
-			tbl[i-1].capacity * 10);
+			tbl[i-1].capacity * 10,
+			voltage);
 	} else if (i == 0) {
 		cap = 1000;
 	} else {
@@ -920,11 +919,12 @@ static int ab8500_fg_battery_resistance(struct ab8500_fg *di)
 	}
 
 	if ((i > 0) && (i < tbl_size)) {
-		resist = interpolate(di->bat_temp / 10,
+		resist = fixp_linear_interpolate(
 			tbl[i].temp,
 			tbl[i].resist,
 			tbl[i-1].temp,
-			tbl[i-1].resist);
+			tbl[i-1].resist,
+			di->bat_temp / 10);
 	} else if (i == 0) {
 		resist = tbl[0].resist;
 	} else {
-- 
2.31.1

