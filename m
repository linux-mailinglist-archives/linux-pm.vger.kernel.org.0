Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B752D9A2F
	for <lists+linux-pm@lfdr.de>; Mon, 14 Dec 2020 15:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438638AbgLNOlN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Dec 2020 09:41:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51732 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408240AbgLNOlJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2020 09:41:09 -0500
Date:   Mon, 14 Dec 2020 14:40:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607956820;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zll1JrFzVPd0X1EtartQXMS5ND/iMzJHsJDnm2GspOo=;
        b=Tuc2QHrB2CsucEBt0LAWNz8A8bDudPag3EWdUaWZSKRHPXZsZbMsAfWqcLtZU440hu6Ach
        TeXlE1zdy7FfNwboQV0xKmvQt+4Hipfzvuqs3ovdX9NK0rpjxnwg1tJpapfgDWdDcEbXLf
        CICSV3vDUsCe0bL7IRM9ovzpWfVyDlqk6hFvwwQ4lznzMB/7fUCQzGd446Um4p6ll+vFUq
        6xlxe54VM0J6ReDIbjVXVgUcikta3ikIFrJtMndker/jbtpykvSdPF3ozNKYHykSfgkTim
        3cTZziBh2U5ZNBjQT0Buqfq0IopDuODEALHLGBv2ZMUFbJ7LJX86xcGjRBCyow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607956820;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zll1JrFzVPd0X1EtartQXMS5ND/iMzJHsJDnm2GspOo=;
        b=gQ779mYT6wyD5Nxd1ePQZKk5vZUcREbCQLrtVZmPPHheVWqYKA/4nRkzmUCBRCV/XYXMdE
        pmBV0A4QuyqQrlAg==
From:   "thermal-bot for Lukasz Luba" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: devfreq_cooling: use a copy of device status
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201210143014.24685-3-lukasz.luba@arm.com>
References: <20201210143014.24685-3-lukasz.luba@arm.com>
MIME-Version: 1.0
Message-ID: <160795682015.3364.4630493531438293478.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     229794eee27fddbedd03be5f8b20375a2637ff48
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//229794eee27fddbedd03be5f8b20375a2637ff48
Author:        Lukasz Luba <lukasz.luba@arm.com>
AuthorDate:    Thu, 10 Dec 2020 14:30:11 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 11 Dec 2020 14:10:44 +01:00

thermal: devfreq_cooling: use a copy of device status

Devfreq cooling needs to now the correct status of the device in order
to operate. Devfreq framework can change the device status in the
background. To mitigate issues make a copy of the status structure and use
it for internal calculations.

In addition this patch adds normalization function, which also makes sure
that whatever data comes from the device, the load will be in range from 1
to 1024.

Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201210143014.24685-3-lukasz.luba@arm.com
---
 drivers/thermal/devfreq_cooling.c | 47 +++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 659c014..afcebad 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -227,20 +227,39 @@ static inline unsigned long get_total_power(struct devfreq_cooling_device *dfc,
 							       voltage);
 }
 
+static void _normalize_load(struct devfreq_dev_status *status)
+{
+	if (status->total_time > 0xfffff) {
+		status->total_time >>= 10;
+		status->busy_time >>= 10;
+	}
+
+	status->busy_time <<= 10;
+	status->busy_time /= status->total_time ? : 1;
+
+	status->busy_time = status->busy_time ? : 1;
+	status->total_time = 1024;
+}
 
 static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cdev,
 					       u32 *power)
 {
 	struct devfreq_cooling_device *dfc = cdev->devdata;
 	struct devfreq *df = dfc->devfreq;
-	struct devfreq_dev_status *status = &df->last_status;
+	struct devfreq_dev_status status;
 	unsigned long state;
-	unsigned long freq = status->current_frequency;
+	unsigned long freq;
 	unsigned long voltage;
 	u32 dyn_power = 0;
 	u32 static_power = 0;
 	int res;
 
+	mutex_lock(&df->lock);
+	status = df->last_status;
+	mutex_unlock(&df->lock);
+
+	freq = status.current_frequency;
+
 	state = freq_get_state(dfc, freq);
 	if (state == THERMAL_CSTATE_INVALID) {
 		res = -EAGAIN;
@@ -268,16 +287,18 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
 	} else {
 		dyn_power = dfc->power_table[state];
 
+		_normalize_load(&status);
+
 		/* Scale dynamic power for utilization */
-		dyn_power *= status->busy_time;
-		dyn_power /= status->total_time;
+		dyn_power *= status.busy_time;
+		dyn_power >>= 10;
 		/* Get static power */
 		static_power = get_static_power(dfc, freq);
 
 		*power = dyn_power + static_power;
 	}
 
-	trace_thermal_power_devfreq_get_power(cdev, status, freq, *power);
+	trace_thermal_power_devfreq_get_power(cdev, &status, freq, *power);
 
 	return 0;
 fail:
@@ -309,14 +330,19 @@ static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
 {
 	struct devfreq_cooling_device *dfc = cdev->devdata;
 	struct devfreq *df = dfc->devfreq;
-	struct devfreq_dev_status *status = &df->last_status;
-	unsigned long freq = status->current_frequency;
-	unsigned long busy_time;
+	struct devfreq_dev_status status;
+	unsigned long freq;
 	s32 dyn_power;
 	u32 static_power;
 	s32 est_power;
 	int i;
 
+	mutex_lock(&df->lock);
+	status = df->last_status;
+	mutex_unlock(&df->lock);
+
+	freq = status.current_frequency;
+
 	if (dfc->power_ops->get_real_power) {
 		/* Scale for resource utilization */
 		est_power = power * dfc->res_util;
@@ -328,8 +354,9 @@ static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
 		dyn_power = dyn_power > 0 ? dyn_power : 0;
 
 		/* Scale dynamic power for utilization */
-		busy_time = status->busy_time ?: 1;
-		est_power = (dyn_power * status->total_time) / busy_time;
+		_normalize_load(&status);
+		dyn_power <<= 10;
+		est_power = dyn_power / status.busy_time;
 	}
 
 	/*
