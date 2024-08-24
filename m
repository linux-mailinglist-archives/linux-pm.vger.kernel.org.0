Return-Path: <linux-pm+bounces-12847-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE4495DAB2
	for <lists+linux-pm@lfdr.de>; Sat, 24 Aug 2024 04:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A570B222BD
	for <lists+linux-pm@lfdr.de>; Sat, 24 Aug 2024 02:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96FA15E97;
	Sat, 24 Aug 2024 02:40:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF0415E8B;
	Sat, 24 Aug 2024 02:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724467202; cv=none; b=MZtlMhFr2wHoBauyc0jrl6rRFbor4TheDixLL67sga1EQJwaA9tJi7O2lbh01MH/BBdeAO+jxbZaAZ7i9K2jF4H60RAM1r7YQxLTXaamGN4fgulYcRt1f95NyEncLm+lkIVPZVlazIwfvpt5WlZnoiIFcDcBTOoFB/C9g4fc8Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724467202; c=relaxed/simple;
	bh=peHTpsNCkjVreEnxuFKPxTQWTQCHPTjc5nVFt6xnik8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F8PmXpyun2p+dpR0W1Spa6zeQiqgGlmgc8msnXba4uJI56886KQz/uIwweGx1L73N9fpcxAopsirIKafZhGD0cNbJ28jp5yILNQsbULZdJkvOdgUSbJGejt5Q2TL5hml+IF3cesQpGhOPgJFv63cAtJNG1y2oMz/RWbTGLs/6as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id 4AF7311626D; Fri, 23 Aug 2024 22:39:54 -0400 (EDT)
Received: from 5400 (unknown [172.56.34.244])
	by spindle.queued.net (Postfix) with ESMTPSA id 636DD10B36A;
	Fri, 23 Aug 2024 22:39:52 -0400 (EDT)
Date: Fri, 23 Aug 2024 22:39:50 -0400
From: Andres Salomon <dilinger@queued.net>
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-kernel@vger.kernel.org, Pali =?UTF-8?B?Um9ow6Fy?=
 <pali@kernel.org>, platform-driver-x86@vger.kernel.org, Matthew Garrett
 <mjg59@srcf.ucam.org>, Sebastian Reichel <sre@kernel.org>, Ilpo
 =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
 linux-pm@vger.kernel.org, Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v3 1/2] platform/x86:dell-laptop: Add knobs to change
 battery charge settings
Message-ID: <20240823223950.7f952489@5400>
In-Reply-To: <380016cc-6ccc-463f-8c66-f2989cd6ef42@redhat.com>
References: <20240815192848.3489d3e1@5400>
	<380016cc-6ccc-463f-8c66-f2989cd6ef42@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.2.5

On Mon, 19 Aug 2024 15:59:45 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
>=20
> On 8/16/24 1:28 AM, Andres Salomon wrote:
[...]
>=20
> > ---
> > Changes in v3:
> >     - switch tokenid and class types
> >     - be stricter with results from both userspace and BIOS
> >     - no longer allow failed BIOS reads
> >     - rename/move dell_send_request_by_token_loc, and add helper functi=
on
> >     - only allow registration for BAT0
> >     - rename charge_type modes to match power_supply names
> > Changes in v2, based on extensive feedback from Pali Roh=C3=A1r <pali@k=
ernel.org>:
> >     - code style changes
> >     - change battery write API to use token->value instead of passed va=
lue
> >     - stop caching current mode, instead querying SMBIOS as needed
> >     - drop the separate list of charging modes enum
> >     - rework the list of charging mode strings
> >     - query SMBIOS for supported charging modes
> >     - split dell_battery_custom_set() up
> > ---
> >  .../ABI/testing/sysfs-class-power-dell        |  33 ++
> >  drivers/platform/x86/dell/Kconfig             |   1 +
> >  drivers/platform/x86/dell/dell-laptop.c       | 316 ++++++++++++++++++
> >  drivers/platform/x86/dell/dell-smbios.h       |   7 +
> >  4 files changed, 357 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-class-power-dell
> >=20
> > diff --git a/Documentation/ABI/testing/sysfs-class-power-dell b/Documen=
tation/ABI/testing/sysfs-class-power-dell
> > new file mode 100644
> > index 000000000000..d8c542177558
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-class-power-dell
> > @@ -0,0 +1,33 @@
> > +What:		/sys/class/power_supply/<supply_name>/charge_type
> > +Date:		August 2024
> > +KernelVersion:	6.12
> > +Contact:	linux-pm@vger.kernel.org
> > +Description:
> > +		Select the charging algorithm to use for the (primary)
> > +		battery.
> > +
> > +		Standard:
> > +			Fully charge the battery at a moderate rate.
> > +		Fast:
> > +			Quickly charge the battery using fast-charge
> > +			technology. This is harder on the battery than
> > +			standard charging and may lower its lifespan.
> > +			The Dell BIOS calls this ExpressCharge=E2=84=A2.
> > +		Trickle:
> > +			Users who primarily operate the system while
> > +			plugged into an external power source can extend
> > +			battery life with this mode. The Dell BIOS calls
> > +			this "Primarily AC Use".
> > +		Adaptive:
> > +			Automatically optimize battery charge rate based
> > +			on typical usage pattern.
> > +		Custom:
> > +			Use the charge_control_* properties to determine
> > +			when to start and stop charging. Advanced users
> > +			can use this to drastically extend battery life.
> > +
> > +		Access: Read, Write
> > +		Valid values:
> > +			      "Standard", "Fast", "Trickle",
> > +			      "Adaptive", "Custom"
> > + =20
>=20
> As the kernel test robot reports:
>=20
> Warning: /sys/class/power_supply/<supply_name>/charge_type is defined 2 t=
imes:  ./Documentation/ABI/testing/sysfs-class-power-dell:0  ./Documentatio=
n/ABI/testing/sysfs-class-power:375
>=20
> So please drop this. What you could do is instead submit (as a separate) =
patch
> an update to Documentation/ABI/testing/sysfs-class-power:375 to use your =
IMHO
> more readable version.
>=20
> And when doing so I think it would best to replace "The Dell BIOS calls t=
his ..."
> with "In vendor tooling this may also be called ...".
>=20
>=20

Is this what you had in mind? I don't see many users of charge_type, and
I'm not sure whether the assumptions I'm making there are correct.

https://lore.kernel.org/lkml/20240820041942.30ed42f3@5400/

> > diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/d=
ell/Kconfig
> > index 85a78ef91182..02405793163c 100644
> > --- a/drivers/platform/x86/dell/Kconfig
> > +++ b/drivers/platform/x86/dell/Kconfig
> > @@ -49,6 +49,7 @@ config DELL_LAPTOP
> >  	default m
> >  	depends on DMI
> >  	depends on BACKLIGHT_CLASS_DEVICE
> > +	depends on ACPI_BATTERY
> >  	depends on ACPI_VIDEO || ACPI_VIDEO =3D n
> >  	depends on RFKILL || RFKILL =3D n
> >  	depends on DELL_WMI || DELL_WMI =3D n
> > diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform=
/x86/dell/dell-laptop.c
> > index 6552dfe491c6..8cc05f0fab91 100644
> > --- a/drivers/platform/x86/dell/dell-laptop.c
> > +++ b/drivers/platform/x86/dell/dell-laptop.c
> > @@ -22,11 +22,13 @@
> >  #include <linux/io.h>
> >  #include <linux/rfkill.h>
> >  #include <linux/power_supply.h>
> > +#include <linux/sysfs.h>
> >  #include <linux/acpi.h>
> >  #include <linux/mm.h>
> >  #include <linux/i8042.h>
> >  #include <linux/debugfs.h>
> >  #include <linux/seq_file.h>
> > +#include <acpi/battery.h>
> >  #include <acpi/video.h>
> >  #include "dell-rbtn.h"
> >  #include "dell-smbios.h"
> > @@ -99,6 +101,18 @@ static bool force_rfkill;
> >  static bool micmute_led_registered;
> >  static bool mute_led_registered;
> > =20
> > +static const struct {
> > +	int token;
> > +	const char *label;
> > +} battery_modes[] =3D {
> > +	{ BAT_STANDARD_MODE_TOKEN, "Standard" },
> > +	{ BAT_EXPRESS_MODE_TOKEN, "Fast" },
> > +	{ BAT_PRI_AC_MODE_TOKEN, "Trickle" },
> > +	{ BAT_ADAPTIVE_MODE_TOKEN, "Adaptive" },
> > +	{ BAT_CUSTOM_MODE_TOKEN, "Custom" },
> > +}; =20
>=20
> So Ilpo suggested to split this (first declare the struct type and then
> declare an array of that type) and Pali suggested to keep this as is.
>=20
> > +static u32 battery_supported_modes; =20
>=20
> I see there also is some disagreement on keeping battery_modes[]
> const vs adding a flag for this in the struct.
>=20
> IMHO in both cases either option is fine, so you (Andres) get
> to choose which solution you prefer in either case.
>=20
> I do see there is some confusion about Ilpo's split suggestion,
> to clarify that, what I believe is Ilpo meant doing something
> like this:

Thanks for clarify that, my fault for misreading what they'd written!






--=20
I'm available for contract & employment work, please contact me if
interested.

