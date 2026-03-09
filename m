Return-Path: <linux-pm+bounces-43973-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMDPEpMxr2kYPgIAu9opvQ
	(envelope-from <linux-pm+bounces-43973-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 21:46:11 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F4F2410FB
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 21:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA97D3051D35
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2026 20:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3636F3563F0;
	Mon,  9 Mar 2026 20:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RTmHBwoM"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE98725A2B4;
	Mon,  9 Mar 2026 20:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773089148; cv=none; b=PAsvTDZ9GeAL4oUUIKuL+EG/gre5xomjYVNVcU2ZG2mpflD8FWYunhJ3s232Wrbhgx97K4tyFpRwAK4QhaQv8jj8BizSlmh2oI84ShhJqVr9ns4rJfNZgQ0sOAF0I4DQX3fG+m9vQOzMeGR1wRb9X4WIueiXgdE0otdEmExnVDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773089148; c=relaxed/simple;
	bh=+OoiKzO30/b0HTsSjmxmKZWRaM2vg9F/qGi89a/eHn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ih2l+2/FvkPrfitUZPFuoE/o0+LUjBxsB0K5VgMHxcdwFjtj4wnv+Yw6ZS5qT+aemzcZsQ69YivcwGE9kssDcf/MZcjkbecGwXlty8kqKNfUnAQxfLrAdvoduvwgzB66/WHRZ7cBwTeu+oXVMmhQEylzWVQlLqJD1BDsqutbL8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RTmHBwoM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r4yNy3lRvtr7DNqjSe9i+ak2Rs4uSSCRK8vrL3F+Og0=; b=RTmHBwoMEWEWandsONyKrPQGnH
	H3WB7HuaACFWcRvvHFroDFbJLPNirJlH0cZpU0QDFzhHQsJ9ZIuHtymJymuxR3SnZ2pWnqAQmyJ/Q
	wm6R3jCgcLv4qlmbCZv9V0sqVthPMyJQof+WqqLM1DZIzOkLPIE4F3tFi6EusZtbnL1EiX0U5C/aR
	X2tlk5bceSWqNSSD90PAkvsqSWB/8WEdv+NcHFJr6Udia05d7sVYQFNPqmDt5HP+6C7EOg3SJ/0bx
	Bok5XbWq3pQhXWvgfKEsd7A1FoXLhL6s83nE8mPkjyTOIKRjYGMxi1xQ3KYj3RGTEpyzj5MzgKqJO
	X0QkEUhg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzhTo-00000006XCe-07wa;
	Mon, 09 Mar 2026 20:45:32 +0000
Date: Mon, 9 Mar 2026 20:45:31 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Dmitry Ilvokhin <d@ilvokhin.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
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
Message-ID: <aa8xawMxLeUjkyHx@casper.infradead.org>
References: <cover.1772206930.git.d@ilvokhin.com>
 <aa7G1nD7Rd9F4eBH@casper.infradead.org>
 <aa7XdpIVtLFS3FIu@shell.ilvokhin.com>
 <aa7dgQDMEz34eadj@casper.infradead.org>
 <20260309151317.7bba06dd@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309151317.7bba06dd@gandalf.local.home>
X-Rspamd-Queue-Id: A6F4F2410FB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43973-lists,linux-pm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:dkim,casper.infradead.org:mid]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 03:13:17PM -0400, Steven Rostedt wrote:
> The biggest issue with making a generic light weight LOCK_STAT is that
> locks are extremely optimized. Any addition of generic lock encoding will
> cause a noticeable overhead when compiled in, even when disabled.

I'm not sure that's true.  Taking the current Debian kernel config
leads to a "call" instruction to acquire a spinlock:

void __insert_inode_hash(struct inode *inode, unsigned long hashval)
{
        struct hlist_head *b = inode_hashtable + hash(inode->i_sb, hashval);

        spin_lock(&inode_hash_lock);
        spin_lock(&inode->i_lock);
        hlist_add_head_rcu(&inode->i_hash, b);
        spin_unlock(&inode->i_lock);
        spin_unlock(&inode_hash_lock);
}

compiles to:

[...]
     280:       23 35 00 00 00 00       and    0x0(%rip),%esi        # 286 <__insert_inode_hash+0x56>
                        282: R_X86_64_PC32      .data..ro_after_init+0x10
     286:       48 8d 2c f0             lea    (%rax,%rsi,8),%rbp
     28a:       e8 00 00 00 00          call   28f <__insert_inode_hash+0x5f>
                        28b: R_X86_64_PLT32     _raw_spin_lock-0x4
     28f:       4c 89 e7                mov    %r12,%rdi
     292:       e8 00 00 00 00          call   297 <__insert_inode_hash+0x67>
                        293: R_X86_64_PLT32     _raw_spin_lock-0x4
[...]

Debian doesn't do anything too weird here:

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set

(The spinlock code is too complex for me to follow what config options
influence whether it's a function call; you probably have enough of it
in your head that you'd know)

> The other issue is the data we store for the lock. A lock is usually just a
> word (or long) in size, embedded in a structure. LOCKDEP and LOCK_STAT adds
> a key per lock. This increases the data size of the kernel.

It does, but perhaps for a light weight lockstat, we could do better
than that.  For example it could use the return address to look up
which lock is being accessed rather than embedding a key in each lock.


