Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E93211059
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 18:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731751AbgGAQO2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 12:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730645AbgGAQO1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 12:14:27 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5988C08C5C1
        for <linux-pm@vger.kernel.org>; Wed,  1 Jul 2020 09:14:27 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id z5so11943407pgb.6
        for <linux-pm@vger.kernel.org>; Wed, 01 Jul 2020 09:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z8ED2nVqG+CIBH/41XUU1eRMBty2La0wKU2T8/KOQQE=;
        b=aT3XbXAazDhd3EFnx9aalxSHZxfWQ+xeYygYoHsc18OYuSlb51hUqYyv26NimOsYhB
         RdL/Zo/joV5orp08RtQ1elMtAqiuKwkSWPDWhRozn5n5hQ5X3zjnaHtGT/RwgVn2XYEx
         0cKmJCPUOX53HpJ04uxl7CMsb7PC1Qwo9aNfzQLdJwAwmdFotpqnpWbtY7ioMEY1UMgX
         3tCeSbBXvPIOWqMiqjw9OAWugvaLf6UyFdt0HoMmQPxUq3LOkkslKqo+5vnj3rVFrvsi
         eHG1sbpFZmty4Dhkm+QH0TxBC7MSHSJPKQMmcOmv59lc/x3lIH9L1H9ejkx1ws3I8piM
         ZTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z8ED2nVqG+CIBH/41XUU1eRMBty2La0wKU2T8/KOQQE=;
        b=ixXB+Essm6eTWvAR97b231kQOh1xaKTBF3UCxqv6htnLoMx2r7Bni0J+DXC3aO2XiB
         fHK7a0FO2YoxESR7Lm63k4CxEMURE6TXwpXs/tvWt7pk/5mVeNsywDFjlqsLRnYo2OqW
         o4rEH9YLnSw5qJaCqrwq1tTfP88uK74JlbGmQkR/p1gBEu0zu/o63QRryym9+KjOf1zT
         j4xxQICHPXhrWUZu6TYUunDat2OyVDHxageq2cROnlCr+Ud7h1/jqQCxV7DpiqtMiB+l
         E3Rf+NQJXct56KHzdoKrhWfFCt4GmjwN9Dh6QlIkiXo3/SVXtZVCevOx5qYz395GPuhC
         MabA==
X-Gm-Message-State: AOAM532KlcVweUnxUFt70I/NWvondi/GSyIxiOYUWkrUFN3D3Wxg2hWl
        L8SMoYVqKzWdf1T52HBzMrRXbA==
X-Google-Smtp-Source: ABdhPJzx9Z9kDDROFnXOfbhTri333C0IO4IyPJwyWfPzpzNhmK2fTUo98DrUABWD49uscLpz1l53Eg==
X-Received: by 2002:a63:b06:: with SMTP id 6mr19931561pgl.116.1593620067010;
        Wed, 01 Jul 2020 09:14:27 -0700 (PDT)
Received: from localhost ([103.208.69.31])
        by smtp.gmail.com with ESMTPSA id my9sm5864044pjb.44.2020.07.01.09.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 09:14:26 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH] thermal: Remove clock_cooling code
Date:   Wed,  1 Jul 2020 21:44:14 +0530
Message-Id: <aa5d5ac2589cf7b14ece882130731b4a916849a6.1593619943.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

clock_cooling has no in-kernel users. It has never found any use in
drivers as far as I can tell.

Remove the code.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/Kconfig         |  10 -
 drivers/thermal/Makefile        |   3 -
 drivers/thermal/clock_cooling.c | 445 --------------------------------
 include/linux/clock_cooling.h   |  57 ----
 4 files changed, 515 deletions(-)
 delete mode 100644 drivers/thermal/clock_cooling.c
 delete mode 100644 include/linux/clock_cooling.h

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 3eb2348e52427..b2250d3be9e18 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -180,16 +180,6 @@ config CPU_IDLE_THERMAL
 	  idle cycle.
 endif
 
-config CLOCK_THERMAL
-	bool "Generic clock cooling support"
-	depends on COMMON_CLK
-	depends on PM_OPP
-	help
-	  This entry implements the generic clock cooling mechanism through
-	  frequency clipping. Typically used to cool off co-processors. The
-	  device that is configured to use this cooling mechanism will be
-	  controlled to reduce clock frequency whenever temperature is high.
-
 config DEVFREQ_THERMAL
 	bool "Generic device cooling support"
 	depends on PM_DEVFREQ
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 0c8b84a09b9aa..11c1768b12273 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -22,9 +22,6 @@ thermal_sys-$(CONFIG_THERMAL_GOV_POWER_ALLOCATOR)	+= gov_power_allocator.o
 thermal_sys-$(CONFIG_CPU_FREQ_THERMAL)	+= cpufreq_cooling.o
 thermal_sys-$(CONFIG_CPU_IDLE_THERMAL)	+= cpuidle_cooling.o
 
-# clock cooling
-thermal_sys-$(CONFIG_CLOCK_THERMAL)	+= clock_cooling.o
-
 # devfreq cooling
 thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
 
diff --git a/drivers/thermal/clock_cooling.c b/drivers/thermal/clock_cooling.c
deleted file mode 100644
index 56cb1f46a428e..0000000000000
--- a/drivers/thermal/clock_cooling.c
+++ /dev/null
@@ -1,445 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- *  drivers/thermal/clock_cooling.c
- *
- *  Copyright (C) 2014 Eduardo Valentin <edubezval@gmail.com>
- *
- *  Copyright (C) 2013	Texas Instruments Inc.
- *  Contact:  Eduardo Valentin <eduardo.valentin@ti.com>
- *
- *  Highly based on cpufreq_cooling.c.
- *  Copyright (C) 2012	Samsung Electronics Co., Ltd(http://www.samsung.com)
- *  Copyright (C) 2012  Amit Daniel <amit.kachhap@linaro.org>
- */
-#include <linux/clk.h>
-#include <linux/clock_cooling.h>
-#include <linux/cpufreq.h>
-#include <linux/device.h>
-#include <linux/err.h>
-#include <linux/export.h>
-#include <linux/idr.h>
-#include <linux/mutex.h>
-#include <linux/pm_opp.h>
-#include <linux/slab.h>
-#include <linux/thermal.h>
-
-/**
- * struct clock_cooling_device - data for cooling device with clock
- * @id: unique integer value corresponding to each clock_cooling_device
- *	registered.
- * @dev: struct device pointer to the device being used to cool off using
- *       clock frequencies.
- * @cdev: thermal_cooling_device pointer to keep track of the
- *	registered cooling device.
- * @clk_rate_change_nb: reference to notifier block used to receive clock
- *                      rate changes.
- * @freq_table: frequency table used to keep track of available frequencies.
- * @clock_state: integer value representing the current state of clock
- *	cooling	devices.
- * @clock_val: integer value representing the absolute value of the clipped
- *	frequency.
- * @clk: struct clk reference used to enforce clock limits.
- * @lock: mutex lock to protect this struct.
- *
- * This structure is required for keeping information of each
- * clock_cooling_device registered. In order to prevent corruption of this a
- * mutex @lock is used.
- */
-struct clock_cooling_device {
-	int id;
-	struct device *dev;
-	struct thermal_cooling_device *cdev;
-	struct notifier_block clk_rate_change_nb;
-	struct cpufreq_frequency_table *freq_table;
-	unsigned long clock_state;
-	unsigned long clock_val;
-	struct clk *clk;
-	struct mutex lock; /* lock to protect the content of this struct */
-};
-#define to_clock_cooling_device(x) \
-		container_of(x, struct clock_cooling_device, clk_rate_change_nb)
-static DEFINE_IDA(clock_ida);
-
-/* Below code defines functions to be used for clock as cooling device */
-
-enum clock_cooling_property {
-	GET_LEVEL,
-	GET_FREQ,
-	GET_MAXL,
-};
-
-/**
- * clock_cooling_get_property - fetch a property of interest for a give cpu.
- * @ccdev: clock cooling device reference
- * @input: query parameter
- * @output: query return
- * @property: type of query (frequency, level, max level)
- *
- * This is the common function to
- * 1. get maximum clock cooling states
- * 2. translate frequency to cooling state
- * 3. translate cooling state to frequency
- * Note that the code may be not in good shape
- * but it is written in this way in order to:
- * a) reduce duplicate code as most of the code can be shared.
- * b) make sure the logic is consistent when translating between
- *    cooling states and frequencies.
- *
- * Return: 0 on success, -EINVAL when invalid parameters are passed.
- */
-static int clock_cooling_get_property(struct clock_cooling_device *ccdev,
-				      unsigned long input,
-				      unsigned long *output,
-				      enum clock_cooling_property property)
-{
-	int i;
-	unsigned long max_level = 0, level = 0;
-	unsigned int freq = CPUFREQ_ENTRY_INVALID;
-	int descend = -1;
-	struct cpufreq_frequency_table *pos, *table = ccdev->freq_table;
-
-	if (!output)
-		return -EINVAL;
-
-	if (!table)
-		return -EINVAL;
-
-	cpufreq_for_each_valid_entry(pos, table) {
-		/* ignore duplicate entry */
-		if (freq == pos->frequency)
-			continue;
-
-		/* get the frequency order */
-		if (freq != CPUFREQ_ENTRY_INVALID && descend == -1)
-			descend = freq > pos->frequency;
-
-		freq = pos->frequency;
-		max_level++;
-	}
-
-	/* No valid cpu frequency entry */
-	if (max_level == 0)
-		return -EINVAL;
-
-	/* max_level is an index, not a counter */
-	max_level--;
-
-	/* get max level */
-	if (property == GET_MAXL) {
-		*output = max_level;
-		return 0;
-	}
-
-	if (property == GET_FREQ)
-		level = descend ? input : (max_level - input);
-
-	i = 0;
-	cpufreq_for_each_valid_entry(pos, table) {
-		/* ignore duplicate entry */
-		if (freq == pos->frequency)
-			continue;
-
-		/* now we have a valid frequency entry */
-		freq = pos->frequency;
-
-		if (property == GET_LEVEL && (unsigned int)input == freq) {
-			/* get level by frequency */
-			*output = descend ? i : (max_level - i);
-			return 0;
-		}
-		if (property == GET_FREQ && level == i) {
-			/* get frequency by level */
-			*output = freq;
-			return 0;
-		}
-		i++;
-	}
-
-	return -EINVAL;
-}
-
-/**
- * clock_cooling_get_level - return the cooling level of given clock cooling.
- * @cdev: reference of a thermal cooling device of used as clock cooling device
- * @freq: the frequency of interest
- *
- * This function will match the cooling level corresponding to the
- * requested @freq and return it.
- *
- * Return: The matched cooling level on success or THERMAL_CSTATE_INVALID
- * otherwise.
- */
-unsigned long clock_cooling_get_level(struct thermal_cooling_device *cdev,
-				      unsigned long freq)
-{
-	struct clock_cooling_device *ccdev = cdev->devdata;
-	unsigned long val;
-
-	if (clock_cooling_get_property(ccdev, (unsigned long)freq, &val,
-				       GET_LEVEL))
-		return THERMAL_CSTATE_INVALID;
-
-	return val;
-}
-EXPORT_SYMBOL_GPL(clock_cooling_get_level);
-
-/**
- * clock_cooling_get_frequency - get the absolute value of frequency from level.
- * @ccdev: clock cooling device reference
- * @level: cooling level
- *
- * This function matches cooling level with frequency. Based on a cooling level
- * of frequency, equals cooling state of cpu cooling device, it will return
- * the corresponding frequency.
- *	e.g level=0 --> 1st MAX FREQ, level=1 ---> 2nd MAX FREQ, .... etc
- *
- * Return: 0 on error, the corresponding frequency otherwise.
- */
-static unsigned long
-clock_cooling_get_frequency(struct clock_cooling_device *ccdev,
-			    unsigned long level)
-{
-	int ret = 0;
-	unsigned long freq;
-
-	ret = clock_cooling_get_property(ccdev, level, &freq, GET_FREQ);
-	if (ret)
-		return 0;
-
-	return freq;
-}
-
-/**
- * clock_cooling_apply - function to apply frequency clipping.
- * @ccdev: clock_cooling_device pointer containing frequency clipping data.
- * @cooling_state: value of the cooling state.
- *
- * Function used to make sure the clock layer is aware of current thermal
- * limits. The limits are applied by updating the clock rate in case it is
- * higher than the corresponding frequency based on the requested cooling_state.
- *
- * Return: 0 on success, an error code otherwise (-EINVAL in case wrong
- * cooling state).
- */
-static int clock_cooling_apply(struct clock_cooling_device *ccdev,
-			       unsigned long cooling_state)
-{
-	unsigned long clip_freq, cur_freq;
-	int ret = 0;
-
-	/* Here we write the clipping */
-	/* Check if the old cooling action is same as new cooling action */
-	if (ccdev->clock_state == cooling_state)
-		return 0;
-
-	clip_freq = clock_cooling_get_frequency(ccdev, cooling_state);
-	if (!clip_freq)
-		return -EINVAL;
-
-	cur_freq = clk_get_rate(ccdev->clk);
-
-	mutex_lock(&ccdev->lock);
-	ccdev->clock_state = cooling_state;
-	ccdev->clock_val = clip_freq;
-	/* enforce clock level */
-	if (cur_freq > clip_freq)
-		ret = clk_set_rate(ccdev->clk, clip_freq);
-	mutex_unlock(&ccdev->lock);
-
-	return ret;
-}
-
-/**
- * clock_cooling_clock_notifier - notifier callback on clock rate changes.
- * @nb:	struct notifier_block * with callback info.
- * @event: value showing clock event for which this function invoked.
- * @data: callback-specific data
- *
- * Callback to hijack the notification on clock transition.
- * Every time there is a clock change, we intercept all pre change events
- * and block the transition in case the new rate infringes thermal limits.
- *
- * Return: NOTIFY_DONE (success) or NOTIFY_BAD (new_rate > thermal limit).
- */
-static int clock_cooling_clock_notifier(struct notifier_block *nb,
-					unsigned long event, void *data)
-{
-	struct clk_notifier_data *ndata = data;
-	struct clock_cooling_device *ccdev = to_clock_cooling_device(nb);
-
-	switch (event) {
-	case PRE_RATE_CHANGE:
-		/*
-		 * checks on current state
-		 * TODO: current method is not best we can find as it
-		 * allows possibly voltage transitions, in case DVFS
-		 * layer is also hijacking clock pre notifications.
-		 */
-		if (ndata->new_rate > ccdev->clock_val)
-			return NOTIFY_BAD;
-		/* fall through */
-	case POST_RATE_CHANGE:
-	case ABORT_RATE_CHANGE:
-	default:
-		return NOTIFY_DONE;
-	}
-}
-
-/* clock cooling device thermal callback functions are defined below */
-
-/**
- * clock_cooling_get_max_state - callback function to get the max cooling state.
- * @cdev: thermal cooling device pointer.
- * @state: fill this variable with the max cooling state.
- *
- * Callback for the thermal cooling device to return the clock
- * max cooling state.
- *
- * Return: 0 on success, an error code otherwise.
- */
-static int clock_cooling_get_max_state(struct thermal_cooling_device *cdev,
-				       unsigned long *state)
-{
-	struct clock_cooling_device *ccdev = cdev->devdata;
-	unsigned long count = 0;
-	int ret;
-
-	ret = clock_cooling_get_property(ccdev, 0, &count, GET_MAXL);
-	if (!ret)
-		*state = count;
-
-	return ret;
-}
-
-/**
- * clock_cooling_get_cur_state - function to get the current cooling state.
- * @cdev: thermal cooling device pointer.
- * @state: fill this variable with the current cooling state.
- *
- * Callback for the thermal cooling device to return the clock
- * current cooling state.
- *
- * Return: 0 (success)
- */
-static int clock_cooling_get_cur_state(struct thermal_cooling_device *cdev,
-				       unsigned long *state)
-{
-	struct clock_cooling_device *ccdev = cdev->devdata;
-
-	*state = ccdev->clock_state;
-
-	return 0;
-}
-
-/**
- * clock_cooling_set_cur_state - function to set the current cooling state.
- * @cdev: thermal cooling device pointer.
- * @state: set this variable to the current cooling state.
- *
- * Callback for the thermal cooling device to change the clock cooling
- * current cooling state.
- *
- * Return: 0 on success, an error code otherwise.
- */
-static int clock_cooling_set_cur_state(struct thermal_cooling_device *cdev,
-				       unsigned long state)
-{
-	struct clock_cooling_device *clock_device = cdev->devdata;
-
-	return clock_cooling_apply(clock_device, state);
-}
-
-/* Bind clock callbacks to thermal cooling device ops */
-static struct thermal_cooling_device_ops const clock_cooling_ops = {
-	.get_max_state = clock_cooling_get_max_state,
-	.get_cur_state = clock_cooling_get_cur_state,
-	.set_cur_state = clock_cooling_set_cur_state,
-};
-
-/**
- * clock_cooling_register - function to create clock cooling device.
- * @dev: struct device pointer to the device used as clock cooling device.
- * @clock_name: string containing the clock used as cooling mechanism.
- *
- * This interface function registers the clock cooling device with the name
- * "thermal-clock-%x". The cooling device is based on clock frequencies.
- * The struct device is assumed to be capable of DVFS transitions.
- * The OPP layer is used to fetch and fill the available frequencies for
- * the referred device. The ordered frequency table is used to control
- * the clock cooling device cooling states and to limit clock transitions
- * based on the cooling state requested by the thermal framework.
- *
- * Return: a valid struct thermal_cooling_device pointer on success,
- * on failure, it returns a corresponding ERR_PTR().
- */
-struct thermal_cooling_device *
-clock_cooling_register(struct device *dev, const char *clock_name)
-{
-	struct thermal_cooling_device *cdev;
-	struct clock_cooling_device *ccdev = NULL;
-	char dev_name[THERMAL_NAME_LENGTH];
-	int ret = 0;
-
-	ccdev = devm_kzalloc(dev, sizeof(*ccdev), GFP_KERNEL);
-	if (!ccdev)
-		return ERR_PTR(-ENOMEM);
-
-	mutex_init(&ccdev->lock);
-	ccdev->dev = dev;
-	ccdev->clk = devm_clk_get(dev, clock_name);
-	if (IS_ERR(ccdev->clk))
-		return ERR_CAST(ccdev->clk);
-
-	ret = ida_simple_get(&clock_ida, 0, 0, GFP_KERNEL);
-	if (ret < 0)
-		return ERR_PTR(ret);
-	ccdev->id = ret;
-
-	snprintf(dev_name, sizeof(dev_name), "thermal-clock-%d", ccdev->id);
-
-	cdev = thermal_cooling_device_register(dev_name, ccdev,
-					       &clock_cooling_ops);
-	if (IS_ERR(cdev)) {
-		ida_simple_remove(&clock_ida, ccdev->id);
-		return ERR_PTR(-EINVAL);
-	}
-	ccdev->cdev = cdev;
-	ccdev->clk_rate_change_nb.notifier_call = clock_cooling_clock_notifier;
-
-	/* Assuming someone has already filled the opp table for this device */
-	ret = dev_pm_opp_init_cpufreq_table(dev, &ccdev->freq_table);
-	if (ret) {
-		ida_simple_remove(&clock_ida, ccdev->id);
-		return ERR_PTR(ret);
-	}
-	ccdev->clock_state = 0;
-	ccdev->clock_val = clock_cooling_get_frequency(ccdev, 0);
-
-	clk_notifier_register(ccdev->clk, &ccdev->clk_rate_change_nb);
-
-	return cdev;
-}
-EXPORT_SYMBOL_GPL(clock_cooling_register);
-
-/**
- * clock_cooling_unregister - function to remove clock cooling device.
- * @cdev: thermal cooling device pointer.
- *
- * This interface function unregisters the "thermal-clock-%x" cooling device.
- */
-void clock_cooling_unregister(struct thermal_cooling_device *cdev)
-{
-	struct clock_cooling_device *ccdev;
-
-	if (!cdev)
-		return;
-
-	ccdev = cdev->devdata;
-
-	clk_notifier_unregister(ccdev->clk, &ccdev->clk_rate_change_nb);
-	dev_pm_opp_free_cpufreq_table(ccdev->dev, &ccdev->freq_table);
-
-	thermal_cooling_device_unregister(ccdev->cdev);
-	ida_simple_remove(&clock_ida, ccdev->id);
-}
-EXPORT_SYMBOL_GPL(clock_cooling_unregister);
diff --git a/include/linux/clock_cooling.h b/include/linux/clock_cooling.h
deleted file mode 100644
index 4b0a69863656c..0000000000000
--- a/include/linux/clock_cooling.h
+++ /dev/null
@@ -1,57 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- *  linux/include/linux/clock_cooling.h
- *
- *  Copyright (C) 2014 Eduardo Valentin <edubezval@gmail.com>
- *
- *  Copyright (C) 2013	Texas Instruments Inc.
- *  Contact:  Eduardo Valentin <eduardo.valentin@ti.com>
- *
- *  Highly based on cpufreq_cooling.c.
- *  Copyright (C) 2012	Samsung Electronics Co., Ltd(http://www.samsung.com)
- *  Copyright (C) 2012  Amit Daniel <amit.kachhap@linaro.org>
- */
-
-#ifndef __CPU_COOLING_H__
-#define __CPU_COOLING_H__
-
-#include <linux/of.h>
-#include <linux/thermal.h>
-#include <linux/cpumask.h>
-
-#ifdef CONFIG_CLOCK_THERMAL
-/**
- * clock_cooling_register - function to create clock cooling device.
- * @dev: struct device pointer to the device used as clock cooling device.
- * @clock_name: string containing the clock used as cooling mechanism.
- */
-struct thermal_cooling_device *
-clock_cooling_register(struct device *dev, const char *clock_name);
-
-/**
- * clock_cooling_unregister - function to remove clock cooling device.
- * @cdev: thermal cooling device pointer.
- */
-void clock_cooling_unregister(struct thermal_cooling_device *cdev);
-
-unsigned long clock_cooling_get_level(struct thermal_cooling_device *cdev,
-				      unsigned long freq);
-#else /* !CONFIG_CLOCK_THERMAL */
-static inline struct thermal_cooling_device *
-clock_cooling_register(struct device *dev, const char *clock_name)
-{
-	return NULL;
-}
-static inline
-void clock_cooling_unregister(struct thermal_cooling_device *cdev)
-{
-}
-static inline
-unsigned long clock_cooling_get_level(struct thermal_cooling_device *cdev,
-				      unsigned long freq)
-{
-	return THERMAL_CSTATE_INVALID;
-}
-#endif	/* CONFIG_CLOCK_THERMAL */
-
-#endif /* __CPU_COOLING_H__ */
-- 
2.25.1

