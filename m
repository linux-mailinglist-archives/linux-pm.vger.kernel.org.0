Return-Path: <linux-pm+bounces-23923-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43534A5DF99
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 15:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593703B95B9
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 14:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C11F24CEFE;
	Wed, 12 Mar 2025 14:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3juhabp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910912441A6;
	Wed, 12 Mar 2025 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741791582; cv=none; b=mnmjx84cyeQguZ8KU69WromOXwe1Lpzdc7VXMaXrTC+jsJDpqSKkLOzYWFfTv6h7FwSd8G3ETFHEGq7zaK/u5hW6O6I5EsqeWaq6lsREROa2amZdFcblpFoeZbMrHall5QVpNlei1KcIrk3owKZgLmkAX1e++pJCSsYtm0pSJeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741791582; c=relaxed/simple;
	bh=qKHl4440qk1/HT376ckRtihAJqb0O/rQGW0XFo0QqFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fbY4eQTwAIEDPoasOmesWAPBH7kzGsT91jUCSKSkzY+fCKOSc0akuhkJF9kLgGQUobryxH5kEFaurX+si8keOMsvv1eFJC0QZGIoHxA4IoEjsJSJAHRQOThUALDaN7PuisDrznISatoZ30MqxMPkMCdqmejrSWT+HTTS78E/fMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3juhabp; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac25313ea37so1048596366b.1;
        Wed, 12 Mar 2025 07:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741791579; x=1742396379; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a3SyTg0NCa9lvne6z+mxZp19Z0gaaai+gw+VCvsnLk4=;
        b=G3juhabp87I2qIYj9Tm+PJTdQ5NT6A6JoLOXBeSAWjJI2E6Js+sUMR8joswOeuQlQ2
         dN9GlD2ItSQtDT7qBpAAjU3usDy8PsWzUrnx/FyMBoDTZypxqGcc7Gy1jYBjb/9F+oik
         ihsDBzzYR/TBc/c+2jKCuLcLfwKZUxW0mhBL8o3ucFwgo0yIWbJpMpL+9SLg6zH43d/d
         gdIcUwDaJ39GBdtYvX4sKPP0KfV7QdZdDibP86WxtzZNdUqsONVsjS9t0rB2YN3XK32z
         bI4hqVIqS1MOKO3jzReiCv2kHarFu+qDnlJ74DuC4BJc090HGRW+acLV9Ic4f9TMaPYs
         LPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741791579; x=1742396379;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a3SyTg0NCa9lvne6z+mxZp19Z0gaaai+gw+VCvsnLk4=;
        b=XDC2llfL/8ZipWn9wwpr7dKnKjdoTxs3s+T07nLCG2WeP2eNuxGOlNqw4IXvjS2aDo
         F4K63mb69/7Z+4pA5KlNbymv6t01fZdHZQHNdXu22o6mnNOemRj8XHmArOmHjjAoaCY/
         WInpoOiHQF6kqKocWut0igZNJpFEXFh3tESqsdox34XMhK+NtUlCb78zcke8Ug7cHM99
         K9npzSxMKtEDU9xZvHuadr2H+RzV3M2KJQG9+oZKMON86SO9d81OhtEu/+1BaMuU6QEU
         Hz0GQduU4hcX0yfWelGK5t3J9YYqT9U0cXRFc8tsNRjtlt2I+v3ZhDD1PCJ9SmknYtuI
         3K7A==
X-Forwarded-Encrypted: i=1; AJvYcCWOe5M/EJ1mneUEHEVeS3hzvgvJ70jb77WNEVjMmTM1lYpmPhmeH9TifQMEWthhqJADUs5xurH70Zfk8DdF6+2R3Z0=@vger.kernel.org, AJvYcCX4GXX67v3dx57YNbEa+ygeZCcL93eZ8WOkGRzh2IUoXPIcHKGqOKruwUm+iRQrQ2SXNbnY0OVMDJk=@vger.kernel.org, AJvYcCXPPzFLQhMHEgtOlNUjA56oCp0qYuc9jArRra8TUSYqD2+Q61U1aWKs1enxBFaT9XqOeP0vB6RHyAKU3SA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoVQF9rCKAh3KogQakPrsf5LZ/E/RY+Crg7SWAdOGRJDlnTF9J
	RwEc/8PaFDx7Djit+MgjUIV70pif432OWaQQDuQFVHrSZnbcaHnnLKEExMk8lbTPw2h74U3ZUwC
	Haqgrc0jONBZwHzwXDkmKL94Xx5s=
X-Gm-Gg: ASbGncu73FlRskrNqQk2delyL3+yiyzoGjEWI6e/TIjQXrK/kQl4uKh0T6z65FM+0KZ
	APyn5zWb05/uMSc85zJEf3sF8GcC9HtImA1BFOnfYK8mMhBmMzr/Kri8iqhvp9wxCWDfBBOB5ly
	IS6OigPJE7zv45U/ZGEX7Ik7uxpg==
X-Google-Smtp-Source: AGHT+IFTAmDUJKde03belOS5TpsnGBNkDmHNjKJjx3vvZcaqf4MLygWUc5G7PDzAqFfXGdcNUzcQs/ObOp1WKsP+o/k=
X-Received: by 2002:a17:907:a0c8:b0:abf:497d:a23d with SMTP id
 a640c23a62f3a-ac252ed8d17mr2752406566b.53.1741791578586; Wed, 12 Mar 2025
 07:59:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310143450.8276-1-linux.amoon@gmail.com> <20250310143450.8276-5-linux.amoon@gmail.com>
 <25fa661b-98e4-468b-bb4d-4a2c95f32b71@kernel.org>
In-Reply-To: <25fa661b-98e4-468b-bb4d-4a2c95f32b71@kernel.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 12 Mar 2025 20:29:19 +0530
X-Gm-Features: AQ5f1JpuXbrfqSfBZqHZuJa8hQ7PpVO1Aj4Wg9PCbJZj7yO22_n9i_FjkfaFgs4
Message-ID: <CANAwSgTeZ83oqatrsWQxT+4RYwEtEqma=R4XX_iGrP2N=phz9Q@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] drivers/thermal/exymos: Use guard notation when
 acquiring mutex
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
	"open list:SAMSUNG THERMAL DRIVER" <linux-pm@vger.kernel.org>, 
	"open list:SAMSUNG THERMAL DRIVER" <linux-samsung-soc@vger.kernel.org>, 
	"moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thanks for your review comments.

On Tue, 11 Mar 2025 at 23:00, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 10/03/2025 15:34, Anand Moon wrote:
> > Using guard notation makes the code more compact and error handling
> > more robust by ensuring that mutexes are released in all code paths
> > when control leaves critical section.
> >
>
> Subject: typo, exynos
Ok.
>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > v4: used DEFINE_GUARD macro to guard exynos_tmu_data structure.
> >     However, incorporating guard(exynos_tmu_data)(data); results
> >     in a recursive deadlock with the mutex during initialization, as this
> >     data structure is common to all the code configurations of Exynos TMU
> > v3: New patch
>
> If you ever use cleanup or guards, you must build your code with recent
> clang and W=1. Failure to do so means you ask reviewers manually to spot
> issues not visible in the context, instead of using tools. It's a NAK
> for me.
 Ok, I will check this next time before submitting the changes.
>
> > ---
> >  drivers/thermal/samsung/exynos_tmu.c | 25 +++++++++++--------------
> >  1 file changed, 11 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> > index a71cde0a4b17e..85f88c5e0f11c 100644
> > --- a/drivers/thermal/samsung/exynos_tmu.c
> > +++ b/drivers/thermal/samsung/exynos_tmu.c
> > @@ -12,6 +12,7 @@
> >   */
> >
> >  #include <linux/clk.h>
> > +#include <linux/cleanup.h>
> >  #include <linux/io.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/module.h>
> > @@ -199,6 +200,9 @@ struct exynos_tmu_data {
> >       void (*tmu_clear_irqs)(struct exynos_tmu_data *data);
> >  };
> >
> > +DEFINE_GUARD(exynos_tmu_data, struct exynos_tmu_data *,
>
> I do not understand why do you need custom guard.

I thought this should add a global guard to exynos_tmu_data using
mutex_lock and mutex_unlock.
I'll drop this if it turns out to be unnecessary.
>
> > +          mutex_lock(&_T->lock), mutex_unlock(&_T->lock))
> > +
> >  /*
> >   * TMU treats temperature as a mapped temperature code.
> >   * The temperature is converted differently depending on the calibration type.
> > @@ -256,7 +260,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
> >       unsigned int status;
> >       int ret = 0;
> >
> > -     mutex_lock(&data->lock);
> > +     guard(mutex)(&data->lock);
>
> Which you do not use... Please don't use cleanup.h if you do not know
> it. It leads to bugs.
>
Ok, I will drop this include of cleanup.h.
>
> Best regards,
> Krzysztof

Thanks
-Anand

