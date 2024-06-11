Return-Path: <linux-pm+bounces-8944-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DBC903B52
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 14:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7192BB29868
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 12:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E4917C9EE;
	Tue, 11 Jun 2024 11:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="lExcCKRe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E120817B4F9;
	Tue, 11 Jun 2024 11:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107194; cv=none; b=PcVBoWZOw6WG8U5dkVi/MOP/8BqLah9M9pfiel5XliRqAci2Ei6yaz8kL2MZ7TRt3iM06XHD1J1mviHLXV/XiwR7QiEsEjA/hCgUvD4zYoW9TVqB1T5Viy4pySoWfUURfSJMt5y2heLVsd6IwPPICX5iDJrgDamww+Osd0CC898=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107194; c=relaxed/simple;
	bh=bD1uQZQ6VtPXlxktaFO9REv2bZmj6NZhK+/8EWaPwIE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oZp25UyUfZ+//rfOUJ6YZMPWSYYQeFwOp34f8C42EtfYBIoXNZ9SZsnvrv9ShEUHeNM6fVa4cx1M1RS+j98i70QC6+ObSRdHvqhxHZ4ICMgtZ8pJNxV4j4c/b5DH8q7FLdNygpjdwEaYHZoAH8VliUGMNS0Q91sHePOk5lemtmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=lExcCKRe; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1885960a27ea11efa54bbfbb386b949c-20240611
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=OQ8chaPOw4A6iAHKeGgGa/xCeVHWlZM1KN2sfBtT4YM=;
	b=lExcCKReTdlfKb03kImMHS/DYm1whSH6LjMcXEvmgiy+YPltrNADawmpj3STAZ3/Zlb2n5bfPhVRCXA6uUY8D/e7uAHMOEqBpdneCtAkaosALwg2DyfSrsiaS85AqfIVun8ABH6g14pdVHaYE6O0JAPzSmmunoY8/ZD12JdVdI8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:556ab7fc-b7bd-4eb7-b1fd-cfd83c392a95,IP:0,U
	RL:0,TC:0,Content:34,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:34
X-CID-META: VersionHash:393d96e,CLOUDID:06de7144-4544-4d06-b2b2-d7e12813c598,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1885960a27ea11efa54bbfbb386b949c-20240611
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <poshao.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1645407644; Tue, 11 Jun 2024 19:59:45 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 11 Jun 2024 19:59:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 11 Jun 2024 19:59:43 +0800
From: PoShao Chen <poshao.chen@mediatek.com>
To: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <clive.lin@mediatek.com>, <ccj.yeh@mediatek.com>,
	<ching-hao.hsu@mediatek.com>, <poshao.chen@mediatek.com>
Subject: [PATCH] cpufreq: Fix per-policy boost behavior after CPU hotplug
Date: Tue, 11 Jun 2024 19:59:20 +0800
Message-ID: <20240611115920.28665-1-poshao.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.915700-8.000000
X-TMASE-MatchedRID: angWuI+ZklD2aJrWQVCF0KEtILqFekmX7h2RrsKOiu27+NPPxj+R6px5
	iJEn6aBLCrMpAjvWT1MRhs8ZJJXuwmNvKIW9g24oA9lly13c/gHt/okBLaEo+MUmcSma304T42W
	Ouy++C8Pg7PmXyAh8kagjAnjVJgVlszLAY5oHhBCzLD5kmcW6ZFY5BBJri9sdmyiLZetSf8mfop
	0ytGwvXiq2rl3dzGQ1GpeevGsoI5fZBtMWO+YKbXYGrvKGRAu9Q0lfOr+bFrzC5D54Rup5JQ2Gg
	aVtth9BFEdlR3DDyofDpl0rUP4mccRofWagfcNVy7ksesgLCKAXRoPmWO3jekxwdkPqCq7vDEyN
	+J8hd+jCS9WgDXVPCn7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.915700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 67E9FD33A2FD7A6F82D0C102646374AC708AF05208AE82E3C5422A827FEE1CB92000:8

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
 drivers/cpufreq/cpufreq.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a45aac17c20f..1f067d91a0b0 100644
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
+				pr_info("%s: per-policy boost flag mirror the cpufreq_driver
+					boost\n", __func__);
+				policy->boost_enabled = cpufreq_driver->boost_enabled;
+				ret = cpufreq_driver->set_boost(policy,
+							cpufreq_driver->boost_enabled);
+				if (ret) {
+					policy->boost_enabled = !policy->boost_enabled;
+					pr_err("%s: per-policy boost flag mirror the cpufreq_driver
+						boost failed\n", __func__);
+				}
+			}
+		}
 	}
 
 	if (cpufreq_driver->get && has_target()) {
-- 
2.18.0


