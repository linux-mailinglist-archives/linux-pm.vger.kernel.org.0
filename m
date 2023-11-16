Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA5E7EE94B
	for <lists+linux-pm@lfdr.de>; Thu, 16 Nov 2023 23:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjKPW3h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Nov 2023 17:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjKPW3f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Nov 2023 17:29:35 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F27B2
        for <linux-pm@vger.kernel.org>; Thu, 16 Nov 2023 14:29:28 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5c5daf2baccso3973717b3.3
        for <linux-pm@vger.kernel.org>; Thu, 16 Nov 2023 14:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700173767; x=1700778567; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wCh9SVmlxV8iSfQqkpg+zJJ3iZh5ZfIYHEkLVt/OL10=;
        b=hL211ETfwubiVLWAAKZZrk3mOMc8jg0mxxIk9kdYChVhji/qSbwTz0guU1PLMJJzb+
         nquThG02USBDYz2JlX+wU2xSIKlWMx2BA9w9R8VARQu3O3895ZPRAUurk2hVUdqeBd1t
         imRkQd5YHmIE3UxYFfEf3lY3FZBwSX9geFC81AYdp855D4DxkTpU+NlGpOKZsQzkRtw+
         gVpUU0FAYUk7gKtd20dhFHk3yNSXYClRRx1FkltAvfXbklGtNghOKZv1CWZpgH3QE1CM
         N/beVUuLQyATOMUuZ3lSMNBsg7DNfzQErqwNqu0jwSERe1JJBQk2x2NBid6OFKjl6bqE
         FYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700173767; x=1700778567;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wCh9SVmlxV8iSfQqkpg+zJJ3iZh5ZfIYHEkLVt/OL10=;
        b=mLTBdRXN1sAXpbYJ9x9LmtESBfZR3zlaIoIdWIBY1Hl8fJxQRJ6v9HL9WCQxdDoU+p
         Hutcl2kNGg+j+wNR73n+WnYfo7N89XeYtB3WJbsgVaTT/+T9w7oc+1JHYa6cuqtS5QEC
         s3Oy+AzVZE7nRwml3qJpjRhp7YG0EiLMz/v/0XivbVK0l0wYpvnSLVFl210OiMCGAooV
         8c/MENCu86Zcyu0tSNNMYseei9VIqLnImYnlyK3rXsDBYkiE/GyCX0GOV8jMqbLhOi8O
         tiEN2drbIgwFwMs/MMoj3cJ1LyNk/ylNaSh5KGgCG/ggH67fifL/+lhwp6gydXiE8QBA
         /PRQ==
X-Gm-Message-State: AOJu0YwsswDq9pSUy5i0KflWz9xGqxqTDlzvSwwo9JAq0Yi3s7zFxlPu
        Q8wtBRsu1f076+KH8HjOrcBpKbFmnMMyNrhs0le5vzVwcypN70Tyv2FKtbvcOWs42P6e+x7eaVR
        28V/XF6ATTUBSHqVsUdl0T+JO3CoBSFZZrQvQadiI6NDwBnLas+4FUoR4l3QxWpfe36unmOjl
X-Google-Smtp-Source: AGHT+IH+TjqJunEdee7R3xMUQFuTn0Tq03RWI6RWZSOJ67tG5nAs+m21p833yXvAZono/IY8W8ap7aEGugOPULA=
X-Received: from tessier.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5422])
 (user=radusolea job=sendgmr) by 2002:a81:49ca:0:b0:59b:e97e:f7df with SMTP id
 w193-20020a8149ca000000b0059be97ef7dfmr449226ywa.2.1700173767326; Thu, 16 Nov
 2023 14:29:27 -0800 (PST)
Date:   Thu, 16 Nov 2023 14:28:42 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231116222842.2121193-1-radusolea@google.com>
Subject: [PATCH RESEND] thermal core: add option to run PM_POST_SUSPEND asynchronously
From:   Radu Solea <radusolea@google.com>
To:     linux-pm@vger.kernel.org
Cc:     rafael@kernel.org, Radu Solea <radusolea@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some thermal zones are bus connected and slow to resume, thus
delaying actions which depend on completion of PM_POST_SUSPEND.
Add optional execution path to resume thermal zones on the system
unbounded workqueue.

Signed-off-by: Radu Solea <radusolea@google.com>
---
 drivers/thermal/Kconfig        | 11 +++++++
 drivers/thermal/thermal_core.c | 58 ++++++++++++++++++++++++++++++----
 2 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 19a4b33cb564..8dbcc62ccf8a 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -91,6 +91,17 @@ config THERMAL_WRITABLE_TRIPS
 	  Say 'Y' here if you would like to allow userspace tools to
 	  change trip temperatures.
 
+config THERMAL_ASYNC_RESUME
+	bool "Thermal async init zones on system resume"
+	default n
+	help
+	  Re-initialize thermal zones asynchronously on system resume.
+	  Thermal zone sensors may be attached on slow buses, impacting
+	  the duration of PM_POST_SUSPEND. If that is a concern enable
+	  this switch.
+
+	  If in doubt, say N.
+
 choice
 	prompt "Default Thermal governor"
 	default THERMAL_DEFAULT_GOV_STEP_WISE
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 842f678c1c3e..5794832e4223 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -21,6 +21,10 @@
 #include <linux/of.h>
 #include <linux/suspend.h>
 
+#ifdef CONFIG_THERMAL_ASYNC_RESUME
+#include <linux/workqueue.h>
+#endif /* CONFIG_THERMAL_ASYNC_RESUME */
+
 #define CREATE_TRACE_POINTS
 #include "thermal_trace.h"
 
@@ -41,6 +45,10 @@ static atomic_t in_suspend;
 
 static struct thermal_governor *def_governor;
 
+#ifdef CONFIG_THERMAL_ASYNC_RESUME
+struct work_struct *resume_thermal_zones_wk;
+#endif /* CONFIG_THERMAL_ASYNC_RESUME */
+
 /*
  * Governor section: set of functions to handle thermal governors
  *
@@ -1495,26 +1503,53 @@ struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name)
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_zone_by_name);
 
-static int thermal_pm_notify(struct notifier_block *nb,
-			     unsigned long mode, void *_unused)
+static inline void resume_thermal_zones(void)
 {
 	struct thermal_zone_device *tz;
 
+	list_for_each_entry(tz, &thermal_tz_list, node) {
+		if (!thermal_zone_device_is_enabled(tz))
+			continue;
+
+		thermal_zone_device_init(tz);
+		thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+	}
+}
+
+#ifdef CONFIG_THERMAL_ASYNC_RESUME
+static void thermal_resume_work_fn(struct work_struct *work)
+{
+	resume_thermal_zones();
+}
+
+static inline void thermal_resume_enqueue(void)
+{
+	INIT_WORK(resume_thermal_zones_wk, thermal_resume_work_fn);
+	queue_work(system_unbound_wq, resume_thermal_zones_wk);
+}
+#endif /* CONFIG_THERMAL_ASYNC_RESUME */
+
+static int thermal_pm_notify(struct notifier_block *nb,
+			     unsigned long mode, void *_unused)
+{
 	switch (mode) {
 	case PM_HIBERNATION_PREPARE:
 	case PM_RESTORE_PREPARE:
 	case PM_SUSPEND_PREPARE:
+#ifdef CONFIG_THERMAL_ASYNC_RESUME
+		flush_work(resume_thermal_zones_wk);
+#endif /* CONFIG_THERMAL_ASYNC_RESUME */
 		atomic_set(&in_suspend, 1);
 		break;
 	case PM_POST_HIBERNATION:
 	case PM_POST_RESTORE:
 	case PM_POST_SUSPEND:
 		atomic_set(&in_suspend, 0);
-		list_for_each_entry(tz, &thermal_tz_list, node) {
-			thermal_zone_device_init(tz);
-			thermal_zone_device_update(tz,
-						   THERMAL_EVENT_UNSPECIFIED);
-		}
+#ifdef CONFIG_THERMAL_ASYNC_RESUME
+		thermal_resume_enqueue();
+#else /* CONFIG_THERMAL_ASYNC_RESUME */
+		resume_thermal_zones();
+#endif /* CONFIG_THERMAL_ASYNC_RESUME */
 		break;
 	default:
 		break;
@@ -1530,6 +1565,15 @@ static int __init thermal_init(void)
 {
 	int result;
 
+#ifdef CONFIG_THERMAL_ASYNC_RESUME
+	resume_thermal_zones_wk = kmalloc(sizeof(*resume_thermal_zones_wk),
+					GFP_KERNEL);
+	if (!resume_thermal_zones_wk) {
+		result = -ENOMEM;
+		goto error;
+	}
+#endif /* CONFIG_THERMAL_ASYNC_RESUME */
+
 	result = thermal_netlink_init();
 	if (result)
 		goto error;
-- 
2.41.0.694.ge786442a9b-goog

