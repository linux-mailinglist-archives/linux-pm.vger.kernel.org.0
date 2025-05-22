Return-Path: <linux-pm+bounces-27478-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4732AC0284
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 04:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E461D7B5651
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 02:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BA214EC60;
	Thu, 22 May 2025 02:35:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368F629CE6;
	Thu, 22 May 2025 02:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747881332; cv=none; b=qcij7MzBPamj+mwxRV/yuqDK5owF+ab7RutwFM/vcHzcmiwZqrj6a8eVW6k2741MdceiEEmue8QEi4EYWqxfFGT+/COOxap3uiwMU9ECsE8v5q801no9M2BScSdnjSde0K8PVX/5IsswiYuARKMLx789vhnnhKhxxEKVKVIvMOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747881332; c=relaxed/simple;
	bh=O5WlLJx2+c4wwI4hD4aEpExVS165ZV3Rb0A7jWj6nqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h1w41cFwvOfx7lhvVDal44mHEvpEsYf1nqZI7mN2XgzmTUcq81KSGub68Ui6SqJWL5AacC7oNLMxETSxS8OYXwArcgOubrbDSiT4eLcAHWkDgPDzqkYYgew/waSn4cmgzV3GokiV2oYWVYhDRNTPDv4lW0yWgw9HIpVil2vPu0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 687d074e36b511f0b29709d653e92f7d-20250522
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:7d0dadb9-b786-4c96-a233-e70fc7d489b2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:162eb6d8f44e73553c797785cbcf1e9c,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 687d074e36b511f0b29709d653e92f7d-20250522
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 261166824; Thu, 22 May 2025 10:35:21 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 2A346E00351B;
	Thu, 22 May 2025 10:17:05 +0800 (CST)
X-ns-mid: postfix-682E8920-922448443
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id D27B7E003519;
	Thu, 22 May 2025 10:17:01 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: rafael@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	tzungbi@kernel.org,
	a.fatoum@pengutronix.de,
	jani.nikula@intel.com,
	joel.granados@kernel.org,
	paulmck@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v2 1/3] PM / Sleep: Replace mutex_[un]lock(&system_transition_mutex) with [un]lock_system_sleep()
Date: Thu, 22 May 2025 10:16:47 +0800
Message-Id: <20250522021649.55228-2-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250522021649.55228-1-zhangzihuan@kylinos.cn>
References: <20250522021649.55228-1-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These function currently calls mutex_lock(&system_transition_mutex) and
mutex_unlock() directly to protect the resume-from-disk operation from
concurrent suspend/resume transitions.

However, this is inconsistent with the rest of the power management
code, where lock_system_sleep() and unlock_system_sleep() are used to
wrap suspend/hibernate transitions. These wrapper functions not only
acquire system_transition_mutex, but also set PF_NOFREEZE for the
calling thread, ensuring that it is not subject to freezing during
suspend.

This change replaces the raw mutex_lock()/unlock() with the standard
lock_system_sleep()/unlock_system_sleep() wrapper pair, bringing it in
line with the locking pattern used by hibernate(), pm_suspend(), and
other similar entry points.

Benefits of this change:

 - Ensures the thread performing software resume is marked PF_NOFREEZE,
   which is important during early resume paths where freezing is
active.
 - Improves code clarity by making the locking intent more explicit.
 - Unifies suspend/hibernate locking style across the kernel power
   subsystem.
 - Reduces the risk of future maintenance issues due to inconsistent
   locking.

No functional change is expected at runtime, since the lock order and
coverage remain the same. This is a straightforward cleanup and
consistency fix.

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
---
 kernel/power/hibernate.c | 5 +++--
 kernel/reboot.c          | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 23c0f4e6cb2f..cfaa92f24857 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -988,6 +988,7 @@ static int __init find_resume_device(void)
=20
 static int software_resume(void)
 {
+	unsigned int sleep_flags;
 	int error;
=20
 	pm_pr_dbg("Hibernation image partition %d:%d present\n",
@@ -995,7 +996,7 @@ static int software_resume(void)
=20
 	pm_pr_dbg("Looking for hibernation image.\n");
=20
-	mutex_lock(&system_transition_mutex);
+	sleep_flags =3D lock_system_sleep();
 	error =3D swsusp_check(true);
 	if (error)
 		goto Unlock;
@@ -1050,7 +1051,7 @@ static int software_resume(void)
 	hibernate_release();
 	/* For success case, the suspend path will release the lock */
  Unlock:
-	mutex_unlock(&system_transition_mutex);
+	unlock_system_sleep(sleep_flags);
 	pm_pr_dbg("Hibernation image not present or could not be loaded.\n");
 	return error;
  Close_Finish:
diff --git a/kernel/reboot.c b/kernel/reboot.c
index ec087827c85c..68ac7e377efb 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -729,6 +729,7 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, uns=
igned int, cmd,
 		void __user *, arg)
 {
 	struct pid_namespace *pid_ns =3D task_active_pid_ns(current);
+	unsigned int sleep_flags;
 	char buffer[256];
 	int ret =3D 0;
=20
@@ -761,7 +762,7 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, uns=
igned int, cmd,
 		cmd =3D LINUX_REBOOT_CMD_HALT;
 	}
=20
-	mutex_lock(&system_transition_mutex);
+	sleep_flags =3D lock_system_sleep();
 	switch (cmd) {
 	case LINUX_REBOOT_CMD_RESTART:
 		kernel_restart(NULL);
@@ -811,7 +812,7 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, uns=
igned int, cmd,
 		ret =3D -EINVAL;
 		break;
 	}
-	mutex_unlock(&system_transition_mutex);
+	unlock_system_sleep(sleep_flags);
 	return ret;
 }
=20
--=20
2.25.1


