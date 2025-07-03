Return-Path: <linux-pm+bounces-30043-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C178AF761D
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 15:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFFCB7B94C8
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 13:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DC82E7BDB;
	Thu,  3 Jul 2025 13:48:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9B528B516;
	Thu,  3 Jul 2025 13:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751550501; cv=none; b=tFWC7S7QbAAoEedqm+e9DgAdsWfES2Uf03a4657qlOGewLLqvAFZOFE34VtOT3aon5W8ZT656cNTdnTZ7xM+l515bdlBBrsLa1whkitMgkEecse/xHLRTeScnGQcdXW/UCwLjTJXOaHdSL3Qy5L+7lakh0GZm6aZMMQ0WMLYoHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751550501; c=relaxed/simple;
	bh=8IvgdlogpP7JuvdzwJQsuveomKygW/XCJS9EI4AtOQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CA7MJHTfoyeFykBApoURGAQJcbzl3hYw0aRDe+SJD8TgjUReuHRe2sOw5kZdvDLmV9MHTByRevbA5qAJLLEqFajBPjyYMu2lYoSgSyH2I+4qo5dgxI13TLxwoQLuWGUsoUkEdG8dK4V6GDHN1Dw7nVUE8LtRH9rewg5AnOhMPAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bXylN3bTtzYQtrF;
	Thu,  3 Jul 2025 21:48:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 5C96B1A12D0;
	Thu,  3 Jul 2025 21:48:15 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP3 (Coremail) with SMTP id _Ch0CgDXOCYJimZoV+8fAg--.35082S2;
	Thu, 03 Jul 2025 21:48:15 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: peterz@infradead.org,
	rafael@kernel.org,
	pavel@kernel.org,
	timvp@google.com,
	tj@kernel.org,
	mkoutny@suse.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH next] sched,freezer: prevent tasks from escaping being frozen
Date: Thu,  3 Jul 2025 13:34:27 +0000
Message-Id: <20250703133427.3301899-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDXOCYJimZoV+8fAg--.35082S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr15JrykWFyUJrWDKF1xXwb_yoW8uFyUp3
	95Wa1UGw10qr42ywnxta1v9398K39rJr4UG34kCF18Xa1YqasxWr4xCry3Wr4jvr1I9r9x
	JayYg34SyayUCa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvj
	xUF1v3UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The commit cff5f49d433f ("cgroup_freezer: cgroup_freezing: Check if not
frozen") modified the cgroup_freezing() logic to also verify that the
FROZEN flag is not set, which affects the return value of the freezing()
function.

In __refrigerator(), the FROZEN flag is set before checking whether the
task should be frozen. This creates a race condition where:
1. The task's FROZEN flag is set.
2. The cgroup freezer state changes to FROZEN (Can be triggered by reading
   freezer.state).
3. freezing() is called and returns false.

As a result, the task may escape being frozen when it should be.

To fix this, move the setting of the FROZEN flag to occur just before
schedule(). This ensures the flag is only set when we're certain the
task must be switched out.

Fixes: cff5f49d433f ("cgroup_freezer: cgroup_freezing: Check if not frozen")
Reported-by: Zhong Jiawei<zhongjiawei1@huawei.com>
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/freezer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/freezer.c b/kernel/freezer.c
index 8d530d0949ff..89edd7550d27 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -71,12 +71,6 @@ bool __refrigerator(bool check_kthr_stop)
 	for (;;) {
 		bool freeze;
 
-		raw_spin_lock_irq(&current->pi_lock);
-		WRITE_ONCE(current->__state, TASK_FROZEN);
-		/* unstale saved_state so that __thaw_task() will wake us up */
-		current->saved_state = TASK_RUNNING;
-		raw_spin_unlock_irq(&current->pi_lock);
-
 		spin_lock_irq(&freezer_lock);
 		freeze = freezing(current) && !(check_kthr_stop && kthread_should_stop());
 		spin_unlock_irq(&freezer_lock);
@@ -84,6 +78,12 @@ bool __refrigerator(bool check_kthr_stop)
 		if (!freeze)
 			break;
 
+		raw_spin_lock_irq(&current->pi_lock);
+		WRITE_ONCE(current->__state, TASK_FROZEN);
+		/* unstale saved_state so that __thaw_task() will wake us up */
+		current->saved_state = TASK_RUNNING;
+		raw_spin_unlock_irq(&current->pi_lock);
+
 		was_frozen = true;
 		schedule();
 	}
-- 
2.34.1


