Return-Path: <linux-pm+bounces-29856-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A343AEE810
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 22:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05953E005C
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 20:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1122309B0;
	Mon, 30 Jun 2025 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwZsr1xX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BAB21CA1F;
	Mon, 30 Jun 2025 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751314879; cv=none; b=h3vjwI3URVfFKQH02qoeUtANOROCSE448hfD1I0RwkLLcY/V8nJ0K9KpLuK50NKgtBdfzck35f3eEj+BJhoFmObWk7rDwGOC7FyWFFKqoY/JHK94NLEsw3a1cnYQUPoogcAxSmdwetM5bzlaRXimenU0IYPqFaidwPYsRQ9mrdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751314879; c=relaxed/simple;
	bh=Fwnv+3tI8qpYaNOAohnsjqByw40uQGXP3Ew7dw6SJA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+o9Vh/meuVRbT5giJEtCk+fWTTG9ThsaA36nSHwNQoaOf8ovuq2gcahLQmbYRnThL4NTIbqVPB/UJ8woWD69UmmYPGi7wyzbTBdjRCn+rHIKPxh9VYwoNYxd6J6kqiUgCHfKUycNRgIDGkFIa4wEWgoDMN19NDZcqMsfLkA/Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwZsr1xX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB35DC4AF09;
	Mon, 30 Jun 2025 20:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751314876;
	bh=Fwnv+3tI8qpYaNOAohnsjqByw40uQGXP3Ew7dw6SJA8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YwZsr1xX+f4zd1tKcntuyeRJiCHKqqtQ7eHY5VqiH0XMuY24YtQDRDsDvrsSUaMXe
	 3p0j79Ik0tqnefle7qOltOyqosNox8H0hRG9Cb8YlBUC3SRmoptWLWJ4GgHde5Jc8e
	 8HZO9Qj3Lv1oFsnn5C77CEwZy5R2ua87vNfyEF96RYuLoD8bwXVew/yQOLP3E72U71
	 KM/VORM19/XBvUkb1tQ5EABlHc0If4V1wWOvz5+GafEhTAkJtZzZzmEz2LbuAPYmFW
	 x9YmrQER/arhm3zNNc5i6TrjD4ET10n8WvYpjIGps4KmIpqCAZ9Z2rs6puye2vzcsv
	 /DKYjzJe6go0w==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-60f276c7313so1611043eaf.2;
        Mon, 30 Jun 2025 13:21:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZViIrvVou+kNrkRHf/TeXmKb/XArfFwW2/07OgEkIV5kaGikCbYXRlpFVuQLaC9YtxWBdmYB91LA=@vger.kernel.org, AJvYcCXYYdXc6Z2aj0VwLaZ9KZjD1b4W8/6K1FrZ37Ml7z36W0/oFAss9zcqUa+tn2KXS6U0wVjr7r06HS4RxEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRK/8rMdunRPesXsCqzzPOthhtT3CBqyJ/9Hdkv1VdWvCrrbvw
	dUkU1lClSvGjomaDEtuQb7LkMGy+dIYnT7oR7Us7BnxP+ji5uLqloQTJhK+MjyFwsZGleZs2KgY
	ajckM6P8t4iEDoednYAfTvh+eJz5nETE=
X-Google-Smtp-Source: AGHT+IHwBKk2EFjdrktPIO4q1VjCPfY5q+iVAPT3tEDnoSpBPNjqGQzYmuLvHcfpLiofmKKiMqsX8EX0gS5R2y5J/mc=
X-Received: by 2002:a05:6820:8109:b0:611:4bfe:610a with SMTP id
 006d021491bc7-611b90edbcfmr9164059eaf.8.1751314875866; Mon, 30 Jun 2025
 13:21:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630104116.3050306-1-guoqing.zhang@amd.com> <20250630104116.3050306-3-guoqing.zhang@amd.com>
In-Reply-To: <20250630104116.3050306-3-guoqing.zhang@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 30 Jun 2025 22:21:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i2v+yUyNes4KpTpDuQVdS8m1x0eBva5_GrMpmuWT4oKQ@mail.gmail.com>
X-Gm-Features: Ac12FXxQnPDN8j2mvespiFaa_u1FRxEcRxrjhC9FkCzbNLDo-NAXahtAh7DLk0E
Message-ID: <CAJZ5v0i2v+yUyNes4KpTpDuQVdS8m1x0eBva5_GrMpmuWT4oKQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] PM: hibernate: shrink shmem pages after dev_pm_ops.prepare()
To: Samuel Zhang <guoqing.zhang@amd.com>
Cc: rafael@kernel.org, len.brown@intel.com, pavel@kernel.org, 
	alexander.deucher@amd.com, christian.koenig@amd.com, 
	mario.limonciello@amd.com, lijo.lazar@amd.com, victor.zhao@amd.com, 
	haijun.chang@amd.com, Qing.Ma@amd.com, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 12:41=E2=80=AFPM Samuel Zhang <guoqing.zhang@amd.co=
m> wrote:
>
> When hibernate with data center dGPUs, huge number of VRAM data will be
> moved to shmem during dev_pm_ops.prepare(). These shmem pages take a lot
> of system memory so that there's no enough free memory for creating the
> hibernation image. This will cause hibernation fail and abort.
>
> After dev_pm_ops.prepare(), call shrink_all_memory() to force move shmem
> pages to swap disk and reclaim the pages, so that there's enough system
> memory for hibernation image and less pages needed to copy to the image.
>
> This patch can only flush and free about half shmem pages. It will be
> better to flush and free more pages, even all of shmem pages, so that
> there're less pages to be copied to the hibernation image and the overall
> hibernation time can be reduced.
>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> ---
>  kernel/power/hibernate.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 10a01af63a80..913a298c1d01 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -370,6 +370,17 @@ static int create_image(int platform_mode)
>         return error;
>  }
>
> +static void shrink_shmem_memory(void)
> +{
> +       struct sysinfo info;
> +       unsigned long pages, freed;
> +

Please add a comment explaining what is going on here.

> +       si_meminfo(&info);
> +       pages =3D info.sharedram;
> +       freed =3D shrink_all_memory(pages);
> +       pr_debug("requested to reclaim %lu pages, freed %lu pages\n", pag=
es, freed);

This message will be hard to decode without any context.

> +}
> +
>  /**
>   * hibernation_snapshot - Quiesce devices and create a hibernation image=
.
>   * @platform_mode: If set, use platform driver to prepare for the transi=
tion.
> @@ -411,6 +422,8 @@ int hibernation_snapshot(int platform_mode)
>                 goto Thaw;
>         }
>

Please add a comment explaining why the below is done.

> +       shrink_shmem_memory();
> +
>         suspend_console();
>         pm_restrict_gfp_mask();
>
> --
> 2.43.5
>
>

