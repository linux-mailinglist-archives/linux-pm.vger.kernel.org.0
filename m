Return-Path: <linux-pm+bounces-23938-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E32AA5E578
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 21:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9494C3A355F
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 20:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D916D1EDA20;
	Wed, 12 Mar 2025 20:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mabNsjkq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D55FBF6
	for <linux-pm@vger.kernel.org>; Wed, 12 Mar 2025 20:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741811687; cv=none; b=PxjX37SSSvzVrdpD50vHqB9/hWaEYk2hcs3NmiopOFx/zHGC5kAqtPXL+Mao3phsRFPCZHqtqOpU2MWts3D5oH1UcSj3fna1vKPczQBZyZbe3HYgCI7+VVaww70rgrn6V/5aW4a21kLTrUpZ2dAqFskcstpClpVQxgJcuJKkqBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741811687; c=relaxed/simple;
	bh=5wW7JPbrCPl4AP/zh9g2savZbdhs1lJus3TWewbdCZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQWCLeefB2YKrB47qyeuQM5+Ra2cKsKD5Y/ay1QnnxGsJpb5gQxEXfcPtqymOmbf9l96NgrHviQrrIxcDZ8XLKQn/dOhd5TwFMaAqR22mrbNewbL7rkvc/pvjg0fXc4HR7GmAkQg3xqzS78naLQ45XAqw3bKntmYm6fan8Xng74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mabNsjkq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DCF3C4CEEA
	for <linux-pm@vger.kernel.org>; Wed, 12 Mar 2025 20:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741811687;
	bh=5wW7JPbrCPl4AP/zh9g2savZbdhs1lJus3TWewbdCZ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mabNsjkqf4QXWUTwa2/KdLpm3QUc6nOHXvY8qX0HNtOQDJVBeO35WHZ34Ol9nHaPC
	 pFTQfVXs2d/ERJOdL9bGzgNjrKQzKOqwOnvrexQWYrCSooHwSj6MZP/wq0gcz3XFmk
	 jrCRB/HpBeX2zzdsDNf8iwsOGE2pMo1suEQv724qa1MES9fUAQXCBRbZ/jvLo2/BQg
	 L9D9OGkqrW8t+UOo/eqVWBI0hSHY6IIpTobyk/+ZKu6vzTZrJvsoP9ygCO6U2LcRWw
	 lUh+EBW5GBOIA1F0AA5HpC7b4+ThP0R9N9l+gn+EuyGIh5x9UeUVwkAGGIudhnVKFx
	 DO03kCVq7xOLw==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2a9ef75a20dso278153fac.2
        for <linux-pm@vger.kernel.org>; Wed, 12 Mar 2025 13:34:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX69QaI7JdXcKlzEKz9sGjB90bhMSnKjsQ/Ui0vXbTq6vCS6PgBgE4xws01k2beeEiM4y9NUNo1Ag==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcnT9tj3xJKmBL//M3EEJG5G+iLevaoe83AyyMOvS0vxo4mHyj
	LLh0ww0ovXstKs/dqcQNGDcrr5K8j1kKJcREyHwEnNE7tjEvNrxVHQ+Y0aOH1hfKGOxyGyXuvnM
	7mqG5EFSRr5PUGVzZurMZvze7is4=
X-Google-Smtp-Source: AGHT+IFgtEf2XNSu7A0UdO8HrA+UG/eZ5KFjgQ1NU5MNyJXTY56zLvd1vpKi5KoIX08UuDrO2VgFBPVjhIMnqWRmZa0=
X-Received: by 2002:a05:6870:6eca:b0:297:2719:deb6 with SMTP id
 586e51a60fabf-2c260f779e6mr11882632fac.1.1741811686503; Wed, 12 Mar 2025
 13:34:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5aac0c93-2723-2ca1-cbfa-98f88b0c900c@kylinos.cn>
In-Reply-To: <5aac0c93-2723-2ca1-cbfa-98f88b0c900c@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Mar 2025 21:34:35 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iDeC-ieFEzzHP=Dpet5T5ssGRHqW-SvRUoSU4PCLR2Fw@mail.gmail.com>
X-Gm-Features: AQ5f1Jq48z0ObbhzeKDnMAI2gfpyrxc1zWgT7VWvZuNTstbZ9xhLsiV4RIVZDTQ
Message-ID: <CAJZ5v0iDeC-ieFEzzHP=Dpet5T5ssGRHqW-SvRUoSU4PCLR2Fw@mail.gmail.com>
Subject: Re: [PATCH] hibernate: pageoffline may be first judged
To: lijun <lijun01@kylinos.cn>
Cc: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 8:04=E2=80=AFAM lijun <lijun01@kylinos.cn> wrote:
>
> From: Li Jun <lijun01@kylinos.cn>
> Date: Mon, 10 Feb 2025 10:40:58 +0800
> Subject: [PATCH] hibernate: pageoffline may be first judged
>
> PageReserved and PageOffline should be first judged.

Why should they?

You need to add this information to the changelog for the patch to be
applicable.

> Signed-off-by: Li Jun <lijun01@kylinos.cn>
> ---
>   kernel/power/snapshot.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index c9fb559a6399..dfbccddb28f1 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1328,10 +1328,10 @@ static struct page *saveable_highmem_page(struct
> zone *zone, unsigned long pfn)
>
>      BUG_ON(!PageHighMem(page));
>
> -   if (swsusp_page_is_forbidden(page) || swsusp_page_is_free(page))
> +   if (PageReserved(page) || PageOffline(page))
>          return NULL;
>
> -   if (PageReserved(page) || PageOffline(page))
> +   if (swsusp_page_is_forbidden(page) || swsusp_page_is_free(page))
>          return NULL;
>
>      if (page_is_guard(page))
> @@ -1387,9 +1387,6 @@ static struct page *saveable_page(struct zone
> *zone, unsigned long pfn)
>
>      BUG_ON(PageHighMem(page));
>
> -   if (swsusp_page_is_forbidden(page) || swsusp_page_is_free(page))
> -       return NULL;
> -
>      if (PageOffline(page))
>          return NULL;
>
> @@ -1397,6 +1394,9 @@ static struct page *saveable_page(struct zone
> *zone, unsigned long pfn)
>          && (!kernel_page_present(page) || pfn_is_nosave(pfn)))
>          return NULL;
>
> +   if (swsusp_page_is_forbidden(page) || swsusp_page_is_free(page))
> +       return NULL;
> +
>      if (page_is_guard(page))
>          return NULL;
>
> --
> 2.34.1
>

