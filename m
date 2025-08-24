Return-Path: <linux-pm+bounces-32951-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8F8B32EA1
	for <lists+linux-pm@lfdr.de>; Sun, 24 Aug 2025 11:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3BB2189C355
	for <lists+linux-pm@lfdr.de>; Sun, 24 Aug 2025 09:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6AE235362;
	Sun, 24 Aug 2025 09:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABm0HVpm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739C41993B9;
	Sun, 24 Aug 2025 09:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756026973; cv=none; b=SxeYllvsrXLx7lVRZBdoNNT6e59or8wELTJjLSdm/s3RFJCElxeA1sKOIG9vhfGCt/LtfnGWVp/jZa3HfCU78BsG7IyO4yUoMbRlPP830FY/u3dkA1LtWXR/yX6cIfV7m+nj+N7LzzPX1LmuJiRNNYR8gRwgvaaZm2BR3x3XIlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756026973; c=relaxed/simple;
	bh=vltdun0Ir366v8oeR05ebGfo1micVhANPjnnRJum7jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Je5T0tJuMjh7aEf2KCAC9FfMo9LcPaWkswNxj5+mfafRmAwR3JNO+5MEMrh9r2R0DKce6ND4PpZBypyObWBnPa+hFCKZsYuuPOknSX4TZcZcQq8QVgaV2/skaGvuQ+UdH1N2ykWgFcoL3u5ZAIjBSOcU0BWSS7VE1HaHyJEpX14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABm0HVpm; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3c68ac7e238so845766f8f.1;
        Sun, 24 Aug 2025 02:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756026970; x=1756631770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qycplVaG17ozy+gQ37nIaXbfzWyYCtskzOLodNq2CBc=;
        b=ABm0HVpmUkPII8tQWJ0MAYuhiOnTGfCwpbG7j1pYITd7udDDPy40+t2ZnwWoh1ac9r
         9nRcuM2Kqn+BXOBQsTRJuK8D88fMH29XXtibcVXVINAYT9me0ufps9XurCVE4n5gl374
         8jLcxmJmesryhlGVFq6sAktuqEAx9oWHeZBkRXIkq47zbQiyyzNfLTkzmp+W1bJzDRE4
         YUPXpj2V8ZKBb/Fnlulx7fhYwH1myfg6VmUF/PDijnFc8rpP6RRgeFuOrQwtER9fWzSv
         h5b1+hbB0N03W2o6JNZ4lXVwD/qeoUTr3CvSc5zJitA/KmW9p4AHGAdt9Z5oc+nY4/jJ
         svmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756026970; x=1756631770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qycplVaG17ozy+gQ37nIaXbfzWyYCtskzOLodNq2CBc=;
        b=oEtBsq/WwccLVByxypdKbCTdUUMHWH04AFE3h1qC40B8fX3gkiALUSicaQtEhG7O3o
         3PJmZ++cFfEguJiBBjmQv4NdlaelH5lTbkAyLCY8lCQZL4p1c32ocjkjyxRKvsYhXA+W
         5QvtWPBdmVbbf39iaXDlevgP8mT+/MAXc2a7z9WkUVxg3fjIZqfDcLoCCEYDRGqqlgGB
         IkuzonYELvwEyozo+I/C5+Eg8p1M6MFV/sqZiD5A2Ex3j2wZr+3sxZMo85j57xpsGQz7
         5Rild5MZYJQ7nZARBgk0MZjoFdTa8uap9zeFrKqScambLN+y4uvtKY1j+L51jLGatR4i
         DURA==
X-Forwarded-Encrypted: i=1; AJvYcCUQnTBOumwD71RQRyB/CqHVXcB8w5Dsxi80OWg7qOXaW29jq+8l3P4SadDYrAuMhNWiXYsFcWsg5hCN@vger.kernel.org, AJvYcCWXRuaL9hB6HQGeNkXxnMUb30LELDkS9mGDkNIBx0pqwuVqa8K/kSHjPTzsejomXb/SMWssFb8V1LQ=@vger.kernel.org, AJvYcCX+nt1E7/Pl3DqaAIpiwwCCep5T+fCmDu7IaWGNJJKcwfFh/+dOT6YsiGKI3vXI9qWfUdUr+NxcCBy5V8Nw@vger.kernel.org
X-Gm-Message-State: AOJu0YzT58mDVGoPjwqGJ6mt3OtVzoTQyFriVsuAyXYcDhIsYtKgoUDR
	7i8qO7ZEJuOGpfcunRe6gvajCj61ReEuJee5I3czYWvsDjD8daxrcCYYgmw6NoVBJwAPtqhFsKp
	U8ndcspWo//6eGtyCeTd+WtMaDQ0Lz+E=
X-Gm-Gg: ASbGncvQOCei/7nf1TqkgSxiN0C/aod7PdEsFQJHplk5FiHvKNDJtk7BEyK3RE1DZFp
	lhN8D1d1lVIjAL7k6zewzW4QHP1ngydHrwU1nFRN2B74xh+mwrdAC/4q8ZqKcd8LesF2IDSGuuM
	K0FNDBsi1VKN2kuxzfkP7wCJSBVkmUVqRK82X+9jJjIXgeDlTM1vzNUSG30XOOrXVVI/k4jD/xw
	A+ZnBdA
X-Google-Smtp-Source: AGHT+IGoqGZoj5/ykELmv50FharuJwuPe3ZEr1Fj+gzhs2MscaxfGv+fbtA+RTRRJ0WYpseQKmYnupyydqzuZQ2NAfc=
X-Received: by 2002:a05:6000:42c5:b0:3c7:c2b:afc3 with SMTP id
 ffacd0b85a97d-3c70c2bb400mr2345085f8f.49.1756026969562; Sun, 24 Aug 2025
 02:16:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430055807.11805-1-clamor95@gmail.com> <20250430055807.11805-2-clamor95@gmail.com>
 <aBh9Q8zr2MtfVJtq@mai.linaro.org>
In-Reply-To: <aBh9Q8zr2MtfVJtq@mai.linaro.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 24 Aug 2025 12:15:58 +0300
X-Gm-Features: Ac12FXzu66BJg1idDag35QW0gGD-rf-eugmdFINgxnKS7WF_FI1Dj6nEwfZJ2iE
Message-ID: <CAPVz0n1_8dBT-HP=hPwTcrCh7bvPBsA8My0VOt8isuXVfXAzUw@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] thermal: thermal-generic-adc: add temperature
 sensor channel
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Jonathan Cameron <jic23@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 5 =D1=82=D1=80=D0=B0=D0=B2. 2025=E2=80=AF=D1=80. =D0=BE 11:56=
 Daniel Lezcano <daniel.lezcano@linaro.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Apr 30, 2025 at 08:58:07AM +0300, Svyatoslav Ryhel wrote:
> > To avoid duplicating sensor functionality and conversion tables, this
> > design allows converting an ADC IIO channel's output directly into a
> > temperature IIO channel. This is particularly useful for devices where
> > hwmon isn't suitable or where temperature data must be accessible throu=
gh
> > IIO.
> >
> > One such device is, for example, the MAX17040 fuel gauge.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/thermal/thermal-generic-adc.c | 55 ++++++++++++++++++++++++++-
> >  1 file changed, 54 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/th=
ermal-generic-adc.c
> > index ee3d0aa31406..7c844589b153 100644
> > --- a/drivers/thermal/thermal-generic-adc.c
> > +++ b/drivers/thermal/thermal-generic-adc.c
> > @@ -7,6 +7,7 @@
> >   * Author: Laxman Dewangan <ldewangan@nvidia.com>
> >   */
> >  #include <linux/iio/consumer.h>
> > +#include <linux/iio/iio.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/platform_device.h>
> > @@ -73,6 +74,58 @@ static const struct thermal_zone_device_ops gadc_the=
rmal_ops =3D {
> >       .get_temp =3D gadc_thermal_get_temp,
> >  };
> >
> > +static const struct iio_chan_spec gadc_thermal_iio_channels[] =3D {
> > +     {
> > +             .type =3D IIO_TEMP,
> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),
> > +     }
> > +};
> > +
> > +static int gadc_thermal_read_raw(struct iio_dev *indio_dev,
> > +                              struct iio_chan_spec const *chan,
> > +                              int *val, int *val2, long mask)
> > +{
> > +     struct gadc_thermal_info *gtinfo =3D iio_priv(indio_dev);
> > +     int ret;
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_PROCESSED:
> > +             ret =3D gadc_thermal_get_temp(gtinfo->tz_dev, val);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             return IIO_VAL_INT;
> > +
> > +     default:
> > +             return -EINVAL;
> > +     }
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
> > +     indio_dev =3D devm_iio_device_alloc(dev, sizeof(*gtinfo));
> > +     if (!indio_dev)
> > +             return -ENOMEM;
> > +
> > +     gtinfo =3D iio_priv(indio_dev);
> > +     memcpy(gtinfo, gti, sizeof(*gtinfo));
>
> Why copy the structure ?
>
> Copying the thermal zone device pointer should be enough, no ?
>

iio_device_alloc created its own copy of struct gadc_thermal_info
hence memcpy is used to fill struct gadc_thermal_info allocated by iio
using struct gadc_thermal_info from gadc, or how do you propose to
handle this? Maybe you could provide a code example for better
understanding.

> > +     indio_dev->name =3D dev_name(dev);
> > +     indio_dev->info =3D &gadc_thermal_iio_info;
> > +     indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +     indio_dev->channels =3D gadc_thermal_iio_channels;
> > +     indio_dev->num_channels =3D ARRAY_SIZE(gadc_thermal_iio_channels)=
;
> > +
> > +     return devm_iio_device_register(dev, indio_dev);
> > +}
> > +
> >  static int gadc_thermal_read_linear_lookup_table(struct device *dev,
> >                                                struct gadc_thermal_info=
 *gti)
> >  {
> > @@ -153,7 +206,7 @@ static int gadc_thermal_probe(struct platform_devic=
e *pdev)
> >
> >       devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
> >
> > -     return 0;
> > +     return gadc_iio_register(&pdev->dev, gti);
> >  }
> >
> >  static const struct of_device_id of_adc_thermal_match[] =3D {
> > --
> > 2.48.1
> >
>
> --
>
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog

