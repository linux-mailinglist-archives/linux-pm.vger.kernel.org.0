Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52BF35F3E6
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2019 09:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfGDHgh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Jul 2019 03:36:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33843 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727463AbfGDHgg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jul 2019 03:36:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id c85so2543847pfc.1
        for <linux-pm@vger.kernel.org>; Thu, 04 Jul 2019 00:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=URsfVb2C5YnDBdAursEkzykoBuRcfjDfpur3Oh0s0WQ=;
        b=yLiVb0ti1ToT9rynffrniwkv2vML1oc4vwTfCyXQAAdUBi4tuqOGD2S0dnIXdFl4Eo
         m86o4yV8wGUA/uIpu8Kl/e30ZKEL1SjkiQstNlymRPfQrrcHFkethJ+EPfRB0xtsSWLd
         2kNI6t3JpkKGDhNEIbSrGDTNCLnMGztukSDreTufoFyVpR+Lh37xvOkIKjO+RPfuD26F
         YxemoCmSJ0/tIchNdpRLrHndHOwhLcaQ5nyTt78yG97nALYDJzqg5Ky0X+cIMcEAwtH3
         BFUOOtH7No+gcHUjN210nTxgc/OnJyEIsOOxfD7m+Zb4cK/ThNV1rAfB8t4w+i6/enln
         crfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=URsfVb2C5YnDBdAursEkzykoBuRcfjDfpur3Oh0s0WQ=;
        b=LEUuYXncCv1Q73k1+raR1QYAbZmGL9besNlwmHwrU32z8CEBvj8xvkpXMKinRp3FfO
         wTVqVaMGt8VrHy1HQa5o+vJm8y3mQr3UacpnUUvl7f50sUlVd9PydlghTVXee1lwQ5Sy
         z++BdMxhGAkJYWtFyEyG0BUdhfd+Ru7Nv5zhDxMWEUGLcKCgno9FOyHOu/U9y1DKE7kE
         4zDB42PP7WwKsEgqQvEmR3onRBoFXUHOp+jkPPTKXRYF9ZBSm0zdji2XUDlZgdoe/Mi3
         qT2YgBVIvCsd/z+Nv9R8h/3x1bEoJpqOy0+oqLqVPx05/jYL74eYEyM3A70FNkFd38Vh
         2dqw==
X-Gm-Message-State: APjAAAVu0l1i/J9m9i6++dV0xgunCh5JjU4MDAAd1QZuwz84D2aT/Fof
        8MOGCENYeZpbESv+fpgXpKjvdg==
X-Google-Smtp-Source: APXvYqzeL4xx7EYVkrKHBw6dBgdJlPznpcVk0xFcfxV9Sip0KNi8buUKHe8obzPvXrjVl+IFdzFaGg==
X-Received: by 2002:a17:90b:8d8:: with SMTP id ds24mr17848618pjb.135.1562225795530;
        Thu, 04 Jul 2019 00:36:35 -0700 (PDT)
Received: from localhost ([122.172.21.205])
        by smtp.gmail.com with ESMTPSA id t10sm4342324pjr.13.2019.07.04.00.36.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 00:36:35 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V6 2/7] PM / QOS: Rename __dev_pm_qos_read_value() and dev_pm_qos_raw_read_value()
Date:   Thu,  4 Jul 2019 13:06:18 +0530
Message-Id: <a7ea078332b5aee680049ccf0c156ff6e378bb72.1562210705.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1562210705.git.viresh.kumar@linaro.org>
References: <cover.1562210705.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

dev_pm_qos_read_value() will soon need to support more constraint types
(min/max frequency) and will have another argument to it, i.e. type of
the constraint. While that is fine for the existing users of
dev_pm_qos_read_value(), but not that optimal for the callers of
__dev_pm_qos_read_value() and dev_pm_qos_raw_read_value() as all the
callers of these two routines are only looking for resume latency
constraint.

Lets make these two routines care only about the resume latency
constraint and rename them to __dev_pm_qos_resume_latency() and
dev_pm_qos_raw_resume_latency().

Suggested-by: Rafael J. Wysocki <rjw@rjwysocki.net>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/domain_governor.c |  2 +-
 drivers/base/power/qos.c             | 13 +++++++++----
 drivers/base/power/runtime.c         |  2 +-
 drivers/cpuidle/governor.c           |  2 +-
 include/linux/pm_qos.h               |  8 ++++----
 5 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 3838045c9277..20e56a5be01f 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -66,7 +66,7 @@ static bool default_suspend_ok(struct device *dev)
 	td->constraint_changed = false;
 	td->cached_suspend_ok = false;
 	td->effective_constraint_ns = 0;
-	constraint_ns = __dev_pm_qos_read_value(dev);
+	constraint_ns = __dev_pm_qos_resume_latency(dev);
 
 	spin_unlock_irqrestore(&dev->power.lock, flags);
 
diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index cfd463212513..7a0d197f0809 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -90,16 +90,16 @@ enum pm_qos_flags_status dev_pm_qos_flags(struct device *dev, s32 mask)
 EXPORT_SYMBOL_GPL(dev_pm_qos_flags);
 
 /**
- * __dev_pm_qos_read_value - Get PM QoS constraint for a given device.
+ * __dev_pm_qos_resume_latency - Get resume latency constraint for a given device.
  * @dev: Device to get the PM QoS constraint value for.
  *
  * This routine must be called with dev->power.lock held.
  */
-s32 __dev_pm_qos_read_value(struct device *dev)
+s32 __dev_pm_qos_resume_latency(struct device *dev)
 {
 	lockdep_assert_held(&dev->power.lock);
 
-	return dev_pm_qos_raw_read_value(dev);
+	return dev_pm_qos_raw_resume_latency(dev);
 }
 
 /**
@@ -112,7 +112,12 @@ s32 dev_pm_qos_read_value(struct device *dev)
 	s32 ret;
 
 	spin_lock_irqsave(&dev->power.lock, flags);
-	ret = __dev_pm_qos_read_value(dev);
+
+	if (IS_ERR_OR_NULL(dev->power.qos))
+		ret = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
+	else
+		ret = pm_qos_read_value(&dev->power.qos->resume_latency);
+
 	spin_unlock_irqrestore(&dev->power.lock, flags);
 
 	return ret;
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 952a1e7057c7..b75335508d2c 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -275,7 +275,7 @@ static int rpm_check_suspend_allowed(struct device *dev)
 	    || (dev->power.request_pending
 			&& dev->power.request == RPM_REQ_RESUME))
 		retval = -EAGAIN;
-	else if (__dev_pm_qos_read_value(dev) == 0)
+	else if (__dev_pm_qos_resume_latency(dev) == 0)
 		retval = -EPERM;
 	else if (dev->power.runtime_status == RPM_SUSPENDED)
 		retval = 1;
diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c
index 9fddf828a76f..2e3e14192bee 100644
--- a/drivers/cpuidle/governor.c
+++ b/drivers/cpuidle/governor.c
@@ -110,7 +110,7 @@ int cpuidle_governor_latency_req(unsigned int cpu)
 {
 	int global_req = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
 	struct device *device = get_cpu_device(cpu);
-	int device_req = dev_pm_qos_raw_read_value(device);
+	int device_req = dev_pm_qos_raw_resume_latency(device);
 
 	return device_req < global_req ? device_req : global_req;
 }
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 58e8749ceac5..5e09d4980786 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -139,7 +139,7 @@ s32 pm_qos_read_value(struct pm_qos_constraints *c);
 #ifdef CONFIG_PM
 enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev, s32 mask);
 enum pm_qos_flags_status dev_pm_qos_flags(struct device *dev, s32 mask);
-s32 __dev_pm_qos_read_value(struct device *dev);
+s32 __dev_pm_qos_resume_latency(struct device *dev);
 s32 dev_pm_qos_read_value(struct device *dev);
 int dev_pm_qos_add_request(struct device *dev, struct dev_pm_qos_request *req,
 			   enum dev_pm_qos_req_type type, s32 value);
@@ -176,7 +176,7 @@ static inline s32 dev_pm_qos_requested_flags(struct device *dev)
 	return dev->power.qos->flags_req->data.flr.flags;
 }
 
-static inline s32 dev_pm_qos_raw_read_value(struct device *dev)
+static inline s32 dev_pm_qos_raw_resume_latency(struct device *dev)
 {
 	return IS_ERR_OR_NULL(dev->power.qos) ?
 		PM_QOS_RESUME_LATENCY_NO_CONSTRAINT :
@@ -189,7 +189,7 @@ static inline enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev,
 static inline enum pm_qos_flags_status dev_pm_qos_flags(struct device *dev,
 							s32 mask)
 			{ return PM_QOS_FLAGS_UNDEFINED; }
-static inline s32 __dev_pm_qos_read_value(struct device *dev)
+static inline s32 __dev_pm_qos_resume_latency(struct device *dev)
 			{ return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT; }
 static inline s32 dev_pm_qos_read_value(struct device *dev)
 			{ return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT; }
@@ -245,7 +245,7 @@ static inline s32 dev_pm_qos_requested_resume_latency(struct device *dev)
 	return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
 }
 static inline s32 dev_pm_qos_requested_flags(struct device *dev) { return 0; }
-static inline s32 dev_pm_qos_raw_read_value(struct device *dev)
+static inline s32 dev_pm_qos_raw_resume_latency(struct device *dev)
 {
 	return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
 }
-- 
2.21.0.rc0.269.g1a574e7a288b

