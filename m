Return-Path: <linux-pm+bounces-23135-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43885A489B3
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 21:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271FE3B2D83
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 20:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F8626FDBA;
	Thu, 27 Feb 2025 20:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBHfbYVe"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF3026FA73;
	Thu, 27 Feb 2025 20:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740687667; cv=none; b=UtCZQGtVi+xLN/gIErDLb/ufDhmlylG4oCguZOPM4bPRc+Uidp1oj3Uf7wWykeRTqCTZHjmWZIcupYQ3uWYtGQ81eJRng9tuQq3crz4owIeID8QGMfYCbrJu9oX5PgqG/M3pntjZRuT/TlV3S+eynWlFpM68QwLiRGd1/RO0OEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740687667; c=relaxed/simple;
	bh=zhgA8lTVYegivj3+EBhgdMTn2Pg98qesetiRioNRoMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yo11p94UiS1s9gl3sfxoL2jINKKWeowEF1Yjsb3Uf229bbvm1gVYESnsbgkP7jpm3CWmaI/TXR8Yf/DY7jgMhq4v11m8kGfyRTW5eYquWQkk9TLXyXOoJVljxaa1N+IU86bfqsdpX058zcToJKMkADYyR+kXpKp9bifkyaWcI4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBHfbYVe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C91C4CEE4;
	Thu, 27 Feb 2025 20:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740687665;
	bh=zhgA8lTVYegivj3+EBhgdMTn2Pg98qesetiRioNRoMo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FBHfbYVe2+Y9RRSmqefAlel/As32WxZhKbbPD3xR7XlI1ZpP03vvcbXDT47FbLzJK
	 OOVkoxZn/4XSTDwy8lFv9RSdCOuOGqpGPbl+Jvv7FN02GTbGPBLuasboS7lilMipHX
	 pnLJOxSPlD86U+3Nk4XilKgRG5w/dyxdcuo1hsWWC9G80wrblb0u4CXIMycaepKUzL
	 s2plX5hvsMFI+dI5iLC4RwOcJs55yej/FVge1GVkgmmq+heiCIwpCzkGeMDBBw2lCk
	 I+MOajgKy829ndtFsVDcK1YEiv1H+bz6V//+GhmtArln1+kQWr81qSDssHCqfy//H2
	 Pjs//4GtZgsCg==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2c13ec72605so505011fac.0;
        Thu, 27 Feb 2025 12:21:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUTiJwa7s3a7atAjcf8EAPAhdjbxMD4pQd4amBeSu8rr/zZzeViQwqd9zb69Uy8r+k1BF/UejXh375g5QG7@vger.kernel.org, AJvYcCV+yyGFoF0+3RLE4UgVoSdfqwSbCeuDCgDoAQqPN3384nCdTPxAassEzaCq8mpUJfk53s8qL2oWgY0=@vger.kernel.org, AJvYcCXO1n6WldVSRp3WYk1QBzqYFJjNSRrhyhQ+PnNRzyi5l8rnvLG1qfPEu13zIIXuRcqsXabZo/ivsrfKpBOpxHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqvKh1GqutQHzD3PfWnu1tCZ+izY3qroNXyLXYonONOSvH8R1F
	qfinOT9w+cOQoLpX/VkUyxcXvC+cb7vkp73V4wbjRl/V3rkDiFO20qdXUmRTHmtKI2YksHG9JtN
	7otFGLDWPvAvVneCi+rJiaSWoeCQ=
X-Google-Smtp-Source: AGHT+IF96SqJIW4mVo1lyssliOdrmZiV4MWUl27EC9mWKW/Y+yznOetIfl7XasPSTISTnP3CvLcKZOXTKrbfxjeNK5M=
X-Received: by 2002:a05:6870:9a1c:b0:29e:671b:6003 with SMTP id
 586e51a60fabf-2c17874d20amr387145fac.32.1740687664295; Thu, 27 Feb 2025
 12:21:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cceb7f8864c43f046cf1c19c3bbcc38a7a57adc5.1740426540.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cceb7f8864c43f046cf1c19c3bbcc38a7a57adc5.1740426540.git.christophe.jaillet@wanadoo.fr>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Feb 2025 21:20:53 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0heBqYxm4GKN+qRD4Av0FBXQ_HvAhxqd7F+1Zeg9_YG8g@mail.gmail.com>
X-Gm-Features: AQ5f1JqvOKeZYSCbqVhP6TK4aZ30CmAT7tomqX60PmVO52rKxjibULcDTdD4GQI
Message-ID: <CAJZ5v0heBqYxm4GKN+qRD4Av0FBXQ_HvAhxqd7F+1Zeg9_YG8g@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: Remove a useless operation in int340x_thermal_zone_add()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 8:50=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> 'zone_trips' has just been allocated with kzalloc(), so .flags is known t=
o
> be 0. Remove the useless | when assigning THERMAL_TRIP_FLAG_RW_TEMP.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This was added in commit cca52f696952 ("thermal: intel: Set
> THERMAL_TRIP_FLAG_RW_TEMP directly")
> ---
>  drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c=
 b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> index 8dca6a6aceca..b43d848e66b8 100644
> --- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> +++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> @@ -143,7 +143,7 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(=
struct acpi_device *adev,
>         for (i =3D 0; i < trip_cnt; i++) {
>                 zone_trips[i].type =3D THERMAL_TRIP_PASSIVE;
>                 zone_trips[i].temperature =3D THERMAL_TEMP_INVALID;
> -               zone_trips[i].flags |=3D THERMAL_TRIP_FLAG_RW_TEMP;
> +               zone_trips[i].flags =3D THERMAL_TRIP_FLAG_RW_TEMP;
>                 zone_trips[i].priv =3D THERMAL_INT_TO_TRIP_PRIV(i);
>         }
>
> --

Applied as 6.15 material with edits in the subject and changelog, thanks!

