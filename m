Return-Path: <linux-pm+bounces-25273-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CB1A861DE
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 17:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C4F17B8D7
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 15:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A76120FA98;
	Fri, 11 Apr 2025 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HPvV0iC+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880A338FAD;
	Fri, 11 Apr 2025 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744385429; cv=none; b=krvGZZq1A+zJbxmDZHAFfVgZ0kl+LuvrBEx5euQM/L9GTYQEsgissc26XRCs6tRLHOpEXmZFxTQLJxeDWB5kuDHIVC/phRIWusLLkM/qlZBVMxPOmr0D/9S2Qr52v5YsoiJSOhSIKqjucoXoobnUxIVCtknauLN0RtR/GrLFmCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744385429; c=relaxed/simple;
	bh=ceFpHSmg7DtGgF8kgC03aZJ7RA1jPrdtiFPTWPJTh+4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=acV+RmItygJduL0kU2ZEFbT4H32GNAh7DKJX+t9JR1YGhsr2LOkAMlZHMMccSuwqsDsryVmrrZ6IQjSRDKAwSDgky+DtMlVs4TgQtL2nwxihk7ZBcHn6UuKIXCZTTbbynPah72yKG45Fzxu7rZ94jki+mn4mrEDBHM76W342A74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HPvV0iC+; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744385427; x=1775921427;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ceFpHSmg7DtGgF8kgC03aZJ7RA1jPrdtiFPTWPJTh+4=;
  b=HPvV0iC+QPfhLLSLrLLv9j1jV+e/c8lUPhFcXgo0AnGz1O3DT672zjxV
   HUTZQ6/G1EIo6cApt84Ug93oXNPSATi7GKoP3I8LOzvBVQT76vqfB0n2q
   yXcIbsf7Q7VIXvAQThb8EMKgYMGX2BKiIOY83KHFlO8aGYjQV3pGjGTMi
   dwVfPmmrjEWPiQ9ZJcaP2jyhlwKHvJswRyCm5lls6oGwHqCz2hRbQaROR
   ascUW4OGCHnzMzCeUPd3A3Sg+ayVb0AOzygY7X3ljWI7HYNWrBB1IoOK/
   R6LV5SQ05ci6IzWBkXC6lzAZ5WhKirZy4BjfaUrWjaqAHhYtBWQJGF7A2
   Q==;
X-CSE-ConnectionGUID: eNpYV1aPTuOh8oIbFIW8hg==
X-CSE-MsgGUID: X17jGYEPRNK1SiFmJwy/bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="63485790"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="63485790"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 08:30:26 -0700
X-CSE-ConnectionGUID: /YRv8toyQZqPVbbB+pEJMA==
X-CSE-MsgGUID: RCoc+ZhwSoy+fC74571Mgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="134093530"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.51])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 08:30:20 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 11 Apr 2025 18:30:17 +0300 (EEST)
To: Antheas Kapenekakis <lkml@antheas.dev>
cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org, 
    linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, 
    Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>, 
    Jonathan Corbet <corbet@lwn.net>, 
    Joaquin Ignacio Aramendia <samsagax@gmail.com>, 
    Derek J Clark <derekjohn.clark@gmail.com>, 
    Kevin Greenberg <kdgreenberg234@protonmail.com>, 
    Joshua Tam <csinaction@pm.me>, Parth Menon <parthasarathymenon@gmail.com>, 
    Eileen <eileen@one-netbook.com>, linux-kernel@vger.kernel.org, 
    sre@kernel.org, linux@weissschuh.net, ilpo.jarvinen@linux.intel.com, 
    hdegoede@redhat.com, mario.limonciello@amd.com
Subject: Re: [PATCH v8 01/14] hwmon: (oxp-sensors) Distinguish the X1
 variants
In-Reply-To: <20250322103606.680401-2-lkml@antheas.dev>
Message-ID: <a2ff773b-fb41-4d02-6f4d-8d8db7a7a28f@linux.intel.com>
References: <20250322103606.680401-1-lkml@antheas.dev> <20250322103606.680401-2-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1590340832-1744385417=:944"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1590340832-1744385417=:944
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 22 Mar 2025, Antheas Kapenekakis wrote:

> Currently, the oxp-sensors driver fuzzy matches the X1 variants. Luckily,
> X1 and X1 mini share most hardware features so this works. However, they
> are completely different product lines, and there is an expectation that
> OneXPlayer will release more devices in the X1 line that may have
> differences.
>=20
> Therefore, distinguish the 3 devices that currently exist in the market.
> These are the OneXPlayer X1 AMD and Intel variants, and the X1 mini which
> only has an AMD variant. As far as registers go, all three support the
> current driver functionality.
>=20
> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/hwmon/oxp-sensors.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
> index 83730d9318240..5a4230ad3757e 100644
> --- a/drivers/hwmon/oxp-sensors.c
> +++ b/drivers/hwmon/oxp-sensors.c
> @@ -205,7 +205,28 @@ static const struct dmi_system_id dmi_table[] =3D {
>  =09{
>  =09=09.matches =3D {
>  =09=09=09DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> -=09=09=09DMI_MATCH(DMI_BOARD_NAME, "ONEXPLAYER X1"),
> +=09=09=09DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER X1 A"),
> +=09=09},
> +=09=09.driver_data =3D (void *)oxp_x1,
> +=09},
> +=09{
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> +=09=09=09DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER X1 i"),
> +=09=09},
> +=09=09.driver_data =3D (void *)oxp_x1,
> +=09},
> +=09{
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> +=09=09=09DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER X1 mini"),
> +=09=09},
> +=09=09.driver_data =3D (void *)oxp_x1,
> +=09},
> +=09{
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> +=09=09=09DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER X1Pro"),
>  =09=09},
>  =09=09.driver_data =3D (void *)oxp_x1,
>  =09},
>=20

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1590340832-1744385417=:944--

