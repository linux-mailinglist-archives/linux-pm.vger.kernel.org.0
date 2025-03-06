Return-Path: <linux-pm+bounces-23553-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F141AA546E9
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 10:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12F5117497C
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 09:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C971220AF69;
	Thu,  6 Mar 2025 09:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l38UIdFg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA86220A5C1;
	Thu,  6 Mar 2025 09:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254610; cv=none; b=YF7D4wE1RZnEpmLzCMibx/2ILlaynbR8rORZz74MysYpiq10rRlaYZ8W4pkKu2PCexHlmO4Td/Lvu0uSvnBdk3kHJMimssWcS+dv7+Tnw49IgYhxO7smlLOE/gyv5zf5iA2gBx3NkYrog8pokq/AvbOkLmPPWQIN4lfjIxqSinQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254610; c=relaxed/simple;
	bh=e/AROmtNQA02sSTZ4A2FXigthR1D6TwSo1b/w26IaUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/pOVlcCUcgACaXm9G2TJBRTOFcMK5XuAGRAWgM/myNQ6dSg/GE6kUoOol/jevEcn4iZuwV1HWMGaY+6qChnaa8aPK0qdxVUTKQfUfG862NKCNgW+hi+iC6VBzOwoU2ceBSy0nVwVQa2pxMcEtxqyr8533dJxY9sq7DJIR/cPxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l38UIdFg; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-390e702d481so233324f8f.1;
        Thu, 06 Mar 2025 01:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741254607; x=1741859407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZbn0ZWk1+rvuFKVTnqNPyrfKXHkL/ZMvNqwP+kgElY=;
        b=l38UIdFg955w9D+jMVU4EcxJXQa6S0sern+d6jsHjl/hpCwZeIrkloveRzdEVKUJ7J
         Irg6v+u++FLJ1WlbNs7t+zfzeGFKYImfM6ReWbKpCm0kCP2LnqU88bG0FQoId+GqVooK
         kKIQuR53PrOCyngbC0y2Fy8xBOlsZ3lVZ1YSeVz/6zl537IXAf/Vua9GSGiXWD70hIma
         s6n101sE07HeQJ9dQkAZxJlpVh5Y58aF1CldCU4sZYfuti+XQ8eYVItajAhtqrEy6Eiw
         qP1H8tD6fJQH8JczZWlnYhHQu6nDqLXbKDO1E+7lMbYV7kDud5S01axptDEUyizu0ino
         fQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741254607; x=1741859407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZbn0ZWk1+rvuFKVTnqNPyrfKXHkL/ZMvNqwP+kgElY=;
        b=F798f8yYYxpLtMkNPgD4mex53PHbgmIFOmyHk029mdx54+ad2ulW22MPxvRD4u+JpP
         /BVUyNQrhlOdUJa69ZWsPPbTlRGT3Td31+HjWb9v6qFNYXYsPn7SLxyu/dcWZBl7oolB
         DAbhFIxPlen9tpVLt7b73xh0/KZnyqQ4oh0Tq4p3lQkMZP5+ZoP4A9mhXta30gCgLZbj
         cVe1FLpaCwvTDIQ+cfvF4JBDrV8URTnSGq+tLwMazD0MsCyn655culBwvLsQxC5H+rQ8
         dMiWm9bBpQFnd6t6elfs6T1MefoshykHt1jiC7plqLSsW311x8Eiyu99uyKYwWlhKGkR
         PLZA==
X-Forwarded-Encrypted: i=1; AJvYcCUCcR+2aqEzZRCWEk4WlqvRpUjIE25WldJEuEaQ4FxqVThf6rV9a4EkAOQwVMZ216lsc6MgeuVd6v2V@vger.kernel.org, AJvYcCXHeUuwKVGlO7cUOgHVdLFgGe6yUdbtQj4nqTb/a1cq5dVOCuA31w58INfhrX+uC4rn8ytVu7d62x4V13RB@vger.kernel.org
X-Gm-Message-State: AOJu0YwEfRcIo2xZlJqEaTmU9pfERCqboDkOfgZi+T2fZQ2oI3FVkFUx
	ntikvDdAmV+eYFk6XHrQV3pfbF6VTBNQ5Ud7UzcHiIfDSRxNzn3j+dJXXIru1c/fQWFzFJlIHtP
	h2A6pFnFUFGVFitc08Hd9GOjqP38=
X-Gm-Gg: ASbGncuhS87Qf7xwGFTFRxm7GmZV2dkUoxULGsSfIfYd1QS6wx52UIB+95AlE8jHEp/
	wyNYkIWBaw7XLLzesiG7g0qFTZUAQgirqPZgHL/yzNXkO2Q2TRoVUWW4+GG1miLdh3W3wMe39h4
	AByarc27WssIPeCm57AEolPsldzoU=
X-Google-Smtp-Source: AGHT+IHsd4hBnwqBMV6hYs1c9OgJ34UfLr66Fmw5hh4VbcZbcNnGwo18Hw3rs1KLCrQQNBpTyvxsy6Y6md6nFJblGKw=
X-Received: by 2002:a05:6000:1a8f:b0:390:e7c1:59d3 with SMTP id
 ffacd0b85a97d-3911f72620bmr5556599f8f.2.1741254606826; Thu, 06 Mar 2025
 01:50:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303122151.91557-1-clamor95@gmail.com> <20250303122151.91557-3-clamor95@gmail.com>
 <3bc7c5a5-8fe7-4c4b-a80e-23522922debb@arm.com> <CAPVz0n0yvw4kyYKSve9sSZEvcZrCYZ6RqCjFSO5OCqtvRZSfJg@mail.gmail.com>
 <f56596fe-92e8-481b-b15b-29b531eaec32@arm.com>
In-Reply-To: <f56596fe-92e8-481b-b15b-29b531eaec32@arm.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 6 Mar 2025 11:49:55 +0200
X-Gm-Features: AQ5f1JpB7S5f4HnXIbqgzShFt_D77QbK0bshvECgENO_LYSZuaLirvex7ZfhGe8
Message-ID: <CAPVz0n2ywjm+nLQ+ZAYbR1P6yCr8FQgOMeDT07s_YHZ7xA_6uA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] thermal: thermal-generic-adc: add temperature
 sensor channel
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 5 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 16:37 Lukas=
z Luba <lukasz.luba@arm.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
>
>
> On 3/5/25 10:06, Svyatoslav Ryhel wrote:
> > =D1=81=D1=80, 5 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 11:52 L=
ukasz Luba <lukasz.luba@arm.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >>
> >>
> >>
> >> On 3/3/25 12:21, Svyatoslav Ryhel wrote:
> >>> To avoid duplicating sensor functionality and conversion tables, this=
 design
> >>> allows converting an ADC IIO channel's output directly into a tempera=
ture IIO
> >>> channel. This is particularly useful for devices where hwmon isn't su=
itable
> >>> or where temperature data must be accessible through IIO.
> >>>
> >>> One such device is, for example, the MAX17040 fuel gauge.
> >>>
> >>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> >>> ---
> >>>    drivers/thermal/thermal-generic-adc.c | 54 +++++++++++++++++++++++=
+++-
> >>>    1 file changed, 53 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/=
thermal-generic-adc.c
> > ...
> >>>
> >>> +static const struct iio_chan_spec gadc_thermal_iio_channel[] =3D {
> >>> +     {
> >>> +             .type =3D IIO_TEMP,
> >>> +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),
> >>
> >> I would add the IIO_CHAN_INFO_SCALE and say it's in milli-degrees.
> >>
> >
> > I have hit this issue already with als sensor. This should definitely
> > be a IIO_CHAN_INFO_PROCESSED since there is no raw temp data we have,
> > it gets processed into temp data via conversion table. I will add
> > Jonathan Cameron to list if you don't mind, he might give some good
> > advice.
>
> I'm not talking about 'PROCESSED' vs 'RAW'...
> I'm asking if you can add the 'SCALE' case to handle and report
> that this device will report 'processed' temp value in milli-degrees
> of Celsius.
>

It seems that SCALE is not applied to PROCESSED channel. I can use RAW
which would work as intended and I will add a note in commit
description why I used RAW. Would that be acceptable?

> >
> >>> +     }
> >>> +};
> >>> +
> >>> +static int gadc_thermal_read_raw(struct iio_dev *indio_dev,
> >>> +                              struct iio_chan_spec const *chan,
> >>> +                              int *temp, int *val2, long mask)
> >>> +{
> >>> +     struct gadc_thermal_info *gtinfo =3D iio_priv(indio_dev);
> >>> +     int ret;
> >>> +
> >>> +     if (mask !=3D IIO_CHAN_INFO_PROCESSED)
> >>> +             return -EINVAL;
> >>
> >> Therefore, here it would need to handle such case as well, when
> >> a client is asking about scale.
> >>
> >>> +
> >>> +     ret =3D gadc_thermal_get_temp(gtinfo->tz_dev, temp);
> >>> +     if (ret < 0)
> >>> +             return ret;
> >>> +
> >>> +     *temp /=3D 1000;
> >>
> >> IMO we shouldn't cut the precision if it's provided.
> >> The user of this would know what to do with the value (when
> >> the proper information about scale is also available).
> >>
> >
> > The it will not fit existing IIO framework and thermal readings will
> > be 1000 off. I have had to adjust this since my battery suddenly got
> > temperature reading of 23200C which obviously was not true. With
> > adjustment temperature will be in 10th of C (yes, odd, I know but it
> > is what it is).
>
> Your battery driver should get and check the 'SCALE' info first, then
> it will know that the value is in higher resolution than it needs.
> Therefore, it can divide the value inside its code.
> Your proposed division here is creating a limitation.
>
> You shouldn't force all other drivers to ignore and drop the
> available information about milli-degC (which is done in this patch).

