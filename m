Return-Path: <linux-pm+bounces-36019-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E99FBD6DA1
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 02:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B2BC423F2A
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 00:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E147191F98;
	Tue, 14 Oct 2025 00:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="eF65qDtV"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5343A335C7;
	Tue, 14 Oct 2025 00:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760400700; cv=none; b=Hoj+yKPuwfYUBUgJ2flyx3hEFyRmek7d0B0yDw9rBX+D7Wqe2mN4eXNgViMkjhAPtCdl8pUjgJeQFQ9bKpm1u426vYLOLUwRIRi37bjUgL2nwmcAxu6Yu/PlQECABnwhccvmQUIiHXRA5f7wAd9Ef7fvMAZj0lZqvM04m7kX2oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760400700; c=relaxed/simple;
	bh=YAl1vjzFbZOL3qiork99EDV0zJFx7mUIQCWmcJ0hq2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A0pFrnpUpucUsgWjG9off3R+u1YKwq7odsvueIH9ezsTcbeXTbdr1Z7zbu+4cabbmD6fCKp8hJqBUjn023m0j/36TV8f/crzLbmsuFVRPknkZ/tWIHS7v2pGCWrNEEggm6ef7NeXqHLlONPsWsOiyuiPlgI4HcaytqSbTvKIkRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=eF65qDtV; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=15vV3+SPFyZkjQKr1uAMsry2Dahq4tig7wyOGWaFCi4=; b=eF65qDtV9EMX7j7QKS8fW9Pm1a
	Uhbn9TiUy5JY/IM1MKkJlVvd9/fk2KNqOZKdmR8kO9o3UWlfqdMXsEJr62YSBuJwYj47vf3oupHrY
	2wYEBt+qRp9ieYH0/Ya8ky9mIlZR2WOTasqDILvcPh4WTia/JusmVjwt9j2Y9VYVwHGB/aVxCWLC5
	tIwmR9aPydusWiB7BbCivbRDw6V+MJZl2ulFQ53d6CCZrKNnwmjpn/xOw2A08/xr/sOAac3KvTLPW
	LOKUMXqaP3rSxbQjYov7f9I4VhWgxR3UpKZg5xTU6dm/NDF7h6vQ6VE8Cd3jHHZzJf1/7vri+pWp8
	YAzuDnMA==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v8SdV-009A17-Ri; Tue, 14 Oct 2025 02:11:31 +0200
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
Subject: [PATCH v5 04/10] PM: EM: Add a skeleton code for netlink notification
Date: Tue, 14 Oct 2025 09:10:49 +0900
Message-ID: <20251014001055.772422-5-changwoo@igalia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014001055.772422-1-changwoo@igalia.com>
References: <20251014001055.772422-1-changwoo@igalia.com>
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
index babd7088fc1c..bc2c08e6f0ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9182,7 +9182,7 @@ F:	include/linux/energy_model.h
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


