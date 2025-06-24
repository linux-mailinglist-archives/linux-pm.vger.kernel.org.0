Return-Path: <linux-pm+bounces-29425-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F4BAE6441
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 14:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9841403D59
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 12:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094DC28DF3D;
	Tue, 24 Jun 2025 12:10:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F521F5617;
	Tue, 24 Jun 2025 12:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750767053; cv=none; b=nFj7w3X5qAwFy656KT9iQ+gIUNwFYAyItGbfSMpr8BREBpYJgRTYuXr7XONf+yZKpM63vZS3qINpuWc49+/I9i5a8YIPTIYvK+L9tmJio723lGkg29yGEDJ9hJ4GTe103YimCIF3exZ9HG/fA57zOY1HkvMOaWzB5tPUJxmV2vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750767053; c=relaxed/simple;
	bh=svt/KgpTl1UQdBWjOCi02AXSgJP8MSaLDBl0In/0Pzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQHGISchQsTpbMXqHoJtotYNxDMvBtI1uNdT8T2KkD4hAHCkb6pbrx7AvQoDIpvHJhwu9JFILce7d1dc07MXou8Rn9A/j9cN9FxFXOYoGZGMnB1s89gSGUDcSORLHa5u1hvAkyTznDXzU016dPBYLDhLcGCcLS91xHxQeQKf6WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4e9a109035bso3820412137.1;
        Tue, 24 Jun 2025 05:10:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750767050; x=1751371850;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mr7Tfc01vfHuBtZDbQIwiPabXFzT1mWwxVomhbQ8jNg=;
        b=gM74n4xdu/bnvVN7mQv5OVlyFJtkNdof4hSpZ9Fxw4qa5l5ep0Br0U/uHWxGxfJBoT
         ExoMaxNeJsroLU3WHn72WWtWS2fh7riP5JWY8bi71uMyMCuetzdqTPK3VcwrvKtwVD7u
         Wd4LDdFU1FcTXYD1N2XYw7uyChboWfB7SkrdW9mxgJIL4XrZ42c3rWUcx4cIEwCZdoUR
         7jzoZIRrZQRq30Kdanca3vEut6MFPxHSnJOeeQoBNeQDPRYiFBwoCkHIMad38YrWKxPz
         rLY+3dl3GZkZMhx3sXuYaYH4uKuXgdeG+7xYQ4G+PfclNjyOX445zdxm+5DAGdWSOuS4
         e6Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUbEbk9tGuGqrINGc/RYzbnOOgoF/Mwnmpgb4eArQYkEjxkdrn0ldLxjjsTvVjTicPFopPLa7c+rr4=@vger.kernel.org, AJvYcCVU17TCHNp3e/9NDq+OMJnTppHk4sJEhGvlroQtxWwHVBQQZ7t6PLNabBPgdviwSHAjU8IoqV+lt9YYRC8=@vger.kernel.org, AJvYcCXu8E7oDU7+MKjJWBCZiBYqCPlsgdPyQ+c7vBLEdcDnK3vTg0pqvcxtSJnJHqmedv7CL4IA33CHfKLwONIyk3e9LPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfU2Cf1voWZyGKSJjSsjEb8VLoipbMley30vYhTBQHo4acatXf
	LQgtvqqWYnwPaQEIFT/xCXor79bAowWwPZoc6/OsuWlBL5BbFLD8bf1yWY3R8S5N
X-Gm-Gg: ASbGnctNAQkZKeuFBlMfP0CHG1+0Nk/KHYc3BpfgUuzvzmYhi7Uwrat5pEgyN+jn+Oe
	EftiSqRjUcGxtfg8BFcRbWdCIIS5ulJ7pMuJ3Q0rnzFRupMRaoj3o2nGiXDgPW2dtrtn4mGKkmv
	TRvO33f0/yEr9Ev0lUOqDf5bzAKOlrGZNEGjbxXvb37g9MxfGIcWO+Qkjsaw3YNjeflO0wAKG7N
	oN6dZnBdG/t9BS04pvzKwC7QJW3pQLesGt4qEmsivkLldMiwS1E5VzHXlALX82858THcCv+0snA
	BlHZjRwuASpU4UCu6Tk9724MFid5e+h+7Udf0u9cMOjB7AgjSxyJuIVyH1hzXHStVBnUY+g24yq
	tiSrjhEk9d4JAxDf9olg75Y6O
X-Google-Smtp-Source: AGHT+IFzPV6lGahCPZM10hz/RD8kJ154DeNa80y71Uq88UWlu8u+px8xBjYaeHlVj54i6i9YJGWLyQ==
X-Received: by 2002:a05:6102:2ad0:b0:4e9:b612:9013 with SMTP id ada2fe7eead31-4e9c2bc7cc9mr9535500137.13.1750767049603;
        Tue, 24 Jun 2025 05:10:49 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8811acfa12csm1646905241.5.2025.06.24.05.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 05:10:48 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-87f36c458afso3418357241.1;
        Tue, 24 Jun 2025 05:10:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVK2X8+VO5aPojiwV3PH9ubC/Ym1OmnSXESz0HiR/fVbdOtZPzzJmL+9iY95lsn2PLUuY15dDQKCd1N2LicD9d8AFI=@vger.kernel.org, AJvYcCVSVjS6vLBWQyJM/iFfh+EelHT77bqkzhbOpe+knTd5uOPhZN9/R1fJZ9dZA7hEUAKJK7US2S77eN6kztk=@vger.kernel.org, AJvYcCXXMCw0in+8ajdrdptpECHwxuUzh4j1OJYHnDQntfIKb/hwtfDWROU5JcamV83sk7ogBDScLdykUUU=@vger.kernel.org
X-Received: by 2002:a05:6102:8016:b0:4df:9e8b:8cad with SMTP id
 ada2fe7eead31-4e9c2c6dcb7mr9458493137.22.1750767048099; Tue, 24 Jun 2025
 05:10:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523134025.75130-1-ulf.hansson@linaro.org>
 <fd4cfe7a-e29b-4237-b82f-48354deead3b@ideasonboard.com> <CAPDyKFpprO=HGuiHX3MQ_+m1YRnaWG=XwCx8-fSdXak8VBDUbQ@mail.gmail.com>
 <CAPDyKFpXcpwkacnYqWz2vxaTd7pW5bSRa2F063BryFxVNEAmPA@mail.gmail.com> <CAMuHMdXGS+efbbQ_Pn1iYhQ1aWc_DuJ-CBN=jxfjwOWxTRx+9Q@mail.gmail.com>
In-Reply-To: <CAMuHMdXGS+efbbQ_Pn1iYhQ1aWc_DuJ-CBN=jxfjwOWxTRx+9Q@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Jun 2025 14:10:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVit2WtjmFUHctBjndAo33Dibsg-GrOyFj98==gxk5rEw@mail.gmail.com>
X-Gm-Features: Ac12FXypYh-k6otCqY6pCtpIjWF0CfZNia3ZUPKNyrqASzd2JswYUEhHL-kiM-Y
Message-ID: <CAMuHMdVit2WtjmFUHctBjndAo33Dibsg-GrOyFj98==gxk5rEw@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] pmdomain: Add generic ->sync_state() support to genpd
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Saravana Kannan <saravanak@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>, 
	Johan Hovold <johan@kernel.org>, Maulik Shah <maulik.shah@oss.qualcomm.com>, 
	Michal Simek <michal.simek@amd.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Jun 2025 at 17:06, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, 23 Jun 2025 at 16:21, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Thu, 19 Jun 2025 at 13:40, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > rcar_gen4_sysc_pd_init() is an early_initcall, which I guess is the
> > > reason for these problems, as the genpd_provider_bus has not been
> > > registered that early (it's done at core_initcall)
> > >
> > > Do you think it would be possible to move rcar_gen4_sysc_pd_init() to
> > > a postcore/arch_initcall?
> >
> > I did some investigation around this and found that both
> > drivers/pmdomain/renesas/rcar-gen4-sysc.c and
> > drivers/pmdomain/renesas/rcar-sysc.c are registering their genpd
> > providers at the early_initcall() level.
> >
> > I was trying to find (by browsing renesas DTSes and looking into
> > drivers) if there is any consumers that actually relies on this, but
> > so far the earliest consumer I have found is the
> > drivers/irqchip/irq-renesas-irqc.c, but that's at postcore_initcall().
> > Of course, it's difficult to say if my analysis is complete as there
> > are a lot of platform variants and I didn't check them all.
> >
> > Maybe we should just give it a try and move both two drivers above to
> > postcore_initcall and see if it works (assuming the irq-renesas-irqc
> > supports -EPROBE_DEFER correctly too).
> >
> > If this doesn't work, I think we need to find a way to allow deferring
> > the call to device_add() in of_genpd_provider_add*() for genpd
> > provider's devices.
>
> Commit dcc09fd143bb97c2 ("soc: renesas: rcar-sysc: Add DT support for
> SYSC PM domains") explains:
>
>    "Initialization is done from an early_initcall(), to make sure the PM
>     Domains are initialized before secondary CPU bringup."
>
> but that matters only for arm32 systems (R-Car Gen1 and Gen2).
> Arm64 systems (R-Car Gen3 and Gen4) use PSCI for CPU PM Domain control.

[...]

> As expected, there is no impact on R-Car H3 ES2.0.
> I will test on R-Car V4M tomorrow, but expect no issues.

R-Car V4M is fine, too.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

