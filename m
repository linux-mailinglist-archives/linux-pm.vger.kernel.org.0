Return-Path: <linux-pm+bounces-34687-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FA6B58219
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 18:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969542A007B
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 16:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8162853E0;
	Mon, 15 Sep 2025 16:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="QyiWEnFU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mta22.hihonor.com (mta22.hihonor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9223B2DC786;
	Mon, 15 Sep 2025 16:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953797; cv=none; b=Gy5K21rm8w8P6Ng3XbNcZoacldDTdZPhKZA4GnJHLfDE2oOR0BrXciiVvkte4PI+4XrGaIRHkbWropF6hNe3f4zRTajtfvdYqp6QlYItN73rWRhNqIzjjcJs+jv5WpV96XqBV2uKn+wBjQL12Fxs1Z7fOhIawOfZzVN7nzF7k2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953797; c=relaxed/simple;
	bh=9tR322AQl5bvOwp61omNV0sMUf9/mhxKPTcUN9oIshE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tCSRqJbQhz6nNuyx/jrUz+m7HXTjYbyB1wN2Zk8Unilaz8p/QOeJFobfLjSr7T9UGJdkm0mOKEd4CTcGKl/s/4J56ZzZLn2WL+dfDIp73YRXksVO6QJe5tDYl5Qt/+Zuw2NLnTLtxv0LNQRzqOdCUdSixaENHMJ+8KDhKxqH2P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=QyiWEnFU; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=r4ridvdVFjNgW7hlKtSiyRIVq3lyiXCccE9PXxhmbvk=;
	b=QyiWEnFUV/ExnSYALnvXb1M/jH8oiPiNC1VRhLS2ogMGSlqwovaMjMYk3mO8z5goVoYM9XXVn
	MIlc4NWH4ivtQtXXb1kuxR6C2sP5BMFuxIsdrQ0nYTQQV5niNokdDW9EWHscyE620HzP1rNAjDK
	bMSjjX4CJii+REUiuBkMhV8=
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4cQVqH4r1rzYlBF4;
	Tue, 16 Sep 2025 00:29:31 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 16 Sep
 2025 00:29:51 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 16 Sep
 2025 00:29:50 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <mhocko@suse.com>
CC: <rientjes@google.com>, <shakeel.butt@linux.dev>,
	<akpm@linux-foundation.org>, <tglx@linutronix.de>, <liam.howlett@oracle.com>,
	<lorenzo.stoakes@oracle.com>, <surenb@google.com>, <lenb@kernel.org>,
	<rafael@kernel.org>, <pavel@kernel.org>, <linux-mm@kvack.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulu.liu@honor.com>, <feng.han@honor.com>, <zhongjinji@honor.com>
Subject: [PATCH v10 0/2] Improvements to Victim Process Thawing and OOM Reaper Traversal Order
Date: Tue, 16 Sep 2025 00:29:44 +0800
Message-ID: <20250915162946.5515-1-zhongjinji@honor.com>
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
the traversal order of the OOM reaper. Since __thaw_task() is used to thaw a
single thread of the victim, thawing only one thread cannot guarantee the
exit of the OOM victim when it is frozen. Patch 1 thaw the entire process
of the OOM victim to ensure that OOM victims are able to terminate themselves.
Even if the oom_reaper is delayed, patch 2 is still beneficial for reaping
processes with a large address space footprint, and it also greatly improves
process_mrelease.

---
v9 -> v10:
- Just update the changelog. [15] [16]

v8 -> v9:
- Replace thaw_oom_process with thaw_process. [13]
- Use tsk_is_oom_victim() to check whether a task is an OOM victim in
  freezing_slow_path(). [14]

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
[13] https://lore.kernel.org/linux-mm/aL_wLqsy7nzP_bRF@tiehlicka/
[14] https://lore.kernel.org/linux-mm/aMAzkQQ4XAFh9xlm@tiehlicka/
[15] https://lore.kernel.org/linux-mm/aMJ619kjFm00c4OP@tiehlicka/
[16] https://lore.kernel.org/linux-mm/aMGWAg5jIitYCXdZ@tiehlicka/

The earlier post:
v9: https://lore.kernel.org/linux-mm/20250910143726.19905-1-zhongjinji@honor.com/
v8: https://lore.kernel.org/linux-mm/20250909090659.26400-1-zhongjinji@honor.com/
v7: https://lore.kernel.org/linux-mm/20250903092729.10611-1-zhongjinji@honor.com/
v6: https://lore.kernel.org/linux-mm/20250829065550.29571-1-zhongjinji@honor.com/
v5: https://lore.kernel.org/linux-mm/20250825133855.30229-1-zhongjinji@honor.com/
v4: https://lore.kernel.org/linux-mm/20250814135555.17493-1-zhongjinji@honor.com/
v3: https://lore.kernel.org/linux-mm/20250804030341.18619-1-zhongjinji@honor.com/
v2: https://lore.kernel.org/linux-mm/20250801153649.23244-1-zhongjinji@honor.com/
v1: https://lore.kernel.org/linux-mm/20250731102904.8615-1-zhongjinji@honor.com/

zhongjinji (2):
  mm/oom_kill: Thaw the entire OOM victim process
  mm/oom_kill: The OOM reaper traverses the VMA maple tree in reverse
    order

 include/linux/freezer.h |  2 ++
 kernel/freezer.c        | 13 ++++++++++++-
 mm/oom_kill.c           | 20 +++++++++++++-------
 3 files changed, 27 insertions(+), 8 deletions(-)

-- 
2.17.1


