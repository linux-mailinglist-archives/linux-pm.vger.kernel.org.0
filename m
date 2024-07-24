Return-Path: <linux-pm+bounces-11353-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C52CF93AAE0
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 04:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 381911F21E50
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 02:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAB1E56A;
	Wed, 24 Jul 2024 02:05:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DB9A95E;
	Wed, 24 Jul 2024 02:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721786712; cv=none; b=qDluzZfLA55Y1+W71A7yYD9wD83fUHt7EZqea59pH5TCVL/3222NHJ14iamyg1tXsWkPjkCeazWcogfZgwng6LIJP9j6JcfcLdKNxX3ncej2ydmWAbNneDOzBtlbnnes0NDeYsaoS2U9qSEUSl1rW1ehbclInVEu3vVdNvqi3gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721786712; c=relaxed/simple;
	bh=DkTr0f25/Lc51xt1K2F7wxnAx+EYBYop47c9ElXUzUY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=fWExSATYHcX4ijPGyStT9S8fpi6k0lnUf7+TSfmzBJP4HW2e2tiB38VnlYfYKsp0uXCwkGJwvGJN14gFwpYe8jcuSo/TfZ9VXD09U7jQxhGwfFMYQN2XMy2WuxSUwphy7LAsyOGfy4qKa/FBGoqAqlcdf+S3PUhiJaKuAcdPJM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id 6FA52115A18; Tue, 23 Jul 2024 22:05:09 -0400 (EDT)
Received: from 5400 (unknown [172.56.164.186])
	by spindle.queued.net (Postfix) with ESMTPSA id 41876115A0B;
	Tue, 23 Jul 2024 22:05:07 -0400 (EDT)
Date: Tue, 23 Jul 2024 22:05:02 -0400
From: Andres Salomon <dilinger@queued.net>
To: linux-kernel@vger.kernel.org
Cc: Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
 platform-driver-x86@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
 Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 "Ilpo =?UTF-8?B?SsOkcnZpbmVu?=" <ilpo.jarvinen@linux.intel.com>,
 linux-pm@vger.kernel.org, Dell.Client.Kernel@dell.com
Subject: [PATCH v2 1/2] platform/x86:dell-laptop: Add knobs to change
 battery charge settings
Message-ID: <20240723220502.77cb0401@5400>
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


The Dell BIOS allows you to set custom charging modes, which is useful
in particular for extending battery life. This adds support for tweaking
those various settings from Linux via sysfs knobs. One might, for
example, have their laptop plugged into power at their desk the vast
majority of the time and choose fairly aggressive battery-saving
settings (only charging once the battery drops to 50% and only charging
up to 80%). When leaving for a trip, they might want to switch those
settings to charge to 100% and charge any time power is available;
rebooting into the BIOS to change those settings is a hassle.

For the Custom charging type mode, we reuse the common
charge_control_{start,end}_threshold sysfs power_supply entries. The
BIOS also has a bunch of other charging modes (with varying levels of
usefulness), so this adds a new Dell-specific sysfs entry called
'charge_type' that's documented in sysfs-class-power-dell (and looks a
lot like sysfs-class-power-wilco).

This work is based on a patch by Perry Yuan <perry_yuan@dell.com> and
Limonciello Mario <Mario_Limonciello@Dell.com> submitted back in 2020:
https://lore.kernel.org/all/20200729065424.12851-1-Perry_Yuan@Dell.com/
Both of their email addresses bounce, so I'm assuming they're no longer
with the company. I've reworked most of the patch to make it smaller and
cleaner.

Signed-off-by: Andres Salomon <dilinger@queued.net>
---
Changes in v2, based on extensive feedback from Pali Roh=C3=A1r <pali@kerne=
l.org>:
    - code style changes
    - change battery write API to use token->value instead of passed value
    - stop caching current mode, instead querying SMBIOS as needed
    - drop the separate list of charging modes enum
    - rework the list of charging mode strings
    - query SMBIOS for supported charging modes
    - split dell_battery_custom_set() up
---
 .../ABI/testing/sysfs-class-power-dell        |  31 ++
 drivers/platform/x86/dell/Kconfig             |   1 +
 drivers/platform/x86/dell/dell-laptop.c       | 288 ++++++++++++++++++
 drivers/platform/x86/dell/dell-smbios.h       |   7 +
 4 files changed, 327 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-dell

diff --git a/Documentation/ABI/testing/sysfs-class-power-dell b/Documentati=
on/ABI/testing/sysfs-class-power-dell
new file mode 100644
index 000000000000..ef72c5f797ce
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-power-dell
@@ -0,0 +1,31 @@
+What:		/sys/class/power_supply/<supply_name>/charge_type
+Date:		July 2024
+KernelVersion:	6.11
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Select the charging algorithm to use for the (primary)
+		battery.
+
+		Standard:
+			Fully charge the battery at a moderate rate.
+		ExpressCharge=E2=84=A2:
+			Quickly charge the battery using fast-charge
+			technology. This is harder on the battery than
+			standard charging and may lower its lifespan.
+		Primarily AC Use:
+			Users who primarily operate the system while
+			plugged into an external power source can extend
+			battery life with this mode.
+		Adaptive:
+			Automatically optimize battery charge rate based
+			on typical usage.
+		Custom:
+			Use the charge_control_* properties to determine
+			when to start and stop charging. Advanced users
+			can use this to drastically extend battery life.
+
+		Access: Read, Write
+		Valid values:
+			      "standard", "express", "primarily_ac",
+			      "adaptive", "custom"
+
diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/=
Kconfig
index 85a78ef91182..02405793163c 100644
--- a/drivers/platform/x86/dell/Kconfig
+++ b/drivers/platform/x86/dell/Kconfig
@@ -49,6 +49,7 @@ config DELL_LAPTOP
 	default m
 	depends on DMI
 	depends on BACKLIGHT_CLASS_DEVICE
+	depends on ACPI_BATTERY
 	depends on ACPI_VIDEO || ACPI_VIDEO =3D n
 	depends on RFKILL || RFKILL =3D n
 	depends on DELL_WMI || DELL_WMI =3D n
diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86=
/dell/dell-laptop.c
index 6552dfe491c6..aae9a95fb188 100644
--- a/drivers/platform/x86/dell/dell-laptop.c
+++ b/drivers/platform/x86/dell/dell-laptop.c
@@ -22,11 +22,13 @@
 #include <linux/io.h>
 #include <linux/rfkill.h>
 #include <linux/power_supply.h>
+#include <linux/sysfs.h>
 #include <linux/acpi.h>
 #include <linux/mm.h>
 #include <linux/i8042.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
+#include <acpi/battery.h>
 #include <acpi/video.h>
 #include "dell-rbtn.h"
 #include "dell-smbios.h"
@@ -99,6 +101,18 @@ static bool force_rfkill;
 static bool micmute_led_registered;
 static bool mute_led_registered;
=20
+static const struct {
+	int token;
+	const char *label;
+} battery_modes[] =3D {
+	{ BAT_STANDARD_MODE_TOKEN, "standard" },
+	{ BAT_EXPRESS_MODE_TOKEN, "express" },
+	{ BAT_PRI_AC_MODE_TOKEN, "primarily_ac" },
+	{ BAT_ADAPTIVE_MODE_TOKEN, "adaptive" },
+	{ BAT_CUSTOM_MODE_TOKEN, "custom" },
+};
+static u32 battery_supported_modes;
+
 module_param(force_rfkill, bool, 0444);
 MODULE_PARM_DESC(force_rfkill, "enable rfkill on non whitelisted models");
=20
@@ -2183,6 +2197,277 @@ static struct led_classdev mute_led_cdev =3D {
 	.default_trigger =3D "audio-mute",
 };
=20
+static int dell_send_request_by_token_loc(struct calling_interface_buffer =
*buffer,
+					  u16 class, u16 select, int type,
+					  u32 val)
+{
+	struct calling_interface_token *token;
+
+	token =3D dell_smbios_find_token(type);
+	if (!token)
+		return -ENODEV;
+
+	/* -1 is a sentinel value, telling us to use token->value */
+	if (val =3D=3D (u32)-1)
+		val =3D token->value;
+
+	dell_fill_request(buffer, token->location, val, 0, 0);
+	return dell_send_request(buffer, class, select);
+}
+
+static int dell_battery_set_mode(const int type)
+{
+	struct calling_interface_buffer buffer;
+
+	/* -1 means use the value from the token */
+	return dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_WRITE,
+			SELECT_TOKEN_STD, type, -1);
+}
+
+static int dell_battery_read(const int type)
+{
+	struct calling_interface_buffer buffer;
+	int err;
+
+	err =3D dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_READ,
+			SELECT_TOKEN_STD, type, 0);
+	if (err)
+		return err;
+
+	return buffer.output[1];
+}
+
+static bool dell_battery_mode_is_active(const int type)
+{
+	struct calling_interface_token *token;
+
+	token =3D dell_smbios_find_token(type);
+	if (!token)
+		return false;
+
+	return token->value =3D=3D dell_battery_read(type);
+}
+
+/* The rules: the minimum start charging value is 50%. The maximum
+ * start charging value is 95%. The minimum end charging value is
+ * 55%. The maximum end charging value is 100%. And finally, there
+ * has to be at least a 5% difference between start & end values.
+ */
+#define CHARGE_START_MIN	50
+#define CHARGE_START_MAX	95
+#define CHARGE_END_MIN		55
+#define CHARGE_END_MAX		100
+#define CHARGE_MIN_DIFF		5
+
+static int dell_battery_set_custom_charge_start(int start)
+{
+	struct calling_interface_buffer buffer;
+	int end;
+
+	if (start < CHARGE_START_MIN)
+		start =3D CHARGE_START_MIN;
+	else if (start > CHARGE_START_MAX)
+		start =3D CHARGE_START_MAX;
+
+	end =3D dell_battery_read(BAT_CUSTOM_CHARGE_END);
+	/* a failed read is okay */
+	if (end < 0)
+		end =3D CHARGE_END_MAX;
+	if ((end - start) < CHARGE_MIN_DIFF)
+		start =3D end - CHARGE_MIN_DIFF;
+
+	return dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_WRITE,
+			SELECT_TOKEN_STD, BAT_CUSTOM_CHARGE_START, start);
+}
+
+static int dell_battery_set_custom_charge_end(int end)
+{
+	struct calling_interface_buffer buffer;
+	int start;
+
+	if (end < CHARGE_END_MIN)
+		end =3D CHARGE_END_MIN;
+	else if (end > CHARGE_END_MAX)
+		end =3D CHARGE_END_MAX;
+
+	start =3D dell_battery_read(BAT_CUSTOM_CHARGE_START);
+	/* a failed read is okay */
+	if (start < 0)
+		start =3D CHARGE_START_MIN;
+	if ((end - start) < CHARGE_MIN_DIFF)
+		end =3D start + CHARGE_MIN_DIFF;
+
+	return dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_WRITE,
+			SELECT_TOKEN_STD, BAT_CUSTOM_CHARGE_END, end);
+}
+
+static ssize_t charge_type_show(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	ssize_t count =3D 0;
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(battery_modes); i++) {
+		bool active;
+
+		if (!(battery_supported_modes & BIT(i)))
+			continue;
+
+		active =3D dell_battery_mode_is_active(battery_modes[i].token);
+		count +=3D sysfs_emit_at(buf, count, active ? "[%s] " : "%s ",
+				battery_modes[i].label);
+	}
+
+	/* convert the last space to a newline */
+	if (count > 0)
+		count--;
+	count +=3D sysfs_emit_at(buf, count, "\n");
+
+	return count;
+}
+
+static ssize_t charge_type_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t size)
+{
+	bool matched =3D false;
+	int err, i;
+
+	for (i =3D 0; i < ARRAY_SIZE(battery_modes); i++) {
+		if (sysfs_streq(battery_modes[i].label, buf)) {
+			matched =3D true;
+			break;
+		}
+	}
+	if (!matched || !(battery_supported_modes & BIT(i)))
+		return -EINVAL;
+
+	err =3D dell_battery_set_mode(battery_modes[i].token);
+	if (err)
+		return err;
+
+	return size;
+}
+
+static ssize_t charge_control_start_threshold_show(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	int start;
+
+	start =3D dell_battery_read(BAT_CUSTOM_CHARGE_START);
+	if (start < 0)
+		return start;
+
+	return sysfs_emit(buf, "%d\n", start);
+}
+
+static ssize_t charge_control_start_threshold_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t size)
+{
+	int ret, start;
+
+	ret =3D kstrtoint(buf, 10, &start);
+	if (ret)
+		return ret;
+
+	ret =3D dell_battery_set_custom_charge_start(start);
+	if (ret)
+		return ret;
+
+	return size;
+}
+
+static ssize_t charge_control_end_threshold_show(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	int end;
+
+	end =3D dell_battery_read(BAT_CUSTOM_CHARGE_END);
+	if (end < 0)
+		return end;
+
+	return sysfs_emit(buf, "%d\n", end);
+}
+
+static ssize_t charge_control_end_threshold_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t size)
+{
+	int ret, end;
+
+	ret =3D kstrtouint(buf, 10, &end);
+	if (ret)
+		return ret;
+
+	ret =3D dell_battery_set_custom_charge_end(end);
+	if (ret)
+		return ret;
+
+	return size;
+}
+
+static DEVICE_ATTR_RW(charge_control_start_threshold);
+static DEVICE_ATTR_RW(charge_control_end_threshold);
+static DEVICE_ATTR_RW(charge_type);
+
+static struct attribute *dell_battery_attrs[] =3D {
+	&dev_attr_charge_control_start_threshold.attr,
+	&dev_attr_charge_control_end_threshold.attr,
+	&dev_attr_charge_type.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(dell_battery);
+
+static int dell_battery_add(struct power_supply *battery,
+		struct acpi_battery_hook *hook)
+{
+	return device_add_groups(&battery->dev, dell_battery_groups);
+}
+
+static int dell_battery_remove(struct power_supply *battery,
+		struct acpi_battery_hook *hook)
+{
+	device_remove_groups(&battery->dev, dell_battery_groups);
+	return 0;
+}
+
+static struct acpi_battery_hook dell_battery_hook =3D {
+	.add_battery =3D dell_battery_add,
+	.remove_battery =3D dell_battery_remove,
+	.name =3D "Dell Primary Battery Extension",
+};
+
+static u32 __init battery_get_supported_modes(void)
+{
+	u32 modes =3D 0;
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(battery_modes); i++) {
+		if (dell_smbios_find_token(battery_modes[i].token))
+			modes |=3D BIT(i);
+	}
+
+	return modes;
+}
+
+static void __init dell_battery_init(struct device *dev)
+{
+	battery_supported_modes =3D battery_get_supported_modes();
+
+	if (battery_supported_modes !=3D 0)
+		battery_hook_register(&dell_battery_hook);
+}
+
+static void __exit dell_battery_exit(void)
+{
+	if (battery_supported_modes !=3D 0)
+		battery_hook_unregister(&dell_battery_hook);
+}
+
 static int __init dell_init(void)
 {
 	struct calling_interface_token *token;
@@ -2219,6 +2504,7 @@ static int __init dell_init(void)
 		touchpad_led_init(&platform_device->dev);
=20
 	kbd_led_init(&platform_device->dev);
+	dell_battery_init(&platform_device->dev);
=20
 	dell_laptop_dir =3D debugfs_create_dir("dell_laptop", NULL);
 	debugfs_create_file("rfkill", 0444, dell_laptop_dir, NULL,
@@ -2293,6 +2579,7 @@ static int __init dell_init(void)
 	if (mute_led_registered)
 		led_classdev_unregister(&mute_led_cdev);
 fail_led:
+	dell_battery_exit();
 	dell_cleanup_rfkill();
 fail_rfkill:
 	platform_device_del(platform_device);
@@ -2311,6 +2598,7 @@ static void __exit dell_exit(void)
 	if (quirks && quirks->touchpad_led)
 		touchpad_led_exit();
 	kbd_led_exit();
+	dell_battery_exit();
 	backlight_device_unregister(dell_backlight_device);
 	if (micmute_led_registered)
 		led_classdev_unregister(&micmute_led_cdev);
diff --git a/drivers/platform/x86/dell/dell-smbios.h b/drivers/platform/x86=
/dell/dell-smbios.h
index ea0cc38642a2..77baa15eb523 100644
--- a/drivers/platform/x86/dell/dell-smbios.h
+++ b/drivers/platform/x86/dell/dell-smbios.h
@@ -33,6 +33,13 @@
 #define KBD_LED_AUTO_50_TOKEN	0x02EB
 #define KBD_LED_AUTO_75_TOKEN	0x02EC
 #define KBD_LED_AUTO_100_TOKEN	0x02F6
+#define BAT_PRI_AC_MODE_TOKEN	0x0341
+#define BAT_ADAPTIVE_MODE_TOKEN	0x0342
+#define BAT_CUSTOM_MODE_TOKEN	0x0343
+#define BAT_STANDARD_MODE_TOKEN	0x0346
+#define BAT_EXPRESS_MODE_TOKEN	0x0347
+#define BAT_CUSTOM_CHARGE_START	0x0349
+#define BAT_CUSTOM_CHARGE_END	0x034A
 #define GLOBAL_MIC_MUTE_ENABLE	0x0364
 #define GLOBAL_MIC_MUTE_DISABLE	0x0365
 #define GLOBAL_MUTE_ENABLE	0x058C
--=20
2.39.2




--=20
I'm available for contract & employment work, see:
https://spindle.queued.net/~dilinger/resume-tech.pdf

