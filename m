Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120F22CE2C2
	for <lists+linux-pm@lfdr.de>; Fri,  4 Dec 2020 00:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgLCXge (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Dec 2020 18:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgLCXgd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Dec 2020 18:36:33 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB7AC061A51
        for <linux-pm@vger.kernel.org>; Thu,  3 Dec 2020 15:35:53 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id j30so2347151pgj.17
        for <linux-pm@vger.kernel.org>; Thu, 03 Dec 2020 15:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=fY4H9271JhSIewrQYXd2G+AEVByTR1z+AsQ06Z9WUFM=;
        b=BsnDVnWtVJcAVmsyJ1XoXJ/wV0uPBh6CSjq0KcKNORuvBouhVc+FDK5rsl9+AhOE9y
         8b0ugvjKBQa2zgLRIQ6ZKckjTkse6jruNG26HA+qI/MVrrdyukQ6hyCdl1FhLbAIQ8Im
         ZizFVYHK0JisT0aLGPARq4bnamVvXcl0o0D9vypq3WMc1gKOdc9lz71g0QRvULTu0Zoq
         cjSQ91SQaPnxIKmASHWeiWen9VPniKaLygBRidIBpolRmKjf32MHDet392Dj3XsNtIva
         QJeQKD1UsnQH8B721jRIlYKB9OB3bPcf5Obg8of/mPvrjYoRQaHxEXQ/gwDOBCjmaH8N
         XPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=fY4H9271JhSIewrQYXd2G+AEVByTR1z+AsQ06Z9WUFM=;
        b=XK0NLhqBs74FapZcd7Wc90pVk+dsDrjoIP/S73aIqGDyCmJQdJToAs6QpVKmstorxs
         t4ea8LWKXVOtBdS6GGhBreKynKnYmKyNGnrQR9pzJ5LzR1iAM53UHjcbTLOuarpPwZY5
         vrZXQHQp+5cjOTmLNTC6h/cQemGGYyUAYijpqMcwlmBqkos7a7ic6QrNF3s6PQ3A+yBm
         +l4tULlhlb6MnJgboxICdzEWEvD2LE67+v5LAbkdmaMMbrIjEgbOVmhG8tvFSLzlVlxT
         KYoTGrsNYPdjH6GxIXyExKMp+bHBlt4X4Nj3tSlzY0MzB/f5XPzvFwafGZG3xcG0zMzM
         E+Cg==
X-Gm-Message-State: AOAM532vPPjOVTTpxYwwlULfOu8jkJbfki4O6LXB1MgR5dnqoQd2v9Gm
        Wx5Tn0q9JB3IbQXaD/VEkfuBzyHgs+JB7w==
X-Google-Smtp-Source: ABdhPJxK7cKTDAgHXoATiU5DTZZenqOXAwUblVyB3xJOEFdw1cmR7xNx6FPFHDgwlzqVBxceZa9Mu0MzNzukIw==
Sender: "tstrudel via sendgmr" <tstrudel@legoland2.mtv.corp.google.com>
X-Received: from legoland2.mtv.corp.google.com ([2620:15c:211:1:7220:84ff:fe09:fd20])
 (user=tstrudel job=sendgmr) by 2002:a17:90a:17a4:: with SMTP id
 q33mr120313pja.0.1607038552128; Thu, 03 Dec 2020 15:35:52 -0800 (PST)
Date:   Thu,  3 Dec 2020 15:35:46 -0800
Message-Id: <20201203233546.3482813-1-tstrudel@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH] PM: domains: create debugfs nodes when adding power domains
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
---
 drivers/base/power/domain.c | 61 ++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 22 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 743268996336..3f168ec93762 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1880,6 +1880,8 @@ static void genpd_lock_init(struct generic_pm_domain *genpd)
 	}
 }
 
+static void genpd_debug_add(struct generic_pm_domain *genpd);
+
 /**
  * pm_genpd_init - Initialize a generic I/O PM domain object.
  * @genpd: PM domain object to initialize.
@@ -1954,12 +1956,15 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 
 	mutex_lock(&gpd_list_lock);
 	list_add(&genpd->gpd_list_node, &gpd_list);
+	genpd_debug_add(genpd);
 	mutex_unlock(&gpd_list_lock);
 
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pm_genpd_init);
 
+static void genpd_debug_remove(struct generic_pm_domain *genpd);
+
 static int genpd_remove(struct generic_pm_domain *genpd)
 {
 	struct gpd_link *l, *link;
@@ -1987,6 +1992,7 @@ static int genpd_remove(struct generic_pm_domain *genpd)
 		kfree(link);
 	}
 
+	genpd_debug_remove(genpd);
 	list_del(&genpd->gpd_list_node);
 	genpd_unlock(genpd);
 	cancel_work_sync(&genpd->power_off_work);
@@ -3177,36 +3183,44 @@ DEFINE_SHOW_ATTRIBUTE(total_idle_time);
 DEFINE_SHOW_ATTRIBUTE(devices);
 DEFINE_SHOW_ATTRIBUTE(perf_state);
 
-static int __init genpd_debug_init(void)
+static void genpd_debug_add(struct generic_pm_domain *genpd)
 {
 	struct dentry *d;
-	struct generic_pm_domain *genpd;
 
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
+static void genpd_debug_remove(struct generic_pm_domain *genpd)
+{
+	struct dentry *d;
+
+	d = debugfs_lookup(genpd->name, genpd_debugfs_dir);
+	debugfs_remove(d);
+}
+
+static int __init genpd_debug_init(void)
+{
 	genpd_debugfs_dir = debugfs_create_dir("pm_genpd", NULL);
 
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
-
 	return 0;
 }
 late_initcall(genpd_debug_init);
@@ -3216,4 +3230,7 @@ static void __exit genpd_debug_exit(void)
 	debugfs_remove_recursive(genpd_debugfs_dir);
 }
 __exitcall(genpd_debug_exit);
+#else
+static void genpd_debug_add(struct generic_pm_domain *genpd) {}
+static void genpd_debug_remove(struct generic_pm_domain *genpd) {}
 #endif /* CONFIG_DEBUG_FS */
-- 
2.29.2.576.ga3fc446d84-goog

