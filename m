Return-Path: <linux-pm+bounces-25261-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F03A86185
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 17:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EE8B1BC0996
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 15:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC25B20E00B;
	Fri, 11 Apr 2025 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dxx5SXRN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4641F3FC8;
	Fri, 11 Apr 2025 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744384394; cv=none; b=RMuCLXClLfv/iCSkB84iQC4nc2IiSCWrctPqzlBu9HaaZnFa8olkreWcElwsITa6yAOUdg0sOgk4PBNuzGzRqyXf0YZDUonQSPjSk30JaTPx9d2ZwAGnKQdBQj0xFwCGwHD6nU8JDLPrkulJCAqTlM7lENhZfcO1+KyookxKmec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744384394; c=relaxed/simple;
	bh=KfhSjZudL1nJjdJ1rTRiN8vFlb91kK2NcoRGIa3wLoM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lhg6CVCNTiS04vC9UIrD/sDjD9MlYKJus0JAmA9eBy71/1cJkMNGSKSoWGPDY8FLPAOlarumq8p48Nb18zJ+xeKvouCITs6a1ZwYxLTIofu1NMd2UXbggl+44lREz/rGC8gKZcFQ0W0M6ZXkPQeyw+QCxJdaQDxHyNE5KEEkPfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dxx5SXRN; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744384393; x=1775920393;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=KfhSjZudL1nJjdJ1rTRiN8vFlb91kK2NcoRGIa3wLoM=;
  b=Dxx5SXRNvQIFIntj/sSxMYTTGCL80ECQ/r2nlL9OsRlU8Iq7nyC6hEh7
   KtCXo7dOky/qPT4VfxnJB3pkQtraFQfYzZa+IFxBosP4BgZ04NINRr8vU
   CtEL30JWcRN+ch2KihIaxpbH0aDWdaFat6XD0ds3BxjIf+CbFvvjSxQJo
   DQJrrAIL85xsHVqRP/AxF/VvRXIIO1opTOcEt99tHoW2Z+See0pxwtJZf
   lXMOZD7oRAOQW6U0oci2WyDLrQ81XueMCS0koXPkJX6yMlrjPOsPF8IO7
   9bUnnAZdBm+emrEY/Ln9KUf2h0xG+A7eO0tbwkM9DP9cS++wwWQ0x5vcm
   A==;
X-CSE-ConnectionGUID: qXd8Hc8sSs2f8hGvr9qM5g==
X-CSE-MsgGUID: ZKFF2AaDRsKxMYn6NxE6Rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="49772130"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="49772130"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 08:13:12 -0700
X-CSE-ConnectionGUID: /o1k0mGdQrWNdDNZ+wqXxA==
X-CSE-MsgGUID: gnvlPmCnSaSFJKSMynQQGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="133977733"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.51])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 08:13:06 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 11 Apr 2025 18:13:02 +0300 (EEST)
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
Subject: Re: [PATCH v8 11/14] platform/x86: oxpec: Adhere to sysfs-class-hwmon
 and enable pwm on 2
In-Reply-To: <20250322103606.680401-12-lkml@antheas.dev>
Message-ID: <4049e2db-fcea-a441-466d-84267d423c2c@linux.intel.com>
References: <20250322103606.680401-1-lkml@antheas.dev> <20250322103606.680401-12-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1583859504-1744384382=:944"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1583859504-1744384382=:944
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 22 Mar 2025, Antheas Kapenekakis wrote:

> Currently, the driver does not adhere to the sysfs-class-hwmon
> specification: 0 is used for auto fan control and 1 is used for manual
> control. However, it is expected that 0 sets the fan to full speed,
> 1 sets the fan to manual, and then 2 is used for automatic control.
>=20
> Therefore, change the sysfs API to reflect this and enable pwm on 2.
>=20
> As we are breaking the ABI for this driver, rename oxpec to oxp_ec,
> reflecting the naming convention used by other drivers, to allow for
> a smooth migration in current userspace programs.

So there's no gracious deprecation of the previous interface? It doesn't=20
sound "smooth" by any means from userspace perspective.

> Closes: https://lore.kernel.org/linux-hwmon/20241027174836.8588-1-derekjo=
hn.clark@gmail.com/
> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Reviewed-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/platform/x86/oxpec.c | 37 ++++++++++++++++++++++++++++++++----
>  1 file changed, 33 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
> index 5b84647569931..3bf2c597e9b00 100644
> --- a/drivers/platform/x86/oxpec.c
> +++ b/drivers/platform/x86/oxpec.c
> @@ -731,7 +731,27 @@ static int oxp_platform_read(struct device *dev, enu=
m hwmon_sensor_types type,
>  =09=09case hwmon_pwm_input:
>  =09=09=09return oxp_pwm_input_read(val);
>  =09=09case hwmon_pwm_enable:
> -=09=09=09return oxp_pwm_read(val);
> +=09=09=09ret =3D oxp_pwm_read(val);
> +=09=09=09if (ret)
> +=09=09=09=09return ret;
> +
> +=09=09=09/* Check for auto and return 2 */
> +=09=09=09if (!*val) {
> +=09=09=09=09*val =3D 2;
> +=09=09=09=09return 0;
> +=09=09=09}
> +
> +=09=09=09/* Return 0 if at full fan speed, 1 otherwise */
> +=09=09=09ret =3D oxp_pwm_fan_speed(val);
> +=09=09=09if (ret)
> +=09=09=09=09return ret;
> +
> +=09=09=09if (*val =3D=3D 255)
> +=09=09=09=09*val =3D 0;
> +=09=09=09else
> +=09=09=09=09*val =3D 1;

Why all these literals? These should be named properly with defines are=20
there some defines/enums for some of them already if this hwmon ABI?

> +
> +=09=09=09return 0;
>  =09=09default:
>  =09=09=09break;
>  =09=09}
> @@ -745,15 +765,24 @@ static int oxp_platform_read(struct device *dev, en=
um hwmon_sensor_types type,
>  static int oxp_platform_write(struct device *dev, enum hwmon_sensor_type=
s type,
>  =09=09=09      u32 attr, int channel, long val)
>  {
> +=09int ret;
> +
>  =09switch (type) {
>  =09case hwmon_pwm:
>  =09=09switch (attr) {
>  =09=09case hwmon_pwm_enable:
>  =09=09=09if (val =3D=3D 1)
>  =09=09=09=09return oxp_pwm_enable();
> -=09=09=09else if (val =3D=3D 0)
> +=09=09=09else if (val =3D=3D 2)
>  =09=09=09=09return oxp_pwm_disable();
> -=09=09=09return -EINVAL;
> +=09=09=09else if (val !=3D 0)

Literals here too should be changed.

> +=09=09=09=09return -EINVAL;
> +
> +=09=09=09/* Enable PWM and set to max speed */
> +=09=09=09ret =3D oxp_pwm_enable();
> +=09=09=09if (ret)
> +=09=09=09=09return ret;
> +=09=09=09return oxp_pwm_input_write(255);
>  =09=09case hwmon_pwm_input:
>  =09=09=09return oxp_pwm_input_write(val);
>  =09=09default:
> @@ -818,7 +847,7 @@ static int oxp_platform_probe(struct platform_device =
*pdev)
>  =09struct device *dev =3D &pdev->dev;
>  =09struct device *hwdev;
> =20
> -=09hwdev =3D devm_hwmon_device_register_with_info(dev, "oxpec", NULL,
> +=09hwdev =3D devm_hwmon_device_register_with_info(dev, "oxp_ec", NULL,
>  =09=09=09=09=09=09     &oxp_ec_chip_info, NULL);
> =20
>  =09return PTR_ERR_OR_ZERO(hwdev);
>=20

--=20
 i.

--8323328-1583859504-1744384382=:944--

