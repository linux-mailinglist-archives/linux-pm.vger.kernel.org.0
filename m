Return-Path: <linux-pm+bounces-7842-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 025AF8C4F7F
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A89321F231E2
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38D7140E30;
	Tue, 14 May 2024 10:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RccTblno";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NqGOq+Mo"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0300213FD83
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681946; cv=none; b=UJHa1567JwwuC9kwcJvZF8UvF2EZak0oF+Mj9Ui3RY0f2BYtBPVmrL6mtntvsSVrDTty6Hntq8Mq8HhZvq1izSI0pYUvg3wHjzjaaWQWkNNWN01w1liB6yoy8q/QSlM27tKbcvkKkCGEltxP89DMpEb394VHbnFdToZtEFuCSlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681946; c=relaxed/simple;
	bh=nPqCDg5Hf/67EuyUXUNro21NvQu0+xhlxN0jlsXZCZ4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=UNNIJRX8nvxND7zEoZCd0gTaMUH3EJU+2rm+uX8oZRWlIuBphfJXBT/HR4XWKZScC84OihQTbBLfTQJwracHZMNN0dJpCp+d2fZ1KNhFPdIahS2HuYGi2Yi+uQHGASBdGVLMpP/0J883F+Z5xv5ZJ4UfQyt8KBuScDZp8JOU/Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RccTblno; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NqGOq+Mo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 May 2024 10:18:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715681938;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=QdwB/vPZpPWKRayFxqTE5Zzo6gQHAZQpxUblVg/mREQ=;
	b=RccTblnozEF3I1FK4DnwH1wy67mxpkfK13O2FIw/r68qZtA5iKOeYn3N8FPN2hO59vSI3N
	vHutgo55x1pbXIQ9CfsoGhsWbnQp+Rub/WWMATGxqPxs/4f1Z4VzVKQ4oJK9KBCewON94S
	l1Wt+BRezNNA9wNG9Isd33ubHXzNeOOeIW8vpYJTi0Zk4/jxPqCm2jN4CSYPQ0n88vRwpX
	N2VkoqXdztIMchBVzXLbM3XMBZkYr4QZRHpTSGAPYlu4qC+INvogoqTkfDfMZuu8nn2PnY
	bebZVdqaYd89m22RyTmlsx/JbatPU4vsQzUDUM2od/5ZngpT1q/6wJnosVbVcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681938;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=QdwB/vPZpPWKRayFxqTE5Zzo6gQHAZQpxUblVg/mREQ=;
	b=NqGOq+MokwSPyLQ2U8VlanqVZZcr7/zppLKkKQ6rw9aR7Z09/0jwxESoceHnsnNYRwXJ88
	FEdmBNRX8Z5VX0BA==
From: "thermal-bot for Stanislaw Gruszka" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] thermal: netlink: Add genetlink bind/unbind
 notifications
Cc: Jakub Kicinski <kuba@kernel.org>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, rui.zhang@intel.com,
 daniel.lezcano@linaro.org, amitk@kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193786.10875.3318705779489360767.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     cf580ad490514cca4abbfef710fe4099738abfbd
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//cf580ad490514cca4abbfef710fe4099738abfbd
Author:        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
AuthorDate:    Fri, 23 Feb 2024 16:59:40 +01:00
Committer:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CommitterDate: Wed, 27 Mar 2024 14:50:26 +01:00

thermal: netlink: Add genetlink bind/unbind notifications

Introduce a new feature to the thermal netlink framework, enabling the
registration of sub drivers to receive events via a notifier mechanism.
Specifically, implement genetlink family bind and unbind callbacks to send
BIND and UNBIND events.

The primary purpose of this enhancement is to facilitate the tracking of
user-space consumers by the Intel HFI driver. By leveraging these
notifications, the driver can determine when consumers are present
or absent.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_netlink.c | 40 ++++++++++++++++++++++++++----
 drivers/thermal/thermal_netlink.h | 26 ++++++++++++++++++++-
 2 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
index 76a231a..d407130 100644
--- a/drivers/thermal/thermal_netlink.c
+++ b/drivers/thermal/thermal_netlink.c
@@ -7,17 +7,13 @@
  * Generic netlink for thermal management framework
  */
 #include <linux/module.h>
+#include <linux/notifier.h>
 #include <linux/kernel.h>
 #include <net/genetlink.h>
 #include <uapi/linux/thermal.h>
 
 #include "thermal_core.h"
 
-enum thermal_genl_multicast_groups {
-	THERMAL_GENL_SAMPLING_GROUP = 0,
-	THERMAL_GENL_EVENT_GROUP = 1,
-};
-
 static const struct genl_multicast_group thermal_genl_mcgrps[] = {
 	[THERMAL_GENL_SAMPLING_GROUP] = { .name = THERMAL_GENL_SAMPLING_GROUP_NAME, },
 	[THERMAL_GENL_EVENT_GROUP]  = { .name = THERMAL_GENL_EVENT_GROUP_NAME,  },
@@ -75,6 +71,7 @@ struct param {
 typedef int (*cb_t)(struct param *);
 
 static struct genl_family thermal_gnl_family;
+static BLOCKING_NOTIFIER_HEAD(thermal_genl_chain);
 
 static int thermal_group_has_listeners(enum thermal_genl_multicast_groups group)
 {
@@ -645,6 +642,27 @@ out_free_msg:
 	return ret;
 }
 
+static int thermal_genl_bind(int mcgrp)
+{
+	struct thermal_genl_notify n = { .mcgrp = mcgrp };
+
+	if (WARN_ON_ONCE(mcgrp > THERMAL_GENL_MAX_GROUP))
+		return -EINVAL;
+
+	blocking_notifier_call_chain(&thermal_genl_chain, THERMAL_NOTIFY_BIND, &n);
+	return 0;
+}
+
+static void thermal_genl_unbind(int mcgrp)
+{
+	struct thermal_genl_notify n = { .mcgrp = mcgrp };
+
+	if (WARN_ON_ONCE(mcgrp > THERMAL_GENL_MAX_GROUP))
+		return;
+
+	blocking_notifier_call_chain(&thermal_genl_chain, THERMAL_NOTIFY_UNBIND, &n);
+}
+
 static const struct genl_small_ops thermal_genl_ops[] = {
 	{
 		.cmd = THERMAL_GENL_CMD_TZ_GET_ID,
@@ -679,6 +697,8 @@ static struct genl_family thermal_gnl_family __ro_after_init = {
 	.version	= THERMAL_GENL_VERSION,
 	.maxattr	= THERMAL_GENL_ATTR_MAX,
 	.policy		= thermal_genl_policy,
+	.bind		= thermal_genl_bind,
+	.unbind		= thermal_genl_unbind,
 	.small_ops	= thermal_genl_ops,
 	.n_small_ops	= ARRAY_SIZE(thermal_genl_ops),
 	.resv_start_op	= THERMAL_GENL_CMD_CDEV_GET + 1,
@@ -686,6 +706,16 @@ static struct genl_family thermal_gnl_family __ro_after_init = {
 	.n_mcgrps	= ARRAY_SIZE(thermal_genl_mcgrps),
 };
 
+int thermal_genl_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&thermal_genl_chain, nb);
+}
+
+int thermal_genl_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&thermal_genl_chain, nb);
+}
+
 int __init thermal_netlink_init(void)
 {
 	return genl_register_family(&thermal_gnl_family);
diff --git a/drivers/thermal/thermal_netlink.h b/drivers/thermal/thermal_netlink.h
index 93a927e..e01221e 100644
--- a/drivers/thermal/thermal_netlink.h
+++ b/drivers/thermal/thermal_netlink.h
@@ -10,6 +10,19 @@ struct thermal_genl_cpu_caps {
 	int efficiency;
 };
 
+enum thermal_genl_multicast_groups {
+	THERMAL_GENL_SAMPLING_GROUP = 0,
+	THERMAL_GENL_EVENT_GROUP = 1,
+	THERMAL_GENL_MAX_GROUP = THERMAL_GENL_EVENT_GROUP,
+};
+
+#define THERMAL_NOTIFY_BIND	0
+#define THERMAL_NOTIFY_UNBIND	1
+
+struct thermal_genl_notify {
+	int mcgrp;
+};
+
 struct thermal_zone_device;
 struct thermal_trip;
 struct thermal_cooling_device;
@@ -18,6 +31,9 @@ struct thermal_cooling_device;
 #ifdef CONFIG_THERMAL_NETLINK
 int __init thermal_netlink_init(void);
 void __init thermal_netlink_exit(void);
+int thermal_genl_register_notifier(struct notifier_block *nb);
+int thermal_genl_unregister_notifier(struct notifier_block *nb);
+
 int thermal_notify_tz_create(const struct thermal_zone_device *tz);
 int thermal_notify_tz_delete(const struct thermal_zone_device *tz);
 int thermal_notify_tz_enable(const struct thermal_zone_device *tz);
@@ -48,6 +64,16 @@ static inline int thermal_notify_tz_create(const struct thermal_zone_device *tz)
 	return 0;
 }
 
+static inline int thermal_genl_register_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
+
+static inline int thermal_genl_unregister_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
+
 static inline int thermal_notify_tz_delete(const struct thermal_zone_device *tz)
 {
 	return 0;

