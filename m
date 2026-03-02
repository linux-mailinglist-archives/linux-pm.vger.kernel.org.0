Return-Path: <linux-pm+bounces-43419-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WE0/ApCTpWnXEAYAu9opvQ
	(envelope-from <linux-pm+bounces-43419-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 14:41:36 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 712C71D9FB8
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 14:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B888F3090088
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 13:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB8E3CC9EC;
	Mon,  2 Mar 2026 13:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJzFxhlE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6912136C5A2;
	Mon,  2 Mar 2026 13:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458486; cv=none; b=C+DdRId+VvDkvIuph4XHUYtSHX+oJG11KTSlAjVaE+xH6zUcaH3vZn/GpwHVtsNTHfRpI0aaptOkJncLlDrLclDg3vqPef87xOrSdeQP9HylKWHo90Lo1omXWAg5GXFBL2UdcZG85B+1s1gMl4FND1tSnC6p2UFTcD1RYJEB+bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458486; c=relaxed/simple;
	bh=7f9Gcp4+1LkfzXFPCa7PcQqPFKqy4PcM0mCYaMby60g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E5m4ltsgQXCeRA3fZ+/QZg2Z0B8n+kqte4VEv4jYoR6XyZQH5qQYNC37PZ07uTBHxvQ0aEbgj89b/tiq92Okk7rj1+gzSOIDatlv7s7g1I+67KtsJskV0NrLN+Pg8JaZg17H5ZU5Ab9Jbgklo2nBKqeJ50uCISQbCRlSSgtwHGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJzFxhlE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85061C19423;
	Mon,  2 Mar 2026 13:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772458486;
	bh=7f9Gcp4+1LkfzXFPCa7PcQqPFKqy4PcM0mCYaMby60g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cJzFxhlE4FbWzbo5g/MSsO88667jBeaaySLaLoBd1bxFWGi77nyUK3rvGNE5eZ6FS
	 OvQoFyJcHhWifxV97kZV86n/hrxIAwuPOywLDum7x+i2buY4ipn0S/kYasF0ykquWo
	 MqP4Pt7NdGDVxT7awVmTEDXGPnTxD3fJ92vd2DIk/1t0qCZniFUQYMFmzuYvTb2xB1
	 uk5T6zUHG6+PXx6wYCCtaXWGxbqfIdwEcbqt2MsLYkNE63m6ccC2X3Y58rxrEegEUA
	 z5mqdciGCt7Ldwv/T7JBKY/c2pYkt1omagB+CrCX3Nr6XSO0kWDu0k976LiWpBDgVJ
	 6gmvj29jmeaKg==
Message-ID: <303e86f9-f86c-4dc9-bfc8-d32c8eeb91b3@kernel.org>
Date: Mon, 2 Mar 2026 14:34:38 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] mm: introduce zone lock wrappers
Content-Language: en-US
To: Dmitry Ilvokhin <d@ilvokhin.com>,
 Andrew Morton <akpm@linux-foundation.org>,
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
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 "linux-cxl@vger.kernel.orgkernel-team"@meta.com
References: <cover.1772206930.git.d@ilvokhin.com>
 <849dee9c47df1e6fba97c9933af0d5a08b8e15d3.1772206930.git.d@ilvokhin.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <849dee9c47df1e6fba97c9933af0d5a08b8e15d3.1772206930.git.d@ilvokhin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43419-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,ilvokhin.com:email]
X-Rspamd-Queue-Id: 712C71D9FB8
X-Rspamd-Action: no action

On 2/27/26 17:00, Dmitry Ilvokhin wrote:
> Add thin wrappers around zone lock acquire/release operations. This
> prepares the code for future tracepoint instrumentation without
> modifying individual call sites.
> 
> Centralizing zone lock operations behind wrappers allows future
> instrumentation or debugging hooks to be added without touching
> all users.
> 
> No functional change intended. The wrappers are introduced in
> preparation for subsequent patches and are not yet used.
> 
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

*checks patch 2 diffstat*

I think we could do it as mm/zone_lock.h even and not pollute include/linux/
Even kernel/power/snapshot.c could include it in a somewhat ugly way.
However we should also later look at moving that particular code somewhere
under mm/ really...

Anyway,

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
>  MAINTAINERS                 |  1 +
>  include/linux/mmzone_lock.h | 38 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
>  create mode 100644 include/linux/mmzone_lock.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 55af015174a5..947298ecb111 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16672,6 +16672,7 @@ F:	include/linux/memory.h
>  F:	include/linux/mm.h
>  F:	include/linux/mm_*.h
>  F:	include/linux/mmzone.h
> +F:	include/linux/mmzone_lock.h
>  F:	include/linux/mmdebug.h
>  F:	include/linux/mmu_notifier.h
>  F:	include/linux/pagewalk.h
> diff --git a/include/linux/mmzone_lock.h b/include/linux/mmzone_lock.h
> new file mode 100644
> index 000000000000..a1cfba8408d6
> --- /dev/null
> +++ b/include/linux/mmzone_lock.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_MMZONE_LOCK_H
> +#define _LINUX_MMZONE_LOCK_H
> +
> +#include <linux/mmzone.h>
> +#include <linux/spinlock.h>
> +
> +static inline void zone_lock_init(struct zone *zone)
> +{
> +	spin_lock_init(&zone->lock);
> +}
> +
> +#define zone_lock_irqsave(zone, flags)				\
> +do {								\
> +	spin_lock_irqsave(&(zone)->lock, flags);		\
> +} while (0)
> +
> +#define zone_trylock_irqsave(zone, flags)			\
> +({								\
> +	spin_trylock_irqsave(&(zone)->lock, flags);		\
> +})
> +
> +static inline void zone_unlock_irqrestore(struct zone *zone, unsigned long flags)
> +{
> +	spin_unlock_irqrestore(&zone->lock, flags);
> +}
> +
> +static inline void zone_lock_irq(struct zone *zone)
> +{
> +	spin_lock_irq(&zone->lock);
> +}
> +
> +static inline void zone_unlock_irq(struct zone *zone)
> +{
> +	spin_unlock_irq(&zone->lock);
> +}
> +
> +#endif /* _LINUX_MMZONE_LOCK_H */


