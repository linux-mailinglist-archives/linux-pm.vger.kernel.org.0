Return-Path: <linux-pm+bounces-1608-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A5C81EF48
	for <lists+linux-pm@lfdr.de>; Wed, 27 Dec 2023 15:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE84B282FFC
	for <lists+linux-pm@lfdr.de>; Wed, 27 Dec 2023 14:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D165745010;
	Wed, 27 Dec 2023 14:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bz3En53h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6A94500F
	for <linux-pm@vger.kernel.org>; Wed, 27 Dec 2023 14:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703685661; x=1735221661;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5LKcQdP7ur7aVptkzL2MhMEUTfXv8C2vm1VS/51uEcs=;
  b=bz3En53hF7i+tO++dSrY7pwibMGrriSO33YPdZj6ZVBoDQ00eEQklUEE
   NCNJQqKzIruFRa25idA3qESLNmV7t6/gPenxt3Vg2MkXid4LcEjWCLBck
   lkVuqaItwF2SYKsOya10yqmfM2nhGWWWy4rAMYsSEjHwD6D5Y6LWBOw/E
   6rQyjSjdpqdueLc4ubV+Wm7Uv0xDpVfixd/s2E1ugq/nQozmvh4/cCdMV
   Kdgz2aKKOeV4aUbqfcqmBTcvevPTVVx8C9qhePZPBfeuG9fdTpDKzosFU
   f/JyKZQO8+j+ns31sXesUELbl4jsbiJM8Rtk3Titq5YuTpnNmQ49hfFE0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="400262197"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="400262197"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 06:01:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="26576567"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.50.181])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 06:00:59 -0800
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH 1/2] thermal: netlink: Add enum for mutlicast groups indexes
Date: Wed, 27 Dec 2023 15:00:56 +0100
Message-Id: <20231227140057.174314-1-stanislaw.gruszka@linux.intel.com>
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


