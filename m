Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBB245322E
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 13:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236208AbhKPMbV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 07:31:21 -0500
Received: from mail-lf1-f52.google.com ([209.85.167.52]:37420 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236046AbhKPMbU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 07:31:20 -0500
Received: by mail-lf1-f52.google.com with SMTP id c32so52774373lfv.4;
        Tue, 16 Nov 2021 04:28:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x34Wmq5UEibmmAViM4h392AJ2nzdGPzrPviO8aZH958=;
        b=RwOnkK1kPcVYq9izUkfCVCAjSZcocSUFy1mdm97IYptjQNVBeZgBMFFOQdwPEdoWNb
         Rj7gTLVwhX6MbAdChSatP0cCAW+AHugAEs5SxShzzoEpQgrE8qBK2rbYDv0kIGvexQ65
         KgfOAA4KjJKQsEyI/1wT1dLRi64d02Ad7LeKqJuby/MnOKgipHlijU0tWCwo1GUMSFaO
         N/Iye0+IRA41Y0c7BRl+4TW8VNXDPNYFtpQBwZde1z3jBHONB5pWHCf1iIMCIrcT+MhN
         0+NtARSPV2xtYfnaF7OgalDUclcS+O4RTVXUC3oUuX9HYIL2S0FD4QJ7180uKQiMwFqZ
         aSsQ==
X-Gm-Message-State: AOAM5334aRr3Mi10LT2cKeCbt2YQGVj3ll8os6hwUH+KSgcEAz+6Tqal
        jr7s8tPNQOKqmBAKcgLx7Mk=
X-Google-Smtp-Source: ABdhPJwVMNPnMiTXtG4+v4jp8KH2KUUJQh74RZsmEtNcFkP9nF5YIgcmZRbfSW+pQvjDFhiAyMJbSQ==
X-Received: by 2002:ac2:54b7:: with SMTP id w23mr6479169lfk.163.1637065701267;
        Tue, 16 Nov 2021 04:28:21 -0800 (PST)
Received: from fedora (dc73szyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::4])
        by smtp.gmail.com with ESMTPSA id k5sm1816451lja.34.2021.11.16.04.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 04:28:20 -0800 (PST)
Date:   Tue, 16 Nov 2021 14:28:13 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, rostokus@gmail.com,
        fan.chen@mediatek.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Subject: [RFC PATCH v3 7/9] power: supply: add simple-gauge for SOC
 estimation and CC correction
Message-ID: <26a80d9081382976cec58f9c3bc0ecb181c5836e.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c73i0tdUUwqAJl/f"
Content-Disposition: inline
In-Reply-To: <cover.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--c73i0tdUUwqAJl/f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add generic 'simple gauge' helper for performing iterative SOC estimation
and coulomb counter correction for devices with a (drifting) coulomb
counter. This should allow few charger/fuel-gauge drivers to use generic
loop instead of implementing their own.

Charger/fuel-gauge drivers can register 'simple-gauge' which does
periodically poll the driver and:
 - get battery state
 - adjust coulomb counter value (to fix drifting caused for example by ADC
   offset) if:
     - Battery is relaxed and OCV<=3D>SOC table is given
     - Battery is full charged
 - get battery age (cycles) from driver
 - get battery temperature
 - do battery capacity correction
     - by battery temperature
     - by battery age
     - by computed Vbat/OCV difference at low-battery condition if
       low-limit is set and OCV table given
     - by IC specific low-battery correction if provided
 - compute current State Of Charge (SOC)
 - do periodical calibration if IC supports that. (Many ICs do calibration
   of CC by shorting the ADC pins and getting the offset).
 - provide the user-space a consistent interface for getting/setting the
   battery-cycle information for ICs which can't store the battery aging
   information. Uses POWER_SUPPLY_PROP_CYCLE_COUNT for this.

The simple gauge provides the last computed SOC as
POWER_SUPPLY_PROP_CAPACITY to power_supply_class when requested.

Things that should/could be added but are missing from this commit:
 - Support starting calibration in HW when entering to suspend. This
   is useful for ICs supporting delayed calibration to mitigate CC error
   during suspend - and to make periodical wake-up less critical.
 - periodical wake-up for performing SOC estimation computation (RTC
   integration)

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

---
RFCv3:
  - use devm_add_action_or_reset
  - Rename to simple_gauge
  - Limit access to power_supply parameters
  - Introduce simple_gauge_drvdata
  - no need to show simple_gauge at config menu. Users should just SELECT i=
t.
  - allow tristate
  - Add blocking 'iteration run' - loop.
  - updated the comment section
  - Fixed clamped SOC which was not updated
  - Small comment improvements
  - Don't allow negative CC after computing capacity corrections
  - Fix gauge looping when last client exits
---
 drivers/power/supply/Kconfig        |    3 +
 drivers/power/supply/Makefile       |    1 +
 drivers/power/supply/simple-gauge.c | 1303 +++++++++++++++++++++++++++
 include/linux/power/simple_gauge.h  |  244 +++++
 4 files changed, 1551 insertions(+)
 create mode 100644 drivers/power/supply/simple-gauge.c
 create mode 100644 include/linux/power/simple_gauge.h

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 5cf5bb56d2e3..24a8d030a391 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -9,6 +9,9 @@ menuconfig POWER_SUPPLY
=20
 if POWER_SUPPLY
=20
+config POWER_SIMPLE_GAUGE
+	tristate
+
 config POWER_SUPPLY_DEBUG
 	bool "Power supply debug"
 	help
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 4e55a11aab79..8c8c5f6a6492 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -5,6 +5,7 @@ power_supply-y				:=3D power_supply_core.o
 power_supply-$(CONFIG_SYSFS)		+=3D power_supply_sysfs.o
 power_supply-$(CONFIG_LEDS_TRIGGERS)	+=3D power_supply_leds.o
=20
+obj-$(CONFIG_POWER_SIMPLE_GAUGE)	+=3D simple-gauge.o
 obj-$(CONFIG_POWER_SUPPLY)	+=3D power_supply.o
 obj-$(CONFIG_POWER_SUPPLY_HWMON) +=3D power_supply_hwmon.o
 obj-$(CONFIG_GENERIC_ADC_BATTERY)	+=3D generic-adc-battery.o
diff --git a/drivers/power/supply/simple-gauge.c b/drivers/power/supply/sim=
ple-gauge.c
new file mode 100644
index 000000000000..7bf96b4d35dd
--- /dev/null
+++ b/drivers/power/supply/simple-gauge.c
@@ -0,0 +1,1303 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Implementation of some generic state-of-charge computations for devices
+ * with coulomb counter
+ *
+ * Copyright 2020 ROHM Semiconductors
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/power/simple_gauge.h>
+#include <linux/wait.h>
+
+#define SWGAUGE_TIMEOUT_JITTER 100
+/* We add 0.5% of uAh to avoid rounding error */
+#define SOC_BY_CAP(uah, round, cap) ((uah + round) * 100 / (cap))
+
+/*
+ * The idea here is to implement (typical?) periodical coulomb-counter pol=
ling
+ * and adjusting. I know few ROHM ICs which do this in out-of-tree drivers=
 -
+ * and I think there is few drivers also in-tree doing something similar. I
+ * believe adding some SOC computation logic to core could benefit a few o=
f the
+ * drivers.
+ *
+ * I selected the ROHM algorithm here because I know it better than others.
+ *
+ * So let's go explaining the logic pulled in here:
+ *
+ * Device drivers for (charger) ICs which contain a coulomb counter can
+ * register here and provide IC specific functions as listed in
+ * include/linux/power/simple_gauge.h struct simple_gauge_ops. Drivers can=
 also
+ * specify time interval the IC is polled.
+ *
+ * After registration the simple_gauge does periodically poll the driver a=
nd:
+ * 1. get battery state
+ * 2. adjust coulomb counter value (to fix drifting caused for example by =
ADC
+ *   offset) if:
+ *     - Battery is relaxed and OCV<=3D>SOC table is given
+ *     - Battery is fully charged
+ * 3. get battery age (cycles) from driver
+ * 4. get battery temperature
+ * 5. do battery capacity correction
+ *     - by battery temperature
+ *     - by battery age
+ *     - by computed Vbat/OCV difference at low-battery condition if
+ *       low-limit is set and OCV table given
+ *     - by IC specific low-battery correction if provided
+ * 6. compute current State Of Charge (SOC) based on corrected capacity
+ * 7. do periodical calibration if IC supports that. (Many ICs do calibrat=
ion
+ *   of CC by shorting the ADC pins and getting the offset).
+ *   TODO: Support starting calibration in HW when entering to suspend. Th=
is
+ *   is useful for ICs supporting delayed calibration to mitigate CC error
+ *   during suspend - and to make periodical wake-up less critical.
+ *
+ * The SW gauge provides the last computed SOC as POWER_SUPPLY_PROP_CAPACI=
TY to
+ * power_supply_class when requested.
+ *
+ * Additionally the SW-gauge provides the user-space a consistent interfac=
e for
+ * getting/setting the battery-cycle information for ICs which can't store=
 the
+ * battery aging information (like how many times battery has been charged=
 to
+ * full) over a reset. POWER_SUPPLY_PROP_CYCLE_COUNT is used for this.
+ *
+ * TODO: Some low-power devices which may spend long times suspended may p=
refer
+ * periodical wake-up for performing SOC estimation/computation even at the
+ * cost of power-consumption caused by such a wake-up. So as a future
+ * improvement it would be nice to see a RTC integration which might allow=
 the
+ * periodic wake-up. (Or is there better ideas?). This could be useful for=
 the
+ * devices which do not support calibration when SOC is turned off and cur=
rent
+ * consumption is minimal.
+ *
+ * If this is not seen as a complete waste of time - then I would like to =
get
+ * suggestions and opinions :) Especially for following:
+ * 1. Should this be meld-in power_supply_class? I didn't go to that route=
 as I
+ *    didn't want to obfuscate the power_supply registration with the item=
s in
+ *    the simple_gauge desc and ops. OTOH, the psy now has a pointer to sw=
-gauge
+ *    and sw-gauge to psy - which is a clear hint that the relation of them
+ *    is quite tight.
+ */
+
+static DEFINE_MUTEX(simple_gauge_lock);
+static DEFINE_MUTEX(simple_gauge_start_lock);
+static LIST_HEAD(simple_gauges);
+
+static int g_running;
+static struct task_struct k;
+
+static int simple_gauge_set_cycle(struct simple_gauge *sw, int new_cycle)
+{
+	int ret =3D 0, old_cycle =3D sw->cycle;
+
+	if (!sw->desc.allow_set_cycle && !sw->ops.set_cycle)
+		return -EINVAL;
+
+	if (sw->ops.set_cycle)
+		ret =3D sw->ops.set_cycle(sw, old_cycle, &new_cycle);
+
+	if (!ret)
+		sw->cycle =3D new_cycle;
+
+	return ret;
+}
+
+static int simple_gauge_set_property(struct power_supply *psy,
+				 enum power_supply_property psp,
+				 const union power_supply_propval *val)
+{
+	struct simple_gauge *sg =3D power_supply_get_drvdata(psy);
+
+	if (!sg) {
+		WARN_ON(!sg);
+		return -EINVAL;
+	}
+
+	if (psp =3D=3D POWER_SUPPLY_PROP_CYCLE_COUNT && sg->desc.allow_set_cycle)
+		return simple_gauge_set_cycle(sg, val->intval);
+
+	if (sg->set_custom_property)
+		return sg->set_custom_property(sg, psp, val);
+
+	return -EOPNOTSUPP;
+}
+
+static int simple_gauge_get_property(struct power_supply *psy,
+				 enum power_supply_property psp,
+				 union power_supply_propval *val)
+{
+	struct simple_gauge *sg =3D power_supply_get_drvdata(psy);
+
+	if (!sg) {
+		WARN_ON(!sg);
+		return -EINVAL;
+	}
+	/*
+	 * We should ensure here is that the first iteration
+	 * loop for SOC calculation must've been performed. TODO:
+	 * How to ensure it?
+	 *
+	 * TODO: Add flags to advertice which properties can be computed by
+	 * sw-gauge (with given call-backs) and only return those. Else
+	 * default with driver get_property to allow the driver to compute
+	 * and provide those w/o the SW-gauge.
+	 *
+	 * Or - we could first try calling the driver call-back and do these
+	 * as a fall-back if driver returns an error?
+	 */
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CAPACITY:
+		spin_lock(&sg->lock);
+		val->intval =3D sg->soc;
+		spin_unlock(&sg->lock);
+		return 0;
+	case POWER_SUPPLY_PROP_CYCLE_COUNT:
+		spin_lock(&sg->lock);
+		val->intval =3D sg->cycle;
+		spin_unlock(&sg->lock);
+		return 0;
+	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
+		/* uAh */
+		val->intval =3D sg->designed_cap;
+		return 0;
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+		spin_lock(&sg->lock);
+		val->intval =3D sg->capacity_uah;
+		spin_unlock(&sg->lock);
+		return 0;
+	case POWER_SUPPLY_PROP_CHARGE_NOW:
+		spin_lock(&sg->lock);
+		val->intval =3D sg->cc_uah;
+		spin_unlock(&sg->lock);
+		return 0;
+	case POWER_SUPPLY_PROP_TEMP:
+		spin_lock(&sg->lock);
+		val->intval =3D sg->temp;
+		spin_unlock(&sg->lock);
+		return 0;
+	default:
+		break;
+	}
+
+	if (sg->get_custom_property)
+		return sg->get_custom_property(sg, psp, val);
+
+	return -EOPNOTSUPP;
+}
+
+static void gauge_put(struct simple_gauge *sw)
+{
+	sw->refcount =3D 0;
+	if (!sw->refcount)
+		wake_up(&sw->wq);
+}
+
+static void gauge_get(struct simple_gauge *sw)
+{
+	sw->refcount =3D 1;
+}
+
+static int gauge_reserved(struct simple_gauge *sw)
+{
+	return sw->refcount;
+}
+
+static int get_dsoc_from_ocv(struct simple_gauge *sw, int *dsoc, int temp,=
 int ocv)
+{
+	int ret;
+
+	/*
+	 * The OCV tables use degree C as units (if I did not misread the
+	 * code - why?) - power_supply class user-space seems to mandate
+	 * the tenths of a degree - so we require this from drivers and
+	 * lose accuracy here :/
+	 */
+	ret =3D power_supply_batinfo_ocv2cap(&sw->info, ocv, temp / 10);
+	if (ret > 0) {
+		*dsoc =3D ret * 10;
+		ret =3D 0;
+	}
+
+	if (ret) {
+		if (!sw->ops.get_soc_by_ocv)
+			return ret;
+		/* For driver callbacks we use tenths of degree */
+		ret =3D sw->ops.get_soc_by_ocv(sw, ocv, temp, dsoc);
+	}
+	return ret;
+}
+
+static int simple_gauge_get_temp(struct simple_gauge *sw, int *temp)
+{
+	if (sw->ops.get_temp)
+		return sw->ops.get_temp(sw, temp);
+
+	return -EINVAL;
+}
+
+static int age_correct_cap(struct simple_gauge *sw, int *uah)
+{
+	int ret =3D 0;
+
+	/* If IC provides more complex degradation computation - use it */
+	if (sw->ops.age_correct_cap) {
+		int tmp =3D *uah;
+
+		ret =3D sw->ops.age_correct_cap(sw, sw->cycle, &tmp);
+		if (!ret) {
+			*uah =3D tmp;
+			return 0;
+		}
+	}
+	/* Calculate constant uAh/cycle degradation */
+	if (sw->desc.degrade_cycle_uah) {
+		int lost_cap;
+
+		lost_cap =3D sw->desc.degrade_cycle_uah * sw->cycle;
+		if (lost_cap > sw->designed_cap)
+			*uah =3D 0;
+		else
+			*uah -=3D sw->desc.degrade_cycle_uah * sw->cycle;
+
+		return 0;
+	}
+
+	return ret;
+}
+
+static int adjust_cc_relax(struct simple_gauge *sw, int rex_volt)
+{
+	int ret, temp, dsoc;
+	int full_uah =3D sw->designed_cap;
+	int uah_now;
+
+	/* get temp */
+	ret =3D simple_gauge_get_temp(sw, &temp);
+	if (ret)
+		return ret;
+
+	/* get ocv */
+	ret =3D get_dsoc_from_ocv(sw, &dsoc, temp, rex_volt);
+	if (ret)
+		return ret;
+
+	/*
+	 * Typically ROHM implemented drivers have kept the value CC in PMIC
+	 * corresponding to IDEAL battery capacity and then substracted the
+	 * lost capacity when converting CC value to uAh. I guess this prevents
+	 * CC from hitting the floor.
+	 */
+	uah_now =3D full_uah * dsoc / 1000 + sw->soc_rounding;
+	if (uah_now > sw->designed_cap)
+		uah_now =3D sw->designed_cap;
+
+	return sw->ops.update_cc_uah(sw, full_uah);
+}
+
+static int get_state(struct simple_gauge *sw, int *state, int *rex_volt)
+{
+	int ret;
+	enum power_supply_property psp =3D POWER_SUPPLY_PROP_STATUS;
+	union power_supply_propval pstate;
+
+	*state =3D 0;
+
+	ret =3D power_supply_get_property(sw->psy, psp, &pstate);
+	if (ret)
+		return ret;
+
+	if (pstate.intval =3D=3D POWER_SUPPLY_STATUS_FULL)
+		*state |=3D SW_GAUGE_FULL;
+	if (pstate.intval =3D=3D POWER_SUPPLY_STATUS_DISCHARGING ||
+	    pstate.intval =3D=3D POWER_SUPPLY_STATUS_NOT_CHARGING) {
+		*state |=3D SW_GAUGE_MAY_BE_LOW;
+		if (sw->desc.clamp_soc)
+			*state |=3D SW_GAUGE_CLAMP_SOC;
+	}
+
+	if (sw->ops.is_relaxed)
+		if (sw->ops.is_relaxed(sw, rex_volt))
+			*state |=3D SW_GAUGE_RELAX;
+	return ret;
+}
+
+static int adjust_cc_full(struct simple_gauge *sw)
+{
+	int ret =3D 0, from_full_uah =3D 0;
+	int full_uah =3D sw->designed_cap;
+
+	/*
+	 * Some ICs are able to provide the uAh lost since the battery was
+	 * fully charged. Decrease this from the designed capacity and set
+	 * the CC value accordingly.
+	 */
+	if (sw->ops.get_uah_from_full)
+		ret =3D sw->ops.get_uah_from_full(sw, &from_full_uah);
+
+	if (ret)
+		dev_warn(sw->dev,
+			 "Failed to get capacity lost after fully charged\n");
+
+	full_uah -=3D from_full_uah;
+
+	/*
+	 * ROHM algorithm adjusts CC here based on designed capacity and not
+	 * based on age/temperature corrected capacity. This helps avoiding
+	 * CC dropping below zero when we estimate aging/temperature impact
+	 * badly. It also allows to keep the estimated SOC in the sw-gauge
+	 * so that all IC drivers do not need to care about it - at least
+	 * in theory. But most importantly - this approach is tested on the
+	 * field :)
+	 */
+	return sw->ops.update_cc_uah(sw, full_uah);
+}
+
+/*
+ * Some charger ICs keep count of battery charge systems but can only store
+ * one or few cycles. They may need to clear the cycle counter and update
+ * counter in SW. This function fetches the counter from HW and allows HW =
to
+ * clear IC counter if needed.
+ */
+static int update_cycle(struct simple_gauge *sw)
+{
+	int cycle, ret =3D -EINVAL;
+
+	if (sw->ops.get_cycle) {
+		/*
+		 * We provide old cycle value to driver so driver does not
+		 * need to cache it
+		 */
+		cycle =3D sw->cycle;
+		ret =3D sw->ops.get_cycle(sw, &cycle);
+		if (ret)
+			return ret;
+		sw->cycle =3D cycle;
+	} else
+		sw->cycle++;
+
+	return 0;
+}
+
+static int simple_gauge_cap2ocv(struct simple_gauge *sw, int dsoc, int tem=
p, int *ocv)
+{
+	int ret;
+
+	if (sw->ops.get_ocv_by_soc)
+		return sw->ops.get_ocv_by_soc(sw, dsoc, temp, ocv);
+
+	ret =3D power_supply_batinfo_dcap2ocv(&sw->info, dsoc, temp / 10);
+	if (ret > 0) {
+		*ocv =3D ret;
+		ret =3D 0;
+	}
+
+	return ret;
+}
+
+static int load_based_soc_zero_adjust(struct simple_gauge *sw, int *effect=
ive_cap,
+				       int cc_uah, int vsys, int temp)
+{
+	int dsoc, ocv_by_cap;
+	int ret, i;
+	int vdrop;
+	struct power_supply_battery_ocv_table *table;
+	int table_len;
+	int soc_adjust =3D 0;
+
+	/*
+	 * Get OCV for current estimated SOC - we use unit of 0.1% for SOC
+	 * (dsoc) to improve accuracy. Note - batinfo expects 1% - should we
+	 * introduce new DT entry of more accurate OCV table for improved SOC
+	 * =3D> OCV where SOC was given using unit of 0.1% for improved internal
+	 * calculation? User space should still only see 1% - but for "zero
+	 * adjust" where we do SOC =3D> OCV =3D> drop-voltage =3D> SOC correction
+	 * =3D> CC/capacity adjustment we would like to have more accurate SOC
+	 * in these intermediate steps.
+	 */
+	dsoc =3D SOC_BY_CAP(cc_uah * 10, 0, *effective_cap);
+	ret =3D simple_gauge_cap2ocv(sw, dsoc, temp, &ocv_by_cap);
+	if (ret) {
+		dev_err(sw->dev, "Failed to convert cap to OCV\n");
+		return ret;
+	}
+	/* Get the difference of OCV (no load) and VBAT (current load) */
+	vdrop =3D ocv_by_cap - vsys;
+	dev_dbg(sw->dev, "Obtained OCV: %d, vsys %d, Computed Vdrop %d\n",
+		ocv_by_cap, vsys, vdrop);
+	if (vdrop <=3D 0)
+		return 0;
+
+	/*
+	 * We know that the SOC should be 0 at the moment when voltage with
+	 * this load drops below system limit. So let's scan the OCV table
+	 * and just assume the vdrop stays constant for the rest of the game.
+	 * This way we can see what is the new 'zero adjusted capacity' for
+	 * our battery.
+	 *
+	 * We don't support non DT originated OCV table here.
+	 *
+	 * I guess we could allow user to provide standard OCV tables in desc.
+	 * Or the full batinfo for that matter. But for now we just force the
+	 * drivers W/O OCV tables in DT to just provide whole low-voltage
+	 * call-back.
+	 */
+	table =3D power_supply_find_ocv2cap_table(&sw->info, temp / 10,
+						&table_len);
+	if (!table) {
+		dev_warn(sw->dev, "No OCV table found\n");
+		return -EINVAL;
+	}
+
+	for (i =3D 0; i < table_len; i++)
+		if (table[i].ocv - vdrop <=3D sw->desc.system_min_voltage)
+			break;
+
+	if (!i)
+		soc_adjust =3D table[0].capacity;
+	else if (i && i < table_len) {
+		int j;
+		int soc_range =3D table[i-1].capacity - table[i].capacity;
+		int volt_range =3D table[i-1].ocv - table[i].ocv;
+		int v_div =3D volt_range/soc_range;
+
+		for (j =3D 0; j < soc_range; j++)
+			if (table[i].ocv + v_div * j - vdrop >=3D
+			   sw->desc.system_min_voltage)
+				break;
+		soc_adjust =3D table[i].capacity + j;
+	}
+	if (soc_adjust) {
+		int new_full_cap;
+
+		/*
+		 * So we know that actually we will have SOC =3D 0 when capacity
+		 * is soc_adjust. Lets compute new battery max capacity based
+		 * on this.
+		 */
+		new_full_cap =3D *effective_cap * (100 - soc_adjust) / 100;
+
+		*effective_cap =3D new_full_cap;
+	}
+
+	return 0;
+}
+
+static int simple_gauge_zero_cap_adjust(struct simple_gauge *sw, int *effe=
ctive_cap,
+				       int *cc_uah, int vsys, int temp)
+{
+	int ret, old_eff_cap =3D *effective_cap;
+
+	if (sw->ops.zero_cap_adjust)
+		ret =3D sw->ops.zero_cap_adjust(sw, effective_cap, *cc_uah, vsys,
+					      temp);
+	else
+		ret =3D load_based_soc_zero_adjust(sw, effective_cap, *cc_uah,
+						 vsys, temp);
+	/*
+	 * As we keep HW CC aligned to designed-cap - we need to
+	 * also cancel this new offset from CC measured uAh
+	 */
+	if (!ret)
+		*cc_uah -=3D old_eff_cap - *effective_cap;
+
+	return ret;
+}
+
+static int find_dcap_change(struct simple_gauge *sw, int temp, int *delta_=
cap)
+{
+	struct power_supply_temp_degr *dclosest =3D NULL, *d;
+	int i;
+
+	for (i =3D 0; i < sw->amount_of_temp_dgr; i++) {
+		d =3D &sw->temp_dgr[i];
+		if (!dclosest) {
+			dclosest =3D d;
+			continue;
+		}
+		if (abs(d->temp_set_point - temp) <
+		    abs(dclosest->temp_set_point - temp))
+			dclosest =3D d;
+	}
+
+	if (!dclosest)
+		return -EINVAL;
+
+	/*
+	 * Temperaure range is in tenths of degrees and degrade value is for a
+	 * degree =3D> divide by 10 after multiplication to fix the scale
+	 */
+	*delta_cap =3D (dclosest->temp_set_point - temp) *
+		     dclosest->temp_degrade_1C / 10 +
+		     dclosest->degrade_at_set;
+
+	return 0;
+}
+
+static int compute_temp_correct_uah(struct simple_gauge *sw, int *cap_uah,=
 int temp)
+{
+	int ret, uah_corr;
+
+	ret =3D find_dcap_change(sw, temp, &uah_corr);
+	if (ret)
+		return ret;
+
+	if (*cap_uah < -uah_corr)
+		*cap_uah =3D 0;
+	else
+		*cap_uah +=3D uah_corr;
+
+	return 0;
+}
+
+static int compute_soc_by_cc(struct simple_gauge *sw, int state)
+{
+	int cc_uah, ret;
+	int current_cap_uah;
+	int temp;
+	int new_soc;
+	bool do_zero_correct, changed =3D false;
+
+	ret =3D sw->ops.get_uah(sw, &cc_uah);
+	/* The CC value should never exceed designed_cap as CC value. */
+	if (cc_uah > sw->designed_cap) {
+		cc_uah =3D sw->designed_cap;
+		sw->ops.update_cc_uah(sw, sw->designed_cap);
+	}
+
+	current_cap_uah =3D sw->designed_cap;
+
+	dev_dbg(sw->dev, "iteration started - CC %u, cap %u (SOC %u)\n",
+		cc_uah, current_cap_uah,
+		SOC_BY_CAP(cc_uah, sw->soc_rounding, current_cap_uah));
+
+	ret =3D age_correct_cap(sw, &current_cap_uah);
+	if (ret) {
+		dev_err(sw->dev, "Age correction of battery failed\n");
+		return ret;
+	}
+
+	if (current_cap_uah =3D=3D 0) {
+		dev_warn(sw->dev, "Battery EOL\n");
+		spin_lock(&sw->lock);
+		sw->capacity_uah =3D 0;
+		sw->soc =3D 0;
+		changed =3D true;
+		goto battery_eol_out;
+	}
+
+	/* Do battery temperature compensation */
+	ret =3D simple_gauge_get_temp(sw, &temp);
+	if (ret) {
+		dev_err(sw->dev, "Failed to get temperature\n");
+		return ret;
+	}
+
+	if (sw->ops.temp_correct_cap)
+		ret =3D sw->ops.temp_correct_cap(sw, &current_cap_uah, temp);
+	else if (sw->amount_of_temp_dgr)
+		ret =3D compute_temp_correct_uah(sw, &current_cap_uah, temp);
+
+	if (ret)
+		dev_warn(sw->dev,
+			 "Couldn't do temperature correction to battery cap\n");
+
+	/*
+	 * We keep HW CC counter aligned to ideal battery CAP - EG, when
+	 * battery is full, CC is set according to ideal battery capacity.
+	 * Same when we set it based on OCV. Thus - when we compute SOC we will
+	 * cancel this offset by decreasing the CC uah with the lost capacity
+	 */
+	cc_uah -=3D (sw->designed_cap - current_cap_uah);
+
+	/* Only need zero correction when discharging */
+	do_zero_correct =3D !!(state & SW_GAUGE_MAY_BE_LOW);
+
+	/*
+	 * Allow all ICs to have own adjustment functions for low Vsys to allow
+	 * them tackle potential issues in capacity estimation at near
+	 * depleted battery
+	 */
+	if (sw->desc.cap_adjust_volt_threshold && sw->ops.get_vsys &&
+	    do_zero_correct) {
+		int vsys;
+
+		ret =3D sw->ops.get_vsys(sw, &vsys);
+		if (ret) {
+			dev_err(sw->dev, "Failed to get vsys\n");
+			return ret;
+		}
+
+		if (sw->desc.cap_adjust_volt_threshold >=3D vsys)
+			ret =3D simple_gauge_zero_cap_adjust(sw, &current_cap_uah,
+							 &cc_uah, vsys, temp);
+		if (ret)
+			dev_warn(sw->dev, "Low voltage adjustment failed\n");
+	}
+
+	dev_dbg(sw->dev, "Corrected cap %u, designed-cap %u (SOC %u)\n",
+		current_cap_uah, sw->designed_cap,
+		SOC_BY_CAP(cc_uah, sw->soc_rounding, current_cap_uah));
+
+	if (cc_uah > sw->designed_cap)
+		cc_uah =3D sw->designed_cap;
+
+	/*
+	 * With badly behaving CC or wrong VDR values we may make the CC to go
+	 * negative. Floor it to zero to avoid exhausting the battery W/O warning.
+	 */
+	if (cc_uah < 0) {
+		dev_warn(sw->dev,
+			 "Bad battery capacity estimate\n");
+		cc_uah =3D 0;
+	}
+	/* Store computed values */
+	spin_lock(&sw->lock);
+	sw->cc_uah =3D cc_uah;
+	sw->temp =3D temp;
+	sw->capacity_uah =3D current_cap_uah;
+	new_soc =3D SOC_BY_CAP(cc_uah, sw->soc_rounding, current_cap_uah);
+
+	/*
+	 * Should we only ping user-space when SOC changes more than N%?
+	 * Should the N be configurable (by user-space?)
+	 */
+	if (sw->soc !=3D new_soc)
+		changed =3D true;
+
+	sw->soc =3D new_soc;
+	if (sw->clamped_soc >=3D 0 && state & SW_GAUGE_CLAMP_SOC) {
+		if (sw->clamped_soc < sw->soc)
+			sw->soc =3D sw->clamped_soc;
+	}
+	sw->clamped_soc =3D sw->soc;
+
+battery_eol_out:
+	spin_unlock(&sw->lock);
+	if (changed)
+		power_supply_changed(sw->psy);
+
+	return ret;
+}
+
+static void calibrate(struct simple_gauge *sw)
+{
+	if (sw->ops.calibrate)
+		sw->ops.calibrate(sw);
+}
+
+static void iterate(struct simple_gauge *sw)
+{
+	int state, ret, rex_volt;
+
+	/* Adjust battery aging information */
+	ret =3D update_cycle(sw);
+	if (ret) {
+		dev_err(sw->dev, "Failed to update battery cycle\n");
+		return;
+	}
+
+	ret =3D get_state(sw, &state, &rex_volt);
+	if (ret) {
+		dev_err(sw->dev, "Failed to get state\n");
+		return;
+	}
+
+	/* Setting CC not possible? Omit CC adjustment */
+	if (sw->ops.update_cc_uah) {
+		if (state & SW_GAUGE_FULL) {
+			ret =3D adjust_cc_full(sw);
+			if (ret)
+				dev_err(sw->dev, "Failed to do FULL adjust\n");
+		}
+		if (state & SW_GAUGE_RELAX) {
+			ret =3D adjust_cc_relax(sw, rex_volt);
+			if (ret)
+				dev_err(sw->dev, "Failed to do RELAX adjust\n");
+		}
+	}
+
+	ret =3D compute_soc_by_cc(sw, state);
+	if (ret)
+		dev_err(sw->dev, "Failed to compute SOC for gauge\n");
+}
+
+static bool should_calibrate(struct simple_gauge *sw, u64 time)
+{
+	if (sw->desc.calibrate_interval &&
+	    sw->next_cal <=3D time + msecs_to_jiffies(SWGAUGE_TIMEOUT_JITTER)) {
+		sw->next_cal =3D time +
+			       msecs_to_jiffies(sw->desc.calibrate_interval);
+		return true;
+	}
+
+	return false;
+
+}
+
+static bool should_compute(struct simple_gauge *sw, u64 time)
+{
+	if (sw->next_iter <=3D time + msecs_to_jiffies(SWGAUGE_TIMEOUT_JITTER) ||
+	    sw->force_run) {
+		sw->force_run =3D 0;
+		sw->next_iter =3D time +
+				msecs_to_jiffies(sw->desc.poll_interval);
+		return true;
+	}
+
+	return false;
+}
+
+static void adjust_next_tmo(struct simple_gauge *sw, u64 *timeout, u64 now)
+{
+	u64 t =3D (sw->desc.calibrate_interval && sw->next_cal < sw->next_iter) ?
+			sw->next_cal : sw->next_iter;
+
+	if (!*timeout || t - now < *timeout)
+		*timeout =3D t - now;
+
+	if (*timeout < msecs_to_jiffies(SWGAUGE_TIMEOUT_JITTER))
+		*timeout =3D msecs_to_jiffies(SWGAUGE_TIMEOUT_JITTER);
+}
+
+static DECLARE_WAIT_QUEUE_HEAD(simple_gauge_thread_wait);
+static DECLARE_WAIT_QUEUE_HEAD(simple_gauge_forced_wait);
+
+static int simple_gauge_forced_run;
+
+/**
+ * simple_gauge_run - force running the computation loop for gauge
+ *
+ * Drivers utilizing simple_gauge can trigger running the SOC computation =
loop even
+ * prior the time-out occurs. This is usable for drivers with longish peri=
od
+ * but which may get interrupts form device when some condition changes. N=
ote,
+ * this function schedules the iteration but does not block.
+ *
+ * @sw: gauge fow which the computation should be ran.
+ */
+void simple_gauge_run(struct simple_gauge *sw)
+{
+	sw->force_run =3D 1;
+	simple_gauge_forced_run =3D 1;
+	barrier();
+	wake_up(&simple_gauge_thread_wait);
+}
+EXPORT_SYMBOL_GPL(simple_gauge_run);
+
+static unsigned int g_iteration;
+
+static unsigned int simple_gauge_run_locked(struct simple_gauge *sg)
+{
+	unsigned int ctr;
+
+	/* Wait for any ongoing iteration */
+	mutex_lock(&simple_gauge_lock);
+	ctr =3D g_iteration;
+	simple_gauge_run(sg);
+	mutex_unlock(&simple_gauge_lock);
+
+	return ctr;
+}
+
+/**
+ * simple_gauge_run_blocking_timeout - Run gauge loop and block until ran
+ *
+ * Trigger simple-gauge to run. Wait until simple-gauge has been ran or ti=
meout
+ * occurs.
+ *
+ * @sg:		Pointer to gauge
+ * @timeout_ms:	Timeout in milliseconds.
+ *
+ * Returns: 0 if gauge loop was ran. -EAGAIN if timeout occurred and
+ *	    -ERESTARTSYS if call was interrupted.
+ */
+int simple_gauge_run_blocking_timeout(struct simple_gauge *sg,
+				      unsigned int timeout_ms)
+{
+	unsigned int ctr;
+	int ret;
+
+	ctr =3D simple_gauge_run_locked(sg);
+	ret =3D wait_event_interruptible_timeout(simple_gauge_forced_wait,
+					       g_iteration > ctr,
+					       timeout_ms);
+	if (ret =3D=3D 1)
+		ret =3D 0;
+	else if (!ret)
+		ret =3D -EAGAIN;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(simple_gauge_run_blocking_timeout);
+
+/**
+ * simple_gauge_run_blocking - Run gauge loop and block until ran
+ *
+ * Trigger simple-gauge to run. Wait until simple-gauge has been ran.
+ *
+ * @sg:		Pointer to gauge
+ *
+ * Returns: 0 on success. -ERESTARTSYS if call was interrupted.
+ */
+int simple_gauge_run_blocking(struct simple_gauge *sg)
+{
+	unsigned int ctr;
+	int ret;
+
+	ctr =3D simple_gauge_run_locked(sg);
+	ret =3D wait_event_interruptible(simple_gauge_forced_wait,
+				       g_iteration > ctr);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(simple_gauge_run_blocking);
+
+static int gauge_thread(void *data)
+{
+
+	for (;;) {
+		u64 timeout =3D 0;
+		struct simple_gauge *sw;
+		u64 now =3D get_jiffies_64();
+
+		if (kthread_should_stop()) {
+			g_running =3D 0;
+			pr_info("gauge thread stopping...\n");
+			/*
+			 * Ensure the g_running is visible to all. OTOH - if
+			 * thread stopping is not supported we can drop this
+			 * clearing.
+			 */
+			smp_wmb();
+			break;
+		}
+
+		simple_gauge_forced_run =3D 0;
+
+		mutex_lock(&simple_gauge_lock);
+		list_for_each_entry(sw, &simple_gauges, node) {
+			gauge_get(sw);
+			if (should_compute(sw, now))
+				iterate(sw);
+			if (should_calibrate(sw, now))
+				calibrate(sw);
+			adjust_next_tmo(sw, &timeout, now);
+			gauge_put(sw);
+		}
+		/*
+		 * Increase iteration counter and wake up the waiters who have
+		 * requested the blocking forced run. NOTE: We must increase
+		 * iteration here inside the locking to avoid race.
+		 */
+		g_iteration++;
+		mutex_unlock(&simple_gauge_lock);
+		wake_up(&simple_gauge_forced_wait);
+
+		/*
+		 * If the last gauge exited we fall to sleep in order to not
+		 * go lopoping with zero timeout. New client registration will
+		 * wake us up.
+		 */
+		if (!timeout && list_empty(&simple_gauges)) {
+			pr_debug("No clients: going to sleep\n");
+			wait_event_interruptible(simple_gauge_thread_wait,
+						 simple_gauge_forced_run);
+		} else {
+			pr_debug("sleeping %u msec\n",
+				 jiffies_to_msecs(timeout));
+			wait_event_interruptible_timeout(simple_gauge_thread_wait,
+						 simple_gauge_forced_run, timeout);
+		}
+	}
+
+	return 0;
+}
+
+static int start_gauge_thread(struct task_struct *k)
+{
+	int ret =3D 0;
+
+	/* Ensure the running state is updated. Is this needed? How likely it is
+	 * this would not be updated? Only reason why we have this first check
+	 * is to avoid unnecessarily getting the lock when the thread is started
+	 * - and it should always be except for the first caller. But does this
+	 * memory barrier actually make this almost as heavy as getting the lock
+	 * every time? Maybe we should just drop the barrier and let us hit the
+	 * lock if g_running is in cache or some such (lots of hand waving to
+	 * make it look like I knew what I was talking about :]).
+	 */
+	smp_rmb();
+	if (g_running)
+		return 0;
+
+	/*
+	 * Would this be cleaner if we used schedule_delayed_work? rather than
+	 * kthread? What I like is only one thread for sw-gauge, with
+	 * not-so-high priority. What is the simplest way to achieve it?
+	 */
+	mutex_lock(&simple_gauge_start_lock);
+	if (!g_running) {
+		k =3D kthread_run(gauge_thread, NULL, "sw-gauge");
+		if (IS_ERR(k))
+			ret =3D PTR_ERR(k);
+		else
+			g_running =3D 1;
+	}
+	mutex_unlock(&simple_gauge_start_lock);
+
+	return ret;
+}
+
+/*
+ * I think this is unnecessary. If someone registers SW gauge to the system
+ * then we can probably leave this running even if the gauge was temporari=
ly
+ * removed. So let's consider removing this and thus simplifying the desig=
n.
+ *
+ * Perhaps even always launch the thread if SW-gauge is configured in?
+ */
+void stop_gauge_thread(struct task_struct *k);
+void stop_gauge_thread(struct task_struct *k)
+{
+	kthread_stop(k);
+}
+
+static bool is_needed_ops_given(struct simple_gauge_ops *ops)
+{
+	return (ops->get_uah && ops->get_temp && ops->update_cc_uah);
+}
+
+static int simple_gauge_set_ops(struct simple_gauge *sw, struct simple_gau=
ge_ops *ops)
+{
+	if (!is_needed_ops_given(ops))
+		return -EINVAL;
+
+	sw->ops =3D *ops;
+
+	return 0;
+}
+
+static int simple_gauge_is_writable(struct power_supply *psy,
+				       enum power_supply_property psp)
+{
+	struct simple_gauge *sg =3D power_supply_get_drvdata(psy);
+
+	if (!sg) {
+		WARN_ON(!sg);
+		return -EINVAL;
+	}
+
+	if (psp =3D=3D POWER_SUPPLY_PROP_CYCLE_COUNT)
+		return sg->desc.allow_set_cycle;
+
+	if (sg->custom_is_writable)
+		return sg->custom_is_writable(sg, psp);
+
+	return 0;
+}
+
+static int sgauge_config_check(struct device *dev, struct simple_gauge_psy=
 *pcfg)
+{
+	const char *errstr =3D NULL;
+
+	if (!pcfg) {
+		errstr =3D "Missing config";
+	} else {
+		if (!pcfg->psy_name)
+			errstr =3D "No power supply name";
+		if (pcfg->num_additional_props) {
+			if (!pcfg->get_custom_property)
+				errstr =3D "property reader required";
+		}
+		if (!pcfg->is_writable) {
+			if (pcfg->set_custom_property)
+				errstr =3D
+				   "set_custom_property() but no is_writable()";
+		}
+	}
+	if (!errstr)
+		return 0;
+
+	dev_err(dev, "%s\n", errstr);
+	return -EINVAL;
+}
+static int simple_gauge_set_props(struct simple_gauge *new,
+				  struct power_supply_desc *pd,
+				  struct simple_gauge_psy *pcfg)
+{
+	int i, j;
+
+	new->properties =3D kzalloc(sizeof(*pcfg->additional_props) *
+				  pcfg->num_additional_props + SIMPLE_GAUGE_PROP_SIZE,
+				  GFP_KERNEL);
+	if (!new->properties)
+		return -ENOMEM;
+
+	for (i =3D 0; i < NUM_SIMPLE_GAUGE_PROPS; i++)
+		new->properties[i] =3D SIMPLE_GAUGE_PROPS[i];
+
+	for (j =3D 0; j < pcfg->num_additional_props; j++, i++)
+		new->properties[i] =3D pcfg->additional_props[j];
+
+	pd->properties =3D new->properties;
+	pd->num_properties =3D i;
+	new->get_custom_property =3D pcfg->get_custom_property;
+	new->set_custom_property =3D pcfg->set_custom_property;
+
+	return 0;
+}
+
+void *simple_gauge_get_drvdata(struct simple_gauge *sg)
+{
+	return sg->desc.drv_data;
+}
+EXPORT_SYMBOL_GPL(simple_gauge_get_drvdata);
+
+/**
+ * psy_register_simple_gauge - register driver to simple_gauge
+ *
+ * @parent:	Parent device for power-supply class device.
+ * @psycfg:	Confiurations for power-supply class.
+ * @ops:	simple_gauge specific operations.
+ * @desc:	simple_gauge configuration data.
+ *
+ * Return:	pointer to simple_gauge on success, an ERR_PTR on failure.
+ *
+ * A power-supply driver for a device with drifting coulomb counter (CC) c=
an
+ * register for periodical polling/CC correction. CC correction is done wh=
en
+ * battery is reported to be FULL or relaxed. For FULL battery the CC is s=
et
+ * based on designed capacity and for relaxed battery CC is set based on o=
pen
+ * circuit voltage. The simple_gauge takes care of registering a power-sup=
ply class
+ * and reporting a few power-supply properties to user-space. See
+ * SWGAUGE_PSY_PROPS. Swauge can also do battery capacity corretions based=
 on
+ * provided temperature/cycle degradation values and/or system voltage lim=
it.
+ */
+struct simple_gauge *__must_check psy_register_simple_gauge(struct device =
*parent,
+						    struct simple_gauge_psy *pcfg,
+						    struct simple_gauge_ops *ops,
+						    struct simple_gauge_desc *desc)
+{
+	struct power_supply_desc *pd;
+	struct power_supply_config pg =3D { 0 };
+	int ret;
+	struct simple_gauge *new;
+
+	if (!parent) {
+		pr_err("no parent\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (!desc->poll_interval) {
+		dev_err(parent, "interval missing\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (sgauge_config_check(parent, pcfg))
+		return ERR_PTR(-EINVAL);
+
+	pd =3D kzalloc(sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		return ERR_PTR(-ENOMEM);
+
+	new =3D kzalloc(sizeof(*new), GFP_KERNEL);
+	if (!new) {
+		ret =3D -ENOMEM;
+		goto free_out;
+	}
+	pd->name =3D pcfg->psy_name;
+	pd->type =3D POWER_SUPPLY_TYPE_BATTERY;
+
+	pg.drv_data =3D new;
+	pg.of_node =3D pcfg->of_node;
+	pg.attr_grp =3D pcfg->attr_grp;
+
+	ret =3D simple_gauge_set_props(new, pd, pcfg);
+	if (ret) {
+		ret =3D -ENOMEM;
+		goto free_out;
+	}
+	new->dev =3D parent;
+	new->custom_is_writable =3D pcfg->is_writable;
+	/* We don't want to clamp SOC before it is initialized */
+	new->clamped_soc =3D -1;
+
+	init_waitqueue_head(&new->wq);
+
+	ret =3D simple_gauge_set_ops(new, ops);
+	if (ret) {
+		dev_err(new->dev, "bad ops\n");
+		goto free_out;
+	}
+	new->desc =3D *desc;
+
+	spin_lock_init(&new->lock);
+	pd->get_property =3D simple_gauge_get_property;
+	pd->set_property =3D simple_gauge_set_property;
+	if (pcfg->is_writable || desc->allow_set_cycle)
+		pd->property_is_writeable =3D simple_gauge_is_writable;
+
+	/* Do we need power_supply_register_ws? */
+	/*
+	 * We should not return SOC to user-space before the first
+	 * estimation iteration is ran. How should we sync this? Should we
+	 * actually start the gauge thread and try getting SOC prior
+	 * registering to psy class? That would require us to do the
+	 * battery-info reading here. Or should we have some way of delaying
+	 * sysfs creation from psy-class until first iteration is done? Kind
+	 * of two-step power-supply class registration? Again, I am open to
+	 * all suggestions!
+	 *
+	 * I don't know how this should be integrated to psy class. Should
+	 * this sit between psy-class and driver? Should this be part of
+	 * psy-class or ?? If this was meld in psy-class registration and
+	 * the psy class registration was just given a new parameter for fuel
+	 * gauge desc - then the synchronization between 1st iteration and
+	 * sysfs creation might get more natural.
+	 */
+	new->psy =3D power_supply_register(parent, pd, &pg);
+	if (IS_ERR(new->psy)) {
+		dev_err(new->dev, "power supply registration failed\n");
+		ret =3D PTR_ERR(new->psy);
+		goto free_out;
+	}
+
+	ret =3D power_supply_get_battery_info(new->psy, &new->info);
+	if (ret && !new->ops.get_soc_by_ocv) {
+		dev_err(new->dev, "No OCV =3D> SoC conversion\n");
+		goto info_out;
+	}
+	if (!ret)
+		new->batinfo_got =3D true;
+
+	if (new->info.temp_dgrd_values) {
+		new->amount_of_temp_dgr =3D new->info.temp_dgrd_values;
+		new->temp_dgr =3D new->info.temp_dgrd;
+	} else {
+		new->amount_of_temp_dgr =3D new->desc.amount_of_temp_dgr;
+		new->temp_dgr =3D new->desc.temp_dgr;
+	}
+
+	if (desc->designed_cap) {
+		new->designed_cap =3D desc->designed_cap;
+	} else if (ret || !new->info.charge_full_design_uah) {
+		dev_err(new->dev, "Unknown battery capacity\n");
+		goto info_out;
+	} else {
+		new->designed_cap =3D new->info.charge_full_design_uah;
+	}
+	/* We add 0.5 % to soc uah in order to avoid flooring */
+	new->soc_rounding =3D new->designed_cap / 200;
+	mutex_lock(&simple_gauge_lock);
+	list_add(&new->node, &simple_gauges);
+	mutex_unlock(&simple_gauge_lock);
+	ret =3D start_gauge_thread(&k);
+	if (ret) {
+		/*
+		 * This error is not related to underlying device but to the
+		 * simple_gauge itself. Thus don't print error using the parent
+		 * device
+		 */
+		pr_err("Failed to start fuel-gauge thread\n");
+		goto info_out;
+	}
+	dev_dbg(new->dev, "YaY! SW-gauge registered\n");
+
+	simple_gauge_run_blocking(new);
+
+	return new;
+
+info_out:
+	if (new->batinfo_got)
+		power_supply_put_battery_info(new->psy, &new->info);
+
+	power_supply_unregister(new->psy);
+free_out:
+	if (new) {
+		kfree(new->properties);
+		kfree(new);
+	}
+	kfree(pd);
+
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(psy_register_simple_gauge);
+
+/**
+ * psy_remove_simple_gauge - deregister driver from simple_gauge
+ *
+ * @sw:	gauge driver to be deregistered.
+ */
+void psy_remove_simple_gauge(struct simple_gauge *sw)
+{
+	const struct power_supply_desc *desc;
+
+	mutex_lock(&simple_gauge_lock);
+	list_del(&sw->node);
+	mutex_unlock(&simple_gauge_lock);
+
+	wait_event(sw->wq, !gauge_reserved(sw));
+
+	if (sw->batinfo_got)
+		power_supply_put_battery_info(sw->psy, &sw->info);
+
+	desc =3D sw->psy->desc;
+	power_supply_unregister(sw->psy);
+
+	kfree(desc);
+	kfree(sw->properties);
+	kfree(sw);
+}
+EXPORT_SYMBOL_GPL(psy_remove_simple_gauge);
+
+static void devm_simple_gauge_release(void *res)
+{
+	psy_remove_simple_gauge(res);
+}
+
+/**
+ * devm_psy_register_simple_gauge - managed register driver to simple_gauge
+ *
+ * @parent:	Parent device for power-supply class device. Swgauge's lifetime
+ *		is also bound to this device.
+ * @psycfg:	Confiurations for power-supply class.
+ * @ops:	simple_gauge specific operations.
+ * @desc:	simple_gauge configuration data.
+ *
+ * Return:	pointer to simple_gauge on success, an ERR_PTR on failure.
+ *
+ * A power-supply driver for a device with drifting coulomb counter (CC) c=
an
+ * register for periodical polling/CC correction. CC correction is done wh=
en
+ * battery is reported to be FULL or relaxed. For FULL battery the CC is s=
et
+ * based on designed capacity and for relaxed battery CC is set based on o=
pen
+ * circuit voltage. The simple_gauge takes care of registering a power-sup=
ply class
+ * and reporting a few power-supply properties to user-space. See
+ * SWGAUGE_PSY_PROPS. Swauge can also do battery capacity corretions based=
 on
+ * provided temperature/cycle degradation values and/or system voltage lim=
it.
+ */
+struct simple_gauge *__must_check
+devm_psy_register_simple_gauge(struct device *parent, struct simple_gauge_=
psy *psycfg,
+			   struct simple_gauge_ops *ops, struct simple_gauge_desc *desc)
+{
+	struct simple_gauge *sw;
+	int ret;
+
+	sw =3D psy_register_simple_gauge(parent, psycfg, ops, desc);
+	if (IS_ERR(sw))
+		return sw;
+
+	ret =3D devm_add_action_or_reset(parent, devm_simple_gauge_release, sw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return sw;
+}
+EXPORT_SYMBOL_GPL(devm_psy_register_simple_gauge);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("generic fuel-gauge on coulomb counter");
+MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
diff --git a/include/linux/power/simple_gauge.h b/include/linux/power/simpl=
e_gauge.h
new file mode 100644
index 000000000000..cd085375ddec
--- /dev/null
+++ b/include/linux/power/simple_gauge.h
@@ -0,0 +1,244 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2020 ROHM Semiconductors */
+
+#ifndef POWER_SW_GAUGE_H
+#define POWER_SW_GAUGE_H
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/power_supply.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#define SW_GAUGE_FULL BIT(0)
+#define SW_GAUGE_RELAX BIT(1)
+#define SW_GAUGE_MAY_BE_LOW BIT(2)
+#define SW_GAUGE_CLAMP_SOC BIT(3)
+
+/* Power supply properties handled by simple_gauge */
+static const enum power_supply_property SIMPLE_GAUGE_PROPS[] =3D {
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_CYCLE_COUNT,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
+	POWER_SUPPLY_PROP_TEMP
+};
+#define SIMPLE_GAUGE_PROP_SIZE (sizeof(SIMPLE_GAUGE_PROPS))
+#define NUM_SIMPLE_GAUGE_PROPS (ARRAY_SIZE(SIMPLE_GAUGE_PROPS))
+
+struct simple_gauge;
+
+/**
+ * struct simple_gauge_ops - fuel-gauge operations
+ *
+ * @is_relaxed:		return true if battery is at relaxed state. Update
+ *			rex_volt to contain measured relaxed battery voltage.
+ * @get_temp:		return the battery temperature in tenths of a degree C.
+ * @get_uah_from_full:	some chargers can provide CC value change since bat=
tery
+ *			was last charged full. This value can be used by
+ *			sw-gauge when correcting CC based on battery full
+ *			status. This function should return charge lost since
+ *			battery was last load full. Units in uAh.
+ * @get_uah:		return current charge as measured by coulomb counter in
+ *			uAh
+ * @update_cc_uah:	Update CC by given charge in uAh
+ * @get_cycle:		get battery cycle for age compensation
+ * @set_cycle:		some batteries/chargers rely on user-space to store the
+ *			cycle infomration over reset. Those drivers can
+ *			implement the set_cycle callback which user-space can
+ *			use to set the stored battery cycle after reset.
+ * @get_sys:		get the current system voltage in uV. Used for
+ *			IC specific low-voltage SOC correction.
+ * @get_soc_by_ocv:	setups which do not store the OCV/SOC information in
+ *			standard battery_info can implement this function to
+ *			compute SOC based on OCV. SOC should be returned as
+ *			units of 0.1%
+ * @get_ocv_by_soc:	setups which do not store the OCV/SOC information in
+ *			standard battery_info can implement this function to
+ *			compute OCV based on SOC. NOTE: Soc is provided to
+ *			the function in units of 0.1% to improve accuracy.
+ * @age_correct_cap:	batteries/devices with more complicated aging
+ *			correction than constant uAh times battery cycles
+ *			can implement this to adjust capacity based on battery
+ *			cycles. For constant aging use degrade_cycle_uah
+ *			in desc.
+ * @temp_correct_cap:	batteries/devices with more complicated temperature
+ *			correction than ranges of temperatures with constant
+ *			change uah/degree C can implement this to adjust
+ *			capacity based on battery temperature.
+ *			For temperature ranges with constant change uAh/degree
+ *			use temp_dgr and amount_of_temp_dgr at desc.
+ * @calibrate:		many devices implement coulomb counter calibration
+ *			(for example by measuring ADC offset pins shorted).
+ *			Such devices can implement this function for periodical
+ *			calibration.
+ * @suspend_calibrate:	Many small capacity battery devices or devices which
+ *			spend long time MCU suspended can benefit from
+ *			starting the calibration when entering to suspend. Such
+ *			devices can implement this callback to initiaite
+ *			calibration when entering to suspend
+ * @zero_cap_adjust: IC specific SOC estimation adjustment to be performed
+ *			when battery is approaching empty.
+ */
+struct simple_gauge_ops {
+	/*
+	 * Get battery relax - could probably also use PSY class state if
+	 * it was extended with some properties like BATTERY_RELAXED to know
+	 * if OCV can be used.
+	 *
+	 * Currently meaningfull states are charging/discharging/full/relaxed
+	 * Full so we can correct battery capacity and/or CC
+	 * Relax so we know we can use OCV
+	 */
+	bool (*is_relaxed)(struct simple_gauge *gauge, int *rex_volt);
+	int (*get_temp)(struct simple_gauge *gauge, int *temp);
+	int (*get_uah_from_full)(struct simple_gauge *gauge, int *uah);
+	int (*get_uah)(struct simple_gauge *gauge, int *uah);
+	int (*update_cc_uah)(struct simple_gauge *gauge, int bcap);
+	int (*get_cycle)(struct simple_gauge *gauge, int *cycle);
+	int (*set_cycle)(struct simple_gauge *gauge, int old, int *new_cycle);
+	int (*get_vsys)(struct simple_gauge *gauge, int *uv);
+	int (*get_soc_by_ocv)(struct simple_gauge *sw, int ocv, int temp, int *so=
c);
+	int (*get_ocv_by_soc)(struct simple_gauge *sw, int soc, int temp, int *oc=
v);
+	int (*age_correct_cap)(struct simple_gauge *gauge, int cycle, int *cap);
+	int (*temp_correct_cap)(struct simple_gauge *gauge, int *cap, int temp);
+	int (*calibrate)(struct simple_gauge *sw);
+	int (*suspend_calibrate)(struct simple_gauge *sw, bool start);
+	int (*zero_cap_adjust)(struct simple_gauge *sw, int *effective_cap,
+				  int cc_uah, int vbat, int temp);
+};
+
+/**
+ * struct simple_gauge_desc - fuel gauge description
+ *
+ * The fuel gauges which benefit from generic computations (typically devi=
ces
+ * with coulomb counter. OCV - SOC table and iterative polling / error
+ * correction) provided by the simple_gauge framework must be described by=
 the
+ * simple_gauge_desc prior registration to the simple_gauge framework.
+ *
+ * @name:		Identifying name for gauge (Is this needed?)
+ * @degrade_cycle_uah:	constant lost capacity / battery cycle in uAh.
+ * @amount_of_temp_dgr:	amount of temperature ranges provided in temp_dgr
+ * @temp_dgr:		ranges of constant lost capacity / temperature degree
+ *			in uAh. Ranges should be sorted in asecnding order by
+ *			temperature_floor.
+ * @poll_interval:	time interval in mS at which this fuel gauge iteration
+ *			loop for volage polling and coulomb counter corrections
+ *			should be ran.
+ * @calibrate_interval:	time interval in mS at which this IC should be
+ *			calibrated.
+ * @designed_cap:	designed battery capacity in uAh. Can be given here if
+ *			not available via batinfo.
+ * @allow_set_cycle:	Allow userspace to set cached battery cycle. If no HW
+ *			access is required when new battery cycle value is set
+ *			the driver can omit set_cycle callback and just set
+ *			this to true.
+ * @clamp_soc:		Set true tonot allow computed SOC to increase if state
+ *			is discharging.
+ * @cap_adjust_volt_threshold: some systems want to apply extra computation
+ *			to estimate battery capacity when voltage gets close
+ *			to system limit in order to avoid shut-down for as long
+ *			as possible. Such ICs can set this limit and optionally
+ *			implement zero_cap_adjust callback.
+ * @system_min_voltage:	ICs using the cap_adjust_volt_threshold and no
+ *			zero_cap_adjust call-back should set this voltage
+ *			to Vsys which correspond empty battery situation.
+ */
+struct simple_gauge_desc {
+	int degrade_cycle_uah;
+	int amount_of_temp_dgr;
+	struct power_supply_temp_degr *temp_dgr;
+	int poll_interval;
+	int calibrate_interval;
+	int designed_cap; /* This is also looked from batinfo (DT node) */
+	int cap_adjust_volt_threshold;
+	int system_min_voltage;
+	bool allow_set_cycle;
+	bool clamp_soc;
+	void *drv_data;
+};
+
+/**
+ * struct simple_gauge_psy - power supply configuration
+ *
+ * configuration being further passed to power-supply registration.
+ */
+struct simple_gauge_psy {
+	const char *psy_name;
+	struct device_node *of_node;
+	/* Device specific sysfs attributes, delivered to power_supply */
+	const struct attribute_group **attr_grp;
+
+	enum power_supply_property *additional_props;
+	int num_additional_props;
+
+	int (*is_writable)(struct simple_gauge *gauge,
+			   enum power_supply_property psp);
+	int (*get_custom_property)(struct simple_gauge *gauge,
+				   enum power_supply_property psp,
+				   union power_supply_propval *val);
+	int (*set_custom_property)(struct simple_gauge *gauge,
+				   enum power_supply_property psp,
+				   const union power_supply_propval *val);
+};
+
+/**
+ * struct simple_gauge - simple_gauge runtime data
+ *
+ * Internal to sw-gauge. Should not be directly accessed/modified by drive=
rs
+ */
+struct simple_gauge {
+	struct device *dev;
+	int designed_cap;	/* This should be available for drivers */
+	struct simple_gauge_desc desc;
+	int cycle;
+	u64 next_iter; /* Time of next iteration in jiffies64 */
+	u64 next_cal; /* Time of next calibration in jiffies64 */
+	int force_run;
+	int refcount;
+	struct power_supply *psy;
+	enum power_supply_property *properties;
+
+	int (*get_custom_property)(struct simple_gauge *gauge,
+				  enum power_supply_property psp,
+				  union power_supply_propval *val);
+	int (*set_custom_property)(struct simple_gauge *gauge,
+				 enum power_supply_property psp,
+				 const union power_supply_propval *val);
+	int (*custom_is_writable)(struct simple_gauge *gauge,
+				  enum power_supply_property psp);
+	struct power_supply_battery_info info;
+	struct simple_gauge_ops ops;
+	struct list_head node;
+	int amount_of_temp_dgr;
+	struct power_supply_temp_degr *temp_dgr;
+	spinlock_t lock;
+	bool batinfo_got;
+	wait_queue_head_t wq;
+	int soc_rounding;
+	int clamped_soc;
+	/* Cached values from prev iteration */
+	int soc;		/* SOC computed at previous iteration */
+	int capacity_uah;	/* CAP computed at previous iteration (uAh) */
+	int cc_uah;		/* uAh reported by CC at previous iteration */
+	int temp;		/* Temperature at previous iteration */
+};
+
+struct simple_gauge *__must_check psy_register_simple_gauge(struct device =
*parent,
+						    struct simple_gauge_psy *psycfg,
+						    struct simple_gauge_ops *ops,
+						    struct simple_gauge_desc *desc);
+void psy_remove_simple_gauge(struct simple_gauge *sw);
+
+struct simple_gauge *__must_check
+devm_psy_register_simple_gauge(struct device *parent, struct simple_gauge_=
psy *psycfg,
+			   struct simple_gauge_ops *ops,
+			   struct simple_gauge_desc *desc);
+void simple_gauge_run(struct simple_gauge *sw);
+int simple_gauge_run_blocking_timeout(struct simple_gauge *sg,
+				      unsigned int timeout_ms);
+int simple_gauge_run_blocking(struct simple_gauge *sg);
+void *simple_gauge_get_drvdata(struct simple_gauge *sg);
+
+#endif /* POWER_SW_GAUGE_H */
--=20
2.31.1


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--c73i0tdUUwqAJl/f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmGTo90ACgkQeFA3/03a
ocVyAAf/fmRNl9/juc5789RuBVgYFnBL+t46yGm+P3n4LF2GNudG9Qa8N3CZ8LKH
8nPWCAvJrewBM/6TEaxDrzuK2jqZ5r5ZMWLDUYwrOPX8eCAkTPOPXJkswz3OJS4n
uNb4It0560fVAoxiUlck5OTpehPYseycmIve/MP9q6FtVRh6UqQH6vhAHVZtFPCZ
+JVo6xIq1Gu9XmzwuyhlfzWWFRU8Sdpn8VhmnJaFw/ORv8ruYQvdTzVskCPfgA3b
8wPV7I+ZhU9EJkCu7nd99yw2Uv4YojX5SzUk+i7CLwC4rMJLquDFWCvMR1bqte+Q
HRdkgQeR/b82EqbjGJQDZzppfHBupw==
=2BTS
-----END PGP SIGNATURE-----

--c73i0tdUUwqAJl/f--
