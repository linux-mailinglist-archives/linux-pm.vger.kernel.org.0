Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3F97602E1
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jul 2023 01:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjGXXAc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jul 2023 19:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjGXXAb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jul 2023 19:00:31 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA6D115
        for <linux-pm@vger.kernel.org>; Mon, 24 Jul 2023 16:00:30 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-55c7bb27977so4348811a12.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Jul 2023 16:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690239630; x=1690844430;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ef0FQIHH5u9yTQ5cgLQKVEsKFhG9dUm/hIqvrCIGtLA=;
        b=NkYRhDO3JbZCCXMQo/dv6hXh21DJcS68yKATQtHLpbEZ5ldgp4KXn7mSG+YgvjX01F
         ZLtFl9FNAHWu5frRzRoErJw3Xlew8vgAVPK8133S8wD775qzkMY4nzi5fc2kaoDmEzwm
         0jp7n2JA6dl9FEI36lAjLny20jKDP5P3DNf1W9Fkk1sNKhD7QVDNz2Qus26hv3qvarqd
         SprwcP8d+3JodojdnK6jzB2Wo+HiY5M6cCDM9kG1bXdmhlAL9dkN+eh7V7PDwND7ax0x
         6+2muAjc6DVvA/LIwJ3oaKe7/CsgH+1Uil5xx8QofqIXmivrr89/85xZMaKVLsccSiXB
         1GEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690239630; x=1690844430;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ef0FQIHH5u9yTQ5cgLQKVEsKFhG9dUm/hIqvrCIGtLA=;
        b=HbQp3u71QfNko45nsszSXEV15ozSMhvVwCVovK4VeHjmxckUInePQ8AndzR6Z7kGWZ
         ApzUnwddNcX0LfvftyAvnxaKEVhmftJt5N+tFJ63vzqWu8G/Izm0wiXxKCXsKLpRYVUI
         /pFW6Aq3l2aUWgDc9bum5HCaC1Ffed2XS4NJabxKgTz+0nPc5GAK+7wtNG/Xnjyq1qtl
         j/CQI+ATj/9ZUjGIs9sUe6lmpfm+E/HPBsh3lUnYUgPWvtU/C0Z7oTk0yoxRSp/cGoag
         FtojA+4gYUz3XSPlcOejCDJn/B/p7gqRmJ4ZC6/FEcBT6/TxG2onJKpeKPRnV3gyj9nA
         0mJA==
X-Gm-Message-State: ABy/qLalxf5Q9rUkfczPXZof0yWcfG46fTC6PMXap/+UjA97zkrYO0qt
        0GygY41tz6fFcPoz/DJOVLHpikxim7xoMGNXK5yEms2jQq21lmEDU/At/HjI/vs6sd5Erd4lmoP
        yVZBxIvegBifNXwMpmmlWfpo2blKvBa0PgK5CgGsqkGAcjQivYvHEtxB4VNAOt52Kk/ngjLs7
X-Google-Smtp-Source: APBJJlEtPhC3N+fK3b66oyZDPTJ4j29GuXYvWQJ1fldMJ6+MvFP6sHtZzWcISjNibekcipTniuHBMCdINYHZYCk=
X-Received: from tessier.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5422])
 (user=radusolea job=sendgmr) by 2002:a63:6f8c:0:b0:563:932d:8cd9 with SMTP id
 k134-20020a636f8c000000b00563932d8cd9mr41838pgc.3.1690239629935; Mon, 24 Jul
 2023 16:00:29 -0700 (PDT)
Date:   Mon, 24 Jul 2023 16:00:14 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230724230014.470081-1-radusolea@google.com>
Subject: [RFC] thermal core: add option to run PM_POST_SUSPEND asynchronously
From:   Radu Solea <radusolea@google.com>
To:     linux-pm@vger.kernel.org
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org,
        Radu Solea <radusolea@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
2.41.0.487.g6d72f3e995-goog

