Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C983331AF
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 23:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhCIWnB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 17:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbhCIWmz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 17:42:55 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C813C06175F
        for <linux-pm@vger.kernel.org>; Tue,  9 Mar 2021 14:42:55 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id w11so19098186wrr.10
        for <linux-pm@vger.kernel.org>; Tue, 09 Mar 2021 14:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=84rQ3NvsOhm26IexTySRGDCIz117SxZ//6BzkM58sV8=;
        b=gMh7U27m742GajfbBTcKF3cghgI5zQOkaYrdSmQpmxb1DaN/msJae1ytHLi5wcuF30
         7KD/kqkI/lu8DsxU5YW/SXn87MeHBIvqZ0xH7s3sRZ4Fzfe3HAfehoK9zK2dspmijQdQ
         sX58szXDngr5enfUG8Oj2T2hL69iKT4QJBf0iMBl2chBfpU++5IprhuCdjPjegcnrs0U
         vQg8hsrwG4AsBa/M/v30kz/U4xHW21q/iFDuGFn8kGr6m/vnuya0ywiO3Pi0i/uamsrE
         v1pmgpnTA0+bTFD81U+s9n4OYXlmYX8UCoBdmEiH/e0T1oWNrgPSEjoJshu7f935wGp3
         QB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=84rQ3NvsOhm26IexTySRGDCIz117SxZ//6BzkM58sV8=;
        b=jjaVQH6gfiz347ku0lrhvIbOQtXNxGrieXUL/6kdbBtKHLKqSu9IUJ4Cag1cNXBBfW
         FhjV9CoQdF5K3LIWAPAHoJAxxK6+fuEvcpNd5BLj33ZVDC09U8hkMip2x0Yv9FgsFsgJ
         kpgIRpkqkSesRtpK75yJTFO/DE9wbAz8Uds97P2Q2z5Cqek5r79aU7HQ2TUxpthf+506
         pLJOhKJMJDk81xb5q2yhIx6H2z80iLKv7sOY4AWTf44hPpoDtecfwLSvLusexdeOnzoK
         LxFlXArmureyGrd71ebKR2DG5wuD+Nh75VTsAMMgUwd4LLdHs2JnlKJMAlItGIwqGLeE
         deug==
X-Gm-Message-State: AOAM531bnka0zcZB311TttdKEAKFRGQwmSmmOpXQQ3DF3a/Ger9dCao5
        rsJB0pw9jLYq8rLNZdBDPIokEztsruUUmo5p
X-Google-Smtp-Source: ABdhPJxEZT/VshtHZAD9ASpOR9dzBu1RWF2fD63V1rDfuovWSZhs4849m8H7Fq0E2VxKMVo1xd9G+Q==
X-Received: by 2002:a05:6000:192:: with SMTP id p18mr107109wrx.403.1615329773814;
        Tue, 09 Mar 2021 14:42:53 -0800 (PST)
Received: from localhost.localdomain ([82.142.0.212])
        by smtp.gmail.com with ESMTPSA id p16sm30352179wrt.54.2021.03.09.14.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 14:42:53 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com
Subject: [PATCH v2 2/5] powercap/drivers/dtpm: Create a registering system
Date:   Tue,  9 Mar 2021 23:42:41 +0100
Message-Id: <20210309224244.27225-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210309224244.27225-1-daniel.lezcano@linaro.org>
References: <20210309224244.27225-1-daniel.lezcano@linaro.org>
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
hierachically the different nodes. Those will be created by name and
found via the list filled by the different subsystem.

If a specified name is not found in the list, it is assumed to be a
virtual node which will have children and the default is to allocate
such node.

When the node register in the list, the function will be dtpm_register
where the previous semantic was to create the node. Thus, the
functions are renamed to reflect their purpose.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---

 V2:
   - Fixed error code path by dropping lock
---
 drivers/powercap/dtpm.c     | 161 ++++++++++++++++++++++++++++++++++--
 drivers/powercap/dtpm_cpu.c |   4 +-
 include/linux/dtpm.h        |  12 ++-
 3 files changed, 164 insertions(+), 13 deletions(-)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index 58433b8ef9a1..d00f55f0ee30 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -20,6 +20,7 @@
 #include <linux/dtpm.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/powercap.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
@@ -34,6 +35,14 @@ static DEFINE_MUTEX(dtpm_lock);
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
@@ -152,6 +161,138 @@ static int __dtpm_update_power(struct dtpm *dtpm)
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
+ * dtpm_get - Get a reference to a dtpm structure
+ * @name: the name of the dtpm device
+ *
+ * The function looks up in the list of the registered dtpm
+ * devices. If the dtpm device is not found, a virtual one is
+ * allocated. This function must be called to create a dtpm node in
+ * the powercap hierarchy.
+ *
+ * Return: a pointer to a dtpm structure, NULL if there is not enough
+ * memory
+ */
+struct dtpm *dtpm_get(const char *name)
+{
+	struct dtpm *dtpm;
+
+	mutex_lock(&dtpm_lock);
+	dtpm = __dtpm_lookup(name);
+	if (!dtpm)
+		dtpm = dtpm_alloc(NULL);
+	else
+		kref_get(&dtpm->kref);
+	mutex_unlock(&dtpm_lock);
+
+	return dtpm;
+}
+
+static void dtpm_release(struct kref *kref)
+{
+	struct dtpm *dtpm = container_of(kref, struct dtpm, kref);
+
+	kfree(dtpm);
+}
+
+/**
+ * dtpm_put - Release a reference on a dtpm device
+ * @dtpm: a pointer to a dtpm structure
+ *
+ * Release the reference on the specified dtpm device. The last
+ * reference leads to a memory release.
+ */
+void dtpm_put(struct dtpm *dtpm)
+{
+	kref_put(&dtpm->kref, dtpm_release);
+}
+
+/**
+ * dtpm_register - Register the dtpm in the dtpm list
+ * @name: a name used as an identifier
+ * @dtpm: the dtpm node to be registered
+ *
+ * Stores the dtpm device in a list.
+ *
+ * Return: 0 on success, -EEXIST if the device name is already present
+ * in the list, -ENOMEM in case of memory allocation failure.
+ */
+int dtpm_register(const char *name, struct dtpm *dtpm)
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
+	pr_info("Registered %s\n", name);
+
+	ret = 0;
+out_unlock:
+	mutex_unlock(&dtpm_lock);
+
+	return ret;
+}
+
+/**
+ * dtpm_unregister - Remove the dtpm device from the list
+ * @name: the dtpm device name to be removed
+ *
+ * Remove the dtpm device from the list of the registered devices.
+ */
+void dtpm_unregister(const char *name)
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
+		pr_info("Unregistered %s\n", name);
+
+		break;
+	}
+
+	mutex_unlock(&dtpm_lock);
+}
+
 /**
  * dtpm_update_power - Update the power on the dtpm
  * @dtpm: a pointer to a dtpm structure to update
@@ -208,7 +349,7 @@ int dtpm_release_zone(struct powercap_zone *pcz)
 	if (root == dtpm)
 		root = NULL;
 
-	kfree(dtpm);
+	dtpm_put(dtpm);
 
 	return 0;
 }
@@ -370,6 +511,7 @@ struct dtpm *dtpm_alloc(struct dtpm_ops *ops)
 	if (dtpm) {
 		INIT_LIST_HEAD(&dtpm->children);
 		INIT_LIST_HEAD(&dtpm->sibling);
+		kref_init(&dtpm->kref);
 		dtpm->weight = 1024;
 		dtpm->ops = ops;
 	}
@@ -378,28 +520,29 @@ struct dtpm *dtpm_alloc(struct dtpm_ops *ops)
 }
 
 /**
- * dtpm_unregister - Unregister a dtpm node from the hierarchy tree
- * @dtpm: a pointer to a dtpm structure corresponding to the node to be removed
+ * dtpm_destroy - Destroy a dtpm node from the hierarchy tree
+ * @dtpm: a pointer to a dtpm structure corresponding to the node to be
+ *	  removed and destroyed
  *
  * Call the underlying powercap unregister function. That will call
  * the release callback of the powercap zone.
  */
-void dtpm_unregister(struct dtpm *dtpm)
+void dtpm_destroy(struct dtpm *dtpm)
 {
 	powercap_unregister_zone(pct, &dtpm->zone);
 
-	pr_info("Unregistered dtpm node '%s'\n", dtpm->zone.name);
+	pr_info("Destroyed dtpm node '%s'\n", dtpm->zone.name);
 }
 
 /**
- * dtpm_register - Register a dtpm node in the hierarchy tree
+ * dtpm_create - Create a dtpm node in the hierarchy tree
  * @name: a string specifying the name of the node
  * @dtpm: a pointer to a dtpm structure corresponding to the new node
  * @parent: a pointer to a dtpm structure corresponding to the parent node
  *
  * Create a dtpm node in the tree. If no parent is specified, the node
  * is the root node of the hierarchy. If the root node already exists,
- * then the registration will fail. The powercap controller must be
+ * then the creation will fail. The powercap controller must be
  * initialized before calling this function.
  *
  * The dtpm structure must be initialized with the power numbers
@@ -413,7 +556,7 @@ void dtpm_unregister(struct dtpm *dtpm)
  *           * parent have ops which are reserved for leaves
  *   Other negative values are reported back from the powercap framework
  */
-int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent)
+int dtpm_create(const char *name, struct dtpm *dtpm, struct dtpm *parent)
 {
 	struct powercap_zone *pcz;
 
@@ -457,7 +600,7 @@ int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent)
 	if (dtpm->ops && !dtpm->ops->update_power_uw(dtpm))
 		__dtpm_add_power(dtpm);
 
-	pr_info("Registered dtpm node '%s' / %llu-%llu uW, \n",
+	pr_info("Created dtpm node '%s' / %llu-%llu uW, \n",
 		dtpm->zone.name, dtpm->power_min, dtpm->power_max);
 
 	mutex_unlock(&dtpm_lock);
diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index cfb120280887..628d4d6d83a6 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -177,7 +177,7 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 
 	sprintf(name, "cpu%d-cpufreq", dtpm_cpu->cpu);
 
-	ret = dtpm_register(name, dtpm, NULL);
+	ret = dtpm_register(name, dtpm);
 	if (ret)
 		goto out_kfree_dtpm_cpu;
 
@@ -190,7 +190,7 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 	return 0;
 
 out_dtpm_unregister:
-	dtpm_unregister(dtpm);
+	dtpm_unregister(name);
 	dtpm_cpu = NULL;
 	dtpm = NULL;
 
diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
index acf8d3638988..d724c5a7b2f4 100644
--- a/include/linux/dtpm.h
+++ b/include/linux/dtpm.h
@@ -14,6 +14,7 @@
 
 struct dtpm {
 	struct powercap_zone zone;
+	struct kref kref;
 	struct dtpm *parent;
 	struct list_head sibling;
 	struct list_head children;
@@ -69,10 +70,17 @@ int dtpm_release_zone(struct powercap_zone *pcz);
 
 struct dtpm *dtpm_alloc(struct dtpm_ops *ops);
 
-void dtpm_unregister(struct dtpm *dtpm);
+void dtpm_destroy(struct dtpm *dtpm);
 
-int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent);
+int dtpm_create(const char *name, struct dtpm *dtpm, struct dtpm *parent);
 
 int dtpm_register_cpu(struct dtpm *parent);
 
+int dtpm_register(const char *name, struct dtpm *dtpm);
+
+void dtpm_unregister(const char *name);
+
+struct dtpm *dtpm_get(const char *name);
+
+void dtpm_put(struct dtpm *dtpm);
 #endif
-- 
2.17.1

