Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E75779AD8
	for <lists+linux-pm@lfdr.de>; Sat, 12 Aug 2023 00:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbjHKWxj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Aug 2023 18:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjHKWxj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Aug 2023 18:53:39 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3B12684
        for <linux-pm@vger.kernel.org>; Fri, 11 Aug 2023 15:53:38 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-268113acd37so4136437a91.0
        for <linux-pm@vger.kernel.org>; Fri, 11 Aug 2023 15:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691794418; x=1692399218;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wCh9SVmlxV8iSfQqkpg+zJJ3iZh5ZfIYHEkLVt/OL10=;
        b=FE2fzx07q4xlYY4C0wE4aD1mX9gWSh85eC53ruh7GiVxDqxWT1OqfmzHrSL+reMOp2
         iOW87/vurbXgIFkp8qu7bso81R7PSiR1Fu7mzqDvK24dSERJAPz/mog0xkMe6o2+w2qf
         KPGWAUcZuFDav+W40yPqI53PaMKAdcSMDmpVyGgVuh5929O5skwfNTAMmvT+BIpIk9oI
         zX90EI4WOOfQzqwdsAEWyKRHJKpblhUspOfUeKluUKS0I9YI2z8f4QNQrUG7cj7U47Un
         ozRwnFscaS5jQJ3Fnv3zi8azK2cDDOWqIarvruNoIv4guehV/BgSOYZuffxDoUteuhOB
         9k6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691794418; x=1692399218;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wCh9SVmlxV8iSfQqkpg+zJJ3iZh5ZfIYHEkLVt/OL10=;
        b=Yxqa2RCB0wee8VbUvqVUydwy4CLmz7/bI89fY5N89wzSzq8bGT4fwCkO83iAYAkOQo
         NLt8RzuJSz/h3mxFcfI9UWLHe7zjyrmEFteUOj7enjOP9xmIKt9TtVjKhkOLyJg9Y6I1
         jWJr2c+dGWWA0tFXNa8lnUbe3lTGCdKRzCS78nG0dQt+omKUYokwsJoo3cVFSU2n77Ep
         wh5KIT0kmMtodgsd8/GfGlYCOR5ytFfc4njOwEt4JauUuYuNQMV14IQzCk0SQiF7JEW9
         ZVFJH9ldgeNxAkH8Bq3/e2ohJLKWQEU40+bX1ML8aA9eEy47KLftW2Rhrj6XQyQab7i0
         F/Ug==
X-Gm-Message-State: AOJu0YyLbPwB/YJi5da7/77ARg3CuxKZscEsWQdzi+k48OQIak4Yf8P9
        bvZ7RFnACoeBBP6VVe+f5Jvi4X8CE71ay7OZlp2Jy9YVT0JyVAbFjZZCcEuh7YlT4vuCNJHNqsg
        czMh+zXRscnV1m1lsglKu9Y/Q71bJCXBVSMCdbI0NzpddFie9MoWICt2g42qctWI74Fv+ADqo
X-Google-Smtp-Source: AGHT+IGJ5G7oxa9OUzN2JT+w+t3qvhrMzqm8FxNorCFsdY+qFFahaL4zMgEUaNm9s0eCd/UV1D9FDI9XbUo5SIg=
X-Received: from tessier.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5422])
 (user=radusolea job=sendgmr) by 2002:a17:90b:fd3:b0:268:96c1:c101 with SMTP
 id gd19-20020a17090b0fd300b0026896c1c101mr1797901pjb.0.1691794418148; Fri, 11
 Aug 2023 15:53:38 -0700 (PDT)
Date:   Fri, 11 Aug 2023 15:52:48 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230811225247.1271387-2-radusolea@google.com>
Subject: [RFC PATCH RESEND] thermal core: add option to run PM_POST_SUSPEND asynchronously
From:   Radu Solea <radusolea@google.com>
To:     linux-pm@vger.kernel.org
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, Radu Solea <radusolea@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
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
2.41.0.694.ge786442a9b-goog

