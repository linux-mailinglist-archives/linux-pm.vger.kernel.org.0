Return-Path: <linux-pm+bounces-1-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D707F2184
	for <lists+linux-pm@lfdr.de>; Tue, 21 Nov 2023 00:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85A771C21212
	for <lists+linux-pm@lfdr.de>; Mon, 20 Nov 2023 23:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FA53AC08;
	Mon, 20 Nov 2023 23:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KmkJG0XY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A04CCD
	for <linux-pm@vger.kernel.org>; Mon, 20 Nov 2023 15:40:24 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5c977cc744aso13998637b3.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Nov 2023 15:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700523623; x=1701128423; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ubCQLYT4M822NaOxEZQsOhm+CIkCwTgeVBziCoxxYQQ=;
        b=KmkJG0XYcuJS9nQSWpwe8tRiG0ecu1J6+sR4viXsD4Ocb87oaU/h9hqOnnfPMZ4qxk
         nWR5jqWWdJK2g7XbAHZ9u/hzOQ4O8LfHaSX5uIgrPjfh0Nk/8TV63zUsZ04qQzk6SXP8
         +hRuLsesmxaS78SmYd6HDXS4AVm+J8ixO3E0+gy66i9v+5Q0D8J1iMfaW53hMPHUw5B/
         7kY1uc+jEOtSBkxvJbvYW2RDWGwlaKr+MfnP4gG8lbNqeuq9npHd/Orq8aUQRzF4iiRB
         VKeIFwMuDw/pkG7oWoEcFyqLzpS9T8okNT1LeyCFH+Q8O80B088hbO2l/Ardk+lVsGtj
         5Z4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700523623; x=1701128423;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ubCQLYT4M822NaOxEZQsOhm+CIkCwTgeVBziCoxxYQQ=;
        b=BL3iwKfnNkt8tpm47mHtHCCo9tK8r3JfsCz04+RmJwz1WXBz24/eU3HJYXEQlC3p3d
         tT42CsLq1OEOtxQgPjgce9kLRxiqwiuFHzWUhO8A0DTOGQBP6V61rRl8rmR8GhBJ2N6r
         r6aWOTYPCfwp3P8bsqAiqjOUq03VZm6dW9HY0XR1XFbRknaj4Ms6WcfNmI1rHSLUBqsj
         DVn29t9dfNqPEBwFWSu7G46gMB1iQOmpR7OZbchEXyi25lJMIaXg53NZZqTA2lQzh/5x
         6Fv5aBkmo6WVmCyEUChbf/31PptxtXWtQ0q1nwgrq3mN+zv+NoaBN7NbP6gyDdTB9NOY
         +CFw==
X-Gm-Message-State: AOJu0YzHbdtW/d1LCp+WSKWn14Lr0oCHYSWHTwsVQ4jNbbis3r366a3b
	ZIKzGBNAQNsXxQ6xFCDoFNpcth1UEYx6PfEJ67yv+yOrMJ1BqcQTZ6XSaKY6LOkG2/PcIAlOzkp
	COKBiIiXo63mP7AK9amK54vmc7LG/s+EgfgqppN1bK8JY6EJzbbrlRFKzG7Unb8EHHdArztqN
X-Google-Smtp-Source: AGHT+IEsSqU7uazrWacsfzjLs36eyAtRdqEMwdiwMw/ZwLP4AklA32nmT1CA+aLi7E7hhnfmmymL4JwxseUbrww=
X-Received: from tessier.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5422])
 (user=radusolea job=sendgmr) by 2002:a25:a285:0:b0:d9c:f811:eb9e with SMTP id
 c5-20020a25a285000000b00d9cf811eb9emr31005ybi.4.1700523623286; Mon, 20 Nov
 2023 15:40:23 -0800 (PST)
Date: Mon, 20 Nov 2023 15:40:14 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231120234015.3273143-1-radusolea@google.com>
Subject: [PATCH v2 RESEND] thermal core: add option to run PM_POST_SUSPEND asynchronously
From: Radu Solea <radusolea@google.com>
To: linux-pm@vger.kernel.org
Cc: rafael@kernel.org, Radu Solea <radusolea@google.com>
Content-Type: text/plain; charset="UTF-8"

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
index c81a00fbca7d..148d6e9734c6 100644
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
index 9c17d35ccbbd..8706f4ff5746 100644
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
+static struct work_struct *resume_thermal_zones_wk;
+#endif /* CONFIG_THERMAL_ASYNC_RESUME */
+
 /*
  * Governor section: set of functions to handle thermal governors
  *
@@ -1506,26 +1514,53 @@ struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name)
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
@@ -1541,6 +1576,15 @@ static int __init thermal_init(void)
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
2.43.0.rc1.413.gea7ed67945-goog


