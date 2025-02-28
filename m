Return-Path: <linux-pm+bounces-23176-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5E3A49A68
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 14:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37DEB173F6C
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 13:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D0126D5BF;
	Fri, 28 Feb 2025 13:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJGgvPX1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D981126BDA3;
	Fri, 28 Feb 2025 13:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740748935; cv=none; b=FpB5DfDARfkG8svp+ESyGzeQkrUgbyLWxM4sx99uZwaSZ/+B0n9tDoyXcRFTByJ/YIoE/SGGu7Thcshfm0aAPwMUjAOkvgYfEpJ6hcfwwJDkbxE/+4rZn1uFOIq8hmUeHW0w2cAHB4Bo2MNoGpOpr/KbnLo1seC8RSbuOKC28RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740748935; c=relaxed/simple;
	bh=Kz7tQ7V+0+WAQoonVHNEEJH3MiDZITaZpOzO7CDVJMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VKj1gkpAUSUb0H+o1Or+dXGALR71oB6OUTSsDAtkpxtGUElQNfbZW9vX1nJv2C2qiYUo8kAwP3w388EUTkwimZ2b070WOSTcA8SishzD0dHy9AekZUrAE2YYzwmmPpOfvQ125tufJwiI/ZeK02UWey4OxjI4sYU5YuvsE03/2vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJGgvPX1; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-390ec7c2d40so743795f8f.1;
        Fri, 28 Feb 2025 05:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740748932; x=1741353732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLCskdkyDjKVzUbxWO5nRc2aTnNTpaWoydhtK7t4lAA=;
        b=dJGgvPX1hkaccIYPc/qRD6g2Rdg8d/IUhokspQrQKp6ZRzs6wEd8fTk+GEgz14zWu1
         Mt4YXejbw4rETgkKuj7c32F3+wlAwW+emaKo7po9Zydo7WJGI97hwEUEC3SAKgJ1vE2f
         HmsuCTUQa/twYZw/Dzj0D9FJkHBCUAEcGeHwhDLcZDaLMJ/XkotIcww8AQ2u+USiaCE/
         DR0bAjE9b0acRAofFAsdKJwAdjQMKwVoyXkAX9iyywAWcGFEq4fHwWqG2KZ/yO8cAzjO
         t0CqIygYQ5/x/q9GPkd3BwrDahgewJJ+2VTFO1Xb6x/g02fONbiqcAXC0wtwuZAx7WDb
         ijug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740748932; x=1741353732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLCskdkyDjKVzUbxWO5nRc2aTnNTpaWoydhtK7t4lAA=;
        b=FXufwooiPBwNjQWBwrW9SQQl5Ham/gRiMDxB6TwXVUQ6ZA5yO21mksVNUz4MGY24b6
         oHwpJa02EfJQB2RBembQE0BtYceobm2aNaF7a7oF6CC4Li2vfPMfmb27jZi61DsEgGuh
         QBBCudJ2piUl4GYm6st/tvx3uSYx0RNM6o5JGwrI2zAiHGbnvVoLHacLDKFse4WP+mFp
         bEloUmM/PPun1cihz4Vt5lXK2w7iNQkOh9MtIrZfaorZgNYK6kTxJMAFOy/3WgRSqVqZ
         9StzhajFKR2yrpK4szsE++uGpnkAEdFYVqtERIAZCj43zuhcj1Th9nUy46Kp4g0QAgLB
         u5/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW39YshyP/9q0ijekT5BcMS0UZWWiONEG2x3FfNMKdAYIRoMp9Ezqehvlj+/r+Ao/YJXUakP6fK6Mxx@vger.kernel.org, AJvYcCXQgwSOLvsEa0lsJjQjKSwCvBkHz8pZpjl9z2aJ0/c597I1eE5nVRTOlsS1zKcCS7ZPK3QuGnc886a96dKy@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4y1jSdGjM8CfdCnnQvoBMRrByT4O1gwrJEn4VHm1iES+zxG4C
	ljCHrkzAWXgI3V6cHbBAHz+24rOklxa860HmMQmMnYQO2uumEj3yNJJFKIGKUPxNsm9G323hTri
	Akwmte5XMpXjaQbNF3ry2yLAZ9Tw=
X-Gm-Gg: ASbGncusqYr8nIKVfgbp3eqncq5R94oQawdi2Os7OpMZwJFuMvhVz8dSFM4pDICm9XD
	tbLc/QHB0AD9BG4mUGRxYaMva7P7pYbzqLf+pJqqXKC3+LQd9Ju+YWw3ohain0u7uOEeGPRxsLH
	lzPGVLXDRA
X-Google-Smtp-Source: AGHT+IEWGseohuDp7KhNAY0LdcYgEQH/Rbd9LdHbvgH4CFd0eo6h8IeKxvf7p55tqbikbGe86i4k9z8m3nzpWQsmL8w=
X-Received: by 2002:a05:6000:401f:b0:38d:d664:67d8 with SMTP id
 ffacd0b85a97d-390ec7c6738mr3084072f8f.11.1740748931828; Fri, 28 Feb 2025
 05:22:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219082817.56339-1-clamor95@gmail.com> <20250219082817.56339-3-clamor95@gmail.com>
 <99ee61dc-abd5-45d9-8d26-a8f0ae94c8eb@arm.com>
In-Reply-To: <99ee61dc-abd5-45d9-8d26-a8f0ae94c8eb@arm.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 28 Feb 2025 15:22:00 +0200
X-Gm-Features: AQ5f1JqiEG1tJRPj2HmNZIqvEspltfMFIDE6rFA4YikSqMAQilmFeeVoGxd-Kho
Message-ID: <CAPVz0n0uWEY+-evrfpci9-1c3icGyHfTHMbXi=P9Sv=Uh3AUaA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] thermal: thermal-generic-adc: add temperature
 sensor channel
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 28 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 15:11 Luka=
sz Luba <lukasz.luba@arm.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> On 2/19/25 08:28, Svyatoslav Ryhel wrote:
> > Add IIO sensor channel along with existing thermal sensor cell. This
> > would benefit devices that use adc sensors to detect temperature and
> > need a custom conversion table.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >   drivers/thermal/thermal-generic-adc.c | 54 ++++++++++++++++++++++++++=
-
> >   1 file changed, 53 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/th=
ermal-generic-adc.c
> > index ee3d0aa31406..a8f3b965b39b 100644
> > --- a/drivers/thermal/thermal-generic-adc.c
> > +++ b/drivers/thermal/thermal-generic-adc.c
> > @@ -7,6 +7,7 @@
> >    * Author: Laxman Dewangan <ldewangan@nvidia.com>
> >    */
> >   #include <linux/iio/consumer.h>
> > +#include <linux/iio/iio.h>
> >   #include <linux/kernel.h>
> >   #include <linux/module.h>
> >   #include <linux/platform_device.h>
> > @@ -73,6 +74,57 @@ static const struct thermal_zone_device_ops gadc_the=
rmal_ops =3D {
> >       .get_temp =3D gadc_thermal_get_temp,
> >   };
> >
> > +static const struct iio_chan_spec gadc_thermal_iio_channel[] =3D {
> > +     {
> > +             .type =3D IIO_TEMP,
> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),
> > +     }
> > +};
> > +
> > +static int gadc_thermal_read_raw(struct iio_dev *indio_dev,
> > +                              struct iio_chan_spec const *chan,
> > +                              int *temp, int *val2, long mask)
> > +{
> > +     struct gadc_thermal_info *gtinfo =3D iio_priv(indio_dev);
> > +     int ret;
> > +
> > +     if (mask !=3D IIO_CHAN_INFO_PROCESSED)
> > +             return -EINVAL;
> > +
> > +     ret =3D gadc_thermal_get_temp(gtinfo->tz_dev, temp);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     *temp /=3D 1000;
> > +
> > +     return IIO_VAL_INT;
> > +}
> > +
> > +static const struct iio_info gadc_thermal_iio_info =3D {
> > +     .read_raw =3D gadc_thermal_read_raw,
> > +};
> > +
> > +static int gadc_iio_register(struct device *dev, struct gadc_thermal_i=
nfo *gti)
> > +{
> > +     struct gadc_thermal_info *gtinfo;
> > +     struct iio_dev *indio_dev;
> > +
> > +     indio_dev =3D devm_iio_device_alloc(dev, sizeof(struct gadc_therm=
al_info));
> > +     if (!indio_dev)
> > +             return -ENOMEM;
> > +
> > +     gtinfo =3D iio_priv(indio_dev);
> > +     memcpy(gtinfo, gti, sizeof(struct gadc_thermal_info));
> > +
> > +     indio_dev->name =3D dev_name(dev);
> > +     indio_dev->info =3D &gadc_thermal_iio_info;
> > +     indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +     indio_dev->channels =3D gadc_thermal_iio_channel;
> > +     indio_dev->num_channels =3D ARRAY_SIZE(gadc_thermal_iio_channel);
> > +
> > +     return devm_iio_device_register(dev, indio_dev);
>
> I don't get the idea why we need iio device, while we already have the
> hwmon.
>

Idea behind this is to be able to convert adc iio channel into temp
iio channel without introducing a new sensor which will duplicate
behavior of existing one (by this I mean conversion table use). Not
all devices can or have to use hwmon and some may require iio channel
hooked up.

Real life example. I own a device (LG P985) which has a fuel gauge
that does not support battery thermal readings. Vendor provided a
dedicated adc sensor and one of its channels is used as thermal sensor
with device specific conversion table. Fuel gauge on the other hand
supports linking in a dedicated temp iio channel to get thermal
readings.

> Could you explain this a bit more, the cover letter also misses
> such justification and details.
>
> Regards,
> Lukasz

