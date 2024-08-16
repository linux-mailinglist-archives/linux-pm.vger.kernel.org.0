Return-Path: <linux-pm+bounces-12374-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 373FA95510F
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 20:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1E91F23115
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 18:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01881C37AE;
	Fri, 16 Aug 2024 18:52:50 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C50B1BDAA0;
	Fri, 16 Aug 2024 18:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723834370; cv=none; b=XZFXh4fK2LI+obgm49m2SyACpt6hvtlPmRwK/9hvvLPcccy6t0ebpyn5lkSqyx6zbZDvlNrzV5tMC3M7retZXPbnChWEufVur5Fbu1Gj8QxNlo7xSVHFsFbzohcFM6JmLvvDSK9/a+YwrqeF2BSkLgp2gmWSJZlXSQWjnMmx4jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723834370; c=relaxed/simple;
	bh=o6AUSx2rTVk7/Bxl+I8kUpI492MWX+uEdMokR5FMjFo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LCUFeSV3ytq0vqXjI/tw8lx5kHIlFeN5mdHKxBl4uwwm9i26BGbjWsmXaFhoaeujnGClI8IrcoNECZZzw7WBwdFVVPWhxggPG5mOgAkSiCizJf9Guo3VXe8BJpKbkduEo+moj4h/5ZZf2K1InKu8MwR037FruvSDfkGYJ8wEYkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id 7AE6611611E; Fri, 16 Aug 2024 14:52:48 -0400 (EDT)
Received: from 5400 (unknown [172.56.34.244])
	by spindle.queued.net (Postfix) with ESMTPSA id 2E7DB116115;
	Fri, 16 Aug 2024 14:52:46 -0400 (EDT)
Date: Fri, 16 Aug 2024 14:52:44 -0400
From: Andres Salomon <dilinger@queued.net>
To: Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc: Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, LKML
 <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Matthew Garrett <mjg59@srcf.ucam.org>, Sebastian Reichel <sre@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org,
 Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v3 1/2] platform/x86:dell-laptop: Add knobs to change
 battery charge settings
Message-ID: <20240816145244.7de8c4c7@5400>
In-Reply-To: <20240816163341.fesk7afikv3n3yer@pali>
References: <20240815192848.3489d3e1@5400>
	<2feb1cf1-7597-9762-0864-87dc9c2c5559@linux.intel.com>
	<20240816163341.fesk7afikv3n3yer@pali>
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

On Fri, 16 Aug 2024 18:33:41 +0200
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> On Friday 16 August 2024 16:56:24 Ilpo J=C3=A4rvinen wrote:
> > On Thu, 15 Aug 2024, Andres Salomon wrote:
> >  =20
> > > The Dell BIOS allows you to set custom charging modes, which is useful
> > > in particular for extending battery life. This adds support for tweak=
ing
> > > those various settings from Linux via sysfs knobs. One might, for
> > > example, have their laptop plugged into power at their desk the vast
> > > majority of the time and choose fairly aggressive battery-saving
> > > settings (eg, only charging once the battery drops below 50% and only
> > > charging up to 80%). When leaving for a trip, it would be more useful
> > > to instead switch to a standard charging mode (top off at 100%, charge
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
> > > Limonciello Mario <Mario_Limonciello@Dell.com> submitted back in 2020:
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
> > > +What:		/sys/class/power_supply/<supply_name>/charge_type
> > > +Date:		August 2024
> > > +KernelVersion:	6.12
> > > +Contact:	linux-pm@vger.kernel.org
> > > +Description:
> > > +		Select the charging algorithm to use for the (primary)
> > > +		battery.
> > > +
> > > +		Standard:
> > > +			Fully charge the battery at a moderate rate.
> > > +		Fast:
> > > +			Quickly charge the battery using fast-charge
> > > +			technology. This is harder on the battery than
> > > +			standard charging and may lower its lifespan.
> > > +			The Dell BIOS calls this ExpressCharge=E2=84=A2.
> > > +		Trickle:
> > > +			Users who primarily operate the system while
> > > +			plugged into an external power source can extend
> > > +			battery life with this mode. The Dell BIOS calls
> > > +			this "Primarily AC Use".
> > > +		Adaptive:
> > > +			Automatically optimize battery charge rate based
> > > +			on typical usage pattern.
> > > +		Custom:
> > > +			Use the charge_control_* properties to determine
> > > +			when to start and stop charging. Advanced users
> > > +			can use this to drastically extend battery life.
> > > +
> > > +		Access: Read, Write
> > > +		Valid values:
> > > +			      "Standard", "Fast", "Trickle",
> > > +			      "Adaptive", "Custom"
> > > +
> > > diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86=
/dell/Kconfig
> > > index 85a78ef91182..02405793163c 100644
> > > --- a/drivers/platform/x86/dell/Kconfig
> > > +++ b/drivers/platform/x86/dell/Kconfig
> > > @@ -49,6 +49,7 @@ config DELL_LAPTOP
> > >  	default m
> > >  	depends on DMI
> > >  	depends on BACKLIGHT_CLASS_DEVICE
> > > +	depends on ACPI_BATTERY
> > >  	depends on ACPI_VIDEO || ACPI_VIDEO =3D n
> > >  	depends on RFKILL || RFKILL =3D n
> > >  	depends on DELL_WMI || DELL_WMI =3D n
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
> > > +	int token;
> > > +	const char *label;
> > > +} battery_modes[] =3D { =20
> >=20
> > Please don't try to do this in one go but split it into two (define and=
=20
> > then declaration of the variable). =20
>=20
> Why? Splitting definition of this anonymous structure and definition of
> variable would leak definition of anonymous structure of out the scope
> where it is used.


Also, it's two different arrays that we then have to keep synced as we
add new modes. That's the main reason I went for the combined struct.


>=20
> > > +	{ BAT_STANDARD_MODE_TOKEN, "Standard" },
> > > +	{ BAT_EXPRESS_MODE_TOKEN, "Fast" },
> > > +	{ BAT_PRI_AC_MODE_TOKEN, "Trickle" },
> > > +	{ BAT_ADAPTIVE_MODE_TOKEN, "Adaptive" },
> > > +	{ BAT_CUSTOM_MODE_TOKEN, "Custom" }, =20
> >=20
> > I suggest aligning the strings with tabs for better readability. =20
>=20
> For aligning something for better readability in "git diff" and
> "git show" (which includes also git format-patch and emails) is better
> to use spaces and not tabs. tab-alignment in git makes worse readability
> (due to name of the token).
>=20

Okay, so I'm hearing to align them, but to use spaces? I'll line everything
up with where "Standard" and "Adaptive" are.

[...]
> > > +
> > > +/*
> > > + * The rules: the minimum start charging value is 50%. The maximum
> > > + * start charging value is 95%. The minimum end charging value is
> > > + * 55%. The maximum end charging value is 100%. And finally, there
> > > + * has to be at least a 5% difference between start & end values.
> > > + */
> > > +#define CHARGE_START_MIN	50
> > > +#define CHARGE_START_MAX	95
> > > +#define CHARGE_END_MIN		55
> > > +#define CHARGE_END_MAX		100
> > > +#define CHARGE_MIN_DIFF		5
> > > +
> > > +static int dell_battery_set_custom_charge_start(int start)
> > > +{
> > > +	struct calling_interface_buffer buffer;
> > > +	int end;
> > > +
> > > +	if (start < CHARGE_START_MIN)
> > > +		start =3D CHARGE_START_MIN;
> > > +	else if (start > CHARGE_START_MAX)
> > > +		start =3D CHARGE_START_MAX; =20
> >=20
> > We have clamp().

Thanks, I'll use that.

> >  =20
> > > +
> > > +	end =3D dell_battery_read(BAT_CUSTOM_CHARGE_END);
> > > +	if (end < 0)
> > > +		return end;
> > > +	if ((end - start) < CHARGE_MIN_DIFF) =20
> >=20
> > Extra parenthesis. =20
>=20
> I pointed about this in previous version and from the discussion the
> conclusion was that there is no reason to remove extra parenthesis.
>=20
> > > +		start =3D end - CHARGE_MIN_DIFF;
> > > +
> > > +	return dell_set_std_token_value(&buffer, BAT_CUSTOM_CHARGE_START,
> > > +			start);
> > > +}
> > > +
> > > +static int dell_battery_set_custom_charge_end(int end)
> > > +{
> > > +	struct calling_interface_buffer buffer;
> > > +	int start;
> > > +
> > > +	if (end < CHARGE_END_MIN)
> > > +		end =3D CHARGE_END_MIN;
> > > +	else if (end > CHARGE_END_MAX)
> > > +		end =3D CHARGE_END_MAX; =20
> >=20
> > clamp.
> >=20

+1

 =20
> > > +	start =3D dell_battery_read(BAT_CUSTOM_CHARGE_START);
> > > +	if (start < 0)
> > > +		return start;
> > > +	if ((end - start) < CHARGE_MIN_DIFF) =20
> >=20
> > Extra parenthesis.
> >  =20
> > > +		end =3D start + CHARGE_MIN_DIFF;
> > > +
> > > +	return dell_set_std_token_value(&buffer, BAT_CUSTOM_CHARGE_END, end=
);
> > > +}
> > > +
> > > +static ssize_t charge_type_show(struct device *dev,
> > > +		struct device_attribute *attr,
> > > +		char *buf)
> > > +{
> > > +	ssize_t count =3D 0;
> > > +	int i;
> > > +
> > > +	for (i =3D 0; i < ARRAY_SIZE(battery_modes); i++) {
> > > +		bool active;
> > > +
> > > +		if (!(battery_supported_modes & BIT(i))) =20
> >=20
> > Why not store this supported information into battery_modes itself? =20
>=20
> Same style is already used in other parts in this driver / source file.
>=20
> > What's the benefit of obfuscation it with the extra variable & BIT()? =
=20
>=20
> In my opinion, this is not obfuscation but clear and common style how to
> check which values of some enumeration are supported.
>=20
> Storing this kind of information into battery_modes is not possible
> because battery_modes is constant array with constant data.
>=20

Yep. It's not a given that all modes will be supported by the BIOS.


--=20
I'm available for contract & employment work, please contact me if
interested.

