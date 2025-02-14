Return-Path: <linux-pm+bounces-22064-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A23A35819
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 08:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DA7A16E999
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 07:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F43215770;
	Fri, 14 Feb 2025 07:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="klcsRgQl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621A51C862B;
	Fri, 14 Feb 2025 07:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739519042; cv=none; b=fYFnLKSGQ3LAyN82zFXTW5LmmzY96KvD5bOFx+FN6EhPYCw7mkQv/BZ3XUTwG6Nc2A9ksKURI2CRLlW2KRUTrNfZnUzJid/DYCuh7qwdMJxrUobaDInravsOkOweVOmu2GtxNzeyAnJH0za0pxEbDU54jJ8y3n3dQKK9STlXD6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739519042; c=relaxed/simple;
	bh=JhIZhzy/VmNLEI+FVSk0Y8ZZKnaxYR5+1TNzTb1xyd0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LE2fEbfTekBKLk37bh4IDygKPSgbwx6gPjEcI+cy8GXi1kpHnzOWWVNOYnvX+XW2htzsXZt090AnHLt2ulUzejXkFLweiEQ4Woa17WcVvsKn20uygFlcw0aJt33kX5AROeIdCtk2OVuD3T3AqkxyTJoIQ9N9izhoBL3JroNUOVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=klcsRgQl; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 71512dbeeaa711efbd192953cf12861f-20250214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=9bd1SEl58hRjLit531fXO640LwjMPruVn6dM/zQMBCk=;
	b=klcsRgQlX7FFDSfPwegFRdsmfui3f8a7uIiCkDVP1SFLrPFoaaSboGMPj9Es9IqTi9m5scQ+ovUBgI+ZmrqovSIwj72C3a+IbZokNpOtKw255GnieX72imLjhPaqFr2jSF8nOMzHQnguZj/1mTjri8R3JKdpcOqV5fboAxfV33w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:fe384a7b-3daf-4329-8c81-1701c5398b67,IP:0,U
	RL:0,TC:0,Content:28,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:28
X-CID-META: VersionHash:60aa074,CLOUDID:90bcbe24-96bd-4ac5-8f2e-15aa1ef9defa,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:4|50,EDM:-3
	,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 71512dbeeaa711efbd192953cf12861f-20250214
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <chun-jen.tseng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1097142833; Fri, 14 Feb 2025 15:43:55 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 14 Feb 2025 15:43:53 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 14 Feb 2025 15:43:53 +0800
From: Mark Tseng <chun-jen.tseng@mediatek.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, "Kyungmin
 Park" <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<chun-jen.tseng@mediatek.com>
Subject: [PATCH v3 2/3] cpufreq: mediatek: Add CPUFREQ_ASYNC_NOTIFICATION flag
Date: Fri, 14 Feb 2025 15:43:33 +0800
Message-ID: <20250214074353.1169864-3-chun-jen.tseng@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250214074353.1169864-1-chun-jen.tseng@mediatek.com>
References: <20250214074353.1169864-1-chun-jen.tseng@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add CPUFREQ_ASYNC_NOTIFICATION flages for cpufreq policy because some of
process will get CPU frequency by cpufreq sysfs node. It may get wrong
frequency then call cpufreq_out_of_sync() to fixed frequency.

Signed-off-by: Mark Tseng <chun-jen.tseng@mediatek.com>
---
 drivers/cpufreq/mediatek-cpufreq.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 07d5958e106a..68fcb6fcbe48 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -209,12 +209,12 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 	struct dev_pm_opp *opp;
 	long freq_hz, pre_freq_hz;
 	int vproc, pre_vproc, inter_vproc, target_vproc, ret;
+	struct cpufreq_freqs freqs;
 
 	mutex_lock(&mtk_policy_lock);
 
 	inter_vproc = info->intermediate_voltage;
-
-	pre_freq_hz = clk_get_rate(cpu_clk);
+	pre_freq_hz = policy->cur * 1000;
 
 	if (unlikely(info->pre_vproc <= 0))
 		pre_vproc = regulator_get_voltage(info->proc_reg);
@@ -307,6 +307,10 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 	}
 
 	info->current_freq = freq_hz;
+	freqs.old = policy->cur;
+	freqs.new = freq_table[index].frequency;
+	cpufreq_freq_transition_begin(policy, &freqs);
+	cpufreq_freq_transition_end(policy, &freqs, false);
 
 out:
 	mutex_unlock(&mtk_policy_lock);
@@ -629,6 +633,7 @@ static unsigned int mtk_cpufreq_get(unsigned int cpu)
 static struct cpufreq_driver mtk_cpufreq_driver = {
 	.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK |
 		 CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
+		 CPUFREQ_ASYNC_NOTIFICATION |
 		 CPUFREQ_IS_COOLING_DEV,
 	.verify = cpufreq_generic_frequency_table_verify,
 	.target_index = mtk_cpufreq_set_target,
-- 
2.45.2


