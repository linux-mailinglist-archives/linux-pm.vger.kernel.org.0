Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C41E112DF3
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2019 16:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfLDPAg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 10:00:36 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39377 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbfLDPAf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2019 10:00:35 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191204150034euoutp02ea052cbc6e5ccce76fdd66073cabc1c9~dMxqdARly1386313863euoutp02A
        for <linux-pm@vger.kernel.org>; Wed,  4 Dec 2019 15:00:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191204150034euoutp02ea052cbc6e5ccce76fdd66073cabc1c9~dMxqdARly1386313863euoutp02A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575471634;
        bh=Ilvsx83Eaa30z89vnb/RD9pmuq7xN4DTWNNaEyITwuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kq++Ur1JxM6diG7q6QRYnv9NW3n2jSZMNG5f36kLg4iq8QeCGFdxdercDan6lnrHk
         3MHa6jgEuD8CLw8KOc1Yxm8xrd5yhzyD6M5u/ypm4Pt0aBm5rySE3pbOvswnO7UJmo
         5rekXXDMGWEJZsgUEAPvA3dUWVG3t5AhH+s1YrSw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191204150033eucas1p1ef9006681cd8d1f850b22d91d10dfce9~dMxqNwu2c0396203962eucas1p1v;
        Wed,  4 Dec 2019 15:00:33 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 65.68.60698.11AC7ED5; Wed,  4
        Dec 2019 15:00:33 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191204150033eucas1p1bf11d36a89c89e3eb55c37a1a204e988~dMxp4tnPR0430304303eucas1p1g;
        Wed,  4 Dec 2019 15:00:33 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191204150033eusmtrp23a6c6e41d57ffb7c5d0aeeb54b4c13e2~dMxp4B2VZ2624126241eusmtrp2t;
        Wed,  4 Dec 2019 15:00:33 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-c1-5de7ca11632e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 74.CF.07950.11AC7ED5; Wed,  4
        Dec 2019 15:00:33 +0000 (GMT)
Received: from AMDC3218.digital.local (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191204150032eusmtip127c8ce5c028f746c0cfb923aaafd8d00~dMxpYEc1g1769317693eusmtip1h;
        Wed,  4 Dec 2019 15:00:32 +0000 (GMT)
From:   Kamil Konieczny <k.konieczny@samsung.com>
To:     k.konieczny@samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH v2 1/3] devfreq: change time stats to 64-bit
Date:   Wed,  4 Dec 2019 16:00:16 +0100
Message-Id: <20191204150018.5234-2-k.konieczny@samsung.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204150018.5234-1-k.konieczny@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsWy7djPc7qCp57HGtz8p2exccZ6VovrX56z
        Wiz4NIPV4vz5DewWZ5vesFtc3jWHzeJz7xFGi7VH7rJb3G5cwebA6bFpVSebR9+WVYwenzfJ
        BTBHcdmkpOZklqUW6dslcGXMu/uLtWCHeEXn+tmsDYyHhbsYOTkkBEwk/rbfYOxi5OIQEljB
        KLFu83I2COcLo0TD66XMEM5nRomtj0DKIFoWXnsPVbWcUeL0x5UILfsWrGcBqWIT0Jc4ePYk
        mC0iIC3RuWgiE0gRs8AxJoldh/6ygiSEBWwkVnR+YAexWQRUJS5uaAWL8wpYSyxceQVoKgfQ
        OnmJOW81QMKcQOUfX39ihCgRlDg58wnYfGagkuats8FOlRDoZpd4ehLkCZBTXST6Hu2DOltY
        4tXxLewQtozE/53zmSDscomnC/vYIZpbGCUetH9kgUhYSxw+fpEV5AhmAU2J9bv0IcKOEiuv
        /4e6jU/ixltBiBv4JCZtm84MEeaV6GgTgqhWlXh+qgdqk7RE1/91rBAlHhLzpstNYFScheSZ
        WUiemYWwdgEj8ypG8dTS4tz01GLjvNRyveLE3OLSvHS95PzcTYzAVHP63/GvOxj3/Uk6xCjA
        wajEw9uw6XmsEGtiWXFl7iFGCQ5mJRHebRJPY4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzVjM8
        iBYSSE8sSc1OTS1ILYLJMnFwSjUw+mxfazrLy//2F3c7rb06pW/8XXIXS7Hb/hMI4tfK4eYy
        MjG5IL7OIn/Z/ZPtDTr9FXKnuzVvPjnz+Nr626rb8n7UeNY2tdzt0F5U3XEkt2NZfsGOkpef
        E4/a8HgVLjqUrN/p8PVdbeMiLsk7Z1vCz14O/iv0g9vSz1m4LFAhX1CM7wnPFyclluKMREMt
        5qLiRACohwUpMQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42I5/e/4XV3BU89jDZq2iltsnLGe1eL6l+es
        Fgs+zWC1OH9+A7vF2aY37BaXd81hs/jce4TRYu2Ru+wWtxtXsDlwemxa1cnm0bdlFaPH501y
        AcxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehnz
        7v5iLdghXtG5fjZrA+Nh4S5GTg4JAROJhdfes3UxcnEICSxllNg/8SgzREJaovH0aiYIW1ji
        z7UuqKJPjBKfjmxmB0mwCehLHDx7kgXEFgFq6Fw0EayBWeAMk8SvlgoQW1jARmJF5wewehYB
        VYmLG1pZQWxeAWuJhSuvAA3lAFogLzHnrQZImBOo/OPrT4wgthBQSc/Td2wQ5YISJ2c+YYEY
        Ly/RvHU28wRGgVlIUrOQpBYwMq1iFEktLc5Nzy020itOzC0uzUvXS87P3cQIjIltx35u2cHY
        9S74EKMAB6MSD2/DpuexQqyJZcWVuYcYJTiYlUR4t0k8jRXiTUmsrEotyo8vKs1JLT7EaAr0
        w0RmKdHkfGC85pXEG5oamltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi4JRqYFx6
        s1pURIopzNtR4j37/Z3rFR8/c9RcJ5lVvjTE7E/H5Ma3mrVLTnw50fhpxslZL3mtcn8Llkrc
        109atURmDlM/P9eaVyxFewzP9SoZT3m0y/Lx8iCx8ny+Coc9FY/92zqMVXsn+Z++ebIt8E2l
        zFSpdL6111ZN5L0Su67CyllRJIJxD8tcGyWW4oxEQy3mouJEALveXZafAgAA
X-CMS-MailID: 20191204150033eucas1p1bf11d36a89c89e3eb55c37a1a204e988
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191204150033eucas1p1bf11d36a89c89e3eb55c37a1a204e988
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191204150033eucas1p1bf11d36a89c89e3eb55c37a1a204e988
References: <20191204150018.5234-1-k.konieczny@samsung.com>
        <CGME20191204150033eucas1p1bf11d36a89c89e3eb55c37a1a204e988@eucas1p1.samsung.com>
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
Changes in v2:
 added Acked-by, rebased on linux-next

 drivers/devfreq/devfreq.c | 14 +++++++-------
 include/linux/devfreq.h   |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index bdeb4189c978..0e2030403e4a 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -199,10 +199,10 @@ static int set_freq_table(struct devfreq *devfreq)
 int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
 {
 	int lev, prev_lev, ret = 0;
-	unsigned long cur_time;
+	unsigned long long cur_time;
 
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
index 2bae9ed3c783..b81a86e47fb9 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -174,8 +174,8 @@ struct devfreq {
 	/* information for device frequency transition */
 	unsigned int total_trans;
 	unsigned int *trans_table;
-	unsigned long *time_in_state;
-	unsigned long last_stat_updated;
+	u64 *time_in_state;
+	unsigned long long last_stat_updated;
 
 	struct srcu_notifier_head transition_notifier_list;
 };
-- 
2.24.0

