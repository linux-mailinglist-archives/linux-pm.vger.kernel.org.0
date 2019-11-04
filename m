Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB5DEEEED
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 23:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389011AbfKDWBR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 17:01:17 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37438 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388999AbfKDWBR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 17:01:17 -0500
Received: by mail-lj1-f195.google.com with SMTP id l20so732198lje.4;
        Mon, 04 Nov 2019 14:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bKkhPNpVCeAxCnkh4nfALfAwjSjtpvS+Vk+nADvtRH0=;
        b=koN7DB+ZefwCQMKp/nxsHUfDct6cxXA5tbzeGSH0sZe0C9rluLztAwaykp2gdWcuww
         idUskPNVZEZ9uI+DkP2qW/sKLimLG36AX4UUbkx4nTtoz280R2qFcix6k18Tl7MYn7Jk
         h7orxd2srF2Pm/GTsJwj1zffFUMiCFbPgH2IXPaUGInodYBRIgAhzp1xODedTtY7N5fb
         KIdyNHSR4fJBlf8rtvpY+LRbCwsxeykamJ1BHRB6K1qSM0HKYhMrA1AsCaOjBDQuwNZU
         2WT+EqoeNt6j+RujVrXMWkxbGPviyaZhgUmiqcL0jpX/Wul4sJ7+Lo9RpbDcKz5WZou2
         EE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bKkhPNpVCeAxCnkh4nfALfAwjSjtpvS+Vk+nADvtRH0=;
        b=RlsSNex7+php9Dz6366k7f8IstzUnh9ZSpaMth0r9D6zV57ugIXs1prjwhXS3uiFiq
         bHofm9yHms6LzGZniSOmOUTk45J3/TQNGGg0l/AaQm2W1NTjBTqMEwKrEwuBRDjL1O5L
         ngeVOpmRdCOjk3+mnZ8bgnofxvABWhtBe9nofdf/RQhWuv5XEsjyqVeG27nxQYOozhiR
         ezsuBL0vNtNLkEZZhOwjhqlvGyElMUT4MS8zkXkLs42YUnxGlmRpcRQn9JRaj+Aoxa72
         RqFnlJXgJW4S1Ooajm/MozXiGhPxWAVQDrI+3HuSFlAq2zThKfmm+yp8SrC0BEViCQYj
         d6SA==
X-Gm-Message-State: APjAAAVY85e6G80Hlzhk4yvGN3199AtgTkuNr280zwV0Fo/iP49UpwFP
        BpW2OmpX+oo4EPYeFGcEJT8=
X-Google-Smtp-Source: APXvYqwYiPr+gYGHNCklPmFijFb1E/THpBVHFVr4bLo9PkUH8EIm9ISa8vfr6rqayJ2Ph37eSnD3nw==
X-Received: by 2002:a2e:970e:: with SMTP id r14mr4447739lji.57.1572904874763;
        Mon, 04 Nov 2019 14:01:14 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id g3sm7454669ljj.59.2019.11.04.14.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 14:01:14 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 16/19] PM / devfreq: Add new interrupt_driven flag for governors
Date:   Tue,  5 Nov 2019 00:56:14 +0300
Message-Id: <20191104215617.25544-17-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104215617.25544-1-digetx@gmail.com>
References: <20191104215617.25544-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently interrupt-driven governors (like NVIDIA Tegra30 ACTMON governor)
are used to set polling_ms=0 in order to avoid periodic polling of device
status by devfreq core. This means that polling interval can't be changed
by userspace for such governors.

The new governor flag allows interrupt-driven governors to convey that
devfreq core shouldn't perform polling of device status and thus generic
devfreq polling interval could be supported by these governors now.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/devfreq.c  | 17 +++++++++++++++++
 drivers/devfreq/governor.h |  3 +++
 2 files changed, 20 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index b905963cea7d..4eff37e8bb07 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -409,6 +409,9 @@ static void devfreq_monitor(struct work_struct *work)
  */
 void devfreq_monitor_start(struct devfreq *devfreq)
 {
+	if (devfreq->governor->interrupt_driven)
+		return;
+
 	INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
 	if (devfreq->profile->polling_ms)
 		queue_delayed_work(devfreq_wq, &devfreq->work,
@@ -426,6 +429,9 @@ EXPORT_SYMBOL(devfreq_monitor_start);
  */
 void devfreq_monitor_stop(struct devfreq *devfreq)
 {
+	if (devfreq->governor->interrupt_driven)
+		return;
+
 	cancel_delayed_work_sync(&devfreq->work);
 }
 EXPORT_SYMBOL(devfreq_monitor_stop);
@@ -453,6 +459,10 @@ void devfreq_monitor_suspend(struct devfreq *devfreq)
 	devfreq_update_status(devfreq, devfreq->previous_freq);
 	devfreq->stop_polling = true;
 	mutex_unlock(&devfreq->lock);
+
+	if (devfreq->governor->interrupt_driven)
+		return;
+
 	cancel_delayed_work_sync(&devfreq->work);
 }
 EXPORT_SYMBOL(devfreq_monitor_suspend);
@@ -473,11 +483,15 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
 	if (!devfreq->stop_polling)
 		goto out;
 
+	if (devfreq->governor->interrupt_driven)
+		goto out_update;
+
 	if (!delayed_work_pending(&devfreq->work) &&
 			devfreq->profile->polling_ms)
 		queue_delayed_work(devfreq_wq, &devfreq->work,
 			msecs_to_jiffies(devfreq->profile->polling_ms));
 
+out_update:
 	devfreq->last_stat_updated = jiffies;
 	devfreq->stop_polling = false;
 
@@ -509,6 +523,9 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
 	if (devfreq->stop_polling)
 		goto out;
 
+	if (devfreq->governor->interrupt_driven)
+		goto out;
+
 	/* if new delay is zero, stop polling */
 	if (!new_delay) {
 		mutex_unlock(&devfreq->lock);
diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index bbe5ff9fcecf..dc7533ccc3db 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -31,6 +31,8 @@
  * @name:		Governor's name
  * @immutable:		Immutable flag for governor. If the value is 1,
  *			this govenror is never changeable to other governor.
+ * @interrupt_driven:	Devfreq core won't schedule polling work for this
+ *			governor if value is set to 1.
  * @get_target_freq:	Returns desired operating frequency for the device.
  *			Basically, get_target_freq will run
  *			devfreq_dev_profile.get_dev_status() to get the
@@ -49,6 +51,7 @@ struct devfreq_governor {
 
 	const char name[DEVFREQ_NAME_LEN];
 	const unsigned int immutable;
+	const unsigned int interrupt_driven;
 	int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
 	int (*event_handler)(struct devfreq *devfreq,
 				unsigned int event, void *data);
-- 
2.23.0

