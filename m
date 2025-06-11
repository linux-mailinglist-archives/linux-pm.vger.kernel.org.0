Return-Path: <linux-pm+bounces-28469-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1B5AD5166
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 12:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CF823A7EEA
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 10:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBFD264F89;
	Wed, 11 Jun 2025 10:13:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E298E263C91;
	Wed, 11 Jun 2025 10:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636782; cv=none; b=bkR6K9N999tKD6jznNNfoOSfaNQzFn1OaeQAbCa+IFfqs5hJGmya/RDQmPiCaoCf0ml4yBDqa7nG5SKbRpmTftuUX+tI8SSa6b5VgKEGRSVhWt3KSkSf88LdmWyKc8dM/6vRa9+yB5OWhYDflgQzbWgzq/lPjmRiDwLrnEhV28Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636782; c=relaxed/simple;
	bh=x0ysDCdSVtwr7d/VzdQgT98jYrwymDeXMxc4Lmu+2hA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dITHyD7Pp+XTnw/l9GMIjcvyKGKSRxteSBDEEiRdbha4jVG/Uciok32/jFd4PuAI0q9whZ9C6ecVUIjPD9DszEEWk+3xS2chYI4hD7Vhq6sFHkm2DD5GZTzeesGbG0Sn2YTAd+Xsfb1XE8EbmaN7/9JEaLJQqgDzXdHVJZpqEYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a3e956c846ac11f0b29709d653e92f7d-20250611
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:4f2e3ccf-e0ca-4173-97c8-8181485caaa2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:8bbcba26a1f4f492e2edf1f591ca0942,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a3e956c846ac11f0b29709d653e92f7d-20250611
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 224284829; Wed, 11 Jun 2025 18:12:54 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 7DB47E00891C;
	Wed, 11 Jun 2025 18:12:54 +0800 (CST)
X-ns-mid: postfix-684956A6-354516248
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id E7931E008900;
	Wed, 11 Jun 2025 18:12:53 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v3 1/1] PM / Freezer: Skip zombie/dead processes to
Date: Wed, 11 Jun 2025 18:12:47 +0800
Message-Id: <20250611101247.15522-2-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250611101247.15522-1-zhangzihuan@kylinos.cn>
References: <20250611101247.15522-1-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When freezing user space during suspend or hibernation, the freezer
iterates over all tasks and attempts to freeze them via
try_to_freeze_tasks().

However, zombie processes (i.e., tasks in EXIT_ZOMBIE state) are no
longer running and will never enter the refrigerator. Trying to freeze
them is meaningless and causes extra overhead, especially when there are
thousands of zombies created during stress conditions such as fork
storms.

This patch skips zombie processes during the freezing phase.

In our testing with ~30,000 user processes (including many zombies), the
average freeze time during suspend (S3) dropped from ~43 ms to ~16 ms:

    - Without the patch: ~43 ms average freeze latency
    - With the patch:    ~16 ms average freeze latency
    - Improvement:       ~62%

This confirms that skipping zombies significantly speeds up the freezing
process when the system is under heavy load with many short-lived tasks.

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>

Changes in v3:
- Added performance test

Changes in v2:
- Simplified code, added judgment of dead processes
- Rewrite changelog
---
 kernel/power/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index a6f7ba2d283d..2bbe22610522 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -51,7 +51,7 @@ static int try_to_freeze_tasks(bool user_only)
 		todo =3D 0;
 		read_lock(&tasklist_lock);
 		for_each_process_thread(g, p) {
-			if (p =3D=3D current || !freeze_task(p))
+			if (p =3D=3D current || p->exit_state || !freeze_task(p))
 				continue;
=20
 			todo++;
--=20
2.25.1


