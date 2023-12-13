Return-Path: <linux-pm+bounces-1098-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B68CD8113B3
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 14:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32B7EB20958
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 13:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458452E41A;
	Wed, 13 Dec 2023 13:52:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF1E3581;
	Wed, 13 Dec 2023 05:52:21 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1fae54afb66so845510fac.1;
        Wed, 13 Dec 2023 05:52:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702475535; x=1703080335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ns4LGXhzsELqeFy5cKH0B3W9wewJJdmQ50HMk4RT/LI=;
        b=bRRbDVGdR45B3UgsLLZMPd4HxzW2pfjT5KirfiDkwlQEYjKTE3Kwlp2YTCZaadNsK3
         baS1ES58NuCtdTyqI6icbQZH45H67eF/qCBkQ7Rx9FZ2dFoqrZEn+ZcGYxq+t8Tw+SAu
         xadh4iQDHuIE+ZjmY0Bd3Qjn9FUX6btRA0THi9Q/MJ+38iAqyIQ7Cc3m3fd2ydNWyXmd
         JiDPwUtJZtRRAnn83m/HQycRLk+e0444WKafoad3oMZ/D6gyQOawlbHPqypP9EsG3QMf
         4EfBtvWwDrRwnc8+DgUqPexQ/6/QBq4v69uII1d/R8I5vDncZVOt8Xrnnl0/K/AW0Rol
         8+0Q==
X-Gm-Message-State: AOJu0Yw7d93kG/1hp0i/x0p0caxfCmS9rD5vcOviZ9NX6py4Yt1mgLfi
	HVQL34657z6u1CLFvYPGeBKc0cC+2YRhbLmuec0=
X-Google-Smtp-Source: AGHT+IFklC2+2yx5+/6px6dm4plrZumhRqC32TtxPC7w0lY9NXF5sm33JROV1+LfS+a7VWPf8xUrG2EjBMfksHgaVsY=
X-Received: by 2002:a05:6871:208c:b0:1fb:19d6:8715 with SMTP id
 ry12-20020a056871208c00b001fb19d68715mr14383677oab.4.1702475534692; Wed, 13
 Dec 2023 05:52:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213011103.1491414-1-zhanghongchen@loongson.cn>
In-Reply-To: <20231213011103.1491414-1-zhanghongchen@loongson.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 Dec 2023 14:52:03 +0100
Message-ID: <CAJZ5v0iTfpo9EH3bCAwJ+E8W67uJyy_9wFBOucJVWmmGV_-XpA@mail.gmail.com>
Subject: Re: [PATCH v3] PM: hibernate: use acquire/release ordering when
 compress/decompress image
To: Hongchen Zhang <zhanghongchen@loongson.cn>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
	Bojan Smojver <bojan@rexursive.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn, 
	stable@vger.kernel.org, Weihao Li <liweihao@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 2:11=E2=80=AFAM Hongchen Zhang
<zhanghongchen@loongson.cn> wrote:
>
> When we test S4(suspend to disk) on LoongArch 3A6000 platform, the
> test case sometimes fails. The dmesg log shows the following error:
>         Invalid LZO compressed length
> After we dig into the code, we find out that:
> When compress/decompress the image, the synchronization operation
> between the control thread and the compress/decompress/crc thread
> uses relaxed ordering interface, which is unreliable, and the
> following situation may occur:
> CPU 0                                   CPU 1
> save_image_lzo                          lzo_compress_threadfn
>                                           atomic_set(&d->stop, 1);
>   atomic_read(&data[thr].stop)
>   data[thr].cmp =3D data[thr].cmp_len;
>                                           WRITE data[thr].cmp_len
> Then CPU0 get a old cmp_len and write to disk. When cpu resume from S4,
> wrong cmp_len is loaded.
>
> To maintain data consistency between two threads, we should use the
> acquire/release ordering interface. So we change atomic_read/atomic_set
> to atomic_read_acquire/atomic_set_release.
>
> Fixes: 081a9d043c98 ("PM / Hibernate: Improve performance of LZO/plain hi=
bernation, checksum image")
> Cc: stable@vger.kernel.org
> Co-developed-by: Weihao Li <liweihao@loongson.cn>

I gather that the tag above is the only difference between this
version of the patch and the previous one.

It is always better to list the changes made between consecutive
versions of a patch.

> Signed-off-by: Weihao Li <liweihao@loongson.cn>
> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> ---
>  kernel/power/swap.c | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index a2cb0babb5ec..d44f5937f1e5 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -606,11 +606,11 @@ static int crc32_threadfn(void *data)
>         unsigned i;
>
>         while (1) {
> -               wait_event(d->go, atomic_read(&d->ready) ||
> +               wait_event(d->go, atomic_read_acquire(&d->ready) ||
>                                   kthread_should_stop());
>                 if (kthread_should_stop()) {
>                         d->thr =3D NULL;
> -                       atomic_set(&d->stop, 1);
> +                       atomic_set_release(&d->stop, 1);
>                         wake_up(&d->done);
>                         break;
>                 }
> @@ -619,7 +619,7 @@ static int crc32_threadfn(void *data)
>                 for (i =3D 0; i < d->run_threads; i++)
>                         *d->crc32 =3D crc32_le(*d->crc32,
>                                              d->unc[i], *d->unc_len[i]);
> -               atomic_set(&d->stop, 1);
> +               atomic_set_release(&d->stop, 1);
>                 wake_up(&d->done);
>         }
>         return 0;
> @@ -649,12 +649,12 @@ static int lzo_compress_threadfn(void *data)
>         struct cmp_data *d =3D data;
>
>         while (1) {
> -               wait_event(d->go, atomic_read(&d->ready) ||
> +               wait_event(d->go, atomic_read_acquire(&d->ready) ||
>                                   kthread_should_stop());
>                 if (kthread_should_stop()) {
>                         d->thr =3D NULL;
>                         d->ret =3D -1;
> -                       atomic_set(&d->stop, 1);
> +                       atomic_set_release(&d->stop, 1);
>                         wake_up(&d->done);
>                         break;
>                 }
> @@ -663,7 +663,7 @@ static int lzo_compress_threadfn(void *data)
>                 d->ret =3D lzo1x_1_compress(d->unc, d->unc_len,
>                                           d->cmp + LZO_HEADER, &d->cmp_le=
n,
>                                           d->wrk);
> -               atomic_set(&d->stop, 1);
> +               atomic_set_release(&d->stop, 1);
>                 wake_up(&d->done);
>         }
>         return 0;
> @@ -798,7 +798,7 @@ static int save_image_lzo(struct swap_map_handle *han=
dle,
>
>                         data[thr].unc_len =3D off;
>
> -                       atomic_set(&data[thr].ready, 1);
> +                       atomic_set_release(&data[thr].ready, 1);
>                         wake_up(&data[thr].go);
>                 }
>
> @@ -806,12 +806,12 @@ static int save_image_lzo(struct swap_map_handle *h=
andle,
>                         break;
>
>                 crc->run_threads =3D thr;
> -               atomic_set(&crc->ready, 1);
> +               atomic_set_release(&crc->ready, 1);
>                 wake_up(&crc->go);
>
>                 for (run_threads =3D thr, thr =3D 0; thr < run_threads; t=
hr++) {
>                         wait_event(data[thr].done,
> -                                  atomic_read(&data[thr].stop));
> +                               atomic_read_acquire(&data[thr].stop));
>                         atomic_set(&data[thr].stop, 0);
>
>                         ret =3D data[thr].ret;
> @@ -850,7 +850,7 @@ static int save_image_lzo(struct swap_map_handle *han=
dle,
>                         }
>                 }
>
> -               wait_event(crc->done, atomic_read(&crc->stop));
> +               wait_event(crc->done, atomic_read_acquire(&crc->stop));
>                 atomic_set(&crc->stop, 0);
>         }
>
> @@ -1132,12 +1132,12 @@ static int lzo_decompress_threadfn(void *data)
>         struct dec_data *d =3D data;
>
>         while (1) {
> -               wait_event(d->go, atomic_read(&d->ready) ||
> +               wait_event(d->go, atomic_read_acquire(&d->ready) ||
>                                   kthread_should_stop());
>                 if (kthread_should_stop()) {
>                         d->thr =3D NULL;
>                         d->ret =3D -1;
> -                       atomic_set(&d->stop, 1);
> +                       atomic_set_release(&d->stop, 1);
>                         wake_up(&d->done);
>                         break;
>                 }
> @@ -1150,7 +1150,7 @@ static int lzo_decompress_threadfn(void *data)
>                         flush_icache_range((unsigned long)d->unc,
>                                            (unsigned long)d->unc + d->unc=
_len);
>
> -               atomic_set(&d->stop, 1);
> +               atomic_set_release(&d->stop, 1);
>                 wake_up(&d->done);
>         }
>         return 0;
> @@ -1335,7 +1335,7 @@ static int load_image_lzo(struct swap_map_handle *h=
andle,
>                 }
>
>                 if (crc->run_threads) {
> -                       wait_event(crc->done, atomic_read(&crc->stop));
> +                       wait_event(crc->done, atomic_read_acquire(&crc->s=
top));
>                         atomic_set(&crc->stop, 0);
>                         crc->run_threads =3D 0;
>                 }
> @@ -1371,7 +1371,7 @@ static int load_image_lzo(struct swap_map_handle *h=
andle,
>                                         pg =3D 0;
>                         }
>
> -                       atomic_set(&data[thr].ready, 1);
> +                       atomic_set_release(&data[thr].ready, 1);
>                         wake_up(&data[thr].go);
>                 }
>
> @@ -1390,7 +1390,7 @@ static int load_image_lzo(struct swap_map_handle *h=
andle,
>
>                 for (run_threads =3D thr, thr =3D 0; thr < run_threads; t=
hr++) {
>                         wait_event(data[thr].done,
> -                                  atomic_read(&data[thr].stop));
> +                               atomic_read_acquire(&data[thr].stop));
>                         atomic_set(&data[thr].stop, 0);
>
>                         ret =3D data[thr].ret;
> @@ -1421,7 +1421,7 @@ static int load_image_lzo(struct swap_map_handle *h=
andle,
>                                 ret =3D snapshot_write_next(snapshot);
>                                 if (ret <=3D 0) {
>                                         crc->run_threads =3D thr + 1;
> -                                       atomic_set(&crc->ready, 1);
> +                                       atomic_set_release(&crc->ready, 1=
);
>                                         wake_up(&crc->go);
>                                         goto out_finish;
>                                 }
> @@ -1429,13 +1429,13 @@ static int load_image_lzo(struct swap_map_handle =
*handle,
>                 }
>
>                 crc->run_threads =3D thr;
> -               atomic_set(&crc->ready, 1);
> +               atomic_set_release(&crc->ready, 1);
>                 wake_up(&crc->go);
>         }
>
>  out_finish:
>         if (crc->run_threads) {
> -               wait_event(crc->done, atomic_read(&crc->stop));
> +               wait_event(crc->done, atomic_read_acquire(&crc->stop));
>                 atomic_set(&crc->stop, 0);
>         }
>         stop =3D ktime_get();
> --

Applied as 6.8 material with some edits in the subject and changelog.

Thanks!

