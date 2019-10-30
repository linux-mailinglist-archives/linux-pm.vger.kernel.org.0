Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 426E7E9EA3
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 16:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfJ3PPG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 11:15:06 -0400
Received: from mail-wm1-f73.google.com ([209.85.128.73]:58595 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfJ3PPF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 11:15:05 -0400
Received: by mail-wm1-f73.google.com with SMTP id g21so765256wmh.8
        for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2019 08:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=m3W2oGARPPMCHIp2PKS5ARTjfwy7pKB/hUfDT0hLOYc=;
        b=Dg00Ev7JgqHNFUTq3JByiGkwiULHuDmUpFRnS5o5Ei7Yx0tsMnIhgJugCuluOLS129
         lTfMs073Q6cpV+CY/E/jLOZP++PQOTZ4HrkU4NqthgzSeNXgzwT9we0oihOoGu/A33Fl
         YflrqNiNTF4FUjoiNnuPfPJprKk/oDeJOKGcnCqjFDXOtqIMN7SIF58Mal1xmUnEC2kg
         /wi++ANhRTULx1R+5t42i0sLbouO4fMRg5Nl+fPabZWl+FfDdOAXF0LyiUoWrDHBBers
         MgCZYLFztRsw0NI4TVEF0rvUc2g+UF/bvjOQWkRcOlhXbN0Kl9ReYRQzF+5MxSLc+DQs
         b3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=m3W2oGARPPMCHIp2PKS5ARTjfwy7pKB/hUfDT0hLOYc=;
        b=eRnUi0mam0iFaHO0bimEdqlrGn3GR2ad3gL7JB+1MMy1Tz01m4KCjOcXck1+5oED/I
         KswLsakasrTLfDAJ/hpPijgOTH2iHXPFuYHuu7UbAhA1KRjFCwbvTibjmxTKwPGK6kus
         knrzdyASSUHkE7eKmBlu3MlxESNY7JJv0l/vAYX+WjU3ukfSNWdQL9gkTtAhItE+ZsOj
         +X+54X0BxNSOq7/Fp33qfzQhpEKtFeDFbFyTpPQNT+Uhu++DULvAvCBMKp0x6Pe2DeXO
         GwwsxUIxltIBhq/GNYEXPlyspKlDc2JQ1xQjG/ThGEd7SeF8XHgb7z0culmCJUOhn0K9
         rJtg==
X-Gm-Message-State: APjAAAXxPALmWJ6NEjB7/JZM0Pyc1CXaGB3xmDh0BBrD8/H9ktqyxfLk
        uRfVp1oCvgoPmv7FUc+BIdcAaHpAlGic
X-Google-Smtp-Source: APXvYqzHm7+kyR5AaNndtjcpbglDxAQyp+X2DBzPerei0J0s7LQflNf+L+6zQV4QTV7lMqMM2cjp1mxq2Ee3
X-Received: by 2002:a5d:4f89:: with SMTP id d9mr365493wru.286.1572448502909;
 Wed, 30 Oct 2019 08:15:02 -0700 (PDT)
Date:   Wed, 30 Oct 2019 15:14:50 +0000
In-Reply-To: <20191030151451.7961-1-qperret@google.com>
Message-Id: <20191030151451.7961-4-qperret@google.com>
Mime-Version: 1.0
References: <20191030151451.7961-1-qperret@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v9 3/4] thermal: cpu_cooling: Make the power-related code
 depend on IPA
From:   Quentin Perret <qperret@google.com>
To:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        catalin.marinas@arm.com, will@kernel.org, daniel.lezcano@linaro.org
Cc:     dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        mka@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The core CPU cooling infrastructure has power-related functions
that have only one client: IPA. Since there can be no user of those
functions if IPA is not compiled in, make sure to guard them with
checks on CONFIG_THERMAL_GOV_POWER_ALLOCATOR to not waste space
unnecessarily.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 drivers/thermal/cpu_cooling.c | 166 +++++++++++++++++-----------------
 1 file changed, 81 insertions(+), 85 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 6b9865c786ba..cc6b84e41404 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -47,7 +47,9 @@
  */
 struct freq_table {
 	u32 frequency;
+#ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
 	u32 power;
+#endif
 };
 
 /**
@@ -95,8 +97,7 @@ static DEFINE_IDA(cpufreq_ida);
 static DEFINE_MUTEX(cooling_list_lock);
 static LIST_HEAD(cpufreq_cdev_list);
 
-/* Below code defines functions to be used for cpufreq as cooling device */
-
+#ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
 /**
  * get_level: Find the level for a particular frequency
  * @cpufreq_cdev: cpufreq_cdev for which the property is required
@@ -265,76 +266,6 @@ static u32 get_dynamic_power(struct cpufreq_cooling_device *cpufreq_cdev,
 	return (raw_cpu_power * cpufreq_cdev->last_load) / 100;
 }
 
-/* cpufreq cooling device callback functions are defined below */
-
-/**
- * cpufreq_get_max_state - callback function to get the max cooling state.
- * @cdev: thermal cooling device pointer.
- * @state: fill this variable with the max cooling state.
- *
- * Callback for the thermal cooling device to return the cpufreq
- * max cooling state.
- *
- * Return: 0 on success, an error code otherwise.
- */
-static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
-				 unsigned long *state)
-{
-	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
-
-	*state = cpufreq_cdev->max_level;
-	return 0;
-}
-
-/**
- * cpufreq_get_cur_state - callback function to get the current cooling state.
- * @cdev: thermal cooling device pointer.
- * @state: fill this variable with the current cooling state.
- *
- * Callback for the thermal cooling device to return the cpufreq
- * current cooling state.
- *
- * Return: 0 on success, an error code otherwise.
- */
-static int cpufreq_get_cur_state(struct thermal_cooling_device *cdev,
-				 unsigned long *state)
-{
-	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
-
-	*state = cpufreq_cdev->cpufreq_state;
-
-	return 0;
-}
-
-/**
- * cpufreq_set_cur_state - callback function to set the current cooling state.
- * @cdev: thermal cooling device pointer.
- * @state: set this variable to the current cooling state.
- *
- * Callback for the thermal cooling device to change the cpufreq
- * current cooling state.
- *
- * Return: 0 on success, an error code otherwise.
- */
-static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
-				 unsigned long state)
-{
-	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
-
-	/* Request state should be less than max_level */
-	if (WARN_ON(state > cpufreq_cdev->max_level))
-		return -EINVAL;
-
-	/* Check if the old cooling action is same as new cooling action */
-	if (cpufreq_cdev->cpufreq_state == state)
-		return 0;
-
-	cpufreq_cdev->cpufreq_state = state;
-
-	return freq_qos_update_request(&cpufreq_cdev->qos_req,
-				cpufreq_cdev->freq_table[state].frequency);
-}
-
 /**
  * cpufreq_get_requested_power() - get the current power
  * @cdev:	&thermal_cooling_device pointer
@@ -478,22 +409,84 @@ static int cpufreq_power2state(struct thermal_cooling_device *cdev,
 				      power);
 	return 0;
 }
+#endif /* CONFIG_THERMAL_GOV_POWER_ALLOCATOR */
+
+/* cpufreq cooling device callback functions are defined below */
+
+/**
+ * cpufreq_get_max_state - callback function to get the max cooling state.
+ * @cdev: thermal cooling device pointer.
+ * @state: fill this variable with the max cooling state.
+ *
+ * Callback for the thermal cooling device to return the cpufreq
+ * max cooling state.
+ *
+ * Return: 0 on success, an error code otherwise.
+ */
+static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
+				 unsigned long *state)
+{
+	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
+
+	*state = cpufreq_cdev->max_level;
+	return 0;
+}
+
+/**
+ * cpufreq_get_cur_state - callback function to get the current cooling state.
+ * @cdev: thermal cooling device pointer.
+ * @state: fill this variable with the current cooling state.
+ *
+ * Callback for the thermal cooling device to return the cpufreq
+ * current cooling state.
+ *
+ * Return: 0 on success, an error code otherwise.
+ */
+static int cpufreq_get_cur_state(struct thermal_cooling_device *cdev,
+				 unsigned long *state)
+{
+	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
+
+	*state = cpufreq_cdev->cpufreq_state;
+
+	return 0;
+}
+
+/**
+ * cpufreq_set_cur_state - callback function to set the current cooling state.
+ * @cdev: thermal cooling device pointer.
+ * @state: set this variable to the current cooling state.
+ *
+ * Callback for the thermal cooling device to change the cpufreq
+ * current cooling state.
+ *
+ * Return: 0 on success, an error code otherwise.
+ */
+static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
+				 unsigned long state)
+{
+	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
+
+	/* Request state should be less than max_level */
+	if (WARN_ON(state > cpufreq_cdev->max_level))
+		return -EINVAL;
+
+	/* Check if the old cooling action is same as new cooling action */
+	if (cpufreq_cdev->cpufreq_state == state)
+		return 0;
+
+	cpufreq_cdev->cpufreq_state = state;
+
+	return freq_qos_update_request(&cpufreq_cdev->qos_req,
+				cpufreq_cdev->freq_table[state].frequency);
+}
 
 /* Bind cpufreq callbacks to thermal cooling device ops */
 
 static struct thermal_cooling_device_ops cpufreq_cooling_ops = {
-	.get_max_state = cpufreq_get_max_state,
-	.get_cur_state = cpufreq_get_cur_state,
-	.set_cur_state = cpufreq_set_cur_state,
-};
-
-static struct thermal_cooling_device_ops cpufreq_power_cooling_ops = {
 	.get_max_state		= cpufreq_get_max_state,
 	.get_cur_state		= cpufreq_get_cur_state,
 	.set_cur_state		= cpufreq_set_cur_state,
-	.get_requested_power	= cpufreq_get_requested_power,
-	.state2power		= cpufreq_state2power,
-	.power2state		= cpufreq_power2state,
 };
 
 static unsigned int find_next_max(struct cpufreq_frequency_table *table,
@@ -603,17 +596,20 @@ __cpufreq_cooling_register(struct device_node *np,
 			pr_debug("%s: freq:%u KHz\n", __func__, freq);
 	}
 
+	cooling_ops = &cpufreq_cooling_ops;
+
+#ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
 	if (capacitance) {
 		ret = update_freq_table(cpufreq_cdev, capacitance);
 		if (ret) {
 			cdev = ERR_PTR(ret);
 			goto remove_ida;
 		}
-
-		cooling_ops = &cpufreq_power_cooling_ops;
-	} else {
-		cooling_ops = &cpufreq_cooling_ops;
+		cooling_ops->get_requested_power = cpufreq_get_requested_power;
+		cooling_ops->state2power = cpufreq_state2power;
+		cooling_ops->power2state = cpufreq_power2state;
 	}
+#endif
 
 	ret = freq_qos_add_request(&policy->constraints,
 				   &cpufreq_cdev->qos_req, FREQ_QOS_MAX,
-- 
2.24.0.rc0.303.g954a862665-goog

