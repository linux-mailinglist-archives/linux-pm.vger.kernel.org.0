Return-Path: <linux-pm+bounces-16646-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 098569B438A
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 08:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6BAE1F22C97
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 07:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1330B2022ED;
	Tue, 29 Oct 2024 07:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="i/1LFc2m"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8FD1CCB33
	for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2024 07:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730188364; cv=none; b=Pq+dSib9Ni6DzcgfGGkXtTjzh6BcgX957xSiKUEhHhXm6rDpLKbiXZdAPpclA0nphoaqInstScc+wE1WHxfU/gqfv4HDHIJkltPqefZRKZ/ObyMDgiaVL+DkHB1p29qSNx/0Z/s8z9+dJMrZu9SueluTvox/DA6VY/5MuB/FXj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730188364; c=relaxed/simple;
	bh=PjkBvTTYwOiWazejEqU9482wFOSVZFs6iPyNkUYLrSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s7pbRjwDFZnN4e3lob4MTibqe4m+7qE4NSzewmQ51vpXb6gAtGPwnQ0u9SbBnxfEwcRYmnoFhG+4nQqBeDuq8BElyBsO1z1lGauSDu5bUWadnpI9buJJA12hONyXk/e6XF/cl9VsS3gMDI3OfStKHqbMv5nENGvCCsYlw+d80eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=i/1LFc2m; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-28cdd9d8d01so2640389fac.1
        for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2024 00:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1730188361; x=1730793161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rbp3tWipnS9n1DED0E9JncApTpU6NEKrzZwh6VcEEY=;
        b=i/1LFc2msEtxXgPB3Trp9GnXTmgxFP7JOr4XYxHWO4yuOaOkwkddkAqs1CNjjgxnCh
         NRSXncSUMARypugVO6QJko/YFRCOiAigXDHDmEaOWLB+zVmSkyVQJegcG/ULttWNiufw
         bDKqGyo358cmXktusfUETCMDe2O8OEjEhojUawFgxI2rziOcIWFFjN2KgLSrpCYz+oC2
         Wju7m/+NFmg+bjHy0komNFimuHpsmbKgPafdcCL2sOPs5djfArhychICMPYzQwt00xCj
         kx2ZwxYzZ+wNCjMm8ji/NU05SqyMRukjB4+VbvQy2+SomSYwvUayONTEPBdvnfuzSjvO
         BQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730188361; x=1730793161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rbp3tWipnS9n1DED0E9JncApTpU6NEKrzZwh6VcEEY=;
        b=gGavF+/TIQcPaJmOcPfrs9c5uUmXDrqbk+gxWS0wZbEzOTTThyCSHzcj8cdStPlXfU
         v8GlNBR4N5+RKxWkM7gnkVjKlSlfsH+nmjrYjsqbAuGpBkRnzat/pfJiyjhQwgWIM+ss
         9dZo20PWv3knGZuiskF51egMhOa3JhJS0e+Pbk2qpmBRG+yiKa7exT/ScbhC/SqRrE98
         GmwIwZvGJVS2+SDzHkHM27tI6vhynltr1s3DkPt058NnrsXU3M88GjCCnQ+avor6+Mmv
         18EpvqEKOVPy3d8VQFTyP0tkeT/0KIJeUWKgCn/x4MJczxUgDGIYiCcH0BJ0/0MBEgkH
         unVA==
X-Forwarded-Encrypted: i=1; AJvYcCWOqNIv/pNVXntenpfehY8q7eQXPADoQ4vPp47lYwV6IhXUHMGJGUvLK1cZ+a3tdGrPcqA00WE4xQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyA639oe9u+e5At2oFaeLKL0RqXbSUkPOC8ixKXp6WXOWmCB7tP
	Tb7qtQ+3tZHyBBIxj6Tgsb8x/wgO0laC74lTxfao0q6EDQOWZ/6Gx0I2WUfoqcamyEn8ySHaYOy
	APsY3isukFRQDfyf1ZNkJYG+4uoJmy+HXKtIK3g==
X-Google-Smtp-Source: AGHT+IHcE0Z//RMNpx9Ji2VGSBbKrOfXkqpktFDkWF0oOow3SiBDbyLJpaYAaQNfcMF3HWuiO8z58Zejjdv6FocygCo=
X-Received: by 2002:a05:6870:82a1:b0:277:cc56:2300 with SMTP id
 586e51a60fabf-29051b4d708mr9099951fac.12.1730188360819; Tue, 29 Oct 2024
 00:52:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028033928.223218-1-nick.hu@sifive.com> <20241028033928.223218-3-nick.hu@sifive.com>
 <5f7179ec-e4ce-4644-8a60-ce407a4d2f11@linaro.org>
In-Reply-To: <5f7179ec-e4ce-4644-8a60-ce407a4d2f11@linaro.org>
From: Nick Hu <nick.hu@sifive.com>
Date: Tue, 29 Oct 2024 15:52:30 +0800
Message-ID: <CAKddAkBRhtUhue7meUFy2ZDyERpcG4ua=Wyb0q-ZaBzmHZCD0A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] clocksource/drivers/timer-riscv: Stop stimecmp
 when cpu hotplug
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: greentime.hu@sifive.com, zong.li@sifive.com, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrew Jones <ajones@ventanamicro.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Mon, Oct 28, 2024 at 5:44=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 28/10/2024 04:39, Nick Hu wrote:
> > Stop the timer when the cpu is going to be offline otherwise the
> > timer interrupt may be pending while performing power-down.
> >
> > Suggested-by: Anup Patel <anup@brainfault.org>
> > Link: https://lore.kernel.org/lkml/20240829033904.477200-3-nick.hu@sifi=
ve.com/T/#u
> > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > Reviewed-by: Anup Patel <anup@brainfault.org>
> > ---
> >   drivers/clocksource/timer-riscv.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/ti=
mer-riscv.c
> > index 48ce50c5f5e6..166dee14e46b 100644
> > --- a/drivers/clocksource/timer-riscv.c
> > +++ b/drivers/clocksource/timer-riscv.c
> > @@ -127,6 +127,12 @@ static int riscv_timer_starting_cpu(unsigned int c=
pu)
> >   static int riscv_timer_dying_cpu(unsigned int cpu)
> >   {
> >       disable_percpu_irq(riscv_clock_event_irq);
> > +     /*
> > +      * Stop the timer when the cpu is going to be offline otherwise
> > +      * the timer interrupt may be pending while performing power-down=
.
> > +      */
> > +     riscv_clock_event_stop();
> > +
> >       return 0;
> >   }
>
> Should it not be the opposite?
>
> First stop the clock which clears the interrupt and then disable the irq?
>
SIE.STIE =3D 0 ->
Mtimer interrupt comes -> trap to m-mode -> raise STIP ->
stop the clock
Is the above case you are concerned about?

>
>
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog

