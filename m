Return-Path: <linux-pm+bounces-11348-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB6293A481
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 18:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83831F23DE9
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 16:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98E5157A61;
	Tue, 23 Jul 2024 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HKIt7X2k"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A4A155312
	for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2024 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721753267; cv=none; b=HF7JUzQ5qKKWS7OIHKRxdtCQLMu53IQZCDG2eMzxvuAzKVoN/5vPHAle5OfABZtBRoA1BYjUDr99OHV676qttETrBipdcWqzJ2p5npUMzv3KDTlBa9avGrSQwKkbtPfQgq2pcM0d8CD9uxM4xcA0YXDWKXr8Tj1FxE9YeNBMfCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721753267; c=relaxed/simple;
	bh=ovjQM5lG4ilTC+5F6TXGapRv5ns+z+SS4q+0grG1X+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W2n6kUiFdEkuQdeZTEw9cBfW4zTTwY6fY0XoBSRFj3pLntEfcJVrNmXj5pR1gOchHNJRFGvH5JfPrFEJHmiHAY/aaLRQJ/M4UlqHe1P7j3/JGviwo1Smu31NIWrIPiqHQTtZkWz2X0I8UIjOLE85rQ1GO6plRksHTJz9FrLA+wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HKIt7X2k; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-65cd720cee2so58413447b3.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2024 09:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721753265; x=1722358065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74HzxpSV7URZ5ukXyWUxMZBvB74HaX9SH0zHZjqujBk=;
        b=HKIt7X2kV20DKkFXix5pBj/bCISABpeab4X1Z0VcLOSFe4sDIBnD7XP0ijUNT/bZQ5
         dUPQIIuw71iEaAfXV6zA7DDWxoFIkzJD1+Hd6krdUhKZVMV5ypBzhU4MWGULqyPXDKnf
         PQNKLbUvsJ/BSqFPiwxiokWoUMpPFIeZKHpgxMeneeX9LXD8/fGZSCbTEsB6XNzwVtZa
         Hu6ONyKcRfD0pYOU1ZAXt0rxFTDokOf+zIUYiRWyCpPSX49k7zSEIKZ6n1KdeLrnPQXA
         oYtG9nW2oM2i9QZ6y7IqUI/bqAanhZ2y/7oj8jMIxGMKa7J84YIzOu2fhwds83Ot3pip
         J3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721753265; x=1722358065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74HzxpSV7URZ5ukXyWUxMZBvB74HaX9SH0zHZjqujBk=;
        b=j0OhZS+lIX+289R4dx+VLvAJqFzyZ2op6ut1wmAPIIUdWKF3AmgrLDZzCrggTpyGbp
         GwD1HWRUJLAkiPPAr7qm6uxipdn8D659lbIpxU8SFZ6JBqv0rqS2LS+wKB5489yFke5I
         gSMnjBuEHuJi8tnzWzLSDF4t/v+1403ecqbOKaMuAGIPEwf7jNu1hj5P6OtzKlQg3vL7
         MZE0Upw/IW9A+7SdzrEj1TGLM/BY6uE/X293XFE/u09q2PoZv+Yd3onXlKKKK1AkFilQ
         K3Lyb1tNR9v9XO8d5GSOdoP1+Ztou5K+Oam1TpnrwY4uDt7H9g9adXC/Pl1S+vQv4W89
         9+Fg==
X-Gm-Message-State: AOJu0YzJ0MYlYwPxklHqboJrS73Ybjhniv8RPjedd2scnapv7goAw6MN
	sVR74zisZ/ahRcuMTNgaNwQ+AQ21QUg8Vwpsqk41TkuSWrFHi3TvFctWvnQk+tux09xm1i+Xx8G
	L7NyDS0a113QLag6FfAgwcXK8VwXKBidoVDeo9Q==
X-Google-Smtp-Source: AGHT+IFNCdB6xhMgLIV6tTLbw7Kn49YzikMa5JepY3lzP+CVyBBnh+TeXodzPmrKVu+S0JqtiErgjD3DEMvkHBiHMwo=
X-Received: by 2002:a05:690c:dc7:b0:65b:a403:9eba with SMTP id
 00721157ae682-671f1098ee3mr3962687b3.11.1721753265081; Tue, 23 Jul 2024
 09:47:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240723141705eucas1p1bbe72a6d543031a41efdbe81d1b03ac3@eucas1p1.samsung.com>
 <CAPLW+4n6XB3fm8KQA=6_2z8ay9pDPtu-VFgAaW5imZkRH2ywkg@mail.gmail.com>
 <20240723141658.374755-1-m.majewski2@samsung.com> <CAPLW+4katjgDUS+e4+iYt+Cz_pKizLFUxqV4KGnbQ5ekAq9Mvw@mail.gmail.com>
In-Reply-To: <CAPLW+4katjgDUS+e4+iYt+Cz_pKizLFUxqV4KGnbQ5ekAq9Mvw@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 23 Jul 2024 11:47:34 -0500
Message-ID: <CAPLW+4nfEjP4FDjRJORyyKk46x4VfFAcMuK88jXUT_LJoP1N_g@mail.gmail.com>
Subject: Re: [PATCH 5/6] drivers/thermal/exynos: add initial Exynos 850 support
To: Mateusz Majewski <m.majewski2@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 10:23=E2=80=AFAM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
>
> On Tue, Jul 23, 2024 at 9:17=E2=80=AFAM Mateusz Majewski
> <m.majewski2@samsung.com> wrote:
> >
> > > Do you know what are the possible implications of not using ACPM? As =
I
> > > understand, ACPM is a Samsung's downstream framework which uses APM
> > > (Active Power Management) IP block internally to act as an IPC
> > > mechanism, which makes it possible to offload any PM related
> > > operations (which might get quite heavy, if we are to belive the TRM
> > > description of APM) from CPU to APM. I'm not against the direct
> > > registers access based implementation (in fact, I'm not sure how that
> > > APM/ACPM thing can be implemented in upstreamable way and if it's
> > > worth it at all). Just curious if we understand what we are
> > > potentially missing out, and if at some point we'll be forced to
> > > implement that ACPM thing anyway (for something else)?
> >
> > Not sure honestly. The downstream v4.10 driver does many operations on
> > registers anyway...?
> >
> > > Not sure if that's true, as already discussed in my comments for the
> > > previous patches. Looks like one clock is still needed, which is the
> > > PCLK bus clock (to interface registers) which might simultaneously ac=
t
> > > as an operating (functional) clock.
> >
> > The code seems to be working correctly without this clock, both registe=
r
> > reads and writes. Maybe the support for extra sensors, which I couldn't
> > get to work, would require this clock?
> >
>
> Chances are that clock was enabled by the bootloader for us (or it's
> just enabled by default) and it just keeps running. If that's so, I'd
> say it must be described in dts and controlled by the driver. Because
> otherwise it might get disabled at any point in future, e.g. kernel
> may disable it during startup as an unused clock (when it's added to
> the clock driver), etc. Let me enable that clock for you, and then you
> can use /sys/kernel/debug/clk/ files to disable it manually and see if
> it actually affects TMU driver.
>

Yeah, that clock is definitely needed. Just submitted the series [1]
adding it, which makes the kernel stuck on startup when your series is
applied. To fix that I added next lines to the TMU node in dts:

8<-------------------------------------------------------------------------=
-->8
     tmuctrl_0: tmu@10070000 {
         compatible =3D "samsung,exynos850-tmu";
         reg =3D <0x10070000 0x800>;
         interrupts =3D <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
+        clock-names =3D "tmu_apbif";
+        clocks =3D <&cmu_peri CLK_GOUT_BUSIF_TMU_PCLK>;
         #thermal-sensor-cells =3D <0>;
    };
8<-------------------------------------------------------------------------=
-->8

Please rework your patches to account for that required clock. Alas
the TMU dts changes can't be submitted until my series [1] is applied.
But you can still apply my series locally, and I think the driver and
bindings changes don't depend on that clock, so it should be ok to
send those

Thanks!

[1] https://lore.kernel.org/linux-samsung-soc/20240723163311.28654-2-semen.=
protsenko@linaro.org/T/#mf28e4aab0111b95479ef632bc1979dff93d28cc7

> > > Exynos850 TRM says AVG_CONTROL offset is 0x38, and 0x58 is actually
> > > for THRESHOLD0_TEMP_RISE3_2 register.
> >
> > Thank you so much! Will fix in v2. Though writing to the right place
> > doesn't seem to change much in practice, probably just means that the
> > correct mode is being used.
> >
> > > Something seems off to me here. How come the shift value for EXYNOS7
> > > case is 8, but the mask is actually 9 bits long? Does it mean the
> > > first error field is 8 bits long, and the second error field is 9 bit=
s
> > > long for EXYNOS7? I don't have the Exynos7 manual, so it's just a
> > > hunch. But if it's true, maybe this shift value has to be added in
> > > your [PATCH 2/6] to fix Exynos7 case?
> >
> > I did not really want to mess with Exynos7 code, as we don't have an
> > Exynos7 board sadly. Honestly I feel like I should drop the 2/6 patch
> > completely and only modify the code to run on 850 correctly.
> >
>
> It feels like there is an error for Exynos7 case there. Take a look at
> this commit:
>
>     aef27b658b43 ("thermal: exynos: use sanitize_temp_error() in
> exynos7_tmu_initialize()")
>
> I think that commit just forgets to update the shift value for Exynos7
> properly. This code:
>
>     data->temp_error1 =3D trim_info & tmu_temp_mask;
>     data->temp_error2 =3D ((trim_info >> EXYNOS_TRIMINFO_85_SHIFT) &
>                 EXYNOS_TMU_TEMP_MASK);
>
> in case of Exynos7 becomes:
>
>     data->temp_error1 =3D trim_info & 0x1ff;    // mask =3D 9 bits
>     data->temp_error2 =3D (trim_info >> 8) & 0xff;
>
> it contradicts itself, because it takes 9 rightmost bits for error1,
> and then uses 1 of those bits for error2 too. It's obvious that if 9
> bits are already used for error1, then for error2 it has to be shifted
> by 9 bits, not 8.
>
> That's why I think your patch 2/6 is legit and useful on its own, and
> it's actually a good catch on your part! But the shift value has to be
> fixed as well (for Exynos7). It's not ideal you don't have the
> hardware to test it, but it just screams *bug* to me :) Also, maybe we
> can ask someone who has Exynos7 hardware to test it for us?
>
> > > Also, just an idea: those values (and other similar values) could be
> > > pre-calculated somewhere during the probe, stored in some struct (e.g=
.
> > > _variant or _chip) and then just used here.
> >
> > sanitize_temp_error is only called one per probe and once per resume, s=
o
> > probably little to gain?
> >
>
> Sure, it was just a minor suggestion to make the code look more linear
> so to speak. It can be totally skipped.
>
> > Will also do all other.

