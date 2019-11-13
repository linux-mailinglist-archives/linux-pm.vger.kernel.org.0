Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94F26FACAA
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 10:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfKMJN4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 04:13:56 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34910 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbfKMJNz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 04:13:55 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191113091355euoutp01b5123259eb7b63a09e78cc606f2e6a2a~WrgATfG1g1907619076euoutp01K
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2019 09:13:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191113091355euoutp01b5123259eb7b63a09e78cc606f2e6a2a~WrgATfG1g1907619076euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573636435;
        bh=wPJLPIsHPtd18ziWhoH1wLWeb4q37D6cAXWrtAjIfCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FU88YKzsFUJsb004xDNiMrlnOVgNUcTiS6pjohpHdlYLjznjOg7s3PtmB16fu2Z6d
         BFxmC/+sAhliwQkUXazBiLt9YJMvYKqMcwZqA9QspFJOfLFqhtJdBNm8y38bLQGSMq
         bLd20bweejvTkqPveZ/tWMGavoGYYWg4x3/je1mY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191113091354eucas1p2ad1b28ccb6a72356006ababe017063d4~Wrf-k_upb0764807648eucas1p2l;
        Wed, 13 Nov 2019 09:13:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 58.82.04469.259CBCD5; Wed, 13
        Nov 2019 09:13:54 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191113091353eucas1p2d9f82697e6ec44c0e38225988227c73c~Wrf-Fn6EJ2485524855eucas1p2O;
        Wed, 13 Nov 2019 09:13:53 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191113091353eusmtrp28034d2cb04b30372ec8194b4870e6a65~Wrf-E_i1c1340513405eusmtrp2X;
        Wed, 13 Nov 2019 09:13:53 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-b3-5dcbc952ed22
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DD.1A.04166.159CBCD5; Wed, 13
        Nov 2019 09:13:53 +0000 (GMT)
Received: from AMDC3218.digital.local (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191113091353eusmtip1f821ee2964d300f19482fb418683e635~Wrf_oTuqG0379503795eusmtip1S;
        Wed, 13 Nov 2019 09:13:53 +0000 (GMT)
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
Subject: [PATCH 6/7] devfreq: move transition statistics allocations to
 set_freq_stats()
Date:   Wed, 13 Nov 2019 10:13:35 +0100
Message-Id: <20191113091336.5218-7-k.konieczny@samsung.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191113091336.5218-1-k.konieczny@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsWy7djP87pBJ0/HGkzawW+xccZ6VovrX56z
        WvTt+89oseDTDFaL8+c3sFucbXrDbnF51xw2i8+9Rxgt1h65y25xu3EFmwOXx6ZVnWweB9/t
        YfLo27KK0ePzJrkAligum5TUnMyy1CJ9uwSujHVvjrAUvBeq2LfmJlMD43L+LkZODgkBE4nt
        px8xdzFycQgJrGCUOPn/ABuE84VRYue6XewQzmdGiW2Tf7PCtJy494UNxBYSWM4o0fElB67j
        w+cpTCAJNgF9iYNnT7KA2CIC0hKdiyYygRQxC/xmktj6Zy8jSEJYIErid8tNsAYWAVWJv88/
        g03lFbCWuNp8C2gbB9A2eYk5bzVAwpwCNhJLf65hhygRlDg58wnYfGagkuats8F+kBBYxC7x
        Zf4mqF4XiZYplRBHC0u8Or6FHcKWkfi/cz4ThF0u8XRhHztEbwujxIP2jywQCWuJw8cvgs1h
        FtCUWL9LHyLsKPFk9VtmiPF8EjfeCkKcwCcxadt0qDCvREebEES1qsTzUz1Qm6Qluv6vgwah
        h0TDojOsExgVZyF5ZhaSZ2Yh7F3AyLyKUTy1tDg3PbXYMC+1XK84Mbe4NC9dLzk/dxMjMPmc
        /nf80w7Gr5eSDjEKcDAq8fBKLDwVK8SaWFZcmXuIUYKDWUmEd0fFiVgh3pTEyqrUovz4otKc
        1OJDjNIcLErivNUMD6KFBNITS1KzU1MLUotgskwcnFINjDt9BS9V/Z32rXbbY5erN1QKlpsf
        Y5DRfj+D4dwu2YheayVjZdMQoUscDN8dmtyOxt6QEmF+qeH9KsH61BUGboXcl3XXJp5UNdbl
        er7L4cQXtewdOZI3jGufqTC6as+PuRJ+7NXvo94hGm6ullte52ret5Kqurm6THDP61leJWt3
        fTLx/mqjqMRSnJFoqMVcVJwIAO8yXFM6AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsVy+t/xu7qBJ0/HGnx4bmixccZ6VovrX56z
        WvTt+89oseDTDFaL8+c3sFucbXrDbnF51xw2i8+9Rxgt1h65y25xu3EFmwOXx6ZVnWweB9/t
        YfLo27KK0ePzJrkAlig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TU
        nMyy1CJ9uwS9jHVvjrAUvBeq2LfmJlMD43L+LkZODgkBE4kT976wdTFycQgJLGWUuL34JQtE
        Qlqi8fRqJghbWOLPtS42EFtI4BOjRENjKojNJqAvcfDsSbB6EaD6zkUTmUAGMQs0MktcPNAE
        1iwsECGx9848sCIWAVWJv88/gw3iFbCWuNp8i7WLkQNogbzEnLcaIGFOARuJpT/XsEPsspZ4
        suEtVLmgxMmZT8DGMAOVN2+dzTyBUWAWktQsJKkFjEyrGEVSS4tz03OLDfWKE3OLS/PS9ZLz
        czcxAuNk27Gfm3cwXtoYfIhRgINRiYf3wLxTsUKsiWXFlbmHGCU4mJVEeHdUnIgV4k1JrKxK
        LcqPLyrNSS0+xGgK9MNEZinR5HxgDOeVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5N
        LUgtgulj4uCUamDsYXSZLPDi+TGH7KiYGuMrvf8UXz2fwv1Y6MSHgo/vSypfrNhTqzv1s9DD
        CT6X1U9MFfqQ9DeTeZr2zon5PPP+nOx+rfs460LugTD5/qUdPOZC/Gu5lk559aRqdWfI5ndL
        EzWen2X54mY2ce2kqr9tse4PWH8+8E5lCf4k+bA1rv215nPzz/WvlFiKMxINtZiLihMB8HcD
        QqkCAAA=
X-CMS-MailID: 20191113091353eucas1p2d9f82697e6ec44c0e38225988227c73c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191113091353eucas1p2d9f82697e6ec44c0e38225988227c73c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191113091353eucas1p2d9f82697e6ec44c0e38225988227c73c
References: <20191113091336.5218-1-k.konieczny@samsung.com>
        <CGME20191113091353eucas1p2d9f82697e6ec44c0e38225988227c73c@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All users of [devm_]devfreq_add_device() don't set freq_table
nor max_state, and there is only one "struct devfreq_profile" per
every "struct devfreq", so move transition memory allocations to
function set_freq_stats() and initialize there other statistics fields.

Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
---
 drivers/devfreq/devfreq.c | 44 +++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 70533b787744..d79412b0de59 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -147,7 +147,26 @@ static int set_freq_table(struct devfreq *devfreq)
 		profile->freq_table[i] = freq;
 	}
 
+	profile->trans_table = devm_kzalloc(devfreq->dev.parent,
+					    array3_size(sizeof(unsigned int),
+							count, count),
+					    GFP_KERNEL);
+	if (!profile->trans_table)
+		goto err_no_mem;
+
+	profile->time_in_state = devm_kcalloc(devfreq->dev.parent, count,
+					      sizeof(*profile->time_in_state),
+					      GFP_KERNEL);
+	if (!profile->time_in_state)
+		goto err_no_mem;
+
+	profile->last_time = get_jiffies_64();
+	spin_lock_init(&profile->stats_lock);
+
 	return 0;
+err_no_mem:
+	profile->max_state = 0;
+	return -ENOMEM;
 }
 
 /**
@@ -694,30 +713,6 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_out;
 	}
 
-	profile->trans_table = devm_kzalloc(&devfreq->dev,
-					    array3_size(sizeof(unsigned int),
-							profile->max_state,
-							profile->max_state),
-					    GFP_KERNEL);
-	if (!profile->trans_table) {
-		mutex_unlock(&devfreq->lock);
-		err = -ENOMEM;
-		goto err_devfreq;
-	}
-
-	profile->time_in_state = devm_kcalloc(&devfreq->dev,
-					      profile->max_state,
-					      sizeof(*profile->time_in_state),
-					      GFP_KERNEL);
-	if (!profile->time_in_state) {
-		mutex_unlock(&devfreq->lock);
-		err = -ENOMEM;
-		goto err_devfreq;
-	}
-
-	profile->last_time = get_jiffies_64();
-	spin_lock_init(&profile->stats_lock);
-
 	srcu_init_notifier_head(&devfreq->transition_notifier_list);
 
 	mutex_unlock(&devfreq->lock);
@@ -749,7 +744,6 @@ struct devfreq *devfreq_add_device(struct device *dev,
 
 err_init:
 	mutex_unlock(&devfreq_list_lock);
-err_devfreq:
 	devfreq_remove_device(devfreq);
 	devfreq = NULL;
 err_dev:
-- 
2.24.0

