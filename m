Return-Path: <linux-pm+bounces-29182-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D1FAE27B7
	for <lists+linux-pm@lfdr.de>; Sat, 21 Jun 2025 09:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA1DE3B5F0C
	for <lists+linux-pm@lfdr.de>; Sat, 21 Jun 2025 07:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745841C8629;
	Sat, 21 Jun 2025 07:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BV90p3g0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81AB1C861E;
	Sat, 21 Jun 2025 07:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750490259; cv=none; b=poz4e6k4lCzwbLwGw2fLzFnnNo+B4WQRqZ+v0zPz4UWW70YdGD+L0wCb0qHyjW4FfmSbsa7oV2E7J2stGM81g2I4Dl9pt9NpPPerTXufvUrmU2iofFDLAS1rb1BnNHrgbmILNXK/TP9qx9g3ehzheBbZn4uX8iPMYpakP0/hibc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750490259; c=relaxed/simple;
	bh=/YBYo23/zqVG/K6r+hmtEQmTWmEBC+Kjo6+ZSVqz07o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hhiY4xCZsR1iJlkDQvzSEAkVPi5nBJ+pFIdNU/SYX0Z/F5LufrUpHgja49JdyZUlCKuwyEq5i2IM5po017BKMiSnuVUzOtjyYt3NnNrJRWc0rIXTb9OtlM1ruzMBCCaKwYaH5JbON1NLHKz1baJL4TjYkH5+6OsR5s84QS7lh98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BV90p3g0; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-addda47ebeaso526466966b.1;
        Sat, 21 Jun 2025 00:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750490256; x=1751095056; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bo59aSl355A+wShZW/KV0Ru3ekeBmk5oXEnZ7H/l/wg=;
        b=BV90p3g0hABJpNGDwiV7k/T4Lj6X5APxBtLC2hY8fmFpWghN7GiyRhxXK3/b0vQDxf
         Hk3Df3AXakIC1bIOS3S/ANIdoSFU+MTa4UOl8bc3PiN8UsqnU8dAPSNoBLLFlHBKu0AV
         6LRI1SryYP53+JfsHNmFHJuMnsOc73QCTvn1VHx2I4g1ap7iBjzNMr41Csx+3mZUDdJ0
         TppPDSVOjrl/luqNKR8eOB0OVgZgAY4iBQCo4H4IF1bgyHm5NVlgo3TCE04sy+b++dK5
         42crN0+FnwipvgIhLoTAi5xq/C4RuAd5voYJjLh9/5SttHJIAT6X5KD7z5xevTQtz48R
         PoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750490256; x=1751095056;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bo59aSl355A+wShZW/KV0Ru3ekeBmk5oXEnZ7H/l/wg=;
        b=SpteDRHZZ13AE4qjYjrVvkiJTG+XxHVtdIL/9fIbslAxCU1kB+1ZWy+jxJCHxAD2yg
         BOcfoCrGz7F5W10G3bfJ9SuuDS4AX1Y6Cg7yDl6N0H48WZlhDGYLY7CTkhb776KK0zi1
         vcFVQ2/8Pxi8B91Bcog129Gtfyo1RjLfXT+GiFRyUHafse9lr/94qhbk72iITk3hDHrF
         J+xoZMGU3O3bTBccBIyFWLWLTZnbTIt1mPL++pfunhb5tmf65Zjbwk1KsxmOFiCH1o3p
         vU6XBCDQBoXujGsdWm+j16AwE0Q/Eb6/4YXQcstDqXiXw2e5w/QUsaPLhfZQ1D4p06KZ
         ExAw==
X-Forwarded-Encrypted: i=1; AJvYcCUtbLv64YxGAVzHRUin/IhpL4vFnWvqkMRUPF26SttXYot9EsROhhZucIGhevZ/zosbY/AOdQlYFZbzHCQ=@vger.kernel.org, AJvYcCWDmGewBOlyLa8FagjULFJzLfKV7ARXmc8OumcwKtLBr+vybQCyKs4qf6BC54VxGM0rEg1wU3y58Vk=@vger.kernel.org, AJvYcCWvqBsQcqndUNuGVcTgcp/aI/4Po/cXVK/yrLSXk6Yvho6+EccjiyboWPgEW9jEvvf5oM2SV+NEU/0C0UQFZ2DKdhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YylY6bQp5MOuvkGM28+jsfuqSy+dIO/Chi6wg8UwvRPpKkKWGmG
	cbBYlH2wFuuibSmUK+Ib7T47OwDhp9chUV8O66flZ1lQSj1t7mTJgOZrjB1PdqeVJnVfrp2wxE0
	qZsrHgZg5AgP7LFsCKOhmrXWKs6d5bNU=
X-Gm-Gg: ASbGncujG+u2+75ghP29hT8SrCifML6XKJYazFHYkpkGN+/vkxO+d8dzQSpzeKA3bYJ
	f0EZU1UJrz0cxIlHvLf7dPetcM5SRKdw1zAGYTVqy59BMFb5SXClgU+R0fGYiwOEZBHFBdpgxrw
	i440bGi/KYDpRKn9UVWELM9dQBkxdk86q6ESjMDFVMaQ==
X-Google-Smtp-Source: AGHT+IFJDhovq12Hf4eA4SNosqcCft5uT2vIt6ARrg45/n4N8HVFpkpi6/xoPTExRyFmBOJk7i7Y6xznFo8rDhMVMXI=
X-Received: by 2002:a17:907:3d86:b0:ad5:8412:1c9 with SMTP id
 a640c23a62f3a-ae057c709afmr512391466b.59.1750490255672; Sat, 21 Jun 2025
 00:17:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250618125812eucas1p11a1ab5210d4efa95a51b3bc7c4f0924d@eucas1p1.samsung.com>
 <20250616163831.8138-2-linux.amoon@gmail.com> <20250618125806.2260184-1-m.majewski2@samsung.com>
 <CANAwSgQ-NFBtUareFmRzNVuKTSC8Vp7HTA0psBqYu2r=aqAGxg@mail.gmail.com>
In-Reply-To: <CANAwSgQ-NFBtUareFmRzNVuKTSC8Vp7HTA0psBqYu2r=aqAGxg@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 21 Jun 2025 12:47:17 +0530
X-Gm-Features: Ac12FXx6b9_Iy6FveNsY4BBaQRZfx2OrqYMft6MDANpLfMD2oPkqTyGtIAq5PSo
Message-ID: <CANAwSgTBzpL+XMJGhG=38A7GOzeayZaG_2LTvsaE2=mF-pn5mg@mail.gmail.com>
Subject: Re: [RRC v1 1/3] thermal/drivers/exynos: Remove unused base_second
 mapping and references
To: Mateusz Majewski <m.majewski2@samsung.com>
Cc: alim.akhtar@samsung.com, bzolnier@gmail.com, daniel.lezcano@linaro.org, 
	krzk@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	rui.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"

Hi Mateusz

On Thu, 19 Jun 2025 at 11:15, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Mateusz,
>
> On Wed, 18 Jun 2025 at 18:28, Mateusz Majewski <m.majewski2@samsung.com> wrote:
> >
> > >       /* On exynos5420 the triminfo register is in the shared space */
> > > -     if (data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO)
> > > -             trim_info = readl(data->base_second + EXYNOS_TMU_REG_TRIMINFO);
> > > -     else
> > > +     if (data->soc == SOC_ARCH_EXYNOS5420 ||
> > > +                     data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO) {
> > >               trim_info = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
> > > -
> > > -     sanitize_temp_error(data, trim_info);
> > > +             sanitize_temp_error(data, trim_info);
> > > +     }
> >
> > If I understand correctly, this means that the triminfo will no longer
> > be read on other SoCs calling this function (3250, 4412, 5250, 5260). Is
> > this intended?
> >
> Thanks for your feedback.
> I will remove the data->soc check for Exynos5420 in the next patch.

Can you check with with following changes

diff --git a/drivers/thermal/samsung/exynos_tmu.c
b/drivers/thermal/samsung/exynos_tmu.c
index 9fc085f4ea1a..0776801fafea 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -469,14 +469,11 @@ static void exynos4412_tmu_initialize(struct
platform_device *pdev)
                ctrl = readl(data->base + EXYNOS_TMU_TRIMINFO_CON2);
                ctrl |= EXYNOS_TRIMINFO_RELOAD_ENABLE;
                writel(ctrl, data->base + EXYNOS_TMU_TRIMINFO_CON2);
+               return;
        }

-       /* On exynos5420 the triminfo register is in the shared space */
-       if (data->soc == SOC_ARCH_EXYNOS5420 ||
-                       data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO) {
-               trim_info = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
-               sanitize_temp_error(data, trim_info);
-       }
+       trim_info = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
+       sanitize_temp_error(data, trim_info);
 }
>
> > By the way, are we sure that data->base_second really is unnecessary?
> > According to the bindings documentation (in
> > Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml),
> > the different address is necessary because the triminfo registers are
> > misplaced on 5420.
>
> As per my Exynos5422 user manual and DTS mapping
> thermal-sensor tmu@10060000 is mapped to CPU0 with tmu_apbif clock
> thermal-sensor tmu@10064000 is mapped to CPU1 with tmu_apbif clock
> thermal-sensor tmu@10068000 is mapped to CPU2 with tmu_apbif clock
> thermal-sensor tmu@1006c000 is mapped to CPU3 with tmu_apbif clock
> thermal-sensor tmu@100a0000 is mapped to GPU with tmu_triminfo_apbif clock.
>
> Well, we are using tmu_triminfo_apbif to configure clk_sec, which is
> using the data->base to enable the clk.
> So, data->base_second is not used any further in the code after we set triminfo

Thanks
Anand

