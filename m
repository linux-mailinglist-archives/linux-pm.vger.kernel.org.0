Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6B4112DEE
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2019 16:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfLDPAg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 10:00:36 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46491 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbfLDPAf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2019 10:00:35 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191204150034euoutp01cde0b4373cef416effc11ebfabed41bc~dMxq_2seg2300123001euoutp01h
        for <linux-pm@vger.kernel.org>; Wed,  4 Dec 2019 15:00:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191204150034euoutp01cde0b4373cef416effc11ebfabed41bc~dMxq_2seg2300123001euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575471634;
        bh=nPQrCD/mKTuifW3dUfM3C+O8poSqC0PNAFTDcneBuHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EoDmdYMTfHR+Bem9OsIcWDI2Uv96pCD81dQ4NxYnPXKiEfYt0kjqABc9kIiUC4Leq
         0nLJEFN+RHkEnKYWRYrmIz2IA1IGkejuNjk64OPocukEguMKOUc3cF0ifJEa4gdBdY
         Zv73rfqgZDv6IhD9oACC1wAnFNnxmJfjQaG2/yAY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191204150034eucas1p14854d151620d20f3c57659b6d427661e~dMxqwTsWd0610306103eucas1p1e;
        Wed,  4 Dec 2019 15:00:34 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id BB.2F.60679.21AC7ED5; Wed,  4
        Dec 2019 15:00:34 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191204150033eucas1p164374e7f15cb9a74b7432ca1a822dc10~dMxqXDJ8D0395203952eucas1p1q;
        Wed,  4 Dec 2019 15:00:33 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191204150033eusmtrp22d45b9edb8d4f271480512d837b65cb4~dMxqWddY12624226242eusmtrp2r;
        Wed,  4 Dec 2019 15:00:33 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-76-5de7ca12a074
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 35.CF.07950.11AC7ED5; Wed,  4
        Dec 2019 15:00:33 +0000 (GMT)
Received: from AMDC3218.digital.local (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191204150033eusmtip160505c92ed8939768d69a85ef53bf05b~dMxp38OvZ1802618026eusmtip16;
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
Subject: [PATCH v2 2/3] devfreq: add clearing transitions stats
Date:   Wed,  4 Dec 2019 16:00:17 +0100
Message-Id: <20191204150018.5234-3-k.konieczny@samsung.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204150018.5234-1-k.konieczny@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djP87pCp57HGlw7KGqxccZ6VovrX56z
        Wiz4NIPV4vz5DewWZ5vesFtc3jWHzeJz7xFGi7VH7rJb3G5cwebA6bFpVSebR9+WVYwenzfJ
        BTBHcdmkpOZklqUW6dslcGUs2CZd0MxdsWnGKrYGxomcXYycHBICJhKzFy9m6mLk4hASWMEo
        8aLzB5TzhVFi/qqPrBDOZ0aJv1t2ssG0nOw+xAKRWM4oMffML1a4lh3z/7OAVLEJ6EscPHsS
        zBYRkJboXDQRbC6zwDEmiV2H/rKCJIQF7CU2dUDYLAKqEs/7DzJ3MXJw8ApYS2zs5wExJQTk
        Jea81QCp4BSwkfj4+hMjiM0rIChxcuYTsPHMQCXNW2czg4yXEOhnl9h6pY8V4lIXiVlNS9kh
        bGGJV8e3QNkyEv93zmeCsMslni7sY4dobmGUeND+kQUiYS1x+PhFVpAjmAU0Jdbv0ocIO0os
        +7CHCeI2PokbbwUhbuCTmLRtOjNEmFeio00IohroqVM9UJukJbr+r4O6zENi+5tm5gmMirOQ
        fDMLyTezEPYuYGRexSieWlqcm55abJSXWq5XnJhbXJqXrpecn7uJEZhoTv87/mUH464/SYcY
        BTgYlXh4GzY9jxViTSwrrsw9xCjBwawkwrtN4mmsEG9KYmVValF+fFFpTmrxIUZpDhYlcd5q
        hgfRQgLpiSWp2ampBalFMFkmDk6pBsbep0WZE5+UJWmlZ4clFbcpz/mnseYOe5uLeq0lH9fD
        Exm1n11v/KlnyjFbbCT47eSFm4vuCy3fntex++2+zDYNiQO/eHiex9nsnJvhHpkicmnLrZWa
        toIRC8prHieGpBrM1p/RPfXp9Qdec9ZalCRceXPs/az/KSvnFD/bO13lR/TUTG9Jd10lluKM
        REMt5qLiRACmoiQpMAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42I5/e/4XV3BU89jDTa9MLfYOGM9q8X1L89Z
        LRZ8msFqcf78BnaLs01v2C0u75rDZvG59wijxdojd9ktbjeuYHPg9Ni0qpPNo2/LKkaPz5vk
        Apij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DIW
        bJMuaOau2DRjFVsD40TOLkZODgkBE4mT3YdYQGwhgaWMErO/akDEpSUaT69mgrCFJf5c62Lr
        YuQCqvnEKHGo+zAzSIJNQF/i4NmTYM0iQA2diyaCNTALnGGS+NVSAWILC9hLbOr4ywpiswio
        SjzvPwjUy8HBK2AtsbGfB8SUEJCXmPMWbC2ngI3Ex9efGCHOsZboefqODcTmFRCUODnzCQvE
        dHmJ5q2zmScwCsxCkpqFJLWAkWkVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYDRsO/Zzyw7G
        rnfBhxgFOBiVeHgbNj2PFWJNLCuuzD3EKMHBrCTCu03iaawQb0piZVVqUX58UWlOavEhRlOg
        FyYyS4km5wMjNa8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA2Nu
        XYRrZ4KpRR5rk6bOEqt0/r3C+Z+PvH5xV+NuaN3OTyc+tu/fany9Jjek1dX744YcM2mz78dN
        na6tZt+QdFPwYuiUb+InVI/NWq/ne+PS7rmz5x/8INr7x/S49xxP5clO5ror2NdVZOnqGPXW
        hXvt/aMQzegs6fi8aV3Kx+2vu5i2pv3TmanEUpyRaKjFXFScCAC9gbGHnAIAAA==
X-CMS-MailID: 20191204150033eucas1p164374e7f15cb9a74b7432ca1a822dc10
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191204150033eucas1p164374e7f15cb9a74b7432ca1a822dc10
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191204150033eucas1p164374e7f15cb9a74b7432ca1a822dc10
References: <20191204150018.5234-1-k.konieczny@samsung.com>
        <CGME20191204150033eucas1p164374e7f15cb9a74b7432ca1a822dc10@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add clearing transition table and time in states devfreq statistics
by writing to trans_stat file in devfreq sysfs.

Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
---
Changes in v2:
 instead of creating new sysfs file, add new functionality to trans_stat
 and clear stats when anything is writen to it

 drivers/devfreq/devfreq.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 0e2030403e4a..901af3b66a76 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1478,7 +1478,27 @@ static ssize_t trans_stat_show(struct device *dev,
 					devfreq->total_trans);
 	return len;
 }
-static DEVICE_ATTR_RO(trans_stat);
+
+static ssize_t trans_stat_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct devfreq *df = to_devfreq(dev);
+	unsigned int cnt = df->profile->max_state;
+
+	if (cnt == 0)
+		return count;
+
+	mutex_lock(&df->lock);
+	memset(df->time_in_state, 0, cnt * sizeof(u64));
+	memset(df->trans_table, 0, cnt * cnt * sizeof(int));
+	df->last_stat_updated = get_jiffies_64();
+	df->total_trans = 0;
+	mutex_unlock(&df->lock);
+
+	return count;
+}
+static DEVICE_ATTR_RW(trans_stat);
 
 static struct attribute *devfreq_attrs[] = {
 	&dev_attr_name.attr,
-- 
2.24.0

