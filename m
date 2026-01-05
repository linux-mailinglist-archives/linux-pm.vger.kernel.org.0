Return-Path: <linux-pm+bounces-40223-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A5ECF5353
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 19:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DB3530351D6
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 18:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4B13218DD;
	Mon,  5 Jan 2026 18:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeJ5E/RN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0960F31AF09
	for <linux-pm@vger.kernel.org>; Mon,  5 Jan 2026 18:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767636960; cv=none; b=KaozQcvnneGxzaP5Pc4GD53q1ON3IN7L+UNK30RsM2jUhdWyC2ZTJWRLkKQdnLehQGrpopPfbY+ZeMkCK/HU8LoZW53oxk5hMyeVQ9zLGxje+gODHNAORRwQXB+fy/D6Zbzzq8SmRcHFLRAUyaINH9GMlTLF2A5ZiWTM9JTw3Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767636960; c=relaxed/simple;
	bh=iGyOLxUKYuDaIZtv89LifJvxneMg9tb2oBlXxH4Rl2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5qmX9yplf1jOtDC8fS+ep+mr+egUp16BAxS32QMPp+DAUrE8DhIG/QeYUHudCZUSekIx/wiZXbZkZOjuRgTJKuhphp3ijr8QTMcqVcmM++nfTDKae58fi/2c8lLd3Vw411BhPtfVPd90yj9AuIUTOm5dz2X7EM6Of0dmqCp+rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeJ5E/RN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5ADFC19424
	for <linux-pm@vger.kernel.org>; Mon,  5 Jan 2026 18:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767636959;
	bh=iGyOLxUKYuDaIZtv89LifJvxneMg9tb2oBlXxH4Rl2U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LeJ5E/RN/0JszFg0FQ8S1atzsOhKO4fvlVmgSV78o5m7qrbr2O/8+avUtBgWXqEJx
	 KfUI7Nfn2INT9Gqi+ukfttuUvOolOrFncxzcSy+Aj9xGldWwLcoOst5QeOzHWnmRMy
	 JFxEIqp/KS3F+TTu5orLnM2v83FoqAQHRS7ZZyb7Cfe9KOCqtxRCaAERt1J8Uz12DA
	 yD/YuobusVmZxf5xJcSeciYRF2EgdUhThKSJee00iZCxXjmf8pFw4WD3tUmyxRKq8x
	 bbUDMBTT1GdbcToHhwXrY7Tbdb75FhPCaS7PnEhxK4O6QjOB+NHK7gU/7n/4W4ZqqL
	 PwuXlhZQYSxJA==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-65cb1d8aa3eso42184eaf.2
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 10:15:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXkE+zX3XQ46BbQvXQlrvaYm3w9MzbqME/IAGKYVCfYn3w9Ii+kyEpxx+P3xcGKUwxSBNy6AdFpvA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEeca99nhnt4FuNvN8L1EvqDZHvij4ZUHOhVvW1pQ/YpqsxPuE
	i+r5nVI/Jhtem9ANdfAjrADJKqmTcJ/Zx5kvGAxajG/yfWDkG+egVTTPRCNkiAF0+lrN4cLtSmh
	1uqmsWNsMf5S/1DBHdNB6uX5+TRacsJQ=
X-Google-Smtp-Source: AGHT+IGk8SymtWERirBOWXQejqL2iHtUQ/aYD4/qP64UvXJAKEsPQ67BP+dUFNftJ6Drvq2Q919My2VZZv9mu5cYpFQ=
X-Received: by 2002:a05:6820:f006:b0:659:9a49:908f with SMTP id
 006d021491bc7-65f479a159cmr234682eaf.14.1767636958755; Mon, 05 Jan 2026
 10:15:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0hn1E=tWVoG7nKsD3_KGygkaGpeSoQ4JsMaJNgugT_Tnw@mail.gmail.com>
 <20251230115613.64080-1-mrout@redhat.com>
In-Reply-To: <20251230115613.64080-1-mrout@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 5 Jan 2026 19:15:47 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gErAwBw_moSmO+qB2tY4dqLtTBm-YZprCPUDJGfLKBwA@mail.gmail.com>
X-Gm-Features: AQt7F2rJ6nb-hcLTPN7wIWcO7aBCE4iteaBmzyp9Kbu5r9lam5dwS1eYUrCgf-A
Message-ID: <CAJZ5v0gErAwBw_moSmO+qB2tY4dqLtTBm-YZprCPUDJGfLKBwA@mail.gmail.com>
Subject: Re: [PATCH v2] PM: hibernate: Fix crash when freeing invalid crypto compressor
To: Malaya Kumar Rout <mrout@redhat.com>
Cc: rafael@kernel.org, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 12:56=E2=80=AFPM Malaya Kumar Rout <mrout@redhat.co=
m> wrote:
>
> When crypto_alloc_acomp() fails, it returns an ERR_PTR value, not NULL.
> The cleanup code in save_compressed_image() and load_compressed_image()
> unconditionally calls crypto_free_acomp() without checking for ERR_PTR,
> which causes crypto_acomp_tfm() to dereference an invalid pointer and
> crash the kernel.
>
> This can be triggered when the compression algorithm is unavailable
> (e.g., CONFIG_CRYPTO_LZO not enabled).
>
> Fix by adding IS_ERR_OR_NULL() checks before calling crypto_free_acomp()
> and acomp_request_free(), similar to the existing kthread_stop() check.
>
> Fixes: b03d542c3c95 ("PM: hibernate: Use crypto_acomp interface")
> Signed-off-by: Malaya Kumar Rout <mrout@redhat.com>
> ---
>  kernel/power/swap.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 33a186373bef..8ee2fa995580 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -902,8 +902,10 @@ static int save_compressed_image(struct swap_map_han=
dle *handle,
>                 for (thr =3D 0; thr < nr_threads; thr++) {
>                         if (data[thr].thr)
>                                 kthread_stop(data[thr].thr);
> -                       acomp_request_free(data[thr].cr);
> -                       crypto_free_acomp(data[thr].cc);
> +                       if (data[thr].cr)
> +                               acomp_request_free(data[thr].cr);
> +                       if (!IS_ERR_OR_NULL(data[thr].cc))
> +                               crypto_free_acomp(data[thr].cc);
>                 }
>                 vfree(data);
>         }
> @@ -1499,8 +1501,10 @@ static int load_compressed_image(struct swap_map_h=
andle *handle,
>                 for (thr =3D 0; thr < nr_threads; thr++) {
>                         if (data[thr].thr)
>                                 kthread_stop(data[thr].thr);
> -                       acomp_request_free(data[thr].cr);
> -                       crypto_free_acomp(data[thr].cc);
> +                       if (data[thr].cr)
> +                               acomp_request_free(data[thr].cr);
> +                       if (!IS_ERR_OR_NULL(data[thr].cc))
> +                               crypto_free_acomp(data[thr].cc);
>                 }
>                 vfree(data);
>         }
> --

Applied as 6.19-rc material, thanks!

