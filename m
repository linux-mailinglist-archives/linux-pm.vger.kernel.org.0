Return-Path: <linux-pm+bounces-1639-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1EA81F70D
	for <lists+linux-pm@lfdr.de>; Thu, 28 Dec 2023 11:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD32A281D0F
	for <lists+linux-pm@lfdr.de>; Thu, 28 Dec 2023 10:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4246D18;
	Thu, 28 Dec 2023 10:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iusbon4r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C285A6ABA
	for <linux-pm@vger.kernel.org>; Thu, 28 Dec 2023 10:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703760574; x=1735296574;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0sAvdIn2E0Oqh1TcFf0EvH/Qeo84THG6gytYAs8xgS8=;
  b=iusbon4rR+7HSsJ5hGcgjjq2TWWXyDKcpr/q5kt3aGZ0aviRDUgvUIyM
   jY4+7aNp3IQm9hF8DJEDwktJpBplPmPBcl5PtimoJ5SGKGMy3kRExOtU8
   im6LOKvHxGLk1YFuxlMVxpkb9u9hjluwphysYWGTF7TyifiBTo0kX138P
   1U6Q5AZ1Qx1FpwuH43PwXy3sNepQZEB3FxxnhGP9IpPMld8hn7jxBGmXe
   LfFVtRd9y/FnVY5MmpWYfJhW0ovouPAPI+xQChhqZela3LarJD3/7Qitu
   EKIQe9qnZf+G31IvWZSPIDEkacqFZxAsH2wze3QO61ZtmZYBnLYgtYnjd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="3372084"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="3372084"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 02:49:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="12974781"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.50.175])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 02:49:31 -0800
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 2/2] thermal: netlink: Add thermal_group_has_listeners() helper
Date: Thu, 28 Dec 2023 11:02:48 +0100
Message-Id: <20231228100248.180721-2-stanislaw.gruszka@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231228100248.180721-1-stanislaw.gruszka@linux.intel.com>
References: <20231228100248.180721-1-stanislaw.gruszka@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper function to check if there are listeners for
thermal_gnl_family multicast groups.

For now use it to avoid unnecessary allocations and sending
thermal genl messages when there are no recipients.

In the future, in conjunction with (not yet implemented) notification
of change in the netlink socket group membership, this helper can be
used to open/close hardware interfaces based on the presence of
user space subscribers.

Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
---
v2: Do not return -ESRCH error when there are no listeners

 drivers/thermal/thermal_netlink.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
index aca36c4ddbf3..332052e24a86 100644
--- a/drivers/thermal/thermal_netlink.c
+++ b/drivers/thermal/thermal_netlink.c
@@ -76,6 +76,11 @@ typedef int (*cb_t)(struct param *);
 
 static struct genl_family thermal_gnl_family;
 
+static int thermal_group_has_listeners(enum thermal_genl_multicast_groups group)
+{
+	return genl_has_listeners(&thermal_gnl_family, &init_net, group);
+}
+
 /************************** Sampling encoding *******************************/
 
 int thermal_genl_sampling_temp(int id, int temp)
@@ -83,6 +88,9 @@ int thermal_genl_sampling_temp(int id, int temp)
 	struct sk_buff *skb;
 	void *hdr;
 
+	if (!thermal_group_has_listeners(THERMAL_GENL_SAMPLING_GROUP))
+		return 0;
+
 	skb = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (!skb)
 		return -ENOMEM;
@@ -280,6 +288,9 @@ static int thermal_genl_send_event(enum thermal_genl_event event,
 	int ret = -EMSGSIZE;
 	void *hdr;
 
+	if (!thermal_group_has_listeners(THERMAL_GENL_EVENT_GROUP))
+		return 0;
+
 	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
-- 
2.34.1


