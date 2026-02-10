Return-Path: <linux-pm+bounces-42469-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAZ8N5l+i2kzUwAAu9opvQ
	(envelope-from <linux-pm+bounces-42469-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 19:53:13 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 866BD11E6FB
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 19:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EAB023018722
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 18:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF4638B98C;
	Tue, 10 Feb 2026 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="ZPYSjFSz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB6138B7AE
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 18:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770749581; cv=none; b=tS4vlCe+1lxG5CcNJBEaf5FqbmZWPoXhIZx6E6YpX8n68DnQE+GhfNR39T48WkBtG5uE959iXBZxMhyCsbbzIIauWxvjq9R+nySjpO7SXKTho8an7XA7Ph5KvIVww7L40CDw82zQ/3hUwiyIkMdFMJGU8AiKjm7lkjRJnjNtMS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770749581; c=relaxed/simple;
	bh=2M+aBL+xwIjke2RBYrRF+nVdMsjWO5VVoMXLUs63K5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzE74qYV4Yp9PSVJdDSVn5EZsvxfPgx3HS9tHZyvDSRuI3KUJnmh5aRtSDPXyoZHQNPTkFEeX6fIE0MsGhQiqfkZLrz2ozlBsXNqVA74yJC3Mao4340eIgFi/XKsexZKZ8K/L3sykKguODdwCKJ3/wORW+jHRCLtKdAaEvUFDGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=ZPYSjFSz; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8c531473fdcso622693485a.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 10:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1770749578; x=1771354378; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dYxAK4MfxkNTvDSky4rly7XqGqYb657cJCOkNsVbPkc=;
        b=ZPYSjFSzo0LI5+2mg7yQ1l3Y0w+fbxoBOsYscmkcIQw4Ip6+OuFlOc1HCTEKS4euqK
         uZGpCAamX7ThxS63/SpJlHXvfsb5oxlNIS4URcwdog+ldFOMjrbCTedZZx8JfnopPmQ2
         cwhIH5mYhKrpgnXROdB1jr/JP7FiaNjaRQ7J+VxbRpuQO/gb0K0P1IHDnfKulFKEExFF
         Uw6HpWhiAsu5eqkrz5wir8dre3siFDyyK1ZrehfbYqy9pMaziqrGfLgVpRHcTelUaac1
         ZImXTbFQVR+chNfoG326fkznH41ggq6K6WnXOOCsDvGO+Ns4nan0rRlZFAVbqbP5e93R
         qgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770749578; x=1771354378;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dYxAK4MfxkNTvDSky4rly7XqGqYb657cJCOkNsVbPkc=;
        b=EfHCtgTGYdzhhMgPJNjuVxdu+5xkyooBJwXTGTnj7qunHiGazdb/CddptH1igpOdob
         ChVf1W1lEm5RhxGS4LywmTLIVqreChcWH5B7ldih3nhwBU3UbqOFhBddKFgzDWe2FyIb
         XtHa4Zi4ihGB8It5ARb5wDDbnCIpkjNAjf1xC0BjartCeadwyzUSy86BNnF409hshDaR
         Os7jZg3ER9bubbQzA2UmZLgL93KBR7u5Vm+ZUVJpI+qll3QGHJV/K6e3/daXlgghIB0g
         OQUsMe0KZeXfb5W50PqTWwPjDz/CrqzK6u8wGsJ0Y1o83OjGxheaUKjDexTPCVeMk7Dk
         2OIA==
X-Forwarded-Encrypted: i=1; AJvYcCVpu7eD8d/RQMNnZvlJulzmLcivc/y6/dpg4jTrNQCkyQaCCKWYgK1T7mR9O7lVxSx0ScgD0eevtw==@vger.kernel.org
X-Gm-Message-State: AOJu0YykJIIcoNtFkOeEgPva2S7fU8+JsYuEm2kb5zpZXp7OJ4Jb+InF
	vv7m2+HMWwB1SzkwnB3cQwTRF+deLOZWqnZNtfBC+oUqimX1f0SzBBVUB5m1Da/Qq5g=
X-Gm-Gg: AZuq6aJ4bhP+dY5IyddumEnHJjytxUjs8D30id5foAzuFvPhFaQCxAkyvLKw4ChmAEU
	qtApxu6YYoRdhl/0keuEY1gzAiowTc3LW/oARINAUKJIaYkJJ6ZQBYgpCj0PrexIIoRSA6CdDTz
	W5WcDS87ZRWtaUxIB/6aAc/8HGDZb5trT5Y1wqhfp5Mt6pBOAaGDc2uZngriSfj7UCVIAt3EHEF
	65K1YlXuw/yYbVQCMyp14+41hqdkAVWAwoZUUFWfGRSFEWzAJ+nMzn5rQYeyr60bfT6R5ycc4br
	XIl5KO7v+05ryHYmMLzUtk7QKbcC9XRx7gRTW8uQvU5rFLWJr6DUD1zSZyKaKgWXyNn686418m4
	JljoqvV3kU2vrwxfXbvuVRegXShjHIGa9g+J5t3FaFj/sQTOOtUWcAis3Jp4RZ3FCTz3814t/c5
	RtSSESTQOpwr3O9uIgtL88ftSfIxfLhd0=
X-Received: by 2002:a05:620a:690e:b0:8b6:1877:3689 with SMTP id af79cd13be357-8cb27fc2b12mr39809385a.35.1770749577839;
        Tue, 10 Feb 2026 10:52:57 -0800 (PST)
Received: from localhost ([2603:7000:c00:100:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9a16240sm1107793485a.35.2026.02.10.10.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 10:52:57 -0800 (PST)
Date: Tue, 10 Feb 2026 13:52:53 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Kairui Song <ryncsn@gmail.com>
Cc: Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org,
	akpm@linux-foundation.org, hughd@google.com, yosry.ahmed@linux.dev,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, len.brown@intel.com,
	chengming.zhou@linux.dev, chrisl@kernel.org,
	huang.ying.caritas@gmail.com, ryan.roberts@arm.com,
	shikemeng@huaweicloud.com, viro@zeniv.linux.org.uk,
	baohua@kernel.org, bhe@redhat.com, osalvador@suse.de,
	christophe.leroy@csgroup.eu, pavel@kernel.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org, peterx@redhat.com, riel@surriel.com,
	joshua.hahnjy@gmail.com, npache@redhat.com, gourry@gourry.net,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	rafael@kernel.org, jannh@google.com, pfalcato@suse.de,
	zhengqi.arch@bytedance.com
Subject: Re: [PATCH v3 00/20] Virtual Swap Space
Message-ID: <aYt-havagZ8kUmov@cmpxchg.org>
References: <20260208215839.87595-2-nphamcs@gmail.com>
 <20260208222652.328284-1-nphamcs@gmail.com>
 <CAMgjq7AQNGK-a=AOgvn4-V+zGO21QMbMTVbrYSW_R2oDSLoC+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7AQNGK-a=AOgvn4-V+zGO21QMbMTVbrYSW_R2oDSLoC+A@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42469-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[38];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kvack.org,linux-foundation.org,google.com,linux.dev,kernel.org,intel.com,arm.com,huaweicloud.com,zeniv.linux.org.uk,redhat.com,suse.de,csgroup.eu,meta.com,vger.kernel.org,surriel.com,gourry.net,bytedance.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 866BD11E6FB
X-Rspamd-Action: no action

Hello Kairui,

On Wed, Feb 11, 2026 at 01:59:34AM +0800, Kairui Song wrote:
> On Mon, Feb 9, 2026 at 7:57 AM Nhat Pham <nphamcs@gmail.com> wrote:
> >     * Reducing the size of the swap descriptor from 48 bytes to 24
> >       bytes, i.e another 50% reduction in memory overhead from v2.
> 
> Honestly if you keep reducing that you might just end up
> reimplementing the swap table format :)

Yeah, it turns out we need the same data points to describe and track
a swapped out page ;)

> > * Operationally, static provisioning the swapfile for zswap pose
> >   significant challenges, because the sysadmin has to prescribe how
> >   much swap is needed a priori, for each combination of
> >   (memory size x disk space x workload usage). It is even more
> >   complicated when we take into account the variance of memory
> >   compression, which changes the reclaim dynamics (and as a result,
> >   swap space size requirement). The problem is further exarcebated for
> >   users who rely on swap utilization (and exhaustion) as an OOM signal.
> 
> So I thought about it again, this one seems not to be an issue. In
> most cases, having a 1:1 virtual swap setup is enough, and very soon
> the static overhead will be really trivial. There won't even be any
> fragmentation issue either, since if the physical memory size is
> identical to swap space, then you can always find a matching part. And
> besides, dynamic growth of swap files is actually very doable and
> useful, that will make physical swap files adjustable at runtime, so
> users won't need to waste a swap type id to extend physical swap
> space.

The issue is address space separation. We don't want things inside the
compressed pool to consume disk space; nor do we want entries that
live on disk to take usable space away from the compressed pool.

The regression reports are fair, thanks for highlighting those. And
whether to make this optional is also a fair discussion.

But some of the numbers comparisons really strike me as apples to
oranges comparisons. It seems to miss the core issue this series is
trying to address.

> > * Another motivation is to simplify swapoff, which is both complicated
> >   and expensive in the current design, precisely because we are storing
> >   an encoding of the backend positional information in the page table,
> >   and thus requires a full page table walk to remove these references.
> 
> The swapoff here is not really a clean swapoff, minor faults will
> still be triggered afterwards, and metadata is not released. So this
> new swapoff cannot really guarantee the same performance as the old
> swapoff.

That seems very academic to me. The goal is to relinquish disk space,
and these patches make that a lot faster.

Let's put it the other way round: if today we had a fast swapoff read
sequence with lazy minor faults to resolve page tables, would we
accept patches that implement the expensive try_to_unuse() scans and
make it mandatory? Considering the worst-case runtime it can cause?

I don't think so. We have this scan because the page table references
are pointing to disk slots, and this is the only way to free them.

> And on the other hand we can already just read everything
> into the swap cache then ignore the page table walk with the older
> design too, that's just not a clean swapoff.

How can you relinquish the disk slot as long as the swp_entry_t is in
circulation?

