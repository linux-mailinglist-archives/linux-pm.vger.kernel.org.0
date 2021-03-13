Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4230F339A53
	for <lists+linux-pm@lfdr.de>; Sat, 13 Mar 2021 01:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbhCMALu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 19:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbhCMALi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 19:11:38 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A867DC061574
        for <linux-pm@vger.kernel.org>; Fri, 12 Mar 2021 16:11:37 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id y124-20020a1c32820000b029010c93864955so16772968wmy.5
        for <linux-pm@vger.kernel.org>; Fri, 12 Mar 2021 16:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yAmGnwA16w4LHPNLFLbSKpp3NmjxrQjmDmvrcI3GNWQ=;
        b=C7aQ+lrP/nxTBEpUayZuzv3/rqFT+250q6y86SPOcW3K3Bcqimj6v7lvTPm8QBdaN8
         fAt24MLpgMQ9IP6R892w8Hoezz/2pzNg8XtVHzw64Mumr7ZckV8MfXuKCtiAAHg886u2
         J5DMAmDL5tOYmhNDt/KFep2tbJBE18XkmpvyHxuZ1KzKHV2jn8Q08a5HFdeiP1ZksFxe
         XHdJ/NdN6QNCxdT0VxAPI5uzLO4HxqrN2qZgVJFSD1SPjRlG9YNZQBkpg2K0q/7alRgx
         TVPneGX0EugCraVeIhDGUDF92ZkX54kPFRkXAje8X9aiakmLFKoJKviCbX+eD1PbrNCJ
         sI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yAmGnwA16w4LHPNLFLbSKpp3NmjxrQjmDmvrcI3GNWQ=;
        b=rABrLEkhBqEFlEw33OEbsP1q9vl5NWmXkdStO11/+VaCyeNooBxeKxPpI/7Of8vwc1
         dAEZMdfE7yAHJwSTBpwWMPoKiTIx+2AlatuSAITXTnXG/TAmbbZfiZqZdAkoFhdQeXAQ
         1NBBGmrx4Gre/0tCOnwyX6+tHXmxUyA/VnYKFSvNKcdgBxDiUV75wjPXCvrROC1VI2Ku
         zsEIJKxATIqzWVBaLAJ9OyNjiEGsn3XlXFjDrh8bXE1hAfswFmx+R3Hsg1qAWG4t+9JF
         2wFJsjZnSyJPQvAp8s6mABwxLhehxssIRjZi35vpbcZaQ0XtB+wD19CgAINphUmc0ZnC
         H3ng==
X-Gm-Message-State: AOAM532NI74NQbCQmrSleUe5NO/SyE5tNahLgdv9a83s+Ozq5PIbcOSu
        QZ77cftgtTOALG3QZSJZR7hqj7Ruos3Hkg==
X-Google-Smtp-Source: ABdhPJx9yx/puKc+6WKY7lxMUkkzUiTgCFUiFhNfU6wiuPmMWT6CvLol8fNnxnaS5CXi9lv+3wZOAA==
X-Received: by 2002:a1c:4182:: with SMTP id o124mr15610354wma.61.1615594296189;
        Fri, 12 Mar 2021 16:11:36 -0800 (PST)
Received: from localhost.localdomain ([82.142.0.212])
        by smtp.gmail.com with ESMTPSA id a6sm4613813wmm.0.2021.03.12.16.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 16:11:35 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com
Subject: [PATCH 2/2] powercap/drivers/dtpm: Allow dtpm node device creation through configfs
Date:   Sat, 13 Mar 2021 01:11:05 +0100
Message-Id: <20210313001105.7568-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210313001105.7568-1-daniel.lezcano@linaro.org>
References: <20210313001105.7568-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The DTPM framework is built on top of the powercap framework as a new
controller to act on the power of the devices. The approach is to
provide an unified API to do power limitation on devices which are
capable of that with different techniques.

In addition, the DTPM framework allows to create a hierarchical
representation of the devices in order to reflect the dependencies of
the power constraints we want to apply to a group of devices.

The hierarchy can be different for the same platform as it will depend
on the form factor (tablet, notebook, phone, ...), on other components
and/or a policy, and application scenario.

The kernel can not have such knowledge and only the SoC vendor can
setup its platform to fulfill the objectives of its hardware.

This patch adds the ability to create a DTPM hierarchy via
configfs. All DTPM capable devices are registered in a list, and the
creation of a configfs directory with the name of one of this device
will create a DTPM node in the DTPM powercap sysfs. If the name is not
in the list, a virtual node will be created instead. This virtual node
in the DTPM semantic is to aggregate the power characteristics of the
children.

In order to do the connection between the configfs and sysfs easily, a
'device' file contains the path to the corresponding DTPM powercap
node in sysfs (cross filesystems symlink is not supported by
configfs).

In order to not block any new features in the future, the hierarchical
constraints are stored under a top folder 'constraints', so sibling
can be created for other purposes if needed.

When the configfs was populated, the module can not be unloaded until
all the elements in the tree have been removed.

1) Resulting creation via mkdir:

root@rock960:/sys/kernel/config# tree dtpm/
dtpm/
└── constraints
    └── platform
            ├── device
	    └── soc
	        ├── device
		└── pkg
		     ├── device
		     ├── cpu0-cpufreq
		     │   └── device
		     ├── cpu4-cpufreq
		     │   └── device
		     └── panfrost-devfreq
		            └── device

2) The content of the 'device' file above

root@rock960:/sys/kernel/config# find dtpm/constraints -name "device" -exec cat {} \;
/devices/virtual/powercap/dtpm/dtpm:0/dtpm:0:0/dtpm:0:0:1
/devices/virtual/powercap/dtpm/dtpm:0/dtpm:0:0/dtpm:0:0:0/dtpm:0:0:0:2
/devices/virtual/powercap/dtpm/dtpm:0/dtpm:0:0/dtpm:0:0:0/dtpm:0:0:0:1
/devices/virtual/powercap/dtpm/dtpm:0/dtpm:0:0/dtpm:0:0:0/dtpm:0:0:0:0
/devices/virtual/powercap/dtpm/dtpm:0/dtpm:0:0/dtpm:0:0:0
/devices/virtual/powercap/dtpm/dtpm:0/dtpm:0:0
/devices/virtual/powercap/dtpm/dtpm:0

3) The dtpm device creation node is reflected in sysfs:

root@rock960:/sys/devices/virtual/powercap/dtpm# find . -type d | grep dtpm
./dtpm:0
./dtpm:0/power
./dtpm:0/dtpm:0:0
./dtpm:0/dtpm:0:0/power
./dtpm:0/dtpm:0:0/dtpm:0:0:0
./dtpm:0/dtpm:0:0/dtpm:0:0:0/dtpm:0:0:0:1
./dtpm:0/dtpm:0:0/dtpm:0:0:0/dtpm:0:0:0:1/power
./dtpm:0/dtpm:0:0/dtpm:0:0:0/power
./dtpm:0/dtpm:0:0/dtpm:0:0:0/dtpm:0:0:0:2
./dtpm:0/dtpm:0:0/dtpm:0:0:0/dtpm:0:0:0:2/power
./dtpm:0/dtpm:0:0/dtpm:0:0:0/dtpm:0:0:0:0
./dtpm:0/dtpm:0:0/dtpm:0:0:0/dtpm:0:0:0:0/power
./dtpm:0/dtpm:0:0/dtpm:0:0:1
./dtpm:0/dtpm:0:0/dtpm:0:0:1/power

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/Kconfig         |   8 +
 drivers/powercap/Makefile        |   1 +
 drivers/powercap/dtpm_configfs.c | 247 +++++++++++++++++++++++++++++++
 include/linux/dtpm.h             |   2 +
 4 files changed, 258 insertions(+)
 create mode 100644 drivers/powercap/dtpm_configfs.c

diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
index 8242e8c5ed77..599b41e4e0a7 100644
--- a/drivers/powercap/Kconfig
+++ b/drivers/powercap/Kconfig
@@ -50,6 +50,14 @@ config DTPM
 	  This enables support for the power capping for the dynamic
 	  thermal power management userspace engine.
 
+config DTPM_CONFIGFS
+	tristate "Dynamic Thermal Power Management configuration via configfs"
+	depends on DTPM && CONFIGFS_FS
+	help
+	  This enables support for creating the DTPM device hierarchy
+	  via configfs giving the userspace full control of the
+	  thermal constraint representation.
+
 config DTPM_CPU
 	bool "Add CPU power capping based on the energy model"
 	depends on DTPM && ENERGY_MODEL
diff --git a/drivers/powercap/Makefile b/drivers/powercap/Makefile
index fabcf388a8d3..519cabc624c3 100644
--- a/drivers/powercap/Makefile
+++ b/drivers/powercap/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_DTPM) += dtpm.o
+obj-$(CONFIG_DTPM_CONFIGFS) += dtpm_configfs.o
 obj-$(CONFIG_DTPM_CPU) += dtpm_cpu.o
 obj-$(CONFIG_POWERCAP)	+= powercap_sys.o
 obj-$(CONFIG_INTEL_RAPL_CORE) += intel_rapl_common.o
diff --git a/drivers/powercap/dtpm_configfs.c b/drivers/powercap/dtpm_configfs.c
new file mode 100644
index 000000000000..196f8e9993da
--- /dev/null
+++ b/drivers/powercap/dtpm_configfs.c
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2021 Linaro Limited
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ * The DTPM framework defines a set of devices which are power capable.
+ *
+ * The configfs allows to create a hierarchy of devices in order
+ * to reflect the constraints we want to apply to them.
+ *
+ * Each dtpm node is created via a mkdir operation in the configfs
+ * directory. It will create the corresponding dtpm device in the
+ * sysfs and the 'device' will contain the absolute path to the dtpm
+ * node in the sysfs, thus allowing to do the connection between the
+ * created dtpm node in the configfs hierarchy and the dtpm node in
+ * the powercap framework.
+ *
+ * The dtpm nodes can be real or virtual. The former is a real device
+ * where acting on its power is possible and is registered in a dtpm
+ * framework's list with an unique name. A creation with mkdir with
+ * one of the registered name will instanciate the dtpm device. If the
+ * name is not in the registered list, it will create a virtual node
+ * where its purpose is to aggregate the power characteristics of its
+ * children which can virtual or real.
+ *
+ * It is not allowed to create a node if another one in the hierarchy
+ * has the same name. That ensures the consistency and prevents
+ * multiple instanciation of the same dtpm device.
+ */
+#include <linux/dtpm.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/configfs.h>
+
+/******************************************************************************/
+struct dtmp_configfs_nodes {
+	const char *name;
+	struct list_head node;
+};
+
+/*
+ * There is no need for a lock because the accessors are called from
+ * make and drop group which are protected by a mutex, There is the
+ * guarantee configfs ops are not called at the same time.
+ */
+static LIST_HEAD(node_list);
+
+static struct dtmp_configfs_nodes *dtmp_configfs_node_find(const char *name)
+{
+	struct dtmp_configfs_nodes *n;
+
+	list_for_each_entry(n, &node_list, node) {
+		if (!strcmp(name, n->name))
+			return n;
+	}
+
+	return NULL;
+}
+
+static int dtmp_configfs_node_add(const char *name)
+{
+	struct dtmp_configfs_nodes *n;
+
+	n = dtmp_configfs_node_find(name);
+	if (n)
+		return -EEXIST;
+
+	n = kzalloc(sizeof(*n), GFP_KERNEL);
+	if (!n)
+		return -ENOMEM;
+
+	n->name = kstrdup(name, GFP_KERNEL);
+	if (!n->name) {
+		kfree(n);
+		return -ENOMEM;
+	}
+
+	list_add_tail(&n->node, &node_list);
+
+	return 0;
+}
+
+void dtmp_configfs_node_del(const char *name)
+{
+	struct dtmp_configfs_nodes *n;
+
+	n = dtmp_configfs_node_find(name);
+	if (!n)
+		return;
+
+	list_del(&n->node);
+	kfree(n->name);
+	kfree(n);
+}
+/******************************************************************************/
+
+static struct config_group *cstrn_group;
+static struct config_item_type dtpm_cstrn_type;
+
+static struct config_group *dtpm_cstrn_make_group(struct config_group *grp, const char *name)
+{
+	struct dtpm *d, *p;
+	int ret;
+
+	/*
+	 * In order to ensure a consistency in terms of the
+	 * constraints in the hierarchy, prevent to create the same
+	 * dtpm node in different places.
+	 */
+	ret = dtmp_configfs_node_add(name);
+	if (ret)
+		return ERR_PTR(ret);
+
+	d = dtpm_get(name);
+	if (!d)
+		goto node_del;
+
+	config_group_init_type_name(&d->cfg, name, &dtpm_cstrn_type);
+
+	/*
+	 * Retrieve the dtpm parent node. The first dtpm node in the
+	 * hierarchy constraint is the root node, thus it does not
+	 * have a parent.
+	 */
+	p = (grp == cstrn_group) ? NULL :
+		container_of(grp, struct dtpm, cfg);
+
+	ret = dtpm_create(name, d, p);
+	if (ret)
+		goto dtpm_free;
+
+	if (!try_module_get(THIS_MODULE)) {
+		ret = -ENODEV;
+		goto dtpm_destroy;
+	}
+
+	return &d->cfg;
+
+dtpm_destroy:
+	dtpm_destroy(d);
+dtpm_free:
+	dtpm_put(d);
+node_del:
+	dtmp_configfs_node_del(name);
+	return ERR_PTR(ret);
+}
+
+static void dtpm_cstrn_drop_group(struct config_group *grp,
+				  struct config_item *cfg)
+{
+	struct config_group *cg = to_config_group(cfg);
+	struct dtpm *d = container_of(cg, struct dtpm, cfg);
+
+	dtmp_configfs_node_del(d->zone.name);
+	dtpm_destroy(d);
+	module_put(THIS_MODULE);
+	config_item_put(cfg);
+}
+
+static struct configfs_group_operations dtpm_cstrn_group_ops = {
+	.make_group = dtpm_cstrn_make_group,
+	.drop_item = dtpm_cstrn_drop_group,
+};
+
+static ssize_t dtpm_cstrn_device_show(struct config_item *cfg, char *str)
+{
+	struct config_group *cg = to_config_group(cfg);
+	struct dtpm *d = container_of(cg, struct dtpm, cfg);
+	struct kobject *kobj = &d->zone.dev.kobj;
+	char *string = kobject_get_path(kobj, GFP_KERNEL);
+	ssize_t len;
+
+	if (!string)
+		return -EINVAL;
+
+	len = sprintf(str, "%s\n", string);
+
+	kfree(string);
+
+	return len;
+}
+
+CONFIGFS_ATTR_RO(dtpm_cstrn_, device);
+
+static struct configfs_attribute *dtpm_cstrn_attrs[] = {
+	&dtpm_cstrn_attr_device,
+	NULL
+};
+
+static struct config_item_type dtpm_cstrn_type = {
+	.ct_owner = THIS_MODULE,
+	.ct_group_ops = &dtpm_cstrn_group_ops,
+};
+
+/******************************************************************************/
+
+static const struct config_item_type dtpm_root_group_type = {
+	.ct_owner = THIS_MODULE,
+};
+
+static struct configfs_subsystem dtpm_subsys = {
+	.su_group = {
+		.cg_item = {
+			.ci_namebuf = "dtpm",
+			.ci_type = &dtpm_root_group_type,
+		},
+	},
+	.su_mutex = __MUTEX_INITIALIZER(dtpm_subsys.su_mutex),
+};
+
+static int __init dtpm_configfs_init(void)
+{
+	int ret;
+
+	config_group_init(&dtpm_subsys.su_group);
+
+	ret = configfs_register_subsystem(&dtpm_subsys);
+	if (ret)
+		return ret;
+
+	cstrn_group = configfs_register_default_group(&dtpm_subsys.su_group,
+						      "constraints",
+						      &dtpm_cstrn_type);
+
+	/*
+	 * The default group does not contain attributes but the other
+	 * group will
+	 */
+	dtpm_cstrn_type.ct_attrs = dtpm_cstrn_attrs;
+
+	return PTR_ERR_OR_ZERO(cstrn_group);
+}
+module_init(dtpm_configfs_init);
+
+static void __exit dtpm_configfs_exit(void)
+{
+	configfs_unregister_default_group(cstrn_group);
+	configfs_unregister_subsystem(&dtpm_subsys);
+}
+module_exit(dtpm_configfs_exit);
+
+MODULE_DESCRIPTION("DTPM configuration driver");
+MODULE_AUTHOR("Daniel Lezcano");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
index 4f7ad21291e6..6b9761aa5ea7 100644
--- a/include/linux/dtpm.h
+++ b/include/linux/dtpm.h
@@ -8,11 +8,13 @@
 #define ___DTPM_H__
 
 #include <linux/powercap.h>
+#include <linux/configfs.h>
 
 #define MAX_DTPM_DESCR 8
 #define MAX_DTPM_CONSTRAINTS 1
 
 struct dtpm {
+	struct config_group cfg;
 	struct powercap_zone zone;
 	struct kref kref;
 	struct dtpm *parent;
-- 
2.17.1

