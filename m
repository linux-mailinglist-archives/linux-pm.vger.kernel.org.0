Return-Path: <linux-pm+bounces-33498-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AF3B3D677
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 04:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4F3C175B54
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 02:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4688F23D7C4;
	Mon,  1 Sep 2025 02:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="UMZOPZRU"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEE8239E63;
	Mon,  1 Sep 2025 02:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756692048; cv=none; b=LP1jExJ48+ZHkzBWNdalidTeEPZpmj3wsfesHMhc/8wRtyTR1KQfOuq4guz2xOEMOiBvLMyG5jbMImWUZulgIzN/FcOQIQdhEjA9S3JntO3AcSAoMTk+aEJ8jvIgafAm3eRNEHvxpXxlucfJkCfinql65RnV20pvuY8qifsDHm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756692048; c=relaxed/simple;
	bh=LyakN45UOS+F8rqmwwILdrFazmjfMUiYFyzoJcdivKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umRFLEYzKQRkccfvtqcLtl2/3/FHso3MhaTH5yoDZwfbYgo5V6E3R8LO4jTAm/4ne4U5d+xocZC01JpfQnudMnVqWMFCtiLavcAAanNUbhCr5ZXtrGOIdtjTK8YgolrNqwqODSWiFyrorjAMciAeGRJqXmqSoce3OMdSDACmSas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=UMZOPZRU; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5dxvfgME0EuBtetIgZsGnsG1UO3q1LjYxquXtFj+L2A=; b=UMZOPZRUTqiiY7V0hSAa7AyW2e
	7BoA29pjr34dj+B6qJJ/NexOi6u1BpV6qteYnECyWf7Kk4sWUkKp7rC5kBh3A0+Hd5QI9RQADItr0
	p5+plFnzHLHKo5R1Pp67uxfisZ6plYvb1ihQPt7PrBMl3S9/z4FMJMpNSFQ0ULpCtyrznGU0yeoz8
	h4lzdG6lLxGyCZeq/8cX6sks3w3VUodz2/IJqP61UzLHAGfubN9LfsBQfhH6Xt++QR+vFF9pRSkYR
	e1TA0cF9DSbRrrvy9r/eo2cf2uR9Hx+6NOPbGrAtzcTmSeOxmaIEKQc2j2OipBieGq81b5bPtsHgm
	DdMSiajQ==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ustqY-0054UE-O2; Mon, 01 Sep 2025 04:00:39 +0200
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
Subject: [PATCH v4 05/10] PM: EM: Add a skeleton code for netlink notification
Date: Mon,  1 Sep 2025 10:59:58 +0900
Message-ID: <20250901020003.86415-6-changwoo@igalia.com>
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

Add a boilerplate code for netlink notification to register the new
protocol family. Also, initialize and register the netlink during booting.
The initialization is called at the postcore level, which is late enough
after the generic netlink is initialized.

Finally, update MAINTAINERS to include new files.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 MAINTAINERS               |  2 +-
 kernel/power/Makefile     |  5 ++++-
 kernel/power/em_netlink.c | 35 +++++++++++++++++++++++++++++++++++
 kernel/power/em_netlink.h | 16 ++++++++++++++++
 4 files changed, 56 insertions(+), 2 deletions(-)
 create mode 100644 kernel/power/em_netlink.c
 create mode 100644 kernel/power/em_netlink.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 0151a0bddd3b..964bb09920c3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9026,7 +9026,7 @@ F:	include/linux/energy_model.h
 F:	Documentation/power/energy-model.rst
 F:	Documentation/netlink/specs/em.yaml
 F:	include/uapi/linux/energy_model.h
-F:	kernel/power/em_netlink_autogen.*
+F:	kernel/power/em_netlink*.*
 
 EPAPR HYPERVISOR BYTE CHANNEL DEVICE DRIVER
 M:	Laurentiu Tudor <laurentiu.tudor@nxp.com>
diff --git a/kernel/power/Makefile b/kernel/power/Makefile
index 874ad834dc8d..284a760aade7 100644
--- a/kernel/power/Makefile
+++ b/kernel/power/Makefile
@@ -21,4 +21,7 @@ obj-$(CONFIG_PM_WAKELOCKS)	+= wakelock.o
 
 obj-$(CONFIG_MAGIC_SYSRQ)	+= poweroff.o
 
-obj-$(CONFIG_ENERGY_MODEL)	+= energy_model.o
+obj-$(CONFIG_ENERGY_MODEL)	+= em.o
+em-y				:= energy_model.o
+em-$(CONFIG_NET)		+= em_netlink_autogen.o em_netlink.o
+
diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
new file mode 100644
index 000000000000..f3fbfeff29a4
--- /dev/null
+++ b/kernel/power/em_netlink.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *
+ * Generic netlink for energy model.
+ *
+ * Copyright (c) 2025 Valve Corporation.
+ * Author: Changwoo Min <changwoo@igalia.com>
+ */
+
+#define pr_fmt(fmt) "energy_model: " fmt
+
+#include <linux/energy_model.h>
+#include <net/sock.h>
+#include <net/genetlink.h>
+#include <uapi/linux/energy_model.h>
+
+#include "em_netlink.h"
+#include "em_netlink_autogen.h"
+
+int em_nl_get_pds_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
+int em_nl_get_pd_table_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
+static int __init em_netlink_init(void)
+{
+	return genl_register_family(&em_nl_family);
+}
+postcore_initcall(em_netlink_init);
+
diff --git a/kernel/power/em_netlink.h b/kernel/power/em_netlink.h
new file mode 100644
index 000000000000..acd186c92d6b
--- /dev/null
+++ b/kernel/power/em_netlink.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *
+ * Generic netlink for energy model.
+ *
+ * Copyright (c) 2025 Valve Corporation.
+ * Author: Changwoo Min <changwoo@igalia.com>
+ */
+#ifndef _EM_NETLINK_H
+#define _EM_NETLINK_H
+
+#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_NET)
+#else
+#endif
+
+#endif /* _EM_NETLINK_H */
-- 
2.51.0


