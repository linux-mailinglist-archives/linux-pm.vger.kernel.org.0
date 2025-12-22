Return-Path: <linux-pm+bounces-39768-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E838BCD4930
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 03:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B747A3005E8E
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 02:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1392F320A01;
	Mon, 22 Dec 2025 02:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOF3Shza"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B7C74BE1
	for <linux-pm@vger.kernel.org>; Mon, 22 Dec 2025 02:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766371428; cv=none; b=TsJM1dsvZI49/4GYj/o32nuMQtniTut8QBKA+NLBpbFzJpgZvn6KBXQmkLb4xRgKeB/l2JYf8/VPYAmUbhFBeqfM3wntG3V6u2x9/Ng6Jq53SyRXsnB+PvPL+mHw2JyCDgb0pOfRyay7BVuxg8SK8C4ZkD1ufZYgXlNq+H5NDQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766371428; c=relaxed/simple;
	bh=0Ea4s7NgHX0Q8NSZF+UknX+hGaSZaZ6HU7+ylHpk9Es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ftpMpVvE7hkNQy9tbsfL3CbZsMMbgNN+9RoB28l8m3rkpvA5cafJMTrN3N/YDMZYLWKQxsIjg5r0vQzr/FU9IKuvyC1aoUt1/kpL5axFcx0kFbKAXBlq7cn+neh/QVTfmgJlUrdKWx09NLmBOqXL57jymhH6bel/tFss8OqxeG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOF3Shza; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b7cee045187so632353166b.0
        for <linux-pm@vger.kernel.org>; Sun, 21 Dec 2025 18:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766371425; x=1766976225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1rmnJHJ0LIIKvu4W1FDMChpGkEUx4rv2xP/CM2TZPs=;
        b=BOF3ShzaOqOCUDuxjr6dl3G3OrqNvNgVHRhNfwxq1gFpB90YwOQZGrUu2l8a1L0VUW
         yWkjbIkLiylhb0fBuEGT0+cKNAuIjvTIPKHmnJAaVNVviJY4E9+NI51Qpu1B9ulfBGxA
         hOCvVpvmgBpKq5gzx1/98a7H94L25VYikgXN/sWVDK/5ybVEcYFQbu806ns/lV0nfinn
         kD92ygTaMPpde0u5sxghPjskAaTdKaTxmMC0NMDzZnUbPfg2jUNC6rCCHMUZSrXdoXhY
         bBTYDprWAP56ewrlCrRqGHOonVOPszokKWMgRXpvX7t4itFMCiIGkCSz9razIoXv3RXi
         EMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766371425; x=1766976225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q1rmnJHJ0LIIKvu4W1FDMChpGkEUx4rv2xP/CM2TZPs=;
        b=b2qVle8M+N0xBhqLeIrI5Egq03MrGlCtKdFjmmcK2dAu1bOwJIfRc4nyvEFgERZLfZ
         u2ZwPOo5fNRckKL04l6G9V+s3+/p2kQGkDzWlJVDbTfKcBF/ibgnC09Sdatwd2Uhw8jL
         T9ufoNiLp+ajL24/BoKNqbt5FUe9XuJJuTFRRrAfjBj8SARY177JoCp79II9YJwZw7kf
         c8R/ZWUJySUP4YYBcgpUXT2OhrBlxPm/iSwDegr8MaLCFBjs03kH5kljzTpQudrLf82l
         dfvrehkXbVKLsbwuJI8TvHx1XPjfnFEvo4HvXePFA0274lzQpGrTTmxs14xOcoy0SESp
         oumA==
X-Forwarded-Encrypted: i=1; AJvYcCVfxjXzHzQ71qyoLXD96NMKUztDTjoipSzh8QSf3fBvy17XNm81cnALbwoan9MBDJx5a6EQ4LIPmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNPG+JPzCb8PkcgTLkJ2TQitDF8ECE61HL/9MrmOjjY4hdZRmh
	zlU8AVm2Q2BRzfmZMmJ5ZOBvp84KOBVhHj9zJ4FTK11VflHqF4G+oFt6U8t0pb6cyRpClvUXrJ6
	vptGaEEsd42HZ+a2zmK3WL9+0YDT7hi8=
X-Gm-Gg: AY/fxX474l58ucQGaYNR3aPC9pRqKw0pWzVrHz/nyfuWaItE/u3VWt/ZUO2Q0v60hDp
	i45YMuAvGkcthXbKbPNwZgjr3dCBsBPlPfZ+zWHdueJ++ZS6/DmzPLM7rBiR24HQYrTQyTh5BUn
	TpSc2JQLdxND3Gv7qnv3qqbk8x2ONXhd4Oc8IQynht4W/l2uvEBd4WJcVajZy0xsNqvP9nzmIfi
	/Ujs6pDt6ACVJtjR2EnNwm3p7yuzdSSgTtlPtRNa0faUgPzOvHyREVUw4KlPEBi6LSvYhaN3UZz
	82nreRLZGjSnFMk9Dt3a68IyPERiMhX8XJuYPw==
X-Google-Smtp-Source: AGHT+IFQefVoDjM6qXm9xXsRKL6C5aCvgURTze+OI7STgiaTEbImwqWU+RexOaZArGYLh6oO0cqE4lk+8QeWmC25uUQ=
X-Received: by 2002:a17:907:da1:b0:b7c:f120:bb23 with SMTP id
 a640c23a62f3a-b80358be994mr1157616166b.30.1766371424269; Sun, 21 Dec 2025
 18:43:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251220-swap-table-p2-v5-0-8862a265a033@tencent.com>
 <20251220-swap-table-p2-v5-14-8862a265a033@tencent.com> <aUYfxQtmWO3STLa8@MiWiFi-R3L-srv>
In-Reply-To: <aUYfxQtmWO3STLa8@MiWiFi-R3L-srv>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 22 Dec 2025 10:43:07 +0800
X-Gm-Features: AQt7F2po-umw4Bfriv3QUkuyjx9oV1Fuo6qEnrjh8W-LWnGbCOhdEYrniOCDIg0
Message-ID: <CAMgjq7A=n=5cOgOYm8i-DmgjxQgYU9om2oq02nBk5vkn7dambA@mail.gmail.com>
Subject: Re: [PATCH v5 14/19] mm, swap: cleanup swap entry management workflow
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, David Hildenbrand <david@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Youngjun Park <youngjun.park@lge.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 20, 2025 at 12:02=E2=80=AFPM Baoquan He <bhe@redhat.com> wrote:
>
> On 12/20/25 at 03:43am, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > The current swap entry allocation/freeing workflow has never had a clea=
r
> > definition. This makes it hard to debug or add new optimizations.
> >
> > This commit introduces a proper definition of how swap entries would be
> > allocated and freed. Now, most operations are folio based, so they will
> > never exceed one swap cluster, and we now have a cleaner border between
> > swap and the rest of mm, making it much easier to follow and debug,
> > especially with new added sanity checks. Also making more optimization
> > possible.
> >
> > Swap entry will be mostly allocated and free with a folio bound.
>                                           ~~~~
>                                           freed, typo

Ack, nice catch.

> > The folio lock will be useful for resolving many swap ralated races.
> >
> > Now swap allocation (except hibernation) always starts with a folio in
> > the swap cache, and gets duped/freed protected by the folio lock:
> >
> > - folio_alloc_swap() - The only allocation entry point now.
> >   Context: The folio must be locked.
> >   This allocates one or a set of continuous swap slots for a folio and
> >   binds them to the folio by adding the folio to the swap cache. The
> >   swap slots' swap count start with zero value.
> >
> > - folio_dup_swap() - Increase the swap count of one or more entries.
> >   Context: The folio must be locked and in the swap cache. For now, the
> >   caller still has to lock the new swap entry owner (e.g., PTL).
> >   This increases the ref count of swap entries allocated to a folio.
> >   Newly allocated swap slots' count has to be increased by this helper
> >   as the folio got unmapped (and swap entries got installed).
> >
> > - folio_put_swap() - Decrease the swap count of one or more entries.
> >   Context: The folio must be locked and in the swap cache. For now, the
> >   caller still has to lock the new swap entry owner (e.g., PTL).
> >   This decreases the ref count of swap entries allocated to a folio.
> >   Typically, swapin will decrease the swap count as the folio got
> >   installed back and the swap entry got uninstalled
> >
> >   This won't remove the folio from the swap cache and free the
> >   slot. Lazy freeing of swap cache is helpful for reducing IO.
> >   There is already a folio_free_swap() for immediate cache reclaim.
> >   This part could be further optimized later.
> >
> > The above locking constraints could be further relaxed when the swap
> > table if fully implemented. Currently dup still needs the caller
>         ~~ s/if/is/ typo

Ack, Thanks!

>
> > to lock the swap entry container (e.g. PTL), or a concurrent zap
> > may underflow the swap count.
> ......
>
>

