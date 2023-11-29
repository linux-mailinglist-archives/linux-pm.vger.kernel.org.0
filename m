Return-Path: <linux-pm+bounces-471-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 738867FD709
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 13:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0900B218A4
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 12:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39CB1B297;
	Wed, 29 Nov 2023 12:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuHY/1Iy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B992DD44;
	Wed, 29 Nov 2023 04:44:03 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-35b0b36716fso6459255ab.0;
        Wed, 29 Nov 2023 04:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701261843; x=1701866643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OlrK86XcWSt3v7Pox0FKoMqKha7dRcJSUQTUI1VMtg=;
        b=JuHY/1Iyqvgk1wdRKkX2qoUyplUqT0dXiANZkbmLDM5DLJDrm18CHkDREuXyGOySva
         DJy5V+iEptDjngdkZ61agDkDMboU5u3H0IJ/mibYuadWi13EvSJ9Y0gawInKh78Joawi
         xPT7m9NdWH/RXVpqpMByNOGacMXpkHJCQHM6YqDwUKfEKsV1bJyJuXqM9RoNOWBlL82q
         Jqr7vNlYPxAJclWaU++xY1YG/KOTIHkJ9AVAbPME6XIoaNprs6HXUNAKS66S9usAz9+S
         pEDCN1oipRJle20Ot8TV6UFzg2C0XxvyisNtd7NxcTszSmGAdP17q6Vj40HhPzUFL5N1
         +a1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701261843; x=1701866643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9OlrK86XcWSt3v7Pox0FKoMqKha7dRcJSUQTUI1VMtg=;
        b=bo62mUu0wKx6/CwwoldFXeRMItzeMgoAM5VyC+meZpPX6JBKHfda9OHSTcUaZclLnH
         uJstyGyV8VxF/xV7KdDw4vnqigQ4svuLcPZXlcMoh7yJCSWdudFtSwXRCAy4nI0gEFsm
         JXelTPTjWbrL3rUEa0hvV/lQr9Urh2s+4A1ifNVhRVTt8J/QSS1mSTguWbkQHcF9+bWM
         /mui1a65M8SubTdSHDlZADlV03p8iI/2BcgnOdvl7c6BycVOYoyERmmXuHcoBDityuV6
         4v4T97D4j9PSxLb73wz9gi4vgqc+zZE+LTyYZy0tzANj+lzUh+jO8km0ezF7tTOEW11b
         FdIQ==
X-Gm-Message-State: AOJu0YwlP+oEEo2Msg8XSnRMQ1yrnejdooxagfhKhcOXOjhJlmYETkEx
	CwIDQgZsgLuvsFSVRrB9PpA=
X-Google-Smtp-Source: AGHT+IF8vix7r5HLakcCz87bbDhj+o+LJxGDDwKNOKgxN0wZIIgMevVBZ/jFZjDXuZFlXhB5NGA5cw==
X-Received: by 2002:a92:ce8c:0:b0:35c:7b32:241f with SMTP id r12-20020a92ce8c000000b0035c7b32241fmr13255039ilo.2.1701261842976;
        Wed, 29 Nov 2023 04:44:02 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:5db0:20f8:912:48b])
        by smtp.gmail.com with ESMTPSA id fe21-20020a056a002f1500b0068bbd43a6e2sm11028416pfb.10.2023.11.29.04.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 04:44:02 -0800 (PST)
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
Subject: [PATCH v12 3/4] reboot: Introduce thermal_zone_device_critical_reboot()
Date: Wed, 29 Nov 2023 09:43:29 -0300
Message-Id: <20231129124330.519423-3-festevam@gmail.com>
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

Introduce thermal_zone_device_critical_reboot() to trigger an
emergency reboot.

It is a counterpart of thermal_zone_device_critical() with the
difference that it will force a reboot instead of shutdown.

The motivation for doing this is to allow the thermal subystem
to trigger a reboot when the temperature reaches the critical
temperature.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v11:
- Move the hermal_zone_device_critical_reboot() prototype to thermal_core.h (Daniel)

 drivers/thermal/thermal_core.c |  7 +++++++
 drivers/thermal/thermal_core.h |  1 +
 include/linux/reboot.h         |  5 +++++
 kernel/reboot.c                | 27 ++++++++++++++++-----------
 4 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index e40b1fc6513c..9d47347d4242 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -327,6 +327,8 @@ static void thermal_zone_device_halt(struct thermal_zone_device *tz, bool shutdo
 
 	if (shutdown)
 		hw_protection_shutdown(msg, poweroff_delay_ms);
+	else
+		hw_protection_reboot(msg, poweroff_delay_ms);
 }
 
 void thermal_zone_device_critical(struct thermal_zone_device *tz)
@@ -335,6 +337,11 @@ void thermal_zone_device_critical(struct thermal_zone_device *tz)
 }
 EXPORT_SYMBOL(thermal_zone_device_critical);
 
+void thermal_zone_device_critical_reboot(struct thermal_zone_device *tz)
+{
+	thermal_zone_device_halt(tz, false);
+}
+
 static void handle_critical_trips(struct thermal_zone_device *tz,
 				  const struct thermal_trip *trip)
 {
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 0a3b3ec5120b..c447d21012d0 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -114,6 +114,7 @@ int thermal_zone_device_set_policy(struct thermal_zone_device *, char *);
 int thermal_build_list_of_policies(char *buf);
 void __thermal_zone_device_update(struct thermal_zone_device *tz,
 				  enum thermal_notify_event event);
+void thermal_zone_device_critical_reboot(struct thermal_zone_device *tz);
 
 /* Helpers */
 #define for_each_trip(__tz, __trip)	\
diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index 4586c663884e..abcdde4df697 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -179,6 +179,11 @@ extern void orderly_poweroff(bool force);
 extern void orderly_reboot(void);
 void __hw_protection_shutdown(const char *reason, int ms_until_forced, bool shutdown);
 
+static inline void hw_protection_reboot(const char *reason, int ms_until_forced)
+{
+	__hw_protection_shutdown(reason, ms_until_forced, false);
+}
+
 static inline void hw_protection_shutdown(const char *reason, int ms_until_forced)
 {
 	__hw_protection_shutdown(reason, ms_until_forced, true);
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 07eb6537ed8b..f76814037f41 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -970,19 +970,22 @@ static void hw_failure_emergency_poweroff(int poweroff_delay_ms)
 }
 
 /**
- * __hw_protection_shutdown - Trigger an emergency system poweroff
+ * __hw_protection_shutdown - Trigger an emergency system shutdown or reboot
  *
- * @reason:		Reason of emergency shutdown to be printed.
- * @ms_until_forced:	Time to wait for orderly shutdown before tiggering a
- *			forced shudown. Negative value disables the forced
- *			shutdown.
+ * @reason:		Reason of emergency shutdown or reboot to be printed.
+ * @ms_until_forced:	Time to wait for orderly shutdown or reboot before
+ *			triggering it. Negative value disables the forced
+ *			shutdown or reboot.
+ * @shutdown:		If true, indicates that a shutdown will happen
+ *			after the critical tempeature is reached.
+ *			If false, indicates that a reboot will happen
+ *			after the critical tempeature is reached.
  *
- * Initiate an emergency system shutdown in order to protect hardware from
- * further damage. Usage examples include a thermal protection or a voltage or
- * current regulator failures.
- * NOTE: The request is ignored if protection shutdown is already pending even
- * if the previous request has given a large timeout for forced shutdown.
- * Can be called from any context.
+ * Initiate an emergency system shutdown or reboot in order to protect
+ * hardware from further damage. Usage examples include a thermal protection.
+ * NOTE: The request is ignored if protection shutdown or reboot is already
+ * pending even if the previous request has given a large timeout for forced
+ * shutdown/reboot.
  */
 void __hw_protection_shutdown(const char *reason, int ms_until_forced, bool shutdown)
 {
@@ -1001,6 +1004,8 @@ void __hw_protection_shutdown(const char *reason, int ms_until_forced, bool shut
 	hw_failure_emergency_poweroff(ms_until_forced);
 	if (shutdown)
 		orderly_poweroff(true);
+	else
+		orderly_reboot();
 }
 
 static int __init reboot_setup(char *str)
-- 
2.34.1


