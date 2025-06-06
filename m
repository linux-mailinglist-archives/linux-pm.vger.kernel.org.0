Return-Path: <linux-pm+bounces-28178-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5D4ACFC5D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 08:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A22EA7A489D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 06:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39401DE889;
	Fri,  6 Jun 2025 06:06:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5284736D;
	Fri,  6 Jun 2025 06:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749189992; cv=none; b=UZwOxf6J7HKDc6S2sA/MPQEfJfQ/SMxnqvahzB/fSSA1T/lCQrK5onHQ6rJ4yVFVejq8+Hvel5FkdsJ2XVatzjmVr2P9ezf/Rdv0rea1JVWSe2bhGuH170J7QDphMziryjAmC7OXKukXZrSOpv88+XC6UOKS1b+ZPiRLKXww5rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749189992; c=relaxed/simple;
	bh=g6gR5ca2BcNvCtBCVJl2Nd0K2sCgWnyiegUtKp1Ui4w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D1+Co3Oz2d8iPtea/3Z0C9JCLQ1YZ75k2y9LUemQdqqBimYUfscewtCujnnecnBDGsnLR3kZo5R53WgQGabkuh7zla1Gqy75WNMw04DI6jNSYQS91E1IA/gGLNR+sxQTq6XDXuOFPAQR0oMPc3zq6nCVCBpD1XxLj2PColWZuFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5e3284e2429c11f0b29709d653e92f7d-20250606
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:9ca42e9d-a54d-48ca-a2f0-f36b09dcd64e,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6493067,CLOUDID:24696fe07121afc78295f14f43985d45,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:1,IP:nil,URL
	:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5e3284e2429c11f0b29709d653e92f7d-20250606
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 417240045; Fri, 06 Jun 2025 14:06:21 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id E7826E00891C;
	Fri,  6 Jun 2025 14:06:20 +0800 (CST)
X-ns-mid: postfix-6842855C-7647601
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 0D171E008900;
	Fri,  6 Jun 2025 14:06:19 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [RESEND PATCH v2] PM / Freezer: Skip dead/zombie processes
Date: Fri,  6 Jun 2025 14:06:04 +0800
Message-Id: <20250606060604.16237-1-zhangzihuan@kylinos.cn>
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
index a6f7ba2d283d..2bbe22610522 100644
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


