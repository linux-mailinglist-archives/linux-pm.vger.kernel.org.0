Return-Path: <linux-pm+bounces-36345-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C0FBE7E74
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 11:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4769F5E775A
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 09:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7552DCC01;
	Fri, 17 Oct 2025 09:53:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F952DC784;
	Fri, 17 Oct 2025 09:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760694834; cv=none; b=FGFDGuAbS+OTGTqOean/JMHenSzIw/DZl7KRuc5wWBkm6iaQseN6PuwPeSdUfXE4sco/BHUUHXvpklCEVchBH7NMYkEm5xkoKf68VdAuT959E3W3Vpd/e/vzwSJt2EQLq2cVUCh3VxfKJ7sCPp5u9x//yOGq/8OP7muaYB1EJ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760694834; c=relaxed/simple;
	bh=KxWv3OkV6Fh1TVJiY1tMIX4D7MibM0hpfwsKlVtzS0I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BZloNjZDq6Gtmdph8x2WXj8YkW2XsfceERQ5oIFao+MjWQMf4jf7rpn9Hm5tZDU/TUqbbCRVlfVVQl7LLdafLUcbxQ8CaFcrCAGO/NK4eMmo9hjtBsJmZehVA/+4CM1v/DzmDmJdcZnIR3dCW9ibpuyV7nJTOmub2qPC+Pruu1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 29fb1a16ab3f11f0a38c85956e01ac42-20251017
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:3730d44e-7d97-4405-bae9-b60d4d2e7084,IP:0,UR
	L:0,TC:0,Content:-5,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-30
X-CID-META: VersionHash:a9d874c,CLOUDID:40513bf150f9d7312e74212bac7c4de4,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|50,EDM:2,IP:nil
	,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 29fb1a16ab3f11f0a38c85956e01ac42-20251017
X-User: luriwen@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luriwen@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 903986183; Fri, 17 Oct 2025 17:53:42 +0800
From: Riwen Lu <luriwen@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Riwen Lu <luriwen@kylinos.cn>,
	xiongxin <xiongxin@kylinos.cn>
Subject: [PATCH v1] PM: suspend: Make pm_test delay interruptible by wakeup events
Date: Fri, 17 Oct 2025 17:53:38 +0800
Message-Id: <20251017095338.4122406-1-luriwen@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify the suspend_test() function to make the test delay can be
interrupted by wakeup events.

This improves the responsiveness of the system during suspend testing
when wakeup events occur, allowing the suspend process to proceed
without waiting for the full test delay to complte when wakeup events
are detected.

Additionally, using msleep() instead of mdelay() avoids potential soft
lockup "CPU stuck" issues when long test delays are configured.

Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
Signed-off-by: xiongxin <xiongxin@kylinos.cn>
---
 kernel/power/suspend.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 4bb4686c1c08..8f022d279635 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -344,10 +344,18 @@ MODULE_PARM_DESC(pm_test_delay,
 static int suspend_test(int level)
 {
 #ifdef CONFIG_PM_DEBUG
+	int i;
+
 	if (pm_test_level == level) {
-		pr_info("suspend debug: Waiting for %d second(s).\n",
+		for (i = 0; i < pm_test_delay; i++) {
+			if (pm_wakeup_pending())
+				break;
+			msleep(1000);
+		}
+		if (i == pm_test_delay)
+			pr_info("suspend debug: Already wait %d second(s).\n",
 				pm_test_delay);
-		mdelay(pm_test_delay * 1000);
+
 		return 1;
 	}
 #endif /* !CONFIG_PM_DEBUG */
-- 
2.25.1


