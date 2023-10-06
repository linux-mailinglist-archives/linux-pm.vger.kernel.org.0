Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5503E7BBE4F
	for <lists+linux-pm@lfdr.de>; Fri,  6 Oct 2023 20:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbjJFSFJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Oct 2023 14:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbjJFSFI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Oct 2023 14:05:08 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A7AE9;
        Fri,  6 Oct 2023 11:05:06 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c746bc3bceso4074415ad.1;
        Fri, 06 Oct 2023 11:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696615506; x=1697220306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7Qu1YLA3o2ZOBF7t7w1ImFAGjG5u+c/lng1hyDe7ew=;
        b=OyOgDc3AGkboJ4gjx3uZ0YzF75y/B6wmvCJ7W0ZsEgQYzb0WY/vL6o1I6O2J2P7jl+
         babUopwAsmTDQB9mT6hCcsxbu2jKBUkIRT/zncLdZ5TX3HcYiegZEJvYWkVF2GxK5nMG
         ZAOILbv8v2W9vbXNsUHM3BqDJNjMRuSLeURBJOI0Ssnc+d0GRmpCf8CrIQwzJ8AsgSHO
         L/I2GNBEyMWyO6D/xtVBLL7MGFQRUIq8Km0C2O8qJW+AkgQ89/5lbNtyut6ib2Rwn9q7
         InSbDxi0IFAY4e66Ohm5NK9mGweo871lH+jnTUopS1DurJ09rps+XwEDkF2rfPWxre9y
         5bjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696615506; x=1697220306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7Qu1YLA3o2ZOBF7t7w1ImFAGjG5u+c/lng1hyDe7ew=;
        b=JSddkdi4Of+Tjup6BkLUcDvG7NHhKptm0M9f+jI83cNjY8RA69V30NM+F42mvEDLp8
         GHCZmyboNYl0mag94DdsF1yTzQwF3AQKV9FcmXA9AZZMOjWco05S/BXZoUDz7zD/bmaR
         1ZIzqWgaHnm0G3pRXcD7TN2buLZNc5wCelUv1uoAA48r1bWFr+xpzN33Y9L5GAkyhUcX
         AqysmFMbOj7MM+Nzlf1adlD3CK2ljdkmTBPDeYe9krhJYcdN1KxDpBPHs89f/i9QthjR
         q9JMB1enGGLvxX02x+jAMtSS+twhjxXuaOPcACvOx4hcerUC19hZKnUFk3eI8ByIWZTq
         V/VQ==
X-Gm-Message-State: AOJu0Yy2SqL2/bVLfQ+lAmghE96d82m6LnyAcvlyE6vhZPzZ/nFbBTcs
        nkry8rvoYXsgy7hQwRc0CHE=
X-Google-Smtp-Source: AGHT+IGXP5HEfK9yYoeyDnLEQvWpKkd+eg/QL1jKgphHOAxo9Cs0Hm8JJaUwwgxkLOXUalLOJJeh7Q==
X-Received: by 2002:a17:902:ec88:b0:1c0:bf60:ba4f with SMTP id x8-20020a170902ec8800b001c0bf60ba4fmr9297693plg.4.1696615506143;
        Fri, 06 Oct 2023 11:05:06 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:d018:9da6:2e69:1658])
        by smtp.gmail.com with ESMTPSA id f11-20020a17090274cb00b001bb1f0605b2sm4165355plt.214.2023.10.06.11.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:05:05 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH v10 2/4] thermal_core: Prepare for introduction of thermal reboot
Date:   Fri,  6 Oct 2023 15:04:51 -0300
Message-Id: <20231006180453.2903342-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006180453.2903342-1-festevam@gmail.com>
References: <20231006180453.2903342-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Fabio Estevam <festevam@denx.de>

Add some helper functions to make it easier introducing the support
for thermal reboot.

No functional change.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v9:
- Newly introduced.

 drivers/thermal/thermal_core.c | 14 ++++++++++----
 include/linux/reboot.h         |  7 ++++++-
 kernel/reboot.c                |  8 ++++----
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 45d0aa0b69b7..3184e9f2eadd 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -313,18 +313,24 @@ static void handle_non_critical_trips(struct thermal_zone_device *tz, int trip)
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
index 395a0ea3c7a8..b236c4c06bb3 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -957,7 +957,7 @@ static void hw_failure_emergency_poweroff(int poweroff_delay_ms)
 }
 
 /**
- * hw_protection_shutdown - Trigger an emergency system poweroff
+ * __hw_protection_shutdown - Trigger an emergency system poweroff
  *
  * @reason:		Reason of emergency shutdown to be printed.
  * @ms_until_forced:	Time to wait for orderly shutdown before tiggering a
@@ -971,7 +971,7 @@ static void hw_failure_emergency_poweroff(int poweroff_delay_ms)
  * if the previous request has given a large timeout for forced shutdown.
  * Can be called from any context.
  */
-void hw_protection_shutdown(const char *reason, int ms_until_forced)
+void __hw_protection_shutdown(const char *reason, int ms_until_forced, bool shutdown)
 {
 	static atomic_t allow_proceed = ATOMIC_INIT(1);
 
@@ -986,9 +986,9 @@ void hw_protection_shutdown(const char *reason, int ms_until_forced)
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

