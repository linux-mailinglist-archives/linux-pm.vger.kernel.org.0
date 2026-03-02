Return-Path: <linux-pm+bounces-43457-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2C37CCwapmnIKQAAu9opvQ
	(envelope-from <linux-pm+bounces-43457-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 00:15:56 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 726D21E6757
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 00:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1C01328D276
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 22:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642DC282F26;
	Mon,  2 Mar 2026 22:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="yBQXxcwP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090902E2DF3;
	Mon,  2 Mar 2026 22:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772491066; cv=none; b=BRwcBNiJ6NAC2+5g0HmY0iVAvNZ6NUKBwRoI9Aah3Ji3K3q4sTFyUzd7Map6/C5I5oXKo8QrtGOB05dJrt+mfHZw9IZ7A/eQ2UBzOv65MHAhx4v8KZXvt8cThS3KbGE2TZhxC+Ba5iVsekYbDBOSJRiXv1Q23s+qdAdqi4HXsZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772491066; c=relaxed/simple;
	bh=J2fvo+KSGZvC6JZi3Fa6EZ+t0vgBEn0ictN2fEgWIcU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=P3ukbVKjuk/Jmkad/43g6aT9Gm/JVWIf79FB5U/dJWlJgS7vg2ehX5WaGnj+65GolNE8MFFqOOXmj7taftXyZ+5nSx/GpwNC6bPXmNhkxSiY1OdlBVvmIa1oYaxBb+hBk6+3iB/jlB/00OdCoQ7yqUfgX3d6oRQr7H5n0XVy68Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=yBQXxcwP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B69DC19423;
	Mon,  2 Mar 2026 22:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1772491065;
	bh=J2fvo+KSGZvC6JZi3Fa6EZ+t0vgBEn0ictN2fEgWIcU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=yBQXxcwP9mbl6ewa3zuQ7K4FL6E89jF1hXOOl0UxVT7zm9U4qr5CRzNo3mZRzswbj
	 yFvT9BHNGoT3b7cGE0DsOEcNs/3YzNes9NLszNK31ww6yKE3FQ3EwkyaLa+mMdvC0z
	 Cl0G0MPesho2q6c7fgIFwUb9qBCx5RknJTdxab9g=
Date: Mon, 2 Mar 2026 14:37:43 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Dmitry Ilvokhin <d@ilvokhin.com>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie
 <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown
 <lenb@kernel.org>, Brendan Jackman <jackmanb@google.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Oscar Salvador
 <osalvador@suse.de>, Qi Zheng <zhengqi.arch@bytedance.com>, Shakeel Butt
 <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 "linux-cxl@vger.kernel.orgkernel-team"@meta.com, SeongJae Park
 <sj@kernel.org>
Subject: Re: [PATCH v4 4/5] mm: rename zone->lock to zone->_lock
Message-Id: <20260302143743.220eed4feb36d7572fe726cc@linux-foundation.org>
In-Reply-To: <0f340324-502b-4719-b3e7-c7ccd4378385@kernel.org>
References: <cover.1772206930.git.d@ilvokhin.com>
	<d61500c5784c64e971f4d328c57639303c475f81.1772206930.git.d@ilvokhin.com>
	<0f340324-502b-4719-b3e7-c7ccd4378385@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 726D21E6757
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43457-lists,linux-pm=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,ilvokhin.com:email]
X-Rspamd-Action: no action

On Mon, 2 Mar 2026 15:10:03 +0100 "Vlastimil Babka (SUSE)" <vbabka@kernel.org> wrote:

> On 2/27/26 17:00, Dmitry Ilvokhin wrote:
> > This intentionally breaks direct users of zone->lock at compile time so
> > all call sites are converted to the zone lock wrappers. Without the
> > rename, present and future out-of-tree code could continue using
> > spin_lock(&zone->lock) and bypass the wrappers and tracing
> > infrastructure.
> > 
> > No functional change intended.
> > 
> > Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> > Acked-by: SeongJae Park <sj@kernel.org>
> 
> I see some more instances of 'zone->lock' in comments in
> include/linux/mmzone.h and under Documentation/ but otherwise LGTM.
> 

I fixed (most of) that in the previous version but my fix was lost.


 include/linux/mmzone.h |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/include/linux/mmzone.h~mm-rename-zone-lock-to-zone-_lock-fix
+++ a/include/linux/mmzone.h
@@ -1037,12 +1037,12 @@ struct zone {
 	 * Locking rules:
 	 *
 	 * zone_start_pfn and spanned_pages are protected by span_seqlock.
-	 * It is a seqlock because it has to be read outside of zone->lock,
+	 * It is a seqlock because it has to be read outside of zone_lock,
 	 * and it is done in the main allocator path.  But, it is written
 	 * quite infrequently.
 	 *
-	 * The span_seq lock is declared along with zone->lock because it is
-	 * frequently read in proximity to zone->lock.  It's good to
+	 * The span_seq lock is declared along with zone_lock because it is
+	 * frequently read in proximity to zone_lock.  It's good to
 	 * give them a chance of being in the same cacheline.
 	 *
 	 * Write access to present_pages at runtime should be protected by
@@ -1065,7 +1065,7 @@ struct zone {
 	/*
 	 * Number of isolated pageblock. It is used to solve incorrect
 	 * freepage counting problem due to racy retrieving migratetype
-	 * of pageblock. Protected by zone->lock.
+	 * of pageblock. Protected by zone_lock.
 	 */
 	unsigned long		nr_isolate_pageblock;
 #endif
@@ -1502,7 +1502,7 @@ typedef struct pglist_data {
 	 * manipulate node_size_lock without checking for CONFIG_MEMORY_HOTPLUG
 	 * or CONFIG_DEFERRED_STRUCT_PAGE_INIT.
 	 *
-	 * Nests above zone->lock and zone->span_seqlock
+	 * Nests above zone_lock and zone->span_seqlock
 	 */
 	spinlock_t node_size_lock;
 #endif
_


