Return-Path: <linux-pm+bounces-28647-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB112AD8853
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 11:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0876B3AED99
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 09:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499C42D8767;
	Fri, 13 Jun 2025 09:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ZIXgdUmt"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5C82D662B;
	Fri, 13 Jun 2025 09:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749807929; cv=none; b=Er/wfuF/1ngCX7rlE8Zmy0J7NDt9N8yi8reUwzcFZq/z+311SQtNW3limeTWtGyGZZVJRR1HROxzJBi+0Xlqc03vExrYyKimj50kQpsVUuzmYFRFN5F3OnniyczKj2cLyYUnoRwZeYLoIj8CrR4rQSNjTj2yNdDJfzkEFXba7uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749807929; c=relaxed/simple;
	bh=CqN/Qf8e2l9r//Sny9CQ0hyEa0CppQf8VAqiYlI4G4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9GkK/+BFuJqUIfunoDFdd9p4G40JaMolqt/6z448Y4muEMT2qbw659/DXWgxSgFg3lkZROuI0XPAlqndCw+MhEUmC+rOlCM2u8eCEMkoZAiOler742twM0O3q+hIdaImgH4xP83GJF7vbkoXBYmZXsfvh/dYLIf/JB8SSf7jAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ZIXgdUmt; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=mks+65N2F057+f+zQWjwi4hlOABnU3KqPspxFC++ges=; b=ZIXgdUmtQ4IktBVe3dwzoDOGli
	P6E7YOQaqpl8UiSFAvmjylBxISp2vTefGLYf6PnWyjpUHtvqQWkgvZ+VCFuBjmQQaK+H5Iw4hb/+C
	pK+4eUZ3Zqk0dbrYyqFrEqtBKyUKLDHwYr7dRGd23+D9B9YLzsPR53EP2W6HPYzgCcaK3/L7Vp/oE
	SLRBL62tmuiQVayxSjtX6n0Kfc74hfU7zpUacYSTYU/PKeOyIayBdgLW8+EgRjwNBJjJmn19YoYn7
	VCiiFb9jqhUmuitpVH+JLR4gbqljdHIFlFplukdH977X/sfCoE+5ZCuubBWE3EIjuFHyTemLVB1/y
	D0k+MGVw==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uQ0yO-002xf3-1l; Fri, 13 Jun 2025 11:45:21 +0200
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
Subject: [PATCH v2 08/10] PM: EM: Implement em_notify_pd_deleted().
Date: Fri, 13 Jun 2025 18:44:26 +0900
Message-ID: <20250613094428.267791-9-changwoo@igalia.com>
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

Add the event notification infrastructure and implement the event
notification for when a performance domain is deleted (EM_CMD_PD_DELETED).

The event contains the ID of the performance domain (EM_A_PD_TABLE_PD_ID)
so the userspace can identify the changed performance domain for further
processing.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/power/em_netlink.c | 56 +++++++++++++++++++++++++++++++++++++++
 kernel/power/em_netlink.h | 18 +++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
index 981bbf1f9a2f..4e34799fd1f8 100644
--- a/kernel/power/em_netlink.c
+++ b/kernel/power/em_netlink.c
@@ -213,6 +213,62 @@ int em_nl_get_pd_table_doit(struct sk_buff *skb, struct genl_info *info)
 	return -EMSGSIZE;
 }
 
+
+/**************************** Event encoding *********************************/
+int em_notify_pd_created(const struct em_perf_domain *pd)
+{
+	return -EOPNOTSUPP;
+}
+
+int em_notify_pd_updated(const struct em_perf_domain *pd)
+{
+	return -EOPNOTSUPP;
+}
+
+static int __em_notify_pd_deleted_size(const struct em_perf_domain *pd)
+{
+	int id_sz = nla_total_size(sizeof(u32)); /* EM_A_PD_TABLE_PD_ID */
+
+	return nlmsg_total_size(genlmsg_msg_size(id_sz));
+}
+
+int em_notify_pd_deleted(const struct em_perf_domain *pd)
+{
+	struct sk_buff *msg;
+	int ret = -EMSGSIZE;
+	void *hdr;
+	int msg_sz;
+
+	if (!genl_has_listeners(&em_nl_family, &init_net, EM_NLGRP_EVENT))
+		return 0;
+
+	msg_sz = __em_notify_pd_deleted_size(pd);
+
+	msg = genlmsg_new(msg_sz, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_put(msg, 0, 0, &em_nl_family, 0, EM_CMD_PD_DELETED);
+	if (!hdr)
+		goto out_free_msg;
+
+	if (nla_put_u32(msg, EM_A_PD_TABLE_PD_ID, pd->id)) {
+		ret = -EMSGSIZE;
+		goto out_free_msg;
+	}
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
+/**************************** Initialization *********************************/
 static int __init em_netlink_init(void)
 {
 	return genl_register_family(&em_nl_family);
diff --git a/kernel/power/em_netlink.h b/kernel/power/em_netlink.h
index acd186c92d6b..938c84ca1f40 100644
--- a/kernel/power/em_netlink.h
+++ b/kernel/power/em_netlink.h
@@ -10,7 +10,25 @@
 #define _EM_NETLINK_H
 
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_NET)
+int em_notify_pd_created(const struct em_perf_domain *pd);
+int em_notify_pd_deleted(const struct em_perf_domain *pd);
+int em_notify_pd_updated(const struct em_perf_domain *pd);
+
 #else
+static inline int em_notify_pd_created(const struct em_perf_domain *pd)
+{
+	return 0;
+}
+
+static inline int em_notify_pd_deleted(const struct em_perf_domain *pd)
+{
+	return 0;
+}
+
+static inline int em_notify_pd_updated(const struct em_perf_domain *pd)
+{
+	return 0;
+}
 #endif
 
 #endif /* _EM_NETLINK_H */
-- 
2.49.0


