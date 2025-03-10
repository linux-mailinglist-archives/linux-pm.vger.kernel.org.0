Return-Path: <linux-pm+bounces-23799-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C30BA5B057
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 00:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FC2F16F3D1
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 23:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202A92222B8;
	Mon, 10 Mar 2025 23:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqxO6F5k"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD471CAA8D;
	Mon, 10 Mar 2025 23:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741651125; cv=none; b=ONBjUxR7PlGMaqIa3X/r2qHC4NAtPIVJdqLtkzvxeLWHMDitF7Yw/j+CCgvFqPT4u+L8FMR+7faRyayaj+LIKKWtdfyl7oIsoom+H5DhjkuksNKYFzzvgwSsUWcxfIBwOTe0aLF0pEPewVA9nlWtEO0rv8Az4ypSiYpSfz8QJXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741651125; c=relaxed/simple;
	bh=YYiZ7NymHlzIQeJGUGBAqfRgFHqsXumJjJgOq5CEvwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LyaI/H+5pF8pfzaj5SF/l4wTNSNkKO8r+ZDi1l9lrEbJHF2RN5INe7++lx+6nNdzX8y0BI+7FjzuS5hBhUALCIw0QCVjrfk/fcOEQF5Rx72683ZxuPVf3O3A/wQNcQzNCbixh8gQzPocvEwk3Abt/rkRbb7EH65XRSTBRZuOHJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqxO6F5k; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e89a2501a0so43988316d6.1;
        Mon, 10 Mar 2025 16:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741651122; x=1742255922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pc8gkEir7a1Cl5Qe7FDUfMjbQLs8BJDHde0vDSJkf1U=;
        b=PqxO6F5k7LdY8SPIgOPPZD5A6iBZsY7zTV0Ua5KtDuUl/KWwaaFiBPaJ8/POs5gEjB
         9tKPIdcM/64DnP8m1B8sU5kkajd1zer5eMTXN3LJP8ILfYRHZKQjxKA/vzmap6eQG5hV
         7amOHYSp/nKTTlpqDUbtqbSCiUglAQXthlXjUe0WuX1OBgr36i1ejc9dUWJObbHqykRJ
         G931y/h1bHPHQHFCOpHeoLY9aLZCD5ptWF7xuQEqquzUpBG55GKHsC2YFeEC6X0Iz11n
         ucYZQBEuK6x8qJ6PzLftV4114psWs2XbKwp4Ra8OowVz+an6gVCA5GOxU03t5LCs+evf
         A+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741651122; x=1742255922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pc8gkEir7a1Cl5Qe7FDUfMjbQLs8BJDHde0vDSJkf1U=;
        b=ZKIR4l7v80c73nVvxul+kmy+l6sg585d02q9ILQ120fd4loJOHW6JHrSXeJMpsKIMe
         vkFP8wKViyZQiu/vj4TNkXM3pG/XGb1JAnsMgX+aW4uhRWJ2+53woaJfQ06Ks+qi2c4F
         POCTc0R3wBJyC905GrfO+dgp/+OaMNUl3BeXQ7pb5Y5twCMp84s1erM2Z53UwKxStMaR
         vCev2a9LW3HnpxXErH3v70Uy+V+M5sthN411W/xHQMogZaYvmshDqwAedvGcgKqMIMFY
         IN1G1pNIT2lsIj5dprrj2d3A4gx4biX4z1HpdQCvSnv2CjI+wQA2M06r6nysjIkPUs8E
         FRnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoQp204AHpYwNCkO/KiHB2r8pEhFNeSxb2MSgdRdef2cL+VPuglRMdflXxil6awL8SHeHxX9fhL/8=@vger.kernel.org, AJvYcCXZcwfLDrZ7Xm+a0igrsZtdvNegFOAUyJWDJ/znBUt90nbR5//wz9zHCNATipN/LXqH+2zjO775SUY=@vger.kernel.org, AJvYcCXmuW3NQZ+3j2etXYurBBFx+pmE3gfd08nNFvZTCWQEwgk79Rh9ON4ayT7LVywogFWThTi62cIF6cwx3gI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMmG0w/uZuqN/FxP9zt0J6u9Q5VmYxxcIADsDcpU+VTLtXCoSd
	nRSnOaoqpH86si0IBRapVQpF9zpCrHa/NRTZLLnl7VOM1jesFRrls2yekpKPCjA+IWI4it26skD
	0Re9ruEq3ZlVSPvZek6005eIFpKw=
X-Gm-Gg: ASbGnctpsXxhaspvpjFDtCtIm7K2cvDRVfLcfRKxVcfhPyBv0J8EX5L3ZxnW0y+gx44
	dxIylMugoUjO2a73Sk4wt+KnuCp+FSCLWejDnHmHW4uJRDzhtf4FWuflQhxnFdODKArBX+xuZYt
	WIK2zSSME8lOVf5+8hwfXb8voCTlw=
X-Google-Smtp-Source: AGHT+IFYidbprkk1HEG8jzgszrmjPn/T0aTA2hw9r+au0uBjjW5EfzplIWM347dNT7vIglBXyLNzlK9Gb/e5quPnc68=
X-Received: by 2002:ad4:5aa2:0:b0:6e8:feae:9291 with SMTP id
 6a1803df08f44-6e90063df9amr193911846d6.24.1741651122128; Mon, 10 Mar 2025
 16:58:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309112114.1177361-1-lkml@antheas.dev> <20250309112114.1177361-11-lkml@antheas.dev>
In-Reply-To: <20250309112114.1177361-11-lkml@antheas.dev>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Mon, 10 Mar 2025 16:58:31 -0700
X-Gm-Features: AQ5f1JpbKu2o3pH6atuHNJEb0pDrqf-fmAx73-9XzSd4YUZkXniQ-CeE7Iwgd7c
Message-ID: <CAFqHKTm8HhPdy04mJ0cyqrHEzGUynxgvnttkAjnJxgKrdrfR8g@mail.gmail.com>
Subject: Re: [PATCH v3 10/12] platform/x86: oxpec: Move pwm value read/write
 to separate functions
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
> Currently, this driver breaks hwmon ABI by using auto as 0 and manual
> as 1. However, for pwm_enable, 0 is full speed, 1 is manual, and 2 is
> auto. For the correction to be possible, this means that the pwm_enable
> endpoint will need access to both pwm enable and value (as for
> the 0th value, the fan needs to be set to full power).
>
> Therefore, move the pwm value read/write to separate functions.
>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/platform/x86/oxpec.c | 162 +++++++++++++++++++----------------
>  1 file changed, 87 insertions(+), 75 deletions(-)
>
> diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
> index 471444fbd786..7dfd798bec87 100644
> --- a/drivers/platform/x86/oxpec.c
> +++ b/drivers/platform/x86/oxpec.c
> @@ -806,6 +806,91 @@ static umode_t oxp_ec_hwmon_is_visible(const void *d=
rvdata,
>         }
>  }
>
> +/* PWM input read/write functions */
> +static int oxp_pwm_input_write(long val)
> +{
> +       if (val < 0 || val > 255)
> +               return -EINVAL;
> +       switch (board) {
> +       case orange_pi_neo:
> +               /* scale to range [1-244] */
> +               val =3D ((val - 1) * 243 / 254) + 1;
> +               return write_to_ec(ORANGEPI_SENSOR_PWM_REG, val);
> +       case oxp_2:
> +       case oxp_x1:
> +               /* scale to range [0-184] */
> +               val =3D (val * 184) / 255;
> +               return write_to_ec(OXP_SENSOR_PWM_REG, val);
> +       case aya_neo_2:
> +       case aya_neo_air:
> +       case aya_neo_air_1s:
> +       case aya_neo_air_plus_mendo:
> +       case aya_neo_air_pro:
> +       case aya_neo_flip:
> +       case aya_neo_geek:
> +       case aya_neo_kun:
> +       case oxp_mini_amd:
> +       case oxp_mini_amd_a07:
> +               /* scale to range [0-100] */
> +               val =3D (val * 100) / 255;
> +               return write_to_ec(OXP_SENSOR_PWM_REG, val);
> +       case aok_zoe_a1:
> +       case oxp_fly:
> +       case oxp_mini_amd_pro:
> +               return write_to_ec(OXP_SENSOR_PWM_REG, val);
> +       default:
> +               return -EOPNOTSUPP;
> +       }
> +}
> +
> +static int oxp_pwm_input_read(long *val)
> +{
> +       int ret;
> +
> +       switch (board) {
> +       case orange_pi_neo:
> +               ret =3D read_from_ec(ORANGEPI_SENSOR_PWM_REG, 1, val);
> +               if (ret)
> +                       return ret;
> +               /* scale from range [1-244] */
> +               *val =3D ((*val - 1) * 254 / 243) + 1;
> +               break;
> +       case oxp_2:
> +       case oxp_x1:
> +               ret =3D read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
> +               if (ret)
> +                       return ret;
> +               /* scale from range [0-184] */
> +               *val =3D (*val * 255) / 184;
> +               break;
> +       case aya_neo_2:
> +       case aya_neo_air:
> +       case aya_neo_air_1s:
> +       case aya_neo_air_plus_mendo:
> +       case aya_neo_air_pro:
> +       case aya_neo_flip:
> +       case aya_neo_geek:
> +       case aya_neo_kun:
> +       case oxp_mini_amd:
> +       case oxp_mini_amd_a07:
> +               ret =3D read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
> +               if (ret)
> +                       return ret;
> +               /* scale from range [0-100] */
> +               *val =3D (*val * 255) / 100;
> +               break;
> +       case aok_zoe_a1:
> +       case oxp_fly:
> +       case oxp_mini_amd_pro:
> +       default:
> +               ret =3D read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
> +               if (ret)
> +                       return ret;
> +               break;
> +       }
> +       return 0;
> +}
> +
>  static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types=
 type,
>                              u32 attr, int channel, long *val)
>  {
> @@ -846,48 +931,7 @@ static int oxp_platform_read(struct device *dev, enu=
m hwmon_sensor_types type,
>         case hwmon_pwm:
>                 switch (attr) {
>                 case hwmon_pwm_input:
> -                       switch (board) {
> -                       case orange_pi_neo:
> -                               ret =3D read_from_ec(ORANGEPI_SENSOR_PWM_=
REG, 1, val);
> -                               if (ret)
> -                                       return ret;
> -                               /* scale from range [1-244] */
> -                               *val =3D ((*val - 1) * 254 / 243) + 1;
> -                               break;
> -                       case oxp_2:
> -                       case oxp_x1:
> -                               ret =3D read_from_ec(OXP_SENSOR_PWM_REG, =
1, val);
> -                               if (ret)
> -                                       return ret;
> -                               /* scale from range [0-184] */
> -                               *val =3D (*val * 255) / 184;
> -                               break;
> -                       case aya_neo_2:
> -                       case aya_neo_air:
> -                       case aya_neo_air_1s:
> -                       case aya_neo_air_plus_mendo:
> -                       case aya_neo_air_pro:
> -                       case aya_neo_flip:
> -                       case aya_neo_geek:
> -                       case aya_neo_kun:
> -                       case oxp_mini_amd:
> -                       case oxp_mini_amd_a07:
> -                               ret =3D read_from_ec(OXP_SENSOR_PWM_REG, =
1, val);
> -                               if (ret)
> -                                       return ret;
> -                               /* scale from range [0-100] */
> -                               *val =3D (*val * 255) / 100;
> -                               break;
> -                       case aok_zoe_a1:
> -                       case oxp_fly:
> -                       case oxp_mini_amd_pro:
> -                       default:
> -                               ret =3D read_from_ec(OXP_SENSOR_PWM_REG, =
1, val);
> -                               if (ret)
> -                                       return ret;
> -                               break;
> -                       }
> -                       return 0;
> +                       return oxp_pwm_input_read(val);
>                 case hwmon_pwm_enable:
>                         return oxp_pwm_read(val);
>                 default:
> @@ -913,39 +957,7 @@ static int oxp_platform_write(struct device *dev, en=
um hwmon_sensor_types type,
>                                 return oxp_pwm_disable();
>                         return -EINVAL;
>                 case hwmon_pwm_input:
> -                       if (val < 0 || val > 255)
> -                               return -EINVAL;
> -                       switch (board) {
> -                       case orange_pi_neo:
> -                               /* scale to range [1-244] */
> -                               val =3D ((val - 1) * 243 / 254) + 1;
> -                               return write_to_ec(ORANGEPI_SENSOR_PWM_RE=
G, val);
> -                       case oxp_2:
> -                       case oxp_x1:
> -                               /* scale to range [0-184] */
> -                               val =3D (val * 184) / 255;
> -                               return write_to_ec(OXP_SENSOR_PWM_REG, va=
l);
> -                       case aya_neo_2:
> -                       case aya_neo_air:
> -                       case aya_neo_air_1s:
> -                       case aya_neo_air_plus_mendo:
> -                       case aya_neo_air_pro:
> -                       case aya_neo_flip:
> -                       case aya_neo_geek:
> -                       case aya_neo_kun:
> -                       case oxp_mini_amd:
> -                       case oxp_mini_amd_a07:
> -                               /* scale to range [0-100] */
> -                               val =3D (val * 100) / 255;
> -                               return write_to_ec(OXP_SENSOR_PWM_REG, va=
l);
> -                       case aok_zoe_a1:
> -                       case oxp_fly:
> -                       case oxp_mini_amd_pro:
> -                               return write_to_ec(OXP_SENSOR_PWM_REG, va=
l);
> -                       default:
> -                               break;
> -                       }
> -                       break;
> +                       return oxp_pwm_input_write(val);
>                 default:
>                         break;
>                 }
> --
> 2.48.1
>

Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>

