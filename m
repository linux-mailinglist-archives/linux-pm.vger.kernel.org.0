Return-Path: <linux-pm+bounces-42787-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAHFM6O8lGm4HQIAu9opvQ
	(envelope-from <linux-pm+bounces-42787-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 20:08:19 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DD914F7C1
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 20:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CBAD7300E5AA
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 19:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BF137472F;
	Tue, 17 Feb 2026 19:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lREQCr5e"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCB0285406
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 19:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771355298; cv=none; b=ZYW6RIUgSQkVw9TldQ1G9fXbt42ogdRITa+tMpVp2Rv+ElWrtt3Sub7IR/ruitVVOyxxsmU7/oAMVg/N8SL+aU6oQfHz/LO32KzqLLPNo3WYP5ZeYmJa+xBdOz6OfIpmJATCl+g72raThUX4r22or3OOfs8NJ2JD7Yyd4pN32EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771355298; c=relaxed/simple;
	bh=kSI1fYFH7lB5j/9HSuMzB+pdP4thtOej3O+BqQSoy+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ornD7RbWH+/vezUJhDKFuo8cRRCY069PBO9ZVxcgovGK/3u2J8z67eW1KLHYTjEGIreEPpOAx9TdjfXigZCHwU6CXqpc10IlGcaiXZ13lA/ZzOCRs/XWo/hnDYwj2haji9g8fkyOcB1RrHmUB0aQ7ruv+eEoz1kJEaxMDXbPlCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lREQCr5e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185E3C19421;
	Tue, 17 Feb 2026 19:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771355297;
	bh=kSI1fYFH7lB5j/9HSuMzB+pdP4thtOej3O+BqQSoy+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=lREQCr5eGmqy6Xg8fcTzjuHXD2/cvR2VV/uPLdd+g8CUFXVa6oNSrzktHT9Vu+ccB
	 j9/KoQAZ1+OvgDPrR0S1cXgfjJXJoRdbevtVK91zLo6JynuvPTHi/xuigrWy5cju2a
	 rvcT9giEaiaHNYB6pzIE+7TQEgnzWeB34uc//7KcwKru4mOOU4yCal5U62huXVXmVH
	 sohveJv/RrJocVY6DSOkJW5IsLqPPriyFzUPcokuEZGq8ywe69l2R+PZD2PVRJYS60
	 ZIg/QbLK/176bOdojuERl9/PxnJZoI0pA6LNkgGUbvt8X5evzjEUzF9ouppi3D9umM
	 4HwQ/m2k5NHUw==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 19/23] tools/power turbostat: Expunge logical_cpu_id
Date: Tue, 17 Feb 2026 13:04:10 -0600
Message-ID: <6be5c151eb1ebf4d5007b9f60c729f7381255a23.1771354333.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <16cc8f249c702b7cbb4c2c2be7cd8f4fdd5d1d0c.1771354332.git.len.brown@intel.com>
References: <16cc8f249c702b7cbb4c2c2be7cd8f4fdd5d1d0c.1771354332.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-42787-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[lenb@kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lenb@kernel.org,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:mid,intel.com:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 70DD914F7C1
X-Rspamd-Action: no action

From: Len Brown <len.brown@intel.com>

There is only once cpu_id name space -- cpu_id.
Expunge the term logical_cpu_id.

No functional change.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 12d5f8112c92..9fdb41410f15 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2393,11 +2393,11 @@ struct platform_counters {
 } platform_counters_odd, platform_counters_even;
 
 struct cpu_topology {
+	int cpu_id;
 	int core_id;		/* unique within a package */
 	int package_id;
 	int die_id;
 	int l3_id;
-	int logical_cpu_id;
 	int physical_node_id;
 	int logical_node_id;	/* 0-based count within the package */
 	int ht_id;		/* unique within a core */
@@ -6099,7 +6099,7 @@ int get_physical_node_id(struct cpu_topology *thiscpu)
 	char path[80];
 	FILE *filep;
 	int i;
-	int cpu = thiscpu->logical_cpu_id;
+	int cpu = thiscpu->cpu_id;
 
 	for (i = 0; i <= topo.max_cpu_num; i++) {
 		sprintf(path, "/sys/devices/system/cpu/cpu%d/node%i/cpulist", cpu, i);
@@ -6174,7 +6174,7 @@ int get_thread_siblings(struct cpu_topology *thiscpu)
 	FILE *filep;
 	unsigned long map;
 	int so, shift, sib_core;
-	int cpu = thiscpu->logical_cpu_id;
+	int cpu = thiscpu->cpu_id;
 	int offset = topo.max_cpu_num + 1;
 	size_t size;
 	int thread_id = 0;
@@ -9596,7 +9596,7 @@ void topology_probe(bool startup)
 			continue;
 		}
 
-		cpus[i].logical_cpu_id = i;
+		cpus[i].cpu_id = i;
 
 		/* get package information */
 		cpus[i].package_id = get_package_id(i);
-- 
2.45.2


