Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5EC2FA803
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 18:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436712AbhARRqn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 12:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406983AbhARRjr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 12:39:47 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D19C0613CF
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 09:38:59 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a12so17239647wrv.8
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 09:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=9DsbzojBVFKuQ48xkTo4URNA+UO51ULaaDoVeAXSBBA=;
        b=P8YxMFky/mImBavbpo7nJwdUt/1ifWSE4KBf/sPnkT27LpA0jX50OVfzcgYE3urnZm
         /zIzAmTU+AffMrzt0s0DAw+P7SsU2INfZnLvfwmJLOd+Mh8CyyZdXTsXGoZnwuy72WGj
         cZXqT5I+WLIWRhIXvI6pXoAHV4BIk4byowE5X+6kRfSfrxkO5WYc9xwkQyeDKSJjrVvO
         60AicgS6UW0FTFUl5rmuHTtkW5iAY+MfSNHdfrsqgIzQa7UcxvPYqahyXujM0CfRceuX
         bECOxxao6O1vJZJaQOkXpEkHCG7Bo/m2+HidxOw1ZO+nvXEOsllmTf8zpi9D/O+vt2El
         PwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9DsbzojBVFKuQ48xkTo4URNA+UO51ULaaDoVeAXSBBA=;
        b=aBWi74m3NvO9Gn4ziJWCuZiULmTdHMOP1P5PFWvI9ian36l3ZwSWpTBE713JEVY9nI
         wO5TdraF0SNai+8yz8Zo8RRCYh1FOzziUFYUAYEOHaSYru4tBA/kMxSTIQnhs1aJYchq
         bkhvmng2WKRCq0/ApNBXaOjMsh3AKMJkMosbVgKEEe8lbo4zRCKF4o4+raIS4Ojo1Aht
         opt6q3AjOa96gC0vjq64OdfZ3IKQkFLgfNy3TT7WlVqeWzCcKDX2ehEiVmj/ilInh1//
         DgWv9qX4lb2tkx+Kjya195E2Kku5e7TW7u+lz2KuiR+2ScTS0tr7G4oxDp83hJQGIUe6
         euGw==
X-Gm-Message-State: AOAM532GaQyN5WNJabQsHRfbfivt8u7ICKUeKCn83zATWiIhXl+qqO7W
        KeuMaVd0VpiosAZs9eREs4i1Xw==
X-Google-Smtp-Source: ABdhPJyq2aDkR1RLYe+jp7iO6xkLOP6P057ChtKd77qUmfHOQxOSPMkiPb9UzfN72DeGoGnHUzowUg==
X-Received: by 2002:a5d:4882:: with SMTP id g2mr541856wrq.273.1610991537677;
        Mon, 18 Jan 2021 09:38:57 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-148-144.adsl.proxad.net. [82.252.148.144])
        by smtp.gmail.com with ESMTPSA id o8sm30042848wrm.17.2021.01.18.09.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 09:38:56 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     Guenter Roeck <linux@roeck-us.net>, Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Amit Kucheria <amitk@kernel.org>,
        linux-hwmon@vger.kernel.org (open list:PWM FAN DRIVER),
        linux-kernel@vger.kernel.org (open list),
        linux-amlogic@lists.infradead.org (open list:KHADAS MCU MFD DRIVER),
        linux-pm@vger.kernel.org (open list:THERMAL)
Subject: [PATCH v2] thermal/core: Make cooling device state change private
Date:   Mon, 18 Jan 2021 18:38:24 +0100
Message-Id: <20210118173824.9970-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The change of the cooling device state should be used by the governor
or at least by the core code, not by the drivers themselves.

Remove the API usage and move the function declaration to the internal
headers.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pwm-fan.c          | 1 -
 drivers/thermal/khadas_mcu_fan.c | 1 -
 drivers/thermal/thermal_core.h   | 2 ++
 include/linux/thermal.h          | 3 ---
 4 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index bdba2143021a..0b1159ceac9b 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -378,7 +378,6 @@ static int pwm_fan_probe(struct platform_device *pdev)
 			return ret;
 		}
 		ctx->cdev = cdev;
-		thermal_cdev_update(cdev);
 	}
 
 	return 0;
diff --git a/drivers/thermal/khadas_mcu_fan.c b/drivers/thermal/khadas_mcu_fan.c
index 9eadd2d6413e..d35e5313bea4 100644
--- a/drivers/thermal/khadas_mcu_fan.c
+++ b/drivers/thermal/khadas_mcu_fan.c
@@ -100,7 +100,6 @@ static int khadas_mcu_fan_probe(struct platform_device *pdev)
 		return ret;
 	}
 	ctx->cdev = cdev;
-	thermal_cdev_update(cdev);
 
 	return 0;
 }
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 90f9a80c8b23..86b8cef7310e 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -65,6 +65,8 @@ static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev)
 		cdev->ops->power2state;
 }
 
+void thermal_cdev_update(struct thermal_cooling_device *);
+
 /**
  * struct thermal_trip - representation of a point in temperature domain
  * @np: pointer to struct device_node that this trip point was created from
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 1e686404951b..6ac7bb1d2b1f 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -390,7 +390,6 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
 int thermal_zone_get_slope(struct thermal_zone_device *tz);
 int thermal_zone_get_offset(struct thermal_zone_device *tz);
 
-void thermal_cdev_update(struct thermal_cooling_device *);
 void thermal_notify_framework(struct thermal_zone_device *, int);
 int thermal_zone_device_enable(struct thermal_zone_device *tz);
 int thermal_zone_device_disable(struct thermal_zone_device *tz);
@@ -437,8 +436,6 @@ static inline int thermal_zone_get_offset(
 		struct thermal_zone_device *tz)
 { return -ENODEV; }
 
-static inline void thermal_cdev_update(struct thermal_cooling_device *cdev)
-{ }
 static inline void thermal_notify_framework(struct thermal_zone_device *tz,
 	int trip)
 { }
-- 
2.17.1

