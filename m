Return-Path: <linux-pm+bounces-29032-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF92AADFC0B
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 05:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9410517F9FB
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 03:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B48023BD02;
	Thu, 19 Jun 2025 03:54:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212B023ABAC;
	Thu, 19 Jun 2025 03:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750305299; cv=none; b=WeWnjQ6eJqfszM09nXc4zjY0ZUlN0S29d4vXA+h76jUh5lJ+iQgHbYgRvA1g8A79gZDvsas6kx/1m245Ny3H+ypFuY3u5ZrlW5jO1JRiycgNQQ0rJfPnhcDMUqf4hDw2rfcqAOglzQWSHTnDpyIMedxpSyoCmRUywHSpD0TdSZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750305299; c=relaxed/simple;
	bh=y2uzoZ5QOSb6Z3GzmpyquAH2fLVaaVeh57OqZC7M0X0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kRcsq5d0cOsrYSUIXt8v3gw12zvoVBc84B+b34fxtD+GepBjcjJnSkhydavy8Z+RPVrnjzH61/2HTDtoqB5ouXMExG58+vuI7wrhNzayFx3Xr+yaEqKUU3h89u/nXwMocVK+dQBEELFWYcPTTHFr4OPxlgF5W6w9Y+dz0RK1a+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 272a7d544cc111f0b29709d653e92f7d-20250619
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:cf6224e5-702d-42b7-8378-6c106d07fa6c,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6493067,CLOUDID:b2808c8d7950ceec268a4d1ec147fdda,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:1,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 272a7d544cc111f0b29709d653e92f7d-20250619
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1059521812; Thu, 19 Jun 2025 11:54:51 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 9E03AE00891C;
	Thu, 19 Jun 2025 11:54:51 +0800 (CST)
X-ns-mid: postfix-68538A0B-23206110
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id C77F9E008900;
	Thu, 19 Jun 2025 11:54:50 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v2 3/4] PM: suspend: Assign pm_suspend_target_state earlier for valid debug logs
Date: Thu, 19 Jun 2025 11:53:54 +0800
Message-Id: <20250619035355.33402-4-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250619035355.33402-1-zhangzihuan@kylinos.cn>
References: <20250619035355.33402-1-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

pm_suspend_target_state is used in debug logs inside enter_state(), but
it is only assigned inside suspend_devices_and_enter(), which is too late=
.

This causes early pm_pr_dbg() output to either show incorrect state or
nothing at all, making suspend debugging harder.

Assign pm_suspend_target_state at the beginning of enter_state() to ensur=
e
early log output is meaningful.

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
---
 kernel/power/suspend.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 76b141b9aac0..16172ca22f21 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -584,6 +584,8 @@ static int enter_state(suspend_state_t state)
 	if (!mutex_trylock(&system_transition_mutex))
 		return -EBUSY;
=20
+	pm_suspend_target_state =3D state;
+
 	if (state =3D=3D PM_SUSPEND_TO_IDLE)
 		s2idle_begin();
=20
@@ -616,6 +618,7 @@ static int enter_state(suspend_state_t state)
 	suspend_finish();
  Unlock:
 	filesystems_thaw();
+	pm_suspend_target_state =3D PM_SUSPEND_ON;
 	mutex_unlock(&system_transition_mutex);
 	return error;
 }
--=20
2.25.1


