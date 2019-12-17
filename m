Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10BD8122F07
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2019 15:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbfLQOmq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Dec 2019 09:42:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31276 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728532AbfLQOmq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Dec 2019 09:42:46 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBHEgOMe102644
        for <linux-pm@vger.kernel.org>; Tue, 17 Dec 2019 09:42:44 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wwe37frkw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Tue, 17 Dec 2019 09:42:44 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <huntbag@linux.vnet.ibm.com>;
        Tue, 17 Dec 2019 14:42:41 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 17 Dec 2019 14:42:39 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBHEgcxU47186300
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Dec 2019 14:42:38 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85B07A405B;
        Tue, 17 Dec 2019 14:42:38 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A69EA4060;
        Tue, 17 Dec 2019 14:42:37 +0000 (GMT)
Received: from ltc-wspoon6.aus.stglabs.ibm.com (unknown [9.40.193.95])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 17 Dec 2019 14:42:37 +0000 (GMT)
From:   Abhishek Goel <huntbag@linux.vnet.ibm.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, daniel.lezcano@linaro.org,
        ego@linux.vnet.ibm.com, oohall@gmail.com, mpe@ellerman.id.au,
        svaidy@linux.ibm.com, Abhishek Goel <huntbag@linux.vnet.ibm.com>
Subject: [RFC] cpuidle : Add debugfs support for cpuidle core
Date:   Tue, 17 Dec 2019 08:38:34 -0600
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 19121714-0016-0000-0000-000002D5D1D9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121714-0017-0000-0000-000033380B9A
Message-Id: <20191217143834.19797-1-huntbag@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-17_02:2019-12-17,2019-12-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 clxscore=1011 mlxlogscore=999 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912170124
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Up until now, we did not have a way to tune cpuidle attribute like
residency in kernel. This patch adds support for debugfs in cpuidle core.
Thereby providing support for tuning cpuidle attributes like residency in
kernel at runtime.
For example: Tuning residency at runtime can be used to quantify governors
decision making as governor uses residency as one of the parameter to
take decision about the state that needs to be entered while idling.

Currently, Only residency have been added in debugfs framework. We can
later on add attributes like latency too.

Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
---
 drivers/cpuidle/Kconfig           |   8 ++
 drivers/cpuidle/Makefile          |   1 +
 drivers/cpuidle/cpuidle-debugfs.c | 188 ++++++++++++++++++++++++++++++
 drivers/cpuidle/cpuidle.c         |  19 ++-
 drivers/cpuidle/cpuidle.h         |  24 ++++
 include/linux/cpuidle.h           |   3 +
 6 files changed, 241 insertions(+), 2 deletions(-)
 create mode 100644 drivers/cpuidle/cpuidle-debugfs.c

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index 88727b7c0d59..630a5a90744b 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -71,6 +71,14 @@ config HALTPOLL_CPUIDLE
          before halting in the guest (more efficient than polling in the
          host via halt_poll_ns for some scenarios).
 
+config CPUIDLE_DEBUG_FS
+	bool "cpuidle state debugging information in debugfs"
+	default y
+	depends on DEBUG_FS
+	help
+	Include cpuidle state debugging information in debugfs. This is mostly
+	useful for kernel developers, but it does not incur any cost at runtime.
+
 endif
 
 config ARCH_NEEDS_CPU_IDLE_COUPLED
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index ee70d5cc5b99..8b5a3f4fe7ec 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
 obj-$(CONFIG_DT_IDLE_STATES)		  += dt_idle_states.o
 obj-$(CONFIG_ARCH_HAS_CPU_RELAX)	  += poll_state.o
 obj-$(CONFIG_HALTPOLL_CPUIDLE)		  += cpuidle-haltpoll.o
+obj-$(CONFIG_CPUIDLE_DEBUG_FS)		  += cpuidle-debugfs.o
 
 ##################################################################################
 # ARM SoC drivers
diff --git a/drivers/cpuidle/cpuidle-debugfs.c b/drivers/cpuidle/cpuidle-debugfs.c
new file mode 100644
index 000000000000..4ebb9d6debae
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-debugfs.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * cpuidle-debugfs : Debugfs for cpuidle driver
+ */
+#include <linux/kernel.h>
+#include <linux/cpu.h>
+#include <linux/cpuidle.h>
+#include <linux/debugfs.h>
+#include <linux/uaccess.h>
+
+#include "cpuidle.h"
+
+#define BUFF_SIZE 12
+
+static int residency_show(void *data, struct seq_file *m)
+{
+	struct cpuidle_state *state = data;
+	char op[BUFF_SIZE];
+
+	snprintf(op, BUFF_SIZE, "%llu\n",
+			ktime_to_us(state->target_residency_ns));
+	seq_puts(m, op);
+	return 0;
+}
+
+static ssize_t residency_write(void *data, const char __user *buf,
+			       size_t count, loff_t *ppos)
+{
+	struct cpuidle_driver *drv = cpuidle_get_driver();
+	struct cpuidle_state *state = data;
+	char opbuf[BUFF_SIZE] = { }, *op;
+	unsigned long long res;
+	int err, i, curr_index = INT_MAX;
+
+	if (count >= BUFF_SIZE) {
+		pr_err("%s: operation too long", __func__);
+		return -EINVAL;
+	}
+
+	if (copy_from_user(opbuf, buf, count))
+		return -EFAULT;
+
+	op = strstrip(opbuf);
+	err = kstrtoull(op, 0, &res);
+	if (err)
+		return err;
+
+	for (i = 0; i < drv->state_count; i++) {
+		if (&drv->states[i] == state) {
+			curr_index = i;
+			break;
+		}
+	}
+	if (curr_index == INT_MAX) {
+		pr_err("state not found\n");
+		return -EFAULT;
+	}
+
+	/* Maintain linearity of residency values */
+	mutex_lock(&cpuidle_lock);
+	if (curr_index && curr_index < drv->state_count - 1) {
+		if (drv->states[curr_index - 1].target_residency < res &&
+		    drv->states[curr_index + 1].target_residency > res) {
+			/* Update both the residency and residency_ns */
+			state->target_residency = (unsigned int)res;
+			state->target_residency_ns =
+				state->target_residency * NSEC_PER_USEC;
+		} else {
+			goto inval;
+		}
+	} else if (!curr_index) {
+		if (drv->states[curr_index + 1].target_residency > res) {
+			state->target_residency = (unsigned int)res;
+			state->target_residency_ns =
+				state->target_residency * NSEC_PER_USEC;
+		} else {
+			goto inval;
+		}
+	} else {
+		if (drv->states[curr_index - 1].target_residency < res) {
+			state->target_residency = (unsigned int)res;
+			state->target_residency_ns =
+				state->target_residency * NSEC_PER_USEC;
+		} else {
+			goto inval;
+		}
+	}
+
+	mutex_unlock(&cpuidle_lock);
+	return count;
+
+inval:
+	pr_err("Input value out of bound\n");
+	mutex_unlock(&cpuidle_lock);
+	return -EINVAL;
+}
+
+static int cpuidle_debugfs_show(struct seq_file *m, void *v)
+{
+	const struct cpuidle_debugfs_attr *attr = m->private;
+	void *data = d_inode(m->file->f_path.dentry->d_parent)->i_private;
+
+	return attr->show(data, m);
+}
+
+static ssize_t cpuidle_debugfs_write(struct file *file, const char __user *buf,
+				     size_t count, loff_t *ppos)
+{
+	struct seq_file *m = file->private_data;
+	const struct cpuidle_debugfs_attr *attr = m->private;
+	void *data = d_inode(file->f_path.dentry->d_parent)->i_private;
+
+	if (!attr->write)
+		return -EPERM;
+
+	return attr->write(data, buf, count, ppos);
+}
+
+static int cpuidle_debugfs_open(struct inode *inode, struct file *file)
+{
+	const struct cpuidle_debugfs_attr *attr = inode->i_private;
+
+	if (WARN_ON_ONCE(!attr->show))
+		return -EPERM;
+
+	return single_open(file, cpuidle_debugfs_show, inode->i_private);
+}
+
+
+static const struct file_operations cpuidle_debugfs_fops = {
+	.open		= cpuidle_debugfs_open,
+	.read		= seq_read,
+	.write		= cpuidle_debugfs_write,
+};
+
+static const struct cpuidle_debugfs_attr cpuidle_debugfs_attrs[] = {
+	{ "target_residency", 0600, residency_show, residency_write},
+	/* We can add other attributes like latency in future */
+	{ },
+};
+
+static void debugfs_create_files(struct dentry *parent, void *data,
+				 const struct cpuidle_debugfs_attr *attr)
+{
+	if (IS_ERR_OR_NULL(parent))
+		return;
+
+	d_inode(parent)->i_private = data;
+
+	for (; attr->name; attr++)
+		debugfs_create_file(attr->name, attr->mode, parent,
+				   (void *)attr, &cpuidle_debugfs_fops);
+}
+
+/*
+ * cpuidle_state_debugfs_unregister : creates a debugfs instance for each
+ *				      cpuidle state for cpuidle driver
+ * @index : index of cpuidle state
+ */
+void cpuidle_state_debugfs_unregister(int index)
+{
+	struct cpuidle_driver *drv;
+
+	drv = cpuidle_get_driver();
+	debugfs_remove_recursive(drv->states[index].debugfs_dir);
+}
+
+/*
+ * cpuidle_state_debugfs_register : creates a debugfs instance for each cpuidle
+ *				    state for cpuidle driver
+ * @index : index of cpuidle state
+ */
+void cpuidle_state_debugfs_register(int index)
+{
+	struct cpuidle_driver *drv;
+	struct cpuidle_state *state;
+	char state_name[BUFF_SIZE];
+
+	drv = cpuidle_get_driver();
+	state = &drv->states[index];
+
+	snprintf(state_name, BUFF_SIZE, "state%d", index);
+	state->debugfs_dir = debugfs_create_dir(state_name,
+						cpuidle_debugfs_root);
+
+	debugfs_create_files(state->debugfs_dir, state, cpuidle_debugfs_attrs);
+}
+
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 569dbac443bd..33d7fb25d879 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -23,6 +23,7 @@
 #include <linux/suspend.h>
 #include <linux/tick.h>
 #include <trace/events/power.h>
+#include <linux/debugfs.h>
 
 #include "cpuidle.h"
 
@@ -32,6 +33,10 @@ DEFINE_PER_CPU(struct cpuidle_device, cpuidle_dev);
 DEFINE_MUTEX(cpuidle_lock);
 LIST_HEAD(cpuidle_detected_devices);
 
+#ifdef CONFIG_DEBUG_FS
+struct dentry *cpuidle_debugfs_root;
+#endif
+
 static int enabled_devices;
 static int off __read_mostly;
 static int initialized __read_mostly;
@@ -666,9 +671,12 @@ EXPORT_SYMBOL_GPL(cpuidle_unregister_device);
  */
 void cpuidle_unregister(struct cpuidle_driver *drv)
 {
-	int cpu;
+	int cpu, i;
 	struct cpuidle_device *device;
 
+	for (i = 0; i < drv->state_count; i++)
+		cpuidle_state_debugfs_unregister(i);
+
 	for_each_cpu(cpu, drv->cpumask) {
 		device = &per_cpu(cpuidle_dev, cpu);
 		cpuidle_unregister_device(device);
@@ -692,7 +700,7 @@ EXPORT_SYMBOL_GPL(cpuidle_unregister);
 int cpuidle_register(struct cpuidle_driver *drv,
 		     const struct cpumask *const coupled_cpus)
 {
-	int ret, cpu;
+	int ret, cpu, i;
 	struct cpuidle_device *device;
 
 	ret = cpuidle_register_driver(drv);
@@ -724,6 +732,9 @@ int cpuidle_register(struct cpuidle_driver *drv,
 		break;
 	}
 
+	for (i = 0; i < drv->state_count; i++)
+		cpuidle_state_debugfs_register(i);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(cpuidle_register);
@@ -774,6 +785,10 @@ static int __init cpuidle_init(void)
 
 	latency_notifier_init(&cpuidle_latency_notifier);
 
+#ifdef CONFIG_DEBUG_FS
+	cpuidle_debugfs_root = debugfs_create_dir("cpuidle", NULL);
+#endif
+
 	return 0;
 }
 
diff --git a/drivers/cpuidle/cpuidle.h b/drivers/cpuidle/cpuidle.h
index 9f336af17fa6..781a9d0f4b43 100644
--- a/drivers/cpuidle/cpuidle.h
+++ b/drivers/cpuidle/cpuidle.h
@@ -37,6 +37,30 @@ extern void cpuidle_remove_device_sysfs(struct cpuidle_device *device);
 extern int cpuidle_add_sysfs(struct cpuidle_device *dev);
 extern void cpuidle_remove_sysfs(struct cpuidle_device *dev);
 
+#ifdef CONFIG_CPUIDLE_DEBUG_FS
+
+#include <linux/seq_file.h>
+
+extern struct dentry *cpuidle_debugfs_root;
+
+struct cpuidle_debugfs_attr {
+	const char *name;
+	umode_t mode;
+	int (*show)(void *, struct seq_file *);
+	ssize_t (*write)(void *, const char __user *, size_t, loff_t *);
+};
+
+extern void cpuidle_state_debugfs_register(int index);
+extern void cpuidle_state_debugfs_unregister(int index);
+#else
+void cpuidle_state_debugfs_register(int index)
+{
+}
+void cpuidle_state_debugfs_unregister(int index)
+{
+}
+#endif
+
 #ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
 bool cpuidle_state_is_coupled(struct cpuidle_driver *drv, int state);
 int cpuidle_coupled_state_verify(struct cpuidle_driver *drv);
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 2dbe46b7c213..fc4f2d7d7419 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -70,6 +70,9 @@ struct cpuidle_state {
 	void (*enter_s2idle) (struct cpuidle_device *dev,
 			      struct cpuidle_driver *drv,
 			      int index);
+#ifdef CONFIG_CPUIDLE_DEBUG_FS
+	struct dentry	*debugfs_dir;
+#endif
 };
 
 /* Idle State Flags */
-- 
2.17.1

