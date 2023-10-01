Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1537F7B44FB
	for <lists+linux-pm@lfdr.de>; Sun,  1 Oct 2023 05:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjJADAb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 30 Sep 2023 23:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjJADAa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 30 Sep 2023 23:00:30 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCF1DD;
        Sat, 30 Sep 2023 20:00:28 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2791d5f1a09so844066a91.1;
        Sat, 30 Sep 2023 20:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696129228; x=1696734028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOU06e8PhnCbUTuWvgOQvWjBh3E5rw9a04k9RldGU5w=;
        b=NwOsiJOwYTSgh+JU0PCCzd39im7XRbI2BZ1uUjn9V7v80CB3rBFhn/DryoH8BNaciP
         WGGiP76t51NMoli0oKf1x5FKBQGXLCxZPqQ3Hw4xpYOct8MGgRJQ6rEYY6DsQB/etxtA
         KdVrinOJQU9gPujZk+51dO+qetNgZixfNuefOrApK2OyZavq3XqvIbp7qCragcVJRihA
         tL9I9SaY9zd1vanUZPJRM0x8oMvpRvZcWH4ISgtTjC++i8vuv6ZhGPI/ue4z5Gd0lGKr
         EOjFMN4YQRByWQ1M2HJ2FHTZpFzssGhn+BAq+RkiIDplQNPQmEyHewsbl352znA68Dnl
         /dfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696129228; x=1696734028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOU06e8PhnCbUTuWvgOQvWjBh3E5rw9a04k9RldGU5w=;
        b=IsU7FKxYR/BXTo7sEnTpRCBrmBemwi+rDXxBqPmlOT/ZoPcH7M1zeOh/AqkrPfm8WH
         oLhSKFpwbSccBluW++AwRdw0f4NeloMJjRGgCyqtCNPRtWMikOz1eHQkbo8obKWbezX/
         7+f+Sh+AHyCSgfXfnL//OWtxYP/P/ayakuhzI09Poz+9f82W1G3zH6S+sR7Cg68g9GGP
         513BnGj22i3n5XM5hOjTE2WdUh7O2+TaHsxutdqBD0RqaWzjy6f7ftWBJCvExT/IXsa7
         0berGyCePWERT9DFS2yyUbHj2M6qXoO9JhmfNWGkKK+tZ3j8ec+4m5VseUwSw6urCDIL
         PqYw==
X-Gm-Message-State: AOJu0YwYcIhl/mB3Te1mas41i5CXUhfW1STUBr4sBekeiaM3wjsXDT/H
        mG6dN9g1v82/Kn8V6gjkaPEJjkYD3gU=
X-Google-Smtp-Source: AGHT+IFnyrvlSvLus7XvJvl+rAgv+NDzgXNSFc2GmZOIv6mqEQCkTPeQd+wNFmnYWV8ViRbyNW4GCA==
X-Received: by 2002:a17:903:1c6:b0:1c0:bf60:ba82 with SMTP id e6-20020a17090301c600b001c0bf60ba82mr9419293plh.5.1696129227714;
        Sat, 30 Sep 2023 20:00:27 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:355a:d2a5:90:39d5])
        by smtp.gmail.com with ESMTPSA id az4-20020a170902a58400b001b8baa83639sm6801788plb.200.2023.09.30.20.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 20:00:27 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH v9 2/3] reboot: Introduce thermal_zone_device_critical_reboot()
Date:   Sun,  1 Oct 2023 00:00:13 -0300
Message-Id: <20231001030014.1244633-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231001030014.1244633-1-festevam@gmail.com>
References: <20231001030014.1244633-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

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
Changes since v8:
- Introduce thermal_zone_device_critical_reboot() to accomodate
Daniel's suggestions.

 drivers/thermal/thermal_core.c | 19 +++++++++++++++++--
 include/linux/reboot.h         | 13 ++++++++++++-
 include/linux/thermal.h        |  1 +
 kernel/reboot.c                | 32 +++++++++++++++++++-------------
 4 files changed, 49 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 38d393f139d8..277aafb294db 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -313,21 +313,36 @@ static void handle_non_critical_trips(struct thermal_zone_device *tz, int trip)
 		       def_governor->throttle(tz, trip);
 }
 
-void thermal_zone_device_critical(struct thermal_zone_device *tz)
+static void thermal_zone_device_shutdown(struct thermal_zone_device *tz, bool shutdown)
 {
 	/*
 	 * poweroff_delay_ms must be a carefully profiled positive value.
 	 * Its a must for forced_emergency_poweroff_work to be scheduled.
 	 */
 	int poweroff_delay_ms = CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS;
+	static const char *msg = "Temperature too high";
 
 	dev_emerg(&tz->device, "%s: critical temperature reached, "
 		  "shutting down\n", tz->type);
 
-	hw_protection_shutdown("Temperature too high", poweroff_delay_ms);
+	if (shutdown)
+		hw_protection_shutdown(msg, poweroff_delay_ms);
+	else
+		hw_protection_reboot(msg, poweroff_delay_ms);
+}
+
+void thermal_zone_device_critical(struct thermal_zone_device *tz)
+{
+	thermal_zone_device_shutdown(tz, true);
 }
 EXPORT_SYMBOL(thermal_zone_device_critical);
 
+void thermal_zone_device_critical_reboot(struct thermal_zone_device *tz)
+{
+	thermal_zone_device_shutdown(tz, false);
+}
+EXPORT_SYMBOL(thermal_zone_device_critical_reboot);
+
 static void handle_critical_trips(struct thermal_zone_device *tz,
 				  int trip, int trip_temp, enum thermal_trip_type trip_type)
 {
diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index c4cc3b89ced1..4683e117c753 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -177,7 +177,18 @@ void ctrl_alt_del(void);
 
 extern void orderly_poweroff(bool force);
 extern void orderly_reboot(void);
-void hw_protection_shutdown(const char *reason, int ms_until_forced);
+
+void __hw_protection_shutdown(const char *reason, int ms_until_forced, bool shutdown);
+
+static inline void hw_protection_reboot(const char *reason, int ms_until_forced)
+{
+	__hw_protection_shutdown(reason, ms_until_forced, false);
+}
+
+static inline void hw_protection_shutdown(const char *reason, int ms_until_forced)
+{
+	__hw_protection_shutdown(reason, ms_until_forced, true);
+}
 
 /*
  * Emergency restart, callable from an interrupt handler.
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 6cfcae22ba12..c5ebb44ae8a6 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -353,6 +353,7 @@ int thermal_zone_get_offset(struct thermal_zone_device *tz);
 int thermal_zone_device_enable(struct thermal_zone_device *tz);
 int thermal_zone_device_disable(struct thermal_zone_device *tz);
 void thermal_zone_device_critical(struct thermal_zone_device *tz);
+void thermal_zone_device_critical_reboot(struct thermal_zone_device *tz);
 #else
 static inline struct thermal_zone_device *thermal_zone_device_register_with_trips(
 					const char *type,
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 395a0ea3c7a8..8b3010b88ed6 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -957,21 +957,25 @@ static void hw_failure_emergency_poweroff(int poweroff_delay_ms)
 }
 
 /**
- * hw_protection_shutdown - Trigger an emergency system poweroff
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
+ * Initiate an emergency system shutdown or reboot in order to protect
+ * hardware from further damage. Usage examples include a thermal protection.
+ * NOTE: The request is ignored if protection shutdown or reboot is already
+ * pending even if the previous request has given a large timeout for forced
+ * shutdown/reboot.
  * Can be called from any context.
  */
-void hw_protection_shutdown(const char *reason, int ms_until_forced)
+void __hw_protection_shutdown(const char *reason, int ms_until_forced, bool shutdown)
 {
 	static atomic_t allow_proceed = ATOMIC_INIT(1);
 
@@ -986,9 +990,11 @@ void hw_protection_shutdown(const char *reason, int ms_until_forced)
 	 * orderly_poweroff failure
 	 */
 	hw_failure_emergency_poweroff(ms_until_forced);
-	orderly_poweroff(true);
+	if (shutdown)
+		orderly_poweroff(true);
+	else
+		orderly_reboot();
 }
-EXPORT_SYMBOL_GPL(hw_protection_shutdown);
 
 static int __init reboot_setup(char *str)
 {
-- 
2.34.1

