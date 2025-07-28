Return-Path: <linux-pm+bounces-31446-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E95B13335
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 04:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AFEF3B7883
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 02:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A06020010C;
	Mon, 28 Jul 2025 02:55:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E310A1FECB0;
	Mon, 28 Jul 2025 02:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753671342; cv=none; b=Y88zQaTHwNVCJwyI68I+w4UxtvmeyJy/ZKBO08zNnMqfxUXKu3sda7FwaQ7zRz7SXCmp1pP1BcK76oJ7oWeh19Askj4H0SejWfrtWMLSaSgBMZOKwWJ95M1/zgQpGDTDvVRdOngDizhtjpenlHP6nWEtSHhGe+48Dlvggl+wg+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753671342; c=relaxed/simple;
	bh=gJtsBq5fZA6h7HMsYnHXxcGmuuxb3sPODk94RG9piwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G8tZbS8/l5vOeW99iXYIm/BqkHPo6WdmyBNcr5Wt9BVBS46yFQuy/MJvK2Q8lA2zyc5qf9ird2nUUobv9DA2MofxdBkebtcyn/RHWlO9BvhxwqDuVDDviqqIoq1pttTLLFcDpzM9fPIC//sypDvrZLY6Wf5ONHb/+e+c+VviQY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4br34p671QzYQv31;
	Mon, 28 Jul 2025 10:55:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8566B1A0D92;
	Mon, 28 Jul 2025 10:55:37 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgDXng+W5oZohS7qBg--.25661S5;
	Mon, 28 Jul 2025 10:55:37 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	rafael@kernel.org,
	pavel@ucw.cz
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH 6.6 3/5] freezer,sched: Do not restore saved_state of a thawed task
Date: Mon, 28 Jul 2025 02:41:19 +0000
Message-Id: <20250728024121.33864-4-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250728024121.33864-1-chenridong@huaweicloud.com>
References: <2025072421-deviate-skintight-bbd5@gregkh>
 <20250728024121.33864-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXng+W5oZohS7qBg--.25661S5
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1kAryUZw4DZr48Cry5CFg_yoW8Aw4xpw
	s8JrW8K3s7try8K39rXws7Xa4DGws5Jw17GrWkCr4UXF4aqa4F9rn7uF15Wa40qrWvgF45
	tay5urySk3ykA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU14x
	RDUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Elliot Berman <quic_eberman@quicinc.com>

[ Upstream commit 23ab79e8e469e2605beec2e3ccb40d19c68dd2e0 ]

It is possible for a task to be thawed multiple times when mixing the
*legacy* cgroup freezer and system-wide freezer. To do this, freeze the
cgroup, do system-wide freeze/thaw, then thaw the cgroup. When this
happens, then a stale saved_state can be written to the task's state
and cause task to hang indefinitely. Fix this by only trying to thaw
tasks that are actually frozen.

This change also has the marginal benefit avoiding unnecessary
wake_up_state(p, TASK_FROZEN) if we know the task is already thawed.
There is not possibility of time-of-compare/time-of-use race when we skip
the wake_up_state because entering/exiting TASK_FROZEN is guarded by
freezer_lock.

Fixes: 8f0eed4a78a8 ("freezer,sched: Use saved_state to reduce some spurious wakeups")
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Abhijeet Dharmapurikar <quic_adharmap@quicinc.com>
Link: https://lore.kernel.org/r/20231120-freezer-state-multiple-thaws-v1-1-f2e1dd7ce5a2@quicinc.com
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/freezer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/freezer.c b/kernel/freezer.c
index c450fa8b8b5e..759006a9a910 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -201,7 +201,7 @@ void __thaw_task(struct task_struct *p)
 	if (WARN_ON_ONCE(freezing(p)))
 		goto unlock;
 
-	if (task_call_func(p, __restore_freezer_state, NULL))
+	if (!frozen(p) || task_call_func(p, __restore_freezer_state, NULL))
 		goto unlock;
 
 	wake_up_state(p, TASK_FROZEN);
-- 
2.34.1


