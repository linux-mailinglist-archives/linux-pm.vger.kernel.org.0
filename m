Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D541FACB0
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 10:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfKMJN4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 04:13:56 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:32954 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfKMJNz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 04:13:55 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191113091353euoutp02dfd4dcaa0102286dff535a8a259dda0d~Wrf_pCvNP2236522365euoutp02c
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2019 09:13:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191113091353euoutp02dfd4dcaa0102286dff535a8a259dda0d~Wrf_pCvNP2236522365euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573636433;
        bh=fefHGcRJB0KQtAWan8ZucPbHfX9vKVV2/4VW/b5EgdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GCTgbkJt5q2bR+vQV364IYwficXX9J8hzYbfy0zOs8pxTF4FCp3HxUWcH4rU1fGj9
         2G6i+Ofz26+2WsLp4LeDtLpv1tTePueFoyhxFadaJbEJw6VlcPS08vFw30rJ9k13ej
         A54B7cm7enYGEYIMknT4qoQfQmXPysZPfGa0Taj0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191113091353eucas1p13fd91e9cb9bc336500ea3de2c9e902f4~Wrf_UOtav1712317123eucas1p1K;
        Wed, 13 Nov 2019 09:13:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id DF.94.04374.059CBCD5; Wed, 13
        Nov 2019 09:13:52 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191113091352eucas1p2c30c8a73a8362aff872e3cd9312eb24b~Wrf9xIPCq2485524855eucas1p2M;
        Wed, 13 Nov 2019 09:13:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191113091352eusmtrp1e8e7326047355e67920c10610e8019e6~Wrf9wm46t1033410334eusmtrp1D;
        Wed, 13 Nov 2019 09:13:52 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-92-5dcbc9508192
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A9.DA.04117.059CBCD5; Wed, 13
        Nov 2019 09:13:52 +0000 (GMT)
Received: from AMDC3218.digital.local (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191113091351eusmtip1d248033f0d70c89c053cfce6364032ef~Wrf9RRtLb0136201362eusmtip1X;
        Wed, 13 Nov 2019 09:13:51 +0000 (GMT)
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
Subject: [PATCH 3/7] devfreq: add clearing transitions stats in sysfs
Date:   Wed, 13 Nov 2019 10:13:32 +0100
Message-Id: <20191113091336.5218-4-k.konieczny@samsung.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191113091336.5218-1-k.konieczny@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsWy7djP87oBJ0/HGky5aWGxccZ6VovrX56z
        WvTt+89oseDTDFaL8+c3sFucbXrDbnF51xw2i8+9Rxgt1h65y25xu3EFmwOXx6ZVnWweB9/t
        YfLo27KK0ePzJrkAligum5TUnMyy1CJ9uwSujBsrtApu8VQ0rv/J1MD4iKuLkZNDQsBEYt/F
        aYxdjFwcQgIrGCUanr6Ecr4wSnx7OYcVwvnMKPH1zz42mJYnc16xQySWM0qcW/yXHaGlpRms
        ik1AX+Lg2ZMsILaIgLRE56KJTCBFzAK/mSS2/tnLCJIQFnCVuP2uixXEZhFQlXj49ANYnFfA
        WuL9uYdAzRxA6+Ql5rzVAAlzCthILP25hh2iRFDi5MwnYPOZgUqat85mBpkvIbCIXWLblqvs
        EKe6SHy/sogZwhaWeHV8C1RcRuL05B4WCLtc4unCPnaI5hZGiQftH6ES1hKHj19kBTmCWUBT
        Yv0ufYiwo8SVD9NZIW7jk7jxVhDiBj6JSdumM0OEeSU62oQgqlUlnp/qYYKwpSW6/q+D6vSQ
        OPA6bAKj4iwkz8xC8swshLULGJlXMYqnlhbnpqcWG+ellusVJ+YWl+al6yXn525iBCaf0/+O
        f93BuO9P0iFGAQ5GJR5eiYWnYoVYE8uKK3MPMUpwMCuJ8O6oOBErxJuSWFmVWpQfX1Sak1p8
        iFGag0VJnLea4UG0kEB6YklqdmpqQWoRTJaJg1OqgdGhYLWD7bcvx3quCxrHHGHcd1Xzc/2a
        xKSzXgvlWPlWn4u/+aieMVBy7feOyq3aIYJftkyVYG0IvPdfxV6w/FPXqiNtVyf4vmFSuuiz
        NOaRdkyt9r6I7SY2Zw69mWH97pSTwaSajpQpAZtjjt9Ta92zecdV5Y28E/6uPXnoVuLxQB7v
        wLDMKAclluKMREMt5qLiRABFOkILOgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsVy+t/xu7oBJ0/HGsyZI2axccZ6VovrX56z
        WvTt+89oseDTDFaL8+c3sFucbXrDbnF51xw2i8+9Rxgt1h65y25xu3EFmwOXx6ZVnWweB9/t
        YfLo27KK0ePzJrkAlig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TU
        nMyy1CJ9uwS9jBsrtApu8VQ0rv/J1MD4iKuLkZNDQsBE4smcV+xdjFwcQgJLGSWWzHvHBJGQ
        lmg8vRrKFpb4c62LDcQWEvjEKHFsTzWIzSagL3Hw7EkWEFsEqL5z0UQmkEHMAo3MEhcPNIE1
        Cwu4Stx+18UKYrMIqEo8fPqBEcTmFbCWeH/uIVAzB9ACeYk5bzVAwpwCNhJLf65hh9hlLfFk
        w1s2iHJBiZMzn4DtYgYqb946m3kCo8AsJKlZSFILGJlWMYqklhbnpucWG+kVJ+YWl+al6yXn
        525iBEbJtmM/t+xg7HoXfIhRgINRiYf3wLxTsUKsiWXFlbmHGCU4mJVEeHdUnIgV4k1JrKxK
        LcqPLyrNSS0+xGgK9MNEZinR5HxgBOeVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5N
        LUgtgulj4uCUamCMKvlRODFUSXut1ZcFN3p3/Zr1WIrdYe5fL6v5B3fOF7yWlyn72q7Qb25c
        l9nX+BnVbyfddz+70l32buFF88QHE7le+vmUhPJ9qPMs9DtvxuvsNTO9ufL8x6/ree60mJue
        +PPA39L9Y3Ck+MoWsaQLYkInAxZarek9rHJ3b6DU2aXKB6fP27JMiaU4I9FQi7moOBEAVkvO
        w6gCAAA=
X-CMS-MailID: 20191113091352eucas1p2c30c8a73a8362aff872e3cd9312eb24b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191113091352eucas1p2c30c8a73a8362aff872e3cd9312eb24b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191113091352eucas1p2c30c8a73a8362aff872e3cd9312eb24b
References: <20191113091336.5218-1-k.konieczny@samsung.com>
        <CGME20191113091352eucas1p2c30c8a73a8362aff872e3cd9312eb24b@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add new function trans_reset in sysfs for clearing transition
table and time in states devfreq statistics.

Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
---
 drivers/devfreq/devfreq.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index ac04b5baef70..0a88055d1362 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1445,6 +1445,31 @@ static ssize_t trans_stat_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(trans_stat);
 
+static void defvreq_stats_clear_table(struct devfreq *devfreq)
+{
+	unsigned int count = devfreq->profile->max_state;
+
+	spin_lock(&devfreq->stats_lock);
+	memset(devfreq->time_in_state, 0, count * sizeof(u64));
+	memset(devfreq->trans_table, 0, count * count * sizeof(int));
+	devfreq->last_stat_updated = get_jiffies_64();
+	devfreq->total_trans = 0;
+	spin_unlock(&devfreq->stats_lock);
+}
+
+static ssize_t trans_reset_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf,
+				 size_t count)
+{
+	struct devfreq *devfreq = to_devfreq(dev);
+
+	defvreq_stats_clear_table(devfreq);
+
+	return count;
+}
+static DEVICE_ATTR_WO(trans_reset);
+
 static struct attribute *devfreq_attrs[] = {
 	&dev_attr_governor.attr,
 	&dev_attr_available_governors.attr,
@@ -1455,6 +1480,7 @@ static struct attribute *devfreq_attrs[] = {
 	&dev_attr_min_freq.attr,
 	&dev_attr_max_freq.attr,
 	&dev_attr_trans_stat.attr,
+	&dev_attr_trans_reset.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(devfreq);
-- 
2.24.0

