Return-Path: <linux-pm+bounces-3804-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE9D8518C9
	for <lists+linux-pm@lfdr.de>; Mon, 12 Feb 2024 17:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A041F21591
	for <lists+linux-pm@lfdr.de>; Mon, 12 Feb 2024 16:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9D03D0DB;
	Mon, 12 Feb 2024 16:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eM6K60/P"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C123D0B6;
	Mon, 12 Feb 2024 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707754596; cv=none; b=Qzaksj99MLxyIx5rucTQDy8wdfig4uRuqydWBpWJeyFpg9LLn5OjkbR/rKwxzoLqTi3Ja9bKVwcG5DGNxdRNMxLGPPQhKL4159aMZ/39EHy9VakRjrMKkMxsBBP3bbfXzudbkH45kO6BUykY7GhVwRFyU7c+SkVmbcip+lo3XV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707754596; c=relaxed/simple;
	bh=TJ8XPREa5fooi39Kbtq0nhln3uQjJqP9rhCqY3fIHHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NV6Rz9n4EAONzQJ7aa7Mjyt+HTvXJl3pSoifjMrM1ThlrqT9DBI7DeemYFVFA3dVwwvAw16kU1qm2bW01fP+9zFhsjitRrzlJ21MLCR+BsnnvaPGDLZCVb5gpNyYOdoSYTX5wKgKecQtcFZm1XoWhp1nHJWZcPDLiBcVmqhm/z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eM6K60/P; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707754595; x=1739290595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TJ8XPREa5fooi39Kbtq0nhln3uQjJqP9rhCqY3fIHHI=;
  b=eM6K60/PG1sAlv71wNDZ6Q6jogtnxgXK0cU0lUUIvajH5Sk+IzmNmI+T
   siDxkXW0XvkqLS3gPk7L1zkm4zgkfeBnkeahVGUPCr02hFwihv9qqgGfA
   RAg7g4wwLX4D0swUAkYLSd7zcI34mkNZ0AxUlZiWT5xUSOcxy/ujrLcsL
   jRrwDvEYBkuxkwEciaaGb2K7RT1bqKydStMIxNbC4B5exAhFi7bFvN3Z6
   ljPBNvfJtSDCVdhwVF8+cJrVWNeZLyw9gxxdSdkxPSveADoj0SwLoTpZc
   j0bnHYZAwkhjpjVPSEdWltdufaeG6y4zS9hrvXOhK4UB3lCIsY2mJbk5V
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1873151"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="1873151"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 08:16:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="7258733"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.44.2])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 08:16:31 -0800
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
Subject: [PATCH v4 1/3] genetlink: Add per family bind/unbind callbacks
Date: Mon, 12 Feb 2024 17:16:13 +0100
Message-Id: <20240212161615.161935-2-stanislaw.gruszka@linux.intel.com>
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


