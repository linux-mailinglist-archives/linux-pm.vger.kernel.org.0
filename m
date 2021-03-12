Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51600338E57
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 14:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhCLNKD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 08:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhCLNJs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 08:09:48 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB04C061761
        for <linux-pm@vger.kernel.org>; Fri, 12 Mar 2021 05:09:47 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a18so4749294wrc.13
        for <linux-pm@vger.kernel.org>; Fri, 12 Mar 2021 05:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W5HXQCi40XxOvUZzXEGLC9mNtUSNsDNwrGp6F1F7KDs=;
        b=GgIUvoCw6pn4Lc1qQuisnsf/TT9SajavPJYQ8RGchpfnZxFTwNC8yoVZlxntS4EWOT
         Ch3dkBxdPbmVPXZ1WNZddhAmNj4FZEpKe/6rKb4LAc3UUU2THEt15cgNSykQyAgDHKpl
         82wYLDF9HseYFQ+PBvp9WR6j1s/LKT2sLAuiCV5l3zLnaBxY1Z+doyv8RFw4pwK9fSUr
         yAwsmTBY/StXU7zkUkKPP+LJKx6LJuYdrTF870/7Wl0pT+SK/Bs+Kdq7rvTfM+CpLV1n
         IyxR6R1WHLH3saEIV1PjMpK9fevr0M3YGE2CqBRNXR457gEdrdncpvRP5GegteEt12xC
         Zo+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W5HXQCi40XxOvUZzXEGLC9mNtUSNsDNwrGp6F1F7KDs=;
        b=W0/2S4LvyzU3cNuwiz7qyvk3STs4SO/22VyVbWRSKpcVHW8rGziX0Xw9NfrrN5dnXk
         NdrZxdxrFdElOolqbR0CRdfwJPQqiQClHcBYALzAngiIgxqezwET6HJPRfmHRS1OyCNS
         bvkacHb4E76CUnbSYypriqOXow5XnM7O28EW8YiLyFiyHqTDtOLTGwvwNXGvDOZVlmi5
         W39fS3pltXOuClW5Cf5INOoL0rVg11rmOpZhpM+gOzvAvR5R3LasQ00R4qO31hTiOjCn
         7wSMAqfBPKZ7QllFwfVctH/ssAxBRjnsSk1p/Exw7H8+qtwQCn/pC8jVJqkRCkOQN0pt
         m/8Q==
X-Gm-Message-State: AOAM532dHdJQI0+T1ywjAzeUERdCYGipgQXwDD8IRfoSlXRJA/I/O3TY
        450ubwqH3hHpqy2tx6VUAkEAXWoMmj6+RQ==
X-Google-Smtp-Source: ABdhPJxrtDwNdCYf4EsCvi3caVBEHkA9O7/CP0fXOJ3g4KBTPfcNCkUM7+JDk9plzYPdLR1Shj/caA==
X-Received: by 2002:a5d:6312:: with SMTP id i18mr14157379wru.149.1615554586277;
        Fri, 12 Mar 2021 05:09:46 -0800 (PST)
Received: from localhost.localdomain ([82.142.0.212])
        by smtp.gmail.com with ESMTPSA id q15sm7655033wrr.58.2021.03.12.05.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 05:09:45 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com
Subject: [PATCH v4 2/5] powercap/drivers/dtpm: Create a registering system
Date:   Fri, 12 Mar 2021 14:04:08 +0100
Message-Id: <20210312130411.29833-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210312130411.29833-1-daniel.lezcano@linaro.org>
References: <20210312130411.29833-1-daniel.lezcano@linaro.org>
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

When the node register in the list, the function will be dtpm_register
where the previous semantic was to create the node. Thus, the
functions are renamed to reflect their purpose.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---

V4:
  - Fixed typo in the commit log

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
index f6076de39540..8592a78e47e4 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -177,7 +177,7 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 
 	snprintf(name, sizeof(name), "cpu%d-cpufreq", dtpm_cpu->cpu);
 
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

