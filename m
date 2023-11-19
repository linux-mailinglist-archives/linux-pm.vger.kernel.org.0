Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DF57F064B
	for <lists+linux-pm@lfdr.de>; Sun, 19 Nov 2023 14:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjKSNGG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Nov 2023 08:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjKSNGF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Nov 2023 08:06:05 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC8D138;
        Sun, 19 Nov 2023 05:06:01 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6cb79883b7fso155922b3a.1;
        Sun, 19 Nov 2023 05:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700399161; x=1701003961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENUasGHTRIrAkUvNkBNrZAWbqtv5P6bCOPtQDUVFnSM=;
        b=Xx5jiKa7ScQ2H1/nDoOobviettzE49/94WEXlL3rhNNaCmA5LSuxFBg94p2wgISfaC
         OX0oho6Ey86HiZs6x/Sm8U6UQ0dLDm9dHNSvU2WHzzEtknNF8BhipUp5kRiQNC635ey9
         rJbaiqTJNCi3bTHgS5ttikwo9TfmBTpTquEx7Y39NsTOkBREuee4mGhQWFQSVx4MUxHW
         lO4/bSgsydaEwG23Z1fOSzWh4oUJHLMT6PmEJifAZIBiqfZbBWhHTmwHr6UpfTGTjZ3+
         mZtgOD7R+I68lAgFvHZ7SK86xSmV+7uGYDjxP7y6szBqDWEk5gsdDV5lM4dvQseRsDCb
         vFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700399161; x=1701003961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENUasGHTRIrAkUvNkBNrZAWbqtv5P6bCOPtQDUVFnSM=;
        b=bFaNaeXh78sRzZJU3VIoWmLDQS4ZpR138XS2U9SsenM41EmyPrGnw+kxaeJ4Eh8VjN
         l4bzUz52pc4X0VAs/XNdIeKWF329rzV55ALrL0ZA8yOpFoJ6AM8pZRtGEVe8LZLSVuTO
         k5MiA07S5GaxscIbSzcLiHYvTHct8UJSry05rzTIIViqusGi1BJqZYwwH17u1HtUFNc4
         6d6y7Ohi49JtIxtstueL0Lh3p6aRJHmXaiVtwtKi3G6OAX+6UHMJ45rB2O+YBZd/a8O0
         ZnZBijFxd040auE0rJ5aT2ZkNtHN3Ol/IRrS23tNEU3gXvekKJZWCCzMVPlSNt4fNtPy
         rnfQ==
X-Gm-Message-State: AOJu0YzF5lGGPVoH7wOdDiG3QU0l870xG4u5/hYihfedE/Z1OUlU24Bq
        EvWAl3hJqHXEP7qbpxXf81c=
X-Google-Smtp-Source: AGHT+IFKtWLk1jBgzeZgTFpvbr1KgVTbLNvKSynR52IsQ7v9P4YfG7STY3NV3MRnMlZ2RHiroW6BSQ==
X-Received: by 2002:a17:903:2448:b0:1ce:ca8:74d5 with SMTP id l8-20020a170903244800b001ce0ca874d5mr6602177pls.1.1700399161137;
        Sun, 19 Nov 2023 05:06:01 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:8afe:6d39:e955:7d2a])
        by smtp.gmail.com with ESMTPSA id ik14-20020a170902ab0e00b001bde65894c8sm4433696plb.268.2023.11.19.05.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 05:06:00 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org, mazziesaccount@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>
Subject: [PATCH v11 2/4] thermal_core: Prepare for introduction of thermal reboot
Date:   Sun, 19 Nov 2023 10:05:49 -0300
Message-Id: <20231119130551.2416869-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231119130551.2416869-1-festevam@gmail.com>
References: <20231119130551.2416869-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Changes since v10:
- None

 drivers/thermal/thermal_core.c | 14 ++++++++++----
 include/linux/reboot.h         |  7 ++++++-
 kernel/reboot.c                |  8 ++++----
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 9c17d35ccbbd..8c808ff9ddfe 100644
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

