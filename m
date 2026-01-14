Return-Path: <linux-pm+bounces-40889-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 794C2D2190C
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 23:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC6883013966
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 22:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614903B52FB;
	Wed, 14 Jan 2026 22:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EJEzYcZm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B501C3ACF0D;
	Wed, 14 Jan 2026 22:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768429768; cv=none; b=LsHGrg9beDINoWAUqUBrmI9NLaqOhhEspq/SzFWYogx+Zj0vDY4bNRb+6J8EB1E+Jfwx7+snlOxLoQFEcQvan8qQFOpSNpe2vPJKD0A5+HD+RdzB0nvwnuyPgW8G1VBavzch0GcFy9M8y512lL/p45IKLTiRQkj50yAsKx2mTUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768429768; c=relaxed/simple;
	bh=UaZFr4hl10mcWar3ySggf/yWyzFeKQkv3nU3vZ2O4q8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nDIwAW5fvm+W7Z+v0TT1DZWmP9thjA2kBnKu7lvJli56SpFUrPsZjrzYUm0stNFYvRBY+NbNwXfSCm4IC41SjHKnuYDGOofUCsib1HxEar3ofJG+33IfzZIe1P5tIhIZ2yTSo0i+iuriEj/M9b1M5jptQvB429uU8Md1kXzmIao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EJEzYcZm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414DDC4CEF7;
	Wed, 14 Jan 2026 22:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768429768;
	bh=UaZFr4hl10mcWar3ySggf/yWyzFeKQkv3nU3vZ2O4q8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EJEzYcZmclR6eee5WcA+Z0GsBCXTzw/VoU9qux0aE2D1CLbb/tFDjfcBlF1fBDezM
	 MsN3isOQhq5clBGCFHYhbnHT4pAVwePw0QNdNvriXn8YbsG8oHOxhXjE0Ak57lf5t1
	 szPwNdCy42G6FVmKsPyLmShMBWQ6STCuDAwyil8c=
Date: Wed, 14 Jan 2026 14:29:21 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Baoquan He <bhe@redhat.com>, Barry Song
 <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, Nhat Pham
 <nphamcs@gmail.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, David Hildenbrand
 <david@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Youngjun Park
 <youngjun.park@lge.com>, Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Ying Huang <ying.huang@linux.alibaba.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
 Chris Mason <clm@meta.com>, Yi Lai <yi1.lai@intel.com>
Subject: Re: [PATCH v5 14/19] mm, swap: cleanup swap entry management
 workflow
Message-Id: <20260114142921.1b47d27a3bb22b41ed0c5526@linux-foundation.org>
In-Reply-To: <CAMgjq7AUz10uETVm8ozDWcB3XohkOqf0i33KGrAquvEVvfp5cg@mail.gmail.com>
References: <20251220-swap-table-p2-v5-0-8862a265a033@tencent.com>
	<20251220-swap-table-p2-v5-14-8862a265a033@tencent.com>
	<CAMgjq7AUz10uETVm8ozDWcB3XohkOqf0i33KGrAquvEVvfp5cg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jan 2026 00:53:41 +0800 Kairui Song <ryncsn@gmail.com> wrote:

> Is it convenient for you to squash this attached fix into this patch?

Done, below

> That's the two issues from Chris Mason and Lai Yi combined in a clean
> to apply format, only 3 lines change.

Let's cc them!

> There might be minor conflict by removing the WARN_ON in two following
> patches, but should be easy to resolve. I can send a v6 if that's
> troublesome.

All fixed up, thanks.


From: Kairui Song <kasong@tencent.com>
Subject: mm, swap: fix locking and leaking with hibernation snapshot releasing
Date: Thu, 15 Jan 2026 00:15:27 +0800

fix leak, per Chris Mason.  Remove WARN_ON, per Lai Yi

Link: https://lkml.kernel.org/r/CAMgjq7AUz10uETVm8ozDWcB3XohkOqf0i33KGrAquvEVvfp5cg@mail.gmail.com
Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: Lai Yi <yi1.lai@linux.intel.com>
Cc: Chris Mason <clm@fb.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 kernel/power/swap.c |    2 +-
 mm/swapfile.c       |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

--- a/kernel/power/swap.c~mm-swap-cleanup-swap-entry-management-workflow-fix
+++ a/kernel/power/swap.c
@@ -199,7 +199,7 @@ void free_all_swap_pages(int swap)
 		ext = rb_entry(node, struct swsusp_extent, node);
 		rb_erase(node, &swsusp_extents);
 
-		for (offset = ext->start; offset < ext->end; offset++)
+		for (offset = ext->start; offset <= ext->end; offset++)
 			swap_free_hibernation_slot(swp_entry(swap, offset));
 
 		kfree(ext);
--- a/mm/swapfile.c~mm-swap-cleanup-swap-entry-management-workflow-fix
+++ a/mm/swapfile.c
@@ -2096,7 +2096,6 @@ void swap_free_hibernation_slot(swp_entr
 
 	ci = swap_cluster_lock(si, offset);
 	swap_entry_put_locked(si, ci, entry, 1);
-	WARN_ON(swap_entry_swapped(si, entry));
 	swap_cluster_unlock(ci);
 
 	/* In theory readahead might add it to the swap cache by accident */
_


