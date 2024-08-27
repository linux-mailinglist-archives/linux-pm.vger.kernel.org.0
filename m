Return-Path: <linux-pm+bounces-12936-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AB096039E
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 09:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EBABB22248
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 07:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE05158D79;
	Tue, 27 Aug 2024 07:48:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB55E154C0A;
	Tue, 27 Aug 2024 07:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744906; cv=none; b=aSovf69ujYXq9xF8/ThWDkxITTs/h72ydAzHWeLXkF2E+TeFGVYwAB73R61EXZCO2rsoHC6Y3Tb9sT3CZFn7N3n1lfYeVpTcwTMCD2gKRjssUQwaBv+yjjVymXpi5mmBlWbsaZYzPW704wnOlH1San68QB6FLSnDBU7Fsd4oGts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744906; c=relaxed/simple;
	bh=NxA9s7sQqwLGwuxcChr5dnPp7Nj2BlckKRYtzA+FACE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cd+PuBnrJABDSc0gpfcniipH+8NBcZS6noJe3WIeayp3wVpPBXvTvmgHvficcvv39O8iA5XQgML1FH4WGtwY5D78GWyE9QqwTYNIndFNZzyr+/pOFm9elCSWY1QsH++Ikdvq3sEyF4LOpI8tB/4uEepOARFrlFw9zWGQoTSB5kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6c0ad8dca82so42489787b3.2;
        Tue, 27 Aug 2024 00:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724744902; x=1725349702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lyFU1QyCNa7lptSAN0cFkDNgjLOOwPVrcUvkymW1zfc=;
        b=lfEpKTg5KrV6k7TIE3wURurG03v2UJich7dKKKXD3iEgs4kLMbTA4QMIoDhoMbW3mD
         iIM04Yeb4+2n6ulPIDKPRlZg4s3uMv1dt3kYVS+wYDfVkNIYCAApf+199aeazTyM6Lhl
         vS7qBZafoZSZsrDk8NYCZCakJWLAhMEs261OQ71FdzRl/Hxn68MxCWJNut1Y3/xGpZGp
         Vn3gw2KGrPwuaM2VqJneSsq9uwaeQ8hGvmRVSHkOoRv8NHDasuIauyPQOBze4/N/vT7n
         WFYm7Ef3y3F7B35sV5cyY6EazJymRV76SGZYR3BArcj+Z8IBraK3l2M+uf3p6IDvSbeG
         t+IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkb9YwfjiNeBDS7MMdrz3i/HoB27n1pFuakLlTpE2cQsAC0vY80pkHijKH8UXvkkTKKzGVSbv96MUjWom2s1Q0gT4=@vger.kernel.org, AJvYcCVXmXnd5HI9qWEEaCiHNvc3+myeju3pwpopF17I+B6fImsK8va35tIJoquY7V21ywQwY+k9WNWazrO/a2ZA@vger.kernel.org, AJvYcCWJKrgbuoAxduESJcqhtRNukpCClap/OmXQw1jBZQqoHlOoK/ul2Mj57rSAbl7nQdOGJy4stVkaorAn1E9T@vger.kernel.org, AJvYcCX3ql1PL74WX+0ycejjz6gKGKTqG+D68H9ZyO0QMzRvSZBQ0PKT7USnFLDUVm4KQTaEH6LIqfh6ROo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFV69poTj2Pz3qXrg0w3DYx4ztHjuHclnkZeH5sK0orX/U297s
	W7SaDLVowvVOoUmpksr8O2WIzwKVl2cQDkl3PnjY9D3vGM9akhs0K+UOe99U
X-Google-Smtp-Source: AGHT+IEfju1tkhk5GMqNOjOWytlRyX5d9chWuwnRQnV8Q3moJ2o2A/bqPIJAoIlNqoLyt4NsC8QK/Q==
X-Received: by 2002:a05:6902:2e11:b0:e13:ec1f:f973 with SMTP id 3f1490d57ef6-e1a2a5df327mr2024098276.30.1724744902292;
        Tue, 27 Aug 2024 00:48:22 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e178e4746c8sm2328017276.26.2024.08.27.00.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 00:48:21 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6c0ad8dca82so42489447b3.2;
        Tue, 27 Aug 2024 00:48:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVMG+yXqHEnif8eY2btAL4izVJIYzwzXBrsr+xb4Ce4oTFbGRS7Si3uGvdvmV0S5/pFetRP/72ClbqRe018XOsVc5k=@vger.kernel.org, AJvYcCVxBywPiqnw1d553P1CVQTU6Q/lXHpWf4rvzXqRHNkZ3ZeSHRcOdP+nzZe55G6yd5NhxN5Ce1VICIjsN2YI@vger.kernel.org, AJvYcCWBdld33+Pbocv/6hBNfeDGqp/fTfub4V7NQQHBTBmmBpUoZzHkKh9OD8JK9pXj9EUJm8OgRWH+NEk=@vger.kernel.org, AJvYcCXipFuQGk4SG+dkv0WcQWAByA/fZswX4vGZ9cqfMgp5Z3EaoHmJE1/oiIAEqrGrnu2Y4n2JMkM3Yu5AKRvj@vger.kernel.org
X-Received: by 2002:a05:690c:dc3:b0:62f:b04c:2442 with SMTP id
 00721157ae682-6cfb9415ebdmr25153437b3.7.1724744901130; Tue, 27 Aug 2024
 00:48:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823-cleanup-h-guard-pm-domain-v1-0-8320722eaf39@linaro.org> <20240823-cleanup-h-guard-pm-domain-v1-9-8320722eaf39@linaro.org>
In-Reply-To: <20240823-cleanup-h-guard-pm-domain-v1-9-8320722eaf39@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Aug 2024 09:48:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV0R0+u1eCiUOHhL5w-wzge9KhgyumJSd28oF9kQmnx_Q@mail.gmail.com>
Message-ID: <CAMuHMdV0R0+u1eCiUOHhL5w-wzge9KhgyumJSd28oF9kQmnx_Q@mail.gmail.com>
Subject: Re: [PATCH 09/10] pmdomain: renesas: rcar-gen4-sysc: Use scoped
 device node handling to simplify error paths
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

> --- a/drivers/pmdomain/renesas/rcar-gen4-sysc.c
> +++ b/drivers/pmdomain/renesas/rcar-gen4-sysc.c
> @@ -303,12 +304,12 @@ static int __init rcar_gen4_sysc_pd_init(void)
>         const struct rcar_gen4_sysc_info *info;
>         const struct of_device_id *match;
>         struct rcar_gen4_pm_domains *domains;
> -       struct device_node *np;
>         void __iomem *base;
>         unsigned int i;
>         int error;
>
> -       np =3D of_find_matching_node_and_match(NULL, rcar_gen4_sysc_match=
es, &match);
> +       struct device_node *np __free(device_node) =3D
> +               of_find_matching_node_and_match(NULL, rcar_gen4_sysc_matc=
hes, &match);

This breaks the declarations/blank-line/code structure, so please move
this up.

If you insist on keeping assignment to and validation of np together,
the line should be split in declaration and assignment.

>         if (!np)
>                 return -ENODEV;
>

> @@ -369,14 +365,12 @@ static int __init rcar_gen4_sysc_pd_init(void)
>                 if (error) {
>                         pr_warn("Failed to add PM subdomain %s to parent =
%u\n",
>                                 area->name, area->parent);
> -                       goto out_put;
> +                       return error;
>                 }
>         }
>
>         error =3D of_genpd_add_provider_onecell(np, &domains->onecell_dat=
a);
>
> -out_put:
> -       of_node_put(np);
>         return error;

return of_genpd_add_provider_onecell(...);

>  }
>  early_initcall(rcar_gen4_sysc_pd_init);

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

