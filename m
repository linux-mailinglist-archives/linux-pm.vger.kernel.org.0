Return-Path: <linux-pm+bounces-43793-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJQEBAGuqmluVQEAu9opvQ
	(envelope-from <linux-pm+bounces-43793-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:35:45 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 621DC21ED8C
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13B2C314AB3E
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 10:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C5737C10E;
	Fri,  6 Mar 2026 10:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LftkTYlB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="632EUAM7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LftkTYlB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="632EUAM7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4361E37B014
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 10:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772793052; cv=none; b=r9JRKbEY8S+c0jRJuR7njXqTmV/ukqK7nZ4KYdBzbJIyDhVzpWIcK9PIVPj1s5E1525serWGKLanXwVbWWiZosPEtEI9EV1Fz+uJ/+Lb//aUHG1X+jy1F+gFH84vrNnB+e85mo9ZWFBKQmes4S0l7iim0kQf9QGvwmHQs1HrKbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772793052; c=relaxed/simple;
	bh=QiSdDIOvoXERoUmCtI5O4kN9vMdE+uj5QAfoVBroZ5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWDjFeioglIrGgepfKbTZa0fZ2+f7H4ZMSyVBIaqV9aqdcpM9Py7kCIA/PwxwGKxYb00vT4HR9ObsNB6Lzyazw6y7uuff5ZAgRvO26tzgzJCGJJt8K/drxhV9ehT3YNZOiOejZpGEFb9Qrp1xzMtxZNnH/QUNFpjJNWj6F31UFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LftkTYlB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=632EUAM7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LftkTYlB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=632EUAM7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 875923FA7A;
	Fri,  6 Mar 2026 10:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772793042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vAQr6SkqV3zjssVR9rZd0gIGba+OVvVWyTtFYxHG1Tw=;
	b=LftkTYlB+zrmExZCM0xNBcZqm2VBg2WGKqZdbGMSrzXN1qHzs8jIT7z9P1neGQNTtOxaS3
	49tsqrFGpbUs1Bkcp3+4aYxaZ/oFlZbu8N5kZJVAVVOKRJIbNWHOmefLgDzGEG5KtChk+i
	udYkR76rHLSYTOgXKupZhCjazdHoYc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772793042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vAQr6SkqV3zjssVR9rZd0gIGba+OVvVWyTtFYxHG1Tw=;
	b=632EUAM7/SbLKijbGlqOzTmYmkiz+gXT9KFcaSSq/c1yD7DQL4ilODdzxNyo+UYamNPbrK
	aDxOVrBsk59Dp/Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LftkTYlB;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=632EUAM7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772793042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vAQr6SkqV3zjssVR9rZd0gIGba+OVvVWyTtFYxHG1Tw=;
	b=LftkTYlB+zrmExZCM0xNBcZqm2VBg2WGKqZdbGMSrzXN1qHzs8jIT7z9P1neGQNTtOxaS3
	49tsqrFGpbUs1Bkcp3+4aYxaZ/oFlZbu8N5kZJVAVVOKRJIbNWHOmefLgDzGEG5KtChk+i
	udYkR76rHLSYTOgXKupZhCjazdHoYc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772793042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vAQr6SkqV3zjssVR9rZd0gIGba+OVvVWyTtFYxHG1Tw=;
	b=632EUAM7/SbLKijbGlqOzTmYmkiz+gXT9KFcaSSq/c1yD7DQL4ilODdzxNyo+UYamNPbrK
	aDxOVrBsk59Dp/Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4A063EA75;
	Fri,  6 Mar 2026 10:30:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WNGxLNCsqmn+NQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 06 Mar 2026 10:30:40 +0000
Date: Fri, 6 Mar 2026 10:30:39 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Oscar Salvador <osalvador@suse.de>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-pm@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH v4 4/5] mm: rename zone->lock to zone->_lock
Message-ID: <nn6xirm5sa3mf63gcq5mlthk3nrrdig6zpv2mj4vqnsl27nsxe@2si2t2l6pgex>
References: <cover.1772206930.git.d@ilvokhin.com>
 <d61500c5784c64e971f4d328c57639303c475f81.1772206930.git.d@ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d61500c5784c64e971f4d328c57639303c475f81.1772206930.git.d@ilvokhin.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 621DC21ED8C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43793-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[29];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pfalcato@suse.de,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 04:00:26PM +0000, Dmitry Ilvokhin wrote:
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
> ---
>  include/linux/mmzone.h      |  7 +++++--
>  include/linux/mmzone_lock.h | 12 ++++++------
>  mm/compaction.c             |  4 ++--
>  mm/internal.h               |  2 +-
>  mm/page_alloc.c             | 16 ++++++++--------
>  mm/page_isolation.c         |  4 ++--
>  mm/page_owner.c             |  2 +-
>  7 files changed, 25 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 3e51190a55e4..32bca655fce5 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1009,8 +1009,11 @@ struct zone {
>  	/* zone flags, see below */
>  	unsigned long		flags;
>  
> -	/* Primarily protects free_area */
> -	spinlock_t		lock;
> +	/*
> +	 * Primarily protects free_area. Should be accessed via zone_lock_*
> +	 * helpers.
> +	 */
> +	spinlock_t		_lock;

I really don't like this uglification.
Suggestion:
	spinlock_t __private	lock;

>  
>  	/* Pages to be freed when next trylock succeeds */
>  	struct llist_head	trylock_free_pages;
> diff --git a/include/linux/mmzone_lock.h b/include/linux/mmzone_lock.h
> index a1cfba8408d6..62e34d500078 100644
> --- a/include/linux/mmzone_lock.h
> +++ b/include/linux/mmzone_lock.h
> @@ -7,32 +7,32 @@
>  
>  static inline void zone_lock_init(struct zone *zone)
>  {
> -	spin_lock_init(&zone->lock);

and then ACCESS_PRIVATE() all over these helpers. This will not make a
difference to the compiler, but it will work with sparse.

It's not that I don't understand what you're doing, but we're going to need
to look to this code and refer to this code 20 years from now, I would rather
not refer to zone->_lock :)

-- 
Pedro

