Return-Path: <linux-pm+bounces-35994-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42843BD5BD8
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 20:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA2224F221E
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 18:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7A42D6E5A;
	Mon, 13 Oct 2025 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5ibWWF0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC052D661A
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760380557; cv=none; b=mfQPKqV824L5WV1JgpWyi+UIbiEIMni+sDX4xVCSP0JA0QaNl3sD58C62cqwTdxhNYbvonOXdaQOxqdtJiZUNNSxIzGNDqnX9US8Q78eBnm4P+3rJVu393dD3diCZTxBVV4niXG4sfamyeQTu6RNC5ziFuLmzPCtWUB2mIFf1Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760380557; c=relaxed/simple;
	bh=zJB6NmYQd7LUbWynkjqCiC8IVIQo06Gd1NNqWWbfhgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rx4MnwI5gTacBonQ7eYsxZXB8fz+gXRDLLl7YLweFc7qLza+jSYUVZHQP4qqTchl3GxNeNE22qSOnUKwJAmXLs/rQ1HK4F4ss2MS7mSyrOMS8eW+GPqEkOAzsVMO0vnDlStRHzv++kE/PhQNGEjPj7PhLvXh+gRIqxJwKNidURE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5ibWWF0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B482CC4CEFE
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 18:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760380556;
	bh=zJB6NmYQd7LUbWynkjqCiC8IVIQo06Gd1NNqWWbfhgo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B5ibWWF01JOByorqAmYB1lR2QxHCL4+ygDhS774yxU8EyuqDikgp7P6SERD4Y8VwH
	 aQFzC4OTJHVedAhZwNK68RojRUmnd2RK3gTjFXl45Je3q53k0tB19aY7dG3Md8V/9x
	 ITARKjX9ijIlTiuzo6XTD8qOE4oputN/hTjBkDBuzvSYPVKkSyE7pk7Twr7NWiCg99
	 BCx29GZOI0A8XahCWKNzy2/J4fDguTVqwbARFYWxZoXkSFW0WN7YSrh4xm66xqjN2J
	 ERXbGswTyRnNc3iXatn6BUwj3ri0eLcE+JbTwAmAQ4hzmbvjRqghwtSsnGRSkNX5/4
	 7SYGKH6sUPJxA==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-74526ca79beso2937764a34.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 11:35:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXnY6l0Ga3bxmjiYLaraskGIkm84AkvQU3hiwqNKSde2XhB3i+bv4V+MYdoCAvAd0x23AEc6620fQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywppwbl2bk1zmtncXC52jWjz7WMO9AbiIIEyWeKCN8O5rZHSQTS
	79dpiO6a/xI50nS48ZsT2LmxD1yhsCU3gz98VbXzQ/VeljkSK7+iCOcQvdvArTaRPLB9v6SzvxI
	mgnUJDyf01iTm5IKH0NZj0apsSTGxJtI=
X-Google-Smtp-Source: AGHT+IHOQjWU/7yBEhHdOZhc6hKTgqTojZ/jcwV1r5BMnvXK+M2EkuWqdsFSSZm72loMz3KtLCr9SfC3Z+Sgk0EbSLo=
X-Received: by 2002:a05:6808:50cd:b0:441:8f74:e98 with SMTP id
 5614622812f47-4418f741d79mr7368955b6e.66.1760380555988; Mon, 13 Oct 2025
 11:35:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1757680816.git.luoxueqin@kylinos.cn> <1764e5db50a9e6a7809f0ec59a7b59e66c1f155f.1757680816.git.luoxueqin@kylinos.cn>
In-Reply-To: <1764e5db50a9e6a7809f0ec59a7b59e66c1f155f.1757680816.git.luoxueqin@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 13 Oct 2025 20:35:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0go3fOmipsBmmqS9xbKA8AbnMqtu52XsrV3iGYEGhegZw@mail.gmail.com>
X-Gm-Features: AS18NWD0PxPs2FXqcTaQpzJxIbymhsAKIH4iAY_tkeD4okFD7WV8j5ct_zMNqok
Message-ID: <CAJZ5v0go3fOmipsBmmqS9xbKA8AbnMqtu52XsrV3iGYEGhegZw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] PM: hibernate: make compression threads configurable
To: Xueqin Luo <luoxueqin@kylinos.cn>
Cc: rafael@kernel.org, pavel@kernel.org, lenb@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 4:23=E2=80=AFAM Xueqin Luo <luoxueqin@kylinos.cn> w=
rote:
>
> The number of compression/decompression threads has a direct impact on
> hibernate image generation and resume latency. Using more threads can
> reduce overall resume time, but on systems with fewer CPU cores it may
> also introduce contention and reduce efficiency.
>
> Performance was evaluated on an 8-core ARM system, averaged over 10 runs:
>
>     cmp_threads   hibernate time (s)   resume time (s)
>     --------------------------------------------------
>           3             12.14              18.86
>           4             12.28              17.48
>           5             11.09              16.77
>           6             11.08              16.44
>
> With 5=E2=80=936 threads, resume latency improves by approximately 12% co=
mpared
> to the default 3-thread configuration, with negligible impact on
> hibernate time.
>
> Introduce a new kernel parameter `cmp_threads=3D` that allows users and
> integrators to tune the number of compression/decompression threads at
> boot. This provides a way to balance performance and CPU utilization
> across a wide range of hardware without recompiling the kernel.
>
> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
> ---
>  kernel/power/swap.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index f8c13f5672ec..dfa9b7c0f96c 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -519,8 +519,8 @@ static int swap_writer_finish(struct swap_map_handle =
*handle,
>                                 CMP_HEADER, PAGE_SIZE)
>  #define CMP_SIZE       (CMP_PAGES * PAGE_SIZE)
>
> -/* Maximum number of threads for compression/decompression. */
> -#define CMP_THREADS    3
> +/* Default number of threads for compression/decompression. */
> +static int cmp_threads =3D 3;
>
>  /* Minimum/maximum number of pages for read buffering. */
>  #define CMP_MIN_RD_PAGES       1024
> @@ -741,7 +741,7 @@ static int save_compressed_image(struct swap_map_hand=
le *handle,
>          * footprint.
>          */
>         nr_threads =3D num_online_cpus() - 1;
> -       nr_threads =3D clamp_val(nr_threads, 1, CMP_THREADS);
> +       nr_threads =3D clamp_val(nr_threads, 1, cmp_threads);
>
>         page =3D (void *)__get_free_page(GFP_NOIO | __GFP_HIGH);
>         if (!page) {
> @@ -1257,7 +1257,7 @@ static int load_compressed_image(struct swap_map_ha=
ndle *handle,
>          * footprint.
>          */
>         nr_threads =3D num_online_cpus() - 1;
> -       nr_threads =3D clamp_val(nr_threads, 1, CMP_THREADS);
> +       nr_threads =3D clamp_val(nr_threads, 1, cmp_threads);
>
>         page =3D vmalloc_array(CMP_MAX_RD_PAGES, sizeof(*page));
>         if (!page) {
> @@ -1697,3 +1697,19 @@ static int __init swsusp_header_init(void)
>  }
>
>  core_initcall(swsusp_header_init);
> +
> +static int __init cmp_threads_setup(char *str)
> +{
> +       int rc =3D kstrtouint(str, 0, &cmp_threads);
> +
> +       if (rc)
> +               return rc;
> +
> +       if (cmp_threads < 1)
> +               cmp_threads =3D 1;

Why not use the default (3) here or return an error?

> +
> +       return 1;
> +
> +}
> +
> +__setup("cmp_threads=3D", cmp_threads_setup);
> --

