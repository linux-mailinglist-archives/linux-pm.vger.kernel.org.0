Return-Path: <linux-pm+bounces-23354-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47255A4DDB5
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 13:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67B48173BCF
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 12:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A111202989;
	Tue,  4 Mar 2025 12:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcpmdagO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2F1202976;
	Tue,  4 Mar 2025 12:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741090822; cv=none; b=U8fLhUp7SQdjccFTRc5KJrQHnasPAVYE6hJHRpUMnc5ERPvdhf4YC+rE/6d8cUuALe3Feqhu3nGJoqvC02Fw2YitupkXLeJWe8uduxMcE4B6qtnLXe3n3FkIX+4puuU2+qqbBFavGMerKQARXRlqh9QglzwKoopgT2YtiP3K3WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741090822; c=relaxed/simple;
	bh=2ar+f7KPMqAX1QocPDdnx0UYD5XmMum8mConbChM40k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PCxXFNVjidfvQgyiHoi45RwCye6OB15rIFOuYaGESOo9Sf8afQlOX00BXYGG9G8dLfqBod/AfUDWM5FJMI6eiV5GQ3cPp5fo7qI5r8rxN1rOK0CjsRyw8v5wM67sbnfdsIUrokVh9hsBemV0FCV7hVhDXVFlRBjQN7b9Vhk7j4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcpmdagO; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab7430e27b2so917452366b.3;
        Tue, 04 Mar 2025 04:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741090819; x=1741695619; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T2b/5ukyRNqmFbWc8ToNTxaJWZ+JvSrLpsvdrXtS7LA=;
        b=XcpmdagOnORuDGP/ewKiHelfF0cxJ3nwuPg2gOUcFq0HtGtsM7NctkH71ZDrtb7E76
         CMBEZd+aWYL4/5qJiKYzszNNa6QRD3lQYeN5EJwpYK0nKR35aBFuYaf7hNrqoPa91rFd
         W6Mht6KgNsv3eUk2pALC3ezwTdlguVDFonzDV1W5FAmskLPohB9USHAM6eHXSLHMR0bf
         FDyPCmEoOqf8hgUTiTF8S/LiJeLZNxgbX2qFnifOxRylKfaDbdNzkPUdmwbOo2cEHXnE
         In638tWXj1k3cPcze3fZwdFdlXJwzodkc0C+25mk+DFqbfF+g7dGk79VcPmz9ZJVmlCw
         3EaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741090819; x=1741695619;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T2b/5ukyRNqmFbWc8ToNTxaJWZ+JvSrLpsvdrXtS7LA=;
        b=IeCjpV5kKfkQT1rLs6Vbg2sUvXbZqzHHLQh6g1q616TdszSkWrZILqIosgFaz7nDiB
         /h2dv9S1K9+QE1terPfvrZrDvGRRZBTO7TT3O2B4ENjwA2MJ5EhzfFJBsTzqNkdMwo4/
         i2wqv6tLvg9UvSdWcciHQTyotMD6TOWozvG5wP1brxEMK3IOlWSAVBEbQ5UUtB1untLu
         2r5rKSMYgEzK5EULYjaJyNRyy2HEv1Ed6vnMAKQiN2nBzXELcQ0aqcsD42ad6/OAfMfz
         9guyZ0lVpiUOMa9eyjwQjJjSl6sf3hSa8DQRScKiCVuNgbDQ8SDU5ZTjtwkfHAKmflOO
         36sw==
X-Forwarded-Encrypted: i=1; AJvYcCWMWGDQ8DwEj1BzWvQxhisGmdBFcd0BUO1da9PYYq8XYSAM0KisLkBIZPHwuGrT9PrT879rYjmJJQPe3Jg=@vger.kernel.org, AJvYcCWpB/Svt0z665xNm0Li5w7q+41lHT/u9Uu0yolJNlZjy7UKoYVNgYSt3d6yNN5oqlNLLUNu/ucbwQk=@vger.kernel.org, AJvYcCXGjHNy9iUk3pojoIqUbzKV0UW+78LTY1c3esyq4WHUrjA4ZqsPN34wBanorqRA8OpxCtYVlwYlSdJTY/9JeCfJgE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0FqtkaNVzfcuFiBZSsrVFkPDcE9L/HIMlidlBIRHI7/dw2lAY
	/VILArU/CEdqCagEadkNYrcGSYGlP3AUSUmjzUfEBCZuHSTkrthW4p6MPad4wYc9yXHECR1VmRr
	hOCSCQt0VQEURSb+x9fRQqZ+5uhs=
X-Gm-Gg: ASbGncs1wtG3PsKxjoKRIiX3W0qb1MHSof2AC5TdR4zjgZsKuYNaTeoKjq0K7YfDYj3
	YSKhTtrcNUv20h09Z7EDw52Qlk/rMLNp5REFNG4qp9m/i3pM4gNn3ZJuUDgEcYR+n/WmIybrsf1
	zcrof2GIl3NHTCsOaM48YT2iVg6A==
X-Google-Smtp-Source: AGHT+IHkYWadWW7TaJ6Pjpkx8CZPlIqxBSv7u3JGLhQgehyVgUtS6n03IifPBFz9R3q6GPUl2gY1BtIeWq8xfJUg8Uk=
X-Received: by 2002:a17:907:6d02:b0:abf:7a80:1a7e with SMTP id
 a640c23a62f3a-abf7a8020bbmr787792166b.9.1741090818886; Tue, 04 Mar 2025
 04:20:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250216195850.5352-1-linux.amoon@gmail.com> <20250216195850.5352-5-linux.amoon@gmail.com>
 <f44efd1a-1f6e-456d-9395-de2a55ef2279@arm.com> <CANAwSgTpV_kGFEU-ND0N+OEtT6+j4ceq37xAoLyC7iHPWAuLjg@mail.gmail.com>
In-Reply-To: <CANAwSgTpV_kGFEU-ND0N+OEtT6+j4ceq37xAoLyC7iHPWAuLjg@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 4 Mar 2025 17:50:01 +0530
X-Gm-Features: AQ5f1JpX0iWefCe0V27iOMVW62tgPomNaHMGwjJbtqtjqB7h6WVwx5RmH8xbgrw
Message-ID: <CANAwSgSWf_YxSi-pzWPaRoiJx7RLrWUz+HTWx5hf+E2x1ZGmoQ@mail.gmail.com>
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

On Sat, 1 Mar 2025 at 00:06, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Lukasz,
>
> On Fri, 28 Feb 2025 at 22:58, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >
> >
> >
> > On 2/16/25 19:58, Anand Moon wrote:
> > > Using guard notation makes the code more compact and error handling
> > > more robust by ensuring that mutexes are released in all code paths
> > > when control leaves critical section.
> > >
> > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > ---
> > > v3: new patch
> > > ---
> > >   drivers/thermal/samsung/exynos_tmu.c | 21 +++++++--------------
> > >   1 file changed, 7 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> > > index fe090c1a93ab..a34ba3858d64 100644
> > > --- a/drivers/thermal/samsung/exynos_tmu.c
> > > +++ b/drivers/thermal/samsung/exynos_tmu.c
> > > @@ -256,7 +256,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
> > >       unsigned int status;
> > >       int ret = 0;
> > >
> > > -     mutex_lock(&data->lock);
> > > +     guard(mutex)(&data->lock);
> > >       clk_enable(data->clk);
> > >       clk_enable(data->clk_sec);
> > >
> > > @@ -270,7 +270,6 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
> > >
> > >       clk_disable(data->clk_sec);
> > >       clk_disable(data->clk);
> > > -     mutex_unlock(&data->lock);
> > >
> > >       return ret;
> > >   }
> > > @@ -292,13 +291,12 @@ static int exynos_thermal_zone_configure(struct platform_device *pdev)
> > >               return ret;
> > >       }
> > >
> > > -     mutex_lock(&data->lock);
> > > +     guard(mutex)(&data->lock);
> > >       clk_enable(data->clk);
> > >
> > >       data->tmu_set_crit_temp(data, temp / MCELSIUS);
> > >
> > >       clk_disable(data->clk);
> > > -     mutex_unlock(&data->lock);
> > >
> > >       return 0;
> > >   }
> > > @@ -325,12 +323,11 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
> > >   {
> > >       struct exynos_tmu_data *data = platform_get_drvdata(pdev);
> > >
> > > -     mutex_lock(&data->lock);
> > > +     guard(mutex)(&data->lock);
> > >       clk_enable(data->clk);
> > >       data->tmu_control(pdev, on);
> > >       data->enabled = on;
> > >       clk_disable(data->clk);
> > > -     mutex_unlock(&data->lock);
> > >   }
> > >
> > >   static void exynos_tmu_update_bit(struct exynos_tmu_data *data, int reg_off,
> > > @@ -645,7 +642,7 @@ static int exynos_get_temp(struct thermal_zone_device *tz, int *temp)
> > >                */
> > >               return -EAGAIN;
> > >
> > > -     mutex_lock(&data->lock);
> > > +     guard(mutex)(&data->lock);
> > >       clk_enable(data->clk);
> > >
> > >       value = data->tmu_read(data);
> > > @@ -655,7 +652,6 @@ static int exynos_get_temp(struct thermal_zone_device *tz, int *temp)
> > >               *temp = code_to_temp(data, value) * MCELSIUS;
> > >
> > >       clk_disable(data->clk);
> > > -     mutex_unlock(&data->lock);
> > >
> > >       return ret;
> > >   }
> > > @@ -720,11 +716,10 @@ static int exynos_tmu_set_emulation(struct thermal_zone_device *tz, int temp)
> > >       if (temp && temp < MCELSIUS)
> > >               goto out;
> > >
> > > -     mutex_lock(&data->lock);
> > > +     guard(mutex)(&data->lock);
> > >       clk_enable(data->clk);
> > >       data->tmu_set_emulation(data, temp);
> > >       clk_disable(data->clk);
> > > -     mutex_unlock(&data->lock);
> > >       return 0;
> > >   out:
> > >       return ret;
> > > @@ -760,14 +755,13 @@ static irqreturn_t exynos_tmu_threaded_irq(int irq, void *id)
> > >
> > >       thermal_zone_device_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);
> > >
> > > -     mutex_lock(&data->lock);
> > > +     guard(mutex)(&data->lock);
> > >       clk_enable(data->clk);
> > >
> > >       /* TODO: take action based on particular interrupt */
> > >       data->tmu_clear_irqs(data);
> > >
> > >       clk_disable(data->clk);
> > > -     mutex_unlock(&data->lock);
> > >
> > >       return IRQ_HANDLED;
> > >   }
> > > @@ -987,7 +981,7 @@ static int exynos_set_trips(struct thermal_zone_device *tz, int low, int high)
> > >   {
> > >       struct exynos_tmu_data *data = thermal_zone_device_priv(tz);
> > >
> > > -     mutex_lock(&data->lock);
> > > +     guard(mutex)(&data->lock);
> > >       clk_enable(data->clk);
> > >
> > >       if (low > INT_MIN)
> > > @@ -1000,7 +994,6 @@ static int exynos_set_trips(struct thermal_zone_device *tz, int low, int high)
> > >               data->tmu_disable_high(data);
> > >
> > >       clk_disable(data->clk);
> > > -     mutex_unlock(&data->lock);
> > >
> > >       return 0;
> > >   }
>
> Thanks for your review comments.
> >
> > IMO you should be able to even use something like we have
> > core framework:
> >
> > guard(thermal_zone)(tz);
> >
> > Your mutex name is simply 'lock' in the struct exynos_tmu_data
> > so you should be able to leverage this by:
> >
> > guard(exynos_tmu_data)(data);
> >

If I introduce the guard it creates a compilation error

amoon@anand-m920q:~/mainline/linux-exynos-6.y-devel$ vi
drivers/thermal/samsung/exynos_tmu.c +306
amoon@anand-m920q:~/mainline/linux-exynos-6.y-devel$ make -j$(nproc)
ARCH=arm CROSS_COMPILE=arm-none-eabi- LOCALVERSION=-u3ml dtbs zImage
modules
  CALL    scripts/checksyscalls.sh
  CHK     kernel/kheaders_data.tar.xz
  CC      drivers/thermal/samsung/exynos_tmu.o
  CC [M]  drivers/md/raid10.o
In file included from ./include/linux/irqflags.h:17,
                 from ./arch/arm/include/asm/bitops.h:28,
                 from ./include/linux/bitops.h:68,
                 from ./include/linux/kernel.h:23,
                 from ./include/linux/clk.h:13,
                 from drivers/thermal/samsung/exynos_tmu.c:14:
drivers/thermal/samsung/exynos_tmu.c: In function 'exynos_tmu_update_bit':
./include/linux/cleanup.h:258:9: error: unknown type name
'class_exynos_tmu_data_t'
  258 |         class_##_name##_t var
__cleanup(class_##_name##_destructor) =   \
      |         ^~~~~~
./include/linux/cleanup.h:309:9: note: in expansion of macro 'CLASS'
  309 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~
drivers/thermal/samsung/exynos_tmu.c:338:9: note: in expansion of macro 'guard'
  338 |         guard(exynos_tmu_data)(data);
      |         ^~~~~
drivers/thermal/samsung/exynos_tmu.c:338:9: error: cleanup argument
not a function
  CC [M]  drivers/md/raid5.o
./include/linux/cleanup.h:259:17: error: implicit declaration of
function 'class_exynos_tmu_data_constructor'
[-Wimplicit-function-declaration]
  259 |                 class_##_name##_constructor
      |                 ^~~~~~
./include/linux/cleanup.h:309:9: note: in expansion of macro 'CLASS'
  309 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~
drivers/thermal/samsung/exynos_tmu.c:338:9: note: in expansion of macro 'guard'
  338 |         guard(exynos_tmu_data)(data);
      |         ^~~~~
./include/linux/compiler.h:166:45: warning: unused variable
'__UNIQUE_ID_guard572' [-Wunused-variable]
  166 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_,
prefix), __COUNTER__)
      |                                             ^~~~~~~~~~~~
./include/linux/cleanup.h:258:27: note: in definition of macro 'CLASS'
  258 |         class_##_name##_t var
__cleanup(class_##_name##_destructor) =   \
      |                           ^~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___PASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:166:29: note: in expansion of macro '__PASTE'
  166 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_,
prefix), __COUNTER__)
      |                             ^~~~~~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___PASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:166:37: note: in expansion of macro '__PASTE'
  166 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_,
prefix), __COUNTER__)
      |                                     ^~~~~~~
./include/linux/cleanup.h:309:22: note: in expansion of macro '__UNIQUE_ID'
  309 |         CLASS(_name, __UNIQUE_ID(guard))
      |                      ^~~~~~~~~~~
drivers/thermal/samsung/exynos_tmu.c:338:9: note: in expansion of macro 'guard'
  338 |         guard(exynos_tmu_data)(data);

Thanks
-Anand

