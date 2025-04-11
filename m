Return-Path: <linux-pm+bounces-25263-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A573BA8618E
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 17:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94391BC1A1D
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 15:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC3A20C009;
	Fri, 11 Apr 2025 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LEN78ifD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5621F3FC8;
	Fri, 11 Apr 2025 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744384450; cv=none; b=UorPbzK6+Jtfh6nEycvHJdpR5ku4rJKmHvZyQnrfy+/BadxdCTg5SdoeP5DevevL/aH928uBHBo6myp23W0n1dO3KMLaDgAYyVAgddLuibH9H8fiRkhS3QO7jWhoIZv/c7aQQILk6Yi/jYPdA+lCiT3M8zpNAGNNlUzTtaybLlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744384450; c=relaxed/simple;
	bh=dOEcyStR65ZFPlrTf3X/KNmQkCp/V+Eznx6i8ACB4lQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AHnhgIiBrAhJUxisq807BJUc5yH7ye+igZdX1XnI4i+idhqVu6uk9LDGQc16G//LBgTOR30lZy/R5Mlxl1NC5H8jzNXladQIiHqw8IE8sLYOxd3lMrkNTP1SilJAqky9CoF9djmV0WLN6bqjJwVWixpbpCAg4tFnDsd0m/tyEyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LEN78ifD; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744384449; x=1775920449;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dOEcyStR65ZFPlrTf3X/KNmQkCp/V+Eznx6i8ACB4lQ=;
  b=LEN78ifDbFBjli/20xfgj/G5YxkpgY4YD30W1bR5TJrYlbxXRlOMnu4f
   84ovZDujA75wzlzg22+r4+6JQPOAYh8c/7/KaZhCCFOctcfhJd+b04Edn
   51vkCSvy2Hss8jHyI8RGRaMoL4rmZOWWrvUQa80K9jIRFpJ9bqulNHH7p
   krBa/2PkUb2uwnENlMASph3/o7YZ9WmbdzzF/byj7iV4gCuQwZB/ibzmY
   sSb4z4UmYn8b06MiLNkU1XmdyLRu9gSlJD8d+33A+9M8YjKo061i+hPF7
   uglQADpWhxL2dvNpVKyUr/gU9RNxC6QEraQnr/yWK5Ra+6ebPmwXmu9Mv
   g==;
X-CSE-ConnectionGUID: V3/xW8R7TZSLGEQJzIG6xg==
X-CSE-MsgGUID: yEMR3Qm/ReaGVvQNXvIcFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="56586372"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="56586372"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 08:14:08 -0700
X-CSE-ConnectionGUID: thjoLN1cSpWHwmzzR+gcDA==
X-CSE-MsgGUID: E4ncuSNURySKF83PIWNyVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="129573443"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.51])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 08:14:00 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 11 Apr 2025 18:13:57 +0300 (EEST)
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
Subject: Re: [PATCH v8 10/14] platform/x86: oxpec: Move fan speed read to
 separate function
In-Reply-To: <20250322103606.680401-11-lkml@antheas.dev>
Message-ID: <342144b1-6380-dda7-b40e-a9090a9c6b90@linux.intel.com>
References: <20250322103606.680401-1-lkml@antheas.dev> <20250322103606.680401-11-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-190906982-1744384437=:944"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-190906982-1744384437=:944
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 22 Mar 2025, Antheas Kapenekakis wrote:

> While not necessary for fixing the ABI hwmon issue, fan speed will be
> the only remaining value without a function. Therefore, finish the
> refactor by moving it to a separate function.
>=20
> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Reviewed-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/platform/x86/oxpec.c | 53 ++++++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
> index 67bfd397802d1..5b84647569931 100644
> --- a/drivers/platform/x86/oxpec.c
> +++ b/drivers/platform/x86/oxpec.c
> @@ -599,6 +599,34 @@ static umode_t oxp_ec_hwmon_is_visible(const void *d=
rvdata,
>  =09}
>  }
> =20
> +/* Fan speed read function */
> +static int oxp_pwm_fan_speed(long *val)
> +{
> +=09switch (board) {
> +=09case orange_pi_neo:
> +=09=09return read_from_ec(ORANGEPI_SENSOR_FAN_REG, 2, val);
> +=09case oxp_2:
> +=09case oxp_x1:
> +=09=09return read_from_ec(OXP_2_SENSOR_FAN_REG, 2, val);
> +=09case aok_zoe_a1:
> +=09case aya_neo_2:
> +=09case aya_neo_air:
> +=09case aya_neo_air_1s:
> +=09case aya_neo_air_plus_mendo:
> +=09case aya_neo_air_pro:
> +=09case aya_neo_flip:
> +=09case aya_neo_geek:
> +=09case aya_neo_kun:
> +=09case oxp_fly:
> +=09case oxp_mini_amd:
> +=09case oxp_mini_amd_a07:
> +=09case oxp_mini_amd_pro:
> +=09=09return read_from_ec(OXP_SENSOR_FAN_REG, 2, val);
> +=09default:
> +=09=09return -EOPNOTSUPP;
> +=09}
> +}
> +
>  /* PWM input read/write functions */
>  static int oxp_pwm_input_write(long val)
>  {
> @@ -693,30 +721,7 @@ static int oxp_platform_read(struct device *dev, enu=
m hwmon_sensor_types type,
>  =09case hwmon_fan:
>  =09=09switch (attr) {
>  =09=09case hwmon_fan_input:
> -=09=09=09switch (board) {
> -=09=09=09case orange_pi_neo:
> -=09=09=09=09return read_from_ec(ORANGEPI_SENSOR_FAN_REG, 2, val);
> -=09=09=09case oxp_2:
> -=09=09=09case oxp_x1:
> -=09=09=09=09return read_from_ec(OXP_2_SENSOR_FAN_REG, 2, val);
> -=09=09=09case aok_zoe_a1:
> -=09=09=09case aya_neo_2:
> -=09=09=09case aya_neo_air:
> -=09=09=09case aya_neo_air_1s:
> -=09=09=09case aya_neo_air_plus_mendo:
> -=09=09=09case aya_neo_air_pro:
> -=09=09=09case aya_neo_flip:
> -=09=09=09case aya_neo_geek:
> -=09=09=09case aya_neo_kun:
> -=09=09=09case oxp_fly:
> -=09=09=09case oxp_mini_amd:
> -=09=09=09case oxp_mini_amd_a07:
> -=09=09=09case oxp_mini_amd_pro:
> -=09=09=09=09return read_from_ec(OXP_SENSOR_FAN_REG, 2, val);
> -=09=09=09default:
> -=09=09=09=09break;
> -=09=09=09}
> -=09=09=09break;
> +=09=09=09return oxp_pwm_fan_speed(val);
>  =09=09default:
>  =09=09=09break;
>  =09=09}
>=20

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-190906982-1744384437=:944--

