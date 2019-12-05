Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10D2911431A
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 15:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbfLEOz5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 09:55:57 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54472 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbfLEOzp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 09:55:45 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191205145543euoutp014ea933ef1675b7143e92f8a51737ee1e~dgWukiNnE2715727157euoutp01Q
        for <linux-pm@vger.kernel.org>; Thu,  5 Dec 2019 14:55:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191205145543euoutp014ea933ef1675b7143e92f8a51737ee1e~dgWukiNnE2715727157euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575557744;
        bh=KmaGbTzTlYOOvKR3naErFrRnhfXJ6/RYsdqeeRcafSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QHpYzvURmvkX1PAyQBb39PJFR2i46c41lpb7R1QHOChrley1ztJQVvEPfYwPViOdj
         KiIVOjiZRNnJakA0DddVh9O97Zn0qtHwmhmUO96fawAbAgIzfI/iJDPoqxxknK8Wtw
         7vwewRUO6EXbhgQJsOpibD2gJzGlE53sZPrc8lZg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191205145543eucas1p23a5368ab9dc57e6fe78a8e29f7d17dc9~dgWuJcaJ61720517205eucas1p2C;
        Thu,  5 Dec 2019 14:55:43 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id CC.A4.61286.F6A19ED5; Thu,  5
        Dec 2019 14:55:43 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191205145543eucas1p11798d11e91f6a691d5989db7cba81b96~dgWt3wZKv1327913279eucas1p1H;
        Thu,  5 Dec 2019 14:55:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191205145543eusmtrp1f3355a836fc8a958c1009709d1b86884~dgWt3E9rm2543125431eusmtrp1j;
        Thu,  5 Dec 2019 14:55:43 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-47-5de91a6fb8fd
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 94.6F.08375.F6A19ED5; Thu,  5
        Dec 2019 14:55:43 +0000 (GMT)
Received: from AMDC3218.digital.local (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191205145542eusmtip27da929fb6ee9b5e7ebc6b73b5ba4c9dd~dgWtaoyNy2088220882eusmtip2X;
        Thu,  5 Dec 2019 14:55:42 +0000 (GMT)
From:   Kamil Konieczny <k.konieczny@samsung.com>
To:     k.konieczny@samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH v3 1/3] devfreq: change time stats to 64-bit
Date:   Thu,  5 Dec 2019 15:55:25 +0100
Message-Id: <20191205145527.26117-2-k.konieczny@samsung.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191205145527.26117-1-k.konieczny@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djPc7r5Ui9jDZrOyFhsnLGe1eL6l+es
        Fgs+zWC1OH9+A7vF2aY37BaXd81hs/jce4TRYu2Ru+wWtxtXsDlwemxa1cnm0bdlFaPH501y
        AcxRXDYpqTmZZalF+nYJXBkLF/xkK5gmUfFw5hLmBsYekS5GTg4JAROJ9zu2MXcxcnEICaxg
        lJjQ9JcdwvnCKPHuzUZWCOczo8TTvjWsMC3rFrwBs4UEljNKbN7tC9fxcsplFpAEm4C+xMGz
        J8FsEQFpic5FE5lAipgFjjFJ7Dr0F6xbWMBG4uvXKYwgNouAqsTxsz+YQWxeoPiSjS1sXYwc
        QNvkJea81QAJcwrYSmy79IwJokRQ4uTMJ2DzmYFKmrfOBvtBQqCbXeLHh4dQl7pI/J9/AsoW
        lnh1fAs7hC0jcXpyDwuEXS7xdGEfO0RzC6PEg/aPUAlricPHL7KCHMEsoCmxfpc+RNhR4uWn
        FawQt/FJ3HgrCHEDn8SkbdOZIcK8Eh1tQhDVqhLPT/UwQdjSEl3/10F1ekj8X8E+gVFxFpJn
        ZiF5ZhbC2gWMzKsYxVNLi3PTU4sN81LL9YoTc4tL89L1kvNzNzECE83pf8c/7WD8einpEKMA
        B6MSD++Mzy9ihVgTy4orcw8xSnAwK4nwpvO9jBXiTUmsrEotyo8vKs1JLT7EKM3BoiTOW83w
        IFpIID2xJDU7NbUgtQgmy8TBKdXA6GUd9aJN+ITJAr55z5ldJ37UtbP7URX/zLai8923r6vO
        yx8OFH7VXrHkWannk/6IcMt7PytShEr339XTUUh50Rwny713S7ZLSaR9gniR1vlVHdHvKx8t
        t46qUuh4qxW3LUFOLzDl1J9tB8451e9c3BeU+2Vr4sXfLWrd2WqF3WtO85xsUPNUYinOSDTU
        Yi4qTgQARHX3EDADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42I5/e/4Pd18qZexBq/fclhsnLGe1eL6l+es
        Fgs+zWC1OH9+A7vF2aY37BaXd81hs/jce4TRYu2Ru+wWtxtXsDlwemxa1cnm0bdlFaPH501y
        AcxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehkL
        F/xkK5gmUfFw5hLmBsYekS5GTg4JAROJdQvesHYxcnEICSxllHjV/4sRIiEt0Xh6NROELSzx
        51oXG0TRJ0aJo+vOsIAk2AT0JQ6ePQlmiwA1dC6aCNbALHCGSeJXSwWILSxgI/H16xSwoSwC
        qhLHz/5gBrF5geJLNrYADeUAWiAvMeetBkiYU8BWYtulZ0wgYSGgkoY3LBDVghInZz5hgZgu
        L9G8dTbzBEaBWUhSs5CkFjAyrWIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiMiG3Hfm7ewXhp
        Y/AhRgEORiUe3hmfX8QKsSaWFVfmHmKU4GBWEuFN53sZK8SbklhZlVqUH19UmpNafIjRFOiF
        icxSosn5wGjNK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TBKdXAaGMu
        4RTBoB2wJvupepewY/vf/JWPoq6H3i3QO5S8vi4svPjuF8vJi6Ij+L48vn9incmanxP7LqSX
        Lb/kzcLlGs+29qS/yRO2yzPjC01EL7yS6Wdo2/HwbW3BF2+xJcfPK8z4I8XXof1UsmzSjtKf
        ijHb/0SLOpy4/5aVW5hjls3BKCnGLW0lSizFGYmGWsxFxYkAYS788Z4CAAA=
X-CMS-MailID: 20191205145543eucas1p11798d11e91f6a691d5989db7cba81b96
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191205145543eucas1p11798d11e91f6a691d5989db7cba81b96
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191205145543eucas1p11798d11e91f6a691d5989db7cba81b96
References: <20191205145527.26117-1-k.konieczny@samsung.com>
        <CGME20191205145543eucas1p11798d11e91f6a691d5989db7cba81b96@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Change time stats counting to bigger type by using 64-bit jiffies.
This will make devfreq stats code look similar to cpufreq stats and
prevents overflow (for HZ = 1000 after 49.7 days).

Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
---
Changes in v3:
- changed types of cur_time and last_stats_updated to u64 as this is
  returned by get_jiffies_64()

Changes in v2:
- added Acked-by, rebased on linux-next
---
 drivers/devfreq/devfreq.c | 14 +++++++-------
 include/linux/devfreq.h   |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index bdeb4189c978..abecadeb3dc2 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -199,10 +199,10 @@ static int set_freq_table(struct devfreq *devfreq)
 int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
 {
 	int lev, prev_lev, ret = 0;
-	unsigned long cur_time;
+	u64 cur_time;
 
 	lockdep_assert_held(&devfreq->lock);
-	cur_time = jiffies;
+	cur_time = get_jiffies_64();
 
 	/* Immediately exit if previous_freq is not initialized yet. */
 	if (!devfreq->previous_freq)
@@ -525,7 +525,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
 			msecs_to_jiffies(devfreq->profile->polling_ms));
 
 out_update:
-	devfreq->last_stat_updated = jiffies;
+	devfreq->last_stat_updated = get_jiffies_64();
 	devfreq->stop_polling = false;
 
 	if (devfreq->profile->get_cur_freq &&
@@ -748,7 +748,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 
 	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
 			devfreq->profile->max_state,
-			sizeof(unsigned long),
+			sizeof(*devfreq->time_in_state),
 			GFP_KERNEL);
 	if (!devfreq->time_in_state) {
 		mutex_unlock(&devfreq->lock);
@@ -756,7 +756,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_devfreq;
 	}
 
-	devfreq->last_stat_updated = jiffies;
+	devfreq->last_stat_updated = get_jiffies_64();
 
 	srcu_init_notifier_head(&devfreq->transition_notifier_list);
 
@@ -1470,8 +1470,8 @@ static ssize_t trans_stat_show(struct device *dev,
 		for (j = 0; j < max_state; j++)
 			len += sprintf(buf + len, "%10u",
 				devfreq->trans_table[(i * max_state) + j]);
-		len += sprintf(buf + len, "%10u\n",
-			jiffies_to_msecs(devfreq->time_in_state[i]));
+		len += sprintf(buf + len, "%10llu\n", (u64)
+			jiffies64_to_msecs(devfreq->time_in_state[i]));
 	}
 
 	len += sprintf(buf + len, "Total transition : %u\n",
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 2bae9ed3c783..41f15e7a22b8 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -174,8 +174,8 @@ struct devfreq {
 	/* information for device frequency transition */
 	unsigned int total_trans;
 	unsigned int *trans_table;
-	unsigned long *time_in_state;
-	unsigned long last_stat_updated;
+	u64 *time_in_state;
+	u64 last_stat_updated;
 
 	struct srcu_notifier_head transition_notifier_list;
 };
-- 
2.24.0

