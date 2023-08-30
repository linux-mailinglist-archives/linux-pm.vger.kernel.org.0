Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B86378DA13
	for <lists+linux-pm@lfdr.de>; Wed, 30 Aug 2023 20:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236645AbjH3SfZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Aug 2023 14:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245490AbjH3PTd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Aug 2023 11:19:33 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4F31A2;
        Wed, 30 Aug 2023 08:19:31 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6bf106fb6a0so984878a34.0;
        Wed, 30 Aug 2023 08:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693408770; x=1694013570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSPPfeRANMxNDziv72JSmTSauePb3uiAcgEWeqKDRLI=;
        b=TQHrzt7dWsl5U91KODm3ThMyElEs/7BgGSL4kU96wiVMkj8gIu+u6at6t+d42WcPU9
         9urfFEdlT9dSOgrhTuQ6I97cUKAsIGm097ty9jKfBMWoTUXQp/5YatVXdFS1sE6oKdbQ
         3jdh0cPgS6KptKKZkIjpFxMG43QkS1UEEar36pGkAq3yZwEf4xjor8jMQFE6kHeGrOKu
         l95mHwAlkvrMmSaek4PoqvYsT3ySXHn8ReBm7IQdIWg2u5teRfv6ILOOWsvA4U0fTDqQ
         Fp2WfmlJfBr8k+rMzPDQ8LnMyH1WlGju6HJO+gP1tYMkYbbdj4+/zKWrSCNA6r19NmtL
         i8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693408770; x=1694013570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zSPPfeRANMxNDziv72JSmTSauePb3uiAcgEWeqKDRLI=;
        b=Rt3Hli3TEiFY+cv4NC+T5H275s4hG6xZbQuwFqX6uUVANXPvBPxq+lLFJ5G6MVL9YI
         Jp1Bfh1PTSUJbWI0WtxB12lm1p+flbckh8B7jRBEqb2x6sxvsAltGqOCI3JPRN9LaRLb
         c47dIAIrSp+c2ptM4ZBOJygd1tqSMKZaW6/h6FHRcJofAYcOnwUDoXPONK2bqnoXNqTD
         RPt2IJYmubIrfUYzceyvlvIFCL4A/9BnUqUQwX5JzbiVl4X8bKD4mGlKtZ7mwyqPV8E7
         ZYJCdRpIKsafR5VULeVJL+ER/nDO+bN+9kM/1w4SMrwMU+DKaeBaNyQ7m/+rH+Siorvp
         pO4Q==
X-Gm-Message-State: AOJu0YyiXeGc3EUOncC/8GLc2Nc7p6fMe+ImrNagAuetOMdaABSjfUPi
        OGBHwlfDim1L7A+D5L3lWQAni58T1Jk=
X-Google-Smtp-Source: AGHT+IHlbwrt/wnoWeHfr/xmhmCu7oF7F7WEAyxfQTZAgDyYsorWIeGrnT6HVRR8EUozh9s2v9+pCw==
X-Received: by 2002:a05:6830:6d16:b0:6bd:990:1a2 with SMTP id dz22-20020a0568306d1600b006bd099001a2mr3212380otb.0.1693408770469;
        Wed, 30 Aug 2023 08:19:30 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:5158:34be:358c:6304])
        by smtp.gmail.com with ESMTPSA id d24-20020a056830139800b006b884bbb4f3sm5672559otq.26.2023.08.30.08.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 08:19:29 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH v6 3/3] thermal: thermal_core: Allow rebooting after critical temp
Date:   Wed, 30 Aug 2023 12:19:08 -0300
Message-Id: <20230830151908.2149847-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830151908.2149847-1-festevam@gmail.com>
References: <20230830151908.2149847-1-festevam@gmail.com>
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

Currently, the default mechanism is to trigger a shutdown after the
critical temperature is reached.

In some embedded cases, such behavior does not suit well, as the board may
be unattended in the field and rebooting may be a better approach.

The bootloader may also check the temperature and only allow the boot to
proceed when the temperature is below a certain threshold.

Introduce support for allowing a reboot to be triggered after the
critical temperature is reached.

If the "critical-action" devicetree property is not found, fall back to
the shutdown action to preserve the existing default behavior.

Tested on a i.MX8MM board with the following devicetree changes:

	thermal-zones {
		cpu-thermal {
			critical-action = "reboot";
		};
	};

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v5:
- Simplify thermal_of_get_critical_action(). (Rafael)

 drivers/thermal/thermal_core.c |  6 +++++-
 drivers/thermal/thermal_of.c   | 21 +++++++++++++++++++++
 include/linux/thermal.h        |  6 ++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index a59700593d32..062114608667 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -320,11 +320,15 @@ void thermal_zone_device_critical(struct thermal_zone_device *tz)
 	 * Its a must for forced_emergency_poweroff_work to be scheduled.
 	 */
 	int poweroff_delay_ms = CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS;
+	static const char *msg = "Temperature too high";
 
 	dev_emerg(&tz->device, "%s: critical temperature reached, "
 		  "shutting down\n", tz->type);
 
-	hw_protection_shutdown("Temperature too high", poweroff_delay_ms);
+	if (tz->action == THERMAL_CRITICAL_ACTION_REBOOT)
+		hw_protection_reboot(msg, poweroff_delay_ms);
+	else
+		hw_protection_shutdown(msg, poweroff_delay_ms);
 }
 EXPORT_SYMBOL(thermal_zone_device_critical);
 
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 4ca905723429..a644a896a617 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -218,6 +218,25 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
 	return tz;
 }
 
+static const char * const critical_actions[] = {
+	[THERMAL_CRITICAL_ACTION_SHUTDOWN]	= "shutdown",
+	[THERMAL_CRITICAL_ACTION_REBOOT]	= "reboot",
+};
+
+static void thermal_of_get_critical_action(struct device_node *np,
+					   enum thermal_action *action)
+{
+	const char *action_string;
+	int ret;
+
+	ret = of_property_read_string(np, "critical-action", &action_string);
+	if (ret < 0)
+		*action = THERMAL_CRITICAL_ACTION_SHUTDOWN;
+
+	if (!strcasecmp(action_string, "reboot"))
+		*action = THERMAL_CRITICAL_ACTION_REBOOT;
+}
+
 static int thermal_of_monitor_init(struct device_node *np, int *delay, int *pdelay)
 {
 	int ret;
@@ -516,6 +535,8 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 		goto out_kfree_trips;
 	}
 
+	thermal_of_get_critical_action(np, &tz->action);
+
 	ret = thermal_zone_device_enable(tz);
 	if (ret) {
 		pr_err("Failed to enabled thermal zone '%s', id=%d: %d\n",
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index b449a46766f5..b68e5734823d 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -34,6 +34,11 @@ struct thermal_cooling_device;
 struct thermal_instance;
 struct thermal_attr;
 
+enum thermal_action {
+	THERMAL_CRITICAL_ACTION_SHUTDOWN = 0, /* shutdown when crit temperature is reached */
+	THERMAL_CRITICAL_ACTION_REBOOT, /* reboot when crit temperature is reached */
+};
+
 enum thermal_trend {
 	THERMAL_TREND_STABLE, /* temperature is stable */
 	THERMAL_TREND_RAISING, /* temperature is raising */
@@ -187,6 +192,7 @@ struct thermal_zone_device {
 	struct list_head node;
 	struct delayed_work poll_queue;
 	enum thermal_notify_event notify_event;
+	enum thermal_action action;
 };
 
 /**
-- 
2.34.1

