Return-Path: <linux-pm+bounces-31449-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B367BB1333B
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 04:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886431748B9
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 02:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381EF207A0C;
	Mon, 28 Jul 2025 02:55:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB5D1FBE80;
	Mon, 28 Jul 2025 02:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753671347; cv=none; b=J83/JEObjSmKD0OrwJZ44/Rh9doQSmmLj54cK6v2ihRAV1m/Vy2WJKWkPLctnVBK3cbglwh6vh7Orb8y+p8QTiUWzNrVBldOXC2hxbphrXtILKUNxGh/rFvKpdljHMVR0WbQT/nD2VCFDkrZIgLmvJcXeDlPmrIoMkwkcjcw6XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753671347; c=relaxed/simple;
	bh=+oL54au+1m3Cp1wMvpFxeLnh9JqL0aaVe+vXbVFj9mE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZNA73wzvfnTpkM0PIHc/+fabm7i/f4LVBv6AAWK31AfSt585NU9ZzUU1FgI/Qn0TG9LWn867acrJXWyl9zI0XVPy/PIClNtICG8EiLk0zWJMEa/M2PEFv51nDeiTJm91ouVj745MIsNPK5VFludOC7qEOADVu+nbeC3vP76ipQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4br34p3bRBzKHMdJ;
	Mon, 28 Jul 2025 10:55:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 554291A0D7D;
	Mon, 28 Jul 2025 10:55:37 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgDXng+W5oZohS7qBg--.25661S2;
	Mon, 28 Jul 2025 10:55:35 +0800 (CST)
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
Subject: [PATCH 6.6 0/5] [Backport] sched,freezer: Remove unnecessary warning in __thaw_task
Date: Mon, 28 Jul 2025 02:41:16 +0000
Message-Id: <20250728024121.33864-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025072421-deviate-skintight-bbd5@gregkh>
References: <2025072421-deviate-skintight-bbd5@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXng+W5oZohS7qBg--.25661S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtF1fGF1DCF48Gry7XrykGrg_yoWkJwb_Ka
	4fGFyxtrykJF1UGFW7KF97XryDKayUJr18GF1qqr45Zry2vr95XF43GrWkur1rX3Z7Xr1D
	Aryftan7Ar1DKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUF1v3UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

To fix the [1] issue, it needs to backport:
9beb8c5e77dc ("sched,freezer: Remove unnecessary warning...")
14a67b42cb6f ("Revert 'cgroup_freezer: cgroup freezing: Check if not...'").

This series aims to backport 9beb8c5e77dc. To avoid conflicts, backport the
missing patches[2].

[1] https://lore.kernel.org/lkml/20250717085550.3828781-1-chenridong@huaweicloud.com/
[2] https://lore.kernel.org/stable/2025072421-deviate-skintight-bbd5@gregkh/

Chen Ridong (1):
  sched,freezer: Remove unnecessary warning in __thaw_task

Elliot Berman (4):
  sched/core: Remove ifdeffery for saved_state
  freezer,sched: Use saved_state to reduce some spurious wakeups
  freezer,sched: Do not restore saved_state of a thawed task
  freezer,sched: Clean saved_state when restoring it during thaw

 include/linux/sched.h |  2 --
 kernel/freezer.c      | 51 +++++++++++++++++--------------------------
 kernel/sched/core.c   | 31 +++++++++++++-------------
 3 files changed, 35 insertions(+), 49 deletions(-)

-- 
2.34.1


