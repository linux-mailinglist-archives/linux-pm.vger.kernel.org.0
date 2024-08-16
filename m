Return-Path: <linux-pm+bounces-12358-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CA8954B6E
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 15:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F16B286383
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 13:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942EA1B86E5;
	Fri, 16 Aug 2024 13:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iuGyZgT3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B66F1AC8B8;
	Fri, 16 Aug 2024 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723816595; cv=none; b=rOftdIeryWb6Y2N2qxZFCg4xl68UXHebvR2p80BskxmL5OqgOkHIPtNELD51GsojPejc+kuMea+fLCmKeKNEWMdw0rieu4UJJX6Y8221u/2FpEg1lF+p4KUllHReG/lebzkP+MpPs6+d1ibOKenriZ9Kf/xyhFyl/C/J73qPxTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723816595; c=relaxed/simple;
	bh=r7zTA+blH6weUVtpm4W8UG1D4Gj7CZ+wGWgBUL2MeRA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IZlvT3pVtbUCBqkqS+wGNFO9IN6tU5LpTz8L37n7GuSFFuE9CGSURARPvNlWxCxY9AQj+6kDK1WA23OSf10yFybB5IGO6JysOafP8r/ppv/kr8gOXVf2688uV9i/wuwiIpJDkJKvt5VKb1xAU3L6YWlXtxTNERrxS3uxdsBmW1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iuGyZgT3; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723816594; x=1755352594;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=r7zTA+blH6weUVtpm4W8UG1D4Gj7CZ+wGWgBUL2MeRA=;
  b=iuGyZgT3aEKUmEvAWOQsjr0mrFav5nREr9oAAHSaR5jntYXno1+E1el5
   +dzxa0sSFgSqYqCAp3QN9dqo60F6380bSf0FwAbOjEdDZmcOi8KUo/0gH
   4oifyp7LCTaZ+8EiOAI4HIrLbLT1+k2TGDlXL0/RpEirNcY/2Fqvuv5h4
   7Vh32bZexLs6SPrdhDXeEkzxz2dd/1gtkilrP2p/LS6E9x9vOYbsGGL0x
   v+HHC8Kf+XXx10gGwqvJRIeSUC2eLOVMBikMyX/Fc7ncrKftn1wv+ExJA
   Oxi21GjsG6dFGVRP5Hbx84Bm88oZsIOj4yRduwWcHYGiEQTMnbuM4Wgi7
   Q==;
X-CSE-ConnectionGUID: R82b3bGUQHq0pV3CVblGOA==
X-CSE-MsgGUID: B3JGCTT9RpKztmADfRuFYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22272475"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="22272475"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 06:56:32 -0700
X-CSE-ConnectionGUID: Cv0KyiwISXaAnpkbYP43GQ==
X-CSE-MsgGUID: bikPDXcESZSmQ5xEi32xVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="90409473"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.28])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 06:56:29 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 16 Aug 2024 16:56:24 +0300 (EEST)
To: Andres Salomon <dilinger@queued.net>
cc: LKML <linux-kernel@vger.kernel.org>, 
    =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali@kernel.org>, 
    platform-driver-x86@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, 
    Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
    linux-pm@vger.kernel.org, Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v3 1/2] platform/x86:dell-laptop: Add knobs to change 
 battery charge settings
In-Reply-To: <20240815192848.3489d3e1@5400>
Message-ID: <2feb1cf1-7597-9762-0864-87dc9c2c5559@linux.intel.com>
References: <20240815192848.3489d3e1@5400>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-413153107-1723816584=:1024"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-413153107-1723816584=:1024
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 15 Aug 2024, Andres Salomon wrote:

> The Dell BIOS allows you to set custom charging modes, which is useful
> in particular for extending battery life. This adds support for tweaking
> those various settings from Linux via sysfs knobs. One might, for
> example, have their laptop plugged into power at their desk the vast
> majority of the time and choose fairly aggressive battery-saving
> settings (eg, only charging once the battery drops below 50% and only
> charging up to 80%). When leaving for a trip, it would be more useful
> to instead switch to a standard charging mode (top off at 100%, charge
> any time power is available). Rebooting into the BIOS to change the
> charging mode settings is a hassle.
>=20
> For the Custom charging type mode, we reuse the common
> charge_control_{start,end}_threshold sysfs power_supply entries. The
> BIOS also has a bunch of other charging modes (with varying levels of
> usefulness), so this also adds a 'charge_type' sysfs entry that maps the
> standard values to Dell-specific ones and documents those mappings in
> sysfs-class-power-dell.
>=20
> This work is based on a patch by Perry Yuan <perry_yuan@dell.com> and
> Limonciello Mario <Mario_Limonciello@Dell.com> submitted back in 2020:
> https://lore.kernel.org/all/20200729065424.12851-1-Perry_Yuan@Dell.com/
> Both of their email addresses bounce, so I'm assuming they're no longer
> with the company. I've reworked most of the patch to make it smaller and
> cleaner.
>=20
> Signed-off-by: Andres Salomon <dilinger@queued.net>
> ---
> Changes in v3:
>     - switch tokenid and class types
>     - be stricter with results from both userspace and BIOS
>     - no longer allow failed BIOS reads
>     - rename/move dell_send_request_by_token_loc, and add helper function
>     - only allow registration for BAT0
>     - rename charge_type modes to match power_supply names
> Changes in v2, based on extensive feedback from Pali Roh=C3=A1r <pali@ker=
nel.org>:
>     - code style changes
>     - change battery write API to use token->value instead of passed valu=
e
>     - stop caching current mode, instead querying SMBIOS as needed
>     - drop the separate list of charging modes enum
>     - rework the list of charging mode strings
>     - query SMBIOS for supported charging modes
>     - split dell_battery_custom_set() up
> ---
>  .../ABI/testing/sysfs-class-power-dell        |  33 ++
>  drivers/platform/x86/dell/Kconfig             |   1 +
>  drivers/platform/x86/dell/dell-laptop.c       | 316 ++++++++++++++++++
>  drivers/platform/x86/dell/dell-smbios.h       |   7 +
>  4 files changed, 357 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-power-dell
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-power-dell b/Documenta=
tion/ABI/testing/sysfs-class-power-dell
> new file mode 100644
> index 000000000000..d8c542177558
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-power-dell
> @@ -0,0 +1,33 @@
> +What:=09=09/sys/class/power_supply/<supply_name>/charge_type
> +Date:=09=09August 2024
> +KernelVersion:=096.12
> +Contact:=09linux-pm@vger.kernel.org
> +Description:
> +=09=09Select the charging algorithm to use for the (primary)
> +=09=09battery.
> +
> +=09=09Standard:
> +=09=09=09Fully charge the battery at a moderate rate.
> +=09=09Fast:
> +=09=09=09Quickly charge the battery using fast-charge
> +=09=09=09technology. This is harder on the battery than
> +=09=09=09standard charging and may lower its lifespan.
> +=09=09=09The Dell BIOS calls this ExpressCharge=E2=84=A2.
> +=09=09Trickle:
> +=09=09=09Users who primarily operate the system while
> +=09=09=09plugged into an external power source can extend
> +=09=09=09battery life with this mode. The Dell BIOS calls
> +=09=09=09this "Primarily AC Use".
> +=09=09Adaptive:
> +=09=09=09Automatically optimize battery charge rate based
> +=09=09=09on typical usage pattern.
> +=09=09Custom:
> +=09=09=09Use the charge_control_* properties to determine
> +=09=09=09when to start and stop charging. Advanced users
> +=09=09=09can use this to drastically extend battery life.
> +
> +=09=09Access: Read, Write
> +=09=09Valid values:
> +=09=09=09      "Standard", "Fast", "Trickle",
> +=09=09=09      "Adaptive", "Custom"
> +
> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/del=
l/Kconfig
> index 85a78ef91182..02405793163c 100644
> --- a/drivers/platform/x86/dell/Kconfig
> +++ b/drivers/platform/x86/dell/Kconfig
> @@ -49,6 +49,7 @@ config DELL_LAPTOP
>  =09default m
>  =09depends on DMI
>  =09depends on BACKLIGHT_CLASS_DEVICE
> +=09depends on ACPI_BATTERY
>  =09depends on ACPI_VIDEO || ACPI_VIDEO =3D n
>  =09depends on RFKILL || RFKILL =3D n
>  =09depends on DELL_WMI || DELL_WMI =3D n
> diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x=
86/dell/dell-laptop.c
> index 6552dfe491c6..8cc05f0fab91 100644
> --- a/drivers/platform/x86/dell/dell-laptop.c
> +++ b/drivers/platform/x86/dell/dell-laptop.c
> @@ -22,11 +22,13 @@
>  #include <linux/io.h>
>  #include <linux/rfkill.h>
>  #include <linux/power_supply.h>
> +#include <linux/sysfs.h>
>  #include <linux/acpi.h>
>  #include <linux/mm.h>
>  #include <linux/i8042.h>
>  #include <linux/debugfs.h>
>  #include <linux/seq_file.h>
> +#include <acpi/battery.h>
>  #include <acpi/video.h>
>  #include "dell-rbtn.h"
>  #include "dell-smbios.h"
> @@ -99,6 +101,18 @@ static bool force_rfkill;
>  static bool micmute_led_registered;
>  static bool mute_led_registered;
> =20
> +static const struct {
> +=09int token;
> +=09const char *label;
> +} battery_modes[] =3D {

Please don't try to do this in one go but split it into two (define and=20
then declaration of the variable).

> +=09{ BAT_STANDARD_MODE_TOKEN, "Standard" },
> +=09{ BAT_EXPRESS_MODE_TOKEN, "Fast" },
> +=09{ BAT_PRI_AC_MODE_TOKEN, "Trickle" },
> +=09{ BAT_ADAPTIVE_MODE_TOKEN, "Adaptive" },
> +=09{ BAT_CUSTOM_MODE_TOKEN, "Custom" },

I suggest aligning the strings with tabs for better readability.

> +};
> +static u32 battery_supported_modes;
> +
>  module_param(force_rfkill, bool, 0444);
>  MODULE_PARM_DESC(force_rfkill, "enable rfkill on non whitelisted models"=
);
> =20
> @@ -353,6 +367,32 @@ static const struct dmi_system_id dell_quirks[] __in=
itconst =3D {
>  =09{ }
>  };
> =20
> +/* -1 is a sentinel value, telling us to use token->value */
> +#define USE_TVAL ((u32) -1)
> +static int dell_send_request_for_tokenid(struct calling_interface_buffer=
 *buffer,
> +=09=09=09=09=09 u16 class, u16 select, u16 tokenid,
> +=09=09=09=09=09 u32 val)
> +{
> +=09struct calling_interface_token *token;
> +
> +=09token =3D dell_smbios_find_token(tokenid);
> +=09if (!token)
> +=09=09return -ENODEV;
> +
> +=09if (val =3D=3D USE_TVAL)
> +=09=09val =3D token->value;
> +
> +=09dell_fill_request(buffer, token->location, val, 0, 0);
> +=09return dell_send_request(buffer, class, select);
> +}
> +
> +static inline int dell_set_std_token_value(struct calling_interface_buff=
er *buffer,
> +=09=09u16 tokenid, u32 value)
> +{
> +=09return dell_send_request_for_tokenid(buffer, CLASS_TOKEN_WRITE,
> +=09=09=09SELECT_TOKEN_STD, tokenid, value);
> +}
> +
>  /*
>   * Derived from information in smbios-wireless-ctl:
>   *
> @@ -2183,6 +2223,279 @@ static struct led_classdev mute_led_cdev =3D {
>  =09.default_trigger =3D "audio-mute",
>  };
> =20
> +static int dell_battery_set_mode(const u16 tokenid)
> +{
> +=09struct calling_interface_buffer buffer;
> +
> +=09return dell_set_std_token_value(&buffer, tokenid, USE_TVAL);
> +}
> +
> +static int dell_battery_read(const u16 tokenid)
> +{
> +=09struct calling_interface_buffer buffer;
> +=09int err;
> +
> +=09err =3D dell_send_request_for_tokenid(&buffer, CLASS_TOKEN_READ,
> +=09=09=09SELECT_TOKEN_STD, tokenid, 0);
> +=09if (err)
> +=09=09return err;
> +
> +=09if (buffer.output[1] > INT_MAX)
> +=09=09return -EIO;
> +
> +=09return buffer.output[1];
> +}
> +
> +static bool dell_battery_mode_is_active(const u16 tokenid)
> +{
> +=09struct calling_interface_token *token;
> +=09int ret;
> +
> +=09ret =3D dell_battery_read(tokenid);
> +=09if (ret < 0)
> +=09=09return false;
> +
> +=09token =3D dell_smbios_find_token(tokenid);
> +=09/* token's already verified by dell_battery_read() */
> +
> +=09return token->value =3D=3D (u16) ret;
> +}
> +
> +/*
> + * The rules: the minimum start charging value is 50%. The maximum
> + * start charging value is 95%. The minimum end charging value is
> + * 55%. The maximum end charging value is 100%. And finally, there
> + * has to be at least a 5% difference between start & end values.
> + */
> +#define CHARGE_START_MIN=0950
> +#define CHARGE_START_MAX=0995
> +#define CHARGE_END_MIN=09=0955
> +#define CHARGE_END_MAX=09=09100
> +#define CHARGE_MIN_DIFF=09=095
> +
> +static int dell_battery_set_custom_charge_start(int start)
> +{
> +=09struct calling_interface_buffer buffer;
> +=09int end;
> +
> +=09if (start < CHARGE_START_MIN)
> +=09=09start =3D CHARGE_START_MIN;
> +=09else if (start > CHARGE_START_MAX)
> +=09=09start =3D CHARGE_START_MAX;

We have clamp().

> +
> +=09end =3D dell_battery_read(BAT_CUSTOM_CHARGE_END);
> +=09if (end < 0)
> +=09=09return end;
> +=09if ((end - start) < CHARGE_MIN_DIFF)

Extra parenthesis.

> +=09=09start =3D end - CHARGE_MIN_DIFF;
> +
> +=09return dell_set_std_token_value(&buffer, BAT_CUSTOM_CHARGE_START,
> +=09=09=09start);
> +}
> +
> +static int dell_battery_set_custom_charge_end(int end)
> +{
> +=09struct calling_interface_buffer buffer;
> +=09int start;
> +
> +=09if (end < CHARGE_END_MIN)
> +=09=09end =3D CHARGE_END_MIN;
> +=09else if (end > CHARGE_END_MAX)
> +=09=09end =3D CHARGE_END_MAX;

clamp.

> +=09start =3D dell_battery_read(BAT_CUSTOM_CHARGE_START);
> +=09if (start < 0)
> +=09=09return start;
> +=09if ((end - start) < CHARGE_MIN_DIFF)

Extra parenthesis.

> +=09=09end =3D start + CHARGE_MIN_DIFF;
> +
> +=09return dell_set_std_token_value(&buffer, BAT_CUSTOM_CHARGE_END, end);
> +}
> +
> +static ssize_t charge_type_show(struct device *dev,
> +=09=09struct device_attribute *attr,
> +=09=09char *buf)
> +{
> +=09ssize_t count =3D 0;
> +=09int i;
> +
> +=09for (i =3D 0; i < ARRAY_SIZE(battery_modes); i++) {
> +=09=09bool active;
> +
> +=09=09if (!(battery_supported_modes & BIT(i)))

Why not store this supported information into battery_modes itself?
What's the benefit of obfuscation it with the extra variable & BIT()?

--=20
 i.

> +=09=09=09continue;
> +
> +=09=09active =3D dell_battery_mode_is_active(battery_modes[i].token);
> +=09=09count +=3D sysfs_emit_at(buf, count, active ? "[%s] " : "%s ",
> +=09=09=09=09battery_modes[i].label);
> +=09}
> +
> +=09/* convert the last space to a newline */
> +=09if (count > 0)
> +=09=09count--;
> +=09count +=3D sysfs_emit_at(buf, count, "\n");
> +
> +=09return count;
> +}
> +
> +static ssize_t charge_type_store(struct device *dev,
> +=09=09struct device_attribute *attr,
> +=09=09const char *buf, size_t size)
> +{
> +=09bool matched =3D false;
> +=09int err, i;
> +
> +=09for (i =3D 0; i < ARRAY_SIZE(battery_modes); i++) {
> +=09=09if (!(battery_supported_modes & BIT(i)))
> +=09=09=09continue;
> +
> +=09=09if (sysfs_streq(battery_modes[i].label, buf)) {
> +=09=09=09matched =3D true;
> +=09=09=09break;
> +=09=09}
> +=09}
> +=09if (!matched || !(battery_supported_modes & BIT(i)))
> +=09=09return -EINVAL;
> +
> +=09err =3D dell_battery_set_mode(battery_modes[i].token);
> +=09if (err)
> +=09=09return err;
> +
> +=09return size;
> +}
> +
> +static ssize_t charge_control_start_threshold_show(struct device *dev,
> +=09=09struct device_attribute *attr,
> +=09=09char *buf)
> +{
> +=09int start;
> +
> +=09start =3D dell_battery_read(BAT_CUSTOM_CHARGE_START);
> +=09if (start < 0)
> +=09=09return start;
> +
> +=09if (start > CHARGE_START_MAX)
> +=09=09return -EIO;
> +
> +=09return sysfs_emit(buf, "%d\n", start);
> +}
> +
> +static ssize_t charge_control_start_threshold_store(struct device *dev,
> +=09=09struct device_attribute *attr,
> +=09=09const char *buf, size_t size)
> +{
> +=09int ret, start;
> +
> +=09ret =3D kstrtoint(buf, 10, &start);
> +=09if (ret)
> +=09=09return ret;
> +=09if (start < 0 || start > 100)
> +=09=09return -EINVAL;
> +
> +=09ret =3D dell_battery_set_custom_charge_start(start);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09return size;
> +}
> +
> +static ssize_t charge_control_end_threshold_show(struct device *dev,
> +=09=09struct device_attribute *attr,
> +=09=09char *buf)
> +{
> +=09int end;
> +
> +=09end =3D dell_battery_read(BAT_CUSTOM_CHARGE_END);
> +=09if (end < 0)
> +=09=09return end;
> +
> +=09if (end > CHARGE_END_MAX)
> +=09=09return -EIO;
> +
> +=09return sysfs_emit(buf, "%d\n", end);
> +}
> +
> +static ssize_t charge_control_end_threshold_store(struct device *dev,
> +=09=09struct device_attribute *attr,
> +=09=09const char *buf, size_t size)
> +{
> +=09int ret, end;
> +
> +=09ret =3D kstrtouint(buf, 10, &end);
> +=09if (ret)
> +=09=09return ret;
> +=09if (end < 0 || end > 100)
> +=09=09return -EINVAL;
> +
> +=09ret =3D dell_battery_set_custom_charge_end(end);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09return size;
> +}
> +
> +static DEVICE_ATTR_RW(charge_control_start_threshold);
> +static DEVICE_ATTR_RW(charge_control_end_threshold);
> +static DEVICE_ATTR_RW(charge_type);
> +
> +static struct attribute *dell_battery_attrs[] =3D {
> +=09&dev_attr_charge_control_start_threshold.attr,
> +=09&dev_attr_charge_control_end_threshold.attr,
> +=09&dev_attr_charge_type.attr,
> +=09NULL,
> +};
> +ATTRIBUTE_GROUPS(dell_battery);
> +
> +static int dell_battery_add(struct power_supply *battery,
> +=09=09struct acpi_battery_hook *hook)
> +{
> +=09/* this currently only supports the primary battery */
> +=09if (strcmp(battery->desc->name, "BAT0") !=3D 0)
> +=09=09return -ENODEV;
> +
> +=09return device_add_groups(&battery->dev, dell_battery_groups);
> +}
> +
> +static int dell_battery_remove(struct power_supply *battery,
> +=09=09struct acpi_battery_hook *hook)
> +{
> +=09device_remove_groups(&battery->dev, dell_battery_groups);
> +=09return 0;
> +}
> +
> +static struct acpi_battery_hook dell_battery_hook =3D {
> +=09.add_battery =3D dell_battery_add,
> +=09.remove_battery =3D dell_battery_remove,
> +=09.name =3D "Dell Primary Battery Extension",
> +};
> +
> +static u32 __init battery_get_supported_modes(void)
> +{
> +=09u32 modes =3D 0;
> +=09int i;
> +
> +=09for (i =3D 0; i < ARRAY_SIZE(battery_modes); i++) {
> +=09=09if (dell_smbios_find_token(battery_modes[i].token))
> +=09=09=09modes |=3D BIT(i);
> +=09}
> +
> +=09return modes;
> +}
> +
> +static void __init dell_battery_init(struct device *dev)
> +{
> +=09battery_supported_modes =3D battery_get_supported_modes();
> +
> +=09if (battery_supported_modes !=3D 0)
> +=09=09battery_hook_register(&dell_battery_hook);
> +}
> +
> +static void __exit dell_battery_exit(void)
> +{
> +=09if (battery_supported_modes !=3D 0)
> +=09=09battery_hook_unregister(&dell_battery_hook);
> +}
> +
>  static int __init dell_init(void)
>  {
>  =09struct calling_interface_token *token;
> @@ -2219,6 +2532,7 @@ static int __init dell_init(void)
>  =09=09touchpad_led_init(&platform_device->dev);
> =20
>  =09kbd_led_init(&platform_device->dev);
> +=09dell_battery_init(&platform_device->dev);
> =20
>  =09dell_laptop_dir =3D debugfs_create_dir("dell_laptop", NULL);
>  =09debugfs_create_file("rfkill", 0444, dell_laptop_dir, NULL,
> @@ -2293,6 +2607,7 @@ static int __init dell_init(void)
>  =09if (mute_led_registered)
>  =09=09led_classdev_unregister(&mute_led_cdev);
>  fail_led:
> +=09dell_battery_exit();
>  =09dell_cleanup_rfkill();
>  fail_rfkill:
>  =09platform_device_del(platform_device);
> @@ -2311,6 +2626,7 @@ static void __exit dell_exit(void)
>  =09if (quirks && quirks->touchpad_led)
>  =09=09touchpad_led_exit();
>  =09kbd_led_exit();
> +=09dell_battery_exit();
>  =09backlight_device_unregister(dell_backlight_device);
>  =09if (micmute_led_registered)
>  =09=09led_classdev_unregister(&micmute_led_cdev);
> diff --git a/drivers/platform/x86/dell/dell-smbios.h b/drivers/platform/x=
86/dell/dell-smbios.h
> index ea0cc38642a2..77baa15eb523 100644
> --- a/drivers/platform/x86/dell/dell-smbios.h
> +++ b/drivers/platform/x86/dell/dell-smbios.h
> @@ -33,6 +33,13 @@
>  #define KBD_LED_AUTO_50_TOKEN=090x02EB
>  #define KBD_LED_AUTO_75_TOKEN=090x02EC
>  #define KBD_LED_AUTO_100_TOKEN=090x02F6
> +#define BAT_PRI_AC_MODE_TOKEN=090x0341
> +#define BAT_ADAPTIVE_MODE_TOKEN=090x0342
> +#define BAT_CUSTOM_MODE_TOKEN=090x0343
> +#define BAT_STANDARD_MODE_TOKEN=090x0346
> +#define BAT_EXPRESS_MODE_TOKEN=090x0347
> +#define BAT_CUSTOM_CHARGE_START=090x0349
> +#define BAT_CUSTOM_CHARGE_END=090x034A
>  #define GLOBAL_MIC_MUTE_ENABLE=090x0364
>  #define GLOBAL_MIC_MUTE_DISABLE=090x0365
>  #define GLOBAL_MUTE_ENABLE=090x058C
>=20
--8323328-413153107-1723816584=:1024--

