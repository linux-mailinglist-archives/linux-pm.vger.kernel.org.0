Return-Path: <linux-pm+bounces-29608-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D79AAEA540
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 20:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC3C16C262
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 18:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7E02264A0;
	Thu, 26 Jun 2025 18:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTB1GOsm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504F8339A8;
	Thu, 26 Jun 2025 18:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750962120; cv=none; b=Wz1uW5hiBxJjLAWZ0YpMYewNHvltb56HaSp1Gvi7lYr8eqsCCNzwcvxrHMb8t2FJcOA+uy91+kvyM+uC8s0YLhuU6MNPFtPryY9xeOWqGDfJmI5EJCOy9lfW+2782sUuE9BoBvCcZXjAvdS/dMI3hd9veYSpOf56V7qdXtGEx4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750962120; c=relaxed/simple;
	bh=6vq6JVu6NcqJTw809vRqKDMRA9357KPANxyf1TFbEx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W9OzIj36TWilVqwSn7HDCAOv6u8LPTJXA93IguoeYEF4JjtQk/29D263/Hq1OIJHr8spwSnxBJRgQ91nmPvosq61AoB6oWGM0EcTSge2yLlt0kBfePp4QA03zQu+mSzaO3Az2pbEh/Fs8TTHiWNgYR+JWT6lLKhD5j+Ciznqsyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTB1GOsm; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae0ccfd5ca5so218789766b.3;
        Thu, 26 Jun 2025 11:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750962116; x=1751566916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3+DMoHHGIgy/vebIi3Jk4k7xIG+hyANlJEXNLYgE3w=;
        b=OTB1GOsmlbI3BzPpoH1R7aG1w0UAPz0acgFttYN7kxYfUHJLkTDBy/JKvSe6ucgMXy
         XuwnAQI1tnhEzDGEjIaFSbgLfkFJlvWh9wekVgyciDQ47eipqsD2Q0WcIvnv1/Z4/sIm
         FAujXs7EcxshzL6GlAAQoz9iihmA/RAir1yHm/Jg0JMgwB1WQmpb9lZ1u0F7D0q9Vt5s
         xsjjzmSLvtV/LTh8w88V0ANUadbDQvqSb84KcdvzcyK7EbkjBdqs9Z/BHQjkI49zLgie
         A07E2TAJ6SJt6VaNYhy8ekTvItm0YCcg6hXwl7uy8gGvMcnAlo3pFjOaxDdndveYpvkN
         1v4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750962116; x=1751566916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3+DMoHHGIgy/vebIi3Jk4k7xIG+hyANlJEXNLYgE3w=;
        b=E7C1zQ6Nkk0Iskqfv4XDlOLApnNA2Zu+Te/bDcByo3j6sHKMbcxtZ3X5rkRsp/LEsl
         y5qLnRVir3elr32xX+Syi61+U5YvcwCUsQ7VFSwcts/KTtErLCZlCNyvLBv2CzfVAdFt
         GEj3dpvTaQG9AZSjCWDH1X0SVjZbbNSlUPIb53Vc4z/NbEI2ID3rjAlCjJevmUTEo0aI
         Mr+qBSeWUmXnORKhgyPawrU/D3gmbuLaZ63T2jm+IwkoIqaKGBwlYyU4gHcJzq1zQ7W6
         dfUZuLZvNtfGc4rRrVWeUv9PALvWZNAZcxNdbs+KAsBqqvI2N6wqipAtsJogShGFrbTe
         3PjA==
X-Forwarded-Encrypted: i=1; AJvYcCVO0aoMPM2ruep6MTKO9NfN+75neHREnHIzI7/SFfWmjFCjDttMV+EmnLN96IeiHbWZb6cenJC8uHTUWv9S4bYygqw=@vger.kernel.org, AJvYcCWMhJEYrPVzMQ/k272o2k1hg5ceBDdigOlvML/O0hU+nz1YLemr/3iCDre+4xrtNxeAJePpvpyR/Ee1uZc=@vger.kernel.org, AJvYcCWux2mB/mv/0QO7Kl7fBRBN7+k5WDp3Sh+WDADRBAdyWxIqs+m9gTFP+s62MJaMbLycVbyANv7sa24=@vger.kernel.org
X-Gm-Message-State: AOJu0YziW7xv8X23QakSdMm5xSPslohOw0RRF3ro/ZEuXIM3vxBupquy
	aIBy2XttblKVcRRy8fd01x4Sw2VZC/hxKSx9JXPK3cIbl5SqBiBcKW05gec0r4FvEv2j4eFFluc
	PUSp2siMp0lQ7u1OcLJ0oImW9A16MN+Y=
X-Gm-Gg: ASbGncsSxGVymhNSbc0xZnE4QFXsUA/4Ibjrkp+5bo3UbowP+iICnD8BmZ9avVSPJ/y
	D4y1AH7Wzc4rVp2iIftanqo5co5o2J4/TkPZD7N4cemKwLERr+TeDtRneB3yz9jD8Q9m28ZE7sV
	2zx5dLT7sNYbNGkpK7cjAGd0FsUvC56ACZ7Bmkrseh
X-Google-Smtp-Source: AGHT+IEsqtj8v2bEovOjiG46CLJ7UL5bwYCV8gHZttkfNpv1pJvRdrPCilDlgYCTp69vYR0Wg+ubr4UgooPkLo5BW/k=
X-Received: by 2002:a17:907:3da5:b0:ad8:9257:571b with SMTP id
 a640c23a62f3a-ae34fd3c530mr13268566b.16.1750962116235; Thu, 26 Jun 2025
 11:21:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250624075847eucas1p2db6e908f78aa603bdf6aec38b653e9af@eucas1p2.samsung.com>
 <CANAwSgQ=G1yJXOg1LdeEf-J56epyNiohCSdNYUvs2AHNv90Hkg@mail.gmail.com> <20250624075815.132207-1-m.majewski2@samsung.com>
In-Reply-To: <20250624075815.132207-1-m.majewski2@samsung.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 26 Jun 2025 23:51:38 +0530
X-Gm-Features: Ac12FXwpXJBzgkh-OwnIhYXUzqm4zOFzScYoLTs9xrNJZHdZ2chXs_WiTmxz6v0
Message-ID: <CANAwSgT2ROe77FVgk41s3xB-a+2SNwo5XWRZzrgxtC_SiooTXA@mail.gmail.com>
Subject: Re: [RRC v1 2/3] thermal/drivers/exynos: Handle temperature threshold
 interrupts and clear corresponding IRQs
To: Mateusz Majewski <m.majewski2@samsung.com>
Cc: alim.akhtar@samsung.com, bzolnier@gmail.com, daniel.lezcano@linaro.org, 
	krzk@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	rui.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mateusz

On Tue, 24 Jun 2025 at 13:28, Mateusz Majewski <m.majewski2@samsung.com> wr=
ote:
>
> > I tried to configure this, referring to the comment in the driver
> >         /*
> >          * Clear the interrupts.  Please note that the documentation fo=
r
> >          * Exynos3250, Exynos4412, Exynos5250 and Exynos5260 incorrectl=
y
> >          * states that INTCLEAR register has a different placing of bit=
s
> >          * responsible for FALL IRQs than INTSTAT register.  Exynos5420
> >          * and Exynos5440 documentation is correct (Exynos4210 doesn't
> >          * support FALL IRQs at all).
> >          */
> >
> > By the way, I don't see Exynos5433 and Exynos7 support
> > INTSTAT and INTCLEAR registers. We are using TMU_REG_INTPEND
> >  to read and update the same register.
> >
> >         if (data->soc =3D=3D SOC_ARCH_EXYNOS5260) {
> >                 tmu_intstat =3D EXYNOS5260_TMU_REG_INTSTAT;
> >                 tmu_intclear =3D EXYNOS5260_TMU_REG_INTCLEAR;
> >         } else if (data->soc =3D=3D SOC_ARCH_EXYNOS7) {
> >                 tmu_intstat =3D EXYNOS7_TMU_REG_INTPEND;
> >                 tmu_intclear =3D EXYNOS7_TMU_REG_INTPEND;
> >         } else if (data->soc =3D=3D SOC_ARCH_EXYNOS5433) {
> >                 tmu_intstat =3D EXYNOS5433_TMU_REG_INTPEND;
> >                 tmu_intclear =3D EXYNOS5433_TMU_REG_INTPEND;
> >         } else {
> >                 tmu_intstat =3D EXYNOS_TMU_REG_INTSTAT;
> >                 tmu_intclear =3D EXYNOS_TMU_REG_INTCLEAR;
> >         }
>
> My understanding of this comment and the situation in general is like
> this:
>
Thanks for clarifying this in such detail.
> 1. On 5420, whenever there is edge interrupt, no matter if rise or fall,
>    a bit gets set to 1 inside INTSTAT, and we clear it by setting the
>    same bit to 1 inside INTCLEAR. The current code does not rely on the
>    concrete bit index, it will just check the temperature after the
>    interrupt.
Correct
> 2. On 4210, there is no falling edge interrupts (so
>    exynos4210_tmu_set_low_temp is empty, we enable polling in DT etc).
>    This is what the "Exynos4210 doesn't support FALL IRQs at all" means.
>    However, rising edge interrupts work exactly the same as on 5420:
>    a bit gets set to 1 inside INTSTAT, and we clear it by setting the
>    same bit to 1 inside INTCLEAR.
For Exynos4210, I am skipping this in the next patch.
> 3. On 3250, 4412, 5250, 5260, it again works the same way as 5420.
>    However, somebody had a copy of documentation that was incorrect: it
>    said that bit indices does not match somehow, which is not true.

> 4. On 5433 and 7, it one more time works the same way as 5420, with a
>    single change: a bit gets set to 1 inside INTPEND, and we clear it
>    by setting it to 1 inside the same INTPEND.
>
> So, all we need to do to support existing SoCs is to read the 1 bit from
> one register, and set the bit with the same index in another register
> (which on some SoCs is the same register). We could interpret the index
> to see what kind of interrupt is this, but we read the temperature to
> get similar information.
>
> So in the end, is it helpful to interpret the INTSTAT bit index, only to
> reset the exact same index inside INTCLEAR? I guess it could be valuable
> if we also used the information about which interrupt it is and somehow
> used it elsewhere (which could actually help with some issues), but that
> is another thing to do.
>
correct.
> > If you have details on how INTSTAT and INTCLEAR are used
> > particularly regarding the update bits, please share them.
> > Specifically, I'm interested in how bits [7:0] correspond to rising edg=
e
> > interrupts and bits [23:16] to falling edge interrupts
> > I feel it's the same as Exynos54222.
>
> Regarding concrete indices on 5433:
> - the 0th bit corresponds to RISE0,
> - the 1st bit corresponds to RISE1,
> - ...
> - the 7th bit corresponds to RISE7,
> - the 16th bit corresponds to FALL0,
> - the 17th bit corresponds to FALL1,
> - ...
> - the 23th bit corresponds to FALL7.
>
Thanks, I will update this in the next version.

> That is probably because this SoC supports more interrupts than others.
> Though do note that currently, we only use part of them (one RISE, one
> FALL if supported, and another RISE for critical temperature (one
> supporting hardware thermal tripping if possible)). Also note that the
> indices in INTSTAT/INTCLEAR/INTPEND match the ones in INTEN, though I
> have not checked thoroughly if that is true for all the SoCs.
>
As per the manuals, we have to enable each corresponding bit for RISE and F=
ALL

INTEN          0x0070    Interrupt enable register
INTSTAT      0x0074    Interrupt status register
INTCLEAR   0x0078    Interrupt clear register

When current temperature exceeds a threshold rise temperature, then
it generates corresponding interrupt (INTREQ_RISE[2:0]).
When current temperature goes below a threshold fall temperature, then
it generates corresponding interrupt (INTREQ_FALL[2:0].

If we correctly configure the mapping of the RISE and FALL bits along with
INTEN, INTSTAT, and INTCLEAR, the interrupt behavior should function
as expected.

The following outlines the interrupt flow as described in the user manual

[1} https://usermanual.wiki/Document/Exynos20441220SCPUsers20ManualVer01000=
Preliminary0.167615881

/* Read the measured data from e-fuse */
Triminfo_25 =3D TRIMINFO[7:0]
/* Calibrated threshold temperature is written into THRES_TEMP_RISE
and THRES_TEMP_FALL */
/* Refer to 1.6.1 */
THRES_TEMP_RISE0 =3D 0x40;
THRES_TEMP_RISE1 =3D 0x50;
THRES_TEMP_RISE2 =3D 0x60;
THRES_TEMP_RISE3 =3D 0x70;
THRES_TEMP_FALL0 =3D 0x3A;
THRES_TEMP_FALL1 =3D 0x4A;
THRES_TEMP_FALL2 =3D 0x5A;
/* Parameter for sampling interval is set */
SAMPLING_INTERVAL =3D 0x1;
/* Interrupt enable */
INTEN[24] =3D0x1; // for INTEN_FALL2
INTEN[20] =3D0x1; // for INTEN_FALL1
INTEN[16] =3D0x1; // for INTEN_FALL0
INTEN[8] =3D0x1; // for INTEN_RISE2
INTEN[4] =3D0x1; // for INTEN_RISE1
INTEN[0] =3D0x1; // for INTEN_RISE0
/* Thermal tripping mode selection */
THERM_TRIP_MODE =3D 0x4;
/* Thermal tripping enable */
THERM_TRIP_EN =3D 0x1;
/* Check sensing operation is idle */
tmu_idle =3D 0;
while(tmu_idle&1) {
    tmu_idle =3D TMU_STATUS[0];
}
/* Start sensing operation */
TMU_CONTROL |=3D 1;

ISR_INTREQ_TMU () {
/* Read interrupt status register */
int_status =3D INTSTAT;
if(int_status[24]) {
    ISR_INT_FALL2();
}
else if(int_status[20]) {
    ISR_INT_FALL1();
}
else if(int_status[16]) {
    ISR_INT_FALL0();
}
Else if(int_status[8]) {
    ISR_INT_RISE2();
}
else if(int_status[4]) {
    ISR_INT_RISE1();
}
else if(int_status[0]) {
    ISR_INT_RISE0();
}
else {
    $display("Some error occurred..!");
}
ISR_INT0 () {
   /* Perform proper task for decrease temperature */
    INTCLEAR[0] =3D 0x1;
}

Hey, if you=E2=80=99ve got a bit of time, could you take a look at these ch=
anges?
[2]  https://lore.kernel.org/all/20250430123306.15072-2-linux.amoon@gmail.c=
om/


> Thank you,
> Mateusz Majewski
Thanks
-Anand

