Return-Path: <linux-pm+bounces-39720-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1D4CD26A4
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 05:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 873533017ED0
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 04:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B211C19EED3;
	Sat, 20 Dec 2025 04:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HRzXcBno"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1F6207DF7
	for <linux-pm@vger.kernel.org>; Sat, 20 Dec 2025 04:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766203349; cv=none; b=A+wRTQj1hXyRMVeErIrTmN/ySpdntnxo0Y5/B0UFr7qB8fnxwQw3bSO0mB5fr0WFNBNXxik5SQjFhgCvJBP5HBp2w7Cfc5Oh4DAJZ0QZXr1ZoCoKAqZ3JT/4I6gUALF9uVRB9YoJ0i4BShUoKRs9k7JdsmblLYjUVbR8REK373E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766203349; c=relaxed/simple;
	bh=GJPbf42Yld+IknBiWEDwm8lq797Hg0zXAoyYXV32KqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q74ZEMPBOimtR5s34GsiVgmTa1znQrTv3IgEWXhYlgbykVIsyH/k94ToTiiGusJPq2OFdnTmRUTIHuy7ptfoUcI+PUY8v/Lykaf6b7NiaADULpa2TYnSsJKmK9Mxa5iLTipz7fskwaHhTIFw6hVGs0W1+2R1QdAqIVI3mMU8QH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HRzXcBno; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766203347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kvqmX5hgABRKtsoboa9njISBubOT841+nRpbPYRdnww=;
	b=HRzXcBnoODZyuTRmFsotw+XuOg5D931pGd6nm9U8CUgcMAr0ND/hjRyGx7FbmSmv40FVXw
	Q/CEqhDXeGA20sDregebe4pBpd9FLYmVWWCpfp9CdB2IjIDMGEo0bit8FOZv14mA9VlNYz
	OwWBQoDXY7Ji5c5rWZHMPm8es5T8RWQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-NwGKxkwYPue8DRXokHcolQ-1; Fri,
 19 Dec 2025 23:02:23 -0500
X-MC-Unique: NwGKxkwYPue8DRXokHcolQ-1
X-Mimecast-MFC-AGG-ID: NwGKxkwYPue8DRXokHcolQ_1766203341
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7601E180060D;
	Sat, 20 Dec 2025 04:02:19 +0000 (UTC)
Received: from localhost (unknown [10.72.112.41])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 90CF2180045B;
	Sat, 20 Dec 2025 04:02:17 +0000 (UTC)
Date: Sat, 20 Dec 2025 12:02:13 +0800
From: Baoquan He <bhe@redhat.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry.ahmed@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>,
	linux-pm@vger.kernel.org,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Subject: Re: [PATCH v5 14/19] mm, swap: cleanup swap entry management workflow
Message-ID: <aUYfxQtmWO3STLa8@MiWiFi-R3L-srv>
References: <20251220-swap-table-p2-v5-0-8862a265a033@tencent.com>
 <20251220-swap-table-p2-v5-14-8862a265a033@tencent.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220-swap-table-p2-v5-14-8862a265a033@tencent.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 12/20/25 at 03:43am, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> The current swap entry allocation/freeing workflow has never had a clear
> definition. This makes it hard to debug or add new optimizations.
> 
> This commit introduces a proper definition of how swap entries would be
> allocated and freed. Now, most operations are folio based, so they will
> never exceed one swap cluster, and we now have a cleaner border between
> swap and the rest of mm, making it much easier to follow and debug,
> especially with new added sanity checks. Also making more optimization
> possible.
> 
> Swap entry will be mostly allocated and free with a folio bound.
                                          ~~~~
                                          freed, typo
> The folio lock will be useful for resolving many swap ralated races.
> 
> Now swap allocation (except hibernation) always starts with a folio in
> the swap cache, and gets duped/freed protected by the folio lock:
> 
> - folio_alloc_swap() - The only allocation entry point now.
>   Context: The folio must be locked.
>   This allocates one or a set of continuous swap slots for a folio and
>   binds them to the folio by adding the folio to the swap cache. The
>   swap slots' swap count start with zero value.
> 
> - folio_dup_swap() - Increase the swap count of one or more entries.
>   Context: The folio must be locked and in the swap cache. For now, the
>   caller still has to lock the new swap entry owner (e.g., PTL).
>   This increases the ref count of swap entries allocated to a folio.
>   Newly allocated swap slots' count has to be increased by this helper
>   as the folio got unmapped (and swap entries got installed).
> 
> - folio_put_swap() - Decrease the swap count of one or more entries.
>   Context: The folio must be locked and in the swap cache. For now, the
>   caller still has to lock the new swap entry owner (e.g., PTL).
>   This decreases the ref count of swap entries allocated to a folio.
>   Typically, swapin will decrease the swap count as the folio got
>   installed back and the swap entry got uninstalled
> 
>   This won't remove the folio from the swap cache and free the
>   slot. Lazy freeing of swap cache is helpful for reducing IO.
>   There is already a folio_free_swap() for immediate cache reclaim.
>   This part could be further optimized later.
> 
> The above locking constraints could be further relaxed when the swap
> table if fully implemented. Currently dup still needs the caller
        ~~ s/if/is/ typo

> to lock the swap entry container (e.g. PTL), or a concurrent zap
> may underflow the swap count.
......


