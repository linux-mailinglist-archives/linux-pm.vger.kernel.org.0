Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B04278B8EF
	for <lists+linux-pm@lfdr.de>; Mon, 28 Aug 2023 22:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbjH1UAt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Aug 2023 16:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbjH1UAN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2023 16:00:13 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FDECCF;
        Mon, 28 Aug 2023 12:59:40 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6bca018afe8so943922a34.0;
        Mon, 28 Aug 2023 12:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693252780; x=1693857580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3vGlWUaAYCJUCQ/766koKoxjA/r8oAudfQqyi82XgI=;
        b=FaDJiFoE0NFwvf4LJlKqVbqfmi97PjYAwp/ni/QOevXBq2lSwC/Xe+jf++hoJLgqsq
         N3kX4Vy3jR20nH8h4eA9Xxm1y0vGdl9+aq9ZU5mcWJJtM/Snc7ey8a8/O6tkokZpyLai
         sk3ROoIOnrX5bfFV5r5o5slOvhMwOA6aLopoZsn+LzoFSMpLOIGa1bpoiIKdfd95XPqR
         OeVhy+Nh/v3uhElIP9ujNF8Q0UdYPbg6WT0R3/UcoYeRXxQTl/ZaR8Dqdj6R6ER9MJ5O
         bZXtfjRJL8kOK1HuWbgKbUzlshR8I3u0D7gVeeDDHD9/ees75T8lXhgsC+ajPoNCPNtx
         RAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693252780; x=1693857580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3vGlWUaAYCJUCQ/766koKoxjA/r8oAudfQqyi82XgI=;
        b=Lyci9yS/u92vqU9TwEeo2nVXyOA2j18V/I1qfrF5IQmGu95hz37h2KwDk9c6v7ZDgx
         52rpRswA0fCUK7yAOWxcfnk+xobIR18jJw9xbjlSOFfNd4g6Wwy6z4VuKfSyFeFYgLjv
         r8EhUsy0OYYQphu1p2RZ2CLPkAc5hmmnZ/U/z3FAAfdEJ8ylqHItrRWvCtZHPo1LVRe1
         bvXCWT9TSRDDuhraVIaxmrmlKaj6HQwL64/C978upCg+dppg3oyC+axDi/k1gygxUdZ2
         QgrODpGtmNIA7hWJRblJRH2BUnY2pyYafAb2rfGfrBmyGiGtx20M/puqD4KXHxCsGDuO
         A8Lg==
X-Gm-Message-State: AOJu0Yz/o0dC0WIGpYd+UHCj9Sj6T2bY/BDBMGEOdnyaNrB8+jjShdM6
        +AYrr+5Oc26E7GaQaYWxPoAxukiM1BM=
X-Google-Smtp-Source: AGHT+IFkU98/VOHNtBJznN2IP+X6jC2asNOB3FiUGPptcXIMwS33Xppsv4sj3AfECf4HgdMSZ5UCEQ==
X-Received: by 2002:a05:6808:2e93:b0:3a7:7366:7523 with SMTP id gt19-20020a0568082e9300b003a773667523mr30900914oib.3.1693252779779;
        Mon, 28 Aug 2023 12:59:39 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:3c37:a69d:a4cd:94fc])
        by smtp.gmail.com with ESMTPSA id k24-20020a544698000000b003a9a2362f66sm2254341oic.16.2023.08.28.12.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 12:59:39 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH v3 3/3] thermal: thermal_core: Allow rebooting after critical temp
Date:   Mon, 28 Aug 2023 16:59:02 -0300
Message-Id: <20230828195902.1645169-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230828195902.1645169-1-festevam@gmail.com>
References: <20230828195902.1645169-1-festevam@gmail.com>
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
Changes since v2:
- None.

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

