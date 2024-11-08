Return-Path: <linux-pm+bounces-17173-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E039C1684
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 07:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2839C1C22BCF
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 06:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0501D0E0A;
	Fri,  8 Nov 2024 06:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JXgfIhOe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AC61CCB49;
	Fri,  8 Nov 2024 06:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731047996; cv=none; b=OfHSRRY9EbbUpIpCnT9oUdPNAXdYl+I+pHFpYsAjD8Ia8st6f4uvB6cjOEJzhCl91egNIrCxzboqIwnJWQIPGEjrEnqnA2ITfAFIuexyHOhYfm+C0ivdM3+esMii/OmXrtq5I1rDd8I0hrNozIPCs9y3/ulVnxJfH/JktdVFps4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731047996; c=relaxed/simple;
	bh=zI9U7yuhxyD8ClEmKsIqlY+TLWEdinb0ARV7SO5LrUA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tzXGw3zkiBThInpBRVue98B/WYr0OsVE8IPONO53KVPuehpTTh+dyL7qvGlKKXqnTfAYYgZE7+7Wl9qWQjGNI8A6EE54iySb1kNZKjmw+mWGPw11GVGpH0PT+ZZgoZmnjQvj7/+lC3y/g4pNn94uKdBq8gY2hL+eh7CwgTdIvHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=JXgfIhOe; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 40fa65e89d9c11efbd192953cf12861f-20241108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ZzjJXM9+qf5x42j7BNch2NJ3M8H32qombIvcqOyyZAA=;
	b=JXgfIhOeAB/wD20FVgs5/Az+2uItJUFy7u3//MOabMxR093cQU/T4N3NQeqHh297QiMYgKdnYbw8fWXNYu+2h4ac+uGaJw0jMFkq2plltLgMSKX8XluDGEwiuP29vzM1UvsWNJf+mntZpQWijMzYp4PdxiMtPs84GN6ncoseD4w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:1d7ccae4-aba0-4101-92d5-af33c4075d29,IP:0,U
	RL:0,TC:0,Content:28,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:28
X-CID-META: VersionHash:b0fcdc3,CLOUDID:79ffb8ca-91e6-4060-9516-6ba489b4e2dc,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 40fa65e89d9c11efbd192953cf12861f-20241108
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <chun-jen.tseng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 639485831; Fri, 08 Nov 2024 14:39:50 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 8 Nov 2024 14:39:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 8 Nov 2024 14:39:48 +0800
From: Mark Tseng <chun-jen.tseng@mediatek.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin
 Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<chun-jen.tseng@mediatek.com>
Subject: [PATCH v2 3/4] cpufreq: mediatek: Add CPUFREQ_ASYNC_NOTIFICATION flag
Date: Fri, 8 Nov 2024 14:39:41 +0800
Message-ID: <20241108063942.19744-4-chun-jen.tseng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20241108063942.19744-1-chun-jen.tseng@mediatek.com>
References: <20241108063942.19744-1-chun-jen.tseng@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Add CPUFREQ_ASYNC_NOTIFICATION flages for cpufreq policy because some of
process will get CPU frequency by cpufreq sysfs node. It may get wrong
frequency then call cpufreq_out_of_sync() to fixed frequency.

Signed-off-by: Mark Tseng <chun-jen.tseng@mediatek.com>
---
 drivers/cpufreq/mediatek-cpufreq.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 6b3cd2b803bf..3369bdd9a348 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -209,12 +209,16 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 	struct dev_pm_opp *opp;
 	long freq_hz, pre_freq_hz;
 	int vproc, pre_vproc, inter_vproc, target_vproc, ret;
+	struct cpufreq_freqs freqs;
 
 	mutex_lock(&mtk_policy_lock);
 
 	inter_vproc = info->intermediate_voltage;
+	pre_freq_hz = policy->cur * 1000;
 
-	pre_freq_hz = clk_get_rate(cpu_clk);
+	freqs.old = policy->cur;
+	freqs.new = freq_table[index].frequency;
+	cpufreq_freq_transition_begin(policy, &freqs);
 
 	if (unlikely(info->pre_vproc <= 0))
 		pre_vproc = regulator_get_voltage(info->proc_reg);
@@ -309,6 +313,7 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 	info->current_freq = freq_hz;
 
 out:
+	cpufreq_freq_transition_end(policy, &freqs, false);
 	mutex_unlock(&mtk_policy_lock);
 
 	return ret;
@@ -632,6 +637,7 @@ static unsigned int mtk_cpufreq_get(unsigned int cpu)
 static struct cpufreq_driver mtk_cpufreq_driver = {
 	.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK |
 		 CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
+		 CPUFREQ_ASYNC_NOTIFICATION |
 		 CPUFREQ_IS_COOLING_DEV,
 	.verify = cpufreq_generic_frequency_table_verify,
 	.target_index = mtk_cpufreq_set_target,
-- 
2.45.2


