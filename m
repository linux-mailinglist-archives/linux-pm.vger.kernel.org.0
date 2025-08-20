Return-Path: <linux-pm+bounces-32714-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D57EB2DDC9
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 15:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 217E64E1C4E
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 13:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB15331E119;
	Wed, 20 Aug 2025 13:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMAuJjhz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE05F31DDAF;
	Wed, 20 Aug 2025 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755696544; cv=none; b=dn2E4QBXnvG4OxKCNjQ21vjSyW+dJ7C2b+RscEy6+oMIWnaoObBnw6Qymw6uZVPyraFZShhzoL0R2bL4GvuEjBj8cQlS2l3VpZDhUyqljxT2Oap2cB8pmfwOdH51jA/q7QhMpUXqqyEnyx0aaS0MAxQifQILftUyDCzmqZVcUzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755696544; c=relaxed/simple;
	bh=AJIjVE+9x/GkFggg+E+VOL6kHUa36rZ+tFjynAzQJkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s90562Zn05XXVuHermmzFssZ8pwNGjo1YZZj4grNdjSd30TJXfNU8bvDmptzJAOwZD7Wl4sWpA/w3n/YVGq4heXBxHlpsC85TYSgtbi3bZF5xfDgLINIY9EqVzjiqVxFAIbTYZ/R9B3kkd6pICz81DdfioeBxu1P8xd30j8pHv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMAuJjhz; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61a8c134609so1844378a12.3;
        Wed, 20 Aug 2025 06:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755696541; x=1756301341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nVpFwznHMpNpqwkISsWqIDhkZo9GN/5f7ypKNFeZFY=;
        b=KMAuJjhzsKqBrT7Zs6umUyIpnKksnx+Hrjxdhz0VumhfKIkt964vOdW8tdJ4fXVAwR
         evGYY5gYH0IV/TbTQY2ZH6+8iMZEnya0bbMHLppCvzCroCEGgR60TrudtOHerKMCiINs
         +3X/tr/ewFyQ1rMtEr6SpGgzDlNg+/aq0LSdfmOgOrb1E3m52TJsIZGn7IuYXXcKLr9j
         4bNrUbzXqzPpLlZFcYxHPNB0xtG9ZYwuULc9HykAZ1TS/uRaHyA8/DOhwDVQk6StsrlT
         3L3m7MnbHXIZ1RqbaYa4rcGFN07XCTYTCgXS6wwMZeH+B4p+qT7xDjG+SOQ8hv0TPpfm
         rQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755696541; x=1756301341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nVpFwznHMpNpqwkISsWqIDhkZo9GN/5f7ypKNFeZFY=;
        b=YrBd50t2369CixJXYbsTWPy0tr9ELan8YmfKwxcYA+qwVNyPouyfsdJAHnliHvObAb
         VzexgBERAEep9lM0bIQfP7YYMdXBQewS20BVdEUCpM0q0uxh5ZIT2A2M21BZpiT6IAC8
         d5EurmP3KHKV9720ycaO9fu+SmDxCKmxnpWcEZJODBYKohqjKWUc/gNvBm/GMxHnU4aD
         n29OOj9u6uN078ateAfHjos4LzUXU3L1nahbFFvVXevH+B3hEQBJJsC7ZPqcrCOduOXL
         ym6FnTlIDlOuOcGXEOamVtuGirFhcsPC6tcZCNfd7VtGS58/HFyme/6psNssjw4B5l0e
         3qdA==
X-Forwarded-Encrypted: i=1; AJvYcCVAxK2GA5Mgub4/q2cigwXomSLl10/OmQ/TRKOipuq2aEW3APGU11HUkxqLkM1MB8lpkX4PuoWLUbE=@vger.kernel.org, AJvYcCWKTDLJZhK0Z7G2+K9IRsq01OddAHo4ty7vjtqRIOXbcTDvW4DYUvlR3XCPnnqNDTnIF7oN7Pa08I4jX7q1o2Epey0=@vger.kernel.org, AJvYcCWudSoMupLUk0RKtvSlvOlg4fQolAe2n3heE+BdNoA0KWgA9dac8sRbrRVxPynXKQ6vakhHTYzdxF2asCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk95NTWTkb1RGqYjwUqNXGrww6efGzOG0Y9tuJSettewAvMjyu
	q/EFCXUVN2BjMJZRDWOSEYwpGnHYLlR6+6yBdIvsc9q3mbGZG60FPOJ/oHRRR575urDIWS/JPCl
	PavRPWNilZCr6HtWftSLE7XODoLyBoHs=
X-Gm-Gg: ASbGncsNJprF+K7ot+ZOCRPoPXJlmVDect5cNG/b+FKghc+XP3gJFX304juqfuOY1sg
	CogGD4QT1hbDZqR9vSDC4QbdmbaWeNn7Rno4e1E6PFhuZ/FoPbrDX/MZ6AEn3xPX4UYM/UwEyAr
	lsOKWnuydYhPQKPXg4z9G/VdQ1Oh8i9ywyUuQnnXoMt6ti9AZT9KDdNlxYpspJJZTaiindoOugw
	Cto8g==
X-Google-Smtp-Source: AGHT+IE1YhFYDwX8RTFqCBvI/O0nzvU66srlAToMGQhCnvv7ApS2NTfh2GSqAw7utXfVWbtfNzrw3Bn9dL0oJJc7q1g=
X-Received: by 2002:a05:6402:460a:b0:612:b742:5bba with SMTP id
 4fb4d7f45d1cf-61a975521a9mr2385263a12.13.1755696540707; Wed, 20 Aug 2025
 06:29:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250819131732eucas1p26bd491e9b6b747a4857905bfd50420a9@eucas1p2.samsung.com>
 <20250813131007.343402-7-linux.amoon@gmail.com> <20250819131704.19780-1-m.majewski2@samsung.com>
In-Reply-To: <20250819131704.19780-1-m.majewski2@samsung.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 20 Aug 2025 18:58:43 +0530
X-Gm-Features: Ac12FXxJk9FiRDbaSI1KGn0qHUotnyfsd3cxseyNycA4dBDFvpr7OUkV8SN9KUE
Message-ID: <CANAwSgSjkP_wZ2Wvk1bZ2j6GHwAqEw1f5ZXLfQyEWgzcBzb6Mw@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] thermal/drivers/exynos: Handle temperature
 threshold IRQs with SoC-specific mapping
To: Mateusz Majewski <m.majewski2@samsung.com>
Cc: alim.akhtar@samsung.com, bzolnier@gmail.com, daniel.lezcano@linaro.org, 
	justinstitt@google.com, krzk@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, llvm@lists.linux.dev, lukasz.luba@arm.com, 
	morbo@google.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	rafael@kernel.org, rui.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mateusz,

Thanks for your review comments..

On Tue, 19 Aug 2025 at 18:47, Mateusz Majewski <m.majewski2@samsung.com> wr=
ote:
>
> Hello :)
>
> > +/* Map Rise and Falling edges for IRQ Clean */
> > +struct tmu_irq_map {
> > +     u32 fall[3];
> > +     u32 rise[3];
> > +};
>
Ops, this is an overkill approach that could be simplified further.

static void exynos4412_tmu_clear_irqs(struct exynos_tmu_data *data)
{
        unsigned int val_irq, clear_irq =3D 0;
        u32 tmu_intstat =3D data->tmu_intstat;
        u32 tmu_intclear =3D data->tmu_intclear;
        static const u32 irq_bits[] =3D {
                BIT(0), BIT(4), BIT(8),   /* Rising edge */
                BIT(12), BIT(16), BIT(20) /* Falling edge */
        };

        val_irq =3D readl(data->base + tmu_intstat);

        /* Set SoC-specific interrupt bit mappings */
        for (int i =3D 0; i < ARRAY_SIZE(irq_bits); i++) {
                if (val_irq & irq_bits[i])
                        clear_irq |=3D irq_bits[i];
        }

        if (clear_irq)
                writel(clear_irq, data->base + tmu_intclear);
}

> Hmm, we can probably get away with less interrupts. We actually only
> enable one fall interrupt in tmu_set_low_temp and one rise interrupt in
> tmu_set_high_temp.

Got it =E2=80=94 we need to enable INTEN for both rising and falling edges,
specific to each SoC.
So each SoC has a one-to-one mapping of INTEN with INTSTAT and INTCLEAR bit=
s
for rising and falling edge detection:.

Exynos4412
   Falling edge: bits 20, 16, 12
   Rising edge: bits 8, 4, 0
Exynos5422
  Falling edge: bits 24, 20, 16
  Rising edge: bits 8, 4, 0
Exynos5433
  Falling edge: bits 23, 17, 16
  Rising edge: bits 7, 1, 0

So we need to enable INTEN like below.

 static void exynos4412_tmu_set_low_temp(struct exynos_tmu_data *data, u8 t=
emp)
 {
        exynos_tmu_update_temp(data, EXYNOS_THD_TEMP_FALL, 0, temp);
-       exynos_tmu_update_bit(data, EXYNOS_TMU_REG_INTEN,
-                             EXYNOS_TMU_INTEN_FALL0_SHIFT, true);
+       for (int i =3D 0; i < 3; i++)
+               exynos_tmu_update_bit(data, EXYNOS_TMU_REG_INTEN,
+                                     EXYNOS_TMU_INTEN_FALL0_SHIFT + i
* 4, true);
 }

 static void exynos4412_tmu_set_high_temp(struct exynos_tmu_data *data, u8 =
temp)
 {
        exynos_tmu_update_temp(data, EXYNOS_THD_TEMP_RISE, 8, temp);
-       exynos_tmu_update_bit(data, EXYNOS_TMU_REG_INTEN,
-                             EXYNOS_TMU_INTEN_RISE0_SHIFT + 4, true);
+       for (int i =3D 0; i < 3; i++)
+               exynos_tmu_update_bit(data, EXYNOS_TMU_REG_INTEN,
+                             EXYNOS_TMU_INTEN_RISE0_SHIFT + 1 * 4, true);
 }

>
> Regarding tmu_set_crit_temp, on SoCs that have hardware thermal tripping
> there is nothing to clear. On others we will reboot immediately anyway,
> though maybe there is nothing wrong with clearing the interrupt
> beforehand? Regardless of this, there is only a rise critical
> temperature interrupt, we never set a matching fall interrupt.
>
As per my understanding, it depends on the calibration consists of reading =
the
measured data from e-fuse and wrote the calibrated threshold temperature to
generate interrupts into trigger level 0-3

THRES_TEMP_RISE and THRES_TEMP_FALL.

When the current temperature exceeds a threshold rise temperature,
 then it generates the corresponding interrupt (INTREQ_RISE[2:0]).
When the current temperature goes below a threshold fall temperature, t
hen it generates a corresponding interrupt (INTREQ_FALL[2:0].

It also depends on the sample interval

> Maybe it would also be good to add a bool to this struct containing
> information about whether a fall interrupt is in use, and reuse
> the same logic for 4210?
>
> (Nitpick: I am not a native speaker of English, but I think "clean" and
> "clear" have slightly different meanings, and the rest of the code
> consistently uses "clear", so it would be worthwhile to also use "clear"
> here.)
>
> > +             break;
>
> Maybe put irq_map inside exynos_tmu_data? exynos_map_dt_data has a
> switch block that is quite similar, in that it also matches on the SoC
> type. This way also there is no need to have a fallback.
>
I want to avoid this If you have any design feedback, plz let me know.

I had attempted to refactor exynos_tmu_data by splitting it per-SoC,
assigning dedicated callback functions for each variant. The goal was
to eliminate
the need for data->soc checks and make the code more modular.
However, the approach didn=E2=80=99t work as expected=E2=80=94devm_thermal_=
of_zone_register()
wouldn=E2=80=99t bind the sensor-specific callbacks correctly.

static const struct thermal_zone_device_ops exynos_sensor_ops =3D {
.get_temp =3D exynos_get_temp,
.set_emul_temp =3D exynos_tmu_set_emulation,
.set_trips =3D exynos_set_trips,
};

> Kind regards,
> Mateusz Majewski

Thanks
-Anand

