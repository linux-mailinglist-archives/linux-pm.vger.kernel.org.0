Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192261A9171
	for <lists+linux-pm@lfdr.de>; Wed, 15 Apr 2020 05:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbgDODKh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Apr 2020 23:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728573AbgDODKf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Apr 2020 23:10:35 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C0AC061A0C;
        Tue, 14 Apr 2020 20:10:35 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b7so6190151pju.0;
        Tue, 14 Apr 2020 20:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HOdeqblmKbIq1HYRtyST7B1hyXGd2ArUMIytUAbODFI=;
        b=TX0PWe/4lXewsPFk8slERl9oVHyDjqH3CE+tSePxfaDhMIpfwzjzbYfUFMaFgyD/Q5
         7n3oXEKtr4vM/5dzEVDDEMeaea/t9sqhpHP4tJEP3gdokqZ8huWfc1NEKBgXYuxWXbPM
         y9shVb0pxKr96tUD4yFxx4n6IUbrI3s3eopQ5pBUY9fWPo6qdj3G7uThL7TT/5JITKpn
         W6BBIo4MSvua+howAg5UZOpVqiOaXz5qpSzCnyWIzywaiS18wcvIR8iJs4ORtLSSyXDI
         qdqdbCw5PIr4SbIwaHKvY0C37VIwYdoGir31aKK2Jc3c4Pg0PsiDkOwQi8YX1QL/SBZr
         f8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HOdeqblmKbIq1HYRtyST7B1hyXGd2ArUMIytUAbODFI=;
        b=X57W48CLV1YEslnHFLNLf80KpsPwZoJ33JXXD67PzUeApTarb+Cxu6XhZBWpj7S9yS
         iQ1WbhD5WjxoQ3rtFJy4Ot6irW8xV82eDldYwDzm7SwqtxrnEMu1g+jhuTtbXkcrZQXP
         vDyQhKXN8qGlSoQKM5AZJteG9OuzmK+CvVKi6V/Hz6EfoxW7Y8w0ztc65y2zbl48W6A9
         acCS4CYC5MqbpLR9XR6zMuqHv38NwKyBQ05KFanClKhwtyBAn4pDnLyNzbNOOstCrCKK
         tiVTCUumOsi6hWbGHpX+OeP6G5nF/cfDS1CH41g+D4ZqdXX0HX8gKrya2XNbbtm6kGQ2
         OuPA==
X-Gm-Message-State: AGi0Puam0TwiZoT32JRs1LdRngrks1yYlAZNMgcke+gMPGhopcYxTWQm
        mTtUFuHD86/FhGpCoNOaU9huPwe3
X-Google-Smtp-Source: APiQypLriBxTFHxwnd22KxHXYwQ3j+UHS+Mj/4TQKaIuYm1nOXQJHzMdfbBBCDkV9FUrhqvXPNQMbw==
X-Received: by 2002:a17:90a:d14d:: with SMTP id t13mr3658141pjw.175.1586920234829;
        Tue, 14 Apr 2020 20:10:34 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id z7sm3131364pff.47.2020.04.14.20.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 20:10:34 -0700 (PDT)
From:   zhang.lyra@gmail.com
To:     linux-pm@vger.kernel.org
Cc:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [RFC PATCH v1 1/2] thermal/drivers/cpufreq_cooling: Add platform callback functions
Date:   Wed, 15 Apr 2020 11:09:58 +0800
Message-Id: <20200415030959.1463-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415030959.1463-1-zhang.lyra@gmail.com>
References: <20200415030959.1463-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Jeson Gao <jeson.gao@unisoc.com>

Reducing frequency to too low will affect the system performance, and
sometimes the temperature could not cool down to an ideal value as well
even if the frequency was reduced to the lowest.

This patch provides users a callback to set its own frequency limit to
prevent cpu frequence from being reduced too low. And also give an interface
to allow users to register specific cooling operations.

Signed-off-by: Jeson Gao <jeson.gao@unisoc.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
---
 drivers/thermal/cpufreq_cooling.c | 53 +++++++++++++++++++++++++++++++
 include/linux/cpu_cooling.h       | 30 +++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index e297e135c031..da1cbb22c975 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -64,6 +64,7 @@ struct time_in_idle {
  * @node: list_head to link all cpufreq_cooling_device together.
  * @idle_time: idle time stats
  * @qos_req: PM QoS contraint to apply
+ * @plat_ops: point to platform callback function.
  *
  * This structure is required for keeping information of each registered
  * cpufreq_cooling_device.
@@ -78,6 +79,7 @@ struct cpufreq_cooling_device {
 	struct list_head node;
 	struct time_in_idle *idle_time;
 	struct freq_qos_request qos_req;
+	struct cpufreq_cooling_plat_ops *plat_ops;
 };
 
 static DEFINE_IDA(cpufreq_ida);
@@ -313,12 +315,24 @@ static int cpufreq_power2state(struct thermal_cooling_device *cdev,
 	u32 last_load, normalised_power;
 	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
 	struct cpufreq_policy *policy = cpufreq_cdev->policy;
+	struct cpufreq_cooling_plat_ops *plat_ops = cpufreq_cdev->plat_ops;
 
 	last_load = cpufreq_cdev->last_load ?: 1;
 	normalised_power = (power * 100) / last_load;
 	target_freq = cpu_power_to_freq(cpufreq_cdev, normalised_power);
 
 	*state = get_level(cpufreq_cdev, target_freq);
+	if (*state == cpufreq_cdev->max_level &&
+			plat_ops && plat_ops->cpufreq_plat_min_freq_limit) {
+		plat_ops->cpufreq_plat_min_freq_limit(policy, &target_freq);
+		*state = get_level(cpufreq_cdev, target_freq);
+	}
+
+	if (plat_ops && plat_ops->cpufreq_plat_cpu_ctrl)
+		plat_ops->cpufreq_plat_cpu_ctrl(policy,
+				last_load, normalised_power,
+				cpu_freq_to_power(cpufreq_cdev, target_freq));
+
 	trace_thermal_power_cpu_limit(policy->related_cpus, target_freq, *state,
 				      power);
 	return 0;
@@ -684,3 +698,42 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 	kfree(cpufreq_cdev);
 }
 EXPORT_SYMBOL_GPL(cpufreq_cooling_unregister);
+
+/**
+ * cpufreq_cooling_plat_ops_register - register platform callback function.
+ * @cdev: thermal cooling device pointer.
+ * @plat_ops: platform callback function pointer.
+ */
+int  cpufreq_cooling_plat_ops_register(struct thermal_cooling_device *cdev,
+			struct cpufreq_cooling_plat_ops *plat_ops)
+{
+	struct cpufreq_cooling_device *cpufreq_cdev;
+
+	if (!cdev && !cdev->devdata && !plat_ops)
+		return -EINVAL;
+
+	cpufreq_cdev = cdev->devdata;
+	cpufreq_cdev->plat_ops = plat_ops;
+
+	return 0;
+
+}
+EXPORT_SYMBOL_GPL(cpufreq_cooling_plat_ops_register);
+
+/**
+ * cpufreq_cooling_plat_ops_unregister - unregister platform callback function.
+ * @cdev: thermal cooling device pointer.
+ */
+int  cpufreq_cooling_plat_ops_unregister(struct thermal_cooling_device *cdev)
+{
+	struct cpufreq_cooling_device *cpufreq_cdev;
+
+	if (!cdev && !cdev->devdata)
+		return -EINVAL;
+
+	cpufreq_cdev = cdev->devdata;
+	cpufreq_cdev->plat_ops = NULL;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cpufreq_cooling_plat_ops_unregister);
diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index 65501d8f9778..3934918e4ab7 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -19,6 +19,23 @@
 
 struct cpufreq_policy;
 
+/**
+ * struct cpufreq_cooling_plat_ops - platfom cpu cooling policy ops
+ *
+ * @cpufreq_plat_cpu_ctrl: this function provides a further core control
+ * policy when the current policies cannot cool down to an expected
+ * temperature value.
+ *
+ * @cpufreq_plat_min_freq_limit: set cpu frequency limit, cooling devices
+ * are not allowed to adjust cpu frequency to out of that limit.
+ */
+struct cpufreq_cooling_plat_ops {
+	int (*cpufreq_plat_cpu_ctrl)(struct cpufreq_policy *policy,
+				u32 load, u32 normalised_power, u32 freq_power);
+	void (*cpufreq_plat_min_freq_limit)(struct cpufreq_policy *policy,
+						u32 *target_freq);
+};
+
 #ifdef CONFIG_CPU_FREQ_THERMAL
 /**
  * cpufreq_cooling_register - function to create cpufreq cooling device.
@@ -40,6 +57,19 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev);
 struct thermal_cooling_device *
 of_cpufreq_cooling_register(struct cpufreq_policy *policy);
 
+/**
+ * cpufreq_cooling_plat_ops_register - register platform callback function.
+ * @cdev: thermal cooling device pointer.
+ * @plat_ops: platform callback function pointer.
+ */
+int cpufreq_cooling_plat_ops_register(struct thermal_cooling_device *cdev,
+			struct cpufreq_cooling_plat_ops *plat_ops);
+/**
+ * cpufreq_cooling_plat_ops_unregister - unregister platform callback function.
+ * @cdev: thermal cooling device pointer.
+ */
+int  cpufreq_cooling_plat_ops_unregister(struct thermal_cooling_device *cdev);
+
 #else /* !CONFIG_CPU_FREQ_THERMAL */
 static inline struct thermal_cooling_device *
 cpufreq_cooling_register(struct cpufreq_policy *policy)
-- 
2.20.1

