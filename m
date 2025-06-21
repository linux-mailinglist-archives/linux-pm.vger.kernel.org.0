Return-Path: <linux-pm+bounces-29181-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA99AE27B4
	for <lists+linux-pm@lfdr.de>; Sat, 21 Jun 2025 09:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 159BA3AE2EE
	for <lists+linux-pm@lfdr.de>; Sat, 21 Jun 2025 07:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160DC1BD9CE;
	Sat, 21 Jun 2025 07:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7F5kWa+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38517196C7C;
	Sat, 21 Jun 2025 07:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750490235; cv=none; b=RY6TY5TdlEezJMW5E9wtUDIEtR4Ql4gNpEkVrrTDQ33FXirV/ye3ViTvZXxofziLGNLPrFon70E3JkpFxPc5kbdbXI9gHrTdOMM1Jgeim6yjRxCfntq3auUUGuJNJaz7WqrybiwIs+zFXAu4Ntk0lHIJW1MBIHnpOfCKIobvYn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750490235; c=relaxed/simple;
	bh=qCNENRpPK/5E6apfanAOWQrNPEygDkh+O7IA2Km3UOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i2XYimS0zOjSM6myduw7imAORoT+o9Fvb/pzFGM0C5Icp7oNGuGKbuLn1fWqjFSBuFKdT75OSxTkeitPvhGEX3/DBvkNTWuGFTAWdW43/R78KuSTOYyZwwOlJculK0Yftysg9C3KSyMZgIQY/xW0TQViGUjN/GNEEXXiWXK1F+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7F5kWa+; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-607cf70b00aso4514244a12.2;
        Sat, 21 Jun 2025 00:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750490231; x=1751095031; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/bcaFXfQWjofieOOSzrQZuk2N3r45IQ/D1htHwwGLOY=;
        b=M7F5kWa+u/tSy1gZv1MuXB2OUNqE58vVcnakfZNmmvUu9Syy5qnpuDNA4RB+2GDSlO
         n9yXy1zTkGvrp5Idmu2DPkQmZk3eRN1qdBdNWKS8t/zJfcTn5WvdMn8Dov+hrhBo26AT
         xHUAyBMcgQAdqNncIYhNILFlXCLRGzfDI58lYR7jzUYP1XTJRT9d1r3bWhFss3PPxkpe
         wU89bP5Gg2YvvG63226thoq9EIoCX/QIwZGSYw6Ny/aBrx4j4GxHsvGawTzWzpExJO7w
         aeuTIqyACHB4pZatNUyiXC7my9ku1a+Wjai/Ms6dsEmurwE4PWsadVYGchpucSLGyLke
         KfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750490231; x=1751095031;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/bcaFXfQWjofieOOSzrQZuk2N3r45IQ/D1htHwwGLOY=;
        b=dSU/LzATuezE/ewLoYJ/eb6XPWWgOu7DxOxd8OTpXl+jwbHuXMEbLuiSopFxGK1/Y2
         VTVMIMTC6yQ3SdkSsOpxelECTWvRo1vU0qgTeqgHSnbN9fdZ44apt31Xjf/X5C2MWJk9
         SW239ixL3tPoX6MEjgg2WgzL2xeGzfJaJ+Kwbo8BHVm86IBQtlm6ZoikJMgW3Sh/lwC8
         Tu9fLd3pMl+2uc1Tv/6nZGlGZfOusVzKPwX0HGyWg/ZEPLeK1MAintngZki2ZBPZkFJi
         Vu2WJUcTdCYGHEtfwxojdUhx3ohXbkTA7Q0kUKAMdmdFGJiWiK7bgfUwQ7IYlZH+TfZG
         zeiA==
X-Forwarded-Encrypted: i=1; AJvYcCWXAYALwtryshxZhl5p+qXWOEL9sKjothDFcUC7+OOr7owpGBELNcZw3WsyQ8tjVhdpd4FdPYRE5FDm+38=@vger.kernel.org, AJvYcCXG2VMpnYZIaPuxdPnIP1lb9iPC4Tz5z/JYvM+vG/AllIT4MzkBum3fcdJ8uBomfK/Zg6HMJCtl9Bo=@vger.kernel.org, AJvYcCXp5OK43wytdrQuzQVQ9ha/WuTP+tvLN4IP0f7eFiO9qLLmrBQOSlAuYTC7GFc0PSEZO/N6+p4AN8aKyAm712cGghc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAJxG66d7j8NAhFphpAd4bloKrz44PzZC+aMyTm7PDECHuVlTR
	Pe/YHtrdUjRDhCFktKAd/7Sdhzi3cv1X6ST1idg5WDDINQyC1GHQB+WJhwNF3frRz9UioGVuJxN
	DJKb0T8uRKV+9NnFB7F0xzSbIvlAG/l4=
X-Gm-Gg: ASbGnctJ0vGyRUSHX+UmMS1q+Ia6kbOxtjCSj6qVf6+DMJkdRY+4UUJOG+m3yQnoH8j
	i909ziqkiNX4DI/74WAtu7FO3ku+qs/7c9rPyszAx+qeEYHzu/Lxq6W3aB71gfaxcOmLuzczRnu
	tJUXOnlKSca8YZuDpdWmZv9bru4P+OjFkJLj/jP7F4DA==
X-Google-Smtp-Source: AGHT+IH66doWMpGtWOMFqbeLqscHl6eWKJT3vUmx953SEzxCv+zBCKw7VBGa8S2Rn8h7FbOcfjnLkvGiGRemhUti3i0=
X-Received: by 2002:a17:906:30cb:b0:ad2:4da6:f58c with SMTP id
 a640c23a62f3a-ae057bdea98mr459148666b.46.1750490231238; Sat, 21 Jun 2025
 00:17:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250618115220eucas1p2b9d37e8cdd1997fa010f51cecdea5e4f@eucas1p2.samsung.com>
 <20250616163831.8138-3-linux.amoon@gmail.com> <20250618115211.2239335-1-m.majewski2@samsung.com>
 <CANAwSgRV=JT+qdAN=M46CZdWaSZnjazdw66fQETw7HeEcLSx8A@mail.gmail.com>
In-Reply-To: <CANAwSgRV=JT+qdAN=M46CZdWaSZnjazdw66fQETw7HeEcLSx8A@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 21 Jun 2025 12:46:53 +0530
X-Gm-Features: Ac12FXyDzDmafHO30O7tOj_g1UTTGVYFB7ldEiK1JVaf1dtCf3kj-sESMmUqQko
Message-ID: <CANAwSgQ=G1yJXOg1LdeEf-J56epyNiohCSdNYUvs2AHNv90Hkg@mail.gmail.com>
Subject: Re: [RRC v1 2/3] thermal/drivers/exynos: Handle temperature threshold
 interrupts and clear corresponding IRQs
To: Mateusz Majewski <m.majewski2@samsung.com>
Cc: alim.akhtar@samsung.com, bzolnier@gmail.com, daniel.lezcano@linaro.org, 
	krzk@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	rui.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"

Hi Mateusz,

On Thu, 19 Jun 2025 at 11:15, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Mateusz,
>
> On Wed, 18 Jun 2025 at 17:22, Mateusz Majewski <m.majewski2@samsung.com> wrote:
> >
> > Hello :)
> >
> > > +#define INTSTAT_FALL2        BIT(24)
> > > +#define INTSTAT_FALL1        BIT(20)
> > > +#define INTSTAT_FALL0        BIT(16)
> > > +#define INTSTAT_RISE2        BIT(8)
> > > +#define INTSTAT_RISE1        BIT(4)
> > > +#define INTSTAT_RISE0        BIT(0)
> > > +
> > > +#define INTCLEAR_FALL2       BIT(24)
> > > +#define INTCLEAR_FALL1       BIT(20)
> > > +#define INTCLEAR_FALL0       BIT(16)
> > > +#define INTCLEAR_RISE2       BIT(8)
> > > +#define INTCLEAR_RISE1       BIT(4)
> > > +#define INTCLEAR_RISE0       BIT(0)
> >
> > > +     /* Map INTSTAT bits to INTCLEAR bits */
> > > +     if (val_irq & INTSTAT_FALL2)
> > > +             clearirq |= INTCLEAR_FALL2;
> > > +     else if (val_irq & INTSTAT_FALL1)
> > > +             clearirq |= INTCLEAR_FALL1;
> > > +     else if (val_irq & INTSTAT_FALL0)
> > > +             clearirq |= INTCLEAR_FALL0;
> > > +     else if (val_irq & INTSTAT_RISE2)
> > > +             clearirq |= INTCLEAR_RISE2;
> > > +     else if (val_irq & INTSTAT_RISE1)
> > > +             clearirq |= INTCLEAR_RISE1;
> > > +     else if (val_irq & INTSTAT_RISE0)
> > > +             clearirq |= INTCLEAR_RISE0;
> >
> > This implies that only these 6 bits are used. Is this true for all SoCs
> > supported by this driver? My understanding is that Exynos 5433 in particular
> > uses bits 7:0 for rise interrupts and 23:16 for fall interrupts. When I tested
> > this patch (both alone and the whole series) on 5433 by running some CPU load,
> > the interrupt seemed to not fire consistently:
> > /sys/class/thermal/cooling_device1/cur_state would never go above 1 (which is
> > consistent with the interrupt firing once, not getting cleared and never firing
> > again; without this patch, it consistently went up to 6) and I got a quick
> > reboot every time.
> >
> Thanks for the feedback,
>
> As per the user manual Exynos4412
> INTSTAT and INTCLEAR have a clear mapping with bits
> falling 20, 16, 12 and rising 8 4 0
>
> whereas Exyno5422 has
> INTSTAT and INTCLEAR have a clear mapping with bits
> falling 24, 20, 16, and rising 8 4 0
>
> Yes, it could differ for all the SoCs,
> I don't have the user manual or TRM for these SoCs
> to configure correctly.
>
> I tried to configure this, referring to the comment in the driver
>         /*
>          * Clear the interrupts.  Please note that the documentation for
>          * Exynos3250, Exynos4412, Exynos5250 and Exynos5260 incorrectly
>          * states that INTCLEAR register has a different placing of bits
>          * responsible for FALL IRQs than INTSTAT register.  Exynos5420
>          * and Exynos5440 documentation is correct (Exynos4210 doesn't
>          * support FALL IRQs at all).
>          */
>
> By the way, I don't see Exynos5433 and Exynos7 support
> INTSTAT and INTCLEAR registers. We are using TMU_REG_INTPEND
>  to read and update the same register.
>
>         if (data->soc == SOC_ARCH_EXYNOS5260) {
>                 tmu_intstat = EXYNOS5260_TMU_REG_INTSTAT;
>                 tmu_intclear = EXYNOS5260_TMU_REG_INTCLEAR;
>         } else if (data->soc == SOC_ARCH_EXYNOS7) {
>                 tmu_intstat = EXYNOS7_TMU_REG_INTPEND;
>                 tmu_intclear = EXYNOS7_TMU_REG_INTPEND;
>         } else if (data->soc == SOC_ARCH_EXYNOS5433) {
>                 tmu_intstat = EXYNOS5433_TMU_REG_INTPEND;
>                 tmu_intclear = EXYNOS5433_TMU_REG_INTPEND;
>         } else {
>                 tmu_intstat = EXYNOS_TMU_REG_INTSTAT;
>                 tmu_intclear = EXYNOS_TMU_REG_INTCLEAR;
>         }
>
I don't have Exynos  Arm64 boards to test on

I believe the Exynos5433 and Exynos7 also use the same
register addresses for INTSTAT and INTCLEAR.

[1] https://github.com/universal5433/android_kernel_samsung_universal5433/blob/lineage-18.1/drivers/thermal/exynos_thermal.c#L854-L892
[2] https://github.com/enesuzun2002/android_kernel_samsung_exynos7420/blob/nx-9.0/drivers/thermal/cal_tmu7420.c#L14-L221

If you have details on how INTSTAT and INTCLEAR are used
particularly regarding the update bits, please share them.
Specifically, I'm interested in how bits [7:0] correspond to rising edge
interrupts and bits [23:16] to falling edge interrupts
I feel it's the same as Exynos54222.

Can you test with these changes? If you have any suggestions,
please feel free to share them

Thanks
-Anand

