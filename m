Return-Path: <linux-pm+bounces-13241-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AF2966429
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 16:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480631F231FA
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 14:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97D71B2516;
	Fri, 30 Aug 2024 14:27:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EE61B1D64;
	Fri, 30 Aug 2024 14:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725028025; cv=none; b=HQLfwnatq0OVwUQfTwews1VYBkJB9yJC3BawVR/jt6iRz1EqvfqqRRaqmD4qKNoOyDYR83jEXhFPoLTGx85pIy4vSclgVRQvYn7NEHOoOh2eSD7Rd/Jlk0jM3U96jPGjJ2d3ycuSym1IKUVd10obsaLF5p9+IsjgB+aHStwC47Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725028025; c=relaxed/simple;
	bh=riMSjBHT8MGmCirH6CadZd30drb78DFiCkhA3dOL1dw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPWgmSYlANQCdnP50O6ncbE0t8IWpfRq+GjbUGoSCVCxqMxXGgdN9iYFZI4++zi9fHNNJpoluyl8DILbFaj9DBlQQGO6biQ8wpbUy0VhL3w0zoYxpEt+t8wJayTsmV6115Hk+IHKBvcdJ5q+RQjacP3Ko6oFuLppuhuFKHhD7J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6b0c5b1adfaso17105777b3.0;
        Fri, 30 Aug 2024 07:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725028022; x=1725632822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yv7/8Lb7z0G9egQFnpRuXTa0llIYLHBeWyN9REUk68=;
        b=VATzhQg2/tgkGQMqFtP3U+CwsI6K4ygTwQZckgHbRaNcRMEts7tjq8ZvOEI5Jlj2Lw
         bRVgpJa2nZNrtDLryZMQnlwmJU/V/4/1kwNBm6CuucJr7z2iX8w9q5txYVPbHBGsOyDn
         h9M2MQNJmUak4RAoo7gDhMAB7bdWsHxErGwXvP+aMY0KFCRi5w0Zq2OettIhuJZNlmV5
         3rzFc4GutRdfOc73RXWN7fecMOfwVIPnyjLdFmNlrG1/YNO1MCUWaAPIQnNN0ok8qhPO
         XdScw3s5OPToTOpKP+ogsvOIZ1dPHv6Hx7ZNTOTBWtG4FU39W+rgqQfgBkdcdQhb0jDF
         Zy/A==
X-Forwarded-Encrypted: i=1; AJvYcCUpBIz0hQNJaV4c5kRQFQrbmasAPz2crdzpzsot2uJDf8rC9sstFo4Giad2fykVN/6L0fl4G+rF1Co=@vger.kernel.org, AJvYcCVG+QgIF+q+z8ItjeqFZIV1FYpeqgj2MGgt9zJAj4aZiuRnKrq4UMB4VpXpltL8AqjUIzu3r/7jz/D8Oh0L@vger.kernel.org, AJvYcCVRTnoeyGTqPOBFUSuluSE1XxwQsLEiqyNSMqUcya8CCP1q7RqhcNy7TKAVgsno0WtFq8T3sovGfkAFEvF30+syh9k=@vger.kernel.org, AJvYcCWMlJedAMW0r3VM20Gex8RAh4R8h1H+AqOkflu8HcgjnKvJtgLA6rqPEQOjdjP6sIeSWey6zYV049pajRwb0qE=@vger.kernel.org, AJvYcCXb9cRZx50EZ22Md6BThqCZMDI8w9qcef38TWC3N7aIA9b/A04f8o5BeoCmxWN208SBcuEykaKbXYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYVxXpEWIzq/efh08mGAb6WPa2vXFutLGL5VGD8SeGQWWCuE0R
	O0Kl4MVS69t5Dl9xHt9yhCA5+/UGa7msoG7+HSt086NrSIgZVP4k8hxQxHiX
X-Google-Smtp-Source: AGHT+IHsbWGEXzXDozk9Hyho8HC2Yqw2+uD41s2oiVJD8CsaHEhwXSTyvx2ujEj7a6xubqLMReYQCg==
X-Received: by 2002:a05:690c:530c:b0:6b0:d571:353d with SMTP id 00721157ae682-6d411291332mr17172797b3.40.1725028021783;
        Fri, 30 Aug 2024 07:27:01 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d2d6198599sm6323027b3.141.2024.08.30.07.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 07:27:01 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6d3f017f80eso7488067b3.1;
        Fri, 30 Aug 2024 07:27:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUhEnyil/E7PnfLFFPdSD15ThIrxQVnSvJJ1MsSXvKF9ZTHGzu5fff1BSDhijBh5aD6hk9NCAxDdvo7l/d1@vger.kernel.org, AJvYcCUpERQKYWmkkNWwTrq8Im8u+7BPc7r9bDZKrQeKibXO0mS413Vc3HeidCIjczoKSWP6hcmZrK4cOgA47RoPg5ATDfs=@vger.kernel.org, AJvYcCW+5Kh3c2MtVXPaOYZ6sub1AVQ556hslpNz3BQeU86DCHTWoKO/bH6MBFsBU66jTJ9puaFiog4pXwkR7oZBoa4=@vger.kernel.org, AJvYcCWoo2dzPwQ5PowfNMX5BHHkLtPS279Sue8f06JhntunxFBDEcK3xLiUI0LfOH5X5goFCSbzp49EeA8=@vger.kernel.org, AJvYcCWqbJQU9v7MIAHkM9qiJ5EFcHk996h3LtcazQ1w4XOEilI+rEFQ9Iu/mP/kf7rDUjJEWrzYeBzEJTM=@vger.kernel.org
X-Received: by 2002:a05:690c:2911:b0:6d4:d6de:3e0f with SMTP id
 00721157ae682-6d4d6de421emr4517577b3.31.1725028019818; Fri, 30 Aug 2024
 07:26:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828140602.1006438-1-claudiu.beznea.uj@bp.renesas.com>
 <20240828140602.1006438-2-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdX+Q99MvQRZcwGbk8F8SiAUzRU_t2QmRuO_6etAqqXskg@mail.gmail.com>
 <8b6fc67d-5e07-4403-ac07-6ad0b9d61882@tuxon.dev> <CAMuHMdUqVcojRoPAEuZ8a9Y-iHm4b185StD73FpQoRFsEiZ8oQ@mail.gmail.com>
 <194e87f4-7eab-4bfb-833a-27fabd2d5205@tuxon.dev>
In-Reply-To: <194e87f4-7eab-4bfb-833a-27fabd2d5205@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 Aug 2024 16:26:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWKVfUn5Xy+vxT3puNT+AKLZtm7o=QBysWxfjk434yUJA@mail.gmail.com>
Message-ID: <CAMuHMdWKVfUn5Xy+vxT3puNT+AKLZtm7o=QBysWxfjk434yUJA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] clk: renesas: rzg2l-cpg: Use GENPD_FLAG_* flags
 instead of local ones
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, sboyd@kernel.org, wim@linux-watchdog.org, 
	linux@roeck-us.net, ulf.hansson@linaro.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Fri, Aug 30, 2024 at 4:07=E2=80=AFPM claudiu beznea <claudiu.beznea@tuxo=
n.dev> wrote:
> On 30.08.2024 11:06, Geert Uytterhoeven wrote:
> > On Fri, Aug 30, 2024 at 9:46=E2=80=AFAM claudiu beznea <claudiu.beznea@=
tuxon.dev> wrote:
> >> On 29.08.2024 15:32, Geert Uytterhoeven wrote:
> >>> On Wed, Aug 28, 2024 at 4:06=E2=80=AFPM Claudiu <claudiu.beznea@tuxon=
.dev> wrote:
> >>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>>>
> >>>> For watchdog PM domain it is necessary to provide GENPD_FLAG_IRQ_SAF=
E flag
> >>>> to be able to power on the watchdog PM domain from atomic context. F=
or
> >>>> this, adjust the current infrastructure to be able to provide GENPD_=
FLAG_*
> >>>> for individual PM domains.
> >>>>
> >>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> >>>> --- a/drivers/clk/renesas/rzg2l-cpg.c
> >>>> +++ b/drivers/clk/renesas/rzg2l-cpg.c
> >
> >>>
> >>>>                 pd->id =3D info->pm_domains[i].id;
> >>>>                 pd->priv =3D priv;
> >>>>
> >>>> -               ret =3D rzg2l_cpg_pd_setup(pd, always_on);
> >>>> +               ret =3D rzg2l_cpg_pd_setup(pd, genpd_flags, always_o=
n);
> >>>>                 if (ret)
> >>>>                         return ret;
> >>>
> >>> What about moving the conditional call to rzg2l_cpg_power_on()
> >>> below to rzg2l_cpg_pd_setup()? Then this function no longer needs
> >>> the always_on flag.
> >>
> >> That could be done but I think it will involve an extra power on/power=
 off
> >> cycle for the unused domains.
> >
> > Still only to be done for the always-on domain, of course.
> > Anyway, up to you.
>
> I checked your proposal. If unconditional power on is going to be done fo=
r
> all the registered domains it may happen to register domains for which
> there are no enabled nodes in device tree and thus the domains to remain =
on
> (because the driver enables it under the hood and the genpd core doesn't
> know about it).
>
> With unconditional power on and the current DTSes the following domains
> remain on after booting with r9a08g045s33-smarc.dtb:
> - sdhi2
> - i2c2
> - i2c3
>
> as the domains are registered and powered (while registered) but the node=
s
> are not enabled in DT.

To make it clear: I did not suggest doing an unconditional power-on.
I merely suggested moving the conditional power-on from
rzg2l_cpg_add_pm_domains() to rzg2l_cpg_pd_setup().

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

