Return-Path: <linux-pm+bounces-29043-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9256BADFD24
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 07:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E704F7A50BA
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 05:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCE6243958;
	Thu, 19 Jun 2025 05:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldCsBguG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78674242907;
	Thu, 19 Jun 2025 05:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750311966; cv=none; b=YtRnPl0RsWGNISKnGTVPzXysHx2pG/rUj+OpHPOwXghydyjdPUAo/sRRSlK/4UiS3zSNy0N8ggLER7PNmPit22qGq2igi1RpxXhN6CNqie4WH5vd30yiSXqDl6Ns7B43NuwwT1zD6R8u3iu79WLmnTSWPxsIIEwadS9wv5hNPDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750311966; c=relaxed/simple;
	bh=iKxpVFHCvmLo55+wb51riJhzDaDVFQPCtKeGf70i6D4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LKegK9popfiEdhDdQl+10Cdq6cTzI6PUPoATN+ugIQfVhEdsMO8a6KJ+b2EEoWxu58qGD+mS2vJ4FbAiqsrRjh2N/wRJGA9qNZ0U3MQWGWRmH5Ihtut/KtWNc6Qw0VhkzmEPChSPff/gYHnOQhNT8cRJdlxXW/gna+FrA/+WvmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldCsBguG; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad8a8da2376so53728466b.3;
        Wed, 18 Jun 2025 22:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750311963; x=1750916763; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rKAUYboHkuuwUmlAEHIaacn6NB6oYrxQ9WGKRISWuqk=;
        b=ldCsBguGGGYL9xFE+WEn44bcH4wne2TAf3ezjQ72O9a+PCxHzPch5+D3taV3y6KvCW
         5eTsofOYthLEM4p6VkJ0xb9QHciuOauxMhkNIrItwhQ/8LGTrJQHYa4AXI1r7lisTuMx
         idHgHFqP7XR4pguABLYzhgsBaj9HM36cgrG/hU7iDwOZH6Cs6hc1c1cY6rUsHPeUT//8
         EAbAd1/csOMG34tCATRM6SFoOKR/1xNDCSi1GLKHAk6aOS0zMHCi9enlIXWSXkQC1sXN
         z3s3qABUeTltAmjABIK5LV3QprwMNLSTmGOmHHuFeureo0mIGK1ygClWsLptj02WR1l5
         wReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750311963; x=1750916763;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rKAUYboHkuuwUmlAEHIaacn6NB6oYrxQ9WGKRISWuqk=;
        b=KZZb4M9yVWsrqsUfefFdJfY+NH2fTPq6JHuZv9jSlsU6iQuq4il4KMFUrG0rsP/sex
         XLQ/qS3toNln+8+/xZYerr+kGNNtnbRuZS87CatFoipRbkIMrP355OWkqhVWVpgepSJh
         fMEkdq0u88OUrOEz97pzT/uSJ0EYzxQkCrWXquwVegaLsQOSbNqJLNO1hoPeL6IsaAHC
         tpFdemRS9LVbgQve+qkzmXdCARWWpk6t/6c0+szSpf2PxoAJS+XR5u/tksBYhnntDhoa
         S+ZEGzHdjtNFRRk8S8qdiGo1+HWNnffNXTT8IddTe/ebzpqLNrpTJVADRg84U+p+R/Q0
         b7Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUeNKM2YvMjEph/yv4XBXZVX5xO9AZB9tzhZ/X5mM7h4YwMMrqYWRrAUs3z9Feg2w7uIUNAFiZd6iNRqWk=@vger.kernel.org, AJvYcCXUDEzQpcTbSeYrzFdp8bj+iVquo9qFJqGKB0TweRINVsbdilSj11i0OIWliGtnicfPdv+OukwDc9U=@vger.kernel.org, AJvYcCXlXuecJjML8ksF7BWSEPGa9DM8Ojo+h2C3xVHCfDaJDsI9EyvtvHbnB3LMFf0dtq7VvOqK50wt4WoLxf59WpGLgBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKtc7dq6eiKPcO01KrBYH2DnNqKUgeuKxNn1Bz3/cPvK5ky6TK
	N1KMNjvnqcMXtXUzV80ignWO/nxKOxeHsqbwOgshXnc/TkN+MDG80eOwKKt99N+1RK2Fi+MnLym
	2jx81RR4Xbto7wkl3dqe6N4EIs9UKEa4=
X-Gm-Gg: ASbGncuSMiI7GVs+q3qOl2z0jAQYLM9SZnAewSRYdTmjJJHI4DE7Nm1axbNuPVaWlFk
	RiC9OHIhUP+ctvcsr7/0k/DyDjD83l49BV8lqUGW2+kVp0r6HWvVY+g9lWN1EqJmc3dCtthTNxw
	VizP60CKEi85qBvU1Yc33xd0dchp3wuhqdgn6OgV73Kw==
X-Google-Smtp-Source: AGHT+IHqjpV+nZYSmGvYxmGFNRO50Tri+Llb+PMo2Om+LTMx4zqLyhSevKBPdts3VbuB6zf8mJvTk3wNS+h3GEbuDQI=
X-Received: by 2002:a17:907:3d8b:b0:ad2:43b6:dd75 with SMTP id
 a640c23a62f3a-adfad2a1ff8mr1916244766b.10.1750311962730; Wed, 18 Jun 2025
 22:46:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250618115220eucas1p2b9d37e8cdd1997fa010f51cecdea5e4f@eucas1p2.samsung.com>
 <20250616163831.8138-3-linux.amoon@gmail.com> <20250618115211.2239335-1-m.majewski2@samsung.com>
In-Reply-To: <20250618115211.2239335-1-m.majewski2@samsung.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 19 Jun 2025 11:15:44 +0530
X-Gm-Features: AX0GCFvmk_wGVlRXfnhPM_Q_4DB5diREj6R5zYA0aszITzoiDTH5uE97mHC1m7Y
Message-ID: <CANAwSgRV=JT+qdAN=M46CZdWaSZnjazdw66fQETw7HeEcLSx8A@mail.gmail.com>
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

On Wed, 18 Jun 2025 at 17:22, Mateusz Majewski <m.majewski2@samsung.com> wrote:
>
> Hello :)
>
> > +#define INTSTAT_FALL2        BIT(24)
> > +#define INTSTAT_FALL1        BIT(20)
> > +#define INTSTAT_FALL0        BIT(16)
> > +#define INTSTAT_RISE2        BIT(8)
> > +#define INTSTAT_RISE1        BIT(4)
> > +#define INTSTAT_RISE0        BIT(0)
> > +
> > +#define INTCLEAR_FALL2       BIT(24)
> > +#define INTCLEAR_FALL1       BIT(20)
> > +#define INTCLEAR_FALL0       BIT(16)
> > +#define INTCLEAR_RISE2       BIT(8)
> > +#define INTCLEAR_RISE1       BIT(4)
> > +#define INTCLEAR_RISE0       BIT(0)
>
> > +     /* Map INTSTAT bits to INTCLEAR bits */
> > +     if (val_irq & INTSTAT_FALL2)
> > +             clearirq |= INTCLEAR_FALL2;
> > +     else if (val_irq & INTSTAT_FALL1)
> > +             clearirq |= INTCLEAR_FALL1;
> > +     else if (val_irq & INTSTAT_FALL0)
> > +             clearirq |= INTCLEAR_FALL0;
> > +     else if (val_irq & INTSTAT_RISE2)
> > +             clearirq |= INTCLEAR_RISE2;
> > +     else if (val_irq & INTSTAT_RISE1)
> > +             clearirq |= INTCLEAR_RISE1;
> > +     else if (val_irq & INTSTAT_RISE0)
> > +             clearirq |= INTCLEAR_RISE0;
>
> This implies that only these 6 bits are used. Is this true for all SoCs
> supported by this driver? My understanding is that Exynos 5433 in particular
> uses bits 7:0 for rise interrupts and 23:16 for fall interrupts. When I tested
> this patch (both alone and the whole series) on 5433 by running some CPU load,
> the interrupt seemed to not fire consistently:
> /sys/class/thermal/cooling_device1/cur_state would never go above 1 (which is
> consistent with the interrupt firing once, not getting cleared and never firing
> again; without this patch, it consistently went up to 6) and I got a quick
> reboot every time.
>
Thanks for the feedback,

As per the user manual Exynos4412
INTSTAT and INTCLEAR have a clear mapping with bits
falling 20, 16, 12 and rising 8 4 0

whereas Exyno5422 has
INTSTAT and INTCLEAR have a clear mapping with bits
falling 24, 20, 16, and rising 8 4 0

Yes, it could differ for all the SoCs,
I don't have the user manual or TRM for these SoCs
to configure correctly.

I tried to configure this, referring to the comment in the driver
        /*
         * Clear the interrupts.  Please note that the documentation for
         * Exynos3250, Exynos4412, Exynos5250 and Exynos5260 incorrectly
         * states that INTCLEAR register has a different placing of bits
         * responsible for FALL IRQs than INTSTAT register.  Exynos5420
         * and Exynos5440 documentation is correct (Exynos4210 doesn't
         * support FALL IRQs at all).
         */

By the way, I don't see Exynos5433 and Exynos7 support
INTSTAT and INTCLEAR registers. We are using TMU_REG_INTPEND
 to read and update the same register.

        if (data->soc == SOC_ARCH_EXYNOS5260) {
                tmu_intstat = EXYNOS5260_TMU_REG_INTSTAT;
                tmu_intclear = EXYNOS5260_TMU_REG_INTCLEAR;
        } else if (data->soc == SOC_ARCH_EXYNOS7) {
                tmu_intstat = EXYNOS7_TMU_REG_INTPEND;
                tmu_intclear = EXYNOS7_TMU_REG_INTPEND;
        } else if (data->soc == SOC_ARCH_EXYNOS5433) {
                tmu_intstat = EXYNOS5433_TMU_REG_INTPEND;
                tmu_intclear = EXYNOS5433_TMU_REG_INTPEND;
        } else {
                tmu_intstat = EXYNOS_TMU_REG_INTSTAT;
                tmu_intclear = EXYNOS_TMU_REG_INTCLEAR;
        }

> Thank you,
> Mateusz Majewski
Thanks
Anand

