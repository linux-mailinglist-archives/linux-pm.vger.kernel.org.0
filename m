Return-Path: <linux-pm+bounces-30660-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6FFB01076
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 02:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F491C243D2
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 00:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFC913B590;
	Fri, 11 Jul 2025 00:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="CtyWLN2g"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC83919DF5F;
	Fri, 11 Jul 2025 00:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752195258; cv=none; b=mqXpsBpbweHMQ24lqWqLbm5CSUAmARNFJF4wkXCIvuAB/43wFzA8oH5YF/rvrLBeFYLSm0Mz58qPJjl+H4WQqN0bdiDpXeUzxxn9pOvm6WAMkwcF0wvQkvtE+ZvQlbyMMCSgmdsgJCww65UNloTQMNInxvPgJ3KsxIN4i662sY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752195258; c=relaxed/simple;
	bh=7Js4D9luViSOnl7yqUbC5Zq6n1b6VggPul/4nId5ZxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SvN3etUj3wQRsdBpnK0hMTUpWtyo0vnyRuaaWJvP81sYXfej/BSnvR6u+8KL9I5tC/jmTeE6iICwkMCKGo3vvIQGpVuijh1UYY0lvSONHn0EWp4NNdxOKjHY3rwgx7vn66z3rsGW68bagPnp7BaTBOwfl9ayeWBAZ8dWqcwxtZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=CtyWLN2g; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=BfNhjyz2JMtll9iGsUO7uQWzfu5EovsXmIYde8nZ3xs=; b=CtyWLN2g13jEHbzdoMdxwp1HP4
	bligWl3mYjV5m5UFXrXzGh02UyClGmS4qfSUsvyhTRAbh27YepWKo6mxgSXHt7nLKa1dHWVE8y5qj
	nBMzbGT7PABjzNqCNxzajY7sqxUvFjuEwijKg+WVWoPB+meg8jrDyXfxxsHsZ1gO8jlq+BrehYEJx
	0mU2DY9DKjUtwG3joiycWvvPM3fFIbKH6d2m6QB6j2kDMERPP6D6GZDz1slFj3c/RewKou9+ZGDXE
	agIamK03w07oRud0dF63F5q1uIU538Af29mcWzvamBdgI/qcqO4UU74qRT7lm99uHV3Yo8DS2Sx7y
	8F3cUNaA==;
Received: from [59.10.240.225] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ua21h-00FAoO-SD; Fri, 11 Jul 2025 02:54:11 +0200
From: Changwoo Min <changwoo@igalia.com>
To: lukasz.luba@arm.com,
	rafael@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org
Cc: christian.loehle@arm.com,
	tj@kernel.org,
	kernel-dev@igalia.com,
	linux-pm@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH v3 09/10] PM: EM: Implement em_notify_pd_created/updated().
Date: Fri, 11 Jul 2025 09:53:09 +0900
Message-ID: <20250711005310.20740-10-changwoo@igalia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250711005310.20740-1-changwoo@igalia.com>
References: <20250711005310.20740-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement two event notifications when a performance domain is created
(EM_CMD_PD_CREATED) and updated (EM_CMD_PD_UPDATED). The message format
of these two event notifications is the same as EM_CMD_GET_PD_TABLE --
containing the performance domain's ID and its energy model table.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/power/em_netlink.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
index b9a2d1a538e7..f133b3170fe1 100644
--- a/kernel/power/em_netlink.c
+++ b/kernel/power/em_netlink.c
@@ -215,14 +215,48 @@ int em_nl_get_pd_table_doit(struct sk_buff *skb, struct genl_info *info)
 
 
 /**************************** Event encoding *********************************/
+static int __em_notify_pd_table(const struct em_perf_domain *pd, int ntf_type)
+{
+	struct sk_buff *msg;
+	int msg_sz, ret = -EMSGSIZE;
+	void *hdr;
+
+	if (!genl_has_listeners(&em_nl_family, &init_net, EM_NLGRP_EVENT))
+		return 0;
+
+	msg_sz = __em_nl_get_pd_table_size(pd);
+
+	msg = genlmsg_new(msg_sz, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_put(msg, 0, 0, &em_nl_family, 0, ntf_type);
+	if (!hdr)
+		goto out_free_msg;
+
+	ret = __em_nl_get_pd_table(msg, pd);
+	if (ret)
+		goto out_free_msg;
+
+	genlmsg_end(msg, hdr);
+
+	genlmsg_multicast(&em_nl_family, msg, 0, EM_NLGRP_EVENT, GFP_KERNEL);
+
+	return 0;
+
+out_free_msg:
+	nlmsg_free(msg);
+	return ret;
+}
+
 int em_notify_pd_created(const struct em_perf_domain *pd)
 {
-	return -EOPNOTSUPP;
+	return __em_notify_pd_table(pd, EM_CMD_PD_CREATED);
 }
 
 int em_notify_pd_updated(const struct em_perf_domain *pd)
 {
-	return -EOPNOTSUPP;
+	return __em_notify_pd_table(pd, EM_CMD_PD_UPDATED);
 }
 
 static int __em_notify_pd_deleted_size(const struct em_perf_domain *pd)
-- 
2.50.0


