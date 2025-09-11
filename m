Return-Path: <linux-pm+bounces-34467-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02101B5334F
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 15:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37D9C1CC0F19
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 13:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49668322C66;
	Thu, 11 Sep 2025 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RY7o4wJK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAA11E51D;
	Thu, 11 Sep 2025 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757596253; cv=none; b=IzlbYmWCNn9MA5iLfHG3sPRtgPkFeB5npla+Uaepb1Xq3ariy4dFUhgvnnpOdx9+JTFhz1IvdjiYTMG3KYe41OFaYoUAmchWHF8KpIh0AMCbU28jQ7f6JRoQHqOMcDw5aVIE9TRFGPiUkfgZjqrmPJ0SCWqvFjy6uOKTlIc8TVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757596253; c=relaxed/simple;
	bh=H4k8Q9rq9zdMEl/Dh5piHrCi/KZ2gwLETPP99gB1EbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENtVpwpSBfeK13Pi4SaaipZqRWSgfPSNoMxRFM9H1OYiWdUjWAA22ldt/0mivzMNUjdbcdbzWIcvWPBGWg+oQm56kNc+qluruI7fsyImHx6u7wM6XVv9biBK7Ck1jOUfD58oTXqeTyNaiYEL4ryqHx9+lvlOZ+phJYGjh1wqMyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RY7o4wJK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EFCAC4CEF7;
	Thu, 11 Sep 2025 13:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757596252;
	bh=H4k8Q9rq9zdMEl/Dh5piHrCi/KZ2gwLETPP99gB1EbA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RY7o4wJKOjS5DgP78W9KZNIiXa6FdVpifM6A1AWdML9p5GoVE62FIniyCJNzqoQSn
	 U7Lik8009k1poAP52p4DKEHOa3hBTPhIBlQ67oLuO2VdLD9NvaAdarJr0D+TLldKw1
	 tEF+/8/bb6y1AjfgaqxwoDjRGBs0Pk9hMiiGJFtQPNjirVah/1GsykSSYbw/6x+FyD
	 X/tDtiCmuvDv1YI0tFf4qejc1Nx13NEtACWVPBXxJFSpWmv+ts4MPnMwCPWglp4mCa
	 S0iScmXZ2kGA4y+Zgzq23opwRAuuI4Hh+dCLdZRl6GPxUiKblJdn/qNmrRbiErZEb8
	 BOQ+bIJjXAgCA==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-61e74e59d8fso337279eaf.0;
        Thu, 11 Sep 2025 06:10:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVRMlCDE6HrUuVwEatFCvIAQ7J2Bnjma4ScJ2ct8cjqD3bnwFQvPT8C+lcVg649Jfd+GI0gnkweOjo=@vger.kernel.org, AJvYcCXEic1ZkyhBvk36kykOlKCDn1UgzFlZrnkRi1nycEwRI7q/xCstGVu+oRwlAZXHSQoMm5ThNfphyhJoftk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxPyuuYE9jqyPkeYDcOxMS+/LcY64IdZI5WqnlwoJ4JxbDHEpk
	nBK/ldV+NP00hHFOYJVOMPu/8h4KbEmKOr9b6PNeuoNRFbZKGuJ8ovBX0LfJsjSdclt8rpvFCnM
	SvYt3y26R44cs50wpD/CTq2An/96b48o=
X-Google-Smtp-Source: AGHT+IEp4oZb5hKSSK2t02v0yzfkPM/CgXSwAhnURJANNfuQmeKFvSkfxAvZim4eOVOp213gLdLmqFSoqal5A3Zlxto=
X-Received: by 2002:a05:6820:3307:b0:61b:f98a:2f19 with SMTP id
 006d021491bc7-621b2f0f23fmr1129291eaf.2.1757596251914; Thu, 11 Sep 2025
 06:10:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1757577879.git.luoxueqin@kylinos.cn> <86d4e558707e7b03c248ef67cb76ec635a875d9b.1757577879.git.luoxueqin@kylinos.cn>
In-Reply-To: <86d4e558707e7b03c248ef67cb76ec635a875d9b.1757577879.git.luoxueqin@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 11 Sep 2025 15:10:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hL_q9t2Tdu5DVZNqV_YkNpofV9S+N-rRRrAY3er5X_7Q@mail.gmail.com>
X-Gm-Features: Ac12FXw74ytzQQDwGB4nu1cTpiup9Fq3YTm8PT-v9dUnNGDt7lsHx4oTc4z8Y3s
Message-ID: <CAJZ5v0hL_q9t2Tdu5DVZNqV_YkNpofV9S+N-rRRrAY3er5X_7Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PM: hibernate: dynamically allocate
 crc->unc_len/unc for configurable threads
To: Xueqin Luo <luoxueqin@kylinos.cn>
Cc: rafael@kernel.org, pavel@kernel.org, lenb@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 10:10=E2=80=AFAM Xueqin Luo <luoxueqin@kylinos.cn> =
wrote:
>
> The current implementation uses fixed-size arrays for crc->unc_len and
> crc->unc, which limits the number of compression threads to a compile-tim=
e
> constant (CMP_THREADS). This patch converts them to dynamically allocated
> arrays, sized according to the actual number of threads selected at runti=
me.

Please don't say "this patch" (or similar) in patch changelogs.  It's
better to use imperative sentences like "Convert them to dynamically
allocated arrays, ...".

>
> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
> ---
>  kernel/power/swap.c | 44 ++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 40 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 0beff7eeaaba..bd149a54c081 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -585,8 +585,8 @@ struct crc_data {
>         wait_queue_head_t go;                     /* start crc update */
>         wait_queue_head_t done;                   /* crc update done */
>         u32 *crc32;                               /* points to handle's c=
rc32 */
> -       size_t *unc_len[CMP_THREADS];             /* uncompressed lengths=
 */
> -       unsigned char *unc[CMP_THREADS];          /* uncompressed data */
> +       size_t **unc_len;                                     /* uncompre=
ssed lengths */
> +       unsigned char **unc;                              /* uncompressed=
 data */
>  };
>
>  /*
> @@ -721,7 +721,21 @@ static int save_compressed_image(struct swap_map_han=
dle *handle,
>
>         crc =3D kzalloc(sizeof(*crc), GFP_KERNEL);
>         if (!crc) {
> -               pr_err("Failed to allocate crc\n");
> +               pr_err("Failed to allocate crc structure\n");
> +               ret =3D -ENOMEM;
> +               goto out_clean;
> +       }
> +
> +       crc->unc_len =3D kcalloc(nr_threads, sizeof(size_t *), GFP_KERNEL=
);
> +       if (!crc->unc_len) {
> +               pr_err("Failed to allocate crc->unc_len for %d threads\n"=
, nr_threads);
> +               ret =3D -ENOMEM;
> +               goto out_clean;
> +       }
> +
> +       crc->unc =3D kcalloc(nr_threads, sizeof(unsigned char *), GFP_KER=
NEL);
> +       if (!crc->unc) {
> +               pr_err("Failed to allocate crc->unc for %d threads\n", nr=
_threads);
>                 ret =3D -ENOMEM;
>                 goto out_clean;
>         }

Can you avoid code duplication by defining helpers for allocating and
freeing them both and using those helpers where applicable (image
creation and uncompression)?

> @@ -886,6 +900,10 @@ static int save_compressed_image(struct swap_map_han=
dle *handle,
>  out_clean:
>         hib_finish_batch(&hb);
>         if (crc) {
> +               if (crc->unc)
> +                       kfree(crc->unc);
> +               if (crc->unc_len)
> +                       kfree(crc->unc_len);
>                 if (crc->thr)
>                         kthread_stop(crc->thr);
>                 kfree(crc);
> @@ -1241,7 +1259,21 @@ static int load_compressed_image(struct swap_map_h=
andle *handle,
>
>         crc =3D kzalloc(sizeof(*crc), GFP_KERNEL);
>         if (!crc) {
> -               pr_err("Failed to allocate crc\n");
> +               pr_err("Failed to allocate crc structure\n");
> +               ret =3D -ENOMEM;
> +               goto out_clean;
> +       }
> +
> +       crc->unc_len =3D kcalloc(nr_threads, sizeof(size_t *), GFP_KERNEL=
);
> +       if (!crc->unc_len) {
> +               pr_err("Failed to allocate crc->unc_len for %d threads\n"=
, nr_threads);
> +               ret =3D -ENOMEM;
> +               goto out_clean;
> +       }
> +
> +       crc->unc =3D kcalloc(nr_threads, sizeof(unsigned char *), GFP_KER=
NEL);
> +       if (!crc->unc) {
> +               pr_err("Failed to allocate crc->unc for %d threads\n", nr=
_threads);
>                 ret =3D -ENOMEM;
>                 goto out_clean;
>         }
> @@ -1507,6 +1539,10 @@ static int load_compressed_image(struct swap_map_h=
andle *handle,
>         for (i =3D 0; i < ring_size; i++)
>                 free_page((unsigned long)page[i]);
>         if (crc) {
> +               if (crc->unc)
> +                       kfree(crc->unc);
> +               if (crc->unc_len)
> +                       kfree(crc->unc_len);
>                 if (crc->thr)
>                         kthread_stop(crc->thr);
>                 kfree(crc);
> --
> 2.43.0
>

