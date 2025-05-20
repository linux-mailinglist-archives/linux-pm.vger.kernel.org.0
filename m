Return-Path: <linux-pm+bounces-27387-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A80DABCDD5
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 05:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7A204A3E8B
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 03:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB36258CD4;
	Tue, 20 May 2025 03:26:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EDC19DFA2;
	Tue, 20 May 2025 03:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747711571; cv=none; b=ovPIB4qzN4wZV4qEYcF/xrfk6AIsylBjZsbO62FdtgqELPAJIqbYY57GHOmTxrBFr3rxU2YdJVNZVe5d9MEd886FVNb9+LerXOFL9LA9LJj07H0rwtqXHjzBpyU+XujZ49d9NJaqguvhn3xIoRKCJBdikXutdMU2oV+4oOTW33w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747711571; c=relaxed/simple;
	bh=tg+9f5/ByTz0+AQUTAOwJD0oEiW16Fr4sW+Q/4ViH6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rWpF2pZ3LXYAVkf8hEybE8+nIvV/BCxS8kLv9Kj8PkP059topsDagdQU0YwMT63x8E2iqfCgt+7Lw17yM+AUmZUjM0JUpTGbeY7QnLEbkXFICA5p5VrEN/xKVHVNQsXL1fHF9OdPlJIOYXtm3bC+grTzsHLJyRnSW9i6vxF9TTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 251d14f8352a11f0b29709d653e92f7d-20250520
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:0f2dcd53-08cf-4cde-8942-edf7488aee0a,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:ee0770a97088b4f5b4010e9bc23f2486,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:5,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 251d14f8352a11f0b29709d653e92f7d-20250520
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 271715950; Tue, 20 May 2025 11:25:57 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 683FCE003505;
	Tue, 20 May 2025 11:25:57 +0800 (CST)
X-ns-mid: postfix-682BF645-263278296
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 4772BE006100;
	Tue, 20 May 2025 11:25:56 +0800 (CST)
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
Subject: [PATCH 2/3] PM / Sleep:  Introduce try_lock_system_sleep()
Date: Tue, 20 May 2025 11:25:44 +0800
Message-Id: <20250520032545.29558-3-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250520032545.29558-1-zhangzihuan@kylinos.cn>
References: <20250520032545.29558-1-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The suspend subsystem uses system_transition_mutex to serialize
suspend and hibernate transitions. The existing lock_system_sleep()
wrapper both acquires the mutex and sets PF_NOFREEZE on the current
task to avoid it being frozen during the suspend process.

However, in some places such as enter_state(), mutex_trylock() is
used instead. This path currently lacks PF_NOFREEZE protection.

This patch introduces a new wrapper:

    try_lock_system_sleep()

It sets PF_NOFREEZE and then performs mutex_trylock(), mirroring the
existing lock_system_sleep() implementation. This improves consistency
and enables future cleanup of raw trylock calls.

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
---
 include/linux/suspend.h |  2 ++
 kernel/power/main.c     | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index da6ebca3ff77..6c9e8fe0c446 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -468,6 +468,7 @@ extern void pm_wakep_autosleep_enabled(bool set);
 extern void pm_print_active_wakeup_sources(void);
=20
 extern unsigned int lock_system_sleep(void);
+extern unsigned int try_lock_system_sleep(void);
 extern void unlock_system_sleep(unsigned int);
=20
 #else /* !CONFIG_PM_SLEEP */
@@ -496,6 +497,7 @@ static inline void pm_wakeup_clear(bool reset) {}
 static inline void pm_system_irq_wakeup(unsigned int irq_number) {}
=20
 static inline unsigned int lock_system_sleep(void) { return 0; }
+static inline unsigned int try_lock_system_sleep(void) { return 0; }
 static inline void unlock_system_sleep(unsigned int flags) {}
=20
 #endif /* !CONFIG_PM_SLEEP */
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 6254814d4817..e5b64f0dda2d 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -58,6 +58,18 @@ unsigned int lock_system_sleep(void)
 }
 EXPORT_SYMBOL_GPL(lock_system_sleep);
=20
+unsigned int try_lock_system_sleep(void)
+{
+	unsigned int flags =3D current->flags;
+	current->flags |=3D PF_NOFREEZE;
+
+	if (!mutex_trylock(&system_transition_mutex))
+		return 0;
+
+	return flags;
+}
+EXPORT_SYMBOL_GPL(try_lock_system_sleep);
+
 void unlock_system_sleep(unsigned int flags)
 {
 	if (!(flags & PF_NOFREEZE))
--=20
2.25.1


