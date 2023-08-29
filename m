Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFAC78C3DA
	for <lists+linux-pm@lfdr.de>; Tue, 29 Aug 2023 14:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbjH2MKJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Aug 2023 08:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbjH2MJr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2023 08:09:47 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D19198;
        Tue, 29 Aug 2023 05:09:44 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1c8cb3c9534so385534fac.1;
        Tue, 29 Aug 2023 05:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693310984; x=1693915784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WS785+RicHHjcIblAdA2mqb2YRvkxHKjPNYEbsxQkJk=;
        b=Q7pavGrIA/L5x4cpCq3yS+dlGPbRRNraIs/0QxGUiica8K3JBdAE/hWszPS88nekj3
         W9d5uy3f+2srUq6Vr+wPVm0YoeTveLjuHteLRwNxGQdqiiM/avhkNbv5ptI9RIGJcxur
         mYB1fTgbJ7oquTyVWITPacUAstH/n7cVUvmWZNF+TR0Wgsb/PJQpWmea29S9t0/JlrOZ
         oKMRGShI/3XFnNGHmJA2wxEriTPYYosGnmhIy9oHskymHY1Kh8Kc1NVsR5RuhpxyspVz
         Qad7kyv+PwmFIl/Gz+e2iUG8kH6XweTCvJSu1rKHOtbRu+I5Uf46QF13HP4dBfhcOe3b
         guJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693310984; x=1693915784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WS785+RicHHjcIblAdA2mqb2YRvkxHKjPNYEbsxQkJk=;
        b=KR0QgdXaMEVoEVmupCN7WmykvhQojT189zZ/Sw1PeREq6BCDavuTjK+jf4ERiJ7dBI
         DOPvtLScP6oSby6qSD3t6Ti5Z8FAh/4iqEyaZ0yG0cYEXM+mXYhcRJObBhKtfCP6Z8y5
         loAz0c3tE0mDXUDpB+XoA0DzICJR08aHlCcCeERNvaCjuYBYNV3j+qITTSXuSNbiIdeU
         OP61E8CxS6I+uD1yhwPoAZGuDdinUERfd/MVdy8CQ5XxCiB3tPgWykD1FS/i1hZMageM
         s0HTy4So5kyG8p4Ko06ZIMCvxa7MSIwjXVtJc9v/7wHI+SSYBtVycINZH+lmJ5dHbp9e
         D0lw==
X-Gm-Message-State: AOJu0Ywg9H96QZg3wQOe05jGLgn2vUUSNTs7Cb3TGv8KGS5mP3Y2tSUU
        f6T2fdRu9kMWGKxqj8jhoBY=
X-Google-Smtp-Source: AGHT+IGOEFoE5aadl4+2v4pvT5gb+yWh+WYIof932iNfRs675GbN1GgnHf0me/9rfgr8INK7rHyDPw==
X-Received: by 2002:a05:6870:7014:b0:1c8:bfd1:ecba with SMTP id u20-20020a056870701400b001c8bfd1ecbamr30515255oae.3.1693310983734;
        Tue, 29 Aug 2023 05:09:43 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:d5ec:d929:1621:6cc6])
        by smtp.gmail.com with ESMTPSA id zc17-20020a056871271100b001d0ad5205fesm2000651oab.7.2023.08.29.05.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 05:09:43 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH v4 3/3] thermal: thermal_core: Allow rebooting after critical temp
Date:   Tue, 29 Aug 2023 09:09:24 -0300
Message-Id: <20230829120924.1711175-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829120924.1711175-1-festevam@gmail.com>
References: <20230829120924.1711175-1-festevam@gmail.com>
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
Changes since v3:
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

