Return-Path: <linux-pm+bounces-42665-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1uepHO6ikWlAlAEAu9opvQ
	(envelope-from <linux-pm+bounces-42665-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 11:41:50 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4687C13E804
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 11:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A185E3002F5E
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 10:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE932C21C2;
	Sun, 15 Feb 2026 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONq2tNF0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949D127F00A
	for <linux-pm@vger.kernel.org>; Sun, 15 Feb 2026 10:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771152105; cv=pass; b=bAs22jZM4BcA3rVlvH3clp4Y8QVf6d2kgQKqqTq13MEJXPsSW4xQ2qwrldnt/jq1NSF83dwAWJ4AAGE7g93JkK+m51xBJhUl89BgIe2tK8JjsSbUJ6SUc0qntzonEjFWutQmGHn9dzlHgvj0dp5S8oimY2BHYxEHEghCbnmDJw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771152105; c=relaxed/simple;
	bh=APXcjzwxCWhaqpXQVQCYIYNzXPWAX+hbujMaVUS3t24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ffqyxdSZjzVzUC76ifM20jN//Zf+zyB8btdw0mxxDxdEnnkMhnTDwk7oDOrJjF76RiSbqUikaCvdrR6G6ehkrlmTKrH/7bJB6M5ZgFrXrfHEyATr/vSBw4CpNttEc3AeZUd2dRPZ0KzNKHvYEWt0XVSninQmWfVSYMPXmX492lI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONq2tNF0; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-65a3fdeb7d9so3351819a12.0
        for <linux-pm@vger.kernel.org>; Sun, 15 Feb 2026 02:41:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771152102; cv=none;
        d=google.com; s=arc-20240605;
        b=ghiZjJ6d8LXWEkL09IaN8XKpx+EsHSPeFrxNLi2KeAn0qnS20wjDtK+O8Xs4MQWWXl
         D1nTHW4QxxwZJh3NQ557K2NDzpcxi7NtmN2/ljBPCdxs1D2OYM5rAD77/6kg5M5BLtGN
         jFO0ZGOIZspByvLP8SeT5i9/5pIUjfUhw0h1iHvqzM+xP7BaSYDKEosZig0aXzf8pFbH
         9TJ8ugQrRykZ6zVjAnqgBSnq/Dg5d4ou68baznPkysLbtFWoIHqJxcFzngv+W3mQBxt8
         2T2K31GptV64dkUY4pX5Nf49QiQd3TKBYzEgUys0skxRYnWxUy7apOiCUD+//QTlSE++
         PnXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m5zqlxMymh8HnDUTEtkdbnJNo81mlSIT2LT41r34kR0=;
        fh=7cLbKvhpA1/+LhXTWsrqfH/UfHjikCSYG8dYkct9qEI=;
        b=CSs2OH2irjA70F3eHkedYOXLyfHNkCjAgCk3oRfspAUPimaHEQlaMw/qJZ/O/MP7IB
         ohgBF7Am3DpHraKjQHAtAwegLwJmMadtBrxqidL1R/nUnVHzWPSSaohk3ZqpqKJjSanN
         dxNRm8+rSVbQ32n8dPaK1EHFH/00sIIbLYBZy5dSkyqrXMQKUG+4CCSCHZWzdMh7Q+C0
         biikDWgCh1a61xDoKxPesh1uAstOCcFJI/fShHY0RMZZZFlVx+C/NaDfqGm1sb8kIyVS
         2bXBQ9rYopAI0++K9gCM+RahtD+6x0ayK30F7HlYNuXd8R4QbzRQBB4quKSZMA34Kq/q
         +2Bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771152102; x=1771756902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5zqlxMymh8HnDUTEtkdbnJNo81mlSIT2LT41r34kR0=;
        b=ONq2tNF0u15JCItbG3f19+zCzezjrAfOwr9mojxtq+KrR3wuJuLkucgG9JyYFg72Ep
         2ANh8Yy2T7UlfH20x7gg62RTFMfViafwYWvdHjWnlTT2bJcFlBdslok29806BRmrFFdn
         lUIEmDh2CDv5i507QxWzjSqlTp43TOIQ8HKNJtQXBBK7B6nA2wXktZwbAHYJ7VuiLVsS
         1WnzUWCSNVTL2pbHV8/h7ToD2fNxswHQrKgUtkVIfaBF9IF8kbFBqgjXoJsyGYkDORXB
         UA7dqKyeYKPJy5G4/Ff8url1oyCg+mlDlTuieJ5wsgRFGi0Nyq7HxvkbVwxnyCn3HN5Q
         PRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771152102; x=1771756902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m5zqlxMymh8HnDUTEtkdbnJNo81mlSIT2LT41r34kR0=;
        b=anz8COD+uUi503S8ugOSBQAVCAdGelppsmULjxR2Rc6TCVlVoEv6kiXXpIQG5GrziP
         vlQRnZtX/VIR8h6z+uKegH4k88fySM8gPCv9Ix1Qli78S8FOLqIekIelHXaR2uV7gAsT
         0ghhlgMgs+f1EyMsmloP4cw6ILQaE2op1tJVe+I7/FzbKHPdD76o17Ep9DIDiVWFGTdA
         2KxcXeQHYGdZmrE6QA1uWrk5Pi90MPjzM4BAVOLcW9jqubJIWPDgbt372Hola1GC02Ia
         fj4nN+9dPEJfDQEJOYhXMaQu6VDD2On7tkGKRqA8lOKDczp4lKa/TTJBezBsW37am63X
         99Gw==
X-Forwarded-Encrypted: i=1; AJvYcCU8oQRK8FhR5hfQ5o8HbpiFios8Sf3AWqUlCTd3yZt1iobsdWkbMMtSKkmRVKIGlrw4fLqNaTNgtw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgBt2DK7hquJwkCHJBXC3rhrvcbNDLZLWdYU8rhBJCmyqzmj/w
	BmGiHr4I2c2Y9F6IsIBmNbsFUu1pawkXNHJ32KzFvDwePbiaMQ6uL1uknimTe5HwTQjLbP3kuQV
	zd32U9qnchlVnH5w0DX/OrBTgPtbjlyQ=
X-Gm-Gg: AZuq6aLePMDFiVL6Zu4TOWTPK9/QpSMN0eu3TgM4lulI509BQy8vY8JSwd93CU2ah7r
	4BhgSa5WOErEaqWmP870SA7DsaLlEsh6ooR0aR03N3W9VPs+02GWAxMaj9Oftm04UNS40yChV0d
	6hyhHl4E9BPx53Nxi2lBGlR6GUwWO9/s+Y0+B2Q4vlGvn4ZBGS/OrTca3tNXL3ouxhy72w2Jgjg
	VEg4rRAiyovwydbVnvQxAFIHDVmOY/6etb9W4PeE2yTrJaA4FfdvHjmQA1olNqxFqRB9Nrsc6Wo
	FGIWIi3dnB7IWwFh0vQT/RWOr7N1SGWgnrX1kZG/2rwNiIo8RLc=
X-Received: by 2002:a17:907:94cb:b0:b87:d255:39ff with SMTP id
 a640c23a62f3a-b8fb449d45emr386598666b.32.1771152101668; Sun, 15 Feb 2026
 02:41:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260215-hibernate-perf-v1-0-f55ee9ee67db@tencent.com> <20260215103815.87329-1-ryncsn@gmail.com>
In-Reply-To: <20260215103815.87329-1-ryncsn@gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sun, 15 Feb 2026 18:41:05 +0800
X-Gm-Features: AaiRm52TPspBi1E7osxd9j9xFU8IPghna5b4nNAZMVt5OuxIX90GIJkGtnMKEhg
Message-ID: <CAMgjq7C2K5mAVcieX5rUUk9Qu3o7OgHkFqBU86AsvxNQG0uoUw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm, swap: simplify checking if a folio is swapped
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Carsten Grohmann <carstengrohmann@gmx.de>, linux-kernel@vger.kernel.org, 
	"open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42665-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,huaweicloud.com,gmail.com,redhat.com,gmx.de,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4687C13E804
X-Rspamd-Action: no action

On Sun, Feb 15, 2026 at 6:38=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> Clean up and simplify how we check if a folio is swapped. The helper
> already requires the folio to be in swap cache and locked. That's enough
> to pin the swap cluster from being freed, so there is no need to lock
> anything else to avoid UAF.
>
> And besides, we have cleaned up and defined the swap operation to be
> mostly folio based, and now the only place a folio will have any of its
> swap slots' count increased from 0 to 1 is folio_dup_swap, which also
> requires the folio lock. So as we are holding the folio lock here, a
> folio can't change its swap status from not swapped (all swap slots have
> a count of 0) to swapped (any slot has a swap count larger than 0).
>
> So there won't be any false negatives of this helper if we simply depend
> on the folio lock to stabilize the cluster.
>
> We are only using this helper to determine if we can and should release
> the swap cache. So false positives are completely harmless, and also
> already exist before. Depending on the timing, previously, it's also
> possible that a racing thread releases the swap count right after
> releasing the ci lock and before this helper returns. In any case, the
> worst that could happen is we leave a clean swap cache. It will still be
> reclaimed when under pressure just fine.
>
> So, in conclusion, we can simplify and make the check much simpler and
> lockless. Also, rename it to folio_maybe_swapped to reflect the design.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swap.h     |  5 ++--
>  mm/swapfile.c | 82 ++++++++++++++++++++++++++++-----------------------
>  2 files changed, 48 insertions(+), 39 deletions(-)
>
> diff --git a/mm/swap.h b/mm/swap.h
> index 9fc5fecdcfdf..3ee761ee8348 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -195,12 +195,13 @@ extern int swap_retry_table_alloc(swp_entry_t entry=
, gfp_t gfp);
>   *
>   * folio_alloc_swap(): the entry point for a folio to be swapped
>   * out. It allocates swap slots and pins the slots with swap cache.
> - * The slots start with a swap count of zero.
> + * The slots start with a swap count of zero. The slots are pinned
> + * by swap cache reference which doesn't contribute to swap count.
>   *
>   * folio_dup_swap(): increases the swap count of a folio, usually
>   * during it gets unmapped and a swap entry is installed to replace
>   * it (e.g., swap entry in page table). A swap slot with swap
> - * count =3D=3D 0 should only be increasd by this helper.
> + * count =3D=3D 0 can only be increased by this helper.
>   *
>   * folio_put_swap(): does the opposite thing of folio_dup_swap().
>   */
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 9628015fd8cf..cb18960a6089 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1743,7 +1743,11 @@ int folio_alloc_swap(struct folio *folio)
>   * @subpage: if not NULL, only increase the swap count of this subpage.
>   *
>   * Typically called when the folio is unmapped and have its swap entry t=
o
> - * take its palce.
> + * take its place: Swap entries allocated to a folio has count =3D=3D 0 =
and pinned
> + * by swap cache. The swap cache pin doesn't increase the swap count. Th=
is
> + * helper sets the initial count =3D=3D 1 and increases the count as the=
 folio is
> + * unmapped and swap entries referencing the slots are generated to repl=
ace
> + * the folio.
>   *
>   * Context: Caller must ensure the folio is locked and in the swap cache=
.
>   * NOTE: The caller also has to ensure there is no raced call to
> @@ -1944,49 +1948,44 @@ int swp_swapcount(swp_entry_t entry)
>         return count < 0 ? 0 : count;
>  }
>
> -static bool swap_page_trans_huge_swapped(struct swap_info_struct *si,
> -                                        swp_entry_t entry, int order)
> +/*
> + * folio_maybe_swapped - Test if a folio covers any swap slot with count=
 > 0.
> + *
> + * Check if a folio is swapped. Holding the folio lock ensures the folio=
 won't
> + * go from not-swapped to swapped because the initial swap count increme=
nt can
> + * only be done by folio_dup_swap, which also locks the folio. But a con=
current
> + * decrease of swap count is possible through swap_put_entries_direct, s=
o this
> + * may return a false positive.
> + *
> + * Context: Caller must ensure the folio is locked and in the swap cache=
.
> + */
> +static bool folio_maybe_swapped(struct folio *folio)
>  {
> +       swp_entry_t entry =3D folio->swap;
>         struct swap_cluster_info *ci;
> -       unsigned int nr_pages =3D 1 << order;
> -       unsigned long roffset =3D swp_offset(entry);
> -       unsigned long offset =3D round_down(roffset, nr_pages);
> -       unsigned int ci_off;
> -       int i;
> +       unsigned int ci_off, ci_end;
>         bool ret =3D false;
>
> -       ci =3D swap_cluster_lock(si, offset);
> -       if (nr_pages =3D=3D 1) {
> -               ci_off =3D roffset % SWAPFILE_CLUSTER;
> -               if (swp_tb_get_count(__swap_table_get(ci, ci_off)))
> -                       ret =3D true;
> -               goto unlock_out;
> -       }
> -       for (i =3D 0; i < nr_pages; i++) {
> -               ci_off =3D (offset + i) % SWAPFILE_CLUSTER;
> -               if (swp_tb_get_count(__swap_table_get(ci, ci_off))) {
> -                       ret =3D true;
> -                       break;
> -               }
> -       }
> -unlock_out:
> -       swap_cluster_unlock(ci);
> -       return ret;
> -}
> -
> -static bool folio_swapped(struct folio *folio)
> -{
> -       swp_entry_t entry =3D folio->swap;
> -       struct swap_info_struct *si;
> -
>         VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
>         VM_WARN_ON_ONCE_FOLIO(!folio_test_swapcache(folio), folio);
>
> -       si =3D __swap_entry_to_info(entry);
> -       if (!IS_ENABLED(CONFIG_THP_SWAP) || likely(!folio_test_large(foli=
o)))
> -               return swap_entry_swapped(si, entry);
> +       ci =3D __swap_entry_to_cluster(entry);
> +       ci_off =3D swp_cluster_offset(entry);
> +       ci_end =3D ci_off + folio_nr_pages(folio);
> +       /*
> +        * Extra locking not needed, folio lock ensures its swap entries
> +        * won't be released, the backing data won't be gone either.
> +        */
> +       rcu_read_lock();
> +       do {
> +               if (__swp_tb_get_count(__swap_table_get(ci, ci_off))) {
> +                       ret =3D true;
> +                       break;
> +               }
> +       } while (++ci_off < ci_end);
> +       rcu_read_unlock();
>
> -       return swap_page_trans_huge_swapped(si, entry, folio_order(folio)=
);
> +       return ret;
>  }
>
>  static bool folio_swapcache_freeable(struct folio *folio)
> @@ -2032,7 +2031,7 @@ bool folio_free_swap(struct folio *folio)
>  {
>         if (!folio_swapcache_freeable(folio))
>                 return false;
> -       if (folio_swapped(folio))
> +       if (folio_maybe_swapped(folio))
>                 return false;
>
>         swap_cache_del_folio(folio);
> @@ -3710,6 +3709,8 @@ void si_swapinfo(struct sysinfo *val)
>   *
>   * Context: Caller must ensure there is no race condition on the referen=
ce
>   * owner. e.g., locking the PTL of a PTE containing the entry being incr=
eased.
> + * Also the swap entry must have a count >=3D 1. Otherwise folio_dup_swa=
p should
> + * be used.
>   */
>  int swap_dup_entry_direct(swp_entry_t entry)
>  {
> @@ -3721,6 +3722,13 @@ int swap_dup_entry_direct(swp_entry_t entry)
>                 return -EINVAL;
>         }
>
> +       /*
> +        * The caller must be increasing the swap count from a direct
> +        * reference of the swap slot (e.g. a swap entry in page table).
> +        * So the swap count must be >=3D 1.
> +        */
> +       VM_WARN_ON_ONCE(!swap_entry_swapped(si, entry));
> +
>         return swap_dup_entries_cluster(si, swp_offset(entry), 1);
>  }
>
> --
> 2.52.0
>

Very sorry about this :/, something is wrong with my local branch
so this is the wrong patch.

Please ignore this series, thanks!

