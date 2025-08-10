Return-Path: <linux-pm+bounces-32111-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4140AB1FD25
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 01:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A223E189A71C
	for <lists+linux-pm@lfdr.de>; Sun, 10 Aug 2025 23:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E602D97A8;
	Sun, 10 Aug 2025 23:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ofzosT26"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7762D97A0;
	Sun, 10 Aug 2025 23:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754868891; cv=none; b=o/4nlFRq0Ti3auVa/OFspiw3A7hTpvikyyJqodysdW5dxAa/NmRjyA8liQs1MZsgHMsC8IXV6EvTq7Mh0IPYKaGzdUEtTBVLjYvf67bpXnoz93Tuhi44rfL80TbWCffb3shkpywamtj4+9x9fFbz66pFI3yrkAN0Y6JFFd0sg7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754868891; c=relaxed/simple;
	bh=Oa2ikAhncCGU9JYgMteZNviLeRQr7b8wO6BUSqUIYyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tcy1Ih/JtAjFpEh3xe6KkyaSCcFn+XJZ0gCG19l2OwvRVbllPVfaIyiGZTAAKnYgrlSF9OR5V0T6BEhewNkmOl42hjZnKEpdNl/SJMjT5O3tzXi74xWpOSrtyOT4dwItMvY/PgPTGDCenNRrc8Qo4qWarOGxLnTqWa5XGD8g6WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ofzosT26; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=19TkK/wQmFixulKIuREFy0xupeNLlFDct+zAu8O96hM=; b=ofzosT26AByj1PgrgdU3t6ExNj
	kjhRnXFrV5ex4laijePjClGIrZtEEn9V6tcgrqUAvJ1Nuexgab7lGt9iOfVp8WWANcCUEqr+TbILr
	l3vm6mA/1OrFL5xvMP3CspyKE2BS4+Z9WeV8VLSvhR+gx+7Y4D1H+17acTFjURQxKNgc69J7ivsEv
	FbpoUMplF9SXBNhOCzPCTW0M18gLamjF0Vca/Dtkh2L/NmuCwxvpb7WcVVpgVMDCueyaJ4yBD3R0w
	PpxOZ8x8GooEVgbzbcN50pXW455lnIt1oke7b7n4DA0Sdn9FjVpyQIUQR16BCNRouhTGVIVNX76Wp
	GhXwgFcA==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ulFYp-00CWBA-Fc; Mon, 11 Aug 2025 01:34:44 +0200
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
Subject: [PATCH RESEND v3 09/10] PM: EM: Implement em_notify_pd_created/updated().
Date: Mon, 11 Aug 2025 08:33:46 +0900
Message-ID: <20250810233347.81957-10-changwoo@igalia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250810233347.81957-1-changwoo@igalia.com>
References: <20250810233347.81957-1-changwoo@igalia.com>
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
 kernel/power/em_netlink.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
index ff6aa848d998..ff3eab078546 100644
--- a/kernel/power/em_netlink.c
+++ b/kernel/power/em_netlink.c
@@ -215,14 +215,48 @@ int em_nl_get_pd_table_doit(struct sk_buff *skb, struct genl_info *info)
 
 
 /**************************** Event encoding *********************************/
+static int __em_notify_pd_table(const struct em_perf_domain *pd, int ntf_type)
+{
+	struct sk_buff *msg;
+	int msg_sz, ret = -EMSGSIZE;
+	void *hdr;
+
+	if (!genl_has_listeners(&em_nl_family, &init_net, EM_NLGRP_EVENT))
+		return 0;
+
+	msg_sz = __em_nl_get_pd_table_size(pd);
+
+	msg = genlmsg_new(msg_sz, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
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
+	return 0;
+
+out_free_msg:
+	nlmsg_free(msg);
+	return ret;
+}
+
 int em_notify_pd_created(const struct em_perf_domain *pd)
 {
-	return -EOPNOTSUPP;
+	return __em_notify_pd_table(pd, EM_CMD_PD_CREATED);
 }
 
 int em_notify_pd_updated(const struct em_perf_domain *pd)
 {
-	return -EOPNOTSUPP;
+	return __em_notify_pd_table(pd, EM_CMD_PD_UPDATED);
 }
 
 static int __em_notify_pd_deleted_size(const struct em_perf_domain *pd)
-- 
2.50.1


