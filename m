Return-Path: <linux-pm+bounces-27780-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B02DCAC74EB
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 02:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCE254A7F9C
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 00:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BB513AA2F;
	Thu, 29 May 2025 00:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="oQvsKvhP"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1C8DF71;
	Thu, 29 May 2025 00:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748477677; cv=none; b=W9LENPqmrcTcih6OyyZduSZIzKsGkhApu0b6ODgmbzvPZ8Z9OuIf41ReMYLhCm90gy1Pwkzv6bCLxFc78YU2yhTqQGs8BNHMlfNMhhgZuXi4XfNtMeuPs2BW+cHrmgu+N7f6VR69ksbPlkP6LSYg0fQFM1SdZP2crg4mCALViIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748477677; c=relaxed/simple;
	bh=/ES+ABK9zEHGOiaJ/G0/yuQFNEKGNHacmFDdoCsxCzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=buyP9FgfsVKDU0y9FCbNLHkjbbE34bu5RN5HJ6KKfFQ+f+4XwA8myMBt83wd3BM9HseRHblchu6qYMJabQdSDtK+VHRX89a5E7mK4PtcmTFvJre5q7SLkPlaZEBpjjAOucDkMDT+AFCmYtXFeRcq8I2I1ZIBK76c7DDe5Rh7kOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=oQvsKvhP; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=TeA43xMymAu112mHxv3Y5f68/jrcu3+91rnd9QVJ/JU=; b=oQvsKvhPpF6DZIYN1gJPezWyIl
	edBsLcc8rWG9/64dEiYlITw3r7p3zXtzYVMiQm95sdSgFCWNVZw+GufZxXIGcPC0MPSHpBDTKHVEy
	YfmVgBBp7K8Zk4UeYBt+R4rCcUKx+0t+hTh0MaUragU+m/F5qHN63pYrh9OB1gNwjj5pByILPPUq6
	dkBgLgBOhYFY8+2FoBudRp5joNLX4VI8Jk1iuuecErsmT9PBA3KLasq6yeR7zFtelkDR0eQOt67BQ
	t/bQ0s5L4EA1xw9OFEA4PFD9A94kA3FBKYeimAaryakkfBawGLLWOfF8BynVet74AvF9gGchCCOf3
	aVw5zE4g==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uKQui-00EZxi-7A; Thu, 29 May 2025 02:14:29 +0200
From: Changwoo Min <changwoo@igalia.com>
To: lukasz.luba@arm.com,
	rafael@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org
Cc: christian.loehle@arm.com,
	tj@kernel.org,
	kernel-dev@igalia.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH 09/11] PM: EM: Implement EM_GENL_CMD_PD_GET_TBL.
Date: Thu, 29 May 2025 09:13:13 +0900
Message-ID: <20250529001315.233492-10-changwoo@igalia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529001315.233492-1-changwoo@igalia.com>
References: <20250529001315.233492-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a userspace requests EM_GENL_CMD_PD_GET_TBL with an ID of a
performance domain, the kernel reports back the energy model table of the
specified performance domain. The message format of the response is as
follows:

EM_GENL_ATTR_PD_TBL (NLA_NESTED)
	EM_TBL_ENTRY_GENL_ATTR_PD (NLA_NESTED)*
		EM_TBL_GENL_ATTR_PS_PERFORMANCE (NLA_U64)
		EM_TBL_GENL_ATTR_PS_FREQUENCY (NLA_U64)
		EM_TBL_GENL_ATTR_PS_POWER (NLA_U64)
		EM_TBL_GENL_ATTR_PS_COST (NLA_U64)
		EM_TBL_GENL_ATTR_PS_FLAGS (NLA_U64)

Where EM_TBL_ENTRY_GENL_ATTR_PD can be repeated as many times as there are
performance states (struct em_perf_state).

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 include/uapi/linux/energy_model.h | 24 ++++++++++++
 kernel/power/em_netlink.c         | 64 ++++++++++++++++++++++++++++++-
 2 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/energy_model.h b/include/uapi/linux/energy_model.h
index 66339ace6fcb..9517ca957a78 100644
--- a/include/uapi/linux/energy_model.h
+++ b/include/uapi/linux/energy_model.h
@@ -12,6 +12,7 @@ enum em_genl_attr {
 	EM_GENL_ATTR_UNSPEC,
 	EM_GENL_ATTR_PAD = EM_GENL_ATTR_UNSPEC,
 	EM_GENL_ATTR_PD,	/* Performance domain */
+	EM_GENL_ATTR_PD_TBL,	/* Performance table of a performance domain */
 	__EM_GENL_ATTR_MAX,
 };
 #define EM_GENL_ATTR_MAX (__EM_GENL_ATTR_MAX - 1)
@@ -39,6 +40,29 @@ enum em_pd_genl_attr {
 
 #define EM_PD_CPUS_LENGTH		256
 
+enum em_tbl_entry_genl_attr {
+	EM_TBL_ENTRY_GENL_ATTR_UNSPEC,
+	EM_TBL_ENTRY_GENL_ATTR_PAD = EM_TBL_ENTRY_GENL_ATTR_UNSPEC,
+	EM_TBL_ENTRY_GENL_ATTR_PD,
+	__EM_TBL_ENTRY_GENL_ATTR_MAX,
+};
+#define EM_TBL_ENTRY_GENL_ATTR_MAX (__EM_TBL_ENTRY_GENL_ATTR_MAX - 1)
+
+enum em_tbl_genl_attr {
+	EM_TBL_GENL_ATTR_UNSPEC,
+	EM_TBL_GENL_ATTR_PAD = EM_TBL_GENL_ATTR_UNSPEC,
+
+	/* Performance table of a performance domain */
+	EM_TBL_GENL_ATTR_PS_PERFORMANCE,
+	EM_TBL_GENL_ATTR_PS_FREQUENCY,
+	EM_TBL_GENL_ATTR_PS_POWER,
+	EM_TBL_GENL_ATTR_PS_COST,
+	EM_TBL_GENL_ATTR_PS_FLAGS,
+
+	__EM_TBL_GENL_ATTR_MAX,
+};
+#define EM_TBL_GENL_ATTR_MAX (__EM_TBL_GENL_ATTR_MAX - 1)
+
 /* Events of em_genl_family */
 enum em_genl_event {
 	EM_GENL_EVENT_UNSPEC,
diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
index ea975ca6272f..5f3d5aaa97d7 100644
--- a/kernel/power/em_netlink.c
+++ b/kernel/power/em_netlink.c
@@ -23,6 +23,8 @@ static const struct genl_multicast_group em_genl_mcgrps[] = {
 static const struct nla_policy em_genl_policy[EM_GENL_ATTR_MAX + 1] = {
 	/* Performance domain */
 	[EM_GENL_ATTR_PD]			= { .type = NLA_NESTED },
+	/* Performance table of a performance domain */
+	[EM_GENL_ATTR_PD_TBL]			= { .type = NLA_NESTED },
 };
 
 struct param {
@@ -94,7 +96,67 @@ static int em_genl_cmd_pd_get_id(struct param *p)
 
 static int em_genl_cmd_pd_get_tbl(struct param *p)
 {
-	return -ENOTSUPP;
+	struct sk_buff *msg = p->msg;
+	struct em_perf_domain *pd;
+	struct em_perf_state *table, *ps;
+	struct nlattr *start_tbl, *entry;
+	int id, i;
+
+	if (!p->attrs[EM_PD_GENL_ATTR_ID])
+		return -EINVAL;
+
+	id = nla_get_u32(p->attrs[EM_PD_GENL_ATTR_ID]);
+
+	pd = em_perf_domain_get_by_id(id);
+	if (!pd)
+		return -EINVAL;
+
+	start_tbl = nla_nest_start(msg, EM_GENL_ATTR_PD_TBL);
+	if (!start_tbl )
+		return -EMSGSIZE;
+
+	rcu_read_lock();
+	table = em_perf_state_from_pd(pd);
+
+	for (i = 0; i < pd->nr_perf_states; i++) {
+		ps = &table[i];
+
+		entry = nla_nest_start(msg, EM_TBL_ENTRY_GENL_ATTR_PD);
+		if (!entry)
+			goto out_cancel_nest;
+
+		if (nla_put_u64_64bit(msg, EM_TBL_GENL_ATTR_PS_PERFORMANCE,
+				      ps->performance, EM_TBL_GENL_ATTR_PAD))
+			goto out_cancel_nest2;
+		if (nla_put_u64_64bit(msg, EM_TBL_GENL_ATTR_PS_FREQUENCY,
+				      ps->frequency, EM_TBL_GENL_ATTR_PAD))
+			goto out_cancel_nest2;
+		if (nla_put_u64_64bit(msg, EM_TBL_GENL_ATTR_PS_POWER,
+				      ps->power, EM_TBL_GENL_ATTR_PAD))
+			goto out_cancel_nest2;
+		if (nla_put_u64_64bit(msg, EM_TBL_GENL_ATTR_PS_COST,
+				      ps->cost, EM_TBL_GENL_ATTR_PAD))
+			goto out_cancel_nest2;
+		if (nla_put_u64_64bit(msg, EM_TBL_GENL_ATTR_PS_FLAGS,
+				      ps->flags, EM_TBL_GENL_ATTR_PAD))
+			goto out_cancel_nest2;
+
+		nla_nest_end(msg, entry);
+	}
+	rcu_read_unlock();
+
+	nla_nest_end(msg, start_tbl);
+
+	return 0;
+
+out_cancel_nest2:
+	nla_nest_cancel(msg, entry);
+
+out_cancel_nest:
+	rcu_read_unlock();
+
+	nla_nest_cancel(msg, start_tbl);
+	return -EMSGSIZE;
 }
 
 static const cb_t cmd_cb[] = {
-- 
2.49.0


