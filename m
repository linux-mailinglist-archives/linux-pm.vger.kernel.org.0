Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64882DB387
	for <lists+linux-pm@lfdr.de>; Tue, 15 Dec 2020 19:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbgLOSSn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Dec 2020 13:18:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34066 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731267AbgLOSSc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2020 13:18:32 -0500
Date:   Tue, 15 Dec 2020 18:17:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608056269;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kXDy539pXtHksIpw/N+m/mifNPf8EMo6Aecqkl85Ljo=;
        b=L4zz5VLjxH++fNbjnExUWfk/qyW8wkBZjUJVVdI1qT8SFpjsRcyEm0OxDbP+/b2ax2K+Gn
        U+9DlvtTnBUL+hl946Dz93Zh/hraapy9h/d7QvEJDJxBsGWX50mrchNd7qBk7YyMUwAjR3
        Oa7OqTmy2HJbKzGOffGs9YD4P/B7diwGj7CYOobPd+UW/yCJJx0i5nZ7VZzEPQsAmUw+8x
        SZ+uXUeDoX3I2UgRBaSZDgQdp/89KEsWIG6vvHEXQb79LVlIvEtDD1iA3jnF0ncbEZkvD7
        xIG0+tuXa9iwJ27bLgH15th42Ak+xhn4hV7EX1lIODU7zNzzr39k84+VQEIwgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608056269;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kXDy539pXtHksIpw/N+m/mifNPf8EMo6Aecqkl85Ljo=;
        b=Yk+G7SBiW5XoRt9GiLuWWuZAegYQOJfiZHw+Isb4mVLwfAOQswNYQL8ktpMuLuKysIGxRM
        AabTOXiJRJ0puvDw==
From:   "thermal-bot for Lukasz Luba" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/devfreq_cooling: Fix the
 build when !ENERGY_MODEL
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201215154221.8828-1-lukasz.luba@arm.com>
References: <20201215154221.8828-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Message-ID: <160805626872.3364.15974921110804156050.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     4401117bf7fc11dc738c0963fa0c94814abc8dcd
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//4401117bf7fc11dc738c0963fa0c94814abc8dcd
Author:        Lukasz Luba <lukasz.luba@arm.com>
AuthorDate:    Tue, 15 Dec 2020 15:42:21 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 15 Dec 2020 17:03:56 +01:00

thermal/drivers/devfreq_cooling: Fix the build when !ENERGY_MODEL

Prevent build failure if the option CONFIG_ENERGY_MODEL is not set. The
devfreq cooling is able to operate without the Energy Model.
Don't use dev->em_pd directly and use local pointer.

Fixes: 615510fe13bd2 ("thermal: devfreq_cooling: remove old power model and use EM")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201215154221.8828-1-lukasz.luba@arm.com
---
 drivers/thermal/devfreq_cooling.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index df1049a..fed3121 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -48,6 +48,7 @@ static DEFINE_IDA(devfreq_ida);
  * @capped_state:	index to cooling state with in dynamic power budget
  * @req_max_freq:	PM QoS request for limiting the maximum frequency
  *			of the devfreq device.
+ * @em_pd:		Energy Model for the associated Devfreq device
  */
 struct devfreq_cooling_device {
 	int id;
@@ -60,6 +61,7 @@ struct devfreq_cooling_device {
 	u32 res_util;
 	int capped_state;
 	struct dev_pm_qos_request req_max_freq;
+	struct em_perf_domain *em_pd;
 };
 
 static int devfreq_cooling_get_max_state(struct thermal_cooling_device *cdev,
@@ -99,9 +101,9 @@ static int devfreq_cooling_set_cur_state(struct thermal_cooling_device *cdev,
 	if (state > dfc->max_state)
 		return -EINVAL;
 
-	if (dev->em_pd) {
+	if (dfc->em_pd) {
 		perf_idx = dfc->max_state - state;
-		freq = dev->em_pd->table[perf_idx].frequency * 1000;
+		freq = dfc->em_pd->table[perf_idx].frequency * 1000;
 	} else {
 		freq = dfc->freq_table[state];
 	}
@@ -181,7 +183,6 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
 {
 	struct devfreq_cooling_device *dfc = cdev->devdata;
 	struct devfreq *df = dfc->devfreq;
-	struct device *dev = df->dev.parent;
 	struct devfreq_dev_status status;
 	unsigned long state;
 	unsigned long freq;
@@ -204,7 +205,7 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
 		res = dfc->power_ops->get_real_power(df, power, freq, voltage);
 		if (!res) {
 			state = dfc->capped_state;
-			dfc->res_util = dev->em_pd->table[state].power;
+			dfc->res_util = dfc->em_pd->table[state].power;
 			dfc->res_util *= SCALE_ERROR_MITIGATION;
 
 			if (*power > 1)
@@ -214,7 +215,7 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
 		}
 	} else {
 		/* Energy Model frequencies are in kHz */
-		perf_idx = get_perf_idx(dev->em_pd, freq / 1000);
+		perf_idx = get_perf_idx(dfc->em_pd, freq / 1000);
 		if (perf_idx < 0) {
 			res = -EAGAIN;
 			goto fail;
@@ -223,7 +224,7 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
 		_normalize_load(&status);
 
 		/* Scale power for utilization */
-		*power = dev->em_pd->table[perf_idx].power;
+		*power = dfc->em_pd->table[perf_idx].power;
 		*power *= status.busy_time;
 		*power >>= 10;
 	}
@@ -241,15 +242,13 @@ static int devfreq_cooling_state2power(struct thermal_cooling_device *cdev,
 				       unsigned long state, u32 *power)
 {
 	struct devfreq_cooling_device *dfc = cdev->devdata;
-	struct devfreq *df = dfc->devfreq;
-	struct device *dev = df->dev.parent;
 	int perf_idx;
 
 	if (state > dfc->max_state)
 		return -EINVAL;
 
 	perf_idx = dfc->max_state - state;
-	*power = dev->em_pd->table[perf_idx].power;
+	*power = dfc->em_pd->table[perf_idx].power;
 
 	return 0;
 }
@@ -259,7 +258,6 @@ static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
 {
 	struct devfreq_cooling_device *dfc = cdev->devdata;
 	struct devfreq *df = dfc->devfreq;
-	struct device *dev = df->dev.parent;
 	struct devfreq_dev_status status;
 	unsigned long freq;
 	s32 est_power;
@@ -287,7 +285,7 @@ static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
 	 * budget. The EM power table is sorted ascending.
 	 */
 	for (i = dfc->max_state; i > 0; i--)
-		if (est_power >= dev->em_pd->table[i].power)
+		if (est_power >= dfc->em_pd->table[i].power)
 			break;
 
 	*state = dfc->max_state - i;
@@ -374,7 +372,8 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 
 	dfc->devfreq = df;
 
-	if (dev->em_pd) {
+	dfc->em_pd = em_pd_get(dev);
+	if (dfc->em_pd) {
 		devfreq_cooling_ops.get_requested_power =
 			devfreq_cooling_get_requested_power;
 		devfreq_cooling_ops.state2power = devfreq_cooling_state2power;
@@ -382,7 +381,7 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 
 		dfc->power_ops = dfc_power;
 
-		num_opps = em_pd_nr_perf_states(dev->em_pd);
+		num_opps = em_pd_nr_perf_states(dfc->em_pd);
 	} else {
 		/* Backward compatibility for drivers which do not use IPA */
 		dev_dbg(dev, "missing EM for cooling device\n");
