Return-Path: <linux-pm+bounces-13104-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 785429639D1
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 07:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81271F22DDD
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 05:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98794136357;
	Thu, 29 Aug 2024 05:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="P/YQ/aUB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FF2149005
	for <linux-pm@vger.kernel.org>; Thu, 29 Aug 2024 05:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724908735; cv=none; b=XplrvTDRS2euLBJnxKPPKpWeEx3bPI8b0N/rjBiGEzNlV+GyNaEw1YvJUmQ22zcrIDTgL+uNUneHemK05kQWvDwSwsBqFexbgFxVsBh7bcRM3ysrJFsnbmejXsI7JFAcsLL4yPklUS7GWca1GSA3oj49mAQdx4IDgAAoJ0kOwlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724908735; c=relaxed/simple;
	bh=fpDL+0iQpSY0M89Gx8z/O74o8zRNybUVdR1eVGEjXso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nEekDgyD8h4Ws1qWYn36ciLmmlhhW/lVbjaZVzICqDg4d4i1aLZ61l1vJe+WZFOv4uCGx8K/Ckps5+36/z1EpovT7INyAA3yp88cqi0ZhUqwpQtaCCh/+ZG6HAWLHr4qys5gQUj6lJbDNZ/Y3tx6ZZ1wGTI02sSIfWmGr+ooW/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=P/YQ/aUB; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-533de5a88f8so240684e87.3
        for <linux-pm@vger.kernel.org>; Wed, 28 Aug 2024 22:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1724908732; x=1725513532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADd1pz5qb8GZVaGnMeyK+BMDRUUvVX49wNmIVUmxoso=;
        b=P/YQ/aUBHk2m6EMrXR+x5/KXJ9RzvaiVPHM2HlxlzppWAlKRKFzt0ALRwpwvPOQ8MC
         aDxNpOD2KHXjPYJ1yJMQgKbtyqACFYxBH9RdPsKpVSgT/ihSjnomCpard//TDDwLa6RS
         ciIR3Ec2XvOxUwWWHPy2kmg08p1k7enMfKt2v5gkcWuz4NuV6vHxCB0KEkhWiodLzm0H
         CdZuRPrR1eZxjagj/E4n5zm/KunfW+Ia6jlv7zjwzDKCg1J69lhY2OzjuJWIrZP7dKGN
         kIfKAX03b+HR1rnBTs9mkmth4iF14f3bxCpMyQYM1dBZlmf59LNkDQl/h8OnESNVkP7Z
         1PgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724908732; x=1725513532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADd1pz5qb8GZVaGnMeyK+BMDRUUvVX49wNmIVUmxoso=;
        b=fZx2HiKBWWcCJ0E559G7D2eV/TX4k2KaiQD5J+w2vZpQuQzjKW8weetuQe03LVEyWE
         reQ75jFAoTFY4PwgkWtCyt3xnEzxDJe8IpH8JyrQ7uJ6YNYtzcpu2gCty84ebF0R1wto
         RD3Tv+fvV2EmYVAG3TjBxQif6PTsl24/RAM2F2biCAgUN2EEMYn8Z3VOy4gj6qwv+e7E
         6Pq2hsCqjLhFaVUqkKfYW5i1Qzkcqpsh2QbLm36ttugfb09gQjR3XiEsDAf6p0B/+Tzn
         MI6uXUv5JKLMlByKJmot6XQ2LTxFD8Dyq08fhEaM0FJPjq7KXw763b2oHiBbsx5Y9236
         bMuA==
X-Forwarded-Encrypted: i=1; AJvYcCUZrrwm8njYCPDd5tdYbvQh4my4oNVwB9QsU7gWjlWUjLc5INv4WeghkLnXMY1gVIzeJY5jJkbt3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhX9ZfXXfge6Gvr7LHEpbHnomqGL3hWX4FR8unCFSdqa7tMOYJ
	HmzBWla+lZYRz04Cex6g9VIrJWKmcwuppvthqRG3xJIuPdIG4QIDCNgP28vB0HvsQVH1r3l95SJ
	oGdOtWpekFwcOT80eSuQ+dx/t4kTqaeM8QXx8aA==
X-Google-Smtp-Source: AGHT+IFRqTsQ8ZecaWgM2Dv+1zg5sGgzkhwWVX9acELeYxsUIxzlJDrqJ7iynAbrAbJ7Rf0HT/LZsQk0wrd27CzsnIQ=
X-Received: by 2002:a05:6512:12d1:b0:533:7ce:20e0 with SMTP id
 2adb3069b0e04-5353e548573mr869523e87.8.1724908731314; Wed, 28 Aug 2024
 22:18:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829033904.477200-1-nick.hu@sifive.com> <20240829033904.477200-3-nick.hu@sifive.com>
In-Reply-To: <20240829033904.477200-3-nick.hu@sifive.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 29 Aug 2024 10:48:40 +0530
Message-ID: <CAK9=C2Xui8c0b55WrZxCZYqK=AFmiPT+nG8d_E0d7SpamwvO-Q@mail.gmail.com>
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

On Thu, Aug 29, 2024 at 9:10=E2=80=AFAM Nick Hu <nick.hu@sifive.com> wrote:
>
> Stop the stimecmp when the cpu is going to be off otherwise the timer
> interrupt may pending while performing power down operation.
>
> Signed-off-by: Nick Hu <nick.hu@sifive.com>
> ---
>  drivers/clocksource/timer-riscv.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/time=
r-riscv.c
> index 48ce50c5f5e6..9a6acaa8dfb0 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -32,15 +32,19 @@
>  static DEFINE_STATIC_KEY_FALSE(riscv_sstc_available);
>  static bool riscv_timer_cannot_wake_cpu;
>
> +static void riscv_clock_stop_stimecmp(void)
> +{
> +       csr_write(CSR_STIMECMP, ULONG_MAX);
> +       if (IS_ENABLED(CONFIG_32BIT))
> +               csr_write(CSR_STIMECMPH, ULONG_MAX);
> +}
> +
>  static void riscv_clock_event_stop(void)
>  {
> -       if (static_branch_likely(&riscv_sstc_available)) {
> -               csr_write(CSR_STIMECMP, ULONG_MAX);
> -               if (IS_ENABLED(CONFIG_32BIT))
> -                       csr_write(CSR_STIMECMPH, ULONG_MAX);
> -       } else {
> +       if (static_branch_likely(&riscv_sstc_available))
> +               riscv_clock_stop_stimecmp();
> +       else
>                 sbi_set_timer(U64_MAX);
> -       }
>  }
>
>  static int riscv_clock_next_event(unsigned long delta,
> @@ -126,7 +130,11 @@ static int riscv_timer_starting_cpu(unsigned int cpu=
)
>
>  static int riscv_timer_dying_cpu(unsigned int cpu)
>  {
> -       disable_percpu_irq(riscv_clock_event_irq);
> +       if (static_branch_likely(&riscv_sstc_available))
> +               riscv_clock_stop_stimecmp();
> +       else
> +               disable_percpu_irq(riscv_clock_event_irq);
> +

Not disabling riscv_clock_event_irq here for Sstc would now
cause riscv_timer_starting_cpu() to unnecessarily enable it
when the CPU is powered-up.

I think the below change is sufficient for this patch:

diff --git a/drivers/clocksource/timer-riscv.c
b/drivers/clocksource/timer-riscv.c
index 48ce50c5f5e6..546fd248f4ff 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -127,6 +127,11 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
 static int riscv_timer_dying_cpu(unsigned int cpu)
 {
        disable_percpu_irq(riscv_clock_event_irq);
+       /*
+        * Stop the timer when the cpu is going to be offline otherwise
+        * the timer interrupt may be pending while performing power-down.
+        */
+       riscv_clock_event_stop();
        return 0;
 }

Regards,
Anup

