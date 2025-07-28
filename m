Return-Path: <linux-pm+bounces-31448-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E75B13339
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 04:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E348B18961AA
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 02:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622F52116E0;
	Mon, 28 Jul 2025 02:55:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E308A1FBE80;
	Mon, 28 Jul 2025 02:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753671343; cv=none; b=X2At+6wkO64YsLKQKQ2jYevnjiBXxxqq5DpEe3gbIHe/5MppaDhrz+DRjH7Enh0NfpJDGmxEVoKxBUfTWKnC6Bn9ZbsCMTWYl8qvt09vH4DY+3WtrAV0D2wvTxZ9LwbCmvxDcqtmIqBA57SVwJhKJMl6mLk7e+D+WCkpponSrEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753671343; c=relaxed/simple;
	bh=LHBmeIa19IMKeKIlGR/byR16EyOel+tFxkosgb9hiVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qop5ZM0I/WFSaCaLF+tfXKSDisGzwcYRaXO/q1FeSb7+2h+UWlus4Sk+Oy7ONbPWxOtt5AjF3rmh/Czdo8qLYqcBqQ3bp0XhtZodCvNXIn1PMqsMMobDxuYBh+LoTjxIJX4C+kmAKucl8vjKapSMTgZAz1knY98T6Qo4shlsR84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4br34p56tdzYQty7;
	Mon, 28 Jul 2025 10:55:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6793C1A018C;
	Mon, 28 Jul 2025 10:55:37 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgDXng+W5oZohS7qBg--.25661S3;
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
Subject: [PATCH 6.6 1/5] sched/core: Remove ifdeffery for saved_state
Date: Mon, 28 Jul 2025 02:41:17 +0000
Message-Id: <20250728024121.33864-2-chenridong@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDXng+W5oZohS7qBg--.25661S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFW8Zw1UJFy5JFyUJFyxXwb_yoW5JF4xpa
	sYgrWxGayUGr1Iqry7A3yDCF9xGwnrXw1UGrZY93y0yFy5t3yFqr1vg343JrWrWrZIkFya
	qrsFvr4Skw4jq3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2HGQ
	DUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Elliot Berman <quic_eberman@quicinc.com>

[ Upstream commit fbaa6a181a4b1886cbf4214abdf9a2df68471510 ]

In preparation for freezer to also use saved_state, remove the
CONFIG_PREEMPT_RT compilation guard around saved_state.

On the arm64 platform I tested which did not have CONFIG_PREEMPT_RT,
there was no statistically significant deviation by applying this patch.

Test methodology:

perf bench sched message -g 40 -l 40

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 include/linux/sched.h |  2 --
 kernel/sched/core.c   | 10 ++--------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 393c300347de..cb38eee732fd 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -753,10 +753,8 @@ struct task_struct {
 #endif
 	unsigned int			__state;
 
-#ifdef CONFIG_PREEMPT_RT
 	/* saved state for "spinlock sleepers" */
 	unsigned int			saved_state;
-#endif
 
 	/*
 	 * This begins the randomizable portion of task_struct. Only
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 760a6c3781cb..ab6550fadecd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2238,17 +2238,15 @@ int __task_state_match(struct task_struct *p, unsigned int state)
 	if (READ_ONCE(p->__state) & state)
 		return 1;
 
-#ifdef CONFIG_PREEMPT_RT
 	if (READ_ONCE(p->saved_state) & state)
 		return -1;
-#endif
+
 	return 0;
 }
 
 static __always_inline
 int task_state_match(struct task_struct *p, unsigned int state)
 {
-#ifdef CONFIG_PREEMPT_RT
 	int match;
 
 	/*
@@ -2260,9 +2258,6 @@ int task_state_match(struct task_struct *p, unsigned int state)
 	raw_spin_unlock_irq(&p->pi_lock);
 
 	return match;
-#else
-	return __task_state_match(p, state);
-#endif
 }
 
 /*
@@ -4059,7 +4054,6 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
 
 	*success = !!(match = __task_state_match(p, state));
 
-#ifdef CONFIG_PREEMPT_RT
 	/*
 	 * Saved state preserves the task state across blocking on
 	 * an RT lock.  If the state matches, set p::saved_state to
@@ -4075,7 +4069,7 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
 	 */
 	if (match < 0)
 		p->saved_state = TASK_RUNNING;
-#endif
+
 	return match > 0;
 }
 
-- 
2.34.1


