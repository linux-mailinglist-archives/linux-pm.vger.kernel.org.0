Return-Path: <linux-pm+bounces-42385-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGmcHrCZimk8MQAAu9opvQ
	(envelope-from <linux-pm+bounces-42385-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 03:36:32 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9C71165A8
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 03:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA130302B525
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 02:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEAA2DF3EA;
	Tue, 10 Feb 2026 02:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="XPEjMes8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976A72765C4
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 02:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770690987; cv=none; b=U46agRzSWJODs5upvPpUZFLeOTGZRPkE+nqQtmePi3Vgoe2eRn7WJYTcgh98bysL+XZu0Xe+X4qs7de7l4Nmof02EI4R/EQtQ2/pDARt35uJrhqu6KeDIvBrKezUdy+V6IXNNjIzetfMwxnmrEoadBm1XXWl0axJ3zZVUMUy2Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770690987; c=relaxed/simple;
	bh=x26zTWRCZztFplfzMY9lFckYK/i5zTHyU1H9HRMmxYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B91raP5NE2JMA28E6DzyGC8NFooWo/UkRQV5L6iPkyI/CXdNzWjiKjWebGKSkBBM/OLfpKRqDPMEzYoiLHGefluboxULLUvR2iWqcZWvOc1E6C+NUTvs6rS9vkIZh2OI9VjtAu5GA5yl+wQnuUT+/5pT3X9yox6FmxASouaQvoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=XPEjMes8; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8ca3807494eso28308985a.2
        for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 18:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1770690984; x=1771295784; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zjDQ6ZMUprUoxKPSBAzYwFLvE0UYKCpqmBg/Zxxlb4c=;
        b=XPEjMes8JmLyeg0/7lSTn+nuGzFQ6Esjp83z8vxDH8vRYKFL3+7NPe+KVskk89Tr++
         L/0PdiId1bsIODT6qYCEft0KOY5BxMPmL9lqUeRjfzoNBzbCeHalEOg6lmZt9ML/YDf8
         vlfcIzlRCW37hb8JNt6fPrPonFDOw+64RfX1egkCMB69QxDYmRZaB3ZCsqbOzWwpZJES
         XpxSnHK3WL6y0Sacx6p7IMgJVmYsIPLaYaEEO6FvhK5ogx15xb/7z7IO7xK7jf/M80jj
         oluLL4RH3KKr4tEPHDGMthYtBzAdWwKpqwZ0uMM8caqmAxB+Hnqz8ZtXiAKSnhQVJxWk
         b5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770690984; x=1771295784;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zjDQ6ZMUprUoxKPSBAzYwFLvE0UYKCpqmBg/Zxxlb4c=;
        b=mq+WdWS+7jG1gZwYfgaRvaMKUpZy4Jhd7K53CDrIq53awcZQlFds7uS9vNeK5EJpL4
         QcXImK5js3AfmQBwQYl5vWqd/+EfQsPh16Blda1eyYVTXe9GOPorm9UFGo50LIF4hx5A
         BW1gRTEXN2hTT1zzVcUelWnj/83znmWOcZPQZIwxumqQ6OzdvhtRDCzctcRHHhiuSMTo
         1kQHV37ArzVHF9JhjudnQ/ppXfP8bJpL5m3uqbiCt6pztBna1ROvQ77tFV1UDRsBPrn4
         5YQwvxkyFEXUJMwBqcI8RvmHNa/iddAiPSl4kWknDKiO0HC97bIBwfNN7iOUFGChQzS5
         KceA==
X-Forwarded-Encrypted: i=1; AJvYcCVWhvwsTXgyc/jADtMtHq36O09ZL1L0Vz2fAUZ4Vxy+nJL3YUYSzZq+bncob6w12nu0FhGK1ZSmAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+xIkCcz9+TVovrI+Jtt8wuIxfFdjnSv5mw7cpXo8DgNuNx2Kh
	IWtRHHLBGbmnv9OsFa2z2HK9cIQJ0Nk01+mG1phKeISwRvsw1khYSC2Hli7LC3OYTcs=
X-Gm-Gg: AZuq6aIWwIK1AMLbw26CFt33SnfIGmnF75E3XLtQq+3/e3CEHE8JQ3ffdrmqgXK1U0t
	kgUttYwDqsReyHZbazMc7ejbopFNyudogwUPki4EICadFPo368qt0bKi/hveif2DCCYrx9G1ims
	6t9iZvqcA6msqM9WLgP3HtJg4E8EOZ3pMTShJx2nGolIkrVufgCmU2kd1384EsmpnbPUZYyOdVJ
	Kvw1+4jxG2ZLYZwmyMBSArV8dRAloriZw+5h1eBf4tHuVDO5ep7clc51yHAMLupOEZm7YKoua4X
	JGJqwm56xvafDtKGaEnLbVJpMUxPWWVWgSL+zd/wvf74FbO0lD+junEB48DH9IKJDf0Lu0hyG1v
	U4PzDyj6gvfETOwlLZXaQxbTfAKfiRmJ/dvnUM+QaGmB+NTLybg3Cp+ZkvjJUDNVW5+ADENFMSe
	C7+ycRVihCNvxzY+6oaKBTW+d5xvdFfjY=
X-Received: by 2002:a05:620a:448c:b0:8c6:af59:5e1b with SMTP id af79cd13be357-8caf16ec082mr1704468885a.77.1770690984280;
        Mon, 09 Feb 2026 18:36:24 -0800 (PST)
Received: from localhost ([2603:7000:c00:100:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953c03fca0sm89843846d6.28.2026.02.09.18.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 18:36:23 -0800 (PST)
Date: Mon, 9 Feb 2026 21:36:22 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chris Li <chrisl@kernel.org>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
	hughd@google.com, yosry.ahmed@linux.dev, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, len.brown@intel.com,
	chengming.zhou@linux.dev, kasong@tencent.com,
	huang.ying.caritas@gmail.com, ryan.roberts@arm.com,
	shikemeng@huaweicloud.com, viro@zeniv.linux.org.uk,
	baohua@kernel.org, bhe@redhat.com, osalvador@suse.de,
	christophe.leroy@csgroup.eu, pavel@kernel.org, linux-mm@kvack.org,
	kernel-team@meta.com, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-pm@vger.kernel.org,
	peterx@redhat.com, riel@surriel.com, joshua.hahnjy@gmail.com,
	npache@redhat.com, gourry@gourry.net, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, rafael@kernel.org,
	jannh@google.com, pfalcato@suse.de, zhengqi.arch@bytedance.com
Subject: Re: [PATCH v3 00/20] Virtual Swap Space
Message-ID: <aYqZppn4yDbTP2_q@cmpxchg.org>
References: <20260208215839.87595-2-nphamcs@gmail.com>
 <20260208223143.366416-1-nphamcs@gmail.com>
 <CACePvbXsngZmn0OrJZjvMhhHnL5FazxYX7ShEpbU9RwHSJaUuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACePvbXsngZmn0OrJZjvMhhHnL5FazxYX7ShEpbU9RwHSJaUuA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42385-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[38];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,google.com,linux.dev,kernel.org,intel.com,tencent.com,arm.com,huaweicloud.com,zeniv.linux.org.uk,redhat.com,suse.de,csgroup.eu,kvack.org,meta.com,vger.kernel.org,surriel.com,gourry.net,bytedance.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cmpxchg.org:mid,cmpxchg.org:dkim]
X-Rspamd-Queue-Id: EE9C71165A8
X-Rspamd-Action: no action

Hi Chris,

On Mon, Feb 09, 2026 at 04:20:21AM -0800, Chris Li wrote:
> On Sun, Feb 8, 2026 at 4:15 PM Nhat Pham <nphamcs@gmail.com> wrote:
> >
> > My sincerest apologies - it seems like the cover letter (and just the
> > cover letter) fails to be sent out, for some reason. I'm trying to figure
> > out what happened - it works when I send the entire patch series to
> > myself...
> >
> > Anyway, resending this (in-reply-to patch 1 of the series):
> 
> For the record I did receive your original V3 cover letter from the
> linux-mm mailing list.
> 
> > Changelog:
> > * RFC v2 -> v3:
> >     * Implement a cluster-based allocation algorithm for virtual swap
> >       slots, inspired by Kairui Song and Chris Li's implementation, as
> >       well as Johannes Weiner's suggestions. This eliminates the lock
> >           contention issues on the virtual swap layer.
> >     * Re-use swap table for the reverse mapping.
> >     * Remove CONFIG_VIRTUAL_SWAP.
> >     * Reducing the size of the swap descriptor from 48 bytes to 24
> 
> Is the per swap slot entry overhead 24 bytes in your implementation?
> The current swap overhead is 3 static +8 dynamic, your 24 dynamic is a
> big jump. You can argue that 8->24 is not a big jump . But it is an
> unnecessary price compared to the alternatives, which is 8 dynamic +
> 4(optional redirect).

No, this is not the net overhead.

The descriptor consolidates and eliminates several other data
structures.

Here is the more detailed breakdown:

> > The size of the virtual swap descriptor is 24 bytes. Note that this is
> > not all "new" overhead, as the swap descriptor will replace:
> > * the swap_cgroup arrays (one per swap type) in the old design, which
> >   is a massive source of static memory overhead. With the new design,
> >   it is only allocated for used clusters.
> > * the swap tables, which holds the swap cache and workingset shadows.
> > * the zeromap bitmap, which is a bitmap of physical swap slots to
> >   indicate whether the swapped out page is zero-filled or not.
> > * huge chunk of the swap_map. The swap_map is now replaced by 2 bitmaps,
> >   one for allocated slots, and one for bad slots, representing 3 possible
> >   states of a slot on the swapfile: allocated, free, and bad.
> > * the zswap tree.
> >
> > So, in terms of additional memory overhead:
> > * For zswap entries, the added memory overhead is rather minimal. The
> >   new indirection pointer neatly replaces the existing zswap tree.
> >   We really only incur less than one word of overhead for swap count
> >   blow up (since we no longer use swap continuation) and the swap type.
> > * For physical swap entries, the new design will impose fewer than 3 words
> >   memory overhead. However, as noted above this overhead is only for
> >   actively used swap entries, whereas in the current design the overhead is
> >   static (including the swap cgroup array for example).
> >
> >   The primary victim of this overhead will be zram users. However, as
> >   zswap now no longer takes up disk space, zram users can consider
> >   switching to zswap (which, as a bonus, has a lot of useful features
> >   out of the box, such as cgroup tracking, dynamic zswap pool sizing,
> >   LRU-ordering writeback, etc.).
> >
> > For a more concrete example, suppose we have a 32 GB swapfile (i.e.
> > 8,388,608 swap entries), and we use zswap.
> >
> > 0% usage, or 0 entries: 0.00 MB
> > * Old design total overhead: 25.00 MB
> > * Vswap total overhead: 0.00 MB
> >
> > 25% usage, or 2,097,152 entries:
> > * Old design total overhead: 57.00 MB
> > * Vswap total overhead: 48.25 MB
> >
> > 50% usage, or 4,194,304 entries:
> > * Old design total overhead: 89.00 MB
> > * Vswap total overhead: 96.50 MB
> >
> > 75% usage, or 6,291,456 entries:
> > * Old design total overhead: 121.00 MB
> > * Vswap total overhead: 144.75 MB
> >
> > 100% usage, or 8,388,608 entries:
> > * Old design total overhead: 153.00 MB
> > * Vswap total overhead: 193.00 MB
> >
> > So even in the worst case scenario for virtual swap, i.e when we
> > somehow have an oracle to correctly size the swapfile for zswap
> > pool to 32 GB, the added overhead is only 40 MB, which is a mere
> > 0.12% of the total swapfile :)
> >
> > In practice, the overhead will be closer to the 50-75% usage case, as
> > systems tend to leave swap headroom for pathological events or sudden
> > spikes in memory requirements. The added overhead in these cases are
> > practically neglible. And in deployments where swapfiles for zswap
> > are previously sparsely used, switching over to virtual swap will
> > actually reduce memory overhead.
> >
> > Doing the same math for the disk swap, which is the worst case for
> > virtual swap in terms of swap backends:
> >
> > 0% usage, or 0 entries: 0.00 MB
> > * Old design total overhead: 25.00 MB
> > * Vswap total overhead: 2.00 MB
> >
> > 25% usage, or 2,097,152 entries:
> > * Old design total overhead: 41.00 MB
> > * Vswap total overhead: 66.25 MB
> >
> > 50% usage, or 4,194,304 entries:
> > * Old design total overhead: 57.00 MB
> > * Vswap total overhead: 130.50 MB
> >
> > 75% usage, or 6,291,456 entries:
> > * Old design total overhead: 73.00 MB
> > * Vswap total overhead: 194.75 MB
> >
> > 100% usage, or 8,388,608 entries:
> > * Old design total overhead: 89.00 MB
> > * Vswap total overhead: 259.00 MB
> >
> > The added overhead is 170MB, which is 0.5% of the total swapfile size,
> > again in the worst case when we have a sizing oracle.

