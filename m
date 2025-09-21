Return-Path: <linux-pm+bounces-35110-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 769E4B8D444
	for <lists+linux-pm@lfdr.de>; Sun, 21 Sep 2025 05:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 755D618A20AD
	for <lists+linux-pm@lfdr.de>; Sun, 21 Sep 2025 03:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E572676E6;
	Sun, 21 Sep 2025 03:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="mSfbdzmH"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF70242D91;
	Sun, 21 Sep 2025 03:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758424833; cv=none; b=els2zHRojpnFdInQ/CqMSxzcMfD0SN+C7ZhLJzhI0Q9WQJ60q5cpsYqp+emM5hM7pZnjU0GqTrZ/UAyZ/yXNuzp2nOORPPxj39ox8/ivTUYpXs3yCfII6FSLGzbYg2SnvzoSuf+3Ev8R9y0KN5ssTG/OAvnCmDLvYZk4fLgMPnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758424833; c=relaxed/simple;
	bh=0S+IcH+DOywjFMM8Qmh8T7Oe3P86Lks3htSrMJA2Ums=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGSHUoQtz8mx3PwaoS/K/meQJHrGgjyVeakCuhW4/DK4D9lREnLV0hsGxF2F7R7dzLBuQRyJGYTzTFIwUnG6eNlDxnVK2HnrGRCU2jtAViN9LNRbcJEb2ewmsiGzEroK40JcEyvrYiY+WfWSvwjwVYqURxI+Eh+t80H7B5OPHt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=mSfbdzmH; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5hWjRQ4uHs+TIl+F6dv0p+5QABRD/gqhJJCYS4oKpSQ=; b=mSfbdzmHSwzei2lCR8ut7ZzD3w
	Fi3ISWFWoPEC0pGkhMu6xYJy2J6pPLuTRJwybg2pJFMN7dYkDFv3zKTqyt9pecEZuslS6qHBxPSG+
	TdAtfg0VVTT7MQTeneqAD4B69mhbDNC8E5XB4ktP/5yWnQjbToPEtf7SqjeJkh+oJXRYZiRGzi8ge
	ezECvlaKBUHNezlMG2rOtHdYQh5yWhgoOpTK/f6xaJWdLR43JLinXBax2SiXaG0w34CzwykOCceJr
	Ni/JU7TdqVBjhbUNBVvNQrHpk59K2/fkMSxoq3bZCrZGfOoqZPLMNZdIvkAZLIGA7IKjeVt1tobBl
	52wwNwpQ==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v0Ach-00EcjW-QV; Sun, 21 Sep 2025 05:20:25 +0200
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
Subject: [PATCH RESEND v4 09/10] PM: EM: Implement em_notify_pd_created/updated()
Date: Sun, 21 Sep 2025 12:19:27 +0900
Message-ID: <20250921031928.205869-10-changwoo@igalia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250921031928.205869-1-changwoo@igalia.com>
References: <20250921031928.205869-1-changwoo@igalia.com>
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
index ff6aa848d998..ff3eab078546 100644
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
2.51.0


