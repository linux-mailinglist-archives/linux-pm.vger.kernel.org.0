Return-Path: <linux-pm+bounces-29030-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1857ADFC07
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 05:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C8C3A5D97
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 03:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE6D239E9C;
	Thu, 19 Jun 2025 03:54:48 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE4D23908B;
	Thu, 19 Jun 2025 03:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750305288; cv=none; b=NKmiAlj9cwtvDNwPIcGOO1v5EW9gUaScTzRmCAKOsdNZmCjY1cf4+XRfIT1/gd1AmkK51v6o/LRxTwlaOp0K2puaHIMZdvxJusH36K8kJPRF3+vtYdFk4PbdISaOdOFW3fmtfgyIWQn6KZshUqHHCTnttEdwzVLNDnKbNpjDAf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750305288; c=relaxed/simple;
	bh=eAit7dLjhFoUkFRK3AiJoiIf5OY6G3Y0LTeOZ+nYXh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UDX1qKF+Kebhf2sMcUT6XPTH6fZLQhIMgBI/vnKH5vqmBE/9A2o6sXrkcJo0FIVdbG4FTvCXwxZGNlYdkjgzEng1ZMTkIHYlP0VceFKK2NaOdkn7VOhOlq2KRwNNinV7D8rHRE05GI7CHZMSCDnLx095R0JCocyeiHv07LONJoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 210d6f944cc111f0b29709d653e92f7d-20250619
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:b4670211-3e8c-4c09-ae35-55eff7c8895b,IP:0,U
	RL:0,TC:0,Content:-25,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-50
X-CID-META: VersionHash:6493067,CLOUDID:97fb7946ccfa904ee71656e6ca9055b8,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:1,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 210d6f944cc111f0b29709d653e92f7d-20250619
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1690500008; Thu, 19 Jun 2025 11:54:41 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 5CA6DE00891C;
	Thu, 19 Jun 2025 11:54:41 +0800 (CST)
X-ns-mid: postfix-68538A01-2107067
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 5BB6BE008900;
	Thu, 19 Jun 2025 11:54:22 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v2 1/4] PM: freezer: Add retry count statistics for freeze pass iterations
Date: Thu, 19 Jun 2025 11:53:52 +0800
Message-Id: <20250619035355.33402-2-zhangzihuan@kylinos.cn>
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

Freezer retry loops during suspend are often triggered by tasks entering
D-state (TASK_UNINTERRUPTIBLE), which cannot be frozen.  This patch adds
a simple retry counter to freeze_processes() to help quantify how many
attempts were required before all tasks entered the frozen state. This
is useful for performance tuning and debugging unpredictable suspend
delays.

A new dmesg log is added for visibility:

freeze round: xx, tasks to freeze: xx

This message allows users to correlate freeze instability with system
state.

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
---
 kernel/power/process.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index dc0dfc349f22..87616ca710ac 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -32,6 +32,7 @@ static int try_to_freeze_tasks(bool user_only)
 	struct task_struct *g, *p;
 	unsigned long end_time;
 	unsigned int todo;
+	unsigned int retry =3D 0;
 	bool wq_busy =3D false;
 	ktime_t start, end, elapsed;
 	unsigned int elapsed_msecs;
@@ -63,6 +64,8 @@ static int try_to_freeze_tasks(bool user_only)
 			todo +=3D wq_busy;
 		}
=20
+		pm_pr_dbg("freeze round: %d, task to freeze: %d\n", retry, todo);
+
 		if (!todo || time_after(jiffies, end_time))
 			break;
=20
@@ -79,6 +82,7 @@ static int try_to_freeze_tasks(bool user_only)
 		usleep_range(sleep_usecs / 2, sleep_usecs);
 		if (sleep_usecs < 8 * USEC_PER_MSEC)
 			sleep_usecs *=3D 2;
+		retry++;
 	}
=20
 	end =3D ktime_get_boottime();
--=20
2.25.1


