Return-Path: <linux-pm+bounces-43349-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDQpB6f1oWkwxgQAu9opvQ
	(envelope-from <linux-pm+bounces-43349-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 20:51:03 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECF71BD191
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 20:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08B1D301982B
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 19:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D3946AEE8;
	Fri, 27 Feb 2026 19:46:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5EF345CC2;
	Fri, 27 Feb 2026 19:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772221595; cv=none; b=bTLW6KRVchUb/owENI508ZzDSNixTVm8nVrBE+tGQwsI6xwlloJRKqG9EXHVGNAkB3GdDrE01p16eLn+9Fc8SDQhjP0BrA2WvI9yOr1yeS5y37DTVTdNrY7YmaeaFfbaiCUemNQSEODQQHPWTyzOrbKgr0YFci8uaSp2GGPQaaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772221595; c=relaxed/simple;
	bh=1mW6fCCYax2pZUF4fOui+HvcEWd5EgKWpV9o0G1W9MU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I2cSFMrn4C/1KGk2DDSc5RAmxDvVcIDVmv4usrSxTh5ZGGzKXcfkE+MV+fy8ajNGViloG4Kj/N0QtX2rPkWxTAweYz31iTBCMtD0TJh6UCQn/bsupNYlwbofBwQrlh8rVuP5WOe5eTAaYP5bLeufxvt/zzZ7PAPXCTL46Nuit2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id A64C8C2DB3;
	Fri, 27 Feb 2026 19:46:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 73BB720016;
	Fri, 27 Feb 2026 19:46:24 +0000 (UTC)
Date: Fri, 27 Feb 2026 14:46:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
 <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Axel Rasmussen <axelrasmussen@google.com>, Yuanchu
 Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Oscar
 Salvador <osalvador@suse.de>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, "linux-cxl@vger.kernel.orgkernel-team"@meta.com
Subject: Re: [PATCH v4 5/5] mm: add tracepoints for zone lock
Message-ID: <20260227144649.3dbff742@gandalf.local.home>
In-Reply-To: <ae145fe890f028409f727b4921904b547346fa0b.1772206930.git.d@ilvokhin.com>
References: <cover.1772206930.git.d@ilvokhin.com>
	<ae145fe890f028409f727b4921904b547346fa0b.1772206930.git.d@ilvokhin.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 75z95ye3rzrmfdo81wu9y48dgd3xrfx4
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/tqfZb3BP+WqZirC6uLCguAOnl9bJ5e/E=
X-HE-Tag: 1772221584-850844
X-HE-Meta: U2FsdGVkX1+Ubmu8sp2dODz5b7SCRkSYEMDCN5v+Sc8RVUFnTWMyKXGqiKeiHhzkb2b1Dt/LC4TG2ySWIbTgjCHFE48LoFDsaEiICe/p8YN2/aPzcJqnY4OY5teYzActk2juaAd+qIppoE/NFDJjLbtNhjOKa04i3NUWuE7O7t9k7DBa3wPcVD/96J/S3S56BDlMtAEH2ZhsHViBS0zvjZ2m5MGhBwQ/3htcYvpQ5Camj+HNfnlj7k03cLgqGqiR5pfViHhEEPD4H0s2EEStIofDRZ+V41gzV4ABYYm5Qzx6r4lMEZFm+F36k0XQZ2gkUYizcUfjlEX3hLaZVHTupY1zOu+4rwAQlFtkxnG72c+Z0v97kHyhCGdUcY3IPgqS
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[goodmis.org : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@goodmis.org,linux-pm@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43349-lists,linux-pm=lfdr.de];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ilvokhin.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gandalf.local.home:mid]
X-Rspamd-Queue-Id: 9ECF71BD191
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 16:00:27 +0000
Dmitry Ilvokhin <d@ilvokhin.com> wrote:

>  static inline void zone_lock_init(struct zone *zone)
>  {
> @@ -12,26 +59,41 @@ static inline void zone_lock_init(struct zone *zone)
>  
>  #define zone_lock_irqsave(zone, flags)				\
>  do {								\
> +	bool success = true;					\
> +								\
> +	__zone_lock_trace_start_locking(zone);			\
>  	spin_lock_irqsave(&(zone)->_lock, flags);		\
> +	__zone_lock_trace_acquire_returned(zone, success);	\

Why the "success" variable and not just:

	__zone_lock_trace_acquire_returned(zone, true);

 ?


>  } while (0)
>  
>  #define zone_trylock_irqsave(zone, flags)			\
>  ({								\
> -	spin_trylock_irqsave(&(zone)->_lock, flags);		\
> +	bool success;						\
> +								\
> +	__zone_lock_trace_start_locking(zone);			\
> +	success = spin_trylock_irqsave(&(zone)->_lock, flags);	\
> +	__zone_lock_trace_acquire_returned(zone, success);	\
> +	success;						\
>  })
>  
>  static inline void zone_unlock_irqrestore(struct zone *zone, unsigned long flags)
>  {
> +	__zone_lock_trace_released(zone);
>  	spin_unlock_irqrestore(&zone->_lock, flags);
>  }
>  
>  static inline void zone_lock_irq(struct zone *zone)
>  {
> +	bool success = true;
> +
> +	__zone_lock_trace_start_locking(zone);
>  	spin_lock_irq(&zone->_lock);
> +	__zone_lock_trace_acquire_returned(zone, success);

Same here.

>  }
>  
>  static inline void zone_unlock_irq(struct zone *zone)
>  {
> +	__zone_lock_trace_released(zone);
>  	spin_unlock_irq(&zone->_lock);
>  }
>

-- Steve


