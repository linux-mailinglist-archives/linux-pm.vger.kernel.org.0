Return-Path: <linux-pm+bounces-27476-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDE7AC0280
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 04:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 198341BA6D4A
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 02:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7085D12CDAE;
	Thu, 22 May 2025 02:35:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643572CCA5;
	Thu, 22 May 2025 02:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747881331; cv=none; b=ATq3xno2NM8ElC9Vgi5szqEtxPOMl1sMGRupk0ARnlL+sIEFPOhCVMyH7EvpvcNnFK84gITJTFNPHtrE/T4BWj0a5RJNocE5QcTNbpcx2ixbpUm8ytB1vEPnWeQjKMjCuudFZ9fbznuhsH1r0pSd/gtBoTzrnUt/dX7/ptHPJHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747881331; c=relaxed/simple;
	bh=X8/nxAlnKfmIilukc3uLUJEJN3++P9YxcsunTFAgtag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BC00shq5IZZPMLjvEm1yzJi/We6LoOe9GjSL6sOKnNrPNTM/F9FNvXNAW9579mG43QoL1kli5yeraOhvAOytg7dZYkCDE/On7YZUtRbHW+zQVj57aVjb84Z2VWXbh4NJ+IUao154WO9iOvBLyDEQ7hipPyTNHWABdbH1ujvQsyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6893bc6e36b511f0b29709d653e92f7d-20250522
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:4803fc01-066d-448a-8340-36b1d7bdff29,IP:0,U
	RL:0,TC:0,Content:-25,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-50
X-CID-META: VersionHash:6493067,CLOUDID:20bd7ec11e7dd67939d0da93bdc0c57b,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:1,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6893bc6e36b511f0b29709d653e92f7d-20250522
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1973197324; Thu, 22 May 2025 10:35:21 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 3B0C6E00351D;
	Thu, 22 May 2025 10:17:09 +0800 (CST)
X-ns-mid: postfix-682E8925-85700445
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 17B3CE00351C;
	Thu, 22 May 2025 10:17:08 +0800 (CST)
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
Subject: [PATCH v2 3/3] PM / Sleep: Replace mutex_trylock(&system_transition_mutex) with try_lock_system_sleep()
Date: Thu, 22 May 2025 10:16:49 +0800
Message-Id: <20250522021649.55228-4-zhangzihuan@kylinos.cn>
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

This patch replaces the remaining instances of mutex_trylock(&system_tran=
sition_mutex)
that semantically intend to *try* acquiring the lock with the newly intro=
duced
try_lock_system_sleep(), which provides a clearer abstraction and avoids =
direct
mutex operations in higher-level PM logic.

This improves code readability, keeps synchronization logic consistent ac=
ross
all system sleep paths, and helps prepare for future enhancements or lock
substitutions (e.g., lockdep annotations or switching to a different lock
primitive).

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
---
 kernel/power/hibernate.c | 6 ++++--
 kernel/power/suspend.c   | 7 +++++--
 kernel/power/user.c      | 6 ++++--
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index cfaa92f24857..c06af4008183 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -1448,9 +1448,11 @@ static const char * const comp_alg_enabled[] =3D {
 static int hibernate_compressor_param_set(const char *compressor,
 		const struct kernel_param *kp)
 {
+	unsigned int sleep_flags;
 	int index, ret;
=20
-	if (!mutex_trylock(&system_transition_mutex))
+	sleep_flags =3D try_lock_system_sleep();
+	if (!sleep_flags)
 		return -EBUSY;
=20
 	index =3D sysfs_match_string(comp_alg_enabled, compressor);
@@ -1463,7 +1465,7 @@ static int hibernate_compressor_param_set(const cha=
r *compressor,
 		ret =3D index;
 	}
=20
-	mutex_unlock(&system_transition_mutex);
+	unlock_system_sleep(sleep_flags);
=20
 	if (ret)
 		pr_debug("Cannot set specified compressor %s\n",
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 8eaec4ab121d..7d39f1ae9711 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -564,6 +564,7 @@ static void suspend_finish(void)
  */
 static int enter_state(suspend_state_t state)
 {
+	unsigned int sleep_flags;
 	int error;
=20
 	trace_suspend_resume(TPS("suspend_enter"), state, true);
@@ -577,7 +578,9 @@ static int enter_state(suspend_state_t state)
 	} else if (!valid_state(state)) {
 		return -EINVAL;
 	}
-	if (!mutex_trylock(&system_transition_mutex))
+
+	sleep_flags =3D try_lock_system_sleep();
+	if (!sleep_flags)
 		return -EBUSY;
=20
 	if (state =3D=3D PM_SUSPEND_TO_IDLE)
@@ -609,7 +612,7 @@ static int enter_state(suspend_state_t state)
 	pm_pr_dbg("Finishing wakeup.\n");
 	suspend_finish();
  Unlock:
-	mutex_unlock(&system_transition_mutex);
+	unlock_system_sleep(sleep_flags);
 	return error;
 }
=20
diff --git a/kernel/power/user.c b/kernel/power/user.c
index 3f9e3efb9f6e..a41fb48b3f96 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -249,6 +249,7 @@ static int snapshot_set_swap_area(struct snapshot_dat=
a *data,
 static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 							unsigned long arg)
 {
+	unsigned int sleep_flags;
 	int error =3D 0;
 	struct snapshot_data *data;
 	loff_t size;
@@ -266,7 +267,8 @@ static long snapshot_ioctl(struct file *filp, unsigne=
d int cmd,
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
=20
-	if (!mutex_trylock(&system_transition_mutex))
+	sleep_flags =3D try_lock_system_sleep();
+	if (!sleep_flags)
 		return -EBUSY;
=20
 	lock_device_hotplug();
@@ -417,7 +419,7 @@ static long snapshot_ioctl(struct file *filp, unsigne=
d int cmd,
 	}
=20
 	unlock_device_hotplug();
-	mutex_unlock(&system_transition_mutex);
+	unlock_system_sleep(sleep_flags);
=20
 	return error;
 }
--=20
2.25.1


