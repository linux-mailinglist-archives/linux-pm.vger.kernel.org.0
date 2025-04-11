Return-Path: <linux-pm+bounces-25267-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA02DA861B8
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 17:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713BC188BF9C
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 15:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A93420B1E2;
	Fri, 11 Apr 2025 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L+Z6WGPt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EA41F91F6;
	Fri, 11 Apr 2025 15:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744384908; cv=none; b=MPGnRyi2Xgk2HrMeb7VK7vX/QOWggwNrk1EdpgSmojPLWHY6S+wmBSHK61wQM2aI2voRHa9jDOlTpoLqmKmpU4uhvDva13nlyXZDcE3gyGxOU6/Oj21TUtJLAnUAP/NKE9N6dH+OxflZljOudXd2Mg//Ahq21fhjwFdgcMxPoJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744384908; c=relaxed/simple;
	bh=Tw87e5Z2+o3Cia05sESpVVc5/dF27IORpEOYljJX210=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=R7F2u8PohkiPCWSaJcB8kdZWHYyg/595vQ2iBnO/xtOGONWJFvLgU/BOZyBOkQkFLlc5kFFOK0UL1qZKUqpyX1BVFHjpC4MdALss7OoGYFLLqLj7rQwE4HiPsVLMCakOfIGRdJxTdQS9JYUzOFijKN8RmRAebk13SbyfcFn8BEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L+Z6WGPt; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744384907; x=1775920907;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Tw87e5Z2+o3Cia05sESpVVc5/dF27IORpEOYljJX210=;
  b=L+Z6WGPtYczkhFqOT1d2LnNSaJPqmbhIqYYU+kzg29vIJJDyuc1DLxyq
   kKYO8TPysKVszmE/5Xhx/613tcxNk3TvtU1KvYPUYfEbfbTdxxTVxWZCL
   sEaahRxqf2S1Fx4s1otP57DpmztCM2Scyf5jzBeST4NR37q71FdriH3bk
   mohpvnxHFzzuVx9WubVGX+klUUuCEF6EIqyLklEJTMyf7JBjb1AdZQYeU
   DaHo1o4y9WE7irbs7bljT7RFmwv/4oNfblEY5bxvVy2i4Hrafx99mGlPq
   36PsU6WBfsucQlgRFCG+vRI1Nmu/k2sr2TMelJwEbUHsf6VjXhb4HkE+m
   g==;
X-CSE-ConnectionGUID: 83xC6K++QYafxUIn+ntV5Q==
X-CSE-MsgGUID: 1vObuezeRTO66Z67nkuJAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="49744352"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="49744352"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 08:21:46 -0700
X-CSE-ConnectionGUID: ZN7F5R2QSnS6gU9u+heceQ==
X-CSE-MsgGUID: OgdXmu7hQnWi10VVkYsecg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="128993003"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.51])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 08:21:40 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 11 Apr 2025 18:21:36 +0300 (EEST)
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
Subject: Re: [PATCH v8 07/14] platform/x86: oxpec: Add turbo led support to
 X1 devices
In-Reply-To: <20250322103606.680401-8-lkml@antheas.dev>
Message-ID: <b63450af-e3e9-41a6-fd14-81a4ac22a69e@linux.intel.com>
References: <20250322103606.680401-1-lkml@antheas.dev> <20250322103606.680401-8-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-207892103-1744384896=:944"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-207892103-1744384896=:944
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 22 Mar 2025, Antheas Kapenekakis wrote:

> The X1 and X1 mini lineups feature an LED nested within their turbo
> button. When turbo takeover is not enabled, the turbo button allows
> the device to switch from 18W to 25W TDP. When the device is in the
> 25W TDP mode, the LED is turned on.
>=20
> However, when we engage turbo takeover, the turbo led remains on its
> last state, which might be illuminated and cannot be currently
> controlled. Therefore, add the register that controls it under sysfs,
> to allow userspace to turn it off once engaging turbo takeover and
> then control it as they wish.
>=20
> 2024 OneXPlayer devices, other than the X1s, do not have a turbo LED.
> However, earlier models do, so this can be extended to them as well
> when the register for it is found.
>=20
> Reviewed-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/platform/x86/oxpec.c | 84 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>=20
> diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
> index ee37070ec54fc..384d525402def 100644
> --- a/drivers/platform/x86/oxpec.c
> +++ b/drivers/platform/x86/oxpec.c
> @@ -87,6 +87,12 @@ static enum oxp_board board;
> =20
>  #define OXP_TURBO_RETURN_VAL           0x00 /* Common return val */
> =20
> +/* X1 Turbo LED */
> +#define OXP_X1_TURBO_LED_REG           0x57
> +
> +#define OXP_X1_TURBO_LED_OFF           0x01
> +#define OXP_X1_TURBO_LED_ON            0x02
> +
>  static const struct dmi_system_id dmi_table[] =3D {
>  =09{
>  =09=09.matches =3D {
> @@ -434,6 +440,73 @@ static ssize_t tt_toggle_show(struct device *dev,
> =20
>  static DEVICE_ATTR_RW(tt_toggle);
> =20
> +/* Callbacks for turbo LED attribute */
> +static umode_t tt_led_is_visible(struct kobject *kobj,
> +=09=09=09=09    struct attribute *attr, int n)
> +{
> +=09switch (board) {
> +=09case oxp_x1:
> +=09=09return attr->mode;
> +=09default:
> +=09=09break;
> +=09}
> +=09return 0;
> +}
> +
> +static ssize_t tt_led_store(struct device *dev,
> +=09=09=09       struct device_attribute *attr, const char *buf,
> +=09=09=09       size_t count)
> +{
> +=09u8 reg, val;
> +=09bool value;
> +=09int rval;
> +
> +=09rval =3D kstrtobool(buf, &value);
> +=09if (rval)
> +=09=09return rval;
> +
> +=09switch (board) {
> +=09case oxp_x1:
> +=09=09reg =3D OXP_X1_TURBO_LED_REG;
> +=09=09val =3D value ? OXP_X1_TURBO_LED_ON : OXP_X1_TURBO_LED_OFF;
> +=09=09break;
> +=09default:
> +=09=09return -EINVAL;
> +=09}
> +=09rval =3D write_to_ec(reg, val);
> +
> +=09if (rval)

Please don't put empty lines in between call and its error handling.

Please change "rval" to "ret".

(I'd add also a patch to convert the another rval to ret if it remains and=
=20
change "retval" too to ret for consistency).

> +=09=09return rval;
> +
> +=09return count;
> +}
> +
> +static ssize_t tt_led_show(struct device *dev,
> +=09=09=09      struct device_attribute *attr, char *buf)
> +{
> +=09int retval;
> +=09long enval;
> +=09long val;
> +=09u8 reg;
> +
> +=09switch (board) {
> +=09case oxp_x1:
> +=09=09reg =3D OXP_X1_TURBO_LED_REG;
> +=09=09enval =3D OXP_X1_TURBO_LED_ON;
> +=09=09break;
> +=09default:
> +=09=09return -EINVAL;
> +=09}
> +
> +=09retval =3D read_from_ec(reg, 1, &val);
> +=09if (retval)
> +=09=09return retval;
> +
> +=09return sysfs_emit(buf, "%d\n", val =3D=3D enval);
> +}
> +
> +static DEVICE_ATTR_RW(tt_led);
> +
>  /* PWM enable/disable functions */
>  static int oxp_pwm_enable(void)
>  {
> @@ -691,8 +764,19 @@ static const struct attribute_group oxp_tt_toggle_at=
tribute_group =3D {
>  =09.attrs =3D oxp_tt_toggle_attrs,
>  };
> =20
> +static struct attribute *oxp_tt_led_attrs[] =3D {
> +=09&dev_attr_tt_led.attr,
> +=09NULL
> +};
> +
> +static const struct attribute_group oxp_tt_led_attribute_group =3D {
> +=09.is_visible =3D tt_led_is_visible,
> +=09.attrs =3D oxp_tt_led_attrs,
> +};
> +
>  static const struct attribute_group *oxp_ec_groups[] =3D {
>  =09&oxp_tt_toggle_attribute_group,
> +=09&oxp_tt_led_attribute_group,
>  =09NULL
>  };
> =20
>=20

--=20
 i.

--8323328-207892103-1744384896=:944--

