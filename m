Return-Path: <linux-pm+bounces-26917-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A022AB0FF7
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 12:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FC44189740E
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 10:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A2428E5E3;
	Fri,  9 May 2025 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LLPf9nQL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA97F17BCE;
	Fri,  9 May 2025 10:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746785391; cv=none; b=YBtfiZ18CcIZpFf4OiZitUvzuIhdzBXOX8bpY/BXj4bwSC6Fy0DZjOyr5didn2SMYrB9A6vNRtiZ80qUU7ZleONkwe2hXZYu/AuoGxUXo18AnuMgY5/KjnRoyhRMpNgeezyi9YTDYiL7SW7rfdrJqvlGyhxxgFrVvSLLLHRYjBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746785391; c=relaxed/simple;
	bh=dB3ZTnyk1kZ+zuDLSOuNbQop1pPwHF748M2kpHxCdzA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WUU83CDZDpoJFZTjMPvSPrsZzHGRpNpL4gQ9Nkl5ZHZbUH7eLvkCiUexx8xCZIPWgK/Z2unoaSd0gUCZ/WYuqosJXidhPA4E4FlHwJKd/ycu5QHZeAkJgejGLxjlgsEBDH607YEsAaGpEU492HXpm9a3DnLA+CV0bQAGDOC+Rc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LLPf9nQL; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746785390; x=1778321390;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dB3ZTnyk1kZ+zuDLSOuNbQop1pPwHF748M2kpHxCdzA=;
  b=LLPf9nQLtoYLlO0F4DLyn5+TSYmfRPumVq5fGZ3mwxu2m1Scd96xjVaV
   aSy4Mr/xCyZ5doLc8ndmDxxA8JCATaA6Jazr9c/aDJPm3uaYbfovhzuGL
   yUi1L7ZZ4B+sbtnzApmm+BhEPfxlBX2HykdOnxvuhpRnu/Q8rtgItgYqj
   xhkwK1uwgVnOjD2Gi1UykQKr3SZEQamB8tWVDo+oS820gHFJ0RBI4Fh1G
   Q6tzkunfMU7H8etS5f4xufu86xTW5wR9JkBDZ7AFWRaRPLBhpm5QYYk36
   KguIHCzeqxLLEzL+CqWWuU0qZSZ9cUA7C3pr2aVkTet/TIuqwowDFlgiN
   w==;
X-CSE-ConnectionGUID: +Ig17lHFSYeslTDji3XC7Q==
X-CSE-MsgGUID: 88ABJpkmTeWMILRrElmEiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="60009857"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="60009857"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 03:09:49 -0700
X-CSE-ConnectionGUID: ueNjeU7KQ82sEWarbwiJ3A==
X-CSE-MsgGUID: fsH6DgXCTSGrIbbsx8jIRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="141784023"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.123])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 03:09:46 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 9 May 2025 13:09:43 +0300 (EEST)
To: Sebastian Reichel <sebastian.reichel@collabora.com>
cc: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] power: supply: core: Add additional health status
 values
In-Reply-To: <8cb0e0f7-a48e-5770-0c82-f0a75ed23d66@linux.intel.com>
Message-ID: <ff044893-04bd-84e1-cfc6-842787a8ba54@linux.intel.com>
References: <20250429003606.303870-1-W_Armin@gmx.de> <wla5mfgblecq7tiiangrzxv32yjhiru4h6i7nnmn3qvvl6o3ht@j7rbgete42u7> <8cb0e0f7-a48e-5770-0c82-f0a75ed23d66@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-118282477-1746785383=:1546"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-118282477-1746785383=:1546
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 5 May 2025, Ilpo J=E4rvinen wrote:
> On Wed, 30 Apr 2025, Sebastian Reichel wrote:
> > On Tue, Apr 29, 2025 at 02:36:03AM +0200, Armin Wolf wrote:
> > > Some batteries can signal when an internal fuse was blown. In such a
> > > case POWER_SUPPLY_HEALTH_DEAD is too vague for userspace applications
> > > to perform meaningful diagnostics.
> > >=20
> > > Additionally some batteries can also signal when some of their
> > > internal cells are imbalanced. In such a case returning
> > > POWER_SUPPLY_HEALTH_UNSPEC_FAILURE is again too vague for userspace
> > > applications to perform meaningful diagnostics.
> > >=20
> > > Add new health status values for both cases.
> > >=20
> > > Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> >=20
> > Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>=20
> Hi Sebastian,
>=20
> Is it okay with you I take this through pdx86 tree?

Ping?

--=20
 i.

>=20
> --
>  i.
>=20
> >=20
> > -- Sebastian
> >=20
> > > ---
> > > Changes since v1:
> > >  - rename "Fuse blown" to "Blown fuse"
> > >  - rename "Cell imbalanced" to "Cell imbalance"
> > > ---
> > >  Documentation/ABI/testing/sysfs-class-power | 2 +-
> > >  drivers/power/supply/power_supply_sysfs.c   | 2 ++
> > >  include/linux/power_supply.h                | 2 ++
> > >  3 files changed, 5 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentat=
ion/ABI/testing/sysfs-class-power
> > > index 2a5c1a09a28f..be8be54b183d 100644
> > > --- a/Documentation/ABI/testing/sysfs-class-power
> > > +++ b/Documentation/ABI/testing/sysfs-class-power
> > > @@ -456,7 +456,7 @@ Description:
> > >  =09=09=09      "Over voltage", "Under voltage", "Unspecified failure=
", "Cold",
> > >  =09=09=09      "Watchdog timer expire", "Safety timer expire",
> > >  =09=09=09      "Over current", "Calibration required", "Warm",
> > > -=09=09=09      "Cool", "Hot", "No battery"
> > > +=09=09=09      "Cool", "Hot", "No battery", "Blown fuse", "Cell imba=
lance"
> > > =20
> > >  What:=09=09/sys/class/power_supply/<supply_name>/precharge_current
> > >  Date:=09=09June 2017
> > > diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/powe=
r/supply/power_supply_sysfs.c
> > > index edb058c19c9c..2703ed1dd943 100644
> > > --- a/drivers/power/supply/power_supply_sysfs.c
> > > +++ b/drivers/power/supply/power_supply_sysfs.c
> > > @@ -110,6 +110,8 @@ static const char * const POWER_SUPPLY_HEALTH_TEX=
T[] =3D {
> > >  =09[POWER_SUPPLY_HEALTH_COOL]=09=09    =3D "Cool",
> > >  =09[POWER_SUPPLY_HEALTH_HOT]=09=09    =3D "Hot",
> > >  =09[POWER_SUPPLY_HEALTH_NO_BATTERY]=09    =3D "No battery",
> > > +=09[POWER_SUPPLY_HEALTH_BLOWN_FUSE]=09    =3D "Blown fuse",
> > > +=09[POWER_SUPPLY_HEALTH_CELL_IMBALANCE]=09    =3D "Cell imbalance",
> > >  };
> > > =20
> > >  static const char * const POWER_SUPPLY_TECHNOLOGY_TEXT[] =3D {
> > > diff --git a/include/linux/power_supply.h b/include/linux/power_suppl=
y.h
> > > index 888824592953..69df3a452918 100644
> > > --- a/include/linux/power_supply.h
> > > +++ b/include/linux/power_supply.h
> > > @@ -71,6 +71,8 @@ enum {
> > >  =09POWER_SUPPLY_HEALTH_COOL,
> > >  =09POWER_SUPPLY_HEALTH_HOT,
> > >  =09POWER_SUPPLY_HEALTH_NO_BATTERY,
> > > +=09POWER_SUPPLY_HEALTH_BLOWN_FUSE,
> > > +=09POWER_SUPPLY_HEALTH_CELL_IMBALANCE,
> > >  };
> > > =20
> > >  enum {
> > > --=20
> > > 2.39.5
> > >=20
> >=20
>=20
--8323328-118282477-1746785383=:1546--

