Return-Path: <linux-pm+bounces-34287-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8449B5029C
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 18:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A35581896AEC
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 16:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EDB32BF3D;
	Tue,  9 Sep 2025 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZI/2bdoe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F062192EE
	for <linux-pm@vger.kernel.org>; Tue,  9 Sep 2025 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435375; cv=none; b=lGcGVd/slVqFVALDc5JtyvnYbRWSwATkHaczDLqt47HEFLdu63HpGe2S2+pAPs72XzYX7Pgp+Q309/q1IO/CWnwgAhDpylf/+62NFJrtT3C32KTHAM0q2+pKnXf2n7rrGgYmA2VmypJC5/4pMtdZ1pzsnk/hq9Pp5KTd2eoxvho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435375; c=relaxed/simple;
	bh=EsLVxuOrVN6D9XKbtQ7qaCCx4H7wMQy2cVtKoXpiJgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bWKPedmBtntD8i7+lgZP/aJHmv4R/GhSSsEwhCSvlyqustLBxXzOuUEmKOZTgoR3GW+8eDkoqBQQjmU8vrt1yMzE/7fIWxXbgNZlfSwYUMIdmPlD1iC8rg8xdDkL3Xwi7np0IDXRAgUwF1xVhNLuavlPIaFbsT/ygMq7bjzMIQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZI/2bdoe; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-621c6ae39b5so28a12.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Sep 2025 09:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757435372; x=1758040172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9QtIdHCJUCA2JKczntVa9IJYW4w3x9PZbG69hcS1lU=;
        b=ZI/2bdoeyNfrDTNmM03+EPWyunOwACwdIeFq2wqYh3EkAfqgJ8W9moItmLsG70sso3
         zidk5PljsRKSyZsnF1/JjeixpTYRIIQG3f4pHhEyRlSY23A1QjKw12a9CB+iP/gLgCih
         ntCK+wG5EthiF55iUjZpLdhj9p8mtH//7Dwa0bhHbR6Ovwm2HramSrX4phy7Sez+OAPX
         2ZOXS7q4f+zoajo+aWpU0mPnO2BR0bqgHmqhcoYf18rr5UEUT9s0E9AQK80ZP3HAvtW5
         Vocx99Hda1pXcC0auYDHAM+yIIb5MI1AK7WLCkCttg6d5OMeQrEEW5SSUetDPdVrsnN4
         C35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757435372; x=1758040172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e9QtIdHCJUCA2JKczntVa9IJYW4w3x9PZbG69hcS1lU=;
        b=fQgh3rakGxWmrPCBe/HMivaNYxlhkAM/8ROXrV0nv3/ogmYnnwS+Rq95DYv7/8gE3G
         Q+FhSWBnurOs3dXRqV3dI9FNPpLXXPa9lHRFwFzo32oDYY1Q59xrqEfuSbc0a6lUgYzH
         qVBXn8lu/GNjdtBu6Z9EZG1EFvqtIT8iHrSzyCvOsPa2pz0dhFgsGHf3XGuQGGt5n7u1
         X9h2VwFj498vM55hcVJjlFGO/RWUQ2yhC6VRlnr/egwPHvKN9z2TJLtfIch1wUY+iuye
         UqNWmvQVR88jKLxnOXq2as7oo+FD4yNyWOV4+gm+ynLu1jqEdiIQXds9FkQZ3QyTqw1e
         +atw==
X-Forwarded-Encrypted: i=1; AJvYcCXIXeCjt9K74hI+EvJiFoVh4HLN+BlpeKKXqiQyw27rR+NgP+d14wN7N5aH1tIw3TC59VLE+GPR/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDKJSJH63MGWKSdYv27fgzP72x15uM2Q120RJ/WdKVOHnFNxjT
	wdgaJsq3V9NqD73S+p8IMMZI8IaCvw7ROI+ifqOpseCAZX6BgsZ4Zl1q/jqaPqMN/348rfuS+TN
	sZRpwX8iN8FZwzU3UD64ls/fAGxW5i1c0ch9GhdAk
X-Gm-Gg: ASbGnct+XVdYZpw8hhkip4g7ogajqNm73ilr916E/ITNjgVSrhb0zFOakkBg+B3ELH4
	WzFWs1T91Y19XnYx7XEC3uc/5urDfO4kC6kJa57qsybaj0HLnY8sm2s6mfZyXrUM85g8dkU29r8
	yw/9BlW9qv8poShSzANT7h69FsQoQGbibzP3xgYxz1RVK7mqPi8vX0E++bAeKbXpRoFwlu3jQlW
	Guxdu6Y+z26rwXcMoL4yKskoYs1twbQcLtX/PZWTj8K
X-Google-Smtp-Source: AGHT+IEZR0ggMbAaCS/pzuxrCrwK8WEzlmOxK64na+KYxM4rF7an2S8xhVcBEwF2bYBe42b+GcnA0H0ZoT7PNYRUAek=
X-Received: by 2002:a50:ccdb:0:b0:61c:1dbc:67a with SMTP id
 4fb4d7f45d1cf-623d4bf0798mr239582a12.3.1757435371609; Tue, 09 Sep 2025
 09:29:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909090659.26400-1-zhongjinji@honor.com> <20250909090659.26400-4-zhongjinji@honor.com>
In-Reply-To: <20250909090659.26400-4-zhongjinji@honor.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 9 Sep 2025 09:29:18 -0700
X-Gm-Features: AS18NWCZpqRQFgOViNXjblOghswTXc_q2re1TtWPGuwM3l9i6O4APd0wr9oM6UY
Message-ID: <CAJuCfpHVzRtUQukO0kZP072vCu89DwOEAocS571b4sGxMc6Zow@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] mm/oom_kill: The OOM reaper traverses the VMA
 maple tree in reverse order
To: zhongjinji <zhongjinji@honor.com>
Cc: mhocko@suse.com, rientjes@google.com, shakeel.butt@linux.dev, 
	akpm@linux-foundation.org, tglx@linutronix.de, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, lenb@kernel.org, rafael@kernel.org, 
	pavel@kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, liulu.liu@honor.com, feng.han@honor.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 2:07=E2=80=AFAM zhongjinji <zhongjinji@honor.com> wr=
ote:
>
> Although the oom_reaper is delayed and it gives the oom victim chance to
> clean up its address space this might take a while especially for
> processes with a large address space footprint. In those cases
> oom_reaper might start racing with the dying task and compete for shared
> resources - e.g. page table lock contention has been observed.
>
> Reduce those races by reaping the oom victim from the other end of the
> address space.
>
> It is also a significant improvement for process_mrelease(). When a proce=
ss
> is killed, process_mrelease is used to reap the killed process and often
> runs concurrently with the dying task. The test data shows that after
> applying the patch, lock contention is greatly reduced during the procedu=
re
> of reaping the killed process.
>
> The test is based on arm64.
>
> Without the patch:
> |--99.57%-- oom_reaper
> |    |--0.28%-- [hit in function]
> |    |--73.58%-- unmap_page_range
> |    |    |--8.67%-- [hit in function]
> |    |    |--41.59%-- __pte_offset_map_lock
> |    |    |--29.47%-- folio_remove_rmap_ptes
> |    |    |--16.11%-- tlb_flush_mmu
> |    |    |--1.66%-- folio_mark_accessed
> |    |    |--0.74%-- free_swap_and_cache_nr
> |    |    |--0.69%-- __tlb_remove_folio_pages
> |    |--19.94%-- tlb_finish_mmu
> |    |--3.21%-- folio_remove_rmap_ptes
> |    |--1.16%-- __tlb_remove_folio_pages
> |    |--1.16%-- folio_mark_accessed
> |    |--0.36%-- __pte_offset_map_lock
>
> With the patch:
> |--99.53%-- oom_reaper
> |    |--55.77%-- unmap_page_range
> |    |    |--20.49%-- [hit in function]
> |    |    |--58.30%-- folio_remove_rmap_ptes
> |    |    |--11.48%-- tlb_flush_mmu
> |    |    |--3.33%-- folio_mark_accessed
> |    |    |--2.65%-- __tlb_remove_folio_pages
> |    |    |--1.37%-- _raw_spin_lock
> |    |    |--0.68%-- __mod_lruvec_page_state
> |    |    |--0.51%-- __pte_offset_map_lock
> |    |--32.21%-- tlb_finish_mmu
> |    |--6.93%-- folio_remove_rmap_ptes
> |    |--1.90%-- __tlb_remove_folio_pages
> |    |--1.55%-- folio_mark_accessed
> |    |--0.69%-- __pte_offset_map_lock
>
> Signed-off-by: zhongjinji <zhongjinji@honor.com>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: Suren Baghdsaryan <surenb@google.com>

> ---
>  mm/oom_kill.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index ffa50a1f0132..52d285da5ba4 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -516,7 +516,7 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
>  {
>         struct vm_area_struct *vma;
>         bool ret =3D true;
> -       VMA_ITERATOR(vmi, mm, 0);
> +       MA_STATE(mas, &mm->mm_mt, ULONG_MAX, ULONG_MAX);
>
>         /*
>          * Tell all users of get_user/copy_from_user etc... that the cont=
ent
> @@ -526,7 +526,13 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
>          */
>         set_bit(MMF_UNSTABLE, &mm->flags);
>
> -       for_each_vma(vmi, vma) {
> +       /*
> +        * It might start racing with the dying task and compete for shar=
ed
> +        * resources - e.g. page table lock contention has been observed.
> +        * Reduce those races by reaping the oom victim from the other en=
d
> +        * of the address space.
> +        */
> +       mas_for_each_rev(&mas, vma, 0) {
>                 if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
>                         continue;
>
> --
> 2.17.1
>

