Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1727884E5
	for <lists+linux-pm@lfdr.de>; Fri, 25 Aug 2023 12:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238344AbjHYK0c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Aug 2023 06:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244533AbjHYK0S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Aug 2023 06:26:18 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF14910FE;
        Fri, 25 Aug 2023 03:26:04 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6b9da57da6bso156806a34.0;
        Fri, 25 Aug 2023 03:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692959164; x=1693563964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9azgcCXgqiRFUl4vyzLhtNKVKo7gKBAaH9EMvhMpt4=;
        b=XRhOaQPAl+L3XziAPcFs54/7EiNlc4yq6eRhzTEilcz2Eywmj7ZgZ2GhMD17V+R5Rk
         kW0FRS0isgOLsl9JM5yL19/1ne2oXI3z1KgvhEpk5VDhhXk0jRYMuVocsRrFp3gpVIi9
         lT3A6JLuqevJbnH628cb81WIWp+zHODcx9Fn904Qi3q8IkhDQZ2Raglp2N4lam9mcAMv
         cODCRr19efyW/juo/XuE+8t7ZxgMz1qM/Vyy6Xs10WpnSqIsk/uvFhstwJwtzRGA4H87
         mLXZXGAZuNo034+eY2zvmD3gA4xI1dx0OdZAH6UQh8o8gpmZWshTOE+D3FEy5402UOUz
         bukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692959164; x=1693563964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9azgcCXgqiRFUl4vyzLhtNKVKo7gKBAaH9EMvhMpt4=;
        b=KusU9/WYDTisLHzkHNdMQU0M2zJBkVKA7eFPSzHmsIUS7h5yhl3nm8Vk2l/Pu0gGog
         5nR+PJMPyNszc6VhVLvbyVxJVLRlVVZ2hNYhig+hWQ0D40EqyXhxpltOF9318Jir68GN
         jxa3x+DaJEYA9SuSNyWkrvXLitdKgE0QkOTyp2BazxYpmHswX+1gPtU0mbJr2/80qFRl
         HpOMiCAd9tP21e0etWUH+TUFQEqqmaSQoRe48D7mYLCvsnXg/HUGa5lYDHRHU1TB2q0V
         /Vw5iLjhqAeWEiGU0t8YT2hhxePhBcsftGw5aqIaUvvc/b+aUMlf+hj5Ry5dh/Iqrd0l
         Eq3g==
X-Gm-Message-State: AOJu0YxBgYoxCiZUfVnLk2lmprGa5KulQDP04PtqMVA6eqvP4VMujwqb
        W/OutCP0n/9pypO5VFFlTdY=
X-Google-Smtp-Source: AGHT+IGRE3xdG9eJUNQkncvKw8mh3uS6wgVtC/h7H4Mesn6ZdUH0yOkkT8ycHg9qcwLTE3iYRoxg/Q==
X-Received: by 2002:a05:6870:6124:b0:1b7:5e47:5b75 with SMTP id s36-20020a056870612400b001b75e475b75mr19769452oae.4.1692959163924;
        Fri, 25 Aug 2023 03:26:03 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:3d89:37d3:ba11:1a82])
        by smtp.gmail.com with ESMTPSA id eb37-20020a056870a8a500b001bf3942ea12sm835916oab.1.2023.08.25.03.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 03:26:03 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH 4/4] thermal: thermal_core: Allow rebooting after critical temp
Date:   Fri, 25 Aug 2023 07:24:53 -0300
Message-Id: <20230825102453.836627-4-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825102453.836627-1-festevam@gmail.com>
References: <20230825102453.836627-1-festevam@gmail.com>
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

Tested on a i.MX8MM board with the following devicetre changes:

	thermal-zones {
		cpu-thermal {
			critical-action = <THERMAL_CRITICAL_ACTION_REBOOT>;
		};
	};
	
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 drivers/thermal/thermal_core.c |  8 +++++++-
 drivers/thermal/thermal_of.c   | 17 ++++++++++++++---
 include/linux/thermal.h        |  6 ++++++
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index cc2b5e81c620..3f4ea27560f8 100644
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
index 330690a3a208..36a2c82d3405 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -218,7 +218,8 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
 	return tz;
 }
 
-static int thermal_of_monitor_init(struct device_node *np, int *delay, int *pdelay)
+static int thermal_of_monitor_init(struct device_node *np, int *delay,
+				   int *pdelay, int *critical_action)
 {
 	int ret;
 
@@ -234,6 +235,14 @@ static int thermal_of_monitor_init(struct device_node *np, int *delay, int *pdel
 		return ret;
 	}
 
+	/*
+	 * If the "critical-action" property is not found, fall back to
+	 * the shutdown action to keep the existing behavior.
+	 */
+	ret = of_property_read_u32(np, "critical-action", critical_action);
+	if (ret < 0)
+		*critical_action = THERMAL_CRITICAL_ACTION_SHUTDOWN;
+
 	return 0;
 }
 
@@ -471,7 +480,7 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 	struct thermal_zone_params tzp = {};
 	struct thermal_zone_device_ops *of_ops;
 	struct device_node *np;
-	int delay, pdelay;
+	int delay, pdelay, critical_action;
 	int ntrips, mask;
 	int ret;
 
@@ -494,7 +503,7 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 		goto out_kfree_of_ops;
 	}
 
-	ret = thermal_of_monitor_init(np, &delay, &pdelay);
+	ret = thermal_of_monitor_init(np, &delay, &pdelay, &critical_action);
 	if (ret) {
 		pr_err("Failed to initialize monitoring delays from %pOFn\n", np);
 		goto out_kfree_trips;
@@ -516,6 +525,8 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 		goto out_kfree_trips;
 	}
 
+	tz->action = critical_action;
+
 	ret = thermal_zone_device_enable(tz);
 	if (ret) {
 		pr_err("Failed to enabled thermal zone '%s', id=%d: %d\n",
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index dee66ade89a0..48f29ab16218 100644
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
@@ -185,6 +190,7 @@ struct thermal_zone_device {
 	struct list_head node;
 	struct delayed_work poll_queue;
 	enum thermal_notify_event notify_event;
+	enum thermal_action action;
 };
 
 /**
-- 
2.34.1

