Return-Path: <linux-pm+bounces-14804-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B9D987070
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 11:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78431F282FB
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 09:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7733A1AAE2A;
	Thu, 26 Sep 2024 09:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="CXGzRBFy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF99192595
	for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2024 09:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727343672; cv=none; b=ks66CmvITwO8bgQG8n/ieYlIFzDh9zYQ634taCHLjAvRfoXYKaI3mcjIMN9ZQpyYun7nfN3dW58AsxM2b0Nd0cTFxIwnvsxilxhkryoaxh+sHqJOg1PUcjPmz2iuQU0S7ZQAJq0ISp+sSFSMTljeSTQ/6/HmFc2dh7dPZpp/dBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727343672; c=relaxed/simple;
	bh=xskZouvFV/Fx30bVQpBOCRnKu9Pt38UA0tbzCtzke7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqfGaOe967rMOrmBXhgNtJ6ToI0+FgefjcgwG5P6y06w8RI0LQjDYqu8aUn4iaYX+W+NqOlvNxWUykUxb+dCVRxcLVQpwk9lwXoY+xdiz0y+BOaDXQ+WQl6d+fKVrgs8ueCe7fQ0WUW6Vv7WrtgoqAPtBE2JPHpTEoRnySYGRq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=CXGzRBFy; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a274ef3bdeso3164015ab.2
        for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2024 02:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1727343670; x=1727948470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FnhWXWhJY5yX0Pz22eGrT3yNZ4PY7RxqE/CT+upcRM=;
        b=CXGzRBFy4kIey4B1W41TVzMU/v+JtpiwlOJR8dYvERYfeAGOl42unEw759WoRpR7iX
         gAf3FggVhXW4F4v9dhahh2NfxMXhOpy5JvQdAQKYnOL2wC8BTmT+Xwrzd1tJq79LeJ3J
         mtoEmrClq4stuQ9dnhWWdISLQjbu+VM/HSWoyrGFL8fsus29tqb+QmU0+CJJVS2SYGes
         uxVHjqyiugxx/2HkRX3Hye6oFGdzCWmtgZWfyrdy0PO9PUt3FLY2ysvvRwC9cXVUvljW
         0xcyna0apPgCWuHSJNEuNqMkvpY6u2ILXnsCh+GTsTavg6fpHYGRRxDNdrlJKdOzF8RQ
         5LvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727343670; x=1727948470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FnhWXWhJY5yX0Pz22eGrT3yNZ4PY7RxqE/CT+upcRM=;
        b=C5MLoaWctAY5CvUVbiM3a8oTjSup9jA1hIKfb7XeljzENV/Ha6m2lQSq0THsJD2gC8
         mPh4f3t5STAN6W3PWWGk+sn9XR6m/Fii783jgJH2pADB1n4GmTmwASK7La814x8ulro8
         Iw+qWYpFfVVbViQ88V3oYI/3jzCP9eDktq+M8w4qP2HTDMdpOQFtRcnA86eG0rzdbeki
         cvS+CE4ahVIoblwgsb6Kcj7sbkWTACk7G15E0uMvF3/Nh4Mcr7KkY+fAYXbiPZTejzuv
         IcEIpvEDzxODSM+tkEjwQaIsUA0TrmoopYcQjehayqn9jhl8YFJjE47fnIPBoTdQd4u7
         Bw/w==
X-Forwarded-Encrypted: i=1; AJvYcCWezPVDJRdgwzUbozIQDEo9XdF3Uyl7dsddBS0kvGtcrcZcnIYe2rb7AwWooQYsYzCIQXGHajdrog==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyR9HWrc//zoNb9cQEYJYIiZ0pA1dWhNCZtepyahiOUO1OhvpC
	MsHRafZlojrMvdaQrFExaqgmWjU23z1r2FKpR1tvnJlfj4aX6IfGvNz/9R8ukZzVK32QLKAQ4wl
	Zalq08HsIXbI37etiUiPGf0yh2HsufSvKQLyVtw==
X-Google-Smtp-Source: AGHT+IHqNUMKocHT7RIHy4uucpu7Fe6ujivpI7W/6ABihTZ2wyqDu266A5BST9H2zCCJnzEm7SRobEf7LeCchdTK+UA=
X-Received: by 2002:a05:6e02:1a24:b0:3a0:52f9:9170 with SMTP id
 e9e14a558f8ab-3a26d6f9e12mr58910685ab.1.1727343669759; Thu, 26 Sep 2024
 02:41:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926065422.226518-1-nick.hu@sifive.com> <20240926065422.226518-4-nick.hu@sifive.com>
In-Reply-To: <20240926065422.226518-4-nick.hu@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 26 Sep 2024 15:10:58 +0530
Message-ID: <CAAhSdy3iB++KRj_q5GS5qpri2A9OZii=p1itxiXQnoos3So3GA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] clocksource/drivers/timer-riscv: Stop stimecmp
 when cpu hotplug
To: Nick Hu <nick.hu@sifive.com>
Cc: greentime.hu@sifive.com, zong.li@sifive.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrew Jones <ajones@ventanamicro.com>, Mayuresh Chitale <mchitale@ventanamicro.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Atish Patra <atishp@rivosinc.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Samuel Ortiz <sameo@rivosinc.com>, 
	Sunil V L <sunilvl@ventanamicro.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 12:26=E2=80=AFPM Nick Hu <nick.hu@sifive.com> wrote=
:
>
> Stop the stimecmp when the cpu is going to be off otherwise the timer
> stimecmp register while cpu non retention suspend.
>
> Suggested-by: Anup Patel <anup@brainfault.org>
> Link: https://lore.kernel.org/lkml/20240829033904.477200-3-nick.hu@sifive=
.com/T/#u
> Signed-off-by: Nick Hu <nick.hu@sifive.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  drivers/clocksource/timer-riscv.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/time=
r-riscv.c
> index 48ce50c5f5e6..166dee14e46b 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -127,6 +127,12 @@ static int riscv_timer_starting_cpu(unsigned int cpu=
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
> +
>         return 0;
>  }
>
> --
> 2.34.1
>

