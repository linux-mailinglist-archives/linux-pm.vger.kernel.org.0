Return-Path: <linux-pm+bounces-26768-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E82F5AAD3AA
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 04:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2131B1BA10A2
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 02:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2220F1A9B53;
	Wed,  7 May 2025 02:58:51 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB59B134A8;
	Wed,  7 May 2025 02:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746586731; cv=none; b=YaFYa4We5q50S/+rUdCk7p+pafAXXnJZNZFvkA82KspgoYjeHXWcegC1Lb3MlHKqWJoReYkZvPhDkO0yq7T0rTEnQvHr8g09zznXcXHPbIxy8svdj7Li8p3o16n8YlMSlPCbcRTo86DqouEAsEF63hn8L5y+Jo859IyIbIJ5+D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746586731; c=relaxed/simple;
	bh=MmUPH4ARy9/vAzjyU9ahx/w7xXUYQgpi4F73R0SBSnA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jxt9/XMvybFRRAl9nS9nBpu1UkyLSI96f6qC0R8Tfw9eGFaW9AW2z2KE4pbVYxvPBDoZyz08w0XuhveAKo3W7ACHV0VHE5LT+5U2GSEvSJv8/6LVGBZoU6a8mEMgVTu38twHHbAOxFYkJU4s8dG1EMKj5Ye6qBY+J+NSA8OScL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2c49f9162aef11f0b29709d653e92f7d-20250507
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:fc6c30e8-57af-4dbe-b9c6-6dd9fc0d9916,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:848f288d76073cecd9c059e60a8b1d35,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2c49f9162aef11f0b29709d653e92f7d-20250507
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1047783727; Wed, 07 May 2025 10:58:37 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 7A81AE006100;
	Wed,  7 May 2025 10:58:37 +0800 (CST)
X-ns-mid: postfix-681ACC5D-342742475
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 24B1BE0080FF;
	Wed,  7 May 2025 10:58:34 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: corbet@lwn.net,
	rafael@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org,
	akpm@linux-foundation.org,
	paulmck@kernel.org,
	rostedt@goodmis.org,
	thuth@redhat.com,
	bp@alien8.de,
	ardb@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v1] PM / sleep: add configurable delay for pm_test
Date: Wed,  7 May 2025 10:57:06 +0800
Message-Id: <20250507025706.311686-1-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch turns this 5 second delay into a configurable module
parameter, so users can determine how long to wait in this
pseudo-hibernate state before resuming the system.

The configurable delay parameter has been added to suspend and
synchronized to hibernate.

Example (wait 30 seconds);

  # echo 30 > /sys/module/hibernate/parameters/pm_test_delay
  # echo core > /sys/power/pm_test

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 kernel/power/hibernate.c                        | 9 +++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
index d9fd26b95b34..082a697a3e95 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6998,6 +6998,13 @@
 			/sys/power/pm_test). Only available when CONFIG_PM_DEBUG
 			is set. Default value is 5.
=20
+	hibernate.pm_test_delay=3D
+			[hibernate]
+			Sets the number of seconds to remain in a suspend test
+			mode before resuming the system (see
+			/sys/power/pm_test). Only available when CONFIG_PM_DEBUG
+			is set. Default value is 5.
+
 	svm=3D		[PPC]
 			Format: { on | off | y | n | 1 | 0 }
 			This parameter controls use of the Protected
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 23c0f4e6cb2f..da7533aab8d1 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -133,10 +133,15 @@ bool system_entering_hibernation(void)
 EXPORT_SYMBOL(system_entering_hibernation);
=20
 #ifdef CONFIG_PM_DEBUG
+static unsigned int pm_test_delay =3D 5;
+module_param(pm_test_delay, uint, 0644);
+MODULE_PARM_DESC(pm_test_delay,
+		 "Number of seconds to wait before resuming from hibernate test");
 static void hibernation_debug_sleep(void)
 {
-	pr_info("debug: Waiting for 5 seconds.\n");
-	mdelay(5000);
+	pr_info("hibernation debug: Waiting for %d second(s).\n",
+			pm_test_delay);
+	mdelay(pm_test_delay * 1000);
 }
=20
 static int hibernation_test(int level)
--=20
2.25.1


