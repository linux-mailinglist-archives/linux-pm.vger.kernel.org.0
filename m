Return-Path: <linux-pm+bounces-31451-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 896E6B1333F
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 04:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF951748FB
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 02:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EE021CC6A;
	Mon, 28 Jul 2025 02:55:48 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820CA218ADD;
	Mon, 28 Jul 2025 02:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753671348; cv=none; b=SHz/Jx7ePfQfs+E/4ewLlLqG1J5WdbU/VXh1j5/WV/PuEE34MBOs9yX3GYf9e/A3kan2rITYExFUMq2Hgq77ikjYofApuTa9w7z1KMX9jLE/RejXBcpMp1hTUHbkBZtvEje5YSvOKjq4AMgUCGBGqxW+2LM6qA4LnhmteLGv6bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753671348; c=relaxed/simple;
	bh=19esnPw9oPLaOU22cf2Kn+OhRJVK1QW/drD/tiTZC/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IxJY4jo8fD3h1anwgqRf2HOWhxyVRXJ9plaZ8JmgL0+/3IOm4a/eJgMrsnGHNhSJTF8u7+vIFRw5ZKSLrxrClYmjUeSnEtFyPwnPsGjbDo1VtA8m6UKvIHesFtTVUtuLEmUK7IMtON9XFjXaZEy3OFAR5bmBsVgBQ6G4jn8MwPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4br34p5cWTzKHMgG;
	Mon, 28 Jul 2025 10:55:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 98F1E1A1245;
	Mon, 28 Jul 2025 10:55:37 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgDXng+W5oZohS7qBg--.25661S6;
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
Subject: [PATCH 6.6 4/5] freezer,sched: Clean saved_state when restoring it during thaw
Date: Mon, 28 Jul 2025 02:41:20 +0000
Message-Id: <20250728024121.33864-5-chenridong@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDXng+W5oZohS7qBg--.25661S6
X-Coremail-Antispam: 1UD129KBjvdXoW7Xry3Gr15AFyxArWUCF4Durg_yoWDGwc_Ka
	y8Gr4093ykJF10gas3Kr45X3W8K34DJw18uw1UXr45uryYvF98JayrXr95GrZ8Wrs2kFyq
	kF1fGwsrKr10qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbqAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s
	0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
	F9NVUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Elliot Berman <quic_eberman@quicinc.com>

[ Upstream commit 418146e39891ef1fb2284dee4cabbfe616cd21cf ]

Clean saved_state after using it during thaw. Cleaning the saved_state
allows us to avoid some unnecessary branches in ttwu_state_match.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20231120-freezer-state-multiple-thaws-v1-2-f2e1dd7ce5a2@quicinc.com
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/freezer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/freezer.c b/kernel/freezer.c
index 759006a9a910..f57aaf96b829 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -187,6 +187,7 @@ static int __restore_freezer_state(struct task_struct *p, void *arg)
 
 	if (state != TASK_RUNNING) {
 		WRITE_ONCE(p->__state, state);
+		p->saved_state = TASK_RUNNING;
 		return 1;
 	}
 
-- 
2.34.1


