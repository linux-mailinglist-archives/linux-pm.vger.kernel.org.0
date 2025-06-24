Return-Path: <linux-pm+bounces-29424-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC53AE63E6
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 13:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48FBE7A3A65
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 11:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155A328D845;
	Tue, 24 Jun 2025 11:52:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B73C21A42F;
	Tue, 24 Jun 2025 11:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750765979; cv=none; b=A3gEeUSvLJCA6B7I1d5cVAv9erhAe38dV+XIb1oTVC0hNCKMKpTU40OJlg42qC/rhWJgd4waRgZgfNYtPh04Iui4A09Dy/uEEIotLSzGmfN5RqvzcEYBWzlzWCnpNqwDzfokftWO7Alz1UEK96qvHcQnPo9pTsFIjtg4rGGDgJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750765979; c=relaxed/simple;
	bh=SNEL7ff1bV6EVPxE0ymDSSOChJQcy4tMjss3xXofuBg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=V3Tm8ZqSnlWh2QacnF4EdnwtGJ9/473AcAVuw5NaziDRN1TZbukCvIyO6YStqnC1KdlEF9grt2XJpdFuXHxQ6MeC7ldpIrf8fsQHQ3o8kG7rJatfuDnV8AL0altpinghcbaguVBqqs+4gZyaA/71SrTfeSq+2EAKwGJfsVTIS0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: bfcc14d050f111f0b29709d653e92f7d-20250624
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:63eea734-fc57-472e-97a4-89637b6213d8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:45fbe85e95b5f6139c8a5b66904cc175,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: bfcc14d050f111f0b29709d653e92f7d-20250624
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 398538517; Tue, 24 Jun 2025 19:52:48 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 2E28EE008FA5;
	Tue, 24 Jun 2025 19:52:48 +0800 (CST)
X-ns-mid: postfix-685A9190-456638
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 422F3E008FA4;
	Tue, 24 Jun 2025 19:52:47 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v1] [RFC PATCH] PM / freezer: skip kernel threads with PF_NOFREEZE to reduce freeze overhead
Date: Tue, 24 Jun 2025 19:52:44 +0800
Message-Id: <20250624115244.19260-1-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

We are exploring performance optimizations in the freezer subsystem, and
would like to submit this RFC patch for your feedback.

On modern systems, the number of kernel threads can easily reach several
hundred.  However, during suspend or hibernate, only a small fraction of
them are actually freezable. Most kernel threads are marked with
`PF_NOFREEZE`.

Despite this, the freezer still traverses every task in the system and
calls `freeze_task()` on all of them.

To reduce this overhead, we propose skipping kernel threads that are
guaranteed non-freezable (`PF_KTHREAD && PF_NOFREEZE`) earlier in the
traversal.

While studying the freezer behavior, we noticed that some kernel threads
had `PF_FROZEN` set but never actually entered `refrigerator()`. This is
confusing, and may indicate subtle races or incomplete freeze logic.

We also observed that some kernel threads are marked as freezable (i.e.
not `PF_NOFREEZE`) but never actually enter the frozen state =E2=80=94 li=
kely
because they never reach `try_to_freeze()` within the freeze window.
This further calls into question whether we should treat such threads as
true freeze targets.

One concern is that kernel threads may **dynamically change state**
during the freeze window. This makes it non-trivial to decide statically
which threads are safe to skip.

This RFC patch adds a preliminary filter to skip kernel threads that are
both:

- Marked with `PF_KTHREAD`; and
- Marked with `PF_NOFREEZE`;

These threads will no longer go through `freeze_task()` or count toward
the `todo` counter. The goal is to reduce traversal time and avoid
unnecessary bookkeeping for threads we know will always be skipped.

We would like to hear your thoughts on whether:

1. This change is acceptable and aligns with the freezer model's design;
2. It's worth pursuing as a real optimization (even if the gain is
   modest);
3. We should further investigate dynamic kernel thread behavior during
   suspend.

here is the S3 log:
grep -E "entered|freezable:1|set_task" dmesg
[  134.344100] current kernel process name:kauditd pid:101 freezable:1 fr=
ozen:0
[  134.344138] current kernel process name:oom_reaper pid:113 freezable:1=
 frozen:0
[  134.344144] current kernel process name:kcompactd0 pid:115 freezable:1=
 frozen:0
[  134.344147] current kernel process name:ksmd pid:116 freezable:1 froze=
n:0
[  134.344150] current kernel process name:khugepaged pid:117 freezable:1=
 frozen:0
[  134.344182] current kernel process name:kswapd0 pid:129 freezable:1 fr=
ozen:0
[  134.344328] current kernel process name:jbd2/sdb3-8 pid:446 freezable:=
1 frozen:0
[  134.344334] current kernel process name:jbd2/sdb2-8 pid:505 freezable:=
1 frozen:0
[  134.344343] current kernel process name:jbd2/sda1-8 pid:510 freezable:=
1 frozen:0
[  134.346411] current kernel process name:kauditd pid:101 freezable:1 fr=
ozen:0
[  134.346434] current kernel process name:oom_reaper pid:113 freezable:1=
 frozen:0
[  134.346438] current kernel process name:kcompactd0 pid:115 freezable:1=
 frozen:0
[  134.346440] current kernel process name:ksmd pid:116 freezable:1 froze=
n:0
[  134.346442] current kernel process name:khugepaged pid:117 freezable:1=
 frozen:0
[  134.346465] current kernel process name:kswapd0 pid:129 freezable:1 fr=
ozen:0
[  134.346567] current kernel process name:jbd2/sdb3-8 pid:446 freezable:=
1 frozen:0
[  134.346571] current kernel process name:jbd2/sdb2-8 pid:505 freezable:=
1 frozen:0
[  134.346577] current kernel process name:jbd2/sda1-8 pid:510 freezable:=
1 frozen:0
[  134.348282] current kernel process name:kauditd pid:101 freezable:1 fr=
ozen:0
[  134.348303] current kernel process name:oom_reaper pid:113 freezable:1=
 frozen:0
[  134.348306] current kernel process name:kcompactd0 pid:115 freezable:1=
 frozen:0
[  134.348308] current kernel process name:ksmd pid:116 freezable:1 froze=
n:0
[  134.348310] current kernel process name:khugepaged pid:117 freezable:1=
 frozen:0
[  134.348331] current kernel process name:kswapd0 pid:129 freezable:1 fr=
ozen:0
[  134.348421] current kernel process name:jbd2/sdb3-8 pid:446 freezable:=
1 frozen:0
[  134.348424] current kernel process name:jbd2/sdb2-8 pid:505 freezable:=
1 frozen:0
[  134.348429] current kernel process name:jbd2/sda1-8 pid:510 freezable:=
1 frozen:0
[  134.352330] current kernel process name:kauditd pid:101 freezable:1 fr=
ozen:0
[  134.352351] current kernel process name:oom_reaper pid:113 freezable:1=
 frozen:0
[  134.352354] current kernel process name:kcompactd0 pid:115 freezable:1=
 frozen:0
[  134.352356] current kernel process name:ksmd pid:116 freezable:1 froze=
n:0
[  134.352358] current kernel process name:khugepaged pid:117 freezable:1=
 frozen:0
[  134.352379] current kernel process name:kswapd0 pid:129 freezable:1 fr=
ozen:0
[  134.352469] current kernel process name:jbd2/sdb3-8 pid:446 freezable:=
1 frozen:0
[  134.352473] current kernel process name:jbd2/sdb2-8 pid:505 freezable:=
1 frozen:0
[  134.352478] current kernel process name:jbd2/sda1-8 pid:510 freezable:=
1 frozen:0
[  134.360328] current kernel process name:kauditd pid:101 freezable:1 fr=
ozen:0
[  134.360349] current kernel process name:oom_reaper pid:113 freezable:1=
 frozen:0
[  134.360353] current kernel process name:kcompactd0 pid:115 freezable:1=
 frozen:0
[  134.360354] current kernel process name:ksmd pid:116 freezable:1 froze=
n:0
[  134.360356] current kernel process name:khugepaged pid:117 freezable:1=
 frozen:0
[  134.360377] current kernel process name:kswapd0 pid:129 freezable:1 fr=
ozen:0
[  134.360467] current kernel process name:jbd2/sdb3-8 pid:446 freezable:=
1 frozen:0
[  134.360471] current kernel process name:jbd2/sdb2-8 pid:505 freezable:=
1 frozen:0
[  134.360476] current kernel process name:jbd2/sda1-8 pid:510 freezable:=
1 frozen:0
[  134.368321] current kernel process name:kauditd pid:101 freezable:1 fr=
ozen:0
[  134.368342] current kernel process name:oom_reaper pid:113 freezable:1=
 frozen:0
[  134.368345] current kernel process name:kcompactd0 pid:115 freezable:1=
 frozen:0
[  134.368347] current kernel process name:ksmd pid:116 freezable:1 froze=
n:0
[  134.368349] current kernel process name:khugepaged pid:117 freezable:1=
 frozen:0
[  134.368370] current kernel process name:kswapd0 pid:129 freezable:1 fr=
ozen:0
[  134.368460] current kernel process name:jbd2/sdb3-8 pid:446 freezable:=
1 frozen:0
[  134.368463] current kernel process name:jbd2/sdb2-8 pid:505 freezable:=
1 frozen:0
[  134.368469] current kernel process name:jbd2/sda1-8 pid:510 freezable:=
1 frozen:0
[  134.376307] current kernel process name:kauditd pid:101 freezable:1 fr=
ozen:0
[  134.376329] current kernel process name:oom_reaper pid:113 freezable:1=
 frozen:0
[  134.376332] current kernel process name:kcompactd0 pid:115 freezable:1=
 frozen:0
[  134.376334] current kernel process name:ksmd pid:116 freezable:1 froze=
n:0
[  134.376336] current kernel process name:khugepaged pid:117 freezable:1=
 frozen:0
[  134.376356] current kernel process name:kswapd0 pid:129 freezable:1 fr=
ozen:0
[  134.376446] current kernel process name:jbd2/sdb3-8 pid:446 freezable:=
1 frozen:0
[  134.376450] current kernel process name:jbd2/sdb2-8 pid:505 freezable:=
1 frozen:0
[  134.376455] current kernel process name:jbd2/sda1-8 pid:510 freezable:=
1 frozen:0
[  134.385070] current kernel process name:kauditd pid:101 freezable:1 fr=
ozen:0
[  134.385093] current kernel process name:oom_reaper pid:113 freezable:1=
 frozen:0
[  134.385097] current kernel process name:kcompactd0 pid:115 freezable:1=
 frozen:0
[  134.385106] current kernel process name:ksmd pid:116 freezable:1 froze=
n:0
[  134.385108] current kernel process name:khugepaged pid:117 freezable:1=
 frozen:0
[  134.385136] current kernel process name:kswapd0 pid:129 freezable:1 fr=
ozen:0
[  134.385238] current kernel process name:jbd2/sdb3-8 pid:446 freezable:=
1 frozen:0
[  134.385242] current kernel process name:jbd2/sdb2-8 pid:505 freezable:=
1 frozen:0
[  134.385247] current kernel process name:jbd2/sda1-8 pid:510 freezable:=
1 frozen:0
[  134.385755] current kernel process name:kauditd pid:101 freezable:1 fr=
ozen:0
[  134.385756] set_task_frozen kernel thread name:kauditd pid:101
[  134.385778] current kernel process name:oom_reaper pid:113 freezable:1=
 frozen:0
[  134.385779] set_task_frozen kernel thread name:oom_reaper pid:113
[  134.385782] current kernel process name:kcompactd0 pid:115 freezable:1=
 frozen:0
[  134.385783] set_task_frozen kernel thread name:kcompactd0 pid:115
[  134.385785] current kernel process name:ksmd pid:116 freezable:1 froze=
n:0
[  134.385786] set_task_frozen kernel thread name:ksmd pid:116
[  134.385788] current kernel process name:khugepaged pid:117 freezable:1=
 frozen:0
[  134.385789] set_task_frozen kernel thread name:khugepaged pid:117
[  134.385810] current kernel process name:kswapd0 pid:129 freezable:1 fr=
ozen:0
[  134.385849] kswapd0 entered refrigerator
[  134.385911] current kernel process name:jbd2/sdb3-8 pid:446 freezable:=
1 frozen:0
[  134.385917] current kernel process name:jbd2/sdb2-8 pid:505 freezable:=
1 frozen:0
[  134.385917] jbd2/sdb3-8 entered refrigerator
[  134.385926] current kernel process name:jbd2/sda1-8 pid:510 freezable:=
1 frozen:0
[  134.385953] jbd2/sdb2-8 entered refrigerator
[  134.385963] jbd2/sda1-8 entered refrigerator
[  134.387526] current kernel process name:kauditd pid:101 freezable:1 fr=
ozen:1
[  134.387549] current kernel process name:oom_reaper pid:113 freezable:1=
 frozen:1
[  134.387553] current kernel process name:kcompactd0 pid:115 freezable:1=
 frozen:1
[  134.387555] current kernel process name:ksmd pid:116 freezable:1 froze=
n:1
[  134.387557] current kernel process name:khugepaged pid:117 freezable:1=
 frozen:1
[  134.387581] current kernel process name:kswapd0 pid:129 freezable:1 fr=
ozen:1
[  134.387682] current kernel process name:jbd2/sdb3-8 pid:446 freezable:=
1 frozen:1
[  134.387686] current kernel process name:jbd2/sdb2-8 pid:505 freezable:=
1 frozen:1
[  134.387692] current kernel process name:jbd2/sda1-8 pid:510 freezable:=
1 frozen:1

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
---
 kernel/power/process.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index dc0dfc349f22..49dc6545a099 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -51,6 +51,8 @@ static int try_to_freeze_tasks(bool user_only)
 		todo =3D 0;
 		read_lock(&tasklist_lock);
 		for_each_process_thread(g, p) {
+			if ((p->flags & PF_KTHREAD) && !(p->flags & PF_NOFREEZE))
+				continue;
 			if (p =3D=3D current || !freeze_task(p))
 				continue;
=20
--=20
2.25.1


