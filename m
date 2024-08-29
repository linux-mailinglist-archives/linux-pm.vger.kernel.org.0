Return-Path: <linux-pm+bounces-13106-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E92AB963B52
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 08:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1884F1C227C8
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 06:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEF916C6A8;
	Thu, 29 Aug 2024 06:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SA4vrN+G"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF2F16B397
	for <linux-pm@vger.kernel.org>; Thu, 29 Aug 2024 06:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912611; cv=none; b=B90Du6YyW0pmSVRp4wvhDRFOlsFYoJZCNcPWanavHybbctsor/r5tEuuR/yiIzF/J/tJQj7vp27pubFWHjCd/AJDCkPXAUp/i0E4mdo195JT7gMLCl80qT/wEApcIES6SeUGdQgTOheKh3m7aMtZ5OjYcayX/cs3TeaTDpAqmUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912611; c=relaxed/simple;
	bh=dkdmIuQYl1coKbga9XyJn6tBjWI8hTtx/BFx3J36z/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJVSQhS37W4it1V969kEeuUjDBBVTeKb9Nc6ZDcqr3A2yHalc+E+mGPWPxV0IdbuWcFUoqQJCjYUrYRxnVbdPT+A+ezsmzHDxQaQCo8q7/sJA5Zaj1x6xr1ig2LXIlVtWflobVyVSeBAtEHxRxCJ54TeFFyTlXdcpV+gk0SD+kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=SA4vrN+G; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3dd25b2c3f2so102169b6e.0
        for <linux-pm@vger.kernel.org>; Wed, 28 Aug 2024 23:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1724912608; x=1725517408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=We5m3+H3R8SKY6TgdOmuAhW7gddzpKBKIL3OWVnLm/o=;
        b=SA4vrN+GleCX+brUm5YBZZkIg+7W9IpjC7OB0KP5YENpab9Zk4dR2BQRbdJbsUhbrd
         FClJ2QDK+4jh8Lm0x6Iakam7AZ6YH1h0E3uCFzl0upuJEetsxjqCg4fL6w1Z/3XoKDB4
         ranr4ZpChBUsxbnNHYq/lB/FSnQNE+G2tUixN/s5tOCMSP82TaiKTX1jfSnA5y/D9BdP
         ZPyEke6/TlK+nPREQxpm1dbghynV+0ObR0uk9PEZpfcOa3UnKSFggNgtKT8vGmQjEd9v
         DUsSzdstx5La5bdllB/DpVd2CwiIamABFv6W2ee086loa6KKP3YEpUF/mG8+ZLIVtmHP
         HPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724912608; x=1725517408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=We5m3+H3R8SKY6TgdOmuAhW7gddzpKBKIL3OWVnLm/o=;
        b=KvFNpzkL9hc1sy32wf0x33schznQ/zkjn1nBazLhU37+lVvhQeaRJG8x2Uu/k5uD02
         GuD3qUnICCtfT0dN+ukMpOMZqiz1pRmb5tov+cwQmwQwR+AGLFtOIYtERjDxsUuRveL6
         AohwfgWOTP33xQikoVuQSlo8m8m9oBaRnY/1hsnN/OISDdQvrNVhEY3yULVj2nARkDdX
         5428KT7UommecCnrkD7J7RAIB7wierWkwH5Azq9VMAoxmfNZQJA0Lcr2JOVTB1QCSD8B
         /9HGfFNlBYPeNqcy6Qojnl/asYQnRXeTfBGv2db0JL8WItNf+dEQ00IyoebJa3bVgQ2+
         zn8g==
X-Forwarded-Encrypted: i=1; AJvYcCXxTbgi/CUsRe6PvuS2cTW7ffh1DTtK2St8lkIjyRHKFQFvtWJU0jNe5oA/F/cNd5pdZ80H/WRmCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqOrNjyvEklJEM1MD/eYOk4ESbbYitp396he8P+bFCB+JUoIJx
	oSZeJL7f6CyJU4pKnd3kHPpcN8SEg/NDykMwWH7jXcCVzfD3y80qzqiDWJOBOCz7aZYo4mNQwQG
	w9+GX4WdMEDBpmH6Dp1yKnD9P7y8W3SVXEPxwQA==
X-Google-Smtp-Source: AGHT+IGx2qU3L4U5PKY484HvHyYBLh0VVe3B33vKeGxVNlqtt9Y75kBhD2f6+d1QQddZ4gxg4HMzb7nFa22jyhmjQaY=
X-Received: by 2002:a05:6808:30a1:b0:3d6:32d2:2c10 with SMTP id
 5614622812f47-3df05e350f0mr2073377b6e.31.1724912608433; Wed, 28 Aug 2024
 23:23:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829033904.477200-1-nick.hu@sifive.com> <20240829033904.477200-3-nick.hu@sifive.com>
 <CAK9=C2Xui8c0b55WrZxCZYqK=AFmiPT+nG8d_E0d7SpamwvO-Q@mail.gmail.com>
In-Reply-To: <CAK9=C2Xui8c0b55WrZxCZYqK=AFmiPT+nG8d_E0d7SpamwvO-Q@mail.gmail.com>
From: Nick Hu <nick.hu@sifive.com>
Date: Thu, 29 Aug 2024 14:23:17 +0800
Message-ID: <CAKddAkCoZy=uid5gVzUg-zwhBxX_EZCbFR18521N3142MPv=jw@mail.gmail.com>
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

On Thu, Aug 29, 2024 at 1:18=E2=80=AFPM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> On Thu, Aug 29, 2024 at 9:10=E2=80=AFAM Nick Hu <nick.hu@sifive.com> wrot=
e:
> >
> > Stop the stimecmp when the cpu is going to be off otherwise the timer
> > interrupt may pending while performing power down operation.
> >
> > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > ---
> >  drivers/clocksource/timer-riscv.c | 22 +++++++++++++++-------
> >  1 file changed, 15 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/ti=
mer-riscv.c
> > index 48ce50c5f5e6..9a6acaa8dfb0 100644
> > --- a/drivers/clocksource/timer-riscv.c
> > +++ b/drivers/clocksource/timer-riscv.c
> > @@ -32,15 +32,19 @@
> >  static DEFINE_STATIC_KEY_FALSE(riscv_sstc_available);
> >  static bool riscv_timer_cannot_wake_cpu;
> >
> > +static void riscv_clock_stop_stimecmp(void)
> > +{
> > +       csr_write(CSR_STIMECMP, ULONG_MAX);
> > +       if (IS_ENABLED(CONFIG_32BIT))
> > +               csr_write(CSR_STIMECMPH, ULONG_MAX);
> > +}
> > +
> >  static void riscv_clock_event_stop(void)
> >  {
> > -       if (static_branch_likely(&riscv_sstc_available)) {
> > -               csr_write(CSR_STIMECMP, ULONG_MAX);
> > -               if (IS_ENABLED(CONFIG_32BIT))
> > -                       csr_write(CSR_STIMECMPH, ULONG_MAX);
> > -       } else {
> > +       if (static_branch_likely(&riscv_sstc_available))
> > +               riscv_clock_stop_stimecmp();
> > +       else
> >                 sbi_set_timer(U64_MAX);
> > -       }
> >  }
> >
> >  static int riscv_clock_next_event(unsigned long delta,
> > @@ -126,7 +130,11 @@ static int riscv_timer_starting_cpu(unsigned int c=
pu)
> >
> >  static int riscv_timer_dying_cpu(unsigned int cpu)
> >  {
> > -       disable_percpu_irq(riscv_clock_event_irq);
> > +       if (static_branch_likely(&riscv_sstc_available))
> > +               riscv_clock_stop_stimecmp();
> > +       else
> > +               disable_percpu_irq(riscv_clock_event_irq);
> > +
>
> Not disabling riscv_clock_event_irq here for Sstc would now
> cause riscv_timer_starting_cpu() to unnecessarily enable it
> when the CPU is powered-up.
>
> I think the below change is sufficient for this patch:
>
> diff --git a/drivers/clocksource/timer-riscv.c
> b/drivers/clocksource/timer-riscv.c
> index 48ce50c5f5e6..546fd248f4ff 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -127,6 +127,11 @@ static int riscv_timer_starting_cpu(unsigned int cpu=
)
>  static int riscv_timer_dying_cpu(unsigned int cpu)
>  {
>         disable_percpu_irq(riscv_clock_event_irq);
> +       /*
> +        * Stop the timer when the cpu is going to be offline otherwise
> +        * the timer interrupt may be pending while performing power-down=
.
> +        */
> +       riscv_clock_event_stop();
>         return 0;
>  }
>
The sbi_exit() of OpenSBI will disable mtimecmp when
sbi_hsm_hart_stop() so the mtimecmp will be disabled twice if there is
no SSTC.
How about adding a SSTC available check before the riscv_clock_event_stop?

  /*
   * Stop the timer when the cpu is going to be offline otherwise
   * the timer interrupt may be pending while performing power-down.
   */
if (static_branch_likely(&riscv_sstc_available))
    riscv_clock_event_stop();

> Regards,
> Anup

