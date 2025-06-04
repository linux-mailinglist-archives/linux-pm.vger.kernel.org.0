Return-Path: <linux-pm+bounces-28084-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 573AAACD652
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 05:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F963A735F
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 03:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83068238C04;
	Wed,  4 Jun 2025 03:10:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8230786337;
	Wed,  4 Jun 2025 03:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749006645; cv=none; b=a7NIfuGHvPn/s/OtYiBMcNJfI9PxyNiZWv9w6mQ8+KyTGGI/ogC62XUPeIEdYzoHiifZk0aKUFjy29lbgEokiJuI6LSwp2MvcyXtAQ/vIudnXfNrhmTFVF2ybI4jKwsXhwCdqORRIZvnrcGhFMqh2k8QBPCM69BuigGjOfq3Rkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749006645; c=relaxed/simple;
	bh=y2uzoZ5QOSb6Z3GzmpyquAH2fLVaaVeh57OqZC7M0X0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jSxR7lHaWzdPQMV1zIVldiWdyHXItBpOgFeQloAV9N9EX4TJIsqWZpJy/EXiRVsg/VQdveR0L5yEg6X5o3Ef/R3NKq2xsW5e4e+R+BzLcClPA9PklXv0lreYSHREz6M4lrfJKnYyZToEH0hpqiupgn2xvtca8Lmj0szH3Ttz6K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7c7a188640f111f0b29709d653e92f7d-20250604
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:b2d976f4-0b6b-4079-baee-20b183da6a7f,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6493067,CLOUDID:44588aa358188fd8e5850a09b38d0a28,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:1,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7c7a188640f111f0b29709d653e92f7d-20250604
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1566144030; Wed, 04 Jun 2025 11:10:36 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 9D2FFE00891C;
	Wed,  4 Jun 2025 11:10:36 +0800 (CST)
X-ns-mid: postfix-683FB92C-49256015
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 14F78E00891B;
	Wed,  4 Jun 2025 11:10:36 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v1 1/2] PM: suspend: Assign pm_suspend_target_state earlier for valid debug logs
Date: Wed,  4 Jun 2025 11:10:23 +0800
Message-Id: <20250604031024.13093-2-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250604031024.13093-1-zhangzihuan@kylinos.cn>
References: <20250604031024.13093-1-zhangzihuan@kylinos.cn>
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


