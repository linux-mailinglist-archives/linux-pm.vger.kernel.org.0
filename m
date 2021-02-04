Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEE130ED96
	for <lists+linux-pm@lfdr.de>; Thu,  4 Feb 2021 08:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbhBDHl3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Feb 2021 02:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbhBDHl1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2021 02:41:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5193EC061573
        for <linux-pm@vger.kernel.org>; Wed,  3 Feb 2021 23:40:47 -0800 (PST)
Date:   Thu, 04 Feb 2021 07:40:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612424445;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hrS5oia4ethNl2nxGmHWQSOKeZBtHqrIzOhnekH39IE=;
        b=MSNcSWn0yL6uQ3t+Rua/jM0LG0/KZLbteg08+7fyNNZNC16hi9FV/uPuWePAxGARNRQ96i
        HgKa7u3lelYTrtCEvg/P9kMaPoOcPnmpLT295v4f94oqn8oCGOr8hJbmX47d0jRdcPuQQN
        Im+Whn+MecoM0pe01QHOhYTPT27c6vKd0KM/iqpTKeXZkj6w+8M+n6dp052r7sdIdDRiH2
        +ti+nWhpXSz3gpP6sqwzRbxrk2uV1TGW9Dk9TdRbQdUYV2Zs6Cf64nSI28SayAufUcVr0N
        PSLi1dG57hkLDSunrkNMBommJMVVGewdj+jgJ5mPVH49Ci8vRgUzjvnRlaPgqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612424445;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hrS5oia4ethNl2nxGmHWQSOKeZBtHqrIzOhnekH39IE=;
        b=caqwKte7B/d0uKAbHV+aj6CjBRWclRaRjd2jGI5J/48lLH9vK+6yrzZd0qPDOQcHIXYsQv
        JWJQZ7qIAEEMnuBg==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Make cooling device state
 change private
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Zhang Rui <rui.zhang@intel.com>, amitk@kernel.org
In-Reply-To: <20210118173824.9970-1-daniel.lezcano@linaro.org>
References: <20210118173824.9970-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <161242444507.23325.10160721886826811281.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     23ff8529ee207c634ce2e170c353938db7aa98a9
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//23ff8529ee207c634ce2e170c353938db7aa98a9
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 18 Jan 2021 18:38:24 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 19 Jan 2021 22:31:10 +01:00

thermal/core: Make cooling device state change private

The change of the cooling device state should be used by the governor
or at least by the core code, not by the drivers themselves.

Remove the API usage and move the function declaration to the internal
headers.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Link: https://lore.kernel.org/r/20210118173824.9970-1-daniel.lezcano@linaro.org
---
 drivers/hwmon/pwm-fan.c          | 1 -
 drivers/thermal/khadas_mcu_fan.c | 1 -
 drivers/thermal/thermal_core.h   | 2 ++
 include/linux/thermal.h          | 3 ---
 4 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 777439f..c8a1597 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -422,7 +422,6 @@ static int pwm_fan_probe(struct platform_device *pdev)
 			return ret;
 		}
 		ctx->cdev = cdev;
-		thermal_cdev_update(cdev);
 	}
 
 	return 0;
diff --git a/drivers/thermal/khadas_mcu_fan.c b/drivers/thermal/khadas_mcu_fan.c
index 9eadd2d..d35e531 100644
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
index 90f9a80..86b8cef 100644
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
index 1e68640..6ac7bb1 100644
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
