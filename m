Return-Path: <linux-pm+bounces-34527-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 998E1B543FD
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 09:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBCB6188CD2D
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 07:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632E72C2369;
	Fri, 12 Sep 2025 07:35:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B496261393;
	Fri, 12 Sep 2025 07:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757662525; cv=none; b=MyDNraeV7XUQyxOacW6OD/dr9dMB+vLvzLZswUeO+TxUUODYq6ryXRvH5dOmqpobqi4kNxat9Ggy0namtjyI2COdID3PdFEHQqgICweZ2GZ6as/5tMkyk6AMZm8ESP40EdjiUhWHhEVqY5g2D5X4lB1E7zTs7FpvBnRqDN+WviY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757662525; c=relaxed/simple;
	bh=7IPfACRdpSZ7D75hs7sK1nm6Ya8/sZT+rnsWbIuVTKY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ohUNzoxjEmdgTFBt6Hl+yxNDFPWGJdFR4kcWaGpGphbqAI+XHY8OB7eKknOTxT6scQtLpJs2ptgOTt5cW2oZbDjaUZzACoCVJ7p7DQNoyplvVb9EDcHxhGKZSkutaWUguw/UeNhxQr0aexnHgRDAhHHVGiMI2aMGmtoP16+SZ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0556282c8fab11f0b29709d653e92f7d-20250912
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR, DN_TRUSTED
	SRC_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:164ef7b0-15c0-49e5-8ec6-deb8b8ff4385,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.1.45,REQID:164ef7b0-15c0-49e5-8ec6-deb8b8ff4385,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:6493067,CLOUDID:9d423894fc4ca7d662ffb4edc7f9ea16,BulkI
	D:250912153516235QZX6V,BulkQuantity:0,Recheck:0,SF:17|19|23|38|43|66|74|78
	|102|850,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,Q
	S:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,
	ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 0556282c8fab11f0b29709d653e92f7d-20250912
X-User: tianyaxiong@kylinos.cn
Received: from localhost.localdomain [(175.2.17.114)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1921609153; Fri, 12 Sep 2025 15:35:14 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: srinivas.pandruvada@linux.intel.com,
	lenb@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH] cpufreq: intel_pstate: Use likely() optimization in intel_pstate_sample()
Date: Fri, 12 Sep 2025 15:35:02 +0800
Message-Id: <20250912073502.743735-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment above the condition `if (cpu->last_sample_time)` clearly
indicates that the branch is taken for the vast majority of invocations
after the first sample in a cycle. The first sample is a one-time
initialization case.

Add likely() hint to the condition to improve branch prediction for
this performance-critical path in intel_pstate_sample().

Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 drivers/cpufreq/intel_pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 2519eb527468..d540f2ab9a52 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2531,7 +2531,7 @@ static inline bool intel_pstate_sample(struct cpudata *cpu, u64 time)
 	 * that sample.time will always be reset before setting the utilization
 	 * update hook and make the caller skip the sample then.
 	 */
-	if (cpu->last_sample_time) {
+	if (likely(cpu->last_sample_time)) {
 		intel_pstate_calc_avg_perf(cpu);
 		return true;
 	}
-- 
2.25.1


