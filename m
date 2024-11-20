Return-Path: <linux-pm+bounces-17824-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD039D3FB5
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 17:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2212B35949
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 15:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B7A146D57;
	Wed, 20 Nov 2024 15:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YfMLuQ48"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4004513DDAA
	for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2024 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732117979; cv=none; b=QmOvvdPtcgynY3W8wlnAdGWWK3yIb4affNmDsKyi+i44vnknWfbpsD/UASQXGhLovuDrXC7D6RFIRE2VZHG5yuM6e9ABhBQ+pKM6yWguW+1mZkSY8Mq33DZIyKP2hZWL5uMn4gjwXDBozkBqLOhrvCZhPVJI+0foirjb4tDinVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732117979; c=relaxed/simple;
	bh=1R2evHqJjTAOJq6eWx6ez7n95sSq3cWULsEjyx+80CM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fQ764W+rlpLerwi6ki3Ny4HBEDh7f+Go/TBAA32VpcrwofGb2ct0TdYcjOe6195j4IB6K+f1n06FpsR9ZYIh/L6jUOlId1fHlwqThc4SL0h7fd07i7Lw8Z9Qegk5vwJuZkryaDW6ShFhu/u7/wHHL4PE3GGYjpW52y8Z616TjP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YfMLuQ48; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so40163035e9.3
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2024 07:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732117975; x=1732722775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W1+yrDJHhNP/k8iIQ03AESdYUNrwW2Xyy7iqhUZ+RYo=;
        b=YfMLuQ48Dw0tfb34k7hRgGPLfyKZse9vD6OPUut+n5RqjUyh9L8xBXun2ec2H1Ro2Y
         s3Mw8YEPwP3sDEVY6VeoO68dFUjjkijJ/y1rrT+AOwIeaDZrSXMSK8iWKNoliB5WH0q/
         tzsjfDDouJYzhmeVPjDqnBCs7wt3m/plZZrIndiOw9JNsvD2fTfEAl0l4AGIttA+4zKL
         b8pxEd+FDyVovqFa76pD8xCYyS2s6El9t8JvDwM6bCQwt2TBhjrkIQCIi95reO9CyXJf
         gjttnDiqwc2qwmnontugxHG1iCWJXwdPRduEhnXcBl71v8Ej7vta3iOYmvuU2tLYnxg9
         V8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732117975; x=1732722775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W1+yrDJHhNP/k8iIQ03AESdYUNrwW2Xyy7iqhUZ+RYo=;
        b=ALNEL+bJAD3bpV8Il8o4bf2gOQ5TJNW98SKyqjkcUU4nehr62aK9+D82A2EFwxMHJJ
         sA3IFDpoB0DcYvdcWcJo/v2JER8g4QrgHUHIDEpjiRlvMqzg01fkBQz3js+NyD2BDwC0
         uZ8+wnSC87cPlc7ofUGHn4R99AH+YDHNUpqob4aW3PZtsPihPVOsGkad1TmCV++oZkvJ
         5iS1RIEl0N1QDf6/Wfe7ijeo473w5K5WMZfMqwE6myh08/PYvhE4XoLFLB4hWynYb/Hb
         gOorFp67Mr+kBxc/f0HkSfzZ0hcpAR3pHGGFapdBEj4d8vJuCCh2vMOemdMWSX5dTJwf
         6qnw==
X-Forwarded-Encrypted: i=1; AJvYcCXvSAhIsEpSPw7DWodG+5ROCWX35eUTWMou0ttubFQ7Ndd1Ym/jCpM87aM2EwFdsNjFoEvr4hW7cw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUFQiDGIrXbqhd+Q8ToTqdkZ2SvWeQb4i6iba3ZXhqWYW9kluE
	i8QMdqIE3DVxqqM2Cywqe6x1ypX+/qwPIHFbLQui1Q34fgR9RsFkbqi7QQUbOHQ=
X-Google-Smtp-Source: AGHT+IEL4RGybpgX5qcUl8wnIgiRUiUJNeTcUs6MFYWo+q4NCVTyqqop0UHcXNi7CIJyBeH9DIsYQw==
X-Received: by 2002:a05:600c:19ca:b0:431:52f5:f48d with SMTP id 5b1f17b1804b1-4334f02a6b9mr31011725e9.31.1732117975472;
        Wed, 20 Nov 2024 07:52:55 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b45d4c68sm22990385e9.22.2024.11.20.07.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 07:52:54 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: rafael@kernel.org
Cc: saravanak@google.com,
	arnd@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quic_manafm@quicinc.com
Subject: [RFC 1/2] power: Userspace performance QoS
Date: Wed, 20 Nov 2024 16:52:44 +0100
Message-ID: <20241120155245.1710666-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the embedded ecosystem, the Linux kernel is modified to integrate
fake thermal cooling devices for the sake of the ABI exported in the
sysfs.

While investigating those different devices, it appears most of them
could fall under a performance QoS feature.

As discussed at the Linux Plumber Conference 2024, we want to let the
userspace to access the device performance knob via a char device
which would be created by the backend drivers and controlled with an
ioctl.

A performance constraint is a minimal or a maximal limit applied to a
device performance state. A process can only set one constraint per
limit, in other words a minimal performance and/or a maximal
performance constraint. A new value will change the current
constraint, not create a new one. If another constraint must be
stacked with the current one, then the char device file must be opened
again and the resulting new file descriptor must be used to create a
new constraint.

Constraint life cycle:

The userspace can be a place where buggy programs with root privileges
can tamper with the device performance. In order to prevent some dumb
logics to set a device performance state and then go away, thus
messing with the global system performance consistency, there is a
particular care of the constraint life cycles. These ones are directly
tied with the opened file descriptor of the char device. When it is
released, then the constraint is removed but only if its refcount
reaches zero. This situation exists if only process sets the
constraint and then closes the file descriptor (manually or at exit
time). If the process forks multiple time and the children inherit the
file descriptor, the constraint will be removed when all the children
close the file descriptor.

However, if another process opens the char device and sets a
constraint which already exists then that results in incrementing the
refcount of the constraint. The constraint is then removed when all
the processes have closed their file descriptor pointing to the char
device.

At creation time:

 - if another process asked for the same limit of performance, then
   the refcount constraint is incremented

 - if there is an existing constraint with a higher priority, then the
   requested constraint is queued in the ordered list of constraints

 - if there is an existing constraint with a lower limit, then the
   requested constrained is applied and the current constraint is
   queued in the ordered list of constraints

At removal time:

 - if the removed constraint is the current one, then the next
   constraint in the ordered list is applied

 - if the removed constraint is not the current one, then it is simply
   removed from the ordered list

The changes allows the userspace to set a performance constraint for a
specific device but the kernel may also want to apply a performance
constraint. The in-kernel API is not yet implemented as it represents
a significant amount of work depending on the direction of this patch.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/linux/perf_qos.h            |  45 ++
 include/uapi/linux/perf_qos_ioctl.h |  47 ++
 kernel/power/Makefile               |   2 +-
 kernel/power/perf_qos.c             | 652 ++++++++++++++++++++++++++++
 4 files changed, 745 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/perf_qos.h
 create mode 100644 include/uapi/linux/perf_qos_ioctl.h
 create mode 100644 kernel/power/perf_qos.c

diff --git a/include/linux/perf_qos.h b/include/linux/perf_qos.h
new file mode 100644
index 000000000000..57529c40be4d
--- /dev/null
+++ b/include/linux/perf_qos.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Performance QoS device abstraction
+ *
+ * Copyright (2024) Linaro Ltd
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ */
+#ifndef __PERF_QOS_H
+#define __PERF_QOS_H
+
+#include <uapi/linux/perf_qos_ioctl.h>
+
+struct perf_qos;
+
+/**
+ * struct perf_qos_value_descr - Performance constraint description
+ *
+ * @unit: the unit used for the constraint (normalized, throughput, ...)
+ * @limit_min: the minimal constraint limit to be set
+ * @limit_max: the maximal constraint limit to be set
+ */
+struct perf_qos_value_descr {
+	perf_qos_unit_t unit;
+	int limit_min;
+	int limit_max;
+};
+
+typedef int (*set_perf_limit_cb_t)(int);
+
+struct perf_qos_ops {
+	set_perf_limit_cb_t set_perf_limit_max;
+	set_perf_limit_cb_t set_perf_limit_min;
+};
+
+extern struct perf_qos *perf_qos_device_create(const char *name,
+					       struct perf_qos_ops *ops,
+					       struct perf_qos_value_descr *descr);
+
+extern int perf_qos_is_allowed(struct perf_qos *pq, int performance);
+
+extern void perf_qos_device_destroy(struct perf_qos *pq);
+
+#endif
diff --git a/include/uapi/linux/perf_qos_ioctl.h b/include/uapi/linux/perf_qos_ioctl.h
new file mode 100644
index 000000000000..a9fb8940c175
--- /dev/null
+++ b/include/uapi/linux/perf_qos_ioctl.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: LGPL-2.0+ WITH Linux-syscall-note */
+/*
+ * Performance QoS device abstraction
+ *
+ * Copyright (2024) Linaro Ltd
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ */
+#ifndef __PERF_QOS_IOCTL_H
+#define __PERF_QOS_IOCTL_H
+
+#include <linux/types.h>
+
+enum {
+	PERF_QOS_IOC_SET_MIN_CMD,
+	PERF_QOS_IOC_GET_MIN_CMD,
+	PERF_QOS_IOC_SET_MAX_CMD,
+	PERF_QOS_IOC_GET_MAX_CMD,
+	PERF_QOS_IOC_GET_UNIT_CMD,
+	PERF_QOS_IOC_GET_LIMITS_CMD,
+	PERF_QOS_IOC_MAX_CMD,
+};
+
+typedef enum {
+	PERF_QOS_UNIT_NORMAL,
+	PERF_QOS_UNIT_KBPS,
+	PERF_QOS_UNIT_MAX
+} perf_qos_unit_t;
+
+struct perf_qos_ioctl_arg {
+	int value;
+	int limit_min;
+	int limit_max;
+	perf_qos_unit_t unit;
+};
+
+#define PERF_QOS_IOCTL_TYPE 'P'
+
+#define PERF_QOS_IOC_SET_MIN	_IOW(PERF_QOS_IOCTL_TYPE, PERF_QOS_IOC_SET_MIN_CMD,	struct perf_qos_ioctl_arg *)
+#define PERF_QOS_IOC_GET_MIN	_IOR(PERF_QOS_IOCTL_TYPE, PERF_QOS_IOC_GET_MIN_CMD,	struct perf_qos_ioctl_arg *)
+#define PERF_QOS_IOC_SET_MAX	_IOW(PERF_QOS_IOCTL_TYPE, PERF_QOS_IOC_SET_MAX_CMD,	struct perf_qos_ioctl_arg *)
+#define PERF_QOS_IOC_GET_MAX	_IOR(PERF_QOS_IOCTL_TYPE, PERF_QOS_IOC_GET_MAX_CMD,	struct perf_qos_ioctl_arg *)
+#define PERF_QOS_IOC_GET_UNIT	_IOR(PERF_QOS_IOCTL_TYPE, PERF_QOS_IOC_GET_UNIT_CMD,	struct perf_qos_ioctl_arg *)
+#define PERF_QOS_IOC_GET_LIMITS	_IOR(PERF_QOS_IOCTL_TYPE, PERF_QOS_IOC_GET_LIMITS_CMD,	struct perf_qos_ioctl_arg *)
+
+#endif
diff --git a/kernel/power/Makefile b/kernel/power/Makefile
index 874ad834dc8d..e2e4d707ab6e 100644
--- a/kernel/power/Makefile
+++ b/kernel/power/Makefile
@@ -8,7 +8,7 @@ endif
 
 KASAN_SANITIZE_snapshot.o	:= n
 
-obj-y				+= qos.o
+obj-y				+= qos.o perf_qos.o
 obj-$(CONFIG_PM)		+= main.o
 obj-$(CONFIG_VT_CONSOLE_SLEEP)	+= console.o
 obj-$(CONFIG_FREEZER)		+= process.o
diff --git a/kernel/power/perf_qos.c b/kernel/power/perf_qos.c
new file mode 100644
index 000000000000..ca0619b07ae5
--- /dev/null
+++ b/kernel/power/perf_qos.c
@@ -0,0 +1,652 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Performance Quality of Service (Perf QoS) support base.
+ *
+ * Copyright (C) 2024 Linaro Ltd
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ */
+#include <linux/cdev.h>
+#include <linux/perf_qos.h>
+#include <linux/list_sort.h>
+
+#define DEVNAME "perf_qos"
+#define NUM_PERF_QOS_MINORS 128
+
+static DEFINE_IDR(perf_qos_minors);
+static struct class *perf_qos_class;
+static dev_t perf_qos_devt;
+
+typedef enum {
+	PERF_QOS_LIMIT_MAX,
+	PERF_QOS_LIMIT_MIN,
+} perf_qos_limit_t;
+
+/**
+ * struct perf_qos_constraint - structure holding a constraint information
+ *
+ * @soft_limit: an integer corresponding of the limit value set
+ * @hard_limit: an integer corresponding to the limit value allowed by the driver
+ * @kref: a refcount to the constraint responsible of its life cycle
+ * @set_perf_limit_cb: a callback to notify the backend driver about the limit change
+ * @node: the list node to attach this constraint with the list of constraints
+ * @head: the list of constraints the @node
+ *
+ * This structure has a couple of instanciation per perf QoS file
+ * opened by a process. The process can apply one or two constraints
+ * to the device.
+ *
+ * Other processes will allocate their own constraints which will be
+ * added in the list of constraints.
+ */
+struct perf_qos_constraint {
+	int soft_limit;
+	int hard_limit;
+	set_perf_limit_cb_t set_perf_limit_cb;
+	struct kref kref;
+	struct list_head node;
+	struct list_head *head;
+};
+
+/**
+ * struct perf_qos - structure owning the constraint information for
+ * 			the device
+ *
+ * @lock: lock to protect the actions on the list of constraints
+ * @perf_qos_cdev: a struct cdev used for the device destruction
+ * @ops: the ops given by the backend driver to notify the change of constraint
+ * @descr: a constraint descriptor giving the units and the boundaries
+ * @perf_min: the list of the minimal performance constraints
+ * @perf_max: the list of the maximal performance constraints
+ */
+struct perf_qos {
+	spinlock_t lock;
+	struct cdev perf_qos_cdev;
+	struct perf_qos_ops *ops;
+	struct perf_qos_value_descr *descr;
+	struct list_head perf_min;
+	struct list_head perf_max;
+};
+
+/**
+ * struct perf_qos_data - structure with the requested constraints
+ *
+ * @pqc_min: the requested performance constraint giving the minimal value
+ * @pqc_max: the requested performance constraint giving the maximal value
+ */
+struct perf_qos_data {
+	struct perf_qos_constraint *pqc_min;
+	struct perf_qos_constraint *pqc_max;
+};
+
+static struct perf_qos_constraint *perf_qos_constraint_find(struct list_head *list, int value)
+{
+	struct perf_qos_constraint *pcq;
+
+	list_for_each_entry(pcq, list, node) {
+		if (pcq->soft_limit == value)
+			return pcq;
+	}
+
+	return NULL;
+}
+
+static int perf_qos_constraint_cmp(void *data,
+				   const struct list_head *l1,
+				   const struct list_head *l2)
+{
+	struct perf_qos_constraint *pqc1 = container_of(l1, struct perf_qos_constraint, node);
+	struct perf_qos_constraint *pqc2 = container_of(l2, struct perf_qos_constraint, node);
+
+	/*
+	 * The comparison will depend if we apply a max or min
+	 * performance constraint. If the soft limit is lesser than
+	 * the hard limit, that means it is a maximum limitation.
+	 */
+	if (pqc1->soft_limit < pqc1->hard_limit)
+		return pqc1->soft_limit - pqc2->soft_limit;
+
+	return pqc2->soft_limit - pqc1->soft_limit;
+}
+
+static int perf_qos_del(struct perf_qos_constraint *pcq)
+{
+	const struct perf_qos_constraint *first;
+	int new_limit;
+
+	first = list_first_entry(pcq->head, struct perf_qos_constraint, node);
+
+	list_del(&pcq->node);
+
+	/*
+	 * The active constraint is not the one we removed, so there
+	 * is nothing more to do
+	 */
+	if (first != pcq)
+		return 0;
+
+	/*
+	 * As we remove the first entry, then get the new first entry
+	 * to apply the next constraint. If there is no more
+	 * constraint set, reset to the original limit. Otherwise, use
+	 * the new constraint value.
+	 */
+	if (list_empty(pcq->head))
+		new_limit = pcq->hard_limit;
+	else {
+		first = list_first_entry(pcq->head, struct perf_qos_constraint, node);
+		new_limit = first->soft_limit;
+	};
+
+	/*
+	 * Notify the backend driver to update its performance level
+	 * if needed. If the performance level is currently inside the
+	 * new limits, nothing will happen. Otherwise it must be
+	 * adjust the current performance level to be inside the
+	 * authorized limits
+	 */
+	pcq->set_perf_limit_cb(new_limit);
+
+	return 1;
+}
+
+static int perf_qos_add(struct perf_qos_constraint *pcq)
+{
+	const struct perf_qos_constraint *first;
+
+	list_add(&pcq->node, pcq->head);
+
+	list_sort(NULL, pcq->head, perf_qos_constraint_cmp);
+
+	/*
+	 * A sort happened resulting in a different constraint at the head
+	 */
+	first = list_first_entry(pcq->head, struct perf_qos_constraint, node);
+
+	/*
+	 * The inserted constraint did not become the active one, so
+	 * we can bail out
+	 */
+	if (pcq != first)
+		return 0;
+
+	/*
+	 * Notify the backend driver to update its performance level
+	 * if needed. If the performance level is currently inside the
+	 * new limits, nothing will happen. Otherwise it must be
+	 * adjust the current performance level to be inside the
+	 * authorized limits
+	 */
+	pcq->set_perf_limit_cb(first->soft_limit);
+
+	return 1;
+}
+
+static void perf_qos_constraint_release(struct kref *kref)
+{
+	struct perf_qos_constraint *pcq;
+
+	pcq = container_of(kref, struct perf_qos_constraint, kref);
+
+	/*
+	 * The removal of the constraint results in the change of the
+	 * first entry of the list which means it was the active
+	 * one. We need to apply the next constraint of the list
+	 */
+	if (perf_qos_del(pcq)) {
+		/* Something to do */
+	}
+
+	kfree(pcq);
+}
+
+static void perf_qos_constraint_put(struct perf_qos_constraint *pcq)
+{
+	kref_put(&pcq->kref, perf_qos_constraint_release);
+}
+
+static void perf_qos_constraint_get(struct perf_qos_constraint *pcq)
+{
+	kref_get(&pcq->kref);
+}
+
+static struct perf_qos_constraint *perf_qos_constraint_alloc(struct perf_qos *pq, int soft_limit,
+							     struct list_head *perf, perf_qos_limit_t limit)
+{
+	struct perf_qos_constraint *pqc;
+
+	pqc = kzalloc(sizeof(*pqc), GFP_KERNEL);
+	if (!pqc)
+		return NULL;
+
+	kref_init(&pqc->kref);
+	INIT_LIST_HEAD(&pqc->node);
+
+	if (limit == PERF_QOS_LIMIT_MAX) {
+		pqc->set_perf_limit_cb = pq->ops->set_perf_limit_max;
+		pqc->hard_limit = pq->descr->limit_max;
+	} else {
+		pqc->set_perf_limit_cb = pq->ops->set_perf_limit_min;
+		pqc->hard_limit = pq->descr->limit_min;
+	}
+
+	pqc->head = perf;
+	pqc->soft_limit = soft_limit;
+
+	return pqc;
+}
+
+static int perf_qos_open(struct inode *inode, struct file *file)
+{
+	struct perf_qos_data *pqd;
+	struct perf_qos *pq;
+
+	pq = idr_find(&perf_qos_minors, iminor(inode));
+	if (!pq)
+		return -ENODEV;
+
+	inode->i_private = pq;
+
+	pqd = kzalloc(sizeof(*pqd), GFP_KERNEL);
+	if (!pqd)
+		return -ENOMEM;
+
+	file->private_data = pqd;
+
+	return 0;
+}
+
+static int perf_qos_release(struct inode *inode, struct file *file)
+{
+	struct perf_qos *pq = inode->i_private;
+	struct perf_qos_data *pqd = file->private_data;
+
+	spin_lock(&pq->lock);
+
+	if (pqd->pqc_min)
+		perf_qos_constraint_put(pqd->pqc_min);
+
+	if (pqd->pqc_max)
+		perf_qos_constraint_put(pqd->pqc_max);
+
+	spin_unlock(&pq->lock);
+
+	kfree(pqd);
+
+	return 0;
+}
+
+static int perf_qos_unset(struct perf_qos_constraint **cur_pqc,
+			  perf_qos_limit_t limit, struct list_head *perf, int value)
+{
+	/*
+	 * Removing a constraint:
+	 *
+	 * - if it exists then *current_pqc is set. We decrement the
+         *   refcount and update the current constraint by setting it
+         *   to NULL
+	 *
+	 * - if the current constraint does not exist then, it is an
+         *   error and we should exit with an error
+	 */
+	if (!(*cur_pqc))
+		return -EINVAL;
+
+	perf_qos_constraint_put(*cur_pqc);
+	*cur_pqc = NULL;
+
+	return 0;
+}
+
+static int perf_qos_set(struct perf_qos *pq, struct perf_qos_constraint **cur_pqc,
+			perf_qos_limit_t limit, struct list_head *perf, int value)
+{
+	struct perf_qos_constraint *pqc;
+	int ret = 0;
+
+	/*
+	 * We are trying to set the same constraint.
+	 */
+	if (*cur_pqc && ((*cur_pqc)->soft_limit == value)) {
+		ret = -EALREADY;
+		goto out;
+	}
+
+	/*
+	 * Case 2 : Adding a constraint:
+	 *
+	 * - it already exists because it was created by another
+	 *   process, we increment the refcount
+	 *
+	 * - it already exists because we created it before, we
+	 *   return an error
+	 *
+	 * - it does not exist but there is a previous different
+         *   constraint we set before. It is a constraint change. We
+         *   must release the previous constraint and create a new
+         *   one. However, we apply the new constraint and then we
+         *   remove the old one in order to not have the backend
+         *   driver with a window where there is no constraint at all
+	 *
+	 * - it does not exist and there is no previous constraint. It
+         *   is a new constraint. We allocate the constraint, apply it
+         *   and set it as the current constraint
+	 */
+	pqc = perf_qos_constraint_find(perf, value);
+	if (pqc) {
+		perf_qos_constraint_get(pqc);
+	} else {
+		pqc = perf_qos_constraint_alloc(pq, value, perf, limit);
+		if (!pqc) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		/*
+		 * The new constraint has to be applied because it
+		 * results in a change of the first entry of the list
+		 * of constraints
+		 */
+		if (perf_qos_add(pqc)) {
+			/* Something to do */
+		}
+	}
+
+	/*
+	 * We previously set a constraint, let's release the refcount
+	 * as we change it. The constraint can be freed if we are the
+	 * last one having a reference to it or if we are the creator
+	 * and no other process held a refcount on it.
+	 */
+	if ((*cur_pqc))
+		perf_qos_constraint_put(*cur_pqc);
+
+	*cur_pqc = pqc;
+out:
+	return ret;
+}
+
+static int ioctl_perf_qos_set_max(struct perf_qos *pq,
+				  struct perf_qos_data *pqd,
+				  struct perf_qos_ioctl_arg *pqia)
+{
+	if (pqia->value > pq->descr->limit_max)
+		return -EINVAL;
+
+	if (pqia->value == pq->descr->limit_max)
+		return perf_qos_unset(&pqd->pqc_max, PERF_QOS_LIMIT_MAX,
+				    &pq->perf_max, pqia->value);
+	else
+		return perf_qos_set(pq, &pqd->pqc_max, PERF_QOS_LIMIT_MAX,
+				    &pq->perf_max, pqia->value);
+}
+
+static int ioctl_perf_qos_set_min(struct perf_qos *pq,
+				  struct perf_qos_data *pqd,
+				  struct perf_qos_ioctl_arg *pqia)
+{
+	if (pqia->value < pq->descr->limit_min)
+		return -EINVAL;
+
+	if (pqia->value == pq->descr->limit_min)
+		return perf_qos_unset(&pqd->pqc_min, PERF_QOS_LIMIT_MIN,
+				    &pq->perf_min, pqia->value);
+	else
+		return perf_qos_set(pq, &pqd->pqc_min, PERF_QOS_LIMIT_MIN,
+				    &pq->perf_min, pqia->value);
+}
+
+static int perf_qos_get(struct list_head *perf, int *value)
+{
+	struct perf_qos_constraint *pqc;
+
+	/*
+	 * We may not have set any performance constraint yet but
+	 * another process may have set one, so we get the head of
+	 * performance constraint list
+	 */
+	if (list_empty(perf))
+		return -ENODATA;
+
+	pqc = list_first_entry(perf, struct perf_qos_constraint, node);
+
+	*value = pqc->soft_limit;
+
+	return 0;
+}
+
+static int ioctl_perf_qos_get_min(struct perf_qos *pq,
+				  struct perf_qos_data *pqd,
+				  struct perf_qos_ioctl_arg *pqia)
+{
+	return perf_qos_get(&pq->perf_min, &pqia->value);
+}
+
+static int ioctl_perf_qos_get_max(struct perf_qos *pq,
+				  struct perf_qos_data *pqd,
+				  struct perf_qos_ioctl_arg *pqia)
+{
+	return perf_qos_get(&pq->perf_max, &pqia->value);
+}
+
+static int ioctl_perf_qos_get_unit(struct perf_qos *pq,
+				   struct perf_qos_data *pqd,
+				   struct perf_qos_ioctl_arg *pqia)
+{
+	pqia->unit = pq->descr->unit;
+
+	return 0;
+}
+
+static int ioctl_perf_qos_get_limits(struct perf_qos *pq,
+				     struct perf_qos_data *pqd,
+				     struct perf_qos_ioctl_arg *pqia)
+{
+	pqia->limit_min = pq->descr->limit_min;
+	pqia->limit_max = pq->descr->limit_max;
+
+	return 0;
+}
+
+typedef int (*perf_qos_ioctl_ops_t)(struct perf_qos *pq,
+				    struct perf_qos_data *pqd,
+				    struct perf_qos_ioctl_arg *pqia);
+
+static long perf_qos_ioctl(struct file *file, unsigned int ucmd,
+			   unsigned long arg)
+{
+	struct perf_qos_data *pqd = file->private_data;
+	struct perf_qos *pq = file->f_inode->i_private;
+	struct perf_qos_ioctl_arg pqia;
+	int cmd = _IOC_NR(ucmd);
+	int dir = _IOC_DIR(ucmd);
+	int type = _IOC_TYPE(ucmd);
+	int ret;
+
+	perf_qos_ioctl_ops_t perf_qos_ioctl_ops[] = {
+		[PERF_QOS_IOC_SET_MAX_CMD]  	= ioctl_perf_qos_set_max,
+		[PERF_QOS_IOC_SET_MIN_CMD]  	= ioctl_perf_qos_set_min,
+		[PERF_QOS_IOC_GET_MAX_CMD]  	= ioctl_perf_qos_get_max,
+		[PERF_QOS_IOC_GET_MIN_CMD]  	= ioctl_perf_qos_get_min,
+		[PERF_QOS_IOC_GET_UNIT_CMD] 	= ioctl_perf_qos_get_unit,
+		[PERF_QOS_IOC_GET_LIMITS_CMD] 	= ioctl_perf_qos_get_limits,
+	};
+
+	if (type != PERF_QOS_IOCTL_TYPE)
+		return -EINVAL;
+
+	if (cmd < 0 || cmd >= PERF_QOS_IOC_MAX_CMD)
+		return -EINVAL;
+
+	if (dir & _IOC_WRITE) {
+		if (copy_from_user(&pqia, (typeof(pqia) *)arg, sizeof(pqia)))
+			return -EACCES;
+	}
+
+	spin_lock(&pq->lock);
+	ret = perf_qos_ioctl_ops[cmd](pq, pqd, &pqia);
+	spin_unlock(&pq->lock);
+
+	if (ret)
+		goto out;
+
+	if (dir & _IOC_READ) {
+		if (copy_to_user((typeof(pqia) *)arg, &pqia, sizeof(pqia)))
+			return -EACCES;
+	}
+out:
+	return ret;
+}
+
+static const struct file_operations perf_qos_fops = {
+	.owner          = THIS_MODULE,
+	.open		= perf_qos_open,
+	.release	= perf_qos_release,
+	.unlocked_ioctl = perf_qos_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= perf_qos_ioctl,
+#endif
+};
+
+void perf_qos_device_destroy(struct perf_qos *pq)
+{
+	idr_remove(&perf_qos_minors, MINOR(pq->perf_qos_cdev.dev));
+	device_destroy(perf_qos_class, pq->perf_qos_cdev.dev);
+	cdev_del(&pq->perf_qos_cdev);
+	kfree(pq->descr);
+	kfree(pq->ops);
+	kfree(pq);
+}
+EXPORT_SYMBOL_GPL(perf_qos_device_destroy);
+
+int perf_qos_is_allowed(struct perf_qos *pq, int performance)
+{
+	const struct perf_qos_constraint *first;
+	int allowed = 1;
+
+	spin_lock(&pq->lock);
+
+	first = list_first_entry(&pq->perf_min, struct perf_qos_constraint, node);
+	if (performance < first->soft_limit)
+		allowed = 0;
+
+	first = list_first_entry(&pq->perf_max, struct perf_qos_constraint, node);
+	if (performance > first->soft_limit)
+		allowed = 0;
+
+	spin_unlock(&pq->lock);
+
+	return allowed;
+}
+EXPORT_SYMBOL_GPL(perf_qos_is_allowed);
+
+struct perf_qos *perf_qos_device_create(const char *name,
+					struct perf_qos_ops *ops,
+					struct perf_qos_value_descr *descr)
+{
+	struct device *dev;
+	struct perf_qos *pq;
+	dev_t devt;
+	int minor;
+	int ret;
+
+	if (!ops->set_perf_limit_max || !ops->set_perf_limit_min)
+		return ERR_PTR(-EINVAL);
+
+	if (descr->unit < 0 || descr->unit >= PERF_QOS_UNIT_MAX)
+		return ERR_PTR(-EINVAL);
+
+	if (descr->limit_min > descr->limit_max)
+		return ERR_PTR(-EINVAL);
+
+	if (descr->unit == PERF_QOS_UNIT_NORMAL) {
+		if (descr->limit_min < 0 || descr->limit_max > 1024)
+			return ERR_PTR(-EINVAL);
+	}
+
+	pq = kzalloc(sizeof(*pq), GFP_KERNEL);
+	if (!pq)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&pq->perf_min);
+	INIT_LIST_HEAD(&pq->perf_max);
+	spin_lock_init(&pq->lock);
+
+	pq->ops = kmemdup(ops, sizeof(*ops), GFP_KERNEL);
+	if (!pq->ops) {
+		ret = -ENOMEM;
+		goto out_kfree_pq;
+	}
+
+	pq->descr = kmemdup(descr, sizeof(*descr), GFP_KERNEL);
+	if (!pq->descr) {
+		ret = -ENOMEM;
+		goto out_kfree_pq_ops;
+	}
+
+	minor = idr_alloc(&perf_qos_minors, pq, 0,
+			  NUM_PERF_QOS_MINORS, GFP_KERNEL);
+	if (minor < 0)
+		goto out_kfree_pq_descr;
+
+	devt = MKDEV(MAJOR(perf_qos_devt), minor);
+
+	cdev_init(&pq->perf_qos_cdev, &perf_qos_fops);
+
+	ret = cdev_add(&pq->perf_qos_cdev, devt, 1);
+	if (ret < 0)
+		goto out_idr_remove;
+
+	dev = device_create(perf_qos_class, NULL, devt, NULL, name);
+	if (IS_ERR(dev)) {
+		ret = PTR_ERR(dev);
+		goto out_cdev_del;
+	}
+
+	return pq;
+
+out_cdev_del:
+	cdev_del(&pq->perf_qos_cdev);
+
+out_idr_remove:
+	idr_remove(&perf_qos_minors, minor);
+
+out_kfree_pq_descr:
+	kfree(pq->descr);
+
+out_kfree_pq_ops:
+	kfree(pq->ops);
+
+out_kfree_pq:
+	kfree(pq);
+
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(perf_qos_device_create);
+
+static char *perf_qos_devnode(const struct device *dev, umode_t *mode)
+{
+	return kasprintf(GFP_KERNEL, "%s/%s", DEVNAME, dev_name(dev));
+}
+
+static int perf_qos_init(void)
+{
+	int ret;
+
+	ret = alloc_chrdev_region(&perf_qos_devt, 0,
+				  NUM_PERF_QOS_MINORS, DEVNAME);
+	if (ret)
+		return ret;
+
+	perf_qos_class = class_create(DEVNAME);
+	if (IS_ERR(perf_qos_class)) {
+		unregister_chrdev_region(perf_qos_devt, NUM_PERF_QOS_MINORS);
+		return PTR_ERR(perf_qos_class);
+	}
+	perf_qos_class->devnode = perf_qos_devnode;
+
+	return 0;
+}
+
+subsys_initcall(perf_qos_init);
-- 
2.43.0


