Return-Path: <linux-pm+bounces-13113-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C764963BF2
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 08:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422231C215D5
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 06:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E028716B754;
	Thu, 29 Aug 2024 06:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="SIhixGlF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27A41607BD
	for <linux-pm@vger.kernel.org>; Thu, 29 Aug 2024 06:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724914190; cv=none; b=n8ERRrUzLysoGMcW103QXhfFN6Uc1JuwZ1Fxb3+mPIntui8J+6dlPxxIpPtoQO1ZCTOZ6fOVitYzlS2pb8dREYcjOcQSLSus4M08A2mCtt7JuwlQOdq0h4jpHmR23SOsecZQwcmUiRAjG8zcBKw/WwI/v1qWW+Z9vLtpEyyIpNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724914190; c=relaxed/simple;
	bh=+6J5GRBTSQB22LMbKF5kAwSQs90jnOuDQH8qepeI/iE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j485OPqMUSbX34rAdqHpGlrVbUm21Dkyt3Bl738hDcQ290Y1HaCx2BHca4AneyEXqNIQCjBNRg5J44f18shHFjeAOPRdy0wooKxGONiMo9KTXTYgAnxiLZHyXH4z0m83cCbyOLHxFMblhQwOXi1GfQsJ5jKzCQP8pqfxb1a0fUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=SIhixGlF; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5344ab30508so1342560e87.0
        for <linux-pm@vger.kernel.org>; Wed, 28 Aug 2024 23:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1724914187; x=1725518987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SJ/S8s6ymwgMOR0oWpgqeaiVzupwAzeqRKGoyGdDvg=;
        b=SIhixGlF2RLJ8y0XNBO1x+YbIzlfNRwPobkCLksOisIFtR/hNrRgJc4jol+avpJM+B
         HEss7TFS82mkiYHwvroeFD9lmwczHJ0n2M5Bx5KENQ/AdAPzAMkW8IYrcoNmBrTYqeOG
         ScIhxf3L3Qe615Xze9hzGo0jyhL7v8Pe68M3jtJnhzvwfyeibT5TCLmxzxRNJpuKRMVx
         TtFESVldMWJU5n/QeflwaNJTXiuXlZym8C5TA69heU3Debx8t0fNF3ehXaGWznsqwRZ5
         RuXaEwvEsrykEcCCDg91K0BOWulZ9izeamDm7mjegcQS5LVOC4ZDUJFT/5p2wgxfXB1e
         +yDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724914187; x=1725518987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3SJ/S8s6ymwgMOR0oWpgqeaiVzupwAzeqRKGoyGdDvg=;
        b=nmU9tOoe6gbp7JAvQqTayHSSoL4GJUSnmrBupHpn/P+0YxpHvNGgZNATPE6tPUBCMP
         wPWU4HHbwC23RreaokLWxfq5pWbSWOYHAZzLHMg+ymKU4BPCfgMqIpAyV8OxDcBl9pPu
         phSgevwAn1ac1qRH6YEDSJSKcMdzELqTqn2/til9byuVLDwLIQLEq8RYwtzHKv4ENf9E
         xNJW69HCkV+ucsEPwQNAyIqDgK26dhAlWrxPI8hlLtJodmZTb4chvz0C1zFs1M/4WMOf
         iRReI6I/ey2FfTdaf8I3lsZBD291Qx+qxGKMs0OfqkDYGMadQLJobIa45wzyj347+c+8
         0T/w==
X-Forwarded-Encrypted: i=1; AJvYcCWbpFqNN898KSTYF8/UzNMj5JYdlpanvJF+vEQgcot6DzTTpbgbHurQh5gzwBeMr+PBqIERxRPKwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNiQ5kJlXxjtbW5cXjKrC14skgfIJ3DfJLYOpYaLE11m99BIgK
	muSCruvSRKYcUqEwZsMupUldm7pLe9JA7sSOomyMSJxrL6QVzFj6ZYivgYLCayvc1hiloKufAGa
	IgHD0ONiTzH9juOsD/8Swd0Yt1njGdRR58stuTw==
X-Google-Smtp-Source: AGHT+IF3BL6bSy6BIFTMgHXF0M9DSfrHTvM8HzubREUgUq0pr1f3k88i+ThXx1hinTdBsAZkIqxHeHHemAumxKwyxQE=
X-Received: by 2002:a05:6512:b1b:b0:52f:30d:526c with SMTP id
 2adb3069b0e04-53540fe8999mr206492e87.5.1724914186368; Wed, 28 Aug 2024
 23:49:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829033904.477200-1-nick.hu@sifive.com> <20240829033904.477200-3-nick.hu@sifive.com>
 <CAK9=C2Xui8c0b55WrZxCZYqK=AFmiPT+nG8d_E0d7SpamwvO-Q@mail.gmail.com> <CAKddAkCoZy=uid5gVzUg-zwhBxX_EZCbFR18521N3142MPv=jw@mail.gmail.com>
In-Reply-To: <CAKddAkCoZy=uid5gVzUg-zwhBxX_EZCbFR18521N3142MPv=jw@mail.gmail.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 29 Aug 2024 12:19:34 +0530
Message-ID: <CAK9=C2VbF2JKSfJLVEV4SYQFxr+gmpBTjtK6DuVFSbEAjRmFOA@mail.gmail.com>
Subject: Re: [PATCH 2/2] time-riscv: Stop stimecmp when cpu hotplug
To: Nick Hu <nick.hu@sifive.com>
Cc: greentime.hu@sifive.com, zong.li@sifive.com, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrew Jones <ajones@ventanamicro.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Sunil V L <sunilvl@ventanamicro.com>, linux-pm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 11:53=E2=80=AFAM Nick Hu <nick.hu@sifive.com> wrote=
:
>
> Hi Anup
>
> On Thu, Aug 29, 2024 at 1:18=E2=80=AFPM Anup Patel <apatel@ventanamicro.c=
om> wrote:
> >
> > On Thu, Aug 29, 2024 at 9:10=E2=80=AFAM Nick Hu <nick.hu@sifive.com> wr=
ote:
> > >
> > > Stop the stimecmp when the cpu is going to be off otherwise the timer
> > > interrupt may pending while performing power down operation.
> > >
> > > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > > ---
> > >  drivers/clocksource/timer-riscv.c | 22 +++++++++++++++-------
> > >  1 file changed, 15 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/=
timer-riscv.c
> > > index 48ce50c5f5e6..9a6acaa8dfb0 100644
> > > --- a/drivers/clocksource/timer-riscv.c
> > > +++ b/drivers/clocksource/timer-riscv.c
> > > @@ -32,15 +32,19 @@
> > >  static DEFINE_STATIC_KEY_FALSE(riscv_sstc_available);
> > >  static bool riscv_timer_cannot_wake_cpu;
> > >
> > > +static void riscv_clock_stop_stimecmp(void)
> > > +{
> > > +       csr_write(CSR_STIMECMP, ULONG_MAX);
> > > +       if (IS_ENABLED(CONFIG_32BIT))
> > > +               csr_write(CSR_STIMECMPH, ULONG_MAX);
> > > +}
> > > +
> > >  static void riscv_clock_event_stop(void)
> > >  {
> > > -       if (static_branch_likely(&riscv_sstc_available)) {
> > > -               csr_write(CSR_STIMECMP, ULONG_MAX);
> > > -               if (IS_ENABLED(CONFIG_32BIT))
> > > -                       csr_write(CSR_STIMECMPH, ULONG_MAX);
> > > -       } else {
> > > +       if (static_branch_likely(&riscv_sstc_available))
> > > +               riscv_clock_stop_stimecmp();
> > > +       else
> > >                 sbi_set_timer(U64_MAX);
> > > -       }
> > >  }
> > >
> > >  static int riscv_clock_next_event(unsigned long delta,
> > > @@ -126,7 +130,11 @@ static int riscv_timer_starting_cpu(unsigned int=
 cpu)
> > >
> > >  static int riscv_timer_dying_cpu(unsigned int cpu)
> > >  {
> > > -       disable_percpu_irq(riscv_clock_event_irq);
> > > +       if (static_branch_likely(&riscv_sstc_available))
> > > +               riscv_clock_stop_stimecmp();
> > > +       else
> > > +               disable_percpu_irq(riscv_clock_event_irq);
> > > +
> >
> > Not disabling riscv_clock_event_irq here for Sstc would now
> > cause riscv_timer_starting_cpu() to unnecessarily enable it
> > when the CPU is powered-up.
> >
> > I think the below change is sufficient for this patch:
> >
> > diff --git a/drivers/clocksource/timer-riscv.c
> > b/drivers/clocksource/timer-riscv.c
> > index 48ce50c5f5e6..546fd248f4ff 100644
> > --- a/drivers/clocksource/timer-riscv.c
> > +++ b/drivers/clocksource/timer-riscv.c
> > @@ -127,6 +127,11 @@ static int riscv_timer_starting_cpu(unsigned int c=
pu)
> >  static int riscv_timer_dying_cpu(unsigned int cpu)
> >  {
> >         disable_percpu_irq(riscv_clock_event_irq);
> > +       /*
> > +        * Stop the timer when the cpu is going to be offline otherwise
> > +        * the timer interrupt may be pending while performing power-do=
wn.
> > +        */
> > +       riscv_clock_event_stop();
> >         return 0;
> >  }
> >
> The sbi_exit() of OpenSBI will disable mtimecmp when
> sbi_hsm_hart_stop() so the mtimecmp will be disabled twice if there is
> no SSTC.
> How about adding a SSTC available check before the riscv_clock_event_stop=
?

Currently, OpenSBI uses mtimecmp only for implementing
SBI time extension but in the future, OpenSBI might implement
a per-hart timer event list to allow M-mode timer events.

Don't assume in what environment the driver is running.

It is possible that the driver is running under a hypervisor
which only provides SBI time extension and does not virtualize
Sstc extension.

>
>   /*
>    * Stop the timer when the cpu is going to be offline otherwise
>    * the timer interrupt may be pending while performing power-down.
>    */
> if (static_branch_likely(&riscv_sstc_available))
>     riscv_clock_event_stop();
>

Regards,
Anup

