Return-Path: <linux-pm+bounces-42785-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGDMCca8lGm4HQIAu9opvQ
	(envelope-from <linux-pm+bounces-42785-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 20:08:54 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A5C14F819
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 20:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D35D3046501
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 19:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE1637474B;
	Tue, 17 Feb 2026 19:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsUc/Kje"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F1F37473C
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 19:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771355294; cv=none; b=gYcMImO/S9J5KLpkSBsWBYMTKzRsgjzn16SU6hXJZtCXuvADxCKU+tsaST1QBFbkTWHJjmi6tlMWx6XTztbiPZfjQbTChPZxGXox0QqVQR/vvrxcELjyGpnkcxSWtMco5q5Q/Zm1I5VqxQwKN+UwJO8M7Aljspp5pHlgRc4Swwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771355294; c=relaxed/simple;
	bh=eIlXssSh9954LAOi6qs03QTcjm+Vq62C0qq2KHQKDEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IRaOP9GOYVg7Zs050FddV2Wkc3uFINK53Qum8znix9bW1pPrtUDW8zGdlsmpzGgiOsjqHl3V4YN7GBDO1Tkxk9q/iz+kP/aqlG2NFR4kQpHrLRnUX+PzS149walVGmrNeuDnHiKtMV8UeNneBalqVTkbSrMrpmcAdMxKCtY27fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsUc/Kje; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B1AC4CEF7;
	Tue, 17 Feb 2026 19:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771355293;
	bh=eIlXssSh9954LAOi6qs03QTcjm+Vq62C0qq2KHQKDEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=EsUc/KjevPdIa6Ctpn9wObimHCfck+L1O7fJdWSPUYaCsRrdKgr/Sx8QHWg03rXzd
	 PLItxZDZ+MGy1iP13Ty533OIY5ZV2+GyebMfEK0l+OXOKFt0cHBkeYEjb/AQ4vQ5M7
	 af0DXmHsex2Ctq7N/JL+QClt9/vc4DGgX334Ko2k0wViMvqoB1lZbSNTRHf6Uf6u9H
	 spSFeJyvhxLbwS2CXJPnSN5Su7zd4yQWRuRh/0QAqen5U+To+koI/4yyn+OVAzpldI
	 bhDgdiQwO6UxeuV1znCF3FcTcnuIOfKWZeUrMShyF7o9DFOyewMh9O9DEd0mkTTAxI
	 yjZZ9pXYkEroA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 17/23] tools/power turbostat: Simplify global core_id calculation
Date: Tue, 17 Feb 2026 13:04:08 -0600
Message-ID: <ddf60e38ca048842a34eb6e9d7a0d3e7d459df8d.1771354333.git.len.brown@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-42785-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[lenb@kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lenb@kernel.org,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 88A5C14F819
X-Rspamd-Action: no action

From: Len Brown <len.brown@intel.com>

Standardize the generation of globally unique core_id's
in a macro, and simplify the related code.

No functional change.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index d37f36852f0f..6091d0117994 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2393,7 +2393,7 @@ struct platform_counters {
 } platform_counters_odd, platform_counters_even;
 
 struct cpu_topology {
-	int core_id;
+	int core_id;		/* unique within a package */
 	int package_id;
 	int die_id;
 	int l3_id;
@@ -2409,12 +2409,12 @@ struct topo_params {
 	int num_packages;
 	int num_die;
 	int num_cpus;
-	int num_cores;
+	int num_cores;		/* system wide */
 	int allowed_packages;
 	int allowed_cpus;
 	int allowed_cores;
 	int max_cpu_num;
-	int max_core_id;
+	int max_core_id;	/* within a package */
 	int max_package_id;
 	int max_die_id;
 	int max_l3_id;
@@ -2446,6 +2446,7 @@ int cpu_is_not_allowed(int cpu)
 	return !CPU_ISSET_S(cpu, cpu_allowed_setsize, cpu_allowed_set);
 }
 
+#define GLOBAL_CORE_ID(core_id, pkg_id)	(core_id + pkg_id * (topo.max_core_id + 1))
 /*
  * run func(thread, core, package) in topology order
  * skip non-present cpus
@@ -5157,32 +5158,18 @@ unsigned long pmt_read_counter(struct pmt_counter *ppmt, unsigned int domain_id)
 /* Rapl domain enumeration helpers */
 static inline int get_rapl_num_domains(void)
 {
-	int num_packages = topo.max_package_id + 1;
-	int num_cores_per_package;
-	int num_cores;
-
 	if (!platform->has_per_core_rapl)
-		return num_packages;
-
-	num_cores_per_package = topo.max_core_id + 1;
-	num_cores = num_cores_per_package * num_packages;
+		return topo.num_packages;
 
-	return num_cores;
+	return topo.num_cores;
 }
 
 static inline int get_rapl_domain_id(int cpu)
 {
-	int nr_cores_per_package = topo.max_core_id + 1;
-	int rapl_core_id;
-
 	if (!platform->has_per_core_rapl)
 		return cpus[cpu].package_id;
 
-	/* Compute the system-wide unique core-id for @cpu */
-	rapl_core_id = cpus[cpu].core_id;
-	rapl_core_id += cpus[cpu].package_id * nr_cores_per_package;
-
-	return rapl_core_id;
+	return GLOBAL_CORE_ID(cpu, cpus[cpu].package_id);
 }
 
 /*
-- 
2.45.2


