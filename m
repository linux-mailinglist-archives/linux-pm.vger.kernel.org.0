Return-Path: <linux-pm+bounces-3067-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1A584402B
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jan 2024 14:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454A5297F98
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jan 2024 13:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98287D3EE;
	Wed, 31 Jan 2024 13:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iakkdDkD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F29A7BB0D;
	Wed, 31 Jan 2024 13:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706593; cv=none; b=qF914E5jgWwuLRQbuh2Enep6IXR2BkFoURxY2o8Bu33o37+lKVc8W2/RTNiHL8LAyHnNIwFJtzQfJkaEqlGGv/2bMY+qn2BgFY6e50oKDGzuhS05++btUFqwhOUOZHbtxBucHtgPduZXv2dXQb3i3hzSQ3SJzQ0DVm57YUiRTaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706593; c=relaxed/simple;
	bh=RCT/pm4jNBaLXvngRoHheyS4c+M6ptTcHkicWfz+8qM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M4zgDtscQ3hwrXYNWy7CLJ78jpMBBAd8xDgXQDbcqUiLOlmsebtxXzOj3zn7gi+3etxkWsNWpayA2oKUh19mbJ0vGKESs68CzvPJaSfrVifOBZG9GFjd8K5J3E72H2twLrD3f9MXjbycXtN/xzzl4Q4mIkJc0a1p/lfjbN2HNkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iakkdDkD; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706706592; x=1738242592;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RCT/pm4jNBaLXvngRoHheyS4c+M6ptTcHkicWfz+8qM=;
  b=iakkdDkDzaii6RpggdOMoQDECMkJrKC9xbrAWqlsfY5gqSVYXbCTN7Qt
   AUEwt6svXrRN9pnjYYZe/3wQVqsuA4W4iExdUcTA0VH4ss06GXwo1ep7z
   s+avRwpGo4ArjBfDvQBnGcqPGZgxcEVdk9hI1SOj4/L1FJiehHMBLYTwD
   FguLrljlMTM5/5zqSa/mUgJLAZu725dorlgc69+vpNZl9ltSiuktHL483
   yvyP71AYoth2T60ss/XCh/eXnXqR4SZRf/n2L3Z7OSuZ3ee38pHDCK7iq
   YvCWdJjiGP9Eh3t/DEEAx1vniA2/NR8Vk8a+N+SdgpoueGtoRDiWREw/M
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="17127000"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="17127000"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 05:09:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="858816208"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="858816208"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.43.19])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 05:09:46 -0800
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
	netdev@vger.kernel.org
Subject: [PATCH 2/3] thermal: netlink: Export thermal_group_has_listeners()
Date: Wed, 31 Jan 2024 13:05:34 +0100
Message-Id: <20240131120535.933424-3-stanislaw.gruszka@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131120535.933424-1-stanislaw.gruszka@linux.intel.com>
References: <20240131120535.933424-1-stanislaw.gruszka@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let drivers use thermal_group_has_listners(). The intel_hfi driver needs
it to enable HFI only when user-space consumers are present.

Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
---
 drivers/thermal/thermal_netlink.c |  7 +------
 drivers/thermal/thermal_netlink.h | 11 +++++++++++
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
index 569e4fa62f73..44e8df2751ba 100644
--- a/drivers/thermal/thermal_netlink.c
+++ b/drivers/thermal/thermal_netlink.c
@@ -13,11 +13,6 @@
 
 #include "thermal_core.h"
 
-enum thermal_genl_multicast_groups {
-	THERMAL_GENL_SAMPLING_GROUP = 0,
-	THERMAL_GENL_EVENT_GROUP = 1,
-};
-
 static const struct genl_multicast_group thermal_genl_mcgrps[] = {
 	[THERMAL_GENL_SAMPLING_GROUP] = { .name = THERMAL_GENL_SAMPLING_GROUP_NAME, },
 	[THERMAL_GENL_EVENT_GROUP]  = { .name = THERMAL_GENL_EVENT_GROUP_NAME,  },
@@ -76,7 +71,7 @@ typedef int (*cb_t)(struct param *);
 
 static struct genl_family thermal_gnl_family;
 
-static int thermal_group_has_listeners(enum thermal_genl_multicast_groups group)
+int thermal_group_has_listeners(enum thermal_genl_multicast_groups group)
 {
 	return genl_has_listeners(&thermal_gnl_family, &init_net, group);
 }
diff --git a/drivers/thermal/thermal_netlink.h b/drivers/thermal/thermal_netlink.h
index 0a9987c3bc57..3272a966f404 100644
--- a/drivers/thermal/thermal_netlink.h
+++ b/drivers/thermal/thermal_netlink.h
@@ -10,10 +10,16 @@ struct thermal_genl_cpu_caps {
 	int efficiency;
 };
 
+enum thermal_genl_multicast_groups {
+	THERMAL_GENL_SAMPLING_GROUP = 0,
+	THERMAL_GENL_EVENT_GROUP = 1,
+};
+
 /* Netlink notification function */
 #ifdef CONFIG_THERMAL_NETLINK
 int __init thermal_netlink_init(void);
 void __init thermal_netlink_exit(void);
+int thermal_group_has_listeners(enum thermal_genl_multicast_groups group);
 int thermal_notify_tz_create(int tz_id, const char *name);
 int thermal_notify_tz_delete(int tz_id);
 int thermal_notify_tz_enable(int tz_id);
@@ -38,6 +44,11 @@ static inline int thermal_netlink_init(void)
 	return 0;
 }
 
+static inline int thermal_group_has_listeners(enum thermal_genl_multicast_groups group)
+{
+	return 0;
+}
+
 static inline int thermal_notify_tz_create(int tz_id, const char *name)
 {
 	return 0;
-- 
2.34.1


