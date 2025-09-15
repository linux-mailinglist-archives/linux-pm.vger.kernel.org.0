Return-Path: <linux-pm+bounces-34686-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86086B5821D
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 18:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C0693B844F
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 16:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8642283FC9;
	Mon, 15 Sep 2025 16:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="DiMtGw/u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mta22.hihonor.com (mta22.hihonor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922A925CC42;
	Mon, 15 Sep 2025 16:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953796; cv=none; b=TMEFA/Nczcqb3nQmTPfbN+xNgkt4pni22B0vBpwt/KJzdIpHDp3B5oN5uc3i1FUCSIBhqmllg9jHojhn86d1NWYchuQCn6Xeh0RD6XxInq1VAwZEShNVzZNUbvbvBy3ygeitL1E20poSd+YkDyydYnHdpHifrV2KPRzW5DGEkr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953796; c=relaxed/simple;
	bh=Cw/nigGtI16TbuhEzvn6dldJ3Eb7lgUvIkmt5HCwQak=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aYWfhgGA5A8PlyE7twA7ZeIQ14lApPmGidhDuNXYEVB896bfOMLP0yIyq46nBEeCU/yxQSggfI7xTyaHC0w/sH2ZFS27rNNIUxSXDQNEftaWY+E5SGsE7jFPTjabeHp7EmjaLWzFVuzHF4oM5JC3R9eVazklWaPhOuMZQP6LXF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=DiMtGw/u; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=q+Rz01jnhZrKhL2yDuA2zWsb7SrFCfsHx3X9jrl/ySE=;
	b=DiMtGw/unnVszkGXeB0iAIK0NMPg16E/Fmf/kqDkPOJQPQero0Jvm1OSLsw4Lgg4LlmX+huEg
	vIJWo5vsYzMLXNZ7CN5vsKWBI704t6GN1v+BVwlkxF8BX4+Ruod3DJjVMTuUMnhsq6uea6RM66j
	7nj5OtvzoGYw2Vfpdm025Bw=
Received: from w012.hihonor.com (unknown [10.68.27.189])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4cQVqJ0GrCzYlBF4;
	Tue, 16 Sep 2025 00:29:32 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w012.hihonor.com
 (10.68.27.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 16 Sep
 2025 00:29:51 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 16 Sep
 2025 00:29:51 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <mhocko@suse.com>
CC: <rientjes@google.com>, <shakeel.butt@linux.dev>,
	<akpm@linux-foundation.org>, <tglx@linutronix.de>, <liam.howlett@oracle.com>,
	<lorenzo.stoakes@oracle.com>, <surenb@google.com>, <lenb@kernel.org>,
	<rafael@kernel.org>, <pavel@kernel.org>, <linux-mm@kvack.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulu.liu@honor.com>, <feng.han@honor.com>, <zhongjinji@honor.com>
Subject: [PATCH v10 2/2] mm/oom_kill: The OOM reaper traverses the VMA maple tree in reverse order
Date: Tue, 16 Sep 2025 00:29:46 +0800
Message-ID: <20250915162946.5515-3-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250915162946.5515-1-zhongjinji@honor.com>
References: <20250915162946.5515-1-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w003.hihonor.com (10.68.17.88) To a018.hihonor.com
 (10.68.17.250)

Although the oom_reaper is delayed and it gives the oom victim chance to
clean up its address space this might take a while especially for
processes with a large address space footprint. In those cases
oom_reaper might start racing with the dying task and compete for shared
resources - e.g. page table lock contention has been observed.

Reduce those races by reaping the oom victim from the other end of the
address space.

It is also a significant improvement for process_mrelease(). When a process
is killed, process_mrelease is used to reap the killed process and often
runs concurrently with the dying task. The test data shows that after
applying the patch, lock contention is greatly reduced during the procedure
of reaping the killed process.

The test is conducted on arm64. The following basic perf numbers show that
applying this patch significantly reduces pte spin lock contention.

Without the patch:
|--99.57%-- oom_reaper
|    |--73.58%-- unmap_page_range
|    |    |--8.67%-- [hit in function]
|    |    |--41.59%-- __pte_offset_map_lock
|    |    |--29.47%-- folio_remove_rmap_ptes
|    |    |--16.11%-- tlb_flush_mmu
|    |--19.94%-- tlb_finish_mmu
|    |--3.21%-- folio_remove_rmap_ptes

With the patch:
|--99.53%-- oom_reaper
|    |--55.77%-- unmap_page_range
|    |    |--20.49%-- [hit in function]
|    |    |--58.30%-- folio_remove_rmap_ptes
|    |    |--11.48%-- tlb_flush_mmu
|    |    |--3.33%-- folio_mark_accessed
|    |--32.21%-- tlb_finish_mmu
|    |--6.93%-- folio_remove_rmap_ptes
|    |--0.69%-- __pte_offset_map_lock

Detailed breakdowns for both scenarios are provided below. The cumulative time
for oom_reaper plus exit_mmap(victim) in both cases is also summarized, making
the performance improvements clear.
+----------------------------------------------------------------+
| Category                      | Applying patch | Without patch |
+-------------------------------+----------------+---------------+
| Total running time            |    132.6       |    167.1      |
|   (exit_mmap + reaper work)   |  72.4 + 60.2   |  90.7 + 76.4  |
+-------------------------------+----------------+---------------+
| Time waiting for pte spinlock |     1.0        |    33.1       |
|   (exit_mmap + reaper work)   |   0.4 + 0.6    |  10.0 + 23.1  |
+-------------------------------+----------------+---------------+
| folio_remove_rmap_ptes time   |    42.0        |    41.3       |
|   (exit_mmap + reaper work)   |  18.4 + 23.6   |  22.4 + 18.9  |
+----------------------------------------------------------------+

From this report, we can see that:
1. The reduction in total time comes mainly from the decrease in time spent
on pte spinlock and other locks.
2. oom_reaper performs more work in some areas, but at the same time,
exit_mmap also handles certain tasks more efficiently, such as
folio_remove_rmap_ptes.

Here is a more detailed perf report. [1]

link: https://lore.kernel.org/all/20250915162619.5133-1-zhongjinji@honor.com/

Signed-off-by: zhongjinji <zhongjinji@honor.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/oom_kill.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 88356b66cc35..28fb36be332b 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -516,7 +516,7 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	bool ret = true;
-	VMA_ITERATOR(vmi, mm, 0);
+	MA_STATE(mas, &mm->mm_mt, ULONG_MAX, ULONG_MAX);
 
 	/*
 	 * Tell all users of get_user/copy_from_user etc... that the content
@@ -526,7 +526,13 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
 	 */
 	set_bit(MMF_UNSTABLE, &mm->flags);
 
-	for_each_vma(vmi, vma) {
+	/*
+	 * It might start racing with the dying task and compete for shared
+	 * resources - e.g. page table lock contention has been observed.
+	 * Reduce those races by reaping the oom victim from the other end
+	 * of the address space.
+	 */
+	mas_for_each_rev(&mas, vma, 0) {
 		if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
 			continue;
 
-- 
2.17.1


