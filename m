Return-Path: <linux-pm+bounces-43427-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPZaO3qspWmpDgAAu9opvQ
	(envelope-from <linux-pm+bounces-43427-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 16:27:54 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 515D91DBD11
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 16:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A66B30734F2
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 15:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412BD4014BD;
	Mon,  2 Mar 2026 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="0XQtejgo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F302DC77F;
	Mon,  2 Mar 2026 15:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772464982; cv=none; b=mgn4ZOnh0/kJZnLWOuf0mIIHaU33hXBQIC+zdLCTOt9JDdwytwj4eoAogjpJFylO7uizf6Ex8jhRQeSSTRa4WSGgFJxguVzffZ4lIAPco3P6XA7TpliiSL0zpZBjJCTKdBkh3zT/ksoavZucPdmPFfB1GWvYZf9oZpOd1Y5P4b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772464982; c=relaxed/simple;
	bh=tnGNrd08ygRLNg29w5uOg5fCwaj3xRbm+K6TxvyXixM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcsTq+bPQT86LRRea+R/Q8ra+/N5rsyyRZm4ORhOLe2j477OmDutr+jr2cKJP+n6xyAPgtlvZVazUkvNsa/c2vjtHK2YX27ZsLXhWLmtIO4LqieEDsNGBA4UQQ+A+864iwXvK8tc1qLMcaMkqeRXaMgPHVvzp/istOuaN7BKjo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=0XQtejgo; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id BD9F5B308A;
	Mon, 02 Mar 2026 15:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1772464979;
	bh=cZrWALVvP/5PCNYa5kN8hhPqzqgPdcu+PQQdFr2xuMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=0XQtejgoF4lHXmQZfH+M5Yr/k2dulaPURnPgHTjB3MWoBc4ABdeo9tX28PvlJ0wfS
	 MhnKUH1BcERlzCflotEoBh7ucIj9rGuOw5aZlwAZ3tTbpooMJtXtq+bpD3TPnVM5C9
	 IoQNyU/1h833NedDbDGWDcatze9MhSFM3hlGuVIY=
Date: Mon, 2 Mar 2026 15:22:57 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH v4 2/5] mm: convert zone lock users to wrappers
Message-ID: <aaWrUezs2XysV2Kl@shell.ilvokhin.com>
References: <cover.1772206930.git.d@ilvokhin.com>
 <d26a43ebed2f0f1edb9cfe4fbed16dd31c7a069c.1772206930.git.d@ilvokhin.com>
 <7e93021d-53dd-4162-97e6-3bca1f46a0c6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e93021d-53dd-4162-97e6-3bca1f46a0c6@kernel.org>
X-Rspamd-Queue-Id: 515D91DBD11
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ilvokhin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ilvokhin.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43427-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	DKIM_TRACE(0.00)[ilvokhin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[d@ilvokhin.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ilvokhin.com:dkim,ilvokhin.com:email,linux.dev:email,shell.ilvokhin.com:mid]
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 09:39:11PM +0100, David Hildenbrand (Arm) wrote:
> On 2/27/26 17:00, Dmitry Ilvokhin wrote:
> > Replace direct zone lock acquire/release operations with the
> > newly introduced wrappers.
> > 
> > The changes are purely mechanical substitutions. No functional change
> > intended. Locking semantics and ordering remain unchanged.
> > 
> > The compaction path is left unchanged for now and will be
> > handled separately in the following patch due to additional
> > non-trivial modifications.
> > 
> > Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> > Reviewed-by: SeongJae Park <sj@kernel.org>
> > ---
> 
> [...]
> 
> >  #ifdef CONFIG_COMPACTION
> > @@ -530,11 +531,14 @@ static bool compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
> >   * Returns true if compaction should abort due to fatal signal pending.
> >   * Returns false when compaction can continue.
> >   */
> > -static bool compact_unlock_should_abort(spinlock_t *lock,
> > -		unsigned long flags, bool *locked, struct compact_control *cc)
> > +
> > +static bool compact_unlock_should_abort(struct zone *zone,
> > +					unsigned long flags,
> > +					bool *locked,
> > +					struct compact_control *cc)
> 
> We tend to use two-tabs on second parameter line; like the existing code
> did.
> 
> 
> Besides that
> 
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> 

Thanks, David. Noted. Appreciate the review and ack.

> -- 
> Cheers,
> 
> David

