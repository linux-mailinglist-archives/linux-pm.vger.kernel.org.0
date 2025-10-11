Return-Path: <linux-pm+bounces-35927-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB5DBCF0FD
	for <lists+linux-pm@lfdr.de>; Sat, 11 Oct 2025 09:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1CCF427B06
	for <lists+linux-pm@lfdr.de>; Sat, 11 Oct 2025 07:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A29223DC6;
	Sat, 11 Oct 2025 07:24:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBD232C8B;
	Sat, 11 Oct 2025 07:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760167477; cv=none; b=Q8VrGUY4eFGZKfdDhLaq6KQPgEOmINDzqbQz1pgTx3haCPZoN1WLZBY/0swPXAGaSbw27BS/j0sBYTNaAwY7OPODG8N9oPclb9+7yg7XrfYGysVgVavwVF72I8Kh6kSVA79O0e9meJde9tALLg19XvUG7CzPjULpuppbGpP19GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760167477; c=relaxed/simple;
	bh=FZxoFQlLKoz4Kv+CDkIGI3+HJGesu2Kt+FmbbodbE8A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mFGG6rEYid6kLMNGSgnjH/tuq4YHGah1UVHmjvwL695FpDJiW44LfEtgOJBBxgQNT9Ob55MuV6DgJLO9x+MlOkZFGQI9S9oBcB15yl74hTH0yPMRxNHNrr9SVLL0XYK/8EF0iLsY4QTaMI7A9j0RNrnfrfuiVNJP0pcM9Tg6C10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 50c4e4b8a67311f0a38c85956e01ac42-20251011
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:ebd9312f-2e9b-43fe-8d37-32deca6b1633,IP:0,UR
	L:0,TC:0,Content:24,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:24
X-CID-META: VersionHash:a9d874c,CLOUDID:dbff7d520c9464dd929b110664d88d67,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:4|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 50c4e4b8a67311f0a38c85956e01ac42-20251011
X-User: zhangzihuan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 133307661; Sat, 11 Oct 2025 15:24:25 +0800
From: zzhwaxy <zhangzihuan@kylinos.cn>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: zhenglifeng <zhenglifeng1@huawei.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v1] cpufreq: preserve freq_table_sorted across suspend/hibernate
Date: Sat, 11 Oct 2025 15:24:20 +0800
Message-Id: <20251011072420.11495-1-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihuan Zhang <zhangzihuan@kylinos.cn>

During S3/S4 suspend and resume, cpufreq policies are not freed or
recreated; the freq_table and policy structure remain intact. However,
set_freq_table_sorted() currently resets policy->freq_table_sorted to
UNSORTED unconditionally, which is unnecessary since the table order
does not change across suspend/resume.

This patch adds a check to skip validation if policy->freq_table_sorted
is already ASCENDING or DESCENDING. This avoids unnecessary traversal
of the frequency table on S3/S4 resume or repeated online events,
reducing overhead while preserving correctness.

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
---
 drivers/cpufreq/cpufreq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 852e024facc3..4a27f6cb07d3 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1421,9 +1421,12 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
 		 * If there is a problem with its frequency table, take it
 		 * offline and drop it.
 		 */
-		ret = cpufreq_table_validate_and_sort(policy);
-		if (ret)
-			goto out_offline_policy;
+		if (policy->freq_table_sorted != CPUFREQ_TABLE_SORTED_ASCENDING &&
+		    policy->freq_table_sorted != CPUFREQ_TABLE_SORTED_DESCENDING) {
+			ret = cpufreq_table_validate_and_sort(policy);
+			if (ret)
+				goto out_offline_policy;
+		}
 
 		/* related_cpus should at least include policy->cpus. */
 		cpumask_copy(policy->related_cpus, policy->cpus);
-- 
2.25.1


