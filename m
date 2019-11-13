Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87BEEFACAC
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 10:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfKMJN5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 04:13:57 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34927 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727283AbfKMJN5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 04:13:57 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191113091355euoutp01ad2643435aa9fa0438242a5dd3af696a~WrgAhoVSF1861518615euoutp01g
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2019 09:13:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191113091355euoutp01ad2643435aa9fa0438242a5dd3af696a~WrgAhoVSF1861518615euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573636435;
        bh=N49/a4oWp3P4D7BBjUxpg5NsZssRUbfxVnbYKU9Xn/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NBLpNodzdUZIV1fmcub5ssUkGDK8Jv/uBSoAhbuCw4R7jGb80T25648gRPCD8yeCB
         6ib3pEQ0gWZ7CWptSlvXCbaz9Jzkc0Sg1JiXaEee1aKoprww7Ivf+GpqZSW8mvX69Z
         LbXUpYATDoyZNM1lowVGqGWEwjeF4QTElHLZaUZk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191113091354eucas1p1119ec71a7c14d025558ea3eb5d60a956~WrgAI1hgR0377603776eucas1p1z;
        Wed, 13 Nov 2019 09:13:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 49.82.04469.259CBCD5; Wed, 13
        Nov 2019 09:13:54 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191113091354eucas1p265de4985d167814f5080fbdf21b75a0a~Wrf-viiw51333913339eucas1p22;
        Wed, 13 Nov 2019 09:13:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191113091354eusmtrp2612372748ac1f755a2964f056937dcc4~Wrf-u0Izx1340513405eusmtrp2a;
        Wed, 13 Nov 2019 09:13:54 +0000 (GMT)
X-AuditID: cbfec7f2-569ff70000001175-b6-5dcbc95236a3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 1F.1A.04166.259CBCD5; Wed, 13
        Nov 2019 09:13:54 +0000 (GMT)
Received: from AMDC3218.digital.local (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191113091353eusmtip13fd034159458230afac32a5df05d39c3~Wrf-FFRzN0136201362eusmtip1a;
        Wed, 13 Nov 2019 09:13:53 +0000 (GMT)
From:   Kamil Konieczny <k.konieczny@samsung.com>
To:     k.konieczny@samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kamil Konieczny <k.konieczny@partner.samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH 7/7] devfreq: move statistics to separate struct
Date:   Wed, 13 Nov 2019 10:13:36 +0100
Message-Id: <20191113091336.5218-8-k.konieczny@samsung.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191113091336.5218-1-k.konieczny@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNKsWRmVeSWpSXmKPExsWy7djPc7pBJ0/HGmy/bGGxccZ6VovrX56z
        WvTt+89oseDTDFaL/sevmS3On9/AbnG26Q27xabH11gtLu+aw2bxufcIo8WM8/uYLNYeuctu
        cbtxBZsDr8emVZ1sHpuX1HscfLeHyaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyPv9rYCn4
        1cVY8W71CtYGxqmFXYycHBICJhI/7t9i7GLk4hASWMEoMXXJfSjnC6PEjCct7CBVQgKfGSW+
        tWjCdNxs6maCKFoOFH94lQWuo/PjTRaQKjYBfYmDZ0+C2SIC0hKdiyaCdTALPGeWuDz/PzNI
        QljAQWLa2h+MIDaLgKrEjR0rwNbxClhLnFz5AqiZA2idvMSctxogYU4BG4mlP9dAlQhKnJz5
        BGw+M1BJ89bZzCDzJQT2sUtcbb3JBHGqi8TBJ41sELawxKvjW9ghbBmJ/zvnQ9WUSzxd2McO
        0dzCKPGg/SMLRMJa4vDxi6wgRzALaEqs36UPcY+jxMWP0hAmn8SNt4IQJ/BJTNo2nRkizCvR
        0SYEMUNV4vmpHqhF0hJd/9exQtgeEl0H+lgnMCrOQvLMLCTPzEJYu4CReRWjeGppcW56arFh
        Xmq5XnFibnFpXrpecn7uJkZgkjr97/inHYxfLyUdYhTgYFTi4ZVYeCpWiDWxrLgy9xCjBAez
        kgjvjooTsUK8KYmVValF+fFFpTmpxYcYpTlYlMR5qxkeRAsJpCeWpGanphakFsFkmTg4pRoY
        16+++6dG7fyKtyXZLHKNwZfyjNeqGk7fGyUU/HJ9/RWNvIWb1hsabuCTyu/bvs7v446M7z+v
        dJ+RPJTOvvXUkqdbfcKYQgL/fw7eru/neKb7Z3GGee2y3h6vO282C9RM9l4WFad2K+mE39tX
        WRNeXV/A8txijrz0rLY9ZUZbK+PnprWsqtY6q8RSnJFoqMVcVJwIAFsaap9OAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsVy+t/xu7pBJ0/HGmx4JGOxccZ6VovrX56z
        WvTt+89oseDTDFaL/sevmS3On9/AbnG26Q27xabH11gtLu+aw2bxufcIo8WM8/uYLNYeuctu
        cbtxBZsDr8emVZ1sHpuX1HscfLeHyaNvyypGj8+b5AJYo/RsivJLS1IVMvKLS2yVog0tjPQM
        LS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyPv9rYCn41cVY8W71CtYGxqmFXYycHBIC
        JhI3m7qZuhi5OIQEljJKNDR8Y4dISEs0nl7NBGELS/y51sUGUfSJUeLZ/3vMIAk2AX2Jg2dP
        soDYIkANnYsmgk1iFnjPLDFpzxZWkISwgIPEtLU/GEFsFgFViRs7VoBt4BWwlji58gVQMwfQ
        BnmJOW81QMKcAjYSS3+uASsRAip5suEtG0S5oMTJmU/AdjEDlTdvnc08gVFgFpLULCSpBYxM
        qxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQIjatuxn5t3MF7aGHyIUYCDUYmH98C8U7FCrIll
        xZW5hxglOJiVRHh3VJyIFeJNSaysSi3Kjy8qzUktPsRoCvTDRGYp0eR8YLTnlcQbmhqaW1ga
        mhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpgNFNweiSwQM7sMd8EkWVN+R4Z33zf
        ndPqPxU/Rdli052TKjtyrnxZwBrzlOv1ngMsej6KdyNlQrTnyEWUzaxOOCg2Z0PwT071BUdy
        yuY/lfJpdJrWKsR5xfB7uemHi0lLJPZIfzilFTDj6a/6piXN8+52aa2ySt/64FrLQ/Vn9heX
        yq/J9Z98TomlOCPRUIu5qDgRAIrne8q+AgAA
X-CMS-MailID: 20191113091354eucas1p265de4985d167814f5080fbdf21b75a0a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191113091354eucas1p265de4985d167814f5080fbdf21b75a0a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191113091354eucas1p265de4985d167814f5080fbdf21b75a0a
References: <20191113091336.5218-1-k.konieczny@samsung.com>
        <CGME20191113091354eucas1p265de4985d167814f5080fbdf21b75a0a@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Count time and transitions between devfreq frequencies in separate struct
for improved code readability and maintenance.

Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
---
 drivers/devfreq/devfreq.c          | 156 ++++++++++++++++-------------
 drivers/devfreq/exynos-bus.c       |   6 +-
 drivers/devfreq/governor_passive.c |  26 +++--
 include/linux/devfreq.h            |  43 ++++----
 4 files changed, 129 insertions(+), 102 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index d79412b0de59..d85867a91230 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -105,10 +105,11 @@ static unsigned long find_available_max_freq(struct devfreq *devfreq)
  */
 static int devfreq_get_freq_level(struct devfreq *devfreq, unsigned long freq)
 {
+	struct devfreq_stats *stats = devfreq->profile->stats;
 	int lev;
 
-	for (lev = 0; lev < devfreq->profile->max_state; lev++)
-		if (freq == devfreq->profile->freq_table[lev])
+	for (lev = 0; lev < stats->max_state; lev++)
+		if (freq == stats->freq_table[lev])
 			return lev;
 
 	return -EINVAL;
@@ -117,56 +118,64 @@ static int devfreq_get_freq_level(struct devfreq *devfreq, unsigned long freq)
 static int set_freq_table(struct devfreq *devfreq)
 {
 	struct devfreq_dev_profile *profile = devfreq->profile;
+	struct devfreq_stats *stats;
 	struct dev_pm_opp *opp;
 	unsigned long freq;
-	int i, count;
+	int i, count, err = -ENOMEM;
 
 	/* Initialize the freq_table from OPP table */
 	count = dev_pm_opp_get_opp_count(devfreq->dev.parent);
 	if (count <= 0)
 		return -EINVAL;
 
-	profile->max_state = count;
-	profile->freq_table = devm_kcalloc(devfreq->dev.parent,
-					count,
-					sizeof(*profile->freq_table),
-					GFP_KERNEL);
-	if (!profile->freq_table) {
-		profile->max_state = 0;
+	stats = devm_kzalloc(devfreq->dev.parent,
+			     sizeof(struct devfreq_stats), GFP_KERNEL);
+	if (!stats)
 		return -ENOMEM;
-	}
 
-	for (i = 0, freq = 0; i < profile->max_state; i++, freq++) {
+	profile->stats = stats;
+	stats->max_state = count;
+	stats->freq_table = devm_kcalloc(devfreq->dev.parent,
+					 count,
+					 sizeof(*stats->freq_table),
+					 GFP_KERNEL);
+	if (!stats->freq_table)
+		goto err_no_mem;
+
+	for (i = 0, freq = 0; i < count; i++, freq++) {
 		opp = dev_pm_opp_find_freq_ceil(devfreq->dev.parent, &freq);
 		if (IS_ERR(opp)) {
-			devm_kfree(devfreq->dev.parent, profile->freq_table);
-			profile->max_state = 0;
-			return PTR_ERR(opp);
+			devm_kfree(devfreq->dev.parent, stats->freq_table);
+			stats->max_state = 0;
+			err = PTR_ERR(opp);
+			goto err_no_mem;
 		}
 		dev_pm_opp_put(opp);
-		profile->freq_table[i] = freq;
+		stats->freq_table[i] = freq;
 	}
 
-	profile->trans_table = devm_kzalloc(devfreq->dev.parent,
-					    array3_size(sizeof(unsigned int),
-							count, count),
-					    GFP_KERNEL);
-	if (!profile->trans_table)
+	stats->trans_table = devm_kzalloc(devfreq->dev.parent,
+					  array3_size(sizeof(unsigned int),
+						      count, count),
+					  GFP_KERNEL);
+	if (!stats->trans_table)
 		goto err_no_mem;
 
-	profile->time_in_state = devm_kcalloc(devfreq->dev.parent, count,
-					      sizeof(*profile->time_in_state),
-					      GFP_KERNEL);
-	if (!profile->time_in_state)
+	stats->time_in_state = devm_kcalloc(devfreq->dev.parent, count,
+					    sizeof(*stats->time_in_state),
+					    GFP_KERNEL);
+	if (!stats->time_in_state)
 		goto err_no_mem;
 
-	profile->last_time = get_jiffies_64();
-	spin_lock_init(&profile->stats_lock);
+	stats->last_time = get_jiffies_64();
+	spin_lock_init(&stats->stats_lock);
 
 	return 0;
 err_no_mem:
-	profile->max_state = 0;
-	return -ENOMEM;
+	stats->max_state = 0;
+	devm_kfree(devfreq->dev.parent, profile->stats);
+	profile->stats = NULL;
+	return err;
 }
 
 /**
@@ -176,7 +185,7 @@ static int set_freq_table(struct devfreq *devfreq)
  */
 int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
 {
-	struct devfreq_dev_profile *profile = devfreq->profile;
+	struct devfreq_stats *stats = devfreq->profile->stats;
 	unsigned long long cur_time;
 	int lev, prev_lev, ret = 0;
 
@@ -184,22 +193,21 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
 
 	/* Immediately exit if previous_freq is not initialized yet. */
 	if (!devfreq->previous_freq) {
-		spin_lock(&profile->stats_lock);
-		profile->last_time = cur_time;
-		spin_unlock(&profile->stats_lock);
+		spin_lock(&stats->stats_lock);
+		stats->last_time = cur_time;
+		spin_unlock(&stats->stats_lock);
 		return 0;
 	}
 
 	prev_lev = devfreq_get_freq_level(devfreq, devfreq->previous_freq);
 
-	spin_lock(&profile->stats_lock);
+	spin_lock(&stats->stats_lock);
 	if (prev_lev < 0) {
 		ret = prev_lev;
 		goto out;
 	}
 
-	profile->time_in_state[prev_lev] +=
-			 cur_time - profile->last_time;
+	stats->time_in_state[prev_lev] += cur_time - stats->last_time;
 	lev = devfreq_get_freq_level(devfreq, freq);
 	if (lev < 0) {
 		ret = lev;
@@ -207,14 +215,14 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
 	}
 
 	if (lev != prev_lev) {
-		profile->trans_table[(prev_lev *
-				profile->max_state) + lev]++;
-		profile->total_trans++;
+		stats->trans_table[(prev_lev *
+				stats->max_state) + lev]++;
+		stats->total_trans++;
 	}
 
 out:
-	profile->last_time = cur_time;
-	spin_unlock(&profile->stats_lock);
+	stats->last_time = cur_time;
+	spin_unlock(&stats->stats_lock);
 	return ret;
 }
 EXPORT_SYMBOL(devfreq_update_status);
@@ -504,9 +512,9 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
 		queue_delayed_work(devfreq_wq, &devfreq->work,
 			msecs_to_jiffies(profile->polling_ms));
 
-	spin_lock(&profile->stats_lock);
-	profile->last_time = get_jiffies_64();
-	spin_unlock(&profile->stats_lock);
+	spin_lock(&profile->stats->stats_lock);
+	profile->stats->last_time = get_jiffies_64();
+	spin_unlock(&profile->stats->stats_lock);
 	devfreq->stop_polling = false;
 
 	if (profile->get_cur_freq &&
@@ -677,7 +685,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->data = data;
 	devfreq->nb.notifier_call = devfreq_notifier_call;
 
-	if (!profile->max_state && !profile->freq_table) {
+	if (!profile->stats) {
 		mutex_unlock(&devfreq->lock);
 		err = set_freq_table(devfreq);
 		if (err < 0)
@@ -1282,6 +1290,7 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
 	struct devfreq *df = to_devfreq(dev);
+	struct devfreq_stats *stats = df->profile->stats;
 	unsigned long value;
 	int ret;
 
@@ -1297,13 +1306,13 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
 			goto unlock;
 		}
 	} else {
-		unsigned long *freq_table = df->profile->freq_table;
+		unsigned long *freq_table = stats->freq_table;
 
 		/* Get minimum frequency according to sorting order */
-		if (freq_table[0] < freq_table[df->profile->max_state - 1])
+		if (freq_table[0] < freq_table[stats->max_state - 1])
 			value = freq_table[0];
 		else
-			value = freq_table[df->profile->max_state - 1];
+			value = freq_table[stats->max_state - 1];
 	}
 
 	df->min_freq = value;
@@ -1326,6 +1335,7 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
 	struct devfreq *df = to_devfreq(dev);
+	struct devfreq_stats *stats = df->profile->stats;
 	unsigned long value;
 	int ret;
 
@@ -1341,11 +1351,11 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
 			goto unlock;
 		}
 	} else {
-		unsigned long *freq_table = df->profile->freq_table;
+		unsigned long *freq_table = stats->freq_table;
 
 		/* Get maximum frequency according to sorting order */
-		if (freq_table[0] < freq_table[df->profile->max_state - 1])
-			value = freq_table[df->profile->max_state - 1];
+		if (freq_table[0] < freq_table[stats->max_state - 1])
+			value = freq_table[stats->max_state - 1];
 		else
 			value = freq_table[0];
 	}
@@ -1373,14 +1383,15 @@ static ssize_t available_frequencies_show(struct device *d,
 					  char *buf)
 {
 	struct devfreq *df = to_devfreq(d);
+	struct devfreq_stats *stats = df->profile->stats;
 	ssize_t count = 0;
 	int i;
 
 	mutex_lock(&df->lock);
 
-	for (i = 0; i < df->profile->max_state; i++)
+	for (i = 0; i < stats->max_state; i++)
 		count += scnprintf(&buf[count], (PAGE_SIZE - count - 2),
-				"%lu ", df->profile->freq_table[i]);
+				"%lu ", stats->freq_table[i]);
 
 	mutex_unlock(&df->lock);
 	/* Truncate the trailing space */
@@ -1398,9 +1409,10 @@ static ssize_t trans_stat_show(struct device *dev,
 {
 	struct devfreq *devfreq = to_devfreq(dev);
 	struct devfreq_dev_profile *profile = devfreq->profile;
+	struct devfreq_stats *stats = profile->stats;
+	unsigned int max_state = stats->max_state;
 	ssize_t len;
 	int i, j;
-	unsigned int max_state = profile->max_state;
 
 	if (!devfreq->stop_polling &&
 			devfreq_update_status(devfreq, devfreq->previous_freq))
@@ -1411,45 +1423,45 @@ static ssize_t trans_stat_show(struct device *dev,
 	len = sprintf(buf, "     From  :   To\n");
 	len += sprintf(buf + len, "           :");
 
-	spin_lock(&profile->stats_lock);
+	spin_lock(&stats->stats_lock);
 	for (i = 0; i < max_state; i++)
 		len += sprintf(buf + len, "%10lu",
-				profile->freq_table[i]);
+				stats->freq_table[i]);
 
 	len += sprintf(buf + len, "   time(ms)\n");
 
 	for (i = 0; i < max_state; i++) {
-		if (profile->freq_table[i] == devfreq->previous_freq)
+		if (stats->freq_table[i] == devfreq->previous_freq)
 			len += sprintf(buf + len, "*");
 		else
 			len += sprintf(buf + len, " ");
 
 		len += sprintf(buf + len, "%10lu:",
-				profile->freq_table[i]);
+				stats->freq_table[i]);
 		for (j = 0; j < max_state; j++)
 			len += sprintf(buf + len, "%10u",
-				profile->trans_table[(i * max_state) + j]);
+				stats->trans_table[(i * max_state) + j]);
 		len += sprintf(buf + len, "%10llu\n", (u64)
-			jiffies64_to_msecs(profile->time_in_state[i]));
+			jiffies64_to_msecs(stats->time_in_state[i]));
 	}
 
 	len += sprintf(buf + len, "Total transition : %u\n",
-					profile->total_trans);
-	spin_unlock(&profile->stats_lock);
+					stats->total_trans);
+	spin_unlock(&stats->stats_lock);
 	return len;
 }
 static DEVICE_ATTR_RO(trans_stat);
 
-static void defvreq_stats_clear_table(struct devfreq_dev_profile *profile)
+static void defvreq_stats_clear_table(struct devfreq_stats *stats)
 {
-	unsigned int count = profile->max_state;
-
-	spin_lock(&profile->stats_lock);
-	memset(profile->time_in_state, 0, count * sizeof(u64));
-	memset(profile->trans_table, 0, count * count * sizeof(int));
-	profile->last_time = get_jiffies_64();
-	profile->total_trans = 0;
-	spin_unlock(&profile->stats_lock);
+	unsigned int count = stats->max_state;
+
+	spin_lock(&stats->stats_lock);
+	memset(stats->time_in_state, 0, count * sizeof(u64));
+	memset(stats->trans_table, 0, count * count * sizeof(int));
+	stats->last_time = get_jiffies_64();
+	stats->total_trans = 0;
+	spin_unlock(&stats->stats_lock);
 }
 
 static ssize_t trans_reset_store(struct device *dev,
@@ -1459,7 +1471,7 @@ static ssize_t trans_reset_store(struct device *dev,
 {
 	struct devfreq *devfreq = to_devfreq(dev);
 
-	defvreq_stats_clear_table(devfreq->profile);
+	defvreq_stats_clear_table(devfreq->profile->stats);
 
 	return count;
 }
diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index d9f377912c10..b212aae2bb3e 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -496,9 +496,9 @@ static int exynos_bus_probe(struct platform_device *pdev)
 	}
 
 out:
-	max_state = bus->devfreq->profile->max_state;
-	min_freq = (bus->devfreq->profile->freq_table[0] / 1000);
-	max_freq = (bus->devfreq->profile->freq_table[max_state - 1] / 1000);
+	max_state = profile->stats->max_state;
+	min_freq = (profile->stats->freq_table[0] / 1000);
+	max_freq = (profile->stats->freq_table[max_state - 1] / 1000);
 	pr_info("exynos-bus: new bus device registered: %s (%6ld KHz ~ %6ld KHz)\n",
 			dev_name(dev), min_freq, max_freq);
 
diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 58308948b863..b2d87a88335c 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -18,6 +18,8 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 	struct devfreq_passive_data *p_data
 			= (struct devfreq_passive_data *)devfreq->data;
 	struct devfreq *parent_devfreq = (struct devfreq *)p_data->parent;
+	struct devfreq_stats *parent_stats = parent_devfreq->profile->stats;
+	struct devfreq_stats *stats;
 	unsigned long child_freq = ULONG_MAX;
 	struct dev_pm_opp *opp;
 	int i, count, ret = 0;
@@ -47,10 +49,14 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 	 * device. And then the index is used for getting the suitable
 	 * new frequency for passive devfreq device.
 	 */
-	if (!devfreq->profile || !devfreq->profile->freq_table
-		|| devfreq->profile->max_state <= 0)
+	if (!devfreq->profile || !devfreq->profile->stats ||
+	    devfreq->profile->stats->max_state <= 0 ||
+	    !parent_devfreq->profile ||	!parent_devfreq->profile->stats ||
+	    parent_devfreq->profile->stats->max_state <= 0)
 		return -EINVAL;
 
+	stats = devfreq->profile->stats;
+	parent_stats = parent_devfreq->profile->stats;
 	/*
 	 * The passive governor have to get the correct frequency from OPP
 	 * list of parent device. Because in this case, *freq is temporary
@@ -68,21 +74,21 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 	 * Get the OPP table's index of decided freqeuncy by governor
 	 * of parent device.
 	 */
-	for (i = 0; i < parent_devfreq->profile->max_state; i++)
-		if (parent_devfreq->profile->freq_table[i] == *freq)
+	for (i = 0; i < parent_stats->max_state; i++)
+		if (parent_stats->freq_table[i] == *freq)
 			break;
 
-	if (i == parent_devfreq->profile->max_state) {
+	if (i == parent_stats->max_state) {
 		ret = -EINVAL;
 		goto out;
 	}
 
 	/* Get the suitable frequency by using index of parent device. */
-	if (i < devfreq->profile->max_state) {
-		child_freq = devfreq->profile->freq_table[i];
+	if (i < stats->max_state) {
+		child_freq = stats->freq_table[i];
 	} else {
-		count = devfreq->profile->max_state;
-		child_freq = devfreq->profile->freq_table[count - 1];
+		count = stats->max_state;
+		child_freq = stats->freq_table[count - 1];
 	}
 
 	/* Return the suitable frequency for passive device. */
@@ -109,7 +115,7 @@ static int update_devfreq_passive(struct devfreq *devfreq, unsigned long freq)
 	if (ret < 0)
 		goto out;
 
-	if (devfreq->profile->freq_table
+	if (devfreq->profile->stats
 		&& (devfreq_update_status(devfreq, freq)))
 		dev_err(&devfreq->dev,
 			"Couldn't update frequency transition information.\n");
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 4ceb2a517a9c..8459af1a1583 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -64,6 +64,30 @@ struct devfreq_dev_status {
  */
 #define DEVFREQ_FLAG_LEAST_UPPER_BOUND		0x1
 
+/**
+ * struct devfreq_stats - Devfreq's transitions stats counters
+ * @freq_table:		Optional list of frequencies to support statistics
+ *			and freq_table must be generated in ascending order.
+ * @max_state:		The size of freq_table.
+ * @total_trans:	Number of devfreq transitions
+ * @trans_table:	Statistics of devfreq transitions
+ * @time_in_state:	Statistics of devfreq states
+ * @last_time:		The last time stats were updated
+ * @stats_lock:		Lock protecting trans_table, time_in_state,
+ *			last_time and total_trans used for statistics
+ */
+struct devfreq_stats {
+	unsigned long *freq_table;
+	unsigned int max_state;
+
+	/* information for device frequency transition */
+	unsigned int total_trans;
+	unsigned int *trans_table;
+	u64 *time_in_state;
+	unsigned long long last_time;
+	spinlock_t stats_lock;
+};
+
 /**
  * struct devfreq_dev_profile - Devfreq's user device profile
  * @initial_freq:	The operating frequency when devfreq_add_device() is
@@ -88,15 +112,7 @@ struct devfreq_dev_status {
  *			from devfreq_remove_device() call. If the user
  *			has registered devfreq->nb at a notifier-head,
  *			this is the time to unregister it.
- * @freq_table:		Optional list of frequencies to support statistics
- *			and freq_table must be generated in ascending order.
- * @max_state:		The size of freq_table.
- * @total_trans:	Number of devfreq transitions
- * @trans_table:	Statistics of devfreq transitions
- * @time_in_state:	Statistics of devfreq states
- * @last_time:		The last time stats were updated
- * @stats_lock:		Lock protecting trans_table, time_in_state,
- *			last_time and total_trans used for statistics
+ * @stats:		Statistics of devfreq states and state transitions
  */
 struct devfreq_dev_profile {
 	unsigned long initial_freq;
@@ -108,14 +124,7 @@ struct devfreq_dev_profile {
 	int (*get_cur_freq)(struct device *dev, unsigned long *freq);
 	void (*exit)(struct device *dev);
 
-	unsigned long *freq_table;
-	unsigned int max_state;
-	/* information for device frequency transition */
-	unsigned int total_trans;
-	unsigned int *trans_table;
-	u64 *time_in_state;
-	unsigned long long last_time;
-	spinlock_t stats_lock;
+	struct devfreq_stats *stats;
 };
 
 /**
-- 
2.24.0

