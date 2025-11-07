Return-Path: <linux-pm+bounces-37622-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B04B2C40B31
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 16:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3695C34FF4C
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 15:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BA532D42D;
	Fri,  7 Nov 2025 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKF2fM7y"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12AA32BF4B
	for <linux-pm@vger.kernel.org>; Fri,  7 Nov 2025 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531007; cv=none; b=GxG3ovHLwqYu4bnxfUHjVP3Tzfz0niqYuefORDiENoo3bJ2tDombbgfGUnLFqYvvjIxpGvvO7NnvjXl3o9ZakZ86b18YaFIzYBMoKm7qqoiBp6CaB2EaHYj+vbVFEgnd+F0gKd3540k/amrZhLdxcdS/9YRDxeRxZ/9fOJEn2LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531007; c=relaxed/simple;
	bh=5J4mzpg4ibKLPOESnlPtSPkFmUgjAih2G313tL5xuvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJgWhXBg++MizQ7D0otGNOa7wRbqKsfF/H+9nH5zKdeP/q5rGsiybpCfAoD/tdYN4j+QUj7lsPU3Q6GWGjavP80rYQL+G18NysILyLjJbkDZ+hODinUOJJsCy9SkyHIGx9QQ3OK2WoQGMmgqNJLq9xxOO7PoZmLui8hZbDq6W4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKF2fM7y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B9AC4CEF8
	for <linux-pm@vger.kernel.org>; Fri,  7 Nov 2025 15:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762531007;
	bh=5J4mzpg4ibKLPOESnlPtSPkFmUgjAih2G313tL5xuvQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XKF2fM7yYw6FpBiqkRMLZnlphQ5FHhSePZIsJo/Oz5WtOPDRYtDlPP/aXanE6LQWh
	 D8QKRYZCbpVNrn9enoP0ktheriN93TpmHf5/PlLyYmiHa0gNRryji+5X8QqOf+xcPe
	 y/hCzHRUu48gRba+xwBZHyP0i7ayPYg5EpFWZFF0DmZt3rqbNsXilQUGp1tiazOybn
	 75zV0jhuwkzch3mcCqGMwSMsAUV7n/PsAHkaBvn+Zv8V1fqagFut8LWDKZJ39z2Qan
	 gUPZPCb8y7J5h0EvsXsQ7vIprxAhXmzLW9x7IFIp2xCdbIUE7WWcGwbNz+01uQT12D
	 EjGjYltlRyU8g==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-656b7f02b56so468972eaf.0
        for <linux-pm@vger.kernel.org>; Fri, 07 Nov 2025 07:56:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUMbcOMweac6oaWE7EJZeIxigKnMvmjbPrW1idALDW0qZpn8kvHUmXhnzvd1i/vlhBMJcc0yhvCwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNJoDbhEb420uC/paNhQPHZzUsbqZ4H87K8YCFozK5hajckfuM
	Jc9WcKj6MRaNn8oH8npc/K9YxaZMnxt0bjnsW+gKqsqUjsipD0QnjYItD+XUkc5wuLCHyx8+W74
	ogQMdg9x/PCzY9xOzspKzRU79Iao8roQ=
X-Google-Smtp-Source: AGHT+IH6HcWkhI+hHyxR6if0hOSgjUQyrBPSMt+JO3mT0Qt9M5a6eycuwQImrW9KnRj6K7T+TFFKBnNoy5q2bo48FQA=
X-Received: by 2002:a05:6820:7182:b0:656:9adc:2d72 with SMTP id
 006d021491bc7-656d1c47235mr1023346eaf.2.1762531006956; Fri, 07 Nov 2025
 07:56:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106045158.3198061-1-superm1@kernel.org> <20251106045158.3198061-3-superm1@kernel.org>
In-Reply-To: <20251106045158.3198061-3-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Nov 2025 16:56:36 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jKitDQinYiLn8d2iuWpOtoBBBf4+Qm=bH+-DbbCBdpMQ@mail.gmail.com>
X-Gm-Features: AWmQ_bl1sDbKYQxLR5erR3Z4j1hAZoBykXrm5yAg0ikfFbDa8bXZBn8vX0umXi0
Message-ID: <CAJZ5v0jKitDQinYiLn8d2iuWpOtoBBBf4+Qm=bH+-DbbCBdpMQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] PM: hibernate: Use atomic64_t for compressed_size variable
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: mario.limonciello@amd.com, lenb@kernel.org, pavel@kernel.org, 
	rafael@kernel.org, Askar Safin <safinaskar@gmail.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 5:52=E2=80=AFAM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> `compressed_size` can overflow, showing nonsensical values.
> Change from `atomic_t` to `atomic64_t` to prevent overflow.
>
> Reported-by: Askar Safin <safinaskar@gmail.com>
> Closes: https://lore.kernel.org/linux-pm/20251105180506.137448-1-safinask=
ar@gmail.com/
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  kernel/power/swap.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index f9bf01f355189..37270fa5ea600 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -635,7 +635,7 @@ struct cmp_data {
>  };
>
>  /* Indicates the image size after compression */
> -static atomic_t compressed_size =3D ATOMIC_INIT(0);
> +static atomic64_t compressed_size =3D ATOMIC_INIT(0);
>
>  /*
>   * Compression function that runs in its own thread.
> @@ -664,7 +664,7 @@ static int compress_threadfn(void *data)
>                 d->ret =3D crypto_acomp_compress(d->cr);
>                 d->cmp_len =3D d->cr->dlen;
>
> -               atomic_set(&compressed_size, atomic_read(&compressed_size=
) + d->cmp_len);

Hmm, how did I miss this?

> +               atomic64_add(d->cmp_len, &compressed_size);
>                 atomic_set_release(&d->stop, 1);
>                 wake_up(&d->done);
>         }
> @@ -696,7 +696,7 @@ static int save_compressed_image(struct swap_map_hand=
le *handle,
>
>         hib_init_batch(&hb);
>
> -       atomic_set(&compressed_size, 0);
> +       atomic64_set(&compressed_size, 0);
>
>         /*
>          * We'll limit the number of threads for compression to limit mem=
ory
> @@ -879,8 +879,8 @@ static int save_compressed_image(struct swap_map_hand=
le *handle,
>                 ret =3D err2;
>         if (!ret) {
>                 swsusp_show_speed(start, stop, nr_to_write, "Wrote");
> -               pr_info("Image size after compression: %d kbytes\n",
> -                       (atomic_read(&compressed_size) / 1024));
> +               pr_info("Image size after compression: %lld kbytes\n",
> +                       (atomic64_read(&compressed_size) / 1024));
>                 pr_info("Image saving done\n");
>         } else
>                 pr_err("Image saving failed: %d\n", ret);
> --

Applied as 6.18-rc material along with the other patches in the
series, with some changelog adjustments, added tags etc.

Thanks!

