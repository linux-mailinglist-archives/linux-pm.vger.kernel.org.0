Return-Path: <linux-pm+bounces-40383-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5113CFF1B9
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 18:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD0453410321
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 16:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E29346A1C;
	Wed,  7 Jan 2026 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eC4UFJM/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2F838BDA5
	for <linux-pm@vger.kernel.org>; Wed,  7 Jan 2026 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767801970; cv=none; b=HN8EL/mC3sQud2j7HBDnQMu/RgYoqxHL/ifvhSb6EOU4/iKV+ea3XHbE+SmhfNhNDSG2faH1bTXV+Ls0Vwh5tAqeX3W7tSRaMytLtZ6F5jumMsxW6fNoWlYBPnMlUeDP2t47F1vetlFBVd76QkdLQ2ucjQMOr9QPS6NiANjyqzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767801970; c=relaxed/simple;
	bh=BjW0MURabj4NVMk8y9mVKEawE6TJi+KK7hcdNzW9f7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKQT/HsyImvBkzBRoL0FPzMGaOy6KhBwJpdkbZ/LbdmCB6HQKNBCyQMaAHe1wTxekKyqLQy6q8IuyI08W93u0g7iP6q2Ceg2KAJjcmdYsQZcz8lwuAWzBKtUDgO6u6zF7DmQetnmsPkYmx3JqbCvOZG80OBUofDiIKpJozL8X4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eC4UFJM/; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64b9cb94ff5so3100586a12.2
        for <linux-pm@vger.kernel.org>; Wed, 07 Jan 2026 08:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767801959; x=1768406759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+lP54RhnuNvs5BPU2CeELlZ9FEsuYM7DOu2bpSXsYs=;
        b=eC4UFJM/MZJmScv4Pz/Erbx5uXecNCu27FlMrPY7CUO2e1LZw8pROCh2NOJhNBpIjr
         eHeRA5hXiVECCV8gacTjBBYw72XK0gUdtuqA0dgcKCl+cEIB8TBcJbIMwMMTRRaIM745
         yjjRD3ZDL86kDSQNAxtUHLa8azAsrqh6d1cV3c/Q8L/jXL3UOU3IrEJIdSc56Mqd01rF
         XOghtjYgJuzX7a+vv4OxtV7F1RVm9QyIMP5bfKCK2gDAmynq/1lbLADXHNFcb7VQTd/6
         6EH+c9VWNjAB0uJd6qd0eFZ/GwrepO3esbHVYYFsEQEekSrXaQGG7NKVwvYJLPj6lGV5
         JwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767801959; x=1768406759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4+lP54RhnuNvs5BPU2CeELlZ9FEsuYM7DOu2bpSXsYs=;
        b=gpDBOwvS1k6zNICZLXkg94rzh6mrWbm3s5fsGUyLzAzdvOCxwsZIRkqlhQmnlik6RZ
         SJCaQaj3+3w6+dsYL2B3ksob7dbRGw+IUnijSolrWnpobAXR4TcspRnwZwykWMHwhwmk
         639kYP1uJpX2y1OAH8lFN8RYxMqpse0WyqC0M2E4D6TDG8HWThWEGte8OHzPjOCBSv9K
         IxKqLuVpw/3KxavyCB24odeLnLAc2BBfgxa8JIGLnJZzBskhFkYEjxdisZl8ug9TnzBR
         t8p6p/5uc0HoowTJJiHQohbvu84recK5kpD5LDRH9PIhs+UM3tZYTBVsOr4gz9EQ3zpt
         jxZA==
X-Forwarded-Encrypted: i=1; AJvYcCW+BbxF3RBcQjsBw6kt5Ds2jxrwlSM9BzYxqMGcz/JogvMivfYl5gWqs0h4UGoMWoyMzZ6RUpzW8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxU7jxvEVJx4pp7csrd4WP+crjKROwfTu6hcjkFnknzzBaAvhi
	FwfWBrzK9xWDEG4UjiBRHsLUr4ruC3OmRZ0cp/6Xes0R1jDb/g/UGs6w10QZmfqVViUPR/lQIvL
	/6Lc3wxMKzO8sjcnIK5jPCJQ49h3X3yo=
X-Gm-Gg: AY/fxX5mkfQV3NnU/8LDybGnWtuGXSqVKGg+CiQi/dWJEXZW3BHrbGIFQWshzjs9yNg
	tCYaPdRRbKw5lZTJWsHKh/zt+oTTWozD+f+JZyC93r51jqHqzQkkkhnWESDLyvae0Qe+EoZ0J8T
	VwWtVXN1wN30/M7TTCf0NO9kuEZTpPY45s4pQ7i1R7ZHl9wGKAoOcLYxIdv24rBX664QtEzgQVC
	nsalRlvvK7mk2zMccS45diEF/MaYe3coNEGCIFg8wX4EfxGS3oEzxSPHwWFciAIdiu1rd8dDbYA
	cWL5uqDuraqcGqL5ZCJ/QfdvAmLt
X-Google-Smtp-Source: AGHT+IF268lKmMRB6hFIs3UMiBKC9a1cNQIxcrYUHlDrac/ngSjkrUEtTtA+Vx+f8gcKm7grqZoOiKa2zHZvFEFYn6I=
X-Received: by 2002:a05:6402:3487:b0:637:dfb1:33a8 with SMTP id
 4fb4d7f45d1cf-65097dcc598mr3052666a12.3.1767801958827; Wed, 07 Jan 2026
 08:05:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251220-swap-table-p2-v5-0-8862a265a033@tencent.com>
 <20251220-swap-table-p2-v5-14-8862a265a033@tencent.com> <aUYfxQtmWO3STLa8@MiWiFi-R3L-srv>
 <CAMgjq7A=n=5cOgOYm8i-DmgjxQgYU9om2oq02nBk5vkn7dambA@mail.gmail.com>
In-Reply-To: <CAMgjq7A=n=5cOgOYm8i-DmgjxQgYU9om2oq02nBk5vkn7dambA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 8 Jan 2026 00:05:21 +0800
X-Gm-Features: AQt7F2qNptlDKTRGB2DfXhz86TIy1LkURo4mHL3lSwPeQd22gsMeYbaRnnPhgnI
Message-ID: <CAMgjq7C+2snKqZm1BKK8jNjkeot9dO1tPx=f7Jt1gBvDvWggAg@mail.gmail.com>
Subject: Re: [PATCH v5 14/19] mm, swap: cleanup swap entry management workflow
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, David Hildenbrand <david@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Youngjun Park <youngjun.park@lge.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 10:43=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> On Sat, Dec 20, 2025 at 12:02=E2=80=AFPM Baoquan He <bhe@redhat.com> wrot=
e:
> >
> > On 12/20/25 at 03:43am, Kairui Song wrote:
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > The current swap entry allocation/freeing workflow has never had a cl=
ear
> > > definition. This makes it hard to debug or add new optimizations.
> > >
> > > This commit introduces a proper definition of how swap entries would =
be
> > > allocated and freed. Now, most operations are folio based, so they wi=
ll
> > > never exceed one swap cluster, and we now have a cleaner border betwe=
en
> > > swap and the rest of mm, making it much easier to follow and debug,
> > > especially with new added sanity checks. Also making more optimizatio=
n
> > > possible.
> > >
> > > Swap entry will be mostly allocated and free with a folio bound.
> >                                           ~~~~
> >                                           freed, typo
>
> Ack, nice catch.
>
> > > The folio lock will be useful for resolving many swap ralated races.
> > >
> > > Now swap allocation (except hibernation) always starts with a folio i=
n
> > > the swap cache, and gets duped/freed protected by the folio lock:
> > >
> > > - folio_alloc_swap() - The only allocation entry point now.
> > >   Context: The folio must be locked.
> > >   This allocates one or a set of continuous swap slots for a folio an=
d
> > >   binds them to the folio by adding the folio to the swap cache. The
> > >   swap slots' swap count start with zero value.
> > >
> > > - folio_dup_swap() - Increase the swap count of one or more entries.
> > >   Context: The folio must be locked and in the swap cache. For now, t=
he
> > >   caller still has to lock the new swap entry owner (e.g., PTL).
> > >   This increases the ref count of swap entries allocated to a folio.
> > >   Newly allocated swap slots' count has to be increased by this helpe=
r
> > >   as the folio got unmapped (and swap entries got installed).
> > >
> > > - folio_put_swap() - Decrease the swap count of one or more entries.
> > >   Context: The folio must be locked and in the swap cache. For now, t=
he
> > >   caller still has to lock the new swap entry owner (e.g., PTL).
> > >   This decreases the ref count of swap entries allocated to a folio.
> > >   Typically, swapin will decrease the swap count as the folio got
> > >   installed back and the swap entry got uninstalled
> > >
> > >   This won't remove the folio from the swap cache and free the
> > >   slot. Lazy freeing of swap cache is helpful for reducing IO.
> > >   There is already a folio_free_swap() for immediate cache reclaim.
> > >   This part could be further optimized later.
> > >
> > > The above locking constraints could be further relaxed when the swap
> > > table if fully implemented. Currently dup still needs the caller
> >         ~~ s/if/is/ typo
>
> Ack, Thanks!

Hi Andrew,

There are no other problems reported with the series so far, for the
two typos here, could you help update the commit message?

