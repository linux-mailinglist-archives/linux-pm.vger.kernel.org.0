Return-Path: <linux-pm+bounces-34376-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E60B519BE
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 16:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B231418901F3
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 14:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED37C33A03E;
	Wed, 10 Sep 2025 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="Z+wOMYIu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mta22.hihonor.com (mta22.hihonor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0D132CF74;
	Wed, 10 Sep 2025 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515063; cv=none; b=FtYOl2cGWvCOsb2b/4lE83jRcVJf9Ez5YKKBCMpyNiqVboAIZou10U/kEiEonLU7kwBCt5gs5FRx9YIzLy70/tnUmJK06w4tEHzKgWqURGLUry4YzHwOOHmDIYmKW4mHz2Xq/FFJg5KhOMGTOOGQvsonIgSfI0dPYzF7tuNMbm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515063; c=relaxed/simple;
	bh=sacmCW970u5wmxcvaaMOuhCwrKJCWULfOyvNHjZPBa8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HlQW2WF1HkHkhKqX9wvp53WvvtozEpEVOp4Nb0gWV3Qt+sTOKI7vH3sisntZ6yvsSYbjxGUeAIBRpQ1pF7LKs9TGaNV6N7GX3plCq2YUqcx7KWsz1iz/B4BOpIgSvYxP05PXN1x9GlreRbnNbB9jApnZibCGG/dYtb1vYduVHy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=Z+wOMYIu; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=Il1AFPpv1ZameRi/y5X+2Ag4jsiAKIDDx/iyk289iXk=;
	b=Z+wOMYIuwHFyT7srvY1qDquEaLfd2ILQX2wLWRt7gYF4UG6PUeTWb6UcxVjQRkWkFhU2xH/mZ
	vcBL1SZ7ZG91omU0NZn0l5OZxCcTd7F3oq8iYYQ47pjNryGTNyBEPDUbsG5ogb8rLS8LKbKRePR
	96r558NQ7HxaqOq7K0VSlak=
Received: from w013.hihonor.com (unknown [10.68.26.19])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4cMNZ2522PzYlFL0;
	Wed, 10 Sep 2025 22:37:14 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w013.hihonor.com
 (10.68.26.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 10 Sep
 2025 22:37:31 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 10 Sep
 2025 22:37:31 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <mhocko@suse.com>
CC: <rientjes@google.com>, <shakeel.butt@linux.dev>,
	<akpm@linux-foundation.org>, <tglx@linutronix.de>, <liam.howlett@oracle.com>,
	<lorenzo.stoakes@oracle.com>, <surenb@google.com>, <lenb@kernel.org>,
	<rafael@kernel.org>, <pavel@kernel.org>, <linux-mm@kvack.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulu.liu@honor.com>, <feng.han@honor.com>, <zhongjinji@honor.com>
Subject: [PATCH v9 2/2] mm/oom_kill: The OOM reaper traverses the VMA maple tree in reverse order
Date: Wed, 10 Sep 2025 22:37:26 +0800
Message-ID: <20250910143726.19905-3-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250910143726.19905-1-zhongjinji@honor.com>
References: <20250910143726.19905-1-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w002.hihonor.com (10.68.28.120) To a018.hihonor.com
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

The test is based on arm64.

Without the patch:
|--99.57%-- oom_reaper
|    |--0.28%-- [hit in function]
|    |--73.58%-- unmap_page_range
|    |    |--8.67%-- [hit in function]
|    |    |--41.59%-- __pte_offset_map_lock
|    |    |--29.47%-- folio_remove_rmap_ptes
|    |    |--16.11%-- tlb_flush_mmu
|    |    |--1.66%-- folio_mark_accessed
|    |    |--0.74%-- free_swap_and_cache_nr
|    |    |--0.69%-- __tlb_remove_folio_pages
|    |--19.94%-- tlb_finish_mmu
|    |--3.21%-- folio_remove_rmap_ptes
|    |--1.16%-- __tlb_remove_folio_pages
|    |--1.16%-- folio_mark_accessed
|    |--0.36%-- __pte_offset_map_lock

With the patch:
|--99.53%-- oom_reaper
|    |--55.77%-- unmap_page_range
|    |    |--20.49%-- [hit in function]
|    |    |--58.30%-- folio_remove_rmap_ptes
|    |    |--11.48%-- tlb_flush_mmu
|    |    |--3.33%-- folio_mark_accessed
|    |    |--2.65%-- __tlb_remove_folio_pages
|    |    |--1.37%-- _raw_spin_lock
|    |    |--0.68%-- __mod_lruvec_page_state
|    |    |--0.51%-- __pte_offset_map_lock
|    |--32.21%-- tlb_finish_mmu
|    |--6.93%-- folio_remove_rmap_ptes
|    |--1.90%-- __tlb_remove_folio_pages
|    |--1.55%-- folio_mark_accessed
|    |--0.69%-- __pte_offset_map_lock

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


