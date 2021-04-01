Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43E4351FAB
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 21:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbhDATYm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 15:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234733AbhDATYY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Apr 2021 15:24:24 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585D8C0319D4
        for <linux-pm@vger.kernel.org>; Thu,  1 Apr 2021 11:37:11 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id j20-20020a05600c1914b029010f31e15a7fso3322049wmq.1
        for <linux-pm@vger.kernel.org>; Thu, 01 Apr 2021 11:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rmrwFawScZd+dgSKIdw3HeIwPz5cHCEkBuBk6dorpvc=;
        b=MCTWNqrDBe5vVSfL76zgApZjRoexIMl3kZz7aYRH1Aukw/7T9gw5sXxuanQLUUQYRr
         WxShjx7t3ymh0gaQCsJ+f5Hmhzq6Ecgij/sVAtYNCtB5cqaADGWVWlYeG7z2Dduz6xDs
         eJs+4EqtyFhdB8ruh343ChpbGCpdrP+euOLlMUEtbgNkHqC36GoJkcQASc/hKV/XCZ3g
         mCEGTIewFkrSusVvTYNyoW1LT/sh9D+6RSr1v1apopMuw3tABle62rsNTtxoGiufHp8E
         pOo+VD+f+Qek/qf6PN3RfjUddn9GFU0fgRW/qn+xOKgG7ANTdK99KpU1ozIgiPD/Xa3Q
         j4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rmrwFawScZd+dgSKIdw3HeIwPz5cHCEkBuBk6dorpvc=;
        b=sIZ0LFVBO7Ktc1zvdP+VAtVAW2r3D34PFU4dKIaL7hllZQ8P2A5CrBn24ZKDutCDNg
         xEkp/shupilMblvvAfbx+8gHR8sYCenjNevjo0nX0u8vPbTUOp951B5/mnm+AoU2i/0W
         S4XUrMZz/J0cLVUMznYapHukPQBlM+4AY238I8UdwfvfXZSyuzjpGn82mzLlF/qJPAGs
         617JdGMP3RHGf/8+EXmhr9QnSWKuO8FonHQ5ng3mSycE62aituJJ9PdbSGd2XmGlNZfm
         piLTK/dtycXSX+YTewfFaRFjjRGEpLQW0SBWKhBwP6sXXSLRigiLVnUZMkos6rhCmdC8
         ZRsQ==
X-Gm-Message-State: AOAM532tBR/yeZOCLhavopRGzVd0szsl9HXI5CGJSXmyyqPJlnsqOH3+
        SfjHbv9pgEGQU1Ux5FjnyHAogX+QxGndNA==
X-Google-Smtp-Source: ABdhPJzI1YBLni6HsfWQ92lf9dwBGOdmx76Hgg/M/EA/CDJpov3WQ6fcFvGuVAEhfm3rmi0MmoD60g==
X-Received: by 2002:a1c:a74b:: with SMTP id q72mr9255532wme.158.1617302229849;
        Thu, 01 Apr 2021 11:37:09 -0700 (PDT)
Received: from localhost.localdomain ([82.142.26.252])
        by smtp.gmail.com with ESMTPSA id b131sm9111490wmb.34.2021.04.01.11.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 11:37:09 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukasz.luba@arm.com, rafael@kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH v6 2/7] powercap/drivers/dtpm: Create a registering system
Date:   Thu,  1 Apr 2021 20:36:49 +0200
Message-Id: <20210401183654.27214-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210401183654.27214-1-daniel.lezcano@linaro.org>
References: <20210401183654.27214-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A SoC can be differently structured depending on the platform and the
kernel can not be aware of all the combinations, as well as the
specific tweaks for a particular board.

The creation of the hierarchy must be delegated to userspace.

These changes provide a registering mechanism where the different
subsystems will initialize their dtpm backends and register with a
name the dtpm node in a list.

The next changes will provide an userspace interface to create
hierarchically the different nodes. Those will be created by name and
found via the list filled by the different subsystem.

If a specified name is not found in the list, it is assumed to be a
virtual node which will have children and the default is to allocate
such node.

Cc: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---

V6:
  - Added the EXPORT_SYMBOL_GPL
V5:
  - Decrease log level from 'info' to 'debug'
  - Remove the refcount, it is pointless, lifetime cycle is already
    handled by the device refcounting. The dtpm node allocator is in
    charge of freeing it.
  - Rename the functions to 'dtpm_add, dtpm_del, dtpm_lookup'
  - Fix missing kfrees when deleting the node from the list
V4:
  - Fixed typo in the commit log
V2:
  - Fixed error code path by dropping lock
---
 drivers/powercap/dtpm.c     | 124 ++++++++++++++++++++++++++++++++++--
 drivers/powercap/dtpm_cpu.c |   8 +--
 include/linux/dtpm.h        |   6 ++
 3 files changed, 130 insertions(+), 8 deletions(-)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index 58433b8ef9a1..a707cc2965a1 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -34,6 +34,14 @@ static DEFINE_MUTEX(dtpm_lock);
 static struct powercap_control_type *pct;
 static struct dtpm *root;
 
+struct dtpm_node {
+	const char *name;
+	struct dtpm *dtpm;
+	struct list_head node;
+};
+
+static LIST_HEAD(dtpm_list);
+
 static int get_time_window_us(struct powercap_zone *pcz, int cid, u64 *window)
 {
 	return -ENOSYS;
@@ -152,6 +160,116 @@ static int __dtpm_update_power(struct dtpm *dtpm)
 	return ret;
 }
 
+static struct dtpm *__dtpm_lookup(const char *name)
+{
+	struct dtpm_node *node;
+
+	list_for_each_entry(node, &dtpm_list, node) {
+		if (!strcmp(name, node->name))
+			return node->dtpm;
+	}
+
+	return NULL;
+}
+
+/**
+ * dtpm_lookup - Lookup for a registered dtpm node given its name
+ * @name: the name of the dtpm device
+ *
+ * The function looks up in the list of the registered dtpm
+ * devices. This function must be called to create a dtpm node in the
+ * powercap hierarchy.
+ *
+ * Return: a pointer to a dtpm structure, NULL if not found.
+ */
+struct dtpm *dtpm_lookup(const char *name)
+{
+	struct dtpm *dtpm;
+
+	mutex_lock(&dtpm_lock);
+	dtpm = __dtpm_lookup(name);
+	mutex_unlock(&dtpm_lock);
+
+	return dtpm;
+}
+EXPORT_SYMBOL_GPL(dtpm_lookup);
+
+/**
+ * dtpm_add - Add the dtpm in the dtpm list
+ * @name: a name used as an identifier
+ * @dtpm: the dtpm node to be registered
+ *
+ * Stores the dtpm device in a list. The list contains all the devices
+ * which are power capable in terms of limitation and power
+ * consumption measurements. Even if conceptually, a power capable
+ * device won't register itself twice, the function will check if it
+ * was already registered in order to prevent a misuse of the API.
+ *
+ * Return: 0 on success, -EEXIST if the device name is already present
+ * in the list, -ENOMEM in case of memory allocation failure.
+ */
+int dtpm_add(const char *name, struct dtpm *dtpm)
+{
+	struct dtpm_node *node;
+	int ret;
+
+	mutex_lock(&dtpm_lock);
+
+	ret = -EEXIST;
+	if (__dtpm_lookup(name))
+		goto out_unlock;
+
+	ret = -ENOMEM;
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node)
+		goto out_unlock;
+
+	node->name = kstrdup(name, GFP_KERNEL);
+	if (!node->name) {
+		kfree(node);
+		goto out_unlock;
+	}
+
+	node->dtpm = dtpm;
+
+	list_add(&node->node, &dtpm_list);
+
+	ret = 0;
+out_unlock:
+	mutex_unlock(&dtpm_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dtpm_add);
+
+/**
+ * dtpm_del - Remove the dtpm device from the list
+ * @name: the dtpm device name to be removed
+ *
+ * Remove the dtpm device from the list of the registered devices.
+ */
+void dtpm_del(const char *name)
+{
+	struct dtpm_node *node;
+
+	mutex_lock(&dtpm_lock);
+
+	list_for_each_entry(node, &dtpm_list, node) {
+
+		if (strcmp(name, node->name))
+			continue;
+
+		list_del(&node->node);
+		kfree(node->name);
+		kfree(node);
+
+		break;
+	}
+
+	mutex_unlock(&dtpm_lock);
+}
+EXPORT_SYMBOL_GPL(dtpm_del);
+
 /**
  * dtpm_update_power - Update the power on the dtpm
  * @dtpm: a pointer to a dtpm structure to update
@@ -208,8 +326,6 @@ int dtpm_release_zone(struct powercap_zone *pcz)
 	if (root == dtpm)
 		root = NULL;
 
-	kfree(dtpm);
-
 	return 0;
 }
 
@@ -388,7 +504,7 @@ void dtpm_unregister(struct dtpm *dtpm)
 {
 	powercap_unregister_zone(pct, &dtpm->zone);
 
-	pr_info("Unregistered dtpm node '%s'\n", dtpm->zone.name);
+	pr_debug("Unregistered dtpm node '%s'\n", dtpm->zone.name);
 }
 
 /**
@@ -457,7 +573,7 @@ int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent)
 	if (dtpm->ops && !dtpm->ops->update_power_uw(dtpm))
 		__dtpm_add_power(dtpm);
 
-	pr_info("Registered dtpm node '%s' / %llu-%llu uW, \n",
+	pr_debug("Created dtpm node '%s' / %llu-%llu uW, \n",
 		dtpm->zone.name, dtpm->power_min, dtpm->power_max);
 
 	mutex_unlock(&dtpm_lock);
diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index f6076de39540..9deafd16a197 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -177,7 +177,7 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 
 	snprintf(name, sizeof(name), "cpu%d-cpufreq", dtpm_cpu->cpu);
 
-	ret = dtpm_register(name, dtpm, NULL);
+	ret = dtpm_add(name, dtpm);
 	if (ret)
 		goto out_kfree_dtpm_cpu;
 
@@ -185,12 +185,12 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 				   &dtpm_cpu->qos_req, FREQ_QOS_MAX,
 				   pd->table[pd->nr_perf_states - 1].frequency);
 	if (ret)
-		goto out_dtpm_unregister;
+		goto out_dtpm_del;
 
 	return 0;
 
-out_dtpm_unregister:
-	dtpm_unregister(dtpm);
+out_dtpm_del:
+	dtpm_del(name);
 	dtpm_cpu = NULL;
 	dtpm = NULL;
 
diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
index acf8d3638988..577c71d4e098 100644
--- a/include/linux/dtpm.h
+++ b/include/linux/dtpm.h
@@ -75,4 +75,10 @@ int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent);
 
 int dtpm_register_cpu(struct dtpm *parent);
 
+struct dtpm *dtpm_lookup(const char *name);
+
+int dtpm_add(const char *name, struct dtpm *dtpm);
+
+void dtpm_del(const char *name);
+
 #endif
-- 
2.17.1

