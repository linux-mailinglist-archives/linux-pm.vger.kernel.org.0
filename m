Return-Path: <linux-pm+bounces-40418-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EEAD01208
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 06:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6441830471A3
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 05:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9153161B1;
	Thu,  8 Jan 2026 05:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="cqMPOLj1"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9A8315D24;
	Thu,  8 Jan 2026 05:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767850374; cv=none; b=BpzjVwXJPDyda1NiJgcctTF5zOttlEDG40GWJL1lAywelvqP+W/rnwaLJ3HFm8tqCjHbyD3mCc57adxP8lFd3Az5aKjBvkSk2auTRTsX9+x40SJFtHv7PFj3iWolyKHXi7ViI4NnQWDL6ZZ9vUcv1156I8+Q8oPwa7y9lWrIYV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767850374; c=relaxed/simple;
	bh=umcr4V4OWsm97p6JlS0pcQ88dGoFzueE6O63BI3jrLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D3Zq2pibp36a7AEOFFA49/l3GGrd1jyif3eGwxPQvIUB9OK/bFkQwFGOw91sXuGvLxtgU6N8r77L5pXnrPokltzONUyuTR18pu5ZeOOtuFPH/hDQHxqTaLIkqvQp/BR0In8HCpVtG8UPEXoKItEjHpg59SKqLwF+51Mfv+En2Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=cqMPOLj1; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=O3MU2NWUBxOwKIjwkLe4ym4uDWSMKFRj2/XqIZZoL1w=; b=cqMPOLj1lDc3J2e2OwFZRerush
	Vi7NQDwgLzIoSX8m9uEldS2ismb0afkYkLW8w3oXZyhGm1O7D355w2QdyKkCiRlSc24utK29JL/of
	rFSG0Z6YUXgBv2AG4yFODngR514J1a2LZ2DVMzruIAlwklLaTE3XATajHvVBzph5m0woNXfYx72sG
	hCpdtJuHa9dfAQwYP5FAgLzSjoqrlv47JTXRntaUXKQVBR4p/l3LDbEhlaQVBzRXYWGzf9KLeaPi0
	JiA1I91lkMNQKLEbgpgSCUqLlJ2hrENuHF2bzMdUvs3zSg1TE4c0hDpfUKMY4rj55peULOMq1PGNp
	gGmYE1NA==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vdidS-002qDc-1j; Thu, 08 Jan 2026 06:32:39 +0100
From: Changwoo Min <changwoo@igalia.com>
To: lukasz.luba@arm.com,
	rafael@kernel.org,
	donald.hunter@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	lenb@kernel.org,
	pavel@kernel.org,
	changwoo@igalia.com
Cc: kernel-dev@igalia.com,
	linux-pm@vger.kernel.org,
	netdev@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 for 6.19 2/4] PM: EM: Rename em.yaml to dev-energymodel.yaml
Date: Thu,  8 Jan 2026 14:32:10 +0900
Message-ID: <20260108053212.642478-3-changwoo@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108053212.642478-1-changwoo@igalia.com>
References: <20260108053212.642478-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The EM YNL specification used many acronyms, including ‘em’, ‘pd’,
‘ps’, etc. While the acronyms are short and convenient, they could be
confusing. So, let’s spell them out to be more specific. The following
changes were made in the spec. Note that the protocol name cannot exceed
GENL_NAMSIZ (16).

  em           -> dev-energymodel
  pds          -> perf-domains
  pd           -> perf-domain
  pd-id        -> perf-domain-id
  pd-table     -> perf-table
  ps           -> perf-state
  get-pds      -> get-perf-domains
  get-pd-table -> get-perf-table
  pd-created   -> perf-domain-created
  pd-updated   -> perf-domain-updated
  pd-deleted   -> perf-domain-deleted

In addition. doc strings were added to the spec. based on the comments in
energy_model.h. Two flag attributes (perf-state-flags and
perf-domain-flags) were added for easily interpreting the bit flags.

Finally, the autogenerated files and em_netlink.c were updated accordingly
to reflect the name changes.

Suggested-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 .../netlink/specs/dev-energymodel.yaml        | 175 ++++++++++++++++++
 Documentation/netlink/specs/em.yaml           | 116 ------------
 MAINTAINERS                                   |   8 +-
 include/uapi/linux/dev_energymodel.h          |  89 +++++++++
 include/uapi/linux/energy_model.h             |  63 -------
 kernel/power/em_netlink.c                     | 135 ++++++++------
 kernel/power/em_netlink_autogen.c             |  44 ++---
 kernel/power/em_netlink_autogen.h             |  20 +-
 8 files changed, 384 insertions(+), 266 deletions(-)
 create mode 100644 Documentation/netlink/specs/dev-energymodel.yaml
 delete mode 100644 Documentation/netlink/specs/em.yaml
 create mode 100644 include/uapi/linux/dev_energymodel.h
 delete mode 100644 include/uapi/linux/energy_model.h

diff --git a/Documentation/netlink/specs/dev-energymodel.yaml b/Documentation/netlink/specs/dev-energymodel.yaml
new file mode 100644
index 000000000000..cbc4bc38f23c
--- /dev/null
+++ b/Documentation/netlink/specs/dev-energymodel.yaml
@@ -0,0 +1,175 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+#
+# Copyright (c) 2025 Valve Corporation.
+#
+---
+name: dev-energymodel
+
+doc: |
+  Energy model netlink interface to notify its changes.
+
+protocol: genetlink
+
+uapi-header: linux/dev_energymodel.h
+
+definitions:
+  -
+    type: flags
+    name: perf-state-flags
+    entries:
+      -
+        name: perf-state-inefficient
+        doc: >-
+          The performance state is inefficient. There is in this perf-domain,
+          another performance state with a higher frequency but a lower or
+          equal power cost.
+  -
+    type: flags
+    name: perf-domain-flags
+    entries:
+      -
+        name: perf-domain-microwatts
+        doc: >-
+          The power values are in micro-Watts or some other scale.
+      -
+        name: perf-domain-skip-inefficiencies
+        doc: >-
+          Skip inefficient states when estimating energy consumption.
+      -
+        name: perf-domain-artificial
+        doc: >-
+          The power values are artificial and might be created by platform
+          missing real power information.
+
+attribute-sets:
+  -
+    name: perf-domains
+    doc: >-
+      Information on all the performance domains.
+    attributes:
+      -
+        name: perf-domain
+        type: nest
+        nested-attributes: perf-domain
+        multi-attr: true
+  -
+    name: perf-domain
+    doc: >-
+      Information on a single performance domains.
+    attributes:
+      -
+        name: pad
+        type: pad
+      -
+        name: perf-domain-id
+        type: u32
+        doc: >-
+          A unique ID number for each performance domain.
+      -
+        name: flags
+        type: u64
+        doc: >-
+          Bitmask of performance domain flags.
+        enum: perf-domain-flags
+      -
+        name: cpus
+        type: string
+        doc: >-
+          CPUs that belong to this performance domain.
+  -
+    name: perf-table
+    doc: >-
+      Performance states table.
+    attributes:
+      -
+        name: perf-domain-id
+        type: u32
+        doc: >-
+          A unique ID number for each performance domain.
+      -
+        name: perf-state
+        type: nest
+        nested-attributes: perf-state
+        multi-attr: true
+  -
+    name: perf-state
+    doc: >-
+      Performance state of a performance domain.
+    attributes:
+      -
+        name: pad
+        type: pad
+      -
+        name: performance
+        type: u64
+        doc: >-
+          CPU performance (capacity) at a given frequency.
+      -
+        name: frequency
+        type: u64
+        doc: >-
+          The frequency in KHz, for consistency with CPUFreq.
+      -
+        name: power
+        type: u64
+        doc: >-
+          The power consumed at this level (by 1 CPU or by a registered
+          device). It can be a total power: static and dynamic.
+      -
+        name: cost
+        type: u64
+        doc: >-
+          The cost coefficient associated with this level, used during energy
+          calculation. Equal to: power * max_frequency / frequency.
+      -
+        name: flags
+        type: u64
+        doc: >-
+          Bitmask of performance state flags.
+        enum: perf-state-flags
+
+operations:
+  list:
+    -
+      name: get-perf-domains
+      attribute-set: perf-domains
+      doc: Get the list of information for all performance domains.
+      do:
+        reply:
+          attributes:
+            - perf-domain
+    -
+      name: get-perf-table
+      attribute-set: perf-table
+      doc: Get the energy model table of a performance domain.
+      do:
+        request:
+          attributes:
+            - perf-domain-id
+        reply:
+          attributes:
+            - perf-domain-id
+            - perf-state
+    -
+      name: perf-domain-created
+      doc: A performance domain is created.
+      notify: get-perf-table
+      mcgrp: event
+    -
+      name: perf-domain-updated
+      doc: A performance domain is updated.
+      notify: get-perf-table
+      mcgrp: event
+    -
+      name: perf-domain-deleted
+      doc: A performance domain is deleted.
+      attribute-set: perf-table
+      event:
+        attributes:
+          - perf-domain-id
+      mcgrp: event
+
+mcast-groups:
+  list:
+    -
+      name: event
diff --git a/Documentation/netlink/specs/em.yaml b/Documentation/netlink/specs/em.yaml
deleted file mode 100644
index 0c595a874f08..000000000000
--- a/Documentation/netlink/specs/em.yaml
+++ /dev/null
@@ -1,116 +0,0 @@
-# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-#
-# Copyright (c) 2025 Valve Corporation.
-#
----
-name: em
-
-doc: |
-  Energy model netlink interface to notify its changes.
-
-protocol: genetlink
-
-uapi-header: linux/energy_model.h
-
-attribute-sets:
-  -
-    name: pds
-    attributes:
-      -
-        name: pd
-        type: nest
-        nested-attributes: pd
-        multi-attr: true
-  -
-    name: pd
-    attributes:
-      -
-        name: pad
-        type: pad
-      -
-        name: pd-id
-        type: u32
-      -
-        name: flags
-        type: u64
-      -
-        name: cpus
-        type: string
-  -
-    name: pd-table
-    attributes:
-      -
-        name: pd-id
-        type: u32
-      -
-        name: ps
-        type: nest
-        nested-attributes: ps
-        multi-attr: true
-  -
-    name: ps
-    attributes:
-      -
-        name: pad
-        type: pad
-      -
-        name: performance
-        type: u64
-      -
-        name: frequency
-        type: u64
-      -
-        name: power
-        type: u64
-      -
-        name: cost
-        type: u64
-      -
-        name: flags
-        type: u64
-
-operations:
-  list:
-    -
-      name: get-pds
-      attribute-set: pds
-      doc: Get the list of information for all performance domains.
-      do:
-        reply:
-          attributes:
-            - pd
-    -
-      name: get-pd-table
-      attribute-set: pd-table
-      doc: Get the energy model table of a performance domain.
-      do:
-        request:
-          attributes:
-            - pd-id
-        reply:
-          attributes:
-            - pd-id
-            - ps
-    -
-      name: pd-created
-      doc: A performance domain is created.
-      notify: get-pd-table
-      mcgrp: event
-    -
-      name: pd-updated
-      doc: A performance domain is updated.
-      notify: get-pd-table
-      mcgrp: event
-    -
-      name: pd-deleted
-      doc: A performance domain is deleted.
-      attribute-set: pd-table
-      event:
-        attributes:
-          - pd-id
-      mcgrp: event
-
-mcast-groups:
-  list:
-    -
-      name: event
diff --git a/MAINTAINERS b/MAINTAINERS
index a0dd762f5648..6f9eada53887 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9298,12 +9298,12 @@ M:	Lukasz Luba <lukasz.luba@arm.com>
 M:	"Rafael J. Wysocki" <rafael@kernel.org>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
-F:	kernel/power/energy_model.c
-F:	include/linux/energy_model.h
+F:	Documentation/netlink/specs/dev-energymodel.yaml
 F:	Documentation/power/energy-model.rst
-F:	Documentation/netlink/specs/em.yaml
-F:	include/uapi/linux/energy_model.h
+F:	include/linux/energy_model.h
+F:	include/uapi/linux/dev_energymodel.h
 F:	kernel/power/em_netlink*.*
+F:	kernel/power/energy_model.c
 
 EPAPR HYPERVISOR BYTE CHANNEL DEVICE DRIVER
 M:	Laurentiu Tudor <laurentiu.tudor@nxp.com>
diff --git a/include/uapi/linux/dev_energymodel.h b/include/uapi/linux/dev_energymodel.h
new file mode 100644
index 000000000000..3399967e1f93
--- /dev/null
+++ b/include/uapi/linux/dev_energymodel.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/dev-energymodel.yaml */
+/* YNL-GEN uapi header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
+
+#ifndef _UAPI_LINUX_DEV_ENERGYMODEL_H
+#define _UAPI_LINUX_DEV_ENERGYMODEL_H
+
+#define DEV_ENERGYMODEL_FAMILY_NAME	"dev-energymodel"
+#define DEV_ENERGYMODEL_FAMILY_VERSION	1
+
+/**
+ * enum dev_energymodel_perf_state_flags
+ * @DEV_ENERGYMODEL_PERF_STATE_FLAGS_PERF_STATE_INEFFICIENT: The performance
+ *   state is inefficient. There is in this perf-domain, another performance
+ *   state with a higher frequency but a lower or equal power cost.
+ */
+enum dev_energymodel_perf_state_flags {
+	DEV_ENERGYMODEL_PERF_STATE_FLAGS_PERF_STATE_INEFFICIENT = 1,
+};
+
+/**
+ * enum dev_energymodel_perf_domain_flags
+ * @DEV_ENERGYMODEL_PERF_DOMAIN_FLAGS_PERF_DOMAIN_MICROWATTS: The power values
+ *   are in micro-Watts or some other scale.
+ * @DEV_ENERGYMODEL_PERF_DOMAIN_FLAGS_PERF_DOMAIN_SKIP_INEFFICIENCIES: Skip
+ *   inefficient states when estimating energy consumption.
+ * @DEV_ENERGYMODEL_PERF_DOMAIN_FLAGS_PERF_DOMAIN_ARTIFICIAL: The power values
+ *   are artificial and might be created by platform missing real power
+ *   information.
+ */
+enum dev_energymodel_perf_domain_flags {
+	DEV_ENERGYMODEL_PERF_DOMAIN_FLAGS_PERF_DOMAIN_MICROWATTS = 1,
+	DEV_ENERGYMODEL_PERF_DOMAIN_FLAGS_PERF_DOMAIN_SKIP_INEFFICIENCIES = 2,
+	DEV_ENERGYMODEL_PERF_DOMAIN_FLAGS_PERF_DOMAIN_ARTIFICIAL = 4,
+};
+
+enum {
+	DEV_ENERGYMODEL_A_PERF_DOMAINS_PERF_DOMAIN = 1,
+
+	__DEV_ENERGYMODEL_A_PERF_DOMAINS_MAX,
+	DEV_ENERGYMODEL_A_PERF_DOMAINS_MAX = (__DEV_ENERGYMODEL_A_PERF_DOMAINS_MAX - 1)
+};
+
+enum {
+	DEV_ENERGYMODEL_A_PERF_DOMAIN_PAD = 1,
+	DEV_ENERGYMODEL_A_PERF_DOMAIN_PERF_DOMAIN_ID,
+	DEV_ENERGYMODEL_A_PERF_DOMAIN_FLAGS,
+	DEV_ENERGYMODEL_A_PERF_DOMAIN_CPUS,
+
+	__DEV_ENERGYMODEL_A_PERF_DOMAIN_MAX,
+	DEV_ENERGYMODEL_A_PERF_DOMAIN_MAX = (__DEV_ENERGYMODEL_A_PERF_DOMAIN_MAX - 1)
+};
+
+enum {
+	DEV_ENERGYMODEL_A_PERF_TABLE_PERF_DOMAIN_ID = 1,
+	DEV_ENERGYMODEL_A_PERF_TABLE_PERF_STATE,
+
+	__DEV_ENERGYMODEL_A_PERF_TABLE_MAX,
+	DEV_ENERGYMODEL_A_PERF_TABLE_MAX = (__DEV_ENERGYMODEL_A_PERF_TABLE_MAX - 1)
+};
+
+enum {
+	DEV_ENERGYMODEL_A_PERF_STATE_PAD = 1,
+	DEV_ENERGYMODEL_A_PERF_STATE_PERFORMANCE,
+	DEV_ENERGYMODEL_A_PERF_STATE_FREQUENCY,
+	DEV_ENERGYMODEL_A_PERF_STATE_POWER,
+	DEV_ENERGYMODEL_A_PERF_STATE_COST,
+	DEV_ENERGYMODEL_A_PERF_STATE_FLAGS,
+
+	__DEV_ENERGYMODEL_A_PERF_STATE_MAX,
+	DEV_ENERGYMODEL_A_PERF_STATE_MAX = (__DEV_ENERGYMODEL_A_PERF_STATE_MAX - 1)
+};
+
+enum {
+	DEV_ENERGYMODEL_CMD_GET_PERF_DOMAINS = 1,
+	DEV_ENERGYMODEL_CMD_GET_PERF_TABLE,
+	DEV_ENERGYMODEL_CMD_PERF_DOMAIN_CREATED,
+	DEV_ENERGYMODEL_CMD_PERF_DOMAIN_UPDATED,
+	DEV_ENERGYMODEL_CMD_PERF_DOMAIN_DELETED,
+
+	__DEV_ENERGYMODEL_CMD_MAX,
+	DEV_ENERGYMODEL_CMD_MAX = (__DEV_ENERGYMODEL_CMD_MAX - 1)
+};
+
+#define DEV_ENERGYMODEL_MCGRP_EVENT	"event"
+
+#endif /* _UAPI_LINUX_DEV_ENERGYMODEL_H */
diff --git a/include/uapi/linux/energy_model.h b/include/uapi/linux/energy_model.h
deleted file mode 100644
index 0bcad967854f..000000000000
--- a/include/uapi/linux/energy_model.h
+++ /dev/null
@@ -1,63 +0,0 @@
-/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
-/* Do not edit directly, auto-generated from: */
-/*	Documentation/netlink/specs/em.yaml */
-/* YNL-GEN uapi header */
-/* To regenerate run: tools/net/ynl/ynl-regen.sh */
-
-#ifndef _UAPI_LINUX_ENERGY_MODEL_H
-#define _UAPI_LINUX_ENERGY_MODEL_H
-
-#define EM_FAMILY_NAME		"em"
-#define EM_FAMILY_VERSION	1
-
-enum {
-	EM_A_PDS_PD = 1,
-
-	__EM_A_PDS_MAX,
-	EM_A_PDS_MAX = (__EM_A_PDS_MAX - 1)
-};
-
-enum {
-	EM_A_PD_PAD = 1,
-	EM_A_PD_PD_ID,
-	EM_A_PD_FLAGS,
-	EM_A_PD_CPUS,
-
-	__EM_A_PD_MAX,
-	EM_A_PD_MAX = (__EM_A_PD_MAX - 1)
-};
-
-enum {
-	EM_A_PD_TABLE_PD_ID = 1,
-	EM_A_PD_TABLE_PS,
-
-	__EM_A_PD_TABLE_MAX,
-	EM_A_PD_TABLE_MAX = (__EM_A_PD_TABLE_MAX - 1)
-};
-
-enum {
-	EM_A_PS_PAD = 1,
-	EM_A_PS_PERFORMANCE,
-	EM_A_PS_FREQUENCY,
-	EM_A_PS_POWER,
-	EM_A_PS_COST,
-	EM_A_PS_FLAGS,
-
-	__EM_A_PS_MAX,
-	EM_A_PS_MAX = (__EM_A_PS_MAX - 1)
-};
-
-enum {
-	EM_CMD_GET_PDS = 1,
-	EM_CMD_GET_PD_TABLE,
-	EM_CMD_PD_CREATED,
-	EM_CMD_PD_UPDATED,
-	EM_CMD_PD_DELETED,
-
-	__EM_CMD_MAX,
-	EM_CMD_MAX = (__EM_CMD_MAX - 1)
-};
-
-#define EM_MCGRP_EVENT	"event"
-
-#endif /* _UAPI_LINUX_ENERGY_MODEL_H */
diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
index 4b85da138a06..6f6238c465bb 100644
--- a/kernel/power/em_netlink.c
+++ b/kernel/power/em_netlink.c
@@ -12,27 +12,31 @@
 #include <linux/energy_model.h>
 #include <net/sock.h>
 #include <net/genetlink.h>
-#include <uapi/linux/energy_model.h>
+#include <uapi/linux/dev_energymodel.h>
 
 #include "em_netlink.h"
 #include "em_netlink_autogen.h"
 
-#define EM_A_PD_CPUS_LEN		256
+#define DEV_ENERGYMODEL_A_PERF_DOMAIN_CPUS_LEN		256
 
 /*************************** Command encoding ********************************/
 static int __em_nl_get_pd_size(struct em_perf_domain *pd, void *data)
 {
-	char cpus_buf[EM_A_PD_CPUS_LEN];
+	char cpus_buf[DEV_ENERGYMODEL_A_PERF_DOMAIN_CPUS_LEN];
 	int *tot_msg_sz = data;
 	int msg_sz, cpus_sz;
 
 	cpus_sz = snprintf(cpus_buf, sizeof(cpus_buf), "%*pb",
 			   cpumask_pr_args(to_cpumask(pd->cpus)));
 
-	msg_sz = nla_total_size(0) +			/* EM_A_PDS_PD */
-		 nla_total_size(sizeof(u32)) +		/* EM_A_PD_PD_ID */
-		 nla_total_size_64bit(sizeof(u64)) +	/* EM_A_PD_FLAGS */
-		 nla_total_size(cpus_sz);		/* EM_A_PD_CPUS */
+	msg_sz = nla_total_size(0) +
+		 /* DEV_ENERGYMODEL_A_PERF_DOMAINS_PERF_DOMAIN */
+		 nla_total_size(sizeof(u32)) +
+		 /* DEV_ENERGYMODEL_A_PERF_DOMAIN_PERF_DOMAIN_ID */
+		 nla_total_size_64bit(sizeof(u64)) +
+		 /* DEV_ENERGYMODEL_A_PERF_DOMAIN_FLAGS */
+		 nla_total_size(cpus_sz);
+		 /* DEV_ENERGYMODEL_A_PERF_DOMAIN_CPUS */
 
 	*tot_msg_sz += nlmsg_total_size(genlmsg_msg_size(msg_sz));
 	return 0;
@@ -40,23 +44,26 @@ static int __em_nl_get_pd_size(struct em_perf_domain *pd, void *data)
 
 static int __em_nl_get_pd(struct em_perf_domain *pd, void *data)
 {
-	char cpus_buf[EM_A_PD_CPUS_LEN];
+	char cpus_buf[DEV_ENERGYMODEL_A_PERF_DOMAIN_CPUS_LEN];
 	struct sk_buff *msg = data;
 	struct nlattr *entry;
 
-	entry = nla_nest_start(msg, EM_A_PDS_PD);
+	entry = nla_nest_start(msg,
+			       DEV_ENERGYMODEL_A_PERF_DOMAINS_PERF_DOMAIN);
 	if (!entry)
 		goto out_cancel_nest;
 
-	if (nla_put_u32(msg, EM_A_PD_PD_ID, pd->id))
+	if (nla_put_u32(msg, DEV_ENERGYMODEL_A_PERF_DOMAIN_PERF_DOMAIN_ID,
+			pd->id))
 		goto out_cancel_nest;
 
-	if (nla_put_u64_64bit(msg, EM_A_PD_FLAGS, pd->flags, EM_A_PD_PAD))
+	if (nla_put_u64_64bit(msg, DEV_ENERGYMODEL_A_PERF_DOMAIN_FLAGS,
+			      pd->flags, DEV_ENERGYMODEL_A_PERF_DOMAIN_PAD))
 		goto out_cancel_nest;
 
 	snprintf(cpus_buf, sizeof(cpus_buf), "%*pb",
 		 cpumask_pr_args(to_cpumask(pd->cpus)));
-	if (nla_put_string(msg, EM_A_PD_CPUS, cpus_buf))
+	if (nla_put_string(msg, DEV_ENERGYMODEL_A_PERF_DOMAIN_CPUS, cpus_buf))
 		goto out_cancel_nest;
 
 	nla_nest_end(msg, entry);
@@ -69,7 +76,8 @@ static int __em_nl_get_pd(struct em_perf_domain *pd, void *data)
 	return -EMSGSIZE;
 }
 
-int em_nl_get_pds_doit(struct sk_buff *skb, struct genl_info *info)
+int dev_energymodel_nl_get_perf_domains_doit(struct sk_buff *skb,
+					      struct genl_info *info)
 {
 	struct sk_buff *msg;
 	void *hdr;
@@ -82,7 +90,7 @@ int em_nl_get_pds_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!msg)
 		return -ENOMEM;
 
-	hdr = genlmsg_put_reply(msg, info, &em_nl_family, 0, cmd);
+	hdr = genlmsg_put_reply(msg, info, &dev_energymodel_nl_family, 0, cmd);
 	if (!hdr)
 		goto out_free_msg;
 
@@ -107,10 +115,10 @@ static struct em_perf_domain *__em_nl_get_pd_table_id(struct nlattr **attrs)
 	struct em_perf_domain *pd;
 	int id;
 
-	if (!attrs[EM_A_PD_TABLE_PD_ID])
+	if (!attrs[DEV_ENERGYMODEL_A_PERF_TABLE_PERF_DOMAIN_ID])
 		return NULL;
 
-	id = nla_get_u32(attrs[EM_A_PD_TABLE_PD_ID]);
+	id = nla_get_u32(attrs[DEV_ENERGYMODEL_A_PERF_TABLE_PERF_DOMAIN_ID]);
 	pd = em_perf_domain_get_by_id(id);
 	return pd;
 }
@@ -119,25 +127,34 @@ static int __em_nl_get_pd_table_size(const struct em_perf_domain *pd)
 {
 	int id_sz, ps_sz;
 
-	id_sz = nla_total_size(sizeof(u32));		/* EM_A_PD_TABLE_PD_ID */
-	ps_sz = nla_total_size(0) +			/* EM_A_PD_TABLE_PS */
-		nla_total_size_64bit(sizeof(u64)) +	/* EM_A_PS_PERFORMANCE */
-		nla_total_size_64bit(sizeof(u64)) +	/* EM_A_PS_FREQUENCY */
-		nla_total_size_64bit(sizeof(u64)) +	/* EM_A_PS_POWER */
-		nla_total_size_64bit(sizeof(u64)) +	/* EM_A_PS_COST */
-		nla_total_size_64bit(sizeof(u64));	/* EM_A_PS_FLAGS */
+	id_sz = nla_total_size(sizeof(u32));
+		/* DEV_ENERGYMODEL_A_PERF_TABLE_PERF_DOMAIN_ID */
+	ps_sz = nla_total_size(0) +
+		/* DEV_ENERGYMODEL_A_PERF_TABLE_PERF_STATE */
+		nla_total_size_64bit(sizeof(u64)) +
+		/* DEV_ENERGYMODEL_A_PERF_STATE_PERFORMANCE */
+		nla_total_size_64bit(sizeof(u64)) +
+		/* DEV_ENERGYMODEL_A_PERF_STATE_FREQUENCY */
+		nla_total_size_64bit(sizeof(u64)) +
+		/* DEV_ENERGYMODEL_A_PERF_STATE_POWER */
+		nla_total_size_64bit(sizeof(u64)) +
+		/* DEV_ENERGYMODEL_A_PERF_STATE_COST */
+		nla_total_size_64bit(sizeof(u64));
+		/* DEV_ENERGYMODEL_A_PERF_STATE_FLAGS */
 	ps_sz *= pd->nr_perf_states;
 
 	return nlmsg_total_size(genlmsg_msg_size(id_sz + ps_sz));
 }
 
-static int __em_nl_get_pd_table(struct sk_buff *msg, const struct em_perf_domain *pd)
+static
+int __em_nl_get_pd_table(struct sk_buff *msg, const struct em_perf_domain *pd)
 {
 	struct em_perf_state *table, *ps;
 	struct nlattr *entry;
 	int i;
 
-	if (nla_put_u32(msg, EM_A_PD_TABLE_PD_ID, pd->id))
+	if (nla_put_u32(msg, DEV_ENERGYMODEL_A_PERF_TABLE_PERF_DOMAIN_ID,
+			pd->id))
 		goto out_err;
 
 	rcu_read_lock();
@@ -146,24 +163,35 @@ static int __em_nl_get_pd_table(struct sk_buff *msg, const struct em_perf_domain
 	for (i = 0; i < pd->nr_perf_states; i++) {
 		ps = &table[i];
 
-		entry = nla_nest_start(msg, EM_A_PD_TABLE_PS);
+		entry = nla_nest_start(msg,
+				       DEV_ENERGYMODEL_A_PERF_TABLE_PERF_STATE);
 		if (!entry)
 			goto out_unlock_ps;
 
-		if (nla_put_u64_64bit(msg, EM_A_PS_PERFORMANCE,
-				      ps->performance, EM_A_PS_PAD))
+		if (nla_put_u64_64bit(msg,
+				      DEV_ENERGYMODEL_A_PERF_STATE_PERFORMANCE,
+				      ps->performance,
+				      DEV_ENERGYMODEL_A_PERF_STATE_PAD))
 			goto out_cancel_ps_nest;
-		if (nla_put_u64_64bit(msg, EM_A_PS_FREQUENCY,
-				      ps->frequency, EM_A_PS_PAD))
+		if (nla_put_u64_64bit(msg,
+				      DEV_ENERGYMODEL_A_PERF_STATE_FREQUENCY,
+				      ps->frequency,
+				      DEV_ENERGYMODEL_A_PERF_STATE_PAD))
 			goto out_cancel_ps_nest;
-		if (nla_put_u64_64bit(msg, EM_A_PS_POWER,
-				      ps->power, EM_A_PS_PAD))
+		if (nla_put_u64_64bit(msg,
+				      DEV_ENERGYMODEL_A_PERF_STATE_POWER,
+				      ps->power,
+				      DEV_ENERGYMODEL_A_PERF_STATE_PAD))
 			goto out_cancel_ps_nest;
-		if (nla_put_u64_64bit(msg, EM_A_PS_COST,
-				      ps->cost, EM_A_PS_PAD))
+		if (nla_put_u64_64bit(msg,
+				      DEV_ENERGYMODEL_A_PERF_STATE_COST,
+				      ps->cost,
+				      DEV_ENERGYMODEL_A_PERF_STATE_PAD))
 			goto out_cancel_ps_nest;
-		if (nla_put_u64_64bit(msg, EM_A_PS_FLAGS,
-				      ps->flags, EM_A_PS_PAD))
+		if (nla_put_u64_64bit(msg,
+				      DEV_ENERGYMODEL_A_PERF_STATE_FLAGS,
+				      ps->flags,
+				      DEV_ENERGYMODEL_A_PERF_STATE_PAD))
 			goto out_cancel_ps_nest;
 
 		nla_nest_end(msg, entry);
@@ -179,7 +207,8 @@ static int __em_nl_get_pd_table(struct sk_buff *msg, const struct em_perf_domain
 	return -EMSGSIZE;
 }
 
-int em_nl_get_pd_table_doit(struct sk_buff *skb, struct genl_info *info)
+int dev_energymodel_nl_get_perf_table_doit(struct sk_buff *skb,
+					    struct genl_info *info)
 {
 	int cmd = info->genlhdr->cmd;
 	int msg_sz, ret = -EMSGSIZE;
@@ -197,7 +226,7 @@ int em_nl_get_pd_table_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!msg)
 		return -ENOMEM;
 
-	hdr = genlmsg_put_reply(msg, info, &em_nl_family, 0, cmd);
+	hdr = genlmsg_put_reply(msg, info, &dev_energymodel_nl_family, 0, cmd);
 	if (!hdr)
 		goto out_free_msg;
 
@@ -221,7 +250,7 @@ static void __em_notify_pd_table(const struct em_perf_domain *pd, int ntf_type)
 	int msg_sz, ret = -EMSGSIZE;
 	void *hdr;
 
-	if (!genl_has_listeners(&em_nl_family, &init_net, EM_NLGRP_EVENT))
+	if (!genl_has_listeners(&dev_energymodel_nl_family, &init_net, DEV_ENERGYMODEL_NLGRP_EVENT))
 		return;
 
 	msg_sz = __em_nl_get_pd_table_size(pd);
@@ -230,7 +259,7 @@ static void __em_notify_pd_table(const struct em_perf_domain *pd, int ntf_type)
 	if (!msg)
 		return;
 
-	hdr = genlmsg_put(msg, 0, 0, &em_nl_family, 0, ntf_type);
+	hdr = genlmsg_put(msg, 0, 0, &dev_energymodel_nl_family, 0, ntf_type);
 	if (!hdr)
 		goto out_free_msg;
 
@@ -240,28 +269,28 @@ static void __em_notify_pd_table(const struct em_perf_domain *pd, int ntf_type)
 
 	genlmsg_end(msg, hdr);
 
-	genlmsg_multicast(&em_nl_family, msg, 0, EM_NLGRP_EVENT, GFP_KERNEL);
+	genlmsg_multicast(&dev_energymodel_nl_family, msg, 0,
+			  DEV_ENERGYMODEL_NLGRP_EVENT, GFP_KERNEL);
 
 	return;
 
 out_free_msg:
 	nlmsg_free(msg);
-	return;
 }
 
 void em_notify_pd_created(const struct em_perf_domain *pd)
 {
-	__em_notify_pd_table(pd, EM_CMD_PD_CREATED);
+	__em_notify_pd_table(pd, DEV_ENERGYMODEL_CMD_PERF_DOMAIN_CREATED);
 }
 
 void em_notify_pd_updated(const struct em_perf_domain *pd)
 {
-	__em_notify_pd_table(pd, EM_CMD_PD_UPDATED);
+	__em_notify_pd_table(pd, DEV_ENERGYMODEL_CMD_PERF_DOMAIN_UPDATED);
 }
 
 static int __em_notify_pd_deleted_size(const struct em_perf_domain *pd)
 {
-	int id_sz = nla_total_size(sizeof(u32)); /* EM_A_PD_TABLE_PD_ID */
+	int id_sz = nla_total_size(sizeof(u32)); /* DEV_ENERGYMODEL_A_PERF_TABLE_PERF_DOMAIN_ID */
 
 	return nlmsg_total_size(genlmsg_msg_size(id_sz));
 }
@@ -272,7 +301,8 @@ void em_notify_pd_deleted(const struct em_perf_domain *pd)
 	void *hdr;
 	int msg_sz;
 
-	if (!genl_has_listeners(&em_nl_family, &init_net, EM_NLGRP_EVENT))
+	if (!genl_has_listeners(&dev_energymodel_nl_family, &init_net,
+				DEV_ENERGYMODEL_NLGRP_EVENT))
 		return;
 
 	msg_sz = __em_notify_pd_deleted_size(pd);
@@ -281,28 +311,29 @@ void em_notify_pd_deleted(const struct em_perf_domain *pd)
 	if (!msg)
 		return;
 
-	hdr = genlmsg_put(msg, 0, 0, &em_nl_family, 0, EM_CMD_PD_DELETED);
+	hdr = genlmsg_put(msg, 0, 0, &dev_energymodel_nl_family, 0,
+			  DEV_ENERGYMODEL_CMD_PERF_DOMAIN_DELETED);
 	if (!hdr)
 		goto out_free_msg;
 
-	if (nla_put_u32(msg, EM_A_PD_TABLE_PD_ID, pd->id)) {
+	if (nla_put_u32(msg, DEV_ENERGYMODEL_A_PERF_TABLE_PERF_DOMAIN_ID,
+			pd->id))
 		goto out_free_msg;
-	}
 
 	genlmsg_end(msg, hdr);
 
-	genlmsg_multicast(&em_nl_family, msg, 0, EM_NLGRP_EVENT, GFP_KERNEL);
+	genlmsg_multicast(&dev_energymodel_nl_family, msg, 0,
+			  DEV_ENERGYMODEL_NLGRP_EVENT, GFP_KERNEL);
 
 	return;
 
 out_free_msg:
 	nlmsg_free(msg);
-	return;
 }
 
 /**************************** Initialization *********************************/
 static int __init em_netlink_init(void)
 {
-	return genl_register_family(&em_nl_family);
+	return genl_register_family(&dev_energymodel_nl_family);
 }
 postcore_initcall(em_netlink_init);
diff --git a/kernel/power/em_netlink_autogen.c b/kernel/power/em_netlink_autogen.c
index ceb3b2bb6ebe..44acef0e7df2 100644
--- a/kernel/power/em_netlink_autogen.c
+++ b/kernel/power/em_netlink_autogen.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
 /* Do not edit directly, auto-generated from: */
-/*	Documentation/netlink/specs/em.yaml */
+/*	Documentation/netlink/specs/dev-energymodel.yaml */
 /* YNL-GEN kernel source */
 /* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
@@ -9,41 +9,41 @@
 
 #include "em_netlink_autogen.h"
 
-#include <uapi/linux/energy_model.h>
+#include <uapi/linux/dev_energymodel.h>
 
-/* EM_CMD_GET_PD_TABLE - do */
-static const struct nla_policy em_get_pd_table_nl_policy[EM_A_PD_TABLE_PD_ID + 1] = {
-	[EM_A_PD_TABLE_PD_ID] = { .type = NLA_U32, },
+/* DEV_ENERGYMODEL_CMD_GET_PERF_TABLE - do */
+static const struct nla_policy dev_energymodel_get_perf_table_nl_policy[DEV_ENERGYMODEL_A_PERF_TABLE_PERF_DOMAIN_ID + 1] = {
+	[DEV_ENERGYMODEL_A_PERF_TABLE_PERF_DOMAIN_ID] = { .type = NLA_U32, },
 };
 
-/* Ops table for em */
-static const struct genl_split_ops em_nl_ops[] = {
+/* Ops table for dev_energymodel */
+static const struct genl_split_ops dev_energymodel_nl_ops[] = {
 	{
-		.cmd	= EM_CMD_GET_PDS,
-		.doit	= em_nl_get_pds_doit,
+		.cmd	= DEV_ENERGYMODEL_CMD_GET_PERF_DOMAINS,
+		.doit	= dev_energymodel_nl_get_perf_domains_doit,
 		.flags	= GENL_CMD_CAP_DO,
 	},
 	{
-		.cmd		= EM_CMD_GET_PD_TABLE,
-		.doit		= em_nl_get_pd_table_doit,
-		.policy		= em_get_pd_table_nl_policy,
-		.maxattr	= EM_A_PD_TABLE_PD_ID,
+		.cmd		= DEV_ENERGYMODEL_CMD_GET_PERF_TABLE,
+		.doit		= dev_energymodel_nl_get_perf_table_doit,
+		.policy		= dev_energymodel_get_perf_table_nl_policy,
+		.maxattr	= DEV_ENERGYMODEL_A_PERF_TABLE_PERF_DOMAIN_ID,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 };
 
-static const struct genl_multicast_group em_nl_mcgrps[] = {
-	[EM_NLGRP_EVENT] = { "event", },
+static const struct genl_multicast_group dev_energymodel_nl_mcgrps[] = {
+	[DEV_ENERGYMODEL_NLGRP_EVENT] = { "event", },
 };
 
-struct genl_family em_nl_family __ro_after_init = {
-	.name		= EM_FAMILY_NAME,
-	.version	= EM_FAMILY_VERSION,
+struct genl_family dev_energymodel_nl_family __ro_after_init = {
+	.name		= DEV_ENERGYMODEL_FAMILY_NAME,
+	.version	= DEV_ENERGYMODEL_FAMILY_VERSION,
 	.netnsok	= true,
 	.parallel_ops	= true,
 	.module		= THIS_MODULE,
-	.split_ops	= em_nl_ops,
-	.n_split_ops	= ARRAY_SIZE(em_nl_ops),
-	.mcgrps		= em_nl_mcgrps,
-	.n_mcgrps	= ARRAY_SIZE(em_nl_mcgrps),
+	.split_ops	= dev_energymodel_nl_ops,
+	.n_split_ops	= ARRAY_SIZE(dev_energymodel_nl_ops),
+	.mcgrps		= dev_energymodel_nl_mcgrps,
+	.n_mcgrps	= ARRAY_SIZE(dev_energymodel_nl_mcgrps),
 };
diff --git a/kernel/power/em_netlink_autogen.h b/kernel/power/em_netlink_autogen.h
index 140ab548103c..f7e4bddcbd53 100644
--- a/kernel/power/em_netlink_autogen.h
+++ b/kernel/power/em_netlink_autogen.h
@@ -1,24 +1,26 @@
 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
 /* Do not edit directly, auto-generated from: */
-/*	Documentation/netlink/specs/em.yaml */
+/*	Documentation/netlink/specs/dev-energymodel.yaml */
 /* YNL-GEN kernel header */
 /* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
-#ifndef _LINUX_EM_GEN_H
-#define _LINUX_EM_GEN_H
+#ifndef _LINUX_DEV_ENERGYMODEL_GEN_H
+#define _LINUX_DEV_ENERGYMODEL_GEN_H
 
 #include <net/netlink.h>
 #include <net/genetlink.h>
 
-#include <uapi/linux/energy_model.h>
+#include <uapi/linux/dev_energymodel.h>
 
-int em_nl_get_pds_doit(struct sk_buff *skb, struct genl_info *info);
-int em_nl_get_pd_table_doit(struct sk_buff *skb, struct genl_info *info);
+int dev_energymodel_nl_get_perf_domains_doit(struct sk_buff *skb,
+					     struct genl_info *info);
+int dev_energymodel_nl_get_perf_table_doit(struct sk_buff *skb,
+					   struct genl_info *info);
 
 enum {
-	EM_NLGRP_EVENT,
+	DEV_ENERGYMODEL_NLGRP_EVENT,
 };
 
-extern struct genl_family em_nl_family;
+extern struct genl_family dev_energymodel_nl_family;
 
-#endif /* _LINUX_EM_GEN_H */
+#endif /* _LINUX_DEV_ENERGYMODEL_GEN_H */
-- 
2.52.0


