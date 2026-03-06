Return-Path: <linux-pm+bounces-43751-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOKwGnKLqml0TQEAu9opvQ
	(envelope-from <linux-pm+bounces-43751-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 09:08:18 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 137F521CDCA
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 09:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94142302336D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 08:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E42372B3A;
	Fri,  6 Mar 2026 08:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7IawFCH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7F2313558;
	Fri,  6 Mar 2026 08:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772784362; cv=none; b=rH3skYcbp8pBkJv7ER5j96DHPMn/0OTa0g1gsD8yMEJDEaFOa1qyZ5EOI/dCUqLr+iloioCxoXof8gp7thoelSYe2Pes6P/tG8sQqgbz/4H2haX2Apqm898iK9qDKpVMIGFwC9OEDMDxz+ViOi2c2vZApNev/4pr6H3uVgkoNW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772784362; c=relaxed/simple;
	bh=LBnLAIcGHsesTcn5+nCMswocvTfZ7iqXSC/2rWKf6mo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=l9r5ARc5PtedPIU9thEAk5GlOr3zWarbO/7JPgdbu6Xcx4EaJva7adES6YAgZjtLO88HIgZEt/FOijSygGw6IBQuFKha0XXvlgEPHeQjT7iHuD3YfpL6aGPQ4Eg/AZZOaMRuJ85tEW3PGSzcIAMcOV82PNEEPFwFxzKJ6z6JuxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7IawFCH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07EEC4CEF7;
	Fri,  6 Mar 2026 08:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772784362;
	bh=LBnLAIcGHsesTcn5+nCMswocvTfZ7iqXSC/2rWKf6mo=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=e7IawFCHAhTtgO2GugIeECwEAMAUwS7CAhKdLOxCNwho2wzUPrFmxuX0/LHIKh4Kw
	 qraeumJ9ZyUL57jNsPz2RIDPJu/e0skvhJsg7SPOAgHZWcL4wA41gYL6zd+LS3tapH
	 b4Pd4tRflwrRsgHHdIQkUGAAYYcHq41rSp3OsLdy8ARqGbWLeGLMs999tv6BBhu+cy
	 10G0W/9KMXIiaWZrXgag1vJzwIY6HCA+8DjBbKyU5wuZhatlvNDmiV4zOTYa6PxYIJ
	 Ex+l2q4U7fRWA3kjpxzxDE2jrt1NzEyabYTyDqMGKONV5Peg3xCTHd/3B6baFYUWXF
	 W6t1hx5WKLGqQ==
Message-ID: <3b0b7f7f-c1b0-4f1c-bece-ce0cae130cb5@kernel.org>
Date: Fri, 6 Mar 2026 09:05:54 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Subject: Re: [PATCH v4 4/5] mm: rename zone->lock to zone->_lock
Content-Language: en-US
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
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
 <ebd994ca-eb04-4dff-a0a8-47aef0934c2c@kernel.org>
 <aanIdk2i-Eo9M967@shell.ilvokhin.com> <aanSnywUXTVPaYUj@shell.ilvokhin.com>
In-Reply-To: <aanSnywUXTVPaYUj@shell.ilvokhin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 137F521CDCA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43751-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,ilvokhin.com:email,linux-foundation.org:email]
X-Rspamd-Action: no action

On 3/5/26 19:59, Dmitry Ilvokhin wrote:
> On Thu, Mar 05, 2026 at 06:16:26PM +0000, Dmitry Ilvokhin wrote:
>> On Thu, Mar 05, 2026 at 10:27:07AM +0100, Vlastimil Babka (SUSE) wrote:
>> > On 3/4/26 16:13, SeongJae Park wrote:
>> > > On Wed, 4 Mar 2026 13:01:45 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:
>> > > 
>> > >> On Tue, Mar 03, 2026 at 05:50:34PM -0800, SeongJae Park wrote:
>> > >> > On Tue, 3 Mar 2026 14:25:55 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:
>> > >> > 
>> > >> > > On Mon, Mar 02, 2026 at 02:37:43PM -0800, Andrew Morton wrote:
>> > >> > > > On Mon, 2 Mar 2026 15:10:03 +0100 "Vlastimil Babka (SUSE)" <vbabka@kernel.org> wrote:
>> > >> > > > 
>> > >> > > > > On 2/27/26 17:00, Dmitry Ilvokhin wrote:
>> > >> > > > > > This intentionally breaks direct users of zone->lock at compile time so
>> > >> > > > > > all call sites are converted to the zone lock wrappers. Without the
>> > >> > > > > > rename, present and future out-of-tree code could continue using
>> > >> > > > > > spin_lock(&zone->lock) and bypass the wrappers and tracing
>> > >> > > > > > infrastructure.
>> > >> > > > > > 
>> > >> > > > > > No functional change intended.
>> > >> > > > > > 
>> > >> > > > > > Suggested-by: Andrew Morton <akpm@linux-foundation.org>
>> > >> > > > > > Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
>> > >> > > > > > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
>> > >> > > > > > Acked-by: SeongJae Park <sj@kernel.org>
>> > >> > > > > 
>> > >> > > > > I see some more instances of 'zone->lock' in comments in
>> > >> > > > > include/linux/mmzone.h and under Documentation/ but otherwise LGTM.
>> > >> > > > > 
>> > >> > > > 
>> > >> > > > I fixed (most of) that in the previous version but my fix was lost.
>> > >> > > 
>> > >> > > Thanks for the fixups, Andrew.
>> > >> > > 
>> > >> > > I still see a few 'zone->lock' references in Documentation remain on
>> > >> > > mm-new. This patch cleans them up, as noted by Vlastimil.
>> > >> > > 
>> > >> > > I'm happy to adjust this patch if anything else needs attention.
>> > >> > > 
>> > >> > > From 9142d5a8b60038fa424a6033253960682e5a51f4 Mon Sep 17 00:00:00 2001
>> > >> > > From: Dmitry Ilvokhin <d@ilvokhin.com>
>> > >> > > Date: Tue, 3 Mar 2026 06:13:13 -0800
>> > >> > > Subject: [PATCH] mm: fix remaining zone->lock references
>> > >> > > 
>> > >> > > Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
>> > >> > > ---
>> > >> > >  Documentation/mm/physical_memory.rst | 4 ++--
>> > >> > >  Documentation/trace/events-kmem.rst  | 8 ++++----
>> > >> > >  2 files changed, 6 insertions(+), 6 deletions(-)
>> > >> > > 
>> > >> > > diff --git a/Documentation/mm/physical_memory.rst b/Documentation/mm/physical_memory.rst
>> > >> > > index b76183545e5b..e344f93515b6 100644
>> > >> > > --- a/Documentation/mm/physical_memory.rst
>> > >> > > +++ b/Documentation/mm/physical_memory.rst
>> > >> > > @@ -500,11 +500,11 @@ General
>> > >> > >  ``nr_isolate_pageblock``
>> > >> > >    Number of isolated pageblocks. It is used to solve incorrect freepage counting
>> > >> > >    problem due to racy retrieving migratetype of pageblock. Protected by
>> > >> > > -  ``zone->lock``. Defined only when ``CONFIG_MEMORY_ISOLATION`` is enabled.
>> > >> > > +  ``zone_lock``. Defined only when ``CONFIG_MEMORY_ISOLATION`` is enabled.
>> > >> > 
>> > >> > Dmitry's original patch [1] was doing 's/zone->lock/zone->_lock/', which aligns
>> > >> > to my expectation.  But this patch is doing 's/zone->lock/zone_lock/'.  Same
>> > >> > for the rest of this patch.
>> > >> > 
>> > >> > I was initially thinking this is just a mistake, but I also found Andrew is
>> > >> > doing same change [2], so I'm bit confused.  Is this an intentional change?
>> > >> > 
>> > >> > [1] https://lore.kernel.org/d61500c5784c64e971f4d328c57639303c475f81.1772206930.git.d@ilvokhin.com
>> > >> > [2] https://lore.kernel.org/20260302143743.220eed4feb36d7572fe726cc@linux-foundation.org
>> > >> > 
>> > >> 
>> > >> Good catch, thanks for pointing this out, SJ.
>> > >> 
>> > >> Originally the mechanical rename was indeed zone->lock -> zone->_lock.
>> > >> However, in Documentation I intentionally switched references to
>> > >> zone_lock instead of zone->_lock. The reasoning is that _lock is now an
>> > >> internal implementation detail, and direct access is discouraged. The
>> > >> intended interface is via the zone_lock_*() / zone_unlock_*() wrappers,
>> > >> so referencing zone_lock in documentation felt more appropriate than
>> > >> mentioning the private struct field (zone->_lock).
>> > > 
>> > > Thank you for this nice and kind clarification, Dmitry!  I agree mentioning
>> > > zone_[un]lock_*() helpers instead of the hidden member (zone->_lock) can be
>> > > better.
>> > > 
>> > > But, I'm concerned if people like me might not aware the intention under
>> > > 'zone_lock'.  If there is a well-known convention that allows people to know it
>> > > is for 'zone_[un]lock_*()' helpers, making it more clear would be nice, in my
>> > > humble opinion.  If there is such a convention but I'm just missing it, please
>> > > ignore.  If I'm not, for eaxmaple,
>> > > 
>> > > "protected by ``zone->lock``" could be re-wrote to
>> > > "protected by ``zone_[un]lock_*()`` locking helpers" or,
>> > > "protected by zone lock helper functions (``zone_[un]lock_*()``)" ?
>> > > 
>> > >> 
>> > >> That said, I agree this creates inconsistency with the mechanical
>> > >> rename, and I'm happy to adjust either way: either consistently refer
>> > >> to the wrapper API, or keep documentation aligned with zone->_lock.
>> > >> 
>> > >> I slightly prefer referring to the wrapper API, but don't have a strong
>> > >> preference as long as we're consistent.
>> > > 
>> > > I also think both approaches are good.  But for the wrapper approach, I think
>> > > giving more contexts rather than just ``zone_lock`` to readers would be nice.
>> > 
>> > Grep tells me that we also have comments mentioning simply "zone lock", btw.
>> > And it's also a term used often in informal conversations. Maybe we could
>> > just standardize on that in comments/documentations as it's easier to read.
>> > Discovering that the field is called _lock and that wrappers should be used,
>> > is hopefully not that difficult.
>> 
>> Thanks for the suggestion, Vlastimil. That sounds reasonable to me as
>> well. I'll update the comments and documentation to consistently use
>> "zone lock".
> 
> Following the suggestion from SJ and Vlastimil, I prepared fixup to
> standardize documentation and comments on the term "zone lock".
> 
> The patch is based on top of the current mm-new.
> 
> Andrew, please let me know if you would prefer a respin of the series
> instead.
> 
> From 267cda3e0e160f97b346009bc48819bfeed92e52 Mon Sep 17 00:00:00 2001
> From: Dmitry Ilvokhin <d@ilvokhin.com>
> Date: Thu, 5 Mar 2026 10:36:17 -0800
> Subject: [PATCH] mm: documentation: standardize on "zone lock" terminology
> 
> During review of the zone lock tracing series it was suggested to
> standardize documentation and comments on the term "zone lock"
> instead of using zone_lock or referring to the internal field
> zone->_lock.
> 
> Update references accordingly.
> 
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Thanks!


