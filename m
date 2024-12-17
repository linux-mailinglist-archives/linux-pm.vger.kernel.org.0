Return-Path: <linux-pm+bounces-19377-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7586B9F4F64
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 16:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA95A16CD2C
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 15:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2FC1F708B;
	Tue, 17 Dec 2024 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kOzh3Grq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C6F1482E7;
	Tue, 17 Dec 2024 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734449065; cv=none; b=bhhqQg09QgcQMNB7/6mIScVrz0DrQ0+W2YTuVJQGdsw/ugS41D97rpWdxwYvlkLxcqIjIPWR/qzu1Zit+8DDSoT0fh3qLAacS1bhzzrIO7pUj5jxGOCezITSjmYUQVqW1TEpMWpsV5vJfpGkZbR0nokhjxT2WKZm8OB6aowoLwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734449065; c=relaxed/simple;
	bh=c3ulHEYBgsgYZ37H3Xd1i6SyEHl45vxz6yUhcVOU6vE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AIMh9jbq2W44raJWwGVN1nuCnZRUVKTsZJcqOIyfSvzoHucgDtDdURu6HkP9vI2z5iOOyaAy/THDuxDFoxPwieYKL/3GFNOEZaiq/H1DasdRozev5ksPoc3nDFztq+mst/VxPdpRSiVRsxElg20HwrlWZcNfuZVSqE5PxPw7TJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kOzh3Grq; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734449064; x=1765985064;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=c3ulHEYBgsgYZ37H3Xd1i6SyEHl45vxz6yUhcVOU6vE=;
  b=kOzh3Grq234yz57Ow3NTu6OEDyrL5CwsUO0CBrsRE+GjHQrLSyXgRrv1
   40Cf6Gsbkb+rkBijKy54iTtQC8+h3r/CDS0oVQaLsnbN4Lv3Z4doRgmGr
   t8947jmeKEHNs6VRPk8J/tyykbwOnI5ds4R/SswLtMaZ0qlJmrtmVVDyE
   VPhwsqk6XNYmhG4mbK6NpK5ldrKbkT5IIcYUv+2/jIqds86secZ81usGs
   SqS+dF+ExHV3sGHhRB4M8lfHR151PD7rytQRut2fbevIwLwKTJQUhv0Bh
   5OCR2amStcswN0wac9pheuq813eQzIpQdbLoSmjHcO/ZualN5WLsaCt4f
   A==;
X-CSE-ConnectionGUID: FdRMYAxERte8Z8Po8YmM/g==
X-CSE-MsgGUID: R8xY/pooS2qH4L2ovus4Vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="46291666"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="46291666"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 07:24:23 -0800
X-CSE-ConnectionGUID: TWLTh27/S0qS4AHCuT0K3A==
X-CSE-MsgGUID: miRv/ZIQRSSG05LykbmMxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128544896"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.192])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 07:24:21 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 17 Dec 2024 17:24:18 +0200 (EET)
To: Hans de Goede <hdegoede@redhat.com>
cc: Andy Shevchenko <andy@kernel.org>, 
    =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>, 
    Sebastian Reichel <sre@kernel.org>, Jelle van der Waa <jelle@vdwaa.nl>, 
    platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 4/4] platform/x86: dell-laptop: Use
 power_supply_charge_types_show/_parse() helpers
In-Reply-To: <6760c9d3-ccf4-47de-bfe5-b59b8b9fca07@redhat.com>
Message-ID: <88a8f295-855a-d191-927e-e8611bc4bea5@linux.intel.com>
References: <20241211174451.355421-1-hdegoede@redhat.com> <20241211174451.355421-5-hdegoede@redhat.com> <0030c3dd-c70c-d21b-de2b-ace0aeb4030d@linux.intel.com> <6760c9d3-ccf4-47de-bfe5-b59b8b9fca07@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1624801791-1734449058=:924"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1624801791-1734449058=:924
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 17 Dec 2024, Hans de Goede wrote:
> On 17-Dec-24 1:01 PM, Ilpo J=C3=A4rvinen wrote:
> > On Wed, 11 Dec 2024, Hans de Goede wrote:
> >=20
> >> Make battery_modes a map between tokens and enum power_supply_charge_t=
ype
> >> values instead of between tokens and strings and use the new
> >> power_supply_charge_types_show/_parse() helpers for show()/store()
> >> to ensure that things are handled in the same way as in other drivers.
> >>
> >> This also changes battery_supported_modes to be a bitmap of charge-typ=
es
> >> (enum power_supply_charge_type values) rather then a bitmap of indices
> >> into battery_modes[].
> >>
> >> Reviewed-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >> ---
> >>  drivers/platform/x86/dell/dell-laptop.c | 54 ++++++++++++------------=
-
> >>  1 file changed, 25 insertions(+), 29 deletions(-)
> >>
> >> diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platfor=
m/x86/dell/dell-laptop.c
> >> index 5671bd0deee7..9a4cfcb8bbe0 100644
> >> --- a/drivers/platform/x86/dell/dell-laptop.c
> >> +++ b/drivers/platform/x86/dell/dell-laptop.c
> >> @@ -103,15 +103,15 @@ static bool mute_led_registered;
> >> =20
> >>  struct battery_mode_info {
> >>  =09int token;
> >> -=09const char *label;
> >> +=09enum power_supply_charge_type charge_type;
> >>  };
> >> =20
> >>  static const struct battery_mode_info battery_modes[] =3D {
> >> -=09{ BAT_PRI_AC_MODE_TOKEN,   "Trickle" },
> >> -=09{ BAT_EXPRESS_MODE_TOKEN,  "Fast" },
> >> -=09{ BAT_STANDARD_MODE_TOKEN, "Standard" },
> >> -=09{ BAT_ADAPTIVE_MODE_TOKEN, "Adaptive" },
> >> -=09{ BAT_CUSTOM_MODE_TOKEN,   "Custom" },
> >> +=09{ BAT_PRI_AC_MODE_TOKEN,   POWER_SUPPLY_CHARGE_TYPE_TRICKLE },
> >> +=09{ BAT_EXPRESS_MODE_TOKEN,  POWER_SUPPLY_CHARGE_TYPE_FAST },
> >> +=09{ BAT_STANDARD_MODE_TOKEN, POWER_SUPPLY_CHARGE_TYPE_STANDARD },
> >> +=09{ BAT_ADAPTIVE_MODE_TOKEN, POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE },
> >> +=09{ BAT_CUSTOM_MODE_TOKEN,   POWER_SUPPLY_CHARGE_TYPE_CUSTOM },
> >>  };
> >>  static u32 battery_supported_modes;
> >> =20
> >> @@ -2261,46 +2261,42 @@ static ssize_t charge_types_show(struct device=
 *dev,
> >>  =09=09struct device_attribute *attr,
> >>  =09=09char *buf)
> >>  {
> >> -=09ssize_t count =3D 0;
> >> +=09enum power_supply_charge_type charge_type;
> >>  =09int i;
> >> =20
> >>  =09for (i =3D 0; i < ARRAY_SIZE(battery_modes); i++) {
> >> -=09=09bool active;
> >> +=09=09charge_type =3D battery_modes[i].charge_type;
> >> =20
> >> -=09=09if (!(battery_supported_modes & BIT(i)))
> >> +=09=09if (!(battery_supported_modes & BIT(charge_type)))
> >>  =09=09=09continue;
> >> =20
> >> -=09=09active =3D dell_battery_mode_is_active(battery_modes[i].token);
> >> -=09=09count +=3D sysfs_emit_at(buf, count, active ? "[%s] " : "%s ",
> >> -=09=09=09=09battery_modes[i].label);
> >> +=09=09if (!dell_battery_mode_is_active(battery_modes[i].token))
> >> +=09=09=09continue;
> >> +
> >> +=09=09return power_supply_charge_types_show(dev, battery_supported_mo=
des,
> >> +=09=09=09=09=09=09      charge_type, buf);
> >>  =09}
> >> =20
> >> -=09/* convert the last space to a newline */
> >> -=09if (count > 0)
> >> -=09=09count--;
> >> -=09count +=3D sysfs_emit_at(buf, count, "\n");
> >> -
> >> -=09return count;
> >> +=09/* No active mode found */
> >> +=09return -EIO;
> >>  }
> >> =20
> >>  static ssize_t charge_types_store(struct device *dev,
> >>  =09=09struct device_attribute *attr,
> >>  =09=09const char *buf, size_t size)
> >>  {
> >> -=09bool matched =3D false;
> >> -=09int err, i;
> >> +=09int charge_type, err, i;
> >> +
> >> +=09charge_type =3D power_supply_charge_types_parse(battery_supported_=
modes, buf);
> >> +=09if (charge_type < 0)
> >> +=09=09return charge_type;
> >> =20
> >>  =09for (i =3D 0; i < ARRAY_SIZE(battery_modes); i++) {
> >> -=09=09if (!(battery_supported_modes & BIT(i)))
> >> -=09=09=09continue;
> >> -
> >> -=09=09if (sysfs_streq(battery_modes[i].label, buf)) {
> >> -=09=09=09matched =3D true;
> >> +=09=09if (battery_modes[i].charge_type =3D=3D charge_type)
> >>  =09=09=09break;
> >> -=09=09}
> >>  =09}
> >> -=09if (!matched)
> >> -=09=09return -EINVAL;
> >> +=09if (i =3D=3D ARRAY_SIZE(battery_modes))
> >> +=09=09return -EIO;
> >=20
> > Hi Hans,
> >=20
> > Is this errno change helpful/correct?
>=20
> power_supply_charge_types_parse() already checks that the user-input
> is one of the values advertised in the passed in battery_supported_modes,
> so when we loop to translate the enum power_supply_charge_type value
> returned by power_supply_charge_types_parse() then we should find
> a matching entry in battery_modes[] if not something is wrong at
> the driver level. So not -EINVAL, since this is a driver issue not
> a user input issue.
>=20
> > There is zero I/O done before=20
> > reaching this point, just input validation, so why does it return errno=
=20
> > that is "I/O error"? If you want to differentiate from -EINVAL, I sugge=
st=20
> > using -ENOENT (but I personally think -EINVAL would be fine as well=20
> > because it's still an invalid argument even if it passed one stage of=
=20
> > the input checks).
>=20
> -ENOENT instead of -EIO works for me.
>=20
> Shall I send out a new version with that changed?
>
> Note that merging this requires the earlier patches from this
> series which have been merged into:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.gi=
t/log/?h=3Dfor-next
>=20
> so this either requires an immutable tag from Sebastian for you to merge,
> or this should be merged through Sebastian's tree.

Yes, please send a new version with -ENOENT as I was going to ask
Sebastian to take this patch but noticed this small errno thing while=20
reading the patch one more time before acking it.

--=20
 i.

--8323328-1624801791-1734449058=:924--

