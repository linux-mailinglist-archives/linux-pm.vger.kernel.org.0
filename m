Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACE5FACA5
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 10:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfKMJNx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 04:13:53 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34895 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfKMJNx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 04:13:53 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191113091352euoutp0165fe7a33e2296be657659647fe69be4c~Wrf9Z225x1861418614euoutp01h
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2019 09:13:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191113091352euoutp0165fe7a33e2296be657659647fe69be4c~Wrf9Z225x1861418614euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573636432;
        bh=psmbkYgjxBJEqnX794aWZ+U0IHZUM+JDqPP7km6ZABk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s8lVm24kE5ETmMHYf3NtCQcgrNJstmgmLLytg09CrMfTyfQDkUh7uSxZta03LDESJ
         vPD88peo+XU3UvSO6ZtXujcmElDVsxZOnlKDPXGl4Ps1E5o1Zhy3frthXw8SX/aT5I
         kKpzJpUV/IbXAaXBq3q6JbQeBEGqHYcBcvDd8zmo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191113091351eucas1p2d7af01ab946580e5f8000d6757e82833~Wrf9HXl8V1779617796eucas1p2s;
        Wed, 13 Nov 2019 09:13:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 7D.24.04309.F49CBCD5; Wed, 13
        Nov 2019 09:13:51 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191113091351eucas1p24afdb94f868b6a7a52b43e81462bb674~Wrf81ft_p2899928999eucas1p2G;
        Wed, 13 Nov 2019 09:13:51 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191113091351eusmtrp1021c6dcdbffd05353b2adb24f08b9622~Wrf807xvn0965609656eusmtrp1j;
        Wed, 13 Nov 2019 09:13:51 +0000 (GMT)
X-AuditID: cbfec7f4-afbff700000010d5-03-5dcbc94f530c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E7.DA.04117.F49CBCD5; Wed, 13
        Nov 2019 09:13:51 +0000 (GMT)
Received: from AMDC3218.digital.local (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191113091350eusmtip1b579afc177f22b4f615f4525f15851b9~Wrf8Wo5P30379503795eusmtip1P;
        Wed, 13 Nov 2019 09:13:50 +0000 (GMT)
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
Subject: [PATCH 1/7] devfreq: change time stats to 64-bit
Date:   Wed, 13 Nov 2019 10:13:30 +0100
Message-Id: <20191113091336.5218-2-k.konieczny@samsung.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191113091336.5218-1-k.konieczny@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsWy7djPc7r+J0/HGhxeoG2xccZ6VovrX56z
        WvTt+89oseDTDFaL8+c3sFucbXrDbnF51xw2i8+9Rxgt1h65y25xu3EFmwOXx6ZVnWweB9/t
        YfLo27KK0ePzJrkAligum5TUnMyy1CJ9uwSujGtnT7MVnBSr+HqnlbmB8blQFyMnh4SAicSX
        9RvZuxi5OIQEVjBK3Pz2iBHC+cIoMf37YxYI5zOjxO8lnYwwLcsXdDOB2EICyxklnpwqgOt4
        svE9G0iCTUBf4uDZkywgtoiAtETnoolMIEXMAr+ZJLb+2Qs2SVjAUuLZ/ndgk1gEVCWW/ZnA
        DmLzClhLLJ53jLmLkQNom7zEnLcaIGFOARuJpT/XQJUISpyc+QRsPjNQSfPW2cwg8yUEFrFL
        7F10hBniUheJ+2/72SFsYYlXx7dA2TISpyf3sEDY5RJPF/axQzS3MEo8aP8IlbCWOHz8IivI
        EcwCmhLrd+lDhB0lvnStY4O4jU/ixltBiBv4JCZtmw51Mq9ERxs0eFUlnp/qYYKwpSW6/q9j
        hbA9JDp2fWSbwKg4C8k3s5B8Mwth7wJG5lWM4qmlxbnpqcVGeanlesWJucWleel6yfm5mxiB
        6ef0v+NfdjDu+pN0iFGAg1GJh/fAvFOxQqyJZcWVuYcYJTiYlUR4d1SciBXiTUmsrEotyo8v
        Ks1JLT7EKM3BoiTOW83wIFpIID2xJDU7NbUgtQgmy8TBKdXA6Cx9yrJY/uHGF0rlz6emH/78
        wCbjR5fDTL+uz9w3eE4o8XQa2+2dHz5F2PKV70JfjqBk1/u+M+5NDnk2hUX+d+1to9CTKw/M
        /nvyZYmG61lW9sLs42fiuoVevxfv+Oz7U3ndCQNzh4L9DwrDN51/u7296SXTFc89t9d8CSz6
        dpXlVSrXDOVH95VYijMSDbWYi4oTAfLKs6U7AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsVy+t/xu7r+J0/HGvz9K26xccZ6VovrX56z
        WvTt+89oseDTDFaL8+c3sFucbXrDbnF51xw2i8+9Rxgt1h65y25xu3EFmwOXx6ZVnWweB9/t
        YfLo27KK0ePzJrkAlig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TU
        nMyy1CJ9uwS9jGtnT7MVnBSr+HqnlbmB8blQFyMnh4SAicTyBd1MXYxcHEICSxklVj5+zwaR
        kJZoPL2aCcIWlvhzrYsNougTo8T2zp3sIAk2AX2Jg2dPsoDYIkANnYsmgk1iFmhklrh4oAms
        W1jAUuLZ/ndgNouAqsSyPxPAmnkFrCUWzzvG3MXIAbRBXmLOWw2QMKeAjcTSn2vASoSASp5s
        eMsGUS4ocXLmE7BdzEDlzVtnM09gFJiFJDULSWoBI9MqRpHU0uLc9NxiI73ixNzi0rx0veT8
        3E2MwEjZduznlh2MXe+CDzEKcDAq8fAemHcqVog1say4MvcQowQHs5II746KE7FCvCmJlVWp
        RfnxRaU5qcWHGE2BfpjILCWanA+M4rySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2amp
        BalFMH1MHJxSDYz2zwPWH50n9a1s3UGezdn5v/WOqO/NqPwfY7Mi3Y6n+QF//ILYd+sDf9Wb
        uKX/1Q2Kkq+V5NE+09jwSVHI5Kiufeb6WXn/eWe5XTpSf69U37Wu/8euxSmX8jJ6Pj02e3/S
        6lKzdRJvqOvF84WGL/ZaPHGVXbgstjYmZG3R1r5Xt5w7XO7lNSuxFGckGmoxFxUnAgAg3k/s
        qgIAAA==
X-CMS-MailID: 20191113091351eucas1p24afdb94f868b6a7a52b43e81462bb674
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191113091351eucas1p24afdb94f868b6a7a52b43e81462bb674
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191113091351eucas1p24afdb94f868b6a7a52b43e81462bb674
References: <20191113091336.5218-1-k.konieczny@samsung.com>
        <CGME20191113091351eucas1p24afdb94f868b6a7a52b43e81462bb674@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Change time stats counting to bigger type by using 64-bit jiffies.
This will make devfreq stats code look similar to cpufreq stats and
prevents overflow (for HZ = 1000 after 49.7 days).

Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
---
 drivers/devfreq/devfreq.c | 14 +++++++-------
 include/linux/devfreq.h   |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index ab22bf8a12d6..1602cca20fc4 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -158,9 +158,9 @@ static int set_freq_table(struct devfreq *devfreq)
 int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
 {
 	int lev, prev_lev, ret = 0;
-	unsigned long cur_time;
+	unsigned long long cur_time;
 
-	cur_time = jiffies;
+	cur_time = get_jiffies_64();
 
 	/* Immediately exit if previous_freq is not initialized yet. */
 	if (!devfreq->previous_freq)
@@ -478,7 +478,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
 		queue_delayed_work(devfreq_wq, &devfreq->work,
 			msecs_to_jiffies(devfreq->profile->polling_ms));
 
-	devfreq->last_stat_updated = jiffies;
+	devfreq->last_stat_updated = get_jiffies_64();
 	devfreq->stop_polling = false;
 
 	if (devfreq->profile->get_cur_freq &&
@@ -698,7 +698,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 
 	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
 			devfreq->profile->max_state,
-			sizeof(unsigned long),
+			sizeof(*devfreq->time_in_state),
 			GFP_KERNEL);
 	if (!devfreq->time_in_state) {
 		mutex_unlock(&devfreq->lock);
@@ -706,7 +706,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_devfreq;
 	}
 
-	devfreq->last_stat_updated = jiffies;
+	devfreq->last_stat_updated = get_jiffies_64();
 
 	srcu_init_notifier_head(&devfreq->transition_notifier_list);
 
@@ -1423,8 +1423,8 @@ static ssize_t trans_stat_show(struct device *dev,
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

