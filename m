Return-Path: <linux-pm+bounces-36531-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 474A1BF3D72
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 00:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1465818C545F
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 22:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F5B2F069E;
	Mon, 20 Oct 2025 22:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="UW7dmHMa"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC371EDA3C;
	Mon, 20 Oct 2025 22:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760998235; cv=none; b=ky+ls3l3W/78wYKI460N8NHGksytSZ6PsPCEwOpd0wp5LGFrDU06RPBAGdHa82QRrsOvVPMrXVXeWt5yIGz2v3L7SvevpUtpXbcw90i9BuKqk4jrSauZv9BWYMHlrm/30eJXnGGCS1DMsViUgqVIL4jWTfG7cOm9QuwkGR00suM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760998235; c=relaxed/simple;
	bh=F/n+yVOEQ6Eii4Ql/sofa4W9UBYJMVjSWOj1xvldWkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkTMTeZDpRZkpl4DHQZLgCbc9ZVOJHg60Ns295iDKOWR16vMcq4Mz1bCtEH8CRD0KZeTSmF4zx6ybtQTplKYUv1bXLZXrjXeFRcvHh5rHmHmTzu/sxFmRbVmnJahXfhEqlmT7nqZQPSN9PluZyZoo+Wu9zXgDqdsihNBIkv+w/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=UW7dmHMa; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=mA7SQiSKYqIaEOVWZl8iC3UkXTHU0IBOg1L46TE7JKI=; b=UW7dmHMapPAqZMA/jRDEcsjr88
	XKbZKzJAtDYxSVkBtaKgwt3VG4tosJ6UaVjBaaYaeLZu9x9NrQCT2CIvkiBQ3aA5CLf8LexeIBnBn
	73c2DxKLXz8TiRUV2FQtYcLVCblBnEbYCPwxzzaxk7NaUDDQmXreVKGIfgfRCXll7NUYocznBPiIm
	wUY72/q5QDMd4qz9pu4c4qP4OMj2nqkVxeQb7fq5md5sI9maFLGVKmCxqrVOFHbk0gROwE/H15s6q
	b2Iwravc51SHOQrimYnOXzDuBRdH6ry/nskq4GWtESvQNy0DDG6hJfeMmpRxYb78UcTQulN3P0dtN
	BtbS/LXQ==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vAy5C-00CHaJ-VR; Tue, 21 Oct 2025 00:10:28 +0200
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
Subject: [PATCH v6 08/10] PM: EM: Implement em_notify_pd_deleted()
Date: Tue, 21 Oct 2025 07:09:12 +0900
Message-ID: <20251020220914.320832-9-changwoo@igalia.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251020220914.320832-1-changwoo@igalia.com>
References: <20251020220914.320832-1-changwoo@igalia.com>
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
 kernel/power/em_netlink.c | 44 +++++++++++++++++++++++++++++++++++++++
 kernel/power/em_netlink.h |  3 +++
 2 files changed, 47 insertions(+)

diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
index 2addc143401b..1595230bf9a0 100644
--- a/kernel/power/em_netlink.c
+++ b/kernel/power/em_netlink.c
@@ -213,6 +213,50 @@ int em_nl_get_pd_table_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+
+/**************************** Event encoding *********************************/
+static int __em_notify_pd_deleted_size(const struct em_perf_domain *pd)
+{
+	int id_sz = nla_total_size(sizeof(u32)); /* EM_A_PD_TABLE_PD_ID */
+
+	return nlmsg_total_size(genlmsg_msg_size(id_sz));
+}
+
+void em_notify_pd_deleted(const struct em_perf_domain *pd)
+{
+	struct sk_buff *msg;
+	void *hdr;
+	int msg_sz;
+
+	if (!genl_has_listeners(&em_nl_family, &init_net, EM_NLGRP_EVENT))
+		return;
+
+	msg_sz = __em_notify_pd_deleted_size(pd);
+
+	msg = genlmsg_new(msg_sz, GFP_KERNEL);
+	if (!msg)
+		return;
+
+	hdr = genlmsg_put(msg, 0, 0, &em_nl_family, 0, EM_CMD_PD_DELETED);
+	if (!hdr)
+		goto out_free_msg;
+
+	if (nla_put_u32(msg, EM_A_PD_TABLE_PD_ID, pd->id)) {
+		goto out_free_msg;
+	}
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
+/**************************** Initialization *********************************/
 static int __init em_netlink_init(void)
 {
 	return genl_register_family(&em_nl_family);
diff --git a/kernel/power/em_netlink.h b/kernel/power/em_netlink.h
index 8114b018c73b..d56e5865e1ed 100644
--- a/kernel/power/em_netlink.h
+++ b/kernel/power/em_netlink.h
@@ -13,6 +13,7 @@
 int for_each_em_perf_domain(int (*cb)(struct em_perf_domain*, void *),
 			    void *data);
 struct em_perf_domain *em_perf_domain_get_by_id(int id);
+void em_notify_pd_deleted(const struct em_perf_domain *pd);
 #else
 static inline
 int for_each_em_perf_domain(int (*cb)(struct em_perf_domain*, void *),
@@ -25,6 +26,8 @@ struct em_perf_domain *em_perf_domain_get_by_id(int id)
 {
 	return NULL;
 }
+
+static inline void em_notify_pd_deleted(const struct em_perf_domain *pd) {}
 #endif
 
 #endif /* _EM_NETLINK_H */
-- 
2.51.1.dirty


