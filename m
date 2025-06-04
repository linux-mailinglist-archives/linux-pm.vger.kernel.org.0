Return-Path: <linux-pm+bounces-28085-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F79ACD654
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 05:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3290A3A7421
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 03:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DD1215179;
	Wed,  4 Jun 2025 03:10:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E03C86337;
	Wed,  4 Jun 2025 03:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749006649; cv=none; b=BxxZW+E5cNIn9trD1pSRcxnA/zBbCKcHZ3WI/FcwRd8o0Mrl5IuQdIjDkwLJoAR5k/gHJ6wweLaDs09z6H0wssS0M6Tlu6QZGckCFULT3ZoCAQj3Nz/itiRKoqaZcll9OfZVY025LdM8DRbQSJtlrRNPBpTeheYzgOUQHui89p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749006649; c=relaxed/simple;
	bh=wkBwDWReUmC3WJ88+crUEMgmlSBBufXjXXl67nIvoRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=okb3TJ9wPwyGW9GzzCtBOLcSakJw/9kZqbmqKKcRCQGVfqo9/G8QAyY+WSrW2JROYmTvTsFdyKiRcEnEPZJ5sfF3Gudfiv/+naJuDbORUZJumwrdVVyS9PgxAOmgZ02JsoJtCBL7V/erasCsPoHaRQczSLYOw+PC//qpyS58ty8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7ebff8cc40f111f0b29709d653e92f7d-20250604
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:af640aba-a206-4dcb-88b9-2ce078e2ace6,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6493067,CLOUDID:632c23e79c9f330fd9d664a4eb7f0627,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:1,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7ebff8cc40f111f0b29709d653e92f7d-20250604
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1464635936; Wed, 04 Jun 2025 11:10:40 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 6F2E2E00891C;
	Wed,  4 Jun 2025 11:10:40 +0800 (CST)
X-ns-mid: postfix-683FB92E-82958516
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 6671CE00891B;
	Wed,  4 Jun 2025 11:10:38 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v1 2/2] PM: suspend: Simplify state check using sleep_state_supported()
Date: Wed,  4 Jun 2025 11:10:24 +0800
Message-Id: <20250604031024.13093-3-zhangzihuan@kylinos.cn>
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


