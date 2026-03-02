Return-Path: <linux-pm+bounces-43423-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPGIFKCbpWmfEwYAu9opvQ
	(envelope-from <linux-pm+bounces-43423-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 15:16:00 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C390E1DA825
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 15:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D2B3300F173
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 14:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551CF3FD12D;
	Mon,  2 Mar 2026 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XC26fhYW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311983F23DD;
	Mon,  2 Mar 2026 14:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460611; cv=none; b=WaZd8YxSV3CxiEuFevMvEDas1t48htME5te4AhOqe5Gnnwtx9MEjfuD00sSZfexMabVXUw2UFCBIENSHTLqxNcYNs7geoFFRX65+GcBBojc3Qylksl6dWmjLdm5u5wGXo7W+J43z6kIq9hCwM+acCKdTEOVtrvXhv9jT4HoB0ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460611; c=relaxed/simple;
	bh=Iw7aUP2S7mWahuhzCJO/BUcWFftOh4Nm7vHQ0zIqiJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NKEoAfS7JeDPjFYKwUOuAIC2I5FFRQ1SJiCSlXIN0yzW+C8TaWoBu/i1MjliKL7KfgIFX99ZmvjLBxj8CtrAwtaIsD+2vg805HDbWCrVVFF+L7+sorgtJr1RLlKnlPDL0HMSjo1NnlDnl+rXZKPWupcH3R7GKZh/etV+fnqc2NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XC26fhYW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2039AC2BC87;
	Mon,  2 Mar 2026 14:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772460610;
	bh=Iw7aUP2S7mWahuhzCJO/BUcWFftOh4Nm7vHQ0zIqiJY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XC26fhYWvpCZWb4IyVpvt4Oen+imcRPCYbXTeuSc1MLlCUVRgZc5v3AQ4m82UcGUX
	 /J8tyC2i62wPJE9f2KQeG9fs5nPTejtD+H/hMq3v7rst6nBeN1ODJCRZRR51tNy7Et
	 JA4yuGwd/7yzIxU3CFW5yUHMty4FxLR94ARGLlXdTSPM/bQlHoL5ZEPokxwStEWYFW
	 V7ebXMDn9zkqFfMb0FW2qZOtiDsDH+uin4ubx7X8NfFN4Y4Gh5IQEQFSpsZ1R6ACE2
	 N/xRfzgEZMD3s/djPCWs+RIbSAfQhxV/2Y4iOcJ+Zk9ZPFy7TgynrP/LmhqHoW7jqO
	 OnzfcZeYpd+3g==
Message-ID: <0f340324-502b-4719-b3e7-c7ccd4378385@kernel.org>
Date: Mon, 2 Mar 2026 15:10:03 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] mm: rename zone->lock to zone->_lock
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
 "linux-cxl@vger.kernel.orgkernel-team"@meta.com,
 SeongJae Park <sj@kernel.org>
References: <cover.1772206930.git.d@ilvokhin.com>
 <d61500c5784c64e971f4d328c57639303c475f81.1772206930.git.d@ilvokhin.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <d61500c5784c64e971f4d328c57639303c475f81.1772206930.git.d@ilvokhin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43423-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ilvokhin.com:email,linux-foundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: C390E1DA825
X-Rspamd-Action: no action

On 2/27/26 17:00, Dmitry Ilvokhin wrote:
> This intentionally breaks direct users of zone->lock at compile time so
> all call sites are converted to the zone lock wrappers. Without the
> rename, present and future out-of-tree code could continue using
> spin_lock(&zone->lock) and bypass the wrappers and tracing
> infrastructure.
> 
> No functional change intended.
> 
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: SeongJae Park <sj@kernel.org>

I see some more instances of 'zone->lock' in comments in
include/linux/mmzone.h and under Documentation/ but otherwise LGTM.

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>


