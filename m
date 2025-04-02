Return-Path: <linux-pm+bounces-24723-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F98A78B9C
	for <lists+linux-pm@lfdr.de>; Wed,  2 Apr 2025 11:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50E0F16FDFE
	for <lists+linux-pm@lfdr.de>; Wed,  2 Apr 2025 09:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D0C236A8B;
	Wed,  2 Apr 2025 09:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJc/11tn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEC4236A7C
	for <linux-pm@vger.kernel.org>; Wed,  2 Apr 2025 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743587882; cv=none; b=YdEofAx9Vs4truP8xd+pyB/ZTJL50UJrUVJtTwhE0HrRVxgv6mPgu6zFF5/u/axeMjZ6n9WxvsEBJZ0y7sVXJ7ES0DBKlagiYjR+lAQOZsQSICU8QVfuqVPxB/QHwxLDWrei4Ec+P12mKb7xDoRakajrZnvaZqKfMyAMicvUkzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743587882; c=relaxed/simple;
	bh=gIhOdbmH0ulUPXvGPHQSFKS24ap5qrR2Nsq6/cqCObQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nRtoE8QSWGbekO8Aof9yV1oFY6g4cjUntZIbG7POcvPiVBiHy6VQE9pp4khgnL0cQjkdmtA45neX+mYVDnt1LOT2a5to8xY3lVZfIRG6xZE72+Lznj+dgmh7SoppyP/DwT6xSP8M4DHzKRqi2iaqqCH5dlRqWUonAlleFXZy3bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJc/11tn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E72AC4CEEA
	for <linux-pm@vger.kernel.org>; Wed,  2 Apr 2025 09:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743587881;
	bh=gIhOdbmH0ulUPXvGPHQSFKS24ap5qrR2Nsq6/cqCObQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EJc/11tnRqd29dtGAwpxKIK2b1SvBuI2aQswFkWSiVvnQlOqSMwX8eQ2c9W+DKMro
	 QKb7bk3BNTfXOqCMBjpFqYsr4eMBKutzdy6nqzKn1Pih6evs00T12yTv3YNBBhiEN6
	 Jde80HqQNlQbfXcFEQh1hBlEAJ2DyaDh4/Y4YhKJg6F1hB8IgHHXGD8DP2WOuKZvbI
	 b8588P7F2BhLFjsnqYFwkd1Hnv2yxY8o4cX9lT9an7kEG7wt7MD61nw6ctxsNsB00u
	 4su22N1/rBTP9erKR7eCJxSF95Msbmf2HzIN77mIzT9HCyFcQg81IJP0DHTQtx8IQM
	 FWXAt9JTjLBuA==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-72b82c8230aso1592359a34.2
        for <linux-pm@vger.kernel.org>; Wed, 02 Apr 2025 02:58:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWDyItWcPbwXNtwS6oFyIc8PGB08kM8Bz4zYWp7liQZw7rFBN6orvOVOJbqzCb5f2eaD6X1yWvYmA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCqxVpiNHpa1fF44JkGLmtvO4RSC0U3rkKrEv83U2XsRhTQ7q/
	E9NhHRuc8HF+q/nYd3DXxtjaWbfGcU6UQxZEmE+bDEuBfC2haZe53dt4ianG1RuKkg/nkaf58hV
	22JQV2LtNSr/0j7X3RsLA9bCAgoM=
X-Google-Smtp-Source: AGHT+IHAoDNTDkI2x7UVj179S3gNl61l8I9ZvOOAbJ+onC1ZOct+Ai4Eekt9h9paGtlM4VO9EYIZxGwDmw5+kFHOmZU=
X-Received: by 2002:a05:6830:6187:b0:727:2f79:ce3a with SMTP id
 46e09a7af769-72e25822c72mr1179675a34.12.1743587880712; Wed, 02 Apr 2025
 02:58:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5aac0c93-2723-2ca1-cbfa-98f88b0c900c@kylinos.cn>
 <CAJZ5v0iDeC-ieFEzzHP=Dpet5T5ssGRHqW-SvRUoSU4PCLR2Fw@mail.gmail.com> <08ec8325a38106cebd68431519c9fbf418431d7e.camel@kylinos.cn>
In-Reply-To: <08ec8325a38106cebd68431519c9fbf418431d7e.camel@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Apr 2025 11:57:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gxEZCRugXhAh7nMAigB0w+=RWg9NAio5orpCiMuvxYHg@mail.gmail.com>
X-Gm-Features: AQ5f1Jo6rWe4bnT7Lu6DpPbUF9u_pKZTqJI5gIceqiuF4xav-uGmmeH-SjrPCEU
Message-ID: <CAJZ5v0gxEZCRugXhAh7nMAigB0w+=RWg9NAio5orpCiMuvxYHg@mail.gmail.com>
Subject: Re: [PATCH] hibernate: pageoffline may be first judged
To: lijun <lijun01@kylinos.cn>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, pavel@ucw.cz, len.brown@intel.com, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 10:38=E2=80=AFAM lijun <lijun01@kylinos.cn> wrote:
>
> From e5b2d7aa9b66cac66314165fee12999f432b29d8 Mon Sep 17 00:00:00 2001
> From: Li Jun <lijun01@kylinos.cn>
> Date: Mon, 10 Feb 2025 10:40:58 +0800
> Subject: [PATCH v2] hibernate: pageoffline may be first judged
>
> 'PageReserved' and 'PageOffline' have weights greater
> than 'is_forbidden' and 'is_free'.so,PageReserved
> and PageOffline should be first judged.
> just as the page is free,but is reserved.

I fail to see why this matters.

NULL is returned if any of these conditions is met, so why would the
ordering of checks matter here?

> Signed-off-by: Li Jun <lijun01@kylinos.cn>
> ---
>  kernel/power/snapshot.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index c9fb559a6399..dfbccddb28f1 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1328,10 +1328,10 @@ static struct page
> *saveable_highmem_page(struct zone *zone, unsigned long pfn)
>
>     BUG_ON(!PageHighMem(page));
>
> -   if (swsusp_page_is_forbidden(page) ||  swsusp_page_is_free(page))
> +   if (PageReserved(page) || PageOffline(page))
>         return NULL;
>
> -   if (PageReserved(page) || PageOffline(page))
> +   if (swsusp_page_is_forbidden(page) ||  swsusp_page_is_free(page))
>         return NULL;
>
>     if (page_is_guard(page))
> @@ -1387,9 +1387,6 @@ static struct page *saveable_page(struct zone
> *zone, unsigned long pfn)
>
>     BUG_ON(PageHighMem(page));
>
> -   if (swsusp_page_is_forbidden(page) || swsusp_page_is_free(page))
> -       return NULL;
> -
>     if (PageOffline(page))
>         return NULL;
>
> @@ -1397,6 +1394,9 @@ static struct page *saveable_page(struct zone
> *zone, unsigned long pfn)
>         && (!kernel_page_present(page) || pfn_is_nosave(pfn)))
>         return NULL;
>
> +   if (swsusp_page_is_forbidden(page) || swsusp_page_is_free(page))
> +       return NULL;
> +
>
>
>
>     if (page_is_guard(page))
>         return NULL;
>
> --
> 2.34.1
>

