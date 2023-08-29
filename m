Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88C678CD1A
	for <lists+linux-pm@lfdr.de>; Tue, 29 Aug 2023 21:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjH2TmV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Aug 2023 15:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjH2TmR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2023 15:42:17 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93412CC;
        Tue, 29 Aug 2023 12:42:14 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6bb1133b063so516214a34.1;
        Tue, 29 Aug 2023 12:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693338134; x=1693942934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CnFKgZAwucJ065KYoJ1cdZyJhgPG4k9NfUZYcn8fZ8=;
        b=MK6Lm8+SyD077uGb4A6W7UleQJdHlYmjVwE0Xcqf5R2Sd8n3cE8z4nJb9S191Oe0LO
         LaldQcukkDwQOfVF7WZQcWVESsPfGWXNi3Vw3Ccxh/AYRNFbnkFR/cQrTtjstmuSLbhD
         ZcOnl6TvZcBP+OlmMeyCS4W3geCgyMorGstbh0JHS8qR8EIz6UdG7hny/YUcl6yOVPvC
         R/8akHF1Qc79qm4T4xRryJf8bTL/KbsXzK+61u3oxv8qwE61jfRjbqvg9oe5ySB3FwV8
         AW3DmfRu6hwAtlX0FiDKIabw8kYrV272JaDVBXBVFwVc31/74/ZI/v8tZ0FGBxwSY/iH
         n7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693338134; x=1693942934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3CnFKgZAwucJ065KYoJ1cdZyJhgPG4k9NfUZYcn8fZ8=;
        b=LWBUxNFl8X0ymyOUpjAljsq3UEHa149WR7iYSyvrcMZaKAeYxE+G9rWKMzmXsM+jG3
         1A/CEvI0QIxBc9pGfSU1GVPbxcUHxSqCZllaoMEGA5H6dLeb7mmeWnqjuAy9e7g0CIg8
         2yu0D+G8rqJK1oyH5XdYY5Ru/zWOw5oWI0nXt1W/Yoe71b9MT3fTm0aYWYR1SCLWVYHF
         WmgsahFBOR4wB1LrKh9pxwNrnN+bonNsaYfMQah93YGwJwfBiMh0CLBuUtTKQEWlz3eV
         dQouxcd9ixYuFH/8fjroLPuMYGcSkDnLrbc1dOWdOvWZ3Rh5MUpns1WSTWUW9sUYcrB1
         S8VQ==
X-Gm-Message-State: AOJu0YwzllTv2U/tQah6Z1bx9aSYduKIagMQh8DqwWcDrJIjxZEv7qlB
        K9oiRdr7KrT6+gEWza2+Z/c=
X-Google-Smtp-Source: AGHT+IH+BInRWvBcHrLGkA3bTOk5HRNqBkDHkntkAbfYISNRKwX6hG+qY8z+Y9saBAzLyCZwgM/Yzw==
X-Received: by 2002:a05:6830:6e18:b0:6b9:f169:99d with SMTP id ec24-20020a0568306e1800b006b9f169099dmr61699otb.2.1693338133899;
        Tue, 29 Aug 2023 12:42:13 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:d5ec:d929:1621:6cc6])
        by smtp.gmail.com with ESMTPSA id c21-20020a9d7855000000b006b9848f8aa7sm4905457otm.45.2023.08.29.12.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 12:42:13 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH v5 3/3] thermal: thermal_core: Allow rebooting after critical temp
Date:   Tue, 29 Aug 2023 16:42:00 -0300
Message-Id: <20230829194200.1901988-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829194200.1901988-1-festevam@gmail.com>
References: <20230829194200.1901988-1-festevam@gmail.com>
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
Changes since v4:
- Simplify the logic inside thermal_zone_device_critical(). (Rafael)
- Declare THERMAL_CRITICAL_ACTION_SHUTDOWN = 0 so it is clear what happens
on non-DT platforms. (Rafael)

 drivers/thermal/thermal_core.c |  6 +++++-
 drivers/thermal/thermal_of.c   | 27 +++++++++++++++++++++++++++
 include/linux/thermal.h        |  6 ++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

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
index 4ca905723429..8bc28cba7406 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -218,6 +218,31 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
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
+	int i, ret;
+
+	ret = of_property_read_string(np, "critical-action", &action_string);
+	if (ret < 0)
+		goto out_default_action;
+
+	for (i = 0; i < ARRAY_SIZE(critical_actions); i++)
+		if (!strcasecmp(action_string, critical_actions[i])) {
+			*action = i;
+			return;
+		}
+
+out_default_action:
+	*action = THERMAL_CRITICAL_ACTION_SHUTDOWN;
+}
+
 static int thermal_of_monitor_init(struct device_node *np, int *delay, int *pdelay)
 {
 	int ret;
@@ -516,6 +541,8 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
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

