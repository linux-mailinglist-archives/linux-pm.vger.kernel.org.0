Return-Path: <linux-pm+bounces-35195-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7D7B94E17
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 09:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 405C72E30E6
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 07:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5BB3164C2;
	Tue, 23 Sep 2025 07:56:23 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20D1314B64;
	Tue, 23 Sep 2025 07:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758614183; cv=none; b=mE5ooLd9eio9QUjro0UuxFNRfheXKDFOmuqtQdInh5ETZl4mmr4ZutvWuQ1gf8yZJusGF640ITA0r3Nue5e0nRfN+gvBu5m05mkQUg3digjM0nKW6ufk+0xjNNkZyvFvk4PccsPVB0R6n1aw/WXjEUYYm9SxsoIIOV7HrX3hcWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758614183; c=relaxed/simple;
	bh=cnkx++Shq2jwD04CEqQwNmyfrJmRTtqWhsvAJ5zdpV0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UzcxhLcnaFN/8OXXBUFlTdZSfNIudKjaStkz/Pobyju7RBvZkCl7EGHKT/Nto5IxBFrC2cOZF2W9UkJ7tzGzOoX+QvG/pqLe2haQCsJX8eXlgc4wT/Gnrbr6loMAuf1N8++Pw7fboUsd5b1aUuSRSLvuMbb3F2s5rRCKSxxDuN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c6465822985211f08b9f7d2eb6caa7cf-20250923
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:5d64f1d0-3975-4023-81f6-aa8fbf00f935,IP:0,U
	RL:0,TC:0,Content:30,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:30
X-CID-META: VersionHash:6493067,CLOUDID:6fc2416127f5ecfd634d1a31a7cab7f3,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:4|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c6465822985211f08b9f7d2eb6caa7cf-20250923
X-User: zhangzihuan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 699213372; Tue, 23 Sep 2025 15:56:12 +0800
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: "Rafael J . wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: zhenglifeng <zhenglifeng1@huawei.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v2] cpufreq: Replace pointer subtraction with iteration macros
Date: Tue, 23 Sep 2025 15:55:53 +0800
Message-Id: <20250923075553.45532-1-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cpufreq documentation suggests avoiding direct pointer subtraction
when working with entries in driver_freq_table, as it is relatively
costly. Instead, the recommended approach is to use the provided
iteration macros:

- cpufreq_for_each_valid_entry_idx()

Replace pointer subtraction in freq_table.c with the macros
cpufreq_for_each_entry_idx() and cpufreq_for_each_valid_entry_idx(), as
the index does not need initialization, avoiding unnecessary
computation. This improves code clarity and follows the established
cpufreq coding style.

No functional change intended.

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>

V2:
 - Remove unnecessary initialization for current and remaining follow Rafael's suggestion
---
 drivers/cpufreq/freq_table.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index d5111ee56e38..408fd8fee2e3 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -33,16 +33,17 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy)
 	struct cpufreq_frequency_table *pos, *table = policy->freq_table;
 	unsigned int min_freq = ~0;
 	unsigned int max_freq = 0;
+	unsigned int i;
 	unsigned int freq;
 
-	cpufreq_for_each_valid_entry(pos, table) {
+	cpufreq_for_each_valid_entry_idx(pos, table, i) {
 		freq = pos->frequency;
 
 		if ((!cpufreq_boost_enabled() || !policy->boost_enabled)
 		    && (pos->flags & CPUFREQ_BOOST_FREQ))
 			continue;
 
-		pr_debug("table entry %u: %u kHz\n", (int)(pos - table), freq);
+		pr_debug("table entry %u: %u kHz\n", i, freq);
 		if (freq < min_freq)
 			min_freq = freq;
 		if (freq > max_freq)
@@ -126,7 +127,7 @@ int cpufreq_table_index_unsorted(struct cpufreq_policy *policy,
 	};
 	struct cpufreq_frequency_table *pos;
 	struct cpufreq_frequency_table *table = policy->freq_table;
-	unsigned int freq, diff, i = 0;
+	unsigned int freq, diff, i;
 	int index;
 
 	pr_debug("request for target %u kHz (relation: %u) for cpu %u\n",
-- 
2.25.1


