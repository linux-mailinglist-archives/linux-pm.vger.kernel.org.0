Return-Path: <linux-pm+bounces-30658-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B59B01072
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 02:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C0311C22D65
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 00:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE87018BC3B;
	Fri, 11 Jul 2025 00:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="CkxaYK4D"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057CA22EF5;
	Fri, 11 Jul 2025 00:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752195247; cv=none; b=nYWXOMHOTQ98c9LMsvI7xR3p+AT5LgxLM4GMs2pXZIHNtYK+B1JrEzoCR9utT19KjSM49tYjNj09Rejx1nsgMCJrw0ysnfxRJxXzazMctXhIM4oOZBn/RC/m7bN9EC5W/AR/XQAgTr5uHS7Diteb4Tidzfvbysf0hmxY74jeWto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752195247; c=relaxed/simple;
	bh=AhwR42dayljc9bEkrbiQc0PjHUMwGewblKYbQfefg7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ReEhLmmf8WhmeCRNzDinOSXK3GMq68M+ptEGppgZhMFcN3rqIgpGHRs/XpsJwiFkLppMo9ZZos1uIHzfO/lcipHYAZRa/23goN1TGqCwu9CJ0WGFbX4rXaH5ytOzo3w9ay9qsCyvnMq7yiWuj1NJXdSHqvtyIfK8pecP4W6/n2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=CkxaYK4D; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=LqtVml4aE1q9zaYJU42nZ1ow/53bY4ktZWJuzFoJRLI=; b=CkxaYK4DDQcBjSw6hf1adCm+T4
	8v+uPadMuWEgI2bqMQgu27T8yMXdzcbZbom46IjDC/AXqEbDg63hns7CcoRh70LExNPt7TQxiyEhs
	ldtf8qvVnYwraw65uwhkKuIqzchvLnOgWcmAxUXWz/w4go7XX6GWRKUonyVHU7DJmj8yvn8AiQXDS
	rnFEr9qO8RVN82nwPye+CgZa0jbyMX+7NflEVyNcQqf7vIUhRX4tbcP5iV6P3emJaCd9IfdPd1epS
	nN024BwptKCzKUCApuCqDJD/LhNW7QJtMp73EpCwEeaZikf01GIZ4IBxQE37kX1xoy3+1NZNh3xUF
	TNZ3quHg==;
Received: from [59.10.240.225] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ua21W-00FAnk-Q6; Fri, 11 Jul 2025 02:54:00 +0200
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
Subject: [PATCH v3 07/10] PM: EM: Implement em_nl_get_pd_table_doit().
Date: Fri, 11 Jul 2025 09:53:07 +0900
Message-ID: <20250711005310.20740-8-changwoo@igalia.com>
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

When a userspace requests EM_CMD_GET_PD_TABLE with an ID of a performancei
domain, the kernel reports back the energy model table of the specified
performance domain. The message format of the response is as follows:

EM_A_PD_TABLE_PD_ID (NLA_U32)
EM_A_PD_TABLE_PS (NLA_NESTED)*
    EM_A_PS_PERFORMANCE (NLA_U64)
    EM_A_PS_FREQUENCY (NLA_U64)
    EM_A_PS_POWER (NLA_U64)
    EM_A_PS_COST (NLA_U64)
    EM_A_PS_FLAGS (NLA_U64)

where EM_A_PD_TABLE_PS can be repeated as many times as there are
performance states (struct em_perf_state).

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/power/em_netlink.c | 108 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 1 deletion(-)

diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
index 31b27c6fe3c9..981bbf1f9a2f 100644
--- a/kernel/power/em_netlink.c
+++ b/kernel/power/em_netlink.c
@@ -102,9 +102,115 @@ int em_nl_get_pds_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+static struct em_perf_domain *__em_nl_get_pd_table_id(struct nlattr **attrs)
+{
+	struct em_perf_domain *pd;
+	int id;
+
+	if (!attrs[EM_A_PD_TABLE_PD_ID])
+		return NULL;
+
+	id = nla_get_u32(attrs[EM_A_PD_TABLE_PD_ID]);
+	pd = em_perf_domain_get_by_id(id);
+	return pd;
+}
+
+static int __em_nl_get_pd_table_size(const struct em_perf_domain *pd)
+{
+	int id_sz, ps_sz;
+
+	id_sz = nla_total_size(sizeof(u32));		/* EM_A_PD_TABLE_PD_ID */
+	ps_sz = nla_total_size(0) +			/* EM_A_PD_TABLE_PS */
+		nla_total_size_64bit(sizeof(u64)) +	/* EM_A_PS_PERFORMANCE */
+		nla_total_size_64bit(sizeof(u64)) +	/* EM_A_PS_FREQUENCY */
+		nla_total_size_64bit(sizeof(u64)) +	/* EM_A_PS_POWER */
+		nla_total_size_64bit(sizeof(u64)) +	/* EM_A_PS_COST */
+		nla_total_size_64bit(sizeof(u64));	/* EM_A_PS_FLAGS */
+	ps_sz *= pd->nr_perf_states;
+
+	return nlmsg_total_size(genlmsg_msg_size(id_sz + ps_sz));
+}
+
+static int __em_nl_get_pd_table(struct sk_buff *msg, const struct em_perf_domain *pd)
+{
+	struct em_perf_state *table, *ps;
+	struct nlattr *entry;
+	int i;
+
+	if (nla_put_u32(msg, EM_A_PD_TABLE_PD_ID, pd->id))
+		goto out_err;
+
+	rcu_read_lock();
+	table = em_perf_state_from_pd((struct em_perf_domain *)pd);
+
+	for (i = 0; i < pd->nr_perf_states; i++) {
+		ps = &table[i];
+
+		entry = nla_nest_start(msg, EM_A_PD_TABLE_PS);
+		if (!entry)
+			goto out_unlock_ps;
+
+		if (nla_put_u64_64bit(msg, EM_A_PS_PERFORMANCE,
+				      ps->performance, EM_A_PS_PAD))
+			goto out_cancel_ps_nest;
+		if (nla_put_u64_64bit(msg, EM_A_PS_FREQUENCY,
+				      ps->frequency, EM_A_PS_PAD))
+			goto out_cancel_ps_nest;
+		if (nla_put_u64_64bit(msg, EM_A_PS_POWER,
+				      ps->power, EM_A_PS_PAD))
+			goto out_cancel_ps_nest;
+		if (nla_put_u64_64bit(msg, EM_A_PS_COST,
+				      ps->cost, EM_A_PS_PAD))
+			goto out_cancel_ps_nest;
+		if (nla_put_u64_64bit(msg, EM_A_PS_FLAGS,
+				      ps->flags, EM_A_PS_PAD))
+			goto out_cancel_ps_nest;
+
+		nla_nest_end(msg, entry);
+	}
+	rcu_read_unlock();
+	return 0;
+
+out_cancel_ps_nest:
+	nla_nest_cancel(msg, entry);
+out_unlock_ps:
+	rcu_read_unlock();
+out_err:
+	return -EMSGSIZE;
+}
+
 int em_nl_get_pd_table_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct sk_buff *msg;
+	struct em_perf_domain *pd;
+	void *hdr;
+	int cmd = info->genlhdr->cmd;
+	int msg_sz, ret;
+
+	pd = __em_nl_get_pd_table_id(info->attrs);
+	if (!pd)
+		return -EINVAL;
+
+	msg_sz = __em_nl_get_pd_table_size(pd);
+
+	msg = genlmsg_new(msg_sz, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_put_reply(msg, info, &em_nl_family, 0, cmd);
+	if (!hdr)
+		goto out_free_msg;
+
+	ret = __em_nl_get_pd_table(msg, pd);
+	if (ret)
+		goto out_free_msg;
+
+	genlmsg_end(msg, hdr);
+	return genlmsg_reply(msg, info);
+
+out_free_msg:
+	nlmsg_free(msg);
+	return -EMSGSIZE;
 }
 
 static int __init em_netlink_init(void)
-- 
2.50.0


