Return-Path: <linux-pm+bounces-25272-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E5BA861D9
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 17:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D46EF17B5DB
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 15:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E9520FA98;
	Fri, 11 Apr 2025 15:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m6Qsf86w"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0974110A1E;
	Fri, 11 Apr 2025 15:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744385401; cv=none; b=deF8XyBuFnmv48uNUlMC/WO/1mujwRRPkLyNuzNHOD3sQ2WnHpQjADMs7LecFZy4qbYf4JQuirr2tsF5TuDN+ReK4jU9aOfjd3mnqnesAjONWfVPHnEQo2R7VEIFDAt03gm2nHiO9c9udgv8d49Y6J1qPnsc7MkTESg6nZ6fmqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744385401; c=relaxed/simple;
	bh=Ni01iCRZ8nltP16X0YSAVPMxsOMEUvSfhhji3sfGVc4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LLVCdP1Ond0G26f0RF5ly0MasYs/vPf7OJ6JtgWfQQBp5Vh5D8QwOkeGEg0cZSGtQug6OhCgBE4NTR4jNrFWQElDpOJsn3gDwg5e9XydQ/TcwOWq/FsPiKdwcRSB+B2wfpcKjIyajFOkonju/0dHQ+NcU+AirT3ZwesQzhb245Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m6Qsf86w; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744385400; x=1775921400;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Ni01iCRZ8nltP16X0YSAVPMxsOMEUvSfhhji3sfGVc4=;
  b=m6Qsf86wQ6sp2b3GqEO4Z48v/r/Pggt3rYvtgRTZNR/rUpYkUCWIkGii
   x52oAuxh0puRM3piS+bdMuRIaqvRFRce0x+E1/lbxr9yDn8l5JoxPwSzL
   fcQUSQSuzx73GGZ/vDHs0j01CzJLLFvWxinYKdueyedgX6gzA/OZfaBTl
   zYbPw1bG4H0LIYZNNJSY8FMMjYXaYHrOQnoHeLP+6pYrscPaAVaNWt8gN
   TsAgD5cDkxzW5PJlOAjQ5pC7xwkN4GLMbt9Kvt7wMQn3hGTBm3GVvNe7V
   RcaNzv818fvM8pDjsK8yDK4N4tmgXLb9mjUw5B6eMRDekdauF+9lop+Ap
   A==;
X-CSE-ConnectionGUID: LG8J9pzPSNuMscEaczHNQw==
X-CSE-MsgGUID: ZJVyuXbUThmEC20MWP1+cA==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="56925622"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="56925622"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 08:30:00 -0700
X-CSE-ConnectionGUID: wlTLVgh6SIqLNL30w0XJhQ==
X-CSE-MsgGUID: iQWqCUW2TwybVGAkJ+8ypg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="166414846"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.51])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 08:29:53 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 11 Apr 2025 18:29:50 +0300 (EEST)
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
Subject: Re: [PATCH v8 02/14] hwmon: (oxp-sensors) Add all OneXFly variants
In-Reply-To: <20250322103606.680401-3-lkml@antheas.dev>
Message-ID: <8bff32cf-8659-f1e7-d187-1399fcca1207@linux.intel.com>
References: <20250322103606.680401-1-lkml@antheas.dev> <20250322103606.680401-3-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2107733643-1744385390=:944"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2107733643-1744385390=:944
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 22 Mar 2025, Antheas Kapenekakis wrote:

> Currently, the driver only has the F1 OneXFly variant, which was based
> on the 7000 AMD platform. Add its special editions: F1 EVA-01, F1 OLED.
> F1 OLED might have been a dev unit, but it is supported by OneXConsole
> with the same features so add it. Then add the F1L variant which is
> based on the 8000 AMD platform and the F1Pro and its special edition
> EVA-02.
>=20
> One might ask why not just fuzzy match. Well, EVA-02 is a variant of
> F1Pro which is a Strix Point handheld, but does not have F1Pro in its
> name. This makes it risky to fuzzy match, as special variants in the
> future from different platforms might not have the same feature set
> or registers.
>=20
> By happenstance, all current devices use the same registers. For the
> charge limitting feature on this series, only F1Pro/X1 (AMD) were
> released with it, but OneXPlayer is providing bios updates for F1, F1L,
> X1 Mini units that use the same register, so treat all of them the same.
>=20
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/hwmon/oxp-sensors.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>=20
> diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
> index 5a4230ad3757e..f7a64fbc8f33e 100644
> --- a/drivers/hwmon/oxp-sensors.c
> +++ b/drivers/hwmon/oxp-sensors.c
> @@ -188,6 +188,41 @@ static const struct dmi_system_id dmi_table[] =3D {
>  =09=09},
>  =09=09.driver_data =3D (void *)oxp_fly,
>  =09},
> +=09{
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> +=09=09=09DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER F1 EVA-01"),
> +=09=09},
> +=09=09.driver_data =3D (void *)oxp_fly,
> +=09},
> +=09{
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> +=09=09=09DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER F1 OLED"),
> +=09=09},
> +=09=09.driver_data =3D (void *)oxp_fly,
> +=09},
> +=09{
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> +=09=09=09DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER F1L"),
> +=09=09},
> +=09=09.driver_data =3D (void *)oxp_fly,
> +=09},
> +=09{
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> +=09=09=09DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER F1Pro"),
> +=09=09},
> +=09=09.driver_data =3D (void *)oxp_fly,
> +=09},
> +=09{
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> +=09=09=09DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER F1 EVA-02"),
> +=09=09},
> +=09=09.driver_data =3D (void *)oxp_fly,
> +=09},
>  =09{
>  =09=09.matches =3D {
>  =09=09=09DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
>=20

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>


--=20
 i.

--8323328-2107733643-1744385390=:944--

