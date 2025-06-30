Return-Path: <linux-pm+bounces-29823-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EAFAED8B9
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 11:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3FE21892491
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 09:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7427E243399;
	Mon, 30 Jun 2025 09:32:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2831120E70B;
	Mon, 30 Jun 2025 09:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751275939; cv=none; b=fKJuaky2KGZ7L+V3yfhV97EcJNS1opc/PUU2HAU9+k2G7rl1gu0InTqQXq4tX7tbUPjaBG61lvlqI4iQhQRaXQCXBS+D9BktY4AztIT+WVr4v+Swte16/gsHs1S0Uy6onzE7VU4mnB2WSeDMvgzxOZ/0xqbcz8EHllKRZwOLlkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751275939; c=relaxed/simple;
	bh=BwUCkqpykc2xiyZ4oqu+ZEGw0sMiSNpgXHtRj3lEPbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jq9DQdZyDfG/mmmKU9xI8T5URCIO4rKyKWRabEHIZYZHys9WkAK95q4MzvakADBL/2p1mnkPhWtI4CAgJFVjvYAsOdix0KfKowCEZURND/5DTN96OgS79GoVs4XUuiw5BmAmPs85tjH0AFT7EtrognT3sICdIQyYeQ/d9cZt684=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4e2b5ffb932so902301137.0;
        Mon, 30 Jun 2025 02:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751275934; x=1751880734;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0HHyttpDTe6qStRsM+nsbJq6FKJZTXS/oIqRBj8ZQtE=;
        b=ctrdL+PabSDUxXpMQyhjEyw83wjJysr0wzzfRaOMsKs0Y1UFM8vU5MAqcmpKTLHO1i
         JqEI3WO6y7j2wesNeo/i/Q8hixOHgJOYEC2rFC1G0kiq19k3m38mFUvWyBLyBbTMajYi
         NPJT4oGbC8sLRhNtdNy6xrgEapYFZajYDU443RaaaJNUGPZaapIeX65jotwWF7QVFrGE
         3FxWhdfcLuudVaLwCTIaI3tvFLbPkVH8BENbY78/rogWMIU8Y+AqkQktgWbIsvn+2iEB
         LdsoRCQI43Tv/Roczps60MsB89kbd4xETgHg6743wLohqwvUXg6+4OvUZQct4emVt+hz
         lRVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUr5oArRa/bndIom0ck9TTYT+v9tJ0ZVwHxBxEnoXudZVDfM8FQ9YyfpNImskjyluuFMA/cEuM+aBcEcFc=@vger.kernel.org, AJvYcCVM7Vw40M+2a2vFgNdvYBybgTAkhlw3w6vSGgqJxYRQXY1Tdy9a9Bkh8EKExbHhe7xcLFnOtKidvBU=@vger.kernel.org, AJvYcCXrH7lNreOj9fi3UJAxnLfSe4T7SQSYKHwZ11qHhMGeUOTUpKNXMhzwM0YC+Lu0a5+Wz1020ixhJ5MvZDjG5C8q01c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaqO+BQBel6p5wuYAorPlpdTJ2K6phMr4l7HWZVglAxKeVU7xZ
	caNFIPOmOPvBSvzTwKL/rD9oDre+zDzF7ZvYi0MhXi+xNQvMHjNEdTTQ0aKrcdoJ
X-Gm-Gg: ASbGncv0rIgwouDy3mynwjVJAzdWkEmy+EEu3klG062aEw13CBwIqCGBJuL7Dz5ZntW
	Dg0gk7KaqK/ESsmWbi12tDYZhG/fHYjbsIxgGlPgU2VMH3NCsA6VZP5x+gwO3cYMsF7tuXxDMaI
	azuLu4ptVQhERvqXHYxtvTpiahNjjruC6ZrmeExtKqho0oDmSHGC23fL7qEe3D8fyHyUVmU3nFP
	YbJkHYo9ofPf3kS5Rn44ZIydygUyppMwWcdIKgRbvtQlLXfSMWoJNKSxolVzgYXUU/PgAzzlSZp
	akqMVcC0tlzZqYTIYOnJUvUKL9PnixwvNzfD+vncW47zYmBRiEBaJ3ls0rCkd5cA2j9YSTVC+lt
	xhEvyC1Igea8mYDzCiaAxS4HM
X-Google-Smtp-Source: AGHT+IGIT+E/CaAL5PE6ydDStpFjv3VCBTFdIKHAfw1sinZ2+157uXsHfhTqTuNcMw8c/ZcwN0uV7g==
X-Received: by 2002:a05:6102:5e8a:b0:4e5:980a:d164 with SMTP id ada2fe7eead31-4ee4f0c2d1bmr8831842137.0.1751275933478;
        Mon, 30 Jun 2025 02:32:13 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-884d1c3781esm1606687241.10.2025.06.30.02.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 02:32:12 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4e7fc3309f2so919111137.2;
        Mon, 30 Jun 2025 02:32:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUxmaTCuRJfAIndzTd41c4PxlEqfTq+N19g4cXfplgimESkcLzekDGRX2Lz99Q1taSb9TzHPMPvG4HxZk=@vger.kernel.org, AJvYcCVA1Q5FrIIRIWr1YG9w5cghVa/zOkLJ9KU5vhCrGRkGlhudzFJWfvK0xZxB4Fto9G/KL1jjuMD3S+c=@vger.kernel.org, AJvYcCXFIvmPkkDG1NylBHyraBVQnZPIvlYM1Xw1vmmHTzXqpXscF4f0OmjQsCpegV8j3ZTS58ISYRaT7BovsA7qmKqVwYw=@vger.kernel.org
X-Received: by 2002:a05:6102:f82:b0:4e2:c6e4:ab1e with SMTP id
 ada2fe7eead31-4ee4f55bd15mr8009074137.7.1751275931927; Mon, 30 Jun 2025
 02:32:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523134025.75130-1-ulf.hansson@linaro.org>
 <fd4cfe7a-e29b-4237-b82f-48354deead3b@ideasonboard.com> <CAPDyKFpprO=HGuiHX3MQ_+m1YRnaWG=XwCx8-fSdXak8VBDUbQ@mail.gmail.com>
 <CAPDyKFpXcpwkacnYqWz2vxaTd7pW5bSRa2F063BryFxVNEAmPA@mail.gmail.com>
 <CAMuHMdXGS+efbbQ_Pn1iYhQ1aWc_DuJ-CBN=jxfjwOWxTRx+9Q@mail.gmail.com> <CAPDyKFoJHFuY278eEobje4TOv_+-i966H2OuP9fqHMLLevb0qw@mail.gmail.com>
In-Reply-To: <CAPDyKFoJHFuY278eEobje4TOv_+-i966H2OuP9fqHMLLevb0qw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 30 Jun 2025 11:31:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVo1eOZiRpcH_XNqP6Y0imk4+bcAe=+W4_Su1pF16uRVA@mail.gmail.com>
X-Gm-Features: Ac12FXyy1jcX9FikFs2NK5_wkqpBj31k8jOziXAUTCaEyHrb3yLbemdWFSlcECU
Message-ID: <CAMuHMdVo1eOZiRpcH_XNqP6Y0imk4+bcAe=+W4_Su1pF16uRVA@mail.gmail.com>
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

Hi Ulf,

On Tue, 24 Jun 2025 at 17:30, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Mon, 23 Jun 2025 at 17:06, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Mon, 23 Jun 2025 at 16:21, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > On Thu, 19 Jun 2025 at 13:40, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > Do you think it would be possible to move rcar_gen4_sysc_pd_init() to
> > > > a postcore/arch_initcall?
> > >
> > > I did some investigation around this and found that both
> > > drivers/pmdomain/renesas/rcar-gen4-sysc.c and
> > > drivers/pmdomain/renesas/rcar-sysc.c are registering their genpd
> > > providers at the early_initcall() level.
> > >
> > > I was trying to find (by browsing renesas DTSes and looking into
> > > drivers) if there is any consumers that actually relies on this, but
> > > so far the earliest consumer I have found is the
> > > drivers/irqchip/irq-renesas-irqc.c, but that's at postcore_initcall().
> > > Of course, it's difficult to say if my analysis is complete as there
> > > are a lot of platform variants and I didn't check them all.
> > >
> > > Maybe we should just give it a try and move both two drivers above to
> > > postcore_initcall and see if it works (assuming the irq-renesas-irqc
> > > supports -EPROBE_DEFER correctly too).
> > >
> > > If this doesn't work, I think we need to find a way to allow deferring
> > > the call to device_add() in of_genpd_provider_add*() for genpd
> > > provider's devices.
> >
> > Commit dcc09fd143bb97c2 ("soc: renesas: rcar-sysc: Add DT support for
> > SYSC PM domains") explains:
> >
> >    "Initialization is done from an early_initcall(), to make sure the PM
> >     Domains are initialized before secondary CPU bringup."
> >
> > but that matters only for arm32 systems (R-Car Gen1 and Gen2).
> > Arm64 systems (R-Car Gen3 and Gen4) use PSCI for CPU PM Domain control.
>
> Geert, thanks a lot for providing these details and helping out, much
> appreciated!
>
> > While changing rcar-sysc.c to use a postcore_initcall indeed moves PM
> > Domain initialization after secondary CPU bringup, the second CPU core
> > on R-Car M2-W is still brought up fine.

To rule out relying on anything being enabled by the bootloader,
I offlined the second CPU, and booted the kernel using kexec.
The second CPU still comes up fine.  Which is not that unsurprising,
as rcar-sysc.c ignores domains with the PD_CPU flag...

> > For R-Car H1, there is a regression:
> >
> >     smp: Bringing up secondary CPUs ...
> >     CPU1: failed to boot: -19
> >     CPU2: failed to boot: -19
> >     CPU3: failed to boot: -19
> >     smp: Brought up 1 node, 1 CPU
> >     SMP: Total of 1 processors activated (500.00 BogoMIPS).
> >
> > CPU bringup/teardown in userspace using
> > /sys/devices/system/cpu/cpu*/online still works.
> > R-Car H1 was never converted to use "enable-method" in DT, and relies
> > on calling into the rcar-sysc driver directly (see [1]).  However,
> > that does not use any actual calls into the genpd core, so probably it
> > can be made to work by splitting rcar_sysc_pd_init() in two parts: an
> > early_initcall() that allocates all domain structures and populates the
> > internal hierarchy, and a postcore_initcall() that registers everything
> > with the genpd core.
>
> Yes, that seems like a viable option.

... so it's just R-Car H1 that needs some code to run early.

> Unless you prefer to have a stab at it, I intend to look into it and
> make the patch(es) part of a new version of the $subject series. Of
> course I am still relying on your help with testing/review.

Sure, I will do testing and review.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

