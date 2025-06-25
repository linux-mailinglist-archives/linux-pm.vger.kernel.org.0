Return-Path: <linux-pm+bounces-29516-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F76AE867C
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 16:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F7D17AE912
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 14:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD255265CB2;
	Wed, 25 Jun 2025 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ph7pKFDr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466D9265CAA
	for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750861727; cv=none; b=HpwVk8BFnbTfh+fG3FJxOOig+qRz2WxIgjdKrOcvSjvH3dckKr/1b8nVnZWV8+Oc36gIhdY9WXEgQ3yoY5F+sNpAOpsqnLZrI5MnDWnZGwhpKRuOEaLZ4xhh5fEUIdJWgnbDZvFfkX7j5Bnj9mYFbraR5y0k4i3QsJR1bYsIkCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750861727; c=relaxed/simple;
	bh=dAl+J1Tcz6ISMuuOHvn3vHfUwlysIZFZemmbPeXBWik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=YpjN2loiUe0aUOZAxGpe3Ka8seIAO9k/k7bkLtpLbVJnOjFe39ODeoPjqZK2FyuPVU5Kfz8Jd1Lf7hmulBge1WG9F43dlmSC6W+wlfZ2tZlmW8Vyy2Mgu4XvEosaQA8DfteD+KViWBcG2w6r0Hx2gYyasLZ3QLCUVTEi+ZeMxQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Ph7pKFDr; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250625142842euoutp02008d3f1d6809525fa1fa588a941ed4d9~MT3XJYC0I1827618276euoutp02u
	for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 14:28:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250625142842euoutp02008d3f1d6809525fa1fa588a941ed4d9~MT3XJYC0I1827618276euoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750861722;
	bh=BEHqxKld16NZowdsW9ycdGcz0oJJ1gT1yM+f7Rye0OQ=;
	h=From:To:Cc:Subject:Date:References:From;
	b=Ph7pKFDryvyLl2EdRhSLOrwswY0PgMoB3sYDrvk/rNsTvGF/xlk2INtf5dnASSi1d
	 a/Mo3ftrqvLh49cBkOXpaZINHrC+3eE5uYrPMT0XEUm1MejC9dAKl35std3tpoamPG
	 ymhl3om1x2pNfXJSwpk3ZUm4wnD73J7UH4dPM1/Y=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250625142842eucas1p1679542a6f19dbc518a71b603e4c1ac1d~MT3Wy58Sy1524315243eucas1p1X;
	Wed, 25 Jun 2025 14:28:42 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250625142841eusmtip1aa0b54a9e4cc0989b543e2f351b57c02~MT3WkfpJf0314403144eusmtip1A;
	Wed, 25 Jun 2025 14:28:41 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Georgi Djakov
	<djakov@kernel.org>
Subject: [PATCH] interconnect: core: Fix circular locking dependency with
 fs_reclaim lock
Date: Wed, 25 Jun 2025 16:28:31 +0200
Message-Id: <20250625142831.754887-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250625142842eucas1p1679542a6f19dbc518a71b603e4c1ac1d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250625142842eucas1p1679542a6f19dbc518a71b603e4c1ac1d
X-EPHeader: CA
X-CMS-RootMailID: 20250625142842eucas1p1679542a6f19dbc518a71b603e4c1ac1d
References: <CGME20250625142842eucas1p1679542a6f19dbc518a71b603e4c1ac1d@eucas1p1.samsung.com>

icc_node_add() calls devm_kasprintf() with GFP_KERNEL allocation mode
under icc_bw_lock. This might lead to circular locking dependency with
fs_reclaim lock as reported by lockdep checker. Fix this by changing
that allocation mode to GFP_ATOMIC.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/interconnect/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
This issue has been observed on Qualcomm RB5 board. Here is a detailed lockdep
warning:
======================================================
WARNING: possible circular locking dependency detected
6.15.0-next-20250527 #10635 Not tainted
------------------------------------------------------
(udev-worker)/217 is trying to acquire lock:
ffffb29952bef2c0 (fs_reclaim){+.+.}-{0:0}, at: __kmalloc_node_track_caller_noprof+0xa4/0x3e0

but task is already holding lock:
ffffb29952ffc588 (icc_bw_lock){+.+.}-{4:4}, at: icc_node_add+0x44/0x154

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (icc_bw_lock){+.+.}-{4:4}
       icc_init+0x48/0x108
       do_one_initcall+0x64/0x308
       kernel_init_freeable+0x284/0x4ec
       kernel_init+0x20/0x1d8
       ret_from_fork+0x10/0x20

-> #0 (fs_reclaim){+.+.}-{0:0}:
       __lock_acquire+0x1408/0x2254
       lock_acquire+0x1c8/0x354
       fs_reclaim_acquire+0xd0/0xe4
       __kmalloc_node_track_caller_noprof+0xa4/0x3e0
       devm_kmalloc+0x58/0x114
       devm_kvasprintf+0x74/0xd4
       devm_kasprintf+0x58/0x80
       icc_node_add+0xb4/0x154
       qcom_osm_l3_probe+0x1f0/0x2cc [icc_osm_l3]
       platform_probe+0x68/0xdc
       really_probe+0xbc/0x298
       __driver_probe_device+0x78/0x12c
       driver_probe_device+0x40/0x164
       __driver_attach+0x9c/0x1ac
       bus_for_each_dev+0x74/0xd0
       driver_attach+0x24/0x30
       bus_add_driver+0xe4/0x208
       driver_register+0x60/0x128
       __platform_driver_register+0x24/0x30
       osm_l3_driver_init+0x20/0x1000 [icc_osm_l3]
       do_one_initcall+0x64/0x308
       do_init_module+0x58/0x23c
       load_module+0x1b80/0x1e38
       init_module_from_file+0x84/0xc4
       idempotent_init_module+0x188/0x27c
       __arm64_sys_finit_module+0x68/0xac
       invoke_syscall+0x48/0x110
       el0_svc_common.constprop.0+0xc8/0xe8
       do_el0_svc+0x20/0x2c
       el0_svc+0x4c/0x158
       el0t_64_sync_handler+0x144/0x168
       el0t_64_sync+0x198/0x19c

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(icc_bw_lock);
                               lock(fs_reclaim);
                               lock(icc_bw_lock);
  lock(fs_reclaim);

 *** DEADLOCK ***

3 locks held by (udev-worker)/217:
 #0: ffff0000816488f8 (&dev->mutex){....}-{4:4}, at: __driver_attach+0x90/0x1ac
 #1: ffffb29952ffc490 (icc_lock){+.+.}-{4:4}, at: icc_node_add+0x38/0x154
 #2: ffffb29952ffc588 (icc_bw_lock){+.+.}-{4:4}, at: icc_node_add+0x44/0x154

stack backtrace:
CPU: 7 UID: 0 PID: 217 Comm: (udev-worker) Not tainted 6.15.0-next-20250527 #10635 PREEMPT
Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
Call trace:
 show_stack+0x18/0x24 (C)
 dump_stack_lvl+0x90/0xd0
 dump_stack+0x18/0x24
 print_circular_bug+0x298/0x37c
 check_noncircular+0x15c/0x170
 __lock_acquire+0x1408/0x2254
 lock_acquire+0x1c8/0x354
 fs_reclaim_acquire+0xd0/0xe4
 __kmalloc_node_track_caller_noprof+0xa4/0x3e0
 devm_kmalloc+0x58/0x114
 devm_kvasprintf+0x74/0xd4
 devm_kasprintf+0x58/0x80
 icc_node_add+0xb4/0x154
 qcom_osm_l3_probe+0x1f0/0x2cc [icc_osm_l3]
 platform_probe+0x68/0xdc
 really_probe+0xbc/0x298
 __driver_probe_device+0x78/0x12c
 driver_probe_device+0x40/0x164
 __driver_attach+0x9c/0x1ac
 bus_for_each_dev+0x74/0xd0
 driver_attach+0x24/0x30
 bus_add_driver+0xe4/0x208
 driver_register+0x60/0x128
 __platform_driver_register+0x24/0x30
 osm_l3_driver_init+0x20/0x1000 [icc_osm_l3]
 do_one_initcall+0x64/0x308
 do_init_module+0x58/0x23c
 load_module+0x1b80/0x1e38
 init_module_from_file+0x84/0xc4
 idempotent_init_module+0x188/0x27c
 __arm64_sys_finit_module+0x68/0xac
 invoke_syscall+0x48/0x110
 el0_svc_common.constprop.0+0xc8/0xe8
 do_el0_svc+0x20/0x2c
 el0_svc+0x4c/0x158
 el0t_64_sync_handler+0x144/0x168
 el0t_64_sync+0x198/0x19c

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 1a41e59c77f8..f6e9f3de6d48 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -1039,7 +1039,7 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
 	node->peak_bw = node->init_peak;
 
 	if (node->id >= ICC_DYN_ID_START)
-		node->name = devm_kasprintf(provider->dev, GFP_KERNEL, "%s@%s",
+		node->name = devm_kasprintf(provider->dev, GFP_ATOMIC, "%s@%s",
 					    node->name, dev_name(provider->dev));
 
 	if (node->avg_bw || node->peak_bw) {
-- 
2.34.1


