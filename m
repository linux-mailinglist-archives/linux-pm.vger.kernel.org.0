Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26BFAFACA9
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 10:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfKMJNz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 04:13:55 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34910 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfKMJNz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 04:13:55 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191113091353euoutp0188a83b5ab6b28d9429312397a972cf3d~Wrf-DJv7g1914219142euoutp01G
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2019 09:13:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191113091353euoutp0188a83b5ab6b28d9429312397a972cf3d~Wrf-DJv7g1914219142euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573636433;
        bh=yzWOzEn9xl+o0h/YwB50Z5PsuJeNLsiTaz8iIyEE6Rg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=plouXazuKAN1Q2rMtGAffaS/b6n4AlyOAJZOg6+3ukzRCtkUWu2FdcrAPP41i76+N
         xhzOdqvk3RvJfDwfOBkX7GE0uBcGEEiXB6POfSQI4j87jloj2e+6kwfFduCl4WibQV
         3himnHzO3Hga4wnvNUAJWCQDaONNszpAWywMIL6U=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191113091353eucas1p1a6b890ef91a9265a8b60d18f0670e20d~Wrf_yvvlt0367003670eucas1p1F;
        Wed, 13 Nov 2019 09:13:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 6F.24.04309.159CBCD5; Wed, 13
        Nov 2019 09:13:53 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191113091352eucas1p1825d815661c1a8377449f511c65ea230~Wrf_P0Wsf0367003670eucas1p1E;
        Wed, 13 Nov 2019 09:13:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191113091352eusmtrp2dac0dd15584ca1abc852136932a9b07d~Wrf_PP9_w1340513405eusmtrp2V;
        Wed, 13 Nov 2019 09:13:52 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-08-5dcbc9516243
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id EC.1A.04166.059CBCD5; Wed, 13
        Nov 2019 09:13:52 +0000 (GMT)
Received: from AMDC3218.digital.local (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191113091352eusmtip10d9792413003df2016df248371553a1a~Wrf9ucwub0379503795eusmtip1R;
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
Subject: [PATCH 4/7] devfreq: change var name used in time statistics
Date:   Wed, 13 Nov 2019 10:13:33 +0100
Message-Id: <20191113091336.5218-5-k.konieczny@samsung.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191113091336.5218-1-k.konieczny@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7djP87qBJ0/HGrzYLmmxccZ6VovrX56z
        WvTt+89oseDTDFaL8+c3sFucbXrDbnF51xw2i8+9Rxgt1h65y25xu3EFmwOXx6ZVnWweB9/t
        YfLo27KK0ePzJrkAligum5TUnMyy1CJ9uwSujBO9NQUvpCq2/z3N1sB4XKyLkZNDQsBE4tLa
        y0xdjFwcQgIrGCX2rV3KCJIQEvjCKLF2czBE4jOjxOT709hhOnZv2soKkVjOKNFxqw/KAeo4
        fG4eWBWbgL7EwbMnWUBsEQFpic5FE8F2MAv8ZpLY+mcv2A5hAVeJtpPbwWwWAVWJKQfbwJp5
        Bawl5nxtZOti5ABaJy8x560GSJhTwEZi6c81UCWCEidnPgGbzwxU0rx1NjPEdYvYJc72hUDY
        LhJXV7xmhbCFJV4d3wL1gYzE/53zmSDscomnC/vYQW6TEGhhlHjQ/pEFImEtcfj4RVaQG5gF
        NCXW79KHCDtKdHw6yApxGp/EjbeCECfwSUzaNp0ZIswr0dEmBFGtKvH8VA/UJmmJrv/roK7x
        kPh9Yi7zBEbFWUiemYXkmVkIexcwMq9iFE8tLc5NTy02ykst1ytOzC0uzUvXS87P3cQITD2n
        /x3/soNx15+kQ4wCHIxKPLwH5p2KFWJNLCuuzD3EKMHBrCTCu6PiRKwQb0piZVVqUX58UWlO
        avEhRmkOFiVx3mqGB9FCAumJJanZqakFqUUwWSYOTqkGxhk7Gnt0NnxfMXvvZAP9tRUc4kuf
        y6v9CizhKxAwut3RnCQesaQ5kt+yxyLxSuYD0zx9p4gvOYxC36fFuPvFnJ74zUhb8+fjBYUT
        PCbtyqh/Hn/43ce/6+0ORu44z8D4U8t6WlVXQXjs7JDabs6F188yrZZV3Luef070pz3N/xeH
        LDvJesMmTYmlOCPRUIu5qDgRAFDyUYE5AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsVy+t/xu7oBJ0/HGpy7bmyxccZ6VovrX56z
        WvTt+89oseDTDFaL8+c3sFucbXrDbnF51xw2i8+9Rxgt1h65y25xu3EFmwOXx6ZVnWweB9/t
        YfLo27KK0ePzJrkAlig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TU
        nMyy1CJ9uwS9jBO9NQUvpCq2/z3N1sB4XKyLkZNDQsBEYvemraxdjFwcQgJLGSUW/t7PCpGQ
        lmg8vZoJwhaW+HOtiw2i6BOjxJfbp8GK2AT0JQ6ePckCYosANXQumsgEUsQs0MgscfFAE1i3
        sICrRNvJ7YwgNouAqsSUg23sIDavgLXEnK+NQFM5gDbIS8x5qwES5hSwkVj6cw1YiRBQyZMN
        b9kgygUlTs58AraLGai8eets5gmMArOQpGYhSS1gZFrFKJJaWpybnltsqFecmFtcmpeul5yf
        u4kRGCfbjv3cvIPx0sbgQ4wCHIxKPLwH5p2KFWJNLCuuzD3EKMHBrCTCu6PiRKwQb0piZVVq
        UX58UWlOavEhRlOgHyYyS4km5wNjOK8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6Yklqdmpq
        QWoRTB8TB6dUA6PFzwQBMS1fu/3VFvPrdqjer79+L2/yHrPw9wfXPTK7k6btpZQ/vdZOZeuJ
        jG8RHWunHfO//cQ4e1m+wt8765TTS5R23vkZEzZRkFNt5nO5J7H8+42comxlzh5UrjmtXqF4
        9STHR6Gj71m3SPXyc5XZnU4R7rx84Dbv4usO686fufDAb6vm4olKLMUZiYZazEXFiQDU0qsR
        qQIAAA==
X-CMS-MailID: 20191113091352eucas1p1825d815661c1a8377449f511c65ea230
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191113091352eucas1p1825d815661c1a8377449f511c65ea230
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191113091352eucas1p1825d815661c1a8377449f511c65ea230
References: <20191113091336.5218-1-k.konieczny@samsung.com>
        <CGME20191113091352eucas1p1825d815661c1a8377449f511c65ea230@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Change var name used in time statistics from last_stat_updated to
last_time. This will make it shorter and similar to cpufreq_stats.

Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
---
 drivers/devfreq/devfreq.c | 12 ++++++------
 include/linux/devfreq.h   |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 0a88055d1362..6e5a17f4c92c 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -165,7 +165,7 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
 	/* Immediately exit if previous_freq is not initialized yet. */
 	if (!devfreq->previous_freq) {
 		spin_lock(&devfreq->stats_lock);
-		devfreq->last_stat_updated = cur_time;
+		devfreq->last_time = cur_time;
 		spin_unlock(&devfreq->stats_lock);
 		return 0;
 	}
@@ -179,7 +179,7 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
 	}
 
 	devfreq->time_in_state[prev_lev] +=
-			 cur_time - devfreq->last_stat_updated;
+			 cur_time - devfreq->last_time;
 	lev = devfreq_get_freq_level(devfreq, freq);
 	if (lev < 0) {
 		ret = lev;
@@ -193,7 +193,7 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
 	}
 
 out:
-	devfreq->last_stat_updated = cur_time;
+	devfreq->last_time = cur_time;
 	spin_unlock(&devfreq->stats_lock);
 	return ret;
 }
@@ -485,7 +485,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
 			msecs_to_jiffies(devfreq->profile->polling_ms));
 
 	spin_lock(&devfreq->stats_lock);
-	devfreq->last_stat_updated = get_jiffies_64();
+	devfreq->last_time = get_jiffies_64();
 	spin_unlock(&devfreq->stats_lock);
 	devfreq->stop_polling = false;
 
@@ -714,7 +714,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_devfreq;
 	}
 
-	devfreq->last_stat_updated = get_jiffies_64();
+	devfreq->last_time = get_jiffies_64();
 	spin_lock_init(&devfreq->stats_lock);
 
 	srcu_init_notifier_head(&devfreq->transition_notifier_list);
@@ -1452,7 +1452,7 @@ static void defvreq_stats_clear_table(struct devfreq *devfreq)
 	spin_lock(&devfreq->stats_lock);
 	memset(devfreq->time_in_state, 0, count * sizeof(u64));
 	memset(devfreq->trans_table, 0, count * count * sizeof(int));
-	devfreq->last_stat_updated = get_jiffies_64();
+	devfreq->last_time = get_jiffies_64();
 	devfreq->total_trans = 0;
 	spin_unlock(&devfreq->stats_lock);
 }
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index a344e0be99f3..2ddf25993f7d 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -134,7 +134,7 @@ struct devfreq_dev_profile {
  * @total_trans:	Number of devfreq transitions
  * @trans_table:	Statistics of devfreq transitions
  * @time_in_state:	Statistics of devfreq states
- * @last_stat_updated:	The last time stat updated
+ * @last_time:		The last time stats were updated
  * @stats_lock:		Lock protecting trans_table, time_in_state, last_time
  *			and total_trans used for statistics
  * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER notifier
@@ -177,7 +177,7 @@ struct devfreq {
 	unsigned int total_trans;
 	unsigned int *trans_table;
 	u64 *time_in_state;
-	unsigned long long last_stat_updated;
+	unsigned long long last_time;
 	spinlock_t stats_lock;
 
 	struct srcu_notifier_head transition_notifier_list;
-- 
2.24.0

