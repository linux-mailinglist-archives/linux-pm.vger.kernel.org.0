Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C440219C415
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 16:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732754AbgDBO2G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 10:28:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39286 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732484AbgDBO2G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2020 10:28:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id p10so4453087wrt.6
        for <linux-pm@vger.kernel.org>; Thu, 02 Apr 2020 07:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+cHrwJ2Hn5m/Qb3jLfMLFnnm5DKsUGWGJFUk2Y++pX0=;
        b=pULk7rj3GE/OloQs/UlEPA3hGEuRaujr/vzLWqxhalI8dIxY/sAGfzu5hMUOuFI9ZB
         z4tRJJMehohhlfyAQ0DVR4ZCRGLNrQr96ZLmJZzRaMPudcchNQwbcprKP67fb+GqWtCT
         RYBayP/aWoVYXea164mZ7/tCnVN45RFj4QK/LSk7uvQAC61NyxrvfTjXUGEiiinRRjXv
         Ao76MhSv6xU/IXBUwLSFaLHo1wVrnRX+035n+amJubfinxJ9jDv+KwhIKyfWE6v5Hzk6
         qrsxJ74FSpgyeE7P48mdwLM3legrLvc0/R23PKlQaDIP8vu0IG4qq3wJEei5++wdJxyc
         CSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+cHrwJ2Hn5m/Qb3jLfMLFnnm5DKsUGWGJFUk2Y++pX0=;
        b=oLpN8MZX1WJkLbbpjggJfQ1ddqf1j/hyWaA35fS6vJ/Q5Wzolh8dJtDDXMGTW1gwsK
         Zo7Gnp/nuWFEfzHGGsfitszDkm0VjW6EkLWzBdchN0HblvFwYWvYct42asO2y0fuqIxU
         ENqBzI+678bupcc4qqphxm2ctoeemYPrEFcD47jPXSpbtjkzq2tn9/JA0Qzt1FM3t88g
         aoA616R3+p8sr7vWit2S/7R/4SlZuVVtX5O0zf7Lp2Akd82GDbaFpVQSiGO40ha4ahr9
         viV6l8Zh1yJUgV8P6xTH4xtIc4q3pbiH0QvKZq512Kh+PI+cDxbSCVKGEyYEeenmIFMT
         4auA==
X-Gm-Message-State: AGi0PuY85QraJg0n9cYoVmwrgoX50NXN+6I9CIO530uojs+AyL0RXPPi
        DvInrmXicro8AWmBfsOvi4m/wQ==
X-Google-Smtp-Source: APiQypK+3IkY+QbxGgVh1nczO4PMUAzFmJPq5vNl2asf7Eve6C5rflARXmwY7NtjH9HNoyosCPb4Dg==
X-Received: by 2002:adf:b6a9:: with SMTP id j41mr1387106wre.70.1585837684482;
        Thu, 02 Apr 2020 07:28:04 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:4b2:e366:e86f:261a])
        by smtp.gmail.com with ESMTPSA id a7sm7045186wmm.34.2020.04.02.07.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 07:28:03 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 3/9] thermal: Move internal IPA functions
Date:   Thu,  2 Apr 2020 16:27:41 +0200
Message-Id: <20200402142747.8307-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200402142747.8307-1-daniel.lezcano@linaro.org>
References: <20200402142747.8307-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The exported IPA functions are used by the IPA. It is pointless to
declare the functions in the thermal.h file.

For better self-encapsulation and less impact for the compilation if a
change is made on it. Move the code in the thermal core internal
header file.

As the users depends on THERMAL then it is pointless to have the stub,
remove them.

Take also the opportunity to fix checkpatch warnings/errors when
moving the code around.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h | 13 +++++++++++++
 include/linux/thermal.h        | 24 ------------------------
 2 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 5d08ad60d9df..f99551ce9838 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -46,6 +46,19 @@ struct thermal_attr {
 	char name[THERMAL_NAME_LENGTH];
 };
 
+static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev)
+{
+	return cdev->ops->get_requested_power && cdev->ops->state2power &&
+		cdev->ops->power2state;
+}
+
+int power_actor_get_max_power(struct thermal_cooling_device *cdev,
+			      struct thermal_zone_device *tz, u32 *max_power);
+int power_actor_get_min_power(struct thermal_cooling_device *cdev,
+			      struct thermal_zone_device *tz, u32 *min_power);
+int power_actor_set_power(struct thermal_cooling_device *cdev,
+			  struct thermal_instance *ti, u32 power);
+
 /*
  * This structure is used to describe the behavior of
  * a certain cooling device on a certain trip point
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 5aa80fb2fb61..e0279f7b43f4 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -399,18 +399,6 @@ void devm_thermal_zone_of_sensor_unregister(struct device *dev,
 #endif
 
 #if IS_ENABLED(CONFIG_THERMAL)
-static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev)
-{
-	return cdev->ops->get_requested_power && cdev->ops->state2power &&
-		cdev->ops->power2state;
-}
-
-int power_actor_get_max_power(struct thermal_cooling_device *,
-			      struct thermal_zone_device *tz, u32 *max_power);
-int power_actor_get_min_power(struct thermal_cooling_device *,
-			      struct thermal_zone_device *tz, u32 *min_power);
-int power_actor_set_power(struct thermal_cooling_device *,
-			  struct thermal_instance *, u32);
 struct thermal_zone_device *thermal_zone_device_register(const char *, int, int,
 		void *, struct thermal_zone_device_ops *,
 		struct thermal_zone_params *, int, int);
@@ -447,18 +435,6 @@ struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
 void thermal_cdev_update(struct thermal_cooling_device *);
 void thermal_notify_framework(struct thermal_zone_device *, int);
 #else
-static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev)
-{ return false; }
-static inline int power_actor_get_max_power(struct thermal_cooling_device *cdev,
-			      struct thermal_zone_device *tz, u32 *max_power)
-{ return 0; }
-static inline int power_actor_get_min_power(struct thermal_cooling_device *cdev,
-					    struct thermal_zone_device *tz,
-					    u32 *min_power)
-{ return -ENODEV; }
-static inline int power_actor_set_power(struct thermal_cooling_device *cdev,
-			  struct thermal_instance *tz, u32 power)
-{ return 0; }
 static inline struct thermal_zone_device *thermal_zone_device_register(
 	const char *type, int trips, int mask, void *devdata,
 	struct thermal_zone_device_ops *ops,
-- 
2.17.1

