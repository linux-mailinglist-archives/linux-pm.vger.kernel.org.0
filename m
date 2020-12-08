Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1152D33D3
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 21:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgLHU0n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 15:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbgLHU0m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 15:26:42 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FF3C06179C
        for <linux-pm@vger.kernel.org>; Tue,  8 Dec 2020 12:25:56 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id c9so23858521ybs.8
        for <linux-pm@vger.kernel.org>; Tue, 08 Dec 2020 12:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=GVBCj7++kadYslQEKiUiOvXrT6u8C535LweeV3vmr3w=;
        b=GpYQ3QJDvynec7G8eavuJvRKmeokXYwUk/DvyDC3rQCo/JzL2hcmyvtT1WwRGq8Lmy
         TvllJRWIfWUzwn3OnjP1wF9jAfazM/mHTaMU/s1zmWuAUVNodHwc0n1dWMhXio7aUxEO
         PMx0pHNYbALD8pWiIGYiCWiQvYvP7ILmIER+SxFtR1oIsqgPsKeQNrDHXLRQ6zfaIlHN
         CIFmnrE3RtuUSUHW1vk8gNefCJXG1SfDqGOdY5j0xptgOnB9UHUu/gP1saxNS6Ok9ui5
         ols2KlUjDbo8F6agl1LN0ziyQv7ectxlEvOAbQ0rNWDudDW74lmyuAHw71C4de4CQctE
         clAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=GVBCj7++kadYslQEKiUiOvXrT6u8C535LweeV3vmr3w=;
        b=X7yM12bQq1Uek/MTKBgLuDaK47iuO/BbtMZTVeG5zsmCVc1vKaZQbr47kzBtfns0mP
         i/DqRwY0zlEH5/JOKrCvA2cNRYmDMQSkeU8a8zeYvqbu4SJOo1RlCxLmHp3mj5Gs5I5g
         XP8n3XZAlMcipUwZpZLY/Zgc7c1j+DJN4SVUEK/nN8hS9P7mYXknIljJhN5xIRdc6v6w
         ktcZqDwW1lAr8ZmxaKmj4IqX3Dh45zdG4C0nyvxaQ9bDw50zivQDARjC7CekQlN+TtZ3
         HMLUwntEN1W1y8tTuORsVbssyUyoVxkRI/NADc/tCS7Uuf0XqoyguwI8hSbj5T+KByZp
         bw1w==
X-Gm-Message-State: AOAM531IGJZ58x6eimO7FIj2Yrzb5Ln5XXSJl27Awm+wPbnUeddij6er
        GPrxXQO8BzXkUGu8Ba5Href9qHjm30z+og==
X-Google-Smtp-Source: ABdhPJxrfnJgi+EoEPqJXFI0NQkBlW/M60oMpPttVL+nDa9ZdrF2cemzNk1oPOuI5AUEOsRmwN6J+aV3XRjjQA==
Sender: "tstrudel via sendgmr" <tstrudel@legoland2.mtv.corp.google.com>
X-Received: from legoland2.mtv.corp.google.com ([2620:15c:211:1:7220:84ff:fe09:fd20])
 (user=tstrudel job=sendgmr) by 2002:a25:bb8f:: with SMTP id
 y15mr98605ybg.451.1607455204168; Tue, 08 Dec 2020 11:20:04 -0800 (PST)
Date:   Tue,  8 Dec 2020 11:19:55 -0800
Message-Id: <20201208191955.2466057-1-tstrudel@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v4] PM: domains: create debugfs nodes when adding power domains
From:   Thierry Strudel <tstrudel@google.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Strudel <tstrudel@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

debugfs nodes were created in genpd_debug_init alled in late_initcall
preventing power domains registered though loadable modules to have
a debugfs entry.

Create/remove debugfs nodes when the power domain is added/removed
to/from the internal gpd_list.

Signed-off-by: Thierry Strudel <tstrudel@google.com>
Change-Id: I8a2e0616746afe2a6bbd9c24bc3a0eaa84725a75
---
v2: fix forward declaration and genpd_debugfs_dir being NULL - Ulf
v3: remove extra trailing char added by mistake in v2 - kernel test robot
v4: cleanup includes and regroup CONFIG_DEBUG_FS CPP blocks - Greg
 drivers/base/power/domain.c | 73 +++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 28 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 2cb5e04cf86c..49c87607cba7 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -21,6 +21,7 @@
 #include <linux/suspend.h>
 #include <linux/export.h>
 #include <linux/cpu.h>
+#include <linux/debugfs.h>
 
 #include "power.h"
 
@@ -210,6 +211,18 @@ static void genpd_sd_counter_inc(struct generic_pm_domain *genpd)
 }
 
 #ifdef CONFIG_DEBUG_FS
+static struct dentry *genpd_debugfs_dir;
+
+static void genpd_debug_add(struct generic_pm_domain *genpd);
+
+static void genpd_debug_remove(struct generic_pm_domain *genpd)
+{
+	struct dentry *d;
+
+	d = debugfs_lookup(genpd->name, genpd_debugfs_dir);
+	debugfs_remove(d);
+}
+
 static void genpd_update_accounting(struct generic_pm_domain *genpd)
 {
 	ktime_t delta, now;
@@ -234,6 +247,8 @@ static void genpd_update_accounting(struct generic_pm_domain *genpd)
 	genpd->accounting_time = now;
 }
 #else
+static inline void genpd_debug_add(struct generic_pm_domain *genpd) {}
+static inline void genpd_debug_remove(struct generic_pm_domain *genpd) {}
 static inline void genpd_update_accounting(struct generic_pm_domain *genpd) {}
 #endif
 
@@ -1827,6 +1842,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 
 	mutex_lock(&gpd_list_lock);
 	list_add(&genpd->gpd_list_node, &gpd_list);
+	genpd_debug_add(genpd);
 	mutex_unlock(&gpd_list_lock);
 
 	return 0;
@@ -1860,6 +1876,7 @@ static int genpd_remove(struct generic_pm_domain *genpd)
 		kfree(link);
 	}
 
+	genpd_debug_remove(genpd);
 	list_del(&genpd->gpd_list_node);
 	genpd_unlock(genpd);
 	cancel_work_sync(&genpd->power_off_work);
@@ -2764,14 +2781,6 @@ core_initcall(genpd_bus_init);
 /***        debugfs support        ***/
 
 #ifdef CONFIG_DEBUG_FS
-#include <linux/pm.h>
-#include <linux/device.h>
-#include <linux/debugfs.h>
-#include <linux/seq_file.h>
-#include <linux/init.h>
-#include <linux/kobject.h>
-static struct dentry *genpd_debugfs_dir;
-
 /*
  * TODO: This function is a slightly modified version of rtpm_status_show
  * from sysfs.c, so generalize it.
@@ -3047,9 +3056,34 @@ DEFINE_SHOW_ATTRIBUTE(total_idle_time);
 DEFINE_SHOW_ATTRIBUTE(devices);
 DEFINE_SHOW_ATTRIBUTE(perf_state);
 
-static int __init genpd_debug_init(void)
+static void genpd_debug_add(struct generic_pm_domain *genpd)
 {
 	struct dentry *d;
+
+	if (!genpd_debugfs_dir)
+		return;
+
+	d = debugfs_create_dir(genpd->name, genpd_debugfs_dir);
+
+	debugfs_create_file("current_state", 0444,
+			    d, genpd, &status_fops);
+	debugfs_create_file("sub_domains", 0444,
+			    d, genpd, &sub_domains_fops);
+	debugfs_create_file("idle_states", 0444,
+			    d, genpd, &idle_states_fops);
+	debugfs_create_file("active_time", 0444,
+			    d, genpd, &active_time_fops);
+	debugfs_create_file("total_idle_time", 0444,
+			    d, genpd, &total_idle_time_fops);
+	debugfs_create_file("devices", 0444,
+			    d, genpd, &devices_fops);
+	if (genpd->set_performance_state)
+		debugfs_create_file("perf_state", 0444,
+				    d, genpd, &perf_state_fops);
+}
+
+static int __init genpd_debug_init(void)
+{
 	struct generic_pm_domain *genpd;
 
 	genpd_debugfs_dir = debugfs_create_dir("pm_genpd", NULL);
@@ -3057,25 +3091,8 @@ static int __init genpd_debug_init(void)
 	debugfs_create_file("pm_genpd_summary", S_IRUGO, genpd_debugfs_dir,
 			    NULL, &summary_fops);
 
-	list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
-		d = debugfs_create_dir(genpd->name, genpd_debugfs_dir);
-
-		debugfs_create_file("current_state", 0444,
-				d, genpd, &status_fops);
-		debugfs_create_file("sub_domains", 0444,
-				d, genpd, &sub_domains_fops);
-		debugfs_create_file("idle_states", 0444,
-				d, genpd, &idle_states_fops);
-		debugfs_create_file("active_time", 0444,
-				d, genpd, &active_time_fops);
-		debugfs_create_file("total_idle_time", 0444,
-				d, genpd, &total_idle_time_fops);
-		debugfs_create_file("devices", 0444,
-				d, genpd, &devices_fops);
-		if (genpd->set_performance_state)
-			debugfs_create_file("perf_state", 0444,
-					    d, genpd, &perf_state_fops);
-	}
+	list_for_each_entry(genpd, &gpd_list, gpd_list_node)
+		genpd_debug_add(genpd);
 
 	return 0;
 }
-- 
2.29.2.576.ga3fc446d84-goog

