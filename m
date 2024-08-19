Return-Path: <linux-pm+bounces-12421-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B159568E4
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 13:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0199B2831C8
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 11:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F151607A7;
	Mon, 19 Aug 2024 11:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n3AsDE/h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02DF14C58C;
	Mon, 19 Aug 2024 11:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724065417; cv=none; b=Es+CtHRtQ/MOQNhaCnFw1P/0a2aBy04GBt2OHnUwBfPVD6z5d02wItK4erPQ4T0PPsDCHo2jHNHGULXqiDtP59DZ1Lm0N0r14jmejfQCgg2tM867BnNQh3ACLOkX+jIr+RkteAYnDPEhOjEVkiQzc+27BtrVku1Mg6M7OhsEh2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724065417; c=relaxed/simple;
	bh=dcac0Wv15+Z6iRtPD7982zQgx7SgPZFZrT3EZ3chLoc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=L/DtUNUoZIeygApvblh8lZq9ztA9ySJE7pDXm8S+GJ6e7v369ce+xo84spIhCjvfDw+kQWmjqkyxwThE4S10wtheY5PWh98SYQtHFnEuGYmgwwQ9LeE5iotki/GQTNg7J+bLVJeTM29xyvkp4Z//snxOK2kMxSjLb6Jf4ptrrls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n3AsDE/h; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724065415; x=1755601415;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=dcac0Wv15+Z6iRtPD7982zQgx7SgPZFZrT3EZ3chLoc=;
  b=n3AsDE/h5a32g3xHipn6qGPlvat2E051wE0n8ZLBjR/E1GcQl7ZgSNgp
   FbxSEJ3d8ZDqpjdxbHSl+MwJP1ugL5B/8DlsGbkPSYaU9cJf0OBHrTzCs
   IjGap5QO006ftkkWMvyhDiaDvDRswaP74u99jjofv35+J0yGH3OtF6D6L
   b0yeUZnR4LP/Sp97CKW2kbHTId8yP5ZeBdXDgroUbvhC2fJ8wLOdNmwmc
   jp3zUmpRnsA9VUfSPehY+FTLQgCdm5FMMn2qN/vYWYFKBrrFwaWQE1JOn
   sopQe5JhI6Vgee29A9LNwc3OLe3ysblwq6z4PHwygQrF7K8kJoU0vkQ8V
   Q==;
X-CSE-ConnectionGUID: yCTlcaukQtCMk1ZdU9qpSg==
X-CSE-MsgGUID: Jzz9I2UaQq2yUS6ijH7kVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="32924550"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="32924550"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 04:03:34 -0700
X-CSE-ConnectionGUID: +0cBXcWqQ8WE0yCn+kPhRw==
X-CSE-MsgGUID: kSx/lvCHTvCEPevNDPyc/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="61113429"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 04:03:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 19 Aug 2024 14:03:27 +0300 (EEST)
To: =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali@kernel.org>
cc: Andres Salomon <dilinger@queued.net>, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, 
    Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
    linux-pm@vger.kernel.org, Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v3 1/2] platform/x86:dell-laptop: Add knobs to change
 battery charge settings
In-Reply-To: <20240816163341.fesk7afikv3n3yer@pali>
Message-ID: <db256dd0-7e0b-a03b-dff6-79da8f3dc8d5@linux.intel.com>
References: <20240815192848.3489d3e1@5400> <2feb1cf1-7597-9762-0864-87dc9c2c5559@linux.intel.com> <20240816163341.fesk7afikv3n3yer@pali>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1170884492-1724062269=:1359"
Content-ID: <0fd0b8ff-47d0-4295-41fd-28daae0b3b91@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1170884492-1724062269=:1359
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <1f5c1e3c-cb92-2c5d-6a09-a0eb31860941@linux.intel.com>

On Fri, 16 Aug 2024, Pali Roh=C3=A1r wrote:
> On Friday 16 August 2024 16:56:24 Ilpo J=C3=A4rvinen wrote:
> > On Thu, 15 Aug 2024, Andres Salomon wrote:
> >=20
> > > The Dell BIOS allows you to set custom charging modes, which is usefu=
l
> > > in particular for extending battery life. This adds support for tweak=
ing
> > > those various settings from Linux via sysfs knobs. One might, for
> > > example, have their laptop plugged into power at their desk the vast
> > > majority of the time and choose fairly aggressive battery-saving
> > > settings (eg, only charging once the battery drops below 50% and only
> > > charging up to 80%). When leaving for a trip, it would be more useful
> > > to instead switch to a standard charging mode (top off at 100%, charg=
e
> > > any time power is available). Rebooting into the BIOS to change the
> > > charging mode settings is a hassle.
> > >=20
> > > For the Custom charging type mode, we reuse the common
> > > charge_control_{start,end}_threshold sysfs power_supply entries. The
> > > BIOS also has a bunch of other charging modes (with varying levels of
> > > usefulness), so this also adds a 'charge_type' sysfs entry that maps =
the
> > > standard values to Dell-specific ones and documents those mappings in
> > > sysfs-class-power-dell.
> > >=20
> > > This work is based on a patch by Perry Yuan <perry_yuan@dell.com> and
> > > Limonciello Mario <Mario_Limonciello@Dell.com> submitted back in 2020=
:
> > > https://lore.kernel.org/all/20200729065424.12851-1-Perry_Yuan@Dell.co=
m/
> > > Both of their email addresses bounce, so I'm assuming they're no long=
er
> > > with the company. I've reworked most of the patch to make it smaller =
and
> > > cleaner.
> > >=20
> > > Signed-off-by: Andres Salomon <dilinger@queued.net>
> > > ---
> > > Changes in v3:
> > >     - switch tokenid and class types
> > >     - be stricter with results from both userspace and BIOS
> > >     - no longer allow failed BIOS reads
> > >     - rename/move dell_send_request_by_token_loc, and add helper func=
tion
> > >     - only allow registration for BAT0
> > >     - rename charge_type modes to match power_supply names
> > > Changes in v2, based on extensive feedback from Pali Roh=C3=A1r <pali=
@kernel.org>:
> > >     - code style changes
> > >     - change battery write API to use token->value instead of passed =
value
> > >     - stop caching current mode, instead querying SMBIOS as needed
> > >     - drop the separate list of charging modes enum
> > >     - rework the list of charging mode strings
> > >     - query SMBIOS for supported charging modes
> > >     - split dell_battery_custom_set() up
> > > ---
> > >  .../ABI/testing/sysfs-class-power-dell        |  33 ++
> > >  drivers/platform/x86/dell/Kconfig             |   1 +
> > >  drivers/platform/x86/dell/dell-laptop.c       | 316 ++++++++++++++++=
++
> > >  drivers/platform/x86/dell/dell-smbios.h       |   7 +
> > >  4 files changed, 357 insertions(+)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-class-power-dell
> > >=20
> > > diff --git a/Documentation/ABI/testing/sysfs-class-power-dell b/Docum=
entation/ABI/testing/sysfs-class-power-dell
> > > new file mode 100644
> > > index 000000000000..d8c542177558
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-class-power-dell
> > > @@ -0,0 +1,33 @@
> > > +What:=09=09/sys/class/power_supply/<supply_name>/charge_type
> > > +Date:=09=09August 2024
> > > +KernelVersion:=096.12
> > > +Contact:=09linux-pm@vger.kernel.org
> > > +Description:
> > > +=09=09Select the charging algorithm to use for the (primary)
> > > +=09=09battery.
> > > +
> > > +=09=09Standard:
> > > +=09=09=09Fully charge the battery at a moderate rate.
> > > +=09=09Fast:
> > > +=09=09=09Quickly charge the battery using fast-charge
> > > +=09=09=09technology. This is harder on the battery than
> > > +=09=09=09standard charging and may lower its lifespan.
> > > +=09=09=09The Dell BIOS calls this ExpressCharge=E2=84=A2.
> > > +=09=09Trickle:
> > > +=09=09=09Users who primarily operate the system while
> > > +=09=09=09plugged into an external power source can extend
> > > +=09=09=09battery life with this mode. The Dell BIOS calls
> > > +=09=09=09this "Primarily AC Use".
> > > +=09=09Adaptive:
> > > +=09=09=09Automatically optimize battery charge rate based
> > > +=09=09=09on typical usage pattern.
> > > +=09=09Custom:
> > > +=09=09=09Use the charge_control_* properties to determine
> > > +=09=09=09when to start and stop charging. Advanced users
> > > +=09=09=09can use this to drastically extend battery life.
> > > +
> > > +=09=09Access: Read, Write
> > > +=09=09Valid values:
> > > +=09=09=09      "Standard", "Fast", "Trickle",
> > > +=09=09=09      "Adaptive", "Custom"
> > > +
> > > diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86=
/dell/Kconfig
> > > index 85a78ef91182..02405793163c 100644
> > > --- a/drivers/platform/x86/dell/Kconfig
> > > +++ b/drivers/platform/x86/dell/Kconfig
> > > @@ -49,6 +49,7 @@ config DELL_LAPTOP
> > >  =09default m
> > >  =09depends on DMI
> > >  =09depends on BACKLIGHT_CLASS_DEVICE
> > > +=09depends on ACPI_BATTERY
> > >  =09depends on ACPI_VIDEO || ACPI_VIDEO =3D n
> > >  =09depends on RFKILL || RFKILL =3D n
> > >  =09depends on DELL_WMI || DELL_WMI =3D n
> > > diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platfo=
rm/x86/dell/dell-laptop.c
> > > index 6552dfe491c6..8cc05f0fab91 100644
> > > --- a/drivers/platform/x86/dell/dell-laptop.c
> > > +++ b/drivers/platform/x86/dell/dell-laptop.c
> > > @@ -22,11 +22,13 @@
> > >  #include <linux/io.h>
> > >  #include <linux/rfkill.h>
> > >  #include <linux/power_supply.h>
> > > +#include <linux/sysfs.h>
> > >  #include <linux/acpi.h>
> > >  #include <linux/mm.h>
> > >  #include <linux/i8042.h>
> > >  #include <linux/debugfs.h>
> > >  #include <linux/seq_file.h>
> > > +#include <acpi/battery.h>
> > >  #include <acpi/video.h>
> > >  #include "dell-rbtn.h"
> > >  #include "dell-smbios.h"
> > > @@ -99,6 +101,18 @@ static bool force_rfkill;
> > >  static bool micmute_led_registered;
> > >  static bool mute_led_registered;
> > > =20
> > > +static const struct {
> > > +=09int token;
> > > +=09const char *label;
> > > +} battery_modes[] =3D {
> >=20
> > Please don't try to do this in one go but split it into two (define and=
=20
> > then declaration of the variable).
>=20
> Why? Splitting definition of this anonymous structure and definition of
> variable would leak definition of anonymous structure of out the scope
> where it is used.

As is, this splits "static const" from battery_modes. Naming anonymous=20
struct isn't as bad problem as you seem to suggest (and named structs=20
are also easier when grepping).

> > > +static ssize_t charge_type_show(struct device *dev,
> > > +=09=09struct device_attribute *attr,
> > > +=09=09char *buf)
> > > +{
> > > +=09ssize_t count =3D 0;
> > > +=09int i;
> > > +
> > > +=09for (i =3D 0; i < ARRAY_SIZE(battery_modes); i++) {
> > > +=09=09bool active;
> > > +
> > > +=09=09if (!(battery_supported_modes & BIT(i)))
> >=20
> > Why not store this supported information into battery_modes itself?
>=20
> Same style is already used in other parts in this driver / source file.

If you refer to 'triggers', it is definitely not an example of something=20
that is easy to follow. With triggers, it seems that there's undocumented=
=20
array-index to hw-field bit mapping going on (or to be more precise, the=20
documentation for the hw field is in a far-away documentation block so
it's practically impossible to make the connection when reading the=20
struct).

> > What's the benefit of obfuscation it with the extra variable & BIT()?
>=20
> In my opinion, this is not obfuscation but clear and common style how to
> check which values of some enumeration are supported.
>
> Storing this kind of information into battery_modes is not possible
> because battery_modes is constant array with constant data.

Err, it's proposed to be const by this patch. Why that struct cannot be=20
changed to be non-const? Clearly there is battery mode related data that=20
is not const.


As a sidenote now that I had to look, this driver is doing other BIT(n)=20
obfusction too (and open-coded FIELD_PREP() seem to be plenty as well).

--
 i.
--8323328-1170884492-1724062269=:1359--

