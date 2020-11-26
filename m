Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC372C51DD
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 11:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387618AbgKZKOO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 05:14:14 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40306 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbgKZKON (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2020 05:14:13 -0500
Received: by mail-lf1-f68.google.com with SMTP id u19so1718074lfr.7;
        Thu, 26 Nov 2020 02:14:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AUfOFx/9lCcJmX6lsFqMfIgP/kWUMnLNSn5ZdmQMoW4=;
        b=YqTN50rR3TNhO/beq51hCE4E7k4mTm0wsBwvDL9gPi/Q3h8nd16JhqMPeDm3WbceVr
         /3Q2tTG5HlURMr/CEx2Hohb7iirc20TpJUFjECGwepspPVGmnL5JSWNvFN32wgQt8qln
         xE9a8vYWzBLe/I51jRBkg6BsscFU9RXZ3c2ctctSNkSpEm8ta/gDQZG35608inUtqyaa
         dBvoDQFnFI2yVKjuNWQejDe9sreBpkt6yBIYNZUoWk/XYFwQbMfAye6Z0mOwAJCswj6H
         EJFESvjTH1hEowdGS5yGdVxAnFE4I6E8F58RhVNcxgDJAU0IUgJ21+h1bVVyGKmAny3W
         ifrw==
X-Gm-Message-State: AOAM532vgUGYVSIdsjnrr7MgbKT88fczfv3insIwwv5UyGx3zJEnVpwM
        jfbqeAy/d1mYJ4Pb3rzXQ0E=
X-Google-Smtp-Source: ABdhPJwITKNJISnHr4TgkWUk1k6IpdtxCNPyjc/K/Gm1kLTkApENGVatjCGQ6II31ENQvXhT6pfAaw==
X-Received: by 2002:a19:404a:: with SMTP id n71mr1044933lfa.493.1606385646388;
        Thu, 26 Nov 2020 02:14:06 -0800 (PST)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id s26sm545012ljo.116.2020.11.26.02.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 02:14:05 -0800 (PST)
Date:   Thu, 26 Nov 2020 12:13:58 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [RFC PATCH 2/2] power: supply: add sw-gauge for SOC estimation and
 CC correction
Message-ID: <70ae1f9da94074934767426ca0a1bef758037199.1606384967.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1606384967.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1606384967.git.matti.vaittinen@fi.rohmeurope.com>
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

Please do not spend hours with full formal review. The code here is
provided to explain what I thought of working with and needs proper
testing prior full review can be beneficial. I hope this still helps
to explain what I have on mind. If this is seen worth the further
work - then I will rework and test this + send a proper code for
review. This one was only compile tested. I just hope to get opinion
whether I should put further work on this or not :)

 drivers/power/supply/Kconfig                |   8 +
 drivers/power/supply/Makefile               |   1 +
 drivers/power/supply/power_supply_swgauge.c | 808 ++++++++++++++++++++
 include/linux/power/sw_gauge.h              | 203 +++++
 include/linux/power_supply.h                |   6 +
 5 files changed, 1026 insertions(+)
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
index 000000000000..96724eb459d8
--- /dev/null
+++ b/drivers/power/supply/power_supply_swgauge.c
@@ -0,0 +1,808 @@
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
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/power/sw_gauge.h>
+#include <linux/wait.h>
+
+#define SWGAUGE_TIMEOUT_JITTER 100
+#define SOC_BY_CAP(uah, cap) ((uah) * 100 / (cap))
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
+static int sw_gauge_get_property(struct power_supply *psy,
+			  enum power_supply_property psp,
+			  union power_supply_propval *val)
+{
+	/*
+	 * The sw-gauge initialization has race. We should set the sw_gauge
+	 * to psy before psy-ops are registered. Consider melding SW gauge in
+	 * psy-core. For now we just return -EBUSY if the sw_gauge was not yet
+	 * set.
+	 */
+	if (!psy->sw_gauge)
+		return -EBUSY;
+
+	if (psp == POWER_SUPPLY_PROP_CAPACITY) {
+		spin_lock(&psy->sw_gauge->lock);
+		val->intval = psy->sw_gauge->soc;
+		spin_unlock(&psy->sw_gauge->lock);
+		return 0;
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
+static int get_soc_from_ocv(struct sw_gauge *sw, int *soc, int temp)
+{
+	int ret, ocv;
+
+	if (!sw->ops.get_vbat)
+		return -EINVAL;
+
+	ret = sw->ops.get_vbat(sw, &ocv);
+	if (ret)
+		return ret;
+
+	ret = power_supply_batinfo_ocv2cap(&sw->info, ocv, temp);
+	if (ret > 0) {
+		*soc = ret;
+		ret = 0;
+	}
+
+	if (ret) {
+		if (!sw->ops.get_soc_by_ocv)
+			return ret;
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
+static int adjust_cc_relax(struct sw_gauge *sw)
+{
+	int ret, temp, soc;
+	int full_uah = sw->designed_cap;
+
+	/* get temp */
+	ret = sw_gauge_get_temp(sw, &temp);
+	if (ret)
+		return ret;
+
+	/* get ocv */
+	ret = get_soc_from_ocv(sw, &soc, temp);
+	if (ret)
+		return ret;
+
+	/*
+	 * Here we just use the Vbat to get SOC. Should we apply some age
+	 * correction?
+	 *
+	 * Typically ROHM implemented drivers have kept the value CC in PMIC
+	 * corresponding to IDEAL battery capacity and then substracted the
+	 * lost capacity when converting CC value to uAh. I guess this prevents
+	 * CC from hitting the floor. But how should we handle it here?
+	 *
+	 * If we do the same here - then the low-voltage adjustment computation
+	 * should re-calculate the current uAh value based on shifted zero
+	 * SOC point because the zero-SOC point adjustment impacts to uAh value
+	 * measured by CC, right?
+	 *
+	 * If we don't, then we shouldn't use age-correction in fully-charged
+	 * battery CC-update.
+	 */
+	ret = age_correct_cap(sw, &full_uah);
+	if (ret) {
+		pr_err("Age correction of battery failed\n");
+		return ret;
+	}
+	/* adjust cc */
+	return sw->ops.update_cc_uah(sw, full_uah * soc / 100);
+}
+
+static int get_state(struct sw_gauge *sw, int *state)
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
+
+	/* TODO: We should store voltage before this check to ensure battery
+	 * is still relaxed before we do query the state. Perhaps we should have
+	 * get_relax_voltage call-back which would return voltage if relaxed - else
+	 * an error.
+	 */
+	if (sw->ops.is_relaxed)
+		if (sw->ops.is_relaxed(sw))
+			*state |= SW_GAUGE_RELAX;
+
+	return ret;
+}
+
+static int adjust_cc_full(struct sw_gauge *sw)
+{
+	int ret, full_uah;
+
+	if (sw->ops.get_uah_cc_full)
+		ret = sw->ops.get_uah_cc_full(sw, &full_uah);
+	else
+		ret = sw->ops.get_uah_cc(sw, &full_uah);
+
+	/*
+	 * ROHM algorithm adjusts CC here based on designed capacity and not
+	 * based on age/temperature corrected capacity.
+	 *
+	 * Let's try to use age-compensated capacity unlike original algorithm.
+	 */
+	ret = age_correct_cap(sw, &full_uah);
+	if (ret) {
+		pr_err("Age correction of battery failed\n");
+		return ret;
+	}
+	return sw->ops.update_cc_uah(sw, full_uah);
+}
+/*
+ * Some charger ICs keep count of battery charge systems but can only store
+ * one or few cycles. They may need to clear the cycle counter and update
+ * counter in SW. This function fetches the counter from HW and allows HW to
+ * clear IC counter if needed.
+ *
+ * TODO: Add sysfs to export counter value to user-space and to allow
+ * user-space to set it after reset.
+ */
+static int update_cycle(struct sw_gauge *sw)
+{
+	int cycle, ret = -EINVAL;
+
+	if (sw->ops.get_cycle) {
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
+static int sw_gauge_cap2ocv(struct sw_gauge *sw, int soc, int temp, int *ocv)
+{
+	int ret;
+
+	ret = power_supply_batinfo_cap2ocv(&sw->info, soc, temp);
+	if (ret > 0) {
+		*ocv = ret;
+		ret = 0;
+	}
+
+	return ret;
+}
+
+static int load_based_soc_zero_adjust(struct sw_gauge *sw, int *effective_cap,
+				       int *cc_uah, int vsys, int temp)
+{
+	int soc, ocv_by_cap;
+	int ret, i;
+	int vdrop;
+	struct power_supply_battery_ocv_table *table;
+	int table_len;
+	int soc_adjust = 0;
+
+	/* Get OCV for current estimated SOC */
+	soc = SOC_BY_CAP(*cc_uah, *effective_cap);
+	ret = sw_gauge_cap2ocv(sw, soc, temp, &ocv_by_cap);
+	if (ret)
+		return ret;
+
+	/* Get the difference of OCV (no load) and VBAT (current load) */
+	vdrop = ocv_by_cap - vsys;
+	if (vdrop <= 0)
+		return 0;
+
+	/*
+	 * We know that the SOC should be 0 at the moment when voltage with
+	 * this load drops below system limit. So let's scan the OCV table
+	 * and just assume the vdrop stays constant for the rest of the game.
+	 * This way we can see what is the new 'zero adjusted capacity' for
+	 * our battery.
+	 */
+	table = power_supply_find_ocv2cap_table(&sw->info, temp, &table_len);
+	if (!table)
+		return -EINVAL;
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
+		new_full_cap = *effective_cap * (100 - soc_adjust)/100;
+		*effective_cap = new_full_cap;
+	}
+
+	return 0;
+}
+
+static int sw_gauge_low_voltage_adjust(struct sw_gauge *sw, int *effective_cap,
+				       int *cc_uah, int vsys, int temp)
+{
+	int ret;
+
+	if (!sw->ops.low_voltage_adjust) {
+		ret = load_based_soc_zero_adjust(sw, effective_cap, cc_uah,
+						 vsys, temp);
+
+		return ret;
+	}
+
+	return sw->ops.low_voltage_adjust(sw, effective_cap, cc_uah, vsys,
+					  temp);
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
+		pr_warn("Temperature below min %d, using range %d->\n", temp,
+			sw->desc->temp_dgr[i].temp_floor);
+	}
+
+	temp_diff = sw->desc->temp_dgr[i].temp_floor - temp;
+	uah_corr = temp_diff * sw->desc->temp_dgr[i].temp_degrade_1C;
+	if (*cap_uah < -uah_corr)
+		*cap_uah = 0;
+	else
+		*cap_uah += uah_corr;
+
+	return 0;
+}
+
+static int compute_soc_by_cc(struct sw_gauge *sw)
+{
+	int cc_uah, ret;
+	int soc_org, current_cap_uah;
+	int temp;
+
+	ret = sw->ops.get_uah_cc(sw, &cc_uah);
+
+	/* Do we need this? */
+	soc_org = SOC_BY_CAP(cc_uah, sw->designed_cap);
+
+	current_cap_uah = sw->designed_cap;
+
+	ret = age_correct_cap(sw, &current_cap_uah);
+	if (ret) {
+		pr_err("Age correction of battery failed\n");
+		return ret;
+	}
+	if (current_cap_uah == 0) {
+		pr_warn("Battery EOL\n");
+		spin_lock(&sw->lock);
+		sw->capacity_uah = 0;
+		sw->soc = 0;
+		spin_unlock(&sw->lock);
+		return 0;
+	}
+
+	/* Do battery temperature compensation */
+	ret = sw_gauge_get_temp(sw, &temp);
+	if (ret)
+		return ret;
+
+	if (sw->ops.temp_correct_cap)
+		ret = sw->ops.temp_correct_cap(sw, &current_cap_uah, temp);
+	else if (sw->desc->amount_of_temp_dgr)
+		ret = compute_temp_correct_uah(sw, &current_cap_uah, temp);
+	else
+		ret = -EINVAL;
+
+	if (ret)
+		pr_warn("Couldn't do temperature correction to battery cap\n");
+
+	/*
+	 * Allow all ICs to have own adjustment functions for low Vsys to allow
+	 * them tackle potential issues in capacity estimation at near
+	 * depleted battery
+	 */
+	if (sw->desc->low_voltage_adjust_threshold && sw->ops.get_vsys) {
+		int vsys;
+
+		ret = sw->ops.get_vsys(sw, &vsys);
+		if (ret)
+			return ret;
+
+		if (sw->desc->low_voltage_adjust_threshold >= vsys)
+			ret = sw_gauge_low_voltage_adjust(sw, &current_cap_uah,
+							 &cc_uah, vsys, temp);
+	}
+
+	spin_lock(&sw->lock);
+	sw->capacity_uah = current_cap_uah;
+	sw->soc = SOC_BY_CAP(cc_uah, current_cap_uah);
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
+	int state, ret;
+
+	/* Adjust battery aging information */
+	ret = update_cycle(sw);
+	if (ret) {
+		pr_err("Failed to update battery cycle\n");
+		return;
+	}
+
+	ret = get_state(sw, &state);
+	if (ret) {
+		pr_err("Failed to get state for gauge %s\n", sw->name);
+		return;
+	}
+
+	/* Setting CC not possible? Omit CC adjustment */
+	if (sw->ops.update_cc_uah) {
+		if (state & SW_GAUGE_FULL) {
+			ret = adjust_cc_full(sw);
+			if (ret)
+				pr_err("Failed to do FULL addjust for gauge '%s'\n",
+				       sw->name);
+		}
+		if (state & SW_GAUGE_RELAX) {
+			ret = adjust_cc_relax(sw);
+			if (ret)
+				pr_err("Failed to do RELAX adjust for gauge '%s'\n",
+				       sw->name);
+		}
+	}
+
+	ret = compute_soc_by_cc(sw);
+	if (ret)
+		pr_err("Failed to compute SOC for gauge '%s'\n", sw->name);
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
+static void adjust_next_tmo(struct sw_gauge *sw, unsigned int *timeout, u64 now)
+{
+	u64 t = (sw->desc->calibrate_interval && sw->next_cal < sw->next_iter) ?
+			sw->next_cal : sw->next_iter;
+
+	if (!*timeout || t < *timeout)
+		*timeout = t;
+
+	if (*timeout - now < msecs_to_jiffies(SWGAUGE_TIMEOUT_JITTER))
+		*timeout = now + msecs_to_jiffies(SWGAUGE_TIMEOUT_JITTER);
+}
+
+static int gauge_thread(void *data)
+{
+	for (;;) {
+		unsigned int timeout = 0;
+		struct sw_gauge *sw;
+		u64 now = get_jiffies_64();
+
+		if (kthread_should_stop()) {
+			g_running = 0;
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
+		msleep(timeout);
+	}
+	pr_debug("SW gauge exiting\n");
+
+	return 0;
+}
+
+static int start_gauge_thread(struct task_struct *k)
+{
+	int ret = 0;
+
+	/* Ensure the running state is updted. Is this needed? How likely it is
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
+static int check_compulsory_ops(struct sw_gauge_ops *ops)
+{
+	return (ops->get_uah_cc && ops->get_temp && ops->update_cc_uah);
+}
+
+static int sw_gauge_set_ops(struct sw_gauge *sw, struct sw_gauge_ops *ops)
+{
+	int ret;
+
+	ret = check_compulsory_ops(ops);
+	if (ret)
+		return ret;
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
+	struct power_supply *psy;
+	struct power_supply_desc pd;
+	int ret;
+	struct sw_gauge *new;
+
+	if (!desc->poll_interval)
+		return ERR_PTR(-EINVAL);
+
+	if (!parent)
+		return ERR_PTR(-EINVAL);
+
+	new = kzalloc(sizeof(struct sw_gauge), GFP_KERNEL);
+	if (!new)
+		return ERR_PTR(-ENOMEM);
+
+	init_waitqueue_head(&new->wq);
+
+	ret = sw_gauge_set_ops(new, ops);
+	if (ret)
+		goto free_out;
+
+	new->desc = desc;
+
+	pd = *psycfg->pdesc;
+	new->orig_get_property = pd.get_property;
+	spin_lock_init(&new->lock);
+	pd.get_property = sw_gauge_get_property;
+
+	/* Do we need power_supply_register_ws? */
+	/*
+	 * Here we have a race. psy->swgauge is not set yet. We should
+	 * set it in power_supply_register
+	 */
+	new->psy = power_supply_register(parent, &pd, psycfg->pcfg);
+	if (IS_ERR(new->psy)) {
+		ret = PTR_ERR(new->psy);
+		goto free_out;
+	}
+	new->psy->sw_gauge = new;
+	new->name = kstrdup(desc->name, GFP_KERNEL);
+	if (!new->name) {
+		ret = -ENOMEM;
+		goto psy_dereg_out;
+	}
+
+	/* Maybe this should be optional */
+	ret = power_supply_get_battery_info(new->psy, &new->info);
+	if (ret && new->ops.get_soc_by_ocv) {
+		pr_err("No OCV => SoC conversion\n");
+		goto name_out;
+	}
+	if (!ret)
+		new->batinfo_got = true;
+
+	if (desc->designed_cap) {
+		new->designed_cap = desc->designed_cap;
+	} else if (ret || !new->info.charge_full_design_uah) {
+		pr_err("Unknown battery capacity\n");
+		goto name_out;
+	} else {
+		new->desc->designed_cap = new->info.charge_full_design_uah;
+	}
+	mutex_lock(&sw_gauge_lock);
+	if (psy->sw_gauge) {
+		ret = -EBUSY;
+		goto err_unlock;
+	};
+	new->psy = psy;
+	psy->sw_gauge = new;
+	list_add(&sw_gauges, &new->node);
+	mutex_unlock(&sw_gauge_lock);
+	ret = start_gauge_thread(&k);
+	if (ret) {
+		pr_err("Failed to start fuel-gauge thread\n");
+		goto name_out;
+	}
+return new;
+
+err_unlock:
+	mutex_unlock(&sw_gauge_lock);
+name_out:
+	if (new->batinfo_got)
+		power_supply_put_battery_info(new->psy, &new->info);
+	kfree(new->name);
+psy_dereg_out:
+	power_supply_unregister(new->psy);
+free_out:
+	kfree(new);
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
+	kfree(sw->name);
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
+MODULE_DESCRIPTION("generic fuel-gauge on coulomb counter");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/power/sw_gauge.h b/include/linux/power/sw_gauge.h
new file mode 100644
index 000000000000..9fa5ad9846d2
--- /dev/null
+++ b/include/linux/power/sw_gauge.h
@@ -0,0 +1,203 @@
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
+
+/**
+ * struct sw_gauge_temp_degr - linear impact of temperature to battery capacity
+ *
+ * Usually temperature impacts on battery capacity. For systems where it is
+ * sufficient to describe capacity change as a series of temperature ranges
+ * where the change is linear (Eg delta cap = temperature_change * constant)
+ * change of capacity per degree can be described by this structure.
+ *
+ * @temp_floor: Lowest temperature where this change is valid
+ * @temp_degrade_1C: Amount of capacity change / temperature degree
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
+ * @is_relaxed:		return true if battery is at relaxed state
+ * @get_temp:		return the battery temperature (Unit? I guess degree C?
+ *			should we use millicelsius to be on a safe side for
+ *			really temp sensitive batteries?)
+ * @get_uah_cc_full:	some chargers perform special operation when battery is
+ *			fully charged. Those drivers can implement
+ *			get_uah_cc_full which should return current charge as
+ *			measured by coulomb counter in uAh
+ * @get_uah_cc:		return current charge as measured by coulomb counter in
+ *			uAh
+ * @update_cc_uah:	Update CC by given charge in uAh
+ * @get_cycle:		get battery cycle for age compensation
+ * @set_cycle:		some batteries/chargers rely on user-space to store the
+ *			cycle infomration over reset. Those drivers can
+ *			implement the set_cycle callback which user-space can
+ *			use to set the stored battery cycle after reset.
+ *			TODO: Implement sysfs for getting and setting battery
+ *			cycle.
+ * @get_vbat:		get the current battery voltage in uV. Used as OCV
+ *			for relaxed battery.
+ * @get_sys:		get the current system voltage in uV. Used for
+ *			IC specific low-voltage SOC correction.
+ * @get_soc_by_ocv:	setups which do not store the OCV/SOC information in
+ *			standard battery_info can implement this function to
+ *			compute SOC based on OCV
+ * @get_ocv_by_soc:	setups which do not store the OCV/SOC information in
+ *			standard battery_info can implement this function to
+ *			compute OCV based on SOC
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
+ * @low_voltage_adjust: IC specific SOC estimation adjustment to be performed
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
+	bool (*is_relaxed)(struct sw_gauge *gauge);
+	int (*get_temp)(struct sw_gauge *gauge, int *temp);
+	int (*get_uah_cc_full)(struct sw_gauge *gauge, int *uah);
+	int (*get_uah_cc)(struct sw_gauge *gauge, int *uah);
+	int (*update_cc_uah)(struct sw_gauge *gauge, int bcap);
+	int (*get_cycle)(struct sw_gauge *gauge, int *cycle);
+	int (*set_cycle)(struct sw_gauge *gauge, int cycle);
+	int (*get_vbat)(struct sw_gauge *gauge, int *uv);
+	int (*get_vsys)(struct sw_gauge *gauge, int *uv);
+	int (*get_soc_by_ocv)(struct sw_gauge *sw, int ocv, int temp, int *soc);
+	int (*get_ocv_by_soc)(struct sw_gauge *sw, int soc, int temp, int *ocv);
+	int (*age_correct_cap)(struct sw_gauge *gauge, int cycle, int *cap);
+	int (*temp_correct_cap)(struct sw_gauge *gauge, int *cap, int temp);
+	int (*calibrate)(struct sw_gauge *sw);
+	int (*suspend_calibrate)(struct sw_gauge *sw, bool start);
+	int (*low_voltage_adjust)(struct sw_gauge *sw, int *effective_cap,
+				  int *cc_uah, int vbat, int temp);
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
+ * @low_voltage_adjust_threshold: some systems want to apply extra computation
+ *				  to SOC when voltage gets close to system
+ *				  limit in order to avoid shut-down for as long
+ *				  as possible. Such ICs can set this limit
+ *				  and optionally implement low_voltage_adjust
+ *				  callback
+ * @system_min_voltage:	ICs using the low_voltage_adjust_threshold and no
+ *			low_voltage_adjust call-back should set this voltage
+ *			to Vsys which correspond empty battery situation.
+ */
+struct sw_gauge_desc {
+	const char *name;
+	int degrade_cycle_uah;
+	int amount_of_temp_dgr;
+	struct sw_gauge_temp_degr *temp_dgr;
+	const int poll_interval;
+	const int calibrate_interval;
+	int designed_cap; /* This is also looked from batinfo (DT node) */
+	int low_voltage_adjust_threshold;
+	int system_min_voltage;
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
+	const char *name;
+	struct sw_gauge_desc *desc;
+	int cycle;
+	u64 next_iter; /* Time of next iteration in jiffies64 */
+	u64 next_cal; /* Time of next calibration in jiffies64 */
+	int refcount;
+	struct power_supply *psy;
+	int soc;		/* Computed SOC */
+	int capacity_uah;	/* Computed capacity uAh */
+	int designed_cap;
+	int (*orig_get_property)(struct power_supply *psy,
+				 enum power_supply_property psp,
+				 union power_supply_propval *val);
+	struct power_supply_battery_info info;
+	struct sw_gauge_ops ops;
+	struct list_head node;
+	spinlock_t lock;
+	bool batinfo_got;
+	wait_queue_head_t wq;
+};
+
+struct sw_gauge *__must_check psy_register_sw_gauge(struct device *parent,
+						    struct sw_gauge_psy *psycfg,
+						    struct sw_gauge_ops *ops,
+						    struct sw_gauge_desc *desc);
+void psy_remove_sw_gauge(struct sw_gauge *sw);
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
