Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF5893B375
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2019 12:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389583AbfFJKv7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jun 2019 06:51:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33482 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389567AbfFJKv6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jun 2019 06:51:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id x15so5110780pfq.0
        for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2019 03:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HRZQIiD3VAYVrpVQWM3sNejmupzZeSRWMABh+Ww3h4Y=;
        b=uTlCkziXEsn//b+HJxzaWBgftw8jjb3Q93jRUqfml/dtx0nZS/yqtCaUQx+/Qsh3lg
         f1ayqkJDgP44p8MNv116VgZ3jyRuFxogG/dim5AJQrRgxB3mPArwELsuAn2FrRpzQakC
         F9GfTDV4SsIllBZU0MbpMLesrHA+9fnToW7krOZGPuvD0qMW9hXmzpTvr22pQBP1cEPC
         8AWA9p1dGYP/5hFnUKnd92c+gID24LX/856KRwzNIB3KQbfGSq2sMQDpq9XwcLw43T2H
         zEHayr34Ztu8GB85YNBGQEQ3z+/Mn/2XuhPtdZzKlZeZV8dpN/TGU6I0JIPuOrghIGZ8
         vyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HRZQIiD3VAYVrpVQWM3sNejmupzZeSRWMABh+Ww3h4Y=;
        b=lMHot4A8S1eOkObJ8uvNFRZ/AlQ/oNbMD+/hRl/7YyUGR8g56HSYjNgH7vVT7cm6H4
         gKfrVlo/SFuUATu4XK2J21lF8ejB3Gtfmvw//I1ZF2RQbI8b3OWNupsJsQiC3yz3NoEZ
         TWs0tpnIZBw7DUyeSDxjNWNYOTLwcnefNIK8WDMxV7rsRuglso/t7wfRjXQbCfb11VVb
         ahUYu572DaE4Lfj1xjw7NHQPPdlmZtmTc6qEqYrqyTKV3iAXjg0KhjIjmi1ftu9AT2Cu
         7oQt5GW1GyY5HRGjoR1AcPCyMH7YiaQfYONL+NADj5G7Lun14AxMrPdH2NGc2YEWAdY1
         /gmg==
X-Gm-Message-State: APjAAAXxvY7GP9WEQkiOTsaICCM67PTblCvM5HRG8HzC5Cx9oTxS5Shi
        JIylU9z/fOOwsc3EHKkVRXscwg==
X-Google-Smtp-Source: APXvYqxmsjC+kjo31axVuDH5tG2Dhf4mYyY4jBcrC/Q8UedCwhle1ML+4DVXwkFIEKt6qDrL8qqlKA==
X-Received: by 2002:a17:90a:32ed:: with SMTP id l100mr20415747pjb.11.1560163917893;
        Mon, 10 Jun 2019 03:51:57 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id j72sm9736360pje.12.2019.06.10.03.51.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 03:51:57 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, mka@chromium.org, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/5] PM / QOS: Pass request type to dev_pm_qos_read_value()
Date:   Mon, 10 Jun 2019 16:21:33 +0530
Message-Id: <b414d788faf4c6f87d01086248db4d2e86635180.1560163748.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1560163748.git.viresh.kumar@linaro.org>
References: <cover.1560163748.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to use dev_pm_qos_read_value(), and other internal routines to
it, to read values for different QoS requests, pass request type as a
parameter to these routines.

For now, it only supports resume-latency request type.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/power/pm_qos_interface.txt |  2 +-
 drivers/base/power/domain_governor.c     |  4 +--
 drivers/base/power/qos.c                 | 10 +++---
 drivers/base/power/runtime.c             |  2 +-
 drivers/cpuidle/governor.c               |  2 +-
 include/linux/pm_qos.h                   | 41 +++++++++++++++++-------
 6 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/Documentation/power/pm_qos_interface.txt b/Documentation/power/pm_qos_interface.txt
index ec7d662d1707..cfcb1df39799 100644
--- a/Documentation/power/pm_qos_interface.txt
+++ b/Documentation/power/pm_qos_interface.txt
@@ -123,7 +123,7 @@ Will remove the element.  After removal it will update the aggregate target and
 call the notification trees if the target was changed as a result of removing
 the request.
 
-s32 dev_pm_qos_read_value(device):
+s32 dev_pm_qos_read_value(device, type):
 Returns the aggregated value for a given device's constraints list.
 
 enum pm_qos_flags_status dev_pm_qos_flags(device, mask)
diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 3838045c9277..f66ac46d07d0 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -33,7 +33,7 @@ static int dev_update_qos_constraint(struct device *dev, void *data)
 		 * take its current PM QoS constraint (that's the only thing
 		 * known at this point anyway).
 		 */
-		constraint_ns = dev_pm_qos_read_value(dev);
+		constraint_ns = dev_pm_qos_read_value(dev, DEV_PM_QOS_RESUME_LATENCY);
 		constraint_ns *= NSEC_PER_USEC;
 	}
 
@@ -66,7 +66,7 @@ static bool default_suspend_ok(struct device *dev)
 	td->constraint_changed = false;
 	td->cached_suspend_ok = false;
 	td->effective_constraint_ns = 0;
-	constraint_ns = __dev_pm_qos_read_value(dev);
+	constraint_ns = __dev_pm_qos_read_value(dev, DEV_PM_QOS_RESUME_LATENCY);
 
 	spin_unlock_irqrestore(&dev->power.lock, flags);
 
diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index cfd463212513..7bb88174371f 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -92,27 +92,29 @@ EXPORT_SYMBOL_GPL(dev_pm_qos_flags);
 /**
  * __dev_pm_qos_read_value - Get PM QoS constraint for a given device.
  * @dev: Device to get the PM QoS constraint value for.
+ * @type: QoS request type.
  *
  * This routine must be called with dev->power.lock held.
  */
-s32 __dev_pm_qos_read_value(struct device *dev)
+s32 __dev_pm_qos_read_value(struct device *dev, enum dev_pm_qos_req_type type)
 {
 	lockdep_assert_held(&dev->power.lock);
 
-	return dev_pm_qos_raw_read_value(dev);
+	return dev_pm_qos_raw_read_value(dev, type);
 }
 
 /**
  * dev_pm_qos_read_value - Get PM QoS constraint for a given device (locked).
  * @dev: Device to get the PM QoS constraint value for.
+ * @type: QoS request type.
  */
-s32 dev_pm_qos_read_value(struct device *dev)
+s32 dev_pm_qos_read_value(struct device *dev, enum dev_pm_qos_req_type type)
 {
 	unsigned long flags;
 	s32 ret;
 
 	spin_lock_irqsave(&dev->power.lock, flags);
-	ret = __dev_pm_qos_read_value(dev);
+	ret = __dev_pm_qos_read_value(dev, type);
 	spin_unlock_irqrestore(&dev->power.lock, flags);
 
 	return ret;
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 952a1e7057c7..92ffc2a0151d 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -275,7 +275,7 @@ static int rpm_check_suspend_allowed(struct device *dev)
 	    || (dev->power.request_pending
 			&& dev->power.request == RPM_REQ_RESUME))
 		retval = -EAGAIN;
-	else if (__dev_pm_qos_read_value(dev) == 0)
+	else if (__dev_pm_qos_read_value(dev, DEV_PM_QOS_RESUME_LATENCY) == 0)
 		retval = -EPERM;
 	else if (dev->power.runtime_status == RPM_SUSPENDED)
 		retval = 1;
diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c
index 9fddf828a76f..fb5659eb2009 100644
--- a/drivers/cpuidle/governor.c
+++ b/drivers/cpuidle/governor.c
@@ -110,7 +110,7 @@ int cpuidle_governor_latency_req(unsigned int cpu)
 {
 	int global_req = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
 	struct device *device = get_cpu_device(cpu);
-	int device_req = dev_pm_qos_raw_read_value(device);
+	int device_req = dev_pm_qos_raw_read_value(device, DEV_PM_QOS_RESUME_LATENCY);
 
 	return device_req < global_req ? device_req : global_req;
 }
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 1f4d456e8fff..55814d48c39c 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -139,8 +139,8 @@ s32 pm_qos_read_value(struct pm_qos_constraints *c);
 #ifdef CONFIG_PM
 enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev, s32 mask);
 enum pm_qos_flags_status dev_pm_qos_flags(struct device *dev, s32 mask);
-s32 __dev_pm_qos_read_value(struct device *dev);
-s32 dev_pm_qos_read_value(struct device *dev);
+s32 __dev_pm_qos_read_value(struct device *dev, enum dev_pm_qos_req_type type);
+s32 dev_pm_qos_read_value(struct device *dev, enum dev_pm_qos_req_type type);
 int dev_pm_qos_add_request(struct device *dev, struct dev_pm_qos_request *req,
 			   enum dev_pm_qos_req_type type, s32 value);
 int dev_pm_qos_update_request(struct dev_pm_qos_request *req, s32 new_value);
@@ -176,11 +176,19 @@ static inline s32 dev_pm_qos_requested_flags(struct device *dev)
 	return dev->power.qos->flags_req->data.flr.flags;
 }
 
-static inline s32 dev_pm_qos_raw_read_value(struct device *dev)
+static inline s32 dev_pm_qos_raw_read_value(struct device *dev,
+					    enum dev_pm_qos_req_type type)
 {
-	return IS_ERR_OR_NULL(dev->power.qos) ?
-		PM_QOS_RESUME_LATENCY_NO_CONSTRAINT :
-		pm_qos_read_value(&dev->power.qos->resume_latency);
+	struct dev_pm_qos *qos = dev->power.qos;
+
+	switch (type) {
+	case DEV_PM_QOS_RESUME_LATENCY:
+		return IS_ERR_OR_NULL(qos) ? PM_QOS_RESUME_LATENCY_NO_CONSTRAINT
+			: pm_qos_read_value(&qos->resume_latency);
+	default:
+		WARN_ON(1);
+		return 0;
+	}
 }
 #else
 static inline enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev,
@@ -189,10 +197,6 @@ static inline enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev,
 static inline enum pm_qos_flags_status dev_pm_qos_flags(struct device *dev,
 							s32 mask)
 			{ return PM_QOS_FLAGS_UNDEFINED; }
-static inline s32 __dev_pm_qos_read_value(struct device *dev)
-			{ return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT; }
-static inline s32 dev_pm_qos_read_value(struct device *dev)
-			{ return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT; }
 static inline int dev_pm_qos_add_request(struct device *dev,
 					 struct dev_pm_qos_request *req,
 					 enum dev_pm_qos_req_type type,
@@ -245,10 +249,23 @@ static inline s32 dev_pm_qos_requested_resume_latency(struct device *dev)
 	return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
 }
 static inline s32 dev_pm_qos_requested_flags(struct device *dev) { return 0; }
-static inline s32 dev_pm_qos_raw_read_value(struct device *dev)
+
+static inline s32 dev_pm_qos_raw_read_value(struct device *dev,
+					    enum dev_pm_qos_req_type type)
 {
-	return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
+	switch type {
+	case DEV_PM_QOS_RESUME_LATENCY:
+		return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
+	default:
+		WARN_ON(1);
+		return 0;
+	}
 }
+
+static inline s32 __dev_pm_qos_read_value(struct device *dev, enum dev_pm_qos_req_type type)
+			{ return dev_pm_qos_raw_read_value(dev, type); }
+static inline s32 dev_pm_qos_read_value(struct device *dev, enum dev_pm_qos_req_type type)
+			{ return dev_pm_qos_raw_read_value(dev, type); }
 #endif
 
 #endif
-- 
2.21.0.rc0.269.g1a574e7a288b

