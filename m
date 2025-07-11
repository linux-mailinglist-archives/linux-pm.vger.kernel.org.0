Return-Path: <linux-pm+bounces-30653-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC08BB01065
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 02:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 662A8188C0FB
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 00:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA0D200A3;
	Fri, 11 Jul 2025 00:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Wm64Eqyh"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D609125B9;
	Fri, 11 Jul 2025 00:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752195223; cv=none; b=g8v3L8vU8tUIS26qwanykXbXl9zcUbXjG7RwUXJUVlhjqeifk9O7qH+PMKe7Ge5lVo8eutN20LX9nacZqqNkvAjssI0OCLIYbIkMa26jVgro6yXLxShz7N6/VNKEG/mS4SAmNBQyP2e16tmz7Bp6pevDrLYCu7ZTXRdEUDChE3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752195223; c=relaxed/simple;
	bh=mYu+Lr5bImRnBvbn2u/2HQqBZwMQTSDJ1jPyeJnrs94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k577Eqj7jS8X8s4Ct7wsmUCg3msEYiIH5MdsGpyEZDuOwjqOAUDcsFAn3vN0pFWdfkjBPZkAbQ4P26H2AQF188K2L15BocwJOtcuK8Z8DUyI/Z+ZO6UelvvaOK5j+ZHqUuKxpKFtVtgf1N334DHeOziR0SppYXs5GJys5g6YdGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Wm64Eqyh; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=TuDAjpodSMl9dnfEvWO7S5GY7MOPrpZFj8+NfZKLDi0=; b=Wm64Eqyhsgib35mn1fx6+Dq193
	NlF7g565rALpM3HxBYriVR/A99LnRcrJg55ucIXF1w4g56+BBtUOc4Z5+gHNb0eM5EBMoCMPMZ1eD
	f3Ow2KKd69MmQQGOLiXcNPimTCZYkE2Bg6iZIlpuZLhCqOjVrOxhb2jyaRM/CY/BaueoOZjy9sj/W
	S9GV8qXZzCQV7yxqKpmxr/6j07QIQQeywCETR06vYsjaWUaOGdkKk1w+VZBWggSdHgau/1czn9lWN
	EB2bbSBBpjPSttVhsv44fIkVtcbFBGq++qyCvS69Gm5ODztSCHeGrXBe+efBeLyvcaDav9H5vHTF1
	vUJ1jU5Q==;
Received: from [59.10.240.225] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ua214-00FAmT-Vr; Fri, 11 Jul 2025 02:53:32 +0200
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
Subject: [PATCH v3 02/10] PM: EM: Add a skeleton code for netlink notification.
Date: Fri, 11 Jul 2025 09:53:02 +0900
Message-ID: <20250711005310.20740-3-changwoo@igalia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250711005310.20740-1-changwoo@igalia.com>
References: <20250711005310.20740-1-changwoo@igalia.com>
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
index e31d22abba6e..2795562bfd73 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8869,7 +8869,7 @@ F:	include/linux/energy_model.h
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
2.50.0


