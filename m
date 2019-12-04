Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07F1F112DF5
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2019 16:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfLDPAp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 10:00:45 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39395 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbfLDPAg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2019 10:00:36 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191204150035euoutp02e0df1f916c5fba0642f6a170e02e7f90~dMxriB_Q_1386313863euoutp02C
        for <linux-pm@vger.kernel.org>; Wed,  4 Dec 2019 15:00:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191204150035euoutp02e0df1f916c5fba0642f6a170e02e7f90~dMxriB_Q_1386313863euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575471635;
        bh=vBSwE8A0E5JhNbi7W86Ls3sR6OAyN6GmkcssEKOy6us=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YykSpnQEstmTHuPldWWzoqVr+iij4ForZ28DEy0iHszAudaapAm6nd/I1zfI4m9mq
         9IVMb+ZbIGA1GRPZAN9lWc/RILuaBQd+74dPHa9pPPW27SfwD0Gw+yJT7SoUGTIgQD
         AQBbcFVXwwBY8PoaLZtOrNpzt8MBPgs+CjdCMM60=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191204150034eucas1p2f4f2adfd5739de835ef1892aa6b39899~dMxrVWU262912729127eucas1p2X;
        Wed,  4 Dec 2019 15:00:34 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 26.68.60698.21AC7ED5; Wed,  4
        Dec 2019 15:00:34 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191204150034eucas1p1b6e7f43a6be59ed2e0a4e55ccdefc750~dMxq4-bz43262132621eucas1p1B;
        Wed,  4 Dec 2019 15:00:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191204150034eusmtrp101baa07d12e7ea03e4766ac3e04c3d23~dMxq4b2nj1235012350eusmtrp1g;
        Wed,  4 Dec 2019 15:00:34 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-c3-5de7ca126fef
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C9.ED.08375.21AC7ED5; Wed,  4
        Dec 2019 15:00:34 +0000 (GMT)
Received: from AMDC3218.digital.local (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191204150033eusmtip1daffbe23f5a0fa94b7153fa0b25aad3f~dMxqXntom1853818538eusmtip1Q;
        Wed,  4 Dec 2019 15:00:33 +0000 (GMT)
From:   Kamil Konieczny <k.konieczny@samsung.com>
To:     k.konieczny@samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH v2 3/3] devfreq: move statistics to separate struct
Date:   Wed,  4 Dec 2019 16:00:18 +0100
Message-Id: <20191204150018.5234-4-k.konieczny@samsung.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204150018.5234-1-k.konieczny@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djP87pCp57HGvSssrTYOGM9q8X1L89Z
        LRZ8msFqcf78BnaLs01v2C0u75rDZvG59wijxdojd9ktbjeuYHPg9Ni0qpPNo2/LKkaPz5vk
        ApijuGxSUnMyy1KL9O0SuDIW7u9jLvhuV9F1ahlTA+MS4y5GTg4JAROJ9SdfM3YxcnEICaxg
        lLi3fTczhPOFUeLAzN1sEM5nRonjRxcCZTjAWlas9YKIL2eU2L9/Ihtcx6knHYwgc9kE9CUO
        nj3JAmKLCEhLdC6ayARSxCxwjEli16G/rCAJYQFniQv7HoI1sAioSmzbdAnM5hWwlpjzYT8b
        xDZ5iTlvNUDCnAI2Eh9ff4IqEZQ4OfMJ2HxmoJLmrbPBzpYQ6GeXuLTxOjPEcy4Sl1b3s0DY
        whKvjm9hh7BlJE5P7oGKl0s8XdjHDtHcwijxoP0jVMJa4vDxi6wgRzALaEqs36UPcY+jxOqp
        8hAmn8SNt4IQJ/BJTNo2HRo+vBIdbUIQM1Qlnp/qYYKwpSW6/q9jhbA9JE4sb2OawKg4C8kz
        s5A8Mwth7QJG5lWM4qmlxbnpqcXGeanlesWJucWleel6yfm5mxiBieb0v+NfdzDu+5N0iFGA
        g1GJh7dh0/NYIdbEsuLK3EOMEhzMSiK82ySexgrxpiRWVqUW5ccXleakFh9ilOZgURLnrWZ4
        EC0kkJ5YkpqdmlqQWgSTZeLglGpgvHJt2+V3SUxHJqUfKzJ02Sse5NtfFvUl19F+tUdpUqLc
        dcOnk/NWrYliPz7dsvBj4TaOxX2my6pvfp6XkbtjO+8k9Tspls4G20K+eS2XFT4xl6dHgv39
        g8wlV7Y/jPU6HvZ2xTqfJ9/fr/z9OXh7VHvpjmdGXEZnDn6Y4RHMLT3Xwd5Pd/OrL0osxRmJ
        hlrMRcWJAHon/oIwAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42I5/e/4XV2hU89jDT7skbbYOGM9q8X1L89Z
        LRZ8msFqcf78BnaLs01v2C0u75rDZvG59wijxdojd9ktbjeuYHPg9Ni0qpPNo2/LKkaPz5vk
        Apij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DIW
        7u9jLvhuV9F1ahlTA+MS4y5GDg4JAROJFWu9uhg5OYQEljJK3D5UD2JLCEhLNJ5ezQRhC0v8
        udbF1sXIBVTziVFi9sEFYAk2AX2Jg2dPsoDYIkANnYsmgsWZBc4wSfxqqQCxhQWcJS7se8gI
        YrMIqEps23QJzOYVsJaY82E/G8QN8hJz3mqAhDkFbCQ+vv7ECHGPtUTP03dsEOWCEidnPmGB
        GC8v0bx1NvMERoFZSFKzkKQWMDKtYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIyHbcd+bt7B
        eGlj8CFGAQ5GJR7ehk3PY4VYE8uKK3MPMUpwMCuJ8G6TeBorxJuSWFmVWpQfX1Sak1p8iNEU
        6IeJzFKiyfnAWM0riTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cCY
        rjN3/Ym+WZ+DNxzvUj7b+24v88wZB0ulu57N/lO4MneybZKK6M8C1trr+Sb583IvbT84Ze/S
        u3y/Xzk+vql40lOuann/usXvdtZI88hfsqq9Lnle6m7Vn/LAYMNDb7qv75/RvqXy64bwddn2
        geEF6nuP/Fu8YhfjvMhF6w8dXNfjmDevaGqElxJLcUaioRZzUXEiAFMslTadAgAA
X-CMS-MailID: 20191204150034eucas1p1b6e7f43a6be59ed2e0a4e55ccdefc750
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191204150034eucas1p1b6e7f43a6be59ed2e0a4e55ccdefc750
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191204150034eucas1p1b6e7f43a6be59ed2e0a4e55ccdefc750
References: <20191204150018.5234-1-k.konieczny@samsung.com>
        <CGME20191204150034eucas1p1b6e7f43a6be59ed2e0a4e55ccdefc750@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Count time and transitions between devfreq frequencies in separate struct
for improved code readability and maintenance.

Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
---
Changes in v2:
 squash three patches into one, do not modify devfreq_profile and separate stats
 into devfreq_stats

 drivers/devfreq/devfreq.c | 68 +++++++++++++++++++++++----------------
 include/linux/devfreq.h   | 31 ++++++++++++------
 2 files changed, 62 insertions(+), 37 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 901af3b66a76..4d50c8f10bd2 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -198,6 +198,7 @@ static int set_freq_table(struct devfreq *devfreq)
  */
 int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
 {
+	struct devfreq_stats *stats = devfreq->stats;
 	int lev, prev_lev, ret = 0;
 	unsigned long long cur_time;
 
@@ -214,8 +215,8 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
 		goto out;
 	}
 
-	devfreq->time_in_state[prev_lev] +=
-			 cur_time - devfreq->last_stat_updated;
+	stats->time_in_state[prev_lev] +=
+			 cur_time - stats->last_stat_updated;
 
 	lev = devfreq_get_freq_level(devfreq, freq);
 	if (lev < 0) {
@@ -224,13 +225,12 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
 	}
 
 	if (lev != prev_lev) {
-		devfreq->trans_table[(prev_lev *
-				devfreq->profile->max_state) + lev]++;
-		devfreq->total_trans++;
+		stats->trans_table[(prev_lev * stats->max_state) + lev]++;
+		stats->total_trans++;
 	}
 
 out:
-	devfreq->last_stat_updated = cur_time;
+	stats->last_stat_updated = cur_time;
 	return ret;
 }
 EXPORT_SYMBOL(devfreq_update_status);
@@ -525,7 +525,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
 			msecs_to_jiffies(devfreq->profile->polling_ms));
 
 out_update:
-	devfreq->last_stat_updated = get_jiffies_64();
+	devfreq->stats->last_stat_updated = get_jiffies_64();
 	devfreq->stop_polling = false;
 
 	if (devfreq->profile->get_cur_freq &&
@@ -735,28 +735,38 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_out;
 	}
 
-	devfreq->trans_table = devm_kzalloc(&devfreq->dev,
+	devfreq->stats = devm_kzalloc(&devfreq->dev, sizeof(*devfreq->stats),
+				      GFP_KERNEL);
+	if (!devfreq->stats) {
+		mutex_unlock(&devfreq->lock);
+		err = -ENOMEM;
+		goto err_devfreq;
+	}
+
+	devfreq->stats->freq_table = devfreq->profile->freq_table;
+	devfreq->stats->max_state = devfreq->profile->max_state;
+	devfreq->stats->trans_table = devm_kzalloc(&devfreq->dev,
 			array3_size(sizeof(unsigned int),
-				    devfreq->profile->max_state,
-				    devfreq->profile->max_state),
+				    devfreq->stats->max_state,
+				    devfreq->stats->max_state),
 			GFP_KERNEL);
-	if (!devfreq->trans_table) {
+	if (!devfreq->stats->trans_table) {
 		mutex_unlock(&devfreq->lock);
 		err = -ENOMEM;
 		goto err_devfreq;
 	}
 
-	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
-			devfreq->profile->max_state,
-			sizeof(*devfreq->time_in_state),
+	devfreq->stats->time_in_state = devm_kcalloc(&devfreq->dev,
+			devfreq->stats->max_state,
+			sizeof(*devfreq->stats->time_in_state),
 			GFP_KERNEL);
-	if (!devfreq->time_in_state) {
+	if (!devfreq->stats->time_in_state) {
 		mutex_unlock(&devfreq->lock);
 		err = -ENOMEM;
 		goto err_devfreq;
 	}
 
-	devfreq->last_stat_updated = get_jiffies_64();
+	devfreq->stats->last_stat_updated = get_jiffies_64();
 
 	srcu_init_notifier_head(&devfreq->transition_notifier_list);
 
@@ -1435,9 +1445,10 @@ static ssize_t trans_stat_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
 	struct devfreq *devfreq = to_devfreq(dev);
+	struct devfreq_stats *stats = devfreq->stats;
+	unsigned int max_state = stats->max_state;
 	ssize_t len;
 	int i, j;
-	unsigned int max_state = devfreq->profile->max_state;
 
 	if (max_state == 0)
 		return sprintf(buf, "Not Supported.\n");
@@ -1454,28 +1465,28 @@ static ssize_t trans_stat_show(struct device *dev,
 	len += sprintf(buf + len, "           :");
 	for (i = 0; i < max_state; i++)
 		len += sprintf(buf + len, "%10lu",
-				devfreq->profile->freq_table[i]);
+				stats->freq_table[i]);
 
 	len += sprintf(buf + len, "   time(ms)\n");
 
 	for (i = 0; i < max_state; i++) {
-		if (devfreq->profile->freq_table[i]
+		if (stats->freq_table[i]
 					== devfreq->previous_freq) {
 			len += sprintf(buf + len, "*");
 		} else {
 			len += sprintf(buf + len, " ");
 		}
 		len += sprintf(buf + len, "%10lu:",
-				devfreq->profile->freq_table[i]);
+				stats->freq_table[i]);
 		for (j = 0; j < max_state; j++)
 			len += sprintf(buf + len, "%10u",
-				devfreq->trans_table[(i * max_state) + j]);
+				stats->trans_table[(i * max_state) + j]);
 		len += sprintf(buf + len, "%10llu\n", (u64)
-			jiffies64_to_msecs(devfreq->time_in_state[i]));
+			jiffies64_to_msecs(stats->time_in_state[i]));
 	}
 
 	len += sprintf(buf + len, "Total transition : %u\n",
-					devfreq->total_trans);
+					stats->total_trans);
 	return len;
 }
 
@@ -1484,16 +1495,17 @@ static ssize_t trans_stat_store(struct device *dev,
 				const char *buf, size_t count)
 {
 	struct devfreq *df = to_devfreq(dev);
-	unsigned int cnt = df->profile->max_state;
+	struct devfreq_stats *stats = df->stats;
+	unsigned int cnt = stats->max_state;
 
 	if (cnt == 0)
 		return count;
 
 	mutex_lock(&df->lock);
-	memset(df->time_in_state, 0, cnt * sizeof(u64));
-	memset(df->trans_table, 0, cnt * cnt * sizeof(int));
-	df->last_stat_updated = get_jiffies_64();
-	df->total_trans = 0;
+	memset(stats->time_in_state, 0, cnt * sizeof(u64));
+	memset(stats->trans_table, 0, cnt * cnt * sizeof(int));
+	stats->last_stat_updated = get_jiffies_64();
+	stats->total_trans = 0;
 	mutex_unlock(&df->lock);
 
 	return count;
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index b81a86e47fb9..2715719924e7 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -106,6 +106,25 @@ struct devfreq_dev_profile {
 	unsigned int max_state;
 };
 
+/**
+ * struct devfreq_stats - Devfreq's transitions stats counters
+ * @freq_table:		List of frequencies in ascending order.
+ * @max_state:		The size of freq_table.
+ * @total_trans:	Number of devfreq transitions.
+ * @trans_table:	Statistics of devfreq transitions.
+ * @time_in_state:	Statistics of devfreq states.
+ * @last_stat_updated:	The last time stats were updated.
+ */
+struct devfreq_stats {
+	unsigned long *freq_table;
+	unsigned int max_state;
+
+	unsigned int total_trans;
+	unsigned int *trans_table;
+	u64 *time_in_state;
+	unsigned long long last_stat_updated;
+};
+
 /**
  * struct devfreq - Device devfreq structure
  * @node:	list node - contains the devices with devfreq that have been
@@ -131,10 +150,7 @@ struct devfreq_dev_profile {
  * @suspend_freq:	 frequency of a device set during suspend phase.
  * @resume_freq:	 frequency of a device set in resume phase.
  * @suspend_count:	 suspend requests counter for a device.
- * @total_trans:	Number of devfreq transitions
- * @trans_table:	Statistics of devfreq transitions
- * @time_in_state:	Statistics of devfreq states
- * @last_stat_updated:	The last time stat updated
+ * @stats:	Statistics of devfreq transitions and states times
  * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER notifier
  *
  * This structure stores the devfreq information for a give device.
@@ -171,11 +187,8 @@ struct devfreq {
 	unsigned long resume_freq;
 	atomic_t suspend_count;
 
-	/* information for device frequency transition */
-	unsigned int total_trans;
-	unsigned int *trans_table;
-	u64 *time_in_state;
-	unsigned long long last_stat_updated;
+	/* information for device frequency transitions */
+	struct devfreq_stats *stats;
 
 	struct srcu_notifier_head transition_notifier_list;
 };
-- 
2.24.0

