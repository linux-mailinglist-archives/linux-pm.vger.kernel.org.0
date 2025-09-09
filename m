Return-Path: <linux-pm+bounces-34225-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D11DBB4A6BF
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 11:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B613B613D
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 09:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD91327F759;
	Tue,  9 Sep 2025 09:07:13 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mta21.hihonor.com (mta21.honor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC42B27C842;
	Tue,  9 Sep 2025 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408833; cv=none; b=gXvdO8/q8L7+j/GwyP+gODzJ8ft2QDieV2d92OQ3Tt0sHM2/xikRhoSZtxrClC3mXD2hfVzbj1KRiMVBPaI06OvVrDT/OAnbKhG7KqAQ9zStt2Yfz/1bveogSAiMUkmZ7tXCcPhtdPg1Jb04a1hi8o0Lulc87Zhdf0V7iA/V0vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408833; c=relaxed/simple;
	bh=JMYFiA/QfCfFUsD7yvBLT33vWqnUtTC2cKiz085S7WE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g8IkGQEjy/RxRs3HgaNZ9/IWWYWDRxGpnbU6S13vl6sBYymCPVsAqs7NUkJGFW4OH9rJtxfVD72rwFS9Joti9A0TGZXvim+PruspjPiIOLfpTTnPsZSlaAbhy4NEPlzE2cENquB7sUOVQB/I8TQCIBDDUemz60Pf1ko0Sa9fEvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4cLdH13hltzYl69p;
	Tue,  9 Sep 2025 17:06:37 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 9 Sep
 2025 17:07:03 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 9 Sep
 2025 17:07:03 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <mhocko@suse.com>
CC: <rientjes@google.com>, <shakeel.butt@linux.dev>,
	<akpm@linux-foundation.org>, <tglx@linutronix.de>, <liam.howlett@oracle.com>,
	<lorenzo.stoakes@oracle.com>, <surenb@google.com>, <lenb@kernel.org>,
	<rafael@kernel.org>, <pavel@kernel.org>, <linux-mm@kvack.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulu.liu@honor.com>, <feng.han@honor.com>, <zhongjinji@honor.com>
Subject: [PATCH v8 2/3] mm/oom_kill: Thaw the entire OOM victim process
Date: Tue, 9 Sep 2025 17:06:58 +0800
Message-ID: <20250909090659.26400-3-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250909090659.26400-1-zhongjinji@honor.com>
References: <20250909090659.26400-1-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w003.hihonor.com (10.68.17.88) To a018.hihonor.com
 (10.68.17.250)

OOM killer is a mechanism that selects and kills processes when the system
runs out of memory to reclaim resources and keep the system stable.
However, the oom victim cannot terminate on its own when it is frozen,
because __thaw_task() only thaws one thread of the victim, while
the other threads remain in the frozen state.

This change will thaw the entire victim process when OOM occurs,
ensuring that the oom victim can terminate on its own.

Signed-off-by: zhongjinji <zhongjinji@honor.com>
---
 mm/oom_kill.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 25923cfec9c6..ffa50a1f0132 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -772,12 +772,11 @@ static void mark_oom_victim(struct task_struct *tsk)
 		mmgrab(tsk->signal->oom_mm);
 
 	/*
-	 * Make sure that the task is woken up from uninterruptible sleep
+	 * Make sure that the process is woken up from uninterruptible sleep
 	 * if it is frozen because OOM killer wouldn't be able to free
-	 * any memory and livelock. freezing_slow_path will tell the freezer
-	 * that TIF_MEMDIE tasks should be ignored.
+	 * any memory and livelock.
 	 */
-	__thaw_task(tsk);
+	thaw_oom_process(tsk);
 	atomic_inc(&oom_victims);
 	cred = get_task_cred(tsk);
 	trace_mark_victim(tsk, cred->uid.val);
-- 
2.17.1


