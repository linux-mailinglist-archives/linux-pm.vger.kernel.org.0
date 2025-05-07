Return-Path: <linux-pm+bounces-26774-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 753DBAAD631
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 08:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF2D8985A30
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 06:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089FC210186;
	Wed,  7 May 2025 06:35:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8285F21019E;
	Wed,  7 May 2025 06:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746599739; cv=none; b=IlyBbO9cj89PXHREcnWnycgU0eONewdev6fqz81Z800RY+r6/as9njbIATQp8VWjorqAYp966umBl6kS7kSSH5x6ZokXmi8NkgWT7YFu1qIOur9AEgNiokKeH9Okt/SMhxYgsXJN1iEQSPqEeoo/G2P8D6vRlqZfDIBglTROBUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746599739; c=relaxed/simple;
	bh=EunsBZu+dPFyFx+so1aikErZNXrHK15H5QeG0WGOHis=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=A9w8eLx3Jvg+eSOrlak9UgZGf3KxWKen/zNDBb8sfe56ug3OHikmK2fm0ZMsDJ1OgZYA6SMq5zLTNMsKIOEhujVbOeLiEA6iNGFXBMHDIt+6hLkZPkclfrqJOcI8CidA7MhQHu4VskYmsyFLCJzRNZs1vE5dLET6wqEsPLLI9V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 77aa34ac2b0d11f0b29709d653e92f7d-20250507
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:01f278ff-13a4-4f34-8fda-6627e63156e8,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:957d935d78f12afb161e3c7259de899b,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 77aa34ac2b0d11f0b29709d653e92f7d-20250507
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 507086601; Wed, 07 May 2025 14:35:29 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id C72F0E006100;
	Wed,  7 May 2025 14:35:28 +0800 (CST)
X-ns-mid: postfix-681AFF30-651625104
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 3AE54E0080FF;
	Wed,  7 May 2025 14:35:25 +0800 (CST)
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
Subject: [PATCH v3] PM / sleep: add configurable delay for pm_test
Date: Wed,  7 May 2025 14:35:20 +0800
Message-Id: <20250507063520.419635-1-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This patch turns this 5 second delay into a configurable module
parameter, so users can determine how long to wait in this
pseudo-hibernate state before resuming the system.

The configurable delay parameter has been added to suspend and
synchronized to hibernation.

Example (wait 30 seconds);

  # echo 30 > /sys/module/hibernate/parameters/pm_test_delay
  # echo core > /sys/power/pm_test

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
---
v3:
 - Fix the location of the hibernate.pm_test_delay parameter in
   kernel-parameters.txt.
 - Update =E2=80=98[hibernate]=E2=80=99 to =E2=80=98[HIBERNATION]=E2=80=99
v2:
 - Fix typos.
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 kernel/power/hibernate.c                        | 9 +++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
index d9fd26b95b34..a110cbb37f20 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1828,6 +1828,13 @@
 				lz4: Select LZ4 compression algorithm to
 				compress/decompress hibernation image.
=20
+	hibernate.pm_test_delay=3D
+			[HIBERNATION]
+			Sets the number of seconds to remain in a hibernation test
+			mode before resuming the system (see
+			/sys/power/pm_test). Only available when CONFIG_PM_DEBUG
+			is set. Default value is 5.
+
 	highmem=3Dnn[KMG]	[KNL,BOOT,EARLY] forces the highmem zone to have an e=
xact
 			size of <nn>. This works even on boxes that have no
 			highmem otherwise. This also works to reduce highmem
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 23c0f4e6cb2f..485133af884d 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -133,10 +133,15 @@ bool system_entering_hibernation(void)
 EXPORT_SYMBOL(system_entering_hibernation);
=20
 #ifdef CONFIG_PM_DEBUG
+static unsigned int pm_test_delay =3D 5;
+module_param(pm_test_delay, uint, 0644);
+MODULE_PARM_DESC(pm_test_delay,
+		 "Number of seconds to wait before resuming from hibernation test");
 static void hibernation_debug_sleep(void)
 {
-	pr_info("debug: Waiting for 5 seconds.\n");
-	mdelay(5000);
+	pr_info("hibernation debug: Waiting for %d second(s).\n",
+		pm_test_delay);
+	mdelay(pm_test_delay * 1000);
 }
=20
 static int hibernation_test(int level)
--=20
2.25.1


