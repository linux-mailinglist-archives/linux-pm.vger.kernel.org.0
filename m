Return-Path: <linux-pm+bounces-13163-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A01964489
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 14:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856C21F263F7
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 12:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07E51A3BAA;
	Thu, 29 Aug 2024 12:33:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA05E1A38F0;
	Thu, 29 Aug 2024 12:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934785; cv=none; b=Wq6fql1DZcKZ2/7/i/0/z/MuHmw0/H4yAW2o1tN0ShzQuP7v8S5tq0gKiGz21iKUhcM/RardOcAAAmSLVbSpv36AnKgZYVrQDNdcVfhXZOCvfKrTDifkE7nUAuORemB+n5w4JIJD3vtuXhmC8tnPPaFzaPdXHMAo6D8sN0FdynI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934785; c=relaxed/simple;
	bh=xut1B75Copn1UQMc3oOTgZsdXNP6Xy8ddJQStmm+73U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+t54aTMpxUYU0NEdczaf5rpYdjev8z8lgNcBQoZZ/rnZfZL2i3GPRBsWHMAxvk00elNpfauKeLaW+d6+J4k2nTJyxlSxg8x+rYzcCwv00JMCa+S/lbejaA4a7FoqniC1v5+ykEpqjcgEam23KwtSk8YVaocAzb1SEY03I9nzFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6c130ffa0adso6323567b3.3;
        Thu, 29 Aug 2024 05:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724934782; x=1725539582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBoF3+XOHG34nWFsOj1vD6Tq0LtW/x7+eoI1HvREX4A=;
        b=VBsmrcgycDa1uxzAsQZqwNRbI5fCKZEJvb6wFNabzi768gBGKdV+8ubYtWpb4NdZdJ
         2qAXkVHsSNEvtGOx93Y2TBxHrslrNkXXRWaTog37Wn3ZFT75EUaX3bvIGBCy5Lmq6q4w
         lYcQ1JHNS0kaNZouK3k2Rh3OcEsPA6eFWhffxMJjbnyfnmYUWjg9Ff2Xw6k16REW07bz
         qWtp3c84BbcLRU1d8zuPp0PnCmkibJ6HQfgdy9AW9qJJAsGWOekiW+OKEv4g7UUF0b7x
         lGj8MCice/cND/U0Sl2smJqrvywhIliuwDcXtgj3aNsgqnnaj/rB7slV4TN+jWlEYyeS
         2X9Q==
X-Forwarded-Encrypted: i=1; AJvYcCURgnorinCplGHSN+FHQRIBgnQXLDYKUibmdgGJzSbUVOO5mCDewp5RqDDSFRJw+KdWzs0ivfNXqZrknljdykc=@vger.kernel.org, AJvYcCUZxa07shkFQ/aOZeeU8J6IgXA0nBDM4IMi9E+G6cqOPgnOMWZBb6uUV7ZjiAwUuDGMRX/J+Q30xBU=@vger.kernel.org, AJvYcCWHmcBClnhmoqMQyiMc+QsOW0A7Y3Jwm0BPSXYOBDO2da+PlC5Hl026rJpMxR4718evcfS4jBOy6kRl/MGkgAD3ors=@vger.kernel.org, AJvYcCWoqqVcKKv0Xv8SIlE9tnQHy/Kvl+KhNW18PAONBilHxsY41w4L795HeGUpCGJOCqHdNjWDfJBLthmvPsN0@vger.kernel.org, AJvYcCXiXPBoXPgOPH+tTgqD1PdVQIjpRzJ0s69eQTYPD00aOHJHxBNmXvLyIEOZVOoI+WeObU8qT/If7Nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzStHEQXMwxTyPnOBrNgfCI4WNwU8wu/SXyYns8Iwo0BQOd/XuI
	Z5nlNOiDty37SJWqo2/FNXeTXZ6oc0HunG7TPCehfz8SgdAbUdTHH23FZ/t2
X-Google-Smtp-Source: AGHT+IGTG6xYFya3Nt+/gww/itAi9HETKsLFYYu4TFE47IKn3Vh9Y9BZ1reE+e8HjyLFDamv3UxAug==
X-Received: by 2002:a05:690c:6903:b0:6b2:7c54:51d with SMTP id 00721157ae682-6d2769e1f05mr31492557b3.23.1724934782487;
        Thu, 29 Aug 2024 05:33:02 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d2d40a7427sm2246717b3.56.2024.08.29.05.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 05:33:02 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6c3f1939d12so5664657b3.2;
        Thu, 29 Aug 2024 05:33:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUV92UKyoPn+oOjdSX9nv72Yrx1eTxQZ06wX5ykVFJV0VwQTNjrM2Uux4VFEURwpCAiJZyoL2nOhnKE86xtz9RbQa4=@vger.kernel.org, AJvYcCVKIiK2YztirlsLFYGYkc5vPfaHeXOERDsTu04p+o7MkzO2qUw8nBjRRLLtVLVSCklq3sY8N4UqXtQ=@vger.kernel.org, AJvYcCVPsyJ9Od0ebkXbzS4gtSQRL/LMfc3G5bSMmLZWMsX4fRjuriVYsQriw6LoZMxw33uejn1PRPNBzCthEOTCtSs=@vger.kernel.org, AJvYcCVgDCVlOgrROZ1me8BTj0aRmzXNV9WOVLoS1yjtu2yVesbUwaEHmvCHT9QX9nyh/NlXExEdBp8qrwc=@vger.kernel.org, AJvYcCXL3KOa38KvSqREbcEyd4eGG+SkUw0/1shInMbo1gX/MXQ4dTZI3ZCkswN4BKtn+eF1hsBerpBt3NWzurQ3@vger.kernel.org
X-Received: by 2002:a05:690c:338f:b0:6b1:3bf8:c161 with SMTP id
 00721157ae682-6d276404cd2mr31558997b3.13.1724934782077; Thu, 29 Aug 2024
 05:33:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828140602.1006438-1-claudiu.beznea.uj@bp.renesas.com> <20240828140602.1006438-2-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240828140602.1006438-2-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 29 Aug 2024 14:32:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX+Q99MvQRZcwGbk8F8SiAUzRU_t2QmRuO_6etAqqXskg@mail.gmail.com>
Message-ID: <CAMuHMdX+Q99MvQRZcwGbk8F8SiAUzRU_t2QmRuO_6etAqqXskg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] clk: renesas: rzg2l-cpg: Use GENPD_FLAG_* flags
 instead of local ones
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, sboyd@kernel.org, wim@linux-watchdog.org, 
	linux@roeck-us.net, ulf.hansson@linaro.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Wed, Aug 28, 2024 at 4:06=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> For watchdog PM domain it is necessary to provide GENPD_FLAG_IRQ_SAFE fla=
g
> to be able to power on the watchdog PM domain from atomic context. For
> this, adjust the current infrastructure to be able to provide GENPD_FLAG_=
*
> for individual PM domains.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/clk/renesas/rzg2l-cpg.c
> +++ b/drivers/clk/renesas/rzg2l-cpg.c
> @@ -1680,11 +1680,13 @@ static int rzg2l_cpg_power_off(struct generic_pm_=
domain *domain)
>         return 0;
>  }
>
> -static int __init rzg2l_cpg_pd_setup(struct rzg2l_cpg_pd *pd, bool alway=
s_on)
> +static int __init rzg2l_cpg_pd_setup(struct rzg2l_cpg_pd *pd, u32 genpd_=
flags,
> +                                    bool always_on)

You don't need always_on, as that should already be reflected in
genpd_flags.

Also, you could do without passing genpd_flags, if the caller would have
initialized pd->genpd.flags (it already initializes pd->genpd.name).

>  {
>         struct dev_power_governor *governor;
>
> -       pd->genpd.flags |=3D GENPD_FLAG_PM_CLK | GENPD_FLAG_ACTIVE_WAKEUP=
;
> +       pd->genpd.flags |=3D GENPD_FLAG_PM_CLK | GENPD_FLAG_ACTIVE_WAKEUP=
 |
> +                          genpd_flags;

Change not needed if the caller would have initialized flags.

>         pd->genpd.attach_dev =3D rzg2l_cpg_attach_dev;
>         pd->genpd.detach_dev =3D rzg2l_cpg_detach_dev;
>         if (always_on) {

The next line is

    pd->genpd.flags |=3D GENPD_FLAG_ALWAYS_ON;

which should already be the case if always_on is true, so it can
be removed.

> @@ -1712,7 +1714,7 @@ static int __init rzg2l_cpg_add_clk_domain(struct r=
zg2l_cpg_priv *priv)
>
>         pd->genpd.name =3D np->name;

pd->genpd.flags =3D GENPD_FLAG_ALWAYS_ON;

>         pd->priv =3D priv;
> -       ret =3D rzg2l_cpg_pd_setup(pd, true);
> +       ret =3D rzg2l_cpg_pd_setup(pd, 0, true);

s/0/GENPD_FLAG_ALWAYS_ON/, FWIW ;-)

>         if (ret)
>                 return ret;
>
> @@ -1777,7 +1779,8 @@ static int __init rzg2l_cpg_add_pm_domains(struct r=
zg2l_cpg_priv *priv)
>                 return ret;
>
>         for (unsigned int i =3D 0; i < info->num_pm_domains; i++) {
> -               bool always_on =3D !!(info->pm_domains[i].flags & RZG2L_P=
D_F_ALWAYS_ON);
> +               u32 genpd_flags =3D info->pm_domains[i].genpd_flags;
> +               bool always_on =3D !!(genpd_flags & GENPD_FLAG_ALWAYS_ON)=
;
>                 struct rzg2l_cpg_pd *pd;
>
>                 pd =3D devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
> @@ -1789,7 +1792,7 @@ static int __init rzg2l_cpg_add_pm_domains(struct r=
zg2l_cpg_priv *priv)

You can add

    pd->genpd.flags =3D info->pm_domains[i].genpd_flags;

above.

>                 pd->id =3D info->pm_domains[i].id;
>                 pd->priv =3D priv;
>
> -               ret =3D rzg2l_cpg_pd_setup(pd, always_on);
> +               ret =3D rzg2l_cpg_pd_setup(pd, genpd_flags, always_on);
>                 if (ret)
>                         return ret;

What about moving the conditional call to rzg2l_cpg_power_on()
below to rzg2l_cpg_pd_setup()? Then this function no longer needs
the always_on flag.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

