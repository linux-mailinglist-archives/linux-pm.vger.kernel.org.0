Return-Path: <linux-pm+bounces-4334-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 574D68616A9
	for <lists+linux-pm@lfdr.de>; Fri, 23 Feb 2024 17:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAE871F26BE9
	for <lists+linux-pm@lfdr.de>; Fri, 23 Feb 2024 16:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A4183CDB;
	Fri, 23 Feb 2024 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iDz75msn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D194883CD2
	for <linux-pm@vger.kernel.org>; Fri, 23 Feb 2024 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703996; cv=none; b=jlXGuK+MwG4oCZqwZoYHXO3HozBTndCv0hHmgwr+n+NyS3nv7LXgT1KQwNXaoqRVIl75BRBi4mKYTG49fhld+q4IxEn2d69xS4kLGcSqAsTrzye+3ZWyNRIqCMS0QdCdzhaAAwaEbguaCnswKMGwFcnWdKSJzKotrPZgKNn9TNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703996; c=relaxed/simple;
	bh=wM3ugoiuK2yKBQNmJd2QdLtW+1dU4BDK+2SVY1gpp8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nO4+bKPtfyWFcbj2UKLH0BzUbW8zHD9PN6JYmNbXbIAPro7C4KWOnDX1YJ0zjvV4FJDC+kPx4SwbeiB865NTMALs3dohcxYv1dTa30tB0dnZ5z1mSV2dyx1vrTS7nDeNDqiCu48G1cEYZfs7Q18zCuGlUaHZanIVI++bHqyclcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iDz75msn; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708703995; x=1740239995;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wM3ugoiuK2yKBQNmJd2QdLtW+1dU4BDK+2SVY1gpp8g=;
  b=iDz75msnbbjFSQAUwc6S94I0r0NcK5ErV+QK96vQf7GQ7k0M3g7M/MOF
   kOVNYrRMgI3W5EcqYHMyFdRif2QvfnYIFyLn1fbSY1rGgcAmiAlvFCEsj
   aHG3pJdds0BDYssc1tzKmgXUDcsfC9ZNFsWpeC8dJt2Ft3oyUGW+4hvYi
   Z7+S1+CTFjJeyGXD5BgKml4/VmzqGKhjpZuFNz9GcivSKAD4xm0xM5hSW
   ExNN16+snWX7AffE5iHfqw630/4E/wxbM1GKK8ViU18Ma4mfnKVcmTNDi
   tni+rhOMjOBRuxtgPN+JMOV7NwzOH2CLrzUjPX8ePbo5pwA2BxiPSKn3D
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="3179333"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="3179333"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:59:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="36956525"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.47.110])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:59:53 -0800
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v5 2/3] thermal: netlink: Rename thermal_gnl_family
Date: Fri, 23 Feb 2024 16:59:41 +0100
Message-Id: <20240223155942.60813-3-stanislaw.gruszka@linux.intel.com>
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

Almost all thermal netlink structures use thermal_genl prefix.
Change thermal_gnl_family name accordingly for consistency.

No functional impact.

Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
---
 drivers/thermal/thermal_netlink.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
index d407130563e5..bef14ce69ec4 100644
--- a/drivers/thermal/thermal_netlink.c
+++ b/drivers/thermal/thermal_netlink.c
@@ -70,12 +70,12 @@ struct param {
 
 typedef int (*cb_t)(struct param *);
 
-static struct genl_family thermal_gnl_family;
+static struct genl_family thermal_genl_family;
 static BLOCKING_NOTIFIER_HEAD(thermal_genl_chain);
 
 static int thermal_group_has_listeners(enum thermal_genl_multicast_groups group)
 {
-	return genl_has_listeners(&thermal_gnl_family, &init_net, group);
+	return genl_has_listeners(&thermal_genl_family, &init_net, group);
 }
 
 /************************** Sampling encoding *******************************/
@@ -92,7 +92,7 @@ int thermal_genl_sampling_temp(int id, int temp)
 	if (!skb)
 		return -ENOMEM;
 
-	hdr = genlmsg_put(skb, 0, 0, &thermal_gnl_family, 0,
+	hdr = genlmsg_put(skb, 0, 0, &thermal_genl_family, 0,
 			  THERMAL_GENL_SAMPLING_TEMP);
 	if (!hdr)
 		goto out_free;
@@ -105,7 +105,7 @@ int thermal_genl_sampling_temp(int id, int temp)
 
 	genlmsg_end(skb, hdr);
 
-	genlmsg_multicast(&thermal_gnl_family, skb, 0, THERMAL_GENL_SAMPLING_GROUP, GFP_KERNEL);
+	genlmsg_multicast(&thermal_genl_family, skb, 0, THERMAL_GENL_SAMPLING_GROUP, GFP_KERNEL);
 
 	return 0;
 out_cancel:
@@ -279,7 +279,7 @@ static int thermal_genl_send_event(enum thermal_genl_event event,
 		return -ENOMEM;
 	p->msg = msg;
 
-	hdr = genlmsg_put(msg, 0, 0, &thermal_gnl_family, 0, event);
+	hdr = genlmsg_put(msg, 0, 0, &thermal_genl_family, 0, event);
 	if (!hdr)
 		goto out_free_msg;
 
@@ -289,7 +289,7 @@ static int thermal_genl_send_event(enum thermal_genl_event event,
 
 	genlmsg_end(msg, hdr);
 
-	genlmsg_multicast(&thermal_gnl_family, msg, 0, THERMAL_GENL_EVENT_GROUP, GFP_KERNEL);
+	genlmsg_multicast(&thermal_genl_family, msg, 0, THERMAL_GENL_EVENT_GROUP, GFP_KERNEL);
 
 	return 0;
 
@@ -590,7 +590,7 @@ static int thermal_genl_cmd_dumpit(struct sk_buff *skb,
 	int ret;
 	void *hdr;
 
-	hdr = genlmsg_put(skb, 0, 0, &thermal_gnl_family, 0, cmd);
+	hdr = genlmsg_put(skb, 0, 0, &thermal_genl_family, 0, cmd);
 	if (!hdr)
 		return -EMSGSIZE;
 
@@ -622,7 +622,7 @@ static int thermal_genl_cmd_doit(struct sk_buff *skb,
 		return -ENOMEM;
 	p.msg = msg;
 
-	hdr = genlmsg_put_reply(msg, info, &thermal_gnl_family, 0, cmd);
+	hdr = genlmsg_put_reply(msg, info, &thermal_genl_family, 0, cmd);
 	if (!hdr)
 		goto out_free_msg;
 
@@ -691,7 +691,7 @@ static const struct genl_small_ops thermal_genl_ops[] = {
 	},
 };
 
-static struct genl_family thermal_gnl_family __ro_after_init = {
+static struct genl_family thermal_genl_family __ro_after_init = {
 	.hdrsize	= 0,
 	.name		= THERMAL_GENL_FAMILY_NAME,
 	.version	= THERMAL_GENL_VERSION,
@@ -718,10 +718,10 @@ int thermal_genl_unregister_notifier(struct notifier_block *nb)
 
 int __init thermal_netlink_init(void)
 {
-	return genl_register_family(&thermal_gnl_family);
+	return genl_register_family(&thermal_genl_family);
 }
 
 void __init thermal_netlink_exit(void)
 {
-	genl_unregister_family(&thermal_gnl_family);
+	genl_unregister_family(&thermal_genl_family);
 }
-- 
2.34.1


