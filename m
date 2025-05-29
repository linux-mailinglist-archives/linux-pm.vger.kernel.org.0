Return-Path: <linux-pm+bounces-27779-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1059FAC74E8
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 02:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B283C4A7343
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 00:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A6F1547EE;
	Thu, 29 May 2025 00:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="LJ4kbhq3"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787684642D;
	Thu, 29 May 2025 00:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748477668; cv=none; b=KqTbEziURHWfts8cT4JdJ7slaJrPVsMNHgnxQq/DUy6r/bpgzW4ghnMyG5G52cuShy30eEcRSO8jz/EA4acQtg8xHiW+DRp3i9DfisC05bD8iFSqsdqdaaA2NCzRYSoqnioVZ0ID93LJK/t0wgEHZds1T7Vosxu6Y5kaiuFJMRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748477668; c=relaxed/simple;
	bh=nCkkIey/nFRJZRwYiHlHKYCl+yrqwz3iupT25TX1JnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qaPK2HSv5ws0D9EhBofMJNaBpIEdXRbj7qZdjbCmrvc/gIQsEF+aq/NA+Nj/8PbDPxJRlA/zoFePt97gzG8M8YW03T2UGkv0Di/TzQrebMJfX/IhRnOeng0B/GfPF1mQNOa+Kxo2ZekxCYKhJkaZZ519RJtKFFzYsuZmSSUtw4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=LJ4kbhq3; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Rl4FC04SxH0qZTjzKBJVM7yZ3pqq7wX9bu8amclj5Zk=; b=LJ4kbhq3GessY4D8u8p9PDFE9V
	jY3EUMMrGz9t2nQEyJXMKmXfeVET5ytPVJNmtrB8EAYthjoaZxK1GzVXv4oy3vBlcJLJLzYeeJGK7
	3Ob68bUnEX1BHeuAX7kbe3eESe0s0aKc4sGhjuLXYzl7lduyGh+aZZHkptCGOsvs6Y0kkkgkcZUXc
	LJQQkhovDovVPvXFxqB/v1kZILIg1Xj9KWAQROAb2JPVHRaqLtDtoQ+UJ3hCNiqkIO0ekCxPdWgA2
	OhTn66m06w4N2zoJU6qN9587j68jOU0IsewYtSMSHrVatRTYvHfwpWX8IpuI5o4QpF6JyiuDvkkrV
	iUTgnthA==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uKQuY-00EZxP-UH; Thu, 29 May 2025 02:14:20 +0200
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
Subject: [PATCH 08/11] PM: EM: Implement EM_GENL_CMD_PD_GET_ID.
Date: Thu, 29 May 2025 09:13:12 +0900
Message-ID: <20250529001315.233492-9-changwoo@igalia.com>
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

When a userspace requests EM_GENL_CMD_PD_GET_ID, the kernel responds with
information on all performance domains. The message format of the response
is as follows:

EM_GENL_ATTR_PD (NLA_NESTED)
	EM_PD_ENTRY_GENL_ATTR_PD (NLA_NESTED)*
		EM_PD_GENL_ATTR_ID (NLA_U32)
		EM_PD_GENL_ATTR_FLAGS (NLA_U64)
		EM_PD_GENL_ATTR_CPUS (NLA_STRING)

Where EM_PD_ENTRY_GENL_ATTR_PD can be repeated as many times as there are
performance domains, and EM_PD_GENL_ATTR_CPUS is a hexadecimal string
representing a CPU bitmask.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 include/uapi/linux/energy_model.h | 25 ++++++++++++++
 kernel/power/em_netlink.c         | 55 ++++++++++++++++++++++++++++++-
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/energy_model.h b/include/uapi/linux/energy_model.h
index 42a19e614c7d..66339ace6fcb 100644
--- a/include/uapi/linux/energy_model.h
+++ b/include/uapi/linux/energy_model.h
@@ -10,10 +10,35 @@
 /* Attributes of em_genl_family */
 enum em_genl_attr {
 	EM_GENL_ATTR_UNSPEC,
+	EM_GENL_ATTR_PAD = EM_GENL_ATTR_UNSPEC,
+	EM_GENL_ATTR_PD,	/* Performance domain */
 	__EM_GENL_ATTR_MAX,
 };
 #define EM_GENL_ATTR_MAX (__EM_GENL_ATTR_MAX - 1)
 
+enum em_pd_entry_genl_attr {
+	EM_PD_ENTRY_GENL_ATTR_UNSPEC,
+	EM_PD_ENTRY_GENL_ATTR_PAD = EM_PD_ENTRY_GENL_ATTR_UNSPEC,
+	EM_PD_ENTRY_GENL_ATTR_PD,
+	__EM_PD_ENTRY_GENL_ATTR_MAX,
+};
+#define EM_PD_ENTRY_GENL_ATTR_MAX (__EM_PD_ENTRY_GENL_ATTR_MAX - 1)
+
+enum em_pd_genl_attr {
+	EM_PD_GENL_ATTR_UNSPEC,
+	EM_PD_GENL_ATTR_PAD = EM_PD_GENL_ATTR_UNSPEC,
+
+	/* Performance domain */
+	EM_PD_GENL_ATTR_ID,
+	EM_PD_GENL_ATTR_FLAGS,
+	EM_PD_GENL_ATTR_CPUS,
+
+	__EM_PD_GENL_ATTR_MAX,
+};
+#define EM_PD_GENL_ATTR_MAX (__EM_PD_GENL_ATTR_MAX - 1)
+
+#define EM_PD_CPUS_LENGTH		256
+
 /* Events of em_genl_family */
 enum em_genl_event {
 	EM_GENL_EVENT_UNSPEC,
diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
index edbaecebd0b4..ea975ca6272f 100644
--- a/kernel/power/em_netlink.c
+++ b/kernel/power/em_netlink.c
@@ -21,6 +21,8 @@ static const struct genl_multicast_group em_genl_mcgrps[] = {
 };
 
 static const struct nla_policy em_genl_policy[EM_GENL_ATTR_MAX + 1] = {
+	/* Performance domain */
+	[EM_GENL_ATTR_PD]			= { .type = NLA_NESTED },
 };
 
 struct param {
@@ -34,9 +36,60 @@ static struct genl_family em_genl_family;
 
 /*************************** Command encoding ********************************/
 
+static int __em_genl_cmd_pd_get_id(struct em_perf_domain *pd, void *data)
+{
+	char cpus_buf[EM_PD_CPUS_LENGTH];
+	struct sk_buff *msg = data;
+	struct nlattr *entry;
+
+	entry = nla_nest_start(msg, EM_PD_ENTRY_GENL_ATTR_PD);
+	if (!entry)
+		goto out_cancel_nest;
+
+	if (nla_put_u32(msg, EM_PD_GENL_ATTR_ID, pd->id))
+		goto out_cancel_nest;
+
+	if (nla_put_u64_64bit(msg, EM_PD_GENL_ATTR_FLAGS, pd->flags,
+			      EM_PD_GENL_ATTR_PAD))
+		goto out_cancel_nest;
+
+	snprintf(cpus_buf, sizeof(cpus_buf), "%*pb",
+		 cpumask_pr_args(to_cpumask(pd->cpus)));
+	if (nla_put_string(msg, EM_PD_GENL_ATTR_CPUS, cpus_buf))
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
 static int em_genl_cmd_pd_get_id(struct param *p)
 {
-	return -ENOTSUPP;
+	struct sk_buff *msg = p->msg;
+	struct nlattr *start_pd;
+	int ret;
+
+	start_pd = nla_nest_start(msg, EM_GENL_ATTR_PD);
+	if (!start_pd)
+		return -EMSGSIZE;
+
+	ret = for_each_em_perf_domain(__em_genl_cmd_pd_get_id, msg);
+	if (ret)
+		goto out_cancel_nest;
+
+	nla_nest_end(msg, start_pd);
+
+	return 0;
+
+out_cancel_nest:
+	nla_nest_cancel(msg, start_pd);
+
+	return ret;
 }
 
 static int em_genl_cmd_pd_get_tbl(struct param *p)
-- 
2.49.0


