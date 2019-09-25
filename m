Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06764BE4D2
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2019 20:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443261AbfIYSnW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 14:43:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45718 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443258AbfIYSnW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2019 14:43:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id 4so354461pgm.12
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2019 11:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3A4s4RAXbpx36Yd7dMGiPVWfF4wDLnMwffQrqpB84M0=;
        b=MI/R7xaYsceleFAz49M00sHxNJtNP9akqwlvZAmxoudAzKmmz7M/h984nTRYIZLyIV
         wCrF5z9qpwpvcsI5fmQKA2msao8HOViN0LSmtdHnn7e1e8iRzS3r2b8RnmEuBtR5dxeH
         B90dhU3GBvA301hKZajAs5Q3jo8xBeHkw0wLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3A4s4RAXbpx36Yd7dMGiPVWfF4wDLnMwffQrqpB84M0=;
        b=qUBcsEu9DeiCwpqCTRPAtwygV53wA8aCPIr11FJ4C0+w3UW87Tl/ePaiNWG7WJx7gF
         DhodsgsXxsOSTH+vwJLyHuOxwazqLpOTOb9JDnvUOnfiJyRitz+kmW5qEVgktVOe+AL8
         FZrPw0+5VUFySxz3RJRWiQHxiGNc/Jwl7+4+tJ482n00abhtr6kc/5hZZDkdGFUejCCa
         tilaftx+xrijGvn3UdPZhPCwIsCHKCBcc/a0j4aSLQRe5l1umujKqc1bhEEVy22uX3Vk
         UMjYwWSdtf4j1r3F7gXE6HlpmEjAOTo8O6qUiSpoYvuI4+Dqdt4OR5XOc9V+rMquA+7K
         naNw==
X-Gm-Message-State: APjAAAX+0uneyHGYFA2CzbTgInU94tvUBUXuKPx+i5stNwZUF2ZtoPuT
        O0CdrtKr8qnVWNhiauV+aooXAA==
X-Google-Smtp-Source: APXvYqwW5vuL8lovJSQXdUV5+1pDcGdZZ1mTw1Iakz6inPcxVjmOF4tVz0FIAXiNfJXeeaRvnVZuKQ==
X-Received: by 2002:aa7:9d8d:: with SMTP id f13mr11549654pfq.196.1569437000973;
        Wed, 25 Sep 2019 11:43:20 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id y28sm6869466pfq.48.2019.09.25.11.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 11:43:20 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 2/2] devfreq: Rename df->previous_freq to df->cur_freq
Date:   Wed, 25 Sep 2019 11:43:14 -0700
Message-Id: <20190925184314.30251-2-mka@chromium.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20190925184314.30251-1-mka@chromium.org>
References: <20190925184314.30251-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The vast majority of code uses df->previous_freq to get the current
frequency of the devfreq device, not the previous one. Rename the
struct field to reflect this.

Add a comment to devfreq_update_stats() to make clear that df->cur_freq
must only be updated after calling this function in the context of a
frequency transition.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/devfreq/devfreq.c            | 28 ++++++++++++++++------------
 drivers/devfreq/governor_passive.c   |  6 +++---
 drivers/devfreq/governor_userspace.c |  2 +-
 drivers/devfreq/tegra20-devfreq.c    |  2 +-
 drivers/devfreq/tegra30-devfreq.c    |  2 +-
 include/linux/devfreq.h              |  4 ++--
 include/trace/events/devfreq.h       |  2 +-
 7 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index fb4318d59aa9..bf42130bb4ec 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -154,6 +154,10 @@ static int set_freq_table(struct devfreq *devfreq)
  * devfreq_update_stats() - Update statistics of devfreq behavior
  * @devfreq:	the devfreq instance
  * @freq:	the update target frequency
+ *
+ * If the function is called in the context of a frequency transition
+ * it expects df->cur_freq to contain the value *before* the transition.
+ * The field must only be updated after calling devfreq_update_stats().
  */
 int devfreq_update_stats(struct devfreq *devfreq, unsigned long freq)
 {
@@ -162,11 +166,11 @@ int devfreq_update_stats(struct devfreq *devfreq, unsigned long freq)
 
 	cur_time = jiffies;
 
-	/* Immediately exit if previous_freq is not initialized yet. */
-	if (!devfreq->previous_freq)
+	/* Immediately exit if cur_freq is not initialized yet. */
+	if (!devfreq->cur_freq)
 		goto out;
 
-	prev_lev = devfreq_get_freq_level(devfreq, devfreq->previous_freq);
+	prev_lev = devfreq_get_freq_level(devfreq, devfreq->cur_freq);
 	if (prev_lev < 0) {
 		ret = prev_lev;
 		goto out;
@@ -295,7 +299,7 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
 	if (devfreq->profile->get_cur_freq)
 		devfreq->profile->get_cur_freq(devfreq->dev.parent, &cur_freq);
 	else
-		cur_freq = devfreq->previous_freq;
+		cur_freq = devfreq->cur_freq;
 
 	freqs.old = cur_freq;
 	freqs.new = new_freq;
@@ -315,7 +319,7 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
 		dev_err(&devfreq->dev,
 			"Couldn't update frequency transition information.\n");
 
-	devfreq->previous_freq = new_freq;
+	devfreq->cur_freq = new_freq;
 
 	if (devfreq->suspend_freq)
 		devfreq->resume_freq = cur_freq;
@@ -450,7 +454,7 @@ void devfreq_monitor_suspend(struct devfreq *devfreq)
 		return;
 	}
 
-	devfreq_update_stats(devfreq, devfreq->previous_freq);
+	devfreq_update_stats(devfreq, devfreq->cur_freq);
 	devfreq->stop_polling = true;
 	mutex_unlock(&devfreq->lock);
 	cancel_delayed_work_sync(&devfreq->work);
@@ -483,7 +487,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
 
 	if (devfreq->profile->get_cur_freq &&
 		!devfreq->profile->get_cur_freq(devfreq->dev.parent, &freq))
-		devfreq->previous_freq = freq;
+		devfreq->cur_freq = freq;
 
 out:
 	mutex_unlock(&devfreq->lock);
@@ -644,7 +648,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->dev.release = devfreq_dev_release;
 	devfreq->profile = profile;
 	strncpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);
-	devfreq->previous_freq = profile->initial_freq;
+	devfreq->cur_freq = profile->initial_freq;
 	devfreq->last_status.current_frequency = profile->initial_freq;
 	devfreq->data = data;
 	devfreq->nb.notifier_call = devfreq_notifier_call;
@@ -1235,14 +1239,14 @@ static ssize_t cur_freq_show(struct device *dev, struct device_attribute *attr,
 		!devfreq->profile->get_cur_freq(devfreq->dev.parent, &freq))
 		return sprintf(buf, "%lu\n", freq);
 
-	return sprintf(buf, "%lu\n", devfreq->previous_freq);
+	return sprintf(buf, "%lu\n", devfreq->cur_freq);
 }
 static DEVICE_ATTR_RO(cur_freq);
 
 static ssize_t target_freq_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%lu\n", to_devfreq(dev)->previous_freq);
+	return sprintf(buf, "%lu\n", to_devfreq(dev)->cur_freq);
 }
 static DEVICE_ATTR_RO(target_freq);
 
@@ -1398,7 +1402,7 @@ static ssize_t trans_stat_show(struct device *dev,
 	unsigned int max_state = devfreq->profile->max_state;
 
 	if (!devfreq->stop_polling &&
-			devfreq_update_stats(devfreq, devfreq->previous_freq))
+			devfreq_update_stats(devfreq, devfreq->cur_freq))
 		return 0;
 	if (max_state == 0)
 		return sprintf(buf, "Not Supported.\n");
@@ -1413,7 +1417,7 @@ static ssize_t trans_stat_show(struct device *dev,
 
 	for (i = 0; i < max_state; i++) {
 		if (devfreq->profile->freq_table[i]
-					== devfreq->previous_freq) {
+					== devfreq->cur_freq) {
 			len += sprintf(buf + len, "*");
 		} else {
 			len += sprintf(buf + len, " ");
diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 1c746b96d3db..2d818eaceb39 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -114,7 +114,7 @@ static int update_devfreq_passive(struct devfreq *devfreq, unsigned long freq)
 		dev_err(&devfreq->dev,
 			"Couldn't update frequency transition information.\n");
 
-	devfreq->previous_freq = freq;
+	devfreq->cur_freq = freq;
 
 out:
 	mutex_unlock(&devfreq->lock);
@@ -134,11 +134,11 @@ static int devfreq_passive_notifier_call(struct notifier_block *nb,
 
 	switch (event) {
 	case DEVFREQ_PRECHANGE:
-		if (parent->previous_freq > freq)
+		if (parent->cur_freq > freq)
 			update_devfreq_passive(devfreq, freq);
 		break;
 	case DEVFREQ_POSTCHANGE:
-		if (parent->previous_freq < freq)
+		if (parent->cur_freq < freq)
 			update_devfreq_passive(devfreq, freq);
 		break;
 	}
diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
index af94942fcf95..566b8d1f0c17 100644
--- a/drivers/devfreq/governor_userspace.c
+++ b/drivers/devfreq/governor_userspace.c
@@ -26,7 +26,7 @@ static int devfreq_userspace_func(struct devfreq *df, unsigned long *freq)
 	if (data->valid)
 		*freq = data->user_frequency;
 	else
-		*freq = df->previous_freq; /* No user freq specified yet */
+		*freq = df->cur_freq; /* No user freq specified yet */
 
 	return 0;
 }
diff --git a/drivers/devfreq/tegra20-devfreq.c b/drivers/devfreq/tegra20-devfreq.c
index ff82bac9ee4e..f99bd6557df5 100644
--- a/drivers/devfreq/tegra20-devfreq.c
+++ b/drivers/devfreq/tegra20-devfreq.c
@@ -61,7 +61,7 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 	return 0;
 
 restore_min_rate:
-	clk_set_min_rate(tegra->emc_clock, devfreq->previous_freq);
+	clk_set_min_rate(tegra->emc_clock, devfreq->cur_freq);
 
 	return err;
 }
diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 536273a811fe..7b3bf7a0b15f 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -474,7 +474,7 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 	return 0;
 
 restore_min_rate:
-	clk_set_min_rate(tegra->emc_clock, devfreq->previous_freq);
+	clk_set_min_rate(tegra->emc_clock, devfreq->cur_freq);
 
 	return err;
 }
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 2bae9ed3c783..21d0108df4c5 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -120,7 +120,7 @@ struct devfreq_dev_profile {
  *		reevaluate operable frequencies. Devfreq users may use
  *		devfreq.nb to the corresponding register notifier call chain.
  * @work:	delayed work for load monitoring.
- * @previous_freq:	previously configured frequency value.
+ * @cur_freq:	the current frequency.
  * @data:	Private data of the governor. The devfreq framework does not
  *		touch this.
  * @min_freq:	Limit minimum frequency requested by user (0: none)
@@ -156,7 +156,7 @@ struct devfreq {
 	struct notifier_block nb;
 	struct delayed_work work;
 
-	unsigned long previous_freq;
+	unsigned long cur_freq;
 	struct devfreq_dev_status last_status;
 
 	void *data; /* private data for governors */
diff --git a/include/trace/events/devfreq.h b/include/trace/events/devfreq.h
index cf5b8772175d..916cfaed5489 100644
--- a/include/trace/events/devfreq.h
+++ b/include/trace/events/devfreq.h
@@ -22,7 +22,7 @@ TRACE_EVENT(devfreq_monitor,
 	),
 
 	TP_fast_assign(
-		__entry->freq = devfreq->previous_freq;
+		__entry->freq = devfreq->cur_freq;
 		__entry->busy_time = devfreq->last_status.busy_time;
 		__entry->total_time = devfreq->last_status.total_time;
 		__entry->polling_ms = devfreq->profile->polling_ms;
-- 
2.23.0.444.g18eeb5a265-goog

