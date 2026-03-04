Return-Path: <linux-pm+bounces-43580-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGT2C1ctqGlPpQAAu9opvQ
	(envelope-from <linux-pm+bounces-43580-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 14:02:15 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F741FFFC1
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 14:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B9B43040F84
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 13:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6198D266B67;
	Wed,  4 Mar 2026 13:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="pFthcIOp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9C81DE8AE;
	Wed,  4 Mar 2026 13:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772629320; cv=none; b=SpxJXVm7Fkr/vc4ly7wfhr9R+OT7WKR2BYLDtEn9UWJua2ZXuoDSjjM9Rz+fnaZz6GbtKWqrqf3snnLnrOB1t1q18tBs4dJL5HL78WB4RhvwzHcKakPVSPhaz2Eo1hFEdzDeCjPcEr8idb0VTdEN6GxXQfjasX9VZUhaBkWhVPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772629320; c=relaxed/simple;
	bh=Kb3qzLz/b1BGRAyVf2N/dxJ8GTEZDpzuub4ZDwWzUNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWHXSpKfMBpK5/iScNnSeA2YXCObWiHAKnPaOPHhQlsOkqgebzcPSeckMoVqF8g+oVKhsltgFIEYgbnNW1bcuuKfulHW7kiYJpQDUvLusIVcD3JjzH4kB4R6DjrhxEIDDFcX3ss8FcKGHoaHybLkNqACpN+6FAmL5zv1Z6aDde4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=pFthcIOp; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 87BDEB3180;
	Wed, 04 Mar 2026 13:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1772629310;
	bh=A9Z22CwhsOMBQOd91GzYVcy5QaFqoA5vc5xFlhCLB5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=pFthcIOpg6gMssYocf5aeRIIf77W9v5hZIKXBO7FBI43GEFsFtiRaFd/8KmWzEQbq
	 r5Mij1YYDKyrPnmIdgwa/tHoTR+2WzWnTHVmDS1cW790Wkj+VNUORUSHNy9/MsuVMl
	 j/JEInhSlK7v2JYG+6N18JlNqCd4oHXPL8TqT9y0=
Date: Wed, 4 Mar 2026 13:01:45 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <aagtOctLQqpDcw_h@shell.ilvokhin.com>
References: <aabvc4Xhc9qBfaG7@shell.ilvokhin.com>
 <20260304015035.84839-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304015035.84839-1-sj@kernel.org>
X-Rspamd-Queue-Id: B9F741FFFC1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ilvokhin.com,reject];
	R_DKIM_ALLOW(-0.20)[ilvokhin.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43580-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	RSPAMD_URIBL_FAIL(0.00)[linux.dev:query timed out,linux-foundation.org:query timed out];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.c.6.3.0.1.0.0.e.4.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[d@ilvokhin.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[ilvokhin.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ilvokhin.com:dkim,ilvokhin.com:email,linux-foundation.org:email,linux.dev:email,shell.ilvokhin.com:mid]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 05:50:34PM -0800, SeongJae Park wrote:
> On Tue, 3 Mar 2026 14:25:55 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:
> 
> > On Mon, Mar 02, 2026 at 02:37:43PM -0800, Andrew Morton wrote:
> > > On Mon, 2 Mar 2026 15:10:03 +0100 "Vlastimil Babka (SUSE)" <vbabka@kernel.org> wrote:
> > > 
> > > > On 2/27/26 17:00, Dmitry Ilvokhin wrote:
> > > > > This intentionally breaks direct users of zone->lock at compile time so
> > > > > all call sites are converted to the zone lock wrappers. Without the
> > > > > rename, present and future out-of-tree code could continue using
> > > > > spin_lock(&zone->lock) and bypass the wrappers and tracing
> > > > > infrastructure.
> > > > > 
> > > > > No functional change intended.
> > > > > 
> > > > > Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> > > > > Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> > > > > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > > > Acked-by: SeongJae Park <sj@kernel.org>
> > > > 
> > > > I see some more instances of 'zone->lock' in comments in
> > > > include/linux/mmzone.h and under Documentation/ but otherwise LGTM.
> > > > 
> > > 
> > > I fixed (most of) that in the previous version but my fix was lost.
> > 
> > Thanks for the fixups, Andrew.
> > 
> > I still see a few 'zone->lock' references in Documentation remain on
> > mm-new. This patch cleans them up, as noted by Vlastimil.
> > 
> > I'm happy to adjust this patch if anything else needs attention.
> > 
> > From 9142d5a8b60038fa424a6033253960682e5a51f4 Mon Sep 17 00:00:00 2001
> > From: Dmitry Ilvokhin <d@ilvokhin.com>
> > Date: Tue, 3 Mar 2026 06:13:13 -0800
> > Subject: [PATCH] mm: fix remaining zone->lock references
> > 
> > Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> > ---
> >  Documentation/mm/physical_memory.rst | 4 ++--
> >  Documentation/trace/events-kmem.rst  | 8 ++++----
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/mm/physical_memory.rst b/Documentation/mm/physical_memory.rst
> > index b76183545e5b..e344f93515b6 100644
> > --- a/Documentation/mm/physical_memory.rst
> > +++ b/Documentation/mm/physical_memory.rst
> > @@ -500,11 +500,11 @@ General
> >  ``nr_isolate_pageblock``
> >    Number of isolated pageblocks. It is used to solve incorrect freepage counting
> >    problem due to racy retrieving migratetype of pageblock. Protected by
> > -  ``zone->lock``. Defined only when ``CONFIG_MEMORY_ISOLATION`` is enabled.
> > +  ``zone_lock``. Defined only when ``CONFIG_MEMORY_ISOLATION`` is enabled.
> 
> Dmitry's original patch [1] was doing 's/zone->lock/zone->_lock/', which aligns
> to my expectation.  But this patch is doing 's/zone->lock/zone_lock/'.  Same
> for the rest of this patch.
> 
> I was initially thinking this is just a mistake, but I also found Andrew is
> doing same change [2], so I'm bit confused.  Is this an intentional change?
> 
> [1] https://lore.kernel.org/d61500c5784c64e971f4d328c57639303c475f81.1772206930.git.d@ilvokhin.com
> [2] https://lore.kernel.org/20260302143743.220eed4feb36d7572fe726cc@linux-foundation.org
> 

Good catch, thanks for pointing this out, SJ.

Originally the mechanical rename was indeed zone->lock -> zone->_lock.
However, in Documentation I intentionally switched references to
zone_lock instead of zone->_lock. The reasoning is that _lock is now an
internal implementation detail, and direct access is discouraged. The
intended interface is via the zone_lock_*() / zone_unlock_*() wrappers,
so referencing zone_lock in documentation felt more appropriate than
mentioning the private struct field (zone->_lock).

That said, I agree this creates inconsistency with the mechanical
rename, and I'm happy to adjust either way: either consistently refer
to the wrapper API, or keep documentation aligned with zone->_lock.

I slightly prefer referring to the wrapper API, but don't have a strong
preference as long as we're consistent.

> 
> Thanks,
> SJ
> 
> [...]

