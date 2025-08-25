Return-Path: <linux-pm+bounces-33045-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5088EB34A9A
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 20:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8F397A61E6
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 18:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18D8220680;
	Mon, 25 Aug 2025 18:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cj+9mOBS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7533D273F9;
	Mon, 25 Aug 2025 18:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756147687; cv=none; b=eX/rJyaryQHQlSJ0GGOURTvn4F8oAPTk6yZ+nXs+IXlRUyCEs5nyxJ+Dg6rits+Hla/f7BphgYrbLT2A3tZkxri8+gpB3SFSalv77/oTIX/MUpFW/XKOpMkJxaEhqxGYwintETjLUcaqoVPgtMfQrsgCUxHRfn+h/qLP58fqm24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756147687; c=relaxed/simple;
	bh=kfLmNjNderRjEUSpgFX2CtsfpkMVTGbPS3oFzNXZnuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WANxEWgT8i2L1Q3UR6T6pwSPpW2hvXbgSjbLRSDf8YvcHc/6Ke9/yDB+qJzl7IDOc9enA6Ahoi3s0gILaSS2Csf9or0PggpFje7CYiMPuHSKLUjK0N9VJrVMry+Rcje8v5tmgoLtmLVgfg47tw7X9WRyAFZr1wbq5Ag9NbLUZSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cj+9mOBS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D4FC4CEED;
	Mon, 25 Aug 2025 18:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756147687;
	bh=kfLmNjNderRjEUSpgFX2CtsfpkMVTGbPS3oFzNXZnuk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Cj+9mOBS9+8QsLYmHc6OTK/qiimHWdSm30p7Qn7kcjF9eCPWp2Mtk1ejVQf42OACn
	 UuixcYcn9V5ceV3Elb8DSyz00bx9XkGXBKVs8F4RuXZ9/ig9pIc9niS8m8pIVACTru
	 sGYz6Yx5CaCFK10FNAlbq9LX6h6fhDJ2XCrauCQUwLY2ynGjtWeiAkpvNqdvDR/1Ik
	 e2B2Ps2IaK1Aknb/fiVfm04gReUPf7JOsZHBWxtlD83PBXqyHlqlwLqLg7rbxL5FdR
	 UHWyLHimAc3sOR3Tvq5tttuSBf3orUOLG8RmAQDBn7fEH2o/wlVNd3ob+OVnun5RVm
	 N16Wg3eBdHjRA==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-61bd4e002afso1466992eaf.2;
        Mon, 25 Aug 2025 11:48:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwGmOBG9ySH+OGT5QIbTIbjdGJPIfyXeDoyY87Yj2MJ6gYChRsxNZYWH9n7FxhQG7c2E5aV5sHMkdSwnY=@vger.kernel.org, AJvYcCVaAqPsSgMfKdxplsWQu2hARUuCXdhXPkL5WgSClLZTg1LZjcSR3JV4U1tXWV63CYk/hjNQxYbE7jQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbzZWFTXa8zOg09tHlhkIk3M5hO9S7FhdC16mlNYRYYtHHWk59
	oRb0FE3i+ba/Jf+JhaPlejQGe+1wxD262jfwq4oFhpQYch9pYNp61Y4vvyFnvq6nPiE1lJyYAdD
	mVXKT0S10oGHrdc74J8+KTU2ruf9cpAg=
X-Google-Smtp-Source: AGHT+IGvFPWw/GJUY0GJQlcJtrWTQ/xwaprAF7FRCJ5TwDyxv6wYLLTmzGgo9Q+6wSVArhJGjFsDRRDOJ1Ct35pf4n8=
X-Received: by 2002:a05:6808:1907:b0:433:fd1b:73f1 with SMTP id
 5614622812f47-43785261777mr5520613b6e.6.1756147686307; Mon, 25 Aug 2025
 11:48:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250817083636.53872-1-rongqianfeng@vivo.com>
In-Reply-To: <20250817083636.53872-1-rongqianfeng@vivo.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Aug 2025 20:47:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iEk2MeXLabuafZdQ3iWaVeB2srrXgZ35=qacOyOknWQQ@mail.gmail.com>
X-Gm-Features: Ac12FXyjVCma_9tpvLgr-AFHrBnFBXJVYl_9K7sKvqx2tCe5PKDyQRmbe_-mIdQ
Message-ID: <CAJZ5v0iEk2MeXLabuafZdQ3iWaVeB2srrXgZ35=qacOyOknWQQ@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: Use vmalloc_array() and vcalloc() to
 improve code
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 17, 2025 at 10:36=E2=80=AFAM Qianfeng Rong <rongqianfeng@vivo.c=
om> wrote:
>
> Remove array_size() calls and replace vmalloc() and vzalloc() with
> vmalloc_array() and vcalloc() respectively to simplify the code in
> save_compressed_image() and load_compressed_image().  vmalloc_array()
> is also optimized better, resulting in less instructions being used,
> and vmalloc_array() handling overflow is more concise [1].
>
> [1]: https://lore.kernel.org/lkml/abc66ec5-85a4-47e1-9759-2f60ab111971@vi=
vo.com/
>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  kernel/power/swap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index ad13c461b657..0beff7eeaaba 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -712,7 +712,7 @@ static int save_compressed_image(struct swap_map_hand=
le *handle,
>                 goto out_clean;
>         }
>
> -       data =3D vzalloc(array_size(nr_threads, sizeof(*data)));
> +       data =3D vcalloc(nr_threads, sizeof(*data));
>         if (!data) {
>                 pr_err("Failed to allocate %s data\n", hib_comp_algo);
>                 ret =3D -ENOMEM;
> @@ -1225,14 +1225,14 @@ static int load_compressed_image(struct swap_map_=
handle *handle,
>         nr_threads =3D num_online_cpus() - 1;
>         nr_threads =3D clamp_val(nr_threads, 1, CMP_THREADS);
>
> -       page =3D vmalloc(array_size(CMP_MAX_RD_PAGES, sizeof(*page)));
> +       page =3D vmalloc_array(CMP_MAX_RD_PAGES, sizeof(*page));
>         if (!page) {
>                 pr_err("Failed to allocate %s page\n", hib_comp_algo);
>                 ret =3D -ENOMEM;
>                 goto out_clean;
>         }
>
> -       data =3D vzalloc(array_size(nr_threads, sizeof(*data)));
> +       data =3D vcalloc(nr_threads, sizeof(*data));
>         if (!data) {
>                 pr_err("Failed to allocate %s data\n", hib_comp_algo);
>                 ret =3D -ENOMEM;
> --

Applied as 6.18 material with some edits in the changelog, thanks!

