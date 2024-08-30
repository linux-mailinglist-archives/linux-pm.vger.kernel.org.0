Return-Path: <linux-pm+bounces-13200-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CB896572B
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 07:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA19286290
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 05:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0DB14EC40;
	Fri, 30 Aug 2024 05:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XdypjZWY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FBA14A0B6
	for <linux-pm@vger.kernel.org>; Fri, 30 Aug 2024 05:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724997391; cv=none; b=Q+7OA77YuLsgjhDvkE7aoau4N+A8M0BqDl7vlrSCK1c4TQ8J3QJh6hQkDd/5O5xIfDmsfwo7glV/s3yb0b5Xjw6xH5N7qBSSnjKM1Fjb1QxhqESyQQ8RBZLVDtI5PioymcU/9dzALwdne4eCKGXWi+xYkTNKBVxPNMYKfslWMYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724997391; c=relaxed/simple;
	bh=BufH58xUlwGgIMD/X+IHjfQoH0oJKj3bV5BKz4Oi78o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X8+ZDdvcobV9M13f2wsdJed7wbAMah1SL+f3EvtjGOhTibydUS2cVVDJXArQVO6pI5adyGyBLKoOdFLy2bZg9klTSoy5DYgDMwwj8wT/ZWxF/0yerZ/rI5hPiSL1DiY8r/7vrPccLpbkXkvuPAX37YPjEkkJcX1NazYeVo7q6TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=XdypjZWY; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3df121f7088so275629b6e.2
        for <linux-pm@vger.kernel.org>; Thu, 29 Aug 2024 22:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1724997388; x=1725602188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jErUDJYJZrdtSGs3YNEXW8T8pZ8TEPOPqQ7j0f/EK1I=;
        b=XdypjZWYL0b2ijAI4gN+q2xT7eWcpLp3eYb8z24uN4/ZHtAIOEBG1snTd7qo+lpSva
         f7bi1u/a2cpFg0qYTdnEwCDu1WNQ2sxVKO7jgfO49Rn1duU/7KqvqoCY3RZaPuzMRmpl
         Sb6O3QD1eJ2cBmgb3Hf3KDTC+TF7ct6rIMKeYkjoDkaERO1Y6Fmg4WYN3kmARvLUtEzd
         +tFGATYL7Y/S9IQuzcqCoHQSGNlgU304OYor6s2fha24PqRSbm3Cvb+h8LAYmoEPPWe/
         2u9llI860KfydaD1u3sPBYSP1B6RT45NwRY98L5thdL//64K/DDTVnn9CS/RNEsLQbiE
         xcqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724997388; x=1725602188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jErUDJYJZrdtSGs3YNEXW8T8pZ8TEPOPqQ7j0f/EK1I=;
        b=ZGlwkv4I0HNcmHTmH4C/r0JLVuViM0aLGSebz/sZFP1fFlCt8GKL6mZ2veFixqjy2w
         yRevmV4WDq/3qYL4Eal6HmcdpsXe9KW5YBMlvUUwSt5q0GBQM4E5atMIn/SuET0UOJY+
         KGT3o8cNYNLD/tX4nq/tH82aMtWsFuAsuazREGbToYPrHttrrSwGIXmScfRcglt2rDnF
         qONE6BZzWUIlNrAWYLWjnjCr760zGR4Yzm3Pg2XuBzEnIb7NNYGuF6VA2PuS9pdgX0Iz
         idnS02gZxZuvuIEwkwPQHyNYiQj/gYQ8DvbkNVHMt/OBCbcO7xXJ1AkU7oz6UDNYObGc
         DSaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe21CiYpeEAIQR/aJgcHBie13AHpXqQjWZaq9OdNDz4r2YYD2fEHm1BEh8nMPydWGVhGcgbfstng==@vger.kernel.org
X-Gm-Message-State: AOJu0YycvABEtqph5iWHWGV19WXKmnNsFZVA9Vv2r+w9RjK8nMbWzI6B
	bL5sJiFdvqTb4W3mJRI6/JvYc6OTz/efA4lmQES+UMqNwPEIT+1f0hxqu6XpzA08ypT8Lzfn/v8
	tZiIE/OfvLjEBLoJiuqMqgFxnmkmIC6dT8p376w==
X-Google-Smtp-Source: AGHT+IHA3E7d2Q5u8iuUQE6FpOiZI0dlWkCb5KtpOqR2HgEH/0+z5Vbpq2htdz0jpr0UjNRAEK7twhGJkx21tqu8hgU=
X-Received: by 2002:a05:6808:1692:b0:3de:13bf:3092 with SMTP id
 5614622812f47-3df05d8557fmr4797666b6e.24.1724997387915; Thu, 29 Aug 2024
 22:56:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829033904.477200-1-nick.hu@sifive.com> <20240829033904.477200-3-nick.hu@sifive.com>
 <CAK9=C2Xui8c0b55WrZxCZYqK=AFmiPT+nG8d_E0d7SpamwvO-Q@mail.gmail.com>
 <CAKddAkCoZy=uid5gVzUg-zwhBxX_EZCbFR18521N3142MPv=jw@mail.gmail.com> <CAK9=C2VbF2JKSfJLVEV4SYQFxr+gmpBTjtK6DuVFSbEAjRmFOA@mail.gmail.com>
In-Reply-To: <CAK9=C2VbF2JKSfJLVEV4SYQFxr+gmpBTjtK6DuVFSbEAjRmFOA@mail.gmail.com>
From: Nick Hu <nick.hu@sifive.com>
Date: Fri, 30 Aug 2024 13:56:17 +0800
Message-ID: <CAKddAkAbf7VJ-dZ_PWsDstTKgTobA_UCYK+vix1ovc-BSMOyJA@mail.gmail.com>
Subject: Re: [PATCH 2/2] time-riscv: Stop stimecmp when cpu hotplug
To: Anup Patel <apatel@ventanamicro.com>
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

Hi Anup

On Thu, Aug 29, 2024 at 2:49=E2=80=AFPM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> On Thu, Aug 29, 2024 at 11:53=E2=80=AFAM Nick Hu <nick.hu@sifive.com> wro=
te:
> >
> > Hi Anup
> >
> > On Thu, Aug 29, 2024 at 1:18=E2=80=AFPM Anup Patel <apatel@ventanamicro=
.com> wrote:
> > >
> > > On Thu, Aug 29, 2024 at 9:10=E2=80=AFAM Nick Hu <nick.hu@sifive.com> =
wrote:
> > > >
> > > > Stop the stimecmp when the cpu is going to be off otherwise the tim=
er
> > > > interrupt may pending while performing power down operation.
> > > >
> > > > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > > > ---
> > > >  drivers/clocksource/timer-riscv.c | 22 +++++++++++++++-------
> > > >  1 file changed, 15 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksourc=
e/timer-riscv.c
> > > > index 48ce50c5f5e6..9a6acaa8dfb0 100644
> > > > --- a/drivers/clocksource/timer-riscv.c
> > > > +++ b/drivers/clocksource/timer-riscv.c
> > > > @@ -32,15 +32,19 @@
> > > >  static DEFINE_STATIC_KEY_FALSE(riscv_sstc_available);
> > > >  static bool riscv_timer_cannot_wake_cpu;
> > > >
> > > > +static void riscv_clock_stop_stimecmp(void)
> > > > +{
> > > > +       csr_write(CSR_STIMECMP, ULONG_MAX);
> > > > +       if (IS_ENABLED(CONFIG_32BIT))
> > > > +               csr_write(CSR_STIMECMPH, ULONG_MAX);
> > > > +}
> > > > +
> > > >  static void riscv_clock_event_stop(void)
> > > >  {
> > > > -       if (static_branch_likely(&riscv_sstc_available)) {
> > > > -               csr_write(CSR_STIMECMP, ULONG_MAX);
> > > > -               if (IS_ENABLED(CONFIG_32BIT))
> > > > -                       csr_write(CSR_STIMECMPH, ULONG_MAX);
> > > > -       } else {
> > > > +       if (static_branch_likely(&riscv_sstc_available))
> > > > +               riscv_clock_stop_stimecmp();
> > > > +       else
> > > >                 sbi_set_timer(U64_MAX);
> > > > -       }
> > > >  }
> > > >
> > > >  static int riscv_clock_next_event(unsigned long delta,
> > > > @@ -126,7 +130,11 @@ static int riscv_timer_starting_cpu(unsigned i=
nt cpu)
> > > >
> > > >  static int riscv_timer_dying_cpu(unsigned int cpu)
> > > >  {
> > > > -       disable_percpu_irq(riscv_clock_event_irq);
> > > > +       if (static_branch_likely(&riscv_sstc_available))
> > > > +               riscv_clock_stop_stimecmp();
> > > > +       else
> > > > +               disable_percpu_irq(riscv_clock_event_irq);
> > > > +
> > >
> > > Not disabling riscv_clock_event_irq here for Sstc would now
> > > cause riscv_timer_starting_cpu() to unnecessarily enable it
> > > when the CPU is powered-up.
> > >
> > > I think the below change is sufficient for this patch:
> > >
> > > diff --git a/drivers/clocksource/timer-riscv.c
> > > b/drivers/clocksource/timer-riscv.c
> > > index 48ce50c5f5e6..546fd248f4ff 100644
> > > --- a/drivers/clocksource/timer-riscv.c
> > > +++ b/drivers/clocksource/timer-riscv.c
> > > @@ -127,6 +127,11 @@ static int riscv_timer_starting_cpu(unsigned int=
 cpu)
> > >  static int riscv_timer_dying_cpu(unsigned int cpu)
> > >  {
> > >         disable_percpu_irq(riscv_clock_event_irq);
> > > +       /*
> > > +        * Stop the timer when the cpu is going to be offline otherwi=
se
> > > +        * the timer interrupt may be pending while performing power-=
down.
> > > +        */
> > > +       riscv_clock_event_stop();
> > >         return 0;
> > >  }
> > >
> > The sbi_exit() of OpenSBI will disable mtimecmp when
> > sbi_hsm_hart_stop() so the mtimecmp will be disabled twice if there is
> > no SSTC.
> > How about adding a SSTC available check before the riscv_clock_event_st=
op?
>
> Currently, OpenSBI uses mtimecmp only for implementing
> SBI time extension but in the future, OpenSBI might implement
> a per-hart timer event list to allow M-mode timer events.
>
> Don't assume in what environment the driver is running.
>
> It is possible that the driver is running under a hypervisor
> which only provides SBI time extension and does not virtualize
> Sstc extension.
>
I see, Thank you for the explanation!

> >
> >   /*
> >    * Stop the timer when the cpu is going to be offline otherwise
> >    * the timer interrupt may be pending while performing power-down.
> >    */
> > if (static_branch_likely(&riscv_sstc_available))
> >     riscv_clock_event_stop();
> >
>
I'll update this one in the next version.

> Regards,
> Anup

Regards,
Nick

