Return-Path: <linux-pm+bounces-23493-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9077CA50415
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 17:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5FA173302
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 16:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACD32517A2;
	Wed,  5 Mar 2025 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHDbr9f1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA0E250C00;
	Wed,  5 Mar 2025 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741190388; cv=none; b=uQaYBD+ijeB/914o2aEy2BFcqL+uskfBufjFHZlZMqIRgNo+P12a8yhHToRKNSU3ztGy7BqXX9isqMTgX5vRtEPHfKyCem4RfC3tn6DwF9pS/ZXIYtT6oDCWfn6DRW/qCP+VS/yoXo1CfihHymzqi4oZAnHWuipPNsNjnUE+t9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741190388; c=relaxed/simple;
	bh=8Lry4w9TtWnkMmRqsKKK53yfuSzcXmAgYv1wuSz41hE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MYdzjji0fpqj6EKzazJM0MQzVhs2z9pLk6hqFHiv3GoWkCfFUEkIwqOiBz1k6bjEEeE+Z6bZGBtFwCKf9i2fl8/3BZ4n99mGH9G+3JSjfLHInuC+M3y4GPPZGpf8G9q9XymAy/q6GYZsIqsSUBlqyaQPiQgszgae6Og+OoBxBlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHDbr9f1; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abf4802b242so832926466b.1;
        Wed, 05 Mar 2025 07:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741190384; x=1741795184; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tNHkJmXM07+1xGaDRSJ0A5BITf+LecZD5bdaeHjapZk=;
        b=FHDbr9f18utWU61jHtKmjL03Ct4pykYFVDdzHls4YJ3eDBsJtnrXDiahLUeYIUKI1W
         UWSyJ4VhgXi1iC4xDMSiAiPkwF+BY5DJQJFnQeZlM9UqmuhqCJjcr1gReC6BEKL6pTFA
         0aB07Hwztvg0dppVlhXhsxCwptHKJJItM+/b7/ApTlyZamXb71WWn+MY1rJ6nBqlAyl2
         nwjfx9LJh3+TWlauSnUKheOcx0agbHZ2OpmEX+zuK3qkUIvC71EgeWiILRYiX3GN4ts2
         waIvA6Y2AVCZV19sOqbW3VObYsQJ1+1hd3TIMOuUNQNfDBw4EbVvyJvshit5V6mcJTQw
         vyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741190384; x=1741795184;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tNHkJmXM07+1xGaDRSJ0A5BITf+LecZD5bdaeHjapZk=;
        b=epn2+ijPC71klyvx8zl/R2vZo7avZLn3O/EivWQnQv+cFlzP/mOzzlRBDut/zpwUQK
         SSK8EoHrWBdmCfxqZwo7RYEmGUHYPiR6r3jPh0YxDvLu+1VRaLToTnxfoA+XawWCWobq
         aa/GJCpBaMWsnlfknBmw9j34YvwjovfTLoWndeAvDQNQ8X9WYlapbz2oMGQ1NNSzjY3p
         qgYhkBjqniE8yNTi5oVEBkJhBl8Im1Kybsz/UXGwX2T9nwgfEnGD3CA+M4FATy0fPeGp
         LGpnhY/+/IoJKFNVk7dwyWElRIwIKBO07nD9v/Ur1CnbzddZpulCcxwQ+noidla0gNW+
         PUew==
X-Forwarded-Encrypted: i=1; AJvYcCUGY/o8WGgZALR5X43vkIEQhS1j4QMTue9pcT+greh+Q9CtWjP1D4A1TsQa/DTZmgH/UQCjHZ8VgtbfATc=@vger.kernel.org, AJvYcCUoVbiQXakDpIFpkMKm+i4FzK0lSNSLOsR0EFKAAVMqbjBevq4fCUWdO86hjkp+zRjYI5rjDGb/Jgzy3UX54yiTM7I=@vger.kernel.org, AJvYcCVgzLZG7J03VQF7l2MMw9IEDSF1M1brgADKmJuWJYmvEwAUsAvo4LeZukPHNgeIiLB09Av2uXJLzNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCzNm3hG/KkVCU16skJUuZ9vv3wjXOB+rHv/KtpJekz5hH9xXi
	hlIsPBMMfKXUuPqIaBhyMizKKOBNFPhWqCVqCX/Gn5YjM6Csttktnqx6veDrYStCmCDNZlui4+n
	5lC8RZzLqYNLiXbDMm5v4hAQGBhw=
X-Gm-Gg: ASbGncv1ctRvBYhgr7SJHoahOF6/vKW03DFC+DO3fnVwnqBa6MP2Qpjr+yRujCKt/o7
	dW07E9nlFzw0Xy0YFoeiU3YwusPcwBNv4d8RC8d6Y/yfqAnQe5iEA88Cu8sw8jGLjcff2EqrZUu
	5beVmsdV3+oGXYTQZ9RPOnGXYObw==
X-Google-Smtp-Source: AGHT+IEQsE+pLAIU3v/ec4405Kg+m90JUNpfZqni22hhxiIr9/+iCpzkVrVUlAcAB0YbRMMiuvNnCzik/ivWF3/YwMM=
X-Received: by 2002:a17:907:da6:b0:ac1:fa0d:756 with SMTP id
 a640c23a62f3a-ac20d943124mr375609766b.34.1741190384124; Wed, 05 Mar 2025
 07:59:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250216195850.5352-1-linux.amoon@gmail.com> <20250216195850.5352-5-linux.amoon@gmail.com>
 <f44efd1a-1f6e-456d-9395-de2a55ef2279@arm.com> <CANAwSgTpV_kGFEU-ND0N+OEtT6+j4ceq37xAoLyC7iHPWAuLjg@mail.gmail.com>
 <CANAwSgSWf_YxSi-pzWPaRoiJx7RLrWUz+HTWx5hf+E2x1ZGmoQ@mail.gmail.com> <7a1cac10-b065-4b4c-b048-10d6b4132f3d@arm.com>
In-Reply-To: <7a1cac10-b065-4b4c-b048-10d6b4132f3d@arm.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 5 Mar 2025 21:29:27 +0530
X-Gm-Features: AQ5f1JppO4fhzc2dkKI1ZBSO1ZKK5PQ7WMoG06FmWIv-xqH6vpAXgcWpPGM7iIg
Message-ID: <CANAwSgQErDnKfaBOkpEwpJsoyUMhNTC2TJNW-eQYHgHu46poCA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] drivers/thermal/exymos: Use guard notation when
 acquiring mutex
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
	"open list:SAMSUNG THERMAL DRIVER" <linux-samsung-soc@vger.kernel.org>, 
	"open list:SAMSUNG THERMAL DRIVER" <linux-pm@vger.kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, open list <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>, Zhang Rui <rui.zhang@intel.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Lukasz,

On Wed, 5 Mar 2025 at 14:12, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 3/4/25 12:20, Anand Moon wrote:
> > Hi Lukasz,
> >
> > On Sat, 1 Mar 2025 at 00:06, Anand Moon <linux.amoon@gmail.com> wrote:
> >>
> >> Hi Lukasz,
> >>
> >> On Fri, 28 Feb 2025 at 22:58, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>>
> >>>
> >>>
> >>> On 2/16/25 19:58, Anand Moon wrote:
> >>>> Using guard notation makes the code more compact and error handling
> >>>> more robust by ensuring that mutexes are released in all code paths
> >>>> when control leaves critical section.
> >>>>
> >>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> >>>> ---
> >>>> v3: new patch
> >>>> ---
> >>>>    drivers/thermal/samsung/exynos_tmu.c | 21 +++++++--------------
> >>>>    1 file changed, 7 insertions(+), 14 deletions(-)
> >>>>
> >>>> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> >>>> index fe090c1a93ab..a34ba3858d64 100644
> >>>> --- a/drivers/thermal/samsung/exynos_tmu.c
> >>>> +++ b/drivers/thermal/samsung/exynos_tmu.c
> >>>> @@ -256,7 +256,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
> >>>>        unsigned int status;
> >>>>        int ret = 0;
> >>>>
> >>>> -     mutex_lock(&data->lock);
> >>>> +     guard(mutex)(&data->lock);
> >>>>        clk_enable(data->clk);
> >>>>        clk_enable(data->clk_sec);
> >>>>
> >>>> @@ -270,7 +270,6 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
> >>>>
> >>>>        clk_disable(data->clk_sec);
> >>>>        clk_disable(data->clk);
> >>>> -     mutex_unlock(&data->lock);
> >>>>
> >>>>        return ret;
> >>>>    }
> >>>> @@ -292,13 +291,12 @@ static int exynos_thermal_zone_configure(struct platform_device *pdev)
> >>>>                return ret;
> >>>>        }
> >>>>
> >>>> -     mutex_lock(&data->lock);
> >>>> +     guard(mutex)(&data->lock);
> >>>>        clk_enable(data->clk);
> >>>>
> >>>>        data->tmu_set_crit_temp(data, temp / MCELSIUS);
> >>>>
> >>>>        clk_disable(data->clk);
> >>>> -     mutex_unlock(&data->lock);
> >>>>
> >>>>        return 0;
> >>>>    }
> >>>> @@ -325,12 +323,11 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
> >>>>    {
> >>>>        struct exynos_tmu_data *data = platform_get_drvdata(pdev);
> >>>>
> >>>> -     mutex_lock(&data->lock);
> >>>> +     guard(mutex)(&data->lock);
> >>>>        clk_enable(data->clk);
> >>>>        data->tmu_control(pdev, on);
> >>>>        data->enabled = on;
> >>>>        clk_disable(data->clk);
> >>>> -     mutex_unlock(&data->lock);
> >>>>    }
> >>>>
> >>>>    static void exynos_tmu_update_bit(struct exynos_tmu_data *data, int reg_off,
> >>>> @@ -645,7 +642,7 @@ static int exynos_get_temp(struct thermal_zone_device *tz, int *temp)
> >>>>                 */
> >>>>                return -EAGAIN;
> >>>>
> >>>> -     mutex_lock(&data->lock);
> >>>> +     guard(mutex)(&data->lock);
> >>>>        clk_enable(data->clk);
> >>>>
> >>>>        value = data->tmu_read(data);
> >>>> @@ -655,7 +652,6 @@ static int exynos_get_temp(struct thermal_zone_device *tz, int *temp)
> >>>>                *temp = code_to_temp(data, value) * MCELSIUS;
> >>>>
> >>>>        clk_disable(data->clk);
> >>>> -     mutex_unlock(&data->lock);
> >>>>
> >>>>        return ret;
> >>>>    }
> >>>> @@ -720,11 +716,10 @@ static int exynos_tmu_set_emulation(struct thermal_zone_device *tz, int temp)
> >>>>        if (temp && temp < MCELSIUS)
> >>>>                goto out;
> >>>>
> >>>> -     mutex_lock(&data->lock);
> >>>> +     guard(mutex)(&data->lock);
> >>>>        clk_enable(data->clk);
> >>>>        data->tmu_set_emulation(data, temp);
> >>>>        clk_disable(data->clk);
> >>>> -     mutex_unlock(&data->lock);
> >>>>        return 0;
> >>>>    out:
> >>>>        return ret;
> >>>> @@ -760,14 +755,13 @@ static irqreturn_t exynos_tmu_threaded_irq(int irq, void *id)
> >>>>
> >>>>        thermal_zone_device_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);
> >>>>
> >>>> -     mutex_lock(&data->lock);
> >>>> +     guard(mutex)(&data->lock);
> >>>>        clk_enable(data->clk);
> >>>>
> >>>>        /* TODO: take action based on particular interrupt */
> >>>>        data->tmu_clear_irqs(data);
> >>>>
> >>>>        clk_disable(data->clk);
> >>>> -     mutex_unlock(&data->lock);
> >>>>
> >>>>        return IRQ_HANDLED;
> >>>>    }
> >>>> @@ -987,7 +981,7 @@ static int exynos_set_trips(struct thermal_zone_device *tz, int low, int high)
> >>>>    {
> >>>>        struct exynos_tmu_data *data = thermal_zone_device_priv(tz);
> >>>>
> >>>> -     mutex_lock(&data->lock);
> >>>> +     guard(mutex)(&data->lock);
> >>>>        clk_enable(data->clk);
> >>>>
> >>>>        if (low > INT_MIN)
> >>>> @@ -1000,7 +994,6 @@ static int exynos_set_trips(struct thermal_zone_device *tz, int low, int high)
> >>>>                data->tmu_disable_high(data);
> >>>>
> >>>>        clk_disable(data->clk);
> >>>> -     mutex_unlock(&data->lock);
> >>>>
> >>>>        return 0;
> >>>>    }
> >>
> >> Thanks for your review comments.
> >>>
> >>> IMO you should be able to even use something like we have
> >>> core framework:
> >>>
> >>> guard(thermal_zone)(tz);
> >>>
> >>> Your mutex name is simply 'lock' in the struct exynos_tmu_data
> >>> so you should be able to leverage this by:
> >>>
> >>> guard(exynos_tmu_data)(data);
> >>>
> >
> > If I introduce the guard it creates a compilation error
> >
> > amoon@anand-m920q:~/mainline/linux-exynos-6.y-devel$ vi
> > drivers/thermal/samsung/exynos_tmu.c +306
> > amoon@anand-m920q:~/mainline/linux-exynos-6.y-devel$ make -j$(nproc)
> > ARCH=arm CROSS_COMPILE=arm-none-eabi- LOCALVERSION=-u3ml dtbs zImage
> > modules
> >    CALL    scripts/checksyscalls.sh
> >    CHK     kernel/kheaders_data.tar.xz
> >    CC      drivers/thermal/samsung/exynos_tmu.o
> >    CC [M]  drivers/md/raid10.o
> > In file included from ./include/linux/irqflags.h:17,
> >                   from ./arch/arm/include/asm/bitops.h:28,
> >                   from ./include/linux/bitops.h:68,
> >                   from ./include/linux/kernel.h:23,
> >                   from ./include/linux/clk.h:13,
> >                   from drivers/thermal/samsung/exynos_tmu.c:14:
> > drivers/thermal/samsung/exynos_tmu.c: In function 'exynos_tmu_update_bit':
> > ./include/linux/cleanup.h:258:9: error: unknown type name
> > 'class_exynos_tmu_data_t'
> >    258 |         class_##_name##_t var
> > __cleanup(class_##_name##_destructor) =   \
> >        |         ^~~~~~
> > ./include/linux/cleanup.h:309:9: note: in expansion of macro 'CLASS'
> >    309 |         CLASS(_name, __UNIQUE_ID(guard))
> >        |         ^~~~~
> > drivers/thermal/samsung/exynos_tmu.c:338:9: note: in expansion of macro 'guard'
> >    338 |         guard(exynos_tmu_data)(data);
> >        |         ^~~~~
> > drivers/thermal/samsung/exynos_tmu.c:338:9: error: cleanup argument
> > not a function
>
> [snip]
>
> Right, you're missing the definition at the begging, like:
>
> DEFINE_GUARD(exynos_tmu_data, struct exynos_tmu_data *,
> mutex_lock(&_T->lock),
>               mutex_unlock(&_T->lock))
>
> below the struct exynos_tmu_data definition.
>
> Also, make sure you include the cleanup.h (it might not complain,
> but it would be explicit and more clear)

Thanks for this tip.
However, incorporating guard(exynos_tmu_data)(data); results
in a recursive deadlock with the mutex during initialization, as this
data structure is common to all the code configurations of Exynos TMU

Thanks
-Anand

