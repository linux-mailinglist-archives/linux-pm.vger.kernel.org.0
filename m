Return-Path: <linux-pm+bounces-470-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C36F7FD707
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 13:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CE8C1F20FCF
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 12:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B514B1CA81;
	Wed, 29 Nov 2023 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFABox7T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C2C10D4;
	Wed, 29 Nov 2023 04:44:00 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6bf20d466cdso617034b3a.1;
        Wed, 29 Nov 2023 04:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701261840; x=1701866640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJ1zqy6y1N//ubnnquRNTd9KIH2W8I83a9N25tLdllg=;
        b=gFABox7T6xGPsgzYB2FHvXdOYaJIiiquijOzzXn2czsdtK7Ox4PcsrAqiepHytQ9jl
         j65lfs/74KoNqiIs7xiTdoois7cEyq3Mq1p0VDKPaTZyYrrOtOG/tMkoyszRWbjKJqJc
         qSBUH7hHpEBokZSxhNpJGsJmbgoLlt2rFHniOjFwE8DR+c8PIKB6qnYcQKfusy6Emk1q
         pUwYStxSFOwY4ZyyGEIU+mlfhWOP6xEPM5Zw455dyzxHv/H/E9L4/jyYxTXcFIHKM4CD
         dxUk+qnTyB60sj/A2+kj9iSOAs1qHu18Jdo4xfKJA9934NWda4XXOUo7/VYfAwXwaosT
         vjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701261840; x=1701866640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJ1zqy6y1N//ubnnquRNTd9KIH2W8I83a9N25tLdllg=;
        b=mA2FDRC+/oFWfjhmFoIVHQlvIVn/8aifpm8MuNk7dPU+x1ZfGdcZXc5gKxoieWBY+A
         SNuBuIiWYswysa5oChhLze4yuS3U6PNiy+96o8DdX+SLjHwjobovamxfEJfmc5i5GZ4n
         LJ6UEuIjyGwrh4l/Kp6X75EMY4KOLCi3OL28phJgg4N0c1axR5dWQgD1C3skYoTyJBDA
         MwA6HBSyrgXn/qvg/D8t41U8olqH9a/eI4KQ7i6agVDaxcEPuXAEvL/cmIyvfpIxJ6Lt
         lpFkNbY+lJbYTqYg5wtPAJTfm/OlgTaTU2aR4NaPAIvus6CvB+PWeEuxld5JNCz0I/Bb
         v0/g==
X-Gm-Message-State: AOJu0YzWuLa4WYSiZgJTjUXA52G7tANgoFxVJSbzFyBeTZx5q965oM9X
	YJECEZ8VKP5Vk/Z5fSpTMcxph8S7O6o=
X-Google-Smtp-Source: AGHT+IEGdkN1rfQtPkhL7w2yOgVIXhMckUbDGamGNT+VQkUiYtAn04rGf5LzLdGGH6vXf3X2xTdmZw==
X-Received: by 2002:a05:6a00:2d97:b0:6cb:a2fa:1dcf with SMTP id fb23-20020a056a002d9700b006cba2fa1dcfmr22098052pfb.3.1701261839826;
        Wed, 29 Nov 2023 04:43:59 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:5db0:20f8:912:48b])
        by smtp.gmail.com with ESMTPSA id fe21-20020a056a002f1500b0068bbd43a6e2sm11028416pfb.10.2023.11.29.04.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 04:43:59 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: daniel.lezcano@linaro.org
Cc: rafael@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	mazziesaccount@gmail.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH v12 2/4] thermal_core: Prepare for introduction of thermal reboot
Date: Wed, 29 Nov 2023 09:43:28 -0300
Message-Id: <20231129124330.519423-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129124330.519423-1-festevam@gmail.com>
References: <20231129124330.519423-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

Add some helper functions to make it easier introducing the support
for thermal reboot.

No functional change.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v11:
- None

 drivers/thermal/thermal_core.c | 14 ++++++++++----
 include/linux/reboot.h         |  7 ++++++-
 kernel/reboot.c                |  8 ++++----
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 625ba07cbe2f..e40b1fc6513c 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -314,18 +314,24 @@ static void handle_non_critical_trips(struct thermal_zone_device *tz,
 		       def_governor->throttle(tz, trip);
 }
 
-void thermal_zone_device_critical(struct thermal_zone_device *tz)
+static void thermal_zone_device_halt(struct thermal_zone_device *tz, bool shutdown)
 {
 	/*
 	 * poweroff_delay_ms must be a carefully profiled positive value.
 	 * Its a must for forced_emergency_poweroff_work to be scheduled.
 	 */
 	int poweroff_delay_ms = CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS;
+	const char *msg = "Temperature too high";
+
+	dev_emerg(&tz->device, "%s: critical temperature reached\n", tz->type);
 
-	dev_emerg(&tz->device, "%s: critical temperature reached, "
-		  "shutting down\n", tz->type);
+	if (shutdown)
+		hw_protection_shutdown(msg, poweroff_delay_ms);
+}
 
-	hw_protection_shutdown("Temperature too high", poweroff_delay_ms);
+void thermal_zone_device_critical(struct thermal_zone_device *tz)
+{
+	thermal_zone_device_halt(tz, true);
 }
 EXPORT_SYMBOL(thermal_zone_device_critical);
 
diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index c4cc3b89ced1..4586c663884e 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -177,7 +177,12 @@ void ctrl_alt_del(void);
 
 extern void orderly_poweroff(bool force);
 extern void orderly_reboot(void);
-void hw_protection_shutdown(const char *reason, int ms_until_forced);
+void __hw_protection_shutdown(const char *reason, int ms_until_forced, bool shutdown);
+
+static inline void hw_protection_shutdown(const char *reason, int ms_until_forced)
+{
+	__hw_protection_shutdown(reason, ms_until_forced, true);
+}
 
 /*
  * Emergency restart, callable from an interrupt handler.
diff --git a/kernel/reboot.c b/kernel/reboot.c
index c3a3b82c4f64..07eb6537ed8b 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -970,7 +970,7 @@ static void hw_failure_emergency_poweroff(int poweroff_delay_ms)
 }
 
 /**
- * hw_protection_shutdown - Trigger an emergency system poweroff
+ * __hw_protection_shutdown - Trigger an emergency system poweroff
  *
  * @reason:		Reason of emergency shutdown to be printed.
  * @ms_until_forced:	Time to wait for orderly shutdown before tiggering a
@@ -984,7 +984,7 @@ static void hw_failure_emergency_poweroff(int poweroff_delay_ms)
  * if the previous request has given a large timeout for forced shutdown.
  * Can be called from any context.
  */
-void hw_protection_shutdown(const char *reason, int ms_until_forced)
+void __hw_protection_shutdown(const char *reason, int ms_until_forced, bool shutdown)
 {
 	static atomic_t allow_proceed = ATOMIC_INIT(1);
 
@@ -999,9 +999,9 @@ void hw_protection_shutdown(const char *reason, int ms_until_forced)
 	 * orderly_poweroff failure
 	 */
 	hw_failure_emergency_poweroff(ms_until_forced);
-	orderly_poweroff(true);
+	if (shutdown)
+		orderly_poweroff(true);
 }
-EXPORT_SYMBOL_GPL(hw_protection_shutdown);
 
 static int __init reboot_setup(char *str)
 {
-- 
2.34.1


