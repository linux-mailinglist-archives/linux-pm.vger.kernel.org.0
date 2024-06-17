Return-Path: <linux-pm+bounces-9278-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F00F690A641
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 09:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6CFE1F22436
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 07:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A12187357;
	Mon, 17 Jun 2024 06:59:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6E8187540;
	Mon, 17 Jun 2024 06:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718607580; cv=none; b=u+4SQmUs8lPhu6jM1ZVDwgulIPJmUHQFN/NSYGS/mtvEb9M48vRHuvjE/GPFLrnCMxsqEsQ/WAFpNQ6zwsSFCVjToWkfRDczMdopT91GHmvJzMZnZturIOoOhHmigEQCRhrsE4mVPlCEwdV0kAb62f3Op4LrEQTdAep9rRigM0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718607580; c=relaxed/simple;
	bh=E0Gdr2tkWJP5rJIJGJ++lcfqiciXh2RK8nGvYz05Hak=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mk2FNmS3WbduaQi2GPAH9Aoymzzl3JZ0wKd0OrPQQR3DyVl8W0flKJ8AkhfnxN6FpuQOKt2id6Pa/QiUWihbwevxcgNxcJp1GKZT0i54wWByz1t5wceb+fLrAnCP5KU4IxEooVLImTs+SSSJ9CkQHEpF59JCfRf8OVTlNcbXKYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 45H6wFkt034272;
	Mon, 17 Jun 2024 14:58:15 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4W2gb25HHtz2SFdvk;
	Mon, 17 Jun 2024 14:53:50 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 17 Jun 2024 14:58:13 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <rafael@kernel.org>,
        <pavel@ucw.cz>
CC: <ke.wang@unisoc.com>, <guohua.yan@unisoc.com>, <xuewen.yan94@gmail.com>,
        <di.shen@unisoc.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] freezer,sched: Preventing kthreads with D-state from being woken up during freeze
Date: Mon, 17 Jun 2024 14:57:55 +0800
Message-ID: <20240617065755.9996-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 45H6wFkt034272

Sometimes althought a kthread was set to be freezable, the thread's
state also could be TASK_UNINTERRUPTIBLE because of some blocked
reasons, such as msleep, wait_for_complete, mutex and so on...
And now, when freezing, the freezer would wakeup them even if
their conditions have not been met, this may not be necessary,
and sometimes waking up early for schedule_timeout() may cause
some driver functions to fail.
So only wake_up kthreads with TASK_INTERRUPTIBLE state.

Co-developed-by: Guohua Yan <guohua.yan@unisoc.com>
Signed-off-by: Guohua Yan <guohua.yan@unisoc.com>
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 kernel/freezer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/freezer.c b/kernel/freezer.c
index f57aaf96b829..cc50721616a2 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -168,7 +168,7 @@ bool freeze_task(struct task_struct *p)
 	if (!(p->flags & PF_KTHREAD))
 		fake_signal_wake_up(p);
 	else
-		wake_up_state(p, TASK_NORMAL);
+		wake_up_state(p, TASK_INTERRUPTIBLE);
 
 	spin_unlock_irqrestore(&freezer_lock, flags);
 	return true;
-- 
2.25.1


