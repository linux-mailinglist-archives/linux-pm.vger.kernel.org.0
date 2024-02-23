Return-Path: <linux-pm+bounces-4333-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D238616A8
	for <lists+linux-pm@lfdr.de>; Fri, 23 Feb 2024 17:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7733B1F26D3C
	for <lists+linux-pm@lfdr.de>; Fri, 23 Feb 2024 16:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5655839FB;
	Fri, 23 Feb 2024 15:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ar7CECH+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0082183A13
	for <linux-pm@vger.kernel.org>; Fri, 23 Feb 2024 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703992; cv=none; b=sPssSE0EKaWJ3HnQW9jQXY3K2OTbdCfLGIyobPA1wmU67q5ViJKIThbTBl9q6jYOUg5QxF4mxIEBjlq2PR972tSNCsP1BiofnNm3oCtMnRO+qL2izq31gFhPO+Y1fzhcWa2ZuUupwmu/KpgBkFK0uBURKfwJ52h0dLaPKw1iiwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703992; c=relaxed/simple;
	bh=nbncvWSmtcdEGM3duaASMr9ciLvNC7n2wGSaxs2VByw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q+62UT8V9N6aaJRZrEniihWynz8kE/rfsaHkxcHJrFYhVSHgCMu+sjN41OAZz5NtBclcQY8HVbktjaGkRADIUxSoJJ9gHbtjB9FzlxOrKFIRhQO536ICW3Hwp5ye6DOfGrs0lrWPJQ7bnyyr4nPImJhF5kTtwhyYdQTZr2zfhSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ar7CECH+; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708703991; x=1740239991;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nbncvWSmtcdEGM3duaASMr9ciLvNC7n2wGSaxs2VByw=;
  b=Ar7CECH+bkJkWV8Zxueyj1tMhSScSaE/InXCyVavkiwxg46dXpvW2UZc
   GKbpS9tPl0xyJZHV8CQ1lNBeK/WagC2uTZVE2XPimYEc6TDZJoW0xXiat
   05yY3FWJhro67C8c9nrie9tQRKwgtH2A/nKO7TEC3KLhA0RrLl5IrTvO2
   GBuapgpSuFLYz3VMnpAJZF4UjSnrOALyP1PJkanEZkHgGdtlbW8awhezT
   heTkZgPiIHKOKiwYESe4Qrj6qy1yx9MK3xDr4gnUkDaiycP3O20l38V/B
   Iee/5wNHBWo4+cASBXepPAcofIEMCPhIwPrxTFT67xNjRsOjjoYSduhoI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="3179309"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="3179309"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:59:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="36956508"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.47.110])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:59:49 -0800
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v5 1/3] thermal: netlink: Add genetlink bind/unbind notifications
Date: Fri, 23 Feb 2024 16:59:40 +0100
Message-Id: <20240223155942.60813-2-stanislaw.gruszka@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223155942.60813-1-stanislaw.gruszka@linux.intel.com>
References: <20240223155942.60813-1-stanislaw.gruszka@linux.intel.com>
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
user-space consumers by the Intel HFI driver. By leveraging these
notifications, the driver can determine when consumers are present
or absent.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
---
 drivers/thermal/thermal_netlink.c | 40 +++++++++++++++++++++++++++----
 drivers/thermal/thermal_netlink.h | 26 ++++++++++++++++++++
 2 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
index 76a231a29654..d407130563e5 100644
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


