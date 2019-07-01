Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5F05BA93
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2019 13:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfGAL0a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jul 2019 07:26:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45632 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbfGAL0a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jul 2019 07:26:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id o13so1414200pgp.12
        for <linux-pm@vger.kernel.org>; Mon, 01 Jul 2019 04:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PlxocW5hWVYXfPkN8RZ8vxi1sxzrmOenQcvIcTZd5kM=;
        b=XUamfttyP80qdspJgf1uIrYuYqNj/n0X1CzPBvPz4mMVT/y51sj6kZS6OMaVHEigV0
         AWHBSQtCgD6fzdYqfjQ4vQ5+CSxugvayzemLhR5nad63DIF2NZptTU7b3vY/IAsf4Kqh
         qaL7GgFhQfaCU/UQ6zPKAYk0JZpem/ygA+1PtSJumre9Jf0FyXphj6sUSAmM7jrpd8zo
         ra/51juPWGNEtGpCyxWs4AggISzIwaTywOYJHN26VS+B4tS8k5b1ooEwWHnscsmtlpDN
         zu3qVHaTP20si2JQVegs0PzPnBAsBoSoV1Jc12R516XJNpRs2qPPMmGz5lgMahUGQTas
         8Q5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PlxocW5hWVYXfPkN8RZ8vxi1sxzrmOenQcvIcTZd5kM=;
        b=DXO7sGpTNOdbO84qKWKbBOC+NNpBNT/DagqZnxeW0Duv9mxUbL1fnRySK7oLcqV37m
         4PHT04qaR+qML6kphwX6rDWg6QdILN7MiqG0b0o/5MiZ1Q/LHDRbBWUMsnN7423fyIa7
         HUyESOeTdqD3X7CPYMK/kvdk0vQdYCwb/Wh+AHIU+7n4qi0kBgTli4NuW534btfROC86
         sYObZ8B1wDo++3lWQm2l4Vv/95OMR2XHTAxST744NlhYvvPkG+3wRySMTf9N8Q1yw185
         6u9t6g7c/orTNk4JBKlyxYSzjzzPMrItQS5tBoGAXhoxIZjnZM8A6uj2NlJZ6DJzv++v
         WLnQ==
X-Gm-Message-State: APjAAAWJtc2mI1WoMjRdDIJUkxyJGwbSlgsS2OkfrSoV/E7+mm0C3Onh
        r3Mpu4s5dFOeBT2kuIsT9gsm5w==
X-Google-Smtp-Source: APXvYqzzXuYchXR4bDT7E4DNJbEi3ftoJcE2aBG4RWQpZQX301aEkSUILM58p+g3QwsHC+9jXUPmdA==
X-Received: by 2002:a65:62c2:: with SMTP id m2mr24639022pgv.413.1561980389387;
        Mon, 01 Jul 2019 04:26:29 -0700 (PDT)
Received: from localhost ([122.172.21.205])
        by smtp.gmail.com with ESMTPSA id m4sm19139569pff.108.2019.07.01.04.26.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 04:26:28 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, mka@chromium.org, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 2/7] PM / QOS: Rename __dev_pm_qos_read_value() and dev_pm_qos_raw_read_value()
Date:   Mon,  1 Jul 2019 16:56:10 +0530
Message-Id: <5c38b4a94f5114bbc99f62d89d4c09f877194dc7.1561979715.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1561979715.git.viresh.kumar@linaro.org>
References: <cover.1561979715.git.viresh.kumar@linaro.org>
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
index 1f4d456e8fff..06aa88496761 100644
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

