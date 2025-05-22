Return-Path: <linux-pm+bounces-27475-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A53DAC027E
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 04:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3119E56E5
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 02:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077F9482F2;
	Thu, 22 May 2025 02:35:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879FC1172A;
	Thu, 22 May 2025 02:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747881330; cv=none; b=uO7bS83gk4dihWMkk1MRYMut9aUd4vZpHU//8EZSktYML9IXrtUGjQIwn3azSEyZy854nRX8uOdxsnutVeAhvu5i8Wzvb4pbPNQPyX359OYGIEFIMOdr2MzG1pIS2D+rrel+b1YgNDvnBcP/wGliDQHiyEovrW1tbdVJ6uS7a0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747881330; c=relaxed/simple;
	bh=ttUHZ2SO5aE6GFFXpMt/n/cJfl6ftCJJVoxXZ5mH3ng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iJWoF02Kz2wejHLiCzEJ90OlZFf8sQ377OWmJitRzXUYysueas2ZDcT+7hn5q2hLjg3i1WImaRxK1LLnYl1iA3Zi+Mg1tJtMypoA9UWi8rlkBR9BOLN0/dVbCBPxvn0PDj56KLEPmDgy2S2zFzgJqSrkvPEtQgpCI6rsZHbQKdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 68ae149236b511f0b29709d653e92f7d-20250522
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:615e2428-35b8-4b14-9f8b-321c3f46725e,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6493067,CLOUDID:6ce6c8b6e70f0946646e63f75385181d,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 68ae149236b511f0b29709d653e92f7d-20250522
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2001903690; Thu, 22 May 2025 10:35:22 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 3AC23E003519;
	Thu, 22 May 2025 10:17:07 +0800 (CST)
X-ns-mid: postfix-682E8923-87613444
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id EAE2BE003519;
	Thu, 22 May 2025 10:17:05 +0800 (CST)
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
Subject: [PATCH v2 2/3] PM / Sleep:  Introduce try_lock_system_sleep()
Date: Thu, 22 May 2025 10:16:48 +0800
Message-Id: <20250522021649.55228-3-zhangzihuan@kylinos.cn>
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
 kernel/power/main.c     | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

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
index 6254814d4817..0d3f94f62664 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -58,6 +58,20 @@ unsigned int lock_system_sleep(void)
 }
 EXPORT_SYMBOL_GPL(lock_system_sleep);
=20
+unsigned int try_lock_system_sleep(void)
+{
+	unsigned int flags =3D current->flags;
+	current->flags |=3D PF_NOFREEZE;
+
+	if (!mutex_trylock(&system_transition_mutex)) {
+		current->flags =3D flags;
+		return 0;
+	}
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


