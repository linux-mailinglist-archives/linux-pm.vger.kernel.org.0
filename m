Return-Path: <linux-pm+bounces-30893-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D41B06DE8
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 08:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F408C565347
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 06:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742A428850E;
	Wed, 16 Jul 2025 06:27:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4291D5CED;
	Wed, 16 Jul 2025 06:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752647220; cv=none; b=s5ke9EJfRDOSyQd49vVZwrA4N+UYcooePNJ/K0fbIxvX4vc0yJt5KeAiRw4DqL8cQDYeWS96fGdNMDEUVRuHJQYa2cbWWGzvtDwc3HSlm26/C/SDTr1PX/XJ2Rj3D1iet/wfnowJx0qmMtT8d6WNAE3P8rPhwuPUWVYOhPbPzkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752647220; c=relaxed/simple;
	bh=xR83r5eBLKHajVPWGodmEeBh6ryn9Dznc6P42/wdyoA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l04Xtn5xAMLUr9aclCwzS45CZoSSxFqUDrO+OKf4PaIgfiDIDOzV+oFLJ7ZSX4UIWCDQuzVJKW1h4Vr9Xz0IWMU73BP17z64QhcQuWXXl7vXxEKoB6FbaicTjn+4KVyq9K071eratxGXQBVw977fyxgmYuxLJRwUOGzwNZ+5w0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: da435738620d11f0b29709d653e92f7d-20250716
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:4f2730b9-e7ab-44b3-8960-e8fc8cfb9052,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6493067,CLOUDID:806aa15322e3e20330aa43b6a0e4f296,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:5,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: da435738620d11f0b29709d653e92f7d-20250716
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1950349900; Wed, 16 Jul 2025 14:26:48 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 3D707E008FA3;
	Wed, 16 Jul 2025 14:26:48 +0800 (CST)
X-ns-mid: postfix-68774628-70193187
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 31905E008FA2;
	Wed, 16 Jul 2025 14:26:47 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: "rafael J . wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>,
	len brown <len.brown@intel.com>,
	pavel machek <pavel@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v4] PM / Freezer: Skip zombie/dead processes to reduce freeze latency
Date: Wed, 16 Jul 2025 14:26:39 +0800
Message-Id: <20250716062639.1528066-2-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250716062639.1528066-1-zhangzihuan@kylinos.cn>
References: <20250716062639.1528066-1-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When freezing user space during suspend or hibernation, the freezer
iterates over all tasks and attempts to freeze them via
try_to_freeze_tasks().

However, zombie processes (i.e., tasks in EXIT_ZOMBIE state) are no
longer running and will never enter the refrigerator. Trying to freeze
them is meaningless and causes extra overhead, especially when there are
thousands of zombies created during stress conditions such as fork
storms.

This patch skips zombie processes during the freezing phase.

In our testing with ~30,000 user processes (including many zombies), the
average freeze time during suspend (S3) dropped from ~43 ms to ~16 ms:

    - Without the patch: ~43 ms average freeze latency
    - With the patch:    ~16 ms average freeze latency
    - Improvement:       ~62%

This confirms that skipping zombies significantly speeds up the freezing
process when the system is under heavy load with many short-lived tasks.

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>

Changes in v4:
- Fix incomplete patch title
- Add a comment: exit_state is better than PF_NOFREEZE if we only intend
  to skip user processes. TODO added for possible future replacement.

Changes in v3:
- Added performance test

Changes in v2:
- Simplified code, added judgment of dead processes
- Rewrite changelog
---
 kernel/power/process.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index dc0dfc349f22..c1d6c5150033 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -51,7 +51,15 @@ static int try_to_freeze_tasks(bool user_only)
 		todo =3D 0;
 		read_lock(&tasklist_lock);
 		for_each_process_thread(g, p) {
-			if (p =3D=3D current || !freeze_task(p))
+			/*
+			 * Zombie and dead tasks are not running anymore and cannot enter
+			 * the __refrigerator(). Skipping them avoids unnecessary freeze atte=
mpts.
+			 *
+			 * TODO: Consider using PF_NOFREEZE instead, which may provide
+			 * a more generic exclusion mechanism for other non-freezable tasks.
+			 * However, for now, exit_state is sufficient to skip user processes.
+			 */
+			if (p =3D=3D current || p->exit_state || !freeze_task(p))
 				continue;
=20
 			todo++;
--=20
2.25.1


