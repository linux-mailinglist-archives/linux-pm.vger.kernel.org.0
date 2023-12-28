Return-Path: <linux-pm+bounces-1638-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D909E81F70C
	for <lists+linux-pm@lfdr.de>; Thu, 28 Dec 2023 11:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 157CA1C20B56
	for <lists+linux-pm@lfdr.de>; Thu, 28 Dec 2023 10:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735F263BA;
	Thu, 28 Dec 2023 10:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iI0B8S3A"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78916FBF
	for <linux-pm@vger.kernel.org>; Thu, 28 Dec 2023 10:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703760570; x=1735296570;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R5TMjyXxMAVvHfktZcOqUrrKY5qVT+aFxOwGz5GOYow=;
  b=iI0B8S3AJVYfUcYh489rsq/VHkgmXn/Zt6/nq9/n1yj7hVZdJUztHrqx
   +kg9URBjparY56m3MGSZi02gZzcOyoLH1eQ2fCToFsqBzqwIqv+8vpzxK
   3KH1eBOae8YUaxjL2QS4y5m1tZ/+ZnG7M3pCozDtzkSDp/QCdIx3CQbUb
   +edtfycctnWmSrwuweoTDEq7XbmJZg6OvaHSAzZ5HyB8+po8yocGpfJlg
   XEnoGKM02fpbKOtdLyhWEQbghFfsgzfqoFWedCkDRzNudkQYwjUZPcrmU
   0OP0T1uYgIOlY2kpofFT58OSwLeqNy6yBnN6AO+2RI4IyHG6DBIxHfvV7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="3832080"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="3832080"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 02:49:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="897170668"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="897170668"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.50.175])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 02:49:27 -0800
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 1/2] thermal: netlink: Add enum for mutlicast groups indexes
Date: Thu, 28 Dec 2023 11:02:47 +0100
Message-Id: <20231228100248.180721-1-stanislaw.gruszka@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use enum instead of hard-coded numbers for indexing multicast groups.

Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
---
v2: No change

 drivers/thermal/thermal_netlink.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
index 21f00d73acb7..aca36c4ddbf3 100644
--- a/drivers/thermal/thermal_netlink.c
+++ b/drivers/thermal/thermal_netlink.c
@@ -13,9 +13,14 @@
 
 #include "thermal_core.h"
 
+enum thermal_genl_multicast_groups {
+	THERMAL_GENL_SAMPLING_GROUP = 0,
+	THERMAL_GENL_EVENT_GROUP = 1,
+};
+
 static const struct genl_multicast_group thermal_genl_mcgrps[] = {
-	{ .name = THERMAL_GENL_SAMPLING_GROUP_NAME, },
-	{ .name = THERMAL_GENL_EVENT_GROUP_NAME,  },
+	[THERMAL_GENL_SAMPLING_GROUP] = { .name = THERMAL_GENL_SAMPLING_GROUP_NAME, },
+	[THERMAL_GENL_EVENT_GROUP]  = { .name = THERMAL_GENL_EVENT_GROUP_NAME,  },
 };
 
 static const struct nla_policy thermal_genl_policy[THERMAL_GENL_ATTR_MAX + 1] = {
@@ -95,7 +100,7 @@ int thermal_genl_sampling_temp(int id, int temp)
 
 	genlmsg_end(skb, hdr);
 
-	genlmsg_multicast(&thermal_gnl_family, skb, 0, 0, GFP_KERNEL);
+	genlmsg_multicast(&thermal_gnl_family, skb, 0, THERMAL_GENL_SAMPLING_GROUP, GFP_KERNEL);
 
 	return 0;
 out_cancel:
@@ -290,7 +295,7 @@ static int thermal_genl_send_event(enum thermal_genl_event event,
 
 	genlmsg_end(msg, hdr);
 
-	genlmsg_multicast(&thermal_gnl_family, msg, 0, 1, GFP_KERNEL);
+	genlmsg_multicast(&thermal_gnl_family, msg, 0, THERMAL_GENL_EVENT_GROUP, GFP_KERNEL);
 
 	return 0;
 
-- 
2.34.1


