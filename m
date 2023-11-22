Return-Path: <linux-pm+bounces-60-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FC67F3F60
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 08:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33F64B20DBB
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 07:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79824208C4;
	Wed, 22 Nov 2023 07:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Sz7JGNi9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5F1F9;
	Tue, 21 Nov 2023 23:59:22 -0800 (PST)
X-UUID: 07c160b4890d11eea33bb35ae8d461a2-20231122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=tjhi/K/EhvYr1Lx5fBNjjJus9/yYhqhMddT4+MH2T8E=;
	b=Sz7JGNi9zi1lbC7Ih3tFU3dTOb7sTARIsQm+QBhpdMWSPzXrI5X+8YdSH2MuqQLgDo+on+D4HbTrhXN0STojaXiKqi5KxGZPg+Lh0CLmNFp9OGk+Q0UvOJJKvB5jFnq9CVugLNKyZ0c6IiaqS8g9TI0i1DAQQmQFdE+9j9W/XGg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:612889fe-36b5-4ab4-bb20-16dd71dc5a26,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:364b77b,CLOUDID:5668d1fc-4a48-46e2-b946-12f04f20af8c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 07c160b4890d11eea33bb35ae8d461a2-20231122
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <chris.feng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1814399489; Wed, 22 Nov 2023 15:59:15 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 22 Nov 2023 15:59:12 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 22 Nov 2023 15:59:11 +0800
From: Chris Feng <chris.feng@mediatek.com>
To: <rafael@kernel.org>, <pavel@ucw.cz>, <len.brown@intel.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@kernel.org>, <hua.yang@mediatek.com>, <ting.wang@mediatek.com>,
	<liang.lu@mediatek.com>, <chetan.kumar@mediatek.com>, Chris Feng
	<chris.feng@mediatek.com>
Subject: [PATCH v3] PM: hibernate: Avoid missing wakeup events during hibernation
Date: Wed, 22 Nov 2023 15:59:08 +0800
Message-ID: <20231122075908.160929-1-chris.feng@mediatek.com>
X-Mailer: git-send-email 2.17.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--6.234600-8.000000
X-TMASE-MatchedRID: gLdsEUOy0hNOgDDV7TiL3UhwlOfYeSqxuCESrx7wlnJ/y29NnT7OA7CQ
	uJto3I58h3AZ1hceMeKIgaYq5OQMhaiQBIWNRE3ZVU3yVpaj3QzuHZGuwo6K7fgnJH5vm2+gYxq
	mcULrxeZTE8AzcnZBquJQGiBsCtAIbeOSMcxEZ1oD2WXLXdz+Afi4nVERfgwdCqIJhrrDy28fmy
	nNioMIj+6/aJF7n+8kHwkV/eq61IT8a7PjRR3cpB3EEAbn+GRbD+LwVja9M4GbKItl61J/yZ+in
	TK0bC9eKrauXd3MZDVOqcOm3C2NvWGVNMXvAToyRMPuRSWTPC2P1OL0DXy7dsMXgUZVMVkywL6S
	xPpr1/I=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.234600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	96CFFA4DD65CA6BAF5318E2350D26575DE99F8A2725B33BB71843DF87C8AACBE2000:8
X-MTK: N

Wakeup events that occur in the hibernation process's
hibernation_platform_enter() cannot wake up the system. Although the
current hibernation framework will execute part of the recovery process
after a wakeup event occurs, it ultimately performs a shutdown operation
because the system does not check the return value of
hibernation_platform_enter(). In short, if a wakeup event occurs before
putting the system into the final low-power state, it will be missed.

To solve this problem, check the return value of
hibernation_platform_enter(). When it returns -EAGAIN or -EBUSY (indicate
the occurrence of a wakeup event), execute the hibernation recovery
process, discard the previously saved image, and ultimately return to the
working state.

Signed-off-by: Chris Feng <chris.feng@mediatek.com>
---
[PATCH v2]:
 - Execute the hibernation recovery process and return to the working state
   when the return value of the function hibernation_platform_enter() is
   -EAGAIN or -EBUSY. Both of the two values may indicate the occurrence of
   a wakeup event.
[PATCH v3]:
 - Use pr_info instead of pr_err, fix undeclared function 'swsusp_unmark'
   build error, refine commit and printing message.
---
 kernel/power/hibernate.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 8d35b9f9aaa3..fb3b63e178b0 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -642,9 +642,9 @@ int hibernation_platform_enter(void)
  */
 static void power_down(void)
 {
-#ifdef CONFIG_SUSPEND
 	int error;
 
+#ifdef CONFIG_SUSPEND
 	if (hibernation_mode == HIBERNATION_SUSPEND) {
 		error = suspend_devices_and_enter(mem_sleep_current);
 		if (error) {
@@ -667,7 +667,15 @@ static void power_down(void)
 		kernel_restart(NULL);
 		break;
 	case HIBERNATION_PLATFORM:
-		hibernation_platform_enter();
+		error = hibernation_platform_enter();
+		if (error == -EAGAIN || error == -EBUSY) {
+#ifdef CONFIG_SUSPEND
+			swsusp_unmark();
+#endif
+			events_check_enabled = false;
+			pr_info("Hibernation process aborted due to detected wakeup event.\n");
+			return;
+		}
 		fallthrough;
 	case HIBERNATION_SHUTDOWN:
 		if (kernel_can_power_off())
-- 
2.17.0


