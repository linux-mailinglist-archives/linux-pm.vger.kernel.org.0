Return-Path: <linux-pm+bounces-36511-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 518BABF326A
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 21:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0A264FAD46
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 19:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5410830CD9F;
	Mon, 20 Oct 2025 19:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtVVRWnr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4CE2D9481
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 19:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987697; cv=none; b=upPRnYMpMNBIWbptKHG9p0/49NKF6KxIAWkuiwPJKFutLnLEgygcPRkZnG/lRVmhDCtFxA9L1dSCKXzzh8R2fWWpVO0cSATjFrKVX+llUGHrgzxReUZ4WI+7d1BVBGKS6qvKp6UJgDNxDyYEP6rQqOTsRgggNChYLJ0oPt/YPzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987697; c=relaxed/simple;
	bh=t1yj2wyNLrOvDV/KWjmpFvzFP7VCH26PbrrX1raHcxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avFighkO0Vw4vfvMrUv4sy3N6PFtNWxxf/hxMmxKMn4WXP3zoj5Qymi6rpqvSGXwywvOUti3dDBVrVoVVJaKj58soW8NJ5gQw+I6eofG/RjdEax2JN67JqINojaXPMWMGSzOfH52nWX+Q1QgP5A+Pkctft0NNxEWVUc0xU4a9xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtVVRWnr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA808C113D0
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 19:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760987696;
	bh=t1yj2wyNLrOvDV/KWjmpFvzFP7VCH26PbrrX1raHcxs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AtVVRWnrRIm8UexYqrMSOIiiGzwAS1CEHuWc982Qu2vlQmopiX8gYEEBXjUBPQIPO
	 E6l5lFxcYRRxJi5aBJGnNcH/NKoEbVFXZZbpn2Ug+3Zqf6mepHrvHGUxy5gRMc4Cqe
	 VfhNjdoC5CRAj9NmscI3O77wkk9ni+lu4BSDGq3t4d6W5KSJ/LaWM6oSxhWf60Tdph
	 P3BG658dRFpARLCw6ig1x6g1HhA53Z0mbCaxIPIyGpwF9scUk2M5LF1jf7fmx41mSS
	 Z9SPTJs1zmtrLZsucUo13U7gt3sGE3ux90eujbkLGXG1h7iPrDhBoBj3N2B3ROABQ6
	 B0BzgHHtN3uiQ==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7bdfbc6ba5cso2000885a34.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 12:14:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWnPkzzq3RRBaK91yQGtJBMLM0tObGfIqBk6AjNvfYnUarQfpErqIp+5fLkdexHcj9lgrqxcFFsGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPaO5wU68Wv2GNmASd/el+8zWSlnswKgBesrX8mtNGoVfQhDdo
	lWsYnrCDO1kZXCpFdavRJ+buEx8iv22eLO9BywEETgNPlAMXBo+u6f6x/aAFRvMKE5cz20XHvyL
	6aHzpRnCjnNh8v6v25f21i7st4Fpowjw=
X-Google-Smtp-Source: AGHT+IGJhvCOM4XeNAjTFTtuleWYlW/bRVcmMPF9hEo3/ucm+3tt1kslszdnjrenYNnJFV5U8D/pYLJ5PHM0y7RaOOI=
X-Received: by 2002:a05:6808:2444:b0:441:8f74:f48 with SMTP id
 5614622812f47-443a31bd4d4mr6441116b6e.66.1760987696143; Mon, 20 Oct 2025
 12:14:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760423687.git.luoxueqin@kylinos.cn> <9f15307fcf22784a82fc1957133dfc2296930c33.1760423687.git.luoxueqin@kylinos.cn>
In-Reply-To: <9f15307fcf22784a82fc1957133dfc2296930c33.1760423687.git.luoxueqin@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Oct 2025 21:14:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hFj5UKaJ0SE1jJ2cS8Os9JxypUZtZRUZatXr-kCDwx_g@mail.gmail.com>
X-Gm-Features: AS18NWAmbunwpbk_nk-VvYe27CBuQ9jXYdP5xVn6w_T6Za5ySs2XdrxdK0ZRO_w
Message-ID: <CAJZ5v0hFj5UKaJ0SE1jJ2cS8Os9JxypUZtZRUZatXr-kCDwx_g@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] PM: hibernate: make compression threads configurable
To: Xueqin Luo <luoxueqin@kylinos.cn>
Cc: rafael@kernel.org, pavel@kernel.org, lenb@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 9:20=E2=80=AFAM Xueqin Luo <luoxueqin@kylinos.cn> w=
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
> index f8c13f5672ec..540cf902498c 100644
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
> +               cmp_threads =3D 3;
> +
> +       return 1;
> +
> +}
> +
> +__setup("cmp_threads=3D", cmp_threads_setup);

So this is just a kernel command line option (and one with a cryptic
name for that matter).

To a minimum, it requires documentation in
Documentation/admin-guide/kernel-parameters.txt, but it also might be
run-time configurable, like pm_debug_messages for one example.

Also the name could be more self-explanatory, like
hibernate_compression_threads or similar.

Thanks!

