Return-Path: <linux-pm+bounces-33497-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 658A3B3D673
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 04:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D1B3BB32A
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 02:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8989F224AE0;
	Mon,  1 Sep 2025 02:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="oTVamgvk"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E08219A8D;
	Mon,  1 Sep 2025 02:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756692043; cv=none; b=Tlz+ZT/Akkgqhyu3jmw7Oj6n2k5t6zSvI8v2JzZo6rBL27sp9QkesaYbrbVGDrwxYW3HuqObKdydw26IT3WKZAijubsohP4l5MdfOVm5n+/LvAUFAn7rAa7ytGzxbkCfnK7hu4iS/EHU7jKQvO3T5c1sNfRmFD7kkFRPXEs4yVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756692043; c=relaxed/simple;
	bh=dsCMGD/7CHdus/6QYTXaZOkmaWXblr8JC8+GVHl1lY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9AmeC38jm/Rj0sdducX3+gdf1DR/h5Zmx+pMDFK/C2bQAuRF8bE8MW/irVyWgE5gBPldTgpcY1hUyzODCgL+fmyWvOAH9WtLpx7wBplxFudk9hHj4q2Z6I0qjddGmgUKTkgVXqJyNN4AqfMlZ8X6KtJoCyX1ARjGZtgWz0Qr84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=oTVamgvk; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Y4aTvxu/44cDdKCEwC4qrk+bUJCVLM13hCu0G1Ejf98=; b=oTVamgvkDFHmvDg4EILIERApeg
	4gMz2r72+WytsoYE3/VYtqwGjuEZ8Kqvsu+9Xg6vJI7MrdG/2yls4ewvb0EK1WP98UEwnOUMB/hE4
	y+iq8thbfX+/HWNsCoNem7kfOtHL+fnbcuj8q7LRm2H+iM81q0MmHFFYMFzSK+S3BnmdXnlPzXgBw
	kN+kyZ1+F4RSboTsVUDXAystY7WjXBwgSprnfEAc9ntY5o+EauH928r+cQUUJQIKA3c8QQY+w8bj6
	TmDMHice87KSDqz+mufTtTQ5w8lGeMS3u/DGld3NSVtaQsd9aqlPEGZ4WZQ1QdHKaZToW70FONccu
	4Nz8qm6Q==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ustqT-0054Tz-Ak; Mon, 01 Sep 2025 04:00:34 +0200
From: Changwoo Min <changwoo@igalia.com>
To: lukasz.luba@arm.com,
	rafael@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org
Cc: christian.loehle@arm.com,
	tj@kernel.org,
	kernel-dev@igalia.com,
	linux-pm@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH v4 04/10] PM: EM: Add em.yaml and autogen files
Date: Mon,  1 Sep 2025 10:59:57 +0900
Message-ID: <20250901020003.86415-5-changwoo@igalia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901020003.86415-1-changwoo@igalia.com>
References: <20250901020003.86415-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a generic netlink spec in YAML format and autogenerate boilerplate
code using ynl-regen.sh to introduce a generic netlink for the energy
model. It allows a userspace program to read the performance domain and
its energy model. It notifies the userspace program when a performance
domain is created or deleted or its energy model is updated through a
multicast interface.

Specifically, it supports two commands:
  - EM_CMD_GET_PDS: Get the list of information for all performance
    domains.
  - EM_CMD_GET_PD_TABLE: Get the energy model table of a performance
    domain.

Also, it supports three notification events:
  - EM_CMD_PD_CREATED: When a performance domain is created.
  - EM_CMD_PD_DELETED: When a performance domain is deleted.
  - EM_CMD_PD_UPDATED: When the energy model table of a performance domain
    is updated.

Finally, update MAINTAINERS to include new files.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 Documentation/netlink/specs/em.yaml | 113 ++++++++++++++++++++++++++++
 MAINTAINERS                         |   3 +
 include/uapi/linux/energy_model.h   |  62 +++++++++++++++
 kernel/power/em_netlink_autogen.c   |  48 ++++++++++++
 kernel/power/em_netlink_autogen.h   |  23 ++++++
 5 files changed, 249 insertions(+)
 create mode 100644 Documentation/netlink/specs/em.yaml
 create mode 100644 include/uapi/linux/energy_model.h
 create mode 100644 kernel/power/em_netlink_autogen.c
 create mode 100644 kernel/power/em_netlink_autogen.h

diff --git a/Documentation/netlink/specs/em.yaml b/Documentation/netlink/specs/em.yaml
new file mode 100644
index 000000000000..9905ca482325
--- /dev/null
+++ b/Documentation/netlink/specs/em.yaml
@@ -0,0 +1,113 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+name: em
+
+doc: |
+  Energy model netlink interface to notify its changes.
+
+protocol: genetlink
+
+uapi-header: linux/energy_model.h
+
+attribute-sets:
+  -
+    name: pds
+    attributes:
+      -
+        name: pd
+        type: nest
+        nested-attributes: pd
+        multi-attr: true
+  -
+    name: pd
+    attributes:
+      -
+        name: pad
+        type: pad
+      -
+        name: pd-id
+        type: u32
+      -
+        name: flags
+        type: u64
+      -
+        name: cpus
+        type: string
+  -
+    name: pd-table
+    attributes:
+      -
+        name: pd-id
+        type: u32
+      -
+        name: ps
+        type: nest
+        nested-attributes: ps
+        multi-attr: true
+  -
+    name: ps
+    attributes:
+      -
+        name: pad
+        type: pad
+      -
+        name: performance
+        type: u64
+      -
+        name: frequency
+        type: u64
+      -
+        name: power
+        type: u64
+      -
+        name: cost
+        type: u64
+      -
+        name: flags
+        type: u64
+
+operations:
+  list:
+    -
+      name: get-pds
+      attribute-set: pds
+      doc: Get the list of information for all performance domains.
+      do:
+        reply:
+          attributes:
+            - pd
+    -
+      name: get-pd-table
+      attribute-set: pd-table
+      doc: Get the energy model table of a performance domain.
+      do:
+        request:
+          attributes:
+            - pd-id
+        reply:
+          attributes:
+            - pd-id
+            - ps
+    -
+      name: pd-created
+      doc: A performance domain is created.
+      notify: get-pd-table
+      mcgrp: event
+    -
+      name: pd-updated
+      doc: A performance domain is updated.
+      notify: get-pd-table
+      mcgrp: event
+    -
+      name: pd-deleted
+      doc: A performance domain is deleted.
+      attribute-set: pd-table
+      event:
+        attributes:
+            - pd-id
+      mcgrp: event
+
+mcast-groups:
+  list:
+    -
+      name: event
diff --git a/MAINTAINERS b/MAINTAINERS
index 6dcfbd11efef..0151a0bddd3b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9024,6 +9024,9 @@ S:	Maintained
 F:	kernel/power/energy_model.c
 F:	include/linux/energy_model.h
 F:	Documentation/power/energy-model.rst
+F:	Documentation/netlink/specs/em.yaml
+F:	include/uapi/linux/energy_model.h
+F:	kernel/power/em_netlink_autogen.*
 
 EPAPR HYPERVISOR BYTE CHANNEL DEVICE DRIVER
 M:	Laurentiu Tudor <laurentiu.tudor@nxp.com>
diff --git a/include/uapi/linux/energy_model.h b/include/uapi/linux/energy_model.h
new file mode 100644
index 000000000000..4ec4c0eabbbb
--- /dev/null
+++ b/include/uapi/linux/energy_model.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/em.yaml */
+/* YNL-GEN uapi header */
+
+#ifndef _UAPI_LINUX_ENERGY_MODEL_H
+#define _UAPI_LINUX_ENERGY_MODEL_H
+
+#define EM_FAMILY_NAME		"em"
+#define EM_FAMILY_VERSION	1
+
+enum {
+	EM_A_PDS_PD = 1,
+
+	__EM_A_PDS_MAX,
+	EM_A_PDS_MAX = (__EM_A_PDS_MAX - 1)
+};
+
+enum {
+	EM_A_PD_PAD = 1,
+	EM_A_PD_PD_ID,
+	EM_A_PD_FLAGS,
+	EM_A_PD_CPUS,
+
+	__EM_A_PD_MAX,
+	EM_A_PD_MAX = (__EM_A_PD_MAX - 1)
+};
+
+enum {
+	EM_A_PD_TABLE_PD_ID = 1,
+	EM_A_PD_TABLE_PS,
+
+	__EM_A_PD_TABLE_MAX,
+	EM_A_PD_TABLE_MAX = (__EM_A_PD_TABLE_MAX - 1)
+};
+
+enum {
+	EM_A_PS_PAD = 1,
+	EM_A_PS_PERFORMANCE,
+	EM_A_PS_FREQUENCY,
+	EM_A_PS_POWER,
+	EM_A_PS_COST,
+	EM_A_PS_FLAGS,
+
+	__EM_A_PS_MAX,
+	EM_A_PS_MAX = (__EM_A_PS_MAX - 1)
+};
+
+enum {
+	EM_CMD_GET_PDS = 1,
+	EM_CMD_GET_PD_TABLE,
+	EM_CMD_PD_CREATED,
+	EM_CMD_PD_UPDATED,
+	EM_CMD_PD_DELETED,
+
+	__EM_CMD_MAX,
+	EM_CMD_MAX = (__EM_CMD_MAX - 1)
+};
+
+#define EM_MCGRP_EVENT	"event"
+
+#endif /* _UAPI_LINUX_ENERGY_MODEL_H */
diff --git a/kernel/power/em_netlink_autogen.c b/kernel/power/em_netlink_autogen.c
new file mode 100644
index 000000000000..a7a09ab1d1c2
--- /dev/null
+++ b/kernel/power/em_netlink_autogen.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/em.yaml */
+/* YNL-GEN kernel source */
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include "em_netlink_autogen.h"
+
+#include <uapi/linux/energy_model.h>
+
+/* EM_CMD_GET_PD_TABLE - do */
+static const struct nla_policy em_get_pd_table_nl_policy[EM_A_PD_TABLE_PD_ID + 1] = {
+	[EM_A_PD_TABLE_PD_ID] = { .type = NLA_U32, },
+};
+
+/* Ops table for em */
+static const struct genl_split_ops em_nl_ops[] = {
+	{
+		.cmd	= EM_CMD_GET_PDS,
+		.doit	= em_nl_get_pds_doit,
+		.flags	= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= EM_CMD_GET_PD_TABLE,
+		.doit		= em_nl_get_pd_table_doit,
+		.policy		= em_get_pd_table_nl_policy,
+		.maxattr	= EM_A_PD_TABLE_PD_ID,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+};
+
+static const struct genl_multicast_group em_nl_mcgrps[] = {
+	[EM_NLGRP_EVENT] = { "event", },
+};
+
+struct genl_family em_nl_family __ro_after_init = {
+	.name		= EM_FAMILY_NAME,
+	.version	= EM_FAMILY_VERSION,
+	.netnsok	= true,
+	.parallel_ops	= true,
+	.module		= THIS_MODULE,
+	.split_ops	= em_nl_ops,
+	.n_split_ops	= ARRAY_SIZE(em_nl_ops),
+	.mcgrps		= em_nl_mcgrps,
+	.n_mcgrps	= ARRAY_SIZE(em_nl_mcgrps),
+};
diff --git a/kernel/power/em_netlink_autogen.h b/kernel/power/em_netlink_autogen.h
new file mode 100644
index 000000000000..78ce609641f1
--- /dev/null
+++ b/kernel/power/em_netlink_autogen.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/em.yaml */
+/* YNL-GEN kernel header */
+
+#ifndef _LINUX_EM_GEN_H
+#define _LINUX_EM_GEN_H
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include <uapi/linux/energy_model.h>
+
+int em_nl_get_pds_doit(struct sk_buff *skb, struct genl_info *info);
+int em_nl_get_pd_table_doit(struct sk_buff *skb, struct genl_info *info);
+
+enum {
+	EM_NLGRP_EVENT,
+};
+
+extern struct genl_family em_nl_family;
+
+#endif /* _LINUX_EM_GEN_H */
-- 
2.51.0


