Return-Path: <linux-pm+bounces-25265-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7952A86194
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 17:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB65716B205
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 15:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC4E210F5A;
	Fri, 11 Apr 2025 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y8igjtSW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154ED20F07D;
	Fri, 11 Apr 2025 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744384629; cv=none; b=SLyE9CXE4idfCQhaqRCzFN+uYgjjTJoCCWIR52qUvPrMaiXG6NWOWJvVhg1w7e4XYvv1tL3jljxQhFpIPJcwdfS/Yey8mWUW7ByTiuybKC20MAlj1XOH7iojjZHFpbjdy01jfj1TeOOonR7V7+vbpQrT0I4znCCUC7AmqF2+dFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744384629; c=relaxed/simple;
	bh=pvn3IXVDFoHiL+8SIW4XH1ZdCzBrI80Ao3qpO8mhyWQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=brbIi2N7a/EpHOg2skwwQn3UkHYD+zG/eZrPDUtrt35HBnYiU7njff0arbsDQzJgmYGfCBwsagLvPfy9ZFBMEt3dMUzW96KGlXY9cWuN0wBZWWjr94/i7EfgctKvpNZOegNEcSwtVfP7Nw9sxY7OD9EFoue+SDCXCvNX60qtabI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y8igjtSW; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744384628; x=1775920628;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pvn3IXVDFoHiL+8SIW4XH1ZdCzBrI80Ao3qpO8mhyWQ=;
  b=Y8igjtSWk2ZRchdXjZdTk/6cO39qJSO3WZzuu571XzHyZFW5r62h8fUG
   4DBeC7NsDY1bGBFFiov7j+RmwjMs8EmPYhEYqmyxaDrAv0bsFSFGNQrku
   j6Evsf3yBslshskToUgFLRnFSAL1VHXT791pcAK+DxOQQ3wzi4bv9tMeg
   CVODzHwCCNFAu2RWERdNnH94gEynRKVGRd0MJCuKtFXCP54Dy40ZaOzLp
   FyXupGs443a5d92Q9SgDInwLEapRw+EMWHLm1ejYQw6JuH0U3d/oXuPOM
   SOUetSX29z3zlPjQ1eYyX9nngkyMNQSAzLbAz9E+2SdOF1WLFgklJQywn
   g==;
X-CSE-ConnectionGUID: hx1ZFg8aSu2ANtNXRNNJ9A==
X-CSE-MsgGUID: iDIKIf6oRLa4snBJFURBlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="45831145"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="45831145"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 08:17:08 -0700
X-CSE-ConnectionGUID: sAWRgJx4TiS9cgxYXjdMAA==
X-CSE-MsgGUID: gJUnx4fZRNiqooMJxuXu0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="160185938"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.51])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 08:17:02 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 11 Apr 2025 18:16:58 +0300 (EEST)
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
Subject: Re: [PATCH v8 08/14] platform/x86: oxpec: Move pwm_enable read to
 its own function
In-Reply-To: <20250322103606.680401-9-lkml@antheas.dev>
Message-ID: <c3b89444-bc78-4e1d-573e-b2f9af9892c2@linux.intel.com>
References: <20250322103606.680401-1-lkml@antheas.dev> <20250322103606.680401-9-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1458065115-1744384618=:944"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1458065115-1744384618=:944
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 22 Mar 2025, Antheas Kapenekakis wrote:

> Currently, this driver breaks ABI by using auto as 0 and manual as 1.
> However, for pwm_enable, 0 is full speed, 1 is manual, and 2 is auto.
> For the correction to be possible, this means that the pwm_enable
> endpoint will need access to both pwm enable and value (as for
> the 0th value, the fan needs to be set to full power).
>=20
> Therefore, begin by moving the current pwm_enable read to its own
> function, oxp_pwm_enable.
>=20
> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Reviewed-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/platform/x86/oxpec.c | 50 +++++++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
> index 384d525402def..2f31490fde64c 100644
> --- a/drivers/platform/x86/oxpec.c
> +++ b/drivers/platform/x86/oxpec.c
> @@ -559,6 +559,32 @@ static int oxp_pwm_disable(void)
>  =09}
>  }
> =20
> +static int oxp_pwm_read(long *val)
> +{
> +=09switch (board) {
> +=09case orange_pi_neo:
> +=09=09return read_from_ec(ORANGEPI_SENSOR_PWM_ENABLE_REG, 1, val);
> +=09case aok_zoe_a1:
> +=09case aya_neo_2:
> +=09case aya_neo_air:
> +=09case aya_neo_air_1s:
> +=09case aya_neo_air_plus_mendo:
> +=09case aya_neo_air_pro:
> +=09case aya_neo_flip:
> +=09case aya_neo_geek:
> +=09case aya_neo_kun:
> +=09case oxp_2:
> +=09case oxp_fly:
> +=09case oxp_mini_amd:
> +=09case oxp_mini_amd_a07:
> +=09case oxp_mini_amd_pro:
> +=09case oxp_x1:
> +=09=09return read_from_ec(OXP_SENSOR_PWM_ENABLE_REG, 1, val);
> +=09default:
> +=09=09return -EOPNOTSUPP;
> +=09}
> +}
> +
>  /* Callbacks for hwmon interface */
>  static umode_t oxp_ec_hwmon_is_visible(const void *drvdata,
>  =09=09=09=09       enum hwmon_sensor_types type, u32 attr, int channel)
> @@ -656,29 +682,7 @@ static int oxp_platform_read(struct device *dev, enu=
m hwmon_sensor_types type,
>  =09=09=09}
>  =09=09=09return 0;
>  =09=09case hwmon_pwm_enable:
> -=09=09=09switch (board) {
> -=09=09=09case orange_pi_neo:
> -=09=09=09=09return read_from_ec(ORANGEPI_SENSOR_PWM_ENABLE_REG, 1, val);
> -=09=09=09case aok_zoe_a1:
> -=09=09=09case aya_neo_2:
> -=09=09=09case aya_neo_air:
> -=09=09=09case aya_neo_air_1s:
> -=09=09=09case aya_neo_air_plus_mendo:
> -=09=09=09case aya_neo_air_pro:
> -=09=09=09case aya_neo_flip:
> -=09=09=09case aya_neo_geek:
> -=09=09=09case aya_neo_kun:
> -=09=09=09case oxp_2:
> -=09=09=09case oxp_fly:
> -=09=09=09case oxp_mini_amd:
> -=09=09=09case oxp_mini_amd_a07:
> -=09=09=09case oxp_mini_amd_pro:
> -=09=09=09case oxp_x1:
> -=09=09=09=09return read_from_ec(OXP_SENSOR_PWM_ENABLE_REG, 1, val);
> -=09=09=09default:
> -=09=09=09=09break;
> -=09=09=09}
> -=09=09=09break;
> +=09=09=09return oxp_pwm_read(val);
>  =09=09default:
>  =09=09=09break;
>  =09=09}
>=20

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1458065115-1744384618=:944--

