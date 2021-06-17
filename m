Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6B43AAB47
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jun 2021 07:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhFQFtE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Jun 2021 01:49:04 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:58757 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbhFQFtC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jun 2021 01:49:02 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210617054652epoutp041b604b73fd930caaad7c831fa7caaf78~JSHYGkiE73044730447epoutp04S
        for <linux-pm@vger.kernel.org>; Thu, 17 Jun 2021 05:46:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210617054652epoutp041b604b73fd930caaad7c831fa7caaf78~JSHYGkiE73044730447epoutp04S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1623908812;
        bh=gVRnGh6/SwyclktozAcfjMAjxPKBukbpUhTca54XqGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GLcYQUhuWm0Kesm/SZa9/Fv6dOdx+SW2HIyBTe8P719Ktbvxzxm0xgwwW7+yP+O8E
         88ps8ocWzETtGAFbB2JDspIKUBA/7IzP421zZMZFprnLAjNONBbXxlHfABxvfc347M
         uzf17xbPSuAF4JJT/26ir18wUxwYtRDbEQVzVaPw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210617054651epcas1p4c62a0107d88eb4dc25e8fb6a564d57a6~JSHXg52dj2867228672epcas1p4L;
        Thu, 17 Jun 2021 05:46:51 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.152]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4G59zX1mJ9z4x9Q3; Thu, 17 Jun
        2021 05:46:48 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        AF.3F.09578.8C1EAC06; Thu, 17 Jun 2021 14:46:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210617054647epcas1p265359058d489661e09d8d48d4937ca7b~JSHToGqYG2425124251epcas1p2Q;
        Thu, 17 Jun 2021 05:46:47 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210617054647epsmtrp1b361d3ef0ba09e61272fc5a3566cb508~JSHTmQ9Jo1936119361epsmtrp1E;
        Thu, 17 Jun 2021 05:46:47 +0000 (GMT)
X-AuditID: b6c32a35-fcfff7000000256a-28-60cae1c83b5e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B7.96.08163.7C1EAC06; Thu, 17 Jun 2021 14:46:47 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210617054647epsmtip14f56319522eff509fa05a559eed02f65~JSHTX__5P1533015330epsmtip1W;
        Thu, 17 Jun 2021 05:46:47 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     andrew-sh.cheng@mediatek.com, hsinyi@chromium.org
Cc:     sibis@codeaurora.org, saravanak@google.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, chanwoo@kernel.org, cwchoi00@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] PM / devfreq: Export devfreq_get_freq_ragne symbol
 within devfreq
Date:   Thu, 17 Jun 2021 15:05:44 +0900
Message-Id: <20210617060546.26933-3-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210617060546.26933-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmru6Jh6cSDJYu5rbYvv4Fq8XEG1dY
        LK5/ec5q8eyotsWE1u3MFmeb3rBbXN41h83ic+8RRovbjSvYLLoO/WWzuLbwPasDt8fshoss
        Hpf7epk8ds66y+6xYFOpx6ZVnWweLSf3s3j0bVnF6PF5k1wAR1S2TUZqYkpqkUJqXnJ+SmZe
        uq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QnUoKZYk5pUChgMTiYiV9O5ui/NKS
        VIWM/OISW6XUgpScAssCveLE3OLSvHS95PxcK0MDAyNToMKE7IzWg22sBbOlK97vbGdtYHwu
        1sXIySEhYCLRvmMPcxcjF4eQwA5GibafG5ggnE+MEtfWfYZyPjNKfL34nxGmZfHmS4wQiV2M
        EkfP/IByvjBKrJt7iBWkik1AS2L/ixtsILaIgKnEnsMTWUCKmAXuMUo8Wn4eLCEsECFx6NUy
        JhCbRUBV4tiu70A2BwevgJXE96MBENvkJVZvOMAMYnMKWEucW3KHHWSOhMBfdom/fy5AneQi
        8XPPHjYIW1ji1fEt7BC2lMTL/jYou1pi5ckjbBDNHYwSW/ZfYIVIGEvsXzoZbDGzgKbE+l36
        EGFFiZ2/54LNZxbgk3j3tYcVpERCgFeio00IokRZ4vKDu0wQtqTE4vZOqBM8JD6fmgYNlD5G
        if8r9rFPYJSbhbBhASPjKkax1ILi3PTUYsMCQ+Q428QITolapjsYJ779oHeIkYmD8RCjBAez
        kgivbvGJBCHelMTKqtSi/Pii0pzU4kOMpsDAm8gsJZqcD0zKeSXxhqZGxsbGFiaGZqaGhkri
        vDvZDiUICaQnlqRmp6YWpBbB9DFxcEo1MB09x8u65OvkYzYitRuOu3y5LXtONPfR7gdKX8Xu
        xZ6qN23IZz28NjX/3tQt25+zXl/x5cRD1hMnFj/6fTjm+81esVwOF07b3EAl95e3k0/rKTK/
        D/jC8WXR1bT2nx9+L/p67WdjUj6PdUxcq+iMcB79jANre2e2KsuWbQuY/SB2b/bl+eebtBUX
        xjGd/Se6+8RbL9EkkSUFyw/X56yo51AtuzGhes7dXF9V4/Ki68s2nSudWnfSc7nOhed1f/TS
        F+kcDTecnzy3USrgy56NwirMmTJxq1a1q1Yk7d556dmvbdM/+/VaqLcc1eqTyJ6RUDp79k7F
        pVWG3cc4rBhEODyvf37ffu/c+Zc6P2Qttq5VYinOSDTUYi4qTgQAHqeePhIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsWy7bCSnO7xh6cSDI4ekbHYvv4Fq8XEG1dY
        LK5/ec5q8eyotsWE1u3MFmeb3rBbXN41h83ic+8RRovbjSvYLLoO/WWzuLbwPasDt8fshoss
        Hpf7epk8ds66y+6xYFOpx6ZVnWweLSf3s3j0bVnF6PF5k1wARxSXTUpqTmZZapG+XQJXRuvB
        NtaC2dIV73e2szYwPhfrYuTkkBAwkVi8+RJjFyMXh5DADkaJpbdaWCESkhLTLh5l7mLkALKF
        JQ4fLoao+cQosW3hR7AaNgEtif0vbrCB1IgImEscvxINUsMs8IpR4t7Zx2A1wgJhEnMfHmED
        sVkEVCWO7frOBFLPK2Al8f1oAMQqeYnVGw4wg9icAtYS55bcYQcpEQIqOf8qfQIj3wJGhlWM
        kqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmbGMEhq6W1g3HPqg96hxiZOBgPMUpwMCuJ8OoW
        n0gQ4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJg1OqgUk1K89m
        +na7d2f6C/bn73Bw1pomfaxbt/z42TUHtXn81l+SljSZyXNL4MTsRVbHunMiM58zPvtx8OhP
        hT3RGp/OZZ5m8d7q+ezLiQnxX6sqvkdol0+ftmzSzFVZDhXal7nE/OW4Vt6+Hn722ZS7goHV
        vJ6/Ztiotvz6fIrLq6BvfdjeKNeMdO0/wRsezpN7ryQnqXl/i2Uy5/2aTnGv9NNPt+9Jrdu9
        b/JN8QMBpX90zusuNFfhPSAx80L+sUnnGN5lM06+EFxjYNa9U7vU2Sch7Gz0rF+d0/fuD7s4
        b9P6/z7zufX3hQUeLfCTVc/18992Ofa4eyLvwRmnZ28r9Kv/zbnwwuHwzW/ahWVyn6xWYinO
        SDTUYi4qTgQA3djmBcgCAAA=
X-CMS-MailID: 20210617054647epcas1p265359058d489661e09d8d48d4937ca7b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210617054647epcas1p265359058d489661e09d8d48d4937ca7b
References: <20210617060546.26933-1-cw00.choi@samsung.com>
        <CGME20210617054647epcas1p265359058d489661e09d8d48d4937ca7b@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to get frequency range within devfreq governors,
export devfreq_get_freq_ragne symbol within devfreq.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c  | 17 +++++++++--------
 drivers/devfreq/governor.h |  2 ++
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 28f3e0ba6cdd..a15545c42fc2 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -112,16 +112,16 @@ static unsigned long find_available_max_freq(struct devfreq *devfreq)
 }
 
 /**
- * get_freq_range() - Get the current freq range
+ * devfreq_get_freq_range() - Get the current freq range
  * @devfreq:	the devfreq instance
  * @min_freq:	the min frequency
  * @max_freq:	the max frequency
  *
  * This takes into consideration all constraints.
  */
-static void get_freq_range(struct devfreq *devfreq,
-			   unsigned long *min_freq,
-			   unsigned long *max_freq)
+void devfreq_get_freq_range(struct devfreq *devfreq,
+			    unsigned long *min_freq,
+			    unsigned long *max_freq)
 {
 	unsigned long *freq_table = devfreq->profile->freq_table;
 	s32 qos_min_freq, qos_max_freq;
@@ -158,6 +158,7 @@ static void get_freq_range(struct devfreq *devfreq,
 	if (*min_freq > *max_freq)
 		*min_freq = *max_freq;
 }
+EXPORT_SYMBOL(devfreq_get_freq_range);
 
 /**
  * devfreq_get_freq_level() - Lookup freq_table for the frequency
@@ -418,7 +419,7 @@ int devfreq_update_target(struct devfreq *devfreq, unsigned long freq)
 	err = devfreq->governor->get_target_freq(devfreq, &freq);
 	if (err)
 		return err;
-	get_freq_range(devfreq, &min_freq, &max_freq);
+	devfreq_get_freq_range(devfreq, &min_freq, &max_freq);
 
 	if (freq < min_freq) {
 		freq = min_freq;
@@ -1561,7 +1562,7 @@ static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
 	unsigned long min_freq, max_freq;
 
 	mutex_lock(&df->lock);
-	get_freq_range(df, &min_freq, &max_freq);
+	devfreq_get_freq_range(df, &min_freq, &max_freq);
 	mutex_unlock(&df->lock);
 
 	return sprintf(buf, "%lu\n", min_freq);
@@ -1615,7 +1616,7 @@ static ssize_t max_freq_show(struct device *dev, struct device_attribute *attr,
 	unsigned long min_freq, max_freq;
 
 	mutex_lock(&df->lock);
-	get_freq_range(df, &min_freq, &max_freq);
+	devfreq_get_freq_range(df, &min_freq, &max_freq);
 	mutex_unlock(&df->lock);
 
 	return sprintf(buf, "%lu\n", max_freq);
@@ -1929,7 +1930,7 @@ static int devfreq_summary_show(struct seq_file *s, void *data)
 
 		mutex_lock(&devfreq->lock);
 		cur_freq = devfreq->previous_freq;
-		get_freq_range(devfreq, &min_freq, &max_freq);
+		devfreq_get_freq_range(devfreq, &min_freq, &max_freq);
 		timer = devfreq->profile->timer;
 
 		if (IS_SUPPORTED_ATTR(devfreq->governor->attrs, POLLING_INTERVAL))
diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index 2d69a0ce6291..9a9495f94ac6 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -86,6 +86,8 @@ int devfreq_remove_governor(struct devfreq_governor *governor);
 
 int devfreq_update_status(struct devfreq *devfreq, unsigned long freq);
 int devfreq_update_target(struct devfreq *devfreq, unsigned long freq);
+void devfreq_get_freq_range(struct devfreq *devfreq, unsigned long *min_freq,
+			    unsigned long *max_freq);
 
 static inline int devfreq_update_stats(struct devfreq *df)
 {
-- 
2.17.1

