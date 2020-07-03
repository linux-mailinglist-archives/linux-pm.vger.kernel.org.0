Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41371213847
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jul 2020 11:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgGCJ5K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jul 2020 05:57:10 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:16023 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgGCJ5G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2020 05:57:06 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200703095702epoutp035311ee78875d6fd0b8474ca43266f3a6~eNZLTmBpH2540225402epoutp03s
        for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2020 09:57:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200703095702epoutp035311ee78875d6fd0b8474ca43266f3a6~eNZLTmBpH2540225402epoutp03s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593770222;
        bh=su8Xz0eTiw2/eqmTu5RSSUx4akCCKlux+fG9+XVKA7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uBAlDZZ7oS43ItlrGaeJ6A2UXqjMHa/eIV6BxxbiK9p/QVdPWP9LInyaZwKHVY/6N
         9l11I2BUoucfYBxYV4tl40RJRoBt6ezz13q2SvGBLXxXym+GLLerWzMM/CzfFMvvlI
         X/cO+W4NG5q5zWmVpZ0V1JA2JNKu2deWMiCwkvlo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200703095702epcas1p29bd71576ea62f0a53d8aa296f679d25a~eNZKyVT2N3113931139epcas1p2C;
        Fri,  3 Jul 2020 09:57:02 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.155]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 49yr3G2FdNzMqYlr; Fri,  3 Jul
        2020 09:56:58 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        09.26.28578.AE00FFE5; Fri,  3 Jul 2020 18:56:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200703095657epcas1p15695a8d0d48e5bf0b195cc5f893a0e72~eNZGjqrbA2153521535epcas1p17;
        Fri,  3 Jul 2020 09:56:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200703095657epsmtrp2c7f223bacc08acc0ffb046c29f68f436~eNZGiv5ld1101611016epsmtrp2A;
        Fri,  3 Jul 2020 09:56:57 +0000 (GMT)
X-AuditID: b6c32a39-8c9ff70000006fa2-54-5eff00ead0d6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6B.15.08382.9E00FFE5; Fri,  3 Jul 2020 18:56:57 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200703095657epsmtip1f9346b00b9d625e3b285441c90ada1b9~eNZGQCo_i0138401384epsmtip1e;
        Fri,  3 Jul 2020 09:56:57 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com,
        enric.balletbo@collabora.com, hl@rock-chips.com, digetx@gmail.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, abel.vesa@nxp.com,
        cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH 1/2] PM / devfreq: Clean up the devfreq instance name in
 sysfs attr
Date:   Fri,  3 Jul 2020 19:08:09 +0900
Message-Id: <20200703100810.12304-2-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200703100810.12304-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMJsWRmVeSWpSXmKPExsWy7bCmnu4rhv9xBt9e8lksu3SU0WLijSss
        Fte/PGe1WP3xMaPFmtuHGC1+bDjFbNEyaxGLxdmmN+wWK+5+ZLW4vGsOm8Xn3iOMFgubWtgt
        bjeuYLP4uWseiwOfx5p5axg9dtxdwuixc9Zddo9NqzrZPHqb37F5bHy3g8nj76z9LB59W1Yx
        enzeJBfAGZVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuW
        mQN0vZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLJArzgxt7g0L10vOT/XytDA
        wMgUqDAhO2P70jMsBT36Fd93X2ZsYJyj1sXIwSEhYCLx8kpcFyMXh5DADkaJlW9mskE4n4Cc
        g3+ZIJxvjBIn7nxk7GLkBOu4032PFSKxF6hqzXyoli+MEsv6tjGDVLEJaEnsf3GDDcQWEbCS
        OP2/gxmkiFlgHpPE4tNXWUCWCwuESrxapA5SwyKgKvFi5Td2EJsXqH7joyPsENvkJVZvOAA2
        k1PAWmLL5smMIHMkBOZySDxrWcIMUeQicfrYESYIW1ji1fEtUM1SEp/f7WWDsKslVp48wgbR
        3MEosWX/BVaIhLHE/qWTmUAOYhbQlFi/Sx8irCix8/dcsJeZBfgk3n3tYYUEGK9ER5sQRImy
        xOUHd6HWSkosbu9kgyjxkPi5NwQSJn2MEj/3XGOewCg3C2HBAkbGVYxiqQXFuempxYYFpsgx
        tokRnDq1LHcwTn/7Qe8QIxMH4yFGCQ5mJRHeBNV/cUK8KYmVValF+fFFpTmpxYcYTYGBN5FZ
        SjQ5H5i880riDU2NjI2NLUwMzUwNDZXEeZ2sL8QJCaQnlqRmp6YWpBbB9DFxcEo1MBXMOT99
        Ptfmnw9YKoXCD2prFjfbbY2+lCYj0jChpDZB6oltv3PhmecTl/jzPz0/qSbwn791YPHh1uV7
        z0v1/ii7e3DplblXYw7bfJ1m5nfs0SstEb1V4kcX+3o8SfOI3+mt15YswHqyfPkLpqNLvofJ
        hZRc+un4eG36tCWJ3DqfFwXU3Fpk2/lr6d/qwqB/S5ykJ6vOsL3Fd8ve3PL1AbuimOQPcafP
        cdQsla/93nh36USpMI8pb6US9039eM3qjMHpwq0zp8rmsEopCp3sPz+xTCLD5fxPWc0Tmg3v
        1StO/bgtosean+/gzvt3/Qaplnph421Lg7y/qTZMeTFTwfTQinV1IiaCyTLzr17ZuEKJpTgj
        0VCLuag4EQAoc309JgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsWy7bCSnO5Lhv9xBrcOqFssu3SU0WLijSss
        Fte/PGe1WP3xMaPFmtuHGC1+bDjFbNEyaxGLxdmmN+wWK+5+ZLW4vGsOm8Xn3iOMFgubWtgt
        bjeuYLP4uWseiwOfx5p5axg9dtxdwuixc9Zddo9NqzrZPHqb37F5bHy3g8nj76z9LB59W1Yx
        enzeJBfAGcVlk5Kak1mWWqRvl8CVsX3pGZaCHv2K77svMzYwzlHrYuTkkBAwkbjTfY+1i5GL
        Q0hgN6PEy51HmCESkhLTLh4FsjmAbGGJw4eLIWo+MUrsb73FClLDJqAlsf/FDTYQW0TARuLu
        4mssIEXMAmuYJN5tP8QEkhAWCJb4t2oCWBGLgKrEi5Xf2EFsXgEriY2PjrBDLJOXWL3hANhi
        TgFriS2bJzOC2EJANR/O7GWewMi3gJFhFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZG
        cJBrae5g3L7qg94hRiYOxkOMEhzMSiK8Car/4oR4UxIrq1KL8uOLSnNSiw8xSnOwKInz3ihc
        GCckkJ5YkpqdmlqQWgSTZeLglGpgUvavTU3s3OL3zLPejU/61Vv+/SFmF2a6HC/aNzP+ef7E
        cH+1tq0Kk9r99rz+FNnVfH5rearnF/0v9aynzfKOFvikrb++rPEy5165kP++M3ZkcM3syr/7
        dP3R7VEbm1Y+aXh35NR5zQ9FHJ8tiqrm3biY0VHsenv9s8y5z4Jydvrp//uotFA7qzOjQcNz
        gv2WT78X9PWeEOO/EjSFtclUX4f5SPn+3GMx964vSaj/EqY0I8vK9NLtG/6GNyeu37fbUfLe
        y8Zd6Snrs54ai5apyu3cfH2r4tfZilYyd+1uznZI0ucr/eTecnSOYOYbocJ0j00XprSfEXvH
        brQmqz6kvMJ6ik+w2d/gH/y/txkHKrEUZyQaajEXFScCADGnQrXhAgAA
X-CMS-MailID: 20200703095657epcas1p15695a8d0d48e5bf0b195cc5f893a0e72
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200703095657epcas1p15695a8d0d48e5bf0b195cc5f893a0e72
References: <20200703100810.12304-1-cw00.choi@samsung.com>
        <CGME20200703095657epcas1p15695a8d0d48e5bf0b195cc5f893a0e72@epcas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The sysfs attr interface used eithere 'df' or 'devfreq' for devfreq instance
name. In order to keep the consistency and to improve the readabilty,
unify the instance name as 'df'.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 73 +++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 33 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 2a4aa8742520..41729a4173ca 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1280,18 +1280,20 @@ EXPORT_SYMBOL(devfreq_remove_governor);
 static ssize_t name_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
-	struct devfreq *devfreq = to_devfreq(dev);
-	return sprintf(buf, "%s\n", dev_name(devfreq->dev.parent));
+	struct devfreq *df = to_devfreq(dev);
+	return sprintf(buf, "%s\n", dev_name(df->dev.parent));
 }
 static DEVICE_ATTR_RO(name);
 
 static ssize_t governor_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
-	if (!to_devfreq(dev)->governor)
+	struct devfreq *df = to_devfreq(dev);
+
+	if (!df->governor)
 		return -EINVAL;
 
-	return sprintf(buf, "%s\n", to_devfreq(dev)->governor->name);
+	return sprintf(buf, "%s\n", df->governor->name);
 }
 
 static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
@@ -1302,6 +1304,9 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	char str_governor[DEVFREQ_NAME_LEN + 1];
 	const struct devfreq_governor *governor, *prev_governor;
 
+	if (!df->governor)
+		return -EINVAL;
+
 	ret = sscanf(buf, "%" __stringify(DEVFREQ_NAME_LEN) "s", str_governor);
 	if (ret != 1)
 		return -EINVAL;
@@ -1315,20 +1320,18 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	if (df->governor == governor) {
 		ret = 0;
 		goto out;
-	} else if ((df->governor && df->governor->immutable) ||
-					governor->immutable) {
+	} else if (df->governor->immutable || governor->immutable) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	if (df->governor) {
-		ret = df->governor->event_handler(df, DEVFREQ_GOV_STOP, NULL);
-		if (ret) {
-			dev_warn(dev, "%s: Governor %s not stopped(%d)\n",
-				 __func__, df->governor->name, ret);
-			goto out;
-		}
+	ret = df->governor->event_handler(df, DEVFREQ_GOV_STOP, NULL);
+	if (ret) {
+		dev_warn(dev, "%s: Governor %s not stopped(%d)\n",
+			 __func__, df->governor->name, ret);
+		goto out;
 	}
+
 	prev_governor = df->governor;
 	df->governor = governor;
 	strncpy(df->governor_name, governor->name, DEVFREQ_NAME_LEN);
@@ -1403,27 +1406,31 @@ static ssize_t cur_freq_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
 	unsigned long freq;
-	struct devfreq *devfreq = to_devfreq(dev);
+	struct devfreq *df = to_devfreq(dev);
 
-	if (devfreq->profile->get_cur_freq &&
-		!devfreq->profile->get_cur_freq(devfreq->dev.parent, &freq))
+	if (df->profile->get_cur_freq &&
+		!df->profile->get_cur_freq(df->dev.parent, &freq))
 		return sprintf(buf, "%lu\n", freq);
 
-	return sprintf(buf, "%lu\n", devfreq->previous_freq);
+	return sprintf(buf, "%lu\n", df->previous_freq);
 }
 static DEVICE_ATTR_RO(cur_freq);
 
 static ssize_t target_freq_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%lu\n", to_devfreq(dev)->previous_freq);
+	struct devfreq *df = to_devfreq(dev);
+
+	return sprintf(buf, "%lu\n", df->previous_freq);
 }
 static DEVICE_ATTR_RO(target_freq);
 
 static ssize_t polling_interval_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", to_devfreq(dev)->profile->polling_ms);
+	struct devfreq *df = to_devfreq(dev);
+
+	return sprintf(buf, "%d\n", df->profile->polling_ms);
 }
 
 static ssize_t polling_interval_store(struct device *dev,
@@ -1571,49 +1578,49 @@ static DEVICE_ATTR_RO(available_frequencies);
 static ssize_t trans_stat_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	struct devfreq *devfreq = to_devfreq(dev);
+	struct devfreq *df = to_devfreq(dev);
 	ssize_t len;
 	int i, j;
-	unsigned int max_state = devfreq->profile->max_state;
+	unsigned int max_state = df->profile->max_state;
 
 	if (max_state == 0)
 		return sprintf(buf, "Not Supported.\n");
 
-	mutex_lock(&devfreq->lock);
-	if (!devfreq->stop_polling &&
-			devfreq_update_status(devfreq, devfreq->previous_freq)) {
-		mutex_unlock(&devfreq->lock);
+	mutex_lock(&df->lock);
+	if (!df->stop_polling &&
+			devfreq_update_status(df, df->previous_freq)) {
+		mutex_unlock(&df->lock);
 		return 0;
 	}
-	mutex_unlock(&devfreq->lock);
+	mutex_unlock(&df->lock);
 
 	len = sprintf(buf, "     From  :   To\n");
 	len += sprintf(buf + len, "           :");
 	for (i = 0; i < max_state; i++)
 		len += sprintf(buf + len, "%10lu",
-				devfreq->profile->freq_table[i]);
+				df->profile->freq_table[i]);
 
 	len += sprintf(buf + len, "   time(ms)\n");
 
 	for (i = 0; i < max_state; i++) {
-		if (devfreq->profile->freq_table[i]
-					== devfreq->previous_freq) {
+		if (df->profile->freq_table[i]
+					== df->previous_freq) {
 			len += sprintf(buf + len, "*");
 		} else {
 			len += sprintf(buf + len, " ");
 		}
 		len += sprintf(buf + len, "%10lu:",
-				devfreq->profile->freq_table[i]);
+				df->profile->freq_table[i]);
 		for (j = 0; j < max_state; j++)
 			len += sprintf(buf + len, "%10u",
-				devfreq->stats.trans_table[(i * max_state) + j]);
+				df->stats.trans_table[(i * max_state) + j]);
 
 		len += sprintf(buf + len, "%10llu\n", (u64)
-			jiffies64_to_msecs(devfreq->stats.time_in_state[i]));
+			jiffies64_to_msecs(df->stats.time_in_state[i]));
 	}
 
 	len += sprintf(buf + len, "Total transition : %u\n",
-					devfreq->stats.total_trans);
+					df->stats.total_trans);
 	return len;
 }
 
-- 
2.17.1

