Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADCB78B2C3
	for <lists+linux-pm@lfdr.de>; Mon, 28 Aug 2023 16:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjH1OOb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Aug 2023 10:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjH1OOW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2023 10:14:22 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73695E7;
        Mon, 28 Aug 2023 07:14:19 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1d0b00d68c7so120628fac.0;
        Mon, 28 Aug 2023 07:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693232058; x=1693836858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRGlx8xWsboOHpufKI6wY/4OuATN1MLCGFA2VszRVGU=;
        b=PqgW8RpvkpLrUQiws7TMN56R66jc6o3nmo1EhWd/EAqbFl19Zl0eJhFGYtW2obS9iC
         QrHOKjneeHH95LO+3UsDAIvWXYT1W9cImyZ8Jjfhs7kk/U4SxCogptdLEZhmhU3ZOsI2
         mmXboR1xSz2q7KUEin1lc+aKrq5y8UzwIa6TBvlI2Z9Zu0pBaMrcSUuHnMc9g1WebUU+
         /3cQAZw9xeHl/4iG/ALzdGZaHFfb9iXvVfP5/BhQ4o4FURnM0RiYw+4RVF4OO1wBYEGW
         9FRCFr9dnpyHbxL/qG9KKJ++u8n1/TSIxW0itpvp3mZSh+ePjN/HH0giqUWAWC3FJt1Q
         vUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693232058; x=1693836858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRGlx8xWsboOHpufKI6wY/4OuATN1MLCGFA2VszRVGU=;
        b=OE+Mo9YUFNGET0XhDQrR6sy5Yu16FoZrLMh/8w0bR+P1OxUZPHsZPiIMZyWwBIuGrt
         nMQyA0HoWGXTESc1ud7Wcb9xNwr/v2NtdYO+omWpumlHLSEJ7CrAmL4ia7CHagBSvD/g
         lWbTW8dHqDh+f1K9wet4qAnVtozF4EFZvRn6fSH68oNtDIkuVNdthNUWHzLPixPytt1b
         LNi7EH+xE2IKa7TDdZ1uuJO1+1tNSaotgr40m0opH/UYedlgkVghDyLklbUr7wlur+sw
         7GMOZRTzv3za7z2+QKJXziD9qQKPXjIoRlnfORQ2rHSmRnuRpL2mOm0ic1K9iW9TRWU7
         pi6w==
X-Gm-Message-State: AOJu0YxEPu2YhD2X7Bedn9dpe7LHplC/w7MSOytGGZPI7kI2CoiqMieN
        mJZuhmKQpmfrgWNmyVtzvqU=
X-Google-Smtp-Source: AGHT+IGsJapNBbY7F7ja/6NfrS2C7BeWFYmKBy7J34p3kgFOHor0KWNPutN2xN3Vnr4vEHV//zw0CA==
X-Received: by 2002:a05:6870:828d:b0:1c8:b870:4e5e with SMTP id q13-20020a056870828d00b001c8b8704e5emr28983262oae.3.1693232058505;
        Mon, 28 Aug 2023 07:14:18 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:3c37:a69d:a4cd:94fc])
        by smtp.gmail.com with ESMTPSA id l5-20020a056870e90500b001c4ede43955sm4323892oan.31.2023.08.28.07.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 07:14:18 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 3/3] thermal: thermal_core: Allow rebooting after critical temp
Date:   Mon, 28 Aug 2023 11:13:41 -0300
Message-Id: <20230828141341.1583591-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230828141341.1583591-1-festevam@gmail.com>
References: <20230828141341.1583591-1-festevam@gmail.com>
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
Changes since v1:
- Adapt to handle 'critical-changes' property as string.

 drivers/thermal/thermal_core.c |  8 +++++++-
 drivers/thermal/thermal_of.c   | 27 +++++++++++++++++++++++++++
 include/linux/thermal.h        |  6 ++++++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index a59700593d32..f69e1667acb1 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -320,11 +320,17 @@ void thermal_zone_device_critical(struct thermal_zone_device *tz)
 	 * Its a must for forced_emergency_poweroff_work to be scheduled.
 	 */
 	int poweroff_delay_ms = CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS;
+	void (*hw_protection_action)(const char *reason, int ms_until_forced);
 
 	dev_emerg(&tz->device, "%s: critical temperature reached, "
 		  "shutting down\n", tz->type);
 
-	hw_protection_shutdown("Temperature too high", poweroff_delay_ms);
+	hw_protection_action = hw_protection_shutdown;
+
+	if (tz->action == THERMAL_CRITICAL_ACTION_REBOOT)
+		hw_protection_action = hw_protection_reboot;
+
+	hw_protection_action("Temperature too high", poweroff_delay_ms);
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
index b449a46766f5..08854f640db9 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -34,6 +34,11 @@ struct thermal_cooling_device;
 struct thermal_instance;
 struct thermal_attr;
 
+enum thermal_action {
+	THERMAL_CRITICAL_ACTION_SHUTDOWN, /* shutdown when crit temperature is reached */
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

