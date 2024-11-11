Return-Path: <linux-pm+bounces-17302-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 568009C38E5
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 08:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5DC1F21872
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 07:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ACE1581F2;
	Mon, 11 Nov 2024 07:11:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36861581E0
	for <linux-pm@vger.kernel.org>; Mon, 11 Nov 2024 07:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731309093; cv=none; b=p93emwgbxQl0VOmNDz+SpNpGldIDRNy1KIh4a8k5gE7Dgk2YCyUV1TDVh0WRJpSK0/2CwTLp4Z4mYMhoLfrOhg7Cg21hfz4K1GoGB4RcIjUsv3h1g6RQeTHFdqIY9l4chSvgFzWpZaQXKk5N0JqCaO/GEzDqy9v5Zxy4WYXCHrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731309093; c=relaxed/simple;
	bh=89ABexJWAQ4xZKofdldXNTx/6JbxW/Rtkxu+Mgpr2m4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=MEj9NoRf1yFs7BnqsOe9zytwIG3FH0B9XYCTybNR8Q3jvQC+o5k3ATH1F3Q1DK8p8Z/dmcjY14IWxX3O5vQtvUedVlEiA108av1jGWYouhb41hmfi4MxPtYg9NjCJ1FMBRpe3cqbJhgSYU+ITbGfkIrZsm3AcbvcPh1VFhAjQJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 23f73eb49ffc11efa216b1d71e6e1362-20241111
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_LANG, HR_MAILER_MTBG, HR_SJ_DIGIT_LEN, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED
	SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1
	AMN_GOOD, AMN_C_TI, AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:05e649ac-4dd5-43cc-a259-af30f9c03b7e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-INFO: VERSION:1.1.38,REQID:05e649ac-4dd5-43cc-a259-af30f9c03b7e,IP:0,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:83d954c0899da4a2f04b3bbdf081bdcf,BulkI
	D:241111151116HCE44RAY,BulkQuantity:0,Recheck:0,SF:38|17|19|66|841|102,TC:
	nil,Content:1,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 23f73eb49ffc11efa216b1d71e6e1362-20241111
X-User: lijun01@kylinos.cn
Received: from [172.30.70.202] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1013789319; Mon, 11 Nov 2024 15:11:15 +0800
Message-ID: <7df8dcd0-c242-5001-b31b-4192afdf7a68@kylinos.cn>
Date: Mon, 11 Nov 2024 15:11:11 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: lijun <lijun01@kylinos.cn>
Subject: [PATCH V2] power: add PM_SUSPEND_MAX in pm_suspend_target_state
To: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
 linux-pm@vger.kernel.org
Cc: lijun01@kylinos.cn
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

 From 65249bb9b422d249c972eac66b763c4c7f30bbce Mon Sep 17 00:00:00 2001
From: Li Jun <lijun01@kylinos.cn>
Date: Fri, 1 Nov 2024 16:31:33 +0800
Subject: [PATCH] power: add PM_SUSPEND_MAX in pm_suspend_target_state

The system is switching to  disk sleep, when executing
to freeze_processes(),one of processes may be get the
system state, but the correct state  must after
suspend_devices_and_enter(state) ,so push this patch.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
  kernel/power/hibernate.c | 3 +++
  1 file changed, 3 insertions(+)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 1f87aa01ba44..c7c0e7c51985 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -766,6 +766,8 @@ int hibernate(void)
     }

     pr_info("hibernation entry\n");
+   pm_suspend_target_state = PM_SUSPEND_MAX;
+
     pm_prepare_console();
     error = pm_notifier_call_chain_robust(PM_HIBERNATION_PREPARE, 
PM_POST_HIBERNATION);
     if (error)
@@ -846,6 +848,7 @@ int hibernate(void)
     hibernate_release();
   Unlock:
     unlock_system_sleep(sleep_flags);
+   pm_suspend_target_state = PM_SUSPEND_ON;
     pr_info("hibernation exit\n");

     return error;
-- 
2.34.1


