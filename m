Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D803213849
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jul 2020 11:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgGCJ5O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jul 2020 05:57:14 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:16011 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgGCJ5H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2020 05:57:07 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200703095701epoutp03cc3adacfc6e1a8456363ee64cbb2c7e3~eNZJ-uX9p2482324823epoutp03d
        for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2020 09:57:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200703095701epoutp03cc3adacfc6e1a8456363ee64cbb2c7e3~eNZJ-uX9p2482324823epoutp03d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593770221;
        bh=S1OpOd9CnBf51VW4J05UzcHwgWzfC7+UJu7z/41L3a8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k8TWXgHTTa6rnQlCeQXqFaveYV5TK0VBNis3sCIS48EbSE7iB4HvPw7/QJ8QgFpyx
         H6ksAHBHmsZyOaaWRtKGQlVP1dzUtZ1mGjwUNNMemYoCB44nPuOr6Z3PVMwyEqf9d5
         /BlyqNUT/6tm90TWcZqkxcsVZ8VyodV0x4/EnfV4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200703095701epcas1p3823e7f714611c7c94f82ef744235e021~eNZJse7RN0642306423epcas1p3T;
        Fri,  3 Jul 2020 09:57:01 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.152]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49yr3G6dmrzMqYkd; Fri,  3 Jul
        2020 09:56:58 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        8A.26.28578.AE00FFE5; Fri,  3 Jul 2020 18:56:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200703095657epcas1p187b7f90a4a33da7791a83a78760f3a91~eNZGvmSkD2155421554epcas1p1g;
        Fri,  3 Jul 2020 09:56:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200703095657epsmtrp14dbe2bc903dfd57e67ab7db40600aa12~eNZGu0Csv1114311143epsmtrp1P;
        Fri,  3 Jul 2020 09:56:57 +0000 (GMT)
X-AuditID: b6c32a39-8c9ff70000006fa2-5a-5eff00eabbe5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5C.15.08382.9E00FFE5; Fri,  3 Jul 2020 18:56:57 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200703095657epsmtip1a5ab9363905b791cb37a3065f62020be~eNZGaLtxw0151101511epsmtip1g;
        Fri,  3 Jul 2020 09:56:57 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com,
        enric.balletbo@collabora.com, hl@rock-chips.com, digetx@gmail.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, abel.vesa@nxp.com,
        cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH 2/2] PM / devfreq: Add governor flags to clarify the
 features
Date:   Fri,  3 Jul 2020 19:08:10 +0900
Message-Id: <20200703100810.12304-3-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200703100810.12304-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMJsWRmVeSWpSXmKPExsWy7bCmru4rhv9xBmc3mlgsu3SU0WLijSss
        Fte/PGe1WP3xMaPFmtuHGC1+bDjFbNEyaxGLxdmmN+wWK+5+ZLW4vGsOm8Xn3iOMFgubWtgt
        bjeuYLP4uWseiwOfx5p5axg9dtxdwuixc9Zddo9NqzrZPHqb37F5bHy3g8nj76z9LB59W1Yx
        enzeJBfAGZVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuW
        mQN0vZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLJArzgxt7g0L10vOT/XytDA
        wMgUqDAhO+PPB4mCbZMZKxZ1PGBqYPxa1sXIySEhYCLx6Ndd5i5GLg4hgR2MEpeuPGeHcD4x
        SmzfswvK+cYosXVJNztMy6lXZ9hAbCGBvYwSCycLQBR9YZRYs7WTBSTBJqAlsf/FDbAiEQEr
        idP/O8B2MAvMY5JYfPoqWJGwgL/E5kuPgIo4OFgEVCXO/qwCCfMC1Xc/2MoGsUxeYvWGA8wg
        NqeAtcSWzZMZIeJzOSRWn8+FsF0kWlfuY4WwhSVeHd8CdaiUxMv+Nii7WmLlySNsIDdICHQw
        SmzZfwGqwVhi/9LJTCA3MAtoSqzfpQ8RVpTY+Xsu2C5mAT6Jd197WEFKJAR4JTrahCBKlCUu
        P7jLBGFLSixu74Q62UNi9aoPbJAw6WOUuHrzAMsERrlZCBsWMDKuYhRLLSjOTU8tNiwwRY6x
        TYzg1KlluYNx+tsPeocYmTgYDzFKcDArifAmqP6LE+JNSaysSi3Kjy8qzUktPsRoCgy7icxS
        osn5wOSdVxJvaGpkbGxsYWJoZmpoqCTO62R9IU5IID2xJDU7NbUgtQimj4mDU6qBKXGnY+a1
        gw+PeC4Uk/e7b53Dz/rwoOB2yROxW4XurKz+NOPNlf8mG4IUnuSybv7w8+r6mxfT9sytzGy5
        Zt7dL6wc19a1meFIese5h8d0z3dLuf+/vetEWXjXKZl7y88ln0xq82Mzqjt6Qvn9p3+17351
        bVzKE9py7MX8d8V3f4tcWnk05u7yRdKScXbX/wYfuHBX455Vae39tiCPYPZVPcVmZYc/H41W
        9F8Ze0ONzUlGcO2J5/OSGbs+3qhLUZlpJql+tubgjTfvfO5Ev2ZY/aLx8PEHNTeq+mp7ygxu
        RP2tzfvEcNNH2WVby4NU0fK3TNPTihOnrO7bJi2ge/3XDdMJrfcXvrd7+sHRzyrWQEOJpTgj
        0VCLuag4EQBh6E4kJgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsWy7bCSnO5Lhv9xBmu2Glksu3SU0WLijSss
        Fte/PGe1WP3xMaPFmtuHGC1+bDjFbNEyaxGLxdmmN+wWK+5+ZLW4vGsOm8Xn3iOMFgubWtgt
        bjeuYLP4uWseiwOfx5p5axg9dtxdwuixc9Zddo9NqzrZPHqb37F5bHy3g8nj76z9LB59W1Yx
        enzeJBfAGcVlk5Kak1mWWqRvl8CV8eeDRMG2yYwVizoeMDUwfi3rYuTkkBAwkTj16gxbFyMX
        h5DAbkaJpQs+sUIkJCWmXTzK3MXIAWQLSxw+XAxR84lR4ujmlYwgNWwCWhL7X9xgA7FFBGwk
        7i6+xgJSxCywhkni3fZDTCAJYQFfib1/WsEGsQioSpz9WQUS5hWwkuh+sJUNYpe8xOoNB5hB
        bE4Ba4ktmyeDzRcCqvlwZi/zBEa+BYwMqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcx
        gkNcS3MH4/ZVH/QOMTJxMB5ilOBgVhLhTVD9FyfEm5JYWZValB9fVJqTWnyIUZqDRUmc90bh
        wjghgfTEktTs1NSC1CKYLBMHp1QD0+xGGy73+NWbL69PFF5t+2rjfreX3N6ZGhN3CDcLHnSQ
        Pj2344BjpFXxZePg88cdtJSFXP6JnY0NtG5r310172fSNNFtE5eweaaflMlwbxapyt299sKv
        +C9uiqxqes1/yp3yuQwtLUuDb96v33xq6cpNFV833T6m4PRoh8pLlcmTyqOyZwkeOyu5qeXS
        kqSU8HTn6J0L9jB48yeKPeab9+QiS+/0ySbnRK5ZFS2p+H/i2TmR71Ypm5VvTzmX9Tdd4GPU
        7LNpSw9I7HG+FVF57DCra/vqtxf+FS0NjY+ezamVt+xC3mbma79KDgd4HHxgK24iubQ422CH
        KOvuQL+Hbo/l5mdUcWoc+fntRZfraSWW4oxEQy3mouJEAIO7zG/gAgAA
X-CMS-MailID: 20200703095657epcas1p187b7f90a4a33da7791a83a78760f3a91
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200703095657epcas1p187b7f90a4a33da7791a83a78760f3a91
References: <20200703100810.12304-1-cw00.choi@samsung.com>
        <CGME20200703095657epcas1p187b7f90a4a33da7791a83a78760f3a91@epcas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DEVFREQ supports the default governors like performance, powersave and also
allows the devfreq driver to add their own governor like tegra30-devfreq.c
according to their requirement. In result, some sysfs attributes are
useful or not useful. Prior to that the user can access all sysfs attributes
regardless of availability.

So, clarify the access permission of sysfs attributes according to governor.
When adding the devfreq governor, can specify the available attribute
information by using DEVFREQ_GOV_ATTR_* constant variable. The user can
read or write the sysfs attributes in accordance to the specified attributes.

/* Devfreq governor flags for attribtures and features */
[Definition for sysfs attributes]
- DEVFREQ_GOV_ATTR_GOVERNOR
- DEVFREQ_GOV_ATTR_AVAIL_GOVERNORS
- DEVFREQ_GOV_ATTR_AVAIL_FREQUENCIES
- DEVFREQ_GOV_ATTR_CUR_FREQ
- DEVFREQ_GOV_ATTR_TARGET_FREQ
- DEVFREQ_GOV_ATTR_MIN_FREQ
- DEVFREQ_GOV_ATTR_MAX_FREQ
- DEVFREQ_GOV_ATTR_TRANS_STAT
- DEVFREQ_GOV_ATTR_POLLING_INTERVAL
- DEVFREQ_GOV_ATTR_TIMER

Also, the devfreq governor is able to have the specific flag as follows
in order to implement the specific feature. For example, Devfreq allows
user to change the governors on runtime via sysfs interface.
But, if devfreq device uses 'passive' governor, don't allow user to change
the governor. For this case, define the DEVFREQ_GOV_FLAT_IMMUTABLE
and set it to flag of passive governor.

[Definition for governor flag]
- DEVFREQ_GOV_FLAG_IMMUTABLE
: If immutable flag is set, governor is never changeable to other governors.
- DEVFREQ_GOV_FLAG_IRQ_DRIVEN
: Devfreq core won't schedule polling work for this governor if value is set.

[Table of governor flag for devfreq governors]
------------------------------------------------------------------------------
                      | simple    | perfor | power | user | passive | tegra30
		      | ondemand  | mance  | save  | space|         |
------------------------------------------------------------------------------
governor              | O         | O      | O     | O    | O       | O
available_governors   | O         | O      | O     | O    | O       | O
available_frequencies | O         | O      | O     | O    | O       | O
cur_freq              | O         | O      | O     | O    | O       | O
target_freq           | O         | O      | O     | O    | O       | O
min_freq              | O         | O      | O     | O    | O       | O
max_freq              | O         | O      | O     | O    | O       | O
trans_stat            | O         | O      | O     | O    | O       | O
                      --------------------------------------------------------
polling_interval      | O         | X      | X     | X    | X       | O
timer                 | O         | X      | X     | X    | X       | X
------------------------------------------------------------------------------
immutable             | X         | X      | X     | X    | O       | O
interrupt_driven      | X(polling)| X      | X     | X    | X       | O (irq)
------------------------------------------------------------------------------

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c                 | 117 +++++++++++++++++++---
 drivers/devfreq/governor.h                |  45 +++++++--
 drivers/devfreq/governor_passive.c        |   3 +-
 drivers/devfreq/governor_performance.c    |   1 +
 drivers/devfreq/governor_powersave.c      |   1 +
 drivers/devfreq/governor_simpleondemand.c |   3 +
 drivers/devfreq/governor_userspace.c      |   1 +
 drivers/devfreq/tegra30-devfreq.c         |   6 +-
 8 files changed, 156 insertions(+), 21 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 41729a4173ca..2ad638f2ed2b 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -456,7 +456,7 @@ static void devfreq_monitor(struct work_struct *work)
  */
 void devfreq_monitor_start(struct devfreq *devfreq)
 {
-	if (devfreq->governor->interrupt_driven)
+	if (DEVFREQ_GOV_FLAG_IRQ_DRIVEN & devfreq->governor->flag)
 		return;
 
 	switch (devfreq->profile->timer) {
@@ -486,7 +486,7 @@ EXPORT_SYMBOL(devfreq_monitor_start);
  */
 void devfreq_monitor_stop(struct devfreq *devfreq)
 {
-	if (devfreq->governor->interrupt_driven)
+	if (DEVFREQ_GOV_FLAG_IRQ_DRIVEN & devfreq->governor->flag)
 		return;
 
 	cancel_delayed_work_sync(&devfreq->work);
@@ -517,7 +517,7 @@ void devfreq_monitor_suspend(struct devfreq *devfreq)
 	devfreq->stop_polling = true;
 	mutex_unlock(&devfreq->lock);
 
-	if (devfreq->governor->interrupt_driven)
+	if (DEVFREQ_GOV_FLAG_IRQ_DRIVEN & devfreq->governor->flag)
 		return;
 
 	cancel_delayed_work_sync(&devfreq->work);
@@ -537,12 +537,13 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
 	unsigned long freq;
 
 	mutex_lock(&devfreq->lock);
-	if (!devfreq->stop_polling)
-		goto out;
 
-	if (devfreq->governor->interrupt_driven)
+	if (DEVFREQ_GOV_FLAG_IRQ_DRIVEN & devfreq->governor->flag)
 		goto out_update;
 
+	if (!devfreq->stop_polling)
+		goto out;
+
 	if (!delayed_work_pending(&devfreq->work) &&
 			devfreq->profile->polling_ms)
 		queue_delayed_work(devfreq_wq, &devfreq->work,
@@ -577,10 +578,10 @@ void devfreq_update_interval(struct devfreq *devfreq, unsigned int *delay)
 	mutex_lock(&devfreq->lock);
 	devfreq->profile->polling_ms = new_delay;
 
-	if (devfreq->stop_polling)
-		goto out;
+	if (DEVFREQ_GOV_FLAG_IRQ_DRIVEN & devfreq->governor->flag)
+		return;
 
-	if (devfreq->governor->interrupt_driven)
+	if (devfreq->stop_polling)
 		goto out;
 
 	/* if new delay is zero, stop polling */
@@ -1281,6 +1282,13 @@ static ssize_t name_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
 	struct devfreq *df = to_devfreq(dev);
+
+	if (!df->governor)
+		return -EINVAL;
+
+	if (!(DEVFREQ_GOV_ATTR_NAME & df->governor->attr))
+		return -EACCES;
+
 	return sprintf(buf, "%s\n", dev_name(df->dev.parent));
 }
 static DEVICE_ATTR_RO(name);
@@ -1293,6 +1301,9 @@ static ssize_t governor_show(struct device *dev,
 	if (!df->governor)
 		return -EINVAL;
 
+	if (!(DEVFREQ_GOV_ATTR_GOVERNOR & df->governor->attr))
+		return -EACCES;
+
 	return sprintf(buf, "%s\n", df->governor->name);
 }
 
@@ -1307,6 +1318,9 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	if (!df->governor)
 		return -EINVAL;
 
+	if (!(DEVFREQ_GOV_ATTR_GOVERNOR & df->governor->attr))
+		return -EACCES;
+
 	ret = sscanf(buf, "%" __stringify(DEVFREQ_NAME_LEN) "s", str_governor);
 	if (ret != 1)
 		return -EINVAL;
@@ -1320,7 +1334,8 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	if (df->governor == governor) {
 		ret = 0;
 		goto out;
-	} else if (df->governor->immutable || governor->immutable) {
+	} else if ((DEVFREQ_GOV_FLAG_IMMUTABLE & df->governor->flag)
+		|| (DEVFREQ_GOV_FLAG_IMMUTABLE & governor->flag)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1366,13 +1381,19 @@ static ssize_t available_governors_show(struct device *d,
 	struct devfreq *df = to_devfreq(d);
 	ssize_t count = 0;
 
+	if (!df->governor)
+		return -EINVAL;
+
+	if (!(DEVFREQ_GOV_ATTR_AVAIL_GOVERNORS & df->governor->attr))
+		return -EACCES;
+
 	mutex_lock(&devfreq_list_lock);
 
 	/*
 	 * The devfreq with immutable governor (e.g., passive) shows
 	 * only own governor.
 	 */
-	if (df->governor && df->governor->immutable) {
+	if (DEVFREQ_GOV_FLAG_IMMUTABLE & df->governor->flag) {
 		count = scnprintf(&buf[count], DEVFREQ_NAME_LEN,
 				  "%s ", df->governor_name);
 	/*
@@ -1383,7 +1404,7 @@ static ssize_t available_governors_show(struct device *d,
 		struct devfreq_governor *governor;
 
 		list_for_each_entry(governor, &devfreq_governor_list, node) {
-			if (governor->immutable)
+			if (DEVFREQ_GOV_FLAG_IMMUTABLE & governor->flag)
 				continue;
 			count += scnprintf(&buf[count], (PAGE_SIZE - count - 2),
 					   "%s ", governor->name);
@@ -1408,6 +1429,12 @@ static ssize_t cur_freq_show(struct device *dev, struct device_attribute *attr,
 	unsigned long freq;
 	struct devfreq *df = to_devfreq(dev);
 
+	if (!df->governor)
+		return -EINVAL;
+
+	if (!(DEVFREQ_GOV_ATTR_CUR_FREQ & df->governor->attr))
+		return -EACCES;
+
 	if (df->profile->get_cur_freq &&
 		!df->profile->get_cur_freq(df->dev.parent, &freq))
 		return sprintf(buf, "%lu\n", freq);
@@ -1421,6 +1448,12 @@ static ssize_t target_freq_show(struct device *dev,
 {
 	struct devfreq *df = to_devfreq(dev);
 
+	if (!df->governor)
+		return -EINVAL;
+
+	if (!(DEVFREQ_GOV_ATTR_TARGET_FREQ & df->governor->attr))
+		return -EACCES;
+
 	return sprintf(buf, "%lu\n", df->previous_freq);
 }
 static DEVICE_ATTR_RO(target_freq);
@@ -1430,6 +1463,12 @@ static ssize_t polling_interval_show(struct device *dev,
 {
 	struct devfreq *df = to_devfreq(dev);
 
+	if (!df->governor)
+		return -EINVAL;
+
+	if (!(DEVFREQ_GOV_ATTR_POLLING_INTERVAL & df->governor->attr))
+		return -EACCES;
+
 	return sprintf(buf, "%d\n", df->profile->polling_ms);
 }
 
@@ -1444,6 +1483,9 @@ static ssize_t polling_interval_store(struct device *dev,
 	if (!df->governor)
 		return -EINVAL;
 
+	if (!(DEVFREQ_GOV_ATTR_POLLING_INTERVAL & df->governor->attr))
+		return -EACCES;
+
 	ret = sscanf(buf, "%u", &value);
 	if (ret != 1)
 		return -EINVAL;
@@ -1462,6 +1504,12 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
 	unsigned long value;
 	int ret;
 
+	if (!df->governor)
+		return -EINVAL;
+
+	if (!(DEVFREQ_GOV_ATTR_MIN_FREQ & df->governor->attr))
+		return -EACCES;
+
 	/*
 	 * Protect against theoretical sysfs writes between
 	 * device_add and dev_pm_qos_add_request
@@ -1488,6 +1536,12 @@ static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
 	struct devfreq *df = to_devfreq(dev);
 	unsigned long min_freq, max_freq;
 
+	if (!df->governor)
+		return -EINVAL;
+
+	if (!(DEVFREQ_GOV_ATTR_MIN_FREQ & df->governor->attr))
+		return -EACCES;
+
 	mutex_lock(&df->lock);
 	get_freq_range(df, &min_freq, &max_freq);
 	mutex_unlock(&df->lock);
@@ -1503,6 +1557,12 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
 	unsigned long value;
 	int ret;
 
+	if (!df->governor)
+		return -EINVAL;
+
+	if (!(DEVFREQ_GOV_ATTR_MAX_FREQ & df->governor->attr))
+		return -EACCES;
+
 	/*
 	 * Protect against theoretical sysfs writes between
 	 * device_add and dev_pm_qos_add_request
@@ -1542,6 +1602,12 @@ static ssize_t max_freq_show(struct device *dev, struct device_attribute *attr,
 	struct devfreq *df = to_devfreq(dev);
 	unsigned long min_freq, max_freq;
 
+	if (!df->governor)
+		return -EINVAL;
+
+	if (!(DEVFREQ_GOV_ATTR_MAX_FREQ & df->governor->attr))
+		return -EACCES;
+
 	mutex_lock(&df->lock);
 	get_freq_range(df, &min_freq, &max_freq);
 	mutex_unlock(&df->lock);
@@ -1558,6 +1624,12 @@ static ssize_t available_frequencies_show(struct device *d,
 	ssize_t count = 0;
 	int i;
 
+	if (!df->governor)
+		return -EINVAL;
+
+	if (!(DEVFREQ_GOV_ATTR_AVAIL_FREQUENCIES & df->governor->attr))
+		return -EACCES;
+
 	mutex_lock(&df->lock);
 
 	for (i = 0; i < df->profile->max_state; i++)
@@ -1583,6 +1655,12 @@ static ssize_t trans_stat_show(struct device *dev,
 	int i, j;
 	unsigned int max_state = df->profile->max_state;
 
+	if (!df->governor)
+		return -EINVAL;
+
+	if (!(DEVFREQ_GOV_ATTR_TRANS_STAT & df->governor->attr))
+		return -EACCES;
+
 	if (max_state == 0)
 		return sprintf(buf, "Not Supported.\n");
 
@@ -1631,6 +1709,12 @@ static ssize_t trans_stat_store(struct device *dev,
 	struct devfreq *df = to_devfreq(dev);
 	int err, value;
 
+	if (!df->governor)
+		return -EINVAL;
+
+	if (!(DEVFREQ_GOV_ATTR_TRANS_STAT & df->governor->attr))
+		return -EACCES;
+
 	if (df->profile->max_state == 0)
 		return count;
 
@@ -1660,6 +1744,9 @@ static ssize_t timer_show(struct device *dev,
 	if (!df->governor)
 		return -EINVAL;
 
+	if (!(DEVFREQ_GOV_ATTR_TIMER & df->governor->attr))
+		return -EACCES;
+
 	return sprintf(buf, "%s\n", timer_name[df->profile->timer]);
 }
 
@@ -1671,6 +1758,12 @@ static ssize_t timer_store(struct device *dev, struct device_attribute *attr,
 	int timer = -1;
 	int ret = 0, i;
 
+	if (!df->governor)
+		return -EINVAL;
+
+	if (!(DEVFREQ_GOV_ATTR_TIMER & df->governor->attr))
+		return -EACCES;
+
 	ret = sscanf(buf, "%16s", str_timer);
 	if (ret != 1)
 		return -EINVAL;
diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index ae4d0cc18359..7385989580a0 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -25,14 +25,47 @@
 #define DEVFREQ_MIN_FREQ			0
 #define DEVFREQ_MAX_FREQ			ULONG_MAX
 
+/* Devfreq governor flags for attribtures and features */
+#define DEVFREQ_GOV_ATTR_NAME				BIT(0)
+#define DEVFREQ_GOV_ATTR_GOVERNOR			BIT(1)
+#define DEVFREQ_GOV_ATTR_AVAIL_GOVERNORS		BIT(2)
+#define DEVFREQ_GOV_ATTR_AVAIL_FREQUENCIES		BIT(3)
+#define DEVFREQ_GOV_ATTR_CUR_FREQ			BIT(4)
+#define DEVFREQ_GOV_ATTR_TARGET_FREQ			BIT(5)
+#define DEVFREQ_GOV_ATTR_MIN_FREQ			BIT(6)
+#define DEVFREQ_GOV_ATTR_MAX_FREQ			BIT(7)
+#define DEVFREQ_GOV_ATTR_TRANS_STAT			BIT(8)
+#define DEVFREQ_GOV_ATTR_POLLING_INTERVAL		BIT(9)
+#define DEVFREQ_GOV_ATTR_TIMER				BIT(10)
+
+#define DEVFREQ_GOV_ATTR_COMMON (DEVFREQ_GOV_ATTR_NAME			\
+				| DEVFREQ_GOV_ATTR_GOVERNOR		\
+				| DEVFREQ_GOV_ATTR_AVAIL_GOVERNORS	\
+				| DEVFREQ_GOV_ATTR_AVAIL_FREQUENCIES	\
+				| DEVFREQ_GOV_ATTR_CUR_FREQ		\
+				| DEVFREQ_GOV_ATTR_TARGET_FREQ		\
+				| DEVFREQ_GOV_ATTR_MIN_FREQ		\
+				| DEVFREQ_GOV_ATTR_MAX_FREQ		\
+				| DEVFREQ_GOV_ATTR_TRANS_STAT )
+
+/*
+ * If immutable flag is set, this governor is never changeable
+ * to other governors.
+ */
+#define DEVFREQ_GOV_FLAG_IMMUTABLE			BIT(0)
+
+/*
+ * Devfreq core won't schedule polling work for this
+ *                     governor if value is set to 1.
+ */
+#define DEVFREQ_GOV_FLAG_IRQ_DRIVEN			BIT(1)
+
 /**
  * struct devfreq_governor - Devfreq policy governor
  * @node:		list node - contains registered devfreq governors
  * @name:		Governor's name
- * @immutable:		Immutable flag for governor. If the value is 1,
- *			this governor is never changeable to other governor.
- * @interrupt_driven:	Devfreq core won't schedule polling work for this
- *			governor if value is set to 1.
+ * @attr:		Governor's attribute flag
+ * @flag:		Governor's flag
  * @get_target_freq:	Returns desired operating frequency for the device.
  *			Basically, get_target_freq will run
  *			devfreq_dev_profile.get_dev_status() to get the
@@ -50,8 +83,8 @@ struct devfreq_governor {
 	struct list_head node;
 
 	const char name[DEVFREQ_NAME_LEN];
-	const unsigned int immutable;
-	const unsigned int interrupt_driven;
+	const unsigned long attr;
+	const unsigned long flag;
 	int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
 	int (*event_handler)(struct devfreq *devfreq,
 				unsigned int event, void *data);
diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index be6eeab9c814..671a5f8f774e 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -180,7 +180,8 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor devfreq_passive = {
 	.name = DEVFREQ_GOV_PASSIVE,
-	.immutable = 1,
+	.attr = DEVFREQ_GOV_ATTR_COMMON,
+	.flag = DEVFREQ_GOV_FLAG_IMMUTABLE,
 	.get_target_freq = devfreq_passive_get_target_freq,
 	.event_handler = devfreq_passive_event_handler,
 };
diff --git a/drivers/devfreq/governor_performance.c b/drivers/devfreq/governor_performance.c
index 5dbc1e56ec08..7ae9829775b8 100644
--- a/drivers/devfreq/governor_performance.c
+++ b/drivers/devfreq/governor_performance.c
@@ -37,6 +37,7 @@ static int devfreq_performance_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor devfreq_performance = {
 	.name = DEVFREQ_GOV_PERFORMANCE,
+	.attr = DEVFREQ_GOV_ATTR_COMMON,
 	.get_target_freq = devfreq_performance_func,
 	.event_handler = devfreq_performance_handler,
 };
diff --git a/drivers/devfreq/governor_powersave.c b/drivers/devfreq/governor_powersave.c
index 4746af2435b0..8761cc400f8a 100644
--- a/drivers/devfreq/governor_powersave.c
+++ b/drivers/devfreq/governor_powersave.c
@@ -37,6 +37,7 @@ static int devfreq_powersave_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor devfreq_powersave = {
 	.name = DEVFREQ_GOV_POWERSAVE,
+	.attr = DEVFREQ_GOV_ATTR_COMMON,
 	.get_target_freq = devfreq_powersave_func,
 	.event_handler = devfreq_powersave_handler,
 };
diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
index 1b314e1df028..57083b83a094 100644
--- a/drivers/devfreq/governor_simpleondemand.c
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -117,6 +117,9 @@ static int devfreq_simple_ondemand_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor devfreq_simple_ondemand = {
 	.name = DEVFREQ_GOV_SIMPLE_ONDEMAND,
+	.attr = DEVFREQ_GOV_ATTR_COMMON
+		| DEVFREQ_GOV_ATTR_POLLING_INTERVAL
+		| DEVFREQ_GOV_ATTR_TIMER,
 	.get_target_freq = devfreq_simple_ondemand_func,
 	.event_handler = devfreq_simple_ondemand_handler,
 };
diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
index 0fd6c4851071..a32bdea49fa3 100644
--- a/drivers/devfreq/governor_userspace.c
+++ b/drivers/devfreq/governor_userspace.c
@@ -132,6 +132,7 @@ static int devfreq_userspace_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor devfreq_userspace = {
 	.name = DEVFREQ_GOV_USERSPACE,
+	.attr = DEVFREQ_GOV_ATTR_COMMON,
 	.get_target_freq = devfreq_userspace_func,
 	.event_handler = devfreq_userspace_handler,
 };
diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index e94a27804c20..620ecd250d7c 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -765,10 +765,12 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor tegra_devfreq_governor = {
 	.name = "tegra_actmon",
+	.flag = DEVFREQ_GOV_FLAG_ATTR_COMMON
+		| DEVFREQ_GOV_FLAG_ATTR_POLLING_INTERVAL,
+	.flag = DEVFREQ_GOV_FLAG_FLAG_IMMUTABLE,
+		| DEVFREQ_GOV_FLAG_FLAG_IRQ_DRIVEN,
 	.get_target_freq = tegra_governor_get_target,
 	.event_handler = tegra_governor_event_handler,
-	.immutable = true,
-	.interrupt_driven = true,
 };
 
 static int tegra_devfreq_probe(struct platform_device *pdev)
-- 
2.17.1

