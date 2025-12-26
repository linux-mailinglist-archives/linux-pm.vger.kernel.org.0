Return-Path: <linux-pm+bounces-39950-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C305CCDEBAB
	for <lists+linux-pm@lfdr.de>; Fri, 26 Dec 2025 14:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B68E300957C
	for <lists+linux-pm@lfdr.de>; Fri, 26 Dec 2025 13:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A7E322B71;
	Fri, 26 Dec 2025 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QU1EohZZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86C33195E6
	for <linux-pm@vger.kernel.org>; Fri, 26 Dec 2025 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766755275; cv=none; b=E0z8scR1ZClS5TZgi3sXblzlV/V/6Gahu/jS3TEPWWv0pbhUNAGScUiLHO2G9Nhg38mYsJ3zkc0ichUjpBAsnZIk/hQIjxH9tjHVcBt/eY+SQwjKN3n6f2Lvp0jmVFC7d5mrCjCUZ1fn9LAvQTnS1UNTsWRAjE+QhTzjQEyactk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766755275; c=relaxed/simple;
	bh=MNoNUciY1e+7b730RbNDwInm/mhXf1WWpbjhtZLTSiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XHPxYbbaVeny66foVNhsmXat9j3moDVO/Q+BFsD/yESM8u3Rpt2dYkCvUJULNLxvaymmccwo2bOhVt7wpjT18bSz/f7BJdHxn2/H2+I/N0s19AnE+u/DkHARkXqVCiLznv9ADizhcO0vYTjVtRh1a6DDEZ+xA5OV20fxKP1pmh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QU1EohZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8195BC4CEF7
	for <linux-pm@vger.kernel.org>; Fri, 26 Dec 2025 13:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766755274;
	bh=MNoNUciY1e+7b730RbNDwInm/mhXf1WWpbjhtZLTSiw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QU1EohZZYS1+RFJd0Y04p3ihQvVuV3Bnw/41kJr589S7dfo3ruwFXypHLo+5nVQNg
	 2Ckyuki/7c+T/Ou1Vr+OJNXoZ8IKG0YfR7Z7cDxt2Ih6Wpv9x/7RgkFU59pd5ijnRZ
	 N1MxJQ2m4jORrJp9JMbPLlnYNX6rlqgl9XpQbwU7RsIdziQktz78/Tr4SQr3fOhQ4u
	 KzekFfrfs0lIftUrSvTaWYD7WX8xIxr1U21wqMqVW4Dp+XvHNNvgPVr2stPm1VzX4N
	 UKvR/JAT6XMSWl447pnt8Tpez9mrPplaUSHqlg/4taOBMAt4aJJdkVw3DNCFv84q/l
	 viIAGru32+dSA==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-3e0f19a38d0so5256442fac.0
        for <linux-pm@vger.kernel.org>; Fri, 26 Dec 2025 05:21:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWbP5BL7qUTkj5Omf8TAbiJT0z3bkwFBZ6JGXVufSiQ+l5ei+fKjQoslxnPqobqAubXDGj0Lacgdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYhxv8Mvvj7qSS89DBvhShtVqSFwecajtPMhebHIg+2QxbT5dT
	ha8Yv3t8GCMTXDRzsTXDb2HInB9yklaTjbXwbignAIjf9E/QX8taZDivGUjeRvzasvObSEVGB6O
	iCvQDVE22ha8X2tUPtSw6NnstG/Lcezg=
X-Google-Smtp-Source: AGHT+IFzO9spBqAO7Jlhyit3/2/eo8sSofRrtbJ985aehe0z1mQruZGtg/ocSMdIVt0nENMoZUpPRNeUE2V6lQbWo4Q=
X-Received: by 2002:a05:6820:4003:b0:65c:fa23:2d02 with SMTP id
 006d021491bc7-65d0e98e734mr8084783eaf.19.1766755273650; Fri, 26 Dec 2025
 05:21:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224182055.124020-1-mrout@redhat.com>
In-Reply-To: <20251224182055.124020-1-mrout@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 26 Dec 2025 14:20:59 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hn1E=tWVoG7nKsD3_KGygkaGpeSoQ4JsMaJNgugT_Tnw@mail.gmail.com>
X-Gm-Features: AQt7F2oGE1ygVufIKtM19Oxoy-ouQlb770WJQaPVc4dAHOLklFg6ImZRWOBDv28
Message-ID: <CAJZ5v0hn1E=tWVoG7nKsD3_KGygkaGpeSoQ4JsMaJNgugT_Tnw@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: Fix crash when freeing invalid crypto compressor
To: Malaya Kumar Rout <mrout@redhat.com>
Cc: linux-kernel@vger.kernel.org, malayarout91@gmail.com, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2025 at 7:21=E2=80=AFPM Malaya Kumar Rout <mrout@redhat.com=
> wrote:
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
> Signed-off-by: Malaya Kumar Rout <mrout@redhat.com>

I think that it should be possible to find a specific commit fixed by
this and provide a Fixes: tag pointing to it.

Can you please do so?

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
> 2.51.0
>

