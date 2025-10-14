Return-Path: <linux-pm+bounces-36024-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECC5BD6DDB
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 02:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0084334FD62
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 00:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05571DED5F;
	Tue, 14 Oct 2025 00:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="N/bFgZtp"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224B81DB54C;
	Tue, 14 Oct 2025 00:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760400730; cv=none; b=pS3ayfdlmO1LWyjv1o4Rn3BaKH5EDz1tZOChT7ZI9fOYQAK7UGM75HcJ/wemNGJWVd21MEt9iU1JLuz7F8Iq5rE2pfe+aVwpr2JPSqgKu/jsxzTYPQ+3va6vkf35838R3hPWvJME8J6Lhy6qqA9e0+LqOJpx5MinnQ/75yqrQIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760400730; c=relaxed/simple;
	bh=/16L3h3rPcUia/KBdLLqDT3dFEA2tNiKZtoA+scMIE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EiGkforxyI6W/JA0ljX3W+SeeK+dCnLjIRk8PF3Fhtr2ZEnD7ZlHu6JHJbR9qmohNrBmjQy3K+WGZnU+nXYbdD06kL/Ik/C5R5Jn5vEGO1VRbCQWEeLIeewz4m/ATF1AlRWdBK7USVKpFbljC6q1sBpNtArXNwOfE0xFQz/aI3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=N/bFgZtp; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=k2PC+Jj1kTBOAx0B4bO5XOI3bA9NYDYZCPNoelOj53M=; b=N/bFgZtphU9PHGFre2zIMXcNH3
	kH+xSuzFfGL/B0CUJkem4YA5jpxM6vrB3krA8DbncfhzjWSvuEoMeuBeJDWDBHfqT84a5tSDJPVFx
	us8ed43Fh22gUG2Cdv78vjf9jXqNosBkUzyqi7cREAwIDZ0m8+UeDWRLq3Zhx34cwSQ/UiGVQ9PIF
	xKUy8+m5ENrSPMCFOwhwMycX0Q+EInhB0rF5npFDK90CJ2OVG3gtVVlM/UQgEf3cIeYz9m9nwYCZb
	9Q9VRaHp4IKWXYL3hfoJjhm6xIRqvETIfw2C/e+oXuTH6Fa1Cy9vfQjR48VT4KXEOEQFUUwjDDiWW
	BCgAnFpg==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v8Se2-009A2z-24; Tue, 14 Oct 2025 02:12:03 +0200
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
Subject: [PATCH v5 09/10] PM: EM: Implement em_notify_pd_created/updated()
Date: Tue, 14 Oct 2025 09:10:54 +0900
Message-ID: <20251014001055.772422-10-changwoo@igalia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014001055.772422-1-changwoo@igalia.com>
References: <20251014001055.772422-1-changwoo@igalia.com>
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
 kernel/power/em_netlink.c | 44 +++++++++++++++++++++++++++++++++++++++
 kernel/power/em_netlink.h |  6 ++++++
 2 files changed, 50 insertions(+)

diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
index 90ae6f1c9c9a..2c55c758de6b 100644
--- a/kernel/power/em_netlink.c
+++ b/kernel/power/em_netlink.c
@@ -215,6 +215,50 @@ int em_nl_get_pd_table_doit(struct sk_buff *skb, struct genl_info *info)
 
 
 /**************************** Event encoding *********************************/
+static void __em_notify_pd_table(const struct em_perf_domain *pd, int ntf_type)
+{
+	struct sk_buff *msg;
+	int msg_sz, ret = -EMSGSIZE;
+	void *hdr;
+
+	if (!genl_has_listeners(&em_nl_family, &init_net, EM_NLGRP_EVENT))
+		return;
+
+	msg_sz = __em_nl_get_pd_table_size(pd);
+
+	msg = genlmsg_new(msg_sz, GFP_KERNEL);
+	if (!msg)
+		return;
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
+	return;
+
+out_free_msg:
+	nlmsg_free(msg);
+	return;
+}
+
+void em_notify_pd_created(const struct em_perf_domain *pd)
+{
+	__em_notify_pd_table(pd, EM_CMD_PD_CREATED);
+}
+
+void em_notify_pd_updated(const struct em_perf_domain *pd)
+{
+	__em_notify_pd_table(pd, EM_CMD_PD_UPDATED);
+}
+
 static int __em_notify_pd_deleted_size(const struct em_perf_domain *pd)
 {
 	int id_sz = nla_total_size(sizeof(u32)); /* EM_A_PD_TABLE_PD_ID */
diff --git a/kernel/power/em_netlink.h b/kernel/power/em_netlink.h
index d56e5865e1ed..583d7f1c3939 100644
--- a/kernel/power/em_netlink.h
+++ b/kernel/power/em_netlink.h
@@ -13,7 +13,9 @@
 int for_each_em_perf_domain(int (*cb)(struct em_perf_domain*, void *),
 			    void *data);
 struct em_perf_domain *em_perf_domain_get_by_id(int id);
+void em_notify_pd_created(const struct em_perf_domain *pd);
 void em_notify_pd_deleted(const struct em_perf_domain *pd);
+void em_notify_pd_updated(const struct em_perf_domain *pd);
 #else
 static inline
 int for_each_em_perf_domain(int (*cb)(struct em_perf_domain*, void *),
@@ -27,7 +29,11 @@ struct em_perf_domain *em_perf_domain_get_by_id(int id)
 	return NULL;
 }
 
+static inline void em_notify_pd_created(const struct em_perf_domain *pd) {}
+
 static inline void em_notify_pd_deleted(const struct em_perf_domain *pd) {}
+
+static inline void em_notify_pd_updated(const struct em_perf_domain *pd) {}
 #endif
 
 #endif /* _EM_NETLINK_H */
-- 
2.51.0


