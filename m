Return-Path: <linux-pm+bounces-3681-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB42084F503
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 13:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7C91C260B6
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 12:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EE62E821;
	Fri,  9 Feb 2024 12:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W5qL7k76"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2D620311;
	Fri,  9 Feb 2024 12:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707480403; cv=none; b=cpOi8fb+Xtav7IC4QoHfWW+n0nw6xeos8FYWn5FkOdwujUUpGX6zqrtBBHuM+HbJMpkIkGD77Yyc2EOOTFPFgf/ynGa7TAT6eDH9K/g5bFX8LatsQ7g9qWh/NR/iP7SAlaTkJokGslZx5JFXPDprNrwF/b7Jni6vOH0Zs/cgLqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707480403; c=relaxed/simple;
	bh=TJ8XPREa5fooi39Kbtq0nhln3uQjJqP9rhCqY3fIHHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nMP2sEO6JAftZetWieVWS3zxOCynssKMBe36P9X6j9kOXuN+wRdwmBXW8nlbTKIQ7L4zRIrCyylsi3T2U5gtdN84YigBgoJuiEKre5HhCx2zJmfcqrsFakkHpkRI/fgntX9iarJGE7+EwSLQ3ch2k8W3jqf049qEyK5y7gaxioc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W5qL7k76; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707480399; x=1739016399;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TJ8XPREa5fooi39Kbtq0nhln3uQjJqP9rhCqY3fIHHI=;
  b=W5qL7k76/Ddf8A5F6+puSIW4JpwDCxwub9E8G/3G4XxuiAWwN1tuiE6+
   EhjueS6+2S0AKFy+gItgdxHPjDZ9Q4/Ovwtw/7G//fSaPFncnZowsHq4k
   m6RexbF6cRSwnYGDiXpEPBFLOdZtr3Mw0ZNfzXEzC1tQ5JiYPjUN/arwK
   IyFUZ/ConETXNBDqCQhr7X+HUpFr+PB3Xxr2dYPRyau4dCUV061i0KMlg
   KAc6JTZq2Fc9KFA1QgjiV6ybpZ6MM2EfUoCzZITmHSnnFym0YGpbCjFex
   AKp+UHisswVfyx+gMWDIupaObKRGzIpuV6y7GCdhmq8/hya5xZnOqXQmH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="12065004"
X-IronPort-AV: E=Sophos;i="6.05,256,1701158400"; 
   d="scan'208";a="12065004"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 04:06:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,256,1701158400"; 
   d="scan'208";a="2224700"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.43.96])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 04:06:33 -0800
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
Subject: [PATCH v3 1/3] genetlink: Add per family bind/unbind callbacks
Date: Fri,  9 Feb 2024 13:06:23 +0100
Message-Id: <20240209120625.1775017-2-stanislaw.gruszka@linux.intel.com>
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

Add genetlink family bind()/unbind() callbacks when adding/removing
multicast group to/from netlink client socket via setsockopt() or
bind() syscall.

They can be used to track if consumers of netlink multicast messages
emerge or disappear. Thus, a client implementing callbacks, can now
send events only when there are active consumers, preventing unnecessary
work when none exist.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
---
 include/net/genetlink.h |  4 ++++
 net/netlink/genetlink.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index e61469129402..ecadba836ae5 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -41,6 +41,8 @@ struct genl_info;
  *	do additional, common, filtering and return an error
  * @post_doit: called after an operation's doit callback, it may
  *	undo operations done by pre_doit, for example release locks
+ * @bind: called when family multicast group is added to a netlink socket
+ * @unbind: called when family multicast group is removed from a netlink socket
  * @module: pointer to the owning module (set to THIS_MODULE)
  * @mcgrps: multicast groups used by this family
  * @n_mcgrps: number of multicast groups
@@ -84,6 +86,8 @@ struct genl_family {
 	void			(*post_doit)(const struct genl_split_ops *ops,
 					     struct sk_buff *skb,
 					     struct genl_info *info);
+	int			(*bind)(int mcgrp);
+	void			(*unbind)(int mcgrp);
 	const struct genl_ops *	ops;
 	const struct genl_small_ops *small_ops;
 	const struct genl_split_ops *split_ops;
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 8c7af02f8454..50ec599a5cff 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1836,6 +1836,9 @@ static int genl_bind(struct net *net, int group)
 		    !ns_capable(net->user_ns, CAP_SYS_ADMIN))
 			ret = -EPERM;
 
+		if (family->bind)
+			family->bind(i);
+
 		break;
 	}
 
@@ -1843,12 +1846,39 @@ static int genl_bind(struct net *net, int group)
 	return ret;
 }
 
+static void genl_unbind(struct net *net, int group)
+{
+	const struct genl_family *family;
+	unsigned int id;
+
+	down_read(&cb_lock);
+
+	idr_for_each_entry(&genl_fam_idr, family, id) {
+		int i;
+
+		if (family->n_mcgrps == 0)
+			continue;
+
+		i = group - family->mcgrp_offset;
+		if (i < 0 || i >= family->n_mcgrps)
+			continue;
+
+		if (family->unbind)
+			family->unbind(i);
+
+		break;
+	}
+
+	up_read(&cb_lock);
+}
+
 static int __net_init genl_pernet_init(struct net *net)
 {
 	struct netlink_kernel_cfg cfg = {
 		.input		= genl_rcv,
 		.flags		= NL_CFG_F_NONROOT_RECV,
 		.bind		= genl_bind,
+		.unbind		= genl_unbind,
 		.release	= genl_release,
 	};
 
-- 
2.34.1


