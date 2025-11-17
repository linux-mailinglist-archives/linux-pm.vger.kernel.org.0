Return-Path: <linux-pm+bounces-38128-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 642C7C6447F
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 14:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 1C42328A43
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 13:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8B03148AB;
	Mon, 17 Nov 2025 13:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GT4QP7/Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C2C331225
	for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 13:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763384777; cv=none; b=a3RwmwrzAU4BTy7MKlBnEjyV4iuV6SGLEetg9mjan3ks3NWs2qthWbeHQ0m87mB9wYMe1npQonHReEM63yaq/LR1WssWUkwaURa0vhK7bj8p129txCLMxtnuQ4aYzTsLCAnxEr9PXbSVsWuOiJQ4dhct9nr9prq0/IsuWvRnSA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763384777; c=relaxed/simple;
	bh=m3OL8AyMbHbrNVKacBSZn0hUzCvhl8MUsvirhFgMsLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLP7zfdHIaJvud0USf6uLqQQ1+KMv4vVSQqMoSEHCGEH7cQ7dPQjI9PPqG1ZblL9WXDLnrvoxLqJDVDu+NH48sgq2BrJ0NnsZcmDDwO10pf2OI2hruI9cpk9s/NdLtxrlcg03TmAFzeWJ/wiifGRO70oeYjWYhen4An+YAqeF7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GT4QP7/Z; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b735b7326e5so589616866b.0
        for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 05:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763384772; x=1763989572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzmClbvPyvBeE+q//jkriOQoEKo3zwFbzk31wn2QdMo=;
        b=GT4QP7/ZzPnwu4O54CPYdCDgahNruSKGNKPiGlhq1ICv/yleCnhwurr15Z63mioHS9
         lGcbNX1XKQ3rFa1EZwsbnl58xMkda8CvaK5rwXPj3IuAgP17RvJwAZQSeYSXpbpecMtY
         XDfs/eXWTjx4HY8EgOV6cxoUD0cbMyo1m5MdjtFTiSZMZY1yv4pll5+7eK7wshuevhAj
         ly6XeVXOMf5OkHo9EGEcsk0tpBN7AUNo9Aj+JuSm7LzeJmwAF4VW2y4b2sBpb2+TtGkK
         XRcfLwkWO3V79E6V3oB22zx5Q6wYs5a46dpmWanGcGB/TDKlhwuRJAq49Zf3t82Z6JK/
         VmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763384772; x=1763989572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dzmClbvPyvBeE+q//jkriOQoEKo3zwFbzk31wn2QdMo=;
        b=NUiasJ3v5jFJFBTqgBBfC9gjWnAJ/+iKodon9C3JMCtUO/rwCJGE8pdiLMcues5k4L
         v/PQSXJIqkrgbg6KuhQWRRbjImF0nFNIA1Zp1DsJe3qTRGnyRKBdwgf/W05gRa7xJPlk
         /hL1H07kj3WD5MC+ZM07yRSoRsnf8130xBEEo/jPu3oqvfPqBaYA5zsLGJftfYpVXSk2
         XO9PNJVLY7MRfKma+ZW+tuRDevmEecDXTWTsit4LwYVAObXw56+KWsaAMTMigfDZwbdS
         bNF8O2EKjncWaKn3WqVj3bCBeGX2VjQ/DvZAiT7X5CeUQXkoudS4XlGZZDhSgQjAm8W6
         fwyA==
X-Forwarded-Encrypted: i=1; AJvYcCV/tTLlx5j32YQJ+K0teQNQM1YXqtP3/MvFZMFlVfMiR7rloB4vRFmU7T+ZiCG19uGnSHHxve0NDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgFxWh9LBXp+GutJBNZYBJjSJ5D6cYZ01HfYSb9v4D88nRBiEF
	r7BZCfjmSbZWs3mr5kMqiwT8NjDjNVnDzvvejZbjetyALK4T/JjP93EqKqGOikdeZlvv+aBWsAH
	UU+RaSJlfd1dcJokL/k6IVEOJt0w8oeM=
X-Gm-Gg: ASbGncs0yAEl6vWOEkfVqRGDB93URQUnKcHsMbKCObrbabLMJqu+zWdRIMNZEBYko1I
	iHSZCr3hQGCPO9Pq1F9PJ8f+xzudoaIZrq7yworsxQFJ8T/fDoXn3VaFKLh275W8JeSdDCjpfto
	gwXVQ8o3DKxzPWBklcJg/RyTSj1fK4ur9hHx0N4NapAYrJU9yBXKYbDQeenPY3mUU3ct0bP9gRZ
	S2qYXSx4mszBs5OUAeJhsO9EDkH54YRFbHw91lORvky+YoBh+7rWNwPiS4GDJm1FV9L7WQE/PmK
	c6xz6UnMRYM44DNgrfopFyn/LTjiDJo=
X-Google-Smtp-Source: AGHT+IHqj3i2HRsibRzHKXf1dtPdvhXDhojSOWprepzSXOkYrPFcbb3l46Wk1jAyobY6QdZ9jWIdnMjC6+X5l2p7ueM=
X-Received: by 2002:a17:906:fe4d:b0:b72:7e7c:e848 with SMTP id
 a640c23a62f3a-b7348570745mr810309066b.17.1763384772052; Mon, 17 Nov 2025
 05:06:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117-swap-table-p2-v2-14-37730e6ea6d5@tencent.com> <202511171942.psG9jTRx-lkp@intel.com>
In-Reply-To: <202511171942.psG9jTRx-lkp@intel.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 17 Nov 2025 21:05:35 +0800
X-Gm-Features: AWmQ_bnUFnm0x-eDcpgtaE3URJs_3MiIsOAITzpaSFBE-GfFvya8ZTJD0VLBPq0
Message-ID: <CAMgjq7BkVvhsCzk2r53159hDoZ+b+AvP1iUTBHA9zvb+SJFg=Q@mail.gmail.com>
Subject: Re: [PATCH v2 14/19] mm, swap: sanitize swap entry management workflow
To: linux-mm@kvack.org
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, David Hildenbrand <david@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Youngjun Park <youngjun.park@lge.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 7:23=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Kairui,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on 41218ede767f6b218185af65ce919d0cade75f6b]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Kairui-Song/mm-swa=
p-rename-__read_swap_cache_async-to-swap_cache_alloc_folio/20251117-021532
> base:   41218ede767f6b218185af65ce919d0cade75f6b
> patch link:    https://lore.kernel.org/r/20251117-swap-table-p2-v2-14-377=
30e6ea6d5%40tencent.com
> patch subject: [PATCH v2 14/19] mm, swap: sanitize swap entry management =
workflow
> config: s390-defconfig (https://download.01.org/0day-ci/archive/20251117/=
202511171942.psG9jTRx-lkp@intel.com/config)
> compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 0=
bba1e76581bad04e7d7f09f5115ae5e2989e0d9)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20251117/202511171942.psG9jTRx-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202511171942.psG9jTRx-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> arch/s390/mm/gmap_helpers.c:35:2: error: call to undeclared function '=
free_swap_and_cache'; ISO C99 and later do not support implicit function de=
clarations [-Wimplicit-function-declaration]
>       35 |         free_swap_and_cache(entry);
>          |         ^
>    arch/s390/mm/gmap_helpers.c:35:2: note: did you mean 'free_swap_cache'=
?
>    include/linux/swap.h:435:6: note: 'free_swap_cache' declared here
>      435 | void free_swap_cache(struct folio *folio);
>          |      ^
>    1 error generated.
>
>
> vim +/free_swap_and_cache +35 arch/s390/mm/gmap_helpers.c
>
> 200197908dc4af Claudio Imbrenda 2025-05-28  19
> 200197908dc4af Claudio Imbrenda 2025-05-28  20  /**
> 6539cf8c98a8cc Lorenzo Stoakes  2025-11-10  21   * ptep_zap_softleaf_entr=
y() - discard a software leaf entry.
> 200197908dc4af Claudio Imbrenda 2025-05-28  22   * @mm: the mm
> 6539cf8c98a8cc Lorenzo Stoakes  2025-11-10  23   * @entry: the software l=
eaf entry that needs to be zapped
> 200197908dc4af Claudio Imbrenda 2025-05-28  24   *
> 6539cf8c98a8cc Lorenzo Stoakes  2025-11-10  25   * Discards the given sof=
tware leaf entry. If the leaf entry was an actual
> 6539cf8c98a8cc Lorenzo Stoakes  2025-11-10  26   * swap entry (and not a =
migration entry, for example), the actual swapped
> 200197908dc4af Claudio Imbrenda 2025-05-28  27   * page is also discarded=
 from swap.
> 200197908dc4af Claudio Imbrenda 2025-05-28  28   */
> 6539cf8c98a8cc Lorenzo Stoakes  2025-11-10  29  static void ptep_zap_soft=
leaf_entry(struct mm_struct *mm, softleaf_t entry)
> 200197908dc4af Claudio Imbrenda 2025-05-28  30  {
> 6539cf8c98a8cc Lorenzo Stoakes  2025-11-10  31          if (softleaf_is_s=
wap(entry))
> 200197908dc4af Claudio Imbrenda 2025-05-28  32                  dec_mm_co=
unter(mm, MM_SWAPENTS);
> 6539cf8c98a8cc Lorenzo Stoakes  2025-11-10  33          else if (softleaf=
_is_migration(entry))
> 6539cf8c98a8cc Lorenzo Stoakes  2025-11-10  34                  dec_mm_co=
unter(mm, mm_counter(softleaf_to_folio(entry)));
> 200197908dc4af Claudio Imbrenda 2025-05-28 @35          free_swap_and_cac=
he(entry);
> 200197908dc4af Claudio Imbrenda 2025-05-28  36  }
> 200197908dc4af Claudio Imbrenda 2025-05-28  37

Ops, not sure why this callsite was missed during the renaming
conversion, probably lost it during a rebase as there are some
conflicts here. This should fix it:

diff --git a/arch/s390/mm/gmap_helpers.c b/arch/s390/mm/gmap_helpers.c
index 549f14ad08af..c3f56a096e8c 100644
--- a/arch/s390/mm/gmap_helpers.c
+++ b/arch/s390/mm/gmap_helpers.c
@@ -32,7 +32,7 @@ static void ptep_zap_softleaf_entry(struct mm_struct
*mm, softleaf_t entry)
                dec_mm_counter(mm, MM_SWAPENTS);
        else if (softleaf_is_migration(entry))
                dec_mm_counter(mm, mm_counter(softleaf_to_folio(entry)));
-       free_swap_and_cache(entry);
+       swap_put_entries_direct(entry, 1);
 }

Will include it in the next update.

