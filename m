Return-Path: <linux-pm+bounces-12937-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E969603B1
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 09:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D28AE282932
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 07:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6953158218;
	Tue, 27 Aug 2024 07:55:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E728F156F28;
	Tue, 27 Aug 2024 07:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724745340; cv=none; b=KUhKVz6ERKqMRF/LPVtG5qGFlP79BSgCo8qSaBaTzh0ezJAFuygo4CpCS9QcFSno2cvCizxTWZDPkt1MHQPkgXS5uxsklgca880u5hEXifqZB3z7TIi4LvjWRbUIa9iD6glA1uGkDoxeUhIIewn6CZauO2ebhFvQ5gwsCZgSjuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724745340; c=relaxed/simple;
	bh=hB7ZwdMBPkDMj4TZ0j8Pz1hCtIfwUxbSGIFo0L0U7yQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MLQ9mY+ja7eqgLOsKzECPyBBCYVnHDOCn2TNxqhKWLQkj6TC94wxEd5E29iPyuyZr19DqjWVDGpJisZBboZkf3jsW8ljov6EYfuJVm/LQHsP/jnUspnX/V9GRo5u3TjtJay0nddUqoY2OOTa4eMHvVmazQG515za10uKl2y5r0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6c0ac97232bso42956117b3.1;
        Tue, 27 Aug 2024 00:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724745336; x=1725350136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4JN30GN77x4NUy5z6yHPloDIcCANz9yHy+MUlnyZj4=;
        b=UVQJW1qKCIapMAvCNrfXUSlau7Hsmx1T+455dMAeiLH7apw9zCMZxa6Q7mmvp8YkL+
         Kl4XW1kE+2YZaTo4ainvB7rvVzk5cr1RRMBBIK0N/tw6OckZ9Xz9InLaRjlqleMTFxJ2
         rwE+DJZGqKVxB0NIp6QCrO7Ti/33Z9zssx9FMtiL54n9rXrbwYmTqromHTU9pLr+klV4
         rqWM2JwP23t7feqc9P4mUpf6VQQIGFrNZGthoJAewAXlTjxLZYsjq4v0rYCMEfYKWeHk
         Bm/HTyUDr1l3mBDZ5I1Me0chf5XJfibviCeEV19e72TRJFmmnavSglY/koEiGnXcNBRT
         yjpA==
X-Forwarded-Encrypted: i=1; AJvYcCV5iAyGN4ELNyBHfoTfgeckXd+6XfLYEDmbsxVLBeBvh8svz2JPV7viNVFuq1/wpvIP+JT9TQg4/WXm1QOC@vger.kernel.org, AJvYcCVMs2HCRxKkZJkxSAT07OuRvmpfFKa50dEuLvcGlYzsSp8zX4zBuNDE+9PdiLIXyGzIvORMkLJ5wY5+yhgF2pX0iB8=@vger.kernel.org, AJvYcCW1W/RxCICE/xZBShw6Yk8xo2qTm8GJJWnB2iB4D4FcTvCATxUMQT/Uuaz9RzoKg6BgLrLn2J8RHBA=@vger.kernel.org, AJvYcCWNhVIE5NUqAOIqoUBCtmAwsX1DvO9UYv7ogo8NTtFJTBHoA5FTXdEZdx4Tsg6QfVd7PulLMQAqGUczq1Gt@vger.kernel.org
X-Gm-Message-State: AOJu0YwNDjSR/El14GN2BVgbCyvk4kCFzYTzb7RHI9PNAh+AVIGKd7DB
	dgkmKGK9Dyky4QCzt2BToxro+VnWz1YA4rPx0EFmM+5E9wtnre6MszZIm4l/
X-Google-Smtp-Source: AGHT+IEO4ABYY/ILHfI9+ZyCGCz7so1nuk8lMph+lgiyFPzGmlvALrUWZgz1gO7bywGHhjNArT4Hsg==
X-Received: by 2002:a05:690c:10d:b0:64a:791b:60ce with SMTP id 00721157ae682-6c6286b93fcmr126703237b3.30.1724745336660;
        Tue, 27 Aug 2024 00:55:36 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39d3a9f90sm18399347b3.96.2024.08.27.00.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 00:55:36 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6b747f2e2b7so48821937b3.3;
        Tue, 27 Aug 2024 00:55:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFydUKDcDk2d3BSoq17yPcG5GhnhY+qE8TI1NJs/UTJWflsNajtRXWCNp2IrwPE5f51dM/bgR3sB/ijv4O@vger.kernel.org, AJvYcCVgWjAhV1NQLdRQg7Nwx3VZPRBNvXZqfP+WH0pxgOWim0xWwu1TA+Vm09kCMe15fKoP8f05CMB3NiM=@vger.kernel.org, AJvYcCVkptfvL4Q59Ig9s5xFBMZzDPszjOaDSblia91AZz+nemGgrBzbZ2ehWmACh0DEU57YUPhk24laLJsb/nd0MKTv5y8=@vger.kernel.org, AJvYcCW82EuplG0JKwEY7ibng+8e5sf2rGcI+CzulBFdwnMKbnR3QIFJQRcHipt+PitKqesiTV/FnH00cup8NLrw@vger.kernel.org
X-Received: by 2002:a05:690c:d8c:b0:643:aef1:fb9d with SMTP id
 00721157ae682-6c624229802mr164962817b3.4.1724745335406; Tue, 27 Aug 2024
 00:55:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823-cleanup-h-guard-pm-domain-v1-0-8320722eaf39@linaro.org> <20240823-cleanup-h-guard-pm-domain-v1-10-8320722eaf39@linaro.org>
In-Reply-To: <20240823-cleanup-h-guard-pm-domain-v1-10-8320722eaf39@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Aug 2024 09:55:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXCPJz=bNZppMExGdhCdzuTVOV-EcvnkZfBYCGnT7A7ZA@mail.gmail.com>
Message-ID: <CAMuHMdXCPJz=bNZppMExGdhCdzuTVOV-EcvnkZfBYCGnT7A7ZA@mail.gmail.com>
Subject: Re: [PATCH 10/10] pmdomain: renesas: rcar-sysc: Use scoped device
 node handling to simplify error paths
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Fri, Aug 23, 2024 at 2:51=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> Obtain the device node reference with scoped/cleanup.h to reduce error
> handling and make the code a bit simpler.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks for your patch!

> --- a/drivers/pmdomain/renesas/rcar-sysc.c
> +++ b/drivers/pmdomain/renesas/rcar-sysc.c
> @@ -348,12 +349,12 @@ static int __init rcar_sysc_pd_init(void)
>         const struct rcar_sysc_info *info;
>         const struct of_device_id *match;
>         struct rcar_pm_domains *domains;
> -       struct device_node *np;
>         void __iomem *base;
>         unsigned int i;
>         int error;
>
> -       np =3D of_find_matching_node_and_match(NULL, rcar_sysc_matches, &=
match);
> +       struct device_node *np __free(device_node) =3D
> +               of_find_matching_node_and_match(NULL, rcar_sysc_matches, =
&match);

Same comment as on [PATCH 9/10].

>         if (!np)
>                 return -ENODEV;
>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

