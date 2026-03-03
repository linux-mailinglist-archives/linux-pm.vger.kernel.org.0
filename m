Return-Path: <linux-pm+bounces-43498-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iP7CKYfwpmk/agAAu9opvQ
	(envelope-from <linux-pm+bounces-43498-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 15:30:31 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8481F17D0
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 15:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E80B33036D50
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 14:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F75B3B3C16;
	Tue,  3 Mar 2026 14:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="cR1o2MTN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2DD3822B7;
	Tue,  3 Mar 2026 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772547964; cv=none; b=WWjfgCJ7jjvbkaAibZCjbbd+H5vneIPugib43HLeaWyD4q9UmBdDp98pFQrX38lh+hFa7DN2AMPBHlzJyV46SNg14vwbjtmvx9iPkUwHCuiGqGhJEMfkFJancncMrFvZcOQX9teA2QdLfycYFQy9l3JGv6C/u/rXqxxLycbMXTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772547964; c=relaxed/simple;
	bh=qnDLvfOYAMIQg8avmH5Pha1NK4JIjQHZjXzlt3EZXyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgaGrHkQQDpt/CN8zvNRSxYaTJD20IFk4+eJh7H4vX/fYFIlAwLi29wqUD3DVld14I7yh0HhRPP/YrYvOblkKS18q9+lx9Tj+lXhcGghMYWfRzjK3wnPJ0Epig8YIIRCAAuwN9Cn1mMxx21KHHUbVHTR+GTLYw8Ig1cDpBHtFYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=cR1o2MTN; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id DDD3FB3100;
	Tue, 03 Mar 2026 14:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1772547960;
	bh=LNVFddGP/SQV1eCKP4+0NtVgj/0UkiifX6TCYuJFdss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cR1o2MTNmIgJM6CSLHyWv2tw4JfyPhDpRjgo6tiqz7f4s2IZ5YCSw5z6tNQXgor7/
	 fhP27pb7RcpWqjF+WmGNTd/A4By/OK271NUgciUW8p2iipyod2Rkd4JS3l1K9JMASN
	 /hTSH+NuohXjtj/oRcJWrcMcZsLRnqGsDfXUKBlg=
Date: Tue, 3 Mar 2026 14:25:55 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH v4 4/5] mm: rename zone->lock to zone->_lock
Message-ID: <aabvc4Xhc9qBfaG7@shell.ilvokhin.com>
References: <cover.1772206930.git.d@ilvokhin.com>
 <d61500c5784c64e971f4d328c57639303c475f81.1772206930.git.d@ilvokhin.com>
 <0f340324-502b-4719-b3e7-c7ccd4378385@kernel.org>
 <20260302143743.220eed4feb36d7572fe726cc@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302143743.220eed4feb36d7572fe726cc@linux-foundation.org>
X-Rspamd-Queue-Id: 0D8481F17D0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ilvokhin.com,reject];
	R_DKIM_ALLOW(-0.20)[ilvokhin.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43498-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[ilvokhin.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[29];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[d@ilvokhin.com,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 02:37:43PM -0800, Andrew Morton wrote:
> On Mon, 2 Mar 2026 15:10:03 +0100 "Vlastimil Babka (SUSE)" <vbabka@kernel.org> wrote:
> 
> > On 2/27/26 17:00, Dmitry Ilvokhin wrote:
> > > This intentionally breaks direct users of zone->lock at compile time so
> > > all call sites are converted to the zone lock wrappers. Without the
> > > rename, present and future out-of-tree code could continue using
> > > spin_lock(&zone->lock) and bypass the wrappers and tracing
> > > infrastructure.
> > > 
> > > No functional change intended.
> > > 
> > > Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> > > Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> > > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > Acked-by: SeongJae Park <sj@kernel.org>
> > 
> > I see some more instances of 'zone->lock' in comments in
> > include/linux/mmzone.h and under Documentation/ but otherwise LGTM.
> > 
> 
> I fixed (most of) that in the previous version but my fix was lost.

Thanks for the fixups, Andrew.

I still see a few 'zone->lock' references in Documentation remain on
mm-new. This patch cleans them up, as noted by Vlastimil.

I'm happy to adjust this patch if anything else needs attention.

From 9142d5a8b60038fa424a6033253960682e5a51f4 Mon Sep 17 00:00:00 2001
From: Dmitry Ilvokhin <d@ilvokhin.com>
Date: Tue, 3 Mar 2026 06:13:13 -0800
Subject: [PATCH] mm: fix remaining zone->lock references

Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
 Documentation/mm/physical_memory.rst | 4 ++--
 Documentation/trace/events-kmem.rst  | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/mm/physical_memory.rst b/Documentation/mm/physical_memory.rst
index b76183545e5b..e344f93515b6 100644
--- a/Documentation/mm/physical_memory.rst
+++ b/Documentation/mm/physical_memory.rst
@@ -500,11 +500,11 @@ General
 ``nr_isolate_pageblock``
   Number of isolated pageblocks. It is used to solve incorrect freepage counting
   problem due to racy retrieving migratetype of pageblock. Protected by
-  ``zone->lock``. Defined only when ``CONFIG_MEMORY_ISOLATION`` is enabled.
+  ``zone_lock``. Defined only when ``CONFIG_MEMORY_ISOLATION`` is enabled.
 
 ``span_seqlock``
   The seqlock to protect ``zone_start_pfn`` and ``spanned_pages``. It is a
-  seqlock because it has to be read outside of ``zone->lock``, and it is done in
+  seqlock because it has to be read outside of ``zone_lock``, and it is done in
   the main allocator path. However, the seqlock is written quite infrequently.
   Defined only when ``CONFIG_MEMORY_HOTPLUG`` is enabled.
 
diff --git a/Documentation/trace/events-kmem.rst b/Documentation/trace/events-kmem.rst
index 68fa75247488..3c20a972de27 100644
--- a/Documentation/trace/events-kmem.rst
+++ b/Documentation/trace/events-kmem.rst
@@ -57,7 +57,7 @@ the per-CPU allocator (high performance) or the buddy allocator.
 
 If pages are allocated directly from the buddy allocator, the
 mm_page_alloc_zone_locked event is triggered. This event is important as high
-amounts of activity imply high activity on the zone->lock. Taking this lock
+amounts of activity imply high activity on the zone_lock. Taking this lock
 impairs performance by disabling interrupts, dirtying cache lines between
 CPUs and serialising many CPUs.
 
@@ -79,11 +79,11 @@ contention on the lruvec->lru_lock.
   mm_page_pcpu_drain		page=%p pfn=%lu order=%d cpu=%d migratetype=%d
 
 In front of the page allocator is a per-cpu page allocator. It exists only
-for order-0 pages, reduces contention on the zone->lock and reduces the
+for order-0 pages, reduces contention on the zone_lock and reduces the
 amount of writing on struct page.
 
 When a per-CPU list is empty or pages of the wrong type are allocated,
-the zone->lock will be taken once and the per-CPU list refilled. The event
+the zone_lock will be taken once and the per-CPU list refilled. The event
 triggered is mm_page_alloc_zone_locked for each page allocated with the
 event indicating whether it is for a percpu_refill or not.
 
@@ -92,7 +92,7 @@ which triggers a mm_page_pcpu_drain event.
 
 The individual nature of the events is so that pages can be tracked
 between allocation and freeing. A number of drain or refill pages that occur
-consecutively imply the zone->lock being taken once. Large amounts of per-CPU
+consecutively imply the zone_lock being taken once. Large amounts of per-CPU
 refills and drains could imply an imbalance between CPUs where too much work
 is being concentrated in one place. It could also indicate that the per-CPU
 lists should be a larger size. Finally, large amounts of refills on one CPU
-- 
2.47.3


