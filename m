Return-Path: <linux-pm+bounces-27543-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B1BAC1ABA
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 05:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBB0817E05F
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 03:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A2822171E;
	Fri, 23 May 2025 03:44:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4745F2DCC02;
	Fri, 23 May 2025 03:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747971841; cv=none; b=A/CiCIcfZ6i1jQ6JVs+vBfQh1jon94r8XQb2snAswCwlLeQuXg1jANkhVSk1Kscp8T9baWr63wdFYJdH52QEL1GZGSMuYAbd/5xLRPdRdiw0kZu4JgaIA4XZsgJe4c+JlYbkMIdcERjOkqTqHQEj324xqqrVR3ZJaMj5ogTYih0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747971841; c=relaxed/simple;
	bh=pvtNNF3h+3VSF0hj81ZgGrG4VIQvL8NxH6ruZPJeRYc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=URjwzwU4mGCRUMiSDxqAY7lA8HgUoasYIStFWL7bP0DwixR1hin2lYQ1YhoQj7Y2cqy8Q/zRjP9prUA9VZljRKjR4glRS+VDCRhqJ001Vvm+C/MZ/C4BtSe6QbrJ+F8gtOSbqYuBZxUuTLdXjbFyvTHEm1bOqKiu0X7SwNBkBeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 24637060378811f0b29709d653e92f7d-20250523
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:cee2b758-5df6-4ad5-b3b3-f9722e7e2662,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:fcf36063a7b938f265164793eaa8fa7a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 24637060378811f0b29709d653e92f7d-20250523
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1571438718; Fri, 23 May 2025 11:43:51 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 3AD6BE003505;
	Fri, 23 May 2025 11:43:51 +0800 (CST)
X-ns-mid: postfix-682FEEF7-47407982
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 57348E003505;
	Fri, 23 May 2025 11:43:50 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: rafael@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v2] PM / Freezer: Skip dead/zombie processes
Date: Fri, 23 May 2025 11:42:53 +0800
Message-Id: <20250523034253.88083-1-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ZOMBIE (exit_state =3D=3D EXIT_ZOMBIE) and DEAD (exit_state =3D=3D EXIT_D=
EAD)
processes have already finished execution and will not be scheduled again=
.

In the context of system suspend (e.g., S3), attempting to freeze such
processes is unnecessary. Moreover, freezing them can obscure suspend
diagnostics and delay resume if they appear "stuck" in logs.

This patch introduces an early check for `p->exit_state !=3D 0` in
`try_to_freeze_tasks()` and skips freezing for such tasks. This is a safe
optimization because:

 - They hold no running resources
 - Their `task_struct` is only waiting to be collected or freed

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>

Changes in v2:
- Simplified code, added judgment of dead processes
- Rewrite changelogs
---
 kernel/power/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index 66ac067d9ae6..82528a79d46a 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -51,7 +51,7 @@ static int try_to_freeze_tasks(bool user_only)
 		todo =3D 0;
 		read_lock(&tasklist_lock);
 		for_each_process_thread(g, p) {
-			if (p =3D=3D current || !freeze_task(p))
+			if (p =3D=3D current || p->exit_state || !freeze_task(p))
 				continue;
=20
 			todo++;
--=20
2.25.1


