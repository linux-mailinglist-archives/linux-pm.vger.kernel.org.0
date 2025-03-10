Return-Path: <linux-pm+bounces-23800-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDE8A5B062
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 00:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9D0818909CA
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 23:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605A92222C4;
	Mon, 10 Mar 2025 23:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKKqBnHx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3B21CAA8D;
	Mon, 10 Mar 2025 23:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741651152; cv=none; b=lL7ZfWauo0wAarBhHUTIVZwbn27iWEKylNcZEHtpkdhLbIh7wnqmcH6agh2+uhQVwOLcJr3am5gHD8/yt4qy8BuO3ZO951iARMTrNy5gtRtIkPDvT5TRmsVFaYl4ui1Um/i+8Y0ZYcO5wrrYkomOxfae3cLavFSti7v6rv9XYNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741651152; c=relaxed/simple;
	bh=4US/uMN12641sUbXkrcHn3xweatLIMUpmxO0Pj2rx/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=itku2l2afcfY/CcSbxnNhr7vKh0sgyOqc733Zqy1wbgc+pe4QPypJVHD+x/wKFM5fe3P1nvBjxxItrGXJUpWLG+yknfrBXQSl8/XxiNyAlDpy36tpTa6W3HDQPQiS+sYmrg580KQyyYx++SByNryS+99jdl46d993+H2F3+3wm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKKqBnHx; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e8ffa00555so30186406d6.0;
        Mon, 10 Mar 2025 16:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741651149; x=1742255949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juOiozFRi0xR2vzVmOrPWBrSEZCYzC4LI9t32rwoAdU=;
        b=ZKKqBnHx9iuR57HlApv+kWmkF9TsXKaCYBc4SNviIze8e49TcxMxc1MGWG2ODT//9i
         Oak2St6QvDWOmg13HUjdH3+zgNiNsXbb1JEyY/YpDskaudlpj9IIKlzDFkqys2il7puL
         DGdwJw02I/BC3B3AsS2H/kT+pIo+F62iwlDlhhhHVWDqfqxg7DJvVtplOunKm6v/uGdc
         qL2ZfKjWnocl3YdubP6359aQFYWomkEXS5LORTgdwj7qNf8XE24u+sOOYeO820djarKh
         CasvSoouLWULTIx6TPpHO+uUfNK6fectXsJ5yHHOy17keRpghYoFA5jdE65bG0jLsBpv
         zrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741651149; x=1742255949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=juOiozFRi0xR2vzVmOrPWBrSEZCYzC4LI9t32rwoAdU=;
        b=UUZeDc4C94IKFVazMo2Vuzr18cJapAnDdTWwODDlES7QejNm/cJ7V23HO1k6R4zhr9
         4VOL/AXcagdJ/3Ls0MWYDL4iw7KOSIxeA+TfsK87pED+ZbUw2Mx3X3lwINUF9+CZ0Qed
         ucxtVTkFOCCRU1oAAGut0eIOWqhWSXwh7XPH+qD0GBOdWpmUnB1drwmbhIwke0LJZwJE
         w73L3xsoGUcLWMVAvoeofRbGyN5XhRmvqpriDmdvaUys7ywbAtGbtDu6GOe/pkP8+o8R
         ywvvlm0PtTfZyy8uhrYblmnu39QzEv7XSXgz+6ElN4Q4IlqKwAuubFQhNEwAhliwPp0Z
         Nexg==
X-Forwarded-Encrypted: i=1; AJvYcCWMx0aYL3IUfZXsu/1OUbkLI//ko55oT0GkOq2m4+4D7NuqxagcgAio5EeiuZc3KKeHL9Bc3XCl4l4=@vger.kernel.org, AJvYcCWOdJQBZ9EHtHRZO6T6xj0rvcOWpUEpyCCjXxLRXKx3XD7tOlUZvHhVUuVdfBPjiLYoDxHoY/e9lwdpS3I=@vger.kernel.org, AJvYcCWzLs6M9nxsR5GssjXHhVMwggwp2q+ZJXoOYvnNKNFNmdkYiP639vOXfof36S9Rx9apFQ8BchNOxvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YynAVCEghV3WSZDMEmSO/vhh+3FY1OK3u985w/QpeiBygUxkHf1
	D+KTtt8aYP+Z4bGewA/BHQSdj2s1Jc54RgmX506ouHtbS+senTEkWqe6Zr+60xtfZuyBfOScfEx
	kNH0gmao3UrIq/vh4l8r4dWJt8Qb1O/AMbDNm8g==
X-Gm-Gg: ASbGncvNbZUJDbsCLbyb2a5lDCSi20ob2TqtEPjXNIzbdt96du1XeHVqTaJ5MO9KtAr
	9qz0i5hQK8PO9BhBwPtEUQIj8SB/82c2huz/+sxQk9dauvWenaq0uOX5L3XHNpWdHaPEbPpzDPD
	3yZK3RYZL1hCnoGI5Ejt/1Q9g091o=
X-Google-Smtp-Source: AGHT+IFf28DqlgoPA5bQcNp5TFTFDIJCfiW0Dbt1uHJ5Rqu5dp96VsyfaT4MaKPeMZbgfEzszBOJqzvpFYl1HyoPCYc=
X-Received: by 2002:ad4:5aa2:0:b0:6e4:3eb1:2bde with SMTP id
 6a1803df08f44-6e9006471bemr271628276d6.19.1741651149619; Mon, 10 Mar 2025
 16:59:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309112114.1177361-1-lkml@antheas.dev> <20250309112114.1177361-12-lkml@antheas.dev>
In-Reply-To: <20250309112114.1177361-12-lkml@antheas.dev>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Mon, 10 Mar 2025 16:58:59 -0700
X-Gm-Features: AQ5f1JpvvGP4KBaivdg_8VfPwhF1eJfa867rjIJ-VfNDZxMtmlxB4HVd4Hib9tM
Message-ID: <CAFqHKTmOxSrPs597N0w=Oty+R7uUjgMZ5gGBgH+8u8u91i3KNA@mail.gmail.com>
Subject: Re: [PATCH v3 11/12] platform/x86: oxpec: Move fan speed read to
 separate function
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, 
	Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Joaquin Ignacio Aramendia <samsagax@gmail.com>, Kevin Greenberg <kdgreenberg234@protonmail.com>, 
	Joshua Tam <csinaction@pm.me>, Parth Menon <parthasarathymenon@gmail.com>, 
	Eileen <eileen@one-netbook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

z

On Sun, Mar 9, 2025 at 4:21=E2=80=AFAM Antheas Kapenekakis <lkml@antheas.de=
v> wrote:
>
> While not necessary for fixing the ABI hwmon issue, fan speed will be
> the only remaining value without a function. Therefore, finish the
> refactor by moving it to a separate function.
>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/platform/x86/oxpec.c | 53 ++++++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
> index 7dfd798bec87..a06a7c54aa08 100644
> --- a/drivers/platform/x86/oxpec.c
> +++ b/drivers/platform/x86/oxpec.c
> @@ -806,6 +806,34 @@ static umode_t oxp_ec_hwmon_is_visible(const void *d=
rvdata,
>         }
>  }
>
> +/* Fan speed read function */
> +static int oxp_pwm_fan_speed(long *val)
> +{
> +       switch (board) {
> +       case orange_pi_neo:
> +               return read_from_ec(ORANGEPI_SENSOR_FAN_REG, 2, val);
> +       case oxp_2:
> +       case oxp_x1:
> +               return read_from_ec(OXP_2_SENSOR_FAN_REG, 2, val);
> +       case aok_zoe_a1:
> +       case aya_neo_2:
> +       case aya_neo_air:
> +       case aya_neo_air_1s:
> +       case aya_neo_air_plus_mendo:
> +       case aya_neo_air_pro:
> +       case aya_neo_flip:
> +       case aya_neo_geek:
> +       case aya_neo_kun:
> +       case oxp_fly:
> +       case oxp_mini_amd:
> +       case oxp_mini_amd_a07:
> +       case oxp_mini_amd_pro:
> +               return read_from_ec(OXP_SENSOR_FAN_REG, 2, val);
> +       default:
> +               return -EOPNOTSUPP;
> +       }
> +}
> +
>  /* PWM input read/write functions */
>  static int oxp_pwm_input_write(long val)
>  {
> @@ -900,30 +928,7 @@ static int oxp_platform_read(struct device *dev, enu=
m hwmon_sensor_types type,
>         case hwmon_fan:
>                 switch (attr) {
>                 case hwmon_fan_input:
> -                       switch (board) {
> -                       case orange_pi_neo:
> -                               return read_from_ec(ORANGEPI_SENSOR_FAN_R=
EG, 2, val);
> -                       case oxp_2:
> -                       case oxp_x1:
> -                               return read_from_ec(OXP_2_SENSOR_FAN_REG,=
 2, val);
> -                       case aok_zoe_a1:
> -                       case aya_neo_2:
> -                       case aya_neo_air:
> -                       case aya_neo_air_1s:
> -                       case aya_neo_air_plus_mendo:
> -                       case aya_neo_air_pro:
> -                       case aya_neo_flip:
> -                       case aya_neo_geek:
> -                       case aya_neo_kun:
> -                       case oxp_fly:
> -                       case oxp_mini_amd:
> -                       case oxp_mini_amd_a07:
> -                       case oxp_mini_amd_pro:
> -                               return read_from_ec(OXP_SENSOR_FAN_REG, 2=
, val);
> -                       default:
> -                               break;
> -                       }
> -                       break;
> +                       return oxp_pwm_fan_speed(val);
>                 default:
>                         break;
>                 }
> --
> 2.48.1
>
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>

