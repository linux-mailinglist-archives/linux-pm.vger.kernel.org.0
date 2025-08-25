Return-Path: <linux-pm+bounces-33049-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 849A2B34AD2
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 21:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461601A86620
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 19:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E2F1F5619;
	Mon, 25 Aug 2025 19:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4W1Obvs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B124A08
	for <linux-pm@vger.kernel.org>; Mon, 25 Aug 2025 19:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756149489; cv=none; b=SqfmoqT/+6moOfYiUjDYJ6vl2H0SGeTUh98dqRd6A5UZ8dhKhIpW+OOPpY8OdJfaEw0dbDW/vZM72/lAsjgepUA6gBusNA8iyY1a42tiVAKTX++3/RfSL9fMPZ0XI4d9esAexov+FOdwsPa0SDpZ9j1gFy+7CE+fQRSnCcJJqIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756149489; c=relaxed/simple;
	bh=a/mU6s6ryMc++uqPPjNddt66eYLmEY20wj1O3uEwvXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kyh9jE2lWGqOrKL7eeZNsPJFTfA2l1VeRYVjPKgSC9PR1Pvm5F6gkuIpdmirUaFa8a18wTHIm//V5o7hc4JUAduoHFB6uOETpXZw25Pl3n+5kXSRC2l1kHSbAUYtrNRK5zj2TKFOAqDD2JGaRfypkkySdj8O5JWDWF0SxUlkmQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4W1Obvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECEAC4AF0B
	for <linux-pm@vger.kernel.org>; Mon, 25 Aug 2025 19:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756149488;
	bh=a/mU6s6ryMc++uqPPjNddt66eYLmEY20wj1O3uEwvXs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V4W1ObvsbfxCJhApDXp8TkpLHMRTM1wgUdKW7KCpaG4Xb67mOPlI4yQkCZ791fWGp
	 z5llg0FI9ghLwDGYxtF0/dFosuf/u88NkocAZGy7X9/HMzjZr6LY/CCOyv1ns7fE2N
	 YRalIucWwzCu7YF2tPTeVq4puEo/jDhtDGeEi4gf2vZgzIRUykKkORBbzu7PLbeunq
	 ava2HwGl0yIGKgrtlR+OljySKvDHf0ghP1uaToRlKpW6qoXDyykkSEP8VO/B5fn7OZ
	 z7ypjpDxu0xBf/OdXt9V7e3KNKKGkQ8w4dSF0+35/3oQNhMDSl8eaf7cMfPWettzYm
	 Jk+dOlYnLAdZA==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-314c3dc92f4so2023221fac.1
        for <linux-pm@vger.kernel.org>; Mon, 25 Aug 2025 12:18:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXbY9QEYE2V/F8k8lMUEMyl59cEW8xXFuq/IJkwK7L+OX7EUvms4EYPNeDAZwpT4J3Zs1pNJRQBkw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQRPns6Ox3afSse4Z1yyCqUi3zllQYfkA/IrhQhmoYnDx4KWzC
	NBpqn3Al72l4gHhsfiS5HvYlBW0QgLxKrzmgj8BhEZ5nVF7jygAmtmvAQfnS48+cCKfO9IoacLO
	cU+xyeTbTA8zBUjbWt72+R18t3nonbKo=
X-Google-Smtp-Source: AGHT+IH8MBM/stDHSjZlzGOInBb7r+6+o1QFotV9b3wMliiN3Fx+hrSi7cOOnD17H2CiqfyNoCtdY8OAgBAvrhXxNOQ=
X-Received: by 2002:a05:6870:bacc:b0:307:aaf0:9588 with SMTP id
 586e51a60fabf-315438b4244mr455488fac.1.1756149487888; Mon, 25 Aug 2025
 12:18:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820013343.1683850-1-lijun01@kylinos.cn>
In-Reply-To: <20250820013343.1683850-1-lijun01@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Aug 2025 21:17:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hoqb1OGb7_QC+7DSFTJ65sP_EqT8cnGsEQRu1c+9esBA@mail.gmail.com>
X-Gm-Features: Ac12FXyoxo71VUy3cG6qU1St9HCeJTKU8qj0JR0Kqog0JlL8I-yPuz6iSulWv_g
Message-ID: <CAJZ5v0hoqb1OGb7_QC+7DSFTJ65sP_EqT8cnGsEQRu1c+9esBA@mail.gmail.com>
Subject: Re: [PATCH v3] hibernate: init image_size depend on totalram_pages
To: Li Jun <lijun01@kylinos.cn>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 3:34=E2=80=AFAM Li Jun <lijun01@kylinos.cn> wrote:
>
>   Some automatically loaded applications greedily occupy
> memory, when total memory is 8GB, the image_size is 3GB,
> when total memory is 16GB, the image_size is 6GB, when
> total memory is 32GB, the image_size is 12GB. some
> of these applications,user may not use them. They occupy
> a large amount of image space, resulting in S4 time of
> over 100 seconds or even more.

You really need to give a real world example of the case in which this
patch makes a difference.

> When the users use s4 first,
> they feel the awakening time is so long,they may not use S4
> anymore. but s4 is so great beacause it can save power and
> preserve the working environment, especially for moblile
> devices.so limit the size of image_size to control the time
> of hibernation and wake-up,making more users love S4.

The above part of the changelog doesn't add useful information, so it
may be dropped.

>   First obtain the number of pages in 8GB of memory,
> MEM_8G_PAGES,and then use 16GB and 32GB based on 8GB.

The above is also not really useful information.

>   When the number of totalram_pages() is greater than MEM_8G_PAGES,

"When the total number of RAM pages is greater than MEM_8G_PAGES,"

> the current physical memory will definitely be greater than 8G.
> if it is 16GB, the current image_size will be initialized to 1/5
> of the totalram_pages().
>   When the number of totalram_pages() is greater than MEM_16G_PAGES,
> the current physical memory will definitely be greater than 16GB.
> if it is 32GB, the current image_size will be initialized to 1/10
> of the totalram_pages().
>    When the number of totalram_pages() is greater than MEM_32G_PAGES,
> the current physical memory will definitely be greater than 32GB,
> if it is 64GB, the currentimage_size will be initialized to 1/20
> of the totalram_mages().
>    This way, when there are 16GB, 32GB or 64GB, the size of the
> image size will be controlled to be slightly more than 3G.Just
> shrink more NR_SLAB_RECLAIMABLE, NR_ACTIVE_ANON, NR_INACTIVE_ANON,
> NR_ACTIVE_FILE, NR_INACTIVE_FILE pages, S4 is still normal.

So overall, the idea is to always create hibernation images of
approximately the same size (by default) regardless of the actual RAM
size, to reduce the time needed to load the image on systems with
relatively large RAM.

However, if the memory is actually used by applications, this may
cause pages to be flushed to swap during the "shrinking" of memory and
then they will be faulted in wholesale during restore which will cause
the whole process to take more time (this processes uncompressed pages
one at a time).

So this approach really only works if applications allocate lots of
memory and then don't use it.  How often does this happen in practice?

> Signed-off-by: Li Jun <lijun01@kylinos.cn>
> ---
>  kernel/power/snapshot.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 501df0676a61..9b11c74592e9 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -135,10 +135,21 @@ void __init hibernate_reserved_size_init(void)
>   * try to create the smallest image possible.
>   */
>  unsigned long image_size;
> +#define MEM_8G                 (8 * 1024 * 1024)//KB
> +#define MEM_8G_PAGES   (MEM_8G / (PAGE_SIZE / 1024))
> +#define MEM_16G_PAGES  (2 * MEM_8G_PAGES)
> +#define MEM_32G_PAGES  (4 * MEM_8G_PAGES)
>
>  void __init hibernate_image_size_init(void)
>  {
> -       image_size =3D ((totalram_pages() * 2) / 5) * PAGE_SIZE;
> +       if (totalram_pages() >=3D MEM_32G_PAGES)
> +               image_size =3D ((totalram_pages() * 1) / 20) * PAGE_SIZE;

What sense does it make to multiply totalram_pages() by 1?

> +       else if (totalram_pages() >=3D MEM_16G_PAGES)
> +               image_size =3D ((totalram_pages() * 1) / 10) * PAGE_SIZE;
> +       else if (totalram_pages() >=3D MEM_8G_PAGES)
> +               image_size =3D ((totalram_pages() * 1) / 5) * PAGE_SIZE;
> +       else
> +               image_size =3D ((totalram_pages() * 2) / 5) * PAGE_SIZE;

Regardless of the concerns above, it looks like the computation here
can be automated somehow?  For instance, a loop can be used for
computing the number by which totalram_pages() is divided.

>  }
>
>  /*
> --

