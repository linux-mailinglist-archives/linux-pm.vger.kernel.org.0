Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DDC329397
	for <lists+linux-pm@lfdr.de>; Mon,  1 Mar 2021 22:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237988AbhCAV2z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Mar 2021 16:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244229AbhCAVXq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Mar 2021 16:23:46 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBAEC06178A
        for <linux-pm@vger.kernel.org>; Mon,  1 Mar 2021 13:23:05 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id e10so17428070wro.12
        for <linux-pm@vger.kernel.org>; Mon, 01 Mar 2021 13:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BolDG0rpbm3VJxsNNntCGEQCMwhe+8DOiuZcK45flWE=;
        b=qZ+9kawyM2v99+BilQ8EwE5yFnTaRIxYSafi9R18pZ+5lRSabU7EhSbUKmUsO7e+aX
         v1qBjCVlPMRWNQydcgMnmM3sJNwTWnLCPyKzCn8RI3qxtwQcPy3w1NH0wOmzPMiqcdX2
         RHq2FZkBjkqx5Z4POo/VhjZlK1fR02CWCIlOC2qZ38LtKysnJbtND5fU0C+lZJwcNa8+
         2eYM+IxySoIct5Xz3jTVfA1VO0FvKFK8AkGfAxMpOilokckVvwhqfkapQJNKpqEKXhVT
         6U16uuPMl3uJH8PPWqIr1zzlqoMoHnmWDjFydtr0/Dm3Kmv576iunwsy7MkXhlGmWfHm
         ogCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BolDG0rpbm3VJxsNNntCGEQCMwhe+8DOiuZcK45flWE=;
        b=L97ObhtizaoxlBOHeyW+O6jEDcTXZs+3ltGuwvNkKUTlff518ba/+P+uO84G6P4jWq
         UY3H5TtqDY4rGXPAmSSR8nSA8DxpP93q58VeQNjSrXHMcD4+L0cJDI/lQMlazRYZ2Rpk
         Jw6W12g0zDSeyve+gGyrLWjavr6BzZwtlljMYhTtjUekidQw+uOROhukIYHu03DeMlzB
         hGljfkTlU75WJWQmuHNg61FDSFcpbXKbV5DxHNf+KxULN7R2hzguaATlZHfLzKfUYJLR
         iZqJ3qZPuFHj3Z9vTuNpmLVPqKiQdEJWBbvuORnf3oyjEO406X3gzHo/WAhrtt+nYQ8b
         YJ6Q==
X-Gm-Message-State: AOAM530NdK2FzY6jQzo+tvfj+jF0byRc2zUDVUUZ52oDs6yNfQr/Fepi
        XDMvocwKAELBS77G+aaEYNI1Zw==
X-Google-Smtp-Source: ABdhPJxA1v/pk449Ghc7UCRigVqv5MvmBklpRtnY/JC/NNBZKxC65Gu0lLlu9184FgmZgT8o46irvw==
X-Received: by 2002:adf:e582:: with SMTP id l2mr18920292wrm.207.1614633783911;
        Mon, 01 Mar 2021 13:23:03 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-144-192.adsl.proxad.net. [82.252.144.192])
        by smtp.gmail.com with ESMTPSA id o11sm6783866wrq.74.2021.03.01.13.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 13:23:03 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 2/5] powercap/drivers/dtpm: Create a registering system
Date:   Mon,  1 Mar 2021 22:21:46 +0100
Message-Id: <20210301212149.22877-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210301212149.22877-1-daniel.lezcano@linaro.org>
References: <20210301212149.22877-1-daniel.lezcano@linaro.org>
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
 drivers/powercap/dtpm.c     | 158 ++++++++++++++++++++++++++++++++++--
 drivers/powercap/dtpm_cpu.c |   4 +-
 include/linux/dtpm.h        |  12 ++-
 3 files changed, 161 insertions(+), 13 deletions(-)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index 1085dccf9c58..20728a28ff0d 100644
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
@@ -152,6 +161,135 @@ static int __dtpm_update_power(struct dtpm *dtpm)
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
+
+	mutex_lock(&dtpm_lock);
+
+	if (__dtpm_lookup(name)) {
+		mutex_unlock(&dtpm_lock);
+		return -EEXIST;
+	}
+
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+
+	node->name = kstrdup(name, GFP_KERNEL);
+	if (!node->name) {
+		kfree(node);
+		return -ENOMEM;
+	}
+
+	node->dtpm = dtpm;
+
+	list_add(&node->node, &dtpm_list);
+
+	pr_info("Registered %s\n", name);
+
+	mutex_unlock(&dtpm_lock);
+
+	return 0;
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
@@ -208,7 +346,7 @@ int dtpm_release_zone(struct powercap_zone *pcz)
 	if (root == dtpm)
 		root = NULL;
 
-	kfree(dtpm);
+	dtpm_put(dtpm);
 
 	return 0;
 }
@@ -370,6 +508,7 @@ struct dtpm *dtpm_alloc(struct dtpm_ops *ops)
 	if (dtpm) {
 		INIT_LIST_HEAD(&dtpm->children);
 		INIT_LIST_HEAD(&dtpm->sibling);
+		kref_init(&dtpm->kref);
 		dtpm->weight = 1024;
 		dtpm->ops = ops;
 	}
@@ -378,28 +517,29 @@ struct dtpm *dtpm_alloc(struct dtpm_ops *ops)
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
@@ -413,7 +553,7 @@ void dtpm_unregister(struct dtpm *dtpm)
  *           * parent have ops which are reserved for leaves
  *   Other negative values are reported back from the powercap framework
  */
-int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent)
+int dtpm_create(const char *name, struct dtpm *dtpm, struct dtpm *parent)
 {
 	struct powercap_zone *pcz;
 
@@ -457,7 +597,7 @@ int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent)
 	if (dtpm->ops && !dtpm->ops->upt_power_uw(dtpm))
 		__dtpm_add_power(dtpm);
 
-	pr_info("Registered dtpm node '%s' / %llu-%llu uW, \n",
+	pr_info("Created dtpm node '%s' / %llu-%llu uW, \n",
 		dtpm->zone.name, dtpm->power_min, dtpm->power_max);
 
 	mutex_unlock(&dtpm_lock);
diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index aff79c649345..1a10537c4434 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -180,7 +180,7 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 
 	sprintf(name, "cpu%d-cpufreq", dtpm_cpu->cpu);
 
-	ret = dtpm_register(name, dtpm, NULL);
+	ret = dtpm_register(name, dtpm);
 	if (ret)
 		goto out_kfree_dtpm_cpu;
 
@@ -193,7 +193,7 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 	return 0;
 
 out_dtpm_unregister:
-	dtpm_unregister(dtpm);
+	dtpm_unregister(name);
 	dtpm_cpu = NULL;
 	dtpm = NULL;
 
diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
index d29be6a0e513..447ea6c60b59 100644
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

