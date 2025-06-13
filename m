Return-Path: <linux-pm+bounces-28648-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D75AD8851
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 11:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C97D71E3208
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 09:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38462D2382;
	Fri, 13 Jun 2025 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="nBTdM5Aj"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C802D2380;
	Fri, 13 Jun 2025 09:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749807934; cv=none; b=Zxdb50HwOXQ+MZkN445eYm5A28nh/otgkwCpXz3JzyJRp4B4N/1G80US5gI72Bj9DO7PCXLzQfXhJoyDtr3z5iODMJUCTkfzQ3GmSEu7L5BrpXaj0AMTYMkhCuxeSWbP35k7RlA2sglm8gAoHpoFPAqTPufTHgFYvaEDBoz3BWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749807934; c=relaxed/simple;
	bh=vAKsyCspG8k8udPYGoB1XYGveWuf+Ep6ooFyi7c4f5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVJDQ5HlS5LiNHX4irRp800v89FyjkEOHbDtjHw7IM4ohxGVw6WWfIEHPsH/rvIKqcCnj2Cjhz/2trq0DIxjBEnqklksrzsRm+fAgA/+QHiDQaE3T3NeJSGrU063OBvuHSKrrgwWtJl+dQNRQbSlHZJJR05RiHZOg3lukNGLdZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=nBTdM5Aj; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Wen9AkqmFZV2LJKf63UmyrtgMUsT3rWAuQ+Twr5vmA0=; b=nBTdM5AjSL0/jxbmxvaIP2xgX3
	Egma//eS1PxWm1sFCV5AOsFUOgMEb0lbC7j0pYhJL8sJORcSBFgYE/TXXF0tgzrKIj4BUEd4Uhjjs
	9Y+wHqIGhTCPo9j8BRzkcGEKuwauLoR8YhslD3Er33D/BBd6gcxBQim+14FbXWJ1lApALC6UfqWNK
	CitODjMus1BLxzrJ3uuo8mlCHqmTOinTlOBnTxLTe6IN4Gr/rLq/8PhJ4h0JRSQtmCfath3QsVpor
	XESOGF0bfuW9Gx0wLP2LVJTi9oHwVtllVqZAxJte8SbwP3qjbsE7QJuFy2X8wf3Hg2UlIJA0sx054
	2n7p0YCg==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uQ0yT-002xfI-Iz; Fri, 13 Jun 2025 11:45:26 +0200
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
Subject: [PATCH v2 09/10] PM: EM: Implement em_notify_pd_created/updated().
Date: Fri, 13 Jun 2025 18:44:27 +0900
Message-ID: <20250613094428.267791-10-changwoo@igalia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613094428.267791-1-changwoo@igalia.com>
References: <20250613094428.267791-1-changwoo@igalia.com>
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
index 4e34799fd1f8..d42da92d1af4 100644
--- a/kernel/power/em_netlink.c
+++ b/kernel/power/em_netlink.c
@@ -215,14 +215,48 @@ int em_nl_get_pd_table_doit(struct sk_buff *skb, struct genl_info *info)
 
 
 /**************************** Event encoding *********************************/
+static int __em_notify_pd_table(const struct em_perf_domain *pd, int ntf_type)
+{
+	struct sk_buff *msg;
+	int msg_sz, ret;
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
2.49.0


