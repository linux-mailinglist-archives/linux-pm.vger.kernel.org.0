Return-Path: <linux-pm+bounces-8986-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B8D9049AC
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 05:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27B561F23DEC
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 03:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246D7171AB;
	Wed, 12 Jun 2024 03:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PgT5OBo8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90016F4FA;
	Wed, 12 Jun 2024 03:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718163167; cv=none; b=pIPknoM0PFfscDLl97jQtwBaorqtbEql27+qcWhGdWX4hX0C0CfR3sPMvuqgSn+vsWYiNderPOgt0V1dCCQEZqnN22N83d/fA7LzqZFCtfRN3eZ3YgkoSjLPo0z73AE6HxNWw4aM8swdrajFFZVnLMQzeq3wpCxAntEaZvWlXpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718163167; c=relaxed/simple;
	bh=F5s5rHsvm5ppr5kjfSxyXYdx+aHaZueLGQxaUiH4j8I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JsHWsmfrmh0qQzK1h+lwc1l4/POl7IaGzyCbeid/192KK8Sw1mgwvr3xhF4Y8pX1vN7t9Pozse1Tcqq1Yr1bM62b0w8e6SiZOlGZY+Cl2QbPgMWBLFg62BbFl2EZThalMGNM2LTfMnW+61YnmUzukIkN5HDd1Qs0n97hgoTmdWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=PgT5OBo8; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 468d685c286c11efa54bbfbb386b949c-20240612
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=NO6bpvyMsNeG63MLNx3I+2NeqQaoc55tIRVNhQA2Xns=;
	b=PgT5OBo8jbtm9lPk7hGWklwOBfEoeS2eZ+Hnky/u4/Bb7aCqvm26wreLGdqmt1mLo+RQv7iKGMpMrxIMSFiWZMdgeM5Nnz77ive6cbnVeWkI56+bolR/8TkdnYzuIaAR0b3pO0XC3ti5oDb8gGoxr0sHwWqERe7ABIpd94Vxtvo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:9b1b2e01-e334-4a86-9f53-57b6351e7411,IP:0,U
	RL:0,TC:0,Content:30,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:30
X-CID-META: VersionHash:393d96e,CLOUDID:fa407844-4544-4d06-b2b2-d7e12813c598,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 468d685c286c11efa54bbfbb386b949c-20240612
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <poshao.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1385990083; Wed, 12 Jun 2024 11:31:37 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 12 Jun 2024 11:31:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 12 Jun 2024 11:31:35 +0800
From: PoShao Chen <poshao.chen@mediatek.com>
To: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <clive.lin@mediatek.com>, <ccj.yeh@mediatek.com>,
	<ching-hao.hsu@mediatek.com>, <poshao.chen@mediatek.com>
Subject: [PATCH v2] cpufreq: Fix per-policy boost behavior after CPU hotplug
Date: Wed, 12 Jun 2024 11:31:12 +0800
Message-ID: <20240612033112.29343-1-poshao.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--6.840000-8.000000
X-TMASE-MatchedRID: PCFkxA7eE672aJrWQVCF0KEtILqFekmX7h2RrsKOiu27+NPPxj+R6px5
	iJEn6aBLCrMpAjvWT1MRhs8ZJJXuwmNvKIW9g24oUIhTTahb7dXnibXdwxr2RxHfiujuTbedNwa
	LRw5VVqxOFu8ssjxG80fE2v2BFLqnEJHpQ2Y9lUTKl4yJoI+fG7yDcEt9eiFZ+3n3Z6rbGhPu9+
	Mep8zDYpwUBKMsw7bNsGRzEHTW2nEfE8yM4pjsDwtuKBGekqUpOlxBO2IcOBYvZJK/Qy7EE+x07
	XKPLh8WePSBYVuZx7CCw/Xp9CiOQ6eg4w9OKN6P
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.840000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: D0D4F7DDEC53A321E553FECA15D2061121DC6F439E42DE1535662CD0C81FDB4B2000:8

This patch fixes the behavior of the cpufreq boost when the
global boost flag is toggled during CPU hotplug offline. This action
previously led to incorrect scaling_max_freq values when the CPU was
brought back online. The issue also manifested as incorrect
scaling_cur_freq under the performance governor.

For example, after the following operations, even if the global boost
is disabled, the resulting scaling_max_freq and scaling_cur_freq
will still reflect the settings of an enabled boost.

$ echo performance > /sys/devices/system/cpu/cpufreq/policy7/scaling_governor
$ cat /sys/devices/system/cpu/cpufreq/policy7/scaling_cur_freq
3200000
$ cat /sys/devices/system/cpu/cpufreq/policy7/scaling_max_freq
3200000

$ echo 1 > /sys/devices/system/cpu/cpufreq/boost
$ cat /sys/devices/system/cpu/cpufreq/policy7/scaling_cur_freq
3250000
$ cat /sys/devices/system/cpu/cpufreq/policy7/scaling_max_freq
3250000

$ echo 0 > /sys/devices/system/cpu/cpu7/online
$ echo 0 > /sys/devices/system/cpu/cpufreq/boost
$ echo 1 > /sys/devices/system/cpu/cpu7/online
$ cat /sys/devices/system/cpu/cpufreq/policy7/scaling_cur_freq
3250000
$ cat /sys/devices/system/cpu/cpufreq/policy7/scaling_max_freq
3250000

Signed-off-by: PoShao Chen <poshao.chen@mediatek.com>

---
V1 -> V2: Adjusted log messages and fixed build error.

Link:
  https://lore.kernel.org/all/20240611115920.28665-1-poshao.chen@mediatek.com/
---
 drivers/cpufreq/cpufreq.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a45aac17c20f..faadae05bc8a 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1495,6 +1495,35 @@ static int cpufreq_online(unsigned int cpu)
 
 		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
 				CPUFREQ_CREATE_POLICY, policy);
+	} else {
+		/*
+		 * Call freq_qos_update_request() for the per-policy boost flag mirror
+		 * the cpufreq_driver boost during hotplug online.
+		 * Register an online callback if the default mirroring of the global
+		 * boost setting is not intended.
+		 */
+		if (!cpufreq_driver->online) {
+			ret = freq_qos_update_request(policy->max_freq_req, policy->max);
+			if (ret)
+				pr_err("%s: freq qos update failed\n", __func__);
+		} else {
+			/*
+			 * Let the per-policy boost flag mirror the cpufreq_driver
+			 * boost if an illegal state occurs after hotplug
+			 */
+			if (policy->boost_enabled && !cpufreq_driver->boost_enabled) {
+				pr_info("%s: local boost flag mirror the global boost\n",
+					__func__);
+				policy->boost_enabled = cpufreq_driver->boost_enabled;
+				ret = cpufreq_driver->set_boost(policy,
+							cpufreq_driver->boost_enabled);
+				if (ret) {
+					policy->boost_enabled = !policy->boost_enabled;
+					pr_err("%s: Failed to mirror the global boost flag\n",
+					       __func__);
+				}
+			}
+		}
 	}
 
 	if (cpufreq_driver->get && has_target()) {
-- 
2.18.0


