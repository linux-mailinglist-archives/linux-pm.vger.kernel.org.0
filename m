Return-Path: <linux-pm+bounces-23801-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D44C2A5B0C2
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 01:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7862E3AC0D0
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 00:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF39823DE;
	Tue, 11 Mar 2025 00:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYI49JaD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17642A50;
	Tue, 11 Mar 2025 00:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741651374; cv=none; b=CWsKZK3UiRuBLK8kNtj8eVHZBdJCRm7nht2KgUHl8ys1uVWqtl787zcvyzp51Psq2dnlzh6tbVdUFCZxty3ngqmFpxARFzXy6FOcy0uAZxtjTiAevgMLAOlaLLpHpOQoXW+ffHhyQBBCvHh+tTX6VKlfLYe65Wn+uL7Y3MnlNXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741651374; c=relaxed/simple;
	bh=/bzZ3tqgSAgUeH3P9V/6CjzaO1tcoIKipRyjvMbQZy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rXLGEdzoPMuCMAfYifi1tbuB3sCO4BGbOzndW8r8XfZcF415jAgewbZEAb5hpAa7rkenN0/sy9ZKgn8yEQgcg+S1duiyNIEX/+7P1rkyvK86YmABecP2SEvk4hO3ZNxBcKdmUdd00u8SOnG1DdzEliOgHrhO3cqMW9MYN+ceh3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYI49JaD; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6dd01781b56so55342566d6.0;
        Mon, 10 Mar 2025 17:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741651372; x=1742256172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DE5Nm1awTt/9mjV3IJdf7v3DvZJeGdomq4tSCreRW8=;
        b=TYI49JaDfPFfRC0VFyVvPyn30P5AEMVTfBN38d9PKOfBBl4ubUa+XzPW4ZMzDMO8Au
         4KMTWMG1+qmbzGF8lQ5ZU3oNSweploRzBBTu4nzspYO/kp+m3q0ectvxUOed8payt+eP
         RbImhsa08NqsIwwdhTJ4yAXsc/yCQvvTLfXr6vwtukJDy0Y0G5KaJHrvv0JgOs5m4d9X
         ejwJUsFbdKCOhLKwbE1n2yHeSYFN6XbsVyOlFfUbKCu+FQII9dhWLdV5es9UxHnPy5mu
         CbLdVf/VJhqCRbCpWBCBLfw+i6iAUf/yFNWcV1JxoskunHoh6IyK18pAeDZfCBaFuGJY
         4IVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741651372; x=1742256172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9DE5Nm1awTt/9mjV3IJdf7v3DvZJeGdomq4tSCreRW8=;
        b=HuT0kxU82ambC6FIqO4dojJ5qiOuHjTG6p/d867RAvn30ciMiLyiLpK9Xj2BtzGRfi
         ChNfVocf1dRRruZDrln7hEMOu1uiekn6lf9heazjTFl38RRu9cDWROJg8+yJgbBse94G
         UoARM0V/VAcGxMRMbPiRNbFcugzrSR0ERgWuPodeUthuMVgCoqNFjzy064BAa6mqdikq
         cuoWg1oetxlyuVs1KHUKctd6e1/OAa22pZIllK2u6V4Us2hmOsoJFNbFv1IwPqd7dtoY
         pTNHzWGUHnKUP34A7oUiY3TWsniKnYYGt1M6B75lRt4ngtKDPtsAwWC+1NFf/j10arQg
         TzYA==
X-Forwarded-Encrypted: i=1; AJvYcCUDK/fn5OmySG0G7mMqB0aNW4uEH2zgZbAWyR2pFN1roUOC3pNPlS0QrC6YK2tkMiigMYA8t+8eIvRTNvA=@vger.kernel.org, AJvYcCUFRIXN+Q3e3J2aanR3r06LmyYDCJ1t/k6trAWWnx3VmzLAtQqqRhGajspf6neINadJpx2BVbPEwc4=@vger.kernel.org, AJvYcCX3/9hy2jfxq3jWKpL1LxAuTATilE9RnY9f+8yBAz2NkiT8c9FrhLzLAFzhrCNbl0KsZ5i+j5uanLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRTpHYvQ3ESDirgcP6VtGz0rEzJgMq+y2Wkaa2t0B955nNFF1/
	2eTWdjWnb8bPxcmrPJgFTj26jL/mo3JiIzQlQ0/IRqbkdhfrjWRxSN2fz42p/P6lnI8VsVB2QCL
	NCRyCdCycb7CnqzpY5y7u+XzL7NM=
X-Gm-Gg: ASbGncs1QyrmwjqGS/aMPaOqBCC3r1wQ8wK6uwnbjIpRUK5qoY65Y2YhPAoRYBJLhGf
	liOb1IqGiX9daUBH3kQ/0nP84e0ZX+7cqMn8h8kiuXrqVC/GTE5Kb1G73Nl1XAs6LP04apwcxdq
	RbUYFXu0qPhBuCNZr0jOyiEda8F7E=
X-Google-Smtp-Source: AGHT+IFgxmWdqNQmcWVzmOitF0f+s9burtwRuWjd0wyEtVhADq0xL3bFdxUIYWY7Cg+RqsN3AqnDIIfJEWaUxP0yWLg=
X-Received: by 2002:ad4:5cce:0:b0:6e8:98a1:3694 with SMTP id
 6a1803df08f44-6e9005b5e13mr235856916d6.8.1741651371868; Mon, 10 Mar 2025
 17:02:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309112114.1177361-1-lkml@antheas.dev> <20250309112114.1177361-13-lkml@antheas.dev>
In-Reply-To: <20250309112114.1177361-13-lkml@antheas.dev>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Mon, 10 Mar 2025 17:02:41 -0700
X-Gm-Features: AQ5f1JpMou8uLHEpxisdvmpdt5Ae3O6YL6431jUd4YlLxiK8h5lJInAVAV6XYEI
Message-ID: <CAFqHKT=WGaiVSQMXVQhA3Yym78RXy=iccizW6tdrvvE08tmazw@mail.gmail.com>
Subject: Re: [PATCH v3 12/12] platform/x86: oxpec: Adhere to sysfs-class-hwmon
 and enable pwm on 2
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, 
	Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Joaquin Ignacio Aramendia <samsagax@gmail.com>, Kevin Greenberg <kdgreenberg234@protonmail.com>, 
	Joshua Tam <csinaction@pm.me>, Parth Menon <parthasarathymenon@gmail.com>, 
	Eileen <eileen@one-netbook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 4:21=E2=80=AFAM Antheas Kapenekakis <lkml@antheas.de=
v> wrote:
>
> Currently, the driver does not adhere to the sysfs-class-hwmon
> specification: 0 is used for auto fan control and 1 is used for manual
> control. However, it is expected that 0 sets the fan to full speed,
> 1 sets the fan to manual, and then 2 is used for automatic control.
>
> Therefore, change the sysfs API to reflect this and enable pwm on 2.
>
> As we are breaking the ABI for this driver, rename oxpec to oxp_ec,
> reflecting the naming convention used by other drivers, to allow for
> a smooth migration in current userspace programs.
>
> Closes: https://lore.kernel.org/linux-hwmon/20241027174836.8588-1-derekjo=
hn.clark@gmail.com/
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/platform/x86/oxpec.c | 37 ++++++++++++++++++++++++++++++++----
>  1 file changed, 33 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
> index a06a7c54aa08..0b13baf190fe 100644
> --- a/drivers/platform/x86/oxpec.c
> +++ b/drivers/platform/x86/oxpec.c
> @@ -938,7 +938,27 @@ static int oxp_platform_read(struct device *dev, enu=
m hwmon_sensor_types type,
>                 case hwmon_pwm_input:
>                         return oxp_pwm_input_read(val);
>                 case hwmon_pwm_enable:
> -                       return oxp_pwm_read(val);
> +                       ret =3D oxp_pwm_read(val);
> +                       if (ret)
> +                               return ret;
> +
> +                       /* Check for auto and return 2 */
> +                       if (!*val) {
> +                               *val =3D 2;
> +                               return 0;
> +                       }
> +
> +                       /* Return 0 if at full fan speed, 1 otherwise */
> +                       ret =3D oxp_pwm_fan_speed(val);
> +                       if (ret)
> +                               return ret;
> +
> +                       if (*val =3D=3D 255)
> +                               *val =3D 0;
> +                       else
> +                               *val =3D 1;
> +
> +                       return 0;
>                 default:
>                         break;
>                 }
> @@ -952,15 +972,24 @@ static int oxp_platform_read(struct device *dev, en=
um hwmon_sensor_types type,
>  static int oxp_platform_write(struct device *dev, enum hwmon_sensor_type=
s type,
>                               u32 attr, int channel, long val)
>  {
> +       int ret;
> +
>         switch (type) {
>         case hwmon_pwm:
>                 switch (attr) {
>                 case hwmon_pwm_enable:
>                         if (val =3D=3D 1)
>                                 return oxp_pwm_enable();
> -                       else if (val =3D=3D 0)
> +                       else if (val =3D=3D 2)
>                                 return oxp_pwm_disable();
> -                       return -EINVAL;
> +                       else if (val !=3D 0)
> +                               return -EINVAL;
> +
> +                       /* Enable PWM and set to max speed */
> +                       ret =3D oxp_pwm_enable();
> +                       if (ret)
> +                               return ret;
> +                       return oxp_pwm_input_write(255);
>                 case hwmon_pwm_input:
>                         return oxp_pwm_input_write(val);
>                 default:
> @@ -1025,7 +1054,7 @@ static int oxp_platform_probe(struct platform_devic=
e *pdev)
>         struct device *dev =3D &pdev->dev;
>         struct device *hwdev;
>
> -       hwdev =3D devm_hwmon_device_register_with_info(dev, "oxpec", NULL=
,
> +       hwdev =3D devm_hwmon_device_register_with_info(dev, "oxp_ec", NUL=
L,
>                                                      &oxp_ec_chip_info, N=
ULL);
>
>         if (charge_behaviour_supported())
> --
> 2.48.1
>
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>

