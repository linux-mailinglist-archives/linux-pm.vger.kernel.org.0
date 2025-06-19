Return-Path: <linux-pm+bounces-29034-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1179ADFC11
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 05:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66501BC098D
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 03:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAF924110F;
	Thu, 19 Jun 2025 03:55:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A42823C50B;
	Thu, 19 Jun 2025 03:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750305300; cv=none; b=VPGKjuApRqImFN0D1BsaVfApgoD8bOfesL+mrxMeRwPN1sTFJV+4GnHuWj2kTt/LX6FWXJ1a22E0rXR43dk3VabUBBsgfQNoo2ldLxVIaU9cb0msP4VMr37SFwm5HEjWy6Rwvrpnp9CEo3W3Eq3bLrr/gOT8QgCDPRLxVjl9/mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750305300; c=relaxed/simple;
	bh=wkBwDWReUmC3WJ88+crUEMgmlSBBufXjXXl67nIvoRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hAqbRHnylziTLP/ObvJB50f2iMoU7vnB6/UVyz4GfjPq9hQZhwErZP8QGV9vWyBKbmofMRqpUzhKJJEnr/JmoSfOWxOStGJItnbEuDiLT0hto4S3nWI3RjVduQjeTDce3rfdYiyEaHKGGJjWsUKHpzwIKtx3X6wopHQPoD/Naqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 28437e5c4cc111f0b29709d653e92f7d-20250619
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:e0c611f5-6af2-4b27-bfee-9bfc5143c9b5,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6493067,CLOUDID:8dc46cc638afb5e98fed8effba1e0052,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:1,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 28437e5c4cc111f0b29709d653e92f7d-20250619
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1067101472; Thu, 19 Jun 2025 11:54:53 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 2B176E00891C;
	Thu, 19 Jun 2025 11:54:53 +0800 (CST)
X-ns-mid: postfix-68538A0D-4009511
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 973E5E008900;
	Thu, 19 Jun 2025 11:54:52 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v2 4/4] PM: suspend: Simplify state check using sleep_state_supported()
Date: Thu, 19 Jun 2025 11:53:55 +0800
Message-Id: <20250619035355.33402-5-zhangzihuan@kylinos.cn>
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

Currently enter_state() open-codes state validation using
`if (state =3D=3D PM_SUSPEND_TO_IDLE) ... else if (!valid_state(state)) .=
..`.

This can be simplified by calling sleep_state_supported(), which already
encodes this logic. This improves clarity and reduces duplication.

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
---
 kernel/power/suspend.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 16172ca22f21..b95c7a80ef20 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -571,16 +571,10 @@ static int enter_state(suspend_state_t state)
 	int error;
=20
 	trace_suspend_resume(TPS("suspend_enter"), state, true);
-	if (state =3D=3D PM_SUSPEND_TO_IDLE) {
-#ifdef CONFIG_PM_DEBUG
-		if (pm_test_level !=3D TEST_NONE && pm_test_level <=3D TEST_CPUS) {
-			pr_warn("Unsupported test mode for suspend to idle, please choose non=
e/freezer/devices/platform.\n");
-			return -EAGAIN;
-		}
-#endif
-	} else if (!valid_state(state)) {
-		return -EINVAL;
-	}
+
+	if (!sleep_state_supported(state))
+		return -ENOSYS;
+
 	if (!mutex_trylock(&system_transition_mutex))
 		return -EBUSY;
=20
--=20
2.25.1


