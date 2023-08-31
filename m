Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E78278EE05
	for <lists+linux-pm@lfdr.de>; Thu, 31 Aug 2023 15:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbjHaNDC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Aug 2023 09:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346312AbjHaNDB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Aug 2023 09:03:01 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1DAE42;
        Thu, 31 Aug 2023 06:02:58 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1c8cb3c9534so64615fac.1;
        Thu, 31 Aug 2023 06:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693486978; x=1694091778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVVIEObE/vLlSMr5jQ6Wbaih9jLFe07U23pYaKd+KLE=;
        b=kzUKmnY1znrc59nXPIT0QDgEouBKpvg0KQ5+pSmjPRQHvgg+rdRDAoKE6pi4ACC4K/
         Vaz7OA/ojSP9M5CNlpOaHs4DO2iC2ONwPmpge6KT/jTDfMY7MYrgoRQvaEUeLEL4cvW7
         dVhCJX+agQeI7r/exjA9EjXu8hE+/A4vrm10HcW6iT8/0p+5TGzR7KxGSKfPMrIW8hG8
         fK/JTngcewdxZuGHYgdQyiE1pT6C3BGAdstQm4uCiuiuIg9RHjpvgfGkLNfOtK0K9vkz
         gqJcbFIRVleXjMC2eolFRIyegmVOGCssOCC5i00ja2iH1VvsaW2uVplX1ps86HF5cbft
         +syg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693486978; x=1694091778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HVVIEObE/vLlSMr5jQ6Wbaih9jLFe07U23pYaKd+KLE=;
        b=V9fsSqBA4z6qUYAC07IeApfVEv1Ed38bxdg9uzbyCcXooDvGilc114vwxrwh0NwMoC
         6IpUGIQIS6Q5WBi1TM4rh31tYCMCGyZU697lHs8fXlNqRl2MHNYSD+7r+EIFcMlylDC7
         vwG+heoGCbP3k1DVoCV+ADj6br15H9otSY0UgSMGlqebEJMXarswhDhl3WzdSM8TScDE
         X9rZVJn5q4QLIdWbB74qtZa+ScVlTXlqZEmfK1a4IQSau8ZVGY5WdIdei5dA1SEKpAdK
         yH3r8TbA3LMKHqBJ6d6Wj/931gR2/7zEN/scLdNmRUINBk71YkQZKe28cQDbx91nvvOV
         9dZA==
X-Gm-Message-State: AOJu0Yym9x5ELbF8dw9RuF2xJef3I03aHMeBs9+CYWTUoJHgLX/uT9zv
        musoDUiK1mHxy2rvwLyryMw=
X-Google-Smtp-Source: AGHT+IHcFcU3HsaoqiFsprrJBO+xB45DxlK7vJKYdIivNWFebWGI/YMFaNDIa8gt9UhkyRY5jN1GlQ==
X-Received: by 2002:a05:6870:738e:b0:1a7:f79c:2fbc with SMTP id z14-20020a056870738e00b001a7f79c2fbcmr6072072oam.0.1693486977799;
        Thu, 31 Aug 2023 06:02:57 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:583a:68ca:f232:6448])
        by smtp.gmail.com with ESMTPSA id zh26-20020a0568716b9a00b001bfd65998aesm802155oab.58.2023.08.31.06.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 06:02:57 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH v7 3/3] thermal: thermal_core: Allow rebooting after critical temp
Date:   Thu, 31 Aug 2023 10:02:42 -0300
Message-Id: <20230831130242.2290502-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831130242.2290502-1-festevam@gmail.com>
References: <20230831130242.2290502-1-festevam@gmail.com>
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
Changes since v6:
- Removed unused variable.

 drivers/thermal/thermal_core.c |  6 +++++-
 drivers/thermal/thermal_of.c   | 16 ++++++++++++++++
 include/linux/thermal.h        |  6 ++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

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
index 4ca905723429..960bcc2a21bc 100644
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
@@ -516,6 +530,8 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
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

