Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8019584360
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 17:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiG1PmH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 11:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiG1PmG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 11:42:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC97D69F26
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 08:42:04 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:42:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659022923;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iPrsEICSuUSQ1FqJcfxN2BtxSd2U4YCPEleD51MuSA4=;
        b=V2uE/W9V1O96vGOQi3JhpFYwmpdCTEYSEtzqSWFGeWuKVzs9qkNecMbmYxjWuKM0dNtXUL
        HuTeUBGzWJVi8GLXkgJaQbzBY8sYbUSTKylrkjpIkw8MPZGIi1pW8Arbb90cET1cidJjnX
        jsV//Mgm0tWe5N5UnS+OlEQFSGIMSpUV04XevzJPXyFsafTabjOD23wU3s/mcSojCPEbEI
        eLSqidbDCzi5bxJu0ASJP0BNlOlHBCMajuzhXboAaB6fNAXPNytCJq2tkJMAQGTw6W91Ee
        pk8wL1OPGs0L2vyUGVdP/tUeoET+aWQBi9/mZHfZqyenweHD0wc+iNr4HsX/Ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659022923;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iPrsEICSuUSQ1FqJcfxN2BtxSd2U4YCPEleD51MuSA4=;
        b=JeX0iWkTfws1RCINgMHAr2gII6ouHUxRdca2hrH5V6Ng/k7nDQzywNXN3w6owDub+JP2kg
        RXHGzXQhdC1+5IBA==
From:   "thermal-bot for Lukasz Luba" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] drivers/thermal/cpufreq_cooling: Update
 outdated comments
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220613124327.30766-4-lukasz.luba@arm.com>
References: <20220613124327.30766-4-lukasz.luba@arm.com>
MIME-Version: 1.0
Message-ID: <165902292216.15455.11562519755936909394.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     9784d2fbb858ec0dd8d0032293aa06fa736d6ea2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//9784d2fbb858ec0dd8d0032293aa06fa736d6ea2
Author:        Lukasz Luba <lukasz.luba@arm.com>
AuthorDate:    Mon, 13 Jun 2022 13:43:26 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 28 Jul 2022 17:29:42 +02:00

drivers/thermal/cpufreq_cooling: Update outdated comments

The code has moved and left some comments stale. Update them where
there is a need.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://lore.kernel.org/r/20220613124327.30766-4-lukasz.luba@arm.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/cpufreq_cooling.c | 44 ++++++++++++------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index 492a67e..50f8b90 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -206,7 +206,7 @@ static u32 get_dynamic_power(struct cpufreq_cooling_device *cpufreq_cdev,
  * complex code may be needed if experiments show that it's not
  * accurate enough.
  *
- * Return: 0 on success, -E* if getting the static power failed.
+ * Return: 0 on success, this function doesn't fail.
  */
 static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 				       u32 *power)
@@ -249,9 +249,8 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
  * milliwatts assuming 100% load.  Store the calculated power in
  * @power.
  *
- * Return: 0 on success, -EINVAL if the cooling device state could not
- * be converted into a frequency or other -E* if there was an error
- * when calculating the static power.
+ * Return: 0 on success, -EINVAL if the cooling device state is bigger
+ * than maximum allowed.
  */
 static int cpufreq_state2power(struct thermal_cooling_device *cdev,
 			       unsigned long state, u32 *power)
@@ -281,15 +280,11 @@ static int cpufreq_state2power(struct thermal_cooling_device *cdev,
  * Calculate a cooling device state for the cpus described by @cdev
  * that would allow them to consume at most @power mW and store it in
  * @state.  Note that this calculation depends on external factors
- * such as the cpu load or the current static power.  Calling this
- * function with the same power as input can yield different cooling
- * device states depending on those external factors.
- *
- * Return: 0 on success, -ENODEV if no cpus are online or -EINVAL if
- * the calculated frequency could not be converted to a valid state.
- * The latter should not happen unless the frequencies available to
- * cpufreq have changed since the initialization of the cpu cooling
- * device.
+ * such as the CPUs load.  Calling this function with the same power
+ * as input can yield different cooling device states depending on those
+ * external factors.
+ *
+ * Return: 0 on success, this function doesn't fail.
  */
 static int cpufreq_power2state(struct thermal_cooling_device *cdev,
 			       u32 power, unsigned long *state)
@@ -401,7 +396,7 @@ static unsigned int get_state_freq(struct cpufreq_cooling_device *cpufreq_cdev,
  * Callback for the thermal cooling device to return the cpufreq
  * max cooling state.
  *
- * Return: 0 on success, an error code otherwise.
+ * Return: 0 on success, this function doesn't fail.
  */
 static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
 				 unsigned long *state)
@@ -420,7 +415,7 @@ static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
  * Callback for the thermal cooling device to return the cpufreq
  * current cooling state.
  *
- * Return: 0 on success, an error code otherwise.
+ * Return: 0 on success, this function doesn't fail.
  */
 static int cpufreq_get_cur_state(struct thermal_cooling_device *cdev,
 				 unsigned long *state)
@@ -479,7 +474,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
  * @em: Energy Model of the cpufreq policy
  *
  * This interface function registers the cpufreq cooling device with the name
- * "thermal-cpufreq-%x". This api can support multiple instances of cpufreq
+ * "cpufreq-%s". This API can support multiple instances of cpufreq
  * cooling devices. It also gives the opportunity to link the cooling device
  * with a device tree node, in order to bind it via the thermal DT code.
  *
@@ -590,8 +585,8 @@ free_cdev:
  * @policy: cpufreq policy
  *
  * This interface function registers the cpufreq cooling device with the name
- * "thermal-cpufreq-%x". This api can support multiple instances of cpufreq
- * cooling devices.
+ * "cpufreq-%s". This API can support multiple instances of cpufreq cooling
+ * devices.
  *
  * Return: a valid struct thermal_cooling_device pointer on success,
  * on failure, it returns a corresponding ERR_PTR().
@@ -608,17 +603,14 @@ EXPORT_SYMBOL_GPL(cpufreq_cooling_register);
  * @policy: cpufreq policy
  *
  * This interface function registers the cpufreq cooling device with the name
- * "thermal-cpufreq-%x". This api can support multiple instances of cpufreq
- * cooling devices. Using this API, the cpufreq cooling device will be
- * linked to the device tree node provided.
+ * "cpufreq-%s". This API can support multiple instances of cpufreq cooling
+ * devices. Using this API, the cpufreq cooling device will be linked to the
+ * device tree node provided.
  *
  * Using this function, the cooling device will implement the power
- * extensions by using a simple cpu power model.  The cpus must have
+ * extensions by using the Energy Model (if present).  The cpus must have
  * registered their OPPs using the OPP library.
  *
- * It also takes into account, if property present in policy CPU node, the
- * static power consumed by the cpu.
- *
  * Return: a valid struct thermal_cooling_device pointer on success,
  * and NULL on failure.
  */
@@ -654,7 +646,7 @@ EXPORT_SYMBOL_GPL(of_cpufreq_cooling_register);
  * cpufreq_cooling_unregister - function to remove cpufreq cooling device.
  * @cdev: thermal cooling device pointer.
  *
- * This interface function unregisters the "thermal-cpufreq-%x" cooling device.
+ * This interface function unregisters the "cpufreq-%x" cooling device.
  */
 void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 {
