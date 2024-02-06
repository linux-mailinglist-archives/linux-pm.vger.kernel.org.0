Return-Path: <linux-pm+bounces-3479-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BCB84B689
	for <lists+linux-pm@lfdr.de>; Tue,  6 Feb 2024 14:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23B2B1F24DC0
	for <lists+linux-pm@lfdr.de>; Tue,  6 Feb 2024 13:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A76131728;
	Tue,  6 Feb 2024 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ue8qPz4k"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59F713173C;
	Tue,  6 Feb 2024 13:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707226580; cv=none; b=H+FaqGLoWEuwTgZJ1U2lMCaT6fcttFO8kKXtkizV7i02VM7jw2FB/OehD/RsKWbva2jOtsAQS/ll3d5vdcA7fsH9YmbMGrPAdXYTXLxJrLO0laE/1jbokDM0OPINUEX+Tx0NpKeET5EAGMfeskZg9r/zs97wvUfUahb2T4SED7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707226580; c=relaxed/simple;
	bh=QjZXjVU5zeGYyC6/h1CagiovDvB8NikvVqpoMa/P8QU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jySj9SEngEdVd/k/nO2SFdaybN2gg3Htohkfa50yK7shgKYYcHwNwn+lQ/OD4MSBgVVgqPjcegjAHp7KpFywDMPfIet1DDZ/rHFN3T2wF9zl5Ax5z6SJ1OYsiTm5J9DgGO3+A0LoWOJ3+RDcrufkKn3NWbkFfmbUPAO7o116Plg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ue8qPz4k; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707226579; x=1738762579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QjZXjVU5zeGYyC6/h1CagiovDvB8NikvVqpoMa/P8QU=;
  b=Ue8qPz4kNKl4HDRI7WjsJ7fUdfX7XeHfMwJqKNOn23XutnZcyWnwwKmB
   CN+eORJUM5hLgGlj9xgLds10TFyJt1oS9n9JHqHwGJ5VwCTrMx+HeOAaI
   vxt04Isk3AmMqIHJjWfYfHGdJFz4FqYC9m13gkFOmWYhuKlwiUrm7tlEL
   PvxDngeUqnBLRkWp6D6oRxWFkYvcm2p/Z5IEl/puY62g/AFqfezPCjZE4
   3PpO8gKS6goMxA3YV1OSpQ5w1QCLGGWhzYQfmulU1Y4JBB7KYgYEX/7t6
   PbR+fdWi4hySngQyn/Z4oVL/+C/loljg2W4IjoLRoEcFTTe5UpyNinFPv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="1014386"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="1014386"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 05:36:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="909636858"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="909636858"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.60.196])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 05:36:14 -0800
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
Subject: [PATCH v2 1/3] genetlink: Add per family bind/unbind callbacks
Date: Tue,  6 Feb 2024 14:36:03 +0100
Message-Id: <20240206133605.1518373-2-stanislaw.gruszka@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206133605.1518373-1-stanislaw.gruszka@linux.intel.com>
References: <20240206133605.1518373-1-stanislaw.gruszka@linux.intel.com>
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
 net/netlink/genetlink.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

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
index 8c7af02f8454..0d1551dadb63 100644
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
 
@@ -1843,12 +1846,42 @@ static int genl_bind(struct net *net, int group)
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
+		const struct genl_multicast_group *grp;
+		int i;
+
+		if (family->n_mcgrps == 0)
+			continue;
+
+		i = group - family->mcgrp_offset;
+		if (i < 0 || i >= family->n_mcgrps)
+			continue;
+
+		grp = &family->mcgrps[i];
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


