Return-Path: <linux-pm+bounces-3066-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE65844029
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jan 2024 14:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3C551C21C61
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jan 2024 13:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CAF7BB0C;
	Wed, 31 Jan 2024 13:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iCGrseRB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF7F7BB06;
	Wed, 31 Jan 2024 13:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706592; cv=none; b=koAXf8qaci4j1qnOZTpo9kw6r5W3Kdqo32D670zMYO9iBSo7CYRx5OsOxMCKqbBSNc96SUG0Fs/U+ixVZTnlceGRkN6zSJffEk810woObph1EDa1cGHFISwoBXBkWQLi5OmRWDZbztZV9wmkAQTpU+B1zClXq+wZzYmdEP71HI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706592; c=relaxed/simple;
	bh=JX0N/7ypdkFlnA58ZmbSsHLuhJ9NA5OC0DOrMAeMuvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y+GwX8IzCPgy2yMm4PQsN/ZA273kE0Q+ym8+Qdu2B6iE2s+/jkUKaNLaARxMaz9CuIVZw0DFcZxyvDgM0qg+950U7ZFyo2bszwq/W4xwJWHZpv1TAC9AnK03D61VGg7w7LsmZs1EC+rNDLobfMbanaJlPXUYWNswhZqj7bjA/xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iCGrseRB; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706706590; x=1738242590;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JX0N/7ypdkFlnA58ZmbSsHLuhJ9NA5OC0DOrMAeMuvk=;
  b=iCGrseRBmbWSt/CD92xmR8reF2SlgdwmoqQrqa/KP9eUvxpBIwQinpR9
   nVvQPem3LD2b6GwjPKpAiEqCqw2CVWZfK6shHEdVv0sbmsiyPmIToHx2X
   Xkwjv8lW0eqm6mNASIfi3S4zWMA2mBo7jtb3KlwBuofsnPlFJnKh08BeT
   BYzvJMh28rAeFxma2LSSni3iuWgJX2wMuFi4NJ+xOuSX/KrAcjQCXJivT
   V3S+WxXFiemZuM0539IoQRcBhK2nPdWPJI1Ws4SxwI1frCFtAVd42uswb
   f6u9nwtjczIHb4SSyUb3aG/b1zXXVZGtDqjqgDtCWJHdRn+dftwhk+/8i
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="17126949"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="17126949"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 05:09:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="858816182"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="858816182"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.43.19])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 05:09:41 -0800
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
Subject: [PATCH 1/3] netlink: Add notifier when changing netlink socket membership
Date: Wed, 31 Jan 2024 13:05:33 +0100
Message-Id: <20240131120535.933424-2-stanislaw.gruszka@linux.intel.com>
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

Add notification when adding/removing multicast group to/from
client socket via setsockopt() syscall.

It can be used with conjunction with netlink_has_listeners() to check
if consumers of netlink multicast messages emerge or disappear.

A client can call netlink_register_notifier() to register a callback.
In the callback check for state NETLINK_CHANGE and NETLINK_URELEASE to
get notification for change in the netlink socket membership.

Thus, a client can now send events only when there are active consumers,
preventing unnecessary work when none exist.

Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
---
 include/linux/notifier.h | 1 +
 net/netlink/af_netlink.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/notifier.h b/include/linux/notifier.h
index 45702bdcbceb..8f5a5eed1e0e 100644
--- a/include/linux/notifier.h
+++ b/include/linux/notifier.h
@@ -227,6 +227,7 @@ static inline int notifier_to_errno(int ret)
 /* Virtual Terminal events are defined in include/linux/vt.h. */
 
 #define NETLINK_URELEASE	0x0001	/* Unicast netlink socket released */
+#define NETLINK_CHANGE		0x0002  /* Changed membership of netlink socket */
 
 /* Console keyboard events.
  * Note: KBD_KEYCODE is always sent before KBD_UNBOUND_KEYCODE, KBD_UNICODE and
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index eb086b06d60d..674af2cb0f12 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1680,6 +1680,11 @@ static int netlink_setsockopt(struct socket *sock, int level, int optname,
 	case NETLINK_ADD_MEMBERSHIP:
 	case NETLINK_DROP_MEMBERSHIP: {
 		int err;
+		struct netlink_notify n = {
+			.net = sock_net(sk),
+			.protocol = sk->sk_protocol,
+			.portid = nlk->portid,
+		};
 
 		if (!netlink_allowed(sock, NL_CFG_F_NONROOT_RECV))
 			return -EPERM;
@@ -1700,6 +1705,7 @@ static int netlink_setsockopt(struct socket *sock, int level, int optname,
 		if (optname == NETLINK_DROP_MEMBERSHIP && nlk->netlink_unbind)
 			nlk->netlink_unbind(sock_net(sk), val);
 
+		blocking_notifier_call_chain(&netlink_chain, NETLINK_CHANGE, &n);
 		break;
 	}
 	case NETLINK_BROADCAST_ERROR:
-- 
2.34.1


