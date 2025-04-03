Return-Path: <linux-pm+bounces-24754-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A70A7A133
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 12:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 417C8170345
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 10:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362CB24BBE3;
	Thu,  3 Apr 2025 10:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiCxQxjB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124411F4CBA
	for <linux-pm@vger.kernel.org>; Thu,  3 Apr 2025 10:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743676920; cv=none; b=rE5x4BDrbj4TBbUDuHYkrSwATexGyejhWXa8e1rEc/UIrSdydU2xvI46N5hv6y8S9Wqu9cl4ezQyvwxwJGxYNO6ZgzVM5WDfLgxplLNbYZnED/eq2qyXWS49MACiliFztnDtIhMIb2vxcGUmN2ObtyyZf04/NjCKkjolwzuZv7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743676920; c=relaxed/simple;
	bh=RZLvLxJufLoGkWAoCoUqfBtDh9g4+Ea4NOrWBP3qh5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YyABBPooDwivRSxZKbaY1/7eOLV9B6IHUNnp4OuhrGOrSn7+sBSDl3ZhZ1eBonSfKJNBqjvNPukDbT5piUb2SqSIzgnfMh3a7Uvh6Ck8w2My/RBW5sWi7Oc0g9rgUS72e29DaT/d58rYd/PRn9zLtjoM6i7cRwhmRIaHYE+MUV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tiCxQxjB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89931C4CEE8
	for <linux-pm@vger.kernel.org>; Thu,  3 Apr 2025 10:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743676919;
	bh=RZLvLxJufLoGkWAoCoUqfBtDh9g4+Ea4NOrWBP3qh5Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tiCxQxjBgeXJcH49l5JBIRkYM76QVbhPJ3E0CJr91pbXQ3JOODG/fXMNymQIlq+A3
	 9ZT3SyOS7C/KZxtuOwqaNF9IRr4KtiWgQNtJUDtvUJ9VUfl4OBZySztacgZOvo5uoq
	 OD1hQ9M/Q9uxwcU6HuVGUDE/WnCoAN9qztbx60IKUWdbMZi9axuqoDwQoJY62hhIL4
	 N03oFi3dD/ir0LivddAS0SlWk0J/7tWOWTljlerAGmVJTPcZ/Drh0ZAWM3OWxnZuIw
	 9x0pM+r09W79MP8yqCWHfQ0cFMC8rdPt5Hqyi3XWVrupIz98x0QHU99NOYnHUVcVCN
	 /rfU0F9mttwAQ==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2c1c9b7bd9aso423412fac.0
        for <linux-pm@vger.kernel.org>; Thu, 03 Apr 2025 03:41:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWGgEmUXPdfUedS/bNhQIFL5ztIhvRYiYFbdsR73EY61zUJrN3g6AKisCB8dzL9kW47Ot3hx6qXkw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRVHZReMfs4lJR+37B6Ijh073rPxsoSgx2iFFe4ze3f+HDXITW
	/RMj+c1CfBLrUovAQcA2XZTam5arjYkmFVgjehfPEsA+BmS9/vRea9c8nVYHWjFwfRZEnJPotF9
	52xVkPW1Yi6uUQjFbdQQZnUF378s=
X-Google-Smtp-Source: AGHT+IF34qAu+g3tcgFpe6qfMq4zHf1Z45Cdn4Zh5YZ3Rzg+T47o6xpxnBLjCt6XxR4K6Jjz0P/OmEVX/z4gc+7beo8=
X-Received: by 2002:a05:6871:209:b0:2bc:7d6f:fa86 with SMTP id
 586e51a60fabf-2cbcf7e0bd6mr13950469fac.35.1743676918808; Thu, 03 Apr 2025
 03:41:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5aac0c93-2723-2ca1-cbfa-98f88b0c900c@kylinos.cn>
 <CAJZ5v0iDeC-ieFEzzHP=Dpet5T5ssGRHqW-SvRUoSU4PCLR2Fw@mail.gmail.com> <a55a3417634ae3ab546121d77af083cbf4fcdc3f.camel@kylinos.cn>
In-Reply-To: <a55a3417634ae3ab546121d77af083cbf4fcdc3f.camel@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 Apr 2025 12:41:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0how8gMN_mhqosNH4kB9uki2drA8RpdCPJVQVp+Kh70Bg@mail.gmail.com>
X-Gm-Features: AQ5f1Jos095cVKc2S_QtF5c5qyOl8Vp6fKpnXU4bxUIfQyr3xV0nAew28GK4dQ0
Message-ID: <CAJZ5v0how8gMN_mhqosNH4kB9uki2drA8RpdCPJVQVp+Kh70Bg@mail.gmail.com>
Subject: Re: [PATCH v3] hibernate: pageoffline may be first judged
To: lijun <lijun01@kylinos.cn>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, pavel@ucw.cz, len.brown@intel.com, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 4:03=E2=80=AFAM lijun <lijun01@kylinos.cn> wrote:
>
> From: Li Jun <lijun01@kylinos.cn>
>
>
>
> Date: Mon, 10 Feb 2025 10:40:58 +0800
> Subject: [PATCH v3] hibernate: pageoffline may be first judged
>
> 'PageReserved' and 'PageOffline' have weights greater
> than 'is_forbidden' and 'is_free'.so,PageReserved
> and PageOffline should be first judged.
> just as the page is free,but is reserved.
>
> the ordering of checks in 'for_each_populated_zone(zone)'
> It means that hundreds of thousands or even millions of
> pages need to be judged, reducing the judgment of one
> statement may save some time.

So this is regarded as a possible optimization.

My understanding of it is as follows:

Since PageReserved(page) and PageOffline(page) are simpler than the
other checks in saveable_highmem_page(), checking them first is likely
to reduce overhead somewhat, or at least it would not make a
measurable difference.

Is this what you wanted to say?

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
>     if (page_is_guard(page))
>         return NULL;
>
> --
> 2.34.1
>
>

