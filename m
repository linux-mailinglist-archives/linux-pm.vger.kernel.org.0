Return-Path: <linux-pm+bounces-27773-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B578CAC74DC
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 02:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40ABA174A94
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 00:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F117A13B58B;
	Thu, 29 May 2025 00:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="YeahE2xi"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD01772612;
	Thu, 29 May 2025 00:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748477635; cv=none; b=iN5lXh4QJxMZlL22UXGpK0gi2OH37SFUUGSuZJ7C0xGmWPR5qm3rFUfao91XrRJK2NpN+pIvGO7mSK9x055crjtI5U5xu7xgphChC8zV1gQBX1rPk1coKtdy3yUFD0f5C0jVB8WzDTntEr/13h+x2Z9eNRVhyRgb1499PlKp/94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748477635; c=relaxed/simple;
	bh=nCg5W9dlXEbA46hwwD/r9httGc2FjaboJW+5wP3K+0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rf+XKN8vprfYYcW1HWfRVHbcqHV50u8xXZ0XxmjSCdvvUFXAmnUs3RHkzUjybLjuUC19FDcdxIJo1wmnJ/z3JlyXc09XOnFv8vg0vYwtkkTi1HFcQCnyaiMc2jRom7WwSoIIIEP8stTsfuo7zJOS6og8V7B8G+tDTL+apBRoezA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=YeahE2xi; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=8kBDfSz1JRvxg2i18Iw+DUUmUuXlPvCrkucQA27DpK8=; b=YeahE2xieWD60T29EOwUMwT1uH
	WUF8P3ZSkxYfVkQ9a78Vy/ePGJGRP0QU8nA1PuDIGFTieurEOp7E/qUYEqbxHwS6FHuYfxbp9OMsW
	BDqKoigBwhpK80Osvqt/p/md5nwkSbXZVY3mH6hhiZrNCx/ppRAM/H4/9tLlQaICq7NsJQiwbJrr3
	f5E9gDG4paHXv2FPx8jQtXqhSbl4mJCe0PUJaed+oGzYQJlljuheTtfKquZz7bFqgzQCld6qVYrD9
	vujopOozo3U6KU5avLoYXlxuVgqPmA6amDqaEBjRhhromXTkOgwdmyv5brnednCfVT5uH1BJv8go4
	jFrKZrjA==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uKQtv-00EZvm-NT; Thu, 29 May 2025 02:13:40 +0200
From: Changwoo Min <changwoo@igalia.com>
To: lukasz.luba@arm.com,
	rafael@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org
Cc: christian.loehle@arm.com,
	tj@kernel.org,
	kernel-dev@igalia.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH 02/11] PM: EM: Add a skeleton code for netlink notification.
Date: Thu, 29 May 2025 09:13:06 +0900
Message-ID: <20250529001315.233492-3-changwoo@igalia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529001315.233492-1-changwoo@igalia.com>
References: <20250529001315.233492-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a boilerplate code for netlink notification to register and unregister
the new protocol family. It defines the supported commands and event types
and adds the minimalistic code for the protocol family registration.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 include/uapi/linux/energy_model.h | 40 ++++++++++++++++++
 kernel/power/Makefile             |  1 +
 kernel/power/em_netlink.c         | 69 +++++++++++++++++++++++++++++++
 kernel/power/em_netlink.h         | 26 ++++++++++++
 4 files changed, 136 insertions(+)
 create mode 100644 include/uapi/linux/energy_model.h
 create mode 100644 kernel/power/em_netlink.c
 create mode 100644 kernel/power/em_netlink.h

diff --git a/include/uapi/linux/energy_model.h b/include/uapi/linux/energy_model.h
new file mode 100644
index 000000000000..42a19e614c7d
--- /dev/null
+++ b/include/uapi/linux/energy_model.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_ENERGY_MODEL_H
+#define _UAPI_LINUX_ENERGY_MODEL_H
+
+/* Adding event notification support elements */
+#define EM_GENL_FAMILY_NAME		"energy_model"
+#define EM_GENL_VERSION			0x01
+#define EM_GENL_EVENT_GROUP_NAME	"event"
+
+/* Attributes of em_genl_family */
+enum em_genl_attr {
+	EM_GENL_ATTR_UNSPEC,
+	__EM_GENL_ATTR_MAX,
+};
+#define EM_GENL_ATTR_MAX (__EM_GENL_ATTR_MAX - 1)
+
+/* Events of em_genl_family */
+enum em_genl_event {
+	EM_GENL_EVENT_UNSPEC,
+	EM_GENL_EVENT_PD_CREATE,	/* Performance domain creation */
+	EM_GENL_EVENT_PD_DELETE,	/* Performance domain deletion */
+	EM_GENL_EVENT_PD_UPDATE,	/* The runtime EM table for the
+					   performance domain is updated */
+	__EM_GENL_EVENT_MAX,
+};
+#define EM_GENL_EVENT_MAX (__EM_GENL_EVENT_MAX - 1)
+
+/* Commands supported by the em_genl_family */
+enum em_genl_cmd {
+	EM_GENL_CMD_UNSPEC,
+	EM_GENL_CMD_PD_GET_ID,		/* Get the list of information
+					   for all performance domains */
+	EM_GENL_CMD_PD_GET_TBL,		/* Get the energy model table
+					   of a performance domain */
+	__EM_GENL_CMD_MAX,
+};
+#define EM_GENL_CMD_MAX (__EM_GENL_CMD_MAX - 1)
+
+
+#endif /* _UAPI_LINUX_ENERGY_MODEL_H */
diff --git a/kernel/power/Makefile b/kernel/power/Makefile
index 874ad834dc8d..6bf157b5fffd 100644
--- a/kernel/power/Makefile
+++ b/kernel/power/Makefile
@@ -22,3 +22,4 @@ obj-$(CONFIG_PM_WAKELOCKS)	+= wakelock.o
 obj-$(CONFIG_MAGIC_SYSRQ)	+= poweroff.o
 
 obj-$(CONFIG_ENERGY_MODEL)	+= energy_model.o
+obj-$(CONFIG_ENERGY_MODEL_NETLINK) += em_netlink.o
diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
new file mode 100644
index 000000000000..30d83fb5a3a8
--- /dev/null
+++ b/kernel/power/em_netlink.c
@@ -0,0 +1,69 @@
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
+
+static const struct genl_multicast_group em_genl_mcgrps[] = {
+	[EM_GENL_EVENT_GROUP]  = { .name = EM_GENL_EVENT_GROUP_NAME,  },
+};
+
+static const struct nla_policy em_genl_policy[EM_GENL_ATTR_MAX + 1] = {
+};
+
+static struct genl_family em_genl_family;
+
+
+static int em_genl_cmd_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return -ENOTSUPP;
+}
+
+static const struct genl_small_ops em_genl_ops[] = {
+	{
+		.cmd = EM_GENL_CMD_PD_GET_ID,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = em_genl_cmd_doit,
+	},
+	{
+		.cmd = EM_GENL_CMD_PD_GET_TBL,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = em_genl_cmd_doit,
+	},
+};
+
+static struct genl_family em_genl_family __ro_after_init = {
+	.hdrsize	= 0,
+	.name		= EM_GENL_FAMILY_NAME,
+	.version	= EM_GENL_VERSION,
+	.maxattr	= EM_GENL_ATTR_MAX,
+	.policy		= em_genl_policy,
+	.small_ops	= em_genl_ops,
+	.n_small_ops	= ARRAY_SIZE(em_genl_ops),
+	.resv_start_op	= __EM_GENL_CMD_MAX,
+	.mcgrps		= em_genl_mcgrps,
+	.n_mcgrps	= ARRAY_SIZE(em_genl_mcgrps),
+};
+
+int __init em_netlink_init(void)
+{
+	return genl_register_family(&em_genl_family);
+}
+
+void __init em_netlink_exit(void)
+{
+	genl_unregister_family(&em_genl_family);
+}
+
diff --git a/kernel/power/em_netlink.h b/kernel/power/em_netlink.h
new file mode 100644
index 000000000000..8cedc6495916
--- /dev/null
+++ b/kernel/power/em_netlink.h
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *
+ * Generic netlink for energy model.
+ *
+ * Copyright (c) 2025 Valve Corporation.
+ * Author: Changwoo Min <changwoo@igalia.com>
+ */
+
+enum em_genl_multicast_groups {
+	EM_GENL_EVENT_GROUP = 0,
+	EM_GENL_MAX_GROUP = EM_GENL_EVENT_GROUP,
+};
+
+/* Netlink notification function */
+#ifdef CONFIG_ENERGY_MODEL_NETLINK
+int __init em_netlink_init(void);
+void __init em_netlink_exit(void);
+#else
+static inline int em_netlink_init(void)
+{
+	return 0;
+}
+
+static inline void em_netlink_exit(void) {}
+#endif /* CONFIG_ENERGY_MODEL_NETLINK */
-- 
2.49.0


