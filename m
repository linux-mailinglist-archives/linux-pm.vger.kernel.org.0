Return-Path: <linux-pm+bounces-43536-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG5tIgaQp2lKiQAAu9opvQ
	(envelope-from <linux-pm+bounces-43536-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 02:51:02 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6BE1F9AF4
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 02:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3236301B161
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 01:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3E03168EB;
	Wed,  4 Mar 2026 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMf6wHgU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7661D18A6DB;
	Wed,  4 Mar 2026 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772589040; cv=none; b=KajSGo4FXYLHKDB3GMvzezQ/K5Ynb7ShcnS5EmmRUT5OeHncqr0KUnZ2xj9P3BckgM+232R0C/K9ok4a+YZtCAb2UTVlMV0eRqCGLlx7jfY3XwlkBCRkUuFBEqqX9prZtvYbxGvGUhoJRsZgXmngLTHfkXJCaYdoZutXjuUV0AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772589040; c=relaxed/simple;
	bh=O1q5xmxh+8ddRQkx9dw/RmwoUPF0G+lCo8Vxz/LWoc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQssc2fJCeln9JtBEMhNELxgdwngkEfDeor5T2Yhhq8Zfu1Gqb3hB2UFZSgh3X/ej+vXeacZVvWvHoxK3EFvYjSBsWYqxdwsvZ8G2fMqnANOLubDhBWzik6atZGUHPkzcmYSlcLDwDnJkAfLpa9C7+tHxu8ZerpJIjGhM0dLpGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMf6wHgU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0B3C116C6;
	Wed,  4 Mar 2026 01:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772589040;
	bh=O1q5xmxh+8ddRQkx9dw/RmwoUPF0G+lCo8Vxz/LWoc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NMf6wHgUjBtsficAhTrZpbDymeP1qrJm9gVBDymeA284t3/4xD/IUN4lsK8wjWy+0
	 bt6Y0geh7b6+ibfslggbZaS+3PjKY4n9O7gpimLq9/ZpKkd7YK3id1SyXOZg5ouJUt
	 uCo3eHNYq8lUU8smojeLkxDQFMVVIdERceZ9EsdlPydbI7Q2l/lMKn1kZcAQzyoIqC
	 8kACgcsK3/8fyojRSMUBnfjlAfY7nOBxBH6s2TEmHbq7UnjMV4sa0IGNnhhOzVEle5
	 lbqA+w5yQeiS1As+ECWzKZrk9mNG9pC+HMt4/sVmhuZobunJ7mNsMpM5MZ/oCu3HN9
	 3+17MGIcWJ4hA==
From: SeongJae Park <sj@kernel.org>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 4/5] mm: rename zone->lock to zone->_lock
Date: Tue,  3 Mar 2026 17:50:34 -0800
Message-ID: <20260304015035.84839-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aabvc4Xhc9qBfaG7@shell.ilvokhin.com>
References: 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4A6BE1F9AF4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43536-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

On Tue, 3 Mar 2026 14:25:55 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:

> On Mon, Mar 02, 2026 at 02:37:43PM -0800, Andrew Morton wrote:
> > On Mon, 2 Mar 2026 15:10:03 +0100 "Vlastimil Babka (SUSE)" <vbabka@kernel.org> wrote:
> > 
> > > On 2/27/26 17:00, Dmitry Ilvokhin wrote:
> > > > This intentionally breaks direct users of zone->lock at compile time so
> > > > all call sites are converted to the zone lock wrappers. Without the
> > > > rename, present and future out-of-tree code could continue using
> > > > spin_lock(&zone->lock) and bypass the wrappers and tracing
> > > > infrastructure.
> > > > 
> > > > No functional change intended.
> > > > 
> > > > Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> > > > Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> > > > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > > Acked-by: SeongJae Park <sj@kernel.org>
> > > 
> > > I see some more instances of 'zone->lock' in comments in
> > > include/linux/mmzone.h and under Documentation/ but otherwise LGTM.
> > > 
> > 
> > I fixed (most of) that in the previous version but my fix was lost.
> 
> Thanks for the fixups, Andrew.
> 
> I still see a few 'zone->lock' references in Documentation remain on
> mm-new. This patch cleans them up, as noted by Vlastimil.
> 
> I'm happy to adjust this patch if anything else needs attention.
> 
> From 9142d5a8b60038fa424a6033253960682e5a51f4 Mon Sep 17 00:00:00 2001
> From: Dmitry Ilvokhin <d@ilvokhin.com>
> Date: Tue, 3 Mar 2026 06:13:13 -0800
> Subject: [PATCH] mm: fix remaining zone->lock references
> 
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> ---
>  Documentation/mm/physical_memory.rst | 4 ++--
>  Documentation/trace/events-kmem.rst  | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/mm/physical_memory.rst b/Documentation/mm/physical_memory.rst
> index b76183545e5b..e344f93515b6 100644
> --- a/Documentation/mm/physical_memory.rst
> +++ b/Documentation/mm/physical_memory.rst
> @@ -500,11 +500,11 @@ General
>  ``nr_isolate_pageblock``
>    Number of isolated pageblocks. It is used to solve incorrect freepage counting
>    problem due to racy retrieving migratetype of pageblock. Protected by
> -  ``zone->lock``. Defined only when ``CONFIG_MEMORY_ISOLATION`` is enabled.
> +  ``zone_lock``. Defined only when ``CONFIG_MEMORY_ISOLATION`` is enabled.

Dmitry's original patch [1] was doing 's/zone->lock/zone->_lock/', which aligns
to my expectation.  But this patch is doing 's/zone->lock/zone_lock/'.  Same
for the rest of this patch.

I was initially thinking this is just a mistake, but I also found Andrew is
doing same change [2], so I'm bit confused.  Is this an intentional change?

[1] https://lore.kernel.org/d61500c5784c64e971f4d328c57639303c475f81.1772206930.git.d@ilvokhin.com
[2] https://lore.kernel.org/20260302143743.220eed4feb36d7572fe726cc@linux-foundation.org


Thanks,
SJ

[...]

