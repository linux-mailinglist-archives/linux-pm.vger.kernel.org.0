Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520261B01C7
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 08:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbgDTGst (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 02:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbgDTGst (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2020 02:48:49 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F281AC061A0C
        for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2020 23:48:48 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id hi11so3453888pjb.3
        for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2020 23:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DMUHPHgNK4YCFCzeh+evq9wW6FTpDRZskhPvZiOmbB8=;
        b=Ke27Vcc/CWWaiv800arg0Eg6ABZAksH3nQqwAcZgCiebZbNffWnnQJETywVrlrOJEH
         5NaJWLUocwEi6gMNckb1zCHFIXFU2ZM3PwMUGpxmE7xjTANu2XSYC8++CkpZnkW3cGd4
         Zur0dxDejfCf4CTc32DX+WC9ai488uhMLhY9sPoy2glhkdyaZaW3o47XIETbKbIlFiEF
         R9axhHOX7vW5EkSGQ/wOR9+XiuvGr828cykKsEC+v30IQG/Fqh2aZhwmQSMSZ4hL7Cpa
         ZonXdmdwaNe2Qwlo4LZtEKrogNeeL3+ZV1JJITRtiA/1FWqYvVqohPlG4QViFo3UUktT
         qNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DMUHPHgNK4YCFCzeh+evq9wW6FTpDRZskhPvZiOmbB8=;
        b=XgShWObam9lPZKczNtG/7/A2tcYNpj18K5tFLoXH5z5t7LQ14hN7hFuVSSUy9ysz4t
         PANGtqx5cPc3Rg/GoO6bVWRwNJq00Hppz6bUHQLoNVTGwsVl7KgBwEO+m+JGrtMMwJ2K
         br/NYsN5sIqw16nX0Nc+LNxFFckFL7VWCaWUqoBn4YsGNc7eWdScefNCR+pwyt7RWU7c
         SgZhfnAa87tUvgwxwczSlH7URp0nTZRpmPYT2mPY5leyoGBLztV74UTejOgpoiJLx5oa
         Fe7dz5k/TmxcP04P6iQBNFpNuC3iERs3+Ngd+3KKw6QHzJRrzkKFtc2ysHJgRBP6Yvup
         9Nrg==
X-Gm-Message-State: AGi0Puayt1rMXMGzlBbVLpf9pxJXJSEWbxrVGKnJtk1HqrDx/F6GnshX
        PAONx3qGfaRVgiFPS1Kejao=
X-Google-Smtp-Source: APiQypINPRLAgn23EsNm7Hfe5uCgruT2zqVdwGUPTVuEAWyAUUFdsVnSx11u2s1Cl3N8dtLFy5Ezwg==
X-Received: by 2002:a17:902:6bc8:: with SMTP id m8mr15424930plt.104.1587365328426;
        Sun, 19 Apr 2020 23:48:48 -0700 (PDT)
Received: from bj04432pcu2.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id w3sm128254pfn.115.2020.04.19.23.48.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Apr 2020 23:48:48 -0700 (PDT)
From:   gao.yunxiao6@gmail.com
To:     daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        amit.kachhap@gmail.com, javi.merino@kernel.org
Cc:     linux-pm@vger.kernel.org, kernel-team@android.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com,
        Jeson Gao <jeson.gao@unisoc.com>
Subject: [PATCH 1/2] thermal/drivers/cpufreq_cooling: Add platform callback functions
Date:   Mon, 20 Apr 2020 14:48:39 +0800
Message-Id: <1587365320-25222-1-git-send-email-gao.yunxiao6@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Jeson Gao <jeson.gao@unisoc.com>

On some platforms, due to the high power consumption, thermal frequency
reduction policy cannot control the desired temperature, platform have to
use the hotplug mechanism to mitigate temperature rising,so adding the
platform callback to support this function.

platform will hotplug out CPU when the normalised power is lower than
the power corresponding to the minimum frequency limit that is set by
platform.

Signed-off-by: Jeson Gao <jeson.gao@unisoc.com>
---
 drivers/thermal/cpufreq_cooling.c | 52 +++++++++++++++++++++++++++++++++++++++
 include/linux/cpu_cooling.h       | 30 ++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index e297e13..16cbf58 100644
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
@@ -684,3 +698,41 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
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
index 65501d8..3934918 100644
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
@@ -40,6 +57,19 @@ struct thermal_cooling_device *
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
1.9.1

