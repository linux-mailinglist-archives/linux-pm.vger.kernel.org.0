Return-Path: <linux-pm+bounces-35107-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C33B1B8D435
	for <lists+linux-pm@lfdr.de>; Sun, 21 Sep 2025 05:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B38A442C14
	for <lists+linux-pm@lfdr.de>; Sun, 21 Sep 2025 03:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9AD25BF1B;
	Sun, 21 Sep 2025 03:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="HTScwmjS"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC0123BCED;
	Sun, 21 Sep 2025 03:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758424817; cv=none; b=fT/4rBDMeOMrQlMnJMRGF1SA01P1/C1cNgzyNy+Q7f6EYoTmnakW+5uQ8XjkwLmf+tVmXDt2m4d+9mDlZVgwapxKaFWnFeEHBlbTl1Y8ztUBpuvR6VyXVJ2jzXBe4Z36tTbE3WOGJWdpGM0oS19OqOs7vzUmiam26M+orWM8hyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758424817; c=relaxed/simple;
	bh=h11SGtV5bb+zU+5RXvkBOpOEmZiHT6WNp4XydOTIj00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oW2zj/BoAzDiorJLyUBBdn9XaE6z1Ys5khwpxpTfe8b1qfG0p1TI65obKoxOWQBEC9SpPKGYi1tzeC35gcUt5V0pHU05d1JzzYn2bNvqHVG5TqExgN5CNCED+UxLyE1QXzFJDGaGCOTYmxD6kHI2kmBERSZFWNs1bEV6mvHXowY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=HTScwmjS; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=TIBfhTObXQDjnOaizlcq1EWJ8ASUl0ca19LxkyMR434=; b=HTScwmjScqf9kfqQ0a8/qVovZI
	aIgtVb/bD8noKgj4//ipaskxxItfKFibf3CF8S1cpMQaJtF54miWc8ii5EcO/QCUiI22DjUoiKM6M
	qfcGFFCNTMBhQlfZFH8CX9rQv5vLODiMjkchUTOaNjwG2xxM/iu5jYE3HNDyji0UueVELGVh6t4Ft
	9OPH+qKG5MITNnEteXnqFLcgv2goFsWrW3X6zLBuZu5iEfrpQ42A8SsfPu0I8mj6aAikrzn8iBY7B
	Yek34GJ9EeMkp6NQWe1vCaV3Xep4EoiHS7G3gN4xxAphF4trwYSDnKLVtRhk9AEY2yUO8WjXbwZi3
	kCQqDwew==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v0AcR-00Eciq-Nj; Sun, 21 Sep 2025 05:20:08 +0200
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
Subject: [PATCH RESEND v4 06/10] PM: EM: Implement em_nl_get_pds_doit()
Date: Sun, 21 Sep 2025 12:19:24 +0900
Message-ID: <20250921031928.205869-7-changwoo@igalia.com>
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


