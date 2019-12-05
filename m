Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F09C114316
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 15:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbfLEOzr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 09:55:47 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47481 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729648AbfLEOzr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 09:55:47 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191205145544euoutp0274ca940913000a1515e53a3cb0c7e554~dgWvgyzOW0629206292euoutp02C
        for <linux-pm@vger.kernel.org>; Thu,  5 Dec 2019 14:55:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191205145544euoutp0274ca940913000a1515e53a3cb0c7e554~dgWvgyzOW0629206292euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575557745;
        bh=Fx2yskW0bzIfcjfnTQfwUwXy0Cft1IpDCl7JR2eiDlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BYTCyYPmTxEBR7quCphl9G66WwWtST+YhE4ZOYVCKLHRf2hLyyTmMOAvfV7GJs1lb
         nFZwbTPHWniPNhe6j/fdWzOstT9cfPF1lSkgPjOnxbJUGM5EgXcXPbdyX33xjvucDA
         TGPOLm+sjL1Kkve9WW/Zb7bcMWmgKKdAWuW86EaI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191205145544eucas1p10ce910b203fa0b5c7d719d66555a75c5~dgWvNk96s2111721117eucas1p1U;
        Thu,  5 Dec 2019 14:55:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id CD.A4.61286.07A19ED5; Thu,  5
        Dec 2019 14:55:44 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191205145544eucas1p17e64389fdee24549a523c624c13194d7~dgWu11xIU2196021960eucas1p1k;
        Thu,  5 Dec 2019 14:55:44 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191205145544eusmtrp1697a5bedac8c8301109089f863ee304d~dgWu1UFts2567425674eusmtrp1a;
        Thu,  5 Dec 2019 14:55:44 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-4b-5de91a709f81
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id BD.01.07950.07A19ED5; Thu,  5
        Dec 2019 14:55:44 +0000 (GMT)
Received: from AMDC3218.digital.local (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191205145543eusmtip2c270c0dacad169041847c6b9a3fc9f99~dgWuXkSb62087620876eusmtip2d;
        Thu,  5 Dec 2019 14:55:43 +0000 (GMT)
From:   Kamil Konieczny <k.konieczny@samsung.com>
To:     k.konieczny@samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 3/3] devfreq: move statistics to separate struct
Date:   Thu,  5 Dec 2019 15:55:27 +0100
Message-Id: <20191205145527.26117-4-k.konieczny@samsung.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191205145527.26117-1-k.konieczny@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7djPc7oFUi9jDRruqlpsnLGe1eL6l+es
        Fgs+zWC1OH9+A7vF2aY37BaXd81hs/jce4TRYu2Ru+wWnzc8ZrS43biCzYHLY3bDRRaPTas6
        2Tz6tqxi9Pi8SS6AJYrLJiU1J7MstUjfLoEr4/6MSSwFMx0r+pcfYWpgbDftYuTkkBAwkVj+
        5RM7iC0ksIJR4uZuti5GLiD7C6PEpJW7mSGcz4wST+/tYYHpWNA0GyqxnFGie8MWFriWtlUH
        2ECq2AT0JQ6ePQnWISIgLdG5aCITiM0s8I5JYtYZBxBbWMBZ4tThaWA1LAKqEufefgCr4RWw
        kXi9azOQzQG0TV5izlsNkDCngK3EtkvPoEoEJU7OfMICMVJeonkryEEgxy1il3j7VgvCdpE4
        1vacDcIWlnh1fAs7hC0jcXpyD9Qz5RJPF/axg9wvIdDCKPGg/SNUwlri8PGLrCA3MAtoSqzf
        pQ8RdpRYtXMFO8RpfBI33gpCnMAnMWnbdGaIMK9ER5sQRLWqxPNTPUwQtrRE1/91rBC2h8TT
        vxvZJjAqzkLyzCwkz8xC2LuAkXkVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYOo5/e/4
        px2MXy8lHWIU4GBU4uGd8flFrBBrYllxZe4hRgkOZiUR3nS+l7FCvCmJlVWpRfnxRaU5qcWH
        GKU5WJTEeasZHkQLCaQnlqRmp6YWpBbBZJk4OKUaGO0vHHz2Y7Hu4e0LFRKO3avvlSmrPrli
        6reJ0Q8kihS/sWq/MZrIdHGNZnfI5UfNwj+mC6jstyhYtqxKM/3IpUrWGcudq8Kf2rqaqbvM
        najEImX9fIEYs9PuiRwHsxdJKB3ZpjZvyfXcS9fbz8x4Uti7Tv+4oFs75+yU09w/tEwZN+6O
        +Wf22luJpTgj0VCLuag4EQBXLA5DOQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsVy+t/xe7oFUi9jDVbP4bHYOGM9q8X1L89Z
        LRZ8msFqcf78BnaLs01v2C0u75rDZvG59wijxdojd9ktPm94zGhxu3EFmwOXx+yGiywem1Z1
        snn0bVnF6PF5k1wAS5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpq
        TmZZapG+XYJexv0Zk1gKZjpW9C8/wtTA2G7axcjJISFgIrGgaTZzFyMXh5DAUkaJ7e/vM0Mk
        pCUaT69mgrCFJf5c62IDsYUEPjFKdK7UAbHZBPQlDp49yQJiiwDVdy6ayAQyiFngC5PEoal7
        WEESwgLOEqcOTwMrYhFQlTj39gPYUF4BG4nXuzYD2RxAC+Ql5rzVAAlzCthKbLv0DCwsBFTS
        8IYFolpQ4uTMJ2A2M1B189bZzBMYBWYhSc1CklrAyLSKUSS1tDg3PbfYSK84Mbe4NC9dLzk/
        dxMjMEq2Hfu5ZQdj17vgQ4wCHIxKPLwzPr+IFWJNLCuuzD3EKMHBrCTCm873MlaINyWxsiq1
        KD++qDQntfgQoynQCxOZpUST84ERnFcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1
        ILUIpo+Jg1OqgVFEbP9pbcbWa0LMa1i4nFdfbJzZfoJxn8vCbUnz46ZU8bHM+rnnBeM27qL/
        rslF4tw9PG7rnzVduMO4ZcZV7y/s4sUXl3RYOvS90HPTrv/E85Pv/5nwH2sX7Hu3OvG4x2pJ
        aQkfnmPvdZZbuGqVKIq+/J/tsn7Bsdj0iG2ix1d8OGt147L7ZFElluKMREMt5qLiRAAsS9o8
        qAIAAA==
X-CMS-MailID: 20191205145544eucas1p17e64389fdee24549a523c624c13194d7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191205145544eucas1p17e64389fdee24549a523c624c13194d7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191205145544eucas1p17e64389fdee24549a523c624c13194d7
References: <20191205145527.26117-1-k.konieczny@samsung.com>
        <CGME20191205145544eucas1p17e64389fdee24549a523c624c13194d7@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Count time and transitions between devfreq frequencies in separate struct
for improved code readability and maintenance.

Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v3:
- removed freq_table and max_state from struct devfreq_stats as they are
  already present in struct devfreq_dev_profile
- renamed last_stat_updated to last_update, as 'stat' is already present
  in struct devfreq_stats
- define struct devfreq_stats stats; in devfreq as there is only one
  stats per devfreq
- improve descriptions of devfreq_stats and stats
- use profile instead of devfreq->profile in devfreq_add_device, as this
  var is already parameter
- added Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Changes in v2:
- squash three patches into one, do not modify devfreq_profile and separate stats
  into devfreq_stats
---
 drivers/devfreq/devfreq.c | 67 ++++++++++++++++++++-------------------
 include/linux/devfreq.h   | 26 +++++++++------
 2 files changed, 51 insertions(+), 42 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 218eb64d7f28..bcd7e92d2cf3 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -198,6 +198,7 @@ static int set_freq_table(struct devfreq *devfreq)
  */
 int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
 {
+	struct devfreq_stats *stats = &devfreq->stats;
 	int lev, prev_lev, ret = 0;
 	u64 cur_time;
 
@@ -214,9 +215,7 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
 		goto out;
 	}
 
-	devfreq->time_in_state[prev_lev] +=
-			 cur_time - devfreq->last_stat_updated;
-
+	stats->time_in_state[prev_lev] += cur_time - stats->last_update;
 	lev = devfreq_get_freq_level(devfreq, freq);
 	if (lev < 0) {
 		ret = lev;
@@ -224,13 +223,13 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
 	}
 
 	if (lev != prev_lev) {
-		devfreq->trans_table[(prev_lev *
-				devfreq->profile->max_state) + lev]++;
-		devfreq->total_trans++;
+		stats->trans_table[(prev_lev * devfreq->profile->max_state) +
+				   lev]++;
+		stats->total_trans++;
 	}
 
 out:
-	devfreq->last_stat_updated = cur_time;
+	stats->last_update = cur_time;
 	return ret;
 }
 EXPORT_SYMBOL(devfreq_update_status);
@@ -525,7 +524,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
 			msecs_to_jiffies(devfreq->profile->polling_ms));
 
 out_update:
-	devfreq->last_stat_updated = get_jiffies_64();
+	devfreq->stats.last_update = get_jiffies_64();
 	devfreq->stop_polling = false;
 
 	if (devfreq->profile->get_cur_freq &&
@@ -735,28 +734,29 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_out;
 	}
 
-	devfreq->trans_table = devm_kzalloc(&devfreq->dev,
+	devfreq->stats.trans_table = devm_kzalloc(&devfreq->dev,
 			array3_size(sizeof(unsigned int),
-				    devfreq->profile->max_state,
-				    devfreq->profile->max_state),
+				    profile->max_state,
+				    profile->max_state),
 			GFP_KERNEL);
-	if (!devfreq->trans_table) {
+	if (!devfreq->stats.trans_table) {
 		mutex_unlock(&devfreq->lock);
 		err = -ENOMEM;
 		goto err_devfreq;
 	}
 
-	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
-			devfreq->profile->max_state,
-			sizeof(*devfreq->time_in_state),
+	devfreq->stats.time_in_state = devm_kcalloc(&devfreq->dev,
+			profile->max_state,
+			sizeof(*devfreq->stats.time_in_state),
 			GFP_KERNEL);
-	if (!devfreq->time_in_state) {
+	if (!devfreq->stats.time_in_state) {
 		mutex_unlock(&devfreq->lock);
 		err = -ENOMEM;
 		goto err_devfreq;
 	}
 
-	devfreq->last_stat_updated = get_jiffies_64();
+	devfreq->stats.last_update = get_jiffies_64();
+	devfreq->stats.total_trans = 0;
 
 	srcu_init_notifier_head(&devfreq->transition_notifier_list);
 
@@ -1435,9 +1435,11 @@ static ssize_t trans_stat_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
 	struct devfreq *devfreq = to_devfreq(dev);
+	struct devfreq_stats *stats = &devfreq->stats;
+	unsigned int max_state = devfreq->profile->max_state;
+	unsigned long *freq_table = devfreq->profile->freq_table;
 	ssize_t len;
 	int i, j;
-	unsigned int max_state = devfreq->profile->max_state;
 
 	if (max_state == 0)
 		return sprintf(buf, "Not Supported.\n");
@@ -1453,29 +1455,27 @@ static ssize_t trans_stat_show(struct device *dev,
 	len = sprintf(buf, "     From  :   To\n");
 	len += sprintf(buf + len, "           :");
 	for (i = 0; i < max_state; i++)
-		len += sprintf(buf + len, "%10lu",
-				devfreq->profile->freq_table[i]);
+		len += sprintf(buf + len, "%10lu", freq_table[i]);
 
 	len += sprintf(buf + len, "   time(ms)\n");
 
 	for (i = 0; i < max_state; i++) {
-		if (devfreq->profile->freq_table[i]
-					== devfreq->previous_freq) {
+		if (freq_table[i] == devfreq->previous_freq)
 			len += sprintf(buf + len, "*");
-		} else {
+		else
 			len += sprintf(buf + len, " ");
-		}
-		len += sprintf(buf + len, "%10lu:",
-				devfreq->profile->freq_table[i]);
+
+		len += sprintf(buf + len, "%10lu:", freq_table[i]);
 		for (j = 0; j < max_state; j++)
 			len += sprintf(buf + len, "%10u",
-				devfreq->trans_table[(i * max_state) + j]);
+				stats->trans_table[(i * max_state) + j]);
+
 		len += sprintf(buf + len, "%10llu\n", (u64)
-			jiffies64_to_msecs(devfreq->time_in_state[i]));
+			jiffies64_to_msecs(stats->time_in_state[i]));
 	}
 
 	len += sprintf(buf + len, "Total transition : %u\n",
-					devfreq->total_trans);
+					stats->total_trans);
 	return len;
 }
 
@@ -1484,6 +1484,7 @@ static ssize_t trans_stat_store(struct device *dev,
 				const char *buf, size_t count)
 {
 	struct devfreq *df = to_devfreq(dev);
+	struct devfreq_stats *stats = &df->stats;
 	unsigned int cnt = df->profile->max_state;
 	int err, value;
 
@@ -1495,10 +1496,10 @@ static ssize_t trans_stat_store(struct device *dev,
 		return count;
 
 	mutex_lock(&df->lock);
-	memset(df->time_in_state, 0, cnt * sizeof(u64));
-	memset(df->trans_table, 0, cnt * cnt * sizeof(int));
-	df->last_stat_updated = get_jiffies_64();
-	df->total_trans = 0;
+	memset(stats->time_in_state, 0, cnt * sizeof(u64));
+	memset(stats->trans_table, 0, cnt * cnt * sizeof(int));
+	stats->last_update = get_jiffies_64();
+	stats->total_trans = 0;
 	mutex_unlock(&df->lock);
 
 	return count;
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 41f15e7a22b8..de2fdc56aa5b 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -106,6 +106,20 @@ struct devfreq_dev_profile {
 	unsigned int max_state;
 };
 
+/**
+ * struct devfreq_stats - Statistics of devfreq device behavior
+ * @total_trans:	Number of devfreq transitions.
+ * @trans_table:	Statistics of devfreq transitions.
+ * @time_in_state:	Statistics of devfreq states.
+ * @last_update:	The last time stats were updated.
+ */
+struct devfreq_stats {
+	unsigned int total_trans;
+	unsigned int *trans_table;
+	u64 *time_in_state;
+	u64 last_update;
+};
+
 /**
  * struct devfreq - Device devfreq structure
  * @node:	list node - contains the devices with devfreq that have been
@@ -131,10 +145,7 @@ struct devfreq_dev_profile {
  * @suspend_freq:	 frequency of a device set during suspend phase.
  * @resume_freq:	 frequency of a device set in resume phase.
  * @suspend_count:	 suspend requests counter for a device.
- * @total_trans:	Number of devfreq transitions
- * @trans_table:	Statistics of devfreq transitions
- * @time_in_state:	Statistics of devfreq states
- * @last_stat_updated:	The last time stat updated
+ * @stats:	Statistics of devfreq device behavior
  * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER notifier
  *
  * This structure stores the devfreq information for a give device.
@@ -171,11 +182,8 @@ struct devfreq {
 	unsigned long resume_freq;
 	atomic_t suspend_count;
 
-	/* information for device frequency transition */
-	unsigned int total_trans;
-	unsigned int *trans_table;
-	u64 *time_in_state;
-	u64 last_stat_updated;
+	/* information for device frequency transitions */
+	struct devfreq_stats stats;
 
 	struct srcu_notifier_head transition_notifier_list;
 };
-- 
2.24.0

