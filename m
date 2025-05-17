Return-Path: <linux-pm+bounces-27267-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8DAABAC23
	for <lists+linux-pm@lfdr.de>; Sat, 17 May 2025 21:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDEA63A5782
	for <lists+linux-pm@lfdr.de>; Sat, 17 May 2025 19:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC3420296F;
	Sat, 17 May 2025 19:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxIFaaK3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A541F4701;
	Sat, 17 May 2025 19:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747510888; cv=none; b=ZZmy7OlyXRLggxjeZvRhRBOVXNidqUETSgUtH6WcsmTz1lyrcyxbRtAmZXKaoKuIoHeNhw41PvQvzAGxcZ0lh5rgkhVry8/YmAgmZ/5fSg3KNTNJKRk5uPMiVZ0Mc64MKJ0J8DIkogN8/xKg0ZDnD5fTnAbKELBQSYvyjycJ4tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747510888; c=relaxed/simple;
	bh=xPLtXQunlgveTeRsuhOJV/+kOS5p9tvCwVH7pRipu2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oqj9CZ+Gt8/pMim2bq2/NgpeV3EzdtVDKXuKj25uzwhnm5Rq45WaGwj5uNcyXg1MYM7Q5DUwvKE5LBSs46Wq03rGkk1hAwmJBakgHF2pgtSlluIEcGGaFJcXqoyuxUofPhcjYByw4fm/hIsViR0uZFcTDhb9WCsV3dDpomA/Aaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxIFaaK3; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad1b94382b8so565368566b.0;
        Sat, 17 May 2025 12:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747510885; x=1748115685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOaJS8qDeTvR+yb6xG8mvyDJYIWOLLbeVsAQNEudTm4=;
        b=DxIFaaK3XVacrilsizoUAuoymcmx3ElePhRdb0htQ3Nic+2aFIZTmw8rDoEJx1/5bf
         l1dIhbgU0pnVeRuUrI2Q//jA9bYbWRnabPRxwtipPm6xwcUd39LuKuHDemFUX/5QYQjV
         L+BNU6OYGcbczJZTVn9H7ZYiEgOOGjoJLG3yuKRIkpCbltGy+5HuB3i0q3MiLPU1L7bu
         bUgZBePTV59lp/x1Go52czXyPI3v/4DjUoJgKPQTHOY2zwaB58a03eUi07X0Yl+6qIoj
         bOkbAZlUk83h/4cGuKK17FLn4iNru1Z62LA0rb7lt+0D69Lm/dReogQaUYCyy0xnFhtC
         wbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747510885; x=1748115685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOaJS8qDeTvR+yb6xG8mvyDJYIWOLLbeVsAQNEudTm4=;
        b=t7GxAXacVhD+KvEeiI9yx75Spz2uiUGakWjbL9jJMYzs46XKM2W1uzV1j99WTNe++f
         DRsP1Tr1g8zHbkWEv/q3OpJUNiTnM4ClXZZgolyAJz3IH9B0STWJ5hiupCqROuHH3CDh
         rTMTSmKLc5KkwnrmntLKhTQrvsf/tmhfcDV37q8HnPSp74BHeCu+lzikMReqwXxkkaHg
         NoYsvbJ8r9p0MMBRTkw7YzneoIYNHKNrzyqR2blCNIgpVt0i+yNfbQuBTVZY7rDQcsWH
         Lm46l9E9+LMb1vPbbdAaElzJbQxi4Y3FiEOtdDqk/V58C5jHL8eJmKlpkYHh8k3P+CS9
         uGAw==
X-Forwarded-Encrypted: i=1; AJvYcCUShzVi9trc7s6z2vQ16ejnkg8KSUWoynR30hPSqmfZgpv8yMEvm4eD0ibjL5gx1Sgk7Bowhqd5tms=@vger.kernel.org, AJvYcCVMsEuATK7C7LU8GGb1wq4FEhSJxNPjE21ewqBQy9lnNaU6sGMU0qyiixCC6xNaiUZcXomoksK3dDg8dzjJ6BdfRhA=@vger.kernel.org, AJvYcCVUcM3DG8UMGOPpCo2oblDb6afvVvMdQhdanmzE6yohLRnY/QJrXMAI2w8iVmaR4BDreZuenucxiVoDCZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNtLdFxiMXw/S/+uS+xZMfWEf7nI/tzdy40fJ073KOUayXKxq6
	k2grnnnaab3MD6/XIdgRfFVrvtyyaTlV6lAWF5UwtMhRVFXeD+5lmk4c+n/BAtnttbh2zxiHpbp
	ukn/AdYbYuvKNlrlY+S9AqjyL0wOknsI=
X-Gm-Gg: ASbGnctOrn5WGzDbzzDownOgdQzYVoG/wPEgQcb1o5Oms+I2n0odEae6gm8zFgoZxZT
	IIO/ntverju5NjMmlG8DHC/kP6VjHkPWOIlEC4iuIFVtzPYJ9n/617Uut6JPln8l690sApqrAAl
	qhAcE5MUkX5YDC4xR21dcpyKSjf60CKJE=
X-Google-Smtp-Source: AGHT+IG2h9FdAqyLAeDMlVgp77wyUY3I3sfyW0h4u8fCLKBnBw3n5d3cWdiSpQGUgrrGQ4d5vHrpjCNIEbTBvGh6C/I=
X-Received: by 2002:a17:907:74a:b0:ad2:43b6:dd6d with SMTP id
 a640c23a62f3a-ad52d45adddmr556931466b.12.1747510884424; Sat, 17 May 2025
 12:41:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430123306.15072-1-linux.amoon@gmail.com> <aCR9RzGMWEuI0pxS@mai.linaro.org>
 <CANAwSgSA-JHMRD7-19wijOY=TSWD-sv6yyrT=mH+wkUJuvxFAw@mail.gmail.com>
 <92c2949e-2fc1-40e9-9dea-e3d9f7aa571d@linaro.org> <CANAwSgQryVLdRVd9KRBnaUcjtX8xR9w9BBTCvoqKH6funkj=2A@mail.gmail.com>
 <3c44154c-7261-4b03-bd12-bddf4d493e74@linaro.org>
In-Reply-To: <3c44154c-7261-4b03-bd12-bddf4d493e74@linaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sun, 18 May 2025 01:11:07 +0530
X-Gm-Features: AX0GCFskBeR8WK9jkalSvJrYI5c9Nua4Ww8iaYWYJnYOXYU21l3OTo_PXNe7k2c
Message-ID: <CANAwSgRnRPb9kPT1rxHFUEvyzoCLTrD5JZVtLHZ9A6gV00dOCw@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Exynos Thermal code improvement
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	"open list:SAMSUNG THERMAL DRIVER" <linux-pm@vger.kernel.org>, 
	"open list:SAMSUNG THERMAL DRIVER" <linux-samsung-soc@vger.kernel.org>, 
	"moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Fri, 16 May 2025 at 20:15, Daniel Lezcano <daniel.lezcano@linaro.org> wr=
ote:
>
> On 5/15/25 20:01, Anand Moon wrote:
> > Hi Daniel,
> >
> > On Thu, 15 May 2025 at 18:59, Daniel Lezcano <daniel.lezcano@linaro.org=
> wrote:
> >>
> >> On 5/15/25 13:10, Anand Moon wrote:
> >>> Hi Daniel,
> >>>
> >>> On Wed, 14 May 2025 at 16:53, Daniel Lezcano <daniel.lezcano@linaro.o=
rg> wrote:
> >>>>
> >>>> On Wed, Apr 30, 2025 at 06:02:56PM +0530, Anand Moon wrote:
> >>>>> Hi All,
> >>>>
> >>>> Hi Anand,
> >>>>
> >>>> if the goal of the changes is to do cleanups, I recommend to rework
> >>>> how the code is organized. Instead of having the data->soc check all
> >>>> around the functions, write per platform functions and store them in
> >>>> struct of_device_id data field instead of the soc version.
> >>>>
> >>>> Basically get rid of exynos_map_dt_data by settings the different op=
s
> >>>> in a per platform structure.
> >>>>
> >>>> Then the initialization routine would be simpler to clean.
> >>>>
> >>>
> >>> Thanks, I had previously attempted this approach.
> >>> The goal is to split the exynos_tmu_data structure to accommodate
> >>> SoC-specific callbacks for initialization and configuration.
> >>>
> >>> In my earlier attempt, I tried to refactor the code to achieve this.
> >>> However, the main challenge I encountered was that the
> >>> exynos_sensor_ops weren=E2=80=99t being correctly mapped for each SoC=
.
> >>>
> >>> Some SoC have multiple sensor
> >>> exynos4x12
> >>>                       tmu: tmu@100c0000
> >>> exynos5420
> >>>                   tmu_cpu0: tmu@10060000
> >>>                   tmu_cpu1: tmu@10064000
> >>>                   tmu_cpu2: tmu@10068000
> >>>                   tmu_cpu3: tmu@1006c000
> >>>                   tmu_gpu: tmu@100a0000
> >>>    exynos5433
> >>>                   tmu_atlas0: tmu@10060000
> >>>                   tmu_atlas1: tmu@10068000
> >>>                   tmu_g3d: tmu@10070000
> >>> exynos7
> >>>                   tmu@10060000
> >>>
> >>> It could be a design issue of the structure.or some DTS issue.
> >>> So what I found in debugging it is not working correctly.
> >>>
> >>> static const struct thermal_zone_device_ops exynos_sensor_ops =3D {
> >>>           .get_temp =3D exynos_get_temp,
> >>>           .set_emul_temp =3D exynos_tmu_set_emulation,
> >>>           .set_trips =3D exynos_set_trips,
> >>> };
> >>>
> >>> The sensor callback will not return a valid pointer and soc id for th=
e get_temp.
> >>>
> >>> Here is my earlier version of local changes.
> >>> [1] https://pastebin.com/bbEP04Zh exynos_tmu.c
> >>> [2] https://pastebin.com/PzNz5yve Odroid U3 dmesg.log
> >>> [3] https://pastebin.com/4Yjt2d2u    Odroid Xu4 dmesg.log
> >>>
> >>> I want to re-model the structure to improve the code.
> >>> Once Its working condition I will send this for review.
> >>>
> >>> If you have some suggestions please let me know.
> >>
> >> I suggest to do the conversion step by step beginning by
> >> exynos4210_tmu_clear_irqs, then by exynos_map_dt_data as the first
> >> cleanup iteration
> >>
> > Ok you want IRQ handle per SoC call back functions?
> > so on all the changes depending on SoC id should be moved to
> > respective callback functions to reduce the code.
>
> I think you can keep the same irq handler function but move the
> tmu_intstat, tmu_intclear in the persoc structure and remove the
> exynos4210_tmu_clear_irqs function.
>
> You should end up with something like:
>
> static irqreturn_t exynos_tmu_threaded_irq(int irq, void *id)
> {
>         struct exynos_tmu_data *data =3D id;
>         unsigned int val_irq;
>
>         thermal_zone_device_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);
>
>         mutex_lock(&data->lock);
>         clk_enable(data->clk);
>
>         val_irq =3D readl(data->base + data->tmu_intstat);
>          writel(val_irq, data->base + data->tmu_intclear);
>
>         clk_disable(data->clk);
>         mutex_unlock(&data->lock);
>
>         return IRQ_HANDLED;
> }

No this will not work,
>
> But if the irq handler has some soc specific code, then it should be a
> separate function
>

INTSTAT interrupt status register holds the pending status of
rising and falling edge of IRQ

#define INTSTAT_FALL2   BIT(24)
#define INTSTAT_FALL1   BIT(20)
#define INTSTAT_FALL0   BIT(16)
#define INTSTAT_RISE2   BIT(8)
#define INTSTAT_RISE1   BIT(4)
#define INTSTAT_RISE0   BIT(0)

#define INTCLEAR_FALL2  BIT(24)
#define INTCLEAR_FALL1  BIT(20)
#define INTCLEAR_FALL0  BIT(16)
#define INTCLEAR_RISE2  BIT(8)
#define INTCLEAR_RISE1  BIT(4)
#define INTCLEAR_RISE0  BIT(0)

static void exynos4210_tmu_clear_irqs(struct exynos_tmu_data *data)
{
        u32 tmu_intstat, tmu_intclear;
        u32 val_irq =3D 0, clear_mask =3D 0;

        if (data->soc =3D=3D SOC_ARCH_EXYNOS5260) {
                tmu_intstat =3D EXYNOS5260_TMU_REG_INTSTAT;
                tmu_intclear =3D EXYNOS5260_TMU_REG_INTCLEAR;
        } else if (data->soc =3D=3D SOC_ARCH_EXYNOS7) {
                tmu_intstat =3D EXYNOS7_TMU_REG_INTPEND;
                tmu_intclear =3D EXYNOS7_TMU_REG_INTPEND;
        } else if (data->soc =3D=3D SOC_ARCH_EXYNOS5433) {
                tmu_intstat =3D EXYNOS5433_TMU_REG_INTPEND;
                tmu_intclear =3D EXYNOS5433_TMU_REG_INTPEND;
        } else {
                tmu_intstat =3D EXYNOS_TMU_REG_INTSTAT;
                tmu_intclear =3D EXYNOS_TMU_REG_INTCLEAR;
        }

        val_irq =3D readl(data->base + tmu_intstat);
        /*
         * Clear the interrupts.  Please note that the documentation for
         * Exynos3250, Exynos4412, Exynos5250 and Exynos5260 incorrectly
         * states that INTCLEAR register has a different placing of bits
         * responsible for FALL IRQs than INTSTAT register.  Exynos5420
         * and Exynos5440 documentation is correct (Exynos4210 doesn't
         * support FALL IRQs at all).
         */

        /* Map INTSTAT bits to INTCLEAR bits */
        if (val_irq & BIT(24))
                clear_mask |=3D BIT(24);
        else if (val_irq & BIT(20))
                clear_mask |=3D BIT(20);
        else if (val_irq & BIT(16))
                clear_mask |=3D BIT(16);
        else if (val_irq & BIT(8))
                clear_mask |=3D BIT(8);
        else if (val_irq & BIT(4))
                clear_mask |=3D BIT(4);
        else if (val_irq & BIT(0))
                clear_mask |=3D BIT(0);

        /* Perform proper task for decrease temperature */
        if (clear_mask)
                writel(clear_mask, data->base + tmu_intclear);
}

TMU clears the rising and falling interrupt according to the user manual.

Thanks
-Anand
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog

