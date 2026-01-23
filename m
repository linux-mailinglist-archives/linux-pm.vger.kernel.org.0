Return-Path: <linux-pm+bounces-41365-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMYNOeRfc2l3vAAAu9opvQ
	(envelope-from <linux-pm+bounces-41365-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 12:47:48 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E69755A9
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 12:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C6BD300BB9A
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 11:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5642E8B94;
	Fri, 23 Jan 2026 11:47:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA8C2C21C0;
	Fri, 23 Jan 2026 11:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168863; cv=none; b=iWM9I+OllWebJnrRAWuCy8fKgGyhqm0ZAGTuq6Ryazo5nUysTgr2zQElRGnHzFdf1dSGm+YDmo2PDzsImd4oKBkxe6T0Q5OwWnMW3STBs0MTenGvLXZ7zS19Aet2ilkHDo5HxMVgJPX0ZMEaCkTa4L7yqlPQPPUh6Qdnk1HDTFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168863; c=relaxed/simple;
	bh=anOz/omBlnUtzbd7MuYz+Z73+fH/2AQ/S8mESgUyU0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ChtVlDYCezcY+25/aVKwAHmm8F+uu+KcerRzLSR3T+8GtuEoefhrhE5C90FiyyGZ5qZTfaaX8sKULUAUjm91iNT8hU6LM+C5l0O4JP9wntUWSpMKXNvyKKf/Qj1bBoCtBtp5u1uSwfaew4leQKkjGE8qafq/4evTwlp6GbeJMZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4de29206f85111f0b0f03b4cfa9209d1-20260123
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD_SPF
	CIE_UNKNOWN, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:b2738101-d985-4748-99f5-a577889acd57,IP:10,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:0
X-CID-INFO: VERSION:1.3.6,REQID:b2738101-d985-4748-99f5-a577889acd57,IP:10,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:5b75032ad5c369711d6281fe0a346359,BulkI
	D:2601231947349Q7FLH74,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bu
	lk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4de29206f85111f0b0f03b4cfa9209d1-20260123
X-User: tianyaxiong@kylinos.cn
Received: from localhost.localdomain [(223.153.58.254)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 160872711; Fri, 23 Jan 2026 19:47:33 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	srinivas.pandruvada@linux.intel.com,
	lenb@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	ricardo.neri-calderon@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH 1/3] x86/sched: Add arch_disable_hybrid_capacity_scale() interface
Date: Fri, 23 Jan 2026 19:47:28 +0800
Message-Id: <20260123114728.1616203-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260123113712.1590187-1-tianyaxiong@kylinos.cn>
References: <20260123113712.1590187-1-tianyaxiong@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-41365-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tianyaxiong@kylinos.cn,linux-pm@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:mid,kylinos.cn:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 86E69755A9
X-Rspamd-Action: no action

Users can enable/disable SMT (Simultaneous Multi-Threading) via
/sys/devices/system/cpu/smt, which means hybrid_capacity() may not
remain constant on heterogeneous platforms.

Therefore, add the arch_disable_hybrid_capacity_scale() interface
to handle dynamic SMT state changes.

Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 arch/x86/include/asm/topology.h  |  2 ++
 arch/x86/kernel/cpu/aperfmperf.c | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 1fadf0cf520c..a0c1205513e3 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -303,6 +303,7 @@ static inline long arch_scale_freq_capacity(int cpu)
 #define arch_scale_freq_capacity arch_scale_freq_capacity
 
 bool arch_enable_hybrid_capacity_scale(void);
+void arch_disable_hybrid_capacity_scale(void);
 void arch_set_cpu_capacity(int cpu, unsigned long cap, unsigned long max_cap,
 			   unsigned long cap_freq, unsigned long base_freq);
 
@@ -313,6 +314,7 @@ extern void arch_set_max_freq_ratio(bool turbo_disabled);
 extern void freq_invariance_set_perf_ratio(u64 ratio, bool turbo_disabled);
 #else
 static inline bool arch_enable_hybrid_capacity_scale(void) { return false; }
+static inline void arch_disable_hybrid_capacity_scale(void) { return; }
 static inline void arch_set_cpu_capacity(int cpu, unsigned long cap,
 					 unsigned long max_cap,
 					 unsigned long cap_freq,
diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index 7ffc78d5ebf2..a499eccf2f5c 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -362,6 +362,7 @@ struct arch_hybrid_cpu_scale {
 };
 
 static struct arch_hybrid_cpu_scale __percpu *arch_cpu_scale;
+static DEFINE_MUTEX(arch_hybrid_mutex);
 
 /**
  * arch_enable_hybrid_capacity_scale() - Enable hybrid CPU capacity scaling
@@ -375,11 +376,19 @@ bool arch_enable_hybrid_capacity_scale(void)
 {
 	int cpu;
 
+	guard(mutex)(&arch_hybrid_mutex);
+
 	if (static_branch_unlikely(&arch_hybrid_cap_scale_key)) {
 		WARN_ONCE(1, "Hybrid CPU capacity scaling already enabled");
 		return true;
 	}
 
+	if (arch_cpu_scale) {
+		static_branch_enable(&arch_hybrid_cap_scale_key);
+		pr_info("Hybrid CPU capacity scaling enabled\n");
+		return true;
+	}
+
 	arch_cpu_scale = alloc_percpu(struct arch_hybrid_cpu_scale);
 	if (!arch_cpu_scale)
 		return false;
@@ -396,6 +405,20 @@ bool arch_enable_hybrid_capacity_scale(void)
 	return true;
 }
 
+/**
+ * arch_disable_hybrid_capacity_scale() - Disable hybrid CPU capacity scaling
+ */
+void arch_disable_hybrid_capacity_scale(void)
+{
+	guard(mutex)(&arch_hybrid_mutex);
+
+	if (static_branch_unlikely(&arch_hybrid_cap_scale_key)) {
+		static_branch_disable(&arch_hybrid_cap_scale_key);
+		pr_info("Hybrid CPU capacity scaling disable\n");
+		return;
+	}
+}
+
 /**
  * arch_set_cpu_capacity() - Set scale-invariance parameters for a CPU
  * @cpu: Target CPU.
-- 
2.25.1


