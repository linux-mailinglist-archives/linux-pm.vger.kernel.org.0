Return-Path: <linux-pm+bounces-25112-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E05FEA844B0
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 15:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17AF27AAD59
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 13:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B825928A3E2;
	Thu, 10 Apr 2025 13:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEoGPYfb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D08626A1C3;
	Thu, 10 Apr 2025 13:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744291451; cv=none; b=ZWlgh6sa4uyDLBXevcZ/Kx4eF1z2ud9SULr8ahH1XTm3f57q8SZnOdUBPJJs0peP2TgevY6vO5dxuBkHqvskJzJnKMDQVFWoczY87/6/YLmo1Twsuc+aTTGPhccogcsgMSxm+3H8kSPbF+Z+pWIBHcM8/PjI3a/XvqkkZEIfdso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744291451; c=relaxed/simple;
	bh=PjNnYyU7svnG4Jb+MSeLk+eCfOL5ztj8PIv/APnVBKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePETkNLEVreV7ThqQ+zFDa9ui6ZMMlcJ0qkPwVLYXcAdNQ3s2g2y7zIPWohEgylONr5oroA+UpA1Q6RDRxQCR7zSJ+vyKbN7TtLADNY/8UVUwdg0xmRRhxGu4rb0c3Cf1+Oq1LKfA8pvo9uAmhpNQ+JPKmS1AncNb1UxB9jD+p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEoGPYfb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B57C4CEE9;
	Thu, 10 Apr 2025 13:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744291451;
	bh=PjNnYyU7svnG4Jb+MSeLk+eCfOL5ztj8PIv/APnVBKk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fEoGPYfbsH3FHAVy1oEB4KLltybzVT3xkDV1DQCj26L95+FJb7v2aV/c0i6o1OcU1
	 hLbNuD2+qEH1k9IS739Hlb5U7C5Cjgp27sGGFcg1X3K01flVsJ/TGZIgryEKS2sU+L
	 v9dMY82uZIL/7p8k1u5O5QRF+9V/LG6pwNmOoh7jdI8doJloHt+OnUD/pavoCVbgdn
	 hSomcUIOhUu2LRZO6p49WDhnKgz2LEbK5uE+cksCR01W8zq0b9fJK4CyJvq2DpG5wO
	 CwM7AZ1ajKCCLAUrdGq726lbNRqFjhcyhWcH4iY7JzthFejy3J6CuKu9vbsW+ufGyI
	 pOoM+/VMFe3SA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2c76a1b574cso266465fac.2;
        Thu, 10 Apr 2025 06:24:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYoUdIWiTj6QFsBacejbvJiWgmfEHRCXlnBufXDqu8x6Z6dFuYdP2Ssp2b2II/4+5nPfYTGnyXJxg=@vger.kernel.org, AJvYcCVkH1JuqUktGadbxX9LWYwf2parDZSLGG5/FmotX+rW4EGKmmSky4vRkcb7+TJqYjQXTP/PUOpT4QTxbUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxNh82SOSeBzymAaRMOIN3CEBX4G7a+uXp+MCneT/2jzASx+TP
	z2uxbY0NmfebwcAWpb2rCCR673dvkhZT5m2lA2Hr3nj0yMPtc/0PeyYmhNz3XwCS1Z2u80WrPgC
	jF+0Eu55b7a0umaw33tNOc7HJ3Xg=
X-Google-Smtp-Source: AGHT+IGnrjgpZpg9n2Ziq3OF/5GTRm4gYLzeqI8ltqxf1OdwbonWUqdZsxQ/g2yJei3J5HaWR/tty6qVcp/p6wYkA50=
X-Received: by 2002:a05:6870:888b:b0:29e:766d:e969 with SMTP id
 586e51a60fabf-2d0b3611dd9mr1593089fac.10.1744291450278; Thu, 10 Apr 2025
 06:24:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_8478BF8F2549630842D323E7394CB6F49D08@qq.com>
In-Reply-To: <tencent_8478BF8F2549630842D323E7394CB6F49D08@qq.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 10 Apr 2025 15:23:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jfAdBbKXBg7k0og6MucptJc9G=RTzFPd=N3Q0VdfToFQ@mail.gmail.com>
X-Gm-Features: ATxdqUFCwlbj0go7vNzpWyH9o9Srm-eULI9a3R27FKSSz_G2gBxWttNvIfXFkBs
Message-ID: <CAJZ5v0jfAdBbKXBg7k0og6MucptJc9G=RTzFPd=N3Q0VdfToFQ@mail.gmail.com>
Subject: Re: [PATCH] PM: EM: Fix potential division-by-zero error in em_compute_costs()
To: Yaxiong Tian <iambestgod@qq.com>
Cc: lukasz.luba@arm.com, rafael@kernel.org, len.brown@intel.com, 
	pavel@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 7:39=E2=80=AFAM Yaxiong Tian <iambestgod@qq.com> wr=
ote:
>
> From: Yaxiong Tian <tianyaxiong@kylinos.cn>
>
> When the device is of a non-CPU type, table[i].performance won't be
> initialized in the previous em_init_performance(), resulting in division
>  by zero when calculating costs in em_compute_costs().
>
> Considering that the performance field in struct em_perf_state is defined
> as "CPU performance (capacity) at a given frequency", the original
> calculation method should be maintained when the device is of a non-CPU
> type.
>
> Fixes: <1b600da51073> ("PM: EM: Optimize em_cpu_energy() and remove divis=
ion")
>
> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
> ---
>  kernel/power/energy_model.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index d9b7e2b38c7a..bbd95573d91e 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -231,9 +231,11 @@ static int em_compute_costs(struct device *dev, stru=
ct em_perf_state *table,
>                             unsigned long flags)
>  {
>         unsigned long prev_cost =3D ULONG_MAX;
> +       u64 fmax;

Why not initialize it here?  Also please retain the reverse x-mas tree
ordering of declarations.

>         int i, ret;
>
>         /* Compute the cost of each performance state. */
> +       fmax =3D (u64) table[nr_states - 1].frequency;

No need to cast to u64 explicitly (it will be cast anyway).

>         for (i =3D nr_states - 1; i >=3D 0; i--) {
>                 unsigned long power_res, cost;
>
> @@ -245,9 +247,15 @@ static int em_compute_costs(struct device *dev, stru=
ct em_perf_state *table,
>                                 return -EINVAL;
>                         }
>                 } else {
> -                       /* increase resolution of 'cost' precision */
> -                       power_res =3D table[i].power * 10;
> -                       cost =3D power_res / table[i].performance;
> +                       if (_is_cpu_device(dev)) {
> +                               /* increase resolution of 'cost' precisio=
n */
> +                               power_res =3D table[i].power * 10;
> +                               cost =3D power_res / table[i].performance=
;
> +                       } else {
> +                               power_res =3D table[i].power;
> +                               cost =3D div64_u64(fmax * power_res, tabl=
e[i].frequency);

Why is it necessary to compute the "cost" field value for non-CPU
devices at all?

> +

An excess empty line.

> +                       }
>                 }
>
>                 table[i].cost =3D cost;
> --

