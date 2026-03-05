Return-Path: <linux-pm+bounces-43702-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNNVFKrSqWmYFgEAu9opvQ
	(envelope-from <linux-pm+bounces-43702-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 19:59:54 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E25221730B
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 19:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 311FB30131DA
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 18:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDE92E266C;
	Thu,  5 Mar 2026 18:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="Yu9Wl8qU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91062E7180;
	Thu,  5 Mar 2026 18:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772737189; cv=none; b=CyCzDmA5hVDOj5FebD+D93psNkKGBrHABr+PwAiBotB0uT88KuUnSln4ftOKFfuWDdkg/o34wORNwOMFinxa1o3hs8Rjd/c5qj1irYamm0bQPHkefT9wh5bCtENnD7Q7c8Qrcw/g7k+xG1U4J/SBmM6X5iDKbBKoBhXF8G0UZyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772737189; c=relaxed/simple;
	bh=UOJv9AO8wNTQ7TxXX+08d9NGssbhEuDcdNRLvjP/ROc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQX43NATbpTVSbZkpG0eNzoK5naoFKoGr+4db10uKbj/BAOmJ70sp245ml2z9wSHZAJmrXwfPA+unYBoByNaFN6gTMHd9OSuT40OoVIOKwiHw5678FaSZj0noGF5SRNY08UUkDSFXHbWmdYPAFDTJTx967jtuDfwS8zQYjyOifA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=Yu9Wl8qU; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 64393B3385;
	Thu, 05 Mar 2026 18:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1772737184;
	bh=xIAr9uTlkQoiGY2a6nmMxMk0lhXg3OGIQh+EEVGCqF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Yu9Wl8qUgY0NYNYCLaNF90IA2VZUwszxKLY9WUGmYRyRQhTHIHYTlLLlG0+XVxrWL
	 rSmpq7m2UiDoXwbdQXlWk5RjV+G3XTm/FdOMIhrogkHuuxyBmsm/lAnM9lv15/pCXV
	 4qf8YBlQ5sdheR8gzAfvo9MzQ9ZSxydSweDd/HoU=
Date: Thu, 5 Mar 2026 18:59:43 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
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
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 4/5] mm: rename zone->lock to zone->_lock
Message-ID: <aanSnywUXTVPaYUj@shell.ilvokhin.com>
References: <20260304151335.172572-1-sj@kernel.org>
 <ebd994ca-eb04-4dff-a0a8-47aef0934c2c@kernel.org>
 <aanIdk2i-Eo9M967@shell.ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aanIdk2i-Eo9M967@shell.ilvokhin.com>
X-Rspamd-Queue-Id: 5E25221730B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ilvokhin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ilvokhin.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43702-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	DKIM_TRACE(0.00)[ilvokhin.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[d@ilvokhin.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,linux.dev:email,ilvokhin.com:dkim,ilvokhin.com:email,shell.ilvokhin.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 06:16:26PM +0000, Dmitry Ilvokhin wrote:
> On Thu, Mar 05, 2026 at 10:27:07AM +0100, Vlastimil Babka (SUSE) wrote:
> > On 3/4/26 16:13, SeongJae Park wrote:
> > > On Wed, 4 Mar 2026 13:01:45 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:
> > > 
> > >> On Tue, Mar 03, 2026 at 05:50:34PM -0800, SeongJae Park wrote:
> > >> > On Tue, 3 Mar 2026 14:25:55 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:
> > >> > 
> > >> > > On Mon, Mar 02, 2026 at 02:37:43PM -0800, Andrew Morton wrote:
> > >> > > > On Mon, 2 Mar 2026 15:10:03 +0100 "Vlastimil Babka (SUSE)" <vbabka@kernel.org> wrote:
> > >> > > > 
> > >> > > > > On 2/27/26 17:00, Dmitry Ilvokhin wrote:
> > >> > > > > > This intentionally breaks direct users of zone->lock at compile time so
> > >> > > > > > all call sites are converted to the zone lock wrappers. Without the
> > >> > > > > > rename, present and future out-of-tree code could continue using
> > >> > > > > > spin_lock(&zone->lock) and bypass the wrappers and tracing
> > >> > > > > > infrastructure.
> > >> > > > > > 
> > >> > > > > > No functional change intended.
> > >> > > > > > 
> > >> > > > > > Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> > >> > > > > > Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> > >> > > > > > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> > >> > > > > > Acked-by: SeongJae Park <sj@kernel.org>
> > >> > > > > 
> > >> > > > > I see some more instances of 'zone->lock' in comments in
> > >> > > > > include/linux/mmzone.h and under Documentation/ but otherwise LGTM.
> > >> > > > > 
> > >> > > > 
> > >> > > > I fixed (most of) that in the previous version but my fix was lost.
> > >> > > 
> > >> > > Thanks for the fixups, Andrew.
> > >> > > 
> > >> > > I still see a few 'zone->lock' references in Documentation remain on
> > >> > > mm-new. This patch cleans them up, as noted by Vlastimil.
> > >> > > 
> > >> > > I'm happy to adjust this patch if anything else needs attention.
> > >> > > 
> > >> > > From 9142d5a8b60038fa424a6033253960682e5a51f4 Mon Sep 17 00:00:00 2001
> > >> > > From: Dmitry Ilvokhin <d@ilvokhin.com>
> > >> > > Date: Tue, 3 Mar 2026 06:13:13 -0800
> > >> > > Subject: [PATCH] mm: fix remaining zone->lock references
> > >> > > 
> > >> > > Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> > >> > > ---
> > >> > >  Documentation/mm/physical_memory.rst | 4 ++--
> > >> > >  Documentation/trace/events-kmem.rst  | 8 ++++----
> > >> > >  2 files changed, 6 insertions(+), 6 deletions(-)
> > >> > > 
> > >> > > diff --git a/Documentation/mm/physical_memory.rst b/Documentation/mm/physical_memory.rst
> > >> > > index b76183545e5b..e344f93515b6 100644
> > >> > > --- a/Documentation/mm/physical_memory.rst
> > >> > > +++ b/Documentation/mm/physical_memory.rst
> > >> > > @@ -500,11 +500,11 @@ General
> > >> > >  ``nr_isolate_pageblock``
> > >> > >    Number of isolated pageblocks. It is used to solve incorrect freepage counting
> > >> > >    problem due to racy retrieving migratetype of pageblock. Protected by
> > >> > > -  ``zone->lock``. Defined only when ``CONFIG_MEMORY_ISOLATION`` is enabled.
> > >> > > +  ``zone_lock``. Defined only when ``CONFIG_MEMORY_ISOLATION`` is enabled.
> > >> > 
> > >> > Dmitry's original patch [1] was doing 's/zone->lock/zone->_lock/', which aligns
> > >> > to my expectation.  But this patch is doing 's/zone->lock/zone_lock/'.  Same
> > >> > for the rest of this patch.
> > >> > 
> > >> > I was initially thinking this is just a mistake, but I also found Andrew is
> > >> > doing same change [2], so I'm bit confused.  Is this an intentional change?
> > >> > 
> > >> > [1] https://lore.kernel.org/d61500c5784c64e971f4d328c57639303c475f81.1772206930.git.d@ilvokhin.com
> > >> > [2] https://lore.kernel.org/20260302143743.220eed4feb36d7572fe726cc@linux-foundation.org
> > >> > 
> > >> 
> > >> Good catch, thanks for pointing this out, SJ.
> > >> 
> > >> Originally the mechanical rename was indeed zone->lock -> zone->_lock.
> > >> However, in Documentation I intentionally switched references to
> > >> zone_lock instead of zone->_lock. The reasoning is that _lock is now an
> > >> internal implementation detail, and direct access is discouraged. The
> > >> intended interface is via the zone_lock_*() / zone_unlock_*() wrappers,
> > >> so referencing zone_lock in documentation felt more appropriate than
> > >> mentioning the private struct field (zone->_lock).
> > > 
> > > Thank you for this nice and kind clarification, Dmitry!  I agree mentioning
> > > zone_[un]lock_*() helpers instead of the hidden member (zone->_lock) can be
> > > better.
> > > 
> > > But, I'm concerned if people like me might not aware the intention under
> > > 'zone_lock'.  If there is a well-known convention that allows people to know it
> > > is for 'zone_[un]lock_*()' helpers, making it more clear would be nice, in my
> > > humble opinion.  If there is such a convention but I'm just missing it, please
> > > ignore.  If I'm not, for eaxmaple,
> > > 
> > > "protected by ``zone->lock``" could be re-wrote to
> > > "protected by ``zone_[un]lock_*()`` locking helpers" or,
> > > "protected by zone lock helper functions (``zone_[un]lock_*()``)" ?
> > > 
> > >> 
> > >> That said, I agree this creates inconsistency with the mechanical
> > >> rename, and I'm happy to adjust either way: either consistently refer
> > >> to the wrapper API, or keep documentation aligned with zone->_lock.
> > >> 
> > >> I slightly prefer referring to the wrapper API, but don't have a strong
> > >> preference as long as we're consistent.
> > > 
> > > I also think both approaches are good.  But for the wrapper approach, I think
> > > giving more contexts rather than just ``zone_lock`` to readers would be nice.
> > 
> > Grep tells me that we also have comments mentioning simply "zone lock", btw.
> > And it's also a term used often in informal conversations. Maybe we could
> > just standardize on that in comments/documentations as it's easier to read.
> > Discovering that the field is called _lock and that wrappers should be used,
> > is hopefully not that difficult.
> 
> Thanks for the suggestion, Vlastimil. That sounds reasonable to me as
> well. I'll update the comments and documentation to consistently use
> "zone lock".

Following the suggestion from SJ and Vlastimil, I prepared fixup to
standardize documentation and comments on the term "zone lock".

The patch is based on top of the current mm-new.

Andrew, please let me know if you would prefer a respin of the series
instead.

From 267cda3e0e160f97b346009bc48819bfeed92e52 Mon Sep 17 00:00:00 2001
From: Dmitry Ilvokhin <d@ilvokhin.com>
Date: Thu, 5 Mar 2026 10:36:17 -0800
Subject: [PATCH] mm: documentation: standardize on "zone lock" terminology

During review of the zone lock tracing series it was suggested to
standardize documentation and comments on the term "zone lock"
instead of using zone_lock or referring to the internal field
zone->_lock.

Update references accordingly.

Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
 Documentation/mm/physical_memory.rst |  4 ++--
 Documentation/trace/events-kmem.rst  |  8 ++++----
 mm/compaction.c                      |  2 +-
 mm/internal.h                        |  2 +-
 mm/page_alloc.c                      | 12 ++++++------
 mm/page_isolation.c                  |  4 ++--
 mm/page_owner.c                      |  2 +-
 7 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/mm/physical_memory.rst b/Documentation/mm/physical_memory.rst
index e344f93515b6..2398d87ac156 100644
--- a/Documentation/mm/physical_memory.rst
+++ b/Documentation/mm/physical_memory.rst
@@ -500,11 +500,11 @@ General
 ``nr_isolate_pageblock``
   Number of isolated pageblocks. It is used to solve incorrect freepage counting
   problem due to racy retrieving migratetype of pageblock. Protected by
-  ``zone_lock``. Defined only when ``CONFIG_MEMORY_ISOLATION`` is enabled.
+  zone lock. Defined only when ``CONFIG_MEMORY_ISOLATION`` is enabled.
 
 ``span_seqlock``
   The seqlock to protect ``zone_start_pfn`` and ``spanned_pages``. It is a
-  seqlock because it has to be read outside of ``zone_lock``, and it is done in
+  seqlock because it has to be read outside of zone lock, and it is done in
   the main allocator path. However, the seqlock is written quite infrequently.
   Defined only when ``CONFIG_MEMORY_HOTPLUG`` is enabled.
 
diff --git a/Documentation/trace/events-kmem.rst b/Documentation/trace/events-kmem.rst
index 3c20a972de27..42f08f3b136c 100644
--- a/Documentation/trace/events-kmem.rst
+++ b/Documentation/trace/events-kmem.rst
@@ -57,7 +57,7 @@ the per-CPU allocator (high performance) or the buddy allocator.
 
 If pages are allocated directly from the buddy allocator, the
 mm_page_alloc_zone_locked event is triggered. This event is important as high
-amounts of activity imply high activity on the zone_lock. Taking this lock
+amounts of activity imply high activity on the zone lock. Taking this lock
 impairs performance by disabling interrupts, dirtying cache lines between
 CPUs and serialising many CPUs.
 
@@ -79,11 +79,11 @@ contention on the lruvec->lru_lock.
   mm_page_pcpu_drain		page=%p pfn=%lu order=%d cpu=%d migratetype=%d
 
 In front of the page allocator is a per-cpu page allocator. It exists only
-for order-0 pages, reduces contention on the zone_lock and reduces the
+for order-0 pages, reduces contention on the zone lock and reduces the
 amount of writing on struct page.
 
 When a per-CPU list is empty or pages of the wrong type are allocated,
-the zone_lock will be taken once and the per-CPU list refilled. The event
+the zone lock will be taken once and the per-CPU list refilled. The event
 triggered is mm_page_alloc_zone_locked for each page allocated with the
 event indicating whether it is for a percpu_refill or not.
 
@@ -92,7 +92,7 @@ which triggers a mm_page_pcpu_drain event.
 
 The individual nature of the events is so that pages can be tracked
 between allocation and freeing. A number of drain or refill pages that occur
-consecutively imply the zone_lock being taken once. Large amounts of per-CPU
+consecutively imply the zone lock being taken once. Large amounts of per-CPU
 refills and drains could imply an imbalance between CPUs where too much work
 is being concentrated in one place. It could also indicate that the per-CPU
 lists should be a larger size. Finally, large amounts of refills on one CPU
diff --git a/mm/compaction.c b/mm/compaction.c
index 143ead2cb10a..32623894a632 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1419,7 +1419,7 @@ static bool suitable_migration_target(struct compact_control *cc,
 		int order = cc->order > 0 ? cc->order : pageblock_order;
 
 		/*
-		 * We are checking page_order without zone->_lock taken. But
+		 * We are checking page_order without zone lock taken. But
 		 * the only small danger is that we skip a potentially suitable
 		 * pageblock, so it's not worth to check order for valid range.
 		 */
diff --git a/mm/internal.h b/mm/internal.h
index f634ac469c87..95b583e7e4f7 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -727,7 +727,7 @@ static inline unsigned int buddy_order(struct page *page)
  * (d) a page and its buddy are in the same zone.
  *
  * For recording whether a page is in the buddy system, we set PageBuddy.
- * Setting, clearing, and testing PageBuddy is serialized by zone->_lock.
+ * Setting, clearing, and testing PageBuddy is serialized by zone lock.
  *
  * For recording page's order, we use page_private(page).
  */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4c95364b7063..75ee81445640 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2440,7 +2440,7 @@ enum rmqueue_mode {
 
 /*
  * Do the hard work of removing an element from the buddy allocator.
- * Call me with the zone->_lock already held.
+ * Call me with the zone lock already held.
  */
 static __always_inline struct page *
 __rmqueue(struct zone *zone, unsigned int order, int migratetype,
@@ -2468,7 +2468,7 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
 	 * fallbacks modes with increasing levels of fragmentation risk.
 	 *
 	 * The fallback logic is expensive and rmqueue_bulk() calls in
-	 * a loop with the zone->_lock held, meaning the freelists are
+	 * a loop with the zone lock held, meaning the freelists are
 	 * not subject to any outside changes. Remember in *mode where
 	 * we found pay dirt, to save us the search on the next call.
 	 */
@@ -7046,7 +7046,7 @@ int alloc_contig_frozen_range_noprof(unsigned long start, unsigned long end,
 	 * pages.  Because of this, we reserve the bigger range and
 	 * once this is done free the pages we are not interested in.
 	 *
-	 * We don't have to hold zone->_lock here because the pages are
+	 * We don't have to hold zone lock here because the pages are
 	 * isolated thus they won't get removed from buddy.
 	 */
 	outer_start = find_large_buddy(start);
@@ -7615,7 +7615,7 @@ void accept_page(struct page *page)
 		return;
 	}
 
-	/* Unlocks zone->_lock */
+	/* Unlocks zone lock */
 	__accept_page(zone, &flags, page);
 }
 
@@ -7632,7 +7632,7 @@ static bool try_to_accept_memory_one(struct zone *zone)
 		return false;
 	}
 
-	/* Unlocks zone->_lock */
+	/* Unlocks zone lock */
 	__accept_page(zone, &flags, page);
 
 	return true;
@@ -7773,7 +7773,7 @@ struct page *alloc_frozen_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned
 
 	/*
 	 * Best effort allocation from percpu free list.
-	 * If it's empty attempt to spin_trylock zone->_lock.
+	 * If it's empty attempt to spin_trylock zone lock.
 	 */
 	page = get_page_from_freelist(alloc_gfp, order, alloc_flags, &ac);
 
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index cf731370e7a7..e8414e9a718a 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -212,7 +212,7 @@ static int set_migratetype_isolate(struct page *page, enum pb_isolate_mode mode,
 	zone_unlock_irqrestore(zone, flags);
 	if (mode == PB_ISOLATE_MODE_MEM_OFFLINE) {
 		/*
-		 * printk() with zone->_lock held will likely trigger a
+		 * printk() with zone lock held will likely trigger a
 		 * lockdep splat, so defer it here.
 		 */
 		dump_page(unmovable, "unmovable page");
@@ -553,7 +553,7 @@ void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn)
 /*
  * Test all pages in the range is free(means isolated) or not.
  * all pages in [start_pfn...end_pfn) must be in the same zone.
- * zone->_lock must be held before call this.
+ * zone lock must be held before call this.
  *
  * Returns the last tested pfn.
  */
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 54a4ba63b14f..109f2f28f5b1 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -799,7 +799,7 @@ static void init_pages_in_zone(struct zone *zone)
 				continue;
 
 			/*
-			 * To avoid having to grab zone->_lock, be a little
+			 * To avoid having to grab zone lock, be a little
 			 * careful when reading buddy page order. The only
 			 * danger is that we skip too much and potentially miss
 			 * some early allocated pages, which is better than
-- 
2.47.3


