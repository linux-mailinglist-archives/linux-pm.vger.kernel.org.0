Return-Path: <linux-pm+bounces-43952-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICN1BqXermm/JQIAu9opvQ
	(envelope-from <linux-pm+bounces-43952-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 15:52:21 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 270AA23AEE0
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 15:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB20F3007B35
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2026 14:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC143D5227;
	Mon,  9 Mar 2026 14:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lB/uQ5QS"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA6E345757;
	Mon,  9 Mar 2026 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773067670; cv=none; b=YfYY4fO6KGkOwr3ykIXfjJN9YJSahEUGbE3DtA/r5DyKxO2OT8mGV4OKNJLq82jau7vuvnEL4qixu0R1QalHoWTf5c++Y7J0Bm1akUz65RNvOG2lxSeK1lrqKfcIaFW0JoeBMTJ+Nl6B9EhaGnMyk/zkgZs6ENt/DB06Jz6asC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773067670; c=relaxed/simple;
	bh=eXyRneHTsvpE0EveC8TOOVKjhFZ5Y6t4ydNgChoLuik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6WDNwMqoFTaFsf0nHiZcKaZZF+DKPIPAmcHJBsgzZfLQvrZQd69uhv8Js/GadxMIfNF2M02v+L0idAEh0ykmkEjQBds7zJNPXNo4JPV6Qcvmmxy23ieK5orOSMb9QhnCgmBj5dZKtHgjJ8H43eRJ1oAkK2NZqKaFoEh+lfQaNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lB/uQ5QS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Nnj4k+XehaMxifjpCjHJ3TnczqL5sK8JKePas2gKMrs=; b=lB/uQ5QSLsq6gH+kR+l86+yhw5
	FbuQvAXOsHCyim+YF0hTYAJW0G999xN9zFVOfpoCYd9npU8AV4L+txlNyjDxtjir0wUVDz9TJVj/h
	SLdO+/BelNCrkIxgc5/tKbKH7TvdKEZkthv/TljmV+H91v2wnZt6T0V0lYd9DdF9KvopEZIb0/2p9
	jnI6nwp4w76mtod5tTZKWu03pCo3W9USscMLbZ9LGRGeb0hRaXEceePsbUInZHyMmJAT7DjHGE/2J
	iw1Bq6KCXTRZyMkKs504FvSuHJQhsO4ev1bqdTIl+EMVppbjDl/ThQ6KNnuZiUIEU2RrG2f88TpwF
	NZkyISzA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzbtK-000000066Hk-0pLi;
	Mon, 09 Mar 2026 14:47:30 +0000
Date: Mon, 9 Mar 2026 14:47:29 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Dmitry Ilvokhin <d@ilvokhin.com>
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
Subject: Re: [PATCH v4 0/5] mm: zone lock tracepoint instrumentation
Message-ID: <aa7dgQDMEz34eadj@casper.infradead.org>
References: <cover.1772206930.git.d@ilvokhin.com>
 <aa7G1nD7Rd9F4eBH@casper.infradead.org>
 <aa7XdpIVtLFS3FIu@shell.ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa7XdpIVtLFS3FIu@shell.ilvokhin.com>
X-Rspamd-Queue-Id: 270AA23AEE0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43952-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.942];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 02:21:42PM +0000, Dmitry Ilvokhin wrote:
> On Mon, Mar 09, 2026 at 01:10:46PM +0000, Matthew Wilcox wrote:
> > On Fri, Feb 27, 2026 at 04:00:22PM +0000, Dmitry Ilvokhin wrote:
> > > This patch series adds dedicated tracepoint instrumentation to
> > > zone lock, following the existing mmap_lock tracing model.
> > 
> > I don't like this at all.  We have CONFIG_LOCK_STAT.  That should be
> > improved insted of coming up with one-offs for every single lock
> > that someone deems "special".
> 
> Thanks for the feedback, Matthew.
> 
> CONFIG_LOCK_STAT provides useful statistics, but it is primarily a
> debug facility and is generally too heavyweight for the production
> environments.

Yes, agreed.  I think that is what needs to change.

> The motivation for this series was to provide lightweight observability
> for the zone lock in production workloads.

I read that.  But first it was the mmap lock.  Now it's the zone lock.
Which lock will be next?  This is too heavyweight a procedure to
follow for each lock of interest.

> I agree that improving generic lock instrumentation would be preferable.
> I did consider whether something similar could be done generically for
> spinlocks, but the unlock path there is typically just a single atomic
> store, so adding generic lightweight instrumentation without affecting
> the fast path is difficult.

This is why we have tracepoint_enabled() and friends.  But ... LOCK_STAT
doesn't affect the unlock path at all.  It only changes the acquire side
to call lock_acquired() (and lock_contended() if the trylock failed).

> In parallel, I've been experimenting with improving observability for
> sleepable locks by adding a contended_release tracepoint, which would
> allow correlating lock holders and waiters in a more generic way. I've
> posted an RFC here:
> 
> https://lore.kernel.org/all/cover.1772642407.git.d@ilvokhin.com/
> 
> I'd appreciate feedback on whether that direction makes sense for
> improving the generic lock tracing infrastructure.

It seems fine to me, but I don't have the depth in the locking code to
give it the thorough review it deserves.

