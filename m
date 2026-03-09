Return-Path: <linux-pm+bounces-43972-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aG4uBVwer2neOAIAu9opvQ
	(envelope-from <linux-pm+bounces-43972-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 20:24:12 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB7D23FC13
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 20:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39892309F6BA
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2026 19:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4B03603D2;
	Mon,  9 Mar 2026 19:13:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C970F345CBE;
	Mon,  9 Mar 2026 19:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773083600; cv=none; b=CHk9Pz1GMgEiZC0IUVazwV39fdh5Ur8A8f4v4ZesaW1g8dYvhsfGer7Sm2faYoxfHnb/eL1V7DQB97lwmqw2y1ZcJpSNb56ADCah9lLjt2FqgQOd2KOJut4J5pqAz+Lz0nLUkVbSLfdu78evc4wDrmZOeVQZBqji346fCnGndiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773083600; c=relaxed/simple;
	bh=3iff4JSo5yZr1GyucTFd4yCpK00l9CNEQ34BVHF5PBc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QdtwPNCkMkhOThdqiZe7SUZI03Hjy3k/YJ3v82MMXgyu3IHWqBgwjW0q51lMHBNWT3OGDkYrb6fMtQ4ivHWpur2mh8mCLY78NDDHsZ2R4qltnUxOl2kUmM+SO0TaCfq2PcAz0n5vAn63MmQBIpS5LdM1GAIefP1cjcM9gR/3DCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 4F80E8B40B;
	Mon,  9 Mar 2026 19:13:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 0D2EF20026;
	Mon,  9 Mar 2026 19:13:09 +0000 (UTC)
Date: Mon, 9 Mar 2026 15:13:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Dmitry Ilvokhin <d@ilvokhin.com>, Andrew Morton
 <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie
 <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Oscar
 Salvador <osalvador@suse.de>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 0/5] mm: zone lock tracepoint instrumentation
Message-ID: <20260309151317.7bba06dd@gandalf.local.home>
In-Reply-To: <aa7dgQDMEz34eadj@casper.infradead.org>
References: <cover.1772206930.git.d@ilvokhin.com>
	<aa7G1nD7Rd9F4eBH@casper.infradead.org>
	<aa7XdpIVtLFS3FIu@shell.ilvokhin.com>
	<aa7dgQDMEz34eadj@casper.infradead.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: c5tso9dgk6q1ihwtr3tucamreajeta1t
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/t1Ugy1fVfjXyAi0RgUyUMU3bb6SSTt54=
X-HE-Tag: 1773083589-71908
X-HE-Meta: U2FsdGVkX1/Wx0umbTtULg2v9su5xeKShIbhebg44QdCcqtOibGO+Ihs1xBog4RL/GQxhiUtLwc8NNVFs8NrifJeiVuZCaBnsyIP5ll9GwHE+DuXexFcf7tzPaO+zm9jcDgS1fMOvX6sNJWwEPx9pBTyzyNPuBu8QJhCoXE92GFp1mdZECY+Okz/VjQo05ivbANloz/uuoLMjauDe+H8knTs5XdzvK9d0uSl4QWvGP+ulTi4xxM518Qk8ORZtElmWksx0uJukhu2dIcBzyH4pmVT7F+Fvs72WiT66l6E4l84judGtvbb7e71dICUFeB/g0OgzEtJORBzgxZX9liw1aXv9m8ED5+yT5Gj3BiGQgUBQ4rPqL2GBiO0rUh+8cxQ
X-Rspamd-Queue-Id: 8CB7D23FC13
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[goodmis.org : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.487];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@goodmis.org,linux-pm@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43972-lists,linux-pm=lfdr.de];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:email]
X-Rspamd-Action: no action

On Mon, 9 Mar 2026 14:47:29 +0000
Matthew Wilcox <willy@infradead.org> wrote:

> > CONFIG_LOCK_STAT provides useful statistics, but it is primarily a
> > debug facility and is generally too heavyweight for the production
> > environments.  
> 
> Yes, agreed.  I think that is what needs to change.

The biggest issue with making a generic light weight LOCK_STAT is that
locks are extremely optimized. Any addition of generic lock encoding will
cause a noticeable overhead when compiled in, even when disabled.

Most of the lock code is inlined for the fast path. Now if we want to add
lock stats, we would need to add hooks into those inlined paths. This will
undoubtedly increase the size of text, which will have an impact on I$.

The other issue is the data we store for the lock. A lock is usually just a
word (or long) in size, embedded in a structure. LOCKDEP and LOCK_STAT adds
a key per lock. This increases the data size of the kernel.

LOCK_STAT was designed on top of LOCKDEP. Perhaps a lighter version of
LOCK_STAT could be designed without LOCKDEP, but it would be a project on
its own.

-- Steve

