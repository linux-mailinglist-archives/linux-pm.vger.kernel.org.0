Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CBE21D188
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 10:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgGMIT5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 04:19:57 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:61065 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbgGMITz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 04:19:55 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200713081947epoutp020bc6addb2c6946059e1437125ea20878~hQhHxdA262126421264epoutp02D
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 08:19:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200713081947epoutp020bc6addb2c6946059e1437125ea20878~hQhHxdA262126421264epoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594628387;
        bh=/cI/w7dq/2YUtamM47ZRZGrvxC3/fvcPLWSVKSlGqtM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VvJslXdBesLt0wYxW030gOdQd9aBPIGTZcCf3HWnAC5OBW9oRKdZYTC5naMqqZuw2
         199NpjPSmb2QwCmkcdfZLsQVh2VUZb1CS7UTQY4rN6cDq+uBHYSH+dCSxnUsAhDeIU
         3feId2Mi8F089IQQdtoPJtHYWEDJofO4TRKTK75A=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200713081947epcas1p42e70bcb205dcb1496af3f84e6012d129~hQhHNNqYk0475404754epcas1p4C;
        Mon, 13 Jul 2020 08:19:47 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.158]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4B4xQS6xBqzMqYkh; Mon, 13 Jul
        2020 08:19:44 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        6C.24.28578.0291C0F5; Mon, 13 Jul 2020 17:19:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200713081944epcas1p22871b6d8a9455226e6cccd08ac0baa73~hQhEO93sf2976529765epcas1p2U;
        Mon, 13 Jul 2020 08:19:44 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200713081944epsmtrp2142b654274e45fd7d6aed6dd7e24b437~hQhEOG7UA2276722767epsmtrp2d;
        Mon, 13 Jul 2020 08:19:44 +0000 (GMT)
X-AuditID: b6c32a39-8dfff70000006fa2-2c-5f0c1920cdd2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7D.7D.08382.F191C0F5; Mon, 13 Jul 2020 17:19:43 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200713081943epsmtip2cbe770721a5beaadca149c44bb542339~hQhD8UrrN2771927719epsmtip2D;
        Mon, 13 Jul 2020 08:19:43 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com,
        enric.balletbo@collabora.com, hl@rock-chips.com, digetx@gmail.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, abel.vesa@nxp.com,
        cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH v2 2/2] PM / devfreq: Add governor flags to clarify the
 features
Date:   Mon, 13 Jul 2020 17:31:13 +0900
Message-Id: <20200713083113.5595-3-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200713083113.5595-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRmVeSWpSXmKPExsWy7bCmvq6CJE+8we7jxhbLLh1ltJh44wqL
        xfUvz1ktVn98zGix5vYhRosfG04xW7TMWsRicbbpDbvFirsfWS0u75rDZvG59wijxcKmFnaL
        240r2Cx+7prH4sDnsWbeGkaPHXeXMHrsnHWX3WPTqk42j97md2weG9/tYPL4O2s/i0ffllWM
        Hp83yQVwRmXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl
        5gBdr6RQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpsCzQK07MLS7NS9dLzs+1MjQw
        MDIFKkzIzpj0+CBTwcYpjBULztxma2B8Vd7FyMkhIWAicfLFbHYQW0hgB6NExxrPLkYuIPsT
        o8SF+6cYIZxvjBLbZ6xmgulY9Xo2VGIvo8Syzl3MEM4XRokds3aAVbEJaEnsf3GDDcQWEbCS
        OP2/A6yIWWAek8Ti01dZQBLCAkESux//YgWxWQRUJW48ucIIYvMKWEr0rJnHCrFOXmL1hgPM
        IDYn0KA31zqYQAZJCMzlkLix7ycLRJGLxNWtB5khbGGJV8e3sEPYUhKf3+1lg7CrJVaePMIG
        0dzBKLFl/wWoDcYS+5dOBprKAXSepsT6XfoQYUWJnb/ngh3ELMAn8e5rDytIiYQAr0RHmxBE
        ibLE5Qd3ocEiKbG4vRNqlYfE6YsdbJBQ6WWUWHpmNeMERrlZCBsWMDKuYhRLLSjOTU8tNiww
        RY60TYzgBKpluYNx+tsPeocYmTgYDzFKcDArifBGi3LGC/GmJFZWpRblxxeV5qQWH2I0BYbe
        RGYp0eR8YArPK4k3NDUyNja2MDE0MzU0VBLn/XeWPV5IID2xJDU7NbUgtQimj4mDU6qBSTbp
        4tZY7YOfXp/Q9Th3cPvLu92uO8tsH0lN2uD/wu/imuQb5p7LJ0pqG8/Tnv7pxUnnXsvbHZYG
        n07tbNqjyhg7z+k/E+Nb0X0LF71dNWXXvogmjlgVjd3sCRksMwNP2H8TOG2Wt7RxTVnNobw+
        +UqXqyvXzhPflmzXqRj2yPb8ptXt7neDj352W1S0LLtB6sBBnQtyTdN/7tyaray8e+H8Ao8J
        vGt2hP8v05Bn0lmWms9ww7ppaa2B7kHnnR6RvhYuaguY39WKzE9Xfco0y/hd7ZpjWaoGifPT
        Jn8p9N92its6T37jjjNB/LdtD+5kKl2Ts+KD47YOqwiNeSuyGS67vHQ6/UtF4bFX38QDYUos
        xRmJhlrMRcWJAP74cSspBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsWy7bCSvK68JE+8wZwp1hbLLh1ltJh44wqL
        xfUvz1ktVn98zGix5vYhRosfG04xW7TMWsRicbbpDbvFirsfWS0u75rDZvG59wijxcKmFnaL
        240r2Cx+7prH4sDnsWbeGkaPHXeXMHrsnHWX3WPTqk42j97md2weG9/tYPL4O2s/i0ffllWM
        Hp83yQVwRnHZpKTmZJalFunbJXBlTHp8kKlg4xTGigVnbrM1ML4q72Lk5JAQMJFY9Xo2Yxcj
        F4eQwG5GiYmf7rBDJCQlpl08ytzFyAFkC0scPlwMUfOJUWJ+00tWkBo2AS2J/S9usIHYIgI2
        EncXX2MBKWIWWMMk8W77ISaQhLBAgMSU/VfAGlgEVCVuPLnCCGLzClhK9KyZxwqxTF5i9YYD
        zCA2p4CVxJtrHWC9QkA1a782ME9g5FvAyLCKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93
        EyM4zLU0dzBuX/VB7xAjEwfjIUYJDmYlEd5oUc54Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rw3
        ChfGCQmkJ5akZqemFqQWwWSZODilGpgOXzq8Uqd00puJ9VZyWRwTpde2BSmsSjDa8kbj5hKe
        l7tVVvA3cyf5iHq0Bk8PM2Q+teimmcS+FdYc8gxXt9dF29m/93Vb8/rg86yHXx9v2qpvzaVV
        NXNCJhez+AHHwncPfboEqhp/TdpfY/Z+9Xqr71Ul6Ym5C1kPfZjhedaI/0HShMwrVdwpL5dP
        Dle3rZm3qvwKG8snP+Ha94z75x12THC/dsj8JuuJy9H3W7RDxcrLMs/MZz15wEUv9HZ0V5zu
        hpa8FPn9PhXMPYyVTLGauvIzplwOk73EnsW+/sCX7YVXKlkWsTcqxIjV3j6TfXViCFvnS2P7
        7P7Zp6+d5+/5FrDr049IUQn914WLWZRYijMSDbWYi4oTAQMGQWviAgAA
X-CMS-MailID: 20200713081944epcas1p22871b6d8a9455226e6cccd08ac0baa73
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200713081944epcas1p22871b6d8a9455226e6cccd08ac0baa73
References: <20200713083113.5595-1-cw00.choi@samsung.com>
        <CGME20200713081944epcas1p22871b6d8a9455226e6cccd08ac0baa73@epcas1p2.samsung.com>
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

/* Devfreq governor flags for attributes and features */
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
 drivers/devfreq/devfreq.c                 | 106 ++++++++++++++++++----
 drivers/devfreq/governor.h                |  44 +++++++--
 drivers/devfreq/governor_passive.c        |   3 +-
 drivers/devfreq/governor_performance.c    |   1 +
 drivers/devfreq/governor_powersave.c      |   1 +
 drivers/devfreq/governor_simpleondemand.c |   3 +
 drivers/devfreq/governor_userspace.c      |   1 +
 drivers/devfreq/tegra30-devfreq.c         |   6 +-
 8 files changed, 139 insertions(+), 26 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 286957f760f1..ce82bdb5fa5c 100644
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
+	if (DEVFREQ_GOV_FLAG_IRQ_DRIVEN & devfreq->governor->flag)
 		goto out;
 
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
@@ -1369,13 +1384,16 @@ static ssize_t available_governors_show(struct device *d,
 	if (!df->governor)
 		return -EINVAL;
 
+	if (!(DEVFREQ_GOV_ATTR_AVAIL_GOVERNORS & df->governor->attr))
+		return -EACCES;
+
 	mutex_lock(&devfreq_list_lock);
 
 	/*
 	 * The devfreq with immutable governor (e.g., passive) shows
 	 * only own governor.
 	 */
-	if (df->governor->immutable) {
+	if (DEVFREQ_GOV_FLAG_IMMUTABLE & df->governor->flag) {
 		count = scnprintf(&buf[count], DEVFREQ_NAME_LEN,
 				  "%s ", df->governor_name);
 	/*
@@ -1386,7 +1404,7 @@ static ssize_t available_governors_show(struct device *d,
 		struct devfreq_governor *governor;
 
 		list_for_each_entry(governor, &devfreq_governor_list, node) {
-			if (governor->immutable)
+			if (DEVFREQ_GOV_FLAG_IMMUTABLE & governor->flag)
 				continue;
 			count += scnprintf(&buf[count], (PAGE_SIZE - count - 2),
 					   "%s ", governor->name);
@@ -1411,9 +1429,12 @@ static ssize_t cur_freq_show(struct device *dev, struct device_attribute *attr,
 	unsigned long freq;
 	struct devfreq *df = to_devfreq(dev);
 
-	if (!df->profile)
+	if (!df->governor || !df->profile)
 		return -EINVAL;
 
+	if (!(DEVFREQ_GOV_ATTR_CUR_FREQ & df->governor->attr))
+		return -EACCES;
+
 	if (df->profile->get_cur_freq &&
 		!df->profile->get_cur_freq(df->dev.parent, &freq))
 		return sprintf(buf, "%lu\n", freq);
@@ -1427,6 +1448,12 @@ static ssize_t target_freq_show(struct device *dev,
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
@@ -1436,9 +1463,12 @@ static ssize_t polling_interval_show(struct device *dev,
 {
 	struct devfreq *df = to_devfreq(dev);
 
-	if (!df->profile)
+	if (!df->governor || !df->profile)
 		return -EINVAL;
 
+	if (!(DEVFREQ_GOV_ATTR_POLLING_INTERVAL & df->governor->attr))
+		return -EACCES;
+
 	return sprintf(buf, "%d\n", df->profile->polling_ms);
 }
 
@@ -1453,6 +1483,9 @@ static ssize_t polling_interval_store(struct device *dev,
 	if (!df->governor)
 		return -EINVAL;
 
+	if (!(DEVFREQ_GOV_ATTR_POLLING_INTERVAL & df->governor->attr))
+		return -EACCES;
+
 	ret = sscanf(buf, "%u", &value);
 	if (ret != 1)
 		return -EINVAL;
@@ -1471,6 +1504,12 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
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
@@ -1497,6 +1536,12 @@ static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
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
@@ -1512,6 +1557,12 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
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
@@ -1551,6 +1602,12 @@ static ssize_t max_freq_show(struct device *dev, struct device_attribute *attr,
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
@@ -1567,9 +1624,12 @@ static ssize_t available_frequencies_show(struct device *d,
 	ssize_t count = 0;
 	int i;
 
-	if (!df->profile)
+	if (!df->governor || !df->profile)
 		return -EINVAL;
 
+	if (!(DEVFREQ_GOV_ATTR_AVAIL_FREQUENCIES & df->governor->attr))
+		return -EACCES;
+
 	mutex_lock(&df->lock);
 
 	for (i = 0; i < df->profile->max_state; i++)
@@ -1595,10 +1655,13 @@ static ssize_t trans_stat_show(struct device *dev,
 	int i, j;
 	unsigned int max_state;
 
-	if (!df->profile)
+	if (!df->governor || !df->profile)
 		return -EINVAL;
 	max_state = df->profile->max_state;
 
+	if (!(DEVFREQ_GOV_ATTR_TRANS_STAT & df->governor->attr))
+		return -EACCES;
+
 	if (max_state == 0)
 		return sprintf(buf, "Not Supported.\n");
 
@@ -1647,9 +1710,12 @@ static ssize_t trans_stat_store(struct device *dev,
 	struct devfreq *df = to_devfreq(dev);
 	int err, value;
 
-	if (!df->profile)
+	if (!df->governor || !df->profile)
 		return -EINVAL;
 
+	if (!(DEVFREQ_GOV_ATTR_TRANS_STAT & df->governor->attr))
+		return -EACCES;
+
 	if (df->profile->max_state == 0)
 		return count;
 
@@ -1676,9 +1742,12 @@ static ssize_t timer_show(struct device *dev,
 {
 	struct devfreq *df = to_devfreq(dev);
 
-	if (!df->profile)
+	if (!df->governor || !df->profile)
 		return -EINVAL;
 
+	if (!(DEVFREQ_GOV_ATTR_TIMER & df->governor->attr))
+		return -EACCES;
+
 	return sprintf(buf, "%s\n", timer_name[df->profile->timer]);
 }
 
@@ -1693,6 +1762,9 @@ static ssize_t timer_store(struct device *dev, struct device_attribute *attr,
 	if (!df->governor || !df->profile)
 		return -EINVAL;
 
+	if (!(DEVFREQ_GOV_ATTR_TIMER & df->governor->attr))
+		return -EACCES;
+
 	ret = sscanf(buf, "%16s", str_timer);
 	if (ret != 1)
 		return -EINVAL;
diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index ae4d0cc18359..7d1ed5933b9a 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -25,14 +25,46 @@
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
+ * If irq_drive flag is set, devfreq won't schedule the work for this governor.
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
+ * @attr:		Governor's sysfs attribute flag
+ * @flag:		Governor's flag
  * @get_target_freq:	Returns desired operating frequency for the device.
  *			Basically, get_target_freq will run
  *			devfreq_dev_profile.get_dev_status() to get the
@@ -50,8 +82,8 @@ struct devfreq_governor {
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
index e94a27804c20..ad5bd8e7b24d 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -765,10 +765,12 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor tegra_devfreq_governor = {
 	.name = "tegra_actmon",
+	.attr = DEVFREQ_GOV_ATTR_COMMON
+		| DEVFREQ_GOV_ATTR_POLLING_INTERVAL,
+	.flag = DEVFREQ_GOV_FLAG_IMMUTABLE
+		| DEVFREQ_GOV_FLAG_IRQ_DRIVEN,
 	.get_target_freq = tegra_governor_get_target,
 	.event_handler = tegra_governor_event_handler,
-	.immutable = true,
-	.interrupt_driven = true,
 };
 
 static int tegra_devfreq_probe(struct platform_device *pdev)
-- 
2.17.1

