Return-Path: <linux-pm+bounces-30714-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3DEB02910
	for <lists+linux-pm@lfdr.de>; Sat, 12 Jul 2025 05:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A011C40231
	for <lists+linux-pm@lfdr.de>; Sat, 12 Jul 2025 03:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5D51991B2;
	Sat, 12 Jul 2025 03:08:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FC62AD0C;
	Sat, 12 Jul 2025 03:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752289729; cv=none; b=NyexCINi5KVLwGaeml3GGdloC7uzpOV3es7TfyXXzns1XZ0LH/M90A8ETWkWFy45gUbiEjDXT0r8XW7aJalVBefQ6unIgWy6JQxm8qhrvPlozUN6J3+5qCX13vACqnNwlVvt3Y/11R5oiiJb9g8B2n/JPtnBMvEJY6rzGU8eXOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752289729; c=relaxed/simple;
	bh=xXpsNqrIXAelX9++dafpoeliHQpwtHT+K5FEXp5y6QE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pvzp3aXpbU+UuzcJmegjw5Yi7FGmy/16RfLzqu+xJTtmwD/v1nyXBdSGMIundVnx3SppeIg04o/78Ci5qhSCGfo5tRp3FP+DUKpPE4rdQiPATvNoOC/1Q+GVk5iv13deY5EdY6jKreVGQyWnfo4HhtEDa2h33QTc0fwb5+myLyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7c48f6a85ecd11f0b29709d653e92f7d-20250712
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:3eb91566-35af-40cd-989e-b43e6266bb63,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:cfdb6a373986939dd1356ddc48538b76,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7c48f6a85ecd11f0b29709d653e92f7d-20250712
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1090271228; Sat, 12 Jul 2025 11:08:29 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 4D669E008FA3;
	Sat, 12 Jul 2025 11:08:29 +0800 (CST)
X-ns-mid: postfix-6871D1AD-10186120
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 08630E008FA2;
	Sat, 12 Jul 2025 11:08:27 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Cc: Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v1] PM: suspend: clean up redundant filesystems_freeze/thaw handling
Date: Sat, 12 Jul 2025 11:08:24 +0800
Message-Id: <20250712030824.81474-1-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The recently introduced support for freezing filesystems during system
suspend included calls to filesystems_freeze() in both suspend_prepare()
and enter_state(), as well as calls to filesystems_thaw() in both
suspend_finish() and the Unlock path in enter_state(). These are
redundant.

- filesystems_freeze() is already called in suspend_prepare(), which is
  the proper and consistent place to handle pre-suspend operations. The
second call in enter_state() is unnecessary and removed.

- filesystems_thaw() is invoked in suspend_finish(), which covers
  successful suspend/resume paths. In the failure case , we add a call
to filesystems_thaw() only when needed, avoiding the duplicate call in
the general Unlock path.

This change simplifies the suspend code and avoids repeated freeze/thaw
calls, while preserving correct ordering and behavior.

Fixes: eacfbf74196f91e4c26d9f8c78e1576c1225cd8c ("power: freeze filesyste=
ms during suspend/resume")
Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
---
 kernel/power/suspend.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index bb608b68fb30..8f3e4c48d5cd 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -384,6 +384,7 @@ static int suspend_prepare(suspend_state_t state)
 		return 0;
=20
 	dpm_save_failed_step(SUSPEND_FREEZE);
+	filesystems_thaw();
 	pm_notifier_call_chain(PM_POST_SUSPEND);
  Restore:
 	pm_restore_console();
@@ -593,8 +594,6 @@ static int enter_state(suspend_state_t state)
 		ksys_sync_helper();
 		trace_suspend_resume(TPS("sync_filesystems"), 0, false);
 	}
-	if (filesystem_freeze_enabled)
-		filesystems_freeze();
=20
 	pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_labels[state])=
;
 	pm_suspend_clear_flags();
@@ -614,7 +613,6 @@ static int enter_state(suspend_state_t state)
 	pm_pr_dbg("Finishing wakeup.\n");
 	suspend_finish();
  Unlock:
-	filesystems_thaw();
 	mutex_unlock(&system_transition_mutex);
 	return error;
 }
--=20
2.25.1


