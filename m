Return-Path: <linux-pm+bounces-13206-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85835965979
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 10:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2A01F23A89
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 08:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A10B167DA4;
	Fri, 30 Aug 2024 08:06:48 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B93165EEB;
	Fri, 30 Aug 2024 08:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725005208; cv=none; b=JFFF0YxCILWqDxpVfjA+9uxH9OupefjI1HkdjB+VR9w9nUwWHFCiE0eBRi0KjgK2XhvGZUoHNw5ZBxGCMZbt3x66lyMq5JgWMNCdw5OMnDKRcJtU6qnJtFzPv9ZytuUkCReWtUhnBSEoFSgsNOZoqHP3ilMRRbf660Tq3Xv9InY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725005208; c=relaxed/simple;
	bh=VteBl1ktda+owSutLUfZmZK8Yr6JwgOtGs4JdVObDYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e9Mbbfx8AWmljLmeTny7aRokDsF/LsTdl53O3LJ+3DEA50tXqM3DQA/qruR87w9TkHKX+jnLy7RfjWl6N1Fib37qd64M1tJNCHjME9ECC/bMXBV8rvGv5Qsbg/7AFLOza/23kiYY7wVs5Jhd8qGwhOL41rq8xCxshuR3F68BQt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6d3f017f80eso4517077b3.1;
        Fri, 30 Aug 2024 01:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725005204; x=1725610004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9iPS+SBt3nBt176C4U0ae1o6YJDXC/Hy1m/tM/oZV58=;
        b=C5MoMGr8p8Un/uoqUsCfFSaPFLg8fOdK4C4XWomVnI6iHF6Qdgw02rZzndm4g4sRlL
         HWLjhFTje1Vt5uea4/r7ixriYAtcle7hmWJtyeAHJDlu9d0L4gtVmYHWjx+LNCIs89K0
         aS6aH7lzqhFqV9EJuBUFKEz0gsGLtxBoVfuN+F7eBVy7QPaPwU6VGre1c/BYjuddiD6Y
         tYp0SRYe/KNKTajj7DFtQ7gO6D9io9VZSnDqkvjTCC/c65HxcFjeGZNEGSTEIpDmurAR
         Zpdb/qJG3+TIfkDJ5RbJA0falr/MHxLaW0+oAduFhw6YmGMfYqfAowpJSbFYxrLyf0/f
         jXrg==
X-Forwarded-Encrypted: i=1; AJvYcCVB04eAD2+ANjMRF7QtzzPRs0OdypjGbRmCCisoOLaVpxcCBzwtmGSr7Cprytrk8YJ4/Xnfd0JdVsMTdZ7o@vger.kernel.org, AJvYcCVqfppLrAzbl109tqSLIDDU1bnlb/z111dKp213JkgsPJQYg67kzS5+KAvA7huDSqQqzjO4OOhAb60=@vger.kernel.org, AJvYcCWVu+qwTst5CxlchESZZEfmbGo4M5XBUBB3R80fTVM6vG9Mdxzlw6fMm6FZVHsZ1QZ2oqRlkkr/vlYxBrU0GMA=@vger.kernel.org, AJvYcCWe7Mc02cxFeG0rdjZHmAHzh0+2Hz/8xDTkWN4ojz+57JPx1f5XvnP40neMPFL5qOXT2nLzO2jurYjBhfBrGWT4Y94=@vger.kernel.org, AJvYcCXtaWindIMWOlOvdexdpNBytuTe+HNWSenn/4bWrxrNOHwhOICAZoID4Ej/44UbA9zxjtsT6HhW/Pc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy4VAb0POH1nNrRU4rxhEUGeqkbkeiAfGilSafqMoL5CbCtkj2
	TUQOq2qhFW7t+2xX6hPF2bF8we/ZCqvYoxYBRFWBU36QV1hrXKXVAaqYHOPB
X-Google-Smtp-Source: AGHT+IGxpgLU4nf0irLKtvdfMa8v9GP6OPyz8uV1M8xYZJEwr9W/gFaJ9MkyuKRsVvoObMR3JTpq6w==
X-Received: by 2002:a05:690c:81:b0:6af:eaa:3dd4 with SMTP id 00721157ae682-6d40f3421a9mr15071557b3.13.1725005203789;
        Fri, 30 Aug 2024 01:06:43 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d47b06daabsm308897b3.142.2024.08.30.01.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 01:06:42 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6d3f017f80eso4516557b3.1;
        Fri, 30 Aug 2024 01:06:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1zMuDwuGnWkv+ANov4LYAzQPHFTH2T4vaRC/GUUL32j6JGxAAZzYXRv6hMb8R3rprKROvNacgPp0kbHBhqRqUmJU=@vger.kernel.org, AJvYcCWm0BUudjIoia4FYMzgYTxErIPJ351lVo53z3q+Z1HTCMo2I+H4IPc64587yxpDBqA1tV49jbA3uaQ=@vger.kernel.org, AJvYcCX3+j4worpGlRLkNbXDiXb0TB0N62ex5Hdp60WhlD6V8w/Qc42VfYOSXUYY+js+82lu95nTaRhh2Tny/BLB@vger.kernel.org, AJvYcCXrp8AZvuKo8CMEcY09u+/nCiXXCHRr+vDLhGZGoBQCZioM6kbG6DjcuA9jOBa5rehnXw4fks2Ue1I=@vger.kernel.org, AJvYcCXyx17iePm1irvdsP1t8VHHpCEiZZ/2/Mcq65ScPwiNAUgy7QHiJcJSlfpm4o+T1/ZPL7JYzCgwgfVGGyLusRw=@vger.kernel.org
X-Received: by 2002:a05:690c:81:b0:6af:eaa:3dd4 with SMTP id
 00721157ae682-6d40f3421a9mr15070947b3.13.1725005202277; Fri, 30 Aug 2024
 01:06:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828140602.1006438-1-claudiu.beznea.uj@bp.renesas.com>
 <20240828140602.1006438-2-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdX+Q99MvQRZcwGbk8F8SiAUzRU_t2QmRuO_6etAqqXskg@mail.gmail.com> <8b6fc67d-5e07-4403-ac07-6ad0b9d61882@tuxon.dev>
In-Reply-To: <8b6fc67d-5e07-4403-ac07-6ad0b9d61882@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 Aug 2024 10:06:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUqVcojRoPAEuZ8a9Y-iHm4b185StD73FpQoRFsEiZ8oQ@mail.gmail.com>
Message-ID: <CAMuHMdUqVcojRoPAEuZ8a9Y-iHm4b185StD73FpQoRFsEiZ8oQ@mail.gmail.com>
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

On Fri, Aug 30, 2024 at 9:46=E2=80=AFAM claudiu beznea <claudiu.beznea@tuxo=
n.dev> wrote:
> On 29.08.2024 15:32, Geert Uytterhoeven wrote:
> > On Wed, Aug 28, 2024 at 4:06=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.d=
ev> wrote:
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> For watchdog PM domain it is necessary to provide GENPD_FLAG_IRQ_SAFE =
flag
> >> to be able to power on the watchdog PM domain from atomic context. For
> >> this, adjust the current infrastructure to be able to provide GENPD_FL=
AG_*
> >> for individual PM domains.
> >>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

> >> --- a/drivers/clk/renesas/rzg2l-cpg.c
> >> +++ b/drivers/clk/renesas/rzg2l-cpg.c

> >
> >>                 pd->id =3D info->pm_domains[i].id;
> >>                 pd->priv =3D priv;
> >>
> >> -               ret =3D rzg2l_cpg_pd_setup(pd, always_on);
> >> +               ret =3D rzg2l_cpg_pd_setup(pd, genpd_flags, always_on)=
;
> >>                 if (ret)
> >>                         return ret;
> >
> > What about moving the conditional call to rzg2l_cpg_power_on()
> > below to rzg2l_cpg_pd_setup()? Then this function no longer needs
> > the always_on flag.
>
> That could be done but I think it will involve an extra power on/power of=
f
> cycle for the unused domains.

Still only to be done for the always-on domain, of course.
Anyway, up to you.

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

