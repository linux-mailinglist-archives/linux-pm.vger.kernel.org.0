Return-Path: <linux-pm+bounces-36530-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 715A6BF3D66
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 00:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34CB318C3E85
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 22:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BC72F0C7F;
	Mon, 20 Oct 2025 22:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jZU14bDL"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCA02E7F11;
	Mon, 20 Oct 2025 22:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760998226; cv=none; b=tBhJ7mBXTZ0Y4Uaut6yz6eZDWiastMtfs1wnf73nQ9++tYJvWYmc2pYm3ZHakTMSVQ9cqh2enRh12oPNY4qD0bhUp8xpcAVoyWYc4oInXkd4i0MtkoUOOYJm4zyLxCIgn40aBMSazsRUrO1fyz9gNL9LXwvvIHTz2yki05xY6ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760998226; c=relaxed/simple;
	bh=SADAOwN3U99LnZ54DRuLES3Q1wKKr9WUFYIo8pnSsvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PHI1gkOQ1D7w59kl6CDBOZmex3IRSOtZdKzVjwWUwin6JxvahsnFVEQ2B3Fs4I2QuH/xAHbBIumlDI1xGF8xSwbd2/LSIORkG7IbOINI5Bd66fJFQZ1wnDYUbVnyvHq2XuAvaPskNQs0BOgGcmEsJangi2rCi8mmDpdCsm+aQhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=jZU14bDL; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=7Dv8lj/ElckfSbohjVkm52cw9POTfO1BvgZSfyl7MaU=; b=jZU14bDLBV9fc+h19xSx/Le1EL
	cxqUbNuOHw7B+ooi2zMLlEtr3pLBYcYzIrq5nFDl/KpJfEn9gVIWX4eGotvUzmFJl0NONGEleyoTT
	l+MF77XgM3nUQHRBf0cqd7KjAhWWMB4DklTgaNcZvBQ7+a82cm0yxKO9xnyQniB7uOyRt6UjLPqIb
	eCTnhZSClgsRTazqlJa2SpQ/3buz11Bv+DeGEs827XQ2AiAFJrulBbd0HfYrGQe2qCAYwSEF2tBF1
	gFjHPv4OVq6Uw1MOI5hENY/tRmvuYqP7mRjmrqN7xlDWK79aGX+CLnrVpd3SNpNt/k6XXH4o1mjoy
	uPvMQK7w==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vAy54-00CHa5-1z; Tue, 21 Oct 2025 00:10:19 +0200
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
Subject: [PATCH v6 07/10] PM: EM: Implement em_nl_get_pd_table_doit()
Date: Tue, 21 Oct 2025 07:09:11 +0900
Message-ID: <20251020220914.320832-8-changwoo@igalia.com>
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

When a userspace requests EM_CMD_GET_PD_TABLE with an ID of a performance
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
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/em_netlink.c | 108 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 1 deletion(-)

diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
index 31b27c6fe3c9..2addc143401b 100644
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
+	int cmd = info->genlhdr->cmd;
+	int msg_sz, ret = -EMSGSIZE;
+	struct em_perf_domain *pd;
+	struct sk_buff *msg;
+	void *hdr;
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
+	return ret;
 }
 
 static int __init em_netlink_init(void)
-- 
2.51.1.dirty


