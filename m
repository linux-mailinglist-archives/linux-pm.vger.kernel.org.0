Return-Path: <linux-pm+bounces-23479-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46631A4FB34
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 11:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B52C3A4F70
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 10:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB742066CB;
	Wed,  5 Mar 2025 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKLw6V8S"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F54C2063EC;
	Wed,  5 Mar 2025 10:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169217; cv=none; b=SPRFkzGn/Gio96T7WOawAL24Yzg5p8LClXeaq9XhtrZ5n2uSSx41QiwKnAog7V1ysnqrfTmj6l3nRA7p/6LbZCsVcwcRDe452M9ZoVeLp60nM8KTrtifztJv7K6tN9J4MczMpQNQCH5zJ5OP5CUq0yXKYaNdag+ThoTCuvovGLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169217; c=relaxed/simple;
	bh=7mW84T2xkd5hZo8Si0Lg8PdibLPx+CpJNVnvqcfgn1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMn5Qp7gk8MlQidzj5d/iNxTrc9sDjZW6FD9/vsjofr+PIvJUS3AeMFl2X+3uelEfsomIu5wU+NrxLeowO6ebZNkC8AfSM5WuwQXpHjw/0iBlabZKU8fuiv7oGmiOeZQORYIPJhCcP2gmKt07fsVfOlQF8ojGsNwKwscB08Kje8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKLw6V8S; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so44795115e9.0;
        Wed, 05 Mar 2025 02:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741169214; x=1741774014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/XiUyM1cjoAZ3Fq3HTmJQRtIFmpmpxkpsux4nn4QUS0=;
        b=IKLw6V8SpSHX9x+UZJqNX6UBMZSz4zoMIF8jErqfiN3ELNOwbtflii/PZP1XNFk34K
         pHaCLAWSjszrDGOfwcvgqvy1XJIlrt9vzBF6tvymZr7LfRA5sXnCbpWmlRQPBmX0U+Ra
         8i8PCdhFdZu4YVV1L1QZTQW2QrBKMF2DYKfEAK4uFJUArA61FZmc7ERE3av3uA+nDB/+
         X1pdcrnZVy3zVZ5MQEuJ065d7aQ/CuO/IjgdwuhfuAoF07klrje5ImELjayl9nv8HDWK
         TuvURPI0Xyb44JfdrPjlWJajRuNLnQAvwnWNOoin2BYVa1lP4u9fhKLVCdvBrHEhLiZd
         QBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741169214; x=1741774014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/XiUyM1cjoAZ3Fq3HTmJQRtIFmpmpxkpsux4nn4QUS0=;
        b=GKeWdP09cZE1GlvjNAUFAtrnUyvH0K0EP3uw2aqGeb8HaHGM4G4rNhCklAUVgsj9lO
         dVpmhg0v6FtJUBGp964uXSjh8qarKS+XawGuxw6/zWsdITUvn4l18dwQUKSkNc7o2saF
         pf7aX1IHkUrYRgGnx045If/ke4lPlPazJoPr7q82Z/DBZFwn3ghF1/u2kV2BlUCFHDLd
         /a7hov4gexX3gu/Sj+RwH1I+SQStqFV7qBViVgfOZwj4s/3TJK9krEa8AvQKDzdTyIkv
         VXx0i0tlH0vwVswM177SK3QL6cVV9Kqvqjj2iaVEJ6su+ukbNqDN6Q9T7C/ThSZKhxKL
         GmyA==
X-Forwarded-Encrypted: i=1; AJvYcCUBnjSOuhLCv2FrE/dDRyA0SSILztIypJbOzG0KdppxvH3k5QHWWTbXXsr6p6YoFGob3bxm6j0WzgKH@vger.kernel.org, AJvYcCWjPt2CnbjkH2Eih/V2TWI0ax0oO5Ctsue3AOUAamkbv8LNjn971ET8N2ba8f4ubcl4/3CfmfqfuZaQW1NR@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ06/E2vSIsRO4WjdGQmqSeDF7aSr9etMXfv6drXON7nyc9B+L
	s+M8eKQOUdcPI9QFsfJ+BjkKyumtqxUdqcCLaXJIRWvttmgQH0/ngXj5er+owCLelWjubLyX1Bt
	rGlusj3P+m3wcGijqptAN8ffn/zxi6g==
X-Gm-Gg: ASbGncuK0YbCYyw/VVK/iqOuaOspN0jUkx9jo8kWcxK8H6lsksgnSk4P+RF6iMTcASf
	tJdCXbErz4G7QvdMKTFzr29Aex14R0PiwgJVOnPd+oB34AwEX3e3oJQgBR9K+ros7dXbWKHUzUP
	37CQmDG5vkZQae1O/HvW4a6ca7yek=
X-Google-Smtp-Source: AGHT+IGQH+0028oYkS9R42msg5Mdw52+1P4tasiG7/x6wWOSR515axfyVGE8a2y8KNU5JqOHDqSEEeXQ/KKwV9F6k1o=
X-Received: by 2002:a05:6000:1562:b0:38d:e6f4:5a88 with SMTP id
 ffacd0b85a97d-3911f749c86mr1771121f8f.12.1741169213604; Wed, 05 Mar 2025
 02:06:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303122151.91557-1-clamor95@gmail.com> <20250303122151.91557-3-clamor95@gmail.com>
 <3bc7c5a5-8fe7-4c4b-a80e-23522922debb@arm.com>
In-Reply-To: <3bc7c5a5-8fe7-4c4b-a80e-23522922debb@arm.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 5 Mar 2025 12:06:42 +0200
X-Gm-Features: AQ5f1JqU5aUOk5hQVwJSEFLdBo0lSQrvsWdK1fX1d4Z1ojd4eLF6lCxxEmO0RYc
Message-ID: <CAPVz0n0yvw4kyYKSve9sSZEvcZrCYZ6RqCjFSO5OCqtvRZSfJg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] thermal: thermal-generic-adc: add temperature
 sensor channel
To: Lukasz Luba <lukasz.luba@arm.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	Laxman Dewangan <ldewangan@nvidia.com>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 5 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 11:52 Lukas=
z Luba <lukasz.luba@arm.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
>
>
> On 3/3/25 12:21, Svyatoslav Ryhel wrote:
> > To avoid duplicating sensor functionality and conversion tables, this d=
esign
> > allows converting an ADC IIO channel's output directly into a temperatu=
re IIO
> > channel. This is particularly useful for devices where hwmon isn't suit=
able
> > or where temperature data must be accessible through IIO.
> >
> > One such device is, for example, the MAX17040 fuel gauge.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >   drivers/thermal/thermal-generic-adc.c | 54 ++++++++++++++++++++++++++=
-
> >   1 file changed, 53 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/th=
ermal-generic-adc.c
...
> >
> > +static const struct iio_chan_spec gadc_thermal_iio_channel[] =3D {
> > +     {
> > +             .type =3D IIO_TEMP,
> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),
>
> I would add the IIO_CHAN_INFO_SCALE and say it's in milli-degrees.
>

I have hit this issue already with als sensor. This should definitely
be a IIO_CHAN_INFO_PROCESSED since there is no raw temp data we have,
it gets processed into temp data via conversion table. I will add
Jonathan Cameron to list if you don't mind, he might give some good
advice.

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
>
> Therefore, here it would need to handle such case as well, when
> a client is asking about scale.
>
> > +
> > +     ret =3D gadc_thermal_get_temp(gtinfo->tz_dev, temp);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     *temp /=3D 1000;
>
> IMO we shouldn't cut the precision if it's provided.
> The user of this would know what to do with the value (when
> the proper information about scale is also available).
>

The it will not fit existing IIO framework and thermal readings will
be 1000 off. I have had to adjust this since my battery suddenly got
temperature reading of 23200C which obviously was not true. With
adjustment temperature will be in 10th of C (yes, odd, I know but it
is what it is).

> > +
> > +     return IIO_VAL_INT;

