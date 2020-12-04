Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437B02CEE4E
	for <lists+linux-pm@lfdr.de>; Fri,  4 Dec 2020 13:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388152AbgLDMor (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Dec 2020 07:44:47 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45612 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388138AbgLDMoq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Dec 2020 07:44:46 -0500
Received: by mail-lj1-f194.google.com with SMTP id q8so6419705ljc.12;
        Fri, 04 Dec 2020 04:44:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mkgmWk3F1v7jvcNTkPmTfW+4Fl09IVALpwH/3HkstQE=;
        b=hCd/Ezch2SbH8hr445m1IuAZZa/wnCvXHE7D2deQiVzUns+F+WBU8Ra3gapBKPvRWD
         NyoFo/ST18BKCr3SiAB8udZLZevG0oC9fi/DrrwoNtSQbAOeV7nixSpBRpoEsJqAgKS/
         kjO9sD8WTKzfomwW2BEbQ3idASBuI6I860HcYLU+hzx/s+d73Gx4Dg94FpSdcB+zPOxy
         rLVg7v5M4uc3h6T5AmCynEtnBU0aTM+YGAi7PenkPqMckDFqTj6ITM10SwPuMLyInjfu
         rhCHJth0kDlDLEgw7BjulU85xSlo/1nnl7LNIDyemGEw/UR3vV2K6UOuthuRTjpK79vW
         Xe5A==
X-Gm-Message-State: AOAM53198r49f2c54Un6chowNF/DWjphj+BNEAWp4DA/EnDqnQZaaVxD
        8h0zeqAAIRTS3Qus+fJUuEk=
X-Google-Smtp-Source: ABdhPJymLPPwX00BA4yhq1fiPoYwNcCo8b/J4QnxAyNB6be76yV1nMSA0rUpW9tMlU2WsWlCcDNOow==
X-Received: by 2002:a2e:5705:: with SMTP id l5mr3367571ljb.93.1607085841055;
        Fri, 04 Dec 2020 04:44:01 -0800 (PST)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id a30sm1654837ljd.91.2020.12.04.04.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 04:44:00 -0800 (PST)
Date:   Fri, 4 Dec 2020 14:43:54 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Cong Pham <cpham2403@gmail.com>, rostokus@gmail.com,
        fan.chen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [RFC PATCH v2 2/6] power: supply: add sw-gauge for SOC estimation
 and CC correction
Message-ID: <639bd97975a7420f6357bdc6161e1fc427fca79d.1607085199.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1607085199.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1607085199.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add generic 'sw gauge' helper for performing iterative SOC estimation
and coulomb counter correction for devices with a (drifting) coulomb
counter. This should allow few charger/fuel-gauge drivers to use generic
loop instead of implementing their own.

Charger/fuel-gauge drivers can register 'sw-gauge' which does periodically
poll the driver and:
 - get battery state
 - adjust coulomb counter value (to fix drifting caused for example by ADC
   offset) if:
     - Battery is relaxed and OCV<=>SOC table is given
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

The SW gauge provides the last computed SOC as POWER_SUPPLY_PROP_CAPACITY
to power_supply_class when requested.

Things that should/could be added but are missing from this commit:
 - Support starting calibration in HW when entering to suspend. This
   is useful for ICs supporting delayed calibration to mitigate CC error
   during suspend - and to make periodical wake-up less critical.
 - provide the user-space a consistent interface for getting/setting the
   battery-cycle information for ICs which can't store the battery aging
   information (like how many times battery has been charged to full)
   over reset. Should POWER_SUPPLY_PROP_CYCLE_COUNT be used?
 - periodical wake-up for performing SOC estimation computation (RTC
   integration)

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---

Here we have quite some fixes from v1 - but still this is just sent to
collect opinions and suggestions (well, collaboration) regarding the
basic concept. No acceptance or accurate review is requested.

 drivers/power/supply/Kconfig                |    8 +
 drivers/power/supply/Makefile               |    1 +
 drivers/power/supply/power_supply_swgauge.c | 1025 +++++++++++++++++++
 include/linux/power/sw_gauge.h              |  225 ++++
 include/linux/power_supply.h                |    6 +
 5 files changed, 1265 insertions(+)
 create mode 100644 drivers/power/supply/power_supply_swgauge.c
 create mode 100644 include/linux/power/sw_gauge.h

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index eec646c568b7..d78231f3caf7 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -9,6 +9,14 @@ menuconfig POWER_SUPPLY
 
 if POWER_SUPPLY
 
+config SW_GAUGE
+	bool "SW gauge"
+	help
+	  Say Y here to enable kernel fuel-gauge which can be used to
+	  compute the remaining state of charge in a battery. The SW gauge
+	  can compensate battery aging and adjust coulomb counter on ICs
+	  based on some battery/charger specific data.
+
 config POWER_SUPPLY_DEBUG
 	bool "Power supply debug"
 	help
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index dd4b86318cd9..f3d9472ee8cb 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -5,6 +5,7 @@ power_supply-y				:= power_supply_core.o
 power_supply-$(CONFIG_SYSFS)		+= power_supply_sysfs.o
 power_supply-$(CONFIG_LEDS_TRIGGERS)	+= power_supply_leds.o
 
+obj-$(CONFIG_SW_GAUGE)		+= power_supply_swgauge.o
 obj-$(CONFIG_POWER_SUPPLY)	+= power_supply.o
 obj-$(CONFIG_POWER_SUPPLY_HWMON) += power_supply_hwmon.o
 obj-$(CONFIG_GENERIC_ADC_BATTERY)	+= generic-adc-battery.o
diff --git a/drivers/power/supply/power_supply_swgauge.c b/drivers/power/supply/power_supply_swgauge.c
new file mode 100644
index 000000000000..0c30f5516774
--- /dev/null
+++ b/drivers/power/supply/power_supply_swgauge.c
@@ -0,0 +1,1025 @@
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
+#include <linux/power/sw_gauge.h>
+#include <linux/wait.h>
+
+#define SWGAUGE_TIMEOUT_JITTER 100
+/* We add 0.5% of uAh to avoid rounding error */
+#define SOC_BY_CAP(uah, round, cap) ((uah + round) * 100 / (cap))
+
+/*
+ * The idea here is to implement (typical?) periodical coulomb-counter polling
+ * and adjusting. I know few ROHM ICs which do this in out-of-tree drivers -
+ * and I think there is few drivers also in-tree doing something similar. I
+ * believe adding some SOC computation logic to core could benefit a few of the
+ * drivers.
+ *
+ * I selected the ROHM algorithm here because I know it better than others.
+ *
+ * So let's go explaining the logic pulled in here:
+ *
+ * Device drivers for (charger) ICs which contain a coulomb counter can
+ * register here and provide IC specific functions as listed in
+ * include/linux/power/sw_gauge.h struct sw_gauge_ops. Drivers can also specify
+ * time interval the IC is polled.
+ *
+ * After registration the sw_gauge does periodically poll the driver and:
+ * - get battery state
+ * - adjust coulomb counter value (to fix drifting caused for example by ADC
+ *   offset) if:
+ *     - Battery is relaxed and OCV<=>SOC table is given
+ *     - Battery is full charged
+ * - get battery age (cycles) from driver
+ * - get battery temperature
+ * - do battery capacity correction
+ *     - by battery temperature
+ *     - by battery age
+ *     - by computed Vbat/OCV difference at low-battery condition if
+ *       low-limit is set and OCV table given
+ *     - by IC specific low-battery correction if provided
+ * - compute current State Of Charge (SOC)
+ * - do periodical calibration if IC supports that. (Many ICs do calibration
+ *   of CC by shorting the ADC pins and getting the offset).
+ * - TODO: Support starting calibration in HW when entering to suspend. This
+ *   is useful for ICs supporting delayed calibration to mitigate CC error
+ *   during suspend - and to make periodical wake-up less critical.
+ *
+ * The SW gauge provides the last computed SOC as POWER_SUPPLY_PROP_CAPACITY to
+ * power_supply_class when requested.
+ *
+ * Additionally the SW-gauge should provide the user-space a consistent
+ * interface for getting/setting the battery-cycle information for ICs which
+ * can't store the battery aging information (like how many times battery
+ * has been charged to full) over reset. (not yet implemnted - will work on it
+ * next if this RFC is not completely frowned upon - Oh, should userspace just
+ * use POWER_SUPPLY_PROP_CYCLE_COUNT for this? I only now noticed that :))
+ *
+ * Some very low-power devices prefer periodical wake-up for performing SOC
+ * estimation computation even at the cost of power-consumption caused by
+ * such wake-up. So as a future improvement it would be nice to see a RTC
+ * integration which might allow the periodic wake-up. (Or is there better
+ * ideas?)
+ *
+ * If this is not seen as a complete waste of time - then I would like to get
+ * suggestions and opinions :) Especially for following:
+ * 1. Is this kind of generic entity needed or should this just be left to be
+ *    implemented in each individual driver?
+ * 2. Should this be meld-in power_supply_class? I didn't go to that route as I
+ *    didn't want to obfuscate the power_supply registration with the items in
+ *    the sw_gauge desc and ops. OTOH, the psy now has a pointer to sw-gauge
+ *    and sw-gauge to psy - which is a clear hint that the relation of them
+ *    is quite tight.
+ */
+
+DEFINE_MUTEX(sw_gauge_lock);
+DEFINE_MUTEX(sw_gauge_start_lock);
+LIST_HEAD(sw_gauges);
+
+static int g_running;
+static struct task_struct k;
+
+static int swgauge_set_cycle(struct sw_gauge *sw, int new_cycle)
+{
+	int ret, old_cycle = sw->cycle;
+
+	if (!sw->desc->allow_set_cycle && !sw->ops.set_cycle)
+		return -EINVAL;
+
+	if (sw->ops.set_cycle)
+		ret = sw->ops.set_cycle(sw, old_cycle, &new_cycle);
+
+	if (!ret)
+		sw->cycle = new_cycle;
+
+	return ret;
+}
+
+static int sw_gauge_set_property(struct power_supply *psy,
+				 enum power_supply_property psp,
+				 const union power_supply_propval *val)
+{
+	if (!psy->sw_gauge)
+		return -EBUSY;
+
+	if (psp == POWER_SUPPLY_PROP_CYCLE_COUNT)
+		return swgauge_set_cycle(psy->sw_gauge, val->intval);
+
+	return psy->sw_gauge->orig_set_property(psy, psp, val);
+}
+
+static int sw_gauge_get_property(struct power_supply *psy,
+				 enum power_supply_property psp,
+				 union power_supply_propval *val)
+{
+	struct sw_gauge *sw = psy->sw_gauge;
+	/*
+	 * The sw-gauge initialization has race. We should set the sw_gauge
+	 * to psy before psy-ops are registered. Consider melding SW gauge in
+	 * psy-core. For now we just return -EBUSY if the sw_gauge was not yet
+	 * set.
+	 *
+	 * Another thing we should ensure here is that the first iteration
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
+	if (!sw)
+		return -EBUSY;
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CAPACITY:
+		spin_lock(&sw->lock);
+		val->intval = sw->soc;
+		spin_unlock(&sw->lock);
+		return 0;
+	case POWER_SUPPLY_PROP_CYCLE_COUNT:
+		spin_lock(&sw->lock);
+		val->intval = sw->cycle;
+		spin_unlock(&sw->lock);
+		return 0;
+	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
+		/* uAh */
+		val->intval = sw->designed_cap;
+		return 0;
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+		spin_lock(&sw->lock);
+		val->intval = sw->capacity_uah;
+		spin_unlock(&sw->lock);
+		return 0;
+	case POWER_SUPPLY_PROP_CHARGE_NOW:
+		spin_lock(&sw->lock);
+		val->intval = sw->cc_uah;
+		spin_unlock(&sw->lock);
+		return 0;
+	case POWER_SUPPLY_PROP_TEMP:
+		/* TODO: Cache last obtained temperature
+		 * Units(?) Check if we have 0.1 degrees C
+		 */
+		spin_lock(&sw->lock);
+		val->intval = sw->temp;
+		spin_unlock(&sw->lock);
+		return 0;
+	default:
+		break;
+	}
+
+	return psy->sw_gauge->orig_get_property(psy, psp, val);
+}
+
+static void gauge_put(struct sw_gauge *sw)
+{
+	sw->refcount = 0;
+	/* Is barrier needed? Do we need to protect the acces with lock
+	 * anyways?
+	 * I don't see use-case where refcount would need to be increased beyond
+	 * 1 - if that happened we should switch to atomic_inc/dec - which
+	 * probably provides the barriers inside.
+	 */
+	smp_wmb();
+	if (!sw->refcount)
+		wake_up(&sw->wq);
+}
+
+static void gauge_get(struct sw_gauge *sw)
+{
+	sw->refcount = 1;
+	/* Is barrier needed? Ensure the refcount does not stay cached */
+	smp_wmb();
+}
+
+static int gauge_reserved(struct sw_gauge *sw)
+{
+	/* Is barrier needed? Ensure the refcount is updated */
+	smp_rmb();
+	return sw->refcount;
+}
+
+static int get_soc_from_ocv(struct sw_gauge *sw, int *soc, int temp, int ocv)
+{
+	int ret;
+
+	/*
+	 * The OCV tables use degree C as units (if I did not misread the
+	 * code - why?) - power_supply class user-space seems to mandate
+	 * the tenths of a degree - so we require this from drivers and
+	 * lose accuracy here :/
+	 */
+	ret = power_supply_batinfo_ocv2cap(&sw->info, ocv, temp / 10);
+	if (ret > 0) {
+		*soc = ret;
+		ret = 0;
+	}
+
+	if (ret) {
+		if (!sw->ops.get_soc_by_ocv)
+			return ret;
+		/* For driver callbacks we use tenths of degree */
+		ret = sw->ops.get_soc_by_ocv(sw, ocv, temp, soc);
+	}
+	return ret;
+}
+
+static int sw_gauge_get_temp(struct sw_gauge *sw, int *temp)
+{
+	if (sw->ops.get_temp)
+		return sw->ops.get_temp(sw, temp);
+
+	return -EINVAL;
+}
+
+static int age_correct_cap(struct sw_gauge *sw, int *uah)
+{
+	int ret = 0;
+
+	/* If IC provides more complex degradation computation - use it */
+	if (sw->ops.age_correct_cap) {
+		int tmp = *uah;
+
+		ret = sw->ops.age_correct_cap(sw, sw->cycle, &tmp);
+		if (!ret) {
+			*uah = tmp;
+			return 0;
+		}
+	}
+	/* Calculate constant uAh/cycle degradation */
+	if (sw->desc->degrade_cycle_uah) {
+		int lost_cap;
+
+		lost_cap = sw->desc->degrade_cycle_uah * sw->cycle;
+		if (lost_cap > sw->designed_cap)
+			*uah = 0;
+		else
+			*uah -= sw->desc->degrade_cycle_uah * sw->cycle;
+
+		return 0;
+	}
+
+	return ret;
+}
+
+static int adjust_cc_relax(struct sw_gauge *sw, int rex_volt)
+{
+	int ret, temp, soc;
+	int full_uah = sw->designed_cap;
+	int uah_now;
+
+	/* get temp */
+	ret = sw_gauge_get_temp(sw, &temp);
+	if (ret)
+		return ret;
+
+	/* get ocv */
+	ret = get_soc_from_ocv(sw, &soc, temp, rex_volt);
+	if (ret)
+		return ret;
+
+	/*
+	 * Typically ROHM implemented drivers have kept the value CC in PMIC
+	 * corresponding to IDEAL battery capacity and then substracted the
+	 * lost capacity when converting CC value to uAh. I guess this prevents
+	 * CC from hitting the floor.
+	 */
+	uah_now = full_uah * soc / 100 + sw->soc_rounding;
+	if (uah_now > sw->designed_cap)
+		uah_now = sw->designed_cap;
+
+	return sw->ops.update_cc_uah(sw, full_uah);
+}
+
+static int get_state(struct sw_gauge *sw, int *state, int *rex_volt)
+{
+	int ret;
+	enum power_supply_property psp = POWER_SUPPLY_PROP_STATUS;
+	union power_supply_propval pstate;
+
+	*state = 0;
+
+	ret = power_supply_get_property(sw->psy, psp, &pstate);
+	if (ret)
+		return ret;
+
+	if (pstate.intval == POWER_SUPPLY_STATUS_FULL)
+		*state |= SW_GAUGE_FULL;
+	if (pstate.intval == POWER_SUPPLY_STATUS_DISCHARGING ||
+	    pstate.intval == POWER_SUPPLY_STATUS_NOT_CHARGING) {
+		*state |= SW_GAUGE_MAY_BE_LOW;
+		if (sw->desc->clamp_soc)
+			*state |= SW_GAUGE_CLAMP_SOC;
+	}
+
+	if (sw->ops.is_relaxed)
+		if (sw->ops.is_relaxed(sw, rex_volt))
+			*state |= SW_GAUGE_RELAX;
+	return ret;
+}
+
+static int adjust_cc_full(struct sw_gauge *sw)
+{
+	int ret, from_full_uah = 0;
+	int full_uah = sw->designed_cap;
+
+	if (sw->ops.get_uah_from_full)
+		ret = sw->ops.get_uah_from_full(sw, &from_full_uah);
+
+	full_uah -= from_full_uah;
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
+ * counter in SW. This function fetches the counter from HW and allows HW to
+ * clear IC counter if needed.
+ */
+static int update_cycle(struct sw_gauge *sw)
+{
+	int cycle, ret = -EINVAL;
+
+	if (sw->ops.get_cycle) {
+		/*
+		 * We provide old cycle value to driver so driver does not
+		 * need to cache it
+		 */
+		cycle = sw->cycle;
+		ret = sw->ops.get_cycle(sw, &cycle);
+		if (ret)
+			return ret;
+		sw->cycle = cycle;
+	} else
+		sw->cycle++;
+
+	return 0;
+}
+
+static int sw_gauge_cap2ocv(struct sw_gauge *sw, int dsoc, int temp, int *ocv)
+{
+	int ret, soc;
+
+	if (sw->ops.get_ocv_by_soc)
+		return sw->ops.get_ocv_by_soc(sw, dsoc, temp, ocv);
+
+	/*
+	 * Ouch.. I'm afraid this kind of kills the accuracy.
+	 * The cap2OCV should accept soc at least as 0.1%
+	 */
+	soc = dsoc / 10;
+	ret = power_supply_batinfo_cap2ocv(&sw->info, soc, temp / 10);
+	if (ret > 0) {
+		*ocv = ret;
+		ret = 0;
+	}
+
+	return ret;
+}
+
+static int load_based_soc_zero_adjust(struct sw_gauge *sw, int *effective_cap,
+				       int cc_uah, int vsys, int temp)
+{
+	int dsoc, ocv_by_cap;
+	int ret, i;
+	int vdrop;
+	struct power_supply_battery_ocv_table *table;
+	int table_len;
+	int soc_adjust = 0;
+
+	/*
+	 * Get OCV for current estimated SOC - we use unit of 0.1% for SOC
+	 * (dsoc) to improve accuracy. Note - batinfo expects 1% - should we
+	 * introduce new DT entry of more accurate OCV table for improved SOC
+	 * => OCV where SOC was given using unit of 0.1% for improved internal
+	 * calculation? User space should still only see 1% - but for "zero
+	 * adjust" where we do SOC => OCV => drop-voltage => SOC correction
+	 * => CC/capacity adjustment we would like to have more accurate SOC
+	 * in these intermediate steps.
+	 */
+	dsoc = SOC_BY_CAP(cc_uah * 10, 0, *effective_cap);
+	ret = sw_gauge_cap2ocv(sw, dsoc, temp, &ocv_by_cap);
+	if (ret) {
+		dev_err(sw->dev, "Failed to convert cap to OCV\n");
+		return ret;
+	}
+	/* Get the difference of OCV (no load) and VBAT (current load) */
+	vdrop = ocv_by_cap - vsys;
+	dev_dbg(sw->dev, "Obtained OCV: %d, vsys %d, Computed Vdrop %d\n",
+		ocv_by_cap, vsys, vdrop);
+	if (vdrop <= 0)
+		return 0;
+
+	/*
+	 * We know that the SOC should be 0 at the moment when voltage with
+	 * this load drops below system limit. So let's scan the OCV table
+	 * and just assume the vdrop stays constant for the rest of the game.
+	 * This way we can see what is the new 'zero adjusted capacity' for
+	 * our battery.
+	 *
+	 * TODO: Should we support non DT originated OCV table also here? Or
+	 * should the driver just provide whole low-voltage call-back in that
+	 * case?
+	 */
+	table = power_supply_find_ocv2cap_table(&sw->info, temp / 10,
+						&table_len);
+	if (!table) {
+		dev_warn(sw->dev, "No OCV table found\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < table_len; i++)
+		if (table[i].ocv - vdrop <= sw->desc->system_min_voltage)
+			break;
+
+	if (!i)
+		soc_adjust = table[0].capacity;
+	else if (i && i < table_len) {
+		int j;
+		int soc_range = table[i-1].capacity - table[i].capacity;
+		int volt_range = table[i-1].ocv - table[i].ocv;
+		int v_div = volt_range/soc_range;
+
+		for (j = 0; j < soc_range; j++)
+			if (table[i].ocv + v_div * j - vdrop >=
+			   sw->desc->system_min_voltage)
+				break;
+		soc_adjust = table[i].capacity + j;
+	}
+	if (soc_adjust) {
+		int new_full_cap;
+
+		/*
+		 * So we know that actually we will have SOC = 0 when capacity
+		 * is soc_adjust. Lets compute new battery max capacity based
+		 * on this.
+		 */
+		new_full_cap = *effective_cap * (100 - soc_adjust) / 100;
+
+		*effective_cap = new_full_cap;
+	}
+
+	return 0;
+}
+
+static int sw_gauge_zero_cap_adjust(struct sw_gauge *sw, int *effective_cap,
+				       int *cc_uah, int vsys, int temp)
+{
+	int ret, old_eff_cap = *effective_cap;
+
+	if (sw->ops.zero_cap_adjust)
+		ret = sw->ops.zero_cap_adjust(sw, effective_cap, *cc_uah, vsys,
+					      temp);
+	else
+		ret = load_based_soc_zero_adjust(sw, effective_cap, *cc_uah,
+						 vsys, temp);
+	/*
+	 * As we keep HW CC aligned to designed-cap - we need to
+	 * also cancel this new offset from CC measured uAh
+	 */
+	if (!ret)
+		*cc_uah -= old_eff_cap - *effective_cap;
+
+	return ret;
+}
+
+static int compute_temp_correct_uah(struct sw_gauge *sw, int *cap_uah, int temp)
+{
+	int i, temp_diff, uah_corr;
+
+	for (i = 0; i < sw->desc->amount_of_temp_dgr &&
+		    sw->desc->temp_dgr[i].temp_floor > temp; i++)
+		;
+
+	if (i == sw->desc->amount_of_temp_dgr) {
+		i -= 1;
+		dev_warn(sw->dev,
+			 "Temperature below min %d, using range %d->\n", temp,
+			sw->desc->temp_dgr[i].temp_floor);
+	}
+
+	temp_diff = sw->desc->temp_dgr[i].temp_floor - temp;
+	/*
+	 * Temperaure range is in tenths of degrees and degrade value is for a
+	 * degree => divide by 10 after multiplication to fix the scale
+	 */
+	uah_corr = temp_diff * sw->desc->temp_dgr[i].temp_degrade_1C / 10;
+	if (*cap_uah < -uah_corr)
+		*cap_uah = 0;
+	else
+		*cap_uah += uah_corr;
+
+	return 0;
+}
+
+static int compute_soc_by_cc(struct sw_gauge *sw, int state)
+{
+	int cc_uah, ret;
+	int current_cap_uah;
+	int temp;
+	int new_soc;
+	bool do_zero_correct;
+
+	ret = sw->ops.get_uah(sw, &cc_uah);
+	/*
+	 * The CC value should never exceed designed_cap as CC value.
+	 */
+	if (cc_uah > sw->designed_cap) {
+		cc_uah = sw->designed_cap;
+		sw->ops.update_cc_uah(sw, sw->designed_cap);
+	}
+
+	current_cap_uah = sw->designed_cap;
+
+	ret = age_correct_cap(sw, &current_cap_uah);
+	if (ret) {
+		dev_err(sw->dev, "Age correction of battery failed\n");
+		return ret;
+	}
+	if (current_cap_uah == 0) {
+		dev_warn(sw->dev, "Battery EOL\n");
+		spin_lock(&sw->lock);
+		sw->capacity_uah = 0;
+		sw->soc = 0;
+		spin_unlock(&sw->lock);
+		return 0;
+	}
+
+	/* Do battery temperature compensation */
+	ret = sw_gauge_get_temp(sw, &temp);
+	if (ret) {
+		dev_err(sw->dev, "Failed to get temperature\n");
+		return ret;
+	}
+
+	if (sw->ops.temp_correct_cap)
+		ret = sw->ops.temp_correct_cap(sw, &current_cap_uah, temp);
+	else if (sw->desc->amount_of_temp_dgr)
+		ret = compute_temp_correct_uah(sw, &current_cap_uah, temp);
+	else
+		ret = -EINVAL;
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
+	cc_uah -= (sw->designed_cap - current_cap_uah);
+
+	/* Only need zero correction when discharging */
+	do_zero_correct = !!(state & SW_GAUGE_MAY_BE_LOW);
+
+	/*
+	 * Allow all ICs to have own adjustment functions for low Vsys to allow
+	 * them tackle potential issues in capacity estimation at near
+	 * depleted battery
+	 */
+	if (sw->desc->cap_adjust_volt_threshold && sw->ops.get_vsys &&
+	    do_zero_correct) {
+		int vsys;
+
+		ret = sw->ops.get_vsys(sw, &vsys);
+		if (ret) {
+			dev_err(sw->dev, "Failed to get vsys\n");
+			return ret;
+		}
+
+		if (sw->desc->cap_adjust_volt_threshold >= vsys)
+			ret = sw_gauge_zero_cap_adjust(sw, &current_cap_uah,
+							 &cc_uah, vsys, temp);
+		if (ret)
+			dev_warn(sw->dev, "Low voltage adjustment failed\n");
+	}
+
+	if (cc_uah > sw->designed_cap)
+		cc_uah = sw->designed_cap;
+
+	/* Store computed values */
+	spin_lock(&sw->lock);
+	sw->cc_uah = cc_uah;
+	sw->temp = temp;
+	sw->capacity_uah = current_cap_uah;
+	new_soc = SOC_BY_CAP(cc_uah, sw->soc_rounding, current_cap_uah);
+	if (sw->soc != new_soc)
+		/*
+		 * Should we ping user-space about the change?
+		 * Should we ping user-space when SOC changes more than N%?
+		 * Should the N be configurable by user-space?
+		 */
+		;
+
+	sw->soc = new_soc;
+	if (state & SW_GAUGE_CLAMP_SOC) {
+		if (sw->clamped_soc < sw->soc)
+			sw->soc = sw->clamped_soc;
+	}
+	sw->clamped_soc = sw->soc;
+	spin_unlock(&sw->lock);
+	return ret;
+}
+
+static void calibrate(struct sw_gauge *sw)
+{
+	if (sw->ops.calibrate)
+		sw->ops.calibrate(sw);
+}
+
+static void iterate(struct sw_gauge *sw)
+{
+	int state, ret, rex_volt;
+
+	/* Adjust battery aging information */
+	ret = update_cycle(sw);
+	if (ret) {
+		dev_err(sw->dev, "Failed to update battery cycle\n");
+		return;
+	}
+
+	ret = get_state(sw, &state, &rex_volt);
+	if (ret) {
+		dev_err(sw->dev, "Failed to get state\n");
+		return;
+	}
+
+	/* Setting CC not possible? Omit CC adjustment */
+	if (sw->ops.update_cc_uah) {
+		if (state & SW_GAUGE_FULL) {
+			ret = adjust_cc_full(sw);
+			if (ret)
+				dev_err(sw->dev, "Failed to do FULL adjust\n");
+		}
+		if (state & SW_GAUGE_RELAX) {
+			ret = adjust_cc_relax(sw, rex_volt);
+			if (ret)
+				dev_err(sw->dev, "Failed to do RELAX adjust\n");
+		}
+	}
+
+	ret = compute_soc_by_cc(sw, state);
+	if (ret)
+		dev_err(sw->dev, "Failed to compute SOC for gauge\n");
+}
+
+static bool should_calibrate(struct sw_gauge *sw, u64 time)
+{
+	if (sw->desc->calibrate_interval &&
+	    sw->next_cal <= time + msecs_to_jiffies(SWGAUGE_TIMEOUT_JITTER)) {
+		sw->next_cal = time +
+			       msecs_to_jiffies(sw->desc->calibrate_interval);
+		return true;
+	}
+
+	return false;
+
+}
+
+static bool should_compute(struct sw_gauge *sw, u64 time)
+{
+	if (sw->next_iter <= time + msecs_to_jiffies(SWGAUGE_TIMEOUT_JITTER)) {
+		sw->next_iter = time +
+				msecs_to_jiffies(sw->desc->poll_interval);
+		return true;
+	}
+
+	return false;
+}
+
+static void adjust_next_tmo(struct sw_gauge *sw, u64 *timeout, u64 now)
+{
+	u64 t = (sw->desc->calibrate_interval && sw->next_cal < sw->next_iter) ?
+			sw->next_cal : sw->next_iter;
+
+	if (!*timeout || t - now < *timeout)
+		*timeout = t - now;
+
+	if (*timeout < msecs_to_jiffies(SWGAUGE_TIMEOUT_JITTER))
+		*timeout = msecs_to_jiffies(SWGAUGE_TIMEOUT_JITTER);
+}
+
+static int gauge_thread(void *data)
+{
+	for (;;) {
+		u64 timeout = 0;
+		struct sw_gauge *sw;
+		u64 now = get_jiffies_64();
+
+		if (kthread_should_stop()) {
+			g_running = 0;
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
+		mutex_lock(&sw_gauge_lock);
+		list_for_each_entry(sw, &sw_gauges, node) {
+			gauge_get(sw);
+			if (should_compute(sw, now))
+				iterate(sw);
+			if (should_calibrate(sw, now))
+				calibrate(sw);
+			adjust_next_tmo(sw, &timeout, now);
+			gauge_put(sw);
+		}
+		mutex_unlock(&sw_gauge_lock);
+		/*
+		 * We should change this to wait_event_interruptible because
+		 * when new swgauge is registered we must wake-up and perform
+		 * the first iteration ASAP. First iteration needs to be done
+		 * before we have SOC for user-space so registration needs to
+		 * kick us here
+		 */
+		pr_debug("sleeping %u msec\n", jiffies_to_msecs(timeout));
+		msleep(jiffies_to_msecs(timeout));
+	}
+
+	return 0;
+}
+
+static int start_gauge_thread(struct task_struct *k)
+{
+	int ret = 0;
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
+	mutex_lock(&sw_gauge_start_lock);
+	if (!g_running) {
+		k = kthread_run(gauge_thread, NULL, "sw-gauge");
+		if (IS_ERR(k))
+			ret = PTR_ERR(k);
+		else
+			g_running = 1;
+	}
+	mutex_unlock(&sw_gauge_start_lock);
+
+	return ret;
+}
+
+/**
+ * I think this is unnecessary. If someone registers SW gauge to the system
+ * then we can probably leave this running even if the gauge was temporarily
+ * removed. So let's consider removing this and thus simplifying the design.
+ *
+ * Perhaps even always launch the thread if SW-gauge is configured in?
+ */
+void stop_gauge_thread(struct task_struct *k)
+{
+	kthread_stop(k);
+}
+
+static bool is_needed_ops_given(struct sw_gauge_ops *ops)
+{
+	return (ops->get_uah && ops->get_temp && ops->update_cc_uah);
+}
+
+static int sw_gauge_set_ops(struct sw_gauge *sw, struct sw_gauge_ops *ops)
+{
+	if (!is_needed_ops_given(ops))
+		return -EINVAL;
+
+	sw->ops = *ops;
+
+	return 0;
+}
+
+struct sw_gauge *__must_check psy_register_sw_gauge(struct device *parent,
+						    struct sw_gauge_psy *psycfg,
+						    struct sw_gauge_ops *ops,
+						    struct sw_gauge_desc *desc)
+{
+	struct power_supply_desc *pd;
+	int ret;
+	struct sw_gauge *new;
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
+	/*
+	 * I don't like this. I mean, we should either get the psy desc from
+	 * driver - or fill the desc here based on information from driver.
+	 *
+	 * This 'get info from driver but override it here' approach does not
+	 * feel correct. Open to suggestions :)
+	 */
+	pd = kzalloc(sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		return ERR_PTR(-ENOMEM);
+
+	new = kzalloc(sizeof(*new), GFP_KERNEL);
+	if (!new) {
+		ret = -ENOMEM;
+		goto free_pd_out;
+	}
+	init_waitqueue_head(&new->wq);
+
+	new->dev = parent;
+
+	ret = sw_gauge_set_ops(new, ops);
+	if (ret) {
+		dev_err(new->dev, "bad ops\n");
+		goto free_out;
+	}
+	new->desc = desc;
+
+	/*
+	 * Besides - we add our own property getting stuff so we should edit
+	 * the available properties. Should we have constant set of properties
+	 * always handled by swgauge (SOC, TEMP, ... ? ) - or should we allow
+	 * different drivers to specify which properties swgauge handles -
+	 * or should we silently handle properties which we can based on
+	 * callbacks provided by driver?
+	 */
+	*pd = *psycfg->pdesc;
+	new->orig_get_property = pd->get_property;
+	new->orig_set_property = pd->set_property;
+	spin_lock_init(&new->lock);
+	pd->get_property = sw_gauge_get_property;
+	pd->set_property = sw_gauge_set_property;
+
+	/* Do we need power_supply_register_ws? */
+	/*
+	 * Here we have a race. psy->swgauge is not set yet. Should we set it
+	 * in power_supply_register?
+	 *
+	 * Also, we should not return SOC to user-space before the first
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
+	new->psy = power_supply_register(parent, pd, psycfg->pcfg);
+	if (IS_ERR(new->psy)) {
+		dev_err(new->dev, "power supply registration failed\n");
+		ret = PTR_ERR(new->psy);
+		goto free_out;
+	}
+	new->psy->sw_gauge = new;
+
+	ret = power_supply_get_battery_info(new->psy, &new->info);
+	if (ret && !new->ops.get_soc_by_ocv) {
+		dev_err(new->dev, "No OCV => SoC conversion\n");
+		goto info_out;
+	}
+	if (!ret)
+		new->batinfo_got = true;
+
+	if (desc->designed_cap) {
+		new->designed_cap = desc->designed_cap;
+	} else if (ret || !new->info.charge_full_design_uah) {
+		dev_err(new->dev, "Unknown battery capacity\n");
+		goto info_out;
+	} else {
+		new->designed_cap = new->info.charge_full_design_uah;
+	}
+	/* We add 0.5 % to soc uah in order to avoid flooring */
+	new->soc_rounding = new->designed_cap / 200;
+	mutex_lock(&sw_gauge_lock);
+	list_add(&new->node, &sw_gauges);
+	mutex_unlock(&sw_gauge_lock);
+	ret = start_gauge_thread(&k);
+	if (ret) {
+		/*
+		 * This error is not related to underlying device but to the
+		 * swgauge itself. Thus don't print error using the parent
+		 * device
+		 */
+		pr_err("Failed to start fuel-gauge thread\n");
+		goto info_out;
+	}
+	dev_dbg(new->dev, "YaY! SW-gauge registered\n");
+return new;
+
+info_out:
+	if (new->batinfo_got)
+		power_supply_put_battery_info(new->psy, &new->info);
+
+	power_supply_unregister(new->psy);
+free_out:
+	kfree(new);
+free_pd_out:
+	kfree(pd);
+
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(psy_register_sw_gauge);
+
+void psy_remove_sw_gauge(struct sw_gauge *sw)
+{
+	struct power_supply *psy = sw->psy;
+
+	if (sw->batinfo_got)
+		power_supply_put_battery_info(sw->psy, &sw->info);
+	power_supply_unregister(sw->psy);
+	mutex_lock(&sw_gauge_lock);
+	if (sw)
+		list_del(&sw->node);
+	mutex_unlock(&sw_gauge_lock);
+
+	psy->sw_gauge = NULL;
+
+	wait_event(sw->wq, !gauge_reserved(sw));
+	kfree(sw);
+}
+EXPORT_SYMBOL_GPL(psy_remove_sw_gauge);
+
+static void devm_sw_gauge_release(struct device *dev, void *res)
+{
+	struct sw_gauge **sw = res;
+
+	psy_remove_sw_gauge(*sw);
+}
+
+struct sw_gauge *__must_check
+devm_psy_register_sw_gauge(struct device *parent, struct sw_gauge_psy *psycfg,
+			   struct sw_gauge_ops *ops, struct sw_gauge_desc *desc)
+{
+	struct sw_gauge **ptr, *sw;
+
+	ptr = devres_alloc(devm_sw_gauge_release, sizeof(*ptr), GFP_KERNEL);
+
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+	sw = psy_register_sw_gauge(parent, psycfg, ops, desc);
+	if (IS_ERR(sw)) {
+		devres_free(ptr);
+	} else {
+		*ptr = sw;
+		devres_add(parent, ptr);
+	}
+	return sw;
+}
+EXPORT_SYMBOL_GPL(devm_psy_register_sw_gauge);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("generic fuel-gauge on coulomb counter");
+MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
diff --git a/include/linux/power/sw_gauge.h b/include/linux/power/sw_gauge.h
new file mode 100644
index 000000000000..a72af1efb584
--- /dev/null
+++ b/include/linux/power/sw_gauge.h
@@ -0,0 +1,225 @@
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
+/**
+ * struct sw_gauge_temp_degr - linear impact of temperature to battery capacity
+ *
+ * Usually temperature impacts on battery capacity. For systems where it is
+ * sufficient to describe capacity change as a series of temperature ranges
+ * where the change is linear (Eg delta cap = temperature_change * constant)
+ * can be described by this structure.
+ *
+ * Please note - in order to avoid unnecessary rounding errors the change
+ * of capacity (uAh) is per change of temperature degree C while the temperature
+ * range floor is in tenths of degree C
+ *
+ * @temp_floor: Lowest temperature where change is valid (unit 0.1 degree C)
+ * @temp_degrade_1C: Capacity change / temperature change (uAh / degree C)
+ */
+struct sw_gauge_temp_degr {
+	int temp_floor;
+	int temp_degrade_1C;
+};
+
+struct sw_gauge;
+
+/**
+ * struct sw_gauge_ops - fuel-gauge operations
+ *
+ * @is_relaxed:		return true if battery is at relaxed state. Update
+ *			rex_volt to contain measured relaxed battery voltage.
+ * @get_temp:		return the battery temperature in tenths of a degree C.
+ * @get_uah_from_full:	some chargers can provide CC value change since battery
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
+ *			compute SOC based on OCV.
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
+struct sw_gauge_ops {
+	/*
+	 * Get battery relax - could probably also use PSY class state if
+	 * it was extended with some properties like BATTERY_RELAXED to know
+	 * if OCV can be used.
+	 *
+	 * Currently meaningfull states are charging/discharging/full/relaxed
+	 * Full so we can correct battery capacity and/or CC
+	 * Relax so we know we can use OCV
+	 */
+	bool (*is_relaxed)(struct sw_gauge *gauge, int *rex_volt);
+	int (*get_temp)(struct sw_gauge *gauge, int *temp);
+	int (*get_uah_from_full)(struct sw_gauge *gauge, int *uah);
+	int (*get_uah)(struct sw_gauge *gauge, int *uah);
+	int (*update_cc_uah)(struct sw_gauge *gauge, int bcap);
+	int (*get_cycle)(struct sw_gauge *gauge, int *cycle);
+	int (*set_cycle)(struct sw_gauge *gauge, int old, int *new_cycle);
+	int (*get_vsys)(struct sw_gauge *gauge, int *uv);
+	int (*get_soc_by_ocv)(struct sw_gauge *sw, int ocv, int temp, int *soc);
+	int (*get_ocv_by_soc)(struct sw_gauge *sw, int soc, int temp, int *ocv);
+	int (*age_correct_cap)(struct sw_gauge *gauge, int cycle, int *cap);
+	int (*temp_correct_cap)(struct sw_gauge *gauge, int *cap, int temp);
+	int (*calibrate)(struct sw_gauge *sw);
+	int (*suspend_calibrate)(struct sw_gauge *sw, bool start);
+	int (*zero_cap_adjust)(struct sw_gauge *sw, int *effective_cap,
+				  int cc_uah, int vbat, int temp);
+};
+
+/**
+ * struct sw_gauge_desc - fuel gauge description
+ *
+ * The fuel gauges which benefit from generic computations (typically devices
+ * with coulomb counter. OCV - SOC table and iterative polling / error
+ * correction) provided by the sw_gauge framework must be described by the
+ * sw_gauge_desc prior reistration to the sw_gauge framework.
+ *
+ * @name:		Identifying name for gauge
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
+struct sw_gauge_desc {
+	const char *name;
+	int degrade_cycle_uah;
+	int amount_of_temp_dgr;
+	struct sw_gauge_temp_degr *temp_dgr;
+	int poll_interval;
+	int calibrate_interval;
+	int designed_cap; /* This is also looked from batinfo (DT node) */
+	int cap_adjust_volt_threshold;
+	int system_min_voltage;
+	bool allow_set_cycle;
+	bool clamp_soc;
+};
+
+/**
+ * struct sw_gauge_psy - power supply configuration
+ *
+ * configuration being further passed to power-supply registration.
+ */
+struct sw_gauge_psy {
+	const struct power_supply_desc *pdesc;
+	const struct power_supply_config *pcfg;
+};
+
+/**
+ * struct sw_gauge - sw_gauge runtime data
+ *
+ * Internal to sw-gauge. Should not be directly accessed/modified by drivers
+ */
+struct sw_gauge {
+	struct device *dev;
+	int designed_cap;	/* This should be available for drivers */
+	struct sw_gauge_desc *desc;
+	int cycle;
+	u64 next_iter; /* Time of next iteration in jiffies64 */
+	u64 next_cal; /* Time of next calibration in jiffies64 */
+	int refcount;
+	struct power_supply *psy;
+	int (*orig_get_property)(struct power_supply *psy,
+				 enum power_supply_property psp,
+				 union power_supply_propval *val);
+	int (*orig_set_property)(struct power_supply *psy,
+				 enum power_supply_property psp,
+				 const union power_supply_propval *val);
+	struct power_supply_battery_info info;
+	struct sw_gauge_ops ops;
+	struct list_head node;
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
+struct sw_gauge *__must_check psy_register_sw_gauge(struct device *parent,
+						    struct sw_gauge_psy *psycfg,
+						    struct sw_gauge_ops *ops,
+						    struct sw_gauge_desc *desc);
+void psy_remove_sw_gauge(struct sw_gauge *sw);
+
+struct sw_gauge *__must_check
+devm_psy_register_sw_gauge(struct device *parent, struct sw_gauge_psy *psycfg,
+			   struct sw_gauge_ops *ops,
+			   struct sw_gauge_desc *desc);
+
+#endif /* POWER_SW_GAUGE_H */
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index bae98b628f92..d80b5e1ba9a2 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -213,6 +213,9 @@ union power_supply_propval {
 
 struct device_node;
 struct power_supply;
+#ifdef CONFIG_SW_GAUGE
+	struct sw_gauge;
+#endif
 
 /* Run-time specific power supply configuration */
 struct power_supply_config {
@@ -309,6 +312,9 @@ struct power_supply {
 	struct led_trigger *charging_blink_full_solid_trig;
 	char *charging_blink_full_solid_trig_name;
 #endif
+#ifdef CONFIG_SW_GAUGE
+	struct sw_gauge *sw_gauge;
+#endif
 };
 
 /*
-- 
2.25.4


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
