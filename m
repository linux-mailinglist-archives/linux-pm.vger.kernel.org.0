Return-Path: <linux-pm+bounces-43946-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NN4J2vHrmlwIwIAu9opvQ
	(envelope-from <linux-pm+bounces-43946-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 14:13:15 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A57239846
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 14:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 720813071F3F
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2026 13:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B37B3ACF0E;
	Mon,  9 Mar 2026 13:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QXH3c3N2"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E5A3A4F50;
	Mon,  9 Mar 2026 13:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773061864; cv=none; b=pmsp1/zhZz88DueaUu0LH1SKLnE2rSefVf7cSI31yvt8lqwibvHJZ9ehu3895+m7aWoCpo9H2q74SYsbpN9n3Z4uDa0ApLoZcJ5WSMeW8gD9BlixU4RaesAujrXEZe+7pYhgFek/sWvu8LrusU/iF6LpKLEDHHJ/4axuE3bJVG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773061864; c=relaxed/simple;
	bh=nZjfTx/ugxBGIyQ1QjlmjuU8PGWzUGRBnVWrjp+AVk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4Isk7xacjrNatoCnaWt8cbXKSKpWMKkCCyoVVw03rQDwsegr2rnkas3dHjqOp03/rRz8egwWrVLhWSSe7bqjGkTPUYwd5dQCvDiNrWXeVQXiTHpTjO7nLWPeRfLpJgowcNxSirVpryT43rht85SefEjAE0QuPyFiH2kzFIGVxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QXH3c3N2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MP91r6c+y7giftvLR1OcIBEAD8RMncykz3hjSEiLD3U=; b=QXH3c3N2WvdAVaSk98rBw2QTWS
	hU5Khg29+699uZHVtoU0uZoe1D1JffMnyRcTC8uQ7cbi7MTdGwkhkTrFM4BxLE7mmonVLmntz5SAP
	IictCbrRUlk+lXjcQDDSzGiCOkzLnQqIORtItpqOvW7X3s3kgk/cOE2ElyskYVfLRf6B9ynL23R4e
	rK4ES1g8jxDUN5iuuqwgC19keOsLHKfFRHgg/jnWLnecoWDm4mQwnmV+S3bnIwP5npEOOGBJmsDeb
	bKuls447s9ARbiGV44qcLe2izeke7FZkNGhnaK8b9FBRLdXrdUrvZp0LPwM3NlLPxUgj1t/dIwV/G
	lBt5MxcA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzaNj-00000005ZGM-0n5j;
	Mon, 09 Mar 2026 13:10:47 +0000
Date: Mon, 9 Mar 2026 13:10:46 +0000
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
Message-ID: <aa7G1nD7Rd9F4eBH@casper.infradead.org>
References: <cover.1772206930.git.d@ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1772206930.git.d@ilvokhin.com>
X-Rspamd-Queue-Id: 07A57239846
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43946-lists,linux-pm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.929];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[casper.infradead.org:mid,infradead.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 04:00:22PM +0000, Dmitry Ilvokhin wrote:
> Zone lock contention can significantly impact allocation and
> reclaim latency, as it is a central synchronization point in
> the page allocator and reclaim paths. Improved visibility into
> its behavior is therefore important for diagnosing performance
> issues in memory-intensive workloads.
> 
> On some production workloads at Meta, we have observed noticeable
> zone lock contention. Deeper analysis of lock holders and waiters
> is currently difficult with existing instrumentation.
> 
> While generic lock contention_begin/contention_end tracepoints
> cover the slow path, they do not provide sufficient visibility
> into lock hold times. In particular, the lack of a release-side
> event makes it difficult to identify long lock holders and
> correlate them with waiters. As a result, distinguishing between
> short bursts of contention and pathological long hold times
> requires additional instrumentation.
> 
> This patch series adds dedicated tracepoint instrumentation to
> zone lock, following the existing mmap_lock tracing model.

I don't like this at all.  We have CONFIG_LOCK_STAT.  That should be
improved insted of coming up with one-offs for every single lock
that someone deems "special".

