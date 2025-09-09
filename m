Return-Path: <linux-pm+bounces-34288-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14122B502A4
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 18:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78C7B541020
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 16:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61632D0C8F;
	Tue,  9 Sep 2025 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JfcmVSjw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1C426F2B2
	for <linux-pm@vger.kernel.org>; Tue,  9 Sep 2025 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435421; cv=none; b=KUf1hEd9HCX2J6xuPqPIzyPLSd81IKat12rpRGqE+tcRkAxi2SFOjSYDhjzjKljgV3j1ceQ94xQkeoTFIcHEPlT8LLNtIljDRXsHKqWqbtTSCRLsbLdag983BR8iqVPfnEjI69SgtAe7tyxq+NsjupZEJrVeVbrKtGjNde5Q+A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435421; c=relaxed/simple;
	bh=G9PEcnKcf0gtKT3AM2VvMAbi0kN3cdo24SxGQ889Ud4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EnpJADnrUyQAWdoQa1Mj8ObXsk6/SeoDEATQrTJwM1qr6LIDsycYrxdhSkcxKg/ceP7dQjhru95zVnB30CCe/vS1Ewwp5PLnitWn344YupK0tkGzSeQlm2xlT2cGFBGA16NEOjem0XG97QSPNvcb4itzfIa9ZRcmEBEwziuE29I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JfcmVSjw; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61ed6eeaff9so20825a12.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Sep 2025 09:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757435418; x=1758040218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHJHNlNOaMOyVoBAHvHo+maMOWkTYnhe6QXua4Kxw8s=;
        b=JfcmVSjwopHDQIStx+t09KlHzkV+DQ3usXYMp1aXOcUZ98o//nTTDJfElTAj0e3jU/
         ZD+E9r39lwpi8cR7envVxeCniVnP/UNoqGgYHblsa0yjG4Xz07GGMG/RyRVYJWHfrxxX
         b06g9OgwslN2cuDEHHtt9KCzFIOpq4iZbMUVd4/x9xXZJl1o8kJmKj3Y7EnL3Qk538GC
         FaF4LmRCRhTRXmbyn2RsXQTgZD9DaNwiBTRMaETOFWN5EoYL7AKcV2v5waYqrP2REix3
         Cd9fKvw/KuGYQZa0tu2epuAuU60zydq+iELXq+4IMMpvrAcGD5nWTCLzaDQ//19k5F3c
         DeBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757435418; x=1758040218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHJHNlNOaMOyVoBAHvHo+maMOWkTYnhe6QXua4Kxw8s=;
        b=IMqtgjwZsRIvEfVXH3e8BOqqGSD481wMm3BMrBH2sxmW/YGaCnxa06YMshLjVF7D+T
         UUOFp6pmhK37oI0L5XrfXl9pGen7zDDh8FvG2/32W9UIOmkT2CHu7hICWvJDZw//SGIU
         I84mLZKyslaWVsi/7qQ4xpiJ8HbKZPJnl762jBDFeHqeSPKL16e8vFJok5sRb8SK/A8I
         dnjp1u7nyey1jvyMDDupz3EQG2Ts7vKCSLOaOIYMIl+3gJq1EiYPKs7TBg1Xprn0fYix
         nZKqfgZyLUifLYOquYvqrawLoBvns0G8p11RxAEaZgtclpEkWrtPSz22CGifmIfYsc61
         kHlQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9TtcIaEgwG7A14qLAoT9o8AC3+z+zdpSxuAoavCSs3omv8bE5KoVTeqHhBLZlPnfkFU4C1sZCHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3jS0sGFRGNMddvPRTL9XArFtXbDelxH9tNTWzxIZB/RE9DWs5
	3CpJq6xNWNdFs4CyR4hw5FIpGiRbVlFp6qdcixFxSVm8sSRi0yvnQsOuc5DWeiG1ywrtSpeifjk
	1uwFk9DUoiVJHsb5XAcqJgGcgTeu7nX7fXy9kvFVb
X-Gm-Gg: ASbGncthLzMRyOQt4qhgY0MhjH2NusSj4mQLLrYRYephAhnE4AqAM8hnO0BbM7jAzgx
	ITZSbShUWX2dHZgCMxiUm9HFRyXzKg1s/AclsqU97fHAF1GExYiysE+pehQqmvdUG95wFikKHgk
	kPwZnArPcCnykOA/MumJgrLsEsXUhpLHlwUDlarcgN2bx9QnWu7gc4fqAVhSETCfvArKsjqEIOH
	gBwm9iQSAebZYNbKphRSEoiV9a3se79Kn/8yqWryPAk
X-Google-Smtp-Source: AGHT+IFbWAiDVlID1hnyzgk511dH5neUI5OLeqIjJ12rVpIAxmuNfaLD/tbpY5u2JY5Vm3Sgx+0SMd1CXr4QkvXrU5o=
X-Received: by 2002:a05:6402:4541:b0:61e:c6ae:7a58 with SMTP id
 4fb4d7f45d1cf-626a1f9b6a2mr267968a12.0.1757435417828; Tue, 09 Sep 2025
 09:30:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909090659.26400-1-zhongjinji@honor.com> <20250909090659.26400-4-zhongjinji@honor.com>
 <CAJuCfpHVzRtUQukO0kZP072vCu89DwOEAocS571b4sGxMc6Zow@mail.gmail.com>
In-Reply-To: <CAJuCfpHVzRtUQukO0kZP072vCu89DwOEAocS571b4sGxMc6Zow@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 9 Sep 2025 09:30:04 -0700
X-Gm-Features: AS18NWAA3gXYcKcu6BJyCASw1JY2Tg5yKdBcwtKDAMzJA7pfY6LSVb0ENi0HJp8
Message-ID: <CAJuCfpFKyPht_31Xq+a7YXhjxMWCrucdMSjJS--YnzMf6npqoQ@mail.gmail.com>
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

On Tue, Sep 9, 2025 at 9:29=E2=80=AFAM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Tue, Sep 9, 2025 at 2:07=E2=80=AFAM zhongjinji <zhongjinji@honor.com> =
wrote:
> >
> > Although the oom_reaper is delayed and it gives the oom victim chance t=
o
> > clean up its address space this might take a while especially for
> > processes with a large address space footprint. In those cases
> > oom_reaper might start racing with the dying task and compete for share=
d
> > resources - e.g. page table lock contention has been observed.
> >
> > Reduce those races by reaping the oom victim from the other end of the
> > address space.
> >
> > It is also a significant improvement for process_mrelease(). When a pro=
cess
> > is killed, process_mrelease is used to reap the killed process and ofte=
n
> > runs concurrently with the dying task. The test data shows that after
> > applying the patch, lock contention is greatly reduced during the proce=
dure
> > of reaping the killed process.
> >
> > The test is based on arm64.
> >
> > Without the patch:
> > |--99.57%-- oom_reaper
> > |    |--0.28%-- [hit in function]
> > |    |--73.58%-- unmap_page_range
> > |    |    |--8.67%-- [hit in function]
> > |    |    |--41.59%-- __pte_offset_map_lock
> > |    |    |--29.47%-- folio_remove_rmap_ptes
> > |    |    |--16.11%-- tlb_flush_mmu
> > |    |    |--1.66%-- folio_mark_accessed
> > |    |    |--0.74%-- free_swap_and_cache_nr
> > |    |    |--0.69%-- __tlb_remove_folio_pages
> > |    |--19.94%-- tlb_finish_mmu
> > |    |--3.21%-- folio_remove_rmap_ptes
> > |    |--1.16%-- __tlb_remove_folio_pages
> > |    |--1.16%-- folio_mark_accessed
> > |    |--0.36%-- __pte_offset_map_lock
> >
> > With the patch:
> > |--99.53%-- oom_reaper
> > |    |--55.77%-- unmap_page_range
> > |    |    |--20.49%-- [hit in function]
> > |    |    |--58.30%-- folio_remove_rmap_ptes
> > |    |    |--11.48%-- tlb_flush_mmu
> > |    |    |--3.33%-- folio_mark_accessed
> > |    |    |--2.65%-- __tlb_remove_folio_pages
> > |    |    |--1.37%-- _raw_spin_lock
> > |    |    |--0.68%-- __mod_lruvec_page_state
> > |    |    |--0.51%-- __pte_offset_map_lock
> > |    |--32.21%-- tlb_finish_mmu
> > |    |--6.93%-- folio_remove_rmap_ptes
> > |    |--1.90%-- __tlb_remove_folio_pages
> > |    |--1.55%-- folio_mark_accessed
> > |    |--0.69%-- __pte_offset_map_lock
> >
> > Signed-off-by: zhongjinji <zhongjinji@honor.com>
> > Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> > Acked-by: Michal Hocko <mhocko@suse.com>
>
> Reviewed-by: Suren Baghdsaryan <surenb@google.com>

Apparently I misspelled my own last name :)

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> > ---
> >  mm/oom_kill.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index ffa50a1f0132..52d285da5ba4 100644
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -516,7 +516,7 @@ static bool __oom_reap_task_mm(struct mm_struct *mm=
)
> >  {
> >         struct vm_area_struct *vma;
> >         bool ret =3D true;
> > -       VMA_ITERATOR(vmi, mm, 0);
> > +       MA_STATE(mas, &mm->mm_mt, ULONG_MAX, ULONG_MAX);
> >
> >         /*
> >          * Tell all users of get_user/copy_from_user etc... that the co=
ntent
> > @@ -526,7 +526,13 @@ static bool __oom_reap_task_mm(struct mm_struct *m=
m)
> >          */
> >         set_bit(MMF_UNSTABLE, &mm->flags);
> >
> > -       for_each_vma(vmi, vma) {
> > +       /*
> > +        * It might start racing with the dying task and compete for sh=
ared
> > +        * resources - e.g. page table lock contention has been observe=
d.
> > +        * Reduce those races by reaping the oom victim from the other =
end
> > +        * of the address space.
> > +        */
> > +       mas_for_each_rev(&mas, vma, 0) {
> >                 if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
> >                         continue;
> >
> > --
> > 2.17.1
> >

