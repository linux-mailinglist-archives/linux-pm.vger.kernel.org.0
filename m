Return-Path: <linux-pm+bounces-25264-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 702B2A8618C
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 17:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E89EC16960B
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 15:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B4420CCF5;
	Fri, 11 Apr 2025 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kb1VQrOI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA27310A1E;
	Fri, 11 Apr 2025 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744384564; cv=none; b=CVV+H+Fv6C2WuK5Ub6G2rdpmVGY7HizPdfLAPdB+7YGV5wPSmYVLLKdncv2jb4UaYu8FSiEUxYf0Htydhkxur8xEstxKSt01i1pWQwrrTJqxsyKE9w768AfU57uQXwVCQf4Ds6ds/Lu/M/DYJifhdNw4jCTeggJ6Z3qUc+XaOaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744384564; c=relaxed/simple;
	bh=U6OoqkNqz6S6tODC5IKLn/+wZf0r4dCyIk6KgClnSDQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MZU8MufOhtKDDuUkFTm1orYkEqJV+6CDHK6OvGJGuuP/hgleKb76PgtWiMkAVX+1AeTJd7/SrpsY66HBDN4m7HXbSdkjXEl+Wx3AaDqE6EChZy2iuUo4JkMrT7T8FvdguENqQ/Xt7A07ZzF47OwnhMQ3+UngTVXQDDU6v1k0nZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kb1VQrOI; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744384563; x=1775920563;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=U6OoqkNqz6S6tODC5IKLn/+wZf0r4dCyIk6KgClnSDQ=;
  b=Kb1VQrOIFYHq5472vbgfNaz/tjE/n04Nu9AqJAsh/mYrT3hMlYoiC1rf
   kHn5GrBtrT9YAza17aDluA4lzSULtASwtcOtw45PzdpgLmH7TBg8c0+kN
   ROSO8VtQD36uT65EPwaGfC//9cIfbNl1JIQcNOqsoV9DIGn3gEmawNOLy
   DnC/GVj9YebC5ICTdG+5AYssgiE8sefsR9oDRwwUKYwipo2IGmzgfoGpD
   9ynC7u/KY7PBafC/obiJ56YBb0VfEBpv/2CAv4oW165aD7ucNrYHniLH0
   FyKEB+ouBTAoyT8LiVr9+db0nzSjyseVm9Q7zUnJ41oDOupUNOS5abtvx
   A==;
X-CSE-ConnectionGUID: wyEusCv2Ru+LDregJr9vHw==
X-CSE-MsgGUID: n/e94ocdSTyvYOqhbmZzFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="56924653"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="56924653"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 08:16:00 -0700
X-CSE-ConnectionGUID: uBHWmv1vTjSyrkivvcgF0Q==
X-CSE-MsgGUID: vN2aYTqTROmVlf9MaFXDgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="166412811"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.51])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 08:15:54 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 11 Apr 2025 18:15:49 +0300 (EEST)
To: Antheas Kapenekakis <lkml@antheas.dev>
cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org, 
    linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, 
    Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>, 
    Jonathan Corbet <corbet@lwn.net>, 
    Joaquin Ignacio Aramendia <samsagax@gmail.com>, 
    Derek J Clark <derekjohn.clark@gmail.com>, 
    Kevin Greenberg <kdgreenberg234@protonmail.com>, 
    Joshua Tam <csinaction@pm.me>, Parth Menon <parthasarathymenon@gmail.com>, 
    Eileen <eileen@one-netbook.com>, LKML <linux-kernel@vger.kernel.org>, 
    sre@kernel.org, linux@weissschuh.net, Hans de Goede <hdegoede@redhat.com>, 
    mario.limonciello@amd.com
Subject: Re: [PATCH v8 09/14] platform/x86: oxpec: Move pwm value read/write
 to separate functions
In-Reply-To: <20250322103606.680401-10-lkml@antheas.dev>
Message-ID: <9356d39d-f23f-2d7b-5593-0b8004e40a61@linux.intel.com>
References: <20250322103606.680401-1-lkml@antheas.dev> <20250322103606.680401-10-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-936839061-1744384549=:944"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-936839061-1744384549=:944
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 22 Mar 2025, Antheas Kapenekakis wrote:

> Currently, this driver breaks hwmon ABI by using auto as 0 and manual
> as 1. However, for pwm_enable, 0 is full speed, 1 is manual, and 2 is
> auto. For the correction to be possible, this means that the pwm_enable
> endpoint will need access to both pwm enable and value (as for
> the 0th value, the fan needs to be set to full power).
>=20
> Therefore, move the pwm value read/write to separate functions.
>=20
> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Reviewed-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/platform/x86/oxpec.c | 162 +++++++++++++++++++----------------
>  1 file changed, 87 insertions(+), 75 deletions(-)
>=20
> diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
> index 2f31490fde64c..67bfd397802d1 100644
> --- a/drivers/platform/x86/oxpec.c
> +++ b/drivers/platform/x86/oxpec.c
> @@ -599,6 +599,91 @@ static umode_t oxp_ec_hwmon_is_visible(const void *d=
rvdata,
>  =09}
>  }
> =20
> +/* PWM input read/write functions */
> +static int oxp_pwm_input_write(long val)
> +{
> +=09if (val < 0 || val > 255)
> +=09=09return -EINVAL;

Please add an empty line here.

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

> +=09switch (board) {
> +=09case orange_pi_neo:
> +=09=09/* scale to range [1-244] */
> +=09=09val =3D ((val - 1) * 243 / 254) + 1;
> +=09=09return write_to_ec(ORANGEPI_SENSOR_PWM_REG, val);
> +=09case oxp_2:
> +=09case oxp_x1:
> +=09=09/* scale to range [0-184] */
> +=09=09val =3D (val * 184) / 255;
> +=09=09return write_to_ec(OXP_SENSOR_PWM_REG, val);
> +=09case aya_neo_2:
> +=09case aya_neo_air:
> +=09case aya_neo_air_1s:
> +=09case aya_neo_air_plus_mendo:
> +=09case aya_neo_air_pro:
> +=09case aya_neo_flip:
> +=09case aya_neo_geek:
> +=09case aya_neo_kun:
> +=09case oxp_mini_amd:
> +=09case oxp_mini_amd_a07:
> +=09=09/* scale to range [0-100] */
> +=09=09val =3D (val * 100) / 255;
> +=09=09return write_to_ec(OXP_SENSOR_PWM_REG, val);
> +=09case aok_zoe_a1:
> +=09case oxp_fly:
> +=09case oxp_mini_amd_pro:
> +=09=09return write_to_ec(OXP_SENSOR_PWM_REG, val);
> +=09default:
> +=09=09return -EOPNOTSUPP;
> +=09}
> +}
> +
> +static int oxp_pwm_input_read(long *val)
> +{
> +=09int ret;
> +
> +=09switch (board) {
> +=09case orange_pi_neo:
> +=09=09ret =3D read_from_ec(ORANGEPI_SENSOR_PWM_REG, 1, val);
> +=09=09if (ret)
> +=09=09=09return ret;
> +=09=09/* scale from range [1-244] */
> +=09=09*val =3D ((*val - 1) * 254 / 243) + 1;
> +=09=09break;
> +=09case oxp_2:
> +=09case oxp_x1:
> +=09=09ret =3D read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
> +=09=09if (ret)
> +=09=09=09return ret;
> +=09=09/* scale from range [0-184] */
> +=09=09*val =3D (*val * 255) / 184;
> +=09=09break;
> +=09case aya_neo_2:
> +=09case aya_neo_air:
> +=09case aya_neo_air_1s:
> +=09case aya_neo_air_plus_mendo:
> +=09case aya_neo_air_pro:
> +=09case aya_neo_flip:
> +=09case aya_neo_geek:
> +=09case aya_neo_kun:
> +=09case oxp_mini_amd:
> +=09case oxp_mini_amd_a07:
> +=09=09ret =3D read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
> +=09=09if (ret)
> +=09=09=09return ret;
> +=09=09/* scale from range [0-100] */
> +=09=09*val =3D (*val * 255) / 100;
> +=09=09break;
> +=09case aok_zoe_a1:
> +=09case oxp_fly:
> +=09case oxp_mini_amd_pro:
> +=09default:
> +=09=09ret =3D read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
> +=09=09if (ret)
> +=09=09=09return ret;
> +=09=09break;
> +=09}
> +=09return 0;
> +}
> +
>  static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types=
 type,
>  =09=09=09     u32 attr, int channel, long *val)
>  {
> @@ -639,48 +724,7 @@ static int oxp_platform_read(struct device *dev, enu=
m hwmon_sensor_types type,
>  =09case hwmon_pwm:
>  =09=09switch (attr) {
>  =09=09case hwmon_pwm_input:
> -=09=09=09switch (board) {
> -=09=09=09case orange_pi_neo:
> -=09=09=09=09ret =3D read_from_ec(ORANGEPI_SENSOR_PWM_REG, 1, val);
> -=09=09=09=09if (ret)
> -=09=09=09=09=09return ret;
> -=09=09=09=09/* scale from range [1-244] */
> -=09=09=09=09*val =3D ((*val - 1) * 254 / 243) + 1;
> -=09=09=09=09break;
> -=09=09=09case oxp_2:
> -=09=09=09case oxp_x1:
> -=09=09=09=09ret =3D read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
> -=09=09=09=09if (ret)
> -=09=09=09=09=09return ret;
> -=09=09=09=09/* scale from range [0-184] */
> -=09=09=09=09*val =3D (*val * 255) / 184;
> -=09=09=09=09break;
> -=09=09=09case aya_neo_2:
> -=09=09=09case aya_neo_air:
> -=09=09=09case aya_neo_air_1s:
> -=09=09=09case aya_neo_air_plus_mendo:
> -=09=09=09case aya_neo_air_pro:
> -=09=09=09case aya_neo_flip:
> -=09=09=09case aya_neo_geek:
> -=09=09=09case aya_neo_kun:
> -=09=09=09case oxp_mini_amd:
> -=09=09=09case oxp_mini_amd_a07:
> -=09=09=09=09ret =3D read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
> -=09=09=09=09if (ret)
> -=09=09=09=09=09return ret;
> -=09=09=09=09/* scale from range [0-100] */
> -=09=09=09=09*val =3D (*val * 255) / 100;
> -=09=09=09=09break;
> -=09=09=09case aok_zoe_a1:
> -=09=09=09case oxp_fly:
> -=09=09=09case oxp_mini_amd_pro:
> -=09=09=09default:
> -=09=09=09=09ret =3D read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
> -=09=09=09=09if (ret)
> -=09=09=09=09=09return ret;
> -=09=09=09=09break;
> -=09=09=09}
> -=09=09=09return 0;
> +=09=09=09return oxp_pwm_input_read(val);
>  =09=09case hwmon_pwm_enable:
>  =09=09=09return oxp_pwm_read(val);
>  =09=09default:
> @@ -706,39 +750,7 @@ static int oxp_platform_write(struct device *dev, en=
um hwmon_sensor_types type,
>  =09=09=09=09return oxp_pwm_disable();
>  =09=09=09return -EINVAL;
>  =09=09case hwmon_pwm_input:
> -=09=09=09if (val < 0 || val > 255)
> -=09=09=09=09return -EINVAL;
> -=09=09=09switch (board) {
> -=09=09=09case orange_pi_neo:
> -=09=09=09=09/* scale to range [1-244] */
> -=09=09=09=09val =3D ((val - 1) * 243 / 254) + 1;
> -=09=09=09=09return write_to_ec(ORANGEPI_SENSOR_PWM_REG, val);
> -=09=09=09case oxp_2:
> -=09=09=09case oxp_x1:
> -=09=09=09=09/* scale to range [0-184] */
> -=09=09=09=09val =3D (val * 184) / 255;
> -=09=09=09=09return write_to_ec(OXP_SENSOR_PWM_REG, val);
> -=09=09=09case aya_neo_2:
> -=09=09=09case aya_neo_air:
> -=09=09=09case aya_neo_air_1s:
> -=09=09=09case aya_neo_air_plus_mendo:
> -=09=09=09case aya_neo_air_pro:
> -=09=09=09case aya_neo_flip:
> -=09=09=09case aya_neo_geek:
> -=09=09=09case aya_neo_kun:
> -=09=09=09case oxp_mini_amd:
> -=09=09=09case oxp_mini_amd_a07:
> -=09=09=09=09/* scale to range [0-100] */
> -=09=09=09=09val =3D (val * 100) / 255;
> -=09=09=09=09return write_to_ec(OXP_SENSOR_PWM_REG, val);
> -=09=09=09case aok_zoe_a1:
> -=09=09=09case oxp_fly:
> -=09=09=09case oxp_mini_amd_pro:
> -=09=09=09=09return write_to_ec(OXP_SENSOR_PWM_REG, val);
> -=09=09=09default:
> -=09=09=09=09break;
> -=09=09=09}
> -=09=09=09break;
> +=09=09=09return oxp_pwm_input_write(val);
>  =09=09default:
>  =09=09=09break;
>  =09=09}
>=20

--=20
 i.

--8323328-936839061-1744384549=:944--

