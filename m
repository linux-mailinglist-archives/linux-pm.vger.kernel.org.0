Return-Path: <linux-pm+bounces-27167-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F927AB7BFB
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 05:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83A9F1BA7B67
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 03:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3648C293B58;
	Thu, 15 May 2025 03:04:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FBA29375F;
	Thu, 15 May 2025 03:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747278258; cv=none; b=osCnekwda3pSCBJpUihbGjzhYLc+qMjSjJrNmZRgeMj+4JzIGk4F+bKcGSD3qa6hXKTk10EQsb+Azxe3XTwt43Gd1Dx6D1MHOePXPawI84RPJApVfDWTE4iiebTsWY4bNkmpgNt2TKUwaxxEIdNjJZYoOS0b61n9/NQlpFAnSSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747278258; c=relaxed/simple;
	bh=KbCF5MKCWNn3YP5xLgTo6/b3b/wNnyl4Ieq6Iz4mRVg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=io+Kjl0QcRAmtmk1Q9mE++TC6iHhor2HCFZm7bUt3QkAO9XKqZNVEIqbZEUfvUXpoMvZnOgf6C2gNMyuchXGwhXlB4y5b9a3wg0CLkyWBgSPH+zsV6A96xk0BJN3vrntPsDYBKNtqJRivfmQ769KgZCdePrrEG5oqKv2d9f5m9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 40f45dde313911f0b29709d653e92f7d-20250515
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:5a9b7689-c6cc-429c-bf32-1c973e39c20c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:8860f9c49583b8e2e2cb45ee7d7b6a34,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 40f45dde313911f0b29709d653e92f7d-20250515
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 606235159; Thu, 15 May 2025 11:04:02 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id C9E55E003507;
	Thu, 15 May 2025 11:04:01 +0800 (CST)
X-ns-mid: postfix-682559A1-648868357
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 4EB96E003506;
	Thu, 15 May 2025 11:04:01 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v1] freezer: Skip zombie processes early to reduce lock contention
Date: Thu, 15 May 2025 11:01:51 +0800
Message-Id: <20250515030151.224508-1-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently, the freezer core processes all tasks, including zombie tasks
(EXIT_ZOMBIE), when performing freeze operations.  However, zombie tasks
cannot be frozen since they are already dead and won't execute further.
Despite this, these tasks are still passed to freeze_task(), which may
involve acquiring locks and accessing unnecessary internal state.

This patch introduces an early check to skip zombie tasks when calling
freeze_task(), significantly reducing the lock contention, especially on
systems with many short-lived processes or a high volume of process
exits.

Benefits:
- Reduces unnecessary lock contention by skipping zombie processes
  earlier in the freeze process.
- Improves overall freezing performance, particularly in high-load
  systems where there are many zombie processes.

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
---
 kernel/freezer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/freezer.c b/kernel/freezer.c
index 8d530d0949ff..a6867195bb77 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -164,6 +164,9 @@ bool freeze_task(struct task_struct *p)
 {
 	unsigned long flags;
=20
+	if (p->exit_state =3D=3D EXIT_ZOMBIE)
+		return false;
+
 	spin_lock_irqsave(&freezer_lock, flags);
 	if (!freezing(p) || frozen(p) || __freeze_task(p)) {
 		spin_unlock_irqrestore(&freezer_lock, flags);
@@ -203,6 +206,9 @@ void __thaw_task(struct task_struct *p)
 {
 	unsigned long flags;
=20
+	if (p->exit_state =3D=3D EXIT_ZOMBIE)
+		return;
+
 	spin_lock_irqsave(&freezer_lock, flags);
 	if (WARN_ON_ONCE(freezing(p)))
 		goto unlock;
--=20
2.25.1


