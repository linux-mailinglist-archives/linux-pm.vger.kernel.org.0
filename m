Return-Path: <linux-pm+bounces-24066-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 084E9A613D5
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 15:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5C0A188988F
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 14:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C436F201006;
	Fri, 14 Mar 2025 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECKRM+AR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C1F200B85;
	Fri, 14 Mar 2025 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963249; cv=none; b=jM6EvZSyTIT9v2m3kaUNO5vozkLLj+qHN3y+4iHmyMqKRuRrz+4+TKYryxX2dQ+gC3IP5GFSp1ydu2MIkaQe3GvWfa+LjIjzeO36sd/iwDF/aU58kwhLotDDTxNAVrBsflZO4pyJmXQIgm9WoCshU5wfySajB5s+0oqkTeK1LvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963249; c=relaxed/simple;
	bh=kOZRCfNTFAmjgM4OTQk9R9L7+HsgtiFA6mjQzji8A2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4fnkC0ooqD11XcB/MxqJlTriZEbrzVSY4wNEF2Lz7gzDOd1w37s2qwr9ofm3BjOX4So3IyZTB2sBi2oOr3XJWQH57rTAKXgpRiikiVMqkV/b4GSmZCQt5EjBgmBKcZowKRMPY+x8yGxBbFXMTgBX3fg4ypsoaqpw15/M53liH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECKRM+AR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D00C4CEF0;
	Fri, 14 Mar 2025 14:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741963249;
	bh=kOZRCfNTFAmjgM4OTQk9R9L7+HsgtiFA6mjQzji8A2U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ECKRM+ARs1Fyk78QojJzfsJqEi7fbp0l1nrtzMn/yCVx17sLw7XpYKaSTnGh5pIlL
	 7tYysO+bYMvFug+wG0foiVu6p299ainK+E6JtKZ0lP2o+KzTxR/I1mTpWqAM+54eQZ
	 Eh41mOz8OdaZb5lpxWdg39mas+LhyOFHmEgzgL6g9rnJcRYkGdgtQwF0JlIqFY49M0
	 YkzV3ASwc2CnWXuSo3BPq86cU+xOUymvHhs2vB0RxWyeT2ngdC8FuT2sqyfi4iO0kx
	 GUQgLvohatzXg0ln9mdL7PK0iCINcOlbYPfMEFaYxClj4DL17fR8RR/u+stangBwSU
	 kbO56sUIHaLHQ==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7289871af1eso538238a34.1;
        Fri, 14 Mar 2025 07:40:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7ewEuTEEhMcq18/oceroaG+KJ71LsbA7x44Pow5aK32BJmWhIs71c5e9ubW5lsKuUK/ay8hCy3w==@vger.kernel.org, AJvYcCU9miiwbZt9+k8k1cvDJpfjcH/4SCXJcKCtTNsAdCHurcLrB1efz+yIwSrFnPZF7qTILB+YLD+y@vger.kernel.org
X-Gm-Message-State: AOJu0YxlY2OKawPlIwJJd3FqCsZhF0wH4mWp6OQeay34qBNW6JGBT/F0
	tB6bYAKqJUCoW6GEno4cAxRkv6yOWhCSruefV/qOpYQ7Sh2Uj+UsGRmdkP6aeasQ/EHokqn+YAq
	CUJHuv/LMsTKLGGB4HAfOrxeDOFU=
X-Google-Smtp-Source: AGHT+IFz7bLipIK5RYmxZqH2ldz7cWhqd71OqQ4DHvt+CZwYWLt/Cy9W23k13fvkLtER/KicxAk91II+KDhySTIgeN4=
X-Received: by 2002:a05:6870:46a7:b0:2c2:2b76:7506 with SMTP id
 586e51a60fabf-2c69118e2fcmr1605373fac.28.1741963248488; Fri, 14 Mar 2025
 07:40:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741954523.git.herbert@gondor.apana.org.au> <785c7858e03ad03a56ffaee0e413c72e0a307a63.1741954523.git.herbert@gondor.apana.org.au>
In-Reply-To: <785c7858e03ad03a56ffaee0e413c72e0a307a63.1741954523.git.herbert@gondor.apana.org.au>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 14 Mar 2025 15:40:37 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gc-Juvkf65Z4bu1PDNKNY58YkPk33oNQvOJ0GXDyXyqQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jr22184Qyn86bekKuTIORGL9m-kGJL55Y-Vi2M5Km5rSK5kh8GQ-SajOvQ
Message-ID: <CAJZ5v0gc-Juvkf65Z4bu1PDNKNY58YkPk33oNQvOJ0GXDyXyqQ@mail.gmail.com>
Subject: Re: [v4 PATCH 12/13] PM: hibernate: Use crypto_acomp interface
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Richard Weinberger <richard@nod.at>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, linux-mtd@lists.infradead.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, 
	Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 1:23=E2=80=AFPM Herbert Xu <herbert@gondor.apana.or=
g.au> wrote:
>
> Replace the legacy crypto compression interface with the new acomp
> interface.
>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

and please feel free to route it as needed along with the rest of the serie=
s.

Thanks!

> ---
>  kernel/power/swap.c | 58 ++++++++++++++++++++++++++++++---------------
>  1 file changed, 39 insertions(+), 19 deletions(-)
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 82b884b67152..80ff5f933a62 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -12,6 +12,7 @@
>
>  #define pr_fmt(fmt) "PM: " fmt
>
> +#include <crypto/acompress.h>
>  #include <linux/module.h>
>  #include <linux/file.h>
>  #include <linux/delay.h>
> @@ -635,7 +636,8 @@ static int crc32_threadfn(void *data)
>   */
>  struct cmp_data {
>         struct task_struct *thr;                  /* thread */
> -       struct crypto_comp *cc;                   /* crypto compressor st=
ream */
> +       struct crypto_acomp *cc;                  /* crypto compressor */
> +       struct acomp_req *cr;                     /* crypto request */
>         atomic_t ready;                           /* ready to start flag =
*/
>         atomic_t stop;                            /* ready to stop flag *=
/
>         int ret;                                  /* return code */
> @@ -656,7 +658,6 @@ static atomic_t compressed_size =3D ATOMIC_INIT(0);
>  static int compress_threadfn(void *data)
>  {
>         struct cmp_data *d =3D data;
> -       unsigned int cmp_len =3D 0;
>
>         while (1) {
>                 wait_event(d->go, atomic_read_acquire(&d->ready) ||
> @@ -670,11 +671,13 @@ static int compress_threadfn(void *data)
>                 }
>                 atomic_set(&d->ready, 0);
>
> -               cmp_len =3D CMP_SIZE - CMP_HEADER;
> -               d->ret =3D crypto_comp_compress(d->cc, d->unc, d->unc_len=
,
> -                                             d->cmp + CMP_HEADER,
> -                                             &cmp_len);
> -               d->cmp_len =3D cmp_len;
> +               acomp_request_set_callback(d->cr, CRYPTO_TFM_REQ_MAY_SLEE=
P,
> +                                          NULL, NULL);
> +               acomp_request_set_src_nondma(d->cr, d->unc, d->unc_len);
> +               acomp_request_set_dst_nondma(d->cr, d->cmp + CMP_HEADER,
> +                                            CMP_SIZE - CMP_HEADER);
> +               d->ret =3D crypto_acomp_compress(d->cr);
> +               d->cmp_len =3D d->cr->dlen;
>
>                 atomic_set(&compressed_size, atomic_read(&compressed_size=
) + d->cmp_len);
>                 atomic_set_release(&d->stop, 1);
> @@ -745,13 +748,20 @@ static int save_compressed_image(struct swap_map_ha=
ndle *handle,
>                 init_waitqueue_head(&data[thr].go);
>                 init_waitqueue_head(&data[thr].done);
>
> -               data[thr].cc =3D crypto_alloc_comp(hib_comp_algo, 0, 0);
> +               data[thr].cc =3D crypto_alloc_acomp(hib_comp_algo, 0, CRY=
PTO_ALG_ASYNC);
>                 if (IS_ERR_OR_NULL(data[thr].cc)) {
>                         pr_err("Could not allocate comp stream %ld\n", PT=
R_ERR(data[thr].cc));
>                         ret =3D -EFAULT;
>                         goto out_clean;
>                 }
>
> +               data[thr].cr =3D acomp_request_alloc(data[thr].cc);
> +               if (!data[thr].cr) {
> +                       pr_err("Could not allocate comp request\n");
> +                       ret =3D -ENOMEM;
> +                       goto out_clean;
> +               }
> +
>                 data[thr].thr =3D kthread_run(compress_threadfn,
>                                             &data[thr],
>                                             "image_compress/%u", thr);
> @@ -899,8 +909,8 @@ static int save_compressed_image(struct swap_map_hand=
le *handle,
>                 for (thr =3D 0; thr < nr_threads; thr++) {
>                         if (data[thr].thr)
>                                 kthread_stop(data[thr].thr);
> -                       if (data[thr].cc)
> -                               crypto_free_comp(data[thr].cc);
> +                       acomp_request_free(data[thr].cr);
> +                       crypto_free_acomp(data[thr].cc);
>                 }
>                 vfree(data);
>         }
> @@ -1142,7 +1152,8 @@ static int load_image(struct swap_map_handle *handl=
e,
>   */
>  struct dec_data {
>         struct task_struct *thr;                  /* thread */
> -       struct crypto_comp *cc;                   /* crypto compressor st=
ream */
> +       struct crypto_acomp *cc;                  /* crypto compressor */
> +       struct acomp_req *cr;                     /* crypto request */
>         atomic_t ready;                           /* ready to start flag =
*/
>         atomic_t stop;                            /* ready to stop flag *=
/
>         int ret;                                  /* return code */
> @@ -1160,7 +1171,6 @@ struct dec_data {
>  static int decompress_threadfn(void *data)
>  {
>         struct dec_data *d =3D data;
> -       unsigned int unc_len =3D 0;
>
>         while (1) {
>                 wait_event(d->go, atomic_read_acquire(&d->ready) ||
> @@ -1174,10 +1184,13 @@ static int decompress_threadfn(void *data)
>                 }
>                 atomic_set(&d->ready, 0);
>
> -               unc_len =3D UNC_SIZE;
> -               d->ret =3D crypto_comp_decompress(d->cc, d->cmp + CMP_HEA=
DER, d->cmp_len,
> -                                               d->unc, &unc_len);
> -               d->unc_len =3D unc_len;
> +               acomp_request_set_callback(d->cr, CRYPTO_TFM_REQ_MAY_SLEE=
P,
> +                                          NULL, NULL);
> +               acomp_request_set_src_nondma(d->cr, d->cmp + CMP_HEADER,
> +                                            d->cmp_len);
> +               acomp_request_set_dst_nondma(d->cr, d->unc, UNC_SIZE);
> +               d->ret =3D crypto_acomp_decompress(d->cr);
> +               d->unc_len =3D d->cr->dlen;
>
>                 if (clean_pages_on_decompress)
>                         flush_icache_range((unsigned long)d->unc,
> @@ -1254,13 +1267,20 @@ static int load_compressed_image(struct swap_map_=
handle *handle,
>                 init_waitqueue_head(&data[thr].go);
>                 init_waitqueue_head(&data[thr].done);
>
> -               data[thr].cc =3D crypto_alloc_comp(hib_comp_algo, 0, 0);
> +               data[thr].cc =3D crypto_alloc_acomp(hib_comp_algo, 0, CRY=
PTO_ALG_ASYNC);
>                 if (IS_ERR_OR_NULL(data[thr].cc)) {
>                         pr_err("Could not allocate comp stream %ld\n", PT=
R_ERR(data[thr].cc));
>                         ret =3D -EFAULT;
>                         goto out_clean;
>                 }
>
> +               data[thr].cr =3D acomp_request_alloc(data[thr].cc);
> +               if (!data[thr].cr) {
> +                       pr_err("Could not allocate comp request\n");
> +                       ret =3D -ENOMEM;
> +                       goto out_clean;
> +               }
> +
>                 data[thr].thr =3D kthread_run(decompress_threadfn,
>                                             &data[thr],
>                                             "image_decompress/%u", thr);
> @@ -1507,8 +1527,8 @@ static int load_compressed_image(struct swap_map_ha=
ndle *handle,
>                 for (thr =3D 0; thr < nr_threads; thr++) {
>                         if (data[thr].thr)
>                                 kthread_stop(data[thr].thr);
> -                       if (data[thr].cc)
> -                               crypto_free_comp(data[thr].cc);
> +                       acomp_request_free(data[thr].cr);
> +                       crypto_free_acomp(data[thr].cc);
>                 }
>                 vfree(data);
>         }
> --
> 2.39.5
>

