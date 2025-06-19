Return-Path: <linux-pm+bounces-29031-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D38ADFC09
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 05:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 348E53ABE83
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 03:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D877A23A987;
	Thu, 19 Jun 2025 03:54:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531C223A98E;
	Thu, 19 Jun 2025 03:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750305296; cv=none; b=deXTrwxyLNzicza4mnYICBJcKoV7gvGBKbqM4d/RANeiWgKYGpX7YYWxfWDHn2LRI8VPJofY5fLJhXY9ct/Qpvq7hZXky08iuqOpwbbwD9w+Nbr0BSZGkPtFmUuzDrlmw7mbKIT6VJ3heeaLo2quYZ5ScYMuSLgQeDXRMFqEnH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750305296; c=relaxed/simple;
	bh=fZSVGE1O4xTy4YTkQhSi8BuCDJSqE1i4HitHdLcQimQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XPQYNfXwjp4c/6CNignOe/hh8Frvj8hH9reNeZDcdQdYBfXuBeBbuC9wyC0JZEkvQ4fFxLkfWUwdKIQUJVmMQFyLFkP04X+RUldBAS/kl3vtoGQ+HdRp1IhGFduDz5Mag5BTulFmN6C0wm0USXRS0VG6UXUVFNMqL7baC2GXRGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 260cfe2e4cc111f0b29709d653e92f7d-20250619
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:470fc5b0-a2b4-4598-825a-d6f051aa7744,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:44a0a1af001ac5a643a542b508c9405f,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 260cfe2e4cc111f0b29709d653e92f7d-20250619
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1184961320; Thu, 19 Jun 2025 11:54:49 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id BE55FE008900;
	Thu, 19 Jun 2025 11:54:49 +0800 (CST)
X-ns-mid: postfix-68538A07-177829
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 933FCE00891C;
	Thu, 19 Jun 2025 11:54:46 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v2 2/4] PM: freezer: Print tasks stuck in D-state during freeze
Date: Thu, 19 Jun 2025 11:53:53 +0800
Message-Id: <20250619035355.33402-3-zhangzihuan@kylinos.cn>
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

To help diagnose freezing delays caused by tasks stuck in D-state, this
patch adds logging for tasks that are stuck in D-state during each retry
of the freezer loop.  Such tasks are not killable and cannot be frozen,
which can cause the system suspend process to retry many times
before aborting.  This message can help developers identify which
user-space or kernel tasks are blocking the freeze process.

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
---
 kernel/power/process.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index 87616ca710ac..4007f621c2ad 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -55,6 +55,9 @@ static int try_to_freeze_tasks(bool user_only)
 			if (p =3D=3D current || !freeze_task(p))
 				continue;
=20
+			if (retry > 1 && READ_ONCE(p->__state) =3D=3D TASK_UNINTERRUPTIBLE)
+				sched_show_task(p);
+
 			todo++;
 		}
 		read_unlock(&tasklist_lock);
--=20
2.25.1


