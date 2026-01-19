Return-Path: <linux-pm+bounces-41068-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7C1D3A058
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 08:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98E2C303AE87
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 07:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF72C33710C;
	Mon, 19 Jan 2026 07:41:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755D027991E;
	Mon, 19 Jan 2026 07:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768808491; cv=none; b=Is0apiHEj4W2lgMZ1bNK5ytt180YNWpFYXpoPMJqzoL28ygIFyH7jzZ9Vm458qDWrFQ4rpHCibPE3+1w7e9qYbNiTxjVU7NS1G355ID/sA7L5tbPeCW6ridIbTn9RbSX+xljLt5ENGGX+1CVldIHWwDbqnvQETFecoxc8oWPn80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768808491; c=relaxed/simple;
	bh=7nsHIS/QnVEKFUy1GC/CoEzptIHny4zw23cSYBLtE/w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k8GpnALH0Z4UBes0iGaRh0dhAnUoJ9kFPVqIzibnKnTdukKMgnvNhtp7vaJgLZ7br0AzvshWHnN+c2EYvkRNRZl0jSqc4Mmqx3B88I27KYV/GiYQeGaeVC0K3Cdayk8L5uW8sQhHPClJmHm0QwmvLsXg8Fptsf1rtxxN5X2qetI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3ffa15d2f50a11f0b0f03b4cfa9209d1-20260119
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR, DN_TRUSTED
	SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD_SPF, CIE_UNKNOWN
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:ca55c94c-a0ef-489d-8167-927da7bbc450,IP:10,U
	RL:0,TC:0,Content:29,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:34
X-CID-INFO: VERSION:1.3.6,REQID:ca55c94c-a0ef-489d-8167-927da7bbc450,IP:10,URL
	:0,TC:0,Content:29,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:34
X-CID-META: VersionHash:a9d874c,CLOUDID:6b666443d6d70ef6984d3658ae4b7402,BulkI
	D:260119154123EBY2RLKP,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	850|898,TC:nil,Content:4|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3ffa15d2f50a11f0b0f03b4cfa9209d1-20260119
X-User: tianyaxiong@kylinos.cn
Received: from localhost.localdomain [(175.2.91.64)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1076215843; Mon, 19 Jan 2026 15:41:22 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: srinivas.pandruvada@linux.intel.com,
	lenb@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	ricardo.neri-calderon@linux.intel.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH] cpufreq: intel_pstate: Disable SMT when hybrid systems are enabled
Date: Mon, 19 Jan 2026 15:41:18 +0800
Message-Id: <20260119074118.835922-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When hwp_is_hybrid && !sched_smt_active(), the driver enables
hybrid_capacity_scale and disables ITMT. According to the original code
logic, these related actions are one-time operations; therefore, I
believe the original design intent did not support dynamic runtime
switching.

However, SMT can be toggled via related interfaces in /sys. When SMT is
enabled, the system is no longer hybrid, and the original settings become
incorrect.

To resolve this confusion, permanently disable SMT by calling
cpuhp_smt_disable().

Fixes: 929ebc93ccaa ("cpufreq: intel_pstate: Set asymmetric CPU capacity on hybrid systems")
Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 drivers/cpufreq/intel_pstate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index ec4abe374573..d0274a3ece2d 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1163,6 +1163,11 @@ static void hybrid_init_cpu_capacity_scaling(bool refresh)
 	 */
 	if (hwp_is_hybrid && !sched_smt_active() && arch_enable_hybrid_capacity_scale()) {
 		hybrid_refresh_cpu_capacity_scaling();
+		/*
+		 * Permanently disable SMT to prevent confusion caused by users
+		 * enabling SMT via /sys.
+		 */
+		cpuhp_smt_disable(CPU_SMT_FORCE_DISABLED);
 		/*
 		 * Disabling ITMT causes sched domains to be rebuilt to disable asym
 		 * packing and enable asym capacity and EAS.
-- 
2.25.1


