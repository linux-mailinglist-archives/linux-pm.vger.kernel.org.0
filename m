Return-Path: <linux-pm+bounces-30268-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8212EAFB105
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 12:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A82004A2314
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 10:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF2728DEEE;
	Mon,  7 Jul 2025 10:18:58 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CA3262FF5;
	Mon,  7 Jul 2025 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751883538; cv=none; b=qjmlHhY58IQFsXGMg2RNam0JfYG7TyuLZLKVP4Yb6VzXwawwqaZug4r9u3sv+Fq+vurFFFLMBzaQ6Htncpr9WD9EudR59Jh97poIqvH3D1YelD/JbgLS3UlP+O1VVNgcAQPSitLuwhP+TOby/Sg16UG192pchGP1/CFF7CmIL0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751883538; c=relaxed/simple;
	bh=cFAP6CR3owaA7Dm23KKzSciiAjNJqaVw9lWzRnyw9YE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1c/XJ3TFYO/BRwaip69ZAFixWIzZs9CLdvxHq/CfZNNzi09WczzLm81B8Ogu8iRIQ+yyXDWSWFbPEh6HHw2p9E4o76xmGFZxxicZv5CGaFg8QxSe8sEJXA29JObQyB5qKhXmPXiDZ/IOejHyRsneQuthnbVkXLFT0xe2fbfP3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-87f2adec2b7so1035307241.0;
        Mon, 07 Jul 2025 03:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751883535; x=1752488335;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H3S6y58EcgsVdkbN4ejnB1qrJUDIxRRLQQfV+wcdOeE=;
        b=UdM3q+HjnWkZBWN5aYNgrEojcqcRMzey/qvs9bCLXNOWCKNVt8ow76ix+Cygze5QRs
         UE5yGhg1MPao3cRPvSN8A8RCHzL9Uq9Nmc9f7VmxaBvGJpJ8zeQtOLJn7HXMzHB7+lyo
         0zuoq8cDgnqHcvuzXb70MKSCvUMJTGks7wwDxqnBwhub04irAyPOER4cQqsYQEqd9V1k
         1JVbVHcYZ6V45hbBMhBvd0Yg+Hq6G0qxV08OZxcwA8RpzOoD5QD5utCHEj7pC5Dc/YHY
         uRH5VsDSqdyaNpLBb4XUuy9L4zIaodsi4p4ySz6MIQAwVVGYU7gjaG3xAiCLETaW8IFi
         2RKA==
X-Forwarded-Encrypted: i=1; AJvYcCVzN56U7jKE9xBR3hVBRuQN7r9NenEmOVrV81x5D4vvCdVk2/NnqqwTi5RFk0UMIHFU/ClwD8Os9g==@vger.kernel.org, AJvYcCW9ctaK9OmG1B505ssyI1jg3v6qWqS0Mr3eJN+KBOqVL5E0twp8wGfYSGA9tza9wtkFfBE/CoA9Goi3gabgcIbK++Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6r4WNSYFZmo+VcSkPDCxkU2FbZ5AVArPeinO7EAkgFbZc5X1w
	Gin20cCxfkwMVXZN4eFbhErU4HsgsSZc1/lyW1VTiI4xFQ8Da9pup00/fbreW62/
X-Gm-Gg: ASbGncupvPsnQo0jxGjsMdH0CM7uyd3NtuqNS0Nm7Eui5GlYUQDI8sZJpF/pT5ydjAK
	hID6xRZ6WgIBIccHzP3pjHE8R9VedJFvThmTAWDi3zNWgKPUOvYGc+sFfNiGh31mjvfrBqULvGd
	gQaKLgxYATimtfnGHi39UE5p4YPgrKaKHshOxl5ftLaaq8pCuIfwA+06pggwkhldceMWxJoHnrO
	5XoJJMW/feIoIx7AtmZoeBke6GUkbdhBzSBWQb+pvZl59P6mDz7goZABIuSP3pyapyokl0dgAbo
	oMKuXx2VcaG0duy3TwmEC8jf4ViU9Z1K0LRHF2nuVsJt7eJtZDj2TP5h72ATBnCH8QlzLmJdDGO
	nP45iIw9wcEg5V48ZF+ff/D6T
X-Google-Smtp-Source: AGHT+IH9GarWhR3spFlE3QF3KdcQJC/rCHmjAXUZb5YUwmb7i8uP2XRrkzOMi1OV5ZmfGVjO8KPKMA==
X-Received: by 2002:a05:6102:3752:b0:4e9:a2bd:b455 with SMTP id ada2fe7eead31-4f2f1ed7245mr6521450137.14.1751883534837;
        Mon, 07 Jul 2025 03:18:54 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-886e93f56eesm1309143241.30.2025.07.07.03.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 03:18:54 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-87f2adec2b7so1035295241.0;
        Mon, 07 Jul 2025 03:18:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVN8iQQ+G4iYiCylYp7p/PigGLaIIkBqF10VyRrQLxj3dq8VTI18JTvbWYWPxkguVm6RoQ7tpmjCg==@vger.kernel.org, AJvYcCXCvX9oAoH+d+7vw5tRrWHgFz0V9IwWR+UM6IcX/IhGiLje8hROeVB2WtZ4sGKpKRTJ3qEQJmB5nGiuqXVgSc1WcRg=@vger.kernel.org
X-Received: by 2002:a05:6102:4404:b0:4e6:f7e9:c481 with SMTP id
 ada2fe7eead31-4f2f1e02c34mr6502633137.7.1751883534212; Mon, 07 Jul 2025
 03:18:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87ldp6cadg.wl-kuninori.morimoto.gx@renesas.com>
 <87h5zucac8.wl-kuninori.morimoto.gx@renesas.com> <CAMuHMdWzSY1FofgbveAZumuuyE6B=Ub2Zxpd9_ks_d9KmrVYtA@mail.gmail.com>
 <87wm8oq3mu.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wm8oq3mu.wl-kuninori.morimoto.gx@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 7 Jul 2025 12:18:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUtrzd1yQpdQcDuFECZipzHob=RNGUMKZSPoq-zGXemxg@mail.gmail.com>
X-Gm-Features: Ac12FXwSc1xiWah__M3-isN-bcuoLZryLIu6TyTmF4VYI1L78hXmUg_22y7TlBc
Message-ID: <CAMuHMdUtrzd1yQpdQcDuFECZipzHob=RNGUMKZSPoq-zGXemxg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] pmdomain: renesas: separate R8A7791/R8A7793
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Morimoto-san,

On Fri, 4 Jul 2025 at 01:03, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> > >  config SYSC_R8A7791
> > > -       bool "System Controller support for R8A7791/R8A7793 (R-Car M2-W/N)" if COMPILE_TEST
> > > +       bool "System Controller support for R8A7791 (R-Car M2-W)" if COMPILE_TEST
> > >         select SYSC_RCAR
> > >
> > >  config SYSC_R8A7792
> > >         bool "System Controller support for R8A7792 (R-Car V2H)" if COMPILE_TEST
> > >         select SYSC_RCAR
> > >
> > > +config SYSC_R8A7793
> > > +       bool "System Controller support for R8A7793 (R-Car M2-N)" if COMPILE_TEST
> > > +       select SYSC_RCAR
> > > +
> > >  config SYSC_R8A7794
> > >         bool "System Controller support for R8A7794 (R-Car E2)" if COMPILE_TEST
> > >         select SYSC_RCAR
> >
> > When configuring the kernel for a Renesas platform, all SYSC_* symbols
> > are invisible symbols, which are auto-selected when needed.  So I see
> > no need to complicate this internal invisible logic.
>
> Hmm ? Yes, but it is for Renesas case.
> non-Renesas can select it, because it has "if COMPILE_TEST" ?
>
> I can see like this (via x86)
>
>         ...
>         [*] System Controller support for R8A7779 (R-Car H1)
>         [*] System Controller support for R8A7790 (R-Car H2)
> =>      [*] System Controller support for R8A7791/R8A7793 (R-Car M2-W/N)
>         [*] System Controller support for R8A7792 (R-Car V2H)
>         [*] System Controller support for R8A7794 (R-Car E2)
>         ...

Is that really a problem? This is shown only when compile-testing.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

