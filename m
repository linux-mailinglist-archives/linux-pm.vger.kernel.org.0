Return-Path: <linux-pm+bounces-33500-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE331B3D67B
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 04:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 271C418990FD
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 02:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DC021254B;
	Mon,  1 Sep 2025 02:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Lgr9WUDN"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE66B212545;
	Mon,  1 Sep 2025 02:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756692058; cv=none; b=nrm+NbqNRVzoQ8wWf2c8IJFhFRj8hAWU5QuOwcsTmv24sLJgfrRlbXpr2Tou1B3shjmluuvOwLnBLUq5Vfpkm1R25CP1iK5WqIGDJLvYsjlUBygFCEs4oi12twn8nWroAygC3KXxEutAfwkUVbOnm+yqYQmYeSFo9eGShdmmFEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756692058; c=relaxed/simple;
	bh=sIUC3+UBuDoJoZKfk7HtTe+i/bxz9UE8eXfzlcItyq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2ewTUIrUajPLqstlTNzZZFFEPv3D3pHjr3n+hBDQFLJgTLorITXV6cAYl5jyAQopSa+7V6aZ99GXzMJhpcIOuT6erIgpG7y9ejkLPRpu2zE8uREg2pGSGtD+VWKQU/ox0ThQbvA9dc4Lkdw+noMHW+3giXEeDYv7eqSVr4Epy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Lgr9WUDN; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=PWEPzpF6RxNqTtrALNVAxf12IenjDGCjXp1MKrJXdqU=; b=Lgr9WUDN5oT+9h7Y7yK3AtYcYL
	1eSxO+34DXvoxgMsvX8uP2cgF7mlxGazyQTU+KFlKesG9fMLCQDSpxg4sEk8Kif43yUL+BEl9J8bI
	jKJ2QrGt1LBiBFzuPnzvfO4j7yIiTuVAEhecxzt1ODJ2HhQAR28VpZiNbN4pT4PwdG3ZC4Zjepmnv
	mTl+PNeJ9OGShcfqbCzbMyyu3T9/tJYzItRmGsianBSxpWv2elTCRyoDsuaiPCMSHUmq1yirq1ogV
	xVCq9rwB1dJmJiSJbZfcItCkhuiA88qtvYPtPvcS3MjwhYGSw1QaxlCvtOOyH/jCxTeqEimQNy3NE
	OsppazzQ==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ustqj-0054Uu-H9; Mon, 01 Sep 2025 04:00:50 +0200
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
Subject: [PATCH v4 07/10] PM: EM: Implement em_nl_get_pd_table_doit()
Date: Mon,  1 Sep 2025 11:00:00 +0900
Message-ID: <20250901020003.86415-8-changwoo@igalia.com>
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
index 31b27c6fe3c9..59953cfedf78 100644
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
+	int msg_sz, ret = -EMSGSIZE;
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
2.51.0


