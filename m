Return-Path: <linux-pm+bounces-954-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85E880ECC1
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 14:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 154C9B20AA6
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 13:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD25060EF7;
	Tue, 12 Dec 2023 13:04:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893C7B3;
	Tue, 12 Dec 2023 05:04:04 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5907e590360so220473eaf.0;
        Tue, 12 Dec 2023 05:04:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702386244; x=1702991044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+zlCPTSk6JdN6595sPJPnN+KjNdsVVraWML48xr0EUg=;
        b=OIfXr3F2S6HNnSJjVC02GFGZT46aLMwjCDD2Bo3Ad+jF7uiEmLOh4Dg2Tmk/Qoilj4
         mkuVZvJzNUQ9/VD2btsZnPMvzBuJ3jcP7zIDOAHbXPPW9wj8CErW5l7SPtvH4Y436YE3
         TbW1lIyVSXaiWi4NDJY/f8mNHGP9KuEC/DQdRV0ee0iaBzjk8w/PxicJovk/RV77MIwt
         Yatx0587W89eviBcghTWkg7ZlXCVAMHevv5A1RihgrfUkUA/hR5uaupIIWeEq6lObdqQ
         bra6M/2IGt9blgkBvIE+7oUtVhnzin4SpJ6e3KWSuCriDw9BaoeYshTMv+jSkaB8UmDx
         8Nbw==
X-Gm-Message-State: AOJu0YyLmEo1m0MTuvGZ/tGFm+F4xDMaRhKkyKWttMtl0trEXN4Gu1q0
	YY91iUTWNReZqLubxkBojr3N0a5BP5jLTVIqq7OfbDJ1yEI=
X-Google-Smtp-Source: AGHT+IGHKSRwC7w0Pqpkxwxhr4hPN9Fyc5P2OWkS0+6K2iUEG88BT1M8zq/bChC78Qo0Q7PAR8XvMk6mRNWiJQh0vbI=
X-Received: by 2002:a4a:c487:0:b0:58d:ddcb:db1a with SMTP id
 f7-20020a4ac487000000b0058dddcbdb1amr10067925ooq.1.1702386243642; Tue, 12 Dec
 2023 05:04:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116005609.1583858-1-zhanghongchen@loongson.cn>
In-Reply-To: <20231116005609.1583858-1-zhanghongchen@loongson.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Dec 2023 14:03:52 +0100
Message-ID: <CAJZ5v0gTcntizfqKMa0YxHbOhNsLf=nAEoOBf2f9fFt-uzzgsg@mail.gmail.com>
Subject: Re: [PATCH v2] PM: hibernate: use acquire/release ordering when
 compress/decompress image
To: Hongchen Zhang <zhanghongchen@loongson.cn>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
	Bojan Smojver <bojan@rexursive.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn, 
	stable@vger.kernel.org, Weihao Li <liweihao@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 1:56=E2=80=AFAM Hongchen Zhang
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
> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> Signed-off-by: Weihao Li <liweihao@loongson.cn>

I was about to apply this patch when I noticed the S-o-b confusion.

Either a From: header pointing to Weihao Li <liweihao@loongson.cn> is
missing and the Hongchen Zhang <zhanghongchen@loongson.cn> sign-off
means that the patch is sent on behalf of Weihao Li, or you both
worked on the patch together and a Co-developed-by: tag pointing to
Weihao Li <liweihao@loongson.cn> is missing.

Which of the above is the case?

> ---
> v1 -> v2:
>         1. add Cc: stable@vger.kernel.org in commit log
>         2. add Fixes: line in commit log
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
> 2.33.0
>

