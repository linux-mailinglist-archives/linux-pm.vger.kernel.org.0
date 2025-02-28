Return-Path: <linux-pm+bounces-23190-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D9AA4A1C2
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 19:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 418903B2393
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 18:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969F427CCCD;
	Fri, 28 Feb 2025 18:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcFQLij8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F6727CCC5;
	Fri, 28 Feb 2025 18:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767791; cv=none; b=IfGhDYkJiVmwP8P94nCmApzTWHNzjm7H5OPcterKSkVvYT2JeLIU6VaDN1WEkntdT2ss4K5uGuwuqyAEuJv4Y0yvtPxxUFA+9jDEpRSgPEgBPF6JCoU9qSJkRPNnU8shxvdfs8sR+0FIFdkoejU+nKmVBXjusHSMRCxU8V0o2jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767791; c=relaxed/simple;
	bh=FOo85UWm0LlESU87rNVLWaSKK4QP39SCLtxM0G1y7aY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QwyJs7v5PUrM4QVvh/6RhMoYcLDKpD1pdCFrkVpHmaqofzFAGnna7HJSWR+ImuKsbiUepvJ8Y+FreqLeQ5aZs2iIJ8a06h5wf/SYCND8VWS2XpLx6z/BsVfrggSPGt9J6EtABNBSnqCxz6BJroixFKPgS+jzVQx60FQx+/m7Mcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcFQLij8; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5ded6c31344so3006511a12.1;
        Fri, 28 Feb 2025 10:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740767788; x=1741372588; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bcOciFev494FQi+ie3YAuQXZTVFD/MHMZEBQgtl8Sq4=;
        b=kcFQLij8BHSltIoBPK3w2aYRv42zty8tn8wsDj4Og4z0d9t58dqmgSpdfN3ozZQFcH
         bd5Pj9LWZoyHE2feg+fZLM8vTczLpLIEiEFL+1J6vbH5kANjHfcIViwxs1qL5t6bSY3g
         VnxfvyCwt5fRiNNCXQ8E2Q8SwyO4qtxbzCW3nGfBaC/ztA103jb/MgK0HIdW17rfuul0
         zYmWGZjkAxKTZQaiFBSv96BtKTgsQDkafC9HveVBH6el5mdOXZZp3WQgS6B/yx2hucRr
         geq33gvEoNv3aXXql/8AhIl9F+Up1xHMfm9+BEolQGeCUcdYOsuCbI5vql8HuW5y/wHl
         CvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740767788; x=1741372588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bcOciFev494FQi+ie3YAuQXZTVFD/MHMZEBQgtl8Sq4=;
        b=gcXfTji0D8fpRRuBfjOOjnOy7kSbkwsj6D+3JOh/GZDGL0g5lgH17N3R1hyqXLl7ci
         mG31Nova51EC4w0+dZO5H9X6XdBc2cod14aOEwDzOyc9OlfaYHIIEwhoreB3aZLsGlpV
         /k578AKsH2xXbQxzY6Zex3IMD9SRebfKIMOFFKw0Gc9kmNsuyKpHgQ3unapShlc2K6dQ
         tdGtYTl6eiDtJrUQmBtmAOxqjJsMoLYJKuB17LgxHJcDNELkZqwUrioQLpOyVSyvJI1O
         pG7zLCtO5jEafaW4r5IUjsDchKTKNgusYqg4gNne7pcBwzoeVMUQdqSoqW3RVujRCAyz
         memw==
X-Forwarded-Encrypted: i=1; AJvYcCUmJ58h6RTDNCeCRkwnW7xcuWe2SY1J/h2hqh5bNNpUOivIEt2+gA0hGqJGF+HZOIpn/u9pfme/7iH4JDc=@vger.kernel.org, AJvYcCW/+ZwdZCcUo7lKkx/zBxGjxmTlG3mSujCM9Wbsy373xXXipdoV4alyNYQKD6I/BKmE8faShza63Q0=@vger.kernel.org, AJvYcCXP2Wu3TNEV40FSzD3TXgOxB2XO/0mdqWts7Q4yqtCVie0yMIkKP0vc8GO3fTP2KyiyEeeMYtoGkJU3unsqdqUbq+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb7LYHQKrvz2Nt2DE982pYgAAzUZ7owOPSfj0I5laen7fyEo9h
	gyFvAO/zvuaaIupDiVmA0wqn3AYiy6tlS8OtLK1Zd7N8RXnp1pj39/OCpHtvSqW3cG+QfHowycz
	zzzPRRTCI1IDIVSQ/KdenjIOubcU=
X-Gm-Gg: ASbGncsjLb3Uh5xkflU2WRrXtnO8DLlHDfgb+9QnQJ3TEDky176u8KhowxE4b0d96uE
	PbVWIn+qw44DEdeevudBSPqI9PzxeqAMWS0U7BPgu9JfEjmVrxGpWb/aaLXRGhmFPnqvW4+pepM
	I2qeoOJKI=
X-Google-Smtp-Source: AGHT+IFE3G2KjHi8I1VMEUvtVVJytNjP0/8SzMhjPmWtNq41A0r54s3RwgOnWAEJT6u1F3AfT20PzYxSV85X9vtUhfM=
X-Received: by 2002:a05:6402:51c6:b0:5dc:5ada:e0c7 with SMTP id
 4fb4d7f45d1cf-5e4d6b4c2edmr8497667a12.26.1740767787540; Fri, 28 Feb 2025
 10:36:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250216195850.5352-1-linux.amoon@gmail.com> <20250216195850.5352-5-linux.amoon@gmail.com>
 <f44efd1a-1f6e-456d-9395-de2a55ef2279@arm.com>
In-Reply-To: <f44efd1a-1f6e-456d-9395-de2a55ef2279@arm.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 1 Mar 2025 00:06:10 +0530
X-Gm-Features: AQ5f1JrCuLXPNSAWoUTKE1NaVm2ihsuQ5JSDdwiiFIEGBSN_Yr_bdvM8NVPBMWc
Message-ID: <CANAwSgTpV_kGFEU-ND0N+OEtT6+j4ceq37xAoLyC7iHPWAuLjg@mail.gmail.com>
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

On Fri, 28 Feb 2025 at 22:58, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 2/16/25 19:58, Anand Moon wrote:
> > Using guard notation makes the code more compact and error handling
> > more robust by ensuring that mutexes are released in all code paths
> > when control leaves critical section.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > v3: new patch
> > ---
> >   drivers/thermal/samsung/exynos_tmu.c | 21 +++++++--------------
> >   1 file changed, 7 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> > index fe090c1a93ab..a34ba3858d64 100644
> > --- a/drivers/thermal/samsung/exynos_tmu.c
> > +++ b/drivers/thermal/samsung/exynos_tmu.c
> > @@ -256,7 +256,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
> >       unsigned int status;
> >       int ret = 0;
> >
> > -     mutex_lock(&data->lock);
> > +     guard(mutex)(&data->lock);
> >       clk_enable(data->clk);
> >       clk_enable(data->clk_sec);
> >
> > @@ -270,7 +270,6 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
> >
> >       clk_disable(data->clk_sec);
> >       clk_disable(data->clk);
> > -     mutex_unlock(&data->lock);
> >
> >       return ret;
> >   }
> > @@ -292,13 +291,12 @@ static int exynos_thermal_zone_configure(struct platform_device *pdev)
> >               return ret;
> >       }
> >
> > -     mutex_lock(&data->lock);
> > +     guard(mutex)(&data->lock);
> >       clk_enable(data->clk);
> >
> >       data->tmu_set_crit_temp(data, temp / MCELSIUS);
> >
> >       clk_disable(data->clk);
> > -     mutex_unlock(&data->lock);
> >
> >       return 0;
> >   }
> > @@ -325,12 +323,11 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
> >   {
> >       struct exynos_tmu_data *data = platform_get_drvdata(pdev);
> >
> > -     mutex_lock(&data->lock);
> > +     guard(mutex)(&data->lock);
> >       clk_enable(data->clk);
> >       data->tmu_control(pdev, on);
> >       data->enabled = on;
> >       clk_disable(data->clk);
> > -     mutex_unlock(&data->lock);
> >   }
> >
> >   static void exynos_tmu_update_bit(struct exynos_tmu_data *data, int reg_off,
> > @@ -645,7 +642,7 @@ static int exynos_get_temp(struct thermal_zone_device *tz, int *temp)
> >                */
> >               return -EAGAIN;
> >
> > -     mutex_lock(&data->lock);
> > +     guard(mutex)(&data->lock);
> >       clk_enable(data->clk);
> >
> >       value = data->tmu_read(data);
> > @@ -655,7 +652,6 @@ static int exynos_get_temp(struct thermal_zone_device *tz, int *temp)
> >               *temp = code_to_temp(data, value) * MCELSIUS;
> >
> >       clk_disable(data->clk);
> > -     mutex_unlock(&data->lock);
> >
> >       return ret;
> >   }
> > @@ -720,11 +716,10 @@ static int exynos_tmu_set_emulation(struct thermal_zone_device *tz, int temp)
> >       if (temp && temp < MCELSIUS)
> >               goto out;
> >
> > -     mutex_lock(&data->lock);
> > +     guard(mutex)(&data->lock);
> >       clk_enable(data->clk);
> >       data->tmu_set_emulation(data, temp);
> >       clk_disable(data->clk);
> > -     mutex_unlock(&data->lock);
> >       return 0;
> >   out:
> >       return ret;
> > @@ -760,14 +755,13 @@ static irqreturn_t exynos_tmu_threaded_irq(int irq, void *id)
> >
> >       thermal_zone_device_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);
> >
> > -     mutex_lock(&data->lock);
> > +     guard(mutex)(&data->lock);
> >       clk_enable(data->clk);
> >
> >       /* TODO: take action based on particular interrupt */
> >       data->tmu_clear_irqs(data);
> >
> >       clk_disable(data->clk);
> > -     mutex_unlock(&data->lock);
> >
> >       return IRQ_HANDLED;
> >   }
> > @@ -987,7 +981,7 @@ static int exynos_set_trips(struct thermal_zone_device *tz, int low, int high)
> >   {
> >       struct exynos_tmu_data *data = thermal_zone_device_priv(tz);
> >
> > -     mutex_lock(&data->lock);
> > +     guard(mutex)(&data->lock);
> >       clk_enable(data->clk);
> >
> >       if (low > INT_MIN)
> > @@ -1000,7 +994,6 @@ static int exynos_set_trips(struct thermal_zone_device *tz, int low, int high)
> >               data->tmu_disable_high(data);
> >
> >       clk_disable(data->clk);
> > -     mutex_unlock(&data->lock);
> >
> >       return 0;
> >   }

Thanks for your review comments.
>
> IMO you should be able to even use something like we have
> core framework:
>
> guard(thermal_zone)(tz);
>
> Your mutex name is simply 'lock' in the struct exynos_tmu_data
> so you should be able to leverage this by:
>
> guard(exynos_tmu_data)(data);
>
> Please try that.

Ok, I will check this

Thanks
-Anand

