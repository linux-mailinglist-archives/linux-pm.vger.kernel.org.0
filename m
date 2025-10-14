Return-Path: <linux-pm+bounces-36021-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BD3BD6D92
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 02:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71B018A6DC8
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 00:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CD513D503;
	Tue, 14 Oct 2025 00:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="b/QEKTjx"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9466E2E63C;
	Tue, 14 Oct 2025 00:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760400711; cv=none; b=X+qStaHodTUjxLesn4fkE+M5V8otXw3eSOdi2JHeBRhq8BPhWbgqlPx8ockxvjRXHUOC5vVe27PP/XRb02dFnBhSC7IV+bs87TmtSq2rIp8C0LMSkDhZmEwQ+Zl7zGhgHe/p3ZSyE9aVGwJmSGvoNXQTWNZlDHF2GQ+gXkIa0+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760400711; c=relaxed/simple;
	bh=XUV4wmTBsIzd42W2BwVmtZRZ9e30c95ouxD1hmQOu4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Se53AdeNJqItFFkPgI8ztpyi7rUHUIawGgjPZPhAvfSpscKLhHpFBIO11Eahb7kybr6QOrXoefmdAoGEqGr25q4Vg11/FlAvApvp3NBjaLx+L04iAQd4vjiMq6HIeu43SpTma8v2jhq6geoCsCMjUYykdxS/ccdK8hWAIrNUUYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=b/QEKTjx; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Z3QqZYj8x3M5weQ58upVJvB8rBfrK+5sn5Z3iFMUmg4=; b=b/QEKTjx20XMXw83BaCJLpBBfJ
	hq4mPjpyuCh3sfDlkRkzQjoLx6kV0DkeB+C8xPjmtU66EjU9ZNHcPHIZ+l4gCfV2zeBLjHYU23UxM
	W3oZFsanRVDxg/kJBkzzJpS1+koeqn9M9XzR7V4OvGLZ7T7+4NJXLzYn0IECpd20XNJoIImZRFtri
	g1HHkAN9fzVJikbLkrlFhXN0Vzc5JrBolvxBZx2ORdDH4+r937Zy8e77oPv/eMlkY5EhFIwyqWgBK
	NsBUyUrVbi2k3THynO9NLLQcZGaWN3T4iiYqmMqPYloIZXiXA0E/WwV7S8TjpqnGZwdgcli9jMEwB
	mn1Y72RQ==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v8Sdi-009A1t-Ko; Tue, 14 Oct 2025 02:11:43 +0200
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
Subject: [PATCH v5 06/10] PM: EM: Implement em_nl_get_pds_doit()
Date: Tue, 14 Oct 2025 09:10:51 +0900
Message-ID: <20251014001055.772422-7-changwoo@igalia.com>
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

When a userspace requests EM_CMD_GET_PDS, the kernel responds with
information on all performance domains. The message format of the
response is as follows:

EM_A_PDS_PD (NLA_NESTED)*
    EM_A_PD_PD_ID (NLA_U32)
    EM_A_PD_FLAGS (NLA_U64)
    EM_A_PD_CPUS (NLA_STRING)

where EM_A_PDS_PD can be repeated as many times as there are performance
domains, and EM_A_PD_CPUS is a hexadecimal string representing a CPU
bitmask.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/em_netlink.c | 82 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 81 insertions(+), 1 deletion(-)

diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
index f3fbfeff29a4..31b27c6fe3c9 100644
--- a/kernel/power/em_netlink.c
+++ b/kernel/power/em_netlink.c
@@ -17,9 +17,89 @@
 #include "em_netlink.h"
 #include "em_netlink_autogen.h"
 
+#define EM_A_PD_CPUS_LEN		256
+
+/*************************** Command encoding ********************************/
+static int __em_nl_get_pd_size(struct em_perf_domain *pd, void *data)
+{
+	char cpus_buf[EM_A_PD_CPUS_LEN];
+	int *tot_msg_sz = data;
+	int msg_sz, cpus_sz;
+
+	cpus_sz = snprintf(cpus_buf, sizeof(cpus_buf), "%*pb",
+			   cpumask_pr_args(to_cpumask(pd->cpus)));
+
+	msg_sz = nla_total_size(0) +			/* EM_A_PDS_PD */
+		 nla_total_size(sizeof(u32)) +		/* EM_A_PD_PD_ID */
+		 nla_total_size_64bit(sizeof(u64)) +	/* EM_A_PD_FLAGS */
+		 nla_total_size(cpus_sz);		/* EM_A_PD_CPUS */
+
+	*tot_msg_sz += nlmsg_total_size(genlmsg_msg_size(msg_sz));
+	return 0;
+}
+
+static int __em_nl_get_pd(struct em_perf_domain *pd, void *data)
+{
+	char cpus_buf[EM_A_PD_CPUS_LEN];
+	struct sk_buff *msg = data;
+	struct nlattr *entry;
+
+	entry = nla_nest_start(msg, EM_A_PDS_PD);
+	if (!entry)
+		goto out_cancel_nest;
+
+	if (nla_put_u32(msg, EM_A_PD_PD_ID, pd->id))
+		goto out_cancel_nest;
+
+	if (nla_put_u64_64bit(msg, EM_A_PD_FLAGS, pd->flags, EM_A_PD_PAD))
+		goto out_cancel_nest;
+
+	snprintf(cpus_buf, sizeof(cpus_buf), "%*pb",
+		 cpumask_pr_args(to_cpumask(pd->cpus)));
+	if (nla_put_string(msg, EM_A_PD_CPUS, cpus_buf))
+		goto out_cancel_nest;
+
+	nla_nest_end(msg, entry);
+
+	return 0;
+
+out_cancel_nest:
+	nla_nest_cancel(msg, entry);
+
+	return -EMSGSIZE;
+}
+
 int em_nl_get_pds_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct sk_buff *msg;
+	void *hdr;
+	int cmd = info->genlhdr->cmd;
+	int ret = -EMSGSIZE, msg_sz = 0;
+
+	for_each_em_perf_domain(__em_nl_get_pd_size, &msg_sz);
+
+	msg = genlmsg_new(msg_sz, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_put_reply(msg, info, &em_nl_family, 0, cmd);
+	if (!hdr)
+		goto out_free_msg;
+
+	ret = for_each_em_perf_domain(__em_nl_get_pd, msg);
+	if (ret)
+		goto out_cancel_msg;
+
+	genlmsg_end(msg, hdr);
+
+	return genlmsg_reply(msg, info);
+
+out_cancel_msg:
+	genlmsg_cancel(msg, hdr);
+out_free_msg:
+	nlmsg_free(msg);
+
+	return ret;
 }
 
 int em_nl_get_pd_table_doit(struct sk_buff *skb, struct genl_info *info)
-- 
2.51.0


