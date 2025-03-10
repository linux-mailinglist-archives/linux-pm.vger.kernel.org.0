Return-Path: <linux-pm+bounces-23791-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA92A5AD13
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 00:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2CD3AEB47
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 23:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F7422156C;
	Mon, 10 Mar 2025 23:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mM+1f7JQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2706017332C;
	Mon, 10 Mar 2025 23:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741649219; cv=none; b=nk8f5B7D2ccDE3Yqv5F34WKkvVHUmKCNq7bWVtdP2A1nkZTdqVGY3vyCpHJY2c5brQWYG8xZL4y+QEtCjTx331WfkO/kvtG0ML4SA/CCmNf0sOJoGUtt/ODCgTLNA+jOsaRh4wQvtyd1Ft5jwV+Kw3KmYMb17/hoQVMQjglYuaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741649219; c=relaxed/simple;
	bh=ZopybM1AWEgiP/TDp5mpeXfpEyUTTu2hwlr8mptNHGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iN6EJvHGMUSC/QCSbAskp526qA0fnYOVoNjf28OTnXlW4qTd0BNZK99OSy4G0xf18EZ2MEFzsxJmr3eYL0Y9Z7DOy+53aiY7mb1tAm2cc0zE2TFaLmu+WX73j9sauf1pFTRtICXVO60IJJ+2VV+lGm9XxfrXkpsDhhWahNyMZjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mM+1f7JQ; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c55500d08cso70762385a.0;
        Mon, 10 Mar 2025 16:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741649217; x=1742254017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xhHTgDCQ+Wcnf3sbf8HhMLimYlSjo1Sx7XAIe3GwSs=;
        b=mM+1f7JQ64RVxalLxPHZ0EZhIXScL7e6yDcX6G/wx3bDVAFaV8GBS9+1glvGrzxcLl
         Ae6NGNwzaH8AC+qKLcoFYiW5EvN1QINl2HPVpJIoUUcn0vnCjXiZGNRirWd24sJfztRF
         THGCeGfg6AMwCWJmIzgbY1pu9Aw9V56jlZXTjKkd3EO4GRq3EdrsiAVm2ttyQYO4TjWy
         Fk4ddsXEDeTlwu7tRqD1A+4gUM6rO1NhQtinh0UN7zwISypXF9B31vLynJELcIUfEeKq
         Yh/k3Ldq5e9OsNSfHw08MmoATaV3YsvId/7q30Um5LUGtNrcaX17OVId5IKcpDyltMlS
         7Yxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741649217; x=1742254017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xhHTgDCQ+Wcnf3sbf8HhMLimYlSjo1Sx7XAIe3GwSs=;
        b=T0XrdTouQo8ZDN3cE+QWyFTSbCv/G4i4oIAHj1Sq5MZzyChgNX3/1IOri38tsKmp8n
         SmzmJg8Mi38SO+oFqByqqw4cN6a/33moinkU5p0tzTWW2mmEgj9UYMvXeCOIf5jNEJf1
         LCsOHClHWNvsdNaKLF0WtwST1WqXpbgIwuzt96/UlrvekAtAf3msA/gaznRcH0U5lvP4
         MAW42JqwmHQlEhNyk3lyUP/yzdCt4UHSlk0CWOTHbYdmL5wJZkQ6z1Da0TuQb37hSc7g
         yy0yfyp/63iPDtsOkGLDNX6XSf+gj2NowtZMc33oLBEJWlqLjtSjaSK1UskWyAS/A0cq
         SOjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtJ+wkaUaXZDgn+K1hqPCLbtOjdTHxxUtlG3IoOJgP7w1GtGIL90MQxCq8PMPrNt4mHzMDj4nt3+XrUco=@vger.kernel.org, AJvYcCX1IDFhqdxJF+Q0Vr87jO2Mk6E40acpJbpdv6B+sdFJitcUPSed2ipKMf3WOxJPFMEAEQ7q+3HPYh4=@vger.kernel.org, AJvYcCX3iG+W0yfT9J9r5aM2LJzhSj0WulvsO8pG2vi+HGKX5FXF725ZJJjqXhgJkMQiN88H9xFNtOwVl6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqhcmaPHRTzO/yHPIJIaUVbfXK5g2Uq/xcSjTvRGCMmGFG49uu
	OyUuyUIf1y105/hiS8FBz3HY4p9GWcOBYh26xT+LrrRz6BIQDFAa67UDbCddF0ETBryTAXoatBJ
	LEJWzXZmASC1pt2reaD9FS3ocmEvYe5kjlj8c1Q==
X-Gm-Gg: ASbGncslH1W6iE4t2WruXp9FCIVu1hEcOD1t56meL/eTk467EqX0bVxAF7c0T27g7/W
	z05r35oa04u/4xOE5dG2oSn2zdGLdmLbVyWgjOiWiO6O+cXQIlT/8P5R/qDFZONMtzp7IuS+/M5
	5a8xP398Fo+cCWlqv2mEfqzSY45gY=
X-Google-Smtp-Source: AGHT+IHSBlfvxRG3rYLiRB48oxfEa2zENomb2DqqEb1e6/VHlzGTUIl5V0cVIhT6beiNFwMs/EPwlUPMCiXXKVAiziI=
X-Received: by 2002:a05:6214:c43:b0:6e8:ebfa:42f9 with SMTP id
 6a1803df08f44-6ea2dd1e704mr27311066d6.16.1741649217039; Mon, 10 Mar 2025
 16:26:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309112114.1177361-1-lkml@antheas.dev> <20250309112114.1177361-10-lkml@antheas.dev>
In-Reply-To: <20250309112114.1177361-10-lkml@antheas.dev>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Mon, 10 Mar 2025 16:26:46 -0700
X-Gm-Features: AQ5f1JqEW-EvQwrvOwMQ0G4UWU38vfz8WpA7Yb2duThLrKAyexG3x3f33iKqk6E
Message-ID: <CAFqHKTnbW-iJT0+46trjkrjp6Qk_JUM4sDGf9t6iM9GDRkQnoA@mail.gmail.com>
Subject: Re: [PATCH v3 09/12] platform/x86: oxpec: Move pwm_enable read to its
 own function
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
> Currently, this driver breaks ABI by using auto as 0 and manual as 1.
> However, for pwm_enable, 0 is full speed, 1 is manual, and 2 is auto.
> For the correction to be possible, this means that the pwm_enable
> endpoint will need access to both pwm enable and value (as for
> the 0th value, the fan needs to be set to full power).
>
> Therefore, begin by moving the current pwm_enable read to its own
> function, oxp_pwm_enable.
>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/platform/x86/oxpec.c | 50 +++++++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
> index eb7eafebbd37..471444fbd786 100644
> --- a/drivers/platform/x86/oxpec.c
> +++ b/drivers/platform/x86/oxpec.c
> @@ -766,6 +766,32 @@ static int oxp_pwm_disable(void)
>         }
>  }
>
> +static int oxp_pwm_read(long *val)
> +{
> +       switch (board) {
> +       case orange_pi_neo:
> +               return read_from_ec(ORANGEPI_SENSOR_PWM_ENABLE_REG, 1, va=
l);
> +       case aok_zoe_a1:
> +       case aya_neo_2:
> +       case aya_neo_air:
> +       case aya_neo_air_1s:
> +       case aya_neo_air_plus_mendo:
> +       case aya_neo_air_pro:
> +       case aya_neo_flip:
> +       case aya_neo_geek:
> +       case aya_neo_kun:
> +       case oxp_2:
> +       case oxp_fly:
> +       case oxp_mini_amd:
> +       case oxp_mini_amd_a07:
> +       case oxp_mini_amd_pro:
> +       case oxp_x1:
> +               return read_from_ec(OXP_SENSOR_PWM_ENABLE_REG, 1, val);
> +       default:
> +               return -EOPNOTSUPP;
> +       }
> +}
> +
>  /* Callbacks for hwmon interface */
>  static umode_t oxp_ec_hwmon_is_visible(const void *drvdata,
>                                        enum hwmon_sensor_types type, u32 =
attr, int channel)
> @@ -863,29 +889,7 @@ static int oxp_platform_read(struct device *dev, enu=
m hwmon_sensor_types type,
>                         }
>                         return 0;
>                 case hwmon_pwm_enable:
> -                       switch (board) {
> -                       case orange_pi_neo:
> -                               return read_from_ec(ORANGEPI_SENSOR_PWM_E=
NABLE_REG, 1, val);
> -                       case aok_zoe_a1:
> -                       case aya_neo_2:
> -                       case aya_neo_air:
> -                       case aya_neo_air_1s:
> -                       case aya_neo_air_plus_mendo:
> -                       case aya_neo_air_pro:
> -                       case aya_neo_flip:
> -                       case aya_neo_geek:
> -                       case aya_neo_kun:
> -                       case oxp_2:
> -                       case oxp_fly:
> -                       case oxp_mini_amd:
> -                       case oxp_mini_amd_a07:
> -                       case oxp_mini_amd_pro:
> -                       case oxp_x1:
> -                               return read_from_ec(OXP_SENSOR_PWM_ENABLE=
_REG, 1, val);
> -                       default:
> -                               break;
> -                       }
> -                       break;
> +                       return oxp_pwm_read(val);
>                 default:
>                         break;
>                 }
> --
> 2.48.1
>

Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>

