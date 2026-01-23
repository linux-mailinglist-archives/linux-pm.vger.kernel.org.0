Return-Path: <linux-pm+bounces-41366-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gC91IXhgc2kCvQAAu9opvQ
	(envelope-from <linux-pm+bounces-41366-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 12:50:16 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D6375625
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 12:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E14F303FFF9
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 11:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952923242D6;
	Fri, 23 Jan 2026 11:47:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5BE30E848;
	Fri, 23 Jan 2026 11:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168879; cv=none; b=f44zSM4RFCshpuH65sdUUl4QGV0VQQwUxfQQ3RrRMLO0RXRJhvjGXA0ex0RaV5ae62dvYY4g6YMxtevEdq8vMMLGDL0/JfDBbjGLkDME3aHLvhQSeUJjPlBpI+SDTssSLm6lFmXgUXQVzlUYZauB3kwnI0xNmsuTlB+BvNJGob8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168879; c=relaxed/simple;
	bh=K3kmJpWTdNx8nnEN7tJMT/DXdbAa6g8xViEWXkWYrlI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=REmx1gnNm2Ju2/2lodKK7Jw1IvsSQFM37grLgAkj1YOxe4KDJcMTynUmpxw9XmVzQARnXr/y9RvCe31BFsTCzHCsVrWpHVYKPieMqkAYZzSBjsxn8wkik+tTBBQm4LlkHjsv5UHlVe2gqg8qAUj61YX2o6Brv2hVSJHcTZ8abDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 56709cb0f85111f0b0f03b4cfa9209d1-20260123
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
X-CID-O-INFO: VERSION:1.3.6,REQID:392627cd-6d1c-45fc-814e-03a99bafb16f,IP:10,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:0
X-CID-INFO: VERSION:1.3.6,REQID:392627cd-6d1c-45fc-814e-03a99bafb16f,IP:10,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:cc28927e8b866054e77c78b6dec8ab76,BulkI
	D:260123194749EN799ZWJ,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bu
	lk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 56709cb0f85111f0b0f03b4cfa9209d1-20260123
X-User: tianyaxiong@kylinos.cn
Received: from localhost.localdomain [(223.153.58.254)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 100858518; Fri, 23 Jan 2026 19:47:47 +0800
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
Subject: [PATCH 2/3] cpufreq: intel_pstate: Remove refresh logic in hybrid_init_cpu_capacity_scaling()
Date: Fri, 23 Jan 2026 19:47:43 +0800
Message-Id: <20260123114743.1616900-1-tianyaxiong@kylinos.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-41366-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tianyaxiong@kylinos.cn,linux-pm@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:mid,kylinos.cn:email]
X-Rspamd-Queue-Id: D8D6375625
X-Rspamd-Action: no action

Users can disable SMT (Simultaneous Multi-Threading) via
/sys/devices/system/cpu/smt, meaning that CPU hybrid capabilities
and related features like EAS (Energy Aware Scheduling) may become
dynamically eligible. Since the driver provides sysfs interfaces
for cpufreq_driver switching, merely performing a refresh is
insufficient.

To address this issue, remove the refresh-related logic.

Fixes: 929ebc93ccaa ("cpufreq: intel_pstate: Set asymmetric CPU capacity on hybrid systems")
Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 drivers/cpufreq/intel_pstate.c | 29 ++---------------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index ec4abe374573..76fb79b8068a 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1140,22 +1140,12 @@ static void hybrid_refresh_cpu_capacity_scaling(void)
 	hybrid_register_all_perf_domains();
 }
 
-static void hybrid_init_cpu_capacity_scaling(bool refresh)
+static void hybrid_init_cpu_capacity_scaling(void)
 {
 	/* Bail out if enabling capacity-aware scheduling is prohibited. */
 	if (no_cas)
 		return;
 
-	/*
-	 * If hybrid_max_perf_cpu is set at this point, the hybrid CPU capacity
-	 * scaling has been enabled already and the driver is just changing the
-	 * operation mode.
-	 */
-	if (refresh) {
-		hybrid_refresh_cpu_capacity_scaling();
-		return;
-	}
-
 	/*
 	 * On hybrid systems, use asym capacity instead of ITMT, but because
 	 * the capacity of SMT threads is not deterministic even approximately,
@@ -1171,18 +1161,6 @@ static void hybrid_init_cpu_capacity_scaling(bool refresh)
 	}
 }
 
-static bool hybrid_clear_max_perf_cpu(void)
-{
-	bool ret;
-
-	guard(mutex)(&hybrid_capacity_lock);
-
-	ret = !!hybrid_max_perf_cpu;
-	hybrid_max_perf_cpu = NULL;
-
-	return ret;
-}
-
 static void __intel_pstate_get_hwp_cap(struct cpudata *cpu)
 {
 	u64 cap;
@@ -3428,7 +3406,6 @@ static void intel_pstate_driver_cleanup(void)
 
 static int intel_pstate_register_driver(struct cpufreq_driver *driver)
 {
-	bool refresh_cpu_cap_scaling;
 	int ret;
 
 	if (driver == &intel_pstate)
@@ -3441,8 +3418,6 @@ static int intel_pstate_register_driver(struct cpufreq_driver *driver)
 
 	arch_set_max_freq_ratio(global.turbo_disabled);
 
-	refresh_cpu_cap_scaling = hybrid_clear_max_perf_cpu();
-
 	intel_pstate_driver = driver;
 	ret = cpufreq_register_driver(intel_pstate_driver);
 	if (ret) {
@@ -3452,7 +3427,7 @@ static int intel_pstate_register_driver(struct cpufreq_driver *driver)
 
 	global.min_perf_pct = min_perf_pct_min();
 
-	hybrid_init_cpu_capacity_scaling(refresh_cpu_cap_scaling);
+	hybrid_init_cpu_capacity_scaling();
 
 	return 0;
 }
-- 
2.25.1


