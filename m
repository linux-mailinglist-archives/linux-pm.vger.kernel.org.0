Return-Path: <linux-pm+bounces-43422-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBCmMhCapWnxEgYAu9opvQ
	(envelope-from <linux-pm+bounces-43422-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 15:09:20 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE961DA66B
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 15:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A993330C6922
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 14:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F413FB05E;
	Mon,  2 Mar 2026 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3sPEAkp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FD03E0C74;
	Mon,  2 Mar 2026 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460165; cv=none; b=OrF0z/yOswTVWV2zv46ez2XbpE0Ji0gMdV5GwkmYZBFyr43ygMVmnX5gvTkYyEuQxbuFdDbSmoHAGD4RBBP1Aky2nxcyQWlkk8RhIb9onMZygWBYi1sqIFM2dZ5Zea1AhFCHEgnMUhva1D0Xc4wOI3mzM/hVVVzyv9NPcW6LTmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460165; c=relaxed/simple;
	bh=sziW4pOUkxTp9O8LXGHmN/0KGKu2HZcxR9I6yaCXqP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=od7oUS0nqsuC/2nAT+T5mQkZnhEpAnQGJbdmWjDJBZ7CiIBxyPmq+e8sutmcX7qSdBnRbf/r8+H8I5HEk9K8Fnj89NmJEZr6JpnaXm17TnVkNLrDXsFg4FMgQPCim6BpXpW1MQhYy39ZN2ffksoAYoingsR5K9QoJVKiUTkm1ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3sPEAkp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4835AC19423;
	Mon,  2 Mar 2026 14:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772460165;
	bh=sziW4pOUkxTp9O8LXGHmN/0KGKu2HZcxR9I6yaCXqP0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J3sPEAkp7ZXe2WdNJfY0wlkY+4gPNTR4C2pJ1PdyTfXB4N+0vvY4E583r8pFrOTd6
	 2fcEoG7epPt1Jr32IIY9UlFEt7QtPxpW0ADSrLZZVXVqE2Ac1Lej86lq9gfkrIj4kZ
	 ojjYIPYUX2o0kCs2MEfhBq1HIe5aI3LgGR+rUTtyNvdskd/j2xtKi40ILxobWdcnKx
	 VpORqxQ4YXNmiVwZqzkAOAhoMvtb72XzRfk+IYI88iHnEqU8HbTl3V7WBWSfuC/DKx
	 PqLL2ESytNeNAe9u0Y52x+9ZxNdqX4L94I6LC+SFQGc0T8ntIHIrBa6E5Sj+Om5xLd
	 t4iYJo49n6tFg==
Message-ID: <7cacd42c-642d-421a-9180-ecf044eda00e@kernel.org>
Date: Mon, 2 Mar 2026 15:02:38 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] mm: convert compaction to zone lock wrappers
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
 <3a09e46f52cf9f709b0725bc2b648cc5212843b2.1772206930.git.d@ilvokhin.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <3a09e46f52cf9f709b0725bc2b648cc5212843b2.1772206930.git.d@ilvokhin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
	TAGGED_FROM(0.00)[bounces-43422-lists,linux-pm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ilvokhin.com:email]
X-Rspamd-Queue-Id: 3EE961DA66B
X-Rspamd-Action: no action

On 2/27/26 17:00, Dmitry Ilvokhin wrote:
> Compaction uses compact_lock_irqsave(), which currently operates
> on a raw spinlock_t pointer so it can be used for both zone->lock
> and lruvec->lru_lock. Since zone lock operations are now wrapped,
> compact_lock_irqsave() can no longer directly operate on a
> spinlock_t when the lock belongs to a zone.
> 
> Split the helper into compact_zone_lock_irqsave() and
> compact_lruvec_lock_irqsave(), duplicating the small amount of
> shared logic. As there are only two call sites and both statically
> know the lock type, this avoids introducing additional abstraction
> or runtime dispatch in the compaction path.
> 
> No functional change intended.
> 
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>


