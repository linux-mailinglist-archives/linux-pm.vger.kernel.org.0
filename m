Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFE52137530
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2020 18:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbgAJRta (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jan 2020 12:49:30 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45843 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbgAJRt1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jan 2020 12:49:27 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so1459227pfg.12
        for <linux-pm@vger.kernel.org>; Fri, 10 Jan 2020 09:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5G0JpOASU+8dPsw9dyToFF25u9NctuOa5AaKBeNFrAY=;
        b=czka4vUoD1xWX1/aGwkqdC76JzOAtN32sVjXs6ELnC11Vep4p5Ae47bSXJUK+y18YP
         bG0uY3Dh9CriOpwtgcn5L6NNzQj1EsmEN6c9//vn+Jelc80dd3CZ1RChbybS+6eUt1qX
         BYRGpWIafdWaZ5xoUf9aW6XohXCc7c1KXrdzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5G0JpOASU+8dPsw9dyToFF25u9NctuOa5AaKBeNFrAY=;
        b=UCV1MxlEvaTv541K3YshelGbhmrT/d70sQ05JgXXspfvaBgSh8MmyXbdgQFfF2Oa77
         IurwIkPdTDx31UmQg+WqnC5zx1qAcKL38yMVCxMSGiP4C2vPlj1GOwsafqmx2tyzcsSS
         ijltLmDYwquisp+6YbLLlz8mZV+ZFEx29KKhoR603awlB7ngwRt7h/O+K0egPjPAYCNx
         u/+7zB2p9JOSOQXNeCMEcioouOo/j2e3IO3UxwtZw2E6lNZMobGWBHk7jE0gA8i3BWA7
         bA1X+O4eqqiPYCgi/YU1I2D1dcH391rMjVxM61J71NPyutEH7CPeXzJ/3hHk421+S/cj
         V5Ug==
X-Gm-Message-State: APjAAAXP+aylY36+dYwpG3re7AGkfFjjfOWJJ00Q/qcW6w3vGRad42rL
        EvfU+PSROfIBcHTtfjuI6IXASw==
X-Google-Smtp-Source: APXvYqxQf/b4p2w/6EVZpvlmPOXsCK5KnE33nu8UunvaeRIukRmlLKB3Lq8IbNv0+zddIinr4awbLA==
X-Received: by 2002:a62:b418:: with SMTP id h24mr5673684pfn.192.1578678566514;
        Fri, 10 Jan 2020 09:49:26 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id a6sm3369154pgg.25.2020.01.10.09.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 09:49:26 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 2/2] PM / devfreq: Use exclusively PM QoS to determine frequency limits
Date:   Fri, 10 Jan 2020 09:49:19 -0800
Message-Id: <20200110094913.2.Ie8eacf976ce7a13e421592f5c1ab8dbdc537da5c@changeid>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
In-Reply-To: <20200110094913.1.I146403d05b9ec82f48b807efd416a57f545b447a@changeid>
References: <20200110094913.1.I146403d05b9ec82f48b807efd416a57f545b447a@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Traditionally devfreq cooling devices dynamically disabled OPPs
that shouldn't be used because of thermal pressure. Devfreq cooling
devices now use PM QoS to set frequency limits, hence the devfreq
code dealing that deals with disabled OPPs can be removed.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 drivers/devfreq/devfreq.c | 75 +++++----------------------------------
 include/linux/devfreq.h   |  4 ---
 2 files changed, 8 insertions(+), 71 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 57f6944d65a6..ec66e2c27cc4 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -73,34 +73,6 @@ static struct devfreq *find_device_devfreq(struct device *dev)
 	return ERR_PTR(-ENODEV);
 }
 
-static unsigned long find_available_min_freq(struct devfreq *devfreq)
-{
-	struct dev_pm_opp *opp;
-	unsigned long min_freq = 0;
-
-	opp = dev_pm_opp_find_freq_ceil(devfreq->dev.parent, &min_freq);
-	if (IS_ERR(opp))
-		min_freq = 0;
-	else
-		dev_pm_opp_put(opp);
-
-	return min_freq;
-}
-
-static unsigned long find_available_max_freq(struct devfreq *devfreq)
-{
-	struct dev_pm_opp *opp;
-	unsigned long max_freq = ULONG_MAX;
-
-	opp = dev_pm_opp_find_freq_floor(devfreq->dev.parent, &max_freq);
-	if (IS_ERR(opp))
-		max_freq = 0;
-	else
-		dev_pm_opp_put(opp);
-
-	return max_freq;
-}
-
 /**
  * get_freq_range() - Get the current freq range
  * @devfreq:	the devfreq instance
@@ -141,10 +113,6 @@ static void get_freq_range(struct devfreq *devfreq,
 		*max_freq = min(*max_freq,
 				(unsigned long)HZ_PER_KHZ * qos_max_freq);
 
-	/* Apply constraints from OPP interface */
-	*min_freq = max(*min_freq, devfreq->scaling_min_freq);
-	*max_freq = min(*max_freq, devfreq->scaling_max_freq);
-
 	if (*min_freq > *max_freq)
 		*min_freq = *max_freq;
 }
@@ -610,23 +578,10 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
 				 void *devp)
 {
 	struct devfreq *devfreq = container_of(nb, struct devfreq, nb);
-	int err = -EINVAL;
+	int err;
 
 	mutex_lock(&devfreq->lock);
-
-	devfreq->scaling_min_freq = find_available_min_freq(devfreq);
-	if (!devfreq->scaling_min_freq)
-		goto out;
-
-	devfreq->scaling_max_freq = find_available_max_freq(devfreq);
-	if (!devfreq->scaling_max_freq) {
-		devfreq->scaling_max_freq = ULONG_MAX;
-		goto out;
-	}
-
 	err = update_devfreq(devfreq);
-
-out:
 	mutex_unlock(&devfreq->lock);
 	if (err)
 		dev_err(devfreq->dev.parent,
@@ -781,19 +736,15 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		mutex_lock(&devfreq->lock);
 	}
 
-	devfreq->scaling_min_freq = find_available_min_freq(devfreq);
-	if (!devfreq->scaling_min_freq) {
-		mutex_unlock(&devfreq->lock);
-		err = -EINVAL;
+	err = dev_pm_qos_add_request(dev, &devfreq->user_min_freq_req,
+				     DEV_PM_QOS_MIN_FREQUENCY, 0);
+	if (err < 0)
 		goto err_dev;
-	}
-
-	devfreq->scaling_max_freq = find_available_max_freq(devfreq);
-	if (!devfreq->scaling_max_freq) {
-		mutex_unlock(&devfreq->lock);
-		err = -EINVAL;
+	err = dev_pm_qos_add_request(dev, &devfreq->user_max_freq_req,
+				     DEV_PM_QOS_MAX_FREQUENCY,
+				     PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
+	if (err < 0)
 		goto err_dev;
-	}
 
 	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
 	atomic_set(&devfreq->suspend_count, 0);
@@ -834,16 +785,6 @@ struct devfreq *devfreq_add_device(struct device *dev,
 
 	mutex_unlock(&devfreq->lock);
 
-	err = dev_pm_qos_add_request(dev, &devfreq->user_min_freq_req,
-				     DEV_PM_QOS_MIN_FREQUENCY, 0);
-	if (err < 0)
-		goto err_devfreq;
-	err = dev_pm_qos_add_request(dev, &devfreq->user_max_freq_req,
-				     DEV_PM_QOS_MAX_FREQUENCY,
-				     PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
-	if (err < 0)
-		goto err_devfreq;
-
 	devfreq->nb_min.notifier_call = qos_min_notifier_call;
 	err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_min,
 				      DEV_PM_QOS_MIN_FREQUENCY);
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index fb376b5b7281..cb75f23ad2f4 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -126,8 +126,6 @@ struct devfreq_dev_profile {
  *		touch this.
  * @user_min_freq_req:	PM QoS minimum frequency request from user (via sysfs)
  * @user_max_freq_req:	PM QoS maximum frequency request from user (via sysfs)
- * @scaling_min_freq:	Limit minimum frequency requested by OPP interface
- * @scaling_max_freq:	Limit maximum frequency requested by OPP interface
  * @stop_polling:	 devfreq polling status of a device.
  * @suspend_freq:	 frequency of a device set during suspend phase.
  * @resume_freq:	 frequency of a device set in resume phase.
@@ -166,8 +164,6 @@ struct devfreq {
 
 	struct dev_pm_qos_request user_min_freq_req;
 	struct dev_pm_qos_request user_max_freq_req;
-	unsigned long scaling_min_freq;
-	unsigned long scaling_max_freq;
 	bool stop_polling;
 
 	unsigned long suspend_freq;
-- 
2.25.0.rc1.283.g88dfdc4193-goog

