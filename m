Return-Path: <linux-pm+bounces-39927-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE1CCDD468
	for <lists+linux-pm@lfdr.de>; Thu, 25 Dec 2025 05:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCDD63049B19
	for <lists+linux-pm@lfdr.de>; Thu, 25 Dec 2025 04:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97124253340;
	Thu, 25 Dec 2025 04:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="lON9XcoM"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA61A192B75;
	Thu, 25 Dec 2025 04:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766635304; cv=none; b=lNo66mc0R7shUNyzTSHRtvEIukG6BXqV3mAlZVa9y04iEIM5s+7L7VOfRnIcFjjXdqGJu7AAFSer5Y2H5hcMCzDccTzym7VMwGWlBrCW8WIzqVRu9az2/vMmYV2ZsH3U+/8tr/4RXGMBOk1BJZ0ib4RHuXST95TBXrL1fNfu9g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766635304; c=relaxed/simple;
	bh=UdwAAtXW32fS6bCl7uwaPVn+j9AvR9cSxwp8VCI72cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=knX9atRUD8v/i74fAK2g7Ef88Ic29EINMDLswXPRhMHIRm95OcQtfvgbfZvJJwPG64dahwgKKM8DhgxZO3OgcOdwPlogf4JY0R2LxE4pLN0FL3mo3ajP/6zlYMuP6z8MUprLx8S+VnS1Rpfd6CrFC9RGPonyW3SIDQ5lSgoJRSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=lON9XcoM; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=uYbciyDjCoohZWJzDduoI7+l5FwGc+voMTyxmtnDYEw=; b=lON9XcoMR1rnWfvQMLXs4jbyL6
	/rMFR/3tOY/aJmL3syOBRGgo/h4lBSvwHlL9LtmSGdJ6URVYVsVx5uky9iR41EH6HdMrJFJO0uoGL
	V8gupPh0XmPZObrQ+uM+O9ijArJfc9/k+YtcNw9R6+sMlrVkOgoZT04Wp6U9EzaLqJlxvw4Tea+hE
	xbpCHnk0u5EPOTau9CcGZtmJWUIqFv0Ip7/5FQDZVwQeB/jgZB7Jxp5zeVWt5R78SZ6NivnGn35qE
	vJF6XcTJwMuSKyeZtQdr9Yjdfd2PA4GFrCpG6THSAzljvorN/NEyJrmNND5LegfpxmEvXW+4iN8oi
	GnxQq2Qw==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vYcXc-00GLlP-JR; Thu, 25 Dec 2025 05:01:33 +0100
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
Subject: [PATCH for 6.19 3/4] PM: EM: Change cpus' type from string to u64 array in the EM YNL spec
Date: Thu, 25 Dec 2025 13:01:03 +0900
Message-ID: <20251225040104.982704-4-changwoo@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251225040104.982704-1-changwoo@igalia.com>
References: <20251225040104.982704-1-changwoo@igalia.com>
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


