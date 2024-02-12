Return-Path: <linux-pm+bounces-3805-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E50588518CB
	for <lists+linux-pm@lfdr.de>; Mon, 12 Feb 2024 17:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FEEA1F21D6F
	for <lists+linux-pm@lfdr.de>; Mon, 12 Feb 2024 16:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7503D0C8;
	Mon, 12 Feb 2024 16:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F2g8dZ/x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2163D0B6;
	Mon, 12 Feb 2024 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707754601; cv=none; b=jq4shgH78EyyyL0994bdVCffI2f5bMkOPKMV+GAfcmk7obPVRok3Pz+giHxPbO6F0KmjdC4gwnz3fWi7ixdaMG5bOcN/ezS68zqWMaiq5lzTC1AONLR2sAm/UTSypHM+COJKU4Rj4YWb5oDJxwBqczPugHS1WZnLmq/cyqCqaUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707754601; c=relaxed/simple;
	bh=ND8n57rlmkSgV9GfOvISLu38xexKqntZbI+U/O7xT9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ejNs/w4uHT227Med0UAfiyczr0/eo5dAhzSTzsRmzl5TE1dhtfDEHmhjH6ivC8aSJTgcYfCjqG3SZhUApk2pAMngW54rvK9CDr5v+E9IIrNzYrl2acKf1ip2d2OQTRghNVHiiL4MMouoasySGEEUSL2Z5/8dwrGBtFmdVm4fiF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F2g8dZ/x; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707754600; x=1739290600;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ND8n57rlmkSgV9GfOvISLu38xexKqntZbI+U/O7xT9w=;
  b=F2g8dZ/xvS1Qfz7EoHpzMTRCz1Es9EoC3IFyk50tRSOaoAhZwJzBh+BH
   TrcMbs93NdK7O05HOJOmZMArS3HRud7PjLCtc0+Yi6uylfAYnbiUbpwg1
   5OJV+ETkNKR1MfES+DccgZYQqRBILpCqYHz6PTcD+cUVe1pdyUkMuJ/HI
   5dSQr2lUADeL3rN1Wg3gcCq2g3OYFMCgTJ4hRKwRKCfuI9c3pc8Kxq3Px
   0JQmnbE2yhUmgdTwW6DkDKtF9cRF1doyeO1VWNKONS8V79OwBUANWFvAV
   Qmclwu5QEcnJ419PbeAGc0tiZOOZUFwxTpWKKtgqIkZVxpFxIfoNIKgi2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1873179"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="1873179"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 08:16:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="7258739"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.44.2])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 08:16:37 -0800
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
Subject: [PATCH v4 2/3] thermal: netlink: Add genetlink bind/unbind notifications
Date: Mon, 12 Feb 2024 17:16:14 +0100
Message-Id: <20240212161615.161935-3-stanislaw.gruszka@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212161615.161935-1-stanislaw.gruszka@linux.intel.com>
References: <20240212161615.161935-1-stanislaw.gruszka@linux.intel.com>
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
 drivers/thermal/thermal_netlink.h | 26 ++++++++++++++++++++
 2 files changed, 61 insertions(+), 5 deletions(-)

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
index 93a927e144d5..e01221e8816b 100644
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
-- 
2.34.1


