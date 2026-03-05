Return-Path: <linux-pm+bounces-43663-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKwQIu1MqWk14AAAu9opvQ
	(envelope-from <linux-pm+bounces-43663-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 10:29:17 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DADFD20E673
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 10:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05533300FED0
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 09:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110E137883B;
	Thu,  5 Mar 2026 09:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SY8eFLte"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21803064A9;
	Thu,  5 Mar 2026 09:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772702835; cv=none; b=hYQ5F6q0n94QBNDACVM/r6qTdQsuRIZoxLk/VsDMsdkzvdkKwdOEIYlIztpr0zQzAzg1B2pdPkAAtw9YepcFW6PJ1l25jXFnQMBvlYX6+xtr0fDZKYeHLRXpsBWRNOBdc7QGLrImW9AocTVUI4bszFln1S7Du+FnkgZ8Qc6pU8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772702835; c=relaxed/simple;
	bh=2PM4TCzaL7PIpbUAvBpvBfsaqfpwHgfynLyCMx106LY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lIVtQjnhXwA2OJapxhpd4C+wuSsWf/mLUnrL1Q1doEOpSEehyeLunBxRgYaqHRp/FwPqtP2ihlvmT5p5aMAFwRQoY0BP4CEKn/Teml3V+oKmsxEhMXCgloppBjwbWs3ETeT+rswecQNY4EXsnEXkjHe6dqSwgbyJYzhYnjynAKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SY8eFLte; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255C4C2BCAF;
	Thu,  5 Mar 2026 09:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772702834;
	bh=2PM4TCzaL7PIpbUAvBpvBfsaqfpwHgfynLyCMx106LY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SY8eFLtecDllvoK9zUMo9qn2jHOAd5sY4zp6ILJ66Tr4bib3tFLTEtqxACNUgf2y2
	 sCF0z+E/B7kUMZf4O3fGNtuQ/24k78Eut7nDBiyY/DUio7LYHlDa4fJCI8+vngGo4t
	 mcpN54APp4sE8UiwGy14kbUMLM9AYwa2N1MZY34ywwEZ2GTqrHnMyi+2TyTqr76X43
	 siVYvzHvBqHZK3sjeZJr1IT43mBMhO04EGXLkzT0d7BcsKWku/qd++43Awvfl2u0U+
	 +Q/jopx6C5PRPyDyZFEW27mfdvkbjRLyk1NnDVtAm295ARYETRb7NTRJhd893NOMHz
	 qeuaSyL+N5G5w==
Message-ID: <ebd994ca-eb04-4dff-a0a8-47aef0934c2c@kernel.org>
Date: Thu, 5 Mar 2026 10:27:07 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] mm: rename zone->lock to zone->_lock
Content-Language: en-US
To: SeongJae Park <sj@kernel.org>, Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Oscar Salvador <osalvador@suse.de>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20260304151335.172572-1-sj@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20260304151335.172572-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DADFD20E673
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43663-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Action: no action

On 3/4/26 16:13, SeongJae Park wrote:
> On Wed, 4 Mar 2026 13:01:45 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:
> 
>> On Tue, Mar 03, 2026 at 05:50:34PM -0800, SeongJae Park wrote:
>> > On Tue, 3 Mar 2026 14:25:55 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:
>> > 
>> > > On Mon, Mar 02, 2026 at 02:37:43PM -0800, Andrew Morton wrote:
>> > > > On Mon, 2 Mar 2026 15:10:03 +0100 "Vlastimil Babka (SUSE)" <vbabka@kernel.org> wrote:
>> > > > 
>> > > > > On 2/27/26 17:00, Dmitry Ilvokhin wrote:
>> > > > > > This intentionally breaks direct users of zone->lock at compile time so
>> > > > > > all call sites are converted to the zone lock wrappers. Without the
>> > > > > > rename, present and future out-of-tree code could continue using
>> > > > > > spin_lock(&zone->lock) and bypass the wrappers and tracing
>> > > > > > infrastructure.
>> > > > > > 
>> > > > > > No functional change intended.
>> > > > > > 
>> > > > > > Suggested-by: Andrew Morton <akpm@linux-foundation.org>
>> > > > > > Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
>> > > > > > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
>> > > > > > Acked-by: SeongJae Park <sj@kernel.org>
>> > > > > 
>> > > > > I see some more instances of 'zone->lock' in comments in
>> > > > > include/linux/mmzone.h and under Documentation/ but otherwise LGTM.
>> > > > > 
>> > > > 
>> > > > I fixed (most of) that in the previous version but my fix was lost.
>> > > 
>> > > Thanks for the fixups, Andrew.
>> > > 
>> > > I still see a few 'zone->lock' references in Documentation remain on
>> > > mm-new. This patch cleans them up, as noted by Vlastimil.
>> > > 
>> > > I'm happy to adjust this patch if anything else needs attention.
>> > > 
>> > > From 9142d5a8b60038fa424a6033253960682e5a51f4 Mon Sep 17 00:00:00 2001
>> > > From: Dmitry Ilvokhin <d@ilvokhin.com>
>> > > Date: Tue, 3 Mar 2026 06:13:13 -0800
>> > > Subject: [PATCH] mm: fix remaining zone->lock references
>> > > 
>> > > Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
>> > > ---
>> > >  Documentation/mm/physical_memory.rst | 4 ++--
>> > >  Documentation/trace/events-kmem.rst  | 8 ++++----
>> > >  2 files changed, 6 insertions(+), 6 deletions(-)
>> > > 
>> > > diff --git a/Documentation/mm/physical_memory.rst b/Documentation/mm/physical_memory.rst
>> > > index b76183545e5b..e344f93515b6 100644
>> > > --- a/Documentation/mm/physical_memory.rst
>> > > +++ b/Documentation/mm/physical_memory.rst
>> > > @@ -500,11 +500,11 @@ General
>> > >  ``nr_isolate_pageblock``
>> > >    Number of isolated pageblocks. It is used to solve incorrect freepage counting
>> > >    problem due to racy retrieving migratetype of pageblock. Protected by
>> > > -  ``zone->lock``. Defined only when ``CONFIG_MEMORY_ISOLATION`` is enabled.
>> > > +  ``zone_lock``. Defined only when ``CONFIG_MEMORY_ISOLATION`` is enabled.
>> > 
>> > Dmitry's original patch [1] was doing 's/zone->lock/zone->_lock/', which aligns
>> > to my expectation.  But this patch is doing 's/zone->lock/zone_lock/'.  Same
>> > for the rest of this patch.
>> > 
>> > I was initially thinking this is just a mistake, but I also found Andrew is
>> > doing same change [2], so I'm bit confused.  Is this an intentional change?
>> > 
>> > [1] https://lore.kernel.org/d61500c5784c64e971f4d328c57639303c475f81.1772206930.git.d@ilvokhin.com
>> > [2] https://lore.kernel.org/20260302143743.220eed4feb36d7572fe726cc@linux-foundation.org
>> > 
>> 
>> Good catch, thanks for pointing this out, SJ.
>> 
>> Originally the mechanical rename was indeed zone->lock -> zone->_lock.
>> However, in Documentation I intentionally switched references to
>> zone_lock instead of zone->_lock. The reasoning is that _lock is now an
>> internal implementation detail, and direct access is discouraged. The
>> intended interface is via the zone_lock_*() / zone_unlock_*() wrappers,
>> so referencing zone_lock in documentation felt more appropriate than
>> mentioning the private struct field (zone->_lock).
> 
> Thank you for this nice and kind clarification, Dmitry!  I agree mentioning
> zone_[un]lock_*() helpers instead of the hidden member (zone->_lock) can be
> better.
> 
> But, I'm concerned if people like me might not aware the intention under
> 'zone_lock'.  If there is a well-known convention that allows people to know it
> is for 'zone_[un]lock_*()' helpers, making it more clear would be nice, in my
> humble opinion.  If there is such a convention but I'm just missing it, please
> ignore.  If I'm not, for eaxmaple,
> 
> "protected by ``zone->lock``" could be re-wrote to
> "protected by ``zone_[un]lock_*()`` locking helpers" or,
> "protected by zone lock helper functions (``zone_[un]lock_*()``)" ?
> 
>> 
>> That said, I agree this creates inconsistency with the mechanical
>> rename, and I'm happy to adjust either way: either consistently refer
>> to the wrapper API, or keep documentation aligned with zone->_lock.
>> 
>> I slightly prefer referring to the wrapper API, but don't have a strong
>> preference as long as we're consistent.
> 
> I also think both approaches are good.  But for the wrapper approach, I think
> giving more contexts rather than just ``zone_lock`` to readers would be nice.

Grep tells me that we also have comments mentioning simply "zone lock", btw.
And it's also a term used often in informal conversations. Maybe we could
just standardize on that in comments/documentations as it's easier to read.
Discovering that the field is called _lock and that wrappers should be used,
is hopefully not that difficult.

