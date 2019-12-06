Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 408CF114C0E
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2019 06:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfLFF1h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Dec 2019 00:27:37 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:29122 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfLFF1h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Dec 2019 00:27:37 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191206052733epoutp02e62a26ee95490c64ad1e1694e127deeb~dsP7rl_mj2215222152epoutp02H
        for <linux-pm@vger.kernel.org>; Fri,  6 Dec 2019 05:27:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191206052733epoutp02e62a26ee95490c64ad1e1694e127deeb~dsP7rl_mj2215222152epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575610053;
        bh=mCyYY3ZTNT06PPdx/CZUMM1o0YbWV2MA1nJ4T3jfLpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MFZ9FnHztFJrFoA4QA4D1nKYaAzN+bD0nezyfxasBQsIYEfLpmvGqYezalUDVGPbw
         CuLAzWYRdBAzEV4m09jEDBW1uQ/HzDOcU/B45Ft1DesuMdJvoDgvU2gzxFPFGv/pDp
         g8716BLgcqrDV2LXE9klLTnikOtcLqxb8RO2KZ/Q=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191206052733epcas1p36e7ae2a438bf52e0b0c17d87fa36f107~dsP7NE-Ck1570915709epcas1p32;
        Fri,  6 Dec 2019 05:27:33 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.153]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47Th1G4n38zMqYkd; Fri,  6 Dec
        2019 05:27:30 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        F6.B7.51241.2C6E9ED5; Fri,  6 Dec 2019 14:27:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191206052729epcas1p110d11c728db1ebd7487c8c5fe936df21~dsP362GWR1204812048epcas1p1f;
        Fri,  6 Dec 2019 05:27:29 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191206052729epsmtrp19ae7f130d1478ee48478cbbe6c2cac63~dsP36El1Z1150311503epsmtrp1K;
        Fri,  6 Dec 2019 05:27:29 +0000 (GMT)
X-AuditID: b6c32a39-14bff7000001c829-29-5de9e6c2f804
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        64.FA.06569.1C6E9ED5; Fri,  6 Dec 2019 14:27:29 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191206052729epsmtip1a75398bf0bdcdcf74151159ebf27166a~dsP3v12uY2991529915epsmtip1L;
        Fri,  6 Dec 2019 05:27:29 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     rafael.j.wysocki@intel.com, myungjoo.ham@samsung.com,
        b.zolnierkie@samsung.com, cw00.choi@samsung.com,
        gregkh@linuxfoundation.org, krzk@kernel.org,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        mchehab@kernel.org, cpgs@samsung.com,
        Kamil Konieczny <k.konieczny@samsung.com>
Subject: [PATCH v4] PM / devfreq: Move statistics to separate struct
 devfreq_stats
Date:   Fri,  6 Dec 2019 14:33:40 +0900
Message-Id: <20191206053340.18706-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205145527.26117-4-k.konieczny@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUwTURDH87rt7pZQ3Kygz8YArheQgCxQXAgYjUc2HhGjn1TEDV1bQq90
        WyMeEUS5goDBIFFqVAQURaAiooFgKngkKhpiUAkeEbVVNEABOYzashD99p83v//MZN7gCFmK
        KvE0g4U3GzgdhfpIm++HRoQ7PruSIx+NLmEay+tljMsRyvSMfJEx2ZX1KHNhuFzGdHU1YMzT
        YwMY0323AmXcJzsAU9fRhzHV9l8SpjfrCsp8vPIdW61gK1tdEtZem4+y7bbrGFvUVAtYtz0w
        SbYzPUHLc2reHMwbUo3qNIMmkdq0PWVtiio2kg6n45iVVLCB0/OJ1LrNSeEb0nSeGang/ZzO
        6nlK4gSBWrEqwWy0WvhgrVGwJFK8Sa0zxZkiBE4vWA2aiFSjPp6OjIxSecC96Vpn7ihistEH
        OssnsUwwFFIA5DgkYuCd562SAuCDk0QLgKXuE6gYDAN4s/MV6qVIYgzAkoGNs47snhaZCLUB
        mGuvmQlGADzuui/xUigRBtudotufiIfO3K+YF0KIyxLYO1SGeRNziR2wKGsKeLWUWArPVExK
        vVrhMfS/vgTEdkHwWsM9xKvlRCK0Pbw4PR8kulHYPVjhKYR7gnVw/LRU5OfCrw+bMFEroas4
        Z0Yfglcfd8x48wBsan8uExPRsL2qVOKtgxChsP7uCvF5EbwzZZuZQQEzG6em6yCEH/wxWigT
        2ypgXg4pIoth9/s+iagXwMrcfFTULHzqdAJxQSUAVnV9QEtA0Nl/3S4AUAvm8SZBr+EF2qT6
        //vsYPogw+JawINnmx2AwAHlqyh3O5NJGbdfyNA7AMQRyl+h8XMlkwo1l3GQNxtTzFYdLziA
        yrPVU4gyINXoOW+DJYVWRUVHRzMxdKyKpqn5Cnz8RTJJaDgLn87zJt4865PgcmUmiFuMBmyV
        P1lWZv10rpcm21h75cuM0T8bJm78PO0TMC9/ta31cMgudkv1O2VLzUKhSHeUqR2caKwby0Mp
        Yc6ZEW3ZoiOxbW/W36IL/PcVVzctaSt0R6BBZf0NbOd52/Ld3O0udA8lJwuL034/6aEuD+KB
        9m12XP3A5vutOeTtGkoqaDk6DDEL3F8BW1mMpgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrILMWRmVeSWpSXmKPExsWy7bCSnO7BZy9jDR5el7XYOGM9q8XLQ5oW
        1788Z7VoXryezWLBpxmsFufPb2C3ONv0ht3i8q45bBafe48wWqw9cpfdYtmmP0wWtxtXsFk8
        XvGW3YHXY/Gel0wem1Z1snnsn7uG3aNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyXrR/ZS6Y
        a1hxdMYv9gbGjxpdjJwcEgImEs3Xd7B2MXJxCAnsZpT4eGkGK0RCUmLaxaPMXYwcQLawxOHD
        xRA1nxglVp5Yzg5SwyagJbH/xQ02EFtEwEbi/dwzLCBFzAIbmCTWHdsGlhAWCJL4sOIrC4jN
        IqAqMX3OLzCbV8BK4snNRYwQy+QlVm84wAxicwrYSsw9vhCsVwho6Onld1knMPItYGRYxSiZ
        WlCcm55bbFhglJdarlecmFtcmpeul5yfu4kRHLBaWjsYT5yIP8QowMGoxMM74/OLWCHWxLLi
        ytxDjBIczEoivOl8L2OFeFMSK6tSi/Lji0pzUosPMUpzsCiJ88rnH4sUEkhPLEnNTk0tSC2C
        yTJxcEo1MFrzK3zbvj54esVxa5uJC18XbedvXXkk2feAkfRt/gNShpe2p+z2Zk25sIrF9Wso
        d+TkvjsnsneIqHM47tW99coiMGXLCX2WWhPJbX8vS9sYuHHNe9o0zbpb3+dJ7ly15KsW5XX1
        AW/W3PVUnxirYHb7nUTvmzsMfu33bh6vfLH+5ezr+c8qpyqxFGckGmoxFxUnAgBQ0ob7VAIA
        AA==
X-CMS-MailID: 20191206052729epcas1p110d11c728db1ebd7487c8c5fe936df21
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191206052729epcas1p110d11c728db1ebd7487c8c5fe936df21
References: <20191205145527.26117-4-k.konieczny@samsung.com>
        <CGME20191206052729epcas1p110d11c728db1ebd7487c8c5fe936df21@epcas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Kamil Konieczny <k.konieczny@samsung.com>

Count time and transitions between devfreq frequencies in separate
struct devfreq_stats for improved code readability and maintenance.

Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
[cw00.choi: Fix the merge conflict in trasn_stat_store]
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 44 ++++++++++++++++++++-------------------
 include/linux/devfreq.h   | 26 +++++++++++++++--------
 2 files changed, 40 insertions(+), 30 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index df31f430051d..1786a86b1779 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -214,8 +214,8 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
 		goto out;
 	}
 
-	devfreq->time_in_state[prev_lev] +=
-			 cur_time - devfreq->last_stat_updated;
+	devfreq->stats.time_in_state[prev_lev] +=
+			cur_time - devfreq->stats.last_update;
 
 	lev = devfreq_get_freq_level(devfreq, freq);
 	if (lev < 0) {
@@ -224,13 +224,13 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
 	}
 
 	if (lev != prev_lev) {
-		devfreq->trans_table[(prev_lev *
-				devfreq->profile->max_state) + lev]++;
-		devfreq->total_trans++;
+		devfreq->stats.trans_table[
+			(prev_lev * devfreq->profile->max_state) + lev]++;
+		devfreq->stats.total_trans++;
 	}
 
 out:
-	devfreq->last_stat_updated = cur_time;
+	devfreq->stats.last_update = cur_time;
 	return ret;
 }
 EXPORT_SYMBOL(devfreq_update_status);
@@ -525,7 +525,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
 			msecs_to_jiffies(devfreq->profile->polling_ms));
 
 out_update:
-	devfreq->last_stat_updated = get_jiffies_64();
+	devfreq->stats.last_update = get_jiffies_64();
 	devfreq->stop_polling = false;
 
 	if (devfreq->profile->get_cur_freq &&
@@ -735,28 +735,29 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_out;
 	}
 
-	devfreq->trans_table = devm_kzalloc(&devfreq->dev,
+	devfreq->stats.trans_table = devm_kzalloc(&devfreq->dev,
 			array3_size(sizeof(unsigned int),
 				    devfreq->profile->max_state,
 				    devfreq->profile->max_state),
 			GFP_KERNEL);
-	if (!devfreq->trans_table) {
+	if (!devfreq->stats.trans_table) {
 		mutex_unlock(&devfreq->lock);
 		err = -ENOMEM;
 		goto err_devfreq;
 	}
 
-	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
+	devfreq->stats.time_in_state = devm_kcalloc(&devfreq->dev,
 			devfreq->profile->max_state,
-			sizeof(*devfreq->time_in_state),
+			sizeof(*devfreq->stats.time_in_state),
 			GFP_KERNEL);
-	if (!devfreq->time_in_state) {
+	if (!devfreq->stats.time_in_state) {
 		mutex_unlock(&devfreq->lock);
 		err = -ENOMEM;
 		goto err_devfreq;
 	}
 
-	devfreq->last_stat_updated = get_jiffies_64();
+	devfreq->stats.total_trans = 0;
+	devfreq->stats.last_update = get_jiffies_64();
 
 	srcu_init_notifier_head(&devfreq->transition_notifier_list);
 
@@ -1469,13 +1470,14 @@ static ssize_t trans_stat_show(struct device *dev,
 				devfreq->profile->freq_table[i]);
 		for (j = 0; j < max_state; j++)
 			len += sprintf(buf + len, "%10u",
-				devfreq->trans_table[(i * max_state) + j]);
+				devfreq->stats.trans_table[(i * max_state) + j]);
+
 		len += sprintf(buf + len, "%10llu\n", (u64)
-			jiffies64_to_msecs(devfreq->time_in_state[i]));
+			jiffies64_to_msecs(devfreq->stats.time_in_state[i]));
 	}
 
 	len += sprintf(buf + len, "Total transition : %u\n",
-					devfreq->total_trans);
+					devfreq->stats.total_trans);
 	return len;
 }
 
@@ -1494,13 +1496,13 @@ static ssize_t trans_stat_store(struct device *dev,
 		return -EINVAL;
 
 	mutex_lock(&df->lock);
-	memset(df->time_in_state, 0, (df->profile->max_state *
-					sizeof(*df->time_in_state)));
-	memset(df->trans_table, 0, array3_size(sizeof(unsigned int),
+	memset(df->stats.time_in_state, 0, (df->profile->max_state *
+					sizeof(*df->stats.time_in_state)));
+	memset(df->stats.trans_table, 0, array3_size(sizeof(unsigned int),
 					df->profile->max_state,
 					df->profile->max_state));
-	df->total_trans = 0;
-	df->last_stat_updated = get_jiffies_64();
+	df->stats.total_trans = 0;
+	df->stats.last_update = get_jiffies_64();
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
2.17.1

