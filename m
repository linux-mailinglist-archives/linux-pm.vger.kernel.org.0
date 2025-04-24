Return-Path: <linux-pm+bounces-26071-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F18A9A0CD
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 08:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88C01946103
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 06:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77098188CCA;
	Thu, 24 Apr 2025 06:04:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AAB10F9;
	Thu, 24 Apr 2025 06:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745474660; cv=none; b=g24YW5OEXMZiJ3afg8KzLWx3Xm2L3mEY3UXjZvMQJHfopPvdhGfMBe8p4ulOVQzj32HSoEWFan77Mr6/SyxpkKb4SW7Dsog1Sb9ZRupyL/QatcnzBY6q7A4PKmO8ZYO6GseKyj3oojwlS67EjabWPxH6EgSSbTB7c8lR3OFggGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745474660; c=relaxed/simple;
	bh=9jOBxXfqJjzemDWC9wMEr4ZMjIghKXEfbkfvSDfTzJI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aNZnixeBiPMnbek47FYPibbmyeMgBosqrTUtTmsvhe+IpUxlN1uO42rRATzV+Ee00j5NAv5Eo/NN+BtfNH8pzBeEZTF2ihAY3HUIhOP7hXc/SRkr2AVz8K804LwUu2F9Betcm/CAeyjNfcoK9LlQBRLUl9Dk3acWHic9ZsedH14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: eefe56b420d111f0a216b1d71e6e1362-20250424
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:64bc51dd-bad9-4dac-afdd-a839f88dcf1c,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:b990c5b9a7bc245efdf77b7bdb89e918,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: eefe56b420d111f0a216b1d71e6e1362-20250424
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1955800148; Thu, 24 Apr 2025 14:04:07 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id A17F9E000082;
	Thu, 24 Apr 2025 14:04:07 +0800 (CST)
X-ns-mid: postfix-6809D457-383916126
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id BD740E000082;
	Thu, 24 Apr 2025 14:04:06 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v1] PM: Remove unnecessary !!
Date: Thu, 24 Apr 2025 14:03:39 +0800
Message-Id: <20250424060339.73119-1-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Double ! or !! are normally required to get 0 or 1 out of a expression.
A comparision always returns 0 or 1 and hence there is no need to apply
double ! over it again.

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
---
 kernel/power/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index 6254814d4817..97746f08b762 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -594,7 +594,7 @@ power_attr(pm_print_times);
=20
 static inline void pm_print_times_init(void)
 {
-	pm_print_times_enabled =3D !!initcall_debug;
+	pm_print_times_enabled =3D initcall_debug;
 }
=20
 static ssize_t pm_wakeup_irq_show(struct kobject *kobj,
--=20
2.25.1


