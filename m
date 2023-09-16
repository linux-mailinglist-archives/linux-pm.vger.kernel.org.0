Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4599B7A2D23
	for <lists+linux-pm@lfdr.de>; Sat, 16 Sep 2023 03:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237926AbjIPBuR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Sep 2023 21:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238348AbjIPBtw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Sep 2023 21:49:52 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C381FE0;
        Fri, 15 Sep 2023 18:49:47 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a9e89fa553so527932b6e.1;
        Fri, 15 Sep 2023 18:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694828987; x=1695433787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ryaascUldLoAOMrQPhkWv4qVjJ1v1YO4kQEKKPJFhA=;
        b=lO0mKFihOkabIUaWxpRkIOR3V8hAuf7ZQrPCI6PM8tHSObJK8G6wPUOH+gpp53JwlE
         a/6QrRzMkW1ggKtxfooYWbAJm8ZaZvT79ijYNr34/Xik4r7baQOVQmvY0NjXI/doWWWn
         NQXucYBwDRWsQdKctE0yPis+0CpJ6CnJLZKCnbAKlwKi1nuNnDfzqlbJfoDC1gvyJACZ
         T9sl1WUg6xxq7w81FVbIQYr6chZK5DAf6QjPBVVjtzEKJegbiIKArfkhaD0B/ePLjcIA
         QHM/rCmsddK5FaTUsKh8hwISyO9dQp1vHIYELlzZfOZmpGrhSMIxKgwvN4st4iC3+WbI
         gGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694828987; x=1695433787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ryaascUldLoAOMrQPhkWv4qVjJ1v1YO4kQEKKPJFhA=;
        b=qViLB48Z87M9dN6AXdMjGHfq0CavJv8wyrBu7so6YxD/r4XWNf90efFq3P0G6Pri4F
         PmX1lRMNDM1do2Mr7VGWdp0U2tCw4nlW8R9aOpnMJNtS58ezMG5KYlmbhHFQeAtY6hjD
         eF1URK6HdKPky+TXGkIJ0abixSEFzvvS3V8kRCaIhajGcEQvvwcIs5WN/l2r4kL9mbR7
         6KxrZBccRjMOTCLAiHzSe2knALtnWXMJq7nIljYwGJvK4uvLWK+OB2i1fSjiEyn2KExu
         F6QbJMrBHnmwBUWbkQh4j89IkfwkCWLAy4Yu4MtfkXVuVft36/jvuzP7T+pfNuNhZKlJ
         9kuQ==
X-Gm-Message-State: AOJu0YybpXb4NEwu4TZLN2yW/1ckqWZmcdGxkyHRjfhzVdJSUM/y9aGW
        YZd5mxmYMhWetTa3OzXtHJY=
X-Google-Smtp-Source: AGHT+IFcAUQhaxv+LcXcq6oSqNf2OMuO3SZhklar+CrKheDOh5TQEBr3Gpor0PjrQF3WfedxbXz5hQ==
X-Received: by 2002:a05:6870:e393:b0:1b7:613c:2e30 with SMTP id x19-20020a056870e39300b001b7613c2e30mr3417770oad.2.1694828987210;
        Fri, 15 Sep 2023 18:49:47 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:bb17:c38c:aa6:be85])
        by smtp.gmail.com with ESMTPSA id eg38-20020a05687098a600b001c4b473581fsm2519986oab.12.2023.09.15.18.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 18:49:46 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH v8 3/3] thermal: thermal_core: Allow rebooting after critical temp
Date:   Fri, 15 Sep 2023 22:49:28 -0300
Message-Id: <20230916014928.2848737-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916014928.2848737-1-festevam@gmail.com>
References: <20230916014928.2848737-1-festevam@gmail.com>
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
		critical-action = "reboot";
	};

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v7:
- Search for the 'critical-action' property in the parent thermal-zone node. (Rafael)

 drivers/thermal/thermal_core.c |  6 +++++-
 drivers/thermal/thermal_of.c   | 16 ++++++++++++++++
 include/linux/thermal.h        |  6 ++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 0bdde1ab5d8b..bfa704516957 100644
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
index 4ca905723429..a1472a1965eb 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -218,6 +218,20 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
 	return tz;
 }
 
+static void thermal_of_get_critical_action(struct device_node *np,
+					   enum thermal_action *action)
+{
+	const char *action_string;
+	int ret;
+
+	ret = of_property_read_string(np->parent, "critical-action", &action_string);
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
@@ -516,6 +530,8 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 		goto out_kfree_trips;
 	}
 
+	thermal_of_get_critical_action(np, &tz->action);
+
 	ret = thermal_zone_device_enable(tz);
 	if (ret) {
 		pr_err("Failed to enabled thermal zone '%s', id=%d: %d\n",
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index eb17495c8acc..8ea761bead79 100644
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
@@ -183,6 +188,7 @@ struct thermal_zone_device {
 	struct list_head node;
 	struct delayed_work poll_queue;
 	enum thermal_notify_event notify_event;
+	enum thermal_action action;
 };
 
 /**
-- 
2.34.1

