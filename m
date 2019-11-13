Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA1B9FACB1
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 10:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfKMJN4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 04:13:56 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:32961 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbfKMJNz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 04:13:55 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191113091353euoutp02ed582669be7682fc13414865bd93f600~Wrf-KA7Bs2229622296euoutp02k
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2019 09:13:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191113091353euoutp02ed582669be7682fc13414865bd93f600~Wrf-KA7Bs2229622296euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573636433;
        bh=RN3M6NGDwfSrIDMXV1ECarDkUOgoQmAqCZDQaPlLzGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pLT7ngax6MOzLJ/J+HBUNYGLCexTEHJEHMTWePru0hJWvv6pggwieeLg0Qxnqa4R7
         pcP1OVrQ0LBz7jNZoAHUdvqqULaZrICH+VXSPOREm3wwLjnllBgPbUHzdypfPiDdiz
         IGLaR+GFoT+TuaKdU2MujQgCJDPpHQCKJxnoTAos=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191113091353eucas1p1663dcbc0990a252b7c38a95b40e756d8~Wrf_7OX2R1712317123eucas1p1M;
        Wed, 13 Nov 2019 09:13:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A7.82.04469.159CBCD5; Wed, 13
        Nov 2019 09:13:53 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191113091353eucas1p283be3173c7a9ea726b4767f9cb113f0f~Wrf_psG_H2485524855eucas1p2N;
        Wed, 13 Nov 2019 09:13:53 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191113091353eusmtrp1ec110aef3d0a253e26b7ab2bd467f195~Wrf_pDb5_1033410334eusmtrp1F;
        Wed, 13 Nov 2019 09:13:53 +0000 (GMT)
X-AuditID: cbfec7f2-569ff70000001175-b0-5dcbc9514cec
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9A.DA.04117.159CBCD5; Wed, 13
        Nov 2019 09:13:53 +0000 (GMT)
Received: from AMDC3218.digital.local (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191113091352eusmtip17b7ddd21cc8578c4caa048af473b8941~Wrf_LtsQj2887828878eusmtip16;
        Wed, 13 Nov 2019 09:13:52 +0000 (GMT)
From:   Kamil Konieczny <k.konieczny@samsung.com>
To:     k.konieczny@samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kamil Konieczny <k.konieczny@partner.samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH 5/7] devfreq: move transition statistics to devfreq profile
 structure
Date:   Wed, 13 Nov 2019 10:13:34 +0100
Message-Id: <20191113091336.5218-6-k.konieczny@samsung.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191113091336.5218-1-k.konieczny@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsWy7djP87qBJ0/HGqy9q2axccZ6VovrX56z
        WvTt+89oseDTDFaL8+c3sFucbXrDbnF51xw2i8+9Rxgt1h65y25xu3EFmwOXx6ZVnWweB9/t
        YfLo27KK0ePzJrkAligum5TUnMyy1CJ9uwSujB2vrzEWTAupWHlvOmsDY4drFyMnh4SAicTl
        xutsXYxcHEICKxgl5t1azw7hfGGUWDXjDVTmM6PE46Y3LDAtzed/MkEkljNKzN59lgWuZcLc
        bWBVbAL6EgfPngSzRQSkJToXTQTrYBb4zSSx9c9exi5GDg5hgXCJG0/0QGpYBFQlus/2MYHY
        vALWEg/+/GECKZEQkJeY81YDJMwpYCOx9OcadogSQYmTM5+AjWcGKmneOpsZZLyEwDx2if1r
        jzFCXOoicaN9FSuELSzx6vgWdghbRuL05B6ob8olni7sY4dobmGUeND+ESphLXH4+EVWkCOY
        BTQl1u/Shwg7Sqz4voIF4jY+iRtvBSFu4JOYtG06M0SYV6KjTQiiWlXi+akeJghbWqLr/zqo
        azwkVtzayjiBUXEWkm9mIflmFsLeBYzMqxjFU0uLc9NTiw3zUsv1ihNzi0vz0vWS83M3MQLT
        z+l/xz/tYPx6KekQowAHoxIPr8TCU7FCrIllxZW5hxglOJiVRHh3VJyIFeJNSaysSi3Kjy8q
        zUktPsQozcGiJM5bzfAgWkggPbEkNTs1tSC1CCbLxMEp1cBYO7GoxmFj6QWh2T/9av/X/S3e
        yLVhA6di8xzh81Kvjzm2fBY6vaqlYcvF6o9zrjetLtg6x85qps3XljmGm3x3Njv5LGy7XWga
        dmI2d9WcT62/vXf/Mnv3pDJwc07A+7jJSybHvVfayPj8q56dum206hT+OwtuBacF6qzRNHiw
        l/neZ9V8iUmeSizFGYmGWsxFxYkAfADY/DsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsVy+t/xu7qBJ0/HGnw+LGKxccZ6VovrX56z
        WvTt+89oseDTDFaL8+c3sFucbXrDbnF51xw2i8+9Rxgt1h65y25xu3EFmwOXx6ZVnWweB9/t
        YfLo27KK0ePzJrkAlig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TU
        nMyy1CJ9uwS9jB2vrzEWTAupWHlvOmsDY4drFyMnh4SAiUTz+Z9MXYxcHEICSxklmv5OYIdI
        SEs0nl7NBGELS/y51sUGUfSJUWLbp/tgCTYBfYmDZ0+ygNgiQA2diyaCTWIWaGSWuHigCaxI
        WCBU4vfh6WBFLAKqEt1n+8DivALWEg/+/AGyOYA2yEvMeasBEuYUsJFY+nMN2BFCQCVPNrxl
        gygXlDg58wnYGGag8uats5knMArMQpKahSS1gJFpFaNIamlxbnpusZFecWJucWleul5yfu4m
        RmCkbDv2c8sOxq53wYcYBTgYlXh4D8w7FSvEmlhWXJl7iFGCg1lJhHdHxYlYId6UxMqq1KL8
        +KLSnNTiQ4ymQD9MZJYSTc4HRnFeSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILU
        Ipg+Jg5OqQbGMrO/X0tMtGzijD3FF7tpe8y9rGpbqCzheOuQkdWv3xcPp0Q8l2aWUHt55Fzs
        Jb1rWeZMecXn7Gor/t/iNX+U9tcwbN0XRy/FvcvDb/ocV5SpDrbnXN2YddDIa/7Xg1Ocgjbs
        eFuarCCu2TVx3bb5//ze7p+9enNadrvm1J7VV00TjH4sqF+sxFKckWioxVxUnAgA/e8pKqoC
        AAA=
X-CMS-MailID: 20191113091353eucas1p283be3173c7a9ea726b4767f9cb113f0f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191113091353eucas1p283be3173c7a9ea726b4767f9cb113f0f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191113091353eucas1p283be3173c7a9ea726b4767f9cb113f0f
References: <20191113091336.5218-1-k.konieczny@samsung.com>
        <CGME20191113091353eucas1p283be3173c7a9ea726b4767f9cb113f0f@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Move transition statistics to devfreq profile structure. This is for
preparation for moving transition statistics into separate struct.
It is safe to do as frequency table and maximum state information are
already present in devfreq profile structure and there are no devfreq
drivers using more than one instance of devfreq structure per devfreq
profile one.

It also makes devfreq code more similar to cpufreq one.

Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
---
 drivers/devfreq/devfreq.c | 115 +++++++++++++++++++-------------------
 include/linux/devfreq.h   |  25 ++++-----
 2 files changed, 70 insertions(+), 70 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 6e5a17f4c92c..70533b787744 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -128,7 +128,7 @@ static int set_freq_table(struct devfreq *devfreq)
 
 	profile->max_state = count;
 	profile->freq_table = devm_kcalloc(devfreq->dev.parent,
-					profile->max_state,
+					count,
 					sizeof(*profile->freq_table),
 					GFP_KERNEL);
 	if (!profile->freq_table) {
@@ -157,29 +157,30 @@ static int set_freq_table(struct devfreq *devfreq)
  */
 int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
 {
-	int lev, prev_lev, ret = 0;
+	struct devfreq_dev_profile *profile = devfreq->profile;
 	unsigned long long cur_time;
+	int lev, prev_lev, ret = 0;
 
 	cur_time = get_jiffies_64();
 
 	/* Immediately exit if previous_freq is not initialized yet. */
 	if (!devfreq->previous_freq) {
-		spin_lock(&devfreq->stats_lock);
-		devfreq->last_time = cur_time;
-		spin_unlock(&devfreq->stats_lock);
+		spin_lock(&profile->stats_lock);
+		profile->last_time = cur_time;
+		spin_unlock(&profile->stats_lock);
 		return 0;
 	}
 
 	prev_lev = devfreq_get_freq_level(devfreq, devfreq->previous_freq);
 
-	spin_lock(&devfreq->stats_lock);
+	spin_lock(&profile->stats_lock);
 	if (prev_lev < 0) {
 		ret = prev_lev;
 		goto out;
 	}
 
-	devfreq->time_in_state[prev_lev] +=
-			 cur_time - devfreq->last_time;
+	profile->time_in_state[prev_lev] +=
+			 cur_time - profile->last_time;
 	lev = devfreq_get_freq_level(devfreq, freq);
 	if (lev < 0) {
 		ret = lev;
@@ -187,14 +188,14 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
 	}
 
 	if (lev != prev_lev) {
-		devfreq->trans_table[(prev_lev *
-				devfreq->profile->max_state) + lev]++;
-		devfreq->total_trans++;
+		profile->trans_table[(prev_lev *
+				profile->max_state) + lev]++;
+		profile->total_trans++;
 	}
 
 out:
-	devfreq->last_time = cur_time;
-	spin_unlock(&devfreq->stats_lock);
+	profile->last_time = cur_time;
+	spin_unlock(&profile->stats_lock);
 	return ret;
 }
 EXPORT_SYMBOL(devfreq_update_status);
@@ -474,23 +475,23 @@ EXPORT_SYMBOL(devfreq_monitor_suspend);
 void devfreq_monitor_resume(struct devfreq *devfreq)
 {
 	unsigned long freq;
+	struct devfreq_dev_profile *profile = devfreq->profile;
 
 	mutex_lock(&devfreq->lock);
 	if (!devfreq->stop_polling)
 		goto out;
 
-	if (!delayed_work_pending(&devfreq->work) &&
-			devfreq->profile->polling_ms)
+	if (!delayed_work_pending(&devfreq->work) && profile->polling_ms)
 		queue_delayed_work(devfreq_wq, &devfreq->work,
-			msecs_to_jiffies(devfreq->profile->polling_ms));
+			msecs_to_jiffies(profile->polling_ms));
 
-	spin_lock(&devfreq->stats_lock);
-	devfreq->last_time = get_jiffies_64();
-	spin_unlock(&devfreq->stats_lock);
+	spin_lock(&profile->stats_lock);
+	profile->last_time = get_jiffies_64();
+	spin_unlock(&profile->stats_lock);
 	devfreq->stop_polling = false;
 
-	if (devfreq->profile->get_cur_freq &&
-		!devfreq->profile->get_cur_freq(devfreq->dev.parent, &freq))
+	if (profile->get_cur_freq &&
+	    !profile->get_cur_freq(devfreq->dev.parent, &freq))
 		devfreq->previous_freq = freq;
 
 out:
@@ -657,7 +658,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->data = data;
 	devfreq->nb.notifier_call = devfreq_notifier_call;
 
-	if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
+	if (!profile->max_state && !profile->freq_table) {
 		mutex_unlock(&devfreq->lock);
 		err = set_freq_table(devfreq);
 		if (err < 0)
@@ -693,29 +694,29 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_out;
 	}
 
-	devfreq->trans_table = devm_kzalloc(&devfreq->dev,
-			array3_size(sizeof(unsigned int),
-				    devfreq->profile->max_state,
-				    devfreq->profile->max_state),
-			GFP_KERNEL);
-	if (!devfreq->trans_table) {
+	profile->trans_table = devm_kzalloc(&devfreq->dev,
+					    array3_size(sizeof(unsigned int),
+							profile->max_state,
+							profile->max_state),
+					    GFP_KERNEL);
+	if (!profile->trans_table) {
 		mutex_unlock(&devfreq->lock);
 		err = -ENOMEM;
 		goto err_devfreq;
 	}
 
-	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
-			devfreq->profile->max_state,
-			sizeof(*devfreq->time_in_state),
-			GFP_KERNEL);
-	if (!devfreq->time_in_state) {
+	profile->time_in_state = devm_kcalloc(&devfreq->dev,
+					      profile->max_state,
+					      sizeof(*profile->time_in_state),
+					      GFP_KERNEL);
+	if (!profile->time_in_state) {
 		mutex_unlock(&devfreq->lock);
 		err = -ENOMEM;
 		goto err_devfreq;
 	}
 
-	devfreq->last_time = get_jiffies_64();
-	spin_lock_init(&devfreq->stats_lock);
+	profile->last_time = get_jiffies_64();
+	spin_lock_init(&profile->stats_lock);
 
 	srcu_init_notifier_head(&devfreq->transition_notifier_list);
 
@@ -1402,9 +1403,10 @@ static ssize_t trans_stat_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
 	struct devfreq *devfreq = to_devfreq(dev);
+	struct devfreq_dev_profile *profile = devfreq->profile;
 	ssize_t len;
 	int i, j;
-	unsigned int max_state = devfreq->profile->max_state;
+	unsigned int max_state = profile->max_state;
 
 	if (!devfreq->stop_polling &&
 			devfreq_update_status(devfreq, devfreq->previous_freq))
@@ -1415,46 +1417,45 @@ static ssize_t trans_stat_show(struct device *dev,
 	len = sprintf(buf, "     From  :   To\n");
 	len += sprintf(buf + len, "           :");
 
-	spin_lock(&devfreq->stats_lock);
+	spin_lock(&profile->stats_lock);
 	for (i = 0; i < max_state; i++)
 		len += sprintf(buf + len, "%10lu",
-				devfreq->profile->freq_table[i]);
+				profile->freq_table[i]);
 
 	len += sprintf(buf + len, "   time(ms)\n");
 
 	for (i = 0; i < max_state; i++) {
-		if (devfreq->profile->freq_table[i]
-					== devfreq->previous_freq) {
+		if (profile->freq_table[i] == devfreq->previous_freq)
 			len += sprintf(buf + len, "*");
-		} else {
+		else
 			len += sprintf(buf + len, " ");
-		}
+
 		len += sprintf(buf + len, "%10lu:",
-				devfreq->profile->freq_table[i]);
+				profile->freq_table[i]);
 		for (j = 0; j < max_state; j++)
 			len += sprintf(buf + len, "%10u",
-				devfreq->trans_table[(i * max_state) + j]);
+				profile->trans_table[(i * max_state) + j]);
 		len += sprintf(buf + len, "%10llu\n", (u64)
-			jiffies64_to_msecs(devfreq->time_in_state[i]));
+			jiffies64_to_msecs(profile->time_in_state[i]));
 	}
 
 	len += sprintf(buf + len, "Total transition : %u\n",
-					devfreq->total_trans);
-	spin_unlock(&devfreq->stats_lock);
+					profile->total_trans);
+	spin_unlock(&profile->stats_lock);
 	return len;
 }
 static DEVICE_ATTR_RO(trans_stat);
 
-static void defvreq_stats_clear_table(struct devfreq *devfreq)
+static void defvreq_stats_clear_table(struct devfreq_dev_profile *profile)
 {
-	unsigned int count = devfreq->profile->max_state;
-
-	spin_lock(&devfreq->stats_lock);
-	memset(devfreq->time_in_state, 0, count * sizeof(u64));
-	memset(devfreq->trans_table, 0, count * count * sizeof(int));
-	devfreq->last_time = get_jiffies_64();
-	devfreq->total_trans = 0;
-	spin_unlock(&devfreq->stats_lock);
+	unsigned int count = profile->max_state;
+
+	spin_lock(&profile->stats_lock);
+	memset(profile->time_in_state, 0, count * sizeof(u64));
+	memset(profile->trans_table, 0, count * count * sizeof(int));
+	profile->last_time = get_jiffies_64();
+	profile->total_trans = 0;
+	spin_unlock(&profile->stats_lock);
 }
 
 static ssize_t trans_reset_store(struct device *dev,
@@ -1464,7 +1465,7 @@ static ssize_t trans_reset_store(struct device *dev,
 {
 	struct devfreq *devfreq = to_devfreq(dev);
 
-	defvreq_stats_clear_table(devfreq);
+	defvreq_stats_clear_table(devfreq->profile);
 
 	return count;
 }
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 2ddf25993f7d..4ceb2a517a9c 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -91,6 +91,12 @@ struct devfreq_dev_status {
  * @freq_table:		Optional list of frequencies to support statistics
  *			and freq_table must be generated in ascending order.
  * @max_state:		The size of freq_table.
+ * @total_trans:	Number of devfreq transitions
+ * @trans_table:	Statistics of devfreq transitions
+ * @time_in_state:	Statistics of devfreq states
+ * @last_time:		The last time stats were updated
+ * @stats_lock:		Lock protecting trans_table, time_in_state,
+ *			last_time and total_trans used for statistics
  */
 struct devfreq_dev_profile {
 	unsigned long initial_freq;
@@ -104,6 +110,12 @@ struct devfreq_dev_profile {
 
 	unsigned long *freq_table;
 	unsigned int max_state;
+	/* information for device frequency transition */
+	unsigned int total_trans;
+	unsigned int *trans_table;
+	u64 *time_in_state;
+	unsigned long long last_time;
+	spinlock_t stats_lock;
 };
 
 /**
@@ -131,12 +143,6 @@ struct devfreq_dev_profile {
  * @suspend_freq:	 frequency of a device set during suspend phase.
  * @resume_freq:	 frequency of a device set in resume phase.
  * @suspend_count:	 suspend requests counter for a device.
- * @total_trans:	Number of devfreq transitions
- * @trans_table:	Statistics of devfreq transitions
- * @time_in_state:	Statistics of devfreq states
- * @last_time:		The last time stats were updated
- * @stats_lock:		Lock protecting trans_table, time_in_state, last_time
- *			and total_trans used for statistics
  * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER notifier
  *
  * This structure stores the devfreq information for a give device.
@@ -173,13 +179,6 @@ struct devfreq {
 	unsigned long resume_freq;
 	atomic_t suspend_count;
 
-	/* information for device frequency transition */
-	unsigned int total_trans;
-	unsigned int *trans_table;
-	u64 *time_in_state;
-	unsigned long long last_time;
-	spinlock_t stats_lock;
-
 	struct srcu_notifier_head transition_notifier_list;
 };
 
-- 
2.24.0

