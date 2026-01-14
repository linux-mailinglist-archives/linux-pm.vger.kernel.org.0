Return-Path: <linux-pm+bounces-40871-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 572CCD202BB
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 17:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4AF930611B7
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 16:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36295399015;
	Wed, 14 Jan 2026 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlZYQ7+2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E775A39E6DD
	for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 16:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768407553; cv=none; b=iOHnaeyGfN2FW5i8oSKaZIO0Sw2Vd8TLX1Rz4j3HKxhxsv5n5rQlDrKDnfPmmUlNmJuNjnGD1CyVwuS/ANxypyVRY5t3oMriqSVpulrUEwx9ww1uHr4v/ZJ6p0CJ5H4XISR6hP2/woCtnYZ7+rfT9LILjZsHSCFTkQvzk+sdoJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768407553; c=relaxed/simple;
	bh=CeLVbhQCeP9PVVvwZhgagBzzPho75MxLFwCSAkeFQTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cN8ntEYOoRX3dncRQ/4TuuzfsdN1w6v+9hIlaYu72xG0oyE1o8INa5zbeuePGuWid7m7x9eocSntZlt3ad+cBciHpJsgY4CywcHr9Rkm2Y2wyFtvhhXwqh4jT1hPT+l523SKqfl+nZZb5U8mR2AkvCh2zHkSDAX4K0rXWl3XGjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlZYQ7+2; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6505cac9879so15044726a12.1
        for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 08:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768407543; x=1769012343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imfPVRl23dlbK6fVFb/rl6IsVwzLYSHlggMP7T9DiFE=;
        b=AlZYQ7+25TKKpI7WsxpJEw/PhGa4QW72TSuKiWg7FyzAQiMkvH5Dzh2skDcTPnQcWp
         Zrjs8eXRVZu9gtPtIzXSlvRzmv5m4gT3l4zh3IwNHTtXTDWOt9hSj+z394aaUx0gXC0N
         DZtjTlqjaiT7IMNr7c0jT9Ccv01WIkTbReZ0gVHV9OXBODE+d9wlRbeL9ZTCflnIzvyJ
         cH1Rn7K4PY5l1wrYi03M6noO8fjluyT8bQlP2cK3Xzhi1qcV/kCG5Je9iLy6LBcvqA0V
         e8SPrIbUVuwWLPKx+BeOeIqM0SA9y5DYgKqUp8jZXKdDnRqNlCegyp/HBd7ArEdhFmXI
         I/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768407543; x=1769012343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=imfPVRl23dlbK6fVFb/rl6IsVwzLYSHlggMP7T9DiFE=;
        b=PBa++ct0QLbnthFS8OGnftYKMHy3XI467FizUgVwBYSYO9Q7kZdl1evq9ncU+WIgYU
         mfr+8K7X4jsPBAGjB5MxbDbu1dbnal8M/fmh4HA+V6I9lv3L1+3q9Vn1OxXFNTUkfKk3
         FRpp3vcEDXG2B2kOKo8jynSFeWCOGYKk5BmQFt+itAAFAl2l7y8pympSNFK6QNNKbn/C
         2KB+N2Wj/H0x6HUJpLX/fE3/m3bPiAnbbijXMk2aWDcTmDy/65Im37P+TFsruk+S2M0u
         YU4pz/KJ5imRBZCwu8YmhpLrIBxn9vKDpK1a0TOv+moZWXqGjJ//MU1ne31e2zfaYRaE
         QVyA==
X-Forwarded-Encrypted: i=1; AJvYcCXvtSASRf8YXzMb3F/mJ/3q1UixkSySPKn1BzxuLpaPP0RcytXUk9Tj3kR/3rhs8ojb63lHrgy1Pw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLOuQTat78Zx8iKMQTsoL51G8Cfvor2NXw+fh5VVgjUSXIcUu7
	QHX99t+WpcZBJbpi7DI7DHUkmexPc2KDKkMqqu2V3vj2RmAjaUyZkWbxmGJBc9bvujc4133yfLD
	NriUDepZOhNqY7/fMtg28LEIlXtpW9+c=
X-Gm-Gg: AY/fxX5xpRIkEcesMXWnnQNNgR8yaOLCpsJfb8DjvKF4I4fzzY2JXmZSzWLZX05ayms
	58QuU0wH/7uYd2o+EpGI5xrLIMfcW841rSjADvQlT73z8OOx0MUV35v1hzs4NjxbXzAP9jIrhXe
	C11GrKiYRgeEWU4WJDJe+1JJX7c0VcVqxwSN5LBMKSFAQ4UqD22ZF/2GaiYMkiUGS2dbu5YdtsL
	CgQw+I9vhmvy9qQfx/942CgrocLadCfF1Rrpj4WNa7t1m0MBpLlU/STuDwhGmHwIyDvd574/ojW
	ef52m7E74VR93OjuEZSA61K2/tP1b20zVcVU770=
X-Received: by 2002:a05:6402:280b:b0:64b:5885:87d6 with SMTP id
 4fb4d7f45d1cf-653ee1b1d0cmr2161521a12.24.1768407543001; Wed, 14 Jan 2026
 08:19:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251220-swap-table-p2-v5-14-8862a265a033@tencent.com> <20260114121654.1029110-1-clm@meta.com>
In-Reply-To: <20260114121654.1029110-1-clm@meta.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 15 Jan 2026 00:18:26 +0800
X-Gm-Features: AZwV_Qj7CkE3W5Y2qsTkRXTs8xTCI3Xbf6SrqUTC_RmOckdRx5H-rx9OxiObNig
Message-ID: <CAMgjq7BKgke-E=2GTvd8eFgkZ2YguogKFVFfBhvd21_t+eY+UA@mail.gmail.com>
Subject: Re: [PATCH v5 14/19] mm, swap: cleanup swap entry management workflow
To: Chris Mason <clm@meta.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Youngjun Park <youngjun.park@lge.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 8:17=E2=80=AFPM Chris Mason <clm@meta.com> wrote:
>
> On Sat, 20 Dec 2025 03:43:43 +0800 Kairui Song <ryncsn@gmail.com> wrote:
>
> Hi everyone,
>
> I ran mm-new through the AI review prompts, and this one was flagged:
>
> > diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> > index 8050e51828351..036489d3b01a9 100644
> > --- a/kernel/power/swap.c
> > +++ b/kernel/power/swap.c
>
> [ ... ]
>
> > @@ -186,6 +186,7 @@ sector_t alloc_swapdev_block(int swap)
> >
> >  void free_all_swap_pages(int swap)
> >  {
> > +     unsigned long offset;
> >       struct rb_node *node;
> >
> >       /*
> > @@ -197,8 +198,9 @@ void free_all_swap_pages(int swap)
> >
> >               ext =3D rb_entry(node, struct swsusp_extent, node);
> >               rb_erase(node, &swsusp_extents);
> > -             swap_free_nr(swp_entry(swap, ext->start),
> > -                          ext->end - ext->start + 1);
> > +
> > +             for (offset =3D ext->start; offset < ext->end; offset++)
> > +                     swap_free_hibernation_slot(swp_entry(swap, offset=
));
>                                            ^^^^^^^^^^^
>
> Is this loop missing the final slot at ext->end?
>
> The old code freed (ext->end - ext->start + 1) entries, which is the
> inclusive range [ext->start, ext->end]. Looking at swsusp_extents_insert(=
),
> when a single slot is inserted it sets ext->start =3D ext->end =3D offset=
, and
> merging extends the range by incrementing ext->end or decrementing
> ext->start. This means ext->end is inclusive.
>
> The new loop uses "offset < ext->end" which iterates [ext->start, ext->en=
d),
> missing the slot at ext->end. Should this be "offset <=3D ext->end" inste=
ad?

Wow, nice catch. Indeed that would be one swap leak for each
hibernation snapshot release I think. I only tested normal
hibernations, didn't realize there is issue with the "release before
use" path. `offset <=3D ext->end` is the right one here.

