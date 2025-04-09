Return-Path: <linux-pm+bounces-25031-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D69A82E53
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 20:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D82886DFB
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 18:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60332777E1;
	Wed,  9 Apr 2025 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUMXlFsJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB94727703E;
	Wed,  9 Apr 2025 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744222515; cv=none; b=hwJxHzKHrK13CqT9O6Z6+zMUqeHVGSLeCTwkrd5lcOSBJJ0BQtFXnqCg8MqPnTRfz4c7gJs8bsOjWCg25OyN12Y1xh86t+qoXNVjHJ2glcp5YLAhXFJ48RoF8zMsOeqpsRdOFp4ukwu2GgDVXRc/cVXUtkaXMwmJ2m79PhMSh1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744222515; c=relaxed/simple;
	bh=4r5HG3NTq9biZEw4Uj9EEIPEGtxbWgWfLLlxbu+5Uk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IxrEytu5yiHk7QzK//S1AHvoWC2hR0SJwUX4UeP3n8Zc81RSuXBzkz4PEqZzfHgbZ57+jvMoaDn9CjSfTME0V+1t21Ezr+qP28nnY/jbGAW0B8fsBCBhTaY0tjjVwywl8Aqt//39cD//ZSngAlXupX3nk1DHoTcisHkAxv1kZ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUMXlFsJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B45C4AF09;
	Wed,  9 Apr 2025 18:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744222515;
	bh=4r5HG3NTq9biZEw4Uj9EEIPEGtxbWgWfLLlxbu+5Uk0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OUMXlFsJD2ytyFDOCigXg+ShBeLN08E376X/Emjr92uXdgxlX3EYTK5XjpmS4v84/
	 qsbQghWx3FblyVyKum8U6AiinZgmuXCpwIGcIHMOJ86WAAWLRXH08w4pS+/WrWiwSu
	 ViSlBezfXI+1RIn38VXeliubwsLokM4SzVsGJDznx/EOQB0Iwbkzt7t8hdLcHZ8Inr
	 xDyTZ8D6AXIT9aCEMmYCw7sMMvTLPUxx9cYcYjTBwGOUEe7Y+TvPwnf2G+8N94FhVx
	 MNLqVmyfAmwQMXiLpq2WyUcHWY+c+TMkFwd9Go7XYFaLxJUN+kRFBQ7OXNNasSJ2WR
	 eiUQsEg+FOgXQ==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6044db3b45bso1266216eaf.1;
        Wed, 09 Apr 2025 11:15:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVKTMBsz9l0kZL9cloyNmE/9kAezRLCptYGJq8b33zDo3+CLuA3uIM9fCgRsAjHabd5trjRhAemuLL6h1c=@vger.kernel.org, AJvYcCXywIL71Fw4iJEvOaH9M4TEIC5R/8zFfQKlmBz1BUkkixMtgQA2qH6i0/3DCpkdMc847fq9X8RpgeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKZCi0S6e/LGHhcgLJZUpAdULGCzp9Zbzhfdg3B8X18I37igvr
	2m6IiyJz3KYh6J/HxP7afeie7OPm9VWjiFj3sWcagNBelJEht06prMDDtc25rRev+5JHWzeWc4b
	AAuUZgWTOzCyIpWNPG/lRgspjIKM=
X-Google-Smtp-Source: AGHT+IHc0XT92maYQsZMhlvcO6Yxw3Krw6nEwd0v7SCqAcl25HTX77lX1X46ge/9KAbZEIg217Bv5g+fdhkX3476zXQ=
X-Received: by 2002:a05:6870:164c:b0:2c2:b18c:9be9 with SMTP id
 586e51a60fabf-2d091718fdfmr2013141fac.3.1744222514331; Wed, 09 Apr 2025
 11:15:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318080755.61126-2-thorsten.blum@linux.dev>
In-Reply-To: <20250318080755.61126-2-thorsten.blum@linux.dev>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Apr 2025 20:15:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ieQTjM1a8mCf5oqFxFZcb6GJM9vcHB1_NHo4sQ5sSNJw@mail.gmail.com>
X-Gm-Features: ATxdqUEsZScLn3IiT-Ti7w4GXgeUD6TxQQWhCmxnbbKMFWVfhoqzKsitfAdnfqE
Message-ID: <CAJZ5v0ieQTjM1a8mCf5oqFxFZcb6GJM9vcHB1_NHo4sQ5sSNJw@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: Remove size arguments when calling strscpy()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 9:09=E2=80=AFAM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> The size parameter is optional and strscpy() automatically determines
> the length of the destination buffer using sizeof() if the argument is
> omitted. This makes the explicit sizeof() calls unnecessary. Remove
> them to shorten and simplify the code.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  kernel/power/hibernate.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 10a01af63a80..ddf7c4a5736f 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -756,7 +756,7 @@ int hibernate(void)
>          * Query for the compression algorithm support if compression is =
enabled.
>          */
>         if (!nocompress) {
> -               strscpy(hib_comp_algo, hibernate_compressor, sizeof(hib_c=
omp_algo));
> +               strscpy(hib_comp_algo, hibernate_compressor);
>                 if (crypto_has_comp(hib_comp_algo, 0, 0) !=3D 1) {
>                         pr_err("%s compression is not available\n", hib_c=
omp_algo);
>                         return -EOPNOTSUPP;
> @@ -1005,9 +1005,9 @@ static int software_resume(void)
>          */
>         if (!(swsusp_header_flags & SF_NOCOMPRESS_MODE)) {
>                 if (swsusp_header_flags & SF_COMPRESSION_ALG_LZ4)
> -                       strscpy(hib_comp_algo, COMPRESSION_ALGO_LZ4, size=
of(hib_comp_algo));
> +                       strscpy(hib_comp_algo, COMPRESSION_ALGO_LZ4);
>                 else
> -                       strscpy(hib_comp_algo, COMPRESSION_ALGO_LZO, size=
of(hib_comp_algo));
> +                       strscpy(hib_comp_algo, COMPRESSION_ALGO_LZO);
>                 if (crypto_has_comp(hib_comp_algo, 0, 0) !=3D 1) {
>                         pr_err("%s compression is not available\n", hib_c=
omp_algo);
>                         error =3D -EOPNOTSUPP;
> @@ -1455,8 +1455,7 @@ static int hibernate_compressor_param_set(const cha=
r *compressor,
>         if (index >=3D 0) {
>                 ret =3D param_set_copystring(comp_alg_enabled[index], kp)=
;
>                 if (!ret)
> -                       strscpy(hib_comp_algo, comp_alg_enabled[index],
> -                               sizeof(hib_comp_algo));
> +                       strscpy(hib_comp_algo, comp_alg_enabled[index]);
>         } else {
>                 ret =3D index;
>         }
> --

Applied as 6.16 material, thanks!

