Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 293FF5BA9C
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2019 13:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbfGAL0d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jul 2019 07:26:33 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45732 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728518AbfGAL0d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jul 2019 07:26:33 -0400
Received: by mail-pl1-f193.google.com with SMTP id bi6so7203047plb.12
        for <linux-pm@vger.kernel.org>; Mon, 01 Jul 2019 04:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mFea1NB8cblkfncT7oG1ziy//jPVykLkqdpiv/Sj2rY=;
        b=q19Xf6xVs1WEk56gh2njTMtLGT4SpsfN/TXoLH9k4sqQi59MufkhkvAeeXC3l2LCSu
         SZ6W4q2yMLzgHu03nuSYNdtba3Jn3QwwNvjE7Uion8tr0a7/G/zPhGuPgOdXUGJ+25cy
         wlWCdjywjns9TWQx5VMyH7RZprrV6Gu36GWA7y1K05pMHnf8Z7DGK7oI6S1FUZwqJTG8
         2KydMVt9I5y35NH9iz/2n38MJCARtEExNSwWxs5WoJH6tFJEI0Sg8G7SqCgwgzWVjq8R
         efXpYwBNUokSdc3vSa4TSPc9a7oqHMc+vGv7SMhGuo1C2R19ev6i86x+uMI7kRDHcRVE
         igKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mFea1NB8cblkfncT7oG1ziy//jPVykLkqdpiv/Sj2rY=;
        b=Rkqs1wgI6+CogbhaSfrG3AltLGF9Pu3jA3eSTj1AEFYwwBRhU8LOvPXB786RGSBriN
         9TMo6RmN3Od8x/d+1Ei+g2w58DrOGpjnMxFOlYZzJVj1RpZ0PUaW4xAAt/YYiSSqgUbL
         z1+30lwpjTwMWsAAe85bjH0oYP6MEyzljGVgj7tjy+xaVtkihloTIbUljQ1mQmSazQmd
         nZbRNUp5/HjjrSKzGrqiAoyezCMbsiAq3t6ileRq5+7yvCKCHezBC2BqYLcVOabmbGz7
         gBPaCcfDiTELrK6POOAokY7CXPBBXzO3u4fHtcqyO1otdcI4LN+GQH0vqMUYj9UKzXtW
         gfJg==
X-Gm-Message-State: APjAAAVWqqTE8jWN+dVwpAsAr4CtaX9++S83NCrlE403WTxHtlWNwXlh
        JzYFV+Krp6b+WyBtrSEkqzr06g==
X-Google-Smtp-Source: APXvYqxd/kWHYOBpA2Tbd26P/S/8mwpWXYYmGaz07CERnq8AYBpub/54s8vuktaM+1fAG5wVZcty/g==
X-Received: by 2002:a17:902:1101:: with SMTP id d1mr28742850pla.212.1561980392649;
        Mon, 01 Jul 2019 04:26:32 -0700 (PDT)
Received: from localhost ([122.172.21.205])
        by smtp.gmail.com with ESMTPSA id m100sm12021381pje.12.2019.07.01.04.26.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 04:26:32 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, mka@chromium.org, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 3/7] PM / QOS: Pass request type to dev_pm_qos_read_value()
Date:   Mon,  1 Jul 2019 16:56:11 +0530
Message-Id: <58c6b468b1c2656df03a8265e82e2e4b8427d687.1561979715.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1561979715.git.viresh.kumar@linaro.org>
References: <cover.1561979715.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to allow dev_pm_qos_read_value() to read values for different
QoS requests, pass request type as a parameter to these routines.

For now, it only supports resume-latency request type but will be
extended to frequency limit (min/max) constraints later on.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/power/pm_qos_interface.txt |  2 +-
 drivers/base/power/domain_governor.c     |  2 +-
 drivers/base/power/qos.c                 | 17 ++++++++++++-----
 include/linux/pm_qos.h                   | 16 +++++++++++++---
 4 files changed, 27 insertions(+), 10 deletions(-)

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
index 20e56a5be01f..daa8c7689f7e 100644
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
 
diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 7a0d197f0809..2461fed0efa0 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -105,18 +105,25 @@ s32 __dev_pm_qos_resume_latency(struct device *dev)
 /**
  * dev_pm_qos_read_value - Get PM QoS constraint for a given device (locked).
  * @dev: Device to get the PM QoS constraint value for.
+ * @type: QoS request type.
  */
-s32 dev_pm_qos_read_value(struct device *dev)
+s32 dev_pm_qos_read_value(struct device *dev, enum dev_pm_qos_req_type type)
 {
+	struct dev_pm_qos *qos = dev->power.qos;
 	unsigned long flags;
 	s32 ret;
 
 	spin_lock_irqsave(&dev->power.lock, flags);
 
-	if (IS_ERR_OR_NULL(dev->power.qos))
-		ret = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
-	else
-		ret = pm_qos_read_value(&dev->power.qos->resume_latency);
+	switch (type) {
+	case DEV_PM_QOS_RESUME_LATENCY:
+		ret = IS_ERR_OR_NULL(qos) ? PM_QOS_RESUME_LATENCY_NO_CONSTRAINT
+			: pm_qos_read_value(&qos->resume_latency);
+		break;
+	default:
+		WARN_ON(1);
+		ret = 0;
+	}
 
 	spin_unlock_irqrestore(&dev->power.lock, flags);
 
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 06aa88496761..5ce1c310373e 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -140,7 +140,7 @@ s32 pm_qos_read_value(struct pm_qos_constraints *c);
 enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev, s32 mask);
 enum pm_qos_flags_status dev_pm_qos_flags(struct device *dev, s32 mask);
 s32 __dev_pm_qos_resume_latency(struct device *dev);
-s32 dev_pm_qos_read_value(struct device *dev);
+s32 dev_pm_qos_read_value(struct device *dev, enum dev_pm_qos_req_type type);
 int dev_pm_qos_add_request(struct device *dev, struct dev_pm_qos_request *req,
 			   enum dev_pm_qos_req_type type, s32 value);
 int dev_pm_qos_update_request(struct dev_pm_qos_request *req, s32 new_value);
@@ -191,8 +191,18 @@ static inline enum pm_qos_flags_status dev_pm_qos_flags(struct device *dev,
 			{ return PM_QOS_FLAGS_UNDEFINED; }
 static inline s32 __dev_pm_qos_resume_latency(struct device *dev)
 			{ return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT; }
-static inline s32 dev_pm_qos_read_value(struct device *dev)
-			{ return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT; }
+static inline s32 dev_pm_qos_read_value(struct device *dev,
+					enum dev_pm_qos_req_type type)
+{
+	switch type {
+	case DEV_PM_QOS_RESUME_LATENCY:
+		return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
+	default:
+		WARN_ON(1);
+		return 0;
+	}
+}
+
 static inline int dev_pm_qos_add_request(struct device *dev,
 					 struct dev_pm_qos_request *req,
 					 enum dev_pm_qos_req_type type,
-- 
2.21.0.rc0.269.g1a574e7a288b

