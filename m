Return-Path: <linux-pm+bounces-40419-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FB5D0120B
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 06:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A74A309FD2C
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 05:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2F4316909;
	Thu,  8 Jan 2026 05:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="mrH+LKHj"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FC03164DB;
	Thu,  8 Jan 2026 05:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767850376; cv=none; b=enORLxFVtD7g8EbHs3Hjl2sq7fjsydB5OAoTWt6lrnDnhPyGYWZdF4eMF4gqK6Ty3OwjL/+Koj3gDok04kPHk/56d4XGXOm5J8mvOIRkUgVQNyBm2545GkLV0eCI6Wu08zoJT0loqWRKxPR5NI9Zrw+XIcEH+Ij/IaKT1e3a2eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767850376; c=relaxed/simple;
	bh=uFeNlJsiFOSFDJYDMZdTK8NEWLsrqGTVSnvDAKwImHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NhNCFE9syz+YVLElr0NeYgwi0dNKTJLmOQHZhkfn1LNSUgZSj8P+zxCp2025ws8931zmaLsQ1nSNSIzErueKvpt+VzNAx2PQFqdOrEwdWg+kTuA0BQD1B65lTawjHMmgrdsiZIPVh5YR0Rl7B3xBntYM8cYZ5m/u4TIRfV/xRx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=mrH+LKHj; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=e4BABN+whOIwpbRjqw8P1lGgt0uMGQduz3cNU8e5qeY=; b=mrH+LKHjl0sW0p2yn9/sA7k7un
	WixBUBLDIuYyKjo3theUunusr6gyZFFimhkR8+RPbyIuPB5vneIkKhsdLLNeXWA+T+LgirDt2ACsm
	VitWjBmLFgd9ugbnOYwItAJX1LgDsEOVLB8z7CQmuGXVpQgp+cGrK9gO6+M7j9ljmVVRl4ipdhps+
	s+zeCj9q2msPkdAcJ0koTSbdXBfQpiw7AG38SsLhuChdcjmgcfiyvfv7eSmToQ8cZvP6N7DG9ENT8
	LnrqzBqiCNcWHwmqOODbIIfRxqn+P6ekg47WQNR11zKGbkd8MTQL+G/JaSNZ7390aTcJ2PHfAgUJU
	pIm5gl0Q==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vdidY-002qDq-Tb; Thu, 08 Jan 2026 06:32:46 +0100
From: Changwoo Min <changwoo@igalia.com>
To: lukasz.luba@arm.com,
	rafael@kernel.org,
	donald.hunter@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	lenb@kernel.org,
	pavel@kernel.org,
	changwoo@igalia.com
Cc: kernel-dev@igalia.com,
	linux-pm@vger.kernel.org,
	netdev@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 for 6.19 3/4] PM: EM: Change cpus' type from string to u64 array in the EM YNL spec
Date: Thu,  8 Jan 2026 14:32:11 +0900
Message-ID: <20260108053212.642478-4-changwoo@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108053212.642478-1-changwoo@igalia.com>
References: <20260108053212.642478-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Previously, the cpus attribute was a string format which was a "%*pb"
stringification of a bitmap. That is not very consumable for a UAPI,
so let’s change it to an u64 array of CPU ids.

Suggested-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 .../netlink/specs/dev-energymodel.yaml        |  3 ++-
 kernel/power/em_netlink.c                     | 22 +++++++++----------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/Documentation/netlink/specs/dev-energymodel.yaml b/Documentation/netlink/specs/dev-energymodel.yaml
index cbc4bc38f23c..af8b8f72f722 100644
--- a/Documentation/netlink/specs/dev-energymodel.yaml
+++ b/Documentation/netlink/specs/dev-energymodel.yaml
@@ -73,7 +73,8 @@ attribute-sets:
         enum: perf-domain-flags
       -
         name: cpus
-        type: string
+        type: u64
+        multi-attr: true
         doc: >-
           CPUs that belong to this performance domain.
   -
diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
index 6f6238c465bb..b6edb018c65a 100644
--- a/kernel/power/em_netlink.c
+++ b/kernel/power/em_netlink.c
@@ -17,17 +17,14 @@
 #include "em_netlink.h"
 #include "em_netlink_autogen.h"
 
-#define DEV_ENERGYMODEL_A_PERF_DOMAIN_CPUS_LEN		256
-
 /*************************** Command encoding ********************************/
 static int __em_nl_get_pd_size(struct em_perf_domain *pd, void *data)
 {
-	char cpus_buf[DEV_ENERGYMODEL_A_PERF_DOMAIN_CPUS_LEN];
+	int nr_cpus, msg_sz, cpus_sz;
 	int *tot_msg_sz = data;
-	int msg_sz, cpus_sz;
 
-	cpus_sz = snprintf(cpus_buf, sizeof(cpus_buf), "%*pb",
-			   cpumask_pr_args(to_cpumask(pd->cpus)));
+	nr_cpus = cpumask_weight(to_cpumask(pd->cpus));
+	cpus_sz = nla_total_size_64bit(sizeof(u64)) * nr_cpus;
 
 	msg_sz = nla_total_size(0) +
 		 /* DEV_ENERGYMODEL_A_PERF_DOMAINS_PERF_DOMAIN */
@@ -44,9 +41,10 @@ static int __em_nl_get_pd_size(struct em_perf_domain *pd, void *data)
 
 static int __em_nl_get_pd(struct em_perf_domain *pd, void *data)
 {
-	char cpus_buf[DEV_ENERGYMODEL_A_PERF_DOMAIN_CPUS_LEN];
 	struct sk_buff *msg = data;
+	struct cpumask *cpumask;
 	struct nlattr *entry;
+	int cpu;
 
 	entry = nla_nest_start(msg,
 			       DEV_ENERGYMODEL_A_PERF_DOMAINS_PERF_DOMAIN);
@@ -61,10 +59,12 @@ static int __em_nl_get_pd(struct em_perf_domain *pd, void *data)
 			      pd->flags, DEV_ENERGYMODEL_A_PERF_DOMAIN_PAD))
 		goto out_cancel_nest;
 
-	snprintf(cpus_buf, sizeof(cpus_buf), "%*pb",
-		 cpumask_pr_args(to_cpumask(pd->cpus)));
-	if (nla_put_string(msg, DEV_ENERGYMODEL_A_PERF_DOMAIN_CPUS, cpus_buf))
-		goto out_cancel_nest;
+	cpumask = to_cpumask(pd->cpus);
+	for_each_cpu(cpu, cpumask) {
+		if (nla_put_u64_64bit(msg, DEV_ENERGYMODEL_A_PERF_DOMAIN_CPUS,
+				      cpu, DEV_ENERGYMODEL_A_PERF_DOMAIN_PAD))
+			goto out_cancel_nest;
+	}
 
 	nla_nest_end(msg, entry);
 
-- 
2.52.0


