Return-Path: <linux-pm+bounces-16915-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A09A9BACB2
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 07:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B53B61F21DA5
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 06:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C2A18C340;
	Mon,  4 Nov 2024 06:43:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3669D38F97
	for <linux-pm@vger.kernel.org>; Mon,  4 Nov 2024 06:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730702584; cv=none; b=Swp/uBXVNrCh5rhFPd/JZcKD78nntWjCyAg5gV4YJuoIFfXYUUvGan+ry83VaA3qvxwGFrd8hVFSNPT0xLU7XgJKUNxLxblKCqqstI3JWAjmKYXl69aosxuwk/3JxCjKo04vp7T0/EPQ5ndnm+zwXJoVdiJIZfM8aC2sszPCEjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730702584; c=relaxed/simple;
	bh=XvTQwqrx+XVF/k/xYZjfu8eHuMxUuwWQ+gHmOCQjiMw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Z31fAZVZ2sj1oKNlUnobOphZq4BRQ2YM/E4JdQqlQQTg2PS244jx9OiumMp2zmJwJrSvnXcb2BzX70cgdMGqWRMMK4HW+Pv0817ApFt+JpoIufCRMWLQwVe3oFBf4a5HXvdADrlGDUXn1WOktROYhjUrJueX6vnALCyYf8PNRwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0480b10c9a7811efa216b1d71e6e1362-20241104
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_LANG, HR_MAILER_MTBG, HR_SJ_LANG, HR_SJ_LEN
	HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS
	HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED
	DN_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:ed02c983-8e34-4d76-aa66-28b04f8cc692,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-INFO: VERSION:1.1.38,REQID:ed02c983-8e34-4d76-aa66-28b04f8cc692,IP:0,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:9b4f1dbc7da7118a639aa05c172ae057,BulkI
	D:24110118023733XZGNBA,BulkQuantity:1,Recheck:0,SF:19|66|841|38|17|102,TC:
	nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-UUID: 0480b10c9a7811efa216b1d71e6e1362-20241104
X-User: lijun01@kylinos.cn
Received: from [172.30.70.202] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 241826530; Mon, 04 Nov 2024 14:42:53 +0800
Message-ID: <1276a683-0c83-3ac2-f63c-f62da25863ac@kylinos.cn>
Date: Mon, 4 Nov 2024 14:42:48 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
 linux-pm@vger.kernel.org
Cc: lijun01@kylinos.cn
From: lijun <lijun01@kylinos.cn>
Subject: [PATCH] power: add PM_SUSPEND_MAX in pm_suspend_target_state
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

 From 8196688c40b7ab55418588a29258fc8fb84905a8 Mon Sep 17 00:00:00 2001
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
  kernel/power/suspend.c   | 4 +++-
  2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 1f87aa01ba44..c7c0e7c51985 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -766,6 +766,8 @@ int hibernate(void)
      }

      pr_info("hibernation entry\n");
+    pm_suspend_target_state = PM_SUSPEND_MAX;
+
      pm_prepare_console();
      error = pm_notifier_call_chain_robust(PM_HIBERNATION_PREPARE, 
PM_POST_HIBERNATION);
      if (error)
@@ -846,6 +848,7 @@ int hibernate(void)
      hibernate_release();
   Unlock:
      unlock_system_sleep(sleep_flags);
+    pm_suspend_target_state = PM_SUSPEND_ON;
      pr_info("hibernation exit\n");

      return error;
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 09f8397bae15..e965d29800d4 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -493,7 +493,6 @@ int suspend_devices_and_enter(suspend_state_t state)
      if (!sleep_state_supported(state))
          return -ENOSYS;

-    pm_suspend_target_state = state;

      if (state == PM_SUSPEND_TO_IDLE)
          pm_set_suspend_no_platform();
@@ -584,6 +583,8 @@ static int enter_state(suspend_state_t state)
      }

      pm_pr_dbg("Preparing system for sleep (%s)\n", 
mem_sleep_labels[state]);
+    pm_suspend_target_state = state;
+
      pm_suspend_clear_flags();
      error = suspend_prepare(state);
      if (error)
@@ -603,6 +604,7 @@ static int enter_state(suspend_state_t state)
      pm_pr_dbg("Finishing wakeup.\n");
      suspend_finish();
   Unlock:
+    pm_suspend_target_state = PM_SUSPEND_ON;
      mutex_unlock(&system_transition_mutex);
      return error;
  }
-- 
2.34.1


