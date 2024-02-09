Return-Path: <linux-pm+bounces-3682-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1694184F506
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 13:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 291E6B23DCD
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 12:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B1D2E64F;
	Fri,  9 Feb 2024 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lH1xPH1y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B215B2EAE5;
	Fri,  9 Feb 2024 12:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707480409; cv=none; b=MaO7rndPTUOSUQmeJ7VPfl3swO6AfhWNNQACLjBOS0J/B2jxH/uLhhsSSWzcxI2Ozx3W066NFg2sGHZl562z9tu9XycWIHYhlqFMCgQEgZ1YeLUe5MBCX6QTkxZYHzS5u/i+6R0j3OWxff4NhKA0BhgAN2T80IU1cQ8rC5wYmSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707480409; c=relaxed/simple;
	bh=mUB42E5zYlBegavQGX67AoSxoH8EjY6FH5y+NA2aTOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b+QJ3J3kGW0ZezTqOjM7mbIata6ixJx/9m/YAiVX0HYdcd3mRegssrVyvn1XG20NwEIdeZAlEkHJrLmxK3rKJiTADwE2LzFMG+voxgr5pvflpKNdB7/O0qYOT7CwKkiB0SIVF0hXwgHMv5MD5lpBjOEEIbVLA3s8HsR9Ed7aWi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lH1xPH1y; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707480404; x=1739016404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mUB42E5zYlBegavQGX67AoSxoH8EjY6FH5y+NA2aTOk=;
  b=lH1xPH1ySuL11VxnZUaKLF8lVC2IyYk94uE83vLT4aJ12k3cq/qf8GNq
   7V5BXdiHXq8RiN/z8BRRUjXHHHUVnuRottr5YkJAu0u0++r9IOm54XbIr
   ufpBO9TTXEYTg+jXzRVHIUbdkhXcW80w6c2tVhrtZQIz0LBiPFj+fYuZe
   SVOZmqj8m2/tsSBrZyA6ewXmmygNeFQHQrMMHJNkl/Q2S7pJURjLRL6KO
   jVlozF03IiNidBmMhqS7N4p84m9InrYHDF3c4pjRCq69Q06Xmvac7j3zX
   FRxRbhMWQgIVSp5QqN9D9ufGUUAl0jNshaRa8YBSFvkDWKD10chWv1kkl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1571380"
X-IronPort-AV: E=Sophos;i="6.05,256,1701158400"; 
   d="scan'208";a="1571380"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 04:06:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,256,1701158400"; 
   d="scan'208";a="6574174"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.43.96])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 04:06:39 -0800
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes@sipsolutions.net>,
	Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org
Subject: [PATCH v3 2/3] thermal: netlink: Add genetlink bind/unbind notifications
Date: Fri,  9 Feb 2024 13:06:24 +0100
Message-Id: <20240209120625.1775017-3-stanislaw.gruszka@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209120625.1775017-1-stanislaw.gruszka@linux.intel.com>
References: <20240209120625.1775017-1-stanislaw.gruszka@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new feature to the thermal netlink framework, enabling the
registration of sub drivers to receive events via a notifier mechanism.
Specifically, implement genetlink family bind and unbind callbacks to send
BIND and UNBIND events.

The primary purpose of this enhancement is to facilitate the tracking of
user-space consumers by the intel_hif driver. By leveraging these
notifications, the driver can determine when consumers are present
or absent.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
---
 drivers/thermal/thermal_netlink.c | 40 +++++++++++++++++++++++++++----
 drivers/thermal/thermal_netlink.h | 25 +++++++++++++++++++
 2 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
index 76a231a29654..86c7653a9530 100644
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
+static BLOCKING_NOTIFIER_HEAD(thermal_gnl_chain);
 
 static int thermal_group_has_listeners(enum thermal_genl_multicast_groups group)
 {
@@ -645,6 +642,27 @@ static int thermal_genl_cmd_doit(struct sk_buff *skb,
 	return ret;
 }
 
+static int thermal_genl_bind(int mcgrp)
+{
+	struct thermal_genl_notify n = { .mcgrp = mcgrp };
+
+	if (WARN_ON_ONCE(mcgrp > THERMAL_GENL_MAX_GROUP))
+		return -EINVAL;
+
+	blocking_notifier_call_chain(&thermal_gnl_chain, THERMAL_NOTIFY_BIND, &n);
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
+	blocking_notifier_call_chain(&thermal_gnl_chain, THERMAL_NOTIFY_UNBIND, &n);
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
+	return blocking_notifier_chain_register(&thermal_gnl_chain, nb);
+}
+
+int thermal_genl_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&thermal_gnl_chain, nb);
+}
+
 int __init thermal_netlink_init(void)
 {
 	return genl_register_family(&thermal_gnl_family);
diff --git a/drivers/thermal/thermal_netlink.h b/drivers/thermal/thermal_netlink.h
index 93a927e144d5..69211ece7392 100644
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
@@ -48,6 +64,15 @@ static inline int thermal_notify_tz_create(const struct thermal_zone_device *tz)
 	return 0;
 }
 
+int thermal_genl_register_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
+
+int thermal_genl_unregister_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
 static inline int thermal_notify_tz_delete(const struct thermal_zone_device *tz)
 {
 	return 0;
-- 
2.34.1


