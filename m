Return-Path: <linux-pm+bounces-29609-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9022BAEA548
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 20:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181EA1C42811
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 18:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52E52EBDFF;
	Thu, 26 Jun 2025 18:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRStpjhZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A4F1F2BB8;
	Thu, 26 Jun 2025 18:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750962179; cv=none; b=u09vZJm9vegcvVtU20L6p7SDSWW4kEKZe8dr3ia2gpV2BREq0FVZDLyoXh+J36oOj55lrNsBPmGzbRuH6XM59qw/tUG4GJp+4nunuEKydG2+F8XNd7Ftffo3hQcINpDGEitt5ULsd5n6gjitg0rCytqUrxqTiMNtRymlDqvJ/DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750962179; c=relaxed/simple;
	bh=9ewmGMSIgXOVup07/pmbXzUq2WXDS5wKKrQ444icgyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qbcm6m7uRaY98GW6AfIq8rwMa2wgaYrxJXDzwJaI2s4A6VdBOHth2CFIZ7bcwAUbXG32DK86O1UvjrlRHzr10/wqFjQVS/BrBbG7fX7hiNHUyUbHLY2sPUz4d1c1EqHQEk0UKOpWcchkQOmm4TXiqy04mthBVxNR7+kymFhwmTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRStpjhZ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae223591067so51771066b.3;
        Thu, 26 Jun 2025 11:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750962176; x=1751566976; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2jjFd06z6IyDDI66ky5VMT2OuzWH5udSZsV9RTM3AcA=;
        b=gRStpjhZqIXWMAnBgdQUBJXmMgjF/6URhvrCwZ1mRZWtENOVNk78YHrAdovF50oeJ5
         B4M9rQVi/kcG/avFJNHAeIV7IK/KeoqA58Ce38UUtQlF6OfWe49LVk6a3h7zoXpCKfTM
         ZanLyqObAiaVx3ix675xhq+b+vRNAt+AqfQC0Ol5ktUBG/qTWHvosdPS4jhFtQ+Xplrm
         MeRP6YDsDx84SZUrPt7RkRDdTwfCegBwomLjRQtDcl+EupKJb93L4BkZGt3jth0WOjU5
         oDouDQ2x/D5gNWrb2F54kSmoWkTV0rhtFFT6dUtAGY2d922bH6HRqvKYEU3EICb5JHMW
         /z/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750962176; x=1751566976;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2jjFd06z6IyDDI66ky5VMT2OuzWH5udSZsV9RTM3AcA=;
        b=dG5kaszCRH1vG7r5Bq2pqIlJxIRXENjyqRIiGjWXJ9ELyKQ/DM0Nfw/c9TGlSumsFA
         S8n9ZrChvtM8i3Aep1q+g+FawVbFXeCDNRKgBmgzGtfRLtIYL7/K1x6cyiYeXGR++CH5
         TircsiYWYwux3L9zK13bB0Aux/0qERpaZ0vh1dfTaOzlYgbi8fo65JC+943WYnTaGKri
         DqQSpWB88ijN0/b/zfvJvoqyCvJUr4Obxls0slD5vQxbbWCd2rBk3bd6cCgOj0mTmex+
         XpmcJDoSHQuDjHVyzbKsF6VjVkzub8oG9U/85wYo+ArxbnHLIAP7z27+FfqeERG3bN/H
         /LdA==
X-Forwarded-Encrypted: i=1; AJvYcCUQdSlmw8bHhfBDxO0FiRapW/0SYemgrhTzg97w1JWVaYYJPAHjgskbttdu93Pv6rFaUzWPosuDZgk=@vger.kernel.org, AJvYcCWtsR3lYdf4T2lLwxHA/fpWd11A4v8iGN3oBS32dWt36T1ZFOyHH2zy3rNRiJ7gQMaltc3ATRrvKt9c7fQhYRuxOMo=@vger.kernel.org, AJvYcCXWIbY+/GKMHAqC5wLnatVNuzJxP/FPogQESJ5dKj5K8gAdF5g6ZAIVBx1vbYN7Coo7okXgZkJGvTADXb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJBK2mm2vpjKeTQLm8VYpQ9RA8Ifeu54YFOl+H0GL1OCc7ASi/
	TK3VTGT6rKwd+0ovKF+nh0UT/32RgZICvzJQpbqik/XFZ1T5rFWmVT1qesZZDKN1qQycFPVxALo
	9SsCAuhOSDcc4Y97bYksh9/AEo3Z0Vrk=
X-Gm-Gg: ASbGnct6SZGEe+dZJxmza6XEo6c5RVnIL3pa8nUNWN3nSRbxSMJqWZ9IJt5OC2O/BOi
	nPgYlPLwT8V2hoCmEhX7EFbbSgGYu62+wfQ7e48EQJRQ5B3PrRXbDd6b8+w9WMZ/0oFMRI/8Mme
	EHYGuTOLvC6skv4cCfpXZTTf0hM7TeOLDq2HcVlugj
X-Google-Smtp-Source: AGHT+IG/HBm4E++R0k9lVC/+RTAtOGgRPzPIB8sRecM543yqweD9y/t71VbdBQVT8JhWrXiQVwMv9oGAJcReShdI/Vc=
X-Received: by 2002:a17:907:d78b:b0:ae0:af6c:680 with SMTP id
 a640c23a62f3a-ae34fd3311fmr10304266b.2.1750962175894; Thu, 26 Jun 2025
 11:22:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250625143825eucas1p2e95ba80552cd289b6e05db33f32ec14a@eucas1p2.samsung.com>
 <CANAwSgTBzpL+XMJGhG=38A7GOzeayZaG_2LTvsaE2=mF-pn5mg@mail.gmail.com> <20250625143816.1146123-1-m.majewski2@samsung.com>
In-Reply-To: <20250625143816.1146123-1-m.majewski2@samsung.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 26 Jun 2025 23:52:38 +0530
X-Gm-Features: Ac12FXzSOcbN1qjL1eCS7VucajWs0aI1NpEXfUMgJBZoyRlg-bsb2m048szqtZE
Message-ID: <CANAwSgTdOyOxhBuFypyJpwjBVa+uKO9R3+6DMYOrnjsC5xvUZw@mail.gmail.com>
Subject: Re: [RRC v1 1/3] thermal/drivers/exynos: Remove unused base_second
 mapping and references
To: Mateusz Majewski <m.majewski2@samsung.com>
Cc: alim.akhtar@samsung.com, bzolnier@gmail.com, daniel.lezcano@linaro.org, 
	krzk@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	rui.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"

Hi Mateusz,

On Wed, 25 Jun 2025 at 20:08, Mateusz Majewski <m.majewski2@samsung.com> wrote:
>
> > Can you check with with following changes
> >
> > diff --git a/drivers/thermal/samsung/exynos_tmu.c
> > b/drivers/thermal/samsung/exynos_tmu.c
> > index 9fc085f4ea1a..0776801fafea 100644
> > --- a/drivers/thermal/samsung/exynos_tmu.c
> > +++ b/drivers/thermal/samsung/exynos_tmu.c
> > @@ -469,14 +469,11 @@ static void exynos4412_tmu_initialize(struct
> > platform_device *pdev)
> >         ctrl = readl(data->base + EXYNOS_TMU_TRIMINFO_CON2);
> >         ctrl = EXYNOS_TRIMINFO_RELOAD_ENABLE;
> >         writel(ctrl, data->base + EXYNOS_TMU_TRIMINFO_CON2);
> > +       return;
> >     }
> >
> > -   /* On exynos5420 the triminfo register is in the shared space */
> > -   if (data->soc == SOC_ARCH_EXYNOS5420
> > -           data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO) {
> > -       trim_info = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
> > -       sanitize_temp_error(data, trim_info);
> > -   }
> > +   trim_info = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
> > +   sanitize_temp_error(data, trim_info);
> > }
>
Thanks for the feedback,
> This does seem to work (tested on 3250 and on 5420) in the sense that I
> can read the temperatures, when they increase the state of the cooling
> device gets increased, and the values look reasonable and stay in a
> reasonable range. Hard to say if the trim and the temperature values are
> correct, though.
>
The driver should read the EXYNOS_TMU_REG_TRIMINFO register
after setting the RELOAD bit to 0x1 in the TRIMINFO_CONTROL (0x14) register.

RELOAD Trim information
Before read TRIMINFO, you shall set RELOAD to 1.
1 = Reload

> (FYI I will probably have a harder time regarding the drivers from
> GitHub you linked in 2/3, so no promises on testing them.)
>
It's just a reference point for gathering information - a few things
are missing in the driver.

> > As per my Exynos5422 user manual and DTS mapping
> > thermal-sensor tmu@10060000 is mapped to CPU0 with tmu_apbif clock
> > thermal-sensor tmu@10064000 is mapped to CPU1 with tmu_apbif clock
> > thermal-sensor tmu@10068000 is mapped to CPU2 with tmu_apbif clock
> > thermal-sensor tmu@1006c000 is mapped to CPU3 with tmu_apbif clock
> > thermal-sensor tmu@100a0000 is mapped to GPU with tmu_triminfo_apbif clock.
>
> Hmm, I might be missing something, but I think the DTS does link to two
> adresses and two clocks, for instance for GPU (in
> arch/arm/boot/dts/samsung/exynos5420.dtsi):
>
>                 tmu_gpu: tmu@100a0000 {
>                         compatible = "samsung,exynos5420-tmu-ext-triminfo";
>                         reg = <0x100a0000 0x100>, <0x10068000 0x4>;
>                         interrupts = <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
>                         clocks = <&clock CLK_TMU_GPU>, <&clock CLK_TMU>;
>                         clock-names = "tmu_apbif", "tmu_triminfo_apbif";
>                         #thermal-sensor-cells = <0>;
>                 };
>
> The manual does indeed not say anything about this, but I feel like the
> current code in essence states that the manual is not correct. We
> probably should have some evidence that the current code is wrong and
> the manual was correct all along?
Well, I tried to fix the DTS, but it didn't work.
>
> Thank you,
> Mateusz Majewski

Thanks
-Anand

