Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEDB4C87C
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2019 09:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfFTHfs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Jun 2019 03:35:48 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41602 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730267AbfFTHfr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jun 2019 03:35:47 -0400
Received: by mail-pl1-f194.google.com with SMTP id m7so1025361pls.8
        for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2019 00:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PlxocW5hWVYXfPkN8RZ8vxi1sxzrmOenQcvIcTZd5kM=;
        b=neDtkbnB32fNUiWRtuM8IA9wvANTqdn4GCX0BHaSi+sZp9pJZWz/+yK7URvT057gpm
         mOAiBkCY6b10Dx1M2aVrWFGT6vV1dxhR68qH/LnfIQ2WPEKkdHHWXOap0WA58bsC7jSY
         KQkbIe6ps7Q35RT0ophUMWBQy3N+2HWmgvFDiSvceXN1/NBol+47TtuDZe+mFyYCdoW6
         UA65wyMnKnZTheqEexkIEmd9m8cTGMdhm6TA9ojLwZvKPmPLH9SG8kOHGG3IzIVHIg5d
         y6iVMu1LqXFH9srEDq/cEBy7ssJot4+oVARC+N6rZGVBXlKdu6gO1axEQLhxX9KMUYfC
         FkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PlxocW5hWVYXfPkN8RZ8vxi1sxzrmOenQcvIcTZd5kM=;
        b=QzFCZiHpuxmdeG/OFFFBzHTF84qP6mSmnEYK3ZHq2eQ3SpTgHzNj8nW1O5w3BsbqQm
         8tZXifrlro+0G11H/6Y5MdNrxZ/UGUkSlTpX4WypisAsrtRV1Mv3KWtWgq3x999ScGXD
         tCpoKdUcQDm67VLHBxFerEHaLYcxBU2xyq4bCF9o9dfwGiFySkZcc9LlXLL+AHn7xcQX
         ik9Yh+W8FHGzZ/zEYJZFEvIXOCmkY18cQ8csqKZ6Rdpcuh4I5DwumtbUjF0InRiOjVrt
         ZvooyKr39fg/xH6skT61C3CR3PyuN8yoWeSkCq4jw+NHOy+2tpI6xIiFHrv5vYlJw30+
         8C/w==
X-Gm-Message-State: APjAAAVkz5oUtSoZ8BvDRgs6NNCZyobY6lR985NWmr1uSvE6GWaNu0e9
        AcdfQkb+G3ejik1cb+NHpC3C3y7QsVk=
X-Google-Smtp-Source: APXvYqwvydDpjxVc0YgXiq55R1zrSeQFQcZ0OknZiFAEJ8CvCofSBk2fY8zZz9BX8X86k8WRmfChbw==
X-Received: by 2002:a17:902:e65:: with SMTP id 92mr117937368plw.13.1561016147164;
        Thu, 20 Jun 2019 00:35:47 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id s24sm20879349pfh.133.2019.06.20.00.35.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 00:35:46 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, mka@chromium.org, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 2/6] PM / QOS: Rename __dev_pm_qos_read_value() and dev_pm_qos_raw_read_value()
Date:   Thu, 20 Jun 2019 13:05:25 +0530
Message-Id: <4597b5639f58b8a55f97241abcbdd49f9dea34e8.1561014965.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1561014965.git.viresh.kumar@linaro.org>
References: <cover.1561014965.git.viresh.kumar@linaro.org>
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

