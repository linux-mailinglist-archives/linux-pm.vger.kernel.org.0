Return-Path: <linux-pm+bounces-43365-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADPbI3kWo2mJ9gQAu9opvQ
	(envelope-from <linux-pm+bounces-43365-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 28 Feb 2026 17:23:21 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 284BC1C4446
	for <lists+linux-pm@lfdr.de>; Sat, 28 Feb 2026 17:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C8CF30692FF
	for <lists+linux-pm@lfdr.de>; Sat, 28 Feb 2026 16:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461632DC322;
	Sat, 28 Feb 2026 16:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7VuuA3T"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB101E8320;
	Sat, 28 Feb 2026 16:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772295793; cv=none; b=gqgY+Jgeg7FFQYoOWDNYUxJHl8pY3wRSF/3milmwla47vuEbkea/ypNe4KN3POC9LS3mEBOZR/Dg+ZhWF4WYytgQ76OyTAsVS+qAxj8Qx8904/UCiEy9qxIHAjCBcwwhsxoVtAV/OeBuSy7XhTaOfD4knJvlTTgmcvsXS7GNhQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772295793; c=relaxed/simple;
	bh=tDPe/nfeuLBd4fs1xZJUaluoGXlO/lbkdH6pyIPqL9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIvcmLkZ1KJ2xOggHZEIH6RcIaFAbSh0db/E0p+eVj7EZMeVUvyU64qugqeFMs2pcQC1UHff1UMIsCEDNiwwkfYeDVcPpl+TD2KxeyXB28Ckjr+MaMI4UCi2KbXYRyDV8BpP1o8SzHlJAp9HK/3bAJlvKCWolBiGy9JrbHctlVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7VuuA3T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6F2C116D0;
	Sat, 28 Feb 2026 16:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772295792;
	bh=tDPe/nfeuLBd4fs1xZJUaluoGXlO/lbkdH6pyIPqL9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z7VuuA3TXUQaqxvibVoBrjp222kjf9cHY1OT0LQPbIAK8IPIL8yEVzJVK54yIYJtE
	 Xk88erL+AsJdeWRBcO3BP3hpf0H/35Tv2/B3rJ33u2IlIXX8r2cLg/eHd/dJKc2K2v
	 RfrGZmuK1fm/LS6K7Vw3k1t6qfYJrmJ3n9jjjadv+5j/42W7+HnYOUFYz5xMdOz0qm
	 sFofpyyGK557/M0WW1SYF5iYRAREbxuaZjIHDnWpkg6WJfoYP2t9kX4bHH1RiSdD7m
	 e6WqMPWMiM+pQvL9FW7MLUh+WAb21vpQshcxFkteXPF1Rl/w4UypNAdW/ska6HjG5Y
	 sruRnfYQYsHiw==
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
	linux-pm@vger.kernel.org,
	"linux-cxl@vger.kernel.orgkernel-team"@meta.com
Subject: Re: [PATCH v4 1/5] mm: introduce zone lock wrappers
Date: Sat, 28 Feb 2026 08:23:08 -0800
Message-ID: <20260228162309.213482-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <849dee9c47df1e6fba97c9933af0d5a08b8e15d3.1772206930.git.d@ilvokhin.com>
References: 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MSBL_EBL_FAIL(0.00)[d@ilvokhin.com:query timed out];
	TAGGED_FROM(0.00)[bounces-43365-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_FAIL(0.00)[linux.dev:query timed out];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 284BC1C4446
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 16:00:23 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:

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

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

