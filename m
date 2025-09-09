Return-Path: <linux-pm+bounces-34224-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63ABEB4A6B6
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 11:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85184E74C6
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 09:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522C12773D8;
	Tue,  9 Sep 2025 09:07:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mta20.hihonor.com (mta20.hihonor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D32276045;
	Tue,  9 Sep 2025 09:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408828; cv=none; b=Xu2HjlEwlL0Rw+wJ8wLCsOc9AWoTYbhwfBVGkOUoWFhKUajxY2jGYO3VHgGpApDngDi/4H9KnuJ5qOTg05tqM5uVOyGZh5LoopuUe+IozxedWfpuehTt8yot6wzGbP+DCZgbRYYVcGUxs1TcUz1rZ11mTlsGX/fXbbIpyEwHEKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408828; c=relaxed/simple;
	bh=0QH6QecDNOEpsUEXikxA+wNaL2GabRTSIitOEvyRCn8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pGSfK/3bBNN06aIWYCz4WQLlWuN8GZKiXmgQgkHfpOk54K9uAy3u4UrIqvxgJEcQeWasfaDzfOyXgu/F+1KbX26/2zYTG9QFqmipqi0SyoB7Xd20KI9VrbH51i5gtC0PKdGNwX2ddPuo41/zw5a6W1c+BNT4J5X05P4m8VgveKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w002.hihonor.com (unknown [10.68.28.120])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4cLdH210r7zYl3P3;
	Tue,  9 Sep 2025 17:06:38 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w002.hihonor.com
 (10.68.28.120) with Microsoft SMTP Server (version=TLS1_2,
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
Subject: [PATCH v8 0/3] Improvements to Victim Process Thawing and OOM Reaper Traversal Order
Date: Tue, 9 Sep 2025 17:06:56 +0800
Message-ID: <20250909090659.26400-1-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w003.hihonor.com (10.68.17.88) To a018.hihonor.com
 (10.68.17.250)

This patch series focuses on optimizing victim process thawing and refining
the traversal order of the OOM reaper. Since __thaw_task is used to thaw a
single thread of the victim, thawing only one thread cannot guarantee the
exit of the OOM victim when it is frozen. Patch 1 and patch 2 thaw the entire
process of the OOM victim to ensure that OOM victims are able to terminate
themselves. Even if the oom_reaper is delayed, patch 3 is still beneficial
for reaping processes with a large address space footprint, and it also
greatly improves process_mrelease.

---
v7 -> v8:
- Introduce thaw_oom_process() for thawing OOM victims. [12]
- Use RCU protection for thread traversal in thaw_oom_process.

v6 -> v7:
- Thawing the victim process to ensure that it can terminate on its own. [10]
- Since the delay reaper is no longer skipped, I'm not sure whether patch 2
  will still be accepted. Revise the Changelog for patch 2. [11]
- Remove report tags

v5 -> v6:
- Use mas_for_each_rev() for VMA traversal [6]
- Simplify the judgment of whether to delay in queue_oom_reaper() [7]
- Refine changelog to better capture the essence of the changes [8]
- Use READ_ONCE(tsk->frozen) instead of checking mm and additional
  checks inside for_each_process(), as it is sufficient [9]
- Add report tags because fengbaopeng and tianxiaobin reported the
  high load issue of the reaper

v4 -> v5:
- Detect frozen state directly, avoid special futex handling. [3]
- Use mas_find_rev() for VMA traversal to avoid skipping entries. [4]
- Only check should_delay_oom_reap() in queue_oom_reaper(). [5]

v3 -> v4:
- Renamed functions and parameters for clarity. [2]
- Added should_delay_oom_reap() for OOM reap decisions.
- Traverse maple tree in reverse for improved behavior.

v2 -> v3:
- Fixed Subject prefix error.

v1 -> v2:
- Check robust_list for all threads, not just one. [1]

Reference:
[1] https://lore.kernel.org/linux-mm/u3mepw3oxj7cywezna4v72y2hvyc7bafkmsbirsbfuf34zpa7c@b23sc3rvp2gp/
[2] https://lore.kernel.org/linux-mm/87cy99g3k6.ffs@tglx/
[3] https://lore.kernel.org/linux-mm/aKRWtjRhE_HgFlp2@tiehlicka/
[4] https://lore.kernel.org/linux-mm/26larxehoe3a627s4fxsqghriwctays4opm4hhme3uk7ybjc5r@pmwh4s4yv7lm/
[5] https://lore.kernel.org/linux-mm/d5013a33-c08a-44c5-a67f-9dc8fd73c969@lucifer.local/
[6] https://lore.kernel.org/linux-mm/nwh7gegmvoisbxlsfwslobpbqku376uxdj2z32owkbftvozt3x@4dfet73fh2yy/
[7] https://lore.kernel.org/linux-mm/af4edeaf-d3c9-46a9-a300-dbaf5936e7d6@lucifer.local/
[8] https://lore.kernel.org/linux-mm/aK71W1ITmC_4I_RY@tiehlicka/
[9] https://lore.kernel.org/linux-mm/jzzdeczuyraup2zrspl6b74muf3bly2a3acejfftcldfmz4ekk@s5mcbeim34my/
[10] https://lore.kernel.org/linux-mm/aLWmf6qZHTA0hMpU@tiehlicka/
[11] https://lore.kernel.org/linux-mm/aLVOICSkyvVRKD94@tiehlicka/
[12] https://lore.kernel.org/linux-mm/aLg0QZQ5kXNJgDMF@tiehlicka/

The earlier post:
v7: https://lore.kernel.org/linux-mm/20250903092729.10611-1-zhongjinji@honor.com/
v6: https://lore.kernel.org/linux-mm/20250829065550.29571-1-zhongjinji@honor.com/
v5: https://lore.kernel.org/linux-mm/20250825133855.30229-1-zhongjinji@honor.com/
v4: https://lore.kernel.org/linux-mm/20250814135555.17493-1-zhongjinji@honor.com/
v3: https://lore.kernel.org/linux-mm/20250804030341.18619-1-zhongjinji@honor.com/
v2: https://lore.kernel.org/linux-mm/20250801153649.23244-1-zhongjinji@honor.com/
v1: https://lore.kernel.org/linux-mm/20250731102904.8615-1-zhongjinji@honor.com/

zhongjinji (3):
  mm/oom_kill: Introduce thaw_oom_process() for thawing OOM victims
  mm/oom_kill: Thaw the entire OOM victim process
  mm/oom_kill: OOM reaper walks VMA maple tree in reverse order

 include/linux/freezer.h |  2 ++
 kernel/freezer.c        | 19 +++++++++++++++++++
 mm/oom_kill.c           | 16 +++++++++++-----
 3 files changed, 32 insertions(+), 5 deletions(-)

-- 
2.17.1


