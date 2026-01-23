Return-Path: <linux-pm+bounces-41367-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cElEFsJgc2kCvQAAu9opvQ
	(envelope-from <linux-pm+bounces-41367-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 12:51:30 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A0275661
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 12:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A212E3031039
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 11:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596662EDD63;
	Fri, 23 Jan 2026 11:48:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4392417FB;
	Fri, 23 Jan 2026 11:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168890; cv=none; b=FhQZwZVfK37GwM42JVgRB6egWSS8LghU6xMIg8PvsYl1i1mQakGjceFUFQuhR7iC9SNGxzUVTbU+4Wa49wMjnIkIOQYFETAnzwlMtnmuJazFHKZZAO5eSgESbTjjPnrgxGh0OSmsMHpE0Vu3Eko6WJAhg+0ak15llct29uT1xic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168890; c=relaxed/simple;
	bh=lIoT50cWDMo+exBKpNX+oR/KZFJTiTa7fdaY4+YHvOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jfqjbnsc2shvyXw2MEQsK4orXTqFz/q/D2oOjKzXxx/JJOZeqfkTC7gCjlPy1xl5fzc+P9KXYNF/pv5Q1Xzx68cbyS0z3HDeb5d7zRptD73BPmItJfmKaLhx8wTYIjvf+Q/6rBUPaNNoEScIKl+/yyR78hQ1h0F5VT3ZUxhhfX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5e51c22ef85111f0b0f03b4cfa9209d1-20260123
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD_SPF
	CIE_UNKNOWN, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:bb8c6732-4ab5-4a85-91c0-85c60c9697c6,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:bb8c6732-4ab5-4a85-91c0-85c60c9697c6,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:3441023eb4c53db1484d72b1731de75c,BulkI
	D:260123194801EPVXKAH7,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bu
	lk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5e51c22ef85111f0b0f03b4cfa9209d1-20260123
X-User: tianyaxiong@kylinos.cn
Received: from localhost.localdomain [(223.153.58.254)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 244023420; Fri, 23 Jan 2026 19:48:00 +0800
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
Subject: [PATCH 3/3] cpufreq: intel_pstate: Enable toggling cpu_capacity_scaling on hybrid platforms during SMT transitions
Date: Fri, 23 Jan 2026 19:47:56 +0800
Message-Id: <20260123114756.1617527-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260123113712.1590187-1-tianyaxiong@kylinos.cn>
References: <20260123113712.1590187-1-tianyaxiong@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tianyaxiong@kylinos.cn,linux-pm@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.998];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kylinos.cn:mid,kylinos.cn:email];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41367-lists,linux-pm=lfdr.de];
	DMARC_NA(0.00)[kylinos.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: C1A0275661
X-Rspamd-Action: no action

Users can disable SMT (Simultaneous Multi-Threading) via
/sys/devices/system/cpu/smt, meaning that CPU hybrid capabilities
and related features like EAS (Energy Aware Scheduling) may become
dynamically eligible. This implies that when an SMT transition
occurs,the system may no longer be considered hybrid, rendering the
original configurations incorrect.

To address this issue, note that SMT transitions are accompanied
by cpufreq online/offline operations, allowing conditional checks
within this path. Specifically:

    When SMT transitions from off → on, cpufreq online operations
occur. If hybrid settings were previously applied, disable-related
operations should be performed.

    When SMT transitions from on → off, cpufreq offline operations
occur. If the system meets hybrid conditions at this point,
enable-related operations should be performed.

Fixes: 929ebc93ccaa ("cpufreq: intel_pstate: Set asymmetric CPU capacity on hybrid systems")
Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 drivers/cpufreq/intel_pstate.c | 60 ++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 76fb79b8068a..fad25aa4b5f8 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1234,6 +1234,59 @@ static void hybrid_update_capacity(struct cpudata *cpu)
 	mutex_unlock(&hybrid_capacity_lock);
 }
 
+static bool hybrid_need_enable_cpu_capacity_scaling(void)
+{
+	guard(mutex)(&hybrid_capacity_lock);
+
+	if (!hybrid_max_perf_cpu && hwp_is_hybrid &&
+		!no_cas && !sched_smt_active())
+		return true;
+	else
+		return false;
+}
+
+static bool hybrid_need_disable_cpu_capacity_scaling(void)
+{
+	guard(mutex)(&hybrid_capacity_lock);
+
+	if (hybrid_max_perf_cpu && sched_smt_active()) {
+		hybrid_max_perf_cpu = NULL;
+		return true;
+	} else {
+		return false;
+	}
+}
+
+static void hybrid_enable_cpu_capacity_scaling_work_fn(struct work_struct *work)
+{
+	if (arch_enable_hybrid_capacity_scale()) {
+		hybrid_refresh_cpu_capacity_scaling();
+		/*
+		 * Disabling ITMT causes sched domains to be rebuilt to disable asym
+		 * packing and enable asym capacity and EAS.
+		 */
+		sched_clear_itmt_support();
+
+	}
+}
+
+static void hybrid_disable_cpu_capacity_scaling_work_fn(struct work_struct *work)
+{
+	unsigned int cpu;
+
+	arch_disable_hybrid_capacity_scale();
+	for_each_possible_cpu(cpu)
+		topology_set_cpu_scale(cpu, arch_scale_cpu_capacity(cpu));
+
+	/* Heterogeneous CPUs have different capabilities, therefore enable
+	 * ITMT when SMT is active.
+	 */
+	sched_set_itmt_support();
+}
+
+static DECLARE_WORK(hybrid_enable_work, hybrid_enable_cpu_capacity_scaling_work_fn);
+static DECLARE_WORK(hybrid_disable_work, hybrid_disable_cpu_capacity_scaling_work_fn);
+
 static void intel_pstate_hwp_set(unsigned int cpu)
 {
 	struct cpudata *cpu_data = all_cpu_data[cpu];
@@ -2967,6 +3020,10 @@ static int intel_cpufreq_cpu_offline(struct cpufreq_policy *policy)
 
 	intel_pstate_exit_perf_limits(policy);
 
+	if (unlikely(hybrid_need_enable_cpu_capacity_scaling()))
+		schedule_work(&hybrid_enable_work);
+
+
 	return 0;
 }
 
@@ -2974,6 +3031,9 @@ static int intel_pstate_cpu_online(struct cpufreq_policy *policy)
 {
 	struct cpudata *cpu = all_cpu_data[policy->cpu];
 
+	if (unlikely(hybrid_need_disable_cpu_capacity_scaling()))
+		schedule_work(&hybrid_disable_work);
+
 	pr_debug("CPU %d going online\n", cpu->cpu);
 
 	intel_pstate_init_acpi_perf_limits(policy);
-- 
2.25.1


