Return-Path: <linux-pm+bounces-33501-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AB5B3D67D
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 04:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BAD01789EA
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 02:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF1D2144C9;
	Mon,  1 Sep 2025 02:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="dvI3HbIj"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044322459D9;
	Mon,  1 Sep 2025 02:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756692063; cv=none; b=OQH5pOsK64EuZ1ZJFYkF/Do1zZr2dQ7ZtkQigdUFU2CeJVOyNZWoXnjLNrhfz74QpnqQAB+i/ygX6cVOcPY34hj/DC/a/Rl5hjNVYDehFZqgYrFC+0eIfwkeMnUYwzZUIkXtLU9lBmr8s263/8HxPW4nzHF96ObXHU0YmBQx2RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756692063; c=relaxed/simple;
	bh=KvOummY2bKQpR2xxdP6117iCBe1tIr1juyf2WSJug5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HN5M13fgfuQYAFgJWDANzikaLE1V4OhonUn6ztvWehoasqp3zU3ezCHbPSr4CWT3cYPngQK/km4MfxfifND+QE1MSxrzpSc1Zf2JTwgRbdeUfccslqWeRuzrUr30OYDjDzyR0JqKOYHhEQwC5uXwxBr+NYWnDJsFO+fmRN5zRfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=dvI3HbIj; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=1WXvdkFJ0S0JfYEwMNPSC8cw/ahSA4Cx3+jCWy0UJRI=; b=dvI3HbIjdu1IULLtHe/jAI5bmi
	Dx/ITK9p5s2jsDVzxNwTeh2jz1YZ31uwyLwDpeRRUtAtrORBryYLzKm5tlmwLDm910c4IgEZPrFd/
	LDSNTEtWWq1GJ637dIl3puLHbZYUosEwS5BK3mrtvManJRxmRrPenGq5HYBaJ0zbvUxhWDlkOCa46
	mRE4krguLaKla3rrrKTZlMtiqIlsCDFDowbHzHwjFGKkTneOqKiWa7nH7MMlhwQQe6tjXKCZMLDSf
	Dl0kVNQYARcPDhEsl83zqu9HZ628qBtY8bjCx9Mkq+aaI8huLxcMBxUjUQBMhKORUEetZeKUwM4WP
	NwCty8Cg==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ustqo-0054VC-Qf; Mon, 01 Sep 2025 04:00:56 +0200
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
Subject: [PATCH v4 08/10] PM: EM: Implement em_notify_pd_deleted()
Date: Mon,  1 Sep 2025 11:00:01 +0900
Message-ID: <20250901020003.86415-9-changwoo@igalia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901020003.86415-1-changwoo@igalia.com>
References: <20250901020003.86415-1-changwoo@igalia.com>
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
index 59953cfedf78..ff6aa848d998 100644
--- a/kernel/power/em_netlink.c
+++ b/kernel/power/em_netlink.c
@@ -213,6 +213,62 @@ int em_nl_get_pd_table_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
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
2.51.0


