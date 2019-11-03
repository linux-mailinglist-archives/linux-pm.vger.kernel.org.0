Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 534D4ED4E5
	for <lists+linux-pm@lfdr.de>; Sun,  3 Nov 2019 21:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfKCUmo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Nov 2019 15:42:44 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44720 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbfKCUmT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Nov 2019 15:42:19 -0500
Received: by mail-lf1-f65.google.com with SMTP id v4so10692261lfd.11;
        Sun, 03 Nov 2019 12:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8UXqS4ThUjHuxqqTSzYOn6v7GnY2Pzlt7kScAbd0iac=;
        b=k3EyGu8F9E3nTMASVj00fxk+7PiRZyDLQcqC85dCcwP3fifgYwxUKzFSxvMpno0/R8
         auEYcVsF7rg1KWvotY4n5X6Oh22dctfhBjJI0Sbpw2m3WhJCJ317/GC4sjSC1TxePr5W
         l3Lzb10KQ17k2u8GyVmdvFdrKrWupT1k/IdcSdVXzDyPw/yRnsYp6ZRjo6KltrEW8zI+
         eb+vWA88ePXjF0OKp6tWcrN9TUpEzT16Y4vEwLJChiSXBJ22be4+bTO1os84yQzFJ6iB
         WB/s9lpg0YJmxrMQkd1eiQ/ERQKGcGuquSHzcdkG2VQc0+LK8uJn3/UcoZeyJ72/BLtX
         lmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8UXqS4ThUjHuxqqTSzYOn6v7GnY2Pzlt7kScAbd0iac=;
        b=in3SMoo5Tu8iTLzvCIlimY7iKP1bntiz8X1qDh/P2XRG5x9gn2DYQxoLmuJ+AKE6C1
         NjMRV4yKxQxu4DA3OsFw8w4FYeI/i18ryJV6JkWLjsPLf5z2waAeL1Gx+xt0eEMWrbzp
         HQJFC3/l/cpwYW11rLyZgsOzCOrV0v7xXYw+7bwB459mX73pUX7W7ey/J3o0vpi2Z3/G
         ik3jBEr09IDxo3c/c79SVWZQX0H/EHVUmBTObxB7IIitUhFqfV3HHY4B5IlCayC1AOj5
         MOQ7N1weQsNjGT6yPxQ8hY8Tu8m9fXF50Q/TH8IzMdpo8Ad13R5jFQtEmuNkjeTDaLvP
         cFxA==
X-Gm-Message-State: APjAAAWBPDEJseTwnaB8ZARz3En5l0QevxkqPy+/oG3LkGUePHb/Ga1N
        CnaiESL06Tt1wU/Z9PVTLt4=
X-Google-Smtp-Source: APXvYqztuWCPmC764oQvwL21tQhnltoMdp/pbeDoeWa+YTmemszjJJy4Qu8kIelZcZ04zJ8CNnKX5A==
X-Received: by 2002:ac2:5967:: with SMTP id h7mr13823850lfp.119.1572813736906;
        Sun, 03 Nov 2019 12:42:16 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id e22sm7099853ljg.73.2019.11.03.12.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 12:42:16 -0800 (PST)
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
Subject: [PATCH v8 15/18] PM / devfreq: Add new interrupt_driven flag for governors
Date:   Sun,  3 Nov 2019 23:41:27 +0300
Message-Id: <20191103204130.2172-16-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191103204130.2172-1-digetx@gmail.com>
References: <20191103204130.2172-1-digetx@gmail.com>
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
 drivers/devfreq/devfreq.c  | 9 +++++++--
 drivers/devfreq/governor.h | 3 +++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index b905963cea7d..a711a76d386e 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -410,7 +410,8 @@ static void devfreq_monitor(struct work_struct *work)
 void devfreq_monitor_start(struct devfreq *devfreq)
 {
 	INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
-	if (devfreq->profile->polling_ms)
+	if (devfreq->profile->polling_ms &&
+	    !devfreq->governor->interrupt_driven)
 		queue_delayed_work(devfreq_wq, &devfreq->work,
 			msecs_to_jiffies(devfreq->profile->polling_ms));
 }
@@ -474,7 +475,8 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
 		goto out;
 
 	if (!delayed_work_pending(&devfreq->work) &&
-			devfreq->profile->polling_ms)
+			devfreq->profile->polling_ms &&
+			!devfreq->governor->interrupt_driven)
 		queue_delayed_work(devfreq_wq, &devfreq->work,
 			msecs_to_jiffies(devfreq->profile->polling_ms));
 
@@ -509,6 +511,9 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
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

