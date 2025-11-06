Return-Path: <linux-pm+bounces-37492-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7924C38AF4
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 02:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 35C8534E5B0
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 01:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46F11E5724;
	Thu,  6 Nov 2025 01:19:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15251E1E00;
	Thu,  6 Nov 2025 01:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762391966; cv=none; b=lohybUH367X6kiJXas6DkNXGG0qLVfXJTJ1uZUlbxmLTGF9EGyslI1OZozf0elcqR6GntFCvtTnxT7DTVtKQ097Rm18wy6UhOhabJSrQlhb8RQ9XCkHThwkVhkeZN946s11v0qcuYGJ9/AhxXFSUzBLJGp8mwBbi7YBqWuTKqBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762391966; c=relaxed/simple;
	bh=nv//fYVhJ0H030NSSLSLbhR3bFrsnMwndEq1rEWpPpc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a1DZyZ6zzbRzQErhABaefoS/lQgh3WVk/h0J4BijilL/8vs8TrI4jHBkp5quHSuRtuecWwUL6pfGH5QQKwp4r5186Bnr0N/okTqerM1+0k7GaXjJ596MZB1f47k1HyzT9fsNguJiiArBTZahiRYgP0ooETGIwhy+o2XLZ+anrnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9b2363e6baae11f0a38c85956e01ac42-20251106
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:b7872f64-fa0a-4f1b-8ef2-616aae83a5e4,IP:0,UR
	L:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:a9d874c,CLOUDID:9388afa816217efbcd6081f1f197ec73,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|15|50,EDM:2,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9b2363e6baae11f0a38c85956e01ac42-20251106
X-User: luriwen@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luriwen@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1600711679; Thu, 06 Nov 2025 09:19:13 +0800
From: Riwen Lu <luriwen@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Riwen Lu <luriwen@kylinos.cn>,
	xiongxin <xiongxin@kylinos.cn>
Subject: [PATCH v2] PM: suspend: Make pm_test delay interruptible by wakeup events
Date: Thu,  6 Nov 2025 09:19:09 +0800
Message-Id: <20251106011909.2189279-1-luriwen@kylinos.cn>
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
without waiting for the full test delay to complete when wakeup events
are detected.

Additionally, using msleep() instead of mdelay() avoids potential soft
lockup "CPU stuck" issues when long test delays are configured.

Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
Signed-off-by: xiongxin <xiongxin@kylinos.cn>
---
 kernel/power/suspend.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 4bb4686c1c08..a8e80ba8ac2c 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -344,10 +344,14 @@ MODULE_PARM_DESC(pm_test_delay,
 static int suspend_test(int level)
 {
 #ifdef CONFIG_PM_DEBUG
+	int i;
+
 	if (pm_test_level == level) {
 		pr_info("suspend debug: Waiting for %d second(s).\n",
 				pm_test_delay);
-		mdelay(pm_test_delay * 1000);
+		for (i = 0; i < pm_test_delay && !pm_wakeup_pending(); i++)
+			msleep(1000);
+
 		return 1;
 	}
 #endif /* !CONFIG_PM_DEBUG */
-- 
2.25.1


