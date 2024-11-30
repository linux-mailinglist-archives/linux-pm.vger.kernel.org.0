Return-Path: <linux-pm+bounces-18264-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 633539DF036
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 12:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1822916236A
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 11:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B17D189F37;
	Sat, 30 Nov 2024 11:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJXYOaFr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BBA15990E;
	Sat, 30 Nov 2024 11:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732966715; cv=none; b=oDwr5cm+mDd6M9mPQFU4rIXlSuJQTz867oyacFRX+X/WeLRN2em79ox8cxweAee77ieyJEeJCcrbSMiGgqoxQjDX817MA7ZiECRhc9/a6CEtXG2YNrsj2PrQVXxm23oKmHwSLwp27EWJnoXY6TVb0d5TYPRoL7Pb0j2qbQtA7Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732966715; c=relaxed/simple;
	bh=llwMWTWTWdxE0Hpd9KZKubPcqkDdkWEnwBHV/Go2mvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNz6f6wsA3guxvwjLVlwMF5+2XjIzvHb6E413N1nRfLdjit4j3ZlcaTcbOgDKNFggD+XIhbjvIWaOp5bHg8SQ1IgP+7VuISLa2qqi4CfaemVrFiScPEpp44ZdK3/m2IRZMQoOx93BWTH6r5cI3CAnoOgLvSghIXEsPmEVUcPCMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJXYOaFr; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-856e7bc5651so1570286241.0;
        Sat, 30 Nov 2024 03:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732966712; x=1733571512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbrr2qfB6+/BjJuq7E43lJE1sJas5MBGpSJDZ+XWZO4=;
        b=eJXYOaFrsK7Yy2du7WmIEQmRindZajWqBehrpZlIt1RjUn36YyGlTkvGHkoReG7Jjh
         6F8N5iWZd5EBZeGjHZXf+WYEJ6wBZji9kJjfAhUjU92AYnffxsmoPHkNxdi4D9e16v2C
         Zvb6uZKropQdXliRABiWjRB5oOvrDwm4Optr2wh9fPbZFPt7LcE756sU0dWvFP3C4K0j
         RREQExnwZasnlkMNjtqDRy4VSJfyHw70I8Y5d8WtCK82uvDq+Zb1VlHKTzwbSFJfG8xU
         sJBWSvItbwruLRICbZc8D0i+vmn6VsnQiGyBEIGrzryIsxcr0QXvhobLcJA4MZSmGv7j
         29dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732966712; x=1733571512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbrr2qfB6+/BjJuq7E43lJE1sJas5MBGpSJDZ+XWZO4=;
        b=BUOd0D1qCLfm3ZJRjqj/WgMZ1X0Mosm1oJbvGbNeajs9quGgO/WDQ/bw5IWmXk07Mj
         GRjFsgdN8Xn3lZ3/l/NLfcUv/4J5rk/RjsRWz04Lh8WqqMpvgbl+dL6QBtr8fDadwyHI
         oF2+zARv7pnqoBU1yF4w0Xisuu2ygnSETmlqxxA6xWRCppuSRjwr2FikFBGUDSSm0wP7
         6/zDBVXiKvJNKAuul8Qs2CxVqb5RNy0qlx6wJOnOAKLk+2zAPjhhX8UH4jBZqqpq8zrw
         WNL//wf3raJjUeffr6Scps9QhKgOOmIPyYnutiCjyYxT4Lx8xB4qquRj2RayGKLc8vdw
         kwQg==
X-Forwarded-Encrypted: i=1; AJvYcCUtFtUjqNtt11OQETWeM9if6ga3t57lAfU4g4qpSItn6f7DDwk0Fzq882effNOrLK5HmFWkQESiTQY=@vger.kernel.org, AJvYcCW+L8hYv+4ODWfIXUZN7rPb4Zepr+NJOAyR1pToR7Jhh+CV0k8Qcjj95WSk8Vn5WVOq9B1g6ykVEJJMT4/tIZV+Tkk=@vger.kernel.org, AJvYcCW6Zp9olCuMnhvvvF4D/I/XNeZSGW+6kaI30uzBoIMGFQf7nUPsgrUGwHli5mvmKfAOAqxknxOp61+C@vger.kernel.org, AJvYcCWqsyTzIL508OCzUZ0pPvqS23msn4U/GapUr+7jcnTvtRf8ckquZ3Ct7TTpM+PYqEOPSmrElAtv47MHa41aEQ==@vger.kernel.org, AJvYcCX7q9oFyjWKdSUIHCdt5JWngaR49T3s2n6NyK+JkFp9g7P7jWaLTxNs+klMNsMqUBi6mmtlrvX3OqzhQM4S@vger.kernel.org
X-Gm-Message-State: AOJu0Ywto91/sXJd4aO9rcr8ihvG7GQ9bbjxjjF0Z5gHb65QYz0i1gaf
	X/JsXb/jH4cQOqoF+iQuywcvjSWbc0sT3+jFbak/nvwmQ0NRjLCFYbtc7poIPTCvPActApQ0Hpr
	FZBOS31WpIkwN7irr+3quTWXEjhI=
X-Gm-Gg: ASbGncuh80iUqb8Kk0PRiB0Mocy6cvzMOqCDjguX59GMnOsGVQrHGRJdRyhphRN6n1C
	2bMmHwkTzTQuTgBHoXV22kQqJQ3eraQ==
X-Google-Smtp-Source: AGHT+IEOjlIPuE+ZgXLyvfndQVoFGvXTAQTOLhdzhSDM04yBi3Tp+D0cxFQCuCqvm5sj20DBHerEXbDd1U2rr4EjqZ4=
X-Received: by 2002:a05:6102:1519:b0:4af:586c:6197 with SMTP id
 ada2fe7eead31-4af586c620emr14093624137.0.1732966712559; Sat, 30 Nov 2024
 03:38:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108-b4-max17042-v4-0-87c6d99b3d3d@gmail.com>
 <20241108-b4-max17042-v4-2-87c6d99b3d3d@gmail.com> <a7182597-b45e-40cf-baeb-60f69ec2365d@marvell.com>
In-Reply-To: <a7182597-b45e-40cf-baeb-60f69ec2365d@marvell.com>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Sat, 30 Nov 2024 14:38:21 +0300
Message-ID: <CABTCjFB9ybKmNh-xuF0qaWQc_j4zNXW36vimdrEPh2hzP1VsBw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] power: supply: max17042: add platform driver variant
To: Amit Singh Tomar <amitsinght@marvell.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, 
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, Purism Kernel Team <kernel@puri.sm>, 
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 29 =D0=BD=D0=BE=D1=8F=D0=B1. 2024=E2=80=AF=D0=B3. =D0=B2 17:0=
3, Amit Singh Tomar <amitsinght@marvell.com>:
>
> Hi,
>
> >
> > The solution here add and option to use max17042 driver as a MFD
> > sub device, thus allowing any additional functionality be implemented a=
s
> > another sub device. This will help to reduce code duplication in MFD
> > fuel gauge drivers.
> >
> > Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> > ---
> > Changes in v4:
> > - rename module_init and module_exit fuctions
> > - rework max17042_init
> > - assign chip_type in probe function
> > - pass i2c_client as pointer on pointer, to use same pointer created in
> >     MFD. This allows devm_regmap_init_i2c to cleanup gracefully.
> >
> > Changes in v3:
> > - pass dev pointer in max17042_probe
> > - remove prints
> > ---
> >    drivers/power/supply/max17042_battery.c | 116 ++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----=
-------------------
> >    1 file changed, 92 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/su=
pply/max17042_battery.c
(...)
> > +static int max17042_platform_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct i2c_client **i2c =3D dev_get_platdata(dev);
> This seems a bit unusual; can't we just use:
> struct i2c_client *i2c =3D dev_get_platdata(&pdev->dev); instead?
> > +     const struct platform_device_id *id =3D platform_get_device_id(pd=
ev);
> > +
> > +     if (!i2c)
> > +             return -EINVAL;
> > +
> > +     return max17042_probe(*i2c, dev, id->driver_data);
> and then just pass "i2c" here ?

This leads to hang on freeing devm resources, when unloading modules.

Platform driver version intended to be used as MFD sub device, where mfd
creates a dummy i2c client, and passes it to max17042 via platform data.
Sequence is: insmod MFD; insmod max17042; rmmod max17042; rmmod MFD; hang h=
ere.

My guess is that it is caused by a new pointer to the i2c-client. New point=
er
created at `platform_device_add_data` function call in `mfd_add_device`.
Since C is pass by value, new pointer is assigned to platform device data.

--=20

Best regards,
Dzmitry

