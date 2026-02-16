Return-Path: <linux-pm+bounces-42683-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPLEG7/Ikmm6xgEAu9opvQ
	(envelope-from <linux-pm+bounces-42683-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 08:35:27 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7321414B7
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 08:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FFD33016901
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 07:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30B52F2619;
	Mon, 16 Feb 2026 07:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvMwA24C"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C01822A7E6
	for <linux-pm@vger.kernel.org>; Mon, 16 Feb 2026 07:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771227308; cv=pass; b=E623kx5TZWzXhadqpwN8BMbQ2xaXUHGCCse83WEaEhw7ECMp03WHRoPCduMKs16Av61bGB9tZju0Wke1Zp+UcCtktbw7Cbk6iUm0M1M92X8OsRgX/6MElNVDYg1NgisV/JVA6F5Dd6LSENyBi5rAECW8hWVG3sKpbXiThjcwwmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771227308; c=relaxed/simple;
	bh=Q4bfO0vInGqKAtVTn91ZzDEC3XLhz7XmH1aZo0HXL1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Go5sFqD7c8lp4d0BL6Vdagr21VstoF9yDjkbbLxzywdjMtPSKSItvFGS2XjwWDYvbjJBm07eh8nMqjLLkGjKYuP2fi1g2FF4lqqaJfOs/81U8ODJEollHBgJKkMe59wTLOQBibUyHvg52MFZqPn+3MmYR4RjOhrwKe1Jt5XjGGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvMwA24C; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-502a789834fso26419841cf.2
        for <linux-pm@vger.kernel.org>; Sun, 15 Feb 2026 23:35:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771227305; cv=none;
        d=google.com; s=arc-20240605;
        b=ZTaGno6mAoODqhRpbwDtR6J4zNdgl/Xtqg4dnhZxI94eBnOcWrP0QuRIuffi+OY6jV
         WhqJ1ERf4oMfyvfF2C0AA057kChKbtBNtObAQKRDXY3Q3NdXn0Ms7Eitn1OA9gO0azay
         ph0PXY5+ojhoIufxgb0WwEFKV4UAsErM1WRVUyjrdnOT+1DnhGqBej9BBVKY43iG1iIh
         2aRZ1dqZpLvj6y9A1g5KH34ow9LXdEAawGUxCMZfG1lvzIwxp9wzlP9ZVFq7fVbE+pvi
         7ccTrgfV4edc8RR02pDJLvo5LOUOBeL4Tp0nZLmoG1jbm5bOX04J/xmQN7N8BtsI547n
         MmKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=024esMGlkL0Bwiyo9ctvcoR2iC+oqeDjq2y9rJqpeMg=;
        fh=QpWMCsAvM0p5rF0sv109PB8IPhRBDsLmutgbk52Q1t8=;
        b=EPxtpIjLmx74biCcc7F3KLnLfxBTP8I0+uvA8as66QEcUDZTBkV+dkAaMsz5w/Xo6i
         MEec8RzcECLAXRQL7acIxAwcKJGhqt/oYHNMaALwAsea7oFnfW+b1OLOkVIlKivhUamJ
         o6trGkcgSYfl+lWvENDA5/LVZffRZPx0LyulbhjmZTafCMwHP76gp/8esEW6NpBWDIuh
         944aAiXgg9GIZSjvgNfofwk8U1kbXKqN5gKoUiY8tzRLmZEcXV+6sFurnkErvAvzfKqY
         g57G6Cp0u6B4sQMJIJUJMOLIVTjCYuw6q57EiPm9l0Gc+LMVwhAWmEgkSHFu8zJVlLyf
         eDcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771227305; x=1771832105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=024esMGlkL0Bwiyo9ctvcoR2iC+oqeDjq2y9rJqpeMg=;
        b=MvMwA24CUuySvEFiSP0OzbbYpW9H4okFDEdGYx/EPRf8v5pMBDUvY067O+rHwfZcmF
         mS53xUbiIu7kHvnDeGcetQ7FqRqTo2nlNbG+3iMIJcqAWkXm9gKI2KaQ9AY6g9Oom0Gv
         IeUmlSs1y8p3KBloRj2JcJtO3YUm4D0z2qV8WNUg+y2EGe8CxdJNRX9qxUitvwpvoZXW
         0LFiDLlD1TgPSSjqLSVo35Pofk9GoCi6op9X/R2EhCZas6yzb0iaZZIsR4EQMBJBYBae
         1lY13z9QCnk03ZPrVtfnQDiOHfVDyjnPmezE1M9Sodh28PXn8UrLJXIpZ3JCCC6VsoLL
         In0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771227305; x=1771832105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=024esMGlkL0Bwiyo9ctvcoR2iC+oqeDjq2y9rJqpeMg=;
        b=rbQqzxuKEQe/EKvwsbl4wqfhF8QyAVC4sJbxOrVPI29w7/o2mTYuov6dPy379taWmd
         BOoILxnmLviPbka+mPEvXNdG+Vr6ddw/MiiJKvn9Bhudx06CUEoxqHScpUDbBnE7PHXq
         OlWX0I8pECjqYn992l/+qGl8q6O87xJekujN2/AkBDFUgBrWVa9LICQE+NLQBrFMGNMO
         fNTOrlr36vdZToK7VMaGOyToPLJTBRJHd8wQiccMQKrTUP5vgntflf7UBqzUHUr4vCga
         1C1NqU2awthIft7qj6GANNAyyDribCJ73lSKdycuarq0SX9lW4garcJ/A2cG4eN1L5uA
         pMHw==
X-Forwarded-Encrypted: i=1; AJvYcCUQJtxVyrOzSSUHa66gWLXUkCOMygWj25NTk4D9qQ/jFsuTG+lo7XZAHcoPaDhKPZtbPTHeHcLU7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeX6lkQHJozGj2TskKT5/sOLZzIdMBCFuKZ1v9t/pBmz2vFfXa
	jALkfP4nO7hPxQbnzfbiS4epGuoSeXl0TAcahWsF6TRtfa0zR6jGY4nL5ZupiskrzW0TjSobaY8
	EpjC4ZYHwabAQ0dSThknsV1p+lPuC8AI=
X-Gm-Gg: AZuq6aIM/fBc/Ep1nCQEUdrEA3HxjwYXiOU3Tx208nzkpWt4cP9Rcc6s1CZR/9ReFAH
	4OYDQZjuDpFE/qF3NukLvLmjmCb7py7Um7Qn5pD/5uuB+yrAE9ZRTgerkBrHipMhoLt8eNCBS9g
	ZZRuL9IZYX1njDExsPxdY5JQucaWc9mAozGUwNtbr2lr+xNPNC+wndhAVxv5dGWlaQay7m0ATNQ
	N5g+Acq5YjwsuRaRK7wTS6QApeA2ETx9vSjY+zbhxe3kO7PHAiZT4URrtGWEWKIEiZw2w/FrHNO
	m+Jg9g==
X-Received: by 2002:ac8:5a82:0:b0:4ff:b1eb:2d03 with SMTP id
 d75a77b69052e-506a6b46d4bmr131456111cf.72.1771227304980; Sun, 15 Feb 2026
 23:35:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216-hibernate-perf-v3-0-74e025091145@tencent.com> <20260216-hibernate-perf-v3-3-74e025091145@tencent.com>
In-Reply-To: <20260216-hibernate-perf-v3-3-74e025091145@tencent.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 16 Feb 2026 15:34:54 +0800
X-Gm-Features: AaiRm539nHIx117-7otZWRWfhYh23TG2xx8FFgV-CfFgMKEERzUaheINn2QkqoY
Message-ID: <CAGsJ_4xpoC78KhYj_b18aVzjGcFGfXnpt7uLGvg7w1B4Y5cc2g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] mm, swap: merge common convention and simplify
 allocation helper
To: kasong@tencent.com
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Carsten Grohmann <mail@carstengrohmann.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-kernel@vger.kernel.org, 
	"open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, Carsten Grohmann <carstengrohmann@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-42683-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,huaweicloud.com,gmail.com,redhat.com,carstengrohmann.de,vger.kernel.org,gmx.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[21cnbao@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7B7321414B7
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 3:00=E2=80=AFAM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
>
> From: Kairui Song <kasong@tencent.com>
>
> Almost all callers of the cluster scan helper require the: lock -> check
> usefulness/emptiness check -> allocate -> unlock routine. So merge them
> into the same helper to simplify the code.

Previously, when !cluster_is_usable(ci, order), we only called
swap_cluster_unlock(). Now we do more work in this path:


out:
        relocate_cluster(si, ci);
        swap_cluster_unlock(ci);
        if (si->flags & SWP_SOLIDSTATE) {
                this_cpu_write(percpu_swap_cluster.offset[order], next);
                this_cpu_write(percpu_swap_cluster.si[order], si);
        } else {
                si->global_cluster->next[order] =3D next;
        }
        return found;

I assume this is what you want to do as well, but can we add
some explanation here?

Also, it would be better to add a comment that
alloc_swap_scan_cluster() expects ci->lock to be held on
entry and releases ci->lock before returning.


>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swapfile.c | 30 ++++++++----------------------
>  1 file changed, 8 insertions(+), 22 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 0d1b17c99221..68dbbbd0dd24 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -923,11 +923,14 @@ static unsigned int alloc_swap_scan_cluster(struct =
swap_info_struct *si,
>         bool need_reclaim, ret, usable;
>
>         lockdep_assert_held(&ci->lock);
> -       VM_WARN_ON(!cluster_is_usable(ci, order));
>
> -       if (end < nr_pages || ci->count + nr_pages > SWAPFILE_CLUSTER)
> +       if (!cluster_is_usable(ci, order) || end < nr_pages ||
> +           ci->count + nr_pages > SWAPFILE_CLUSTER)
>                 goto out;
>
> +       if (cluster_is_empty(ci))
> +               offset =3D cluster_offset(si, ci);
> +
>         for (end -=3D nr_pages; offset <=3D end; offset +=3D nr_pages) {
>                 need_reclaim =3D false;
>                 if (!cluster_scan_range(si, ci, offset, nr_pages, &need_r=
eclaim))
> @@ -1060,14 +1063,7 @@ static unsigned long cluster_alloc_swap_entry(stru=
ct swap_info_struct *si,
>                         goto new_cluster;
>
>                 ci =3D swap_cluster_lock(si, offset);
> -               /* Cluster could have been used by another order */
> -               if (cluster_is_usable(ci, order)) {
> -                       if (cluster_is_empty(ci))
> -                               offset =3D cluster_offset(si, ci);
> -                       found =3D alloc_swap_scan_cluster(si, ci, folio, =
offset);
> -               } else {
> -                       swap_cluster_unlock(ci);
> -               }
> +               found =3D alloc_swap_scan_cluster(si, ci, folio, offset);
>                 if (found)
>                         goto done;
>         }
> @@ -1332,14 +1328,7 @@ static bool swap_alloc_fast(struct folio *folio)
>                 return false;
>
>         ci =3D swap_cluster_lock(si, offset);
> -       if (cluster_is_usable(ci, order)) {
> -               if (cluster_is_empty(ci))
> -                       offset =3D cluster_offset(si, ci);
> -               alloc_swap_scan_cluster(si, ci, folio, offset);
> -       } else {
> -               swap_cluster_unlock(ci);
> -       }
> -
> +       alloc_swap_scan_cluster(si, ci, folio, offset);
>         put_swap_device(si);
>         return folio_test_swapcache(folio);
>  }
> @@ -1945,10 +1934,7 @@ swp_entry_t swap_alloc_hibernation_slot(int type)
>                 pcp_offset =3D this_cpu_read(percpu_swap_cluster.offset[0=
]);
>                 if (pcp_si =3D=3D si && pcp_offset) {
>                         ci =3D swap_cluster_lock(si, pcp_offset);
> -                       if (cluster_is_usable(ci, 0))
> -                               offset =3D alloc_swap_scan_cluster(si, ci=
, NULL, pcp_offset);
> -                       else
> -                               swap_cluster_unlock(ci);
> +                       offset =3D alloc_swap_scan_cluster(si, ci, NULL, =
pcp_offset);
>                 }
>                 if (!offset)
>                         offset =3D cluster_alloc_swap_entry(si, NULL);
>
> --
> 2.52.0
>
>

Thanks
Barry

